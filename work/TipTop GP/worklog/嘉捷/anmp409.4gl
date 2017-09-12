# Prog. Version..: '5.30.08-13.07.05(00010)'     #
#
# Pattern name...: anmp409.4gl
# Descriptions...: NM系統傳票拋轉還原
# Date & Author..: 97/05/09 By Danny
# Modify.........: No.9028 04/01/07 By Kitty 將利息暫估合併進來
# Modify.........: No.FUN-550057 BY wujie    單據編號加大
# Modify.........: NO.MOD-570223 05/07/29 By Yiting 傳票還原時,應判斷AP系統關帳
# Modify.........: MOD-590081 05/09/20 By Smapmin 取消call s_abhmod()
# Modify.........: FUN-590111 05/10/03 By Nicola 還原更新gsh,gse
# Modify.........: TQC-620099 06/02/20 By Smapmin npp00若為4,5,11,12,則必須至anmp110執行還原作業
# Modify.........: No.FUN-570127 06/03/08 By yitin 批次背景執行
# Modify.........: MOD-630059 06/03/16 By Smapmin 修正TQC-620099,新增8,9,10的判斷
# Modify.........: No.FUN-660148 06/06/21 By Hellen cl_err --> cl_err3
# Modify.........: No.FUN-670006 06/07/10 By Jackho 帳別權限修改
# Modify.........: No.FUN-670039 06/07/12 By Carrier 帳別擴充
# Modify.........: No.FUN-670060 06/07/27 By ice FUN-660148修改錯誤還原
# Modify.........: No.FUN-680034 06/08/25 By ice 兩套帳功能修改
# Modify.........: No.FUN-680107 06/09/07 By Hellen 欄位類型修改
# Modify.........: No.FUN-690117 06/10/16 By cheunl cl_used位置調整及EXIT PROGRAM后加cl_used
# Modify.........: No.FUN-6A0082 06/11/06 By dxfwo l_time轉g_time
# Modify.........: No.MOD-740189 07/04/22 By Carrier g_existno/acc2的判斷加入g_aza.aza63這個條件
# Modify.........: No.TQC-750211 07/05/28 By chenl   修改p409_t()bug
# Modify.........: No.CHI-780008 07/08/13 By Smapmin 還原MOD-590081
# Modify.........: No.CHI-810018 08/03/07 By Smapmin 若存在票據立帳資料,一併update 立帳資料的傳票編號
# Modify.........: No.CHI-810019 08/04/16 By Smapmin 若存在票據立帳資料,一併update 立帳資料的傳票編號
# Modify.........: No.FUN-980005 09/08/12 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980020 09/08/30 By douzh GP5.2架構重整，修改sub相關傳參
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-990031 09/10/13 By lutingtingGP5.2財務營運中心欄位調整,營運中心要控制在同一法人下 
# Modify.........: No:CHI-A20014 10/02/25 By sabrina 送簽中或已核准不可還原
# Modify.........: No:CHI-A40016 10/04/13 By Summer 當npp00 = '18' AND nmz52 = 'Y'時,2-1.抓取 aba06 = 'AC'
#                                                   2-2.檢核若 aba07 = 傳票單號 AND aba06 = 'RA'存在時,則不可還原
# Modify.........: No.FUN-A50102 10/07/09 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:MOD-A80132 10/08/18 By Dido 當多筆合併時,應增加 distinct 與 npptype 條件 
# Modify.........: No:MOD-AA0163 10/10/27 By Dido 改用 COUNT 方式判斷 npp00 是否為 18 類別 
# Modify.........: No:MOD-AB0110 10/11/11 By Dido 增加排除 '24'類別 
# Modify.........: No.FUN-B50090 11/05/16 By suncx 財務關帳日期加嚴控管修正
# Modify.........: No.FUN-B40056 11/06/03 By guoch  刪除資料時一併刪除tic_file的資料
# Modify.........: No:CHI-C20017 12/05/29 By jinjj 若g_bgjob='Y'時使用彙總訊息方式呈現
# Modify.........: No.FUN-CB0096 13/01/10 by zhangweib 增加log檔記錄程序運行過程
# Modify.........: No.FUN-D60110 13/08/26 by yangtt 憑證編號開窗可多選
# Modify.........: No:dengsy160322 16/03/22 By dengsy 1.輸入時,傳票編號不允許打*號
#                                                  2.拋轉還原時多控卡不允許刪除不同來源碼的傳票
 
DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE g_wc,g_sql       string                     #No.FUN-580092 HCN
DEFINE g_dbs_gl 	LIKE type_file.chr21       #No.FUN-680107 VARCHAR(21)
DEFINE p_plant          LIKE nmz_file.nmz02p       #No.FUN-680107 VARCHAR(12)
DEFINE p_acc            LIKE aaa_file.aaa01        #No.FUN-670039
DEFINE p_acc2           LIKE aaa_file.aaa01        #No.FUN-670039 #No.FUN-680034
DEFINE gl_date		LIKE type_file.dat         #No.FUN-680107 DATE
DEFINE gl_yy,gl_mm	LIKE type_file.num5        #No.FUN-680107 SMALLINT
DEFINE g_existno	LIKE npp_file.nppglno	   #No.FUN-550057
DEFINE g_existno2	LIKE npp_file.nppglno	   #No.FUN-680034
DEFINE g_str 		LIKE type_file.chr3        #No.FUN-680107 VARCHAR(3)
DEFINE g_mxno		LIKE type_file.chr8        #No.FUN-680107 VARCHAR(8)
DEFINE g_aaz84          LIKE aaz_file.aaz84        #還原方式 1.刪除 2.作廢 no.4868
DEFINE p_row,p_col      LIKE type_file.num5        #No.FUN-680107 SMALLINT
DEFINE g_change_lang    LIKE type_file.chr1        #是否有做語言切換 No.FUN-570127 #No.FUN-680107 VARCHAR(1)
DEFINE g_cnt            LIKE type_file.num10       #No.FUN-680107 INTEGER
DEFINE g_msg            LIKE type_file.chr1000     #No.FUN-680107 VARCHAR(72)
DEFINE g_flag           LIKE type_file.chr1        #No.FUN-680107 VARCHAR(1)
#No.FUN-CB0096 ---start--- Add
DEFINE g_id     LIKE azu_file.azu00
DEFINE l_id     STRING
DEFINE l_time   LIKE type_file.chr8
#No.FUN-CB0096 ---end  --- Add
#No.FUN-D60110 ---Add--- Start
DEFINE g_existno_str     STRING
DEFINE bst base.StringTokenizer
DEFINE temptext STRING
DEFINE l_errno LIKE type_file.num10
DEFINE g_existno1_str STRING
DEFINE tm   RECORD
            wc1         STRING
            END RECORD
#No.FUN-D60110 ---Add--- End
 
MAIN
#     DEFINEl_time LIKE type_file.chr8               #No.FUN-6A0082
DEFINE l_flag           LIKE type_file.chr1        #No.FUN-570127 #No.FUN-680107 VARCHAR(1)
     OPTIONS
        INPUT NO WRAP
    DEFER INTERRUPT
 
#->No.FUN-570127 --start--
   INITIALIZE g_bgjob_msgfile TO NULL
   LET p_plant   = ARG_VAL(1)           #總帳營運中心編號
   LET p_acc     = ARG_VAL(2)           #總帳帳別編號
   LET g_existno = ARG_VAL(3)           #原總帳傳票編號
   LET g_bgjob   = ARG_VAL(4)           #背景作業
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
#->No.FUN-570127 ---end---
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("ANM")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-690117
   #No.FUN-CB0096 ---start--- Add
    LET l_time = TIME
    LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
    LET l_id = g_plant CLIPPED , g_prog CLIPPED , '100' , g_user CLIPPED , g_today USING 'YYYYMMDD' , l_time
    LET g_sql = "SELECT azu00 + 1 FROM azu_file ",
                " WHERE azu00 LIKE '",l_id,"%' "
    PREPARE aglt110_sel_azu FROM g_sql
    EXECUTE aglt110_sel_azu INTO g_id
    IF cl_null(g_id) THEN
       LET g_id = l_id,'000000'
    ELSE
       LET g_id = g_id + 1
    END IF
    CALL s_log_data('I','100',g_id,'1',l_time,'','')
   #No.FUN-CB0096 ---end  --- Add
 
#NO.FUN-570127 mark-- 
#   OPEN WINDOW p409 AT p_row,p_col WITH FORM "anm/42f/anmp409"
#         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
#   CALL cl_ui_init()
 
#   CALL cl_opmsg('z')
 
#   CALL p409()
 
#   CLOSE WINDOW p409
#NO.FUN-570127 mark--
 
   WHILE TRUE
      CALL s_showmsg_init()   #CHI-C20017 add
      IF g_bgjob = "N" THEN
         CALL p409_ask()
         #FUN-D60110 ---Add--- Start
         IF tm.wc1 = " 1=1" THEN
            CALL cl_err('','9033',0)
            CONTINUE WHILE  
         END IF
         #FUN-D60110 ---Add--- End
         IF cl_sure(18,20) THEN
            LET g_success = 'Y'
            BEGIN WORK
            #FUN-D60110 ---Add--- Start
            CALL p409_existno_chk()
            IF g_success = 'N' THEN 
               CALL s_showmsg()
               CONTINUE WHILE
             END IF
            #FUN-D60110 ---Add--- End
            CALL p409()
            CALL s_showmsg()   #CHI-C20017 add
            IF g_success = 'Y' THEN
               COMMIT WORK
               CALL cl_end2(1) RETURNING l_flag
            ELSE
               ROLLBACK WORK
               CALL cl_end2(2) RETURNING l_flag
            END IF
            IF l_flag THEN
               CONTINUE WHILE
            ELSE
               CLOSE WINDOW p409
               EXIT WHILE
            END IF
         ELSE
            CONTINUE WHILE
         END IF
      ELSE
         LET g_success = 'Y'
         LET tm.wc1 = "g_existno IN ('",g_existno,"')"  #No.FUN-D60110 Add
         CALL p409_existno_chk()                        #No.FUN-D60110 Add
       #No.FUN-D60110 ---Mark--- Start
       # #No.FUN-680034 --Begin
       # IF g_aza.aza63 = 'Y' THEN
       #    SELECT UNIQUE npp07,nppglno INTO p_acc2,g_existno2
       #      FROM npp_file 
       #     WHERE npp01 IN
       #   (SELECT npp01 FROM npp_file 
       #     WHERE npp07 = p_acc AND nppglno = g_existno AND npptype = '0' )
       #       AND npptype = '1'
       #    IF SQLCA.sqlcode THEN
       #       #CALL cl_err3("sel","npp_file","","","axr-800","","",1)   #CHI-C20017 mark
       #       CALL s_errmsg('','','','axr-800',1)   #CHI-C20017 add
       #       LET g_success = 'N'
       #    END IF 
       # END IF
       # #No.FUN-680034 --End
       #No.FUN-D60110 ---Mark--- End
         BEGIN WORK
         CALL p409()
         CALL s_showmsg()   #CHI-C20017 add
         IF g_success = "Y" THEN
            COMMIT WORK
         ELSE
            ROLLBACK WORK
         END IF
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
#->No.FUN-570127 ---end---
     #No.FUN-CB0096 ---start--- add
     #LET l_time = TIME   #No.FUN-D60110 Mark
      LET l_time = l_time + 1 #No.FUN-D60110   Add
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
END MAIN
 
FUNCTION p409()
 
#NO.FUN-570127 mark--
#  WHILE TRUE
      # 得出總帳 database name
      # g_nmz.nmz02p -> g_plant_new -> s_getdbs() -> g_dbs_new --> g_dbs_gl
#       LET g_flag = 'Y'
#       CALL p409_ask()			
#       IF g_flag = 'N' THEN
#          CONTINUE WHILE
#       END IF
#       IF INT_FLAG THEN
#          LET INT_FLAG = 0
#          EXIT WHILE
#       END IF
 
#       IF NOT cl_sure(10,10) THEN
#          EXIT WHILE
#       END IF
#       CALL cl_wait()
#       BEGIN WORK
#      LET p_row = 19 LET p_col = 20
#      OPEN WINDOW p409_t_w9 AT p_row,p_col WITH 3 ROWS, 70 COLUMNS
 
