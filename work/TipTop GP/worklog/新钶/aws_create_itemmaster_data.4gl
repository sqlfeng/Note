# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#{
# Program name...: aws_create_itemmaster_data.4gl
# Descriptions...: 提供建立料件基本資料的服務
# Date & Author..: 2008/06/10 by kim
# Memo...........:
# Modify.........: 新建立 FUN-860036
# Modify.........: NO.CHI-870011 08/07/07 by kim  MDM整合 for GP5.1
# Modify.........: NO.FUN-890113 08/11/04 By kevin 當ima06 是空值不作處理
#
#}
# Modify.........: No.TQC-940184 09/04/30 By mike 跨庫的SQL語句一律使用s_dbstring()的寫法
# Modify.........: No.FUN-950007 09/05/06 By sabrina 跨主機資料拋轉，shell手工調整
# Modify.........: No.FUN-A70106 10/07/20 By Mandy (1)增加自動確認功能
#                  原aimi100.4gl的i100_confirm()被拆分成
#                  i100sub_chk()    ==>確認前的欄位檢核
#                  i100sub_y_upd()  ==>做欄位的異動或呼叫MES
#                  i100sub_carry()  ==>資料中心拋轉(ps:aws_create_itemmaster_data此Service不做資料中心拋轉)
# Modify.........: No.FUN-A70106 10/07/20 By Mandy (2) 改用動態方式取得對方拋給TIPTOP的值
#                  a:TEMP TABLE ima_tmp1 =>放對方給TIPTOP的值        :SELECT * INTO l_ima.* FROM ima_tmp1
#                  b.TEMP TABLE ima_tmp2 =>放程式中default ima_file值   
# Modify.........: No.TQC-A90047 10/09/17 (1)一次拋轉多筆資料時,僅第一筆有進TIPTOP,其餘資料未拋轉進來
#                                         (2)若有錯誤,錯誤訊息內加上錯誤的料件編號
#                                         (3)BEGIN WORK~COMMIT WORK 內含DROP指令影響Transation的正確性
# Modify.........: No.FUN-AB0009 10/11/02 CreateItemMasterData 由PLM拋轉資料過來做修正時,資料並未更新成功
# Modify.........: No.FUN-AB0038 10/11/15 (1)新增或修改料件時,要判斷分群碼是否存在ERP
#                                         (2)EXECUTE和DELETE 指令之後皆要有指令執行成功否的判斷,若不成功要ROLLBACK
# Modify.........: No.FUN-AB0109 10/11/26 By Mandy aws_create_itemmaster_data.4gl 要有資料中心拋轉的功能
# Modify.........: No.FUN-AC0026 10/12/13 By Mandy PLM-資料中心功能
# Modify.........: No.TQC-B10095 11/01/12 By Mandy 新增料號資料內含有單引號(ex:ima021)，造成TIPTOP在組sql的時候出錯
#----------------------------------------------------------------------------------------------
# Modify.........: No.FUN-A70106 11/06/28 By Mandy GP5.1追版至GP5.25==>以上zl單號為GP5.1更新歷程的zl單號
#------------------------------------------------------------------str------------------------
# 以下為GP5.25 原單號
# Modify.........: No.TQC-940183 09/04/30 By Carrier rowi定義規範化
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.091021     09/10/21 By lilingyu r.c2 fail
# Modify.........: No:FUN-A20044 10/03/19 by dxfwo  於 GP5.2 Single DB架構中，因img_file 透過view 會過濾Plant Code，因此會造 
#                                                 成 ima26* 角色混亂的狀況，因此对ima26的调整
#------------------------------------------------------------------end------------------------
# Modify.........: No.FUN-D10092 13/01/20 By Abby  PLM GP5.3追版 add str----------------------
# Modify.........: No.FUN-C20084 12/02/15 By Mandy 新增料件不成功,出現err:無法將 null 插入欄,因為ima_file alter table 新增欄位ima159,但限制為NOT NULL的,必需給default
# Modify.........: No.TQC-C50229 12/05/29 By Mandy (1)新增料件時,在檢核段,以分群碼預設值做檢核,並未用PLM拋過來的值做check
#                                                  (2)錯誤訊息顯示的加強
# Modify.........: No.FUN-C70008 12/07/02 By Mandy 程式執行效率優化
# Modify.........: No.FUN-C70008 12/07/13 By Mandy Schema有設定NOT NULL的欄位,若值為一個空白' ',在INSERT or UPDATE之前尚需給default
# Modify.........: No.FUN-C70009 12/07/05 By Lilan FOR PLM Beta(台基)客戶問題處理回收
# Modify.........: No.FUN-C90107 12/10/24 By Nina  (1)因為PLM整合時,Service "CreateItemMasterData"欲共用無效段,將i100_x()拆至aimi100_sub.4gl
#                                                  (2)新增料件不成功,出現err:無法將null插入欄,因為ima_file新增欄位ima926,ima160限制為NOT NULL,必須給default值
# Modify.........: No.FUN-D10092 13/01/20 By Abby  PLM GP5.3追版 add end----------------------
# Modify.........: No.FUN-D10122 13/01/28 By Nina  (1)修正只是update料號沒有要做失效也會跑到失效段的問題
#                                                  (2)新增料件不成功,出現err:無法將null插入欄,因為ima_file新增欄位ima934限制為NOT NULL,必須給default值
#
# Modify.........: No:FUN-D40103 13/05/09 By lixh1 增加儲位有效性檢查

# Modify.........: No:FUN-FB0001 15/11/02 By Jessica PLM：將原本多筆料號被LOCK後統一COMMIT機制，改為一筆LOCK後COMMIT再Lock下一筆

DATABASE ds

#FUN-860036

GLOBALS "../../config/top.global"
GLOBALS "../4gl/aws_ttsrv2_global.4gl"   #TIPTOP Service Gateway 使用的全域變數檔

GLOBALS
DEFINE
   g_ima       RECORD LIKE ima_file.*,
   g_ima_t     RECORD LIKE ima_file.*,
   g_ima_o     RECORD LIKE ima_file.*,
   g_sql       STRING 
DEFINE g_dbase             LIKE type_file.chr21
      #g_ima_rowid         LIKE type_file.chr18 #TQC-940184
      #g_ima_rowid         LIKE type_file.chr18 #TQC-940184  #091021 mark
#DEFINE g_dbstring          LIKE type_file.chr21  #TQC-940184
DEFINE g_db_type           LIKE type_file.chr21
DEFINE g_errary            DYNAMIC ARRAY OF RECORD
                              db     LIKE type_file.chr21, 
                              value  STRING,
                              field  LIKE ztb_file.ztb03,
                              fname  LIKE gae_file.gae04,
                              errno  LIKE ze_file.ze01,
                              ename  LIKE ze_file.ze03                              
                           END RECORD
DEFINE g_ans               LIKE type_file.chr1
DEFINE g_cnt               LIKE type_file.num10
DEFINE g_flag2             LIKE type_file.chr1
DEFINE g_forupd_sql        STRING
#FUN-A70106--add---str-- 
DEFINE g_get_xml           DYNAMIC ARRAY OF RECORD       #
                             field_name    STRING,
                             field_value   STRING
                           END RECORD
DEFINE g_field_count       LIKE type_file.num10
#FUN-A70106--add---end--
DEFINE g_do_data_carry     LIKE type_file.chr1 #FUN-C70008 是否需做資料中心拋轉
DEFINE g_original_str      STRING              #FUN-C70008 add #最原始的對方傳過來的ima的內容存放字串
DEFINE g_imaacti           LIKE ima_file.imaacti     #FUN-D10122 add

END GLOBALS

#[
# Description....: 提供建立料件基本資料的服務(入口 function)
# Date & Author..: 2007/06/10 by kim
# Parameter......: none
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_create_itemmaster_data()


    WHENEVER ERROR CONTINUE

    CALL aws_ttsrv_preprocess()    #呼叫服務前置處理程序

    #--------------------------------------------------------------------------#
    # 新增料件基本資料                                                         #
    #--------------------------------------------------------------------------#
    IF g_status.code = "0" THEN
       CALL aws_create_itemmaster_data_process()
    END IF

    CALL aws_ttsrv_postprocess()   #呼叫服務後置處理程序
END FUNCTION


#[
# Description....: 依據傳入資訊新增一筆 ERP 料件基本資料
# Date & Author..: 2007/06/10 by kim
# Parameter......: none
# Return.........: none
# Memo...........:
# Modify.........:
#
#]
FUNCTION aws_create_itemmaster_data_process()
    DEFINE l_i       LIKE type_file.num10
    DEFINE l_j       LIKE type_file.num10 #TQC-A90047 add
    DEFINE l_commit  LIKE type_file.chr1  #TQC-A90047 add
    DEFINE l_sql     STRING
    DEFINE l_cnt     LIKE type_file.num5 
    DEFINE l_cnt1    LIKE type_file.num10,
           l_cnt2    LIKE type_file.num10
    DEFINE l_wc      STRING
    DEFINE l_node    om.DomNode
    DEFINE l_node1   om.DomNode
    DEFINE l_ima     RECORD LIKE ima_file.*  
    DEFINE p_cmd     LIKE type_file.chr1
    DEFINE l_status  LIKE type_file.chr1     #FUN-A70106 add
    DEFINE l_imaacti LIKE ima_file.imaacti   #FUN-A70106 add
    DEFINE l_exe_confirm LIKE type_file.chr1 #FUN-A70106 add
    DEFINE l_list    om.NodeList             #FUN-A70106 add
    DEFINE l_name    STRING                  #FUN-A70106 add
    DEFINE l_value   STRING                  #FUN-A70106 add
    DEFINE l_str     STRING                  #FUN-A70106 add
    DEFINE l_msg     STRING                  #FUN-AC0026 add
    DEFINE l_description STRING              #TQC-C50229 add
    DEFINE l_gev04   LIKE gev_file.gev04     #FUN-C70008 add
    DEFINE l_gew03   LIKE gew_file.gew03     #FUN-C70008 add

    #--------------------------------------------------------------------------#
    # 處理呼叫方傳遞給 ERP 的料件基本資料                                      #
    #--------------------------------------------------------------------------#
    LET l_cnt1 = aws_ttsrv_getMasterRecordLength("ima_file")            #取得共有幾筆單檔資料 *** 原則上應該僅一次一筆！ ***
    IF l_cnt1 = 0 THEN
       LET g_status.code = "-1"
       LET g_status.description = "No recordset processed!"
       RETURN
    END IF

    #FUN-C70009---add---str---
    IF cl_null(l_cnt1) THEN
       LET g_status.code = "-1"
       LET g_status.description = "No recordset processed!(ima_file is null!)"
       RETURN
    END IF
    #FUN-C70009---add---str---

    LET g_forupd_sql = " SELECT * FROM ima_file ",
                      #" WHERE ROWID = ? FOR UPDATE NOWAIT " #091021 mark
                       " WHERE ima01=? FOR UPDATE "          #091021 add
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)           #091021 add
    DECLARE i100_cl CURSOR FROM g_forupd_sql

#TQC-940184   ---start
   #LET g_db_type=cl_db_get_database_type()
   #IF g_db_type="IFX" THEN
   #   LET g_dbstring=":"
   #ELSE
   #   LET g_dbstring="."
   #END IF
