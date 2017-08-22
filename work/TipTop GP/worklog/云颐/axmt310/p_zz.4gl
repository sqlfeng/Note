# Prog. Version..: '5.30.06-13.03.12(00010)'     #
#
# Pattern name...: p_zz.4gl
# Descriptions...: 程式資料建立
# Date & Author..: 02/05/31 LYS
# Modify.........: 03/11/13 By saki modify zz14 no use;
# Modify.........: 04/04/05 By saki open
# Modify.........: 04/08/19 By alex p_zz_k modify
# Modify.........: 04/09/02 By alex 新增從 menu 可更新權限
# Modify.........: 04/09/27 By echo 程式名稱改由gaz_file紀錄,Tool Bar
#                              與 Ring Menu中的列印功能,都沒有關聯到gaz_file
# Modify.........: No.MOD-490466 04/09/29 By saki 直接Q程式名稱
# Modify.........: No.MOD-450030 04/10/04 By saki 錯誤訊息查看功能
# Modify.........: No.MOD-4A0024 04/10/12 By alex 增加複製 gak,gal,gaz功能
# Modify.........: No.MOD-4A0338 04/11/03 By Smapmin 以za_file取代PRINT中文字的部份
# Modify.........: No.MOD-4B0066 04/11/08 By alex 移除zz11,zz12,zz23,zz24 (per,4gl)
#                                及其它於Genero無效設定  (database端不變)
# Modify.........: No.FUN-4B0030 04/11/08 By alex 加MENU時"執行","目錄維護"判斷
# Modify.........: No.MOD-4B0183 04/11/17 By alex 移除 zz18,zz19無效設定
# Modify.........: No.FUN-4C0040 04/12/07 By pengu Data and Group權限控管
# Modify.........: No.MOD-4C0181 05/01/05 By alex 修改 ora 資料
# Modify.........: No.FUN-4C0104 05/01/05 By alex 修改 4js bug 定義超長
# Modify.........: No.MOD-510130 05/02/17 By saki 修改4sm update路徑
# Modify.........: No.MOD-530126 05/03/16 By alex 修改群組權限設定的功能
# Modify.........: No.MOD-530169 05/03/22 By alex 增加 CONSTRUCT 時 zz10開窗功能
# Modify.........: No.FUN-530040 05/03/23 By saki 更改每次修改4sm的暫存檔名
# Modify.........: No.MOD-530797 05/03/29 By alex 修改複置重複key值時無法離開的問題
# Modify.........: No.FUN-540035 05/04/18 By saki 拷貝完成後直接可修改新資料
# Modify.........: No.MOD-540140 05/04/20 By alex 刪除 HELP FILE
# Modify.........: No.MOD-540196 05/04/29 By pengu 無法顯示報表
# Modify.........: No.MOD-570093 05/07/06 By pengu p_zz 群組全限設定改單身權限 (0,1,2,3) 不會寫入資料庫
# Modify.........: No.FUN-570276 05/07/30 By alex 串入 p_zr 於 menu 處
# Modify.........: No.MOD-580056 05/08/05 By yiting key可更改
# Modify.........: No.MOD-580200 05/08/20 By alex s_act_desc_tab 移除橫向 (最後一參數為1) 顯示處
# Modify.........: No.FUN-5A0192 05/10/26 By alex 在p_zz_k中新增可直接維護單身權限功能
# Modify.........: No.FUN-5C0057 05/12/13 By alex 取消 p_zz_k() 維護報表權限功能
# Modify.........: No.FUN-5C0121 06/01/20 By saki 資料瀏覽功能
# Modify.........: No.FUN-660081 06/06/16 By Carrier cl_err --> cl_err3
# Modify.........: NO.FUN-680135 06/09/15 By douzh 類型轉換
# Modify.........: No.FUN-6A0080 06/10/23 By Czl g_no_ask改成g_no_ask
# Modify.........: No.FUN-6A0096 06/10/27 By czl l_time轉g_time
# Modify.........: No.FUN-6A0092 06/11/17 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No.FUN-690069 07/01/23 By Echo 新增判斷執行p_query，程式代碼必須為QueryID
# Modify.........: No.TQC-740191 07/04/23 By Pengu 新增判斷執行p_query，程式代碼必須為QueryID
# Modify.........: No.TQC-760169 07/06/25 Smapmin 模組下拉式選單應排除公用模組名稱
# Modify.........: No.TQC-760179 07/07/12 By rainy 新增報表列印抬頭欄位
# Modify.........: No.TQC-790092 07/09/17 By rainy 修正Primary Key後, 程式判斷錯誤訊息時必須改變做法
# Modify.........: No.MOD-7B0168 07/11/20 By Smapmin 無法連續執行二次複製動作
# Modify.........: No.FUN-7C0042 07/12/13 By alex 擋掉p_query衍生作業執行右側功能
# Modify.........: No.TQC-810008 08/01/09 By Sarah
#                  1.新增時,預設zz14='5'
#                  2.若zz03='R',則請提示需設定報表類型(zz14)的欄位,若無調整(zz14='5'),則不允許存檔
#                  3.若zz14=null也不允許存檔
# Modify.........: No.FUN-810043 08/01/15 By alex 新增zy資料後提示使用者已完成
# Modify.........: No.MOD-810166 08/01/21 By alexstar zy07給預設值
# Modify.........: No.MOD-810259 08/01/30 By alex 增加客製選項於單身中
# Modify.........: No.MOD-830017 08/03/04 By alex 修正MOD-4A0094的語法
# Modify.........: No.FUN-860033 08/06/06 By alex 修正 ON IDLE區段
# Modify.........: No.TQC-870041 08/07/30 By clover 修正azz28 有預設3
# Modify.........: No.MOD-8B0286 08/11/27 By Sarah p_zz_k()段CALL s_act_define()前需再抓一次ARR_CURR()
# Modify.........: No.FUN-830037 09/02/09 By alex 作法調整,關閉即時update 4sm功能
# Modify.........: No.MOD-950281 09/05/31 By Dido 刪除時應同步刪除我的最愛程式資料檔(gbi_file)
# Modify.........: No.FUN-960118 09/06/16 By alex 加上註記以便調整MSV
# Modify.........: No.FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-A10114 10/01/20 By alex 調整 p_report 比照 p_query
# Modify.........: No.FUN-A60046 10/06/11 By Kevin On Windows, zz08 不可接受單引號 
# Modify.........: No.FUN-AA0069 10/10/27 By Kevin 若zr 無資料則補做p_get_zr
# Modify.........: No.TQC-AB0023 10/11/09 By houlia 修改"CANCEL"【ESC】退出功能
# Modify.........: No.TQC-AB0058 10/11/17 By lilingyu MARK TQC-AB0023修改部分
# Modify.........: No.FUN-AC0058 10/12/20 By tsai_yen 執行指令zz08修改後,帶出的p_link應該是新資料
# Modify.........: No.MOD-B50035 11/05/05 By sabrina 資料有修改時，zzmodu應帶g_user的值
# Modify.........: No.FUN-B50030 11/05/12 By jrg542 新增4pw維護選項  
# Modify.........: No.FUN-B70050 11/08/18 By Sakura 加判斷zz03='I'時，zz13欄位才可維護，反之不可維護且zz13="N"
# Modify.........: No.MOD-B80235 11/08/23 By Vampire 將程式裡zy07=zz32的地方mark 
# Modify.........: No.FUN-B80190 11/08/30 By jrg542 加入download 捷徑，然後可以啟動TIPTOP 
# Modify.........: No.FUN-B60064 11/09/15 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.FUN-B60070 11/10/24 By Hiko 1.【群組權限設定作業】內的“權限類別代號“欄位使用開窗.
#                                                 2.【對全部群組新增】改為可挑選權限類別之後才更新.
# Modify.........: No.FUN-B70091 11/11/08 By LeoChang [群組權限設定]功能中加上權限類別說明[zw02]的欄位

# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No:FUN-C30027 12/08/15 By bart 複製後停在新資料畫面

IMPORT os
DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE g_zz           RECORD
         zz01           LIKE zz_file.zz01,
         zz011          LIKE zz_file.zz011,
         gaz03          LIKE gaz_file.gaz03,
         zz03           LIKE zz_file.zz03,
         zz04           LIKE zz_file.zz04,
         zz05           LIKE zz_file.zz05,
         zz06           LIKE zz_file.zz06,
         zz07           LIKE zz_file.zz07,
         zz08           LIKE zz_file.zz08,
         zz09           LIKE zz_file.zz09,
         zz10           LIKE zz_file.zz10,
#        zz11           LIKE zz_file.zz11,    #2004/11/08 原為編修記錄
#        zz12           LIKE zz_file.zz12,    #2004/11/08 原為測試執行
         zz13           LIKE zz_file.zz13,
         zz14           LIKE zz_file.zz14,
         zz15           LIKE zz_file.zz15,    #2004/11/17 AGL傳帳別否
         zz16           LIKE zz_file.zz16,
         zz17           LIKE zz_file.zz17,
#        zz18           LIKE zz_file.zz18,    #2004/11/17 原為 使用者資料權限
#        zz19           LIKE zz_file.zz19,    #2004/11/17 原為 部門資料權限
         zz21           LIKE zz_file.zz21,
         zz22           LIKE zz_file.zz22,
#        zz23           LIKE zz_file.zz23,    #2004/11/08 原為 Read設定用
#        zz24           LIKE zz_file.zz24,    #2004/11/08 原為 Lock Time用
         zz25           LIKE zz_file.zz25,
         zz26           LIKE zz_file.zz26,
         zz27           LIKE zz_file.zz27,
         zz28           LIKE zz_file.zz28,
         zz29           LIKE zz_file.zz29,
         zz30           LIKE zz_file.zz30,
         zz31           LIKE zz_file.zz31,
         zz32           LIKE zz_file.zz32,
         zzuser         LIKE zz_file.zzuser,
         zzgrup         LIKE zz_file.zzgrup,
         zzmodu         LIKE zz_file.zzmodu,
         zzdate         LIKE zz_file.zzdate,
         zzoriu       LIKE zz_file.zzoriu,      #No.FUN-980030 10/01/04
         zzorig       LIKE zz_file.zzorig      #No.FUN-980030 10/01/04
                  END RECORD,
       g_zz1          RECORD
         zz01           LIKE zz_file.zz01,
         zz011          LIKE zz_file.zz011,
         gaz03          LIKE gaz_file.gaz03,
         zz03           LIKE zz_file.zz03,
         zz04           LIKE zz_file.zz04,
         zz05           LIKE zz_file.zz05,
         zz06           LIKE zz_file.zz06,
         zz07           LIKE zz_file.zz07,
         zz08           LIKE zz_file.zz08,
         zz09           LIKE zz_file.zz09,
         zz10           LIKE zz_file.zz10,
#        zz11           LIKE zz_file.zz11,
#        zz12           LIKE zz_file.zz12,
         zz13           LIKE zz_file.zz13,
         zz14           LIKE zz_file.zz14,
         zz15           LIKE zz_file.zz15,
         zz16           LIKE zz_file.zz16,
         zz17           LIKE zz_file.zz17,
#        zz18           LIKE zz_file.zz18,
#        zz19           LIKE zz_file.zz19,
         zz21           LIKE zz_file.zz21,
         zz22           LIKE zz_file.zz22,
#        zz23           LIKE zz_file.zz23,
#        zz24           LIKE zz_file.zz24,
         zz25           LIKE zz_file.zz25,
         zz26           LIKE zz_file.zz26,
         zz27           LIKE zz_file.zz27,
         zz28           LIKE zz_file.zz28,
         zz29           LIKE zz_file.zz29,
         zz30           LIKE zz_file.zz30,
         zz31           LIKE zz_file.zz31,
         zz32           LIKE zz_file.zz32,
         zzuser         LIKE zz_file.zzuser,
         zzgrup         LIKE zz_file.zzgrup,
         zzmodu         LIKE zz_file.zzmodu,
         zzdate         LIKE zz_file.zzdate
                  END RECORD,
       g_zz_t         RECORD
         zz01           LIKE zz_file.zz01,
         zz011          LIKE zz_file.zz011,
         gaz03          LIKE gaz_file.gaz03,
         zz03           LIKE zz_file.zz03,
         zz04           LIKE zz_file.zz04,
         zz05           LIKE zz_file.zz05,
         zz06           LIKE zz_file.zz06,
         zz07           LIKE zz_file.zz07,
         zz08           LIKE zz_file.zz08,
         zz09           LIKE zz_file.zz09,
         zz10           LIKE zz_file.zz10,
#        zz11           LIKE zz_file.zz11,
#        zz12           LIKE zz_file.zz12,
         zz13           LIKE zz_file.zz13,
         zz14           LIKE zz_file.zz14,
         zz15           LIKE zz_file.zz15,
         zz16           LIKE zz_file.zz16,
         zz17           LIKE zz_file.zz17,
#        zz18           LIKE zz_file.zz18,
#        zz19           LIKE zz_file.zz19,
         zz21           LIKE zz_file.zz21,
         zz22           LIKE zz_file.zz22,
#        zz23           LIKE zz_file.zz23,
#        zz24           LIKE zz_file.zz24,
         zz25           LIKE zz_file.zz25,
         zz26           LIKE zz_file.zz26,
         zz27           LIKE zz_file.zz27,
         zz28           LIKE zz_file.zz28,
         zz29           LIKE zz_file.zz29,
         zz30           LIKE zz_file.zz30,
         zz31           LIKE zz_file.zz31,
         zz32           LIKE zz_file.zz32,
         zzuser         LIKE zz_file.zzuser,
         zzgrup         LIKE zz_file.zzgrup,
         zzmodu         LIKE zz_file.zzmodu,
         zzdate         LIKE zz_file.zzdate,
         zzoriu       LIKE zz_file.zzoriu,      #No.FUN-980030 10/01/04
         zzorig       LIKE zz_file.zzorig      #No.FUN-980030 10/01/04
                  END RECORD,
       g_zz01_t         LIKE zz_file.zz01,
 #      g_x              ARRAY[20] OF VARCHAR(40),#No.MOD-540196
       g_wc             STRING,
       g_sql            STRING,
       p_row,p_col      LIKE type_file.num5    #No.FUN-680135 SMALLINT
DEFINE g_forupd_sql     STRING                 #SELECT ... FOR UPDATE  SQL
DEFINE g_cnt            LIKE type_file.num10   #No.FUN-680135 INTEGER
 #DEFINE g_dash           VARCHAR(400)            #Dash line     #No.MOD-540196
DEFINE g_i              LIKE type_file.num5    #count/index for any purpose  #No.FUN-680135 SMALLINT
 #DEFINE g_len            SMALLINT             #Report width(79/132/136)     #No.MOD-540196
DEFINE g_msg            LIKE ze_file.ze03      #No.FUN-680135 VARCHAR(72)
DEFINE g_zz04_ds        STRING
DEFINE g_before_input_done   LIKE type_file.num5    #No.FUN-680135 SMALLINT
DEFINE g_zz011          STRING
DEFINE g_transname      STRING
DEFINE g_curs_index     LIKE type_file.num10   #No.FUN-680135 INTEGER
DEFINE g_row_count      LIKE type_file.num10   #No.FUN-680135 INTEGER
DEFINE g_jump           LIKE type_file.num10   #No.FUN-680135 INTEGER
DEFINE g_no_ask        LIKE type_file.num5    #No.FUN-680135 SMALLINT #FUN-6A0080
 