#       LET g_success = 'Y'
#NO.FUN-570127mark---
 
       LET g_plant_new=p_plant
       CALL s_getdbs()
       LET g_dbs_gl=g_dbs_new
 
       #no.4868 (還原方式為刪除/作廢)
       #LET g_sql = "SELECT aaz84 FROM ",g_dbs_gl CLIPPED,"aaz_file",
       LET g_sql = "SELECT aaz84 FROM ",cl_get_target_table(g_plant_new,'aaz_file'), #FUN-A50102
                   " WHERE aaz00 = '0' "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
       PREPARE aaz84_pre FROM g_sql
       IF STATUS THEN
         #str CHI-C20017 mod
          #CALL cl_err('prepare aaz84_pre',STATUS,1)
            #IF g_bgjob = 'Y' THEN   #No.FUN-D60110  Mark
             CALL s_errmsg('','','prepare aaz84_pre',STATUS,1)
         #No.FUN-D60110 ---Mark--- Start
         #ELSE
         #   CALL cl_err('prepare aaz84_pre',STATUS,1)
         #END IF
         #No.FUN-D60110 ---Mark--- End
         #end CHI-C20017 mod
          CLOSE WINDOW p409_t_w9
          LET g_success = 'N'
          #NO.FUN-570127 start--
          IF g_bgjob = 'Y' THEN   
             CALL cl_batch_bg_javamail("N")  
          END IF
          CALL s_showmsg()   #CHI-C20017 add
        #No.FUN-CB0096 ---start--- add
        #LET l_time = TIME   #No.FUN-D60110 Mark
         LET l_time = l_time + 1 #No.FUN-D60110   Add
         LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
         CALL s_log_data('U','100',g_id,'1',l_time,'','')
        #No.FUN-CB0096 ---end  --- add
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
         EXIT PROGRAM
          #NO.FUN-570127 END --
       #   EXIT WHILE
       END IF
       DECLARE aaz84_cs CURSOR FOR aaz84_pre
       IF STATUS THEN
         #str CHI-C20017 mod
          #CALL cl_err('declare aaz84_pre',STATUS,1)
         #IF g_bgjob = 'Y' THEN   #No.FUN-D60110 Mark
             CALL s_errmsg('','','declare aaz84_pre',STATUS,1)
         #No.FUN-D60110 ---Mark--- Start
         #ELSE
         #   CALL cl_err('declare aaz84_pre',STATUS,1)
         #END IF
         #end CHI-C20017 mod
         #No.FUN-D60110 ---Mark--- End
          CLOSE WINDOW p409_t_w9
          LET g_success = 'N'
          #NO.FUN-570127 start--
          IF g_bgjob = 'Y' THEN   
             CALL cl_batch_bg_javamail("N")  
          END IF
          CALL s_showmsg()   #CHI-C20017 add
        #No.FUN-CB0096 ---start--- add
         #LET l_time = TIME   #No.FUN-D60110 Mark
          LET l_time = l_time + 1 #No.FUN-D60110   Add
          LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
          CALL s_log_data('U','100',g_id,'1',l_time,'','')
        #No.FUN-CB0096 ---end  --- add
          CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
          EXIT PROGRAM
          #NO.FUN-570127 END --
          #EXIT WHILE
       END IF
       OPEN aaz84_cs
       IF STATUS THEN
         #str CHI-C20017 mod
          #CALL cl_err('open aaz84',STATUS,1)
         #IF g_bgjob = 'Y' THEN   #No.FUN-D60110 Mark
             CALL s_errmsg('','','open aaz84',STATUS,1)
         #No.FUN-D60110 ---Mark--- Start
         #ELSE
         #   CALL cl_err('open aaz84',STATUS,1)
         #END IF
         #end CHI-C20017 mod
         #No.FUN-D60110 ---Mark--- End
          CLOSE WINDOW p409_t_w9
          LET g_success = 'N'
          #NO.FUN-570127 start--
          IF g_bgjob = 'Y' THEN   
             CALL cl_batch_bg_javamail("N")  
          END IF
          CALL s_showmsg()   #CHI-C20017 add
         #No.FUN-CB0096 ---start--- add
         #LET l_time = TIME   #No.FUN-D60110 Mark
          LET l_time = l_time + 1 #No.FUN-D60110   Add
          LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
          CALL s_log_data('U','100',g_id,'1',l_time,'','')
         #No.FUN-CB0096 ---end  --- add
          CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
          EXIT PROGRAM
          #NO.FUN-570127 END --
          #EXIT WHILE
       END IF
       FETCH aaz84_cs INTO g_aaz84
       IF STATUS THEN
         #str CHI-C20017 mod
          #CALL cl_err('fetch aaz84',STATUS,1)
         #IF g_bgjob = 'Y' THEN    #No.FUN-D60110   Mark
             CALL s_errmsg('','','fetch aaz84',STATUS,1)
         #No.FUN-D60110 ---Mark--- Start
         #ELSE
         #   CALL cl_err('fetch aaz84',STATUS,1)
         #END IF
         #end CHI-C20017 mod
         #No.FUN-D60110 ---Mark--- End
          CLOSE WINDOW p409_t_w9
          LET g_success = 'N'
          #NO.FUN-570127 start--
          IF g_bgjob = 'Y' THEN   
             CALL cl_batch_bg_javamail("N")  
          END IF
          CALL s_showmsg()   #CHI-C20017 add
        #No.FUN-CB0096 ---start--- add
        #LET l_time = TIME   #No.FUN-D60110 Mark
         LET l_time = l_time + 1 #No.FUN-D60110   Add
         LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
         CALL s_log_data('U','100',g_id,'1',l_time,'','')
        #No.FUN-CB0096 ---end  --- add
          CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
          EXIT PROGRAM
          #NO.FUN-570127 END --
          #EXIT WHILE
       END IF
       #no.4868(end)
 
       CALL p409_t()
       #No.FUN-680034 --Begn
       IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
          CALL p409_t_1()
       END IF 
       #No.FUN-680034 --End
 
#NO.FUN-570127 mark--
#      IF g_success = 'Y' THEN
#         COMMIT WORK
#         CALL cl_end2(1) RETURNING g_flag        #批次作業正確結束
#      ELSE
#         ROLLBACK WORK
#         CALL cl_end2(2) RETURNING g_flag        #批次作業失敗
#      END IF
#      IF g_flag THEN
#         CONTINUE WHILE
#      ELSE
#         EXIT WHILE
#      END IF
#    END WHILE
#NO.FUN-570127 mark--
    ERROR ""
#   CLOSE WINDOW p409_t_w9
END FUNCTION
 
FUNCTION p409_ask()
   DEFINE   l_abapost,l_flag   LIKE type_file.chr1    #No.FUN-680107 VARCHAR(1)
   DEFINE   l_aba19            LIKE aba_file.aba19
   DEFINE   l_abaacti          LIKE aba_file.aba19
   DEFINE   l_aba00            LIKE aba_file.aba00
   DEFINE   l_aaa07            LIKE aaa_file.aaa07
   DEFINE   l_cnt              LIKE type_file.num5    #TQC-620099  #No.FUN-680107 SMALLINT
   DEFINE   l_cnt18            LIKE type_file.num5    #MOD-AA0163
   DEFINE   lc_cmd             LIKE type_file.chr1000 #No.FUN-680107 VARCHAR(500)     #No.FUN-570127
   DEFINE   li_chk_bookno      LIKE type_file.num5    #No.FUN-680107 SMALLINT   #No.FUN-670006
   DEFINE   l_i                LIKE type_file.num5,   #No.FUN-680107 SMALLINT
            l_dbname           LIKE type_file.chr21,  #No.FUN-680107 VARCHAR(21)
            l_ds               LIKE azp_file.azp01,
            l_sql              STRING                 #No.FUN-670006  -add 
   DEFINE   l_npp07            LIKE npp_file.npp07    #No.FUN-680034
   DEFINE   l_nppglno          LIKE npp_file.nppglno  #No.FUN-680034
   DEFINE   l_aba20            LIKE aba_file.aba20    #CHI-A20014 add
   DEFINE   l_npp00            LIKE npp_file.npp00    #CHI-A40016 add
   DEFINE   l_aba01            LIKE aba_file.aba01    #CHI-A40016 add

#->No.FUN-570127 --start--
   OPEN WINDOW p409 AT p_row,p_col WITH FORM "anm/42f/anmp409"
        ATTRIBUTE (STYLE = g_win_style)
 
   CALL cl_ui_init()
   #No.FUN-680034 --Begin
   CALL cl_set_comp_visible("g_existno2,p_acc2",g_aza.aza63='Y')
   #No.FUN-680034 --End
   CALL cl_opmsg('z')
#->No.FUN-570127 ---end---
 
   LET p_plant = g_nmz.nmz02p
   LET p_acc   = g_nmz.nmz02b
   LET p_acc2  = g_nmz.nmz02c    #No.FUN-680034
   LET g_existno = NULL
   LET g_existno2= NULL          #No.FUN-680034
   LET g_bgjob = 'N '            #NO.FUN-570127 
   DISPLAY NULL TO FORMONLY.g_existno1  #No.FUN-D60110 Add
   WHILE TRUE                    #NO.FUN-570127
   DIALOG ATTRIBUTES(UNBUFFERED)  #No.FUN-D60110 Add
   #INPUT BY NAME p_plant,p_acc,g_existno WITHOUT DEFAULTS
  #INPUT BY NAME p_plant,p_acc,g_existno,p_acc2,g_existno2,g_bgjob WITHOUT DEFAULTS  #NO.FUN-570127 #No.FUN-680034   #No.FUN_D60110   Mark
   INPUT BY NAME p_plant,p_acc,p_acc2 ATTRIBUTE(WITHOUT DEFAULTS=TRUE)     #No.FUN-D60110 Add
 
#No.FUN-550057--begin
   BEFORE INPUT
   CALL cl_set_docno_format("g_existno")
   CALL cl_set_docno_format("g_existno2")      #No.FUN-680034
#No.FUN-550057--end
      AFTER FIELD p_plant
         IF NOT cl_null(p_plant) THEN
            #FUN-990031--mod--str--    營運中心要控制在當前法人下
            #SELECT azp01 FROM azp_file WHERE azp01 = p_plant
            #IF STATUS <> 0 THEN
            #   NEXT FIELD p_plant
            #END IF
            SELECT * FROM azw_file WHERE azw01 = p_plant AND azw02 = g_legal                                                        
            IF STATUS THEN                                                                                                          
               CALL cl_err3("sel","azw_file",p_plant,"","agl-171","","",1)                                                          
               NEXT FIELD p_plant                                                                                                   
            END IF                                                                                                                  
            #FUN-990031--mod--end 
 
            #modi by canny(980714)
            LET g_plant_new=p_plant
            CALL s_getdbs()
            LET g_dbs_gl=g_dbs_new
            #end modi by
         END IF
 
      AFTER FIELD p_acc
         IF NOT cl_null(p_acc) THEN
            LET g_nmz.nmz02b = p_acc
## No:2551 modify 1998/10/19 ---------------------
            #No.FUN-670006--begin
             CALL s_check_bookno(p_acc,g_user,p_plant) 
                  RETURNING li_chk_bookno
             IF (NOT li_chk_bookno) THEN
                  NEXT FIELD p_acc
             END IF 
             LET g_plant_new= p_plant  #工廠編號
                 CALL s_getdbs()
                 LET l_sql = "SELECT COUNT(*)",
                             #"  FROM ",g_dbs_new CLIPPED,"aaa_file ",
                             "  FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102
                             " WHERE aaa01 = '",p_acc,"' ",
                             "   AND aaaacti IN ('Y','y') "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
                 PREPARE p409_pre2 FROM l_sql
                 DECLARE p409_cur2 CURSOR FOR p409_pre2
                 OPEN p409_cur2
                 FETCH p409_cur2 INTO g_cnt
#           SELECT COUNT(*) INTO g_cnt FROM aaa_file WHERE aaa01=p_acc
            #No.FUN-670006--end 
            IF g_cnt=0 THEN
               CALL cl_err('sel aaa',100,0)
               NEXT FIELD p_acc
            END IF
            #No.FUN-680034--begin
            IF NOT cl_null(p_acc2) AND g_aza.aza63 = 'Y' THEN  #No.MOD-740189
               LET g_nmz.nmz02c = p_acc2                                                                                               
               CALL s_check_bookno(p_acc2,g_user,p_plant)                                                                             
                    RETURNING li_chk_bookno                                                                                           
               IF (NOT li_chk_bookno) THEN                                                                                            
                    NEXT FIELD p_acc
               END IF                                                                                                                 
               LET g_plant_new= p_plant  #工廠編號                                                                                    
               CALL s_getdbs()                                                                                                    
               LET l_sql = "SELECT COUNT(*)",                                                                                     
                           #"  FROM ",g_dbs_new CLIPPED,"aaa_file ",   
                           "  FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102                         
                           " WHERE aaa01 = '",p_acc2,"' ",                                                                        
                           "   AND aaaacti IN ('Y','y') "
 	           CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
               CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
               PREPARE p409_pre22 FROM l_sql                                                                                      
               DECLARE p409_cur22 CURSOR FOR p409_pre22                                                                           
               OPEN p409_cur22                                                                                                    
               FETCH p409_cur22 INTO g_cnt                                                                                        
               IF g_cnt=0 THEN                                                                                                         
                  CALL cl_err('sel aaa',100,0)                                                                                         
                  NEXT FIELD p_acc
               END IF                                                                                                                  