#TQC-940184   ---end

    SELECT * INTO g_sma.* FROM sma_file WHERE sma00='0'
    SELECT * INTO g_aza.* FROM aza_file WHERE aza01='0'
   #TQC-A90047 add----str---
   #移至BEGIN WORK~COMMIT WORK 之外
    DROP TABLE ima_tmp1 
    SELECT * FROM ima_file 
     WHERE 1=2 
      INTO TEMP ima_tmp1

    DROP TABLE ima_tmp2
    SELECT * FROM ima_file 
     WHERE 1=2 
      INTO TEMP ima_tmp2
   #TQC-A90047 add----end---
    #FUN-C70008 add----str---
     DROP TABLE ima_tmp_def
     SELECT * FROM ima_file 
      WHERE 1=2 
       INTO TEMP ima_tmp_def
     LET l_sql = "INSERT INTO ima_tmp_def(",
                 "ima01 ,ima26 ,ima261,ima262,ima915,",
                 "ima916,ima150,ima151,ima152,",
                 "ima910,ima926,ima022,ima156,ima158,ima927,ima120", #FUN-A70106 110628 add
                 ",ima159",                                                 #FUN-C20084 add ima159
                 ",ima928,ima160",                                          #FUN-C90107 add
                 ",ima934",                                                 #FUN-D10122 add ima934
                 ") VALUES (",
                 "'@TEST',0,0,0,'0',' ',' ',' ',' ',",
                 "' ','N','0',' ',' ','N',' ','3',' ','N','Y')" #FUN-A70106 110628 add #FUN-C20084 給ima159默認值'3' #FUN-C90107 add ima928, ima160預設值'','N'  #FUN-D10122 add ima934
     PREPARE ins_prep FROM l_sql
     EXECUTE ins_prep
     IF SQLCA.SQLCODE THEN
        LET g_status.code = SQLCA.SQLCODE
        LET g_status.sqlcode = SQLCA.SQLCODE
        RETURN
     END IF
     
     LET g_do_data_carry = 'N' 
     SELECT gev04 
       INTO l_gev04 
       FROM gev_file 
      WHERE gev01 = '1' 
        AND gev02 = g_plant
        AND gev03 = 'Y'
     
     IF NOT cl_null(l_gev04) THEN 
        SELECT UNIQUE gew03 
          INTO l_gew03 
          FROM gew_file
         WHERE gew01 = l_gev04 
           AND gew02 = '1'
        IF l_gew03 = '1' THEN #自動拋轉
            LET g_do_data_carry = 'Y'
        END IF
     END IF
     #FUN-C70008 add----end---
     
     IF g_do_data_carry = 'Y' THEN #FUN-C70008 add if 判斷
        #FUN-AC0026---add----str---
         #建立臨時表,用于存放拋轉的資料
         CALL s_dc_cre_temp_table("ima_file") RETURNING g_dc_tabname
         
         #建立歷史資料拋轉的臨時表
         CALL s_dc_cre_temp_table("gex_file") RETURNING g_dc_hist_tab
        #FUN-AC0026---add----str---
     END IF #FUN-C70008 add


   #BEGIN WORK  #FUN-FB0001 mark 

    FOR l_i = 1 TO l_cnt1
        BEGIN WORK                     #FUN-FB0001 add
        LET l_commit = 'N' #TQC-A90047
        INITIALIZE l_ima.* TO NULL
        INITIALIZE g_ima_t.* TO NULL
        INITIALIZE g_ima_o.* TO NULL        
        LET gi_err_code=NULL

        LET l_node = aws_ttsrv_getMasterRecord(l_i, "ima_file")         #目前處理單檔的 XML 節點
        LET l_status = aws_ttsrv_getParameter("status")                 #FUN-A70106 add
        LET l_ima.ima01 = aws_ttsrv_getRecordField(l_node, "ima01")     #取得此筆單檔資料的欄位值
        IF cl_null(l_ima.ima01) THEN
           LET g_status.code = "-286"                                   #主鍵的欄位值不可為 NULL
           EXIT FOR
        END IF
        #FUN-A70106 add---str---
        #取得此筆單檔資料的分群碼 
        LET l_ima.ima06 = aws_ttsrv_getRecordField(l_node, "ima06")     
        IF cl_null(l_ima.ima06) THEN
           #分群碼不能為空，請確認！
           LET g_status.code = "aws-334"
           EXIT FOR
        END IF
        #FUN-A70106 add---end---

        #FUN-A70106--add----str---
        #改用動態方式取得l_ima.*
       #TQC-A90047 mark---str---
       #移至BEGIN WORK~COMMIT WORK 之外
       #DROP TABLE ima_tmp1 
       #SELECT * FROM ima_file 
       # WHERE 1=2 
       #  INTO TEMP ima_tmp1
       #TQC-A90047 mark---end---
       #FUN-C70008 mark---str---
       #移至FOR 迴圈外,並改寫
       #LET l_sql = "INSERT INTO ima_tmp1(",
       #            "ima01 ,ima26 ,ima261,ima262,ima915,",
       #            "ima916,ima150,ima151,ima152,",
       #            "ima910,ima926,ima022,ima156,ima158,ima927,ima120", #FUN-A70106 110628 add
       #            ",ima159",                                                 #FUN-C20084 add ima159
       #            ") VALUES (",
       #            "'@TEST',0,0,0,'0',' ',' ',' ',' ',",
       #            "' ','N','0',' ',' ','N',' ','3' )" #FUN-A70106 110628 add #FUN-C20084 給ima159默認值'3' 
       #PREPARE ins_prep FROM l_sql
       #EXECUTE ins_prep
       ##FUN-AB0038--add----str---
       #IF SQLCA.SQLCODE THEN
       #   LET g_status.code = SQLCA.SQLCODE
       #   LET g_status.sqlcode = SQLCA.SQLCODE
       #   EXIT FOR
       #END IF
       ##FUN-AB0038--add----end---
       #FUN-C70008 mark---end---
       #FUN-C70008 add----str---
        DELETE FROM ima_tmp1 
        IF SQLCA.SQLCODE THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
           EXIT FOR
        END IF
        INSERT INTO ima_tmp1
        SELECT *
          FROM ima_tmp_def
         WHERE 1=1
        IF SQLCA.SQLCODE OR SQLCA.sqlerrd[3] = 0 THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
           EXIT FOR
        END IF
       #FUN-C70008 add----end---
        #--------------------------------------------------------------------------#
        # 取得 <Record> 節點中的 <Field>                                           #
        #--------------------------------------------------------------------------#
        LET l_list = l_node.selectByTagName("Field")
        LET l_str  = ""
        LET g_field_count = l_list.getLength()

       #TQC-A90047--------------mod----str---
       #此範圍內的變數l_i全改成l_j,因為和外圈的FOR l_i相衝
        FOR l_j = 1 TO l_list.getLength() #TQC-A90047 add
            LET l_node1 = l_list.item(l_j)
            LET l_name = l_node1.getAttribute("name")
            LET l_value = l_node1.getAttribute("value")
            LET l_value = cl_replace_str(l_value CLIPPED,"'","''") #TQC-B10095 add
            LET g_get_xml[l_j].field_name = l_name
            LET g_get_xml[l_j].field_value = l_value
           #FUN-D10122 add str-----------------
            IF g_get_xml[l_j].field_name = 'imaacti' THEN
               LET g_imaacti = g_get_xml[l_j].field_value
            END IF
           #FUN-D10122 add end-----------------
            IF l_j = l_list.getLength() THEN
       #TQC-A90047--------------mod----end---
                LET l_str = l_str CLIPPED,l_name CLIPPED," = ","'",l_value CLIPPED,"'"
            ELSE
                LET l_str = l_str CLIPPED,l_name CLIPPED," = ","'",l_value CLIPPED,"',"
            END IF
        END FOR
        LET g_original_str = l_str #FUN-C70008 add #最原始的對方傳過來的ima的內容存放字串
        LET l_sql = "UPDATE ima_tmp1 ",
                    "   SET ",l_str CLIPPED
        PREPARE upd_prep FROM l_sql
        EXECUTE upd_prep
        #FUN-AB0038--add----str---
        IF SQLCA.SQLCODE THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
           EXIT FOR
        END IF
        #FUN-AB0038--add----end---
        
        SELECT * INTO l_ima.* FROM ima_tmp1 
        DELETE FROM ima_tmp1 #TQC-A90047 add
        #FUN-AB0038--add----str---
        IF SQLCA.SQLCODE OR SQLCA.sqlerrd[3] = 0 THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
           EXIT FOR
        END IF
        #FUN-AB0038--add----end---

        #FUN-A70106--add----str---

       #FUN-A70106--add----str---
       ##MDM mapping表上可能傳入以下欄位
       #LET l_ima.ima02   = aws_ttsrv_getRecordField(l_node,"ima02")   #品名
       #LET l_ima.ima021  = aws_ttsrv_getRecordField(l_node,"ima021")  #規格
       #LET l_ima.ima04   = aws_ttsrv_getRecordField(l_node,"ima04")   #工程圖號
       #LET l_ima.ima06   = aws_ttsrv_getRecordField(l_node,"ima06")   #分群碼
       #LET l_ima.ima07   = aws_ttsrv_getRecordField(l_node,"ima07")   #ABC碼
       #LET l_ima.ima08   = aws_ttsrv_getRecordField(l_node,"ima08")   #來源碼
       #LET l_ima.ima15   = aws_ttsrv_getRecordField(l_node,"ima15")   #保稅與否
       #LET l_ima.ima16   = aws_ttsrv_getRecordField(l_node,"ima16")   #低階碼
       #LET l_ima.ima18   = aws_ttsrv_getRecordField(l_node,"ima18")   #單位重量
       #LET l_ima.ima24   = aws_ttsrv_getRecordField(l_node,"ima24")   #檢驗碼
       #LET l_ima.ima25   = aws_ttsrv_getRecordField(l_node,"ima25")   #庫存單位
       #LET l_ima.ima35   = aws_ttsrv_getRecordField(l_node,"ima35")   #主要倉庫別
       ##LET l_ima.ima37   = aws_ttsrv_getRecordField(l_node,"ima37")   #補貨策略碼 FUN-890113
       #LET l_ima.ima42   = aws_ttsrv_getRecordField(l_node,"ima42")   #批號追蹤方式
       #LET l_ima.ima43   = aws_ttsrv_getRecordField(l_node,"ima43")   #採購員
       #LET l_ima.ima45   = aws_ttsrv_getRecordField(l_node,"ima45")   #採購單位倍量
       #LET l_ima.ima46   = aws_ttsrv_getRecordField(l_node,"ima46")   #最少採購數量
       #LET l_ima.ima491  = aws_ttsrv_getRecordField(l_node,"ima491")  #入庫前置期
       #LET l_ima.ima54   = aws_ttsrv_getRecordField(l_node,"ima54")   #主要供應廠商
       #LET l_ima.ima56   = aws_ttsrv_getRecordField(l_node,"ima56")   #生產單位倍量
       #LET l_ima.ima571  = aws_ttsrv_getRecordField(l_node,"ima571")  #主製程料件
       #LET l_ima.ima59   = aws_ttsrv_getRecordField(l_node,"ima59")   #固定前置時間
       #LET l_ima.ima60   = aws_ttsrv_getRecordField(l_node,"ima60")   #變動前置時間
       #LET l_ima.ima64   = aws_ttsrv_getRecordField(l_node,"ima64")   #發料單位倍量
       #LET l_ima.ima67   = aws_ttsrv_getRecordField(l_node,"ima67")   #計畫員
       #LET l_ima.ima72   = aws_ttsrv_getRecordField(l_node,"ima72")   #成本單位的庫存數量
       #LET l_ima.ima94   = aws_ttsrv_getRecordField(l_node,"ima94")   #備料量
       #LET l_ima.ima100  = aws_ttsrv_getRecordField(l_node,"ima100")  #檢驗程度
       #LET l_ima.ima101  = aws_ttsrv_getRecordField(l_node,"ima101")  #檢驗水準
       #LET l_ima.ima102  = aws_ttsrv_getRecordField(l_node,"ima102")  #級數
       #LET l_ima.ima121  = aws_ttsrv_getRecordField(l_node,"ima121")  #單位材料成本
       #LET l_ima.ima122  = aws_ttsrv_getRecordField(l_node,"ima122")  #單位人工成本
       #LET l_ima.ima123  = aws_ttsrv_getRecordField(l_node,"ima123")  #單位製造費用
       #LET l_ima.ima124  = aws_ttsrv_getRecordField(l_node,"ima124")  #單位管銷成本
       #LET l_ima.ima907  = aws_ttsrv_getRecordField(l_node,"ima907")  #第二單位(母單位/參考單位)
       #LET l_ima.ima1019 = aws_ttsrv_getRecordField(l_node,"ima1019") #零只長度
       #LET l_ima.ima1020 = aws_ttsrv_getRecordField(l_node,"ima1020") #零只寬度
       #LET l_ima.ima1021 = aws_ttsrv_getRecordField(l_node,"ima1021") #零只高度
       #FUN-A70106--add----end---

        LET l_cnt=0
        SELECT COUNT(*) INTO l_cnt 
          FROM ima_file 
         WHERE ima01=l_ima.ima01
        IF l_cnt>0 THEN
           LET p_cmd='u'
        ELSE
           LET p_cmd='a'
        END IF
        CASE p_cmd
           WHEN "a"
              LET g_ima.*=l_ima.*
              INITIALIZE g_ima_t.* TO NULL
              INITIALIZE g_ima_o.* TO NULL
              LET g_ans=TRUE
              LET g_action_choice=NULL

           WHEN "u"
             #091021--mod---str---
             #SELECT ima_file.ROWID,ima_file.imaacti  
             #  INTO g_ima_rowid,l_imaacti 
              SELECT ima01,ima_file.imaacti 
                INTO g_ima.ima01,l_imaacti 
             #091021--mod---end---
                FROM ima_file 
               WHERE ima01=l_ima.ima01 #FUN-A70106 add imaacti
              IF SQLCA.sqlcode THEN
                 LET g_status.code = SQLCA.sqlcode
                 EXIT FOR
              END IF
              #FUN-A70106---add----str---
              IF l_imaacti = 'N' THEN 
                 LET g_status.code = 'mfg1000' #本資料為無效資料,不可更改
                 EXIT FOR
              END IF
              #FUN-A70106---add----end---
              #----------------------------------------------------------------------#
              # 修改前檢查                                                           #
              #----------------------------------------------------------------------#
              IF NOT i100_u_updchk() THEN
                 CALL aws_create_itemmaster_error()
                 EXIT FOR
              END IF

              LET g_ima_t.* = g_ima.*
              LET g_ima_o.* = g_ima.*
             #CALL aws_create_itemmaster_field_update(l_ima.*)     #FUN-A70106 mark
              CALL aws_create_itemmaster_field_update_new() #FUN-A70106 add
              #FUN-AB0038---add---str---
              IF g_status.code <> 0 THEN
                  EXIT FOR
              END IF
              #FUN-AB0038---add---end---
              LET g_ans=FALSE
              LET g_action_choice=NULL

           OTHERWISE
              LET g_status.code = 'aws-101'
              EXIT FOR
        END CASE


        #----------------------------------------------------------------------#
        # 指定g_ima Default                                                    #
        #----------------------------------------------------------------------#
        IF p_cmd='a' THEN
           CALL i100_default()     
        END IF
        
        #----------------------------------------------------------------------#
        # g_ima欄位檢查                                                        #
        #----------------------------------------------------------------------#
        IF NOT aws_create_itemmaster_field_check(p_cmd) THEN
           CALL aws_create_itemmaster_error()
           EXIT FOR
        END IF

        #----------------------------------------------------------------------#
        # 新增前檢查                                                           #
        #----------------------------------------------------------------------#
        IF p_cmd='a' THEN
           CALL i100_a_inschk()
           LET l_sql = i100_i_inpchk()
           IF NOT cl_null(l_sql) THEN
              CALL aws_create_itemmaster_error()
              EXIT FOR
           END IF
        END IF

        #避免傳入值在途中被改掉,需重新指定一次g_ima
       #CALL aws_create_itemmaster_field_update(l_ima.*)     #FUN-A70106 mark
        CALL aws_create_itemmaster_field_update_new()        #FUN-A70106 add
        #FUN-AB0038---add---str---
        IF g_status.code <> 0 THEN
            EXIT FOR
        END IF
        #FUN-AB0038---add---end---

        #------------------------------------------------------------------#
        # RECORD資料傳到NODE                                               #
        #------------------------------------------------------------------#
        CALL aws_ttsrv_setRecordField_record(l_node,base.Typeinfo.create(g_ima))

        IF cl_null(g_ima.ima09) THEN
           LET g_ima.ima09= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima09", " ")
        END IF
        IF cl_null(g_ima.ima10) THEN
           LET g_ima.ima10= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima10", " ")
        END IF
        IF cl_null(g_ima.ima11) THEN
           LET g_ima.ima11= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima11", " ")
        END IF
        IF cl_null(g_ima.ima12) THEN
           LET g_ima.ima12= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima12", " ")
        END IF

        IF cl_null(g_ima.ima23) THEN
           LET g_ima.ima23= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima23", " ")
        END IF
       #IF g_ima.ima35 IS NULL THEN  #FUN-C70008 mark
        IF cl_null(g_ima.ima35) THEN #FUN-C70008 add
           LET g_ima.ima35=' ' #No.7726
           CALL aws_ttsrv_setRecordField(l_node, "ima35", " ")
        END IF
        
       #IF g_ima.ima36 IS NULL THEN  #FUN-C70008 mark
        IF cl_null(g_ima.ima36) THEN #FUN-C70008 add
           LET g_ima.ima36=' ' #No.7726
           CALL aws_ttsrv_setRecordField(l_node, "ima36", " ")
        END IF
        
        IF cl_null(g_ima.ima150) THEN
           LET g_ima.ima150= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima150", " ")
        END IF
        IF cl_null(g_ima.ima151) THEN
           LET g_ima.ima151= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima151", " ")
        END IF
        IF cl_null(g_ima.ima152) THEN
           LET g_ima.ima152= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima152", " ")
        END IF
        IF cl_null(g_ima.ima910) THEN
           LET g_ima.ima910= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima910", " ")
        END IF
        #FUN-C70008---add----str---
        IF cl_null(g_ima.ima916) THEN
           LET g_ima.ima916= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima916", " ")
        END IF
        IF cl_null(g_ima.ima150) THEN
           LET g_ima.ima150= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima150", " ")
        END IF
        IF cl_null(g_ima.ima151) THEN
           LET g_ima.ima151= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima151", " ")
        END IF
        IF cl_null(g_ima.ima152) THEN
           LET g_ima.ima152= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima152", " ")
        END IF
        IF cl_null(g_ima.ima156) THEN
           LET g_ima.ima156= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima156", " ")
        END IF
        IF cl_null(g_ima.ima158) THEN
           LET g_ima.ima158= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima158", " ")
        END IF
        IF cl_null(g_ima.ima120) THEN
           LET g_ima.ima120= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima120", " ")
        END IF
        IF cl_null(g_ima.ima159) THEN
           LET g_ima.ima159= ' '
           CALL aws_ttsrv_setRecordField(l_node, "ima159", " ")
        END IF
        #FUN-C70008---add----end---
        
       #FUN-C90107 add str---
        IF cl_null(g_ima.ima926) THEN
           LET g_ima.ima926= 'N'
           CALL aws_ttsrv_setRecordField(l_node, "ima926", " ")
        END IF
        IF cl_null(g_ima.ima928) THEN
           LET g_ima.ima928= ''
           CALL aws_ttsrv_setRecordField(l_node, "ima928", " ")
        END IF
        IF cl_null(g_ima.ima160) THEN
           LET g_ima.ima160= 'N'
           CALL aws_ttsrv_setRecordField(l_node, "ima160", " ")
        END IF
       #FUN-C90107 add end---

        #----------------------------------------------------------------------#
        # 判斷此資料是否已經建立, 若已建立則為 Update                          #
        #----------------------------------------------------------------------#
        SELECT COUNT(*) INTO l_cnt2 FROM ima_file WHERE ima01 = g_ima.ima01
        IF l_cnt2 = 0 THEN
           LET l_sql = aws_ttsrv_getRecordSql(l_node, "ima_file", "I", NULL)   #I 表示取得 INSERT SQL
        ELSE
           LET l_wc = " ima01 = '", g_ima.ima01 CLIPPED, "' "                  #UPDATE SQL 時的 WHERE condition
           LET l_sql = aws_ttsrv_getRecordSql(l_node, "ima_file", "U", l_wc)   #U 表示取得 UPDATE SQL
        END IF

        #----------------------------------------------------------------------#
        # 執行 INSERT / UPDATE SQL                                             #
        #----------------------------------------------------------------------#
        EXECUTE IMMEDIATE l_sql
        IF SQLCA.SQLCODE THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
           EXIT FOR
        END IF
   #END FOR #TQC-A90047 mark

   #FUN-A70106---mark---str---
   ##全部處理都成功才 COMMIT WORK
   #IF g_status.code = "0" THEN
   #   COMMIT WORK
   #ELSE
   #   ROLLBACK WORK
   #END IF
   #FUN-A70106---mark---end---

   ##TQC-A90047---mark---str---
   ##FUN-A70106---add----str---
   #IF g_status.code = "0" THEN
   #    IF l_status = 'Y' THEN #執行確認段否
   #        LET l_exe_confirm = 'N'
   #        IF l_cnt2 = 0 THEN
   #            LET l_exe_confirm = 'Y'
   #        ELSE
   #            IF cl_null(l_imaacti) OR l_imaacti = 'P' THEN
   #                LET l_exe_confirm = 'Y'
   #            END IF
   #        END IF
   #        IF l_exe_confirm = 'Y' THEN
   #            CALL i100sub_y_chk(l_ima.ima01)
   #            IF g_success = 'N' THEN
   #                LET g_status.code = g_errno
   #                ROLLBACK WORK
   #            ELSE
   #                CALL i100sub_y_upd(l_ima.ima01)
   #                IF g_success = 'N' THEN
   #                    LET g_status.code = g_errno
   #                    ROLLBACK WORK
   #                ELSE
   #                    COMMIT WORK
   #                END IF
   #            END IF
   #        ELSE
   #            COMMIT WORK
   #        END IF
   #    ELSE
   #        COMMIT WORK
   #    END IF
   #ELSE
   #    ROLLBACK WORK
   #END IF
   ##FUN-A70106---add----end---
   ##TQC-A90047---mark---end---
   #TQC-A90047---add----str---
       IF g_status.code = "0" THEN
           IF l_status = 'Y' THEN #執行確認段否
               LET l_exe_confirm = 'N'
               IF l_cnt2 = 0 THEN
                   LET l_exe_confirm = 'Y'
               ELSE
                   IF cl_null(l_imaacti) OR l_imaacti = 'P' THEN
                       LET l_exe_confirm = 'Y'
                   END IF
               END IF
               IF l_exe_confirm = 'Y' THEN
                   CALL i100sub_y_chk(l_ima.ima01)
                   IF g_success = 'N' THEN
                       LET g_status.code = g_errno
                       EXIT FOR
                   ELSE
                       CALL i100sub_y_upd(l_ima.ima01)
                       IF g_success = 'N' THEN
                           LET g_status.code = g_errno
                           EXIT FOR
                       END IF
                      #FUN-AC0026----mark---str---
                      ##FUN-AB0109---add----str---
                      #CALL i100sub_carry(l_ima.ima01)
                      #IF g_success = 'N' THEN
                      #    LET g_status.code = g_errno
                      #    EXIT FOR
                      #END IF
                      ##FUN-AB0109---add----end---
                      #FUN-AC0026----mark---end---
                      IF g_do_data_carry = 'Y' THEN #FUN-C70008 add if 判斷
                         #FUN-AC0026----add----str---
                          CALL i100sub_carry(l_ima.ima01)
                          IF g_err_msg.getLength() <> 0 THEN
                              LET g_status.code = 'aws-607'
                              CALL cl_get_err_msg() RETURNING l_msg
                              EXIT FOR
                          END IF
                         #FUN-AC0026----add----end---
                      END IF #FUN-C70008 add
                   END IF
               #FUN-AC0026---add----str--
               ELSE
                   IF g_do_data_carry = 'Y' THEN #FUN-C70008 add if 判斷
                       CALL i100sub_carry(l_ima.ima01)
                       IF g_err_msg.getLength() <> 0 THEN
                           LET g_status.code = 'aws-607'
                           CALL cl_get_err_msg() RETURNING l_msg
                           EXIT FOR
                       END IF
                   END IF #FUN-C70008 add
               #FUN-AC0026---add----end--
               END IF
           END IF
       ELSE
           EXIT FOR 
       END IF
       LET l_commit = 'Y'
      #FUN-FB0001 add str---
       IF l_commit = 'Y' THEN
          CLOSE i100_cl
          COMMIT WORK         
       END IF
      #FUN-FB0001 add end---  
    END FOR 
    IF l_commit = 'N' THEN
        IF g_status.code != "0" THEN
           #TQC-C50229--mod---str---
           #LET g_status.description = cl_getmsg(g_status.code, g_lang)   #取得 error code
            LET l_description = cl_getmsg(g_status.code, g_lang)   #取得error code
            IF NOT cl_null(g_status.description) THEN
                LET g_status.description = g_status.description CLIPPED,":",l_description CLIPPED
            ELSE
                LET g_status.description = l_description CLIPPED
            END IF
           #TQC-C50229--mod---end---
        END IF
        LET g_status.description = l_ima.ima01 CLIPPED,':',g_status.description
        #FUN-AC0026---add---str---
        IF g_status.code = 'aws-607' THEN
            LET g_status.description = g_status.description,"==>",l_msg
        END IF
        #FUN-AC0026---add---end---
        CLOSE i100_cl  #FUN-FB0001 add 
        ROLLBACK WORK
   #FUN-FB0001 mark str---
   #ELSE
   #    COMMIT WORK
   #FUN-FB0001 mark end---
    END IF
    #TQC-A90047---add----end---
    IF g_do_data_carry = 'Y' THEN #FUN-C70008 add if 判斷
        #FUN-AC0026---add----str---
        CALL s_dc_drop_temp_table(g_dc_tabname)
        CALL s_dc_drop_temp_table(g_dc_hist_tab)
        #FUN-AC0026---add----end---
    END IF #FUN-C70008 add