MAIN
   DEFINE l_zz011       LIKE zz_file.zz011
 
   OPTIONS
      INPUT NO WRAP
   DEFER INTERRUPT
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("AZZ")) THEN
      EXIT PROGRAM
   END IF
 
   CALL cl_used(g_prog,g_time,1) RETURNING g_time 
   INITIALIZE g_zz.* TO NULL
   INITIALIZE g_zz_t.* TO NULL
   LET g_transname=""
 
   LET g_forupd_sql = "SELECT zz01,zz011,'',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10, ",
 #                           " zz11,zz12, ",    #MOD-4B0066
                            " zz13,zz14,zz15, ",
                            " zz16,zz17, ",
 #                           " zz18,zz19, ",    #MOD-4B0183
                            " zz21,zz22, ",
 #                           " zz23,zz24, ",    #MOD-4B0066
                            " zz25,zz26,zz27,zz28,zz29,zz30,zz31, ",
                            " zz32,zzuser,zzgrup,zzmodu,zzdate ",
                       " FROM zz_file ",
                      " WHERE zz01 =? FOR UPDATE "       #No.TQC-740191 modify
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE p_zz_curl CURSOR FROM g_forupd_sql
 
   OPEN WINDOW p_zz_w WITH FORM "azz/42f/p_zz"
      ATTRIBUTE(STYLE=g_win_style CLIPPED)
 
   CALL cl_ui_init()
 
   #-----指定combo zz011的值-------------#
   LET g_zz011=""
   #-----TQC-760169---------
   #DECLARE p_zz011_cur CURSOR FOR SELECT gao01 FROM gao_file ORDER BY gao01
   DECLARE p_zz011_cur CURSOR FOR 
     SELECT gao01 FROM gao_file 
       WHERE gao01 NOT IN ('SUB','CSUB','LIB','CLIB','QRY','CQRY')
             ORDER BY gao01
   #-----END TQC-760169-----
   FOREACH p_zz011_cur INTO l_zz011
      IF cl_null(g_zz011) THEN
         LET g_zz011=l_zz011
      ELSE
         LET g_zz011=g_zz011 CLIPPED,",",l_zz011 CLIPPED
      END IF
   END FOREACH
 
    # MOD-4B0130 加上 "MENU"
   LET g_zz011 = g_zz011 CLIPPED,",MENU"
 
   CALL cl_set_combo_items("zz011",g_zz011,g_zz011)
   #-------------------------------------#
 
   CALL p_zz_menu()
 
   CLOSE WINDOW p_zz_w
     CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0096
 
END MAIN
 
 
FUNCTION p_zz_curs()
 
   CLEAR FORM
 
   # 2004/03/16 hjwang:變更程式名稱多語言架構
   CONSTRUCT BY NAME g_wc ON zz01,zz011,gaz03,
                             zz10,zz27,zz03,zz08,zz21,zz09,
                             zz22,zz14,zz06,zz17,zz16,zz07,
                             zz05,zz28,zz30,zz29,zz26,zz13,zz25,
                             zz31,zzuser,zzmodu,zzgrup,zzdate
 