#           ELSE                        #No.MOD-740189
#              NEXT FIELD p_acc         #No.MOD-740189
            END IF
            #No.FUN-680034 --End
         END IF
## -----------------------------------------------
     #No.FUN-D60110 ---Mark--- Start
#     AFTER FIELD g_existno
#        IF NOT cl_null(g_existno) THEN
#           #-----TQC-620099---------
#           LET l_cnt = 0
#           SELECT COUNT(*) INTO l_cnt FROM npp_file
#             WHERE nppglno = g_existno AND
#                   npp00 IN ('4','5','8','9','10','11','12','24')   #MOD-630059 #MOD-AB0110
#           IF l_cnt > 0 THEN
#              CALL cl_err('','anm-061',0)
#              NEXT FIELD g_existno
#           END IF
#           #-----END TQC-620099-----

#          #CHI-A40016 add --start--
#           LET l_cnt18 = 0                                                      #MOD-AA0163
#          #SELECT npp00 INTO l_npp00 FROM npp_file             #MOD-A80132 mark
#          #SELECT DISTINCT npp00 INTO l_npp00 FROM npp_file    #MOD-A80132      #MOD-AA0163 mark
#           SELECT COUNT(*) INTO l_cnt18 FROM npp_file                           #MOD-AA0163
#             WHERE nppglno = g_existno
#               AND npptype = '0'                               #MOD-A80132
#               AND npp00 = '18'                                                 #MOD-AA0163 
#           IF STATUS THEN
#              CALL cl_err('sel npp:',STATUS,0)
#              NEXT FIELD g_existno
#           END IF
#          #CHI-A40016 add --end--

#          #CHI-A40016 mod --start--
#           #LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20 ",    #CHI-A20014 add aba20
#           #          " FROM ",g_dbs_gl CLIPPED,"aba_file",
#           #          " WHERE aba01 = ? AND aba00 = ? AND aba06='NM'"
#          #IF l_npp00 = '18' AND g_nmz.nmz52 = 'Y' THEN    #MOD-AA0163 mark
#           IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN       #MOD-AA0163
#             LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ",    #CHI-A20014 add aba20
#                       #" FROM ",g_dbs_gl CLIPPED,"aba_file",
#                       " FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
#                       " WHERE aba01 = ? AND aba00 = ? AND aba06='AC'"
#           ELSE
#             LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ",    #CHI-A20014 add aba20
#                       #" FROM ",g_dbs_gl CLIPPED,"aba_file",
#                       " FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
#                       " WHERE aba01 = ? AND aba00 = ? AND aba06='NM'"
#           END IF
#          #CHI-A40016 mod --end--

#	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#           PREPARE p409_t_p1 FROM g_sql
#           DECLARE p409_t_c1 CURSOR FOR p409_t_p1
#           IF STATUS THEN
#              CALL cl_err('decl aba_cursor:',STATUS,0)
#              NEXT FIELD g_existno
#           END IF
#           OPEN p409_t_c1 USING g_existno,g_nmz.nmz02b
#           FETCH p409_t_c1 INTO l_aba00,gl_date,gl_yy,gl_mm,l_abapost,l_aba19,
#                                l_abaacti,l_aba20,l_aba01 #no.7378    #CHI-A20014 add l_aba20 #CHI-A40016 add l_aba01
#           IF STATUS THEN
#              CALL cl_err('sel aba:',STATUS,0)
#              NEXT FIELD g_existno
#           END IF

#           #CHI-A40016 add --start--
#          #IF l_npp00 = '18' AND g_nmz.nmz52 = 'Y' THEN    #MOD-AA0163 mark
#           IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN       #MOD-AA0163
#             LET l_cnt = 0
#             SELECT COUNT(*) INTO l_cnt FROM aba_file
#               WHERE aba07 = l_aba01
#                 AND aba06 = 'RA'
#             IF l_cnt > 0 THEN
#                CALL cl_err('','axm-898',0)
#                NEXT FIELD g_existno
#             END IF
#           END IF
#           #CHI-A40016 add --end--

#           #no.7378
#           IF l_abaacti = 'N' THEN
#              CALL cl_err('','mfg8001',1)
#              NEXT FIELD g_existno
#           END IF
#          #CHI-A20014---add---start---
#           IF l_aba20 MATCHES '[Ss1]' THEN
#              CALL cl_err('','mfg3557',0)
#              NEXT FIELD g_existno
#           END IF
#          #CHI-A20014---add---end---
#           #no.7378(end)
#           IF NOT cl_null(l_aba00) THEN
#No.FUN-670060 --Begin
#           FOR l_i = 1 TO length(g_dbs_gl)
#               IF g_dbs_gl[l_i,l_i] matches "[:.]" THEN 
#                  EXIT FOR
#               END IF
#           END FOR
#           LET l_dbname = g_dbs_gl[1,l_i-1]
#           SELECT azp01 INTO l_ds FROM azp_file  WHERE azp03 = l_dbname
#No.FUN-670060 --End
#           #No.FUN-670006--begin
#            CALL s_check_bookno(l_aba00,g_user,l_ds)       #No.FUN-670060
#            CALL s_check_bookno(l_aba00,g_user,p_plant)    #No.FUN-670060
#                 RETURNING li_chk_bookno
#            IF (NOT li_chk_bookno) THEN
#                 NEXT FIELD p_bookno
#            END IF 
#            #No.FUN-670006--end
#           END IF 
#          #---增加判斷會計帳別之關帳日期
#           #LET g_sql="SELECT aaa07 FROM ",g_dbs_gl CLIPPED,"aaa_file"," WHERE aaa01='",l_aba00,"'"
#           LET g_sql="SELECT aaa07 FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102
#                     " WHERE aaa01='",l_aba00,"'"
#	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#           PREPARE p409_x_gl_p1 FROM g_sql
#           DECLARE p409_c_gl_p1 CURSOR FOR p409_x_gl_p1
#           OPEN p409_c_gl_p1
#           FETCH p409_c_gl_p1 INTO l_aaa07
#           IF gl_date <= l_aaa07 THEN
#              CALL cl_err(gl_date,'agl-200',0)
#              NEXT FIELD g_existno
#           END IF
#          #------ end -------------------
#         #FUN-B50090 add begin-------------------------
#         #重新抓取關帳日期
#            LET g_sql ="SELECT nmz10 FROM nmz_file ",
#                       " WHERE nmz00 = '0'"
#            PREPARE nmz10_p FROM g_sql
#            EXECUTE nmz10_p INTO g_nmz.nmz10
#         #FUN-B50090 add -end--------------------------
#            IF gl_date < g_sma.sma53 THEN
#            IF gl_date < g_nmz.nmz10 THEN  #MOD-570223
#              CALL cl_err(gl_date,'aap-027',0)
#              NEXT FIELD g_existno
#           END IF
#           IF l_aba19 ='Y' THEN
#              CALL cl_err(gl_date,'aap-026',0)
#              NEXT FIELD g_existno
#           END IF
#           IF l_abapost = 'Y' THEN
#              CALL cl_err(g_existno,'aap-130',0)
#              NEXT FIELD g_existno
#           END IF
#          #No.B003 010413 by plum
#          #No.FUN-680034 --Begin
#          IF g_aza.aza63 = 'Y' THEN
#             SELECT UNIQUE npp07,nppglno INTO l_npp07,l_nppglno 
#               FROM npp_file 
#              WHERE npp01 IN
#            (SELECT npp01 FROM npp_file 
#              WHERE npp07 = p_acc AND nppglno = g_existno AND npptype = '0' )
#                AND npptype = '1'
#             IF SQLCA.sqlcode THEN
#                CALL cl_err3("sel","npp_file","","","axr-800","","",1)
#                NEXT FIELD g_existno
#             END IF 
#             LET g_nmz.nmz02c = l_npp07
#             DISPLAY l_npp07 TO FORMONLY.p_acc2
#             DISPLAY l_nppglno TO FORMONLY.g_existno2
#             LET p_acc2 = l_npp07
#             LET g_existno2 = l_nppglno
#          END IF
#          IF NOT cl_null(g_existno2) AND g_aza.aza63 = 'Y' THEN  #No.MOD-740189
#             LET l_cnt = 0
#             SELECT COUNT(*) INTO l_cnt FROM npp_file
#              WHERE nppglno = g_existno2 AND
#                    npp00 IN ('4','5','8','9','10','11','12')
#             IF l_cnt > 0 THEN
#                CALL cl_err('','anm-061',0)
#                NEXT FIELD g_existno
#             END IF

#            #CHI-A40016 add --start--
#             LET l_cnt18 = 0                                                      #MOD-AA0163
#            #SELECT npp00 INTO l_npp00 FROM npp_file             #MOD-A80132 mark
#            #SELECT DISTINCT npp00 INTO l_npp00 FROM npp_file    #MOD-A80132      #MOD-AA0163 mark
#             SELECT COUNT(*) INTO l_cnt18 FROM npp_file                           #MOD-AA0163
#               WHERE nppglno = g_existno2
#                 AND npptype = '1'                               #MOD-A80132
#                 AND npp00 = '18'                                                 #MOD-AA0163 
#             IF STATUS THEN
#                CALL cl_err('sel npp:',STATUS,0)
#                NEXT FIELD g_existno
#             END IF
#            #CHI-A40016 add --end--

#            #CHI-A40016 mod --start--
#             #LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20 ",    #CHI-A20014 add aba20
#             #          " FROM ",g_dbs_gl CLIPPED,"aba_file",
#             #          " WHERE aba01 = ? AND aba00 = ? AND aba06='NM'"
#            #IF l_npp00 = '18' AND g_nmz.nmz52 = 'Y' THEN    #MOD-AA0163 mark
#             IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN       #MOD-AA0163
#               LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ",    #CHI-A20014 add aba20
#                         #" FROM ",g_dbs_gl CLIPPED,"aba_file",
#                         " FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
#                         " WHERE aba01 = ? AND aba00 = ? AND aba06='AC'"
#             ELSE 
#               LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ",    #CHI-A20014 add aba20
#                         #" FROM ",g_dbs_gl CLIPPED,"aba_file",
#                         " FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
#                         " WHERE aba01 = ? AND aba00 = ? AND aba06='NM'"
#             END IF
#            #CHI-A40016 mod --end--
#	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#             PREPARE p409_t_p12 FROM g_sql
#             DECLARE p409_t_c12 CURSOR FOR p409_t_p12
#             IF STATUS THEN
#                CALL cl_err('decl aba_cursor:',STATUS,0)
#                NEXT FIELD g_existno
#             END IF
#             OPEN p409_t_c12 USING g_existno2,g_nmz.nmz02c
#             FETCH p409_t_c12 INTO l_aba00,gl_date,gl_yy,gl_mm,l_abapost,l_aba19,
#                                   l_abaacti,l_aba20,l_aba01   #CHI-A20014 add l_aba20 #CHI-A40016 add l_aba01
#             IF STATUS THEN
#                CALL cl_err('sel aba:',STATUS,0)
#                NEXT FIELD g_existn
#             END IF

#             #CHI-A40016 add --start--
#            #IF l_npp00 = '18' AND g_nmz.nmz52 = 'Y' THEN    #MOD-AA0163 mark
#             IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN       #MOD-AA0163
#               LET l_cnt = 0
#               SELECT COUNT(*) INTO l_cnt FROM aba_file
#                 WHERE aba07 = l_aba01
#                   AND aba06 = 'RA'
#               IF l_cnt > 0 THEN
#                  CALL cl_err('','axm-898',0)
#                  NEXT FIELD g_existno
#               END IF
#            END IF
#            #CHI-A40016 add --end--