END FUNCTION

FUNCTION aws_create_itemmaster_error()
   IF gi_err_code<>"0" THEN
      LET g_status.code = gi_err_code
   ELSE
      IF NOT cl_null(g_errno) THEN
         LET g_status.code = g_errno
      ELSE
         LET g_status.code = '-1106'
      END IF
   END IF
END FUNCTION

#將l_ima中非NULL的欄位值(本次更新的欄位)更新到g_ima
FUNCTION aws_create_itemmaster_field_update(l_ima)
DEFINE l_ima RECORD LIKE ima_file.*

   IF NOT cl_null(l_ima.ima01  ) THEN LET g_ima.ima01  =l_ima.ima01   END IF
   IF NOT cl_null(l_ima.ima02  ) THEN LET g_ima.ima02  =l_ima.ima02   END IF
   IF NOT cl_null(l_ima.ima021 ) THEN LET g_ima.ima021 =l_ima.ima021  END IF
   IF NOT cl_null(l_ima.ima04  ) THEN LET g_ima.ima04  =l_ima.ima04   END IF
   IF NOT cl_null(l_ima.ima06  ) THEN LET g_ima.ima06  =l_ima.ima06   END IF
   IF NOT cl_null(l_ima.ima07  ) THEN LET g_ima.ima07  =l_ima.ima07   END IF
   IF NOT cl_null(l_ima.ima08  ) THEN LET g_ima.ima08  =l_ima.ima08   END IF
   IF NOT cl_null(l_ima.ima15  ) THEN LET g_ima.ima15  =l_ima.ima15   END IF
   IF NOT cl_null(l_ima.ima16  ) THEN LET g_ima.ima16  =l_ima.ima16   END IF
   IF NOT cl_null(l_ima.ima18  ) THEN LET g_ima.ima18  =l_ima.ima18   END IF
   IF NOT cl_null(l_ima.ima24  ) THEN LET g_ima.ima24  =l_ima.ima24   END IF
   IF NOT cl_null(l_ima.ima25  ) THEN LET g_ima.ima25  =l_ima.ima25   END IF
   IF NOT cl_null(l_ima.ima35  ) THEN LET g_ima.ima35  =l_ima.ima35   END IF
   IF NOT cl_null(l_ima.ima37  ) THEN LET g_ima.ima37  =l_ima.ima37   END IF
   IF NOT cl_null(l_ima.ima42  ) THEN LET g_ima.ima42  =l_ima.ima42   END IF
   IF NOT cl_null(l_ima.ima43  ) THEN LET g_ima.ima43  =l_ima.ima43   END IF
   IF NOT cl_null(l_ima.ima45  ) THEN LET g_ima.ima45  =l_ima.ima45   END IF
   IF NOT cl_null(l_ima.ima46  ) THEN LET g_ima.ima46  =l_ima.ima46   END IF
   IF NOT cl_null(l_ima.ima491 ) THEN LET g_ima.ima491 =l_ima.ima491  END IF
   IF NOT cl_null(l_ima.ima54  ) THEN LET g_ima.ima54  =l_ima.ima54   END IF
   IF NOT cl_null(l_ima.ima56  ) THEN LET g_ima.ima56  =l_ima.ima56   END IF
   IF NOT cl_null(l_ima.ima571 ) THEN LET g_ima.ima571 =l_ima.ima571  END IF
   IF NOT cl_null(l_ima.ima59  ) THEN LET g_ima.ima59  =l_ima.ima59   END IF
   IF NOT cl_null(l_ima.ima60  ) THEN LET g_ima.ima60  =l_ima.ima60   END IF
   IF NOT cl_null(l_ima.ima64  ) THEN LET g_ima.ima64  =l_ima.ima64   END IF
   IF NOT cl_null(l_ima.ima67  ) THEN LET g_ima.ima67  =l_ima.ima67   END IF
   IF NOT cl_null(l_ima.ima72  ) THEN LET g_ima.ima72  =l_ima.ima72   END IF
   IF NOT cl_null(l_ima.ima94  ) THEN LET g_ima.ima94  =l_ima.ima94   END IF
   IF NOT cl_null(l_ima.ima100 ) THEN LET g_ima.ima100 =l_ima.ima100  END IF
   IF NOT cl_null(l_ima.ima101 ) THEN LET g_ima.ima101 =l_ima.ima101  END IF
   IF NOT cl_null(l_ima.ima102 ) THEN LET g_ima.ima102 =l_ima.ima102  END IF
   IF NOT cl_null(l_ima.ima121 ) THEN LET g_ima.ima121 =l_ima.ima121  END IF
   IF NOT cl_null(l_ima.ima122 ) THEN LET g_ima.ima122 =l_ima.ima122  END IF
   IF NOT cl_null(l_ima.ima123 ) THEN LET g_ima.ima123 =l_ima.ima123  END IF
   IF NOT cl_null(l_ima.ima124 ) THEN LET g_ima.ima124 =l_ima.ima124  END IF
   IF NOT cl_null(l_ima.ima907 ) THEN LET g_ima.ima907 =l_ima.ima907  END IF
   IF NOT cl_null(l_ima.ima1019) THEN LET g_ima.ima1019=l_ima.ima1019 END IF
   IF NOT cl_null(l_ima.ima1020) THEN LET g_ima.ima1020=l_ima.ima1020 END IF
   IF NOT cl_null(l_ima.ima1021) THEN LET g_ima.ima1021=l_ima.ima1021 END IF