#                            2004/03/26 將 zz04 排除在外, 因為不是直接查出來
#                                       的資料
#                            zz04,
 #                            zz23,zz24,zz18,zz19, #BUG-4B0066,MOD-4B0183
 #                            zz11,zz12,           #MOD-4B0066
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(zz01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gaz"
               LET g_qryparam.state = "c"
               LET g_qryparam.default1= g_zz.zz01
               LET g_qryparam.arg1 = g_lang CLIPPED
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO zz01
               NEXT FIELD zz01
 
            WHEN INFIELD(zz10)     #MOD-530169
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gaw"
               LET g_qryparam.state = "c"
               LET g_qryparam.default1= g_zz.zz10
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO zz10
               NEXT FIELD zz10
         END CASE
 
      ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
   END CONSTRUCT
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('zzuser', 'zzgrup') #FUN-980030
 
    #MOD-490466
   IF g_wc.getIndexOf("gaz03",1) THEN
      # MOD-4A0094
      LET g_sql="SELECT UNIQUE zz01 FROM zz_file, gaz_file ",  #OUTER gaz_file ",  #MOD-830017
                " WHERE gaz_file.gaz01 = zz_file.zz01 AND ",g_wc CLIPPED, " ORDER BY zz01"
   ELSE
      LET g_sql="SELECT zz01 FROM zz_file ", # 組合出 SQL 指令
                " WHERE ",g_wc CLIPPED, " ORDER BY zz01"
   END IF
 
   PREPARE p_zz_prepare FROM g_sql           # RUNTIME 編譯
   DECLARE p_zz_curs                         # SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR p_zz_prepare
 
    #MOD-490466
   IF g_wc.getIndexOf("gaz03",1) THEN
      LET g_sql= "SELECT COUNT(UNIQUE zz01) FROM zz_file,gaz_file WHERE zz01=gaz01 AND ",g_wc CLIPPED
   ELSE
      LET g_sql= "SELECT COUNT(*) FROM zz_file WHERE ",g_wc CLIPPED
   END IF
 
   PREPARE p_zz_precount FROM g_sql
   DECLARE p_zz_count CURSOR FOR p_zz_precount
 
END FUNCTION
 
FUNCTION p_zz_menu()
 
    DEFINE ls_zz04  STRING
    DEFINE ls_sql   STRING   #No.FUN-620071
    DEFINE l_cnt    LIKE   type_file.num5
 
    MENU ""
        BEFORE MENU
           CALL cl_navigator_setting(g_curs_index, g_row_count)
 
        ON ACTION insert                         #"A.輸入" HELP 32001
            LET g_action_choice="insert"
            IF cl_chk_act_auth() THEN
               CALL p_zz_a()
            END IF
 
        ON ACTION query                          #"Q.查詢" HELP 32002
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN
               CALL p_zz_q()
            END IF
 
        ON ACTION first                          #KEY(F)
            CALL p_zz_fetch('F')
 
        ON ACTION previous                       #"P.上筆" HELP 32004
            CALL p_zz_fetch('P')
 
        ON ACTION jump                           #KEY('/')
            CALL p_zz_fetch('/')
 
        ON ACTION next                           #"N.下筆" HELP 32003
            CALL p_zz_fetch('N')
 
        ON ACTION last                           #KEY(L)
            CALL p_zz_fetch('L')
 
        ON ACTION modify                         #"U.更改" HELP 32005
            LET g_action_choice="modify"
            IF cl_chk_act_auth() THEN
               CALL p_zz_u()
            END IF
 
        ON ACTION delete                         #"R.取消" HELP 32006
            LET g_action_choice="delete"
            IF cl_chk_act_auth() THEN
               CALL p_zz_r()
            END IF
 
        ON ACTION reproduce                      #"C.複製" HELP 32008
            LET g_action_choice="reproduce"
            IF cl_chk_act_auth() THEN
               CALL p_zz_copy()
            END IF
 
        ON ACTION output                          #FUN-570276
           LET g_action_choice="output"
           IF cl_chk_act_auth() THEN
              IF cl_null(g_wc) THEN
                 CALL cl_err('',-400,0)
              ELSE
                 MENU "" ATTRIBUTE(STYLE="popup")
                    ON ACTION print_withlength
                       IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
                       LET g_wc = g_wc, " AND gaz_file.gaz01=zz_file.zz01 ",
                                        " AND gaz_file.gaz02='",g_lang,"' "
                       LET g_msg='p_query "p_zz_1" "',g_wc CLIPPED,'"'
                       CALL cl_cmdrun(g_msg)
                    ON ACTION print_list
                       IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
                       LET g_wc = g_wc, " AND gaz_file.gaz01=zz_file.zz01 ",
                                        " AND gaz_file.gaz02='",g_lang,"' "
                       LET g_msg='p_query "p_zz" "',g_wc CLIPPED,'"'
                       CALL cl_cmdrun(g_msg)
                 END MENU
              END IF
           END IF
 
        ON ACTION maintain_link                  #"link 維護"
           LET g_action_choice="maintain_link"
           CALL p_zz_get_transname() #FUN-AC0058
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF NOT cl_null(g_transname) AND NOT cl_null(g_zz.zz01) THEN
                 IF g_transname.trim() != g_zz.zz01 CLIPPED THEN
                    IF g_transname = "p_query" OR g_transname = "p_report" THEN   #FUN-7C0042 FUN-A10114
                       CALL cl_err_msg(NULL, "azz-277",g_zz.zz01 CLIPPED,10)
                       CONTINUE MENU
                    END IF
                    CALL cl_err_msg(NULL, "azz-060", g_zz.zz01 CLIPPED || "|" || g_transname.trim(), 10)
                 END IF
                 LET g_msg='p_link "',g_transname,'" '
                 IF p_zz_chk_link() THEN
                    CALL cl_cmdrun_wait(g_msg)
                 END IF
              ELSE
                 CALL cl_err('',-400,0)
              END IF
           END IF
 
        ON ACTION maintain_act                   #"act 維護"
           LET g_action_choice="maintain_act"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF NOT cl_null(g_transname) AND NOT cl_null(g_zz.zz01) THEN
                 IF g_transname.trim() != g_zz.zz01 CLIPPED THEN
                    IF g_transname = "p_query" OR g_transname = "p_report" THEN   #FUN-7C0042 FUN-A10114
                       CALL cl_err_msg(NULL, "azz-277",g_zz.zz01 CLIPPED,10)
                       CONTINUE MENU
                    END IF
                    CALL cl_err_msg(NULL, "azz-060", g_zz.zz01 CLIPPED || "|" || g_transname.trim(), 10)
                 END IF
                 LET g_msg='p_base_act "',g_transname,'" "p_zz" "',g_zz.zz01 CLIPPED,'"'
                 IF p_zz_chk_action() THEN
                    CALL cl_cmdrun_wait(g_msg)
                 END IF
                 SELECT zz04 INTO g_zz.zz04 FROM zz_file WHERE zz01=g_zz.zz01
                 # 2004/06/10 資料結構改變
                 CALL s_act_desc_tab(g_zz.zz01,g_zz.zz04,g_zz.zz32,"0") RETURNING g_zz04_ds
                 DISPLAY g_zz04_ds TO zz04_ds
              ELSE
                 CALL cl_err('',-400,0)
              END IF
           END IF
 
        ON ACTION maintain_per                   #"per 維護"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF NOT cl_null(g_transname) AND NOT cl_null(g_zz.zz01) THEN
                 IF g_transname.trim() != g_zz.zz01 CLIPPED THEN
                    IF g_transname = "p_query" OR g_transname = "p_report" THEN   #FUN-7C0042 FUN-A10114
                       CALL cl_err_msg(NULL, "azz-277",g_zz.zz01 CLIPPED,10)
                       CONTINUE MENU
                    END IF
                    CALL cl_err_msg(NULL, "azz-060", g_zz.zz01 CLIPPED || "|" || g_transname.trim(), 10)
                 END IF
                 LET g_msg='p_base_per "',g_transname,'"'
                 CALL cl_cmdrun_wait(g_msg)
              ELSE
                 CALL cl_err('',-400,0)
              END IF
           END IF
 
        ON ACTION maintain_help                  #"help 維護"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF NOT cl_null(g_transname) AND NOT cl_null(g_zz.zz01) THEN
                 IF g_transname.trim() != g_zz.zz01 CLIPPED THEN
                    IF g_transname = "p_query" OR g_transname = "p_report" THEN   #FUN-7C0042 FUN-A10114
                       CALL cl_err_msg(NULL, "azz-277",g_zz.zz01 CLIPPED,10)
                       CONTINUE MENU
                    END IF
                    CALL cl_err_msg(NULL, "azz-060", g_zz.zz01 CLIPPED || "|" || g_transname.trim(), 10)
                 END IF
                 LET g_msg='p_help "',g_transname,'"'
                 CALL cl_cmdrun_wait(g_msg)
              ELSE
                 CALL cl_err('',-400,0)
              END IF
           END IF
 
        ON ACTION maintain_zr                    #"zr 維護"  FUN-570276
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF NOT cl_null(g_transname) AND NOT cl_null(g_zz.zz01) THEN
                 IF g_transname.trim() != g_zz.zz01 CLIPPED THEN
                    IF g_transname = "p_query" OR g_transname = "p_report" THEN   #FUN-7C0042 FUN-A10114
                       CALL cl_err_msg(NULL, "azz-277",g_zz.zz01 CLIPPED,10)
                       CONTINUE MENU
                    END IF
                    CALL cl_err_msg(NULL, "azz-060", g_zz.zz01 CLIPPED || "|" || g_transname.trim(), 10)
                 END IF
                 #FUN-AA0069
                 SELECT COUNT(*) INTO l_cnt FROM zr_file WHERE zr01 = g_zz.zz01
                 IF l_cnt = 0 THEN
                    LET g_msg='p_get_zr "',g_transname,'"'
                    CALL cl_cmdrun_wait(g_msg)
                 END IF
                 LET g_msg='p_zr "',g_transname,'"'

                 CALL cl_cmdrun_wait(g_msg)
              ELSE
                 CALL cl_err('',-400,0)
              END IF
           END IF
 
        ON ACTION maintain_menus                 #"目錄維護"
           IF NOT cl_null(g_zz.zz01) THEN
              IF g_zz.zz011 = "MENU" THEN
                 LET g_msg='p_zm "',g_zz.zz01,'"'
                 CALL cl_cmdrun_wait(g_msg)
              ELSE
                 CALL cl_err_msg(NULL, "azz-070", g_zz.zz01 CLIPPED, 10)
              END IF
           ELSE
              CALL cl_err('',-400,0)
           END IF
 
        ON ACTION exection                       #"執行"
           LET g_action_choice="exection"
           IF cl_chk_act_auth() AND NOT cl_null(g_zz.zz01) THEN
              IF g_zz.zz011 != "MENU" THEN
                 CALL cl_cmdrun(g_zz.zz01)
              ELSE
                 CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
              END IF
           ELSE
              CALL cl_err('',-400,0)
           END IF
 
        ON ACTION help                           #"H.說明" HELP 10102
            CALL cl_show_help()
 
        ON ACTION locale
           CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
        ON ACTION exit                           #"Esc.結束"
           LET g_action_choice="exit"
           EXIT MENU
 
        ON ACTION authorization                  #"K.群組權限設定"
           LET g_action_choice="authorization"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF cl_chk_act_auth() THEN
                 CALL p_zz_k()
              END IF
           END IF
 
        ON ACTION gen_auth                       #KEY(G) 更新單支權限
           LET g_action_choice="gen_auth"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF cl_chk_act_auth() THEN
                 CALL p_zz_gen()
              END IF
           END IF
 
        ON ACTION gen_auth_all                   #KEY(J) 權限批次更新
            LET g_action_choice="gen_auth_all"
            IF cl_chk_act_auth() THEN
               CALL p_zz_genall()
            END IF
 
         ON ACTION readlog                        #MOD-450030
           LET g_action_choice = "readlog"
           IF g_zz.zz011 = "MENU" THEN   #FUN-570276
              CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
           ELSE
              IF cl_chk_act_auth() THEN
                 CALL p_zz_readlog()
              END IF
           END IF
        #FUN-B50030 START

        ON ACTION maintain_4pw                          #FUN-B50030
           LET g_action_choice="maintain_4pw"
           IF cl_chk_act_auth() THEN
              IF cl_null(g_zz.zz01) THEN
                 CALL cl_err('',-400,0)
              ELSE
                 MENU "" ATTRIBUTE(STYLE="popup")
                    ON ACTION generation_4pw     #產生4pw
                       CALL p_zz_get_transname() #FUN-AC0058
                       LET g_msg='p_zz_proj "',g_transname,'" ' ,'"g"'
                       CALL cl_cmdrun(g_msg)  
                    ON ACTION reload_4pw         #回讀4pw
                       LET g_msg='p_zz_proj "',g_transname,'" ' ,'"r"'
                       CALL cl_cmdrun(g_msg)
                 END MENU
              END IF
           END IF
        #FUN-B50030 END

#TQC-AB0058 --begin--
#  #TQC-AB0023   --add
#         ON ACTION cancel
#            LET g_action_choice = "exit"
#            EXIT MENU
#  #TQC-AB0023 --end
#TQC-AB0058 --end--
  
         ON ACTION close  
  #COMMAND KEY(INTERRUPT) #FUN-9B0145  
            LET INT_FLAG=FALSE 		#MOD-570244	mars
            LET g_action_choice = "exit"
            EXIT MENU

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE MENU
 
        ON ACTION about         #MOD-4C0121
           CALL cl_about()      #MOD-4C0121
 
        ON ACTION controlg                       #KEY(CONTROL-G)
           CALL cl_cmdask()

        ON ACTION download_lnk  #FUN-B80190 --start--

           IF cl_chk_act_auth() AND NOT cl_null(g_zz.zz01) THEN
              IF g_zz.zz011 != "MENU" THEN
                 CALL p_zz_download_lnk() #FUN-B80190
              ELSE
                 CALL cl_err_msg(NULL, "azz-071", g_zz.zz01 CLIPPED, 10)
              END IF
           ELSE
              CALL cl_err('',-400,0)
           END IF
                                 #FUN-B80190 --end--
    END MENU
    CLOSE p_zz_curs
END FUNCTION
 
# FUN-B80190 -- start --
FUNCTION p_zz_download_lnk()
    DEFINE ls_temp_dir    STRING 
    DEFINE ls_temp_file   STRING
    DEFINE ls_bat_file   STRING
    DEFINE ls_str        STRING 
    DEFINE ls_str2       STRING
    DEFINE lc_channel    base.Channel
    DEFINE ls_file STRING 
    DEFINE ls_window_path STRING 
    
    LET ls_temp_file = g_prog,".txt"         #p_zz.txt
    LET ls_bat_file = "DSC_",g_zz.zz01,".bat"   #DSC_p_zz.bat 
    LET ls_temp_dir = FGL_GETENV("TEMPDIR")  
    LET ls_temp_dir = os.Path.join(ls_temp_dir,ls_temp_file)

    LET ls_window_path = cl_browse_dir()
    LET ls_window_path = os.Path.join(ls_window_path,ls_bat_file)
    
    LET lc_channel = base.Channel.create()
    CALL lc_channel.openFile(ls_temp_dir CLIPPED, "w" ) #a : For Append mode 
    CALL lc_channel.setDelimiter("")

    LET ls_str = "@echo off\n"
    LET ls_str = ls_str,"CD \"C:\\Program Files\\DSC\\TIPTOPSSO\\\"\n" #目前根據TIPTOPSSO安裝路徑為依據
    LET ls_str = ls_str,"START TIPTOPSSO.exe ",g_user," " ,g_plant," ",g_zz.zz01 ,"\n"
    LET ls_str = ls_str, "EXIT\n"
    CALL lc_channel.write(ls_str)
    CALL lc_channel.close()
                                  #先產生tmp之後下載到目的
    LET status = cl_download_file(ls_temp_dir,ls_window_path)  #cl_download_file("/tmp/a.doc", "C:/temp/b.doc")
    #DISPLAY "status:",status
    IF status THEN
       CALL cl_err(ls_window_path,"azz1087",1)
       DISPLAY "Download OK!!"
    ELSE
       CALL cl_err(ls_window_path,"azz1088",1)
       DISPLAY "Download fail!!"
    END IF
    
END FUNCTION
# FUN-B80190 -- end --
 
# MOD-4A0058 執行前先確認 p_link 有無資料, 如果無資料則
#            詢問是否對此 program ID 建立新 link 資料
FUNCTION p_zz_chk_link()
 
   DEFINE li_count  LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE lc_gak01  LIKE gak_file.gak01
 
   LET lc_gak01=g_transname.trim()
   SELECT count(*) INTO li_count
     FROM gak_file WHERE gak01=lc_gak01
   IF NOT SQLCA.SQLCODE AND li_count = 0 THEN
      IF cl_confirm("azz-062") THEN   #查無任何 link 資料,是否建立新的?
         INSERT INTO gak_file (gak01,gakuser,gakgrup,gakdate,gakoriu,gakorig)
                     VALUES (lc_gak01,g_user,g_grup,g_today, g_user, g_grup)       #No.FUN-980030 10/01/04  insert columns oriu, orig
         IF SQLCA.SQLCODE THEN
            CALL cl_err3("ins","gak_file",lc_gak01,"",SQLCA.sqlcode,"","Chk gak_file",0)   #No.FUN-660081
            RETURN FALSE
         END IF
         INSERT INTO gal_file (gal01,gal02,gal03,gal04)
                     VALUES (lc_gak01,g_zz.zz011,lc_gak01,"Y")
         IF SQLCA.SQLCODE THEN
            CALL cl_err3("ins","gal_file",lc_gak01,g_zz.zz011,SQLCA.sqlcode,"","Chk gal_file",0)   #No.FUN-660081
            RETURN FALSE
         END IF
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
 
FUNCTION p_zz_chk_action()
 
   DEFINE li_count  LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE lc_gap01  LIKE gap_file.gap01
 
   LET lc_gap01=g_transname.trim()
   SELECT count(*) INTO li_count
     FROM gap_file WHERE gap01=lc_gap01
   IF NOT SQLCA.SQLCODE AND li_count = 0 THEN
      IF cl_confirm("azz-063") THEN   #查無任何 Action 資料,建立臨時資料
         INSERT INTO gap_file (gap01,gap02,gap03,gap04,gap05,gap06)
                     VALUES (lc_gap01,"locale","N","N","N","N")
         IF SQLCA.SQLCODE THEN
            CALL cl_err3("ins","gap_file",lc_gap01,"locale",SQLCA.sqlcode,"","Chk gap_file",0)   #No.FUN-660081
            RETURN FALSE
         END IF
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
 
FUNCTION p_zz_a()
 
   MESSAGE ""
   CLEAR FORM                                   # 清螢墓欄位內容
   INITIALIZE g_zz.* LIKE zz_file.*
   LET g_transname = ""
   LET g_zz.zz16 = 0
   LET g_zz.zz07 = 0
   LET g_zz.zz09 = g_today
   LET g_zz.zz13 = 'N'
   LET g_zz.zz14 = '5'   #TQC-810008 add
   LET g_zz.zz15 = "N"
   LET g_zz.zz25 = 'N'
   LET g_zz.zz05 = 'N'
   LET g_zz.zz06 = '1'
   LET g_zz.zz26 = 'N'
   LET g_zz.zz28 = '3'     #TQC-870041
   LET g_zz.zz29 = '1'
   LET g_zz.zz30 = 0
   LET g_zz.zz32 = '0'
   LET g_zz01_t = NULL
   LET g_zz04_ds = NULL
   CALL cl_opmsg('a')
 
   WHILE TRUE
      LET g_zz.zzuser = g_user
      LET g_zz.zzmodu = ''
      LET g_zz.zzgrup = g_grup               #使用者所屬群
      LET g_zz.zzdate = g_today
 
      CALL p_zz_i("a")                      # 各欄位輸入
 
      IF INT_FLAG THEN                         # 若按了DEL鍵
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         CLEAR FORM
         EXIT WHILE
      END IF
 
      IF g_zz.zz01 IS NULL THEN                # KEY 不可空白
         CONTINUE WHILE
      END IF
 
      # DISK WRITE
      INSERT INTO zz_file (zz01,zz011,zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10,
 #                          zz11,zz12,   #MOD-4B0066
                           zz13,zz14,zz15,
                           zz16,zz17,
 #                          zz18,zz19,   #MOD-4B0183
                           zz21,zz22,
 #                          zz23,zz24,   #MOD-4B0066
                           zz25,zz26,zz27,zz28,zz29,zz30,zz31,
                           zz32,zzuser,zzgrup,zzmodu,zzdate)
          VALUES (g_zz.zz01, g_zz.zz011,g_zz.zz03, g_zz.zz04, g_zz.zz05,
                  g_zz.zz06, g_zz.zz07, g_zz.zz08, g_zz.zz09, g_zz.zz10,
 #                 g_zz.zz11, g_zz.zz12, #MOD-4B0066
                  g_zz.zz13, g_zz.zz14, g_zz.zz15,
                  g_zz.zz16, g_zz.zz17,
 #                 g_zz.zz18, g_zz.zz19, #MOD-4B0183
                  g_zz.zz21, g_zz.zz22,
 #                 g_zz.zz23, g_zz.zz24, #MOD-4B0066
                  g_zz.zz25, g_zz.zz26, g_zz.zz27, g_zz.zz28, g_zz.zz29,
                  g_zz.zz30, g_zz.zz31, g_zz.zz32,
                g_zz.zzuser, g_zz.zzgrup, g_zz.zzmodu, g_zz.zzdate)
 
      IF SQLCA.sqlcode THEN
#        CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)   #No.FUN-660081
         CALL cl_err3("ins","zz_file",g_zz.zz01,"",SQLCA.sqlcode,"","",0)   #No.FUN-660081
         CONTINUE WHILE
      ELSE
         LET g_zz_t.* = g_zz.*                # 保存上筆資料
         SELECT zz01 INTO g_zz.zz01 FROM zz_file
          WHERE zz01 = g_zz.zz01
         CALL p_zz_gen()
         CALL cl_err_msg(NULL, "azz-278", g_zz.zz01 CLIPPED || "|" || g_clas CLIPPED, 10)   #FUN-810043
         CALL p_zz_get_transname() # 2004/09/29 MOD-490276
      END IF
 
      EXIT WHILE
   END WHILE
 
END FUNCTION
 
FUNCTION p_zz_i(p_cmd)
 
   DEFINE p_cmd      LIKE type_file.chr1,    #No.FUN-680135 VARCHAR(1)
          l_sysi     LIKE type_file.chr3,    #No.FUN-680135 VARCHAR(03)
          l_zz08     LIKE zz_file.zz08,
          l_n        LIKE type_file.num5,    #No.FUN-680135 SMALLINT
          ls_msg     STRING
   DEFINE ls_zz04    STRING
   DEFINE ls_zz08    STRING   #FUN-A60046
   DEFINE l_str      STRING,                 #FUN-690069
          l_cnt      LIKE type_file.num5     #FUN-690069
   DEFINE li_smb03   LIKE type_file.num5     #MOD-810259
   DEFINE lc_smb03   LIKE smb_file.smb03     #MOD-810259
 
   # 2004/03/26 將 zz04 以多語言, 直行方式排列
   DISPLAY g_zz04_ds TO zz04_ds
 
   # 2004/03/16 hjwang: 變更程式名稱多語言架構
   INPUT BY NAME g_zz.zz01, g_zz.zz011, g_zz.gaz03,
                 g_zz.zz10, g_zz.zz27,  g_zz.zz03,
                 g_zz.zz08, g_zz.zz21,  g_zz.zz09,  g_zz.zz15,
                 g_zz.zz22, g_zz.zz14,  g_zz.zz06,  g_zz.zz17,
                 g_zz.zz16, g_zz.zz07,  g_zz.zz05,  g_zz.zz28,
                 g_zz.zz30, g_zz.zz29,  g_zz.zz26,  g_zz.zz13,
                 g_zz.zz25, g_zz.zz31,
                 g_zz.zzuser,g_zz.zzmodu,g_zz.zzgrup,g_zz.zzdate
 #                g_zz.zz04, g_zz.zz23,g_zz.zz24, #MOD-4B0066
 #                g_zz.zz18,g_zz.zz19,            #MOD-4B0183
 #                g_zz.zz11,g_zz.zz12,            #MOD-4B0066
         WITHOUT DEFAULTS
 
      BEFORE INPUT
         LET g_before_input_done = FALSE
          #NO.MOD-580056 MARK
         #CALL p_zz_set_entry()
         #CALL p_zz_set_no_entry()
         #--
         CALL p_zz_set_entry(p_cmd)
         CALL p_zz_set_no_entry(p_cmd)
         LET g_before_input_done = TRUE
 
      AFTER FIELD zz01
         IF NOT cl_null(g_zz.zz01) THEN
            IF p_cmd = "a" OR (p_cmd = "u" AND g_zz.zz01 != g_zz01_t) THEN
               SELECT count(*) INTO l_n FROM zz_file
                WHERE zz01 = g_zz.zz01
               IF l_n > 0 THEN                  # Duplicated
                  CALL cl_err(g_zz.zz01,-239,0)
                  LET g_zz.zz01 = g_zz01_t
                  DISPLAY BY NAME g_zz.zz01 #ATTRIBUTE(YELLOW)
                  NEXT FIELD zz01
               END IF
               #MOD-810259
               CALL p_zz_zz01_industry() RETURNING li_smb03,lc_smb03
               IF li_smb03 THEN
                  CALL cl_err_msg(NULL,"azz-279",g_zz.zz01||"|"||lc_smb03,30)
               END IF
               IF g_zz.zz01[1]='a' AND LENGTH(g_zz.zz01)=7 AND cl_null(g_zz.zz08[21]) THEN
                  LET g_zz.zz03=UPSHIFT(g_zz.zz01[4,4])
                  LET l_sysi=UPSHIFT(g_zz.zz01[1,3])
                  IF cl_get_os_type() <> "WINDOWS" THEN    #MOD-830017
                     LET g_zz.zz08='$FGLRUN $'
                     LET g_zz.zz08=g_zz.zz08 CLIPPED,l_sysi,'i/',g_zz.zz01
                  ELSE
                     LET g_zz.zz08='%FGLRUN% %'
                     LET g_zz.zz08=g_zz.zz08 CLIPPED,l_sysi,'i%/',g_zz.zz01
                  END IF
                  DISPLAY BY NAME g_zz.zz03,g_zz.zz08
               END IF
            END IF
         END IF
 
      AFTER FIELD zz08
         IF cl_get_os_type()= "WINDOWS" THEN   #FUN-A60046 
            LET ls_zz08 = g_zz.zz08
            IF ls_zz08.getIndexOf("'",1) >0 THEN          
               CALL cl_err('',"azz-808",1)
               NEXT FIELD zz08
            END IF
         END IF

      AFTER FIELD zz011
         IF g_zz.zz011="AGL" OR g_zz.zz011="CGL" OR
            g_zz.zz011="GGL" OR g_zz.zz011="CGGL" THEN
            CALL cl_set_comp_visible("zz15",TRUE)
         ELSE
            CALL cl_set_comp_visible("zz15",FALSE)
         END IF
 
      BEFORE FIELD zz28
         #CALL p_zz_set_entry()  #NO.MOD-580056 MARK
        CALL p_zz_set_entry(p_cmd)
 
      AFTER FIELD zz28
         #CALL p_zz_set_no_entry()  #NO.MOD-580056 MARK
        CALL p_zz_set_no_entry(p_cmd)
        IF g_zz.zz28 != "2" THEN
           LET g_zz.zz29 = ""
           LET g_zz.zz30 = ""
        END IF
        DISPLAY BY NAME g_zz.zz29,g_zz.zz30

      #FUN-B70050----add--start      
      BEFORE FIELD zz03
        CALL p_zz_set_entry(p_cmd)  

      AFTER FIELD zz03
        CALL p_zz_set_no_entry(p_cmd)
      #FUN-B70050----add--end
 
      #FUN-690069
      AFTER INPUT
         LET g_zz.zzuser = s_get_data_owner("zz_file") #FUN-C10039
         LET g_zz.zzgrup = s_get_data_group("zz_file") #FUN-C10039
         IF INT_FLAG THEN EXIT INPUT END IF           # 使用者不玩了
        #str TQC-810008 add
         IF cl_null(g_zz.zz14) THEN
            CALL cl_err(g_zz.zz14,'mfg0037',0)   #本欄位不可空白, 請重新輸入!
            NEXT FIELD zz14
         ELSE
            IF g_zz.zz03='R' AND g_zz.zz14='5' THEN   #程式類別=R.報表
               CALL cl_err(g_zz.zz14,'azz-802',0)
               NEXT FIELD zz14
            END IF
         END IF
        #end TQC-810008 add
         # str TQC-870041
          IF cl_null(g_zz.zz28) THEN
                CALL cl_err(g_zz.zz28,'mfg0037',0)   #本欄位不可空白, 請重新輸入!
                NEXT FIELD zz28
          END IF
         # end TQC-870041
         LET l_str = g_zz.zz08
         IF l_str.getIndexOf('p_query',1) > 0 
          AND g_zz.zz01 <> "p_query"
         THEN
            SELECT COUNT(*) INTO l_cnt FROM zai_file WHERE zai01 = g_zz.zz01
            IF l_cnt = 0 THEN
               CALL cl_err(g_zz.zz01,'azz-257',0)
               NEXT FIELD zz01
            END IF
         END IF
      #END FUN-690069
 
      ON ACTION update_user
         CASE WHEN INFIELD(zz04)
                 UPDATE zy_file SET zy03 = g_zz.zz04
                  WHERE zy02 = g_zz.zz01
              WHEN INFIELD(zz13)
                 UPDATE zy_file SET zy04 = g_zz.zz13
                  WHERE zy02 = g_zz.zz01
         END CASE
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(zz01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gaz"
               LET g_qryparam.default1= g_zz.zz01
               LET g_qryparam.arg1= g_lang
               CALL cl_create_qry() RETURNING g_zz.zz01
               DISPLAY g_zz.zz01 TO zz01
               NEXT FIELD zz01
            WHEN INFIELD(zz10)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gaw"
               LET g_qryparam.default1= g_zz.zz10
               CALL cl_create_qry() RETURNING g_zz.zz10
               DISPLAY g_zz.zz10 TO zz10
               NEXT FIELD zz10
            OTHERWISE
               EXIT CASE
         END CASE
 
      ON ACTION controlo                         # 沿用所有欄位
         IF INFIELD(zz01) THEN
             LET g_zz.* = g_zz_t.*
             LET g_zz.zz09 = g_today
             LET g_zz.zz16 = 0
             LET g_zz.zzuser = g_user
             LET g_zz.zzmodu = g_user
             LET g_zz.zzdate = g_today
             CALL p_zz_show()
             NEXT FIELD zz01
         END IF
 
      ON ACTION controlv
         CALL cl_show_req_fields()
 
      ON ACTION controlf                         # 欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
display'frm_name:',g_frm_name,' fld-name:',g_fld_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
#      ON ACTION modify_basic_func
#         # 2004/06/08 因應共用程式問題  此處應傳 g_transname
#         CALL s_act_define(NULL,g_transname,'zz_file',g_zz.zz04,g_zz.zz32)
#              RETURNING ls_zz04,g_zz.zz32
#         # 2004/04/28 必須在回來時重選重秀
#         # 2004/06/10 資料結構改變
#         CALL s_act_desc_tab(g_zz.zz01,ls_zz04,g_zz.zz32,"0") RETURNING g_zz04_ds
#         LET g_zz.zz04= ls_zz04
#         DISPLAY g_zz04_ds TO zz04_ds
 
      ON ACTION modify_program_name
         #CALL p_gaz_item(g_zz.zz01)     #TQC-760179
         CALL p_gaz_item(g_zz.zz01,'P')  #TQC-760179
         # 2004/03/24 因為並沒有傳語言別進入 p_gaz_item,所以必在回來時重選重秀
         CALL p_zz_update_zz03()
         DISPLAY " " TO gaz03
         DISPLAY g_zz.gaz03 TO gaz03
 
     #TQC-760179 begin
      ON ACTION modify_report_title
         CALL p_gaz_item(g_zz.zz01,'R')
         CALL p_zz_show_rpttitle()
     #TQC-760179 end
 
      ON ACTION about         #FUN-860033
         CALL cl_about()      #FUN-860033
 
      ON ACTION controlg      #FUN-860033
         CALL cl_cmdask()     #FUN-860033
 
      ON ACTION help          #FUN-860033
         CALL cl_show_help()  #FUN-860033
 
      ON IDLE g_idle_seconds  #FUN-860033
          CALL cl_on_idle()
          CONTINUE INPUT
 
   END INPUT
 
END FUNCTION
 
#TQC-760179 begin
FUNCTION p_zz_show_rpttitle()
  DEFINE l_gaz06 LIKE gaz_file.gaz06
  SELECT gaz06 INTO l_gaz06 FROM gaz_file
   WHERE gaz01=g_zz.zz01 AND gaz02=g_lang AND gaz05="Y"
  IF SQLCA.sqlcode THEN
    LET l_gaz06 = ''
  END IF
  IF l_gaz06 is null OR l_gaz06 = ' ' THEN
    SELECT gaz06 INTO l_gaz06 FROM gaz_file
     WHERE gaz01=g_zz.zz01 AND gaz02=g_lang AND gaz05="N"
    IF SQLCA.sqlcode THEN
      LET l_gaz06 = ''
    END IF
  END IF
  DISPLAY l_gaz06 TO gaz06
END FUNCTION
#TQC-760179 end
 
FUNCTION p_zz_update_zz03()
   SELECT gaz03 INTO g_zz.gaz03 FROM gaz_file
    WHERE gaz01=g_zz.zz01 AND gaz02=g_lang AND gaz05="Y"
   IF g_zz.gaz03 is null OR g_zz.gaz03=" " THEN
      SELECT gaz03 INTO g_zz.gaz03 FROM gaz_file
       WHERE gaz01=g_zz.zz01 AND gaz02=g_lang AND gaz05="N"
   END IF
END FUNCTION
 
 #FUNCTION p_zz_set_entry()  #NO.MOD-580056 MARK
FUNCTION p_zz_set_entry(p_cmd)
DEFINE p_cmd LIKE type_file.chr1    #bug-580056  #No.FUN-680135 VARCHAR(1)
 
    #NO.MOD-580056
   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
     CALL cl_set_comp_entry("zz01",TRUE)
   END IF
   #--END
 
   IF INFIELD(zz28) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("zz29,zz30",TRUE)
   END IF

   #FUN-B70050----add--start   
   IF g_zz.zz03 = 'I' THEN 
    CALL cl_set_comp_entry("zz13",TRUE)
   END IF
   #FUN-B70050----add--end
   
END FUNCTION
 
 #FUNCTION p_zz_set_no_entry()  #NO.MOD-580056 MARK
FUNCTION p_zz_set_no_entry(p_cmd)
 DEFINE p_cmd LIKE type_file.chr1    #MOD-580056  #No.FUN-680135 VARCHAR(1)
 
    #MOD-580056
   IF p_cmd = 'u' AND ( NOT g_before_input_done ) AND g_chkey='N' THEN
     CALL cl_set_comp_entry("zz01",FALSE)
   END IF
   #--END
 
   IF INFIELD(zz28) OR (NOT g_before_input_done) THEN
      IF g_zz.zz28 != "2" THEN
         CALL cl_set_comp_entry("zz29,zz30",FALSE)
      END IF
   END IF

   #FUN-B70050----add--start   
   IF g_zz.zz03 <> 'I' THEN
    CALL cl_set_comp_entry("zz13",FALSE)
    LET g_zz.zz13 ='N'
   END IF
   #FUN-B70050----add--end  
   
END FUNCTION
 
FUNCTION p_zz_get_transname()
 
   DEFINE ls_zz08   STRING
   DEFINE li_s      LIKE type_file.num5    #No.FUN-680135 
   DEFINE li_e      LIKE type_file.num5    #No.FUN-680135
   DEFINE li_shift  LIKE type_file.num5
 
   LET ls_zz08 = g_zz.zz08 CLIPPED
 
   #UNIX環境變數只要前端加 $,Windows要前後加%,故兩者shift位置差1
   IF os.Path.separator()="/" THEN
      LET li_s = ls_zz08.getIndexOf("i/",1)    #UNIX Base
      LET li_shift = 2
   ELSE
      LET li_s = ls_zz08.getIndexOf("i%\/",1)  #Windows Base
      LET li_shift = 3
   END IF
   LET li_e = ls_zz08.getIndexOf(" ",li_s+1)
 
   IF li_e = 0 THEN
      LET li_e = ls_zz08.getLength()
      LET g_transname = ls_zz08.subString(li_s+li_shift,li_e)
   ELSE
      LET g_transname = ls_zz08.subString(li_s+li_shift,li_e-1)
   END IF
   RETURN
END FUNCTION
 
FUNCTION p_zz_q()
 
   LET g_row_count = 0
   LET g_zz.zz01=""
   CALL cl_navigator_setting(g_curs_index, g_row_count)
 
   MESSAGE ""
   CALL cl_opmsg('q')
   DISPLAY '   ' TO FORMONLY.cnt
 
   CALL p_zz_curs()                          # 宣告 SCROLL CURSOR
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLEAR FORM
      RETURN
   END IF
 
   OPEN p_zz_count
   FETCH p_zz_count INTO g_row_count
   DISPLAY g_row_count TO FORMONLY.cnt
 
   OPEN p_zz_curs                            # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)
      INITIALIZE g_zz.* TO NULL
      LET g_transname=""
   ELSE
      CALL p_zz_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF
 
END FUNCTION
 
FUNCTION p_zz_fetch(p_flzz)
   DEFINE
       p_flzz          LIKE type_file.chr1,   #No.FUN-680135 VARCHAR(1)
       l_abso          LIKE type_file.num10   #No.FUN-680135 INTEGER
 
   CASE p_flzz
      WHEN 'N' FETCH NEXT     p_zz_curs INTO g_zz.zz01
      WHEN 'P' FETCH PREVIOUS p_zz_curs INTO g_zz.zz01
      WHEN 'F' FETCH FIRST    p_zz_curs INTO g_zz.zz01
      WHEN 'L' FETCH LAST     p_zz_curs INTO g_zz.zz01
      WHEN '/'
            IF (NOT g_no_ask) THEN  #FUN-6A0080
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
 
               PROMPT g_msg CLIPPED,': ' FOR g_jump
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()
 
                  ON ACTION about         #MOD-4C0121
                     CALL cl_about()      #MOD-4C0121
 
                  ON ACTION help          #MOD-4C0121
                     CALL cl_show_help()  #MOD-4C0121
 
                  ON ACTION controlg      #MOD-4C0121
                     CALL cl_cmdask()     #MOD-4C0121
 
               END PROMPT
               IF INT_FLAG THEN
                  LET INT_FLAG = 0
                  LET g_jump = g_curs_index     #No.FUN-5C0121
                  EXIT CASE
               END IF
            END IF
            FETCH ABSOLUTE g_jump p_zz_curs INTO g_zz.zz01
            LET g_no_ask = FALSE     #FUN-6A0080
   END CASE
 
   IF SQLCA.sqlcode THEN
      #No.FUN-690060
      INITIALIZE g_zz.* TO NULL
      LET g_zz.zz01 = NULL
      #END No.FUN-690060
      CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)
      RETURN
   ELSE
      CASE p_flzz
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
 
      CALL cl_navigator_setting(g_curs_index, g_row_count)
   END IF
 
   SELECT zz01,zz011,'',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10,
 #         zz11,zz12,  #MOD-4B0066
          zz13,zz14,zz15,
          zz16,zz17,
 #         zz18,zz19,  #MOD-4B0183
          zz21,zz22,
 #         zz23,zz24,  #MOD-4B0066
          zz25,zz26,zz27,zz28,zz29,zz30,zz31,
          zz32,zzuser,zzgrup,zzmodu,zzdate
     INTO g_zz.*
     FROM zz_file  # 重讀DB,因TEMP有不被更新特性
    WHERE zz01 = g_zz.zz01      #FUN-960118
 
   IF SQLCA.sqlcode THEN
#     CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)   #No.FUN-660081
      CALL cl_err3("sel","zz_file",g_zz.zz01,"",SQLCA.sqlcode,"","",0)   #No.FUN-660081
   ELSE                                  #FUN-4C0040權限控管
       LET g_data_owner=g_zz.zzuser
       LET g_data_group=g_zz.zzgrup
      CALL p_zz_update_zz03()
 
      # 2004/03/26 權限項目變更顯示方法
      CALL s_act_desc_tab(g_zz.zz01,g_zz.zz04,g_zz.zz32,"0") RETURNING g_zz04_ds
 
      CALL p_zz_show()                      # 重新顯示
   END IF
 
END FUNCTION
 
FUNCTION p_zz_show()
 
   LET g_zz_t.* = g_zz.*
 
   # 2004/05/19 抓 trans name
   CALL p_zz_get_transname()
 
   # 2004/12/29 若 zz011=AGL,CGL,GGL or CGGL 才 show zz15
   IF g_zz.zz011="AGL" OR g_zz.zz011="CGL" OR
      g_zz.zz011="GGL" OR g_zz.zz011="CGGL" THEN
      CALL cl_set_comp_visible("zz15",TRUE)
   ELSE
      CALL cl_set_comp_visible("zz15",FALSE)
   END IF
 
   DISPLAY g_zz.zz01,g_zz.zz011,g_zz.gaz03,g_zz.zz10,g_zz.zz27,
           g_zz.zzuser,g_zz.zzmodu,g_zz.zzgrup,g_zz.zzdate,
           g_zz.zz03,g_zz.zz14,g_zz04_ds,
 #          g_zz.zz23,g_zz.zz24,g_zz.zz18,g_zz.zz19,  #BUG-4B0066,MOD-4B0183
           g_zz.zz08,g_zz.zz21,
           g_zz.zz22,g_zz.zz17,g_zz.zz16,g_zz.zz07,g_zz.zz06,
 #          g_zz.zz11,g_zz.zz12,                      #MOD-4B0066
           g_zz.zz09,g_zz.zz15,
           g_zz.zz13,g_zz.zz25,g_zz.zz05,g_zz.zz26,
           g_zz.zz28,g_zz.zz29,g_zz.zz30,g_zz.zz31
        TO zz01,zz011,gaz03,zz10,zz27,
           zzuser,zzmodu,zzgrup,zzdate,
           zz03,zz14,zz04_ds,
 #          zz23,zz24,zz18,zz19,                      #BUG-4B0066,MOD-4B0183
           zz08,zz21,
           zz22,zz17,zz16,zz07,zz06,
 #          zz11,zz12,   #MOD-4B0066
           zz09,zz15,
           zz13,zz25,zz05,zz26,zz28,zz29,zz30,zz31
 
    CALL p_zz_show_rpttitle()   #TQC-760179
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION
 
FUNCTION p_zz_u()
 
   IF g_zz.zz01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_zz01_t = g_zz.zz01
   BEGIN WORK
 
   OPEN p_zz_curl USING g_zz.zz01
   IF SQLCA.sqlcode THEN
      CALL cl_err('OPEN zo_file',SQLCA.sqlcode,1)
      RETURN
   END IF
 
   FETCH p_zz_curl INTO g_zz.*               # 對DB鎖定
   IF SQLCA.sqlcode THEN
      CALL cl_err('FETCH zo_file',SQLCA.sqlcode,1)
      RETURN
   END IF
 
   LET g_zz01_t = g_zz.zz01
   LET g_zz.zzdate = g_today                  #修改日期
 
   # 2004/03/16 抓取程式名稱
   CALL p_zz_update_zz03()
 
   # 2004/03/26 權限項目變更顯示方法
   CALL s_act_desc_tab(g_zz.zz01,g_zz.zz04,g_zz.zz32,"0") RETURNING g_zz04_ds
 
   CALL p_zz_show()                          # 顯示最新資料
 
   WHILE TRUE
      CALL p_zz_i("u")                      # 欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
 
      # 更新DB
      UPDATE zz_file SET zz01 = g_zz.zz01, zz011= g_zz.zz011,
                         zz03 = g_zz.zz03, zz04 = g_zz.zz04,
                         zz05 = g_zz.zz05, zz06 = g_zz.zz06,
                         zz07 = g_zz.zz07, zz08 = g_zz.zz08,
                         zz09 = g_zz.zz09, zz10 = g_zz.zz10,
 #                        zz11 = g_zz.zz11, zz12 = g_zz.zz12,  #MOD-4B0066
                         zz13 = g_zz.zz13, zz14 = g_zz.zz14,
                         zz15 = g_zz.zz15,
                         zz16 = g_zz.zz16, zz17 = g_zz.zz17,
 #                        zz18 = g_zz.zz18, zz19 = g_zz.zz19,  #MOD-4B0183
                         zz21 = g_zz.zz21, zz22 = g_zz.zz22,
 #                        zz23 = g_zz.zz23, zz24 = g_zz.zz24,  #MOD-4B0066
                         zz25 = g_zz.zz25, zz26 = g_zz.zz26,
                         zz27 = g_zz.zz27, zz28 = g_zz.zz28,
                         zz29 = g_zz.zz29, zz30 = g_zz.zz30,
                         zz31 = g_zz.zz31,
                         zz32 = g_zz.zz32,
                         zzuser = g_zz.zzuser,
                         zzgrup = g_zz.zzgrup,
                        #zzmodu = g_zz.zzmodu,       #MOD-B50035 mark
                         zzmodu = g_user,            #MOD-B50035 add
                         zzdate = g_zz.zzdate
                   WHERE zz01 = g_zz_t.zz01
 
      IF SQLCA.sqlcode THEN
#        CALL cl_err(g_zz.zz01,SQLCA.sqlcode,1)   #No.FUN-660081
         CALL cl_err3("upd","zz_file",g_zz01_t,"",SQLCA.sqlcode,"","",1)   #No.FUN-660081
         CONTINUE WHILE
      END IF
 
      IF g_zz.zz01<>g_zz_t.zz01 THEN
         UPDATE zm_file SET zm01=g_zz.zz01 WHERE zm01=g_zz_t.zz01
         UPDATE zm_file SET zm04=g_zz.zz01 WHERE zm04=g_zz_t.zz01
         UPDATE zy_file SET zy02=g_zz.zz01 WHERE zy02=g_zz_t.zz01
      END IF
 
#     #FUN-830037 由於 #TQC-920011已將create_4sm改為exe2作法,以下整段mark掉
#     IF g_zz.zz08 <> g_zz_t.zz08 THEN
#        CALL p_zz_update_4sm(g_zz_t.zz08 CLIPPED,g_zz.zz08 CLIPPED)
#        CALL cl_err("","azz-707",0)
#        CALL ui.Interface.refresh()
#     END IF
 
      EXIT WHILE
   END WHILE
 
   CLOSE p_zz_curl
   COMMIT WORK
 
END FUNCTION
 
FUNCTION p_zz_r()
   DEFINE
       l_chr LIKE type_file.chr1    #No.FUN-680135 VARCHAR(1)
 
   IF g_zz.zz01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   BEGIN WORK
 
   OPEN p_zz_curl USING g_zz.zz01
 
   FETCH p_zz_curl INTO g_zz.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)
      RETURN
   END IF
 
   # 2004/03/26 權限項目變更顯示方法
   CALL s_act_desc_tab(g_zz.zz01,g_zz.zz04,g_zz.zz32,"0") RETURNING g_zz04_ds
 
   CALL p_zz_update_zz03()   #MOD-830017
   CALL p_zz_show()
 
   IF cl_delete() THEN
      DELETE FROM zz_file WHERE zz01 = g_zz.zz01
      IF SQLCA.sqlcode THEN