#             IF l_abaacti = 'N' THEN
#                CALL cl_err('','mfg8003',1)
#                NEXT FIELD g_existno
#             END IF
#            #CHI-A20014---add---start---
#             IF l_aba20 MATCHES '[Ss1]' THEN
#                CALL cl_err('','mfg3557',0)
#                NEXT FIELD g_existno
#             END IF
#            #CHI-A20014---add---end---
#             IF NOT cl_null(l_aba00) THEN
#                CALL s_check_bookno(l_aba00,g_user,p_plant)
#                   RETURNING li_chk_bookno
#                IF (NOT li_chk_bookno) THEN
#                   NEXT FIELD p_bookno
#                END IF 
#             END IF 
#             #---增加判斷會計帳別之關帳日期
#             #LET g_sql="SELECT aaa07 FROM ",g_dbs_gl CLIPPED,"aaa_file"," WHERE aaa01='",l_aba00,"'"
#             LET g_sql="SELECT aaa07 FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102
#                       " WHERE aaa01='",l_aba00,"'"
#	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#             PREPARE p409_x_gl_p12 FROM g_sql
#             DECLARE p409_c_gl_p12 CURSOR FOR p409_x_gl_p12
#             OPEN p409_c_gl_p12
#             FETCH p409_c_gl_p12 INTO l_aaa07
#             IF gl_date <= l_aaa07 THEN
#                CALL cl_err(gl_date,'agl-200',0)
#                NEXT FIELD g_existno
#             END IF
#             #------ end -------------------
#         #FUN-B50090 add begin-------------------------
#         #重新抓取關帳日期
#             LET g_sql ="SELECT nmz10 FROM nmz_file ",
#                        " WHERE nmz00 = '0'"
#             PREPARE nmz10_p1 FROM g_sql
#             EXECUTE nmz10_p1 INTO g_nmz.nmz10
#         #FUN-B50090 add -end--------------------------
#             IF gl_date < g_nmz.nmz10 THEN  #MOD-570223
#                CALL cl_err(gl_date,'aap-027',0)
#                NEXT FIELD g_existno
#             END IF
#             IF l_aba19 ='Y' THEN
#                CALL cl_err(gl_date,'aap-026',0)
#                NEXT FIELD g_existno
#             END IF
#             IF l_abapost = 'Y' THEN
#                CALL cl_err(g_existno2,'aap-132',0)
#                NEXT FIELD g_existno
#             END IF
#           ELSE                    #No.MOD-740189
#             NEXT FIELD g_existno  #No.MOD-740189
#          END IF
#          #No.FUN-680034 --End
#        END IF
        #No.FUN-D60110 ---Mark--- Start

      ON ACTION CONTROLP   #No.FUN-D60110   Add
 
      AFTER INPUT
        IF INT_FLAG THEN
            #EXIT INPUT     #No.FUN-D60110   Mark
            EXIT DIALOG     #No.FUN-D60110 Add
        END IF
        # 得出總帳 database name
        # g_apz.apz02p -> g_plant_new -> s_getdbs() -> g_dbs_new --> g_dbs_gl
        LET g_plant_new= p_plant  # 工廠編號
        CALL s_getdbs()
        LET g_dbs_gl=g_dbs_new    # 得資料庫名稱
        #No.B003...end
 
        #No.FUN-580031 --start--
            CALL cl_qbe_init()
        #No.FUN-580031 ---end---
#    #No.FUN-D60110 ---Mark--- Start
#     ON ACTION CONTROLR
#        CALL cl_show_req_fields()
#
#     ON ACTION CONTROLG
#        CALL cl_cmdask()
#
#     ON ACTION locale                    #genero
#NO.FUN-570127 mark
#         LET g_action_choice = "locale"
#          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
#NO.FUN-570127 mark
#       LET g_change_lang = TRUE
#       EXIT INPUT
#
#     ON IDLE g_idle_seconds
#        CALL cl_on_idle()
#        CONTINUE INPUT
#
#     ON ACTION about         #MOD-4C0121
#        CALL cl_about()      #MOD-4C0121
#
#     ON ACTION help          #MOD-4C0121
#        CALL cl_show_help()  #MOD-4C0121
#
#
#     ON ACTION exit  #加離開功能genero
#        LET INT_FLAG = 1
#        EXIT INPUT
#
#        #No.FUN-580031 --start--
#        ON ACTION qbe_select
#           CALL cl_qbe_select()
#        #No.FUN-580031 ---end---
#
#        #No.FUN-580031 --start--
#        ON ACTION qbe_save
#           CALL cl_qbe_save()
#        #No.FUN-580031 ---end---
#     #No.FUN-D60110 ---Mark--- End
 
   END INPUT

   #FUN-D60110 ---Add--- Start
   CONSTRUCT BY NAME  tm.wc1 ON g_existno
      BEFORE CONSTRUCT
        CALL cl_qbe_init()

   AFTER FIELD g_existno
      IF tm.wc1 = " 1=1" THEN 
         CALL cl_err('','9033',0)
         NEXT FIELD g_existno 
      END IF
    #dengsy160322---add---str--
      IF GET_FLDBUF(g_existno) = "*" THEN
         CALL cl_err('','9034',0)
         NEXT FIELD g_existno
      END IF
     #dengsy160322---add---end--  
      CALL p409_existno_chk() 
      IF g_success = 'N' THEN 
         CALL s_showmsg()
         NEXT FIELD g_existno
      END IF 

      ON ACTION CONTROLP
         CASE 
            WHEN INFIELD(g_existno)
              LET g_existno_str = ''
              CALL q_aba01_1( TRUE, TRUE, p_plant,p_acc,' ','NM')
              RETURNING g_existno_str   
              DISPLAY g_existno_str TO g_existno
              NEXT FIELD g_existno
         END CASE

   END CONSTRUCT

   INPUT BY NAME g_bgjob ATTRIBUTE(WITHOUT DEFAULTS=TRUE)

   END INPUT 
   
   ON ACTION CONTROLR
         CALL cl_show_req_fields()
      ON ACTION CONTROLG
         CALL cl_cmdask()
      ON ACTION locale
         LET g_change_lang = TRUE
      ON ACTION exit 
         LET INT_FLAG = 1
         EXIT DIALOG    
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG  
 
      ON ACTION about         
         CALL cl_about()     
 
      ON ACTION help         
         CALL cl_show_help() 
  
      ON ACTION ACCEPT
         #dengsy160322---add---str--
         IF GET_FLDBUF(g_existno) = "*" THEN
            CALL cl_err('','9034',0)
            NEXT FIELD g_existno
         END IF
         #dengsy160322---add---end-- 
         EXIT DIALOG        
       
      ON ACTION CANCEL
         LET INT_FLAG=1
         EXIT DIALOG 
 
      ON ACTION qbe_select
         CALL cl_qbe_select()
 
      ON ACTION qbe_save
         CALL cl_qbe_save()
   END DIALOG 
   #FUN-D60110 ---Add--- End
  
#NO.FUN-570127 start---
#   IF g_action_choice = "locale" THEN  #genero
#      LET g_action_choice = ""
#      CALL cl_dynamic_locale()
#      LET g_flag = 'N'
#   END IF
   IF g_change_lang THEN
      LET g_change_lang = FALSE
      CALL cl_dynamic_locale()
      CONTINUE WHILE
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p409
     #No.FUN-CB0096 ---start--- add

     #LET l_time = TIME   #No.FUN-D60110 Mark
      LET l_time = l_time + 1 #No.FUN-D60110   Add
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
      EXIT PROGRAM
   END IF
   IF g_bgjob = "Y" THEN
      SELECT zz08 INTO lc_cmd FROM zz_file
       WHERE zz01 = "anmp409"
      IF SQLCA.sqlcode OR lc_cmd IS NULL THEN
          CALL cl_err('anmp409','9031',1)   
      ELSE
         LET lc_cmd = lc_cmd CLIPPED,
                      " '",p_plant CLIPPED,"'",
                      " '",p_acc CLIPPED,"'",
                      " '",g_existno CLIPPED,"'",
                      " '",g_bgjob CLIPPED,"'"
         CALL cl_cmdat('anmp409',g_time,lc_cmd CLIPPED)
      END IF
      CLOSE WINDOW p409
     #No.FUN-CB0096 ---start--- add
     #LET l_time = TIME   #No.FUN-D60110 Mark
      LET l_time = l_time + 1 #No.FUN-D60110   Add
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
      EXIT PROGRAM
   END IF
   EXIT WHILE
END WHILE
#->No.FUN-570127 ---end---
END FUNCTION
 
FUNCTION p409_t()
DEFINE n1,n2,n3,n4,n5,n6,n7,n8,n9 LIKE type_file.num10    #No.FUN-680107 INTEGER    #No:8582
DEFINE n10,n11,n12,n13,n14,n15    LIKE type_file.num10    #No.FUN-680107 INTEGER    #No:8582 #No:9028
DEFINE n16,n17                    LIKE type_file.num10    #No.FUN-680107 INTEGER    #No.FUN-590111
DEFINE l_nppsys                   LIKE npp_file.nppsys
DEFINE l_npp00                    LIKE npp_file.npp00
DEFINE l_aba01  LIKE aba_file.aba01 
DEFINE i            LIKE type_file.num5
DEFINE l_tc_agl03   LIKE tc_agl_file.tc_agl03
DEFINE l_date       LIKE type_file.dat
DEFINE l_time       LIKE type_file.chr10
DEFINE l_user       LIKE type_file.chr10
DEFINE l_sql        STRING
DEFINE l_cnt        LIKE type_file.num5 
DEFINE l_success_status   LIKE type_file.chr1


   IF g_aaz84 = '2' THEN   #還原方式為作廢 #no.4868

  #FUN-D60110 ---Add--- Start
   LET tm.wc1 = cl_replace_str(tm.wc1,"nppglno","aba01")
  #FUN-D60110 ---Add--- End
   
   #LET g_sql="UPDATE ",g_dbs_gl CLIPPED," aba_file  SET abaacti = 'N' ",
   LET g_sql="UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
             "   SET abaacti = 'N' ",
                #" WHERE aba01 = ? AND aba00 = ? "     #No.FUN-D60110   Mark
                " WHERE  aba00 = ? ",                  #No.FUN-D60110 Add
                "   AND ",tm.wc1                       #No.FUN-D60110 Add
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
   PREPARE p409_updaba_p FROM g_sql
  #EXECUTE p409_updaba_p USING g_existno,g_nmz.nmz02b   #No.FUN-D60110   Mark
   EXECUTE p409_updaba_p USING g_nmz.nmz02b              #No.FUN-D60110 Add
   IF SQLCA.sqlcode THEN
     #str CHI-C20017 mod
      #CALL cl_err('(upd abaacti)',SQLCA.sqlcode,1) LET g_success = 'N' RETURN
      LET g_success = 'N'
     #IF g_bgjob = 'Y' THEN  #No.FUN-D60110   Mark
      CALL s_errmsg('','','(upd abaacti)',SQLCA.sqlcode,1)
     #No.FUN-D60110 ---Mark--- Start
     #ELSE
     #   CALL cl_err('(upd abaacti)',SQLCA.sqlcode,1)
     #   RETURN
     #END IF
     #CHI-C20017--add--end
     #No.FUN-D60110 ---Mark--- End
   END IF
ELSE
   IF g_bgjob = 'N' THEN  #NO.FUN-570127 
       DISPLAY "Delete GL's Voucher body!" AT 1,1 #-------------------------
   END IF

      #FUN-D60110 ---Add--- Start
         LET tm.wc1 = cl_replace_str(tm.wc1,"nppglno","abb01")
      #FUN-D60110 ---Add--- End
   
   #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"abb_file WHERE abb01=? AND abb00=?"
   LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'abb_file'), #FUN-A50102
                #" WHERE abb01=? AND abb00=?"    #No.FUN-D60110   Mark
                " WHERE  abb00 = ? ",            #No.FUN-D60110 Add
                "   AND ",tm.wc1                 #No.FUN-D60110 Add
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
   PREPARE p409_2_p3 FROM g_sql
   #EXECUTE p409_2_p3 USING g_existno,g_nmz.nmz02b    #No.FUN-D60110   Mark
   EXECUTE p409_2_p3 USING g_nmz.nmz02b               #No.FUN-D60110 Add
   IF SQLCA.sqlcode THEN
     #str CHI-C20017 mod
      #CALL cl_err('(del abb)',SQLCA.sqlcode,1) LET g_success = 'N' RETURN
      LET g_success = 'N'
     #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
         CALL s_errmsg('','','(del abb)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del abb)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #CHI-C20017--add--end
        #No.FUN-D60110 ---Mark--- End
   END IF
   IF g_bgjob = 'N' THEN  #NO.FUN-570127 
       DISPLAY "Delete GL's Voucher head!" AT 1,1 #-------------------------
   END IF
   #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"aba_file WHERE aba01=? AND aba00=?"
   LET tm.wc1 = cl_replace_str(tm.wc1,"abb01","aba01")     #No.FUN-D60110 Add
   LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                #" WHERE aba01=? AND aba00=?"    #No.FUN-D60110   Mark
                " WHERE  aba00 = ? ",            #No.FUN-D60110 Add
                "   AND ",tm.wc1                 #No.FUN-D60110 Add
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
   PREPARE p409_2_p4 FROM g_sql
      #EXECUTE p409_2_p4 USING g_existno,g_nmz.nmz02b    #No.FUN-D60110   Mark
#      EXECUTE p409_2_p4 USING g_nmz.nmz02b    #mark by jixf 20150326           #No.FUN-D60110 Add
   IF SQLCA.sqlcode THEN
     #str CHI-C20017 mod
      #CALL cl_err('(del aba)',SQLCA.sqlcode,1) LET g_success = 'N' RETURN
#      LET g_success = 'N'    #mark by jixf 20150326
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
#            CALL s_errmsg('','','(del aba)',SQLCA.sqlcode,1)   #mark by jixf 20150326
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del aba)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #CHI-C20017--add--end
        #No.FUN-D60110 ---Mark--- End
   END IF
   IF SQLCA.sqlerrd[3] = 0 THEN
     #str CHI-C20017 mod
      #CALL cl_err('(del aba)','aap-161',1) LET g_success = 'N' RETURN