END FUNCTION

#將l_ima中非NULL的欄位值(本次更新的欄位)更新到g_ima
FUNCTION aws_create_itemmaster_field_update_new()
DEFINE l_sql   STRING
DEFINE l_i     LIKE type_file.num10
DEFINE l_str   STRING                  
       #TQC-A90049--mark---str---
       #DROP TABLE ima_tmp2
       #SELECT * FROM ima_file 
       # WHERE 1=2 
       #  INTO TEMP ima_tmp2
       #TQC-A90049--mark---end---
        INSERT INTO ima_tmp2 VALUES(g_ima.*)
       #FUN-C70008 mark---str---
       #FOR l_i = 1 TO g_field_count
       #    #FUN-AB0009----str---
       #    #IF NOT cl_null(g_get_xml[l_i].field_value) THEN
       #    #    IF l_i = g_field_count THEN
       #    #        LET l_str = l_str CLIPPED,g_get_xml[l_i].field_name," = '",g_get_xml[l_i].field_value,"'"
       #    #    ELSE
       #    #        LET l_str = l_str CLIPPED,g_get_xml[l_i].field_name," = '",g_get_xml[l_i].field_value,"',"
       #    #    END IF
       #    #END IF
       #     IF NOT cl_null(g_get_xml[l_i].field_value) THEN
       #         IF l_i = 1 THEN
       #             LET l_str = l_str CLIPPED,g_get_xml[l_i].field_name," = '",g_get_xml[l_i].field_value,"'"
       #         ELSE
       #             LET l_str = l_str CLIPPED,","
       #             LET l_str = l_str CLIPPED,g_get_xml[l_i].field_name," = '",g_get_xml[l_i].field_value,"'"
       #         END IF
       #     END IF
       #    #FUN-AB0009----end---
       #END FOR
       #FUN-C70008 mark---end---
        LET l_sql = "UPDATE ima_tmp2 ",
                   #"   SET ",l_str CLIPPED            #FUN-C70008 mark
                    "   SET ",g_original_str CLIPPED   #FUN-C70008 add
        PREPARE upd_ima_tmp2_prep FROM l_sql
        EXECUTE upd_ima_tmp2_prep
        #FUN-AB0038--add----str---
        IF SQLCA.SQLCODE THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
        END IF
        #FUN-AB0038--add----end---
        SELECT * INTO g_ima.* FROM ima_tmp2
        DELETE FROM ima_tmp2 #TQC-A90047 add
        #FUN-AB0038--add----str---
        IF SQLCA.SQLCODE OR SQLCA.sqlerrd[3] = 0 THEN
           LET g_status.code = SQLCA.SQLCODE
           LET g_status.sqlcode = SQLCA.SQLCODE
        END IF
        #FUN-AB0038--add----end---

END FUNCTION