#        CALL cl_err("del zz:",SQLCA.sqlcode,0)   #No.FUN-660081
         CALL cl_err3("del","zz_file",g_zz.zz01,"",SQLCA.sqlcode,"","del zz",0)   #No.FUN-660081
         ROLLBACK WORK
      END IF
 
      DELETE FROM zy_file WHERE zy02=g_zz.zz01
      DELETE FROM zr_file WHERE zr01=g_zz.zz01
      DELETE FROM zm_file WHERE zm04=g_zz.zz01
      DELETE FROM zm_file WHERE zm01=g_zz.zz01
 
      IF cl_confirm("azz-065") THEN   #是否刪除 gaz gak gal gap 等資料?
         DELETE FROM gaz_file WHERE gaz01=g_zz.zz01
         DELETE FROM gak_file WHERE gak01=g_zz.zz01
         DELETE FROM gal_file WHERE gal01=g_zz.zz01
         DELETE FROM gap_file WHERE gap01=g_zz.zz01
         DELETE FROM gax_file WHERE gax01=g_zz.zz01  #MOD-530797
         DELETE FROM gbi_file WHERE gbi02=g_zz.zz01  #MOD-950281
      END IF
 
      LET g_msg = TIME
 
      INSERT INTO azo_file (azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)  #FUN-980011 add
             VALUES('p_zz',g_user,g_today,g_msg,g_zz.zz01,'delete',g_plant,g_legal) #FUN-980011 add
 
      CLEAR FORM
      INITIALIZE g_zz.* TO NULL
      LET g_transname=""
      OPEN p_zz_count
      #FUN-B60064-add-str--
      IF STATUS THEN
         CLOSE p_zz_curl
         CLOSE p_zz_count
         COMMIT WORK
         RETURN
      END IF
      #FUN-B60064-add-end--
      FETCH p_zz_count INTO g_row_count
      #FUN-B60064-add-str--
      IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
         CLOSE p_zz_curl
         CLOSE p_zz_count
         COMMIT WORK
         RETURN
      END IF
      #FUN-B60064-add-end--
      DISPLAY g_row_count TO FORMONLY.cnt
      OPEN p_zz_curs
      IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL p_zz_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET g_no_ask = TRUE       #FUN-6A0080
         CALL p_zz_fetch('/')
      END IF
   END IF
 
   CLOSE p_zz_curl
   COMMIT WORK
 