#      LET g_success = 'N'  #mark by jixf 20150326
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
#         CALL s_errmsg('','','(del aba)','aap-161',1)   #mark by jixf 20150326
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del aba)','aap-161',1)
        #   RETURN
        #END IF
        #CHI-C20017--add--end
        #No.FUN-D60110 ---Mark--- Start
   END IF
   #str----add by jixf 20140924
      LET l_sql="SELECT aba01 FROM aba_file WHERE ",tm.wc1,""
      PREPARE l_pre2 FROM l_sql
      DECLARE l_cur2 CURSOR FOR l_pre2
      LET l_aba01=''
      FOREACH l_cur2 INTO l_aba01
         IF g_success='Y' THEN
            LET l_tc_agl03=''
            SELECT tc_agl03 INTO l_tc_agl03 FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02b AND tc_agl01=l_aba01 AND tc_agl02='INS'
            IF l_tc_agl03 = 'Y' THEN 
               DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02b AND tc_agl01=l_aba01 AND tc_agl03='N'
               INSERT INTO tc_agl_file VALUES (g_nmz.nmz02b,l_aba01,'DEL','N','','','','','',0,0)
               CALL del_aba(l_aba01,'DEL',g_nmz.nmz02b) RETURNING l_success_status
               IF l_success_status = 'N' THEN 
                  LET g_success = 'N'
               END IF
               IF l_success_status = 'Y' THEN 
                  DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02b AND tc_agl01=l_aba01
               END IF 
            END IF 
            IF l_tc_agl03 = 'N' THEN 
               DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02b AND tc_agl01=l_aba01
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  LET l_success_status='N'
                  LET g_success = 'N'
               ELSE  
                  LET l_success_status='Y'
               END IF 
            END IF 
         END IF    
      END FOREACH 
      EXECUTE p409_2_p4 USING g_nmz.nmz02b
      IF SQLCA.sqlcode THEN
         LET l_success_status='N'
         CALL s_errmsg('','','(del aba)',SQLCA.SQLCODE,1)
      END IF 
      IF SQLCA.sqlerrd[3] = 0 THEN
         LET l_success_status='N'
         CALL s_errmsg('','','(del aba)',SQLCA.SQLCODE,1)
      END IF 
#      IF l_success_status = 'Y' THEN 
#         COMMIT WORK 
#      END IF     
      IF l_success_status = 'N' OR g_success = 'N' THEN 
         ROLLBACK WORK 
      END IF
   #end----add by jixf 20140924
   IF g_bgjob = 'N' THEN  #NO.FUN-570127 
       DISPLAY "Delete GL's Voucher desp!" AT 1,1 #-------------------------
   END IF
   #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"abc_file WHERE abc01=? AND abc00=?"

   LET tm.wc1 = cl_replace_str(tm.wc1,"aba01","abc01")     #No.FUN-D60110 Add

   LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'abc_file'), #FUN-A50102
                #" WHERE abc01=? AND abc00=?"    #No.FUN-D60110   Mark
                " WHERE  abc00=?",               #No.FUN-D60110 Add
                "   AND ",tm.wc1                 #No.FUN-D60110 Add
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
   PREPARE p409_2_p5 FROM g_sql
      #EXECUTE p409_2_p5 USING g_existno,g_nmz.nmz02b   #No.FUN-D60110   Mark
      EXECUTE p409_2_p5 USING g_nmz.nmz02b              #No.FUN-D60110 Add
   IF SQLCA.sqlcode THEN
     #str CHI-C20017 mod
      #CALL cl_err('(del abc)',SQLCA.sqlcode,1) LET g_success = 'N' RETURN
      LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
         CALL s_errmsg('','','(del abc)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del abc)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        ##CHI-C20017--add--end
        #No.FUN-D60110 ---Mark--- End
   END IF
#FUN-B40056 --begin
   LET tm.wc1 = cl_replace_str(tm.wc1,"abc01","tic04")     #No.FUN-D60110 Add
   LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'tic_file'), 
                #" WHERE tic04 =? AND tic00 =?"  #No.FUN-D60110   Mark
                " WHERE  tic00 =?",              #No.FUN-D60110 Add
                "   AND ",tm.wc1                 #No.FUN-D60110 Add
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql     
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
   PREPARE p409_2_p8 FROM g_sql
     #EXECUTE p409_2_p8 USING g_existno,g_nmz.nmz02b   #No.FUN-D60110   Mark 
      EXECUTE p409_2_p8 USING g_nmz.nmz02b              #No.FUN-D60110 Add
   IF SQLCA.sqlcode THEN
     #str CHI-C20017 mod
      #CALL cl_err('(del tic)',SQLCA.sqlcode,1) LET g_success = 'N' RETURN
      LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
            CALL s_errmsg('','','(del tic)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del tic)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        ##CHI-C20017--add--end
        #No.FUN-D60110 ---Mark--- End
   END IF
#FUN-B40056 --end
END IF
#  CALL s_abhmod(g_dbs_gl,g_nmz.nmz02b,g_existno)   #MOD-590081   #CHI-780008 #FUN-980020 mark
   CALL s_abhmod(p_plant,g_nmz.nmz02b,g_existno)    #FUN-980020
   IF g_success = 'N' THEN RETURN END IF
        LET g_msg = TIME
        INSERT INTO azo_file (azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)          #FUN-980005 add plant & legal 
                       VALUES('anmp409',g_user,g_today,g_msg,g_existno,'delete',g_plant,g_legal)
   #----------------------------------------------------------------------
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE npl_file SET npl09=NULL WHERE npl09=g_existno
           IF g_aaz.aaz84 = '2' THEN
              LET tm.wc1 = cl_replace_str(tm.wc1,"aba01","npl09")
           ELSE
              LET tm.wc1 = cl_replace_str(tm.wc1,"tic04","npl09")
           END IF
           LET g_sql ="UPDATE npl_file SET npl09=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p1 FROM g_sql
           EXECUTE p409_p1
          #No.FUN-D60110 ---Mod--- Start
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd npl09)',STATUS,1) #LET g_success='N' RETURN #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","npl_file",g_existno,"",STATUS,"","(upd npl09)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110  Mark
                 CALL s_errmsg('','','(upd npl09)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","npl_file",g_existno,"",STATUS,"","(upd npl09)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n1=SQLCA.SQLERRD[3]
 
           #-----CHI-810018---------
           UPDATE apa_file SET apa44=NULL WHERE apa44=g_existno
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE apa_file SET apa44=NULL WHERE apa44=g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"npl09","apa44")
           LET g_sql ="UPDATE apa_file SET apa44=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p2 FROM g_sql
           EXECUTE p409_p2
          #No.FUN-D60110 ---Mod--- Start
           IF STATUS THEN
             #str CHI-C20017 mod
              #CALL cl_err3("upd","apa_file",g_existno,"",STATUS,"","(upd apa44)",1) 
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd apa44)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","apa_file",g_existno,"",STATUS,"","(upd apa44)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           #-----END CHI-810018-----
 
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE npn_file SET npn09=NULL WHERE npn09=g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"apa44","npn09")
           LET g_sql ="UPDATE npn_file SET npn09=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p3 FROM g_sql
           EXECUTE p409_p3
          #No.FUN-D60110 ---Mod--- 
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd npn09)',STATUS,1) #LET g_success='N' RETURN #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","npn_file",g_existno,"",STATUS,"","(upd npn09)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN    #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd npn09)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","npn_file",g_existno,"",STATUS,"","(upd npn09)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n2=SQLCA.SQLERRD[3]
 
           #-----CHI-810019---------
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE oma_file SET oma33=NULL WHERE oma33=g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"npn09","oma33")
           LET g_sql ="UPDATE oma_file SET oma33=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p4 FROM g_sql
           EXECUTE p409_p4
          #No.FUN-D60110 ---Mod--- 
           IF STATUS THEN
             #str CHI-C20017 mod
              #CALL cl_err3("upd","oma_file",g_existno,"",STATUS,"","(upd oma33)",1) 
             #IF g_bgjob = 'Y' THEN    #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd oma33)',STATUS,1)
            #No.FUN-D60110 ---Mark--- STart
            # ELSE
            #    CALL cl_err3("upd","oma_file",g_existno,"",STATUS,"","(upd oma33)",1)
            # END IF
            ##end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
           END IF
           #-----END CHI-810019-----

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nmg_file SET nmg13=NULL,nmg14=NULL WHERE nmg13=g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"oma33","nmg13")
           LET g_sql ="UPDATE nmg_file SET nmg13=NULL,nmg14=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p5 FROM g_sql
           EXECUTE p409_p5
          #No.FUN-D60110 ---Mod--- 
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nmg13)',STATUS,1) #LET g_success='N' RETURN #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nmg_file",g_existno,"",STATUS,"","(upd nmg13)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nmg13)',STATUS,1)
            #No.FUN-D60110 ---Mark--- Start
            # ELSE
            #    CALL cl_err3("upd","nmg_file",g_existno,"",STATUS,"","(upd nmg13)",1)
            # END IF
             #end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
           END IF
           LET n3=SQLCA.SQLERRD[3]
 
           #-------------- NO:0121   modify in 99/05/11 ---------------------#
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nni_file SET nniglno=NULL WHERE nniglno=g_existno   #還息
           LET tm.wc1 = cl_replace_str(tm.wc1,"nmg13","nniglno")
           LET g_sql ="UPDATE nni_file SET nniglno=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p6 FROM g_sql
           EXECUTE p409_p6
          #No.FUN-D60110 ---Mod--- 
           
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nniglno)',STATUS,1)   #No.FUN-660148
              #CALL cl_err3("upd","nni_file",g_existno,"",STATUS,"","(upd nniglno)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nniglno)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nni_file",g_existno,"",STATUS,"","(upd nniglno)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n4=SQLCA.SQLERRD[3]

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nnk_file SET nnkglno=NULL WHERE nnkglno=g_existno   #還本
           LET tm.wc1 = cl_replace_str(tm.wc1,"nniglno","nnkglno")
           LET g_sql ="UPDATE nnk_file SET nnkglno=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p7 FROM g_sql
           EXECUTE p409_p7
          #No.FUN-D60110 ---Mod---
          IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nnkglno)',STATUS,1) #LET g_success='N' RETURN   #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nnk_file",g_existno,"",STATUS,"","(upd nnkglno)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110 Mark
               CALL s_errmsg('','','(upd nnkglno)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nnk_file",g_existno,"",STATUS,"","(upd nnkglno)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- 
           END IF
           LET n5=SQLCA.SQLERRD[3]
           #-----------------------------------------------------------------#
           #No.+093 010427 by plum add
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nmh_file SET nmh33=NULL,nmh34=NULL WHERE nmh33=g_existno   #收票anmt200
           LET tm.wc1 = cl_replace_str(tm.wc1,"nnkglno","nmh33")
           LET g_sql ="UPDATE nmh_file SET nmh33=NULL,nmh34=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p8 FROM g_sql
           EXECUTE p409_p8
          #No.FUN-D60110 ---Mod---
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nmh33)',STATUS,1) #LET g_success='N' RETURN   #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nmh_file",g_existno,"",STATUS,"","(upd nmh33)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nmh33)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nmh_file",g_existno,"",STATUS,"","(upd nmh33)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n6=SQLCA.SQLERRD[3]
           #No.+093 ..end
           #no.7277
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nne_file SET nneglno=NULL WHERE nneglno=g_existno  #短期融資
           LET tm.wc1 = cl_replace_str(tm.wc1,"nmh33","nneglno")
           LET g_sql ="UPDATE nne_file SET nneglno=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p9 FROM g_sql
           EXECUTE p409_p9
          #No.FUN-D60110 ---Mod---
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nneglno)',STATUS,1) #LET g_success='N' RETURN   #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nne_file",g_existno,"",STATUS,"","(upd nneglno)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nneglno)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nne_file",g_existno,"",STATUS,"","(upd nneglno)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n7=SQLCA.SQLERRD[3]

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nng_file SET nngglno=NULL WHERE nngglno=g_existno  #中長貸
           LET tm.wc1 = cl_replace_str(tm.wc1,"nneglno","nngglno")
           LET g_sql ="UPDATE nng_file SET nngglno=NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p10 FROM g_sql
           EXECUTE p409_p10
          #No.FUN-D60110 ---Mod---
           IF STATUS THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nngglno)',STATUS,1) #LET g_success='N' RETURN  #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nng_file",g_existno,"",STATUS,"","(upd nngglno)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nngglno)',STATUS,1)
            #No.FUN-D60110 ---Mark--- Start
            # ELSE
            #    CALL cl_err3("upd","nng_file",g_existno,"",STATUS,"","(upd nngglno)",1)
            # END IF
            ##end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
           END IF
           LET n8=SQLCA.SQLERRD[3]
           #no.7277(end)

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nme_file SET nme10 = NULL WHERE nme10 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nngglno","nme10")
           LET g_sql ="UPDATE nme_file SET nme10 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p11 FROM g_sql
           EXECUTE p409_p11
          #No.FUN-D60110 ---Mod---
           IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#             CALL cl_err('(upd nme10)',STATUS,1) #LET g_success='N' RETURN  #No:8582   #No.FUN-660148
              #CALL cl_err3("upd","nme_file",g_existno,"",STATUS,"","(upd nme10)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nme10)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nme_file",g_existno,"",STATUS,"","(upd nme10)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
           END IF
           LET n10=SQLCA.SQLERRD[3]    #No:8582

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nmi_file SET nmi10 = NULL,nmi11 = NULL WHERE nmi10 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nme10","nmi10")
           LET g_sql ="UPDATE nmi_file SET nmi10 = NULL,nmi11 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p12 FROM g_sql
           EXECUTE p409_p12
          #No.FUN-D60110 ---Mod---
          IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd nmi10)',STATUS,1) #LET g_success='N' RETURN #No:8582   #No.FUN-660148
             #CALL cl_err3("upd","nmi_file",g_existno,"",STATUS,"","(upd nmi10)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN    #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nmi10)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nmi_file",g_existno,"",STATUS,"","(upd nmi10)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
          END IF
          LET n11=SQLCA.SQLERRD[3]       #No:8582

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nmf_file SET nmf11 = NULL,nmf13 = NULL WHERE nmf11 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nmi10","nmf11")
           LET g_sql ="UPDATE nmf_file SET nmf11 = NULL,nmf13 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p13 FROM g_sql
           EXECUTE p409_p13
          #No.FUN-D60110 ---Mod---
          IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd nmf11)',STATUS,1) #LET g_success='N' RETURN #No:8582   #No.FUN-660148
             #CALL cl_err3("upd","nmf_file",g_existno,"",STATUS,"","(upd nmf11)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN    #No.FUN-D60110 Mark
                 CALL s_errmsg('','','(upd nmf11)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","nmf_file",g_existno,"",STATUS,"","(upd nmf11)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
          END IF
          LET n12=SQLCA.SQLERRD[3]       #No:8582

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE nmd_file SET nmd27 = NULL WHERE nmd27 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nmf11","nmd27")
           LET g_sql ="UPDATE nmd_file SET nmd27 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p14 FROM g_sql
           EXECUTE p409_p14
          #No.FUN-D60110 ---Mod---
          IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd nmd27)',STATUS,1)   #No.FUN-660148
             #CALL cl_err3("upd","nmd_file",g_existno,"",STATUS,"","(upd nmd27)",1) #No.FUN-660148
          #  LET g_success='N' RETURN    #no.TQC-750211 mark
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd nmd27)',STATUS,1)
            #No.FUN-D60110 ---Mark--- Start
            # ELSE
            #    CALL cl_err3("upd","nmd_file",g_existno,"",STATUS,"","(upd nmd27)",1)
            # END IF
             #end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
          END IF
          LET n13=SQLCA.SQLERRD[3]       #No:8582

          #No.FUN-D60110 ---Mod--- Start
          #No:9028
          #UPDATE nnm_file SET nnmglno = NULL WHERE nnmglno=g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nmd27","nnmglno")
           LET g_sql ="UPDATE nnm_file SET nnmglno = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p15 FROM g_sql
           EXECUTE p409_p15
          #No.FUN-D60110 ---Mod---
          LET n15=SQLCA.SQLERRD[3]
 
          #-----No.FUN-590111-----
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE gsh_file SET gsh21 = NULL,gsh22 = NULL WHERE gsh21 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"nnmglno","gsh21")
           LET g_sql ="UPDATE gsh_file SET gsh21 = NULL,gsh22 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p16 FROM g_sql
           EXECUTE p409_p16
          #No.FUN-D60110 ---Mod---
          IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd gsh21)',STATUS,1)   #No.FUN-660148
             #CALL cl_err3("upd","gsh_file",g_existno,"",STATUS,"","(upd gsh21)",1) #No.FUN-660148
            #LET g_success='N' RETURN   #No.TQC-750211 mark
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd gsh21)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","gsh_file",g_existno,"",STATUS,"","(upd gsh21)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- End
          END IF
          LET n16=SQLCA.SQLERRD[3]

          #No.FUN-D60110 ---Mod--- Start
          #UPDATE gse_file SET gse21 = NULL,gse22 = NULL WHERE gse21 = g_existno
           LET tm.wc1 = cl_replace_str(tm.wc1,"gsh21","gse21")
           LET g_sql ="UPDATE gse_file SET gse21 = NULL,gse22 = NULL WHERE ",tm.wc1 CLIPPED
           PREPARE p409_p17 FROM g_sql
           EXECUTE p409_p17
          #No.FUN-D60110 ---Mod---
          IF SQLCA.sqlcode  THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd gse21)',STATUS,1)   #No.FUN-660148
             #CALL cl_err3("upd","gse_file",g_existno,"",STATUS,"","(upd gse21)",1) #No.FUN-660148
            #LET g_success='N' RETURN     #No.TQC-750211
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd gse21)',STATUS,1)
             #No.FUN-D60110 ---Mark--- Start
             #ELSE
             #   CALL cl_err3("upd","gse_file",g_existno,"",STATUS,"","(upd gse21)",1)
             #END IF
             #end CHI-C20017 mod
             #No.FUN-D60110 ---Mark--- Start
          END IF
          LET n17=SQLCA.SQLERRD[3]
          #-----No.FUN-590111 END-----
 
          #----------------------------------------------------------------------
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE npp_file SET npp03=NULL,
          #                    nppglno=NULL,
          #                    npp06=NULL,
          #                    npp07=NULL
          # WHERE nppglno=g_existno
          #   AND npptype = '0'            #No.FUN-680034
          #   AND npp07 = g_nmz.nmz02b     #No.FUN-680034
           LET tm.wc1 = cl_replace_str(tm.wc1,"gse21","nppglno")
           LET g_sql ="UPDATE npp_file SET npp03=NULL, nppglno=NULL,npp06=NULL,npp07=NULL ",
                      " WHERE ",tm.wc1 CLIPPED,
                      "   AND npptype = '0'",
                      "AND npp07 = '",g_nmz.nmz02b,"'"
           PREPARE p409_p18 FROM g_sql
           EXECUTE p409_p18
          #No.FUN-D60110 ---Mod---
          IF STATUS OR SQLCA.sqlerrd[3]=0 THEN
             #str CHI-C20017 mod