FUNCTION aws_create_itemmaster_field_check(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_n LIKE type_file.num5

   LET gi_err_code=NULL
   LET g_errno =NULL
   LET g_dbase =NULL

   IF NOT i100_chk_ima01(p_cmd) THEN
      RETURN FALSE
   END IF

   #FUN-890113 start
   {IF cl_null(g_ima_t.ima06) OR (g_ima_t.ima06<>g_ima.ima06) THEN 
      LET g_errno=NULL
      CALL i100_ima06('N')
      IF NOT cl_null(g_errno) THEN
         RETURN FALSE
      END IF
   END IF} 

   #FUN-AB0038---add---str---
   LET g_errno=NULL
   CALL i100_ima06('N')
   IF NOT cl_null(g_errno) THEN
      RETURN FALSE
   END IF
   #FUN-AB0038---add---end---

   IF p_cmd='a' THEN                                                    
      IF NOT cl_null(g_ima.ima06) THEN
   	 CALL i100_set_rel_ima06()	   	    	  	
         SELECT imz150,imz152 
           INTO g_ima.ima150,g_ima.ima152 
           FROM imz_file
          WHERE imz01=g_ima.ima06
      END IF
   END IF
   #FUN-890113 end
   CALL aws_create_itemmaster_field_update_new() #TQC-C50229 add

   IF NOT i100_chk_ima08(p_cmd) THEN
      RETURN FALSE
   END IF
   
   IF NOT i100_chk_ima13() THEN
      RETURN FALSE
   END IF
   
   IF NOT i100_chk_ima13() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima14() THEN
      RETURN FALSE
   END IF
   
   IF NOT s_chk_checkbox(g_ima.ima24) THEN
      RETURN FALSE
   END IF
   IF NOT s_chk_checkbox(g_ima.ima911) THEN
      RETURN FALSE
   END IF
   IF NOT s_chk_checkbox(g_ima.ima107) THEN
      RETURN FALSE
   END IF
   IF NOT s_chk_checkbox(g_ima.ima147) THEN
      RETURN FALSE
   END IF
   IF NOT s_chk_checkbox(g_ima.ima15) THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima109() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima903() THEN
      RETURN FALSE
   END IF

   IF NOT s_chk_checkbox(g_ima.ima105) THEN
      RETURN FALSE
   END IF
   IF NOT s_chk_checkbox(g_ima.ima70) THEN
      RETURN FALSE
   END IF

   IF NOT i100_chk_ima09() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima10() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima11() THEN
      RETURN FALSE
   END IF
   IF p_cmd='a' THEN
      LET g_ima.ima1014='1'
   END IF
   IF NOT cl_null(g_ima.ima1014) THEN
      IF g_ima.ima1014 NOT MATCHES '[123456]' THEN
         RETURN FALSE
      END IF
   END IF
   IF NOT i100_chk_ima12() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima25(p_cmd) THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima35() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima36() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima23() THEN
      RETURN FALSE
   END IF
   IF g_aza.aza50='N' THEN
      IF NOT i100_chk_ima07() THEN
         RETURN FALSE
      END IF
   END IF
   IF g_ima.ima27 IS NOT NULL THEN
      IF g_ima.ima27 <0 THEN
         LET g_errno='mfg4012'
         RETURN FALSE
      END IF
   END IF

   IF g_ima.ima28 IS NOT NULL THEN
      IF g_ima.ima28 <0 THEN
         LET g_errno='mfg4012'
         RETURN FALSE
      END IF
   END IF
   IF g_ima.ima271 IS NOT NULL THEN
      IF g_ima.ima271 <0 THEN
         LET g_errno='mfg4012'
         RETURN FALSE
      END IF
   END IF

   IF g_ima.ima71 IS NOT NULL THEN
      IF g_ima.ima71 <0 THEN
         LET g_errno='mfg4012'
         RETURN FALSE
      END IF
   END IF
   #IF NOT i100_chk_ima37() THEN #FUN-890113
   #   RETURN FALSE
   #END IF
   IF NOT i100_chk_ima51() THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima52() THEN
      RETURN FALSE
   END IF
   IF NOT cl_null(g_ima.ima39) OR g_ima.ima39 != ' '  THEN
       IF NOT i100_chk_ima39() THEN
          RETURN FALSE
       END IF
   END IF
   IF NOT cl_null(g_ima.ima391) OR g_ima.ima391 != ' '  THEN
       IF NOT i100_chk_ima391() THEN
          RETURN FALSE
       END IF
   END IF
   IF NOT i100_chk_ima906(p_cmd) THEN
      RETURN FALSE
   END IF
   IF NOT i100_chk_ima907(p_cmd) THEN
      RETURN FALSE
   END IF

   IF cl_null(g_ima.ima908) THEN
      IF g_sma.sma116 MATCHES '[123]' THEN
         LET g_ima.ima908 = g_ima.ima25
      END IF
   END IF

   IF NOT i100_chk_ima908(p_cmd) THEN
      RETURN FALSE
   END IF
   IF NOT cl_null(g_ima.ima920) THEN
      SELECT COUNT(*) INTO l_n FROM geh_file,gei_file
       WHERE geh04 = '5'
         AND geh01 = gei03
         AND gei01 = g_ima.ima920
      IF l_n = 0 THEN
         LET g_errno='aoo-112'
         RETURN FALSE
      END IF
   END IF
   IF NOT cl_null(g_ima.ima923) THEN
      SELECT COUNT(*) INTO l_n FROM geh_file,gei_file
       WHERE geh04 = '6'
         AND geh01 = gei03
         AND gei01 = g_ima.ima923
      IF l_n = 0 THEN
         LET g_errno='aoo-112'
         RETURN FALSE
      END IF
   END IF
   IF g_ima.ima925 NOT MATCHES '[123]' THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION



FUNCTION i100_chk_cur(p_sql)
DEFINE p_sql STRING
DEFINE l_cnt LIKE type_file.num5
DEFINE l_result LIKE type_file.chr1
DEFINE l_dbase LIKE type_file.chr21
   IF NOT cl_null(g_dbase) THEN  #指定資料庫,Table Name 前面加上資料庫名稱,如果有兩個Tablename,則此處理必須改寫
     #LET l_dbase=" FROM ",g_dbase CLIPPED,g_dbstring CLIPPED   #TQC-940184
      LET l_dbase=" FROM ",s_dbstring(g_dbase CLIPPED)          #TQC-940184  
      CALL cl_replace_once()
      LET p_sql=cl_replace_str(p_sql," FROM ",l_dbase)
      CALL cl_replace_init()
   END IF
	CALL cl_replace_sqldb(l_dbase) RETURNING l_dbase		#FUN-920032
   PREPARE i100_chk_cur_p FROM p_sql
   DECLARE i100_chk_cur_c CURSOR FOR i100_chk_cur_p
   OPEN i100_chk_cur_c
   FETCH i100_chk_cur_c INTO l_cnt
   IF SQLCA.sqlcode OR l_cnt=0 THEN
      LET l_result=FALSE
   ELSE
      LET l_result=TRUE
   END IF
   FREE i100_chk_cur_p
   CLOSE i100_chk_cur_c
   RETURN l_result
END FUNCTION



FUNCTION i100_chk_ima09()
   IF cl_null(g_ima.ima09) THEN
      RETURN TRUE
   END IF
   LET g_sql= #"SELECT azf01 FROM azf_file ", 
             "SELECT COUNT(*) FROM azf_file ",
             " WHERE azf01='",g_ima.ima09,"' AND azf02='D' ", #6818
             " AND azfacti='Y'"
#   IF SQLCA.sqlcode  THEN 
    IF NOT i100_chk_cur(g_sql) THEN 
#     CALL cl_err(g_ima.ima09,'mfg1306',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN 
         CALL cl_err3("sel","azf_file",g_ima.ima09,"","mfg1306","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1306"                         #TQC-C50229 add
         LET g_status.description = "ima09:",g_ima.ima09     #TQC-C50229 add
      ELSE  
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima09
         LET g_errary[g_cnt].field="ima09"
         LET g_errary[g_cnt].errno="mfg1306"
         RETURN TRUE
      END IF
      LET g_ima.ima09 = g_ima_o.ima09
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION


FUNCTION i100_chk_ima10()
   IF cl_null(g_ima.ima10) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT azf01 FROM azf_file 
             "SELECT COUNT(*) FROM azf_file ", 
             "WHERE azf01='",g_ima.ima10,"' AND azf02='E' ", #6818
             "AND azfacti='Y'"
   #IF SQLCA.sqlcode  THEN 
    IF NOT i100_chk_cur(g_sql) THEN 
#     CALL cl_err(g_ima.ima10,'mfg1306',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN 
         CALL cl_err3("sel","azf_file",g_ima.ima10,"","mfg1306","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1306"                         #TQC-C50229 add
         LET g_status.description = "ima10:",g_ima.ima10     #TQC-C50229 add
         LET g_ima.ima10 = g_ima_o.ima10
         RETURN FALSE
      ELSE  
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima10
         LET g_errary[g_cnt].field="ima10"
         LET g_errary[g_cnt].errno="mfg1306"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION


FUNCTION i100_chk_ima11()
   IF cl_null(g_ima.ima11) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT azf01 FROM azf_file 
             "SELECT COUNT(*) FROM azf_file ", 
             "WHERE azf01='",g_ima.ima11,"' AND azf02='F' ", #6818
             "AND azfacti='Y'"
   #IF SQLCA.sqlcode  THEN 
    IF NOT i100_chk_cur(g_sql) THEN 
#     CALL cl_err(g_ima.ima11,'mfg1306',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN 
         CALL cl_err3("sel","azf_file",g_ima.ima11,"","mfg1306","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1306"                         #TQC-C50229 add
         LET g_status.description = "ima11:",g_ima.ima11     #TQC-C50229 add
         LET g_ima.ima11 = g_ima_o.ima11
         RETURN FALSE
      ELSE  
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima11
         LET g_errary[g_cnt].field="ima11"
         LET g_errary[g_cnt].errno="mfg1306"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION


FUNCTION i100_chk_ima12()
   IF cl_null(g_ima.ima12) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT azf01 FROM azf_file , 
             "SELECT COUNT(*) FROM azf_file ", 
             "WHERE azf01='",g_ima.ima12,"' AND azf02='G' ", #6818
             "AND azfacti='Y'"
   #IF SQLCA.sqlcode  THEN 
    IF NOT i100_chk_cur(g_sql) THEN 
#     CALL cl_err(g_ima.ima12,'mfg1306',1)   #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN 
         CALL cl_err3("sel","azf_file",g_ima.ima12,"","mfg1306","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1306"                         #TQC-C50229 add
         LET g_status.description = "ima12:",g_ima.ima12     #TQC-C50229 add
         LET g_ima.ima12 = g_ima_o.ima12
         RETURN FALSE
      ELSE  
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima12
         LET g_errary[g_cnt].field="ima12"
         LET g_errary[g_cnt].errno="mfg1306"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION


FUNCTION i100_chk_ima23()
   IF cl_null(g_ima.ima23) THEN
      RETURN TRUE
   END IF

   
   LET g_sql="SELECT COUNT(*) FROM gen_file ",
             "WHERE gen01='",g_ima.ima23,"' ",
             "AND genacti='Y'"
   

   #IF SQLCA.sqlcode  THEN 
    IF NOT i100_chk_cur(g_sql) THEN 
#     CALL cl_err(g_ima.ima23,'aoo-001',1)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gen_file",g_ima.ima23,"","aoo-001","","",1)  #No.FUN-660156
         LET gi_err_code = "aoo-001"                         #TQC-C50229 add
         LET g_status.description = "ima23:",g_ima.ima23     #TQC-C50229 add
         LET g_ima.ima23 = g_ima_o.ima23       
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima23
         LET g_errary[g_cnt].field="ima23"
         LET g_errary[g_cnt].errno="aoo-001"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima25(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_errno STRING
   
   IF cl_null(g_ima.ima25) THEN
      RETURN TRUE
   END IF

   #CHI-870011
   IF p_cmd='u' THEN
      IF g_ima_t.ima25<>g_ima.ima25 THEN
         LET l_errno=NULL
         CALL s_chkitmdel(g_ima.ima01) RETURNING l_errno
         IF NOT cl_null(l_errno) THEN
            LET g_errno=l_errno
            RETURN FALSE
         END IF
      END IF
   END IF

   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
              "SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
              "WHERE gfe01='",g_ima.ima25,"' ",
              "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode  THEN #FUN-5A0027
    IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima25,'mfg1200',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima25,"","mfg1200","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1200"                         #TQC-C50229 add
         LET g_status.description = "ima25:",g_ima.ima25     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima25
         LET g_errary[g_cnt].field="ima25"
         LET g_errary[g_cnt].errno="mfg1200"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima31()
   IF cl_null(g_ima.ima31) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
             "SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima31,"' ",
             "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode  THEN #FUN-5A0027
    IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima31,'mfg1311',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima31,"","mfg1311","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1311"                         #TQC-C50229 add
         LET g_status.description = "ima31:",g_ima.ima31     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima31
         LET g_errary[g_cnt].field="ima31"
         LET g_errary[g_cnt].errno="mfg1311"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima35()
   IF cl_null(g_ima.ima35) THEN
      RETURN TRUE
   END IF
   #SELECT * FROM imd_file WHERE imd01=g_ima.ima35 AND imdacti='Y' #FUN-5A0027
   LET g_sql="SELECT COUNT(*) FROM imd_file ", #FUN-5A0027
             "WHERE imd01='",g_ima.ima35,"' AND imdacti='Y'"
   #IF SQLCA.sqlcode  THEN #FUN-5A0027
    IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima35,'mfg1100',1)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","imd_file",g_ima.ima35,"","mfg1100","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1100"                         #TQC-C50229 add
         LET g_status.description = "ima35:",g_ima.ima35     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima35
         LET g_errary[g_cnt].field="ima35"
         LET g_errary[g_cnt].errno="mfg1100"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima39()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima39) THEN
      RETURN TRUE
   END IF
   LET g_sql="SELECT COUNT(*) FROM aag_file ",
             "WHERE aag01 = '",g_ima.ima39,"' ",
             "  AND aag07 <> '1'",              #No.8400 #MOD-490065將aag071改為aag07
             "  AND aag00 = '",g_aza.aza81,"'"  #No.FUN-730020
   #IF l_cnt=0 THEN     # Unique  #FUN-5A0027
    IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima39,"anm-001",1)
         LET gi_err_code = "anm-001"                         #TQC-C50229 add
         LET g_status.description = "ima39:",g_ima.ima39     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima39
         LET g_errary[g_cnt].field="ima39"
         LET g_errary[g_cnt].errno="anm-001"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-680034 --START
FUNCTION i100_chk_ima391()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima391) THEN
      RETURN TRUE
   END IF
#No.TQC-7C0003 --begin
   IF g_aza.aza63 ='N' THEN
      RETURN TRUE
   END IF
#No.TQC-7C0003 --end
   LET g_sql="SELECT COUNT(*) FROM aag_file ",
             "WHERE aag01 = '",g_ima.ima391,"' ",
             "  AND aag07 <> '1'",              
             "  AND aag00 = '",g_aza.aza82,"'"  
   #IF l_cnt=0 THEN     # Unique  #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima391,"anm-001",1)
         LET gi_err_code = "anm-001"                           #TQC-C50229 add
         LET g_status.description = "ima391:",g_ima.ima391     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima391
         LET g_errary[g_cnt].field="ima391"
         LET g_errary[g_cnt].errno="anm-001"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION
#FUN-680034 --END

#FUN-640260 add
FUNCTION i100_chk_ima43()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima43) THEN
      RETURN TRUE
   END IF
   LET g_sql="SELECT COUNT(*) FROM gen_file ",
             "WHERE gen01='",g_ima.ima43,"' ",
             "AND genacti='Y'"
   #IF SQLCA.SQLCODE OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima43,'apm-048',1)
         LET gi_err_code = "apm-048"                         #TQC-C50229 add
         LET g_status.description = "ima43:",g_ima.ima43     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima43
         LET g_errary[g_cnt].field="ima43"
         LET g_errary[g_cnt].errno="apm-048"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima44()
   IF cl_null(g_ima.ima44) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
             "SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima44,"' ",
             "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima44,'apm-047',1)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima44,"","apm-047","","",1)  #No.FUN-660156
         LET gi_err_code = "apm-047"                         #TQC-C50229 add
         LET g_status.description = "ima44:",g_ima.ima44     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima44
         LET g_errary[g_cnt].field="ima44"
         LET g_errary[g_cnt].errno="apm-047"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima54()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima54) THEN
      RETURN TRUE
   END IF
   LET g_sql="SELECT COUNT(*) FROM pmc_file ",
             "WHERE pmc01 = '",g_ima.ima54,"' ",
             "AND pmcacti='Y'"
   #IF SQLCA.SQLCODE OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima54,'mfg3001',1)
         LET gi_err_code = "mfg3001"                         #TQC-C50229 add
         LET g_status.description = "ima54:",g_ima.ima54     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima54
         LET g_errary[g_cnt].field="ima54"
         LET g_errary[g_cnt].errno="mfg3001"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima55()
   IF cl_null(g_ima.ima55) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
             "SELECT COUNT(*) FROM gfe_file ",
             "WHERE gfe01='",g_ima.ima55,"' ",
             "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima55,'mfg1325',1)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima55,"","mfg1325","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1325"                         #TQC-C50229 add
         LET g_status.description = "ima55:",g_ima.ima55     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima55
         LET g_errary[g_cnt].field="ima55"
         LET g_errary[g_cnt].errno="mfg1325"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima571()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima571) THEN
      RETURN TRUE
   END IF
   
   IF g_ima.ima01=g_ima.ima571 THEN
      RETURN TRUE
   END IF
   
   LET g_sql= "SELECT COUNT(*) FROM ecu_file ",
              "WHERE ecu01='",g_ima.ima571,"' "
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima571,'aec-014',1)
         LET gi_err_code = "aec-014"                           #TQC-C50229 add
         LET g_status.description = "ima571:",g_ima.ima571     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima571
         LET g_errary[g_cnt].field="ima571"
         LET g_errary[g_cnt].errno="aec-014"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima63()
   IF cl_null(g_ima.ima63) THEN
      RETURN TRUE
   END IF
   #SELECT gfe01 FROM gfe_file #FUN-5A0027
   LET g_sql="SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima63,"' ",
             "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima63,'mfg1326',1)   #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima63,"","mfg1326","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1326"                         #TQC-C50229 add
         LET g_status.description = "ima63:",g_ima.ima63     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima63
         LET g_errary[g_cnt].field="ima63"
         LET g_errary[g_cnt].errno="mfg1326"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima67()
DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER
   IF cl_null(g_ima.ima67) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt FROM gen_file #FUN-5A0027
             "SELECT COUNT(*) FROM gen_file ", #FUN-5A0027
             "WHERE gen01='",g_ima.ima67,"' ", #FUN-5A0027
             "AND genacti='Y'"
   #IF SQLCA.SQLCODE OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima67,'arm-045',1)
         LET gi_err_code = "arm-045"                         #TQC-C50229 add
         LET g_status.description = "ima67:",g_ima.ima67     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima67
         LET g_errary[g_cnt].field="ima67"
         LET g_errary[g_cnt].errno="arm-045"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima86()
   IF cl_null(g_ima.ima86) THEN
      RETURN TRUE
   END IF
   #SELECT gfe01 FROM gfe_file  #FUN-5A0027
   LET g_sql="SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima86,"' ",
             "AND gfeacti IN ('y','Y')"
   #IF SQLCA.sqlcode THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima86,'mfg1203',1) #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima86,"","mfg1203","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1203"                         #TQC-C50229 add
         LET g_status.description = "ima86:",g_ima.ima86     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima86
         LET g_errary[g_cnt].field="ima86"
         LET g_errary[g_cnt].errno="mfg1203"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima87()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima87) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt #FUN-5A0027
             "SELECT COUNT(*) FROM smg_file ", #FUN-5A0027
             "WHERE smg01 = '",g_ima.ima87,"' ",
             "AND smgacti='Y'"
   #IF SQLCA.sqlcode OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima87,'mfg1313',1)
         LET gi_err_code = "mfg1313"                         #TQC-C50229 add
         LET g_status.description = "ima87:",g_ima.ima87     #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima87
         LET g_errary[g_cnt].field="ima87"
         LET g_errary[g_cnt].errno="mfg1313"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima872()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER  #FUN-5A0027
   IF cl_null(g_ima.ima872) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt #FUN-5A0027
             "SELECT COUNT(*) FROM smg_file ", #FUN-5A0027
             "WHERE smg01 = '",g_ima.ima872,"' ",
             "AND smgacti='Y'"
   #IF SQLCA.sqlcode OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima872,'mfg1313',1)
         LET gi_err_code = "mfg1313"                         #TQC-C50229 add
         LET g_status.description = "ima872:",g_ima.ima872   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima872
         LET g_errary[g_cnt].field="ima872"
         LET g_errary[g_cnt].errno="mfg1313"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima874()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima874) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt #FUN-5A0027
             "SELECT COUNT(*) FROM smg_file ", #FUN-5A0027
             "WHERE smg01 = '",g_ima.ima874,"' ",
             "AND smgacti='Y'"
   #IF SQLCA.sqlcode OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima874,'mfg1313',1)
         LET gi_err_code = "mfg1313"                         #TQC-C50229 add
         LET g_status.description = "ima874:",g_ima.ima874   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima874
         LET g_errary[g_cnt].field="ima874"
         LET g_errary[g_cnt].errno="mfg1313"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima109()
   IF cl_null(g_ima.ima109) THEN
      RETURN TRUE
   END IF

   #No.FUN-7C0010  --Begin
   #check by aooi601 setting
   CALL s_field_chk(g_ima.ima109,'1',g_plant,'ima109') RETURNING g_flag2
   IF g_flag2 = '0' THEN
      CALL cl_err(g_ima.ima109,'aoo-043',1)
      LET gi_err_code = "aoo-043"                         #TQC-C50229 add
      LET g_status.description = "ima109:",g_ima.ima109   #TQC-C50229 add
      LET g_ima.ima109 = g_ima_o.ima109
      RETURN FALSE
   END IF
   #No.FUN-7C0010  --End

   #SELECT azf01 FROM azf_file #FUN-5A0027
   LET g_sql="SELECT COUNT(*) FROM azf_file ", #FUN-5A0027
             "WHERE azf01='",g_ima.ima109,"' AND azf02='8' ",
             "AND azfacti='Y'"
   #IF SQLCA.sqlcode THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima109,'mfg1306',1)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","azf_file",g_ima.ima109,"","mfg1306","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg1306"                           #TQC-C50229 add
         LET g_status.description = "ima109:",g_ima.ima109     #TQC-C50229 add
         LET g_ima.ima109 = g_ima_o.ima109
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima109
         LET g_errary[g_cnt].field="ima109"
         LET g_errary[g_cnt].errno="mfg1306"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima131()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima131) THEN #FUN-5A0027
      RETURN TRUE
   END IF

   #SELECT COUNT(*) INTO l_cnt FROM oba_file #FUN-5A0027
   LET g_sql="SELECT COUNT(*) FROM oba_file ", #FUN-5A0027
             "WHERE oba01='",g_ima.ima131,"' "
   #IF STATUS THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima131,'aim-142',1)
         LET gi_err_code = "aim-142"                         #TQC-C50229 add
         LET g_status.description = "ima131:",g_ima.ima131   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima131
         LET g_errary[g_cnt].field="ima131"
         LET g_errary[g_cnt].errno="aim-142"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima132()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima132) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT count(*) INTO l_cnt FROM aag_file #FUN-5A0027
             "SELECT count(*) FROM aag_file ",
             "WHERE aag01 = '",g_ima.ima132,"' ",
             "  AND aag00 = '",g_aza.aza81,"'"  #No.FUN-730020
   #IF l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima132,"anm-001",1)
         LET gi_err_code = "anm-001"                         #TQC-C50229 add
         LET g_status.description = "ima132:",g_ima.ima132   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima132
         LET g_errary[g_cnt].field="ima132"
         LET g_errary[g_cnt].errno="anm-001"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima133(p_cmd)