END FUNCTION
 
 
# 2004/06/16 群組權限設定: 更新 zy 中所有群組下有關本程式(zz01)的權限記錄
FUNCTION p_zz_k()
   DEFINE l_zy DYNAMIC ARRAY OF RECORD
           zy01     LIKE zy_file.zy01,
           zw02     LIKE zw_file.zw02,        #FUN-B70091
           zy03     LIKE zy_file.zy03,
           zy04     LIKE zy_file.zy04,
           zy05     LIKE zy_file.zy05,
#          zy06     LIKE zy_file.zy06,        #FUN-5C0057
           zy07     LIKE zy_file.zy07
               END RECORD
# 2004/08/19 l_zy要直接 show出來,所以select到資料後將 zy03另外寫入到lc_zy03
# DEFINE lc_zy03 DYNAMIC ARRAY OF RECORD    #MOD-580200
#          zy03     LIKE zy_file.zy03
#              END RECORD
 
   DEFINE l_exit_sw LIKE type_file.chr1   #No.FUN-680135 VARCHAR(1)
   DEFINE li_i     LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE li_j     LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE li_k     LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE m_zy     RECORD                 # 整批更新用
           zy01     LIKE zy_file.zy01,
           zy02     LIKE zy_file.zy02,
           zy03     LIKE zy_file.zy03,
           zy04     LIKE zy_file.zy04,
           zy05     LIKE zy_file.zy05,
#          zy06     LIKE zy_file.zy06,     #FUN-5C0057
           zy07     LIKE zy_file.zy07,
           zyuser   LIKE zy_file.zyuser,
           zygrup   LIKE zy_file.zygrup,
           zymodu   LIKE zy_file.zymodu,
           zydate   LIKE zy_file.zydate
               END RECORD
   DEFINE l_allow_insert LIKE type_file.num5    #No.FUN-680135 SMALLINT
   DEFINE l_allow_delete LIKE type_file.num5    #No.FUN-680135 SMALLINT
   #Begin:FUN-B60070
   DEFINE l_zw_list STRING,
          l_zw_stok base.StringTokenizer
   #End:FUN-B60070
 
   IF cl_null(g_zz.zz01) THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF
 
   OPEN WINDOW p_zz_kw WITH FORM "azz/42f/p_zz_k"
   ATTRIBUTE(STYLE=g_win_style CLIPPED)
 
   CALL cl_ui_locale("p_zz_k")
 
   CALL l_zy.clear()
#  CALL lc_zy03.clear()     #MOD-580200
 
   DECLARE p_zz_kc CURSOR FOR
#     SELECT zy01,zy03,zy04,zy05,zy07 FROM zy_file        #FUN-5C0057
#     SELECT zy01,zy03,zy04,zy05,zy06,zy07 FROM zy_file
      SELECT zy01,zw02,zy03,zy04,zy05,zy07 FROM zy_file   #FUN-B70091
       LEFT JOIN zw_file ON zy_file.zy01 = zw_file.zw01   #FUN-B70091
       WHERE zy02=g_zz.zz01 ORDER BY 1
 
   LET li_i=1
 
   FOREACH p_zz_kc INTO l_zy[li_i].*
      # 04/08/19 變更權限顯示方式
      # 05/03/16 BUG-530126   MOD-580200