#            CALL cl_err('(upd npp03)',STATUS,1) #LET g_success='N' RETURN#No:8582   #No.FUN-660148
             #CALL cl_err3("upd","npp_file",g_existno,"",STATUS,"","(upd npp03)",1) #No.FUN-660148
             #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                 CALL s_errmsg('','','(upd npp03)',STATUS,1)
            #No.FUN-D60110 ---Mark--- Start
            # ELSE
            #    CALL cl_err3("upd","npp_file",g_existno,"",STATUS,"","(upd npp03)",1)
            # END IF
             #end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
          END IF
          LET n14=SQLCA.SQLERRD[3]       #No:8582
          #No8582
          IF n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15 = 0 THEN
             #str CHI-C20017 mod
             #CALL cl_err('upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
             #LET g_success='N' RETURN
             LET g_success='N'
            #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
                CALL s_errmsg('','','upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
            #No.FUN-D60110 ---Mark--- Start
            #ELSE
            #   CALL cl_err('upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
            #   RETURN
            #END IF
            #end CHI-C20017 mod
            #No.FUN-D60110 ---Mark--- End
          END IF
  #No.FUN-CB0096 ---start--- Add
  #LET l_time = TIME   #No.FUN-D60110 Mark
   LET l_time = l_time + 1 #No.FUN-D60110   Add
   LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
   CALL s_log_data('I','114',g_id,'2',l_time,g_existno,'')
  #No.FUN-CB0096 ---end  --- Add
END FUNCTION
 
#No.FUN-680034 --Begin
FUNCTION p409_t_1()
   DEFINE n1,n2,n3,n4,n5,n6,n7,n8,n9 LIKE type_file.num10    #No.FUN-680107 INTEGER #No:8582
   DEFINE n10,n11,n12,n13,n14,n15    LIKE type_file.num10    #No.FUN-680107 INTEGER #No:8582 #No:9028
   DEFINE n16,n17                    LIKE type_file.num10    #No.FUN-680107 INTEGER #No.FUN-590111
   DEFINE l_nppsys                   LIKE npp_file.nppsys
   DEFINE l_npp00                    LIKE npp_file.npp00
   DEFINE l_aba01   LIKE aba_file.aba01 
  DEFINE i            LIKE type_file.num5
  DEFINE l_tc_agl03   LIKE tc_agl_file.tc_agl03
  DEFINE l_date       LIKE type_file.dat
  DEFINE l_time       LIKE type_file.chr10
  DEFINE l_user       LIKE type_file.chr10
  DEFINE l_sql        STRING
  DEFINE l_cnt        LIKE type_file.num5 
  DEFINE l_success_status   LIKE type_file.chr1

   IF g_aaz84 = '2' THEN   #還原方式為作廢 #no.4868
      LET tm.wc1 = cl_replace_str(g_existno1_str,"g_existno","aba01")          #No.FUN-D60110   Add
      #LET g_sql="UPDATE ",g_dbs_gl CLIPPED," aba_file  SET abaacti = 'N' ",
      LET g_sql="UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                "   SET abaacti = 'N' ",
               #" WHERE aba01 = ? AND aba00 = ? "        #No.FUN-D60110   Mark
                " WHERE  aba00 = ? ",                     #No.FUN-D60110   Add
                "   AND ",tm.wc1                          #No.FUN-D60110   Add  
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p409_updaba_p2 FROM g_sql
     #EXECUTE p409_updaba_p2 USING g_existno2,g_nmz.nmz02c   #No.FUN-D60110   Mark
      EXECUTE p409_updaba_p2 USING g_nmz.nmz02c   #No.FUN-D60110   Add
      IF SQLCA.sqlcode THEN
        #str CHI-C20017 mod
         #CALL cl_err('(upd abaacti)',SQLCA.sqlcode,1) 
         #LET g_success = 'N' 
         #RETURN
         LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
            CALL s_errmsg('','','(upd abaacti)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(upd abaacti)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
   ELSE
      IF g_bgjob = 'N' THEN  #NO.FUN-570127 
         DISPLAY "Delete GL's Voucher body!" AT 1,1 #-------------------------
      END IF
      LET tm.wc1 = cl_replace_str(g_existno1_str,"g_existno","abb01")          #No.FUN-D60110   Add
      #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"abb_file WHERE abb01=? AND abb00=?"
      LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'abb_file'), #FUN-A50102
               #" WHERE abb01=? AND abb00=?"     #No.FUN-D60110   Mark 
                " WHERE abb00=?",                #No.FUN-D60110   Add  
                "   AND ",tm.wc1                  #No.FUN-D60110   Add   
 	   CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p409_2_p32 FROM g_sql
     #EXECUTE p409_2_p32 USING g_existno2,g_nmz.nmz02c   #No.FUN-D60110   Add
      EXECUTE p409_2_p32 USING g_nmz.nmz02c    #No.FUN-D60110   Add
      IF SQLCA.sqlcode THEN
        #str CHI-C20017 mod
         #CALL cl_err('(del abb)',SQLCA.sqlcode,1) 
         #LET g_success = 'N' 
         #RETURN
         LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN    #No.FUN-D60110   Mark
            CALL s_errmsg('','','(del abb)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del abb)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
      IF g_bgjob = 'N' THEN  #NO.FUN-570127 
         DISPLAY "Delete GL's Voucher head!" AT 1,1 #-------------------------
      END IF
      #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"aba_file WHERE aba01=? AND aba00=?"
      LET tm.wc1 = cl_replace_str(tm.wc1,"abb01","aba01")          #No.FUN-D60110   Add
      LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
               #" WHERE aba01=? AND aba00=?"     #No.FUN-D60110 Mark
                " WHERE aba00=?",               #No.FUN-D60110   Mark
                "   AND ",tm.wc1                 #No.FUN-D60110   Add 
 	   CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p409_2_p42 FROM g_sql
     #EXECUTE p409_2_p42 USING g_existno2,g_nmz.nmz02c   #No.FUN-D60110   Mark
#      EXECUTE p409_2_p42 USING g_nmz.nmz02c   #No.FUN-D60110   Add  #mark by jixf 20150326
      IF SQLCA.sqlcode THEN
        #str CHI-C20017 mod
         #CALL cl_err('(del aba)',SQLCA.sqlcode,1) 
         #LET g_success = 'N'
         #RETURN
#         LET g_success = 'N'   #mark by jixf 20150326
        #IF g_bgjob = 'Y' THEN #No.FUN-D60110   Mark
#            CALL s_errmsg('','','(del aba)',SQLCA.sqlcode,1)  #mark by jixf 20150326
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del aba)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
      IF SQLCA.sqlerrd[3] = 0 THEN
        #str CHI-C20017 mod
         #CALL cl_err('(del aba)','aap-161',1) 
         #LET g_success = 'N' 
         #RETURN
#         LET g_success = 'N'   #mark by jixf 20150326
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
#            CALL s_errmsg('','','(del aba)','aap-161',1) #mark by jixf 20150326
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del aba)','aap-161',1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
      #str----add by jixf 20140924
      LET l_sql="SELECT aba01 FROM aba_file WHERE ",tm.wc1,""
      PREPARE l_pre1 FROM l_sql
      DECLARE l_cur1 CURSOR FOR l_pre1
      LET l_aba01=''
      FOREACH l_cur1 INTO l_aba01
         IF g_success='Y' THEN
            LET l_tc_agl03=''
            SELECT tc_agl03 INTO l_tc_agl03 FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02c AND tc_agl01=l_aba01 AND tc_agl02='INS'
            IF l_tc_agl03 = 'Y' THEN 
               DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02c AND tc_agl01=l_aba01 AND tc_agl03='N'
               INSERT INTO tc_agl_file VALUES (g_nmz.nmz02c,l_aba01,'DEL','N','','','','','',0,0)
               CALL del_aba(l_aba01,'DEL',g_nmz.nmz02c) RETURNING l_success_status
               IF l_success_status = 'N' THEN 
                  LET g_success = 'N'
               END IF
               IF l_success_status = 'Y' THEN 
                  DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02c AND tc_agl01=l_aba01
               END IF 
            END IF 
            IF l_tc_agl03 = 'N' THEN 
               DELETE FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02c AND tc_agl01=l_aba01
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  LET l_success_status='N'
                  LET g_success = 'N'
               ELSE  
                  LET l_success_status='Y'
               END IF 
            END IF 
         END IF    
      END FOREACH 
      EXECUTE p409_2_p42 USING g_nmz.nmz02c
      IF SQLCA.sqlcode THEN
         LET l_success_status='N'
         CALL s_errmsg('','','(del aba)',SQLCA.SQLCODE,1)
      END IF 
      IF SQLCA.sqlerrd[3] = 0 THEN
         LET l_success_status='N'
         CALL s_errmsg('','','(del aba)',SQLCA.SQLCODE,1)
      END IF 