DEFINE p_cmd LIKE type_file.chr1    #No.FUN-690026 VARCHAR(1)
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima133) THEN
      RETURN TRUE
   END IF
   IF p_cmd='u' THEN
      LET g_sql= #SELECT COUNT(*) INTO l_cnt FROM ima_file #FUN-5A0027
                "SELECT COUNT(*) FROM ima_file ",
                "WHERE ima01 = '",g_ima.ima133,"' "
      #IF l_cnt=0 THEN #FUN-5A0027
      IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
         IF cl_null(g_dbase) THEN #FUN-5A0027
            CALL cl_err(g_ima.ima133,'axm-297',1)
            LET gi_err_code = "axm-297"                         #TQC-C50229 add
            LET g_status.description = "ima133:",g_ima.ima133   #TQC-C50229 add
            RETURN FALSE
         ELSE  #FUN-5A0027
            LET g_cnt=g_errary.getlength()+1
            LET g_errary[g_cnt].db=g_dbase
            LET g_errary[g_cnt].value=g_ima.ima133
            LET g_errary[g_cnt].field="ima133"
            LET g_errary[g_cnt].errno="axm-297"
            RETURN TRUE
         END IF
      ELSE
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima134()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027 mark
   IF cl_null(g_ima.ima134) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt FROM obe_file #FUN-5A0027
             "SELECT COUNT(*) FROM obe_file ",
             "WHERE obe01='",g_ima.ima134,"' "
   #IF l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima134,'axm-810',1)
         LET gi_err_code = "axm-810"                         #TQC-C50229 add
         LET g_status.description = "ima134:",g_ima.ima134   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima134
         LET g_errary[g_cnt].field="ima134"
         LET g_errary[g_cnt].errno="axm-810"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima136()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima136) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt FROM imd_file  #FUN-5A0027
             "SELECT COUNT(*) FROM imd_file ",
             "WHERE imd01='",g_ima.ima136,"' ",
             "AND imdacti='Y'"
   #IF SQLCA.SQLCODE OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima136,'mfg1100',1)
         LET gi_err_code = "mfg1100"                         #TQC-C50229 add
         LET g_status.description = "ima136:",g_ima.ima136   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima136
         LET g_errary[g_cnt].field="ima136"
         LET g_errary[g_cnt].errno="mfg1100"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima137()
#DEFINE l_cnt LIKE type_file.num10   #No.FUN-690026 INTEGER #FUN-5A0027
   IF cl_null(g_ima.ima137) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT COUNT(*) INTO l_cnt FROM ime_file WHERE ime01=g_ima.ima136 #FUN-5A0027
             "SELECT COUNT(*) FROM ime_file ", #FUN-5A0027
             "WHERE ime01='",g_ima.ima136,"' ",
             "AND ime02='",g_ima.ima137,"' ",
             " AND imeacti = 'Y' "   #FUN-D40103
   #IF SQLCA.SQLCODE OR l_cnt=0 THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima137,'mfg1101',0)
         LET gi_err_code = "mfg1101"                         #TQC-C50229 add
         LET g_status.description = "ima137:",g_ima.ima137   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima137
         LET g_errary[g_cnt].field="ima137"
         LET g_errary[g_cnt].errno="mfg1101"
         RETURN TRUE
      END IF
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima907(p_cmd)
DEFINE p_cmd           LIKE type_file.chr1    #No.FUN-690026 VARCHAR(1)
DEFINE l_factor        LIKE img_file.img21
   IF cl_null(g_ima.ima907) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
             "SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima907,"' ",
             "AND gfeacti IN ('Y','y')"
   #IF SQLCA.sqlcode  THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima907,'mfg0019',0)  #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima907,"","mfg0019","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg0019"                         #TQC-C50229 add
         LET g_status.description = "ima907:",g_ima.ima907   #TQC-C50229 add
         LET g_ima.ima907 = g_ima_o.ima907
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima907
         LET g_errary[g_cnt].field="ima907"
         LET g_errary[g_cnt].errno="mfg0019"
         RETURN TRUE
      END IF
   END IF
   #母子單位時,第二單位必須和ima25有轉換率
   CALL s_du_umfchk(g_ima.ima01,'','','',g_ima.ima25,
                    g_ima.ima907,g_ima.ima906)
        RETURNING g_errno,l_factor
   IF NOT cl_null(g_errno) THEN
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima01,g_errno,0)
         LET gi_err_code = g_errno                           #TQC-C50229 add
         LET g_status.description = "ima907:",g_ima.ima907   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima907
         LET g_errary[g_cnt].field="ima907"
         LET g_errary[g_cnt].errno=g_errno
         RETURN TRUE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

#FUN-640260 add
FUNCTION i100_chk_ima908(p_cmd)
DEFINE p_cmd    LIKE type_file.chr1    #No.FUN-690026 VARCHAR(1)
DEFINE l_factor LIKE img_file.img21

   IF cl_null(g_ima.ima908) THEN
      RETURN TRUE
   END IF
   LET g_sql= #SELECT gfe01 FROM gfe_file #FUN-5A0027
             "SELECT COUNT(*) FROM gfe_file ", #FUN-5A0027
             "WHERE gfe01='",g_ima.ima908,"' ",
             "AND gfeacti IN ('Y','y')"
   #IF SQLCA.sqlcode  THEN #FUN-5A0027
   IF NOT i100_chk_cur(g_sql) THEN #FUN-5A0027
#     CALL cl_err(g_ima.ima908,'mfg0019',0)   #No.FUN-660156 MARK
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err3("sel","gfe_file",g_ima.ima908,"","mfg0019","","",1)  #No.FUN-660156
         LET gi_err_code = "mfg0019"                         #TQC-C50229 add
         LET g_status.description = "ima908:",g_ima.ima908   #TQC-C50229 add
         LET g_ima.ima908 = g_ima_o.ima908
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima908
         LET g_errary[g_cnt].field="ima908"
         LET g_errary[g_cnt].errno="mfg0019"
         RETURN TRUE
      END IF
   END IF
   #計價單位時,計價單位必須和ima25有轉換率
   CALL s_du_umfchk(g_ima.ima01,'','','',g_ima.ima25,
                    g_ima.ima908,'2')
        RETURNING g_errno,l_factor
   IF NOT cl_null(g_errno) THEN
      IF cl_null(g_dbase) THEN #FUN-5A0027
         CALL cl_err(g_ima.ima01,g_errno,1)   #TQC-6C0026 modify 0->1
         LET gi_err_code = g_errno                           #TQC-C50229 add
         LET g_status.description = "ima908:",g_ima.ima908   #TQC-C50229 add
         RETURN FALSE
      ELSE  #FUN-5A0027
         LET g_cnt=g_errary.getlength()+1
         LET g_errary[g_cnt].db=g_dbase
         LET g_errary[g_cnt].value=g_ima.ima908
         LET g_errary[g_cnt].field="ima908"
         LET g_errary[g_cnt].errno=g_errno
         RETURN TRUE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_ima06(p_def)
  DEFINE
     p_def          LIKE type_file.chr1,    
     #l_ans          LIKE type_file.chr1,   
     l_msg          LIKE ze_file.ze03,      
     l_imzacti      LIKE imz_file.imzacti

   LET g_errno = ' '
   LET g_ans=' ' #FUN-5A0027 l_ans->g_ans
    SELECT imzacti INTO l_imzacti
      FROM imz_file
     WHERE imz01 = g_ima.ima06
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3179'
         WHEN l_imzacti='N' LET g_errno = '9028'
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
END FUNCTION

#FUN-860036
#將imz_file相關欄位套用到ima_file,由i100_chk_ima06搬過來
FUNCTION i100_set_rel_ima06()
  DEFINE
     l_imz02        LIKE imz_file.imz02,
     l_imaacti      LIKE ima_file.imaacti,
     l_imauser      LIKE ima_file.imauser,
     l_imagrup      LIKE ima_file.imagrup,
     l_imamodu      LIKE ima_file.imamodu,
     l_imadate      LIKE ima_file.imadate

   #FUN-710060---mod---str---
   #SELECT *  INTO g_ima.ima06,l_imz02,g_ima.ima03,g_ima.ima04,
    SELECT imz01,imz02,imz03 ,imz04,
           imz07,imz08,imz09,imz10,
           imz11,imz12,imz14,imz15,
           imz17,imz19,imz21,
           imz23,imz24,imz25,imz27,
           imz28,imz31,imz31_fac,imz34,
           imz35,imz36,imz37,imz38,
           imz39,imz42,imz43,imz44,
           imz44_fac,imz45,imz46 ,imz47,
           imz48,imz49,imz491,imz50,
           imz51,imz52,imz54,imz55,
           imz55_fac,imz56,imz561,imz562,
           imz571,
           imz59 ,imz60,imz61,imz62,
           imz63,imz63_fac ,imz64,imz641,
           imz65,imz66,imz67,imz68,
           imz69,imz70,imz71,imz86,
           imz86_fac ,imz87,imz871,imz872,
           imz873,imz874,imz88,imz89,
           imz90,imz94,imz99,imz100 ,
           imz101,imz102 ,imz103,imz105,
           imz106,imz107,imz108,imz109,
           imz110,imz130,imz131,imz132,
           imz133,imz134,
           imz147,imz148,imz903,
           imzacti,imzuser,imzgrup,imzmodu,imzdate,
           imz906,imz907,imz908,imz909,
           imz911,
           imz136,imz137,imz391,imz1321,
           imz72
   #FUN-710060---mod---end---

      INTO g_ima.ima06,l_imz02,g_ima.ima03,g_ima.ima04,
           g_ima.ima07,g_ima.ima08,g_ima.ima09,g_ima.ima10,
           g_ima.ima11,g_ima.ima12,g_ima.ima14,g_ima.ima15,
           g_ima.ima17,g_ima.ima19,g_ima.ima21,
           g_ima.ima23,g_ima.ima24,g_ima.ima25,g_ima.ima27, #No.7703 add ima24
           g_ima.ima28,g_ima.ima31,g_ima.ima31_fac,g_ima.ima34,
           g_ima.ima35,g_ima.ima36,g_ima.ima37,g_ima.ima38,
           g_ima.ima39,g_ima.ima42,g_ima.ima43,g_ima.ima44,
           g_ima.ima44_fac,g_ima.ima45,g_ima.ima46,g_ima.ima47,
           g_ima.ima48,g_ima.ima49,g_ima.ima491,g_ima.ima50,
           g_ima.ima51,g_ima.ima52,g_ima.ima54,g_ima.ima55,
           g_ima.ima55_fac,g_ima.ima56,g_ima.ima561,g_ima.ima562,
           g_ima.ima571,
           g_ima.ima59, g_ima.ima60,g_ima.ima61,g_ima.ima62,
           g_ima.ima63, g_ima.ima63_fac,g_ima.ima64,g_ima.ima641,
           g_ima.ima65, g_ima.ima66,g_ima.ima67,g_ima.ima68,
           g_ima.ima69, g_ima.ima70,g_ima.ima71,g_ima.ima86,
           g_ima.ima86_fac, g_ima.ima87,g_ima.ima871,g_ima.ima872,
           g_ima.ima873, g_ima.ima874,g_ima.ima88,g_ima.ima89,
           g_ima.ima90,g_ima.ima94,g_ima.ima99,g_ima.ima100,     #NO.6842養生
           g_ima.ima101,g_ima.ima102,g_ima.ima103,g_ima.ima105,  #NO.6842養生
           g_ima.ima106,g_ima.ima107,g_ima.ima108,g_ima.ima109,  #NO.6842養生
           g_ima.ima110,g_ima.ima130,g_ima.ima131,g_ima.ima132,  #NO.6842養生
           g_ima.ima133,g_ima.ima134,                            #NO.6842養生
           g_ima.ima147,g_ima.ima148,g_ima.ima903,
           l_imaacti,l_imauser,l_imagrup,l_imamodu,l_imadate,
           g_ima.ima906,g_ima.ima907,g_ima.ima908,g_ima.ima909,  #FUN-540025
           g_ima.ima911,                                         #FUN-610080 加ima911
           g_ima.ima136,g_ima.ima137,g_ima.ima391,g_ima.ima1321, #FUN-650004   #FUN-680034
           g_ima.ima915                                          #FUN-710060 add
           FROM  imz_file
           WHERE imz01 = g_ima.ima06
   IF g_ima.ima99 IS NULL THEN LET g_ima.ima99 = 0 END IF
   IF g_ima.ima133 IS NULL THEN LET g_ima.ima133 = g_ima.ima01 END IF
   IF g_ima.ima01[1,4]='MISC' THEN #NO.6808(養生)
      LET g_ima.ima08='Z'
   END IF