#     LET lc_zy03[li_i].zy03=l_zy[li_i].zy03
#     CALL s_act_desc_tab(g_zz.zz01,lc_zy03[li_i].zy03,l_zy[li_i].zy07,"1") RETURNING l_zy[li_i].zy03
 
      LET li_i=li_i + 1
      IF li_i > g_max_rec THEN
         CALL cl_err('',9035,0)
         EXIT FOREACH
      END IF
   END FOREACH
   CALL l_zy.deleteElement(li_i)
   LET li_i=li_i-1
 
   BEGIN WORK
   LET g_success='Y'
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   # 2004/06/16 如果重新產生  則再檢查一下
   WHILE TRUE
     LET l_exit_sw="Y"
     INPUT ARRAY l_zy WITHOUT DEFAULTS FROM s_zy.*
        ATTRIBUTE(COUNT=li_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                  INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE FIELD zy01
           LET li_k = ARR_CURR()
           IF l_zy[li_k].zy01 IS NULL THEN
              LET l_zy[li_k].zw02=NULL    #FUN-B70091
#             #MOD-580200
              LET l_zy[li_k].zy03=g_zz.zz04
#             LET lc_zy03[li_k].zy03=g_zz.zz04  # lc_zy03實存資料移動
              LET l_zy[li_k].zy04='0'
              LET l_zy[li_k].zy05='0'
#             LET l_zy[li_k].zy06=NULL    #FUN-5C0057
              LET l_zy[li_k].zy07='0'
           END IF
 
        AFTER FIELD zy01
           IF NOT cl_null(l_zy[li_k].zy01) THEN
              FOR li_j=1 TO l_zy.getLength()
                 IF li_j=li_k THEN CONTINUE FOR END IF
                 IF l_zy[li_j].zy01=l_zy[li_k].zy01 THEN
                    CALL cl_err('','-239',0)
                    NEXT FIELD zy01
                 END IF
              END FOR
 
#             SELECT zw02 FROM zw_file WHERE zw01=l_zy[li_k].zy01
              SELECT zw02 INTO l_zy[li_k].zw02 FROM zw_file WHERE zw01=l_zy[li_k].zy01   #FUN-B70091
              IF STATUS THEN
#                CALL cl_err('sel zw:',STATUS,0)   #No.FUN-660081
                 CALL cl_err3("sel","zw_file",l_zy[li_k].zy01,"",STATUS,"","sel zw",0)   #No.FUN-660081
                 NEXT FIELD zy01
              END IF
              DISPLAY l_zy[li_k].zw02 TO zw02          #FUN-B70091
           END IF

        #Begin:FUN-B60070
        ON ACTION controlp
            CASE
               WHEN INFIELD(zy01)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_zw"
                  LET g_qryparam.default1 = l_zy[li_k].zy01
                  CALL cl_create_qry() RETURNING l_zy[li_k].zy01
                  DISPLAY l_zy[li_k].zy01 TO zy01
               OTHERWISE
                  EXIT CASE
           END CASE
        #End:FUN-B60070

        ON ACTION all_add
           CALL p_zz_w() RETURNING l_zw_list #FUN-B60070:群組資料改為勾選方式處理.
           IF NOT cl_null(l_zw_list) THEN #FUN-B60070 
              LET l_exit_sw="N"
              EXIT INPUT
           END IF
 
        ON ACTION modify_auth
           LET li_k = ARR_CURR()   #MOD-8B0286 add
           # 2004/08/19 變更權限顯示方式
#          #MOD-580200取消顯示方式變更
           CALL s_act_define(l_zy[li_k].zy01,g_zz.zz01,'zy_file',l_zy[li_k].zy03,l_zy[li_k].zy07)
                RETURNING l_zy[li_k].zy03,l_zy[li_k].zy07
#          CALL s_act_define(l_zy[li_k].zy01,g_zz.zz01,'zy_file',lc_zy03[li_k].zy03,l_zy[li_k].zy07)
#               RETURNING lc_zy03[li_k].zy03,l_zy[li_k].zy07
#          CALL s_act_desc_tab(g_zz.zz01,lc_zy03[li_k].zy03,l_zy[li_k].zy07,"1") RETURNING l_zy[li_k].zy03
           DISPLAY l_zy[li_k].zy03 TO zy03
           DISPLAY l_zy[li_k].zy04 TO zy04
           NEXT FIELD zy03
 
        ON ACTION modify_detail_auth   #FUN-5A0192
           CALL s_act_detail(l_zy[li_k].zy07) RETURNING l_zy[li_k].zy07
           DISPLAY l_zy[li_k].zy07 TO zy07
 
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
     END INPUT
 
     IF INT_FLAG THEN
        LET INT_FLAG=0
        ROLLBACK WORK
        CLOSE WINDOW p_zz_kw
        RETURN
     END IF
 
     # 2004/06/16 如果重新產生  則再檢查一下
     IF l_exit_sw='Y' THEN
        EXIT WHILE
     ELSE
        #Begin:FUN-B60070
        #CALL l_zy.clear()
 #      # CALL lc_zy03.clear()     #MOD-580200
        #DECLARE p_zz_kc2 CURSOR FOR
        #   SELECT zw01 FROM zw_file ORDER BY zw01
        #LET li_i=1
        #FOREACH p_zz_kc2 INTO l_zy[li_i].zy01
        #   # 04/08/19 變更權限顯示方式
#       #   # MOD-580200取消顯示方式變更
        #   LET l_zy[li_i].zy03=g_zz.zz04
#       #   LET lc_zy03[li_i].zy03=g_zz.zz04
#       #   CALL s_act_desc_tab(g_zz.zz01,lc_zy03[li_i].zy03,l_zy[li_i].zy07,"1") RETURNING l_zy[li_i].zy03
        #   LET l_zy[li_i].zy04='0'
        #   LET l_zy[li_i].zy05='0'
#       #   LET l_zy[li_i].zy06=NULL    #FUN-5C0057
        #   LET l_zy[li_i].zy07='0'     #MOD-810166
        #   LET li_i=li_i+1
        #END FOREACH
        #CALL l_zy.deleteElement(li_i)
        #LET li_i=li_i-1

        #將p_zz_w畫面所選擇的zw01塞入l_zy陣列內.
        CALL l_zy.clear()
        LET li_i=1
        LET l_zw_stok = base.StringTokenizer.create(l_zw_list,",")
        WHILE l_zw_stok.hasMoreTokens()
           LET l_zy[li_i].zy01 = l_zw_Stok.nextToken()
           LET l_zy[li_i].zy03=g_zz.zz04
           LET l_zy[li_i].zy04='0'
           LET l_zy[li_i].zy05='0'
           LET l_zy[li_i].zy07='0'
           LET li_i=li_i+1
        END WHILE
        #End:FUN-B60070
     END IF
   END WHILE
 
   DELETE FROM zy_file WHERE zy02=g_zz.zz01
 
   FOR li_j=1 TO l_zy.getLength()
      LET m_zy.zy01=l_zy[li_j].zy01
      LET m_zy.zy02=g_zz.zz01
#     #MOD-580200
      LET m_zy.zy03=l_zy[li_j].zy03
#     LET m_zy.zy03=lc_zy03[li_j].zy03
      LET m_zy.zy04=l_zy[li_j].zy04
      LET m_zy.zy05=l_zy[li_j].zy05
#     LET m_zy.zy06=l_zy[li_j].zy06      #FUN-5C0057
     #LET m_zy.zy07=g_zz.zz32            #MOD-570093 mark
      LET m_zy.zy07=l_zy[li_j].zy07      #MOD-570093 add
      LET m_zy.zyuser=g_user
      LET m_zy.zygrup=g_grup
      LET m_zy.zydate=g_today
 
#     INSERT INTO zy_file VALUES (m_zy.*)    #FUN-5C0057
      INSERT INTO zy_file (zy01,zy02,zy03,zy04,zy05,zy07,zyuser,zygrup,zydate)
      VALUES (m_zy.zy01, g_zz.zz01, m_zy.zy03, m_zy.zy04, m_zy.zy05,
              m_zy.zy07, g_user,    g_grup,    g_today)
 
      LET g_msg='ins zy:',m_zy.zy01
 
      IF SQLCA.SQLCODE THEN                  #FUN-5C0057
#        CALL cl_err(g_msg,SQLCA.SQLCODE,1)   #No.FUN-660081
         CALL cl_err3("ins","zy_file",m_zy.zy01,g_zz.zz01,SQLCA.sqlcode,"","",1)   #No.FUN-660081
         LET g_success='N'
      END IF
   END FOR
 
   IF g_success='Y' THEN
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF
 
   CLOSE WINDOW p_zz_kw
 
END FUNCTION
 
#Begin:FUN-B60070
FUNCTION p_zz_w()
   DEFINE l_zw DYNAMIC ARRAY OF RECORD
               select LIKE type_file.chr1,
               zw01   LIKE zw_file.zw01,
               zw02   LIKE zw_file.zw02
               END RECORD
   DEFINE l_cnt SMALLINT,
          l_err STRING
   DEFINE l_rec_b SMALLINT,
          l_ac    SMALLINT,
          l_idx   SMALLINT,
          l_zw_sbuf base.StringBuffer,
          l_return  STRING

   OPEN WINDOW p_zz_w2 WITH FORM "azz/42f/p_zz_w" ATTRIBUTE(STYLE=g_win_style CLIPPED)

   CALL cl_ui_locale("p_zz_w")

   DECLARE zw_curs CURSOR FOR
      SELECT 'Y',zw01,zw02 FROM zw_file ORDER BY zw01

   LET l_cnt = 1
   FOREACH zw_curs INTO l_zw[l_cnt].*
      IF SQLCA.SQLCODE THEN
         LET l_err="foreach zw_file data error"
         CALL cl_err(l_err, SQLCA.SQLCODE, 1)
         EXIT FOREACH
      END IF
      IF l_cnt > g_max_rec THEN
         CALL cl_err("", 9035, 0)
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_zw.deleteElement(l_cnt)

   #改成INPUT
   LET l_rec_b = l_zw.getLength()
   LET l_ac = 0
   LET l_zw_sbuf = base.StringBuffer.create()

   INPUT ARRAY l_zw WITHOUT DEFAULTS FROM s_zw.*
      ATTRIBUTE(COUNT=l_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)
      BEFORE INPUT
         IF l_rec_b != 0 THEN
            CALL FGL_SET_ARR_CURR(l_ac)
         END IF

      BEFORE ROW
         LET l_ac = ARR_CURR()

      AFTER INPUT
         IF NOT INT_FLAG THEN
            CALL l_zw_sbuf.clear()

            FOR l_idx=1 TO l_rec_b
               IF l_zw[l_idx].select = "Y" THEN
                  CALL l_zw_sbuf.append(l_zw[l_idx].zw01||",")
               END IF
            END FOR
         END IF

         LET INT_FLAG = FALSE

      ON ACTION select_all
         FOR l_idx=1 TO l_rec_b
             LET l_zw[l_idx].select = "Y"
         END FOR

      ON ACTION cancel_all
         FOR l_idx=1 TO l_rec_b
             LET l_zw[l_idx].select = "N"
         END FOR

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
   END INPUT

   IF l_zw_sbuf.getLength()>0 THEN
      LET l_return = l_zw_sbuf.toString()
      LET l_return = l_return.subString(1, l_return.getLength()-1) #要將最後一個逗號刪除
   END IF

   CLOSE WINDOW p_zz_w2

   RETURN l_return
END FUNCTION
#End:FUN-B60070

# 2004/06/16 更新本支程式在本使用者所屬群組下的單支權限記錄
FUNCTION p_zz_gen()
 
DEFINE l_menu LIKE zm_file.zm01 #程式代號
 
    IF cl_null(g_zz.zz01) THEN
       CALL cl_err('',-400,1)
       RETURN
    END IF
 
    INSERT INTO zy_file(zy01,zy02,zy03,zy04,zy05,zy06,zy07,
                        zyuser,zygrup,zymodu,zydate)
                 VALUES(g_clas,g_zz.zz01,g_zz.zz04,'0','0', #g_zz.zz18,g_zz.zz19,
                        #'',g_zz.zz32,g_user,g_grup,'',g_today)     #MOD-B80235 mark
                        '','0',g_user,g_grup,'',g_today)            #MOD-B80235 add
 
    CASE SQLCA.sqlcode
       WHEN 0
          MESSAGE SQLCA.SQLERRD[3],' Row of ',g_clas,'-',g_zz.zz01,'Insert'
     ##TQC-790092 begin
       OTHERWISE
         IF cl_sql_dup_value(SQLCA.SQLCODE) THEN 
            UPDATE zy_file
               SET zy03=g_zz.zz04,
                   #zy07=g_zz.zz32,   #MOD-B80235 mark
                   zy06=NULL,
                   zydate=g_today
             WHERE zy01=g_clas AND zy02=g_zz.zz01
             MESSAGE SQLCA.SQLERRD[3], ' Row(s) of ',g_clas,'-',g_zz.zz01,
                    ' Update','-->',SQLCA.SQLCODE
         ELSE
            MESSAGE ' Insert or update ',g_zz.zz01,'failure','-->',SQLCA.SQLCODE
         END IF
       #WHEN -239
       #   UPDATE zy_file
       #      SET zy03=g_zz.zz04,
 #     #           zy04=g_zz.zz18,   #MOD-4B0183
 #     #           zy05=g_zz.zz19,   #MOD-4B0183
       #          zy07=g_zz.zz32,
       #          zy06=NULL,
       #          zydate=g_today
       #    WHERE zy01=g_clas AND zy02=g_zz.zz01
       #    MESSAGE SQLCA.SQLERRD[3], ' Row(s) of ',g_clas,'-',g_zz.zz01,
       #           ' Update','-->',SQLCA.SQLCODE
       #OTHERWISE
       #   MESSAGE ' Insert or update ',g_zz.zz01,'failure','-->',SQLCA.SQLCODE
     ##TQC-790092 end
   END CASE
 
END FUNCTION
 
# 2004/06/16 更新此次 QBE 出來的範圍下的全部屬於該使用者所屬群組現行的權限
FUNCTION p_zz_genall()
 
    DEFINE l_menu    LIKE zm_file.zm01 #程式代號
 
    IF cl_null(g_zz.zz01) THEN
       CALL cl_err('',"azz-046",1)
       RETURN
    END IF
 
    LET g_sql = "SELECT zz01,zz011,'',  zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10, ",
 #                     " zz11,zz12,    #MOD-4B0066
                      " zz13,zz14,zz15, ",
                      " zz16,zz17, ",
 #                     " zz18,zz19, ", #MOD-4B0183
                      " zz21,zz22, ",
 #                     " zz23,zz24, ", #MOD-4B0066
                      " zz25,zz26,zz27,zz28,zz29,zz30,zz31, ",
                      " zz32,zzuser,zzgrup,zzmodu,zzdate ",
                 " FROM zz_file ",
                " WHERE ",g_wc CLIPPED, " ORDER BY zz01"
 
    PREPARE p_zz_prepare1 FROM g_sql
    DECLARE p_zz_curs1 CURSOR WITH HOLD FOR p_zz_prepare1
 
    FOREACH p_zz_curs1 INTO g_zz1.*
       IF g_zz1.zz01 IS NULL THEN
           RETURN
       END IF
 
        INSERT INTO zy_file(zy01,zy02,zy03,          #zy04,zy05, MOD-4B0183
                           zy06,zy07,
                           zyuser,zygrup,zymodu,zydate)
                    VALUES(g_clas,                   # zy01
                           g_zz1.zz01,               # zy02
                           g_zz1.zz04,               # zy03  MOD-4B0183
#                          g_zz1.zz18,               # zy04  MOD-4B0183
#                          g_zz1.zz19,               # zy05
                           '',                       # zy06
                           #g_zz1.zz32,              # zy07  #MOD-B80235 mark
                           '0',                      # zy07  #MOD-B80235 add 
                           g_user,g_grup,'',g_today) # user,grup,modu,date
 
       CASE SQLCA.sqlcode
            WHEN 0
              MESSAGE SQLCA.SQLERRD[3],' Row of ',g_clas,'-',g_zz.zz01,'Insert'
         #TQC-790092 begin
            OTHERWISE
              IF cl_sql_dup_value(SQLCA.SQLCODE) THEN 
                 UPDATE zy_file
                    SET zy03=g_zz1.zz04,
                        zy06=NULL,
                        #zy07=g_zz1.zz32,     #MOD-B80235 mark
                        zydate=g_today
                  WHERE zy01=g_clas
                    AND zy02=g_zz1.zz01
                 MESSAGE SQLCA.SQLERRD[3], ' Row(s) of ',g_clas,'-',g_zz1.zz01,
                   ' Update','-->',SQLCA.SQLCODE
              ELSE
                MESSAGE ' Insert or update ',g_zz1.zz01,'failure','-->',SQLCA.SQLCODE
              END IF
           # WHEN -239
           #   UPDATE zy_file
           #      SET zy03=g_zz1.zz04,
#          #          zy04=g_zz1.zz18,  MOD-4B0183
#          #          zy05=g_zz1.zz19,  MOD-4B0183
           #          zy06=NULL,
           #          zy07=g_zz1.zz32,
           #          zydate=g_today
           #    WHERE zy01=g_clas
           #      AND zy02=g_zz1.zz01
           #   MESSAGE SQLCA.SQLERRD[3], ' Row(s) of ',g_clas,'-',g_zz1.zz01,
           #     ' Update','-->',SQLCA.SQLCODE
           # OTHERWISE
           #   MESSAGE ' Insert or update ',g_zz1.zz01,'failure','-->',SQLCA.SQLCODE
         #TQC-790092 end
       END CASE
    END FOREACH
END FUNCTION
 
FUNCTION p_zz_copy()
 
    DEFINE l_n             LIKE type_file.num5   #No.FUN-680135 SMALLINT
    DEFINE l_zz08          LIKE zz_file.zz08 
    DEFINE l_newno         LIKE zz_file.zz01
    DEFINE l_oldno         LIKE zz_file.zz01     #No.FUN-540035
    DEFINE li_smb03        LIKE type_file.num5   #MOD-810259
    DEFINE lc_smb03        LIKE smb_file.smb03   #MOD-810259
 
    IF g_zz.zz01 IS NULL THEN
       CALL cl_err('',-400,0)
       RETURN
    ELSE
       #No.FUN-540035 --start--
       LET l_oldno = g_zz.zz01
    END IF
 
    #-----MOD-7B0168---------
    LET g_before_input_done = FALSE
    CALL p_zz_set_entry('a')
    LET g_before_input_done = TRUE
    #-----END MOD-7B0168-----
 
    CALL cl_getmsg('copy',g_lang) RETURNING g_msg
    LET INT_FLAG = 0  ######add for prompt bug
 
#   PROMPT g_msg CLIPPED,': ' FOR l_newno
    INPUT l_newno WITHOUT DEFAULTS FROM zz01
 
       AFTER FIELD zz01   #MOD-530797
         SELECT COUNT(*) INTO l_n FROM zz_file WHERE zz01=l_newno
         IF l_n > 0 THEN
            CALL cl_err(l_newno,-239,0)
            NEXT FIELD zz01
         END IF
         #MOD-810259
         CALL p_zz_zz01_industry() RETURNING li_smb03,lc_smb03
         IF li_smb03 THEN
            CALL cl_err_msg(NULL,"azz-279",g_zz.zz01||"|"||lc_smb03,30)
         END IF
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
       ON ACTION about         #MOD-4C0121
          CALL cl_about()      #MOD-4C0121
 
       ON ACTION help          #MOD-4C0121
          CALL cl_show_help()  #MOD-4C0121
 
       ON ACTION controlg      #MOD-4C0121
          CALL cl_cmdask()     #MOD-4C0121
 
    END INPUT
 
    IF INT_FLAG OR cl_null(l_newno) THEN
       LET INT_FLAG = 0
       RETURN
    END IF
 
    DROP TABLE x
 
#   SELECT zz01,zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10,
#          zz11,zz12,  #MOD-4B0066
#          zz13,zz14,zz15,zz16,zz17,zz18,zz19,zz21,zz22,
#          zz23,zz24,  #MOD-4B0066
#          zz25,zz26,zz27,zz28,zz29,zz30,zz31,
#          zz011,zz32,zzuser,zzgrup,zzmodu,zzdate
    SELECT *
      FROM zz_file WHERE zz01=g_zz.zz01 INTO TEMP x
 
    IF cl_get_os_type() <> "WINDOWS" THEN    #for all kinds of UNIX #MOD-830017
       LET l_zz08="$FGLRUN $",UPSHIFT(g_zz.zz011) CLIPPED,"i/",l_newno
    ELSE                                     #for all versions of WINDOWS
       LET l_zz08="%FGLRUN% %",UPSHIFT(g_zz.zz011) CLIPPED,"i%/",l_newno
    END IF
 
    UPDATE x SET zz01 = l_newno,    #資料鍵值
                 zz08 = l_zz08,     #資料建立日期
                 zz09 = g_today,    #資料建立日期
                 zzuser = g_user,   #資料所有者
                 zzgrup = g_grup,   #資料所有者所屬群
                 zzmodu = g_user,   #資料修改日期
                 zzdate = g_today   #資料建立日期
 
    INSERT INTO zz_file SELECT *
#   INSERT INTO zz_file SELECT zz01,'','','',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10,
#                              zz11,zz12,   #MOD-4B0066
#                              zz13,zz14,zz15,zz16,zz17,zz18,zz19,zz21,zz22,
#                              zz23,zz24,   #MOD-4B0066
#                              zz25,zz26,zz27,
#                              zzuser,zzgrup,zzmodu,zzdate,zz28,zz29,zz30,zz31,zz011,zz32
                        FROM x
    IF SQLCA.sqlcode THEN
#      CALL cl_err(g_zz.zz01,SQLCA.sqlcode,0)   #No.FUN-660081
       CALL cl_err3("ins","zz_file",l_newno,"",SQLCA.sqlcode,"","",0)   #No.FUN-660081
    ELSE
       DROP TABLE y    #MOD-830017
       SELECT * FROM gaz_file WHERE gaz01=l_oldno INTO TEMP y
       UPDATE y SET gaz01 = l_newno,
                    gazuser = g_user,   #資料所有者
                    gazgrup = g_grup,   #資料所有者所屬群
                    gazmodu = g_user,   #資料修改日期
                    gazdate = g_today   #資料建立日期
       INSERT INTO gaz_file SELECT * FROM y
 
       MESSAGE 'ROW(',l_newno,') O.K'
        CALL p_zz_get_transname() # 2004/09/29 MOD-490276
 
       # MOD-4A0024
       IF cl_confirm("azz-058") THEN   #是否複製 zz_name link 及相關文件資料?
          CALL p_zz_copy_link(l_newno)
       END IF
    END IF
 
    #No.FUN-540035 --start--
    SELECT zz01 INTO g_zz.zz01 FROM zz_file WHERE zz01 = l_newno
    CALL p_zz_u()
    #FUN-C30027---begin
    #SELECT zz01,zz011,'',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10,
    #       zz13,zz14,zz15,zz16,zz17,zz21,zz22,zz25,zz26,zz27,zz28,zz29,
    #       zz30,zz31,zz32,zzuser,zzgrup,zzmodu,zzdate
    #  INTO g_zz.*
    #  FROM zz_file
    # WHERE zz01 = l_oldno
    #FUN-C30027---end
    CALL p_zz_update_zz03()   #MOD-830017
    CALL p_zz_show()
    #No.FUN-540035 ---end---
END FUNCTION
 
 # MOD-4A0024 複製 gaz_file, gak_file, gal_file
FUNCTION p_zz_copy_link(l_newzz01)
 
   DEFINE l_newzz01     LIKE zz_file.zz01
   DEFINE l_notfound    LIKE type_file.num5    #No.FUN-680135 SMALLINT
 
   # Update gaz_file
   DELETE FROM gaz_file WHERE gaz01=l_newzz01
   DROP TABLE x
   SELECT * FROM gaz_file WHERE gaz01=g_zz.zz01 INTO TEMP x     #No.FUN-540035
   IF SQLCA.sqlcode = 100 THEN
      LET l_notfound = TRUE
   END IF
   IF NOT l_notfound THEN
      UPDATE x SET gaz01  = l_newzz01,
                   gazuser= g_user,
                   gazgrup= g_grup,
                   gazmodu= NULL,
                   gazdate= g_today
      INSERT INTO gaz_file SELECT * FROM x
 
      IF SQLCA.SQLCODE THEN
#        CALL cl_err("Reproduce gaz_file",SQLCA.SQLCODE,1)   #No.FUN-660081
         CALL cl_err3("ins","gaz_file",l_newzz01,"",SQLCA.sqlcode,"","Reproduce gaz_file",1)   #No.FUN-660081
         RETURN
      END IF
   END IF
 
   # Update gak_file
   DELETE FROM gak_file WHERE gak01=l_newzz01
   DROP TABLE x
   SELECT * FROM gak_file WHERE gak01=g_zz.zz01 INTO TEMP x     #No.FUN-540035
   IF SQLCA.sqlcode = 100 THEN
      LET l_notfound = TRUE
   END IF
   IF NOT l_notfound THEN
      UPDATE x SET gak01  = l_newzz01,
                   gakuser= g_user,                             #No.FUN-540035
                   gakgrup= g_grup,
                   gakmodu= NULL,
                   gakdate= g_today
      INSERT INTO gak_file SELECT * FROM x
 
      IF SQLCA.SQLCODE THEN
#        CALL cl_err("Reproduce gak_file",SQLCA.SQLCODE,1)   #No.FUN-660081
         CALL cl_err3("ins","gak_file",l_newzz01,"",SQLCA.sqlcode,"","Reproduce gak_file",1)   #No.FUN-660081
         RETURN
      END IF
   END IF
 
   # Update gal_file
   DELETE FROM gal_file WHERE gal01=l_newzz01
   DROP TABLE x
   SELECT * FROM gal_file WHERE gal01=g_zz.zz01 INTO TEMP x     #No.FUN-540035
   IF SQLCA.sqlcode = 100 THEN
      LET l_notfound = TRUE
   END IF
   IF NOT l_notfound THEN
      UPDATE x SET gal01  = l_newzz01
      INSERT INTO gal_file SELECT * FROM x
 
      IF SQLCA.SQLCODE THEN
#        CALL cl_err("Reproduce gal_file",SQLCA.SQLCODE,1)   #No.FUN-660081
         CALL cl_err3("ins","gal_file",l_newzz01,"",SQLCA.sqlcode,"","Reproduce gal_file",1)   #No.FUN-660081
         RETURN
      END IF
   END IF
#  CALL cl_err_msg(NULL, "azz-064", l_newzz01, 10)      #No.FUN-540035
   RETURN
END FUNCTION
 
#MOD-450030
FUNCTION p_zz_readlog()
   DEFINE   l_cmd        STRING
   DEFINE   lc_channel   base.Channel
   DEFINE   ls_result    STRING
   DEFINE   lr_log       DYNAMIC ARRAY OF RECORD
               log_name  STRING,
               log_date  STRING,
               log_user  STRING
                         END RECORD
   DEFINE   li_cnt       LIKE type_file.num10   #No.FUN-680135 INTEGER
   DEFINE   li_inx_s     LIKE type_file.num10,  #No.FUN-680135 INTEGER
            li_inx_e     LIKE type_file.num10   #No.FUN-680135 INTEGER
   DEFINE   ls_prog      STRING
   DEFINE   ls_top_path  STRING
 
 
   IF g_zz.zz01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   CALL lr_log.clear()
   LET ls_top_path = FGL_GETENV("TOP")
   LET lc_channel = base.Channel.create()
   LET l_cmd = "ls ",ls_top_path,"/log"     # log 不會放在 $CUST
   CALL lc_channel.openPipe(l_cmd,"r")
   LET li_cnt = 1
   WHILE (lc_channel.read(ls_result))
      LET lr_log[li_cnt].log_name = ls_result
 
      LET li_inx_e = lr_log[li_cnt].log_name.getIndexOf("_",1)
      LET lr_log[li_cnt].log_date = lr_log[li_cnt].log_name.subString(1,li_inx_e - 1)
 
      LET li_inx_s = li_inx_e + 1
      LET li_inx_e = lr_log[li_cnt].log_name.getIndexOf("_",li_inx_s)
      LET lr_log[li_cnt].log_user = lr_log[li_cnt].log_name.subString(li_inx_s,li_inx_e - 1)
 
      LET li_inx_s = li_inx_e + 1
      LET li_inx_e = lr_log[li_cnt].log_name.getIndexOf(".",li_inx_s)
      LET ls_prog = lr_log[li_cnt].log_name.subString(li_inx_s,li_inx_e - 1)
 
      IF ls_prog.equals(g_zz.zz01 CLIPPED) THEN
         LET li_cnt = li_cnt + 1
      ELSE
         CALL lr_log.deleteElement(li_cnt)
      END IF
   END WHILE
   CALL lc_channel.close()
   LET li_cnt = li_cnt - 1
   DISPLAY li_cnt TO FORMONLY.cnt
 
   IF lr_log.getLength() = 0 THEN
      CALL cl_err("","azz-703",1)
      RETURN
   END IF
 
   OPEN WINDOW readlog_w WITH FORM "azz/42f/p_zz_readlog"
   CALL cl_ui_locale("p_zz_readlog")
 
   DISPLAY g_zz.zz01 TO FORMONLY.exe_prog
 
   CALL cl_set_act_visible("accept,cancel",FALSE)
   DISPLAY ARRAY lr_log TO s_log.* ATTRIBUTE(UNBUFFERED)
 
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("grid01","AUTO")           #No.FUN-6A0092
 
      ON ACTION accept
         CALL p_zz_readlog_view(lr_log[ARR_CURR()].log_name)
 
      ON ACTION view_content
         CALL p_zz_readlog_view(lr_log[ARR_CURR()].log_name)
 
      ON ACTION log_delete
         LET l_cmd = "rm ",ls_top_path,"/log/",lr_log[ARR_CURR()].log_name
         RUN l_cmd
         CALL lr_log.deleteElement(ARR_CURR())
         LET li_cnt = li_cnt - 1
         DISPLAY li_cnt TO FORMONLY.cnt
 
      ON ACTION exit
         EXIT DISPLAY
 
      ON ACTION about         #FUN-860033
         CALL cl_about()      #FUN-860033
 
      ON ACTION controlg      #FUN-860033
         CALL cl_cmdask()     #FUN-860033
 
      ON ACTION help          #FUN-860033
         CALL cl_show_help()  #FUN-860033
 
      ON IDLE g_idle_seconds  #FUN-860033
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel",TRUE)
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
   CLOSE WINDOW readlog_w
END FUNCTION
 
FUNCTION p_zz_readlog_view(ls_log_name)
   DEFINE   ls_log_name   STRING
   DEFINE   ls_msg        STRING
   DEFINE   l_cmd         STRING
   DEFINE   ls_top        STRING
   DEFINE   lc_channel    base.Channel
   DEFINE   ls_result     STRING
 
 
   OPEN WINDOW readlog_view_w WITH FORM "azz/42f/p_zz_readlog_view"
      ATTRIBUTE(STYLE="dialog")
 
   LET lc_channel = base.Channel.create()
    # No: MOD-540077 --start--
   LET ls_top = FGL_GETENV("TOP")
   LET l_cmd = ls_top,"/log/",ls_log_name
    # No: MOD-540077 ---end---
   CALL lc_channel.openFile(l_cmd,"r")
   WHILE (lc_channel.read(ls_result))
      LET ls_msg = ls_msg,ls_result,'\n'
   END WHILE
   CALL lc_channel.close()
 
   MENU ls_log_name
      BEFORE MENU
         DISPLAY ls_msg TO FORMONLY.content
      ON ACTION ok
         EXIT MENU
      ON ACTION about         #FUN-860033
         CALL cl_about()      #FUN-860033
 
      ON ACTION controlg      #FUN-860033
         CALL cl_cmdask()     #FUN-860033
 
      ON ACTION help          #FUN-860033
         CALL cl_show_help()  #FUN-860033
 
      ON IDLE g_idle_seconds  #FUN-860033
          CALL cl_on_idle()
          CONTINUE MENU
   END MENU
 
   CLOSE WINDOW readlog_view_w
END FUNCTION
 
FUNCTION p_zz_out()
 
    DEFINE l_i             LIKE type_file.num5,    #No.FUN-680135 SMALLINT
           l_name          LIKE type_file.chr20,   # External(Disk) file name  #No.FUN-680135 VARCHAR(20)
           l_za05          LIKE za_file.za05,      #No.FUN-680135 VARCHAR(40)
           l_chr           LIKE type_file.chr1     #No.FUN-680135 VARCHAR(1)
 
    IF g_wc IS NULL THEN
       CALL cl_err('','9057',0)
       RETURN
    END IF
    CALL cl_wait()
     # LET l_name = 'p_zz.out'    #No.MOD-540196
       CALL cl_outnam('p_zz') RETURNING l_name    #No.MOD-540196
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
 
 #-------------------------No.MOD-540196--------------------
{
    DECLARE p_zz_za_cur CURSOR FOR
            SELECT za02,za05 FROM za_file
             WHERE za01 = "p_zz" AND za03 = g_lang
    FOREACH p_zz_za_cur INTO g_i,l_za05
       LET g_x[g_i] = l_za05
    END FOREACH
}
 #-------------------------No.MOD-540196 END--------------------
 
    SELECT zz17 INTO g_len FROM zz_file WHERE zz01 = 'p_zz'
    IF g_len = 0 OR g_len IS NULL THEN LET g_len = 80 END IF
   #  FOR g_i = 1 TO g_len LET g_dash[g_i,g_i] = '=' END FOR   #No.MOD-540196
    display g_wc
 
 # MOD-490440
    LET g_sql="SELECT zz01,zz011,' ',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10, ",
 #                   " zz11,zz12,    #MOD-4B0066
                    " zz13,zz14,zz15, ",
                    " zz16,zz17, ",
 #                   " zz18,zz19, ", #MOD-4B0183
                    " zz21,zz22, ",
 #                   " zz23,zz24, ", #MOD-4B0066
                    " zz25,zz26,zz27,zz28,zz29,zz30,zz31, ",
                    " zz32,zzuser,zzgrup,zzmodu,zzdate ",
               " FROM zz_file",          # 組合出 SQL 指令
              " WHERE ",g_wc CLIPPED
 
 # END MOD-490440
 
    PREPARE p_zz_p1 FROM g_sql                # RUNTIME 編譯
    DECLARE p_zz_curo CURSOR FOR p_zz_p1
 
    START REPORT p_zz_rep TO l_name
    LET g_pageno=0
 
    FOREACH p_zz_curo INTO g_zz.*
        IF SQLCA.sqlcode THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
 
        CALL p_zz_update_zz03()
        OUTPUT TO REPORT p_zz_rep(g_zz.*)
    END FOREACH
 
    FINISH REPORT p_zz_rep
    CLOSE p_zz_curo
    ERROR ""
    CALL cl_prt(l_name,' ','1',g_len)
END FUNCTION
 
REPORT p_zz_rep(sr)
 
   DEFINE l_trailer_sw    LIKE type_file.chr1,   #No.FUN-680135 VARCHAR(1)
          sr              RECORD
            zz01          LIKE zz_file.zz01,
            zz011         LIKE zz_file.zz011,
            gaz03         LIKE gaz_file.gaz03,
            zz03          LIKE zz_file.zz03,
            zz04          LIKE zz_file.zz04,
            zz05          LIKE zz_file.zz05,
            zz06          LIKE zz_file.zz06,
            zz07          LIKE zz_file.zz07,
            zz08          LIKE zz_file.zz08,
            zz09          LIKE zz_file.zz09,
            zz10          LIKE zz_file.zz10,
#           zz11          LIKE zz_file.zz11,
#           zz12          LIKE zz_file.zz12,
            zz13          LIKE zz_file.zz13,
            zz14          LIKE zz_file.zz14,
            zz15          LIKE zz_file.zz15,
            zz16          LIKE zz_file.zz16,
            zz17          LIKE zz_file.zz17,
#           zz18          LIKE zz_file.zz18,
#           zz19          LIKE zz_file.zz19,
            zz21          LIKE zz_file.zz21,
            zz22          LIKE zz_file.zz22,
#           zz23          LIKE zz_file.zz23,
#           zz24          LIKE zz_file.zz24,
            zz25          LIKE zz_file.zz25,
            zz26          LIKE zz_file.zz26,
            zz27          LIKE zz_file.zz27,
            zz28          LIKE zz_file.zz28,
            zz29          LIKE zz_file.zz29,
            zz30          LIKE zz_file.zz30,
            zz31          LIKE zz_file.zz31,
            zz32          LIKE zz_file.zz32,
            zzuser        LIKE zz_file.zzuser,
            zzgrup        LIKE zz_file.zzgrup,
            zzmodu        LIKE zz_file.zzmodu,
            zzdate        LIKE zz_file.zzdate,
            zzoriu       LIKE zz_file.zzoriu,      #No.FUN-980030 10/01/04
            zzorig       LIKE zz_file.zzorig      #No.FUN-980030 10/01/04
                     END RECORD,
          n               LIKE type_file.num5,   #No.FUN-680135 SMALLINT
          l_chr           LIKE type_file.chr1    #No.FUN-680135 VARCHAR(1)
 
   OUTPUT
       TOP MARGIN g_top_margin
       LEFT MARGIN g_left_margin
       BOTTOM MARGIN g_bottom_margin
       PAGE LENGTH g_page_line
 
    ORDER BY sr.zz01
 
    FORMAT
        PAGE HEADER
           PRINT ' 2.2 ',g_x[1]
           PRINT '┌─────┬──────────────────┬──────────┬──┐'
           PRINT g_x[13],g_x[14]
          #PRINT '│ 程式編號 │ 程  式  名  稱                     │ 基  本  權  限     │寬度│'
           LET l_trailer_sw = 'y'
 
        ON EVERY ROW
           PRINT '├─────┼──────────────────┼──────────┼──┤'
           PRINT COLUMN 1,'│',sr.zz01 CLIPPED,
                 COLUMN 13,'│',sr.gaz03 CLIPPED,
                 COLUMN 51,'│',sr.zz04[1,20] CLIPPED,
                 COLUMN 73,'│',sr.zz17 USING '###' CLIPPED,
                 COLUMN 79,'│'
 
        ON LAST ROW
           PRINT '├─────┼──────────────────┼──────────┼──┤'
           LET sr.zz01 = NULL LET sr.gaz03 = NULL
           LET sr.zz04 = NULL LET sr.zz17 = NULL
           LET n = LINENO
           WHILE n < 53
            PRINT COLUMN 1, '│',sr.zz01 CLIPPED,
                  COLUMN 13,'│',sr.gaz03 CLIPPED,
                  COLUMN 51,'│',sr.zz04[1,20] CLIPPED,
                  COLUMN 73,'│',sr.zz17 USING '###' CLIPPED,
                  COLUMN 79,'│'
            LET n = n + 1
           END WHILE
        PAGE TRAILER
           PRINT '└─────┴──────────────────┴──────────┴──┘'
           PRINT
           PRINT COLUMN 36,'2-2-',PAGENO USING '<<<<'
END REPORT
 
#REPORT p_zz_repx0(sr)
#    DEFINE
#        l_trailer_sw    VARCHAR(1),
#        sr              RECORD
#            zz01          LIKE zz_file.zz01,
#            zz011         LIKE zz_file.zz011,
#            gaz03         LIKE gaz_file.gaz03,
#            zz03          LIKE zz_file.zz03,
#            zz04          LIKE zz_file.zz04,
#            zz05          LIKE zz_file.zz05,
#            zz06          LIKE zz_file.zz06,
#            zz07          LIKE zz_file.zz07,
#            zz08          LIKE zz_file.zz08,
#            zz09          LIKE zz_file.zz09,
#            zz10          LIKE zz_file.zz10,
##           zz11          LIKE zz_file.zz11,
##           zz12          LIKE zz_file.zz12,
#            zz13          LIKE zz_file.zz13,
#            zz14          LIKE zz_file.zz14,
#            zz15          LIKE zz_file.zz15,
#            zz16          LIKE zz_file.zz16,
#            zz17          LIKE zz_file.zz17,
##           zz18          LIKE zz_file.zz18,
##           zz19          LIKE zz_file.zz19,
#            zz21          LIKE zz_file.zz21,
#            zz22          LIKE zz_file.zz22,
##           zz23          LIKE zz_file.zz23,
##           zz24          LIKE zz_file.zz24,
#            zz25          LIKE zz_file.zz25,
#            zz26          LIKE zz_file.zz26,
#            zz27          LIKE zz_file.zz27,
#            zz28          LIKE zz_file.zz28,
#            zz29          LIKE zz_file.zz29,
#            zz30          LIKE zz_file.zz30,
#            zz31          LIKE zz_file.zz31,
#            zz32          LIKE zz_file.zz32,
#            zzuser        LIKE zz_file.zzuser,
#            zzgrup        LIKE zz_file.zzgrup,
#            zzmodu        LIKE zz_file.zzmodu,
#            zzdate        LIKE zz_file.zzdate
#                     END RECORD,
#        n                SMALLINT,
#        l_chr            LIKE type_file.chr1    #No.FUN-680135 VARCHAR(1)
#
#   OUTPUT
#       TOP MARGIN g_top_margin
#       LEFT MARGIN g_left_margin
#       BOTTOM MARGIN g_bottom_margin
#       PAGE LENGTH g_page_line
#
#    ORDER BY sr.zz01
#
#    FORMAT
#        PAGE HEADER
#            PRINT ' 2.2 ',g_x[1]
#            PRINT '┌─────┬──────────────────┬──────────┬──┐'
#            PRINT g_x[13],g_x[14]
#           #PRINT '│ PROGRAM  │     DESCRIPTION                    │ BASIC PRIVILEDGES  │ WID│'
#            LET l_trailer_sw = 'y'
#
#        ON EVERY ROW
#            PRINT '├─────┼──────────────────┼──────────┼──┤'
#            PRINT COLUMN 1,'│',sr.zz01 CLIPPED,
#                  COLUMN 13,'│',sr.gaz03 CLIPPED,
#                  COLUMN 51,'│',sr.zz04[1,20] CLIPPED,
#                  COLUMN 73,'│',sr.zz17 USING '###' CLIPPED,
#                  COLUMN 79,'│'
#
#        ON LAST ROW
#            PRINT '├─────┼──────────────────┼──────────┼──┤'
#           LET sr.zz01 = NULL LET sr.gaz03 = NULL
#           LET sr.zz04 = NULL LET sr.zz17 = NULL
#           LET n = LINENO
#           WHILE n < 53
#            PRINT  COLUMN 1,'│',sr.zz01 CLIPPED,
#                   COLUMN 13,'│',sr.gaz03 CLIPPED,
#                   COLUMN 51,'│',sr.zz04[1,20] CLIPPED,
#                   COLUMN 73,'│',sr.zz17 USING '###' CLIPPED,
#                   COLUMN 79,' │'
#            LET n = n + 1
#           END WHILE
#        PAGE TRAILER
#           PRINT '└─────┴──────────────────┴──────────┴──┘'
#         # PRINT '+------------------------------------------------------------------------------+'
#           PRINT
#           PRINT COLUMN 36,'2-2-',PAGENO USING '<<<<'
#END REPORT
 
FUNCTION p_zz_out2()     #FUN-570276 p_print()
    DEFINE
        l_i             LIKE type_file.num5,    #No.FUN-680135 SMALLINT
        l_name          LIKE type_file.chr20,   # External(Disk) file name  #No.FUN-680135 VARCHAR(20)
        l_za05          LIKE za_file.za05,      #No.FUN-680135 VARCHAR(40)
        l_chr           LIKE type_file.chr1     #No.FUN-680135 VARCHAR(1)
 
    IF g_wc IS NULL THEN
        CALL cl_err('',-400,0)
        RETURN
    END IF
    CALL cl_wait()
 
#   LET l_name = 'p_zz2.out'                   #FUN-570276
    CALL cl_outnam('p_zz') RETURNING l_name    #FUN-570276
 
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    DECLARE p_zz_za_cur2 CURSOR FOR
            SELECT za02,za05 FROM za_file
             WHERE za01 = "p_zz" AND za03 = g_lang
    FOREACH p_zz_za_cur2 INTO g_i,l_za05
       LET g_x[g_i] = l_za05
    END FOREACH
    SELECT zz17 INTO g_len FROM zz_file WHERE zz01 = 'p_zz'
    IF g_len = 0 OR g_len IS NULL THEN LET g_len = 80 END IF
    FOR g_i = 1 TO g_len LET g_dash[g_i,g_i] = '=' END FOR
 ### MOD-490440 ###
    LET g_sql="SELECT zz01,zz011,' ',zz03,zz04,zz05,zz06,zz07,zz08,zz09,zz10, ",
 #                   " zz11,zz12,      #MOD-4B0066
                    " zz13,zz14,zz15, ",
                    " zz16,zz17, ",
 #                   " zz18,zz19, ",   #MOD-4B0183
                    " zz21,zz22, ",
 #                   " zz23,zz24, ",   #MOD-4B0066
                    " zz25,zz26,zz27,zz28,zz29,zz30,zz31, ",
                    " zz32,zzuser,zzgrup,zzmodu,zzdate ",
               " FROM zz_file",          # 組合出 SQL 指令
              " WHERE ",g_wc CLIPPED
 ### END MOD-490440 ###
   PREPARE p_zz_p2 FROM g_sql                # RUNTIME 編譯
    DECLARE p_zz_curo2                        # SCROLL CURSOR
         CURSOR FOR p_zz_p2
 
    START REPORT p_zz_rep2 TO l_name
 
    FOREACH p_zz_curo2 INTO g_zz.*
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
 
       CALL p_zz_update_zz03()
 
       OUTPUT TO REPORT p_zz_rep2(g_zz.*)
    END FOREACH
 
    FINISH REPORT p_zz_rep2
 
    CLOSE p_zz_curo2
    ERROR ""
    CALL cl_prt(l_name,' ','1',g_len)
END FUNCTION
 
REPORT p_zz_rep2(sr)
 
   DEFINE l_trailer_sw    LIKE type_file.chr1,   #No.FUN-680135 VARCHAR(1)
          sr              RECORD
            zz01          LIKE zz_file.zz01,
            zz011         LIKE zz_file.zz011,
            gaz03         LIKE gaz_file.gaz03,
            zz03          LIKE zz_file.zz03,
            zz04          LIKE zz_file.zz04,
            zz05          LIKE zz_file.zz05,
            zz06          LIKE zz_file.zz06,
            zz07          LIKE zz_file.zz07,
            zz08          LIKE zz_file.zz08,
            zz09          LIKE zz_file.zz09,
            zz10          LIKE zz_file.zz10,
#           zz11          LIKE zz_file.zz11,
#           zz12          LIKE zz_file.zz12,
            zz13          LIKE zz_file.zz13,
            zz14          LIKE zz_file.zz14,
            zz15          LIKE zz_file.zz15,
            zz16          LIKE zz_file.zz16,
            zz17          LIKE zz_file.zz17,
#           zz18          LIKE zz_file.zz18,
#           zz19          LIKE zz_file.zz19,
            zz21          LIKE zz_file.zz21,
            zz22          LIKE zz_file.zz22,
#           zz23          LIKE zz_file.zz23,
#           zz24          LIKE zz_file.zz24,
            zz25          LIKE zz_file.zz25,
            zz26          LIKE zz_file.zz26,
            zz27          LIKE zz_file.zz27,
            zz28          LIKE zz_file.zz28,
            zz29          LIKE zz_file.zz29,
            zz30          LIKE zz_file.zz30,
            zz31          LIKE zz_file.zz31,
            zz32          LIKE zz_file.zz32,
            zzuser        LIKE zz_file.zzuser,
            zzgrup        LIKE zz_file.zzgrup,
            zzmodu        LIKE zz_file.zzmodu,
            zzdate        LIKE zz_file.zzdate,
            zzoriu       LIKE zz_file.zzoriu,      #No.FUN-980030 10/01/04
            zzorig       LIKE zz_file.zzorig      #No.FUN-980030 10/01/04
                      END RECORD,
          n               LIKE type_file.num5,   #No.FUN-680135 SMALLINT
          l_last_sw       LIKE type_file.chr1,   #No.FUN-680135 VARCHAR(1)
          l_chr           LIKE type_file.chr1    #No.FUN-680135 VARCHAR(1)
 
   OUTPUT
       TOP MARGIN g_top_margin
       LEFT MARGIN g_left_margin
       BOTTOM MARGIN g_bottom_margin
       PAGE LENGTH g_page_line
 
    ORDER BY sr.zz01
 
    FORMAT
        PAGE HEADER
            PRINT (g_len-FGL_WIDTH(g_company CLIPPED))/2 SPACES,g_company CLIPPED
            PRINT ' '
            PRINT (g_len-FGL_WIDTH(g_x[1]))/2 SPACES,g_x[1]
            PRINT ' '
            PRINT g_x[2] CLIPPED,g_today,' ',TIME,
                COLUMN g_len-10,g_x[3] CLIPPED,PAGENO USING '<<<'
            PRINT g_dash[1,g_len]
 
##          PRINT g_x[13] CLIPPED,COLUMN 21,g_x[14] CLIPPED
             PRINT g_x[11] CLIPPED                                ##MOD-490440
            PRINT '---------- -----------------------------------'
            LET l_last_sw = 'n'
 
     ON EVERY ROW
            PRINT COLUMN 1,sr.zz01, COLUMN 12,sr.gaz03
 
     ON LAST ROW
           PRINT g_dash[1,g_len]
           LET l_last_sw = 'y'
           PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[7] CLIPPED
 
     PAGE TRAILER
           IF l_last_sw = 'n'
              THEN PRINT g_dash[1,g_len]
                   PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[6] CLIPPED
              ELSE SKIP 2 LINE
           END IF
END REPORT
 
 
 
FUNCTION p_zz_zz01_industry()    #MOD-810259
 
   DEFINE lc_smb03    LIKE smb_file.smb03
   DEFINE lc_zz01     LIKE zz_file.zz01
   DEFINE li_i        LIKE type_file.num5
   DEFINE ls_zz01     STRING
 
   LET ls_zz01=DOWNSHIFT(g_zz.zz01 CLIPPED)
   IF NOT ls_zz01.getIndexOf("_",1) THEN
      RETURN FALSE,''
   END IF
   WHILE TRUE
      LET li_i=ls_zz01.getIndexOf("_",1)
      IF NOT li_i THEN EXIT WHILE END IF
      LET ls_zz01=ls_zz01.subString(li_i+1,ls_zz01.getLength())
   END WHILE
   LET lc_zz01=ls_zz01.trim()
   SELECT COUNT(*) INTO li_i FROM smb_file WHERE smb01=lc_zz01
   IF NOT li_i THEN
      RETURN FALSE,''
   END IF
   SELECT smb03 INTO lc_smb03 FROM smb_file WHERE smb01=lc_zz01 AND smb02=g_lang
   RETURN TRUE,lc_smb03
 
END FUNCTION
 