#      IF l_success_status = 'Y' THEN 
#         COMMIT WORK 
#      END IF     
      IF l_success_status = 'N' OR g_success = 'N' THEN 
         ROLLBACK WORK 
      END IF 
      #end----add by jixf 20140924
      IF g_bgjob = 'N' THEN  #NO.FUN-570127 
         DISPLAY "Delete GL's Voucher desp!" AT 1,1 #-------------------------
      END IF
      #LET g_sql="DELETE FROM ",g_dbs_gl CLIPPED,"abc_file WHERE abc01=? AND abc00=?"
      LET tm.wc1 = cl_replace_str(tm.wc1,"aba01","abc01")   #No.FUN-D60110   Add
      LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'abc_file'), #FUN-A50102
               #" WHERE abc01=? AND abc00=?"    #No.FUN-D60110   Mark
                " WHERE  abc00=?",              #No.FUN-D60110   Add
                "   AND ",tm.wc1                #No.FUN-D60110   Add 
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p409_2_p52 FROM g_sql
     #EXECUTE p409_2_p52 USING g_existno2,g_nmz.nmz02c   #No.FUN-D60110   Mark
      EXECUTE p409_2_p52 USING g_nmz.nmz02c   #No.FUN-D60110   Add
      IF SQLCA.sqlcode THEN
        #str CHI-C20017 mod
         #CALL cl_err('(del abc)',SQLCA.sqlcode,1) 
         #LET g_success = 'N' 
         #RETURN
         LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN   #No.FUN-D60110   Mark
            CALL s_errmsg('','','(del abc)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del abc)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
#FUN-B40056 --begin
      LET tm.wc1 = cl_replace_str(tm.wc1,"abc01","tic04")          #No.FUN-D60110   Add
      LET g_sql="DELETE FROM ",cl_get_target_table(g_plant_new,'tic_file'),
               #" WHERE tic04 =? AND tic00 =?"  #No.FUN-D60110   Mark
                " WHERE tic00 =?",              #No.FUN-D60110   Add
                "   AND ",tm.wc1                #No.FUN-D60110   Add 
 	   CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p409_2_p82 FROM g_sql
     #EXECUTE p409_2_p82 USING g_existno2,g_nmz.nmz02c   #No.FUN-D60110   Mark
      EXECUTE p409_2_p82 USING g_nmz.nmz02c   #No.FUN-D60110   Mark
      IF SQLCA.sqlcode THEN
        #str CHI-C20017 mod
         #CALL cl_err('(del tic)',SQLCA.sqlcode,1) 
         #LET g_success = 'N' 
         #RETURN
         LET g_success = 'N'
        #IF g_bgjob = 'Y' THEN     #No.FUN-D60110   Mark
            CALL s_errmsg('','','(del tic)',SQLCA.sqlcode,1)
        #No.FUN-D60110 ---Mark--- Start
        #ELSE
        #   CALL cl_err('(del tic)',SQLCA.sqlcode,1)
        #   RETURN
        #END IF
        #end CHI-C20017 mod
        #No.FUN-D60110 ---Mark--- End
      END IF
#FUN-B40056 --end
   END IF
#  CALL s_abhmod(g_dbs_gl,g_nmz.nmz02c,g_existno2)   #MOD-590081   #CHI-780008 #FUN-980020 mark
   CALL s_abhmod(p_plant,g_nmz.nmz02c,g_existno2)    #FUN-980020
   IF g_success = 'N' THEN RETURN END IF
      LET g_msg = TIME
      INSERT INTO azo_file (azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)          #FUN-980005 add plant & legal 
                     VALUES('anmp409',g_user,g_today,g_msg,g_existno2,'delete',g_plant,g_legal)
      #----------------------------------------------------------------------
#     UPDATE npl_file SET npl09=NULL WHERE npl09=g_existno2
#     IF STATUS THEN
#        CALL cl_err3("upd","npl_file",g_existno2,"",STATUS,"","(upd npl09)",1) #No.FUN-660148
#     END IF
#     LET n1=SQLCA.SQLERRD[3]
 
#     UPDATE npn_file SET npn09=NULL WHERE npn09=g_existno2
#     IF STATUS THEN
#        CALL cl_err3("upd","npn_file",g_existno2,"",STATUS,"","(upd npn09)",1) #No.FUN-660148
#     END IF
#     LET n2=SQLCA.SQLERRD[3]
 
#     UPDATE nmg_file SET nmg13=NULL,
#                         nmg14=NULL
#      WHERE nmg13=g_existno2
#     IF STATUS THEN
#        CALL cl_err3("upd","nmg_file",g_existno,"",STATUS,"","(upd nmg13)",1) #No.FUN-660148
#     END IF
#     LET n3=SQLCA.SQLERRD[3]
 
#     #-------------- NO:0121   modify in 99/05/11 ---------------------#
#     UPDATE nni_file SET nniglno=NULL
#      WHERE nniglno=g_existno2  #還息
#     IF STATUS THEN
#        CALL cl_err3("upd","nni_file",g_existno,"",STATUS,"","(upd nniglno)",1) #No.FUN-660148
#     END IF
#     LET n4=SQLCA.SQLERRD[3]
 
#     UPDATE nnk_file SET nnkglno=NULL
#      WHERE nnkglno=g_existno2  #還本
#     IF STATUS THEN
#        CALL cl_err3("upd","nnk_file",g_existno,"",STATUS,"","(upd nnkglno)",1) #No.FUN-660148
#     END IF
#     LET n5=SQLCA.SQLERRD[3]
#     #-----------------------------------------------------------------#
#     #No.+093 010427 by plum add
#     UPDATE nmh_file SET nmh33=NULL,
#                         nmh34=NULL
#      WHERE nmh33=g_existno2  #收票anmt200
#     IF STATUS THEN
#        CALL cl_err3("upd","nmh_file",g_existno,"",STATUS,"","(upd nmh33)",1) #No.FUN-660148
#     END IF
#     LET n6=SQLCA.SQLERRD[3]
#     #No.+093 ..end
#     #no.7277
#     UPDATE nne_file SET nneglno=NULL
#      WHERE nneglno=g_existno2 #短期融資
#     IF STATUS THEN
#        CALL cl_err3("upd","nne_file",g_existno,"",STATUS,"","(upd nneglno)",1) #No.FUN-660148
#     END IF
#     LET n7=SQLCA.SQLERRD[3]
 
#     UPDATE nng_file SET nngglno=NULL
#      WHERE nngglno=g_existno2 #中長貸
#     IF STATUS THEN
#        CALL cl_err3("upd","nng_file",g_existno,"",STATUS,"","(upd nngglno)",1) #No.FUN-660148
#     END IF
#     LET n8=SQLCA.SQLERRD[3]
#     #no.7277(end)
 
#     UPDATE nme_file SET nme10 = NULL
#      WHERE nme10 = g_existno2
#     IF SQLCA.sqlcode  THEN
#        CALL cl_err3("upd","nme_file",g_existno,"",STATUS,"","(upd nme10)",1) #No.FUN-660148
#     END IF
#     LET n10=SQLCA.SQLERRD[3]    #No:8582
 
#     UPDATE nmi_file SET nmi10 = NULL,
#                         nmi11 = NULL
#      WHERE nmi10 = g_existno2
#    IF SQLCA.sqlcode  THEN
#       CALL cl_err3("upd","nmi_file",g_existno,"",STATUS,"","(upd nmi10)",1) #No.FUN-660148
#    END IF
#    LET n11=SQLCA.SQLERRD[3]       #No:8582
 
#    UPDATE nmf_file SET nmf11 = NULL,
#                        nmf13 = NULL
#     WHERE nmf11 = g_existno2
#    IF SQLCA.sqlcode  THEN
#       CALL cl_err3("upd","nmf_file",g_existno,"",STATUS,"","(upd nmf11)",1) #No.FUN-660148
#    END IF
#    LET n12=SQLCA.SQLERRD[3]       #No:8582
 
#    UPDATE nmd_file SET nmd27 = NULL
#     WHERE nmd27 = g_existno2
#    IF SQLCA.sqlcode  THEN
#       CALL cl_err3("upd","nmd_file",g_existno,"",STATUS,"","(upd nmd27)",1) #No.FUN-660148
#       LET g_success='N' RETURN
#    END IF
#    LET n13=SQLCA.SQLERRD[3]       #No:8582
 
#    #No:9028
#    UPDATE nnm_file SET nnmglno = NULL
#     WHERE nnmglno=g_existno2
#    LET n15=SQLCA.SQLERRD[3]
 
#    #-----No.FUN-590111-----
#    UPDATE gsh_file SET gsh21 = NULL,
#                        gsh22 = NULL
#     WHERE gsh21 = g_existno2
#    IF SQLCA.sqlcode  THEN
#       CALL cl_err3("upd","gsh_file",g_existno,"",STATUS,"","(upd gsh21)",1) #No.FUN-660148
#       LET g_success='N'
#       RETURN
#    END IF
#    LET n16=SQLCA.SQLERRD[3]
 
#    UPDATE gse_file SET gse21 = NULL,
#                        gse22 = NULL
#     WHERE gse21 = g_existno2
#    IF SQLCA.sqlcode  THEN
#       CALL cl_err3("upd","gse_file",g_existno,"",STATUS,"","(upd gse21)",1) #No.FUN-660148
#       LET g_success='N'
#       RETURN
#    END IF
#    LET n17=SQLCA.SQLERRD[3]
     #-----No.FUN-590111 END-----
 
     #----------------------------------------------------------------------
          #----------------------------------------------------------------------
          #No.FUN-D60110 ---Mod--- Start
          #UPDATE npp_file SET npp03=NULL,
          #                    nppglno=NULL,
          #                    npp06=NULL,
          #                    npp07=NULL
          # WHERE nppglno=g_existno
          #   AND npptype = '1'            #No.FUN-680034
          #   AND npp07 = g_nmz.nmz02c     #No.FUN-680034
           LET tm.wc1 = cl_replace_str(tm.wc1,"tic04","nppglno")
           LET g_sql ="UPDATE npp_file SET npp03=NULL, nppglno=NULL,npp06=NULL,npp07=NULL ",
                      " WHERE ",tm.wc1 CLIPPED,
                      "   AND npptype = '1'",
                      "AND npp07 = '",g_nmz.nmz02c,"'"
           PREPARE p409_p19 FROM g_sql
           EXECUTE p409_p19
          #No.FUN-D60110 ---Mod---
     IF STATUS OR SQLCA.sqlerrd[3]=0 THEN
        #str CHI-C20017 mod
        #CALL cl_err3("upd","npp_file",g_existno2,"",STATUS,"","(upd npp03)",1) #No.FUN-660148

     END IF
     LET n14=SQLCA.SQLERRD[3]       #No:8582
     #No8582
     IF n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15 = 0 THEN
        #str CHI-C20017 mod
        #CALL cl_err('upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
        #LET g_success='N' 
        #RETURN
        LET g_success='N'
       #IF g_bgjob = 'Y' THEN  #No.FUN-D60110   Mark
           CALL s_errmsg('','','upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
       #No.FUN-D60110 ---Mark--- Start
       #ELSE
       #   CALL cl_err('upd npl09/npn09/nmg13/nmnn?glno/nmh33','aap-161',1)
       #   RETURN
       #END IF
       #end CHI-C20017 mod
       #No.FUN-D60110 ---Mark--- End
     END IF
  #No.FUN-CB0096 ---start--- Add
  #LET l_time = TIME   #No.FUN-D60110 Mark
   LET l_time = l_time + 1 #No.FUN-D60110   Add
   LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
   CALL s_log_data('I','114',g_id,'2',l_time,g_existno,'')
  #No.FUN-CB0096 ---end  --- Add
END FUNCTION
#No.FUN-680034 --End
#Patch....NO.TQC-610036 <001> #

#FUN-D60110 ---Add--- Start
FUNCTION p409_existno_chk()  
   DEFINE   l_abapost      LIKE type_file.chr1    
   DEFINE   l_aba19        LIKE aba_file.aba19 
   DEFINE   l_abaacti      LIKE aba_file.abaacti
   DEFINE   l_aba01        LIKE aba_file.aba01 
   DEFINE   l_aba00        LIKE aba_file.aba00 
   DEFINE   l_aaa07        LIKE aaa_file.aaa07 
   DEFINE   l_npp07        LIKE npp_file.npp07     
   DEFINE   l_nppglno      LIKE npp_file.nppglno   
   DEFINE   l_cnt          LIKE type_file.num5     
   DEFINE   l_cnt18        LIKE type_file.num5     
   DEFINE   l_aba20        LIKE aba_file.aba20 
   DEFINE   l_aba06        LIKE aba_file.aba06   #add by dengsy160322   

   CALL s_showmsg_init()
   LET g_existno2 = NULL
   LET g_success = 'Y' 
   LET tm.wc1 = cl_replace_str(tm.wc1,"g_existno","nppglno")
   LET l_cnt = 0
   LET g_sql = "SELECT COUNT(*) FROM npp_file",
               " WHERE ",tm.wc1 CLIPPED,
               "   AND npp00 IN ('4','5','8','9','10','11','12','24')"
   PREPARE p409_chk_p FROM g_sql
   EXECUTE p409_chk_p INTO l_cnt
   IF l_cnt > 0 THEN 
      LET g_success = 'N'
   END IF
   LET l_cnt18 = 0                                           
   LET g_sql = "SELECT COUNT(*) FROM npp_file",  
               " WHERE ",tm.wc1 CLIPPED,
               "   AND npptype = '0'",                       
               "   AND npp00 = '18'"
   PREPARE p409_chk_p1 FROM g_sql
   EXECUTE p409_chk_p1 INTO l_cnt18
   IF STATUS THEN
      LET g_success = 'N'
   END IF
   LET tm.wc1 = cl_replace_str(tm.wc1,"nppglno","aba01")
   IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN     
      LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01,aba06 ",   #add aba06 by dengsy160322
                "  FROM ",cl_get_target_table(g_plant_new,'aba_file'), 
                #" WHERE aba00 = ? AND aba06='AC' AND ",tm.wc1 CLIPPED  #mark by dengsy160322
                " WHERE aba00 = ?  AND ",tm.wc1 CLIPPED   #add by dengsy160322
   ELSE
      LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01,aba06 ",   #add aba06 by dengsy160322  
                "  FROM ",cl_get_target_table(g_plant_new,'aba_file'), 
                #" WHERE aba00 = ? AND aba06='NM' AND ",tm.wc1 CLIPPED   #mark by dengsy160322
                " WHERE aba00 = ?  AND ",tm.wc1 CLIPPED    #add by dengsy160322
   END IF
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql     
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE p409_t_p1 FROM g_sql
   DECLARE p409_t_c1 CURSOR FOR p409_t_p1
   IF STATUS THEN
      CALL s_errmsg('',l_aba01,'',STATUS,1)
      LET g_success = 'N'
   END IF
   OPEN p409_t_c1 USING g_nmz.nmz02b
   FOREACH p409_t_c1 INTO l_aba00,gl_date,gl_yy,gl_mm,l_abapost,l_aba19,
                        l_abaacti,l_aba20,l_aba01,l_aba06    #add l_aba06 by dengsy160322 
      IF STATUS THEN
         CALL s_errmsg('',l_aba01,'',STATUS,1)
         LET g_success = 'N'
      END IF
      IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN     
      LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM aba_file
          WHERE aba07 = l_aba01
            AND aba06 = 'RA'
         IF l_cnt > 0 THEN
            CALL s_errmsg('',l_aba01,'','axm-898',1)
            LET g_success = 'N'
         END IF
      END IF
      IF l_abaacti = 'N' THEN
         CALL s_errmsg('',l_aba01,'','mfg8001',1)
         LET g_success = 'N'
      END IF
      IF l_aba20 MATCHES '[Ss1]' THEN
         CALL s_errmsg('',l_aba01,'','mfg3557',1)
         LET g_success = 'N'
      END IF 
      #dengsy160322---add---str--
      IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN
         IF l_aba06 <> 'AC' THEN
            CALL s_errmsg('sel aba:',l_aba01,'','agl040',1)
            LET g_success = 'N'
         END IF
      ELSE
         IF l_aba06 <> 'NM' THEN
            CALL s_errmsg('sel aba:',l_aba01,'','agl040',1)
            LET g_success = 'N'
         END IF
      END IF
     #dengsy160322---add---end-- 
     #---增加判斷會計帳別之關帳日期
      LET g_sql="SELECT aaa07 FROM ",cl_get_target_table(g_plant_new,'aaa_file'), 
                " WHERE aaa01='",l_aba00,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql     
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
      PREPARE p409_x_gl_p1 FROM g_sql
      DECLARE p409_c_gl_p1 CURSOR FOR p409_x_gl_p1
      OPEN p409_c_gl_p1
      FETCH p409_c_gl_p1 INTO l_aaa07
      IF gl_date <= l_aaa07 THEN
         CALL s_errmsg('',l_aba01,'','agl-200',1)
         LET g_success = 'N'
      END IF
     #重新抓取關帳日期
      LET g_sql ="SELECT nmz10 FROM nmz_file ",
                 " WHERE nmz00 = '0'"
      PREPARE nmz10_p FROM g_sql
      EXECUTE nmz10_p INTO g_nmz.nmz10
      IF gl_date < g_nmz.nmz10 THEN 
         CALL s_errmsg('',l_aba01,'','aap-027',1)
         LET g_success = 'N'
      END IF
      IF l_aba19 ='Y' THEN
         CALL s_errmsg('',l_aba01,'','aap-026',1)
         LET g_success = 'N'
      END IF
      IF l_abapost = 'Y' THEN
         CALL s_errmsg('',l_aba01,'','aap-130',1)
         LET g_success = 'N'
      END IF
   END FOREACH
   LET tm.wc1 = cl_replace_str(tm.wc1,"aba01","nppglno")
   IF g_aza.aza63 = 'Y' THEN
      LET g_sql = "SELECT UNIQUE npp07,nppglno ",
                  "  FROM npp_file",
                  " WHERE npp01 IN (SELECT npp01 FROM npp_file ",
                  "                  WHERE npp07 = '",p_acc,"'",
                  "                    AND npptype = '0' ",
                  "                    AND ",tm.wc1," )", 
                  "   AND npptype = '1'"
      PREPARE p409_chk_p21 FROM g_sql
      DECLARE p409_chk_p2 CURSOR FOR p409_chk_p21
      IF SQLCA.sqlcode THEN
         CALL s_errmsg('','',tm.wc1,'axr-800',1)
         LET g_success = 'N'
      END IF 
      FOREACH p409_chk_p2 INTO l_npp07,l_nppglno
         LET g_nmz.nmz02c = l_npp07
         DISPLAY l_npp07 TO FORMONLY.p_acc2
         DISPLAY l_nppglno TO FORMONLY.g_existno2
         LET p_acc2 = l_npp07
         LET g_existno2 = l_nppglno 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM npp_file
          WHERE nppglno = g_existno2
            AND npp00 IN ('4','5','8','9','10','11','12')
         IF l_cnt > 0 THEN
            CALL s_errmsg('','',tm.wc1,'anm-061',1)
            LET g_success = 'N'
         END IF

         SELECT COUNT(*) INTO l_cnt18 FROM npp_file  
          WHERE nppglno = g_existno2
            AND npptype = '1'                       
            AND npp00 = '18'                         
         IF STATUS THEN
            CALL s_errmsg('',g_existno2,'',STATUS,1)
            LET g_success = 'N'
         END IF
           
         IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN     
            LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ", 
                      " FROM ",cl_get_target_table(g_plant_new,'aba_file'),
                      " WHERE aba01 = ? AND aba00 = ? AND aba06='AC'"
         ELSE 
            LET g_sql="SELECT aba00,aba02,aba03,aba04,abapost,aba19,abaacti,aba20,aba01 ",
                      " FROM ",cl_get_target_table(g_plant_new,'aba_file'), 
                      " WHERE aba01 = ? AND aba00 = ? AND aba06='NM'"
         END IF
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql   
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
         PREPARE p409_t_p12 FROM g_sql
         DECLARE p409_t_c12 CURSOR FOR p409_t_p12
         IF STATUS THEN
            CALL s_errmsg('',g_existno2,'decl aba_cursor:',STATUS,1)
            LET g_success = 'N'
         END IF
         OPEN p409_t_c12 USING g_existno2,g_nmz.nmz02c
         FETCH p409_t_c12 INTO l_aba00,gl_date,gl_yy,gl_mm,l_abapost,l_aba19,
                               l_abaacti,l_aba20,l_aba01 
         IF STATUS THEN
            CALL s_errmsg('',g_existno2,'sel aba:',STATUS,1)
            LET g_success = 'N'
         END IF
           
         IF l_cnt18 > 0 AND g_nmz.nmz52 = 'Y' THEN
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM aba_file
             WHERE aba07 = l_aba01
               AND aba06 = 'RA'
            IF l_cnt > 0 THEN
            CALL s_errmsg('',g_existno2,'','axm-898',1)
               LET g_success = 'N'
            END IF
         END IF

         IF l_abaacti = 'N' THEN
            CALL s_errmsg('',g_existno2,'','mfg8003',1)
            LET g_success = 'N'
         END IF
         IF l_aba20 MATCHES '[Ss1]' THEN
            CALL s_errmsg('',g_existno2,'','mfg3557',1)
            LET g_success = 'N'
         END IF
        #---增加判斷會計帳別之關帳日期
         LET g_sql="SELECT aaa07 FROM ",cl_get_target_table(g_plant_new,'aaa_file'),
                   " WHERE aaa01='",l_aba00,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE p409_x_gl_p12 FROM g_sql
         DECLARE p409_c_gl_p12 CURSOR FOR p409_x_gl_p12
         OPEN p409_c_gl_p12
         FETCH p409_c_gl_p12 INTO l_aaa07
         IF gl_date <= l_aaa07 THEN
            CALL s_errmsg('',g_existno2,gl_date,'agl-200',1)
            LET g_success = 'N'
         END IF
        #重新抓取關帳日期
         LET g_sql ="SELECT nmz10 FROM nmz_file ",
                    " WHERE nmz00 = '0'"
         PREPARE nmz10_p1 FROM g_sql
         EXECUTE nmz10_p1 INTO g_nmz.nmz10
         IF gl_date < g_nmz.nmz10 THEN
            CALL s_errmsg('',g_existno2,gl_date,'agl-027',1)
            LET g_success = 'N'
         END IF
         IF l_aba19 ='Y' THEN
            CALL s_errmsg('',g_existno2,gl_date,'agl-026',1)
            LET g_success = 'N'
         END IF
         IF l_abapost = 'Y' THEN
            CALL s_errmsg('',g_existno2,gl_date,'aap-132',1)
            LET g_success = 'N'
         END IF
         IF cl_null(g_existno1_str) THEN 
            LET g_existno1_str = "'",l_nppglno,"'"
         ELSE
            LET g_existno1_str = g_existno1_str,",'",l_nppglno,"'"
         END IF 
      END FOREACH
   END IF
   LET g_existno2 = ""
   LET g_existno1_str = "g_existno IN (",g_existno1_str,")"
END FUNCTION 
#FUN-D60110 ---Add--- End