END FUNCTION

FUNCTION i100_u_updchk()
   DEFINE l_i      LIKE type_file.num5      #FUN-F50005 add
#   OPEN i100_cl USING g_ima_rowid  #091021 mark
      FOR l_i = 1 to 3  #FUN-F50005 add
         OPEN i100_cl USING g_ima.ima01  #091021 add
         IF SQLCA.sqlcode THEN
            CALL cl_err(g_ima.ima01,SQLCA.sqlcode,0)
            LET gi_err_code = SQLCA.sqlcode                   #TQC-C50229 add
            LET g_status.description = "ima01:",g_ima.ima01   #TQC-C50229 add
           #FUN-F50005 add start ---
           #若最後一次判斷資料依然發生錯誤,則直接往下執行程式
            IF l_i < 3 THEN
               SLEEP 2
               CONTINUE FOR
            END IF
           #FUN-F50005 add end ---
            RETURN FALSE
         END IF
         FETCH i100_cl INTO g_ima.*               # 對DB鎖定
         IF SQLCA.sqlcode THEN
            CALL cl_err(g_ima.ima01,SQLCA.sqlcode,0)
            LET gi_err_code = SQLCA.sqlcode                   #TQC-C50229 add
            LET g_status.description = "ima01:",g_ima.ima01   #TQC-C50229 add
           #FUN-F50005 add start ---
           #若最後一次判斷資料依然發生錯誤,則直接往下執行程式
            IF l_i < 3 THEN
               SLEEP 2
               CONTINUE FOR
            END IF
           #FUN-F50005 add end ---
            RETURN FALSE
         END IF
       
         IF g_ima.imaacti ='N' THEN    #檢查資料是否為無效
            CALL cl_err(g_ima.ima01,'mfg1000',0)
            LET gi_err_code = "mfg1000"                           #TQC-C50229 add
            LET g_status.description = "imaacti:",g_ima.imaacti   #TQC-C50229 add
            RETURN FALSE
         END IF
       
        #FUN-C90107 add str---
         IF g_imaacti = 'N' THEN   #FUN-D10122 add
            CALL i100sub_x(g_ima.ima01)  #料件做失效前的檢核
            IF NOT cl_null(g_errno) THEN
               RETURN FALSE
            END IF
         END IF                    #FUN-D10122 add
        #FUN-C90107 add end---
       
         LET g_ima.imamodu = g_user                   #修改者
         LET g_ima.imadate = g_today                  #修改日期
         RETURN TRUE
      END FOR  #FUN-F50005 add
END FUNCTION

FUNCTION i100_default()

   LET g_ima.ima07 = 'A'
   LET g_ima.ima08 = 'P'
   LET g_ima.ima108 = 'N'
   LET g_ima.ima14 = 'N'
   LET g_ima.ima903= 'N' #NO.6872
   LET g_ima.ima905= 'N'
   LET g_ima.ima15 = 'N'
   LET g_ima.ima16 = 99
   LET g_ima.ima18 = 0
   LET g_ima.ima09 =' '
   LET g_ima.ima10 =' '
   LET g_ima.ima11 =' '
   LET g_ima.ima12 =' '
   LET g_ima.ima23 = ' '
   #-----No.FUN-810036-----
   LET g_ima.ima918= 'N'
   LET g_ima.ima919= 'N'
   LET g_ima.ima921= 'N'
   LET g_ima.ima922= 'N'
   LET g_ima.ima924= 'N'
   #-----No.FUN-810036 END-----
   LET g_ima.ima24 = 'N'
   LET g_ima.ima911= 'N'   #FUN-610080
  ##NO.FUN-A20044   --begin
  #LET g_ima.ima26 = 0
  #LET g_ima.ima261 = 0
  #LET g_ima.ima262 = 0
  ##NO.FUN-A20044   --end
   LET g_ima.ima27 = 0
   LET g_ima.ima271 = 0
   LET g_ima.ima28 = 0
   LET g_ima.ima30 = g_today #No.7643 新增 aimi100料號時應default ima30=料件建立日期,以便循環盤點機制
   LET g_ima.ima31_fac = 1
   LET g_ima.ima32 = 0
   LET g_ima.ima33 = 0
   LET g_ima.ima37 = '0'
   LET g_ima.ima38 = 0
   LET g_ima.ima40 = 0
   LET g_ima.ima41 = 0
   LET g_ima.ima42 = '0'
   LET g_ima.ima44_fac = 1
   LET g_ima.ima45 = 0
   LET g_ima.ima46 = 0
   LET g_ima.ima47 = 0
   LET g_ima.ima48 = 0
   LET g_ima.ima49 = 0
   LET g_ima.ima491 = 0
   LET g_ima.ima50 = 0
   LET g_ima.ima51 = 1
   LET g_ima.ima52 = 1
   LET g_ima.ima140 = 'N'
   LET g_ima.ima53 = 0
   LET g_ima.ima531 = 0
   LET g_ima.ima55_fac = 1
   LET g_ima.ima56 = 1
   LET g_ima.ima561 = 1  #最少生產數量
   LET g_ima.ima562 = 0  #生產時損耗率
   LET g_ima.ima57 = 0
   LET g_ima.ima58 = 0
   LET g_ima.ima59 = 0
   LET g_ima.ima60 = 0
   LET g_ima.ima61 = 0
   LET g_ima.ima62 = 0
   LET g_ima.ima63_fac = 1
   LET g_ima.ima64 = 1
   LET g_ima.ima641 = 1   #最少發料數量
   LET g_ima.ima65 = 0
   LET g_ima.ima66 = 0
   LET g_ima.ima68 = 0
   LET g_ima.ima69 = 0
   LET g_ima.ima70 = 'N'
   LET g_ima.ima107= 'N'
   LET g_ima.ima147= 'N' #BugNo.6542 add ima147
   LET g_ima.ima71 = 0
   LET g_ima.ima72 = 0
   LET g_ima.ima75 = ''
   LET g_ima.ima76 = ''
   LET g_ima.ima77 = 0
   LET g_ima.ima78 = 0
  #LET g_ima.ima79 = 0         #TQC-650066 mark
   LET g_ima.ima80 = 0
   LET g_ima.ima81 = 0
   LET g_ima.ima82 = 0
   LET g_ima.ima83 = 0
   LET g_ima.ima84 = 0
   LET g_ima.ima85 = 0
   LET g_ima.ima852= 'N'
   LET g_ima.ima853= 'N'
   LET g_ima.ima871 = 0
   LET g_ima.ima86_fac = 1
   LET g_ima.ima873 = 0
   LET g_ima.ima88 = 1
   LET g_ima.ima91 = 0
   LET g_ima.ima92 = 'N'
   LET g_ima.ima93 = "NNNNNNNN"
   LET g_ima.ima94 = ''
   LET g_ima.ima95 = 0
   LET g_ima.ima96 = 0
   LET g_ima.ima97 = 0
   LET g_ima.ima98 = 0
   LET g_ima.ima99 = 0
   LET g_ima.ima100 = 'N'
   LET g_ima.ima101 = '1'
   LET g_ima.ima102 = '1'
   LET g_ima.ima103 = '0'
   LET g_ima.ima104 = 0
   LET g_ima.ima910 = ' '  #FUN-550014
   LET g_ima.ima105 = 'N'
   LET g_ima.ima110 = '1'
   LET g_ima.ima139 = 'N'
   LET g_ima.imaacti= 'P' #有效的資料
   LET g_ima.imauser= g_user
   LET g_ima.imaoriu = g_user #FUN-980030
   LET g_ima.imaorig = g_grup #FUN-980030
   LET g_ima.imagrup= g_grup                #使用者所屬群
   LET g_ima.imadate= g_today
   LET g_ima.ima901 = g_today               #料件建檔日期
   LET g_ima.ima912 = 0   #FUN-610080
   #產品資料
   LET g_ima.ima130 = '1'
   LET g_ima.ima121 = 0
   LET g_ima.ima122 = 0
   LET g_ima.ima123 = 0
   LET g_ima.ima124 = 0
   LET g_ima.ima125 = 0
   LET g_ima.ima126 = 0
   LET g_ima.ima127 = 0
   LET g_ima.ima128 = 0
   LET g_ima.ima129 = 0
   LET g_ima.ima141 = '0'
  #LET g_ima.ima1010 = '1' #No.FUN-610013 #FUN-690060
   LET g_ima.ima1010 = '0' #0:開立        #FUN-690060
   #單位控制部分

   #FUN-540025  --begin
   IF g_sma.sma115 = 'Y' THEN
      IF g_sma.sma122 MATCHES '[13]' THEN
         LET g_ima.ima906 = '2'
      ELSE
         LET g_ima.ima906 = '3'
      END IF
   ELSE
      LET g_ima.ima906 = '1'
   END IF
   LET g_ima.ima909 = 0
   #FUN-540025  --end
   LET g_ima.ima1001 = ''
   LET g_ima.ima1002 = ''
   LET g_ima.ima1014 = '1'
   #FUN-810038................begin
   LET g_ima.ima915 = '0' #FUN-890113
   LET g_ima.ima916 = ' '
   LET g_ima.ima150 = ' '
   LET g_ima.ima151 = ' '
   LET g_ima.ima152 = ' '
   #FUN-810038................end
   #-----No.FUN-810036-----
   LET g_ima.ima918='N'
   LET g_ima.ima919='N'
   LET g_ima.ima921='N'
   LET g_ima.ima922='N'
   LET g_ima.ima924='N'
   LET g_ima.ima925='1'
   #-----No.FUN-810036 END-----
   LET g_ima.ima916=g_plant  #No.FUN-7C0010
   LET g_ima.ima917=0        #No.FUN-7C0010
   #FUN-A70106---add---str---
   LET g_ima.ima022 = 0
   LET g_ima.ima156 = 'N'
   LET g_ima.ima158 = 'N'
   LET g_ima.ima926 = 'N'
   LET g_ima.ima927 = 'N'
   LET g_ima.ima120 = '1'
   #FUN-A70106---add---end---
END FUNCTION

FUNCTION i100_a_inschk()
   IF g_ima.ima31 IS NULL THEN
      LET g_ima.ima31=g_ima.ima25
      LET g_ima.ima31_fac=1
   END IF

   IF g_ima.ima133 IS NULL THEN
      LET g_ima.ima133 = g_ima.ima01
   END IF

   #No.B013 010322 by plum
   IF g_ima.ima571 IS NULL THEN
      LET g_ima.ima571 = g_ima.ima01
   END IF
   #No.B013 ..end

   IF g_ima.ima44 IS NULL OR g_ima.ima44=' ' THEN
      LET g_ima.ima44=g_ima.ima25   #採購單位
      LET g_ima.ima44_fac=1
   END IF

   IF g_ima.ima55 IS NULL OR g_ima.ima55=' ' THEN
      LET g_ima.ima55=g_ima.ima25   #生產單位
      LET g_ima.ima55_fac=1
   END IF

   IF g_ima.ima63 IS NULL OR g_ima.ima63=' ' THEN
      LET g_ima.ima63=g_ima.ima25   #發料單位
      LET g_ima.ima63_fac=1
   END IF

   LET g_ima.ima86=g_ima.ima25   #庫存單位=成本單位
   LET g_ima.ima86_fac=1

   IF g_ima.ima35 IS NULL THEN
      LET g_ima.ima35=' ' #No.7726
   END IF

   IF g_ima.ima36 IS NULL THEN
      LET g_ima.ima36=' ' #No.7726
   END IF

   IF g_ima.ima910 IS NULL THEN
      LET g_ima.ima910=' ' #FUN-550014
   END IF

   #IF g_aza.aza44 = "Y" THEN  #FUN-550077 #TQC-6C0060 mark
   #   CALL cl_itemname_switch(1,"ima_file","ima02",g_ima.ima01,g_ima.ima02) RETURNING g_ima.ima02
   #   CALL cl_itemname_switch(1,"ima_file","ima021",g_ima.ima01,g_ima.ima021) RETURNING g_ima.ima021
   #END IF

   LET g_ima.ima913 = "N"   #No.MOD-640061
END FUNCTION

FUNCTION i100_i_inpchk()
   IF ( g_ima.ima37='0' OR g_ima.ima37 ='5' )
      AND ( g_ima.ima08 NOT MATCHES '[MSPVZ]' )
   THEN CALL cl_err(g_ima.ima37,'mfg3201',1)
        LET gi_err_code = "mfg3201"                        #TQC-C50229 add
        LET g_status.description = "ima08:",g_ima.ima08    #TQC-C50229 add
        RETURN "ima01"
   END IF
   #FUN-540025  --begin
   IF g_sma.sma115 = 'Y' THEN
      IF g_ima.ima906 IS NULL THEN
         LET gi_err_code = "aim-996"                          #TQC-C50229 add
         LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
         RETURN "ima906"
      END IF
   END IF
   IF g_sma.sma122 = '1' THEN
      IF g_ima.ima906 = '3' THEN
         CALL cl_err('','asm-322',1)
         LET gi_err_code = "asm-322"                          #TQC-C50229 add
         LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
         RETURN "ima906"
      END IF
   END IF
   IF g_sma.sma122 = '2' THEN
      IF g_ima.ima906 = '2' THEN
         CALL cl_err('','asm-323',1)
         LET gi_err_code = "asm-323"                          #TQC-C50229 add
         LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
         RETURN "ima906"
      END IF
   END IF
   #FUN-540025  --end
   RETURN NULL
END FUNCTION

FUNCTION i100_chk_ima01(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_cnt LIKE type_file.num5
   DEFINE l_ima01 STRING

   IF NOT cl_null(g_ima.ima01) THEN
      IF p_cmd = "a" OR                    # 若輸入或更改且改KEY
        (p_cmd = "u" AND g_ima.ima01 != g_ima_t.ima01) THEN
          SELECT COUNT(*) INTO l_cnt FROM ima_file
              WHERE ima01 = g_ima.ima01
          IF l_cnt > 0 THEN                  # Duplicated
              CALL cl_err(g_ima.ima01,-239,0)
              LET gi_err_code = "-239"                           #TQC-C50229 add
              LET g_status.description = "ima01:",g_ima.ima01    #TQC-C50229 add
              LET g_ima.ima01 = g_ima_t.ima01
              RETURN FALSE
          END IF
          #-----No.FUN-640043-----
          LET l_ima01 = g_ima.ima01
          IF l_ima01.getIndexOf("*",1) OR l_ima01.getIndexOf(":",1)
             OR l_ima01.getIndexOf("|",1) OR l_ima01.getIndexOf("?",1)
             OR l_ima01.getIndexOf("!",1) OR l_ima01.getIndexOf("%",1)
             OR l_ima01.getIndexOf("&",1) OR l_ima01.getIndexOf("^",1)
             OR l_ima01.getIndexOf("<",1) OR l_ima01.getIndexOf(">",1) THEN
             CALL cl_err(g_ima.ima01,"aim-122",0)
             LET gi_err_code = "aim-122"                        #TQC-C50229 add
             LET g_status.description = "ima01:",g_ima.ima01    #TQC-C50229 add
             LET g_ima.ima01 = g_ima_t.ima01
             RETURN FALSE
          END IF
          #-----No.FUN-640043 END-----
      END IF
      IF cl_null(g_ima.ima571) THEN    #No.MOD-790164 add
         LET g_ima.ima571 = g_ima.ima01
      END IF        #No.MOD-790164 add
      IF g_ima.ima01[1,4]='MISC' AND
          (NOT cl_null(g_ima.ima01[5,10])) THEN    #NO.6808(養生)
          SELECT COUNT(*) INTO l_cnt FROM ima_file   #至少要有一筆'MISC'先存在
           WHERE ima01='MISC'                      #才可以打其它MISCXX資料
          IF l_cnt=0 THEN
             CALL cl_err('','aim-806',1)
             LET gi_err_code = "aim-806"                        #TQC-C50229 add
             LET g_status.description = "ima01:",g_ima.ima01    #TQC-C50229 add
             RETURN FALSE
          END IF
      END IF
      IF g_ima.ima01[1,4]='MISC' THEN
          LET g_ima.ima08='Z'
      END IF
      SELECT ima1015 INTO g_ima.ima1015
        FROM ima_file
       WHERE ima01=g_ima.ima01
      #No.FUN-7C0010  --Begin
      #check by aooi601 setting
      CALL s_field_chk(g_ima.ima01,'1',g_plant,'ima01') RETURNING g_flag2
      IF g_flag2 = '0' THEN
         CALL cl_err(g_ima.ima01,'aoo-043',1)
         LET gi_err_code = "aoo-043"                        #TQC-C50229 add
         LET g_status.description = "ima01:",g_ima.ima01    #TQC-C50229 add
         LET g_ima.ima01 = g_ima_t.ima01
         RETURN FALSE
      END IF
      #No.FUN-7C0010  --End
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima08(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_misc LIKE type_file.chr4

   IF NOT cl_null(g_ima.ima08) THEN
      IF g_ima.ima08 NOT MATCHES "[CTDAMPXKUVZS]"
           OR g_ima.ima08 IS NULL
         THEN CALL cl_err(g_ima.ima08,'mfg1001',0)
              LET gi_err_code = "mfg1001"                        #TQC-C50229 add
              LET g_status.description = "ima08:",g_ima.ima08    #TQC-C50229 add
              LET g_ima.ima08 = g_ima_o.ima08
              RETURN FALSE
         ELSE IF g_ima.ima08 != 'T' THEN
                 LET g_ima.ima13 = NULL
              END IF
      END IF
      #NO.6808(養生)
      LET l_misc=g_ima.ima01[1,4]
      IF l_misc='MISC' AND g_ima.ima08 <>'Z' THEN
          CALL cl_err('','aim-805',0)
          LET gi_err_code = "aim-805"                        #TQC-C50229 add
          LET g_status.description = "ima08:",g_ima.ima08    #TQC-C50229 add
          RETURN FALSE
      END IF
      LET g_ima_o.ima08 = g_ima.ima08
      IF g_ima.ima08 NOT MATCHES "[MT]" THEN #NO.6872
          LET g_ima.ima903 = 'N'
          LET g_ima.ima905 = 'N'
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima13()
   IF NOT cl_null(g_ima.ima13) THEN
       IF (g_ima.ima08 = 'T') AND (g_ima.ima13 IS NULL
                 OR g_ima.ima13 = ' ' )
         THEN CALL cl_err(g_ima.ima13,'mfg1327',0)
              LET gi_err_code = "mfg1327"                        #TQC-C50229 add
              LET g_status.description = "ima13:",g_ima.ima13    #TQC-C50229 add
              LET g_ima.ima13 = g_ima_o.ima13
              RETURN FALSE
       END IF
       IF g_ima.ima18 IS NOT NULL
          THEN IF (g_ima_o.ima13 IS NULL ) OR (g_ima_o.ima13 != g_ima.ima13)
                 THEN SELECT ima08 FROM ima_file
                                    WHERE ima01 = g_ima.ima13
                                      AND ima08 matches 'C'
                                      AND imaacti matches'[Yy]'
                      IF SQLCA.sqlcode != 0 THEN
#                        CALL cl_err(g_ima.ima13,'mfg1328',0)  #No.FUN-660156 MARK
                         CALL cl_err3("sel","ima_file",g_ima.ima13,"",
                                       "mfg1328","","",1)  #No.FUN-660156
                         LET gi_err_code = "mfg1328"                        #TQC-C50229 add
                         LET g_status.description = "ima13:",g_ima.ima13    #TQC-C50229 add
                         LET g_ima.ima13 = g_ima_o.ima13
                         RETURN FALSE
                      END IF
              END IF
       END IF
   END IF
   LET g_ima_o.ima13 = g_ima.ima13
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima14()
   IF NOT cl_null(g_ima.ima14) THEN
      IF g_ima.ima14 NOT MATCHES "[YN]" THEN
         CALL cl_err(g_ima.ima14,'mfg1002',0)
         LET gi_err_code = "mfg1002"                        #TQC-C50229 add
         LET g_status.description = "ima14:",g_ima.ima14    #TQC-C50229 add
         LET g_ima.ima14 = g_ima_o.ima14
         RETURN FALSE
      END IF
   END IF
   LET g_ima_o.ima14 = g_ima.ima14
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima903()
   IF NOT cl_null(g_ima.ima903) THEN
      IF g_ima.ima903 NOT MATCHES "[YN]" THEN
         CALL cl_err(g_ima.ima903,'mfg1002',0)
         LET gi_err_code = "mfg1002"                          #TQC-C50229 add
         LET g_status.description = "ima903:",g_ima.ima903    #TQC-C50229 add
         LET g_ima.ima903 = g_ima_o.ima903
         RETURN FALSE
      END IF
      LET g_ima_o.ima903 = g_ima.ima903
      IF cl_null(g_ima.ima905) THEN
          LET g_ima.ima905 = 'N'
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima36()
    IF g_ima.ima36 !=' ' AND g_ima.ima36 IS NOT NULL THEN
       SELECT * FROM ime_file WHERE ime01=g_ima.ima35
          AND ime02=g_ima.ima36
          AND imeacti = 'Y'   #FUN-D40103
       IF SQLCA.SQLCODE THEN
#         CALL cl_err(g_ima.ima36,'mfg1101',0) #No.FUN-660156 MARK
          CALL cl_err3("sel","ime_file",g_ima.ima36,"","mfg1101",
                       "","",1)  #No.FUN-660156
          LET gi_err_code = "mfg1101"                          #TQC-C50229 add
          LET g_status.description = "ima36:",g_ima.ima36      #TQC-C50229 add
          RETURN FALSE
       END IF
    END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima37()
   IF NOT cl_null(g_ima.ima37) THEN
#     IF g_ima.ima37 NOT MATCHES "[012345]" THEN                #No.FUN-810016 --mark--
      IF g_ima.ima37 NOT MATCHES "[0123456]" THEN                #No.FUN-810016
          CALL cl_err(g_ima.ima37,'mfg1003',0)
          LET gi_err_code = "mfg1003"                          #TQC-C50229 add
          LET g_status.description = "ima37:",g_ima.ima37      #TQC-C50229 add
          LET g_ima.ima37 = g_ima_o.ima37
          RETURN FALSE
      END IF
      #CALL s_opc(g_ima.ima37) RETURNING g_sta
      #--->補貨策略碼為'0'(再訂購點),'5'(期間採購)
      IF ( g_ima.ima37='0' OR g_ima.ima37 ='5' )
         AND ( g_ima.ima08 NOT MATCHES '[MSPVZ]' ) THEN
         CALL cl_err(g_ima.ima37,'mfg3201',0)
         LET gi_err_code = "mfg3201"                          #TQC-C50229 add
         LET g_status.description = "ima37:",g_ima.ima37      #TQC-C50229 add
         LET g_ima.ima37 = g_ima_o.ima37
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima07()
   IF NOT cl_null(g_ima.ima07) THEN
      IF g_ima.ima07 NOT MATCHES'[ABC]' THEN
          CALL cl_err(g_ima.ima07,'mfg0009',0)
          LET gi_err_code = "mfg0009"                          #TQC-C50229 add
          LET g_status.description = "ima07:",g_ima.ima07      #TQC-C50229 add
          LET g_ima.ima07 = g_ima_o.ima07
          RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima51()
   IF NOT cl_null(g_ima.ima51) THEN
      IF g_ima.ima51 <= 0
      THEN CALL cl_err(g_ima.ima51,'mfg1322',0)
           LET gi_err_code = "mfg1322"                          #TQC-C50229 add
           LET g_status.description = "ima51:",g_ima.ima51      #TQC-C50229 add
           LET g_ima.ima51 = g_ima_o.ima51
           RETURN FALSE
      END IF
    ELSE 
      LET g_ima.ima51 = 1
       
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima52()
   IF NOT cl_null(g_ima.ima52) THEN 
     IF g_ima.ima52 <= 0 THEN
        CALL cl_err(g_ima.ima52,'mfg1322',0)
        LET gi_err_code = "mfg1322"                          #TQC-C50229 add
        LET g_status.description = "ima52:",g_ima.ima52      #TQC-C50229 add
        LET g_ima.ima52 = g_ima_o.ima52
        RETURN FALSE
     END IF
   ELSE 
     LET g_ima.ima52 = 1
      
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION i100_chk_ima906(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1

   IF NOT cl_null(g_ima.ima906) THEN
      IF g_sma.sma115 = 'Y' THEN
         IF g_ima.ima906 IS NULL THEN
            CALL cl_err(g_ima.ima906,'aim-998',0)
            LET gi_err_code = "aim-998"                          #TQC-C50229 add
            LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
            RETURN FALSE
         END IF
         IF g_sma.sma122 = '1' THEN
            IF g_ima.ima906 = '3' THEN
               CALL cl_err('','asm-322',1)
               LET gi_err_code = "asm-322"                          #TQC-C50229 add
               LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
               RETURN FALSE
            END IF
         END IF
         IF g_sma.sma122 = '2' THEN
            IF g_ima.ima906 = '2' THEN
               CALL cl_err('','asm-323',1)
               LET gi_err_code = "asm-323"                          #TQC-C50229 add
               LET g_status.description = "ima906:",g_ima.ima906    #TQC-C50229 add
               RETURN FALSE
            END IF
         END IF
         IF g_ima.ima906 <> '1' THEN
            IF cl_null(g_ima.ima907) THEN
               LET g_ima.ima907 = g_ima.ima25
            END IF
         END IF
         IF g_sma.sma116 MATCHES '[123]' THEN    #No.FUN-610076
            IF cl_null(g_ima.ima908) THEN
               LET g_ima.ima908 = g_ima.ima25
            END IF
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#FUN-D10092
