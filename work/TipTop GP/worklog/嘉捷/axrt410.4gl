# Prog. Version..: '5.25.02-11.06.20(00010)'     #
#
# Pattern name...: axrt410.4gl
# Descriptions...: 退款沖帳單維護作業
# Date & Author..: 09/06/23 By dongbg
# Modify.........: No:FUN-960141 09/06/23 By dongbg GP5.2修改:此程序copy axrt400而來
# Modify.........: No:FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: NO:FUN-960140 09/09/07 By lutingting 畫面去除ooa37
# Modify.........: No:FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No:FUN-980020 09/09/10 By douzh GP5.2集團架構sub相關修改
# Modify.........: No:FUN-990031 09/10/26 By lutingting GP5.2營運中心調整，拿掉單身營運中心欄位,因為立帳會丟到dsall所以不需要去不同得營運中心抓資料
# Modify.........: No:MOD-9B0043 09/11/06 By lutingting1, 借方 3待抵應收得時候要可以維護oma00='23'的預收款 
#                                                      2, 只有退款借方才可維護類型轉費用F,貸方不可以
# Modify.........: No:FUN-9B0106 09/11/19 By kevin 用s_dbstring(l_dbs CLIPPED) 判斷跨資料庫
# Modify.........: No:TQC-9C0057 09/12/09 By Carrier 状况码赋值
# Modify.........: No:TQC-9C0179 09/12/29 By tsai_yen EXECUTE裡不可有擷取字串的中括號[]
# Modify.........: No:TQC-9C0190 09/12/30 By Carrier report fail
# Modify.........: No:FUN-9C0168 10/01/04 By lutingting 差異調整為9溢退時會新增一筆溢退得借方帶科目ool33
# Modify.........: No:TQC-A20043 10/02/23 By lutingting 自動產生單身時增加TT得資料 
# Modify.........: No:FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No:FUN-A40001 10/04/01 By lutingting 借方增加類型 A:溢退 F:轉費用  貸方增加類型ACDEQ
# Modify.........: No:FUN-A40054 10/04/22 By shiwuying 已抛转票据不可取消审核
# Modify.........: No:FUN-A50103 10/06/03 By Nicola 訂單多帳期 
# Modify.........: No.FUN-A60056 10/06/30 By lutingting GP5.2財務串前段問題整批調整 
# Modify.........: No.FUN-A40076 10/07/02 By xiaofeizhu ooa37 = 'Y' 改成 ooa37 = '2'
# Modify.........: No.FUN-A50102 10/07/06 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:CHI-A70015 10/07/06 By Nicola 需考慮無訂單出貨
# Modify.........: No.FUN-A90003 10/09/07 by xiaofeizhu 改成雙單身
# Modify.........: No:TQC-A90057 10/09/20 By Carrier q_ooa 加传参
# Modify.........: No:FUN-AB0034 10/12/16 By wujie   oma73/oma73f预设0
# Modify.........: No:TQC-AC0397 10/12/31 By huangtao 借方為待抵賬款時，應該可以錄入27類型的單據
# Modify.........: No:TQC-B10005 11/01/05 By huangtao 借方為待抵賬款時，應該可以錄入26類型的單據
# Modify.........: No:TQC-AC0373 11/01/06 By shiwuying 第一單身字段oob20,oob23,oob17,oob18,oob21無條件隱藏
# Modify.........: No:TQC-B10053 11/01/10 By wuxj 借方<貸方時，選擇溢退的待抵處理方式產生的溢退單據性質改為'14'雜項，單別默認抓取ooz26
# Modify.........: No.FUN-B10053 11/01/20 By yinhy 科目查询自动过滤
# Modify.........: No.MOD-B30240 11/03/12 By lutingting贷方选支票时自动带科目
# Modify.........: No.MOD-B30227 11/03/12 By zhangweib 當選擇"借方" 時，下拉選單排除"支票"和TT"
# Modify.........: No.MOD-B30255 11/03/12 By wuxj      借方是待抵时，不允许修改，科目为noentry
# Modify.........: No.MOD-B30387 11/03/14 By zhangweib axrt410按下修改鍵，帳款客戶欄位顏色不可為"黃色"
# Modify.........: No.MOD-B30389 11/03/14 By lutingting溢退處理時,借方待抵單據若都為24:暫收,則產生的axrt300資料不應含有稅額
# Modify.........: No.MOD-B30388 11/03/14 By zhangweib 修改過會計科目欄位時自動開創的where條件
# Modify.........: NO.FUN-B30166 11/03/29 By zhangweib nme_file add nme27
# Modify.........: No:CHI-B30061 11/04/07 By zhangweib 去掉單身中的借方、貸方欄位，直接給預設值
# Modify.........: No:TQC-B40032 11/04/07 By yinhy 錄入借方資料時參考單號無法自動帶出
# Modify.........: No:FUN-B40056 11/05/12 By guoch 刪除資料時一併刪除tic_file的資料
# Modify.........: No.FUN-B50090 11/05/16 By suncx 財務關帳日期加嚴控管修正
# Modify.........: No.FUN-B50064 11/06/03 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.MOD-B50249 11/06/10 By wujie    点E离开无法退出
# Modify.........: No.110914     11/09/14 By zhangym  维护TT的时候，银行对应的会计科目应该能够自动带出来;无法直接抛转凭证进行修正
# Modify.........: No.140620     14/06/20 By ppan  审核时验证是否超过收支单金额


DATABASE ds
 
#GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"              #modify by zhangym 110914
 
DEFINE g_ooa            RECORD LIKE ooa_file.*,
       g_ooa_t          RECORD LIKE ooa_file.*,
       g_ooa_o          RECORD LIKE ooa_file.*,
       g_artype         LIKE type_file.chr2,               #No.FUN-680123 VARCHAR(2),
       b_oob            RECORD LIKE oob_file.*,
       g_oob            DYNAMIC ARRAY OF RECORD            #程式變數(Program Variables)
                           oob02     LIKE oob_file.oob02,
                           #oob05     LIKE oob_file.oob05,   #No.FUN-690090 add   #FUN-990031 mark
                           oob03     LIKE oob_file.oob03,
                           oob04     LIKE oob_file.oob04,
                           oob04_d   LIKE type_file.chr20,                            #No.FUN-680022 add
                           oob06     LIKE oob_file.oob06,
                           oob19     LIKE oob_file.oob19,   #No.FUN-680022 add
                           oob15     LIKE oob_file.oob15,
                          #FUN-960141 add begin
                           oob20     LIKE oob_file.oob20,
                           oob23     LIKE oob_file.oob23,
                           oob17     LIKE oob_file.oob17,
                           oob18     LIKE oob_file.oob18,
                           oob21     LIKE oob_file.oob21,
                          #FUN-960141 add end
                           oob11     LIKE oob_file.oob11,
                           oob111    LIKE oob_file.oob111,  #No.FUN-670047 add
                           oob13     LIKE oob_file.oob13,
                           oob14     LIKE oob_file.oob14,
                           oob07     LIKE oob_file.oob07,
                           oob08     LIKE oob_file.oob08,
                           oob09     LIKE oob_file.oob09,
                           oob10     LIKE oob_file.oob10,
                           oob12     LIKE oob_file.oob12,
                          #FUN-850038 --start---
                           oobud01   LIKE oob_file.oobud01,
                           oobud02   LIKE oob_file.oobud02,
                           oobud03   LIKE oob_file.oobud03,
                           oobud04   LIKE oob_file.oobud04,
                           oobud05   LIKE oob_file.oobud05,
                           oobud06   LIKE oob_file.oobud06,
                           oobud07   LIKE oob_file.oobud07,
                           oobud08   LIKE oob_file.oobud08,
                           oobud09   LIKE oob_file.oobud09,
                           oobud10   LIKE oob_file.oobud10,
                           oobud11   LIKE oob_file.oobud11,
                           oobud12   LIKE oob_file.oobud12,
                           oobud13   LIKE oob_file.oobud13,
                           oobud14   LIKE oob_file.oobud14,
                           oobud15   LIKE oob_file.oobud15
                          #FUN-850038 --end--
                        END RECORD,
       g_oob_t          RECORD
                           oob02     LIKE oob_file.oob02,
                           #oob05     LIKE oob_file.oob05,   #No.FUN-690090 add  #FUN-990031 MARK
                           oob03     LIKE oob_file.oob03,
                           oob04     LIKE oob_file.oob04,
                          #oob04_d   LIKE oob_file.oob04,  #No.FUN-680123 VARCHAR(10),    #No.FUN-680022 mark
                           oob04_d   LIKE type_file.chr20,                             #No.FUN-680022 add
                           oob06     LIKE oob_file.oob06,
                           oob19     LIKE oob_file.oob19,  #No.FUN-680022 add
                           oob15     LIKE oob_file.oob15,
                          #FUN-960141 add begin
                           oob20     LIKE oob_file.oob20,
                           oob23     LIKE oob_file.oob23,
                           oob17     LIKE oob_file.oob17,
                           oob18     LIKE oob_file.oob18,
                           oob21     LIKE oob_file.oob21,
                          #FUN-960141 add end
                           oob11     LIKE oob_file.oob11,
                           oob111    LIKE oob_file.oob111, #No.FUN-670047 add
                           oob13     LIKE oob_file.oob13,
                           oob14     LIKE oob_file.oob14,
                           oob07     LIKE oob_file.oob07,
                           oob08     LIKE oob_file.oob08,
                           oob09     LIKE oob_file.oob09,
                           oob10     LIKE oob_file.oob10,
                           oob12     LIKE oob_file.oob12,
                          #FUN-850038 --start---
                           oobud01   LIKE oob_file.oobud01,
                           oobud02   LIKE oob_file.oobud02,
                           oobud03   LIKE oob_file.oobud03,
                           oobud04   LIKE oob_file.oobud04,
                           oobud05   LIKE oob_file.oobud05,
                           oobud06   LIKE oob_file.oobud06,
                           oobud07   LIKE oob_file.oobud07,
                           oobud08   LIKE oob_file.oobud08,
                           oobud09   LIKE oob_file.oobud09,
                           oobud10   LIKE oob_file.oobud10,
                           oobud11   LIKE oob_file.oobud11,
                           oobud12   LIKE oob_file.oobud12,
                           oobud13   LIKE oob_file.oobud13,
                           oobud14   LIKE oob_file.oobud14,
                           oobud15   LIKE oob_file.oobud15
                          #FUN-850038 --end--
                        END RECORD,
#FUN-A90003--Add--Begin--#
       g_oob_d          DYNAMIC ARRAY OF RECORD           
                           oob02_1     LIKE oob_file.oob02,
                           oob03_d     LIKE oob_file.oob03,
                           oob04_1     LIKE oob_file.oob04,
                           oob04_1_d   LIKE type_file.chr20,                           
                           oob06_1     LIKE oob_file.oob06,
                           oob19_1     LIKE oob_file.oob19,  
                           oob15_1     LIKE oob_file.oob15,
                           oob20_1     LIKE oob_file.oob20,
                           oob23_1     LIKE oob_file.oob23,
                           oob17_1     LIKE oob_file.oob17,
                           oob18_1     LIKE oob_file.oob18,
                           oob21_1     LIKE oob_file.oob21,
                           oob11_1     LIKE oob_file.oob11,
                           oob111_1    LIKE oob_file.oob111,
                           oob13_1     LIKE oob_file.oob13,
                           oob14_1     LIKE oob_file.oob14,
                           oob07_1     LIKE oob_file.oob07,
                           oob08_1     LIKE oob_file.oob08,
                           oob09_1     LIKE oob_file.oob09,
                           oob10_1     LIKE oob_file.oob10,
                           oob12_1     LIKE oob_file.oob12,
                           oobud01_1   LIKE oob_file.oobud01,
                           oobud02_1   LIKE oob_file.oobud02,
                           oobud03_1   LIKE oob_file.oobud03,
                           oobud04_1   LIKE oob_file.oobud04,
                           oobud05_1   LIKE oob_file.oobud05,
                           oobud06_1   LIKE oob_file.oobud06,
                           oobud07_1   LIKE oob_file.oobud07,
                           oobud08_1   LIKE oob_file.oobud08,
                           oobud09_1   LIKE oob_file.oobud09,
                           oobud10_1   LIKE oob_file.oobud10,
                           oobud11_1   LIKE oob_file.oobud11,
                           oobud12_1   LIKE oob_file.oobud12,
                           oobud13_1   LIKE oob_file.oobud13,
                           oobud14_1   LIKE oob_file.oobud14,
                           oobud15_1   LIKE oob_file.oobud15
                        END RECORD,
       g_oob_d_t        RECORD           
                           oob02_1     LIKE oob_file.oob02,
                           oob03_d     LIKE oob_file.oob03,
                           oob04_1     LIKE oob_file.oob04,
                           oob04_1_d   LIKE type_file.chr20,                           
                           oob06_1     LIKE oob_file.oob06,
                           oob19_1     LIKE oob_file.oob19,  
                           oob15_1     LIKE oob_file.oob15,
                           oob20_1     LIKE oob_file.oob20,
                           oob23_1     LIKE oob_file.oob23,
                           oob17_1     LIKE oob_file.oob17,
                           oob18_1     LIKE oob_file.oob18,
                           oob21_1     LIKE oob_file.oob21,
                           oob11_1     LIKE oob_file.oob11,
                           oob111_1    LIKE oob_file.oob111,
                           oob13_1     LIKE oob_file.oob13,
                           oob14_1     LIKE oob_file.oob14,
                           oob07_1     LIKE oob_file.oob07,
                           oob08_1     LIKE oob_file.oob08,
                           oob09_1     LIKE oob_file.oob09,
                           oob10_1     LIKE oob_file.oob10,
                           oob12_1     LIKE oob_file.oob12,
                           oobud01_1   LIKE oob_file.oobud01,
                           oobud02_1   LIKE oob_file.oobud02,
                           oobud03_1   LIKE oob_file.oobud03,
                           oobud04_1   LIKE oob_file.oobud04,
                           oobud05_1   LIKE oob_file.oobud05,
                           oobud06_1   LIKE oob_file.oobud06,
                           oobud07_1   LIKE oob_file.oobud07,
                           oobud08_1   LIKE oob_file.oobud08,
                           oobud09_1   LIKE oob_file.oobud09,
                           oobud10_1   LIKE oob_file.oobud10,
                           oobud11_1   LIKE oob_file.oobud11,
                           oobud12_1   LIKE oob_file.oobud12,
                           oobud13_1   LIKE oob_file.oobud13,
                           oobud14_1   LIKE oob_file.oobud14,
                           oobud15_1   LIKE oob_file.oobud15
                        END RECORD,
#FUN-A90003--Add--End--#
                                                                        
       g_oma            RECORD LIKE oma_file.*,
        g_wc,g_wc2,g_sql string,                         #No.FUN-580092 HCN
       g_t1             LIKE ooy_file.ooyslip,           #No.FUN-680123 VARCHAR(5),        #No.FUN-550071
       g_buf            LIKE type_file.chr20,            #No.FUN-680123 VARCHAR(20),
       g_buf1           LIKE type_file.chr20,            #No.FUN-680123 VARCHAR(20),
       g_ooa31_diff     LIKE ooa_file.ooa31d,
       g_ooa32_diff     LIKE ooa_file.ooa32d,
       g_argv1          LIKE ooa_file.ooa01,              # FUN-580154 沖帳單號
       tot,tot1,tot2    LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       tot3             LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       un_pay1,un_pay2  LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       g_yy             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,
       g_mm             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,
       diff_flag        LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),    # 差異處理方式
       g_rec_b          LIKE type_file.num5,              #No.FUN-680123 SMALLINT,   #單身筆數
       l_ac             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,   #目前處理的ARRAY CNT
       p_row,p_col      LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_net            LIKE apv_file.apv04               #MOD-590440
#主程式開始
DEFINE g_forupd_sql     STRING                            #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done   LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_chr            LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
DEFINE g_chr2           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
DEFINE g_chr3           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1) #FUN-580154
DEFINE g_laststage      LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1) #FUN-580154
DEFINE g_cnt            LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_i              LIKE type_file.num5               #No.FUN-680123 SMALLINT   #count/index for any purpose
DEFINE g_msg            LIKE type_file.chr1000            #No.FUN-680123 VARCHAR(72)
DEFINE g_str            STRING                            #No.FUN-670060
DEFINE g_wc_gl          STRING                            #No.FUN-670060
DEFINE g_dbs_gl         LIKE type_file.chr21              #No.FUN-680123 VARCHAR(21)   #No.FUN-670060
DEFINE l_dbs_new        LIKE type_file.chr21              #No.FUN-680123 VARCHAR(21)   #No.FUN-670060
DEFINE g_row_count      LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_curs_index     LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_jump           LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE mi_no_ask        LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_argv2          STRING                            #No.TQC-630066
DEFINE g_bookno1        LIKE aza_file.aza81               #NO.FUN-730073   
DEFINE g_bookno2        LIKE aza_file.aza82               #NO.FUN-730073   
DEFINE g_flag           LIKE type_file.chr1               #NO.FUN-730073 
DEFINE l_sql            STRING                            #No.FUN-850143
DEFINE l_str            STRING                            #No.FUN-850143
DEFINE l_table          STRING                            #No.FUN-850143
#FUN-960141 add
DEFINE g_dbs2           LIKE type_file.chr30  
DEFINE li_result        LIKE type_file.num5
#END
DEFINE g_plant2         LIKE type_file.chr10              #FUN-980020
DEFINE l_ac2            LIKE type_file.num5               #FUN-A90003 Add
DEFINE g_rec_b2         LIKE type_file.num5               #FUN-A90003 Add
DEFINE g_wc3            STRING                            #FUN-A90003 Add
DEFINE g_b_flag         STRING                            #FUN-A90003 Add 
DEFINE g_apz13          LIKE apz_file.apz13               #MOD-B30240
DEFINE g_aps            RECORD LIKE aps_file.*            #MOD-B30240 
DEFINE g_tc_hka     RECORD LIKE tc_hka_file.*  #add by shijl 161223

MAIN
#   DEFINE l_time        LIKE type_file.chr8               #No.FUN-680123 VARCHAR(8)                  #計算被使用時間   #No.FUN-6A0095
   #FUN-640246
   IF FGL_GETENV("FGLGUI") <> "0" THEN
      OPTIONS                               #改變一些系統預設值
         INPUT NO WRAP
   END IF
   #END FUN-640246
 
   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
#   IF (NOT cl_setup("AXR")) THEN
   IF (NOT cl_setup("CXR")) THEN   
      EXIT PROGRAM
   END IF
 
   LET g_artype = ARG_VAL(1)
   LET g_argv1 = ARG_VAL(1)
   LET g_argv2=ARG_VAL(2)           #No.TQC-630066
 
   ### 98/07/16 add by connie
   ### axr_stup : 造成後面程式段以 g_dbs_new 為主(總帳)--前端有多工廠,總帳一套
  #LET g_dbs_new = g_dbs CLIPPED,":" #TQC-950020     
   LET g_dbs_new = s_dbstring(g_dbs CLIPPED) #TQC-950020    
   LET g_wc2=' 1=1'
   LET l_dbs_new = g_dbs_new  #No.FUN-670060 add
 
#  SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05 FROM azi_file  #No.CHI-6A0004
#   WHERE azi01 = g_aza.aza17                           #No.CHI-6A0004         
 
 
      CALL cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
        RETURNING g_time     #No.FUN-6A0095
 
    #No.FUN-850143-------start--
    LET l_sql = "ooa01.ooa_file.ooa01,", 
                "ooa02.ooa_file.ooa02,", 
                "ooa03.ooa_file.ooa03,", 
                "ooa032.ooa_file.ooa032,",
                "ooa15.ooa_file.ooa15,", 
                "gem02.gem_file.gem02,", 
                "ooa23.ooa_file.ooa23,", 
                "ooa31d.ooa_file.ooa31d,",
                "ooa32d.ooa_file.ooa32d,",
                "ooa13.ooa_file.ooa13,", 
                "aag02.aag_file.aag02,", 
                "azi04.azi_file.azi04,",
                "l_n.type_file.num5" 
    LET l_table = cl_prt_temptable('axrt410',l_sql) CLIPPED
    IF l_table=-1 THEN EXIT PROGRAM END IF
    
    LET l_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
                " VALUES(?,?,?,?,?,?,?,?,?,?, ?,?,?)"
    PREPARE insert_prep FROM l_sql
    IF STATUS THEN
       CALL cl_err('insert_prep:',STATUS,1) EXIT PROGRAM 
    END IF            
    #No.FUN-850143-------end
   
    LET g_forupd_sql = "SELECT * FROM ooa_file WHERE ooa01 = ? FOR UPDATE "   #wujie 091021
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t410_cl CURSOR FROM g_forupd_sql
 
   
#FUN-580154
    IF fgl_getenv('EASYFLOW') = "1" THEN
       LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
    END IF
#FUN-580154 End
   #FUN-640246
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      LET p_row = 2 LET p_col = 3
      OPEN WINDOW t410_w AT p_row,p_col
#        WITH FORM "axr/42f/axrt410"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
        WITH FORM "cxr/42f/axrt410"  ATTRIBUTE (STYLE = g_win_style CLIPPED)        
      
      CALL cl_ui_init()
      CALL cl_set_comp_visible("oob03,oob03_d",FALSE)   #No.CHI-B30061 add
      CALL t410_set_comb_oob04()                        #FUN-A90003 Add
      CALL t410_set_comb_oob04_1()                      #FUN-A90003 Add      
   END IF
   #END FUN-640246
 
   CALL cl_set_comp_visible("oob20,oob23,oob17,oob18,oob21",FALSE) #TQC-AC0373
  #No.FUN-670047--begin-- add
   IF g_aza.aza63='N' THEN
      CALL cl_set_comp_visible("oob111",FALSE)
      CALL cl_set_comp_visible("oob111_1",FALSE)        #FUN-A90003 Add
   END IF
  #No.FUN-670047--end-- add
 
#FUN-580154
    #如果由表單追蹤區觸發程式, 此參數指定為何種資料匣
    #當為 EasyFlow 簽核時, 加入 EasyFlow 簽核 toolbar icon
    CALL aws_efapp_toolbar()    #FUN-580154
    #No.TQC-630066 --start--
    IF NOT cl_null(g_argv1) THEN
      CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t410_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t410_a()
            END IF
   #FUN-640246
          WHEN "efconfirm"
             CALL t410_q()
             CALL t410_y_chk()          #CALL 原確認的 check 段
             IF g_success = "Y" THEN
                CALL t410_y_upd()       #CALL 原確認的 update 段
             END IF
             EXIT PROGRAM
          OTHERWISE
             CALL t410_q()
      END CASE
    END IF
    #No.TQC-630066 --end--
   #IF NOT cl_null(g_argv1) THEN
   #   CALL t410_q()
   #END IF
   #END FUN-640246
 
    #No.MOD-590440  --begin
    SELECT * INTO g_apz.* FROM apz_file WHERE apz00='0'
    #No.MOD-590440  --end
 
    #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
    CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, confirm, undo_confirm, easyflow_approval,gen_entry,entry_sheet,carry_voucher,undo_carry_voucher")  #TQC-740156 modify
         RETURNING g_laststage
#FUN-580154 End
 
    CALL t410_menu()
 
    CLOSE WINDOW t410_w                 #結束畫面
 
      CALL cl_used(g_prog,g_time,2)    #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
        RETURNING g_time     #No.FUN-6A0095
 
END MAIN

#FUN-A90003--Mark--Begin--#
{ 
FUNCTION t410_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
 
   CLEAR FORM                             #清除畫面
   CALL g_oob.clear()
 
#FUN-580154
   IF NOT cl_null(g_argv1) THEN
      LET g_wc=" ooa01='",g_argv1,"'"
      LET g_wc2=" 1=1"  #No.TQC-630066
   ELSE
      CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
   INITIALIZE g_ooa.* TO NULL    #No.FUN-750051
      CONSTRUCT BY NAME g_wc ON ooa01,ooa02,ooa03,ooa35,ooa36,   #FUN-960141 add ooa35,ooa36
                                ooa032,ooa14,ooa15,ooa23,
                                #ooa37,ooa38,    #FUN-960141 add    #FUN-960140 mark
                                ooa38,           #FUN-960140 add
                                ooa13,ooa33,ooa992,ooaconf,ooamksg,ooa34,ooa31d,     #No.FUN-540046  #No.FUN-690090 add ooa992
                                ooa31c,ooauser,ooagrup,ooamodu,ooadate,
                               #FUN-850038   ---start---
                                ooaud01,ooaud02,ooaud03,ooaud04,ooaud05,
                                ooaud06,ooaud07,ooaud08,ooaud09,ooaud10,
                                ooaud11,ooaud12,ooaud13,ooaud14,ooaud15
                               #FUN-850038    ----end----
 
               #No.FUN-580031 --start--     HCN
               BEFORE CONSTRUCT
                  CALL cl_qbe_init()
               #No.FUN-580031 --end--       HCN
          ON ACTION CONTROLP
             CASE
                #95/11/10 by danny (單別查詢)
                WHEN INFIELD(ooa01)
                   CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooa"
                  LET g_qryparam.arg1 = "2"       #No.TQC-A90057
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO ooa01
                NEXT FIELD ooa01
 
                WHEN INFIELD(ooa03)
                   CALL cl_init_qry_var()
#                  LET g_qryparam.form = "q_occ"     #No.FUN-670026 mark
                   LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa03
                   NEXT FIELD ooa03
                WHEN INFIELD(ooa13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ool"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa13
                   NEXT FIELD ooa13
                WHEN INFIELD(ooa14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gen"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa14
                   NEXT FIELD ooa14
                WHEN INFIELD(ooa15)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gem"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa15
                   NEXT FIELD ooa15
                WHEN INFIELD(ooa23)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azi"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa23
                   NEXT FIELD ooa23
             END CASE
 
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
          ON ACTION about         #MOD-4C0121
             CALL cl_about()      #MOD-4C0121
 
          ON ACTION help          #MOD-4C0121
             CALL cl_show_help()  #MOD-4C0121
 
          ON ACTION controlg      #MOD-4C0121
             CALL cl_cmdask()     #MOD-4C0121
 
		#No.FUN-580031 --start--     HCN
                 ON ACTION qbe_select
		   CALL cl_qbe_list() RETURNING lc_qbe_sn
		   CALL cl_qbe_display_condition(lc_qbe_sn)
		#No.FUN-580031 --end--       HCN
      END CONSTRUCT
 
      IF INT_FLAG THEN
         RETURN
      END IF
   END IF
# FUN-580154 End
 
   #資料權限的檢查
   #Begin:FUN-980030
   #   IF g_priv2='4' THEN                           #只能使用自己的資料
   #      LET g_wc = g_wc clipped," AND ooauser = '",g_user,"'"
   #   END IF
 
   #   IF g_priv3='4' THEN                           #只能使用相同群的資料
   #      LET g_wc = g_wc clipped," AND ooagrup MATCHES '",g_grup CLIPPED,"*'"
   #   END IF
 
   #   IF g_priv3 MATCHES "[5678]" THEN    #TQC-5C0134群組權限
   #      LET g_wc = g_wc clipped," AND ooagrup IN ",cl_chk_tgrup_list()
   #   END IF
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('ooauser', 'ooagrup')
   #End:FUN-980030
 
 
   IF cl_null(g_argv1) THEN
      #CONSTRUCT g_wc2 ON oob02,oob05,oob03,oob04,oob06,oob19,oob15,   #FUN-990031 mark
      CONSTRUCT g_wc2 ON oob02,oob03,oob04,oob06,oob19,oob15,    #FUN-990031 del oob05
                         oob20,oob23,oob17,oob18,oob21,   #FUN-960141 add
                         oob11,oob111,        #No.FUN-670047  add oob111   #No.FUN-680022 add oob19  #No.FUN-690090  add oob05
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12         #No.MOD-920178 add
                        #No.FUN-850038 --start--
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
                        #No.FUN-850038 ---end---
              #FROM s_oob[1].oob02,s_oob[1].oob05,s_oob[1].oob03,s_oob[1].oob04,    #No.FUN-690090 add oob05   #FUN-990031 mark
              FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,     #FUN-990031 del oob05
                   s_oob[1].oob06,s_oob[1].oob19,                 #No.FUN-680022 add s_oob[1].oob19
                   s_oob[1].oob15,
                   s_oob[1].oob20,s_oob[1].oob23,s_oob[1].oob17,s_oob[1].oob18,s_oob[1].oob21, #FUN-960141 add
                   s_oob[1].oob11,s_oob[1].oob111, #No.FUN-670047 add s_oob[1].oob111
                   s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                   s_oob[1].oob08 
                  ,s_oob[1].oob09,s_oob[1].oob10,s_oob[1].oob12   #No.MOD-920178 add 
                  #No.FUN-850038 --start--
                  ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                  ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                  ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                  ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                  ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
                  #No.FUN-850038 ---end---
 
		#No.FUN-580031 --start--     HCN
		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
		#No.FUN-580031 --end--       HCN
 
         ON ACTION CONTROLP    #ok
            CASE
               WHEN INFIELD(oob04)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04
#MOD-5B0108
              WHEN INFIELD(oob06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06
#END MOD-5B0108
               WHEN INFIELD(oob11)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11
                  NEXT FIELD oob11
#No.FUN-670047--begin-- add
               WHEN INFIELD(oob111)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111
                  NEXT FIELD oob111
#No.FUN-670047--end-- add
               WHEN INFIELD(oob13)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13   #MOD-620011
                  NEXT FIELD oob13
               WHEN INFIELD(oob07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07   #MOD-620011
                  NEXT FIELD oob07
#FUN-960141 add begin  
               WHEN INFIELD (oob17)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nma'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob17
                    NEXT FIELD oob17  
               WHEN INFIELD (oob18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nmc02'
                    LET g_qryparam.state = "c"
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob18
                    NEXT FIELD oob18
               WHEN INFIELD (oob21)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nml'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob21
                    NEXT FIELD oob21 
#FUN-960141 add end  
                  OTHERWISE EXIT CASE
            END CASE
 
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT
 
          ON ACTION about         #MOD-4C0121
             CALL cl_about()      #MOD-4C0121
 
          ON ACTION help          #MOD-4C0121
             CALL cl_show_help()  #MOD-4C0121
 
          ON ACTION controlg      #MOD-4C0121
             CALL cl_cmdask()     #MOD-4C0121
 
		#No.FUN-580031 --start--     HCN
                    ON ACTION qbe_save
		       CALL cl_qbe_save()
		#No.FUN-580031 --end--       HCN
      END CONSTRUCT
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         RETURN
      END IF
   END IF
 
   IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
      LET g_sql = "SELECT ooa01 FROM ooa_file",    #wujie 091021
                  " WHERE ", g_wc CLIPPED,
                  "   AND ooa00 = '1' ",  #FUN-570099
#                 "   AND ooa37 = 'Y' ",  #FUN-960141   #FUN-A40076 Mark
                  "   AND ooa37 = '2' ",                #FUN-A40076 Add 
#                 " ORDER BY 2"
                  " ORDER BY ooa01"    #wujie 091021
   ELSE                              # 若單身有輸入條件
      LET g_sql = "SELECT UNIQUE ooa_file.ooa01 ",    #wujie 091021
                  "  FROM ooa_file, oob_file",
                  " WHERE ooa01 = oob01",
#                 "   AND ooa37 = 'Y' ",  #FUN-960141   #FUN-A40076 Mark
                  "   AND ooa37 = '2' ",                #FUN-A40076 Add                   
                  "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                  "   AND ooa00 = '1' ",  #FUN-570099
#                 " ORDER BY 2"
                  " ORDER BY ooa01"    #wujie 091021
   END IF
 
   PREPARE t410_prepare FROM g_sql
   DECLARE t410_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR t410_prepare
 
   IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
      LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                "   AND ooa00 = '1' ", #FUN-570099
#               "   AND ooa37 = 'Y' "   #FUN-570099   #FUN-A40076 Mark
                "   AND ooa37 = '2' "                 #FUN-A40076 Add                 
   ELSE
      LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file WHERE ",
                "oob01=ooa01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
                "   AND ooa00 = '1' ", #FUN-570099
#               "   AND ooa37 = 'Y' "   #FUN-570099   #FUN-A40076 Mark
                "   AND ooa37 = '2' "                 #FUN-A40076 Add                
   END IF
 
   PREPARE t410_precount FROM g_sql
   DECLARE t410_count CURSOR FOR t410_precount
 
END FUNCTION
}
##FUN-A90003--Mark--End--#

#FUN-A90003--Add--Begin--#
FUNCTION t410_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01   
 
   CLEAR FORM                             #清除畫面
   CALL g_oob.clear()
   CALL g_oob_d.clear()
 
   IF NOT cl_null(g_argv1) THEN
      LET g_wc=" ooa01='",g_argv1,"'"
      LET g_wc2=" 1=1"
      LET g_wc3=" 1=1" 
   ELSE
      CALL cl_set_head_visible("","YES")      
   INITIALIZE g_ooa.* TO NULL 
   
      DIALOG ATTRIBUTES(UNBUFFERED)
     
      CONSTRUCT BY NAME g_wc ON ooa01,ooa02,ooa03,ooa35,ooa36,   
                                ooa032,ooa14,ooa15,ooa23,
                                ooa38,           
                                ooa13,ooa33,ooa992,ooaconf,ooamksg,ooa34,ooa31d,   
                                ooa31c,ooauser,ooagrup,ooamodu,ooadate,
                                ooaud01,ooaud02,ooaud03,ooaud04,ooaud05,
                                ooaud06,ooaud07,ooaud08,ooaud09,ooaud10,
                                ooaud11,ooaud12,ooaud13,ooaud14,ooaud15

          BEFORE CONSTRUCT
            CALL cl_qbe_init()

      END CONSTRUCT

      CONSTRUCT g_wc2 ON oob02,oob03,oob04,oob06,oob19,oob15,    
                         oob20,oob23,oob17,oob18,oob21,  
                         oob11,oob111,       
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12         
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
              FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,     
                   s_oob[1].oob06,s_oob[1].oob19,                 
                   s_oob[1].oob15,
                   s_oob[1].oob20,s_oob[1].oob23,s_oob[1].oob17,s_oob[1].oob18,s_oob[1].oob21, 
                   s_oob[1].oob11,s_oob[1].oob111, 
                   s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                   s_oob[1].oob08 
                  ,s_oob[1].oob09,s_oob[1].oob10,s_oob[1].oob12   
                  ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                  ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                  ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                  ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                  ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
 
		  BEFORE CONSTRUCT
		    CALL cl_qbe_display_condition(lc_qbe_sn)      

      END CONSTRUCT      

      CONSTRUCT g_wc3 ON oob02,oob03,oob04,oob06,oob19,oob15,    
                         oob20,oob23,oob17,oob18,oob21,  
                         oob11,oob111,       
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12         
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
              FROM s_oob_d[1].oob02_1,s_oob_d[1].oob03_d,s_oob_d[1].oob04_1,     
                   s_oob_d[1].oob06_1,s_oob_d[1].oob19_1,                 
                   s_oob_d[1].oob15_1,
                   s_oob_d[1].oob20_1,s_oob_d[1].oob23_1,s_oob_d[1].oob17_1,
                   s_oob_d[1].oob18_1,s_oob_d[1].oob21_1, 
                   s_oob_d[1].oob11_1,s_oob_d[1].oob111_1, 
                   s_oob_d[1].oob13_1,s_oob_d[1].oob14_1,s_oob_d[1].oob07_1,
                   s_oob_d[1].oob08_1 
                  ,s_oob_d[1].oob09_1,s_oob_d[1].oob10_1,s_oob_d[1].oob12_1   
                  ,s_oob_d[1].oobud01_1,s_oob_d[1].oobud02_1,s_oob_d[1].oobud03_1
                  ,s_oob_d[1].oobud04_1,s_oob_d[1].oobud05_1,s_oob_d[1].oobud06_1
                  ,s_oob_d[1].oobud07_1,s_oob_d[1].oobud08_1,s_oob_d[1].oobud09_1
                  ,s_oob_d[1].oobud10_1,s_oob_d[1].oobud11_1,s_oob_d[1].oobud12_1
                  ,s_oob_d[1].oobud13_1,s_oob_d[1].oobud14_1,s_oob_d[1].oobud15_1
 
		  BEFORE CONSTRUCT
		    CALL cl_qbe_display_condition(lc_qbe_sn)      

      END CONSTRUCT

          ON ACTION CONTROLP
             CASE
                WHEN INFIELD(ooa01)
                   CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooa"
                  LET g_qryparam.arg1 = "2"       #No.TQC-A90057
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO ooa01
                NEXT FIELD ooa01
 
                WHEN INFIELD(ooa03)
                   CALL cl_init_qry_var() 
                   LET g_qryparam.form = "q_occ11"   
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa03
                   NEXT FIELD ooa03
                WHEN INFIELD(ooa13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ool"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa13
                   NEXT FIELD ooa13
                WHEN INFIELD(ooa14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gen"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa14
                   NEXT FIELD ooa14
                WHEN INFIELD(ooa15)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gem"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa15
                   NEXT FIELD ooa15
                WHEN INFIELD(ooa23)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azi"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa23
                   NEXT FIELD ooa23                   
               WHEN INFIELD(oob04)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04
              WHEN INFIELD(oob06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06
               WHEN INFIELD(oob11)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11
                  NEXT FIELD oob11
               WHEN INFIELD(oob111)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111
                  NEXT FIELD oob111
               WHEN INFIELD(oob13)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13   
                  NEXT FIELD oob13
               WHEN INFIELD(oob07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07   
                  NEXT FIELD oob07
               WHEN INFIELD (oob17)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nma'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob17
                    NEXT FIELD oob17  
               WHEN INFIELD (oob18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nmc02'
                    LET g_qryparam.state = "c"
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob18
                    NEXT FIELD oob18
               WHEN INFIELD (oob21)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nml'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob21
                    NEXT FIELD oob21  
               WHEN INFIELD(oob04_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04_1
              WHEN INFIELD(oob06_1)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06_1
               WHEN INFIELD(oob11_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11_1
                  NEXT FIELD oob11_1
               WHEN INFIELD(oob111_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111_1
                  NEXT FIELD oob111_1
               WHEN INFIELD(oob13_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13_1   
                  NEXT FIELD oob13_1
               WHEN INFIELD(oob07_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07_1   
                  NEXT FIELD oob07_1
               WHEN INFIELD (oob17_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nma'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob17_1
                    NEXT FIELD oob17_1  
               WHEN INFIELD (oob18_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nmc02'
                    LET g_qryparam.state = "c"
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob18_1
                    NEXT FIELD oob18_1
               WHEN INFIELD (oob21_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nml'
                    LET g_qryparam.state = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oob21_1
                    NEXT FIELD oob21_1  
                  OTHERWISE EXIT CASE
            END CASE
 
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG
 
          ON ACTION about        
             CALL cl_about()     
 
          ON ACTION help         
             CALL cl_show_help()  
 
          ON ACTION controlg     
             CALL cl_cmdask()     
 
          ON ACTION qbe_save
		         CALL cl_qbe_save()

          ON ACTION accept
             EXIT DIALOG

          ON ACTION cancel
             LET INT_FLAG = TRUE
             EXIT DIALOG		       
      END DIALOG
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         RETURN
      END IF
   END IF

   IF cl_null(g_wc2) THEN
      LET g_wc2 =' 1=1' 
   END IF  
   IF cl_null(g_wc3) THEN
      LET g_wc3 =' 1=1' 
   END IF
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('ooauser', 'ooagrup')

   IF g_wc3=" 1=1" THEN
      IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
         LET g_sql = "SELECT ooa01 FROM ooa_file",
                     " WHERE ", g_wc CLIPPED,
                     "   AND ooa00 = '1' ",  
                     "   AND ooa37 = '2' ",  
                     " ORDER BY 1"
      ELSE                              # 若單身有輸入條件
         LET g_sql = "SELECT UNIQUE ooa01 ",
                     "  FROM ooa_file, oob_file",
                     " WHERE ooa01 = oob01",
                     "   AND ", g_wc CLIPPED,
                     "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                     "   AND ooa00 = '1' ",  
                     "   AND ooa37 = '2' ", 
                     " ORDER BY 1"
      END IF
   ELSE
      IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
         LET g_sql = "SELECT ooa01 ",
                     "  FROM ooa_file, oob_file",
                     " WHERE ooa01 = oob01",
                     "   AND ", g_wc CLIPPED,
                     "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                     "   AND ooa00 = '1' ",  
                     "   AND ooa37 = '2' ",  
                     " ORDER BY 1"
      ELSE                              # 若單身有輸入條件
         LET g_sql = "SELECT UNIQUE ooa01 ",
                     "  FROM ooa_file, oob_file",
                     " WHERE ooa01 = oob01",
                     "   AND ", g_wc CLIPPED,
                     "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                     "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                     "   AND ooa00 = '1' ",  
                     "   AND ooa37 = '2' ",  
                     " ORDER BY 1"
      END IF
   END IF

   PREPARE t410_prepare FROM g_sql
   DECLARE t410_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR t410_prepare

   IF g_wc3=" 1=1" THEN
      IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
         LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                   "   AND ooa00 = '1' ", 
                   "   AND ooa37 = '2' " 
      ELSE
         LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                   " WHERE oob01=ooa01 ",
                   "   AND ",g_wc CLIPPED,
                   "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                   "   AND ooa00 = '1' ",
                   "   AND ooa37 = '2' "  
      END IF
   ELSE
      IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
         LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                   " WHERE oob01=ooa01 ",
                   "   AND ",g_wc CLIPPED,
                   "   AND ooa00 = '1' ", 
                   "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                   "   AND ooa37 = '2' "  
      ELSE
         LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                   " WHERE oob01=ooa01 ",
                   "   AND ",g_wc CLIPPED,
                   "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                   "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                   "   AND ooa00 = '1' ", 
                   "   AND ooa37 = '2' " 
      END IF
   END IF
 
   PREPARE t410_precount FROM g_sql
   DECLARE t410_count CURSOR FOR t410_precount
 
END FUNCTION
#FUN-A90003--Add--End--#
 
FUNCTION t410_menu()
   DEFINE l_creator  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINe l_flowuser LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1) # 是否有指定加簽人員      #FUN-580154
 
   LET l_flowuser = "N"
 
   WHILE TRUE
      CALL t410_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t410_a()
            END IF
 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t410_q()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t410_r()
            END IF
 
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t410_u()
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN
#              CALL t410_b()                  #FUN-A90003 Mark
               CASE g_b_flag                  #FUN-A90003 Add
                    WHEN '1' CALL t410_b()    #FUN-A90003 Add
                    WHEN '2' CALL t410_b2()   #FUN-A90003 Add 
               END CASE                       #FUN-A90003 Add
            ELSE
               LET g_action_choice = NULL
            END IF
 
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL t410_out()
            END IF
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         #FUN-4B0017
         WHEN "exporttoexcel"
             IF cl_chk_act_auth() THEN
                CALL cl_export_to_excel
                (ui.Interface.getRootNode(),base.TypeInfo.create(g_oob),'','')
             END IF
         #--
 
#        WHEN "other_data"
#           IF cl_chk_act_auth() THEN
#              CALL t410_2()
#           END IF
 
         WHEN "gen_entry"
            CALL t410_v()
 
         WHEN "entry_sheet"
            IF cl_chk_act_auth() THEN
               CALL t410_3()
               CALL t410_npp02() #No.+085 010426 by plum
            END IF
 
       #No.FUN-670047--begin-- add
         WHEN "entry_sheet2"
            IF cl_chk_act_auth() THEN
               CALL t410_3_1()
               CALL t410_npp02() #No.+085 010426 by plum
            END IF
       #No.FUN-670047--end-- add
 
         WHEN "memo"
            IF cl_chk_act_auth() THEN
               CALL t410_m()
            END IF
 
         #No.FUN-670060 --begin--
         WHEN "carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf = 'Y' THEN
                  CALL t410_carry_voucher()
               ELSE
                  CALL cl_err('','atm-402',1)
               END IF
            END IF
 
         WHEN "undo_carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf = 'Y' THEN
                  CALL t410_undo_carry_voucher() 
               ELSE
                  CALL cl_err('','atm-403',1)
               END IF
            END IF
         #No.FUN-670060 --end-- 
 
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
            	#add by andy 2016/12/19 18:14:29----s---------
               CALL t410_c_chk()
              #add by andy 2016/12/19 18:14:29----e---------
#FUN-580154
               #CALL t410_y()
               IF g_success = "Y" THEN
                CALL t410_y_chk()          #CALL 原確認的 check 段
               END IF
               IF g_success = "Y" THEN
                  CALL t410_y_upd()       #CALL 原確認的 update 段
               END IF
#FUN-580154 End
            END IF
 
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t410_z()
            END IF
 
         WHEN "void"
            IF cl_chk_act_auth() THEN
               CALL t410_x()
            END IF
 
#FUN-580154
         #@WHEN "准"
         WHEN "agree"
            IF g_laststage = "Y" AND l_flowuser = "N" THEN  #最後一關並且沒有加>
               CALL t410_y_upd()      #CALL 原確認的 update 段
            ELSE
               LET g_success = "Y"
               IF NOT aws_efapp_formapproval() THEN
                  LET g_success = "N"
               END IF
            END IF
            IF g_success = 'Y' THEN
                   IF cl_confirm('aws-081') THEN  #詢問是否繼續下一筆資料的簽核
                     IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                        LET l_flowuser = "N"
                        LET g_argv1 = aws_efapp_wsk(1)   #取得單號
                        IF NOT cl_null(g_argv1) THEN     #自動 query 帶出資料
                          CALL t410_q()
                         #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, confirm, undo_confirm, easyflow_approval,gen_entry,entry_sheet,carry_voucher,undo_carry_voucher")  #TQC-740156 modify
                               RETURNING g_laststage
                        ELSE
                            EXIT WHILE
                        END IF
                      ELSE
                        EXIT WHILE
                      END IF
                   ELSE
                      EXIT WHILE
                   END IF
             END IF
 
         #@WHEN "不准"
         WHEN "deny"
            IF ( l_creator := aws_efapp_backflow() ) IS NOT NULL THEN #退回關卡
               IF aws_efapp_formapproval() THEN
                  IF l_creator = "Y" THEN
                     LET g_ooa.ooa34= 'R'
                     DISPLAY BY NAME g_ooa.ooa34
                  END IF
                  IF cl_confirm('aws-081') THEN     #詢問是否繼續下一筆資料的簽>
                     IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                       LET l_flowuser = "N"
                       LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                       IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                          CALL t410_q()
                        #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, confirm, undo_confirm, easyflow_approval,gen_entry,entry_sheet,carry_voucher,undo_carry_voucher")  #TQC-740156 modify
                              RETURNING g_laststage
                       ELSE
                             EXIT WHILE
                       END IF
                     ELSE
                        EXIT WHILE
                     END IF
                  ELSE
                     EXIT WHILE
                  END IF
               END IF
            END IF
 
         #@WHEN "加簽"
         WHEN "modify_flow"
              IF aws_efapp_flowuser() THEN   #選擇欲加簽人員
                 LET l_flowuser = 'Y'
              ELSE
                 LET l_flowuser = 'N'
              END IF
 
         #@WHEN "撤簽"
         WHEN "withdraw"
              IF cl_confirm("aws-080") THEN
                 IF aws_efapp_formapproval() THEN
                    EXIT WHILE
                 END IF
              END IF
 
         #@WHEN "抽單"
         WHEN "org_withdraw"
              IF cl_confirm("aws-079") THEN
                 IF aws_efapp_formapproval() THEN
                    EXIT WHILE
                    END IF
              END IF
 
         #@WHEN "簽核意見"
         WHEN "phrase"
              CALL aws_efapp_phrase()
#FUN-580154 End
 
         ##EasyFlow送簽
         WHEN "easyflow_approval"     #FUN-550049
           IF cl_chk_act_auth() THEN
                CALL t410_ef()
           END IF
 
         #@WHEN "簽核狀況"
         WHEN "approval_status"
            IF cl_chk_act_auth() THEN        #DISPLAY ONLY
               IF aws_condition2() THEN                #FUN-550049
                   CALL aws_efstat2()                  #MOD-560007
               END IF
            END IF
 
         #No.FUN-6B0042-------add--------str----
         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_ooa.ooa01 IS NOT NULL THEN
                 LET g_doc.column1 = "ooa01"
                 LET g_doc.value1 = g_ooa.ooa01
                 CALL cl_doc()
               END IF
         END IF
         #No.FUN-6B0042-------add--------end----
 
     END CASE
   END WHILE
END FUNCTION
 
FUNCTION t410_a()
   DEFINE l_ooymxno LIKE ooy_file.ooymxno,
          l_stra    LIKE type_file.chr4,             #No.FUN-680123 VARCHAR(4), #TQC-840066
          l_strb    LIKE aba_file.aba18,             #No.FUN-680123 VARCHAR(2),
          l_strc    LIKE type_file.chr3,             #No.FUN-680123 VARCHAR(3),
          l_ooa_b   LIKE ooa_file.ooa03,             #No.FUN-680123 HAR(10),
          l_ooa_e   LIKE ooa_file.ooa03              #No.FUN-680123 VARCHAR(10)
 
   IF s_shut(0) THEN RETURN END IF
 
   MESSAGE ""
   CLEAR FORM
   CALL g_oob.clear()
   CALL g_oob_d.clear()                              #FUN-A90003 Add
   INITIALIZE g_ooa.* TO NULL
   LET g_ooa_o.* = g_ooa.*
   CALL cl_opmsg('a')
 
   WHILE TRUE
      #No.TQC-630066 --start--
      IF NOT cl_null(g_argv1) AND (g_argv2 = "insert") THEN
         LET g_ooa.ooa01 = g_argv1
      END IF     
      #No.TQC-630066 --end--
      LET g_ooa.ooa00 = '1'   #FUN-570099
      LET g_ooa.ooa02 = g_today
      LET g_ooa.ooa021 = g_today
       LET g_ooa.ooa13 = g_ooz.ooz08 #MOD-4A0119
      LET g_ooa.ooa14 = g_user
      LET g_ooa.ooa15 = g_grup
      LET g_ooa.ooa20 = 'Y'
      LET g_ooa.ooa31d = 0
      LET g_ooa.ooa31c = 0
      LET g_ooa.ooa32d = 0
      LET g_ooa.ooa32c = 0
      LET g_ooa.ooaconf = 'N'
      LET g_ooa.ooaprsw = 0
      LET g_ooa.ooauser = g_user
      LET g_ooa.ooaoriu = g_user #FUN-980030
      LET g_ooa.ooaorig = g_grup #FUN-980030
      LET g_ooa.ooagrup = g_grup
      LET g_ooa.ooadate = g_today
      LET g_ooa.ooamksg = "N"     #No.FUN-540046
      LET g_ooa.ooa34 = "0"       #No.FUN-540046
      #LET g_ooa.ooaplant = g_plant       #FUN-960141   #FUN-960141 mark 090824
      LET g_ooa.ooalegal = g_azw.azw02   #FUN-960141
#     LET g_ooa.ooa37 = 'Y'              #FUN-960141    #FUN-A40076 Mark
      LET g_ooa.ooa37 = '2'                             #FUN-A40076 Add 
      LET g_ooa.ooa38 = '2'              #FUN-960141
      #LET g_ooa.ooaplant = g_plant #FUN-980011 add     #FUN-960141 mark 090824
      LET g_ooa.ooalegal = g_legal #FUN-980011 add
 
      CALL t410_i("a")                #輸入單頭
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         INITIALIZE g_ooa.* TO NULL
         #ROLLBACK WORK EXIT WHILE   #MOD-730060
         EXIT WHILE   #MOD-730060
      END IF
 
      BEGIN WORK
      #CALL s_auto_assign_no("axr",g_ooa.ooa01,g_ooa.ooa02,"30","ooa_file","ooa01","","","")  #FUN-960140 mark
      CALL s_auto_assign_no("axr",g_ooa.ooa01,g_ooa.ooa02,"32","ooa_file","ooa01","","","")   #FUN-960140 add 
           RETURNING g_cnt,g_ooa.ooa01
      IF (NOT g_cnt) THEN
         ROLLBACK WORK
         CONTINUE WHILE
      END IF
      DISPLAY BY NAME g_ooa.ooa01
      #--
 
      INSERT INTO ooa_file VALUES (g_ooa.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         ROLLBACK WORK  #No:7837
         CALL cl_err3("ins","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","ins ooa",1)  #No.FUN-660116
         CONTINUE WHILE
      ELSE
         COMMIT WORK   #No:7837
         CALL cl_flow_notify(g_ooa.ooa01,'I')
      END IF
 
      LET g_ooa_t.* = g_ooa.*
      CALL g_oob.clear()
      LET g_rec_b=0
      CALL g_oob_d.clear()            #FUN-A90003 Add
      LET g_rec_b2=0                  #FUN-A90003 Add
 
      LET l_ac=1
 
      CALL t410_b()                   #輸入單身
      CALL t410_b2()                  #FUN-A90003 Add
      
      EXIT WHILE
   END WHILE
 
END FUNCTION
 
FUNCTION t410_input_nr()
 
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
 
   IF g_ooz.ooz23 = 'N' AND g_ooz.ooz24 = 'N' THEN
      RETURN
   END IF
 
   IF g_ooz.ooz23 = 'Y' THEN             #NO:4181
      IF cl_confirm('axr-200') THEN
         #CALL cl_cmdrun('anmt200')      #FUN-660216 remark
         CALL cl_cmdrun_wait('anmt200')  #FUN-660216 add
      END IF
   END IF
 
   IF g_ooz.ooz24 = 'Y' THEN
      IF NOT cl_confirm('axr-201') THEN
         RETURN
      END IF
      #CALL cl_cmdrun('anmt302')      #FUN-660216 reamrk
      CALL cl_cmdrun_wait('anmt302')  #FUN-660216 add
   END IF
 
END FUNCTION
 
FUNCTION t410_g_b()                       #先由應收票據或TT自動產生借方單身
 
   SELECT COUNT(*) INTO g_cnt FROM oob_file
    WHERE oob01 = g_ooa.ooa01
 
   IF g_cnt > 0 THEN
      RETURN
   END IF            #已有單身則不可再產生
 
   IF cl_null(g_ooa.ooa36) THEN   #FUN-960141
      CALL t410_g_b1()
   END IF                         #FUN-960141
 
#  CALL t410_g_b2()  #FUN-960141 暫時不要
 
   CALL t410_b_fill('1=1')
   CALL t410_b_fill_2('1=1') #FUN-A90003 Add
 
END FUNCTION
 
FUNCTION t410_g_b1()
   DEFINE sw1,sw2,sw3,sw4  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh            RECORD LIKE nmh_file.*
   DEFINE l_nmg            RECORD LIKE nmg_file.*
   DEFINE l_npk            RECORD LIKE npk_file.*
   DEFINE l_oma            RECORD LIKE oma_file.*
   DEFINE l_omc            RECORD LIKE omc_file.*    #No.FUN-680022
   DEFINE l_apc            RECORD LIKE apc_file.*    #No.FUN-680022 add
   DEFINE l_apa            RECORD LIKE apa_file.*
   DEFINE l_oob09          LIKE oob_file.oob09
   DEFINE l_oob10          LIKE oob_file.oob10
   DEFINE l_ooydmy1        LIKE ooy_file.ooydmy1
   DEFINE g_t1             LIKE type_file.chr5       #No.FUN-680123 VARCHAR(03)   #MOD-730023
   DEFINE l_ool            RECORD LIKE ool_file.*,
          l_sql            LIKE type_file.chr1000    #No.FUN-680123 VARCHAR(1300)
   DEFINE l_apz27          LIKE apz_file.apz27
   DEFINE l_nmz20          LIKE nmz_file.nmz20
   DEFINE l_nmz59          LIKE nmz_file.nmz59
   DEFINE ls_tmp           STRING
   DEFINE l_aag05          LIKE aag_file.aag05   #MOD-730022
   DEFINE l_bookno         LIKE aag_file.aag00   #No.FUN-740184
   DEFINE p05f             LIKE apg_file.apg05f  #MOD-820134
   DEFINE p05              LIKE apg_file.apg05   #MOD-820134
   DEFINE l_gem10          LIKE gem_file.gem10   #MOD-910107 add
 
   LET p_row = 8 LET p_col = 27
   OPEN WINDOW t4003_w AT p_row,p_col
     WITH FORM "axr/42f/axrt4003"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   #FUN-960141 add
   CALL cl_set_comp_visible("sw1",FALSE)
  #CALL cl_set_comp_visible("sw2",FALSE)   #TQC-A20043
   CALL cl_set_comp_visible("sw4",FALSE)
   #FUN-960141 end
   CALL cl_ui_locale("axrt4003")

   LET sw2 = 'Y'    #TQC-A20043 
   LET sw3 = 'Y'
 
   INPUT BY NAME sw2, sw3 WITHOUT DEFAULTS    #TQC-A20043 add sw2
 
#--NO.MOD-860078 start-----
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION help          
         CALL cl_show_help()  
 
      ON ACTION controlg      
         CALL cl_cmdask()     
#--NO.MOD-860078 end-------
   END INPUT
 
   CLOSE WINDOW t4003_w
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   SELECT * INTO l_ool.* FROM ool_file
    WHERE ool01 = g_ooa.ooa13
 
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
   LET b_oob.oob02=0

 
   IF sw3='Y' THEN
######No.FUN-680022 --begin--
#--mark-- by cl 保留原先程序
#     #No.TQC-5C0086  --Begin                                                                                                       
#     IF g_ooz.ooz07 = 'N' THEN                                                                                                     
#        LET l_sql = "SELECT * FROM oma_file ",                                                                                     
##                   " WHERE oma03 = '",g_ooa.ooa03,"' ",  #No.FUN-670026 mark                                                                         
##                   "   AND oma032= '",g_ooa.ooa032,"' ", #No.FUN-670026 mark                                                                         
#                    " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
#                    "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
#                    "   AND (oma54t>oma55 OR oma56t>oma57) ",                                                                      
#                    "   AND oma00 MATCHES '2*' ",                                                                                  
#                    "   AND omavoid = 'N' ",                                                                                       
#                    "   AND oma00 != '23' "                                                                                        
#     ELSE                                                                                                                          
#     END IF                                                                                                                        
#        LET l_sql = "SELECT * FROM oma_file ",                                                                                     
##                   " WHERE oma03 = '",g_ooa.ooa03,"' ",  #No.FUN-670026 mark                                                                         
##                   "   AND oma032= '",g_ooa.ooa032,"' ", #No.FUN-670026 mark                                                                         
#                    " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
#                    "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
#                    "   AND (oma54t>oma55 OR oma61>0) ",                                                                           
#                    "   AND oma00 MATCHES '2*' ",                                                                                  
#                    "   AND omavoid = 'N' ",                                                                                       
#                    "   AND oma00 != '23' "                                                                                        
#--mark-- by cl  保留原先程序
      IF g_ooz.ooz07 = 'N' THEN                                                                                                     
         LET l_sql = "SELECT * FROM oma_file,omc_file ",    
                     " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
                     "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
                     "   AND oma01 = omc01 ",              #No.FUN-680022 add
                     "   AND (omc08>omc10 OR omc09 >omc11) ", #No.FUN-680022 
                     "   AND oma00 LIKE '2%' ",                                                                                  
                     "   AND omavoid = 'N' ",                                                                                       
                     "   AND omaconf = 'Y' ",   #MOD-760119
                    #"   AND oma00 != '23' "               #No.FUN-A40054
                    # "   AND (oma00 = '23' OR oma00='24')" #No.FUN-A40054 #No.TQC-B40032 mark
                     "   AND (oma00 = '21' OR oma00 = '22' OR oma00 = '23' OR oma00='24' OR oma00='26' OR oma00='27')" #No.TQC-B40032

      ELSE                                                                                                                          
         LET l_sql = "SELECT * FROM oma_file ,omc_file ",                                                                                     
                     " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
                     "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
                     "   AND oma01 = omc01 ",              #No.FUN-680022 add
                     "   AND (omc08>omc10 OR omc13 >0) ", #No.FUN-680022 
                     "   AND oma00 LIKE '2%' ",                                                                                  
                     "   AND omavoid = 'N' ",                                                                                       
                     "   AND omaconf = 'Y' ",   #MOD-760119
                    #"   AND oma00 != '23' "               #No.FUN-A40054
                    #"   AND (oma00 = '23' OR oma00='24')" #No.FUN-A40054  #No.TQC-B40032 mark
                     "   AND (oma00 = '21' OR oma00 = '22' OR oma00 = '23' OR oma00='24' OR oma00='26' OR oma00='27')" #No.TQC-B40032
      END IF                                                                                                                        
######No.FUN-680022 --end--
      PREPARE t410_g_b_p13 FROM l_sql                                                                                               
      DECLARE t410_g_b_c13 CURSOR FOR t410_g_b_p13                                                                                  
      #No.TQC-5C0086  --End
      FOREACH t410_g_b_c13 INTO l_oma.*,l_omc.*    #No.FUN-680022 add omc
        IF STATUS THEN EXIT FOREACH END IF
 
        #FUN-660035 add --start
        IF l_oma.oma02 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
           CONTINUE FOREACH
        END IF
        #FUN-660035 add --end
 
### 03/05/28 by connie bug no:7368
      # IF l_oma.oma23 != g_ooa.ooa23 THEN CONTINUE FOREACH END IF
        IF g_ooa.ooa23 IS NOT NULL AND l_oma.oma23 != g_ooa.ooa23 THEN
           CONTINUE FOREACH
        END IF
        IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277             
#--end
       #--- 970421 須考慮未確認沖帳資料
        SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
         WHERE oob06=l_omc.omc01 AND ooa01=oob01 AND ooaconf='N' AND oob19=l_omc.omc02  #No.FUN-680022  #No.FUN-7B0055
        IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
        IF cl_null(l_oob10) THEN LET l_oob10=0 END IF
       #No.+009 010418 by plum mod axrt300:'2*'可產生分錄
       #若己在axrt300產生分錄,因稅額已在前端立過了,故在此不用再立,
       #故此處金額應直接取含稅金額
           LET b_oob.oob09=l_omc.omc08 -l_omc.omc10 - l_oob09  #No.FUN-680022
           LET b_oob.oob10=l_omc.omc09 -l_omc.omc11 - l_oob10  #No.FUN-680022
        CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net  #No.FUN-680022  #No.FUN-7B0055
        LET b_oob.oob10 = b_oob.oob10 + g_net 
        #No.TQC-5C0086  --End
       #No.+009....end
       #---------------------------- 先作未稅
       #TQC-A20043--mod--str--
        SELECT MAX(oob02) INTO b_oob.oob02 FROM oob_file 
         WHERE oob01 = b_oob.oob01
        IF cl_null(b_oob.oob02) THEN
           LET b_oob.oob02 = 0
        END IF 
       #TQC-A20043--mod--end
        LET b_oob.oob02=b_oob.oob02+1
        LET b_oob.oob03='1'
        LET b_oob.oob04='3'
        LET b_oob.oob06=l_omc.omc01        #No.FUN-680022
        LET b_oob.oob14=NULL
        LET b_oob.oob15=NULL               #No.MOD-950132
        LET b_oob.oob07=l_oma.oma23
        LET b_oob.oob08=l_oma.oma24
        LET b_oob.oob20='N'  
        IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
           IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
              LET b_oob.oob08 = l_omc.omc07   #No.FUN-680022 --modify
           ELSE                                       #MOD-940277
           	  LET b_oob.oob08 = l_oma.oma24           #MOD-940277
           END IF                                     #MOD-940277     
           IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
              LET b_oob.oob08 = l_oma.oma24
           END IF
           CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob15)
                RETURNING tot3
           IF (l_oob09+b_oob.oob09+l_omc.omc10) = l_omc.omc08  THEN  #No.FUN-680022 
              LET b_oob.oob10 = tot3 - l_oob10
           END IF
        END IF
 
         SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 #MOD-560077   #No.CHI-6A0004 #MOD-940238 mark
       #98/01/02 modify 未扣除已沖帳
        CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09    #No.CHI-6A0004 
        CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10    #No.CHI-6A0004
        LET b_oob.oob11=l_oma.oma18
        IF g_aza.aza63='Y' THEN           #No.FUN-670047
           LET b_oob.oob111=l_oma.oma181  #No.FUN-670047
        END IF                            #No.FUN-670047
       #No.+009 ...end
        LET b_oob.oob19 = l_omc.omc02     #No.FUN-680022 add
 
        IF b_oob.oob09<=0 THEN CONTINUE FOREACH END IF   #no:6252
        #-----MOD-730022---------
        #No.FUN-740184  --Begin
        CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2
        IF g_flag='1' THEN
           CALL cl_err(l_oma.oma02,'aoo-081',1)
        END IF
        #No.FUN-740184  --End  
        LET l_aag05 = ''
        SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                  AND aag00=g_bookno1      #No.FUN-730073
        IF l_aag05 = 'Y' THEN
           LET b_oob.oob13 = l_oma.oma15
        ELSE
           LET b_oob.oob13 = ''
        END IF
        #-----END MOD-730022-----
        #No.FUN-740184  --Begin
        IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
           CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                RETURNING l_bookno,b_oob.oob11
           CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                RETURNING l_bookno,b_oob.oob111
        END IF
        #No.FUN-740184  --End  
        #FUN-960141 add
        #LET b_oob.oobplant = l_oma.omaplant   #FUN-960141 mark 090824
        LET b_oob.ooblegal = l_oma.omalegal
        #FUN-960141 end
        LET b_oob.oob20 = 'N'  #No.FUN-A40054
        INSERT INTO oob_file VALUES (b_oob.*)
       #---------------------------- 再作稅額
       #No.+009 010418 by plum mod
       #若'2*'己在axrt300產生分錄,因稅額已在前端立過了,故在此不用再立
       #IF l_oma.oma54x != 0 THEN
        IF l_ooydmy1='N' AND l_oma.oma54x != 0 THEN
           LET b_oob.oob02=b_oob.oob02+1
           LET b_oob.oob09=l_oma.oma54x LET b_oob.oob10=l_oma.oma56x
           LET b_oob.oob11=l_ool.ool14
           IF g_aza.aza63='Y' THEN           #No.FUN-670047
              LET b_oob.oob111=l_ool.ool141  #No.FUN-670047          
           END IF                            #No.FUN-670047
           CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09      #No.CHI-6A0004
           CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10      #No.CHI-6A0004
           #No.FUN-740184  --Begin
           IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                   RETURNING l_bookno,b_oob.oob11
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                   RETURNING l_bookno,b_oob.oob111
           END IF
           #No.FUN-740184  --End  
           #FUN-960141 add
           #LET b_oob.oobplant = l_oma.omaplant    #FUN-960141 mark 090824
           LET b_oob.ooblegal = l_oma.omalegal
           #FUN-960141 end
           INSERT INTO oob_file VALUES (b_oob.*)
        END IF
      END FOREACH
   END IF

#TQC-A20043--add--str--
#----------------------------------- #由TT產生單身
   IF sw2='Y' THEN
      DECLARE t410_g_b_c12 CURSOR FOR
       SELECT nmg_file.*,npk_file.* FROM nmg_file,npk_file
        WHERE nmg00=npk00 AND nmg18=g_ooa.ooa03 AND nmg19=g_ooa.ooa032
          AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
         #AND (nmg23-nmg24>0)   #luttb
          AND nmgconf='Y'
      FOREACH t410_g_b_c12 INTO l_nmg.*,l_npk.*
        IF STATUS THEN EXIT FOREACH END IF

        IF l_nmg.nmg01 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
           CONTINUE FOREACH
        END IF

        IF g_ooa.ooa23 IS NOT NULL AND l_npk.npk05 != g_ooa.ooa23 THEN
           CONTINUE FOREACH
        END IF
        #須考慮未確認沖帳資料
        SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file,ooa_file
         WHERE oob06 = l_nmg.nmg00 AND oob01 = ooa01 AND ooaconf = 'N'
               AND ooa01 != g_ooa.ooa01 AND oob15 = l_npk.npk01   #MOD-720129
        IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
        IF cl_null(l_oob10) THEN LET l_oob10=0 END IF

        SELECT MAX(oob02) INTO b_oob.oob02 FROM oob_file
         WHERE oob01 = b_oob.oob01
        IF cl_null(b_oob.oob02) THEN
           LET b_oob.oob02 = 0
        END IF
        LET b_oob.oob02=b_oob.oob02+1
        LET b_oob.oob03='2'
        LET b_oob.oob04='A'
        LET b_oob.oob06=l_nmg.nmg00
        LET b_oob.oob14=l_nmg.nmg01
        LET b_oob.oob07=l_npk.npk05    #幣別
        LET b_oob.oob08=l_npk.npk06    #匯率
        LET b_oob.oob15=l_npk.npk01
        LET b_oob.oob20= 'N'
        LET b_oob.oob17=l_npk.npk04    #銀行編號
        LET b_oob.oob18=l_npk.npk02    #銀存異動碼
        SELECT nmc05 INTO b_oob.oob21
          FROM nmc_file WHERE nmc01 = b_oob.oob18
           AND nmcacti  = 'Y'
        #原幣是否應再扣除已沖金額
        LET b_oob.oob09=l_npk.npk08 - l_nmg.nmg24 - l_oob09   #原幣入帳金額
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07
        LET b_oob.oob10=l_npk.npk09-(l_nmg.nmg24*l_npk.npk06)-l_oob10  #本幣入帳金額

        SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
        IF l_nmz20 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
           IF g_apz.apz27 = 'Y' THEN
              LET b_oob.oob08 = l_nmg.nmg09
           ELSE
                  LET b_oob.oob08 = l_npk.npk06
           END IF
           IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
              LET b_oob.oob08 = l_npk.npk06
           END IF
           CALL s_g_np('3','2',b_oob.oob06,b_oob.oob15)
                RETURNING tot3
           IF (l_oob09+b_oob.oob09+l_nmg.nmg24) = l_nmg.nmg23 THEN
              LET b_oob.oob10 = tot3 - l_oob10
           END IF
        END IF

        CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09
        CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10
           IF l_nmg.nmg29='Y' THEN
              LET b_oob.oob11=l_npk.npk071   #會計科目
              IF g_aza.aza63='Y' THEN
                 LET b_oob.oob111=l_npk.npk072
              END IF
           ELSE
              LET b_oob.oob11=l_npk.npk07    #會計科目
              IF g_aza.aza63='Y' THEN
                 LET b_oob.oob111=l_npk.npk073
              END IF
           END IF
        CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2
        IF g_flag='1' THEN
           CALL cl_err(l_nmg.nmg01,'aoo-081',1)
        END IF
        LET l_aag05 = ''
        SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                  AND aag00=g_bookno1
        IF l_aag05 = 'Y' THEN
           LET l_gem10=s_costcenter(l_nmg.nmg11)
           IF NOT cl_null(l_gem10) THEN
              LET b_oob.oob13 = l_gem10
           ELSE
              LET b_oob.oob13 = l_nmg.nmg11
           END IF
        ELSE
           LET b_oob.oob13 = ''
        END IF
        LET b_oob.oob12 = l_npk.npk10
        LET b_oob.ooblegal = g_ooa.ooalegal
        IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN
           IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg01) THEN
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                   RETURNING l_bookno,b_oob.oob11
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                   RETURNING l_bookno,b_oob.oob111
           END IF
           LET b_oob.oob20 = 'N' #No.FUN-A40054
           INSERT INTO oob_file VALUES (b_oob.*)
        END IF
      END FOREACH
   END IF
#TQC-A20043--add--end
   CALL t410_bu()   #MOD-630069
 
END FUNCTION
 
FUNCTION t410_g_b2()
   DEFINE gen_sw        LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
   DEFINE l_sql         LIKE type_file.chr1000            #No.FUN-680123 VARCHAR(300)
   DEFINE g_wc          string                            #No.FUN-580092 HCN
   DEFINE g_sql         string                            #No.FUN-580092 HCN
   DEFINE l_oma            RECORD LIKE oma_file.*
   DEFINE l_omb            RECORD LIKE omb_file.*
   DEFINE l_omc            RECORD LIKE omc_file.*         #No.FUN-680022 --add
   DEFINE debit_tot,credit_tot    LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6) #FUN-4C0013
   DEFINE t14t,p14t      LIKE omb_file.omb14
   DEFINE t16t,p16t      LIKE omb_file.omb16
   DEFINE l_apa  RECORD LIKE apa_file.*
   DEFINE s_omab DYNAMIC ARRAY OF RECORD
                        sel       LIKE type_file.chr1,    #No.FUN-680123 VARCHAR(1),
                        omb01     LIKE omb_file.omb01,
                        omc02     LIKE omc_file.omc02,    #No.FUN-680022 --add
                        omb04     LIKE omb_file.omb04,
                        omb06     LIKE omb_file.omb06,
                        omb03     LIKE omb_file.omb03,
                        oma10     LIKE oma_file.oma10,
                        oma67     LIKE oma_file.oma67,   #FUN-810074
                        oma23     LIKE oma_file.oma23,
                        omb14t    LIKE omb_file.omb14,
                        omb16t    LIKE omb_file.omb16
                        END RECORD
   DEFINE i,j           LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE un_conf_amt1  LIKE oma_file.oma54
   DEFINE un_conf_amt2  LIKE oma_file.oma56
   #add 030311 NO.A048
   DEFINE l_oma00       LIKE oma_file.oma00
   #add 030422 NO.A058
   DEFINE l_omb34       LIKE omb_file.omb34
   DEFINE l_omb14t      LIKE omb_file.omb14t
   DEFINE ls_tmp STRING
   DEFINE l_allow_insert  LIKE type_file.num5    #No.FUN-680123 SMALLINT               #可新增否
   DEFINE l_allow_delete  LIKE type_file.num5    #No.FUN-680123 SMALLINT               #可刪除否
   DEFINE tot4,tot4t      LIKE type_file.num20_6 #No.FUN-680123 DEC(20,6)              #TQC-5B0171
   DEFINE l_aag05         LIKE aag_file.aag05   #MOD-730022
   DEFINE l_bookno        LIKE aag_file.aag00   #No.FUN-740184
 
 
   SELECT COUNT(*) INTO i FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
   IF i=0 THEN RETURN END IF
   LET p_row = 11 LET p_col = 27
   OPEN WINDOW t4008_w AT p_row,p_col WITH FORM "axr/42f/axrt4008"
    ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4008")
 
   INPUT BY NAME gen_sw
      AFTER FIELD gen_sw
          IF gen_sw NOT MATCHES "[0123]" THEN NEXT FIELD gen_sw END IF
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
   CLOSE WINDOW t4008_w
   IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
   IF gen_sw=0 THEN RETURN END IF
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
  #-------借:
   SELECT SUM(oob09) INTO debit_tot FROM oob_file
    WHERE oob01=b_oob.oob01 AND oob03='1'
   IF cl_null(debit_tot) THEN LET debit_tot= 0 END IF
   IF gen_sw='2' AND debit_tot <= 0 THEN RETURN END IF
  #-------貸:
   SELECT SUM(oob09) INTO credit_tot FROM oob_file
    WHERE oob01=b_oob.oob01 AND oob03='2'
   IF cl_null(credit_tot) THEN LET credit_tot= 0 END IF
   LET debit_tot = debit_tot - credit_tot
 #TQC-750177 begin
   IF gen_sw = 2 AND debit_tot = 0 THEN 
      RETURN 
   END IF
 #TQC-750177 end
   SELECT MAX(oob02) INTO b_oob.oob02 FROM oob_file WHERE oob01=b_oob.oob01
#MOD-940291 --begin    
    IF cl_null(b_oob.oob02) THEN 
       LET b_oob.oob02 = 0 
    END IF 	       
#MOD-940291 --end       
#   IF b_oob.oob02 < 4 OR b_oob.oob02 IS NULL THEN LET b_oob.oob02 = 4 END IF     #MOD-940291 mark
 
   MESSAGE "WAITING ....."
      DROP TABLE omab_tmp
      IF g_ooz.ooz62='N' THEN    #不衝賬至項次
         #No.TQC-5C0086  --Begin                                                                                                    
         IF g_ooz.ooz07 = 'N' THEN
            SELECT oma_file.*,omc_file.* FROM oma_file,omc_file #No.FUN-680022 --add omc_file 
#            WHERE oma03=g_ooa.ooa03 AND oma032=g_ooa.ooa032 #No.FUN-670026 mark
             WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
               AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
             # AND (oma54t>oma55 OR oma56t>oma57) AND oma00 MATCHES "1*"   #No.FUN-680022 --mark--
               AND (omc08 >omc10 OR omc09 >omc11) AND oma00 LIKE "1%"   #No.FUN-680022 --modify--
               AND oma01=omc01                                             #No.FUN-680022 --add
               AND omaconf='Y'
               AND omavoid = 'N'
              INTO TEMP omab_tmp
         ELSE                                                                                                                       
            SELECT oma_file.*,omc_file.* FROM oma_file,omc_file      #No.FUN-680022 --add omc_file
#            WHERE oma03=g_ooa.ooa03 AND oma032=g_ooa.ooa032 #No.FUN-670026 mark                                                                       
             WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
               AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
             # AND (oma54t>oma55 OR oma61>0) AND oma00 MATCHES "1*"     #No.FUN-680022 --mark-- 
               #AND (oma08 >omc10 OR omc13>0) AND oma00 LIKE "1%"     #No.FUN-680022 --modify--    #MOD-790016
               AND (omc08 >omc10 OR omc13>0) AND oma00 LIKE "1%"     #No.FUN-680022 --modify--    #MOD-790016
               AND oma01=omc01                                          #No.FUN-680022 --add
               AND omaconf='Y'    
               AND omavoid = 'N' 
              INTO TEMP omab_tmp                                                                                                    
         END IF                                                                                                                     
         #No.TQC-5C0086 --End
      ELSE                      #衝賬至項次
         #No.TQC-5C0086  --Begin                                                                                                    
         IF g_ooz.ooz07 = 'N' THEN
            SELECT oma_file.*,omb_file.* FROM oma_file,omb_file
#            WHERE oma03=g_ooa.ooa03 AND oma032=g_ooa.ooa032 #No.FUN-670026 mark
             WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
               AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
               AND omaconf='Y' AND oma01=omb01 AND omavoid='N'
               AND (oma54t>oma55 OR oma56t>oma57) AND oma00 MATCHES "1*"
              INTO TEMP omab_tmp
         ELSE                                                                                                                       
            SELECT oma_file.*,omb_file.* FROM oma_file,omb_file                                                                     
#            WHERE oma03=g_ooa.ooa03 AND oma032=g_ooa.ooa032 #No.FUN-670026 mark                                                                       
             WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
               AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
               AND omaconf='Y' AND oma01=omb01 AND omavoid='N'                                                                      
               AND (oma54t>oma55 OR oma61>0) AND oma00 MATCHES "1*"                                                                 
              INTO TEMP omab_tmp                                                                                                    
         END IF                                                                                                                     
         #No.TQC-5C0086 --End
      END IF
      IF STATUS THEN CALL cl_err('ins omab_tmp:',STATUS,1) RETURN END IF
   #--------------------------------------------- 970123 roger
   IF gen_sw='3' THEN
      LET p_row = 6 LET p_col = 3
      OPEN WINDOW t4007_w AT p_row,p_col WITH FORM "axr/42f/axrt4007"
            ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
      CALL cl_ui_locale("axrt4007")
 
      #modify 030311 NO.A048(加取oma00)
      IF g_ooz.ooz62='N' THEN        #是否沖到應收單身
         #modify 030422 NO.A058
         #No.TQC-5C0086  --Begin                                                                                                    
         IF g_ooz.ooz07 = 'N' THEN
           #No.FUN-680022 --begin-- mark
           #LET l_sql="SELECT 'N',oma01,' ',' ','',oma10,oma23,",   #MOD-490095
           #          " oma54t-oma55,oma56t-oma57,oma00,oma55,oma54t",
           #          " FROM omab_tmp",
           #          " ORDER BY oma01"
           #No.FUN-680022 --end-- mark
           #No.FUN-680022 --begin--
            #LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma23,",   #FUN-810074
            LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma67,oma23,",   #FUN-810074
                      " omc08-omc10,omc09-omc11,oma00,omc10,omc08",
                      " FROM omab_tmp",
                      " ORDER BY omc01,omc02"
           #No.FUN-680022 --end-- 
         ELSE                                                                                                                       
           #No.FUN-680022 --begin-- mark
           #LET l_sql="SELECT 'N',oma01,' ',' ','',oma10,oma23,",   #MOD-490095                                                     
           #         " oma54t-oma55,oma61,oma00,oma55,oma54t",                                                                      
           #         " FROM omab_tmp",                                                                                              
           #         " ORDER BY oma01"                 
           #No.FUN-680022 --end--   mark 
           #No.FUN-680022 --begin--
            #LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma23,",   #FUN-810074
            LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma67,oma23,",   #FUN-810074
                      " omc08-omc10,omc13,oma00,omc10,omc08",
                      " FROM omab_tmp",
                      " ORDER BY omc01,omc02"
           #NO.FUN-680022 --end-- mark
         END IF                                                                                                                     
         #No.TQC-5C0086  --End
      ELSE
         #modify 030422 NO.A058
         #No.TQC-5C0086  --Begin                                                                                                    
         IF g_ooz.ooz07 = 'N' THEN
            #LET l_sql="SELECT 'N',omb01,'',omb04,omb06,omb03,oma10,oma23,", #MOD-490095  #No.FUN-680022 --add''   #FUN-810074
            LET l_sql="SELECT 'N',omb01,'',omb04,omb06,omb03,oma10,oma67,oma23,", #MOD-490095  #No.FUN-680022 --add''   #FUN-810074
                      " omb14t-omb34,omb16t-omb35,oma00,omb34,omb14t",
                      " FROM omab_tmp",
                      " ORDER BY omb01,omb03"
         ELSE                                                                                                                       
            #LET l_sql="SELECT 'N',omb01,'',omb04,omb06,omb03,oma10,oma23,", #MOD-490095   #No.FUN-680022 --add''   #FUN-810074
            LET l_sql="SELECT 'N',omb01,'',omb04,omb06,omb03,oma10,oma67,oma23,", #MOD-490095   #No.FUN-680022 --add''   #FUN-810074
                      " omb14t-omb34,omb37,oma00,omb34,omb14t",
                      " FROM omab_tmp",   
                      " ORDER BY omb01,omb03"  
         END IF                                                                                                                     
         #No.TQC-5C0086  --End 
      END IF
      PREPARE t410_tmp FROM l_sql
      DECLARE omab_tmp_c CURSOR FOR t410_tmp
      LET i=1
      #modify 030311 NO.A048
      #modify 030422 NO.A058
      CALL s_omab.clear()
      FOREACH omab_tmp_c INTO s_omab[i].*,l_oma00,l_omb34,l_omb14t
        IF s_omab[i].oma23 != g_ooa.ooa23 THEN
           IF g_ooz.ooz62='N' THEN
             DELETE FROM omab_tmp
              WHERE oma01=s_omab[i].omb01 AND omb19=s_omab[i].omc02
           ELSE
             DELETE FROM omab_tmp
              WHERE omb01=s_omab[i].omb01 AND omb03=s_omab[i].omb03
           END IF
           INITIALIZE s_omab[i].* TO NULL
           CONTINUE FOREACH
        END IF
        #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
        LET un_conf_amt1=0 LET un_conf_amt2=0
        IF g_ooz.ooz62='Y' THEN
           SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
             FROM oob_file, ooa_file
            WHERE oob06=s_omab[i].omb01 AND oob15=s_omab[i].omb03
              AND oob03='2' AND oob09 IS NOT NULL
              AND oob01=ooa01 AND ooaconf='N'
        ELSE
           SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
             FROM oob_file, ooa_file
            WHERE oob06=s_omab[i].omb01 AND oob19=s_omab[i].omc02       #No.FUN-680022 --modify
              AND oob03='2' AND oob09 IS NOT NULL
              AND oob01=ooa01 AND ooaconf='N'
        END IF
        IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
        IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
        LET s_omab[i].omb14t=s_omab[i].omb14t-un_conf_amt1
        LET s_omab[i].omb16t=s_omab[i].omb16t-un_conf_amt2
 
        #add 030206 NO.A048
        IF g_ooz.ooz07 = 'Y' AND s_omab[i].oma23 != g_aza.aza17 THEN
           IF g_ooz.ooz62='Y' THEN      #No.FUN-680022 --add
              CALL s_g_np('1',l_oma00,s_omab[i].omb01,s_omab[i].omb03)
                   RETURNING tot3
              #modify 030422 NO.A058
              #No.TQC-5B0171 --start--
              #取得衝帳單的待扺金額
              CALL t410_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
              CALL cl_digcut(tot4,t_azi04) RETURNING tot4       #No.CHI-6A0004
              CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
              #未衝金額扣除待扺
              LET tot3 = tot3 - tot4t
              #No.TQC-5B0171 --end--
              IF (un_conf_amt1+s_omab[i].omb14t+l_omb34) = l_omb14t THEN
                 LET s_omab[i].omb16t = tot3 - un_conf_amt2
              END IF
          #No.FUN-680022 --begin-- add
          #ELSE                                
          #   CALL s_g_np('1',l_oma00,s_omab[i].omb01,s_omab[i].omc02)
          #        RETURNING tot3
          #   #取得衝帳單的待扺金額
          #   CALL t410_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
          #   CALL cl_digcut(tot4,t_azi04) RETURNING tot4                 
          #   CALL cl_digcut(tot4t,t_azi04) RETURNING tot4t
          #   #未衝金額扣除待扺
          #   LET tot3 = tot3 - tot4t
          #   IF (un_conf_amt1+s_omab[i].omb14t+l_omb34) = l_omb14t THEN
          #      LET s_omab[i].omb16t = tot3 - un_conf_amt2
          #   END IF
          #No.FUN-680022 --end--
           END IF      #No.FUN-680022 --add
        END IF
 
        IF s_omab[i].omb14t<=0 THEN
          IF g_ooz.ooz62='Y' THEN
           DELETE FROM omab_tmp
            WHERE omb01=s_omab[i].omb01 AND omb03=s_omab[i].omb03
          ELSE
           DELETE FROM omab_tmp
            WHERE oma01=s_omab[i].omb01 AND omb03=s_omab[i].omc02   #NO.FUN-680022 --add
          END IF
           INITIALIZE s_omab[i].* TO NULL
           CONTINUE FOREACH
        END IF
        LET i=i+1
      END FOREACH
 
       #MOD-490095
      CALL s_omab.deleteElement(i)
      LET i=i-1
      #--
 
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")
 
      INPUT ARRAY s_omab WITHOUT DEFAULTS FROM s_omab.*
            ATTRIBUTE(COUNT=i,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
         BEFORE FIELD sel
           LET t14t=0 LET t16t=0
           LET p14t=0 LET p16t=0
           FOR g_cnt=1 TO i
              IF s_omab[g_cnt].omb01 IS NULL THEN CONTINUE FOR END IF
              LET t14t=t14t+s_omab[g_cnt].omb14t
              LET t16t=t16t+s_omab[g_cnt].omb16t
              IF s_omab[g_cnt].sel='Y' AND s_omab[g_cnt].sel IS NOT NULL
                 AND s_omab[g_cnt].sel <>' ' THEN
                 LET p14t=p14t+s_omab[g_cnt].omb14t
                 LET p16t=p16t+s_omab[g_cnt].omb16t
              END IF
           END FOR
           DISPLAY BY NAME t14t,t16t,p14t,p16t
 
         AFTER INPUT
           FOR g_cnt=1 TO i
              IF s_omab[g_cnt].sel='Y' AND s_omab[g_cnt].sel IS NOT NULL
                 AND s_omab[i].sel <>' ' THEN
                 CONTINUE FOR
              END IF
              IF s_omab[g_cnt].omb01 IS NULL THEN CONTINUE FOR END IF
              IF g_ooz.ooz62='Y' THEN
                 DELETE FROM omab_tmp
                  WHERE omb01=s_omab[g_cnt].omb01 AND omb03=s_omab[g_cnt].omb03
              ELSE
                 DELETE FROM omab_tmp
                  WHERE oma01=s_omab[g_cnt].omb01 AND omc02=s_omab[g_cnt].omc02   #No.FUN-680022 --add
              END IF
           END FOR
 
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
 
      IF INT_FLAG THEN LET INT_FLAG=0 END IF
      CLOSE WINDOW t4007_w
   END IF
   #-------------------------------------------------------------------
  IF g_ooz.ooz62='N' THEN
     DECLARE t410_g_b_c211 CURSOR FOR                       #由應收產生單身
      SELECT * FROM omab_tmp ORDER BY oma01,omc02    #No.FUN-680022 --add
     FOREACH t410_g_b_c211 INTO l_oma.*,l_omc.*
       IF STATUS THEN EXIT FOREACH END IF
      #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
       SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
         FROM oob_file, ooa_file
        WHERE oob06=l_oma.oma01 AND oob03='2' AND oob09 IS NOT NULL
        # AND oob01=ooa01 AND ooaconf='N'                        #No.FUN-680022 --mark
          AND oob19=l_omc.omc02 AND oob01=ooa01 AND ooaconf='N'  #No.FUN-680022 --add
       IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
       IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
     # LET l_oma.oma54t=l_oma.oma54t-un_conf_amt1         #No.FUM-680022 --mark
     # LET l_oma.oma56t=l_oma.oma56t-un_conf_amt2         #No.FUM-680022 --mark
     # IF l_oma.oma54t<=0 THEN CONTINUE FOREACH END IF    #No.FUM-680022 --mark
       LET l_omc.omc08 =l_omc.omc08 -un_conf_amt1         #No.FUN-680022 --add
       LET l_omc.omc09 =l_omc.omc09 -un_conf_amt2         #No.FUN-680022 --add 
       IF l_omc.omc08 <=0 THEN CONTINUE FOREACH END IF    #No.FUN-680022 --add
       IF l_oma.oma23 != g_ooa.ooa23 THEN CONTINUE FOREACH END IF
       IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277            
       LET b_oob.oob02=b_oob.oob02+1
       LET b_oob.oob03='2'
       LET b_oob.oob04='1'
     # LET b_oob.oob06=l_oma.oma01      #No.FUN-680022 --mark
       LET b_oob.oob06=l_omc.omc01      #No.FUN-680022 --add
       LET b_oob.oob19=l_omc.omc02      #No.FUN-680022 --add
       LET b_oob.oob14=l_oma.oma10
       LET b_oob.oob07=l_oma.oma23
       LET b_oob.oob08=l_oma.oma24
     # LET b_oob.oob09=l_oma.oma54t-l_oma.oma55     #No.FUN-680022 --mark
     # LET b_oob.oob10=l_oma.oma56t-l_oma.oma57     #No.FUN-680022 --mark
       LET b_oob.oob09=l_omc.omc08 -l_omc.omc10     #No.FUN-680022 --add
       LET b_oob.oob10=l_omc.omc09 -l_omc.omc11     #No.FUN-680022 --add
       #No.TQC-5C0086  --Begin                                                                                                      
     # CALL s_ar_oox03(l_oma.oma01) RETURNING g_net #No.FUN-680022 --mark
       CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net #No.FUN-680022 --add #No.FUN-7B0055 
       LET b_oob.oob10 = b_oob.oob10 + g_net                                                                                        
       #No.TQC-5C0086  --End
       #FUN-960141 add
       #LET b_oob.oobplant = l_oma.omaplant    #FUN-960141 mark 090824
       LET b_oob.ooblegal = l_oma.omalegal
       #FUN-960141 end
       LET b_oob.oob11=l_oma.oma18
       IF g_aza.aza63='Y' THEN          #No.FUN-670047
          LET b_oob.oob111=l_oma.oma181 #No.FUN-670047
       END IF                           #No.FUN-670047
       #-----MOD-730022---------
       #LET b_oob.oob13=l_oma.oma15
       #No.FUN-740184  --Begin
       CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2
       IF g_flag='1' THEN
          CALL cl_err(l_oma.oma02,'aoo-081',1)
       END IF
       #No.FUN-740184  --End  
       LET l_aag05 = ''
       SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                 AND aag00=g_bookno1      #No.FUN-730073
       IF l_aag05 = 'Y' THEN
          LET b_oob.oob13 = l_oma.oma15
       ELSE
          LET b_oob.oob13 = ''
       END IF
       #-----END MOD-730022-----
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 recuva
#       SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 add #MOD-940238 mark
       IF gen_sw='2' AND debit_tot < b_oob.oob09 THEN
          LET b_oob.oob09 = debit_tot
         #-----97/07/23 modify by sophia
        #No.FUN-680022--begin-- --mark
        #IF b_oob.oob09 = l_oma.oma54t THEN
        #   LET b_oob.oob10 = l_oma.oma56t
        #No.FUN-680022--end-- --mark
        #No.FUN-680022--begin-- add
         IF b_oob.oob09 = l_omc.omc08  THEN
            LET b_oob.oob10 = l_omc.omc09 
        #No.FUN-680022--end-- add
         ELSE
            LET b_oob.oob10 = debit_tot * b_oob.oob08
         END IF
       END IF
       #add 030206 NO.A048
       IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
         #No.FUN-680022--begin--
             IF g_apz.apz27 = 'Y' THEN                 #MOD-940277
               LET b_oob.oob08 = l_omc.omc07
             ELSE                                      #MOD-940277
             	 LET b_oob.oob08 = l_oma.oma24           #MOD-940277
             END IF                                    #MOD-940277	   
             IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
                LET b_oob.oob08 = l_oma.oma24
             END IF
             #CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob19)  #No.FUN-7B0055
             CALL s_g_np1('1',l_oma.oma00,b_oob.oob06,'',b_oob.oob19)  #No.FUN-7B0055
                  RETURNING tot3
             #modify 030422 NO.A058
             #No.TQC-5B0171 --start--
             #發票待扺針對整張衝帳單,先不考慮ooz62='Y'的情形
             #取得衝帳單的待扺金額
             CALL t410_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
             CALL cl_digcut(tot4,t_azi04) RETURNING tot4    #No.CHI-6A0004
             CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t  #No.CHI-6A0004
             #未衝金額扣除待扺
             LET tot3 = tot3 - tot4t
             #No.TQC-5B0171 --end--
             IF (un_conf_amt1+b_oob.oob09+l_omc.omc10) = l_omc.omc08  THEN
                LET b_oob.oob10 = tot3 - un_conf_amt2
             END IF
         #No.FUN-680022--end--
         #No.FUN-680022--begin--  mark
         #   LET b_oob.oob08 = l_oma.oma60
         #   IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
         #      LET b_oob.oob08 = l_oma.oma24
         #   END IF
         #   CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob15)
         #        RETURNING tot3
         #   #modify 030422 NO.A058
         #   #No.TQC-5B0171 --start--
         #   #發票待扺針對整張衝帳單,先不考慮ooz62='Y'的情形
         #   #取得衝帳單的待扺金額
         #   CALL t410_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
         #   CALL cl_digcut(tot4,t_azi04) RETURNING tot4
         #   CALL cl_digcut(tot4t,t_azi04) RETURNING tot4t
         #   #未衝金額扣除待扺
         #   LET tot3 = tot3 - tot4t
         #   #No.TQC-5B0171 --end--
         #   IF (un_conf_amt1+b_oob.oob09+l_oma.oma55) = l_oma.oma54t THEN
         #      LET b_oob.oob10 = tot3 - un_conf_amt2
         #   END IF
         #No.FUN-680022--end-- mark
       END IF
 
#      CALL cl_digcut(b_oob.oob08,t_azi07) RETURNING b_oob.oob08     #No.MOD-910070 #MOD-940238 mark
       CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004
       CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004 
       #No.FUN-740184  --Begin
       IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
          CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
               RETURNING l_bookno,b_oob.oob11
          CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
               RETURNING l_bookno,b_oob.oob111
       END IF
       #No.FUN-740184  --End  
       INSERT INTO oob_file VALUES (b_oob.*)
       LET debit_tot=debit_tot - b_oob.oob09
       IF gen_sw='2' AND debit_tot <= 0 THEN EXIT FOREACH END IF
     END FOREACH
  ELSE
     DECLARE t410_g_b_c212 CURSOR FOR                       #由應收產生單身
      SELECT * FROM omab_tmp ORDER BY omb01,omb03
     FOREACH t410_g_b_c212 INTO l_oma.*,l_omb.*
       IF STATUS THEN EXIT FOREACH END IF
      #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
       SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
         FROM oob_file, ooa_file
        WHERE oob06=l_omb.omb01 AND oob15=l_omb.omb03
          AND oob03='2' AND oob09 IS NOT NULL
          AND oob01=ooa01 AND ooaconf='N'
       IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
       IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
       LET l_omb.omb14t=l_omb.omb14t-un_conf_amt1
       LET l_omb.omb16t=l_omb.omb16t-un_conf_amt2
       IF l_omb.omb14t<=0 THEN CONTINUE FOREACH END IF
       IF l_oma.oma23 != g_ooa.ooa23 THEN CONTINUE FOREACH END IF
       IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277            
       LET b_oob.oob02=b_oob.oob02+1
       LET b_oob.oob03='2'
       LET b_oob.oob04='1'
       LET b_oob.oob06=l_oma.oma01
       LET b_oob.oob14=l_oma.oma10
       LET b_oob.oob07=l_oma.oma23
       LET b_oob.oob08=l_oma.oma24
       LET b_oob.oob09=l_omb.omb14t-l_omb.omb34
       LET b_oob.oob10=l_omb.omb16t-l_omb.omb35
       LET b_oob.oob11=l_oma.oma18
       IF g_aza.aza63='Y' THEN          #No.FUN-670047
          LET b_oob.oob111=l_oma.oma181 #No.FUN-670047
       END IF                           #No.FUN-670047
       #-----MOD-730022---------
       #LET b_oob.oob13=l_oma.oma15
       #No.FUN-740184  --Begin
       CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2
       IF g_flag='1' THEN
          CALL cl_err(l_oma.oma02,'aoo-081',1)
       END IF
       #No.FUN-740184  --End  
       #FUN-960141 add
       #LET b_oob.oobplant = l_oma.omaplant    #FUN-960141 mark 090824
       LET b_oob.ooblegal = l_oma.omalegal
       #FUN-960141 end
       LET l_aag05 = ''
       SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                 AND aag00=g_bookno1      #No.FUN-730073
       IF l_aag05 = 'Y' THEN
          LET b_oob.oob13 = l_oma.oma15
       ELSE
          LET b_oob.oob13 = ''
       END IF
       #-----END MOD-730022-----
       LET b_oob.oob15=l_omb.omb03
       SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 recuva
#      SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 add  #MOD-940238 amrk
       IF gen_sw='2' AND debit_tot < b_oob.oob09 THEN
          LET b_oob.oob09 = debit_tot
         #-----97/07/23 modify by sophia
          IF b_oob.oob09 = l_omb.omb14t THEN
             LET b_oob.oob10 = l_omb.omb16t
          ELSE
             LET b_oob.oob10 = debit_tot * b_oob.oob08
          END IF
       END IF
       #add 030206 NO.A048
       IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
          IF g_apz.apz27 = 'Y' THEN                #MOD-940277
             LET b_oob.oob08 = l_oma.oma60
          ELSE                                     #MOD-940277
          	 LET b_oob.oob08 = l_oma.oma24         #MOD-940277
          END IF                                   #MOD-940277	    
          IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
             LET b_oob.oob08 = l_oma.oma24
          END IF
          CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob15)
               RETURNING tot3
          #modify 030422 NO.A058
          IF (un_conf_amt1+b_oob.oob09+l_omb.omb34) = l_omb.omb14t THEN
             LET b_oob.oob10 = tot3 - un_conf_amt2
          END IF
       END IF
 
#      CALL cl_digcut(b_oob.oob08,t_azi07) RETURNING b_oob.oob08      #No.MOD-910070 #MOD-940238 MARK
       CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09      #No.CHI-6A0004
       CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10      #No.CHI-6A0004
       #No.FUN-740184  --Begin
       IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
          CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
               RETURNING l_bookno,b_oob.oob11
          CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
               RETURNING l_bookno,b_oob.oob111
       END IF
       #No.FUN-740184  --End  
       INSERT INTO oob_file VALUES (b_oob.*)
       LET debit_tot=debit_tot - b_oob.oob09
       IF gen_sw='2' AND debit_tot <= 0 THEN EXIT FOREACH END IF
     END FOREACH
  END IF
   #-------------------------------------------------------------------
   DROP TABLE omab_tmp   #TQC-620114
   CALL t410_bu()
   CALL t410_b_fill(' 1=1')
   CALL t410_b_fill_2('1=1') #FUN-A90003 Add
END FUNCTION
 
FUNCTION t410_u()
   DEFINE l_yy,l_mm   LIKE type_file.num5               #No.FUN-680123 SMALLINT
   DEFINE l_occ       RECORD LIKE occ_file.*     #MOD-B30387 wangxin add
 
   IF s_shut(0) THEN RETURN END IF
   IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0) RETURN
   END IF
   IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
 
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_ooa_o.* = g_ooa.*
    LET g_success = 'Y'   #MOD-730060
    BEGIN WORK
 
    OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
    IF STATUS THEN
       CALL cl_err("OPEN t410_cl:", STATUS, 1)
       CLOSE t410_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t410_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
        CLOSE t410_cl ROLLBACK WORK RETURN
    END IF
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
    CALL t410_show()
    WHILE TRUE
        LET g_ooa.ooamodu=g_user                # 不可改單號,客戶...
        LET g_ooa.ooadate=g_today
         #No.FUN-8A0075--BEGIN--                                                                                                       
      IF g_ooa.ooa34 matches '[Ss]' THEN
         CALL cl_set_comp_entry("ooa14,ooa02,ooa15,ooa03",FALSE)
      ELSE
         CALL cl_set_comp_entry("ooa14,ooa02,ooa15,ooa03",TRUE) 
      END IF
#No.MOD-B30387---add-BEGIN----
       LET g_cnt = 0
       SELECT COUNT(*) INTO g_cnt FROM oob_file WHERE oob01=g_ooa.ooa01
       IF cl_null(g_cnt) THEN LET g_cnt=0 END IF
       CALL cl_set_comp_entry("ooa03",g_cnt=0)
#No.MOD-B30387---add-END------
        INPUT BY NAME g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa13,g_ooa.ooa14,g_ooa.ooa15,  #MOD-B30387 add ooa03
                      g_ooa.ooa23,
                      g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,
                      g_ooa.ooaud04,g_ooa.ooaud05,g_ooa.ooaud06,
                      g_ooa.ooaud07,g_ooa.ooaud08,g_ooa.ooaud09,
                      g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
                      g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15 
                      WITHOUT DEFAULTS
       #FUN-850038     ----end----
 
           AFTER FIELD ooa02
             IF g_ooa.ooa34 NOT matches '[Ss]' THEN    #FUN-8A0075
             IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
                CALL cl_err('','axr-164',0) NEXT FIELD ooa02
             END IF
             #add by danny 020313 期末調匯(A008)
             IF g_ooz.ooz07 = 'Y' THEN
                LET l_yy = YEAR(g_ooa.ooa02)
                LET l_mm = MONTH(g_ooa.ooa02)
                #IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) > 1 THEN
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) < 1 THEN  #MOD-8B0213
                   CALL cl_err(g_ooa.ooa02,'axr-405',0)
                   NEXT FIELD ooa02   #MOD-830047
                END IF
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) = 0 THEN
                   CALL cl_err(g_ooa.ooa02,'axr-406',0) NEXT FIELD ooa02
                END IF
             END IF
             #No.+043 010402 by plum add
             LET g_cnt=0
             SELECT COUNT(*) INTO g_cnt FROM oob_file,oma_file
             #No.+3974 plum
             #WHERE ( YEAR(oma02) != YEAR(g_ooa.ooa02)
            #str MOD-880174 mod
            # WHERE ( YEAR(oma02) > YEAR(g_ooa.ooa02)
            ##..end
            #    OR  (YEAR(oma02) = YEAR(g_ooa.ooa02)
            #   AND  MONTH(oma02) > MONTH(g_ooa.ooa02) ))
              WHERE oma02 > g_ooa.ooa02
            #end MOD-880174 mod
                AND oob03='2' AND oob04='1' AND oob06=oma01
                AND oob06 IS NOT NULL
                AND oob01=g_ooa.ooa01
             IF g_cnt >0 AND g_cnt IS NOT NULL THEN
                CALL cl_err('','axr-371',0)
                LET g_ooa.ooa02 = g_ooa_t.ooa02
                DISPLAY BY NAME g_ooa.ooa02
                NEXT FIELD ooa02
                #NO.FUN-730073---begin---                                                                                              
                 CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                                   
                      RETURNING g_flag,g_bookno1,g_bookno2                                                                              
                 IF g_flag = '1' THEN     #抓不到帳別                                                                                   
                    CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                                 
                    NEXT FIELD ooa02                                                                                                     
                 END IF                                                                                                                 
                #NO.FUN-730073---end---   
             END IF
            #No.+043 ..end
             END IF    #FUN-8A0075
           #MOD-B30278 wangxin add ---begin---
           AFTER FIELD ooa03
              IF NOT cl_null(g_ooa.ooa03) THEN
                 SELECT * INTO l_occ.* FROM occ_file
                  WHERE occ01=g_ooa.ooa03 AND occacti='Y'
                    AND (occ06='1' OR occ06='3')
                 IF STATUS THEN
                    CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","select occ",1)  #No.FUN-660116
                    NEXT FIELD ooa03
                 END IF
                 IF l_occ.occacti = 'N' THEN
                    CALL cl_err(l_occ.occ01,'9028',0) NEXT FIELD ooa03
                 END IF
                 #LET g_ooa.ooa23 = l_occ.occ42 
                 #add by andy 2017/4/21 11:13:04----s-------
                 IF l_occ.occ03 MATCHES '[BCEF]' THEN
                 	 LET g_ooa.ooa23 = 'USD'
                 ELSE
                   LET g_ooa.ooa23 = l_occ.occ42 
                 END IF
                 #add by andy 2017/4/21 11:13:04----e-------
                 DISPLAY BY NAME g_ooa.ooa23
                 IF g_ooa.ooa03 != 'MISC' THEN
                    LET g_ooa.ooa032 = l_occ.occ02 DISPLAY BY NAME g_ooa.ooa032
                 END IF
              END IF
           #MOD-B30278 wangxin add ----end----
           AFTER FIELD ooa13
                 IF NOT cl_null(g_ooa.ooa13) THEN
                    SELECT COUNT(*) INTO g_cnt FROM ool_file WHERE ool01=g_ooa.ooa13
                    IF g_cnt=0 THEN
                       CALL cl_err('ool_file',100,0) NEXT FIELD ooa13
                    END IF
                 END IF
           AFTER FIELD ooa14
                 IF NOT cl_null(g_ooa.ooa14) THEN
                    SELECT gen03 INTO g_buf FROM gen_file
                           WHERE gen01=g_ooa.ooa14
                    IF STATUS THEN
#                      CALL cl_err('select gen',STATUS,0)    #No.FUN-660116
                       CALL cl_err3("sel","gen_file",g_ooa.ooa14,"",STATUS,"","select gen",1)  #No.FUN-660116
                       NEXT FIELD ooa14
                    END IF
                  # IF cl_null(g_ooa.ooa15) THEN   #No.FUN-560122 Mark
                       LET g_ooa.ooa15=g_buf  DISPLAY By NAME g_ooa.ooa15
                  # END IF
                 END IF
          AFTER FIELD ooa15
                IF NOT cl_null(g_ooa.ooa15) THEN
                   SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_ooa.ooa15
                         AND gemacti='Y'   #NO:6950
                   IF STATUS THEN
#                     CALL cl_err('select gem',STATUS,0)   #No.FUN-660116
                      CALL cl_err3("sel","gem_file",g_ooa.ooa15,"",STATUS,"","select gem",1)  #No.FUN-660116
                      NEXT FIELD ooa15 
                   END IF
                END IF
         AFTER FIELD ooa23
                IF NOT cl_null(g_ooa.ooa23) THEN
                   SELECT azi02,azi03,azi04 INTO g_buf,t_azi03,t_azi04   #No.CHI-6A0004
                          FROM azi_file WHERE azi01=g_ooa.ooa23
                   IF STATUS THEN
#                     CALL cl_err('select azi',STATUS,0)    #No.FUN-660116
                      CALL cl_err3("sel","azi_file",g_ooa.ooa23,"",STATUS,"","select azi",1)  #No.FUN-660116
                      NEXT FIELD ooa23
                   END IF
                END IF
 
      #FUN-850038     ---start---
        AFTER FIELD ooaud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        #FUN-850038     ----end----
 
         ON ACTION CONTROLP
            CASE 
                 #MOD-B30278 wangxin add ---begin---
                 WHEN INFIELD(ooa03)
                       CALL cl_init_qry_var()
                       LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                       LET g_qryparam.default1 = g_ooa.ooa03
                       CALL cl_create_qry() RETURNING g_ooa.ooa03
                       DISPLAY BY NAME g_ooa.ooa03
                       NEXT FIELD ooa03
                 #MOD-B30278 wangxin add ----end---- 
                 WHEN INFIELD(ooa13)
                       CALL cl_init_qry_var()
                       LET g_qryparam.form = "q_ool"
                       LET g_qryparam.default1 = g_ooa.ooa13
                       CALL cl_create_qry() RETURNING g_ooa.ooa13
#                       CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa13 )
                       DISPLAY BY NAME g_ooa.ooa13
                       NEXT FIELD ooa13
                  WHEN INFIELD(ooa14)
                       CALL cl_init_qry_var()
                       LET g_qryparam.form = "q_gen"
                       LET g_qryparam.default1 = g_ooa.ooa14
                       CALL cl_create_qry() RETURNING g_ooa.ooa14
#                       CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa14 )
                       DISPLAY BY NAME g_ooa.ooa14
                       NEXT FIELD ooa14
                   WHEN INFIELD(ooa15)
                       CALL cl_init_qry_var()
                       LET g_qryparam.form = "q_gem"
                       LET g_qryparam.default1 = g_ooa.ooa15
                       CALL cl_create_qry() RETURNING g_ooa.ooa15
#                       CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa15 )
                       DISPLAY BY NAME g_ooa.ooa15
 #                       NEXT FIELD ooa15a   #MOD-580270
                        NEXT FIELD ooa15   #MOD-580270
                  OTHERWISE    EXIT CASE
            END CASE
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()
 
 
        END INPUT
 
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_ooa.*=g_ooa_t.*
            CALL t410_show()
            CALL cl_err('','9001',0)
            LET g_success = 'N' #MOD-730060
            EXIT WHILE
        END IF
 
        IF g_ooa.ooa34 NOT matches '[Ss]' THEN
           LET g_ooa.ooa34 = '0'          #FUN-550049
        END IF
        UPDATE ooa_file SET * = g_ooa.* WHERE ooa01 = g_ooa.ooa01   #wujie 091021
        IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","ooa_file",g_ooa_o.ooa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
            CONTINUE WHILE
        END IF
        DISPLAY BY NAME g_ooa.ooa34
        IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
        IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
        CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
 
        EXIT WHILE
    END WHILE
    CLOSE t410_cl
    IF g_success = 'Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF   #MOD-730060
    CALL cl_flow_notify(g_ooa.ooa01,'U')
# 新增自動確認功能 Modify by Charis 96-09-23
     LET g_t1=s_get_doc_no(g_ooa.ooa01)   #NO.FUN-560060  #MOD-560077
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF STATUS THEN
       RETURN
    END IF
    IF g_ooy.ooyprit='Y' THEN CALL t410_out() END IF   #單據需立即列印
    IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
       THEN RETURN
    ELSE
       LET g_action_choice = "insert"        #FUN-640246
       CALL t410_y_chk()          #CALL 原確認的 check 段
       IF g_success = "Y" THEN
          CALL t410_y_upd()       #CALL 原確認的 update 段
       END IF
    END IF
END FUNCTION
 
#No.+085 010426 by plum
FUNCTION t410_npp02()
   IF cl_null(g_ooa.ooa33) THEN
      UPDATE npp_file SET npp02 = g_ooa.ooa02
       WHERE npp01 = g_ooa.ooa01
         AND npp011 = 1
         AND npp00 = 3
         AND nppsys = 'AR'
      IF STATUS THEN
         CALL cl_err3("upd","npp_file",g_ooa.ooa01,"",STATUS,"","upd npp02:",1)  #No.FUN-660116 
      END IF
   END IF
 
END FUNCTION
#No.+085..end
 
#處理INPUT
FUNCTION t410_i(p_cmd)
  DEFINE p_cmd           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)                #a:輸入 u:更改
  DEFINE l_flag          LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)               #判斷必要欄位是否有輸入
  DEFINE l_n1            LIKE type_file.num5               #No.FUN-680123 SMALLINT
  DEFINE l_occ           RECORD LIKE occ_file.*
  DEFINE x                         RECORD LIKE oob_file.*
  DEFINE l_yy,l_mm       LIKE type_file.num5               #No.FUN-680123 SMALLINT
  DEFINE l_ooyacti       LIKE ooy_file.ooyacti             #No.TQC-770025
 
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
    INPUT BY NAME g_ooa.ooaoriu,g_ooa.ooaorig,
        g_ooa.ooa01,g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa032,
        g_ooa.ooa35,g_ooa.ooa36,     #FUN-960141 add
        g_ooa.ooa14,g_ooa.ooa15,g_ooa.ooa23,
        #g_ooa.ooa37,g_ooa.ooa38,     #FUN-960141 add     #FUN-960140 mark
        g_ooa.ooa38,                  #FUN-960140 add
        g_ooa.ooa13,
        g_ooa.ooa33,g_ooa.ooa992,g_ooa.ooaconf,g_ooa.ooa31d,g_ooa.ooa31c,  #No.FUN-690090 add ooa992
        g_ooa.ooauser,g_ooa.ooagrup, g_ooa.ooamodu,g_ooa.ooadate,
       #FUN-850038     ---start---
        g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,g_ooa.ooaud04,
        g_ooa.ooaud05,g_ooa.ooaud06,g_ooa.ooaud07,g_ooa.ooaud08,
        g_ooa.ooaud09,g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
        g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15
       #FUN-850038     ----end----
        WITHOUT DEFAULTS
 
        BEFORE INPUT
          LET g_before_input_done = FALSE
          CALL t410_set_entry(p_cmd)
          CALL t410_set_no_entry(p_cmd)
          LET g_before_input_done = TRUE
 
        AFTER FIELD ooa01
            IF NOT cl_null(g_ooa.ooa01) THEN
                #MOD-560077
                LET g_t1=s_get_doc_no(g_ooa.ooa01) #MOD-560077
                #No.TQC-770025 --start--
                LET l_ooyacti = NULL
                SELECT ooyacti INTO l_ooyacti FROM ooy_file
                 WHERE ooyslip = g_t1
                IF l_ooyacti <> 'Y' THEN
                   CALL cl_err(g_t1,'axr-956',1)
                   NEXT FIELD ooa01
                END IF
                #No.TQC-770025 --end--
               #CALL s_check_no('axr',g_t1,"",'30',"ooa_file","ooa01","")  #MOD-460077         #MOD-8B0100 mark
                #CALL s_check_no('axr',g_ooa.ooa01,"",'30',"ooa_file","ooa01","")  #MOD-460077  #MOD-8B0100  #FUN-960140 
                CALL s_check_no('axr',g_ooa.ooa01,"",'32',"ooa_file","ooa01","")  #FUN-960140
                     RETURNING g_cnt,g_ooa.ooa01
                IF NOT g_cnt  THEN
                   LET g_ooa.ooa01=g_ooa_t.ooa01
                   NEXT FIELD ooa01
                ELSE
                   SELECT ooyapr,'0' INTO g_ooa.ooamksg,g_ooa.ooa34
                     FROM ooy_file
                    WHERE ooyslip = g_t1
                   DISPLAY BY NAME g_ooa.ooamksg,g_ooa.ooa34
                END IF
                #--
{
               LET g_t1=g_ooa.ooa01[1,3]
               CALL s_axrslip(g_t1,'30',g_sys)          #檢查單別
               IF NOT cl_null(g_errno)THEN
                  CALL cl_err(g_t1,g_errno,0)
                  NEXT FIELD ooa01
               #-----No.FUN-540046-----
               ELSE
                  SELECT ooyapr,'0' INTO g_ooa.ooamksg,g_ooa.ooa34
                    FROM ooy_file
                   WHERE ooyslip = g_t1
                  DISPLAY BY NAME g_ooa.ooamksg,g_ooa.ooa34
               #-----No.FUN-540046-----
               END IF
               IF p_cmd = 'a' AND cl_null(g_ooa.ooa01[5,10]) AND g_ooy.ooyauno = 'N'
               THEN NEXT FIELD ooa01
               END IF
               IF g_ooa.ooa01 != g_ooa_t.ooa01 OR g_ooa_t.ooa01 IS NULL THEN
                   IF g_ooy.ooyauno = 'Y' AND NOT cl_chk_data_continue(g_ooa.ooa01[5,10]) THEN
                      CALL cl_err('','9056',0) NEXT FIELD ooa01
                   END IF
                   SELECT count(*) INTO g_cnt FROM ooa_file
                    WHERE ooa01 = g_ooa.ooa01
                   IF g_cnt > 0 THEN   #資料重複
                      CALL cl_err(g_ooa.ooa01,-239,0)
                      LET g_ooa.ooa01 = g_ooa_t.ooa01
                      DISPLAY BY NAME g_ooa.ooa01
                      NEXT FIELD ooa01
                   END IF
               END IF
}
            END IF
 
        AFTER FIELD ooa02
          IF NOT cl_null(g_ooa.ooa01) THEN
             IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
                CALL cl_err('','axr-164',0) NEXT FIELD ooa02
             END IF
             #add by danny 020313 期末調匯(A008)
             IF g_ooz.ooz07 = 'Y' THEN
                LET l_yy = YEAR(g_ooa.ooa02)
                LET l_mm = MONTH(g_ooa.ooa02)
                #IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) > 1 THEN
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) < 1 THEN  #MOD-8B0213
                   CALL cl_err(g_ooa.ooa02,'axr-405',0)
                   NEXT FIELD ooa02   #MOD-830047
                END IF
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) = 0 THEN
                   CALL cl_err(g_ooa.ooa02,'axr-406',0) NEXT FIELD ooa02
                END IF
             END IF
             #NO.FUN-730073---begin---  
             CALL s_get_bookno(YEAR(g_ooa.ooa02))
                  RETURNING g_flag,g_bookno1,g_bookno2
             IF g_flag = '1' THEN     #抓不到帳別
               CALL cl_err(g_ooa.ooa02,'aoo-081',1)
               NEXT FIELD ooa02   
             END IF
             #NO.FUN-730073---end---
         END IF
 
       BEFORE FIELD ooa03
          CALL t410_set_entry(p_cmd)
 
       AFTER FIELD ooa03
          IF NOT cl_null(g_ooa.ooa03) THEN
             SELECT * INTO l_occ.* 
               FROM occ_file 
              WHERE occ01=g_ooa.ooa03
                AND occacti='Y'                  #No.FUN-670026
                AND (occ06 = '1' or occ06 = '3') #No.FUN-670026
             IF STATUS THEN
#               CALL cl_err('select occ',STATUS,0)   #No.FUN-660116
                CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","select occ",1)  #No.FUN-660116
                NEXT FIELD ooa03 
             END IF
             IF l_occ.occacti = 'N' THEN
                CALL cl_err(l_occ.occ01,'9028',0) NEXT FIELD ooa03
             END IF
             IF g_ooa.ooa23 IS NULL THEN
                #LET g_ooa.ooa23 = l_occ.occ42 
                #add by andy 2017/4/21 11:13:04----s-------
                 IF l_occ.occ03 MATCHES '[BCEF]' THEN
                 	 LET g_ooa.ooa23 = 'USD'
                 ELSE
                   LET g_ooa.ooa23 = l_occ.occ42 
                 END IF
                 #add by andy 2017/4/21 11:13:04----e-------
                DISPLAY BY NAME g_ooa.ooa23
             END IF
             IF g_ooa.ooa03 != 'MISC' THEN
                LET g_ooa.ooa032 = l_occ.occ02 DISPLAY BY NAME g_ooa.ooa032
             END IF
          END IF
          CALL t410_set_no_entry(p_cmd)
 
 
       AFTER FIELD ooa13
          IF NOT cl_null(g_ooa.ooa13) THEN
             SELECT COUNT(*) INTO g_cnt FROM ool_file  WHERE ool01=g_ooa.ooa13
             IF g_cnt=0 THEN
                CALL cl_err('ool_file',100,0) NEXT FIELD ooa13
             END IF
          END IF
 
       AFTER FIELD ooa14
          IF NOT cl_null(g_ooa.ooa14) THEN
             SELECT gen03 INTO g_buf FROM gen_file WHERE gen01=g_ooa.ooa14
             IF STATUS THEN
#               CALL cl_err('select gen',STATUS,0)    #No.FUN-660116
                CALL cl_err3("sel","gen_file",g_ooa.ooa14,"",STATUS,"","select gen",1)  #No.FUN-660116
                NEXT FIELD ooa14
             END IF
          #  IF cl_null(g_ooa.ooa15) THEN  #No.FUN-560122 Mark
                LET g_ooa.ooa15=g_buf  DISPLAY By NAME g_ooa.ooa15
          #  END IF
          END IF
 
       AFTER FIELD ooa15
          IF NOT cl_null(g_ooa.ooa15) THEN
             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_ooa.ooa15
                AND gemacti='Y'   #NO:6950
             IF STATUS THEN
#               CALL cl_err('select gem',STATUS,0)    #No.FUN-660116
                CALL cl_err3("sel","gem_file",g_ooa.ooa15,"",STATUS,"","select gem",1)  #No.FUN-660116
                NEXT FIELD ooa15
             END IF
          END IF
 
       AFTER FIELD ooa23
          IF NOT cl_null(g_ooa.ooa23) THEN
             SELECT azi02,azi03,azi04 INTO g_buf,t_azi03,t_azi04    #No.CHI-6A0004
                 FROM azi_file WHERE azi01=g_ooa.ooa23
             IF STATUS THEN
#               CALL cl_err('select azi',STATUS,0)    #No.FUN-660116
                CALL cl_err3("sel","azi_file",g_ooa.ooa23,"",STATUS,"","select azi",1)  #No.FUN-660116
                NEXT FIELD ooa23
             END IF
          END IF
 
      #FUN-850038     ---start---
        AFTER FIELD ooaud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        #FUN-850038     ----end----
 
       AFTER INPUT   #97/05/22 modify
          IF INT_FLAG THEN EXIT INPUT END IF
 
         ON ACTION CONTROLP     #ok
            CASE
               #95/11/10 by danny (單別查詢)
               WHEN INFIELD(ooa01)
                    #CALL q_ooy( FALSE, TRUE, g_ooa.ooa01,'30',g_sys)  #TQC-670008
                    #CALL q_ooy( FALSE, TRUE, g_ooa.ooa01,'30','AXR')   #TQC-670008  #FUN-960140 
                    CALL q_ooy( FALSE, TRUE, g_ooa.ooa01,'32','AXR')    #FUN-960140 
                    RETURNING g_t1
                   #LET g_ooa.ooa01[1,3] = g_t1
                     LET g_ooa.ooa01 = g_t1  #MOD-560077
                    DISPLAY BY NAME g_ooa.ooa01
                    NEXT FIELD ooa01
               WHEN INFIELD(ooa03)
                    CALL cl_init_qry_var()
#                   LET g_qryparam.form = "q_occ"     #No.FUN-670026 mark
                    LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                    LET g_qryparam.default1 = g_ooa.ooa03
                    CALL cl_create_qry() RETURNING g_ooa.ooa03
#                    CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa03 )
                    DISPLAY BY NAME g_ooa.ooa03
                    NEXT FIELD ooa03
               WHEN INFIELD(ooa13)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_ool"
                    LET g_qryparam.default1 = g_ooa.ooa13
                    CALL cl_create_qry() RETURNING g_ooa.ooa13
#                    CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa13 )
                    DISPLAY BY NAME g_ooa.ooa13
                    NEXT FIELD ooa13
               WHEN INFIELD(ooa14)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_ooa.ooa14
                    CALL cl_create_qry() RETURNING g_ooa.ooa14
#                    CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa14 )
                    DISPLAY BY NAME g_ooa.ooa14
                    NEXT FIELD ooa14
               WHEN INFIELD(ooa15)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem"
                    LET g_qryparam.default1 = g_ooa.ooa15
                    CALL cl_create_qry() RETURNING g_ooa.ooa15
#                    CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa15 )
                    DISPLAY BY NAME g_ooa.ooa15
                    NEXT FIELD ooa15
               WHEN INFIELD(ooa23)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_ooa.ooa23
                    CALL cl_create_qry() RETURNING g_ooa.ooa23
#                    CALL FGL_DIALOG_SETBUFFER( g_ooa.ooa23 )
                    DISPLAY BY NAME g_ooa.ooa23
                    NEXT FIELD ooa23
            END CASE
 
        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
       #FUN-640246
       #ON ACTION CONTROLO                        # 沿用所有欄位
       #    IF INFIELD(ooa01) THEN
       #        LET g_ooa.* = g_ooa_t.*
       #        CALL t410_show()
       #        NEXT FIELD ooa01
       #    END IF
       #END FUN-640246
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
    END INPUT
END FUNCTION
 
FUNCTION t410_set_entry(p_cmd)
 DEFINE p_cmd   LIKE type_file.chr1               #No.FUN-680123 VARCHAR(01)
 
   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("ooa01",TRUE)
   END IF
   IF INFIELD(ooa03) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("ooa032",TRUE)
   END IF
   IF INFIELD(aba02) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("abauser,aba11,aba10",TRUE)
   END IF
END FUNCTION
 
FUNCTION t410_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1               #No.FUN-680123 VARCHAR(01)
 
    IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
    CALL cl_set_comp_entry("ooa01",FALSE)
    END IF
 
    IF INFIELD(ooa03) OR (NOT g_before_input_done) THEN
        IF g_ooa.ooa03 != 'MISC' THEN
           CALL cl_set_comp_entry("ooa032",FALSE)
        END IF
    END IF
END FUNCTION
 
FUNCTION t410_set_entry_1()
   CALL cl_set_comp_entry("ooa01,ooa14,ooa02,ooa15,ooa03,ooa032",TRUE)
END FUNCTION
 
FUNCTION t410_set_no_entry_1()
  IF g_ooa.ooa34 matches '[Ss]' THEN
     CALL cl_set_comp_entry("ooa01,ooa14,ooa02,ooa15,ooa03,ooa032",FALSE)
  END IF
END FUNCTION
FUNCTION t410_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_ooa.* TO NULL               #No.FUN-6B0042
   #MESSAGE ""
    CALL cl_msg("")                          #FUN-640246
 
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL t410_show0()     #FUN-960141 add
    CALL t410_cs()
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_ooa.* TO NULL RETURN 
    END IF
   #MESSAGE " SEARCHING ! "
    CALL cl_msg(" SEARCHING ! ")                              #FUN-640246
 
    OPEN t410_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_ooa.* TO NULL
    ELSE
        OPEN t410_count
        FETCH t410_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL t410_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
   #MESSAGE ""
    CALL cl_msg("")                              #FUN-640246
 
END FUNCTION
 
FUNCTION t410_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),               #處理方式
    l_abso          LIKE type_file.num10              #No.FUN-680123 INTEGER                #絕對的筆數
 
    CASE p_flag
#wujie 091021 --begin
        WHEN 'N' FETCH NEXT     t410_cs INTO g_ooa.ooa01
        WHEN 'P' FETCH PREVIOUS t410_cs INTO g_ooa.ooa01
        WHEN 'F' FETCH FIRST    t410_cs INTO g_ooa.ooa01
        WHEN 'L' FETCH LAST     t410_cs INTO g_ooa.ooa01
#wujie 091021 --end
        WHEN '/'
            IF (NOT mi_no_ask) THEN
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0  ######add for prompt bug
                PROMPT g_msg CLIPPED,': ' FOR g_jump
                   ON IDLE g_idle_seconds
                      CALL cl_on_idle()
#                      CONTINUE PROMPT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
                END PROMPT
                IF INT_FLAG THEN
                    LET INT_FLAG = 0
                    EXIT CASE
                END IF
            END IF
            FETCH ABSOLUTE g_jump t410_cs INTO g_ooa.ooa01   #wujie 091021
            LET mi_no_ask = FALSE
    END CASE
 
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)
        INITIALIZE g_ooa.* TO NULL  #TQC-6B0105
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
    SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01   #wujie 091021
    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
       INITIALIZE g_ooa.* TO NULL
       RETURN
    ELSE
       LET g_data_owner = g_ooa.ooauser     #No.FUN-4C0049
       LET g_data_group = g_ooa.ooagrup     #No.FUN-4C0049
       #NO.FUN-730073---begin---                                                                                           
       CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                               
       RETURNING g_flag,g_bookno1,g_bookno2                                                                          
       IF g_flag = '1' THEN     #抓不到帳別                                                                               
       CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                            
       END IF                                                                                                             
       #NO.FUN-730073---end---  
       CALL t410_show()
    END IF
END FUNCTION
 
FUNCTION t410_show()
    LET g_ooa_t.* = g_ooa.*                #保存單頭舊值
 
    DISPLAY BY NAME g_ooa.ooa01,g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa032, g_ooa.ooaoriu,g_ooa.ooaorig,
                    g_ooa.ooa35,g_ooa.ooa36,   #FUN-960141
                    g_ooa.ooa14,g_ooa.ooa15,g_ooa.ooa23,
                    #g_ooa.ooa37,g_ooa.ooa38,   #FUN-960141  #FUN-960140 mark
                    g_ooa.ooa38,                #FUN-960140 add
                    g_ooa.ooa13,
                    g_ooa.ooa33,g_ooa.ooa992,g_ooa.ooaconf,g_ooa.ooamksg,g_ooa.ooa34,     #No.FUN-540046  #No.FUN-690090 add ooa992
                    g_ooa.ooa31d,g_ooa.ooa31c,g_ooa.ooauser,g_ooa.ooagrup,
                    g_ooa.ooamodu,g_ooa.ooadate,
                   #FUN-850038     ---start---
                    g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,g_ooa.ooaud04,
                    g_ooa.ooaud05,g_ooa.ooaud06,g_ooa.ooaud07,g_ooa.ooaud08,
                    g_ooa.ooaud09,g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
                    g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15
                   #FUN-850038     ----end----
 
    #CKP
    #FUN-550049
    IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
    ## END FUN-550049 ##
    CALL t410_show2()
    CALL t410_show_amt()
#    LET g_t1=g_ooa.ooa01[1,3]   #TQC-5A0089
    LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    CALL t410_b_fill(g_wc2)
    CALL t410_b_fill_2(g_wc3) #FUN-A90003 Add
         #CKP
    #FUN-550049
    IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
    ## END FUN-550049 ##
 
END FUNCTION
 
FUNCTION t410_show2()
     SELECT azi03,azi04 INTO t_azi03,t_azi04  #MOD-560077  #No.CHI-6A0004
                     FROM azi_file WHERE azi01=g_ooa.ooa23
END FUNCTION
FUNCTION t410_show_amt()
   LET g_ooa31_diff=g_ooa.ooa31c-g_ooa.ooa31d
   LET g_ooa32_diff=g_ooa.ooa32c-g_ooa.ooa32d
   DISPLAY BY NAME g_ooa.ooa31d,g_ooa.ooa31c,g_ooa.ooa32c,g_ooa.ooa32d,
                   g_ooa31_diff,g_ooa32_diff
END FUNCTION
 
FUNCTION t410_r()
    DEFINE l_chr,l_sure LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),
           l_n          LIKE type_file.num5               #No.FUN-680123 SMALLINT
 
    IF s_shut(0) THEN RETURN END IF
    IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooa34 matches '[Ss1]' THEN          #FUN-550049
       CALL cl_err('','mfg3557',0)
       RETURN
    END IF
 
   #-----97/05/26 modify 傳票編號不為空白,show警告訊息
    IF NOT cl_null(g_ooa.ooa33) THEN
       CALL cl_err(g_ooa.ooa01,'axr-310',0)
       RETURN
    END IF
    BEGIN WORK
    OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
    IF STATUS THEN
       CALL cl_err("OPEN t410_cl:", STATUS, 1)
       CLOSE t410_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t410_cl INTO g_ooa.*
    IF STATUS THEN 
       CALL cl_err('sel ooa',STATUS,0) 
       ROLLBACK WORK 
       RETURN 
    END IF
    CALL t410_show()
    IF cl_delh(20,16) THEN
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "ooa01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_ooa.ooa01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                            #No.FUN-9B0098 10/02/24
        MESSAGE "Delete ooa,oob,oao,npp,npp!"
        DELETE FROM ooa_file WHERE ooa01 = g_ooa.ooa01
        IF SQLCA.SQLERRD[3]=0
#            THEN CALL cl_err('No ooa deleted','',0)   #No.FUN-660116
             THEN CALL cl_err3("del","ooa_file",g_ooa.ooa01,"","","","No ooa deleted",1)  #No.FUN-660116
                ROLLBACK WORK RETURN
        END IF
        DELETE FROM oob_file WHERE oob01 = g_ooa.ooa01
        DELETE FROM npp_file WHERE npp01 = g_ooa.ooa01 AND nppsys = 'AR'
                               AND npp00 = 3  AND npp011 = 1
        DELETE FROM npq_file WHERE npq01 = g_ooa.ooa01 AND npqsys = 'AR'
                               AND npq00 = 3 AND npq011 = 1
     #FUN-B40056--add--str--
        DELETE FROM tic_file WHERE tic04 = g_ooa.ooa01
     #FUN-B40056--add--end--
        LET g_msg=TIME
        INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)     #FUN-980011 add
           VALUES ('axrt400',g_user,g_today,g_msg,g_ooa.ooa01,'delete',g_plant,g_legal) #FUN-980011 add
        CLEAR FORM
        CALL g_oob.clear()
        CALL g_oob_d.clear()
          INITIALIZE g_ooa.* TO NULL
        MESSAGE ""
        OPEN t410_count
        #FUN-B50064-add-start--
        IF STATUS THEN
           CLOSE t410_cs
           CLOSE t410_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end-- 
        FETCH t410_count INTO g_row_count
        #FUN-B50064-add-start--
        IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
           CLOSE t410_cs
           CLOSE t410_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end-- 
        DISPLAY g_row_count TO FORMONLY.cnt
        OPEN t410_cs
        IF g_curs_index = g_row_count + 1 THEN
           LET g_jump = g_row_count
           CALL t410_fetch('L')
        ELSE
           LET g_jump = g_curs_index
           LET mi_no_ask = TRUE
           CALL t410_fetch('/')
        END IF
 
    END IF
    CLOSE t410_cl
    COMMIT WORK
    CALL cl_flow_notify(g_ooa.ooa01,'D')
END FUNCTION
 
FUNCTION t410_b()
DEFINE l_ac_t          LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #未取消的ARRAY CNT
       l_row,l_col     LIKE type_file.num5,   #No.FUN-680123 SMALLINT,                     #分段輸入之行,列數
       l_n,l_cnt       LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #檢查重複用
       l_lock_sw       LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #單身鎖住否
       p_cmd           LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #處理狀態
       l_possible      LIKE type_file.num5,   #No.FUN-680123 SMALLINT, #用來設定判斷重複的可能性
       l_b2            LIKE type_file.chr1000,#No.FUN-680123 VARCHAR(30),
       l_flag          LIKE type_file.num10,  #No.FUN-680123 INTEGER,
       oob10_t         LIKE oob_file.oob10,
       l_nmh32         LIKE nmh_file.nmh32,
       l_aag07         LIKE aag_file.aag07,
       oob08_t         LIKE oob_file.oob08,  #FUN-4C0013
       oob09_t         LIKE oob_file.oob09,  #FUN-4C0013
       l_allow_insert  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可新增否
       l_allow_delete  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可刪除否
       ls_tmp          STRING,
       l_ooa34         LIKE ooa_file.ooa34,
       l_aag05         LIKE aag_file.aag05   #MOD-5B0012
DEFINE l_nmh04         LIKE nmh_file.nmh04   #FUN-660035
DEFINE l_i             LIKE type_file.num5   #TQC-6B0067
DEFINE l_oma00         LIKE oma_file.oma00   #MOD-940420
DEFINE l_apa00         LIKE apa_file.apa00   #MOD-940420
DEFINE l_ac2_t         LIKE type_file.num5   #FUN-A90003 Add
    LET l_ooa34 = g_ooa.ooa34      #FUN-550049
 
    LET g_action_choice = ""
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    #No.FUN-8A0075--BEGIN--
    #IF g_ooa.ooa34 matches '[Ss]' THEN       #FUN-550049
    #   CALL cl_err('','apm-030',0)
    #   RETURN
    #END IF
    #FUN-8A0075--END--
 
 
    CALL t410_g_b()                 #先由應收票據或TT自動產生借方單身
    CALL t410_b_fill(g_wc2)       #FUN-A90003 Add
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = " SELECT * FROM oob_file WHERE oob01=? AND oob02=? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t410_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
      LET l_ac_t = 0
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")
 
      INPUT ARRAY g_oob WITHOUT DEFAULTS FROM s_oob.*
            ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
 
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.cn3
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()
            LET g_success = 'Y'   #MOD-730060
            BEGIN WORK
 
            OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
            IF STATUS THEN
               CALL cl_err("OPEN t410_cl:", STATUS, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF
            FETCH t410_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE t410_cl 
               ROLLBACK WORK 
               RETURN
            END IF
           # IF g_oob[l_ac].oob02 IS NOT NULL THEN
            IF g_rec_b>=l_ac THEN
               LET p_cmd='u'
               LET g_oob_t.* = g_oob[l_ac].*  #BACKUP
               OPEN t410_bcl USING g_ooa.ooa01,g_oob_t.oob02
               IF STATUS THEN
                  CALL cl_err("OPEN t410_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
                  CLOSE t410_bcl
                  ROLLBACK WORK
               ELSE
                  FETCH t410_bcl INTO b_oob.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      CALL t410_b_move_to()
                  END IF
               END IF
               CALL t410_need()
               CALL t410_set_entry_b()
               CALL t410_set_entry_b_1()    #FUN-8A0075
               CALL t410_set_no_entry_b()
              #NO.FUN-680022--begin-- add
               CALL t410_set_no_entry_b1()
               CALL t410_set_entry_b1()
              #No.FUN-680022--end-- add
               CALL t410_set_no_entry_b_1()    #FUN-8A0075
               CALL cl_show_fld_cont()               #No.FUN-550037
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF
 
        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_success = 'N'   #MOD-730060
               CANCEL INSERT
            END IF
            CALL t410_b_move_back()
            #<-NO:0352--
            SELECT COUNT(*) INTO l_n FROM oob_file
             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob[l_ac].oob02
           #str MOD-940261 add
            IF NOT cl_null(g_oob[l_ac].oob10) THEN
               IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                  (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                  IF NOT t410_oob09_13('2',p_cmd) THEN
                  END IF
               END IF
            END IF
           #end MOD-940261 add
         #No.TQC-670085--begin-- modify
         #  IF l_n = 0 THEN                                   #<-NO:0352--
         #     IF g_oob[l_ac].oob09 = 0 AND g_oob[l_ac].oob10 = 0 THEN
         #        INITIALIZE g_oob[l_ac].* TO NULL  #重要欄位空白,無效
         #     END IF
         #  END IF
         #No.TQC-670085--end-- modify
#MOD-950129 --begin--
           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
           END IF
           IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN   
               IF NOT cl_null(g_oob[l_ac].oob15) THEN 
                  CALL t410_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,l_ac)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                     NEXT FIELD oob06
                  END IF 
               END IF 
            END IF   
           IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2' THEN
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob[l_ac].oob06 AND
                      oob15 = g_oob[l_ac].oob15 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15
                 END IF
              END IF
              IF g_oob_t.oob15 <> g_oob[l_ac].oob15 OR
                 g_oob_t.oob15 IS NULL THEN
                 CALL t410_oob06_12()
                 DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                                 g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                                 g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                                 g_oob[l_ac].oob13,g_oob[l_ac].oob14  
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob[l_ac].oob15) THEN
                 CALL t410_oob06_item()
              END IF
          END IF 
#MOD-950129 --end--                   
            INSERT INTO oob_file VALUES(b_oob.*)
            IF SQLCA.sqlcode THEN
               LET g_success = 'N'   #MOD-730060
#              CALL cl_err('ins oob',SQLCA.sqlcode,0)   #No.FUN-660116
               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  #No.FUN-660116
               CANCEL INSERT
           #-----MOD-730060---------
           #ELSE
           #   MESSAGE 'INSERT O.K'
           #   LET l_ooa34 = '0'          #FUN-550049
           #   CALL t410_mlog('A')
           #   LET g_rec_b=g_rec_b+1
           #   DISPLAY g_rec_b TO FORMONLY.cn2
           #   CALL t410_bu()
           #   COMMIT WORK
            END IF
            CALL t410_mlog('A')
            CALL t410_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'INSERT O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                  LET l_ooa34 = '0'
               END IF                                   #No.FUN-8A0075
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cn2
               COMMIT WORK
            ELSE
               MESSAGE 'INSERT ERR'
               ROLLBACK WORK
            END IF
            #-----END MOD-730060-----
        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oob[l_ac].* TO NULL      #900423
            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
                LET g_oob[l_ac].oob07=g_ooa.ooa23
            END IF
            LET b_oob.oob01=g_ooa.ooa01
            #FUN-960141 add begin
            #LET b_oob.oobplant=g_ooa.ooaplant    #FUN-960141 mark 090824
            LET b_oob.ooblegal=g_ooa.ooalegal
            #FUN-960141 add end
            LET g_oob[l_ac].oob08=1
            LET g_oob[l_ac].oob09=0
            LET g_oob[l_ac].oob10=0
            LET g_oob[l_ac].oob20='N'                 #FUN-960141
            LET g_oob_t.* = g_oob[l_ac].*             #新輸入資料
            #LET g_oob[l_ac].oob02 = 1                 #add by zhangym 120528
            LET g_oob[l_ac].oob03 = '1'               #新輸入資料
#           LET g_oob[l_ac].oob04 = '1'               #新輸入資料         #No.MOD-B30227 Mark
            LET g_oob[l_ac].oob04 = '3'               #新輸入資料         #No.MOD-B30227 add
#            LET g_oob[l_ac].oob13=g_ooa.ooa15   #MOD-5B0012
            LET g_oob_t.* = g_oob[l_ac].*             #新輸入資料   #MOD-850246 add
            CALL t410_set_entry_b()
            CALL t410_set_entry_b_1()   #FUN-8A0075
            CALL t410_set_no_entry_b()
            CALL t410_need()            #FUN-960141   
            CALL cl_show_fld_cont()     #FUN-550037(smin)
 
            NEXT FIELD oob02
 
        BEFORE FIELD oob02                            #default 序號
           IF g_oob[l_ac].oob02 IS NULL OR g_oob[l_ac].oob02 = 0 THEN
               #IF l_ac=1 THEN LET g_chr='1' END IF
                IF l_ac>1 THEN LET g_chr=g_oob[l_ac-1].oob03 END IF
               #IF g_chr IS NULL THEN LET g_chr='2' END IF
                SELECT MAX(oob02)+1 INTO g_oob[l_ac].oob02 FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 #AND oob03<=g_chr
                IF g_oob[l_ac].oob02 IS NULL THEN
                    LET g_oob[l_ac].oob02 = 1
                    #LET g_oob_t.oob02 = g_oob[l_ac].oob02    #add by zhangym 120528
                END IF
           END IF
 
        AFTER FIELD oob02                        #check 序號是否重複
            IF NOT cl_null(g_oob[l_ac].oob02) THEN
               IF g_oob[l_ac].oob02 != g_oob_t.oob02 OR g_oob_t.oob02 IS NULL THEN
                  SELECT count(*) INTO l_n FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob[l_ac].oob02
                  IF l_n > 0 THEN
                     LET g_oob[l_ac].oob02 = g_oob_t.oob02
                     CALL cl_err('',-239,0) NEXT FIELD oob02
                  END IF
               END IF
            END IF
 
        AFTER FIELD oob03
           IF NOT cl_null(g_oob[l_ac].oob03) THEN
              IF g_oob[l_ac].oob03 NOT MATCHES "[12]" THEN NEXT FIELD oob03 END IF
              CALL t410_need()    #FUN-960141 add
             #No.MOD-850161--begin--                                                                                                
                 IF NOT cl_null(g_oob[l_ac].oob04) THEN                                                                             
                    LET l_cnt = 0                                                                                                   
                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
                       WHERE ooc01 = g_oob[l_ac].oob04                                                                              
                    IF l_cnt = 0 THEN                                                                                               
                       IF g_oob[l_ac].oob03='1' THEN                                                                                
                          #FUN-960141 modify
                          #IF g_oob[l_ac].oob04 NOT MATCHES '[1-9]' THEN                                                             
                          #IF g_oob[l_ac].oob04 NOT MATCHES '[1-9,A,E,F,Q]' THEN   #FUN-A40001
                           IF g_oob[l_ac].oob04 NOT MATCHES '[1-9,A,F]' THEN   #FUN-A40001
                          #End
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04                                                                                       
                          END IF                                                                                                    
                       ELSE                                                                                                         
                          #FUN-960141 modify
                          #IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9]' THEN                                                       
                          #IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,F,Q]' THEN   #MOD-9B0043
                          #IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,Q]' THEN   #MOD-9B0043   #FUN-A40001
                           IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,A,C,D,E,Q]' THEN  #FUN-A40001
                          #End
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04                                                                                       
                          END IF                                                                                                    
                       END IF                                                                                                       
                    END IF                                                                                                          
                 END IF                                                                                                             
             #No.MOD-850161---end--- 
           END IF
 
        BEFORE FIELD oob04
           CALL t410_set_entry_b()
 
        AFTER FIELD oob04
           IF NOT cl_null(g_oob[l_ac].oob04) THEN
              CALL t410_need()    #FUN-960141 add
              #-----MOD-610050---------
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM ooc_file
                 WHERE ooc01 = g_oob[l_ac].oob04
              IF l_cnt = 0 THEN
                 IF g_oob[l_ac].oob03='1' THEN
                   #FUN-960141 modify
                   #IF g_oob[l_ac].oob04 NOT MATCHES '[1-9]' THEN
                    IF g_oob[l_ac].oob04 NOT MATCHES '[1-9,A,E,F,Q]' THEN  
                   #End
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04
                    END IF
                    #mark by zhangym 121024 begin-----
                    # IF g_oob[l_ac].oob04 = 'A' THEN  
                    #    CALL cl_err('','axr-518',0)
                    #    NEXT FIELD oob04
                    # END IF
                    #mark by zhangym 121024 end-----                    
                 ELSE
                   #FUN-960141 modify 
                   #IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9]' THEN
                   #IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,F,Q]' THEN   #MOD-9B0043
                   IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,Q]' THEN   #MOD-9B0043 
                   #End 
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04
                    END IF
                 END IF
              END IF
              #No.MOD-910070---Begin
            # SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file   #MOD-940238
              SELECT azi04 INTO t_azi04 FROM azi_file                 #MOD-940238
               WHERE azi01 = g_oob[l_ac].oob07  
              #No.MOD-910070---End 
              #-----END MOD-610050-----
             #str MOD-8B0210 add
             #若oob04='9'時,oob15預設值為0,無須維護
              IF g_oob[l_ac].oob04='9' THEN
                 LET g_oob[l_ac].oob15=0
                 DISPLAY BY NAME g_oob[l_ac].oob15
              END IF
             #end MOD-8B0210 add
              CALL s_oob04(g_oob[l_ac].oob03,g_oob[l_ac].oob04)
                   RETURNING g_oob[l_ac].oob04_d
              CALL t410_acct_code()
              IF g_oob[l_ac].oob11 IS NULL THEN
                 SELECT ooc03 INTO g_oob[l_ac].oob11 FROM ooc_file
                  WHERE ooc01=g_oob[l_ac].oob04
                 DISPLAY BY NAME g_oob[l_ac].oob11   #NO.MOD-5A0095
              END IF
             #No.FUN-670047--begin-- add
              IF g_aza.aza63='Y' THEN
                 IF g_oob[l_ac].oob111 IS NULL THEN
                    SELECT ooc04 INTO g_oob[l_ac].oob111 FROM ooc_file
                     WHERE ooc01=g_oob[l_ac].oob04
                    DISPLAY BY NAME g_oob[l_ac].oob111
                 END IF
              END IF
             #No.FUN-670047--end-- add
              IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = "7" AND
                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN
                 CALL cl_err('','axr-204',0) NEXT FIELD oob04
              END IF
              IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 MATCHES "[567]" AND
                 g_oob[l_ac].oob09 = 0   AND g_oob[l_ac].oob10 = 0 THEN
                 LET g_oob[l_ac].oob07 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob[l_ac].oob08 = 1
                    ELSE LET g_oob[l_ac].oob08 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob[l_ac].oob09 = g_ooa31_diff
                 LET g_oob[l_ac].oob10 = g_ooa32_diff
#                LET g_oob[l_ac].oob08 = cl_digcut(g_oob[l_ac].oob08,t_azi07)  #MOD-910070 add  #MOD-940238 MARK
                 LET g_oob[l_ac].oob09 = cl_digcut(g_oob[l_ac].oob09,t_azi04)  #MOD-910070 add 
                 LET g_oob[l_ac].oob10 = cl_digcut(g_oob[l_ac].oob10,g_azi04)  #No.CHI-6A0004
		 DISPLAY BY NAME g_oob[l_ac].oob08   #NO.MOD-5A0095
		 DISPLAY BY NAME g_oob[l_ac].oob09   #NO.MOD-5A0095
		 DISPLAY BY NAME g_oob[l_ac].oob10   #NO.MOD-5A0095
              END IF
              IF g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 MATCHES "[23]" AND
                 g_oob[l_ac].oob09 = 0   AND g_oob[l_ac].oob10 = 0 THEN
                 LET g_oob[l_ac].oob07 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob[l_ac].oob08 = 1
                    ELSE LET g_oob[l_ac].oob08 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob[l_ac].oob09 = -g_ooa31_diff
                 LET g_oob[l_ac].oob10 = -g_ooa32_diff
#                LET g_oob[l_ac].oob08 = cl_digcut(g_oob[l_ac].oob08,t_azi07)  #MOD-910070 add #MOD-940238 MARK
                 LET g_oob[l_ac].oob09 = cl_digcut(g_oob[l_ac].oob09,t_azi04)  #MOD-910070 add 
                 LET g_oob[l_ac].oob10 = cl_digcut(g_oob[l_ac].oob10,g_azi04)  #No.CHI-6A0004
	         DISPLAY BY NAME g_oob[l_ac].oob08   #NO.MOD-5A0095
	         DISPLAY BY NAME g_oob[l_ac].oob09   #NO.MOD-5A0095
	         DISPLAY BY NAME g_oob[l_ac].oob10   #NO.MOD-5A0095
              END IF
         END IF
         CALL t410_set_no_entry_b()
         CALL t410_set_no_entry_b1()           #No.FUN-680022  
         CALL t410_set_entry_b1()              #No.FUN-680022  
 
#No.MOD-B30255  ----begin---
        BEFORE FIELD oob11
           CALL cl_set_comp_entry("oob11",TRUE)
           IF g_oob[l_ac].oob04 = '3' AND (NOT cl_null(g_oob[l_ac].oob11)) THEN 
              CALL cl_set_comp_entry("oob11",FALSE)
           END IF 
#No.MOD-B30255  ---end---
 
        AFTER FIELD oob06
           IF NOT cl_null(g_oob[l_ac].oob06) THEN
               #IF (g_oob_t.oob06 != g_oob[l_ac].oob06) OR (g_oob_t.oob04 != g_oob[l_ac].oob04) THEN   #No.MOD-530346
               #NO.MOD-570198
             #No.FUN-680022 --begin-- 
             #若為借方，且非待扺
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 != '3' THEN
                 IF (p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06 OR
                       g_oob_t.oob04 != g_oob[l_ac].oob04) THEN   #No.MOD-530346
                    CALL t410_oob06()
 
                    IF g_errno = 'N' THEN
                       NEXT FIELD oob06
                    END IF
                 END IF
              END IF
             #No.FUN-680022--end-- 
 
              #FUN-660035 --add start
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
                  WHERE nmh01 = g_oob[l_ac].oob06
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob[l_ac].oob06
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE oma00 MATCHES '2*'
                    AND oma01 = g_oob[l_ac].oob06 
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'1*'
                    AND apa01 = g_oob[l_ac].oob06
              END IF
              IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE  oma00 MATCHES '1*'
                    AND oma01 = g_oob[l_ac].oob06 
              END IF
              IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'2*'
                    AND apa01 = g_oob[l_ac].oob06
              END IF 
  
              #TQC-A20043--add--str--
              IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='A' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob[l_ac].oob06
              END IF
              #TQC-A20043--add--end

              IF SQLCA.sqlcode THEN
                 CALL cl_err3("sel","nmh_file",g_oob[l_ac].oob06,"",SQLCA.sqlcode,"","",0) 
              ELSE
                 IF l_nmh04 > g_ooa.ooa02 THEN
                    CALL cl_err('','axr-371',0)
                    NEXT FIELD oob06
                 END IF 
              END IF
              #FUN-660035 --add end
 
              #No.FUN-740184  --Begin
              CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2
              IF g_flag='1' THEN
                 CALL cl_err(l_nmh04,'aoo-081',1)
                 NEXT FIELD oob06
              END IF        
              #No.FUN-740184  --End              
 
#MOD-940420  add --begin
             IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[39]" THEN                         
                IF p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06  THEN 
                   IF g_oob[l_ac].oob04 = '3' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob[l_ac].oob06
             #         IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND (l_oma00!='24') THEN    #MOD-9B0043 add 23
             #         IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND (l_oma00!='24') AND (l_oma00!='27') THEN    #TQC-AC0397 
                       IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND (l_oma00!='24') AND (l_oma00!='26') AND (l_oma00!='27') THEN  #TQC-B10005
                         CALL cl_err('','axr-992',0)
                         NEXT FIELD oob06
                      END IF 
                   END IF 
                   IF g_oob[l_ac].oob04 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob[l_ac].oob06
                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') THEN 
                         CALL cl_err('','axr-993',0)
                         NEXT FIELD oob06 
                      END IF   
                   END IF 
                END IF                 
             END IF 
#MOD-940420  add  --end             
             
             #No.TQC-6B0067--begin-- add
             IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN
                IF p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06  THEN 
#MOD-940420  add  --begin
                   IF g_oob[l_ac].oob04 = '1' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob[l_ac].oob06
                      IF (l_oma00!='11') AND (l_oma00!='12') AND
                         (l_oma00!='13') AND (l_oma00!='14') THEN 
                         CALL cl_err('','axr-994',0)
                         NEXT FIELD oob06
                      END IF 
                   END IF 
                   IF g_oob[l_ac].oob04 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob[l_ac].oob06
#No.MOD-B50249 --begin
                      IF l_apa00 NOT MATCHES '2*' THEN 
#                     IF (l_apa00 !='21') AND (l_apa00 !='22') AND
#                        (l_apa00 !='23') AND (l_apa00 !='24') THEN 
#No.MOD-B50249 --end
                         CALL cl_err('','axr-995',0)
                         NEXT FIELD oob06 
                      END IF   
                   END IF                    
#MOD-940420  add --end                                      
                  #No.TQC-810034--begin--
                   CALL t410_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,l_ac)
                   IF NOT cl_null(g_errno) THEN 
                      CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                      NEXT FIELD oob06
                   END IF 
                  #No.TQC-810034---end---
                  IF g_oob[l_ac].oob04='1' THEN 
                     SELECT COUNT(*) INTO l_i FROM omc_file 
                      WHERE omc01=g_oob[l_ac].oob06
                     IF l_i=1 THEN
                        LET g_oob[l_ac].oob19=1
                        CALL t410_oob06()
                        IF g_errno = 'N' THEN
                           NEXT FIELD oob19
                        ELSE 
                        	 NEXT FIELD oob11
                        END IF
                     END IF 
                  END IF
                  IF g_oob[l_ac].oob04='9' THEN 
                     SELECT COUNT(*) INTO l_i FROM apc_file
                      WHERE apc01=g_oob[l_ac].oob06
                     IF l_i=1 THEN
                        LET g_oob[l_ac].oob19=1
                        CALL t410_oob06()
                        IF g_errno = 'N' THEN
                           NEXT FIELD oob19
                        ELSE 
                        	 NEXT FIELD oob11
                        END IF
                     END IF 
                  END IF                   
                END IF 
              END IF
              #No.TQC-6B0067--end-- add
           END IF
 
 
       #NO.FUN-680022--begin-- add
        BEFORE FIELD oob19
           CALL t410_set_no_entry_b1()
           CALL t410_set_entry_b1()
       #No.FUN-680022--end-- add
 
       #FUN-680022 --begin--
        AFTER FIELD oob19
           IF cl_null(g_oob[l_ac].oob19) AND 
              NOT (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='4') THEN   #MOD-840084
              CALL cl_err("","axr-411",1)
              NEXT FIELD oob06 
           END IF 
           IF NOT cl_null(g_oob[l_ac].oob19) THEN
             #若為待扺，或為貸方
              IF (p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06 OR
                  g_oob_t.oob04 != g_oob[l_ac].oob04 OR 
                  g_oob_t.oob19 != g_oob[l_ac].oob19 ) THEN  
                 CALL t410_oob06()
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob19
                 END IF
              END IF
           END IF
           
        
        BEFORE FIELD oob15
           CALL t410_set_no_entry_b1() 
           CALL t410_set_entry_b1()
 
       #FUN-680022 --end--
 
        AFTER FIELD oob15
           #-----MOD-640190---------
           #IF g_ooz.ooz62 = 'Y' THEN  
           #   IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
           #      IF cl_null(g_oob[l_ac].oob15) THEN
           #         NEXT FIELD oob15
           #      END IF
           #   END IF
           #END IF
 
           #FUN-960141 modify   begin
           #衝帳單身為oma00='15'/'16'/'17'/'18'/'26'/'27'類型不用衝至項次 
           #IF g_ooz.ooz62 = 'Y' THEN  
           #   IF cl_null(g_oob[l_ac].oob15) THEN
           #      NEXT FIELD oob15
           #   END IF
           #END IF
            IF g_ooz.ooz62 = 'Y' THEN
               IF cl_null(g_oob[l_ac].oob15) THEN
                  IF NOT cl_null(g_oob[l_ac].oob06) THEN
                     LET l_oma00 = NULL
                     SELECT oma00 INTO l_oma00  FROM oma_file
                      WHERE oma01 = g_oob[l_ac].oob06 
                     IF NOT cl_null(l_oma00) THEN
                        IF l_oma00 NOT MATCHES '[15,16,17,18,26,27]' THEN
                           NEXT FIELD oob15
                        END IF
                     ELSE
                        NEXT FIELD oob15  
                     END IF 
                  ELSE
                     NEXT FIELD oob15
                  END IF  
                END IF
            END IF  
           #FUN-960141 modify   end
 
           #No.TQC-810034--begin--
            IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN   #MOD-850006
               IF NOT cl_null(g_oob[l_ac].oob15) THEN 
                  CALL t410_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,l_ac)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                     NEXT FIELD oob06
                  END IF 
               END IF 
            END IF   #MOD-850006
           #No.TQC-810034---end---
           IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2' THEN
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob[l_ac].oob06 AND
                      oob15 = g_oob[l_ac].oob15 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15
                 END IF
              END IF
              IF g_oob_t.oob15 <> g_oob[l_ac].oob15 OR
                 g_oob_t.oob15 IS NULL THEN
                 CALL t410_oob06_12()
                 DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                                 g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                                 g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                                 g_oob[l_ac].oob13,g_oob[l_ac].oob14  #MOD-8A0009
   
#MOD-740395.....begin
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06
                 END IF
#MOD-740395.....end
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob[l_ac].oob15) THEN
                 CALL t410_oob06_item()
              END IF
          END IF 
          #-----MOD-640190---------
 
        #FUN-960141 add begin
        AFTER FIELD oob17
           IF NOT cl_null(g_oob[l_ac].oob17) THEN
              CALL t410_oob17(g_oob[l_ac].oob17)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob[l_ac].oob17 = g_oob_t.oob17
                 NEXT FIELD oob17
              END IF  
           END IF  
 
        AFTER FIELD oob18
           IF NOT cl_null(g_oob[l_ac].oob18) THEN
              CALL t410_oob18(g_oob[l_ac].oob18)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob[l_ac].oob18 = g_oob_t.oob18
                 NEXT FIELD oob18
              END IF  
           END IF  
      
        AFTER FIELD oob21
           IF NOT cl_null(g_oob[l_ac].oob21) THEN
              CALL t410_oob21(g_oob[l_ac].oob21)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob[l_ac].oob21 = g_oob_t.oob21
                 NEXT FIELD oob21
              END IF  
           END IF  
        #FUN-960141 add end
 
        BEFORE FIELD oob07
           IF cl_null(g_oob[l_ac].oob07) AND NOT cl_null(g_ooa.ooa23) THEN
              LET g_oob[l_ac].oob07=g_ooa.ooa23
           END IF
           # 971021 TT/NR/CN/AR 不允許修改幣別
           IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[1239]") OR
              (g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[1]") THEN
           END IF
 
        AFTER FIELD oob07
           IF g_oob[l_ac].oob07 IS NULL THEN NEXT FIELD oob07 END IF  #No.TQC-670085
## No.2693 modify 1998/10/31 至少需判斷幣別為正確值
           IF NOT cl_null(g_oob[l_ac].oob07) THEN
              CALL t410_oob07('a')
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_oob[l_ac].oob07,g_errno,0)
                 LET g_oob[l_ac].oob07 = g_oob_t.oob07
                 #-------------NO.MOD-5A0095 START--------------
                 DISPLAY BY NAME g_oob[l_ac].oob07
                 #-------------NO.MOD-5A0095 END----------------
                 NEXT FIELD oob07
              END IF
            END IF
 
        BEFORE FIELD oob08
#MOD-5B0012
           CALL cl_set_comp_entry("oob08",TRUE)
           CALL t410_set_no_entry_b()
#END MOD-5B0012
           LET oob08_t=g_oob[l_ac].oob08   #No.+010
           # 971021 TT/NR/CN/AR 不允許修改匯率
           IF g_oob[l_ac].oob08 = 0 OR g_oob[l_ac].oob08 = 1 OR
              cl_null(g_oob[l_ac].oob08) THEN
              CALL s_curr3(g_oob[l_ac].oob07,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob[l_ac].oob08
#             LET g_oob[l_ac].oob08 = cl_digcut(g_oob[l_ac].oob08,t_azi07)  #MOD-910070 add  #MOD-940238 MARK    
              #-------------NO.MOD-5A0095 START--------------
              DISPLAY BY NAME g_oob[l_ac].oob08
              #-------------NO.MOD-5A0095 END----------------
           END IF
           LET oob08_t=g_oob[l_ac].oob08
 
#MOD-5B0012
        AFTER FIELD oob08
           CALL cl_set_comp_entry("oob08",TRUE)
#END MOD-5B0012
          #str MOD-8A0256 add
           IF (oob08_t!=g_oob[l_ac].oob08) THEN
             #SELECT azi04 INTO t_azi04 FROM azi_file  #MOD-8C0102 mark
             # WHERE azi01 = g_oob[l_ac].oob07         #MOD-8C0102 mark
              LET g_oob[l_ac].oob10 = g_oob[l_ac].oob08 * g_oob[l_ac].oob09
              CALL cl_digcut(g_oob[l_ac].oob10,g_azi04)
                   RETURNING g_oob[l_ac].oob10
           END IF
          #end MOD-8A0256 add
 
        BEFORE FIELD oob09
           LET oob09_t=g_oob[l_ac].oob09
 
        AFTER FIELD oob09
## No.2694 modify 1998/10/31 判斷金額是否沖過頭
           IF NOT cl_null(g_oob[l_ac].oob09) THEN
              IF g_oob_t.oob09 != g_oob[l_ac].oob09 OR
                 g_oob_t.oob09 IS NOT NULL THEN
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN
                    IF NOT t410_oob09_11('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2') THEN
                    IF NOT t410_oob09_12('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                    (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                    IF NOT t410_oob09_13('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '9') THEN
                    #IF NOT t410_oob09_19('1',p_cmd) THEN   #MOD-750063
                    IF NOT t410_oob09_19('1',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob09
                    END IF
                 END IF
                 #-----MOD-750063---------
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t410_oob09_19('1',p_cmd,'2') THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 #-----END MOD-750063-----
              END IF
##--------------------------
#             IF (oob08_t!=g_oob[l_ac].oob08) OR (oob09_t!=g_oob[l_ac].oob09) THEN  #MOD-740395
              IF (oob08_t!=g_oob[l_ac].oob08) OR (oob09_t!=g_oob[l_ac].oob09) OR oob09_t IS NULL THEN #MOD-740395
                  SELECT azi04 INTO t_azi04 FROM azi_file  #MOD-560077  #No.CHI-6A0004
                  WHERE azi01 = g_oob[l_ac].oob07
                  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) #BUG-530346 MOD-560077   #No.CHI-6A0004
                 RETURNING g_oob[l_ac].oob09
                 LET g_oob[l_ac].oob10 = g_oob[l_ac].oob08 * g_oob[l_ac].oob09
                  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) #BUG-530346 MOD-560077  #No.CHI-6A0004
                 RETURNING g_oob[l_ac].oob10
              END IF
              IF g_oob[l_ac].oob09 <= 0 THEN
                 IF g_oob[l_ac].oob04 <> '7' THEN
                    NEXT FIELD oob09
                 END IF
              END IF
              #add by danny 020311 期末調匯(A008)
              IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') OR
                    #add 030306  NO.A048
                    (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') THEN
                    IF NOT t410_oob09_13('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
              END IF
           END IF
 
        BEFORE FIELD oob10
           LET oob10_t=g_oob[l_ac].oob10
 
        AFTER FIELD oob10
           IF NOT cl_null(g_oob[l_ac].oob10) THEN
              IF g_oob_t.oob10 != g_oob[l_ac].oob10 OR g_oob_t.oob10 IS NOT NULL THEN
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN
                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
                     WHERE nmh01 = g_oob[l_ac].oob06
                       AND nmh38 <> 'X'
                    IF cl_null(l_nmh32) THEN
                       LET l_nmh32 = 0
                    END IF
                    IF g_oob[l_ac].oob10 > l_nmh32 THEN
                       NEXT FIELD oob10
                    END IF
                    IF NOT t410_oob09_11('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2') THEN
                    #-----MOD-630069---------
                    #SELECT SUM(npk09) INTO l_nmh32 FROM nmg_file,npk_file
                    # WHERE nmg00 = npk00
                    #   AND nmg00= g_oob[l_ac].oob06
                    #   AND (nmg20 = '21' OR nmg20 = '22')
                    #   AND npk04 IS NOT NULL
                    #   AND nmgconf <> 'X'
                    #IF cl_null(l_nmh32) THEN
                    #   LET l_nmh32 = 0
                    #END IF
                    #IF g_oob[l_ac].oob10 > l_nmh32 THEN
                    #   NEXT FIELD oob10
                    #END IF
                    #-----END MOD-630069-----
                    IF NOT t410_oob09_12('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                    (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                    IF NOT t410_oob09_13('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '9') THEN
                    #IF NOT t410_oob09_19('2',p_cmd) THEN   #MOD-750063
                    IF NOT t410_oob09_19('2',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob10
                    END IF
                 END IF
                 #-----MOD-750063---------
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t410_oob09_19('2',p_cmd,'2') THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 #-----END MOD-750063-----
              END IF
              ##------------------------------------------------
              IF oob10_t <> g_oob[l_ac].oob10 OR g_oob[l_ac].oob07 <> g_aza.aza17 THEN
#                 IF cl_confirm('axr-320') THEN
                    SELECT azi04 INTO t_azi04 FROM azi_file #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 RECUVA
#                   SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file  #MOD-910070 add  #MOD-940238 MARK
                     WHERE azi01 = g_oob[l_ac].oob07
                    CALL cl_digcut(g_oob[l_ac].oob10,g_azi04)  #BUG-530346 MOD-560077  #No.CHI-6A0004
                         RETURNING g_oob[l_ac].oob10
                    LET g_oob[l_ac].oob09 = g_oob[l_ac].oob10 / g_oob[l_ac].oob08
                    CALL cl_digcut(g_oob[l_ac].oob09,t_azi04)  #BUG-530346 MOD-560077  #No.CHI-6A0004
                         RETURNING g_oob[l_ac].oob09
#                 ELSE
#                    LET g_oob[l_ac].oob08 = g_oob[l_ac].oob10 / g_oob[l_ac].oob09
#                 END IF
              END IF
              IF g_oob[l_ac].oob08 = 1 AND g_oob[l_ac].oob07 <> g_aza.aza17 THEN
                 LET g_oob[l_ac].oob08 = g_oob[l_ac].oob10 / g_oob[l_ac].oob09
              END IF
#             CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08 #MOD-910070 add #MOD-940238 MARK
              IF g_oob[l_ac].oob10 <= 0 THEN
                 NEXT FIELD oob10
              END IF
           END IF
 
        AFTER FIELD oob11
          IF g_oob[l_ac].oob11 IS NULL THEN NEXT FIELD oob11 END IF    #No.TQC-670085
          LET l_aag05=''   #FUN-8C0089 add
          IF NOT cl_null(g_oob[l_ac].oob11) THEN
             #NO:6702
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11   #FUN-8C0089 add aag05,l_aag05
                                                                   AND aag00=g_bookno1            #No.FUN-730073    
                                                                   AND aag07 IN ('2','3')         #No.FUN-B10053      
                                                                   AND aag03 = '2'                #No.FUN-B10053
#               CALL cl_err('select aag',STATUS,0)    #No.FUN-660116
            IF STATUS THEN                      
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oob[l_ac].oob11,"",STATUS,"","select aag",1)  #No.FUN-660116
                CALL cl_err3("sel","aag_file",g_oob[l_ac].oob11,"",STATUS,"","select aag",0)
                CALL cl_init_qry_var()
                LET g_qryparam.form ='q_aag'
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 =g_oob[l_ac].oob11
                LET g_qryparam.arg1 = g_bookno1
#               LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob[l_ac].oob11 CLIPPED,"%'"   #No.MOD-B30388  Mark
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' "   #No.MOD-B30388  add
                CALL cl_create_qry() RETURNING g_oob[l_ac].oob11
                DISPLAY BY NAME g_oob[l_ac].oob11
                #No.FUN-B10053  --End
                NEXT FIELD oob11
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob[l_ac].oob11,'agl-015',0) NEXT FIELD oob11
             END IF
             #NO:6702
            #FUN-8C0089---add---str--- 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob[l_ac].oob13) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob11,g_oob[l_ac].oob13,g_bookno1)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob11
                END IF
             ELSE                                  #MOD-920163 add
                LET g_oob[l_ac].oob13=''           #MOD-920163 add
                DISPLAY BY NAME g_oob[l_ac].oob13  #MOD-920163 add
             END IF
            #FUN-8C0089---add---end---
             CALL t410_set_no_entry_b1()   #MOD-920163 add
             CALL t410_set_entry_b1()      #MOD-920163 add
          END IF
 
#No.FUN-670047--begin-- add
        AFTER FIELD oob111
          IF g_oob[l_ac].oob111 IS NULL THEN NEXT FIELD oob111 END IF   
          IF NOT cl_null(g_oob[l_ac].oob111) THEN
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob111   #FUN-8C0089 add aag05,l_aag05
                                                                   AND aag00=g_bookno2      #No.FUN-730073
                                                                   AND aag07 IN ('2','3')   #No.FUN-B10053 
                                                                   AND aag03 = '2'          #No.FUN-B10053 
             IF STATUS THEN
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oob[l_ac].oob111,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oob[l_ac].oob111,"",STATUS,"","select aag",0)  
                CALL cl_init_qry_var()
                LET g_qryparam.form ='q_aag'
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 =g_oob[l_ac].oob111
                LET g_qryparam.arg1 = g_bookno2
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob[l_ac].oob111 CLIPPED,"%'" 
                CALL cl_create_qry() RETURNING g_oob[l_ac].oob111
                DISPLAY BY NAME g_oob[l_ac].oob111
                #No.FUN-B10053  --End
                NEXT FIELD oob111
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob[l_ac].oob111,'agl-015',0) NEXT FIELD oob111
             END IF
 
            #FUN-8C0089---add---str--- 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob[l_ac].oob13) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob111,g_oob[l_ac].oob13,g_bookno2)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob111
                END IF
             END IF
            #FUN-8C0089---add---end---
 
          END IF
#No.FUN-670047--end-- add
 
#MOD-5B0012
          BEFORE FIELD oob13
            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
             WHERE aag01=g_oob[l_ac].oob11
               AND aag00=g_bookno1          #No.FUN-730073
           #CALL cl_set_comp_entry("oob13",TRUE)   #MOD-920163 mark
            IF l_aag05='N' THEN
           #   CALL cl_set_comp_entry("oob13",FALSE)   #MOD-920163 mark
               LET g_oob[l_ac].oob13=''
               DISPLAY BY NAME g_oob[l_ac].oob13
            END IF
            CALL t410_set_no_entry_b1()   #MOD-920163 add
            CALL t410_set_entry_b1()      #MOD-920163 add
#END MOD-5B0012
 
        AFTER FIELD oob13
          IF NOT cl_null(g_oob[l_ac].oob13) THEN
             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob[l_ac].oob13
                AND gemacti='Y'   #NO:6950
             IF STATUS THEN
#               CALL cl_err('select gem',STATUS,0)    #No.FUN-660116
                CALL cl_err3("sel","gem_file",g_oob[l_ac].oob13,"",STATUS,"","select gem",1)  #No.FUN-660116
                NEXT FIELD oob13
             END IF
            #FUN-8C0089---add---str---
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET l_aag05=''   
             SELECT aag05 INTO l_aag05 FROM aag_file
              WHERE aag01 = g_oob[l_ac].oob11
                AND aag00 = g_bookno1      
            
             LET g_errno = ' '   
             IF l_aag05 = 'Y' AND NOT cl_null(g_oob[l_ac].oob11) THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN    
                   CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob11,g_oob[l_ac].oob13,g_bookno1)
                                 RETURNING g_errno
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob13
                END IF
             END IF
            
             IF g_aza.aza63='Y' THEN 
                LET l_aag05=''   
                SELECT aag05 INTO l_aag05 FROM aag_file
                 WHERE aag01 = g_oob[l_ac].oob111
                   AND aag00 = g_bookno2      
                
                LET g_errno = ' '   
                IF l_aag05 = 'Y' AND NOT cl_null(g_oob[l_ac].oob111) THEN
                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                   IF g_aaz.aaz90 !='Y' THEN  
                      CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob111,g_oob[l_ac].oob13,g_bookno2)
                                    RETURNING g_errno
                   END IF
                   IF NOT cl_null(g_errno) THEN
                      CALL cl_err('',g_errno,0)
                      NEXT FIELD oob13
                   END IF
                END IF
             END IF  
            #FUN-8C0089---add---end---
          END IF
#MOD-5B0012
            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
               WHERE aag01=g_oob[l_ac].oob11  
                 AND aag00=g_bookno1        #No.FUN-730073
            IF l_aag05='Y' AND cl_null(g_oob[l_ac].oob13) THEN
               CALL cl_err('','aap-099',0)
               NEXT FIELD oob13
            END IF
           #CALL cl_set_comp_entry("oob13",TRUE)   #MOD-920163 mark
#END MOD-5B0012
 
        #No.FUN-850038 --start--
        AFTER FIELD oobud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        #No.FUN-850038 ---end---
 
        BEFORE DELETE                            #是否取消單身
            DISPLAY "g_oob_t.oob02=",g_oob_t.oob02
            IF g_oob_t.oob02 > 0 AND g_oob_t.oob02 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   LET g_success = 'N'   #MOD-730060
                   CANCEL DELETE
                END IF
                # genero shell add start
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   LET g_success = 'N'   #MOD-730060
                   CANCEL DELETE
                END IF
                # genero shell add end
                DELETE FROM oob_file
                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_t.oob02
                IF SQLCA.sqlcode THEN
#                   CALL cl_err(g_oob_t.oob02,SQLCA.sqlcode,0)   #No.FUN-660116
                    CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_t.oob02,SQLCA.sqlcode,"","",1)  #No.FUN-660116
                    LET g_success = 'N'   #MOD-730060
                    #ROLLBACK WORK   #MOD-730060
                    CANCEL DELETE
                END IF
                CALL t410_mlog('R')
            #-----MOD-730060---------
            #    COMMIT WORK
            #    LET g_rec_b=g_rec_b-1
            #    DISPLAY g_rec_b TO FORMONLY.cn2
            #    LET l_ooa34 = '0'          #FUN-550049
            #END IF
            #IF cl_null(g_oob_t.oob02) THEN   #若本身有空行單身筆數要減1
            #    LET g_rec_b=g_rec_b-1        #確保g_rec_b筆數正確(genero)
            #END IF
           #END IF   #MOD-850246 mark
                IF g_success = 'Y' THEN
                   IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                      LET l_ooa34 = '0'
                   END IF                                   #No.FUN-8A0075
                   LET g_rec_b=g_rec_b-1
                   DISPLAY g_rec_b TO FORMONLY.cn2
                   IF cl_null(g_oob_t.oob02) THEN
                      LET g_rec_b=g_rec_b-1
                   END IF
                   COMMIT WORK
                ELSE
                   ROLLBACK WORK
                END IF
            END IF   #MOD-850246 add
            #-----END MOD-730060-----
            CALL t410_bu()
 
        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_oob[l_ac].* = g_oob_t.*
               CLOSE t410_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_oob[l_ac].oob02,-263,1)
               LET g_oob[l_ac].* = g_oob_t.*
               LET g_success='N'   #MOD-730060
            ELSE
               CALL t410_b_move_back()
               SELECT COUNT(*) INTO l_n FROM oob_file
                WHERE oob01=g_ooa.ooa01  AND oob02=g_oob[l_ac].oob02
               IF l_n = 0 THEN                                   #<-NO:0352--
                  IF g_oob[l_ac].oob09 = 0 AND g_oob[l_ac].oob10 = 0 THEN
                     INITIALIZE g_oob[l_ac].* TO NULL  #重要欄位空白,無效
                     LET g_success='N'   #MOD-730060
                  END IF
               END IF
#MOD-950129 --begin--
           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
           END IF
           IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN   
               IF NOT cl_null(g_oob[l_ac].oob15) THEN 
                  CALL t410_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,l_ac)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                     NEXT FIELD oob06
                  END IF 
               END IF 
            END IF   
           IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2' THEN
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob[l_ac].oob06 AND
                      oob15 = g_oob[l_ac].oob15 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15
                 END IF
              END IF
              IF g_oob_t.oob15 <> g_oob[l_ac].oob15 OR
                 g_oob_t.oob15 IS NULL THEN
                 CALL t410_oob06_12()
                 DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                                 g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                                 g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                                 g_oob[l_ac].oob13,g_oob[l_ac].oob14  
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob[l_ac].oob15) THEN
                 CALL t410_oob06_item()
              END IF
          END IF 
#MOD-950129 --end--                  
               UPDATE oob_file SET * = b_oob.*
                  WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_t.oob02
               IF SQLCA.sqlcode THEN
#                 CALL cl_err('upd oob',SQLCA.sqlcode,0)   #No.FUN-660116
                  CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_t.oob02,SQLCA.sqlcode,"","upd oob",1)  #No.FUN-660116
                  LET g_oob[l_ac].* = g_oob_t.*
                  LET g_success='N'   #MOD-730060
            #-----MOD-730060--------
            #   ELSE
            #      MESSAGE 'UPDATE O.K'
            #      LET l_ooa34 = '0'          #FUN-550049
            #      CALL t410_mlog('U')
            #      CALL t410_bu()
            #    COMMIT WORK
            #   END IF
            #END IF
               #-----MOD-870147---------
               ELSE 
                  UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
                   WHERE ooa01 = g_ooa.ooa01 
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
                     LET g_oob[l_ac].* = g_oob_t.*
                     LET g_success='N'   
                  END IF
                  DISPLAY g_user TO ooamodu
                  DISPLAY g_today TO ooadate
               #-----END MOD-870147----- 
                END IF
            END IF
            CALL t410_mlog('U')
            CALL t410_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'UPDAET O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                  LET l_ooa34 = '0'
               END IF                                   #No.FUN-8A0075
               COMMIT WORK
            ELSE
               MESSAGE 'UPDATE ERR'
               ROLLBACK WORK
            END IF
            #-----END MOD-730060-----
 
        AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_oob[l_ac].* = g_oob_t.*
               END IF
               CLOSE t410_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            CLOSE t410_bcl
            COMMIT WORK
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(oob02) AND l_ac > 1 THEN
                LET g_oob[l_ac].* = g_oob[l_ac-1].*
                LET g_oob[l_ac].oob02 = NULL
                NEXT FIELD oob02
            END IF
        ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
 
        ON ACTION CONTROLP
            CASE
#MOD-590452 將原本mark的部份取消
                WHEN INFIELD(oob04)
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_ooc"
                     LET g_qryparam.default1 = g_oob[l_ac].oob04
                     LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  #No.TQC-7B0028
                     CALL cl_create_qry() RETURNING g_oob[l_ac].oob04
                     DISPLAY BY NAME g_oob[l_ac].oob04         #No.MOD-490344
                     NEXT FIELD oob04
#END MOD-590452
                 #--- 970421 新增
                 WHEN INFIELD(oob06)
                      IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmh5"
                          LET g_qryparam.arg1 = g_ooa.ooa03
                          LET g_qryparam.arg2 = g_doc_len   #MOD-770022
                          CALL cl_create_qry() RETURNING g_oob[l_ac].oob06
                          NEXT FIELD oob06
                      END IF
                      IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmg"
                          LET g_qryparam.default1 = g_oob[l_ac].oob06
                           LET g_qryparam.arg1 = g_ooa.ooa03   #No.MOD-530346
                          CALL cl_create_qry() RETURNING g_oob[l_ac].oob06
                          NEXT FIELD oob06
                      END IF
                      IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
#                        CALL q_oma1(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, #No.FUN-670026 mark
#                                    g_ooa.ooa01,g_ooa.ooa03,'2*')                   #No.FUN-670026 mark
                       #No.FUN-680022--begin-- mark
                       # CALL q_oma4(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, #No.FUN-670026 
                       #             g_ooa.ooa01,g_ooa.ooa03,'2*')                   #No.FUN-670026 
                       #      RETURNING b_oob.oob06,
                       #                b_oob.oob09,b_oob.oob10
                       #No.FUN-680022--end-- mark
                       #No.FUN-680022--begin-- add
                         CALL q_oma4(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, 
                                     g_ooa.ooa01,g_ooa.ooa03,'2*')                   
                              RETURNING b_oob.oob06,b_oob.oob09,       #No.FUN-680022-- add oob19
                                        b_oob.oob10,b_oob.oob19
                       #No.FUN-680022--end-- add
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob[l_ac].oob06 = b_oob.oob06
                            LET g_oob[l_ac].oob19 = b_oob.oob19   #No.FUN-680022 --add
                            LET g_oob[l_ac].oob09 = b_oob.oob09
                            LET g_oob[l_ac].oob10 = b_oob.oob10
                         END IF
                         NEXT FIELD oob06
                      END IF
                      #No.B082 010412 by linda add
                      IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='9' THEN
                         CALL q_apa4( FALSE, TRUE, ' ')
                         RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob[l_ac].oob06 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06
                      END IF
                      #No.B082 end----
                      IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
                         IF g_ooz.ooz62='N' THEN
#                           CALL q_oma1(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, #No.FUN-670026 mark
#                                        g_ooa.ooa01,g_ooa.ooa03,'1*')   #No.MOD-530346 #No.FUN-670026 mark
                            CALL q_oma4(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, #No.FUN-670026 
                                        g_ooa.ooa01,g_ooa.ooa03,'1*')                   #No.FUN-670026 
                                 RETURNING b_oob.oob06,b_oob.oob09,  #No.FUN-680022 --add oob19
                                           b_oob.oob10,b_oob.oob19
                         ELSE
                            CALL q_omb(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02,
                                       g_ooa.ooa01, g_ooa.ooa03,'1%') #No.FUN-550131 1* -> 1%
                             RETURNING b_oob.oob06,b_oob.oob15,
                                       b_oob.oob09,b_oob.oob10
                         END IF
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob[l_ac].oob06 = b_oob.oob06
                            LET g_oob[l_ac].oob09 = b_oob.oob09
                            LET g_oob[l_ac].oob10 = b_oob.oob10
                           #LET g_oob[l_ac].oob15 = b_oob.oob15  #No.FUN-680022 --mark
                           #No.FUN-680022--begin--  add
                            IF g_ooz.ooz62='Y' THEN
                               LET g_oob[l_ac].oob15 = b_oob.oob15
                            ELSE
                               LET g_oob[l_ac].oob19 = b_oob.oob19
                            END IF
                           #No.FUN-680022--end-- add
                         END IF
                         NEXT FIELD oob06
                      END IF
                      #No.B082 010412 by linda add
                      IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='9' THEN
                         CALL q_apa5( FALSE, TRUE, ' ')
                              RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob[l_ac].oob06 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06
                      END IF
                      #No.B082 end----
                      #TQC-A20043--add--str--
                      IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='A' THEN
                         CALL q_nmg(FALSE,TRUE,g_oob[l_ac].oob06,g_ooa.ooa03,
                                    g_ooa.ooa032,g_ooa.ooa02,g_ooa.ooa23)
                              RETURNING g_oob[l_ac].oob06,g_oob[l_ac].oob15,
                                        g_oob[l_ac].oob09,g_oob[l_ac].oob10,    
                                        g_oob[l_ac].oob18,g_oob[l_ac].oob17
                         NEXT FIELD oob06
                         DISPLAY BY NAME g_oob[l_ac].oob18
                         DISPLAY BY NAME g_oob[l_ac].oob17
                        #DISPLAY BY NAME g_oob[l_ac].oob06
                        #DISPLAY BY NAME g_oob[l_ac].oob09
                        #DISPLAY BY NAME g_oob[l_ac].oob10
                        #DISPLAY BY NAME g_oob[l_ac].oob15
                      END IF
                      #TQC-A20043--add--end
                       DISPLAY BY NAME g_oob[l_ac].oob06     #No.MOD-490344
                       DISPLAY BY NAME g_oob[l_ac].oob09     #No.MOD-490344
                       DISPLAY BY NAME g_oob[l_ac].oob10     #No.MOD-490344
                       DISPLAY BY NAME g_oob[l_ac].oob15     #No.MOD-490344
               WHEN INFIELD(oob11)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_aag'
                    LET g_qryparam.default1 =g_oob[l_ac].oob11
                    LET g_qryparam.arg1 = g_bookno1      #No.FUN-730073 
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob11
                    DISPLAY BY NAME g_oob[l_ac].oob11
                    NEXT FIELD oob11
              #No.FUN-670047--begin-- add
               WHEN INFIELD(oob111)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_aag'
                    LET g_qryparam.default1 =g_oob[l_ac].oob111
                    LET g_qryparam.arg1 = g_bookno2      #No.FUN-730073 
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob111
                    DISPLAY BY NAME g_oob[l_ac].oob111
                    NEXT FIELD oob111
              #No.FUN-670047--end-- add
               WHEN INFIELD(oob13)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_gem'
                    LET g_qryparam.default1 = g_oob[l_ac].oob13
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob13
                    DISPLAY BY NAME g_oob[l_ac].oob13
                    NEXT FIELD oob13
               WHEN INFIELD(oob07)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_azi'
                    LET g_qryparam.default1 =g_oob[l_ac].oob07
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob07
                    DISPLAY BY NAME g_oob[l_ac].oob07
                    NEXT FIELD oob07
               #FUN-4B0056
               WHEN INFIELD(oob08)
                    CALL s_rate(g_oob[l_ac].oob07,g_oob[l_ac].oob08)
                    RETURNING g_oob[l_ac].oob08
#                   LET g_oob[l_ac].oob08 = cl_digcut(g_oob[l_ac].oob08,t_azi07)  #MOD-910070 add #MOD-940238 MARK
                    DISPLAY BY NAME g_oob[l_ac].oob08
                    NEXT FIELD oob08
               #--
               #FUN-960141 add begin
               WHEN INFIELD (oob17)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nma'
                    LET g_qryparam.default1 = g_oob[l_ac].oob17
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob17
                    DISPLAY BY NAME g_oob[l_ac].oob17
                    NEXT FIELD oob17
               WHEN INFIELD (oob18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nmc02'
                    LET g_qryparam.default1 = g_oob[l_ac].oob18
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob18
                    DISPLAY BY NAME g_oob[l_ac].oob18
                    NEXT FIELD oob18
               WHEN INFIELD (oob21)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nml'
                    LET g_qryparam.default1 = g_oob[l_ac].oob21
                    CALL cl_create_qry() RETURNING g_oob[l_ac].oob21
                    DISPLAY BY NAME g_oob[l_ac].oob21
                    NEXT FIELD oob21
               #FUN-960141 add end
               OTHERWISE EXIT CASE
            END CASE
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION receive_notes
                 IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
                    #CALL cl_cmdrun('anmt200')      #FUN-660216 remark
                    CALL cl_cmdrun_wait('anmt200')  #FUN-660216 add
                 END IF
        ON ACTION bank_income_expense
                 IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
                    #CALL cl_cmdrun('anmt302')      #FUN-660216 remark
                    CALL cl_cmdrun_wait('anmt302')  #FUN-660216 add
                 END IF
        ON ACTION maintain_accounts
                 IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
                    #CALL cl_cmdrun('axrt300')      #FUN-660216 remark
                    CALL cl_cmdrun_wait('axrt300')  #FUN-660216 add
                 END IF
                 IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
                    #CALL cl_cmdrun('axrt300')      #FUN-660216 remark
                    CALL cl_cmdrun_wait('axrt300')  #FUN-660216 add
                 END IF
        ON ACTION ar_account_category
                    CALL cl_cmdrun('axri040')
#FUN-960141 mark
#       ON ACTION auto_contra
#          CALL t410_g_b2()
#          EXIT INPUT
#FUN-960141 end
 
        ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
      END INPUT
     #FUN-550049
     
  
#No.MOD-B50249 --begin
#      #FUN-A90003--Add--Begin--#
#      INPUT ARRAY g_oob_d WITHOUT DEFAULTS FROM s_oob_d.*
#            ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED,
#                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
# 
#        BEFORE INPUT
#            IF g_rec_b2 != 0 THEN
#               CALL fgl_set_arr_curr(l_ac2)
#            END IF
# 
#        BEFORE ROW
#            LET p_cmd = ''
#            LET l_ac2 = ARR_CURR()
#            DISPLAY l_ac2 TO FORMONLY.cn3
#            LET l_lock_sw = 'N'                   #DEFAULT
#            LET l_n  = ARR_COUNT()
#            LET g_success = 'Y'   
#            BEGIN WORK
# 
#            OPEN t410_cl USING g_ooa.ooa01   
#            IF STATUS THEN
#               CALL cl_err("OPEN t410_cl:", STATUS, 1)
#               CLOSE t410_cl
#               ROLLBACK WORK
#               RETURN
#            END IF
#            FETCH t410_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
#            IF SQLCA.sqlcode THEN
#               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
#               CLOSE t410_cl 
#               ROLLBACK WORK 
#               RETURN
#            END IF
#            IF g_rec_b2>=l_ac2 THEN
#               LET p_cmd='u'
#               LET g_oob_d_t.* = g_oob_d[l_ac2].*  #BACKUP
#               OPEN t410_bcl USING g_ooa.ooa01,g_oob_d_t.oob02_1
#               IF STATUS THEN
#                  CALL cl_err("OPEN t410_bcl:", STATUS, 1)
#                  LET l_lock_sw = "Y"
#                  CLOSE t410_bcl
#                  ROLLBACK WORK
#               ELSE
#                  FETCH t410_bcl INTO b_oob.*
#                  IF SQLCA.sqlcode THEN
#                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
#                      LET l_lock_sw = "Y"
#                  ELSE
#                      CALL t410_b_move_to_2()
#                  END IF
#               END IF
#               CALL t410_need_2()
#               CALL t410_set_entry_b_2()
#               CALL t410_set_entry_b_1_2()    
#               CALL t410_set_no_entry_b_2()
#               CALL t410_set_no_entry_b1_2()
#               CALL t410_set_entry_b1_2()
#               CALL t410_set_no_entry_b_1_2()    
#               CALL cl_show_fld_cont()               
#               CALL cl_show_fld_cont()    
#            END IF
# 
#        AFTER INSERT
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               LET g_success = 'N'   
#               CANCEL INSERT
#            END IF
#            CALL t410_b_move_back_2()
#            SELECT COUNT(*) INTO l_n FROM oob_file
#             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
#            IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
#               IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                  (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                  IF NOT t410_oob09_1_13_2('2',p_cmd) THEN
#                  END IF
#               END IF
#            END IF
#
#           IF g_ooz.ooz62 = 'Y' THEN  
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#           END IF
#           IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
#               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
#                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
#                  IF NOT cl_null(g_errno) THEN 
#                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                     NEXT FIELD oob06_1
#                  END IF 
#               END IF 
#            END IF   
#           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM oob_file
#                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
#                      oob15 = g_oob_d[l_ac2].oob15_1 AND
#                      oob01 = g_ooa.ooa01
#              IF p_cmd = 'a' THEN
#                 IF l_cnt > 0 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              ELSE
#                 IF l_cnt > 1 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              END IF
#              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
#                 g_oob_d_t.oob15_1 IS NULL THEN
#                 CALL t410_oob06_1_12_2()
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
#                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
#                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
#                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob06_1
#                 END IF
#              END IF
#          ELSE
#              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
#                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 CALL t410_oob06_1_item_2()
#              END IF
#          END IF 
#                
#            INSERT INTO oob_file VALUES(b_oob.*)
#            IF SQLCA.sqlcode THEN
#               LET g_success = 'N'   
#               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  
#               CANCEL INSERT
#            END IF
#            CALL t410_mlog('A')
#            CALL t410_bu()
#            IF g_success = 'Y' THEN
#               MESSAGE 'INSERT O.K'
#               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
#                  LET l_ooa34 = '0'
#               END IF                                 
#               LET g_rec_b2=g_rec_b2+1
#               DISPLAY g_rec_b2 TO FORMONLY.cn3
#               COMMIT WORK
#            ELSE
#               MESSAGE 'INSERT ERR'
#               ROLLBACK WORK
#            END IF
#            
#        BEFORE INSERT
#            LET l_n = ARR_COUNT()
#            LET p_cmd='a'
#            INITIALIZE g_oob_d[l_ac2].* TO NULL    
#            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
#                LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
#            END IF
#            LET b_oob.oob01=g_ooa.ooa01
#
#            LET b_oob.ooblegal=g_ooa.ooalegal
#
#            LET g_oob_d[l_ac2].oob08_1=1
#            LET g_oob_d[l_ac2].oob09_1=0
#            LET g_oob_d[l_ac2].oob10_1=0
#            LET g_oob_d[l_ac2].oob20_1='N'                 
#            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料
#            LET g_oob_d[l_ac2].oob03_d = '2'               #新輸入資料
#            LET g_oob_d[l_ac2].oob04_1 = '1'               #新輸入資料
#            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料   
#            CALL t410_set_entry_b_2()
#            CALL t410_set_entry_b_1_2()   
#            CALL t410_set_no_entry_b_2()
#            CALL t410_need_2()            
#            CALL cl_show_fld_cont()     
# 
#            NEXT FIELD oob02_1
# 
#        BEFORE FIELD oob02_1                            #default 序號
#           IF g_oob_d[l_ac2].oob02_1 IS NULL OR g_oob_d[l_ac2].oob02_1 = 0 THEN
#                IF l_ac2>1 THEN LET g_chr=g_oob_d[l_ac2-1].oob03_d END IF
#                SELECT MAX(oob02)+1 INTO g_oob_d[l_ac2].oob02_1 FROM oob_file
#                   WHERE oob01 = g_ooa.ooa01 
#                IF g_oob_d[l_ac2].oob02_1 IS NULL THEN
#                    LET g_oob_d[l_ac2].oob02_1 = 1
#                END IF
#           END IF
# 
#        AFTER FIELD oob02_1                        #check 序號是否重複
#            IF NOT cl_null(g_oob_d[l_ac2].oob02_1) THEN
#               IF g_oob_d[l_ac2].oob02_1 != g_oob_d_t.oob02_1 OR g_oob_d_t.oob02_1 IS NULL THEN
#                  SELECT count(*) INTO l_n FROM oob_file
#                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob_d[l_ac2].oob02_1
#                  IF l_n > 0 THEN
#                     LET g_oob_d[l_ac2].oob02_1 = g_oob_d_t.oob02_1
#                     CALL cl_err('',-239,0) NEXT FIELD oob02_1
#                  END IF
#               END IF
#            END IF
# 
#        AFTER FIELD oob03_d
#           IF NOT cl_null(g_oob_d[l_ac2].oob03_d) THEN
#              IF g_oob_d[l_ac2].oob03_d NOT MATCHES "[12]" THEN NEXT FIELD oob03_d END IF
#              CALL t410_need_2()                                                                                             
#                 IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN                                                                             
#                    LET l_cnt = 0                                                                                                   
#                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
#                       WHERE ooc01 = g_oob_d[l_ac2].oob04_1                                                                              
#                    IF l_cnt = 0 THEN                                                                                               
#                       IF g_oob_d[l_ac2].oob03_d='1' THEN
#                           IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,A,F]' THEN   
#                             CALL cl_err('','axr-917',0)                                                                            
#                             NEXT FIELD oob04_1                                                                                       
#                          END IF                                                                                                    
#                       ELSE                                                                                                         
#                           IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,A,C,D,E,Q]' THEN  
#                             CALL cl_err('','axr-917',0)                                                                            
#                             NEXT FIELD oob04_1                                                                                       
#                          END IF                                                                                                    
#                       END IF                                                                                                       
#                    END IF                                                                                                          
#                 END IF
#           END IF
# 
#        BEFORE FIELD oob04_1
#           CALL t410_set_entry_b_2()
# 
#        AFTER FIELD oob04_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN
#              CALL t410_need_2()
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM ooc_file
#                 WHERE ooc01 = g_oob_d[l_ac2].oob04_1
#              IF l_cnt = 0 THEN
#                 IF g_oob_d[l_ac2].oob03_d='1' THEN
#                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,A,E,F,Q]' THEN  
#                       CALL cl_err('','axr-917',0)
#                       NEXT FIELD oob04_1
#                    END IF
#                 ELSE
#                   IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,Q]' THEN   
#                       CALL cl_err('','axr-917',0)
#                       NEXT FIELD oob04_1
#                    END IF
#                 END IF
#              END IF
#              SELECT azi04 INTO t_azi04 FROM azi_file                 
#               WHERE azi01 = g_oob_d[l_ac2].oob07_1  
#             #若oob04_1='9'時,oob15_1預設值為0,無須維護
#              IF g_oob_d[l_ac2].oob04_1='9' THEN
#                 LET g_oob_d[l_ac2].oob15_1=0
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob15_1
#              END IF
#              CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
#                   RETURNING g_oob_d[l_ac2].oob04_1_d
#              CALL t410_acct_code_2()
#              IF g_oob_d[l_ac2].oob11_1 IS NULL THEN
#                 SELECT ooc03 INTO g_oob_d[l_ac2].oob11_1 FROM ooc_file
#                  WHERE ooc01=g_oob_d[l_ac2].oob04_1
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1   
#              END IF
#              IF g_aza.aza63='Y' THEN
#                 IF g_oob_d[l_ac2].oob111_1 IS NULL THEN
#                    SELECT ooc04 INTO g_oob_d[l_ac2].oob111_1 FROM ooc_file
#                     WHERE ooc01=g_oob_d[l_ac2].oob04_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                 END IF
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = "7" AND
#                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN
#                 CALL cl_err('','axr-204',0) NEXT FIELD oob04_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[567]" AND
#                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
#                 IF g_ooa31_diff = 0
#                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
#                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
#                 END IF
#                 LET g_oob_d[l_ac2].oob09_1 = g_ooa31_diff
#                 LET g_oob_d[l_ac2].oob10_1 = g_ooa32_diff
#                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
#                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
#	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
#	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[23]" AND
#                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
#                 IF g_ooa31_diff = 0
#                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
#                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
#                 END IF
#                 LET g_oob_d[l_ac2].oob09_1 = -g_ooa31_diff
#                 LET g_oob_d[l_ac2].oob10_1 = -g_ooa32_diff
#                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
#                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#	               DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
#	               DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
#	               DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
#              END IF
#              #MOD-B30240--add--str--
#              IF g_oob_d[l_ac2].oob04_1 = 'D' THEN    #支票
#                 SELECT apz13 INTO g_apz13 FROM apz_file WHERE apz00 = '0'
#                 IF g_apz13 = 'Y' THEN
#                    SELECT * INTO g_aps.* FROM aps_file WHERE aps01=g_ooa.ooa15  
#                 ELSE
#                    SELECT * INTO g_aps.* FROM aps_file WHERE (aps01 = ' ' OR aps01 IS NULL)
#                 END IF
#                 LET g_oob_d[l_ac2].oob11_1 = g_aps.aps24
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
#                 IF g_aza.aza63 = 'Y' THEN
#                    LET g_oob_d[l_ac2].oob111_1 = g_aps.aps241
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                 END IF 
#              END IF 
#              #MOD-B30240--add--end
#         END IF
#         CALL t410_set_no_entry_b_2()
#         CALL t410_set_no_entry_b1_2()           
#         CALL t410_set_entry_b1_2()               
# 
#        AFTER FIELD oob06_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
#             #若為借方，且非待扺
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 != '3' THEN
#                 IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
#                       g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN  
#                    CALL t410_oob06_1_2()
# 
#                    IF g_errno = 'N' THEN
#                       NEXT FIELD oob06_1
#                    END IF
#                 END IF
#              END IF
#
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
#                  WHERE nmh01 = g_oob_d[l_ac2].oob06_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
#                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
#                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                 SELECT oma02 INTO l_nmh04 FROM oma_file
#                  WHERE oma00 MATCHES '2*'
#                    AND oma01 = g_oob_d[l_ac2].oob06_1 
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                 SELECT apa02 INTO l_nmh04 FROM apa_file
#                  WHERE apa00 matches'1*'
#                    AND apa01 = g_oob_d[l_ac2].oob06_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                 SELECT oma02 INTO l_nmh04 FROM oma_file
#                  WHERE  oma00 MATCHES '1*'
#                    AND oma01 = g_oob_d[l_ac2].oob06_1 
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                 SELECT apa02 INTO l_nmh04 FROM apa_file
#                  WHERE apa00 matches'2*'
#                    AND apa01 = g_oob_d[l_ac2].oob06_1
#              END IF 
#
#              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='A' THEN
#                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
#                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
#              END IF
#
#              IF SQLCA.sqlcode THEN
#                 CALL cl_err3("sel","nmh_file",g_oob_d[l_ac2].oob06_1,"",SQLCA.sqlcode,"","",0) 
#              ELSE
#                 IF l_nmh04 > g_ooa.ooa02 THEN
#                    CALL cl_err('','axr-371',0)
#                    NEXT FIELD oob06_1
#                 END IF 
#              END IF
#
#              CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2
#              IF g_flag='1' THEN
#                 CALL cl_err(l_nmh04,'aoo-081',1)
#                 NEXT FIELD oob06_1
#              END IF        
#
#             IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[39]" THEN                         
#                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
#                   IF g_oob_d[l_ac2].oob04_1 = '3' THEN 
#                      SELECT oma00 INTO l_oma00 FROM oma_file
#                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND (l_oma00!='24') THEN    #MOD-9B0043 add 23
#                         CALL cl_err('','axr-992',0)
#                         NEXT FIELD oob06_1
#                      END IF 
#                   END IF 
#                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
#                      SELECT apa00 INTO l_apa00 FROM apa_file
#                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') THEN 
#                         CALL cl_err('','axr-993',0)
#                         NEXT FIELD oob06_1 
#                      END IF   
#                   END IF 
#                END IF                 
#             END IF 
#
#             IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN
#                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
#
#                   IF g_oob_d[l_ac2].oob04_1 = '1' THEN 
#                      SELECT oma00 INTO l_oma00 FROM oma_file
#                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_oma00!='11') AND (l_oma00!='12') AND
#                         (l_oma00!='13') AND (l_oma00!='14') THEN 
#                         CALL cl_err('','axr-994',0)
#                         NEXT FIELD oob06_1
#                      END IF 
#                   END IF 
#                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
#                      SELECT apa00 INTO l_apa00 FROM apa_file
#                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_apa00!='21') AND (l_apa00!='22') AND
#                         (l_apa00!='23') AND (l_apa00!='24') THEN 
#                         CALL cl_err('','axr-995',0)
#                         NEXT FIELD oob06_1 
#                      END IF   
#                   END IF                    
#
#                   CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
#                   IF NOT cl_null(g_errno) THEN 
#                      CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                      NEXT FIELD oob06_1
#                   END IF 
#
#                  IF g_oob_d[l_ac2].oob04_1='1' THEN 
#                     SELECT COUNT(*) INTO l_i FROM omc_file 
#                      WHERE omc01=g_oob_d[l_ac2].oob06_1
#                     IF l_i=1 THEN
#                        LET g_oob_d[l_ac2].oob19_1=1
#                        CALL t410_oob06_1_2()
#                        IF g_errno = 'N' THEN
#                           NEXT FIELD oob19_1
#                        ELSE 
#                        	 NEXT FIELD oob11_1
#                        END IF
#                     END IF 
#                  END IF
#                  IF g_oob_d[l_ac2].oob04_1='9' THEN 
#                     SELECT COUNT(*) INTO l_i FROM apc_file
#                      WHERE apc01=g_oob_d[l_ac2].oob06_1
#                     IF l_i=1 THEN
#                        LET g_oob_d[l_ac2].oob19_1=1
#                        CALL t410_oob06_1_2()
#                        IF g_errno = 'N' THEN
#                           NEXT FIELD oob19_1
#                        ELSE 
#                        	 NEXT FIELD oob11_1
#                        END IF
#                     END IF 
#                  END IF                   
#                END IF 
#              END IF
#           END IF
#
#        BEFORE FIELD oob19_1
#           CALL t410_set_no_entry_b1_2()
#           CALL t410_set_entry_b1_2()
#
#        AFTER FIELD oob19_1
#           IF cl_null(g_oob_d[l_ac2].oob19_1) AND 
#              NOT (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='4') THEN   
#              CALL cl_err("","axr-411",1)
#              NEXT FIELD oob06_1 
#           END IF 
#           IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN
#             #若為待扺，或為貸方
#              IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
#                  g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1 OR 
#                  g_oob_d_t.oob19_1 != g_oob_d[l_ac2].oob19_1 ) THEN  
#                 CALL t410_oob06_1_2()
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob19_1
#                 END IF
#              END IF
#           END IF
#           
#        
#        BEFORE FIELD oob15_1
#           CALL t410_set_no_entry_b1_2() 
#           CALL t410_set_entry_b1_2()
# 
#        AFTER FIELD oob15_1
#            IF g_ooz.ooz62 = 'Y' THEN
#               IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                  IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
#                     LET l_oma00 = NULL
#                     SELECT oma00 INTO l_oma00  FROM oma_file
#                      WHERE oma01 = g_oob_d[l_ac2].oob06_1 
#                     IF NOT cl_null(l_oma00) THEN
#                        IF l_oma00 NOT MATCHES '[15,16,17,18,26,27]' THEN
#                           NEXT FIELD oob15_1
#                        END IF
#                     ELSE
#                        NEXT FIELD oob15_1  
#                     END IF 
#                  ELSE
#                     NEXT FIELD oob15_1
#                  END IF  
#                END IF
#            END IF  
#
#            IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
#               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
#                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
#                  IF NOT cl_null(g_errno) THEN 
#                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                     NEXT FIELD oob06_1
#                  END IF 
#               END IF 
#            END IF  
#           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM oob_file
#                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
#                      oob15 = g_oob_d[l_ac2].oob15_1 AND
#                      oob01 = g_ooa.ooa01
#              IF p_cmd = 'a' THEN
#                 IF l_cnt > 0 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              ELSE
#                 IF l_cnt > 1 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              END IF
#              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
#                 g_oob_d_t.oob15_1 IS NULL THEN
#                 CALL t410_oob06_1_12_2()
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
#                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
#                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
#                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1 
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob06_1
#                 END IF
#              END IF
#          ELSE
#              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
#                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 CALL t410_oob06_1_item_2()
#              END IF
#          END IF 
#
#        AFTER FIELD oob17_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob17_1) THEN
#              CALL t410_oob17(g_oob_d[l_ac2].oob17_1)
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err('',g_errno,0)
#                 LET g_oob_d[l_ac2].oob17_1 = g_oob_d_t.oob17_1
#                 NEXT FIELD oob17_1
#              END IF  
#           END IF  
# 
#        AFTER FIELD oob18_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob18_1) THEN
#              CALL t410_oob18_1_2(g_oob_d[l_ac2].oob18_1)
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err('',g_errno,0)
#                 LET g_oob_d[l_ac2].oob18_1 = g_oob_d_t.oob18_1
#                 NEXT FIELD oob18_1
#              END IF  
#           END IF  
#      
#        AFTER FIELD oob21_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob21_1) THEN
#              CALL t410_oob21(g_oob_d[l_ac2].oob21_1)
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err('',g_errno,0)
#                 LET g_oob_d[l_ac2].oob21_1 = g_oob_d_t.oob21_1
#                 NEXT FIELD oob21_1
#              END IF  
#           END IF  
# 
#        BEFORE FIELD oob07_1
#           IF cl_null(g_oob_d[l_ac2].oob07_1) AND NOT cl_null(g_ooa.ooa23) THEN
#              LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
#           END IF
#           # 971021 TT/NR/CN/AR 不允許修改幣別
#           IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
#              (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
#           END IF
# 
#        AFTER FIELD oob07_1
#           IF g_oob_d[l_ac2].oob07_1 IS NULL THEN NEXT FIELD oob07_1 END IF
#           IF NOT cl_null(g_oob_d[l_ac2].oob07_1) THEN
#              CALL t410_oob07_1('a')
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err(g_oob_d[l_ac2].oob07_1,g_errno,0)
#                 LET g_oob_d[l_ac2].oob07_1 = g_oob_d_t.oob07_1
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
#                 NEXT FIELD oob07_1
#              END IF
#            END IF
# 
#        BEFORE FIELD oob08_1
#
#           CALL cl_set_comp_entry("oob08_1",TRUE)
#           CALL t410_set_no_entry_b_2()
#
#           LET oob08_t=g_oob_d[l_ac2].oob08_1   #No.+010
#           # 971021 TT/NR/CN/AR 不允許修改匯率
#           IF g_oob_d[l_ac2].oob08_1 = 0 OR g_oob_d[l_ac2].oob08_1 = 1 OR
#              cl_null(g_oob_d[l_ac2].oob08_1) THEN
#              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
#                   RETURNING g_oob_d[l_ac2].oob08_1
#              DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
#           END IF
#           LET oob08_t=g_oob_d[l_ac2].oob08_1
#
#        AFTER FIELD oob08_1
#           CALL cl_set_comp_entry("oob08_1",TRUE)
#           IF (oob08_t!=g_oob_d[l_ac2].oob08_1) THEN
#              LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
#              CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)
#                   RETURNING g_oob_d[l_ac2].oob10_1
#           END IF
# 
#        BEFORE FIELD oob09_1
#           LET oob09_t=g_oob_d[l_ac2].oob09_1
# 
#        AFTER FIELD oob09_1
### No.2694 modify 1998/10/31 判斷金額是否沖過頭
#           IF NOT cl_null(g_oob_d[l_ac2].oob09_1) THEN
#              IF g_oob_d_t.oob09_1 != g_oob_d[l_ac2].oob09_1 OR
#                 g_oob_d_t.oob09_1 IS NOT NULL THEN
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
#                    IF NOT t410_oob09_1_11_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
#                    IF NOT t410_oob09_1_12_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                    IF NOT t410_oob09_1_13_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t410_oob09_1_19_2('1',p_cmd,'1') THEN   
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t410_oob09_1_19_2('1',p_cmd,'2') THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#              END IF
#
#              IF (oob08_t!=g_oob_d[l_ac2].oob08_1) OR (oob09_t!=g_oob_d[l_ac2].oob09_1) OR oob09_t IS NULL THEN 
#                  SELECT azi04 INTO t_azi04 FROM azi_file  
#                  WHERE azi01 = g_oob_d[l_ac2].oob07_1
#                  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) 
#                 RETURNING g_oob_d[l_ac2].oob09_1
#                 LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
#                  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) 
#                 RETURNING g_oob_d[l_ac2].oob10_1
#              END IF
#              IF g_oob_d[l_ac2].oob09_1 <= 0 THEN
#                 IF g_oob_d[l_ac2].oob04_1 <> '7' THEN
#                    NEXT FIELD oob09_1
#                 END IF
#              END IF
#              IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') OR
#                    (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') THEN
#                    IF NOT t410_oob09_1_13_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#              END IF
#           END IF
# 
#        BEFORE FIELD oob10_1
#           LET oob10_t=g_oob_d[l_ac2].oob10_1
# 
#        AFTER FIELD oob10_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
#              IF g_oob_d_t.oob10_1 != g_oob_d[l_ac2].oob10_1 OR g_oob_d_t.oob10_1 IS NOT NULL THEN
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
#                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
#                     WHERE nmh01 = g_oob_d[l_ac2].oob06_1
#                       AND nmh38 <> 'X'
#                    IF cl_null(l_nmh32) THEN
#                       LET l_nmh32 = 0
#                    END IF
#                    IF g_oob_d[l_ac2].oob10_1 > l_nmh32 THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                    IF NOT t410_oob09_1_11_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
#                    IF NOT t410_oob09_1_12_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                    IF NOT t410_oob09_1_13_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t410_oob09_1_19_2('2',p_cmd,'1') THEN   
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t410_oob09_1_19_2('2',p_cmd,'2') THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#              END IF
#              IF oob10_t <> g_oob_d[l_ac2].oob10_1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
#                 IF cl_confirm('axr-320') THEN
#                    SELECT azi04 INTO t_azi04 FROM azi_file
#                     WHERE azi01 = g_oob_d[l_ac2].oob07_1
#                    CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#                         RETURNING g_oob_d[l_ac2].oob10_1
#                    LET g_oob_d[l_ac2].oob09_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob08_1
#                    CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
#                         RETURNING g_oob_d[l_ac2].oob09_1
#                 ELSE
#                    LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
#                 END IF
#              END IF
#              IF g_oob_d[l_ac2].oob08_1 = 1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
#                 LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
#              END IF
#              IF g_oob_d[l_ac2].oob10_1 <= 0 THEN
#                 NEXT FIELD oob10_1
#              END IF
#           END IF
# 
#        AFTER FIELD oob11_1
#          IF g_oob_d[l_ac2].oob11_1 IS NULL THEN NEXT FIELD oob11_1 END IF    
#          LET l_aag05=''   
#          IF NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
#             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1   
#                                                                   AND aag00=g_bookno1 
#                                                                   AND aag07 IN ('2','3')  #FUN-B10053 
#                                                                   AND aag03 = '2'         #FUN-B10053      
#             IF STATUS THEN
#                #No.FUN-B10053  --Begin
#                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",1) 
#                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",0) 
#                CALL cl_init_qry_var()
#                LET g_qryparam.form ='q_aag'
#                LET g_qryparam.construct = 'N'
#                LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
#                LET g_qryparam.arg1 = g_bookno1
#                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob_d[l_ac2].oob11_1 CLIPPED,"%'"
#                CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
#                DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
#                #No.FUN-B10053  --End
#                NEXT FIELD oob11_1
#             END IF
#             IF l_aag07='1' THEN #統制帳戶
#                CALL cl_err(g_oob_d[l_ac2].oob11_1,'agl-015',0) NEXT FIELD oob11_1
#             END IF
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN
#                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)  
#                                    RETURNING g_errno
#                   END IF
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob11_1
#                END IF
#             ELSE                                  
#                LET g_oob_d[l_ac2].oob13_1=''           
#                DISPLAY BY NAME g_oob_d[l_ac2].oob13_1  
#             END IF
#             CALL t410_set_no_entry_b1_2()   
#             CALL t410_set_entry_b1_2()      
#          END IF
#
#        AFTER FIELD oob111_1
#          IF g_oob_d[l_ac2].oob111_1 IS NULL THEN NEXT FIELD oob111_1 END IF   
#          IF NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
#             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob111_1 
#                                                                   AND aag00=g_bookno2
#                                                                   AND aag07 IN ('2','3')   #FUN-B10053 
#                                                                   AND aag03 = '2'          #FUN-B10053
#             IF STATUS THEN
#                #No.FUN-B10053  --Begin
#                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",1)  
#                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",0)  
#                CALL cl_init_qry_var()
#                LET g_qryparam.form ='q_aag'
#                LET g_qryparam.construct = 'N'
#                LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
#                LET g_qryparam.arg1 = g_bookno2
#                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob_d[l_ac2].oob111_1 CLIPPED,"%'"
#                CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
#                DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                #No.FUN-B10053  --End
#                NEXT FIELD oob111_1
#             END IF
#             IF l_aag07='1' THEN #統制帳戶
#                CALL cl_err(g_oob_d[l_ac2].oob111_1,'agl-015',0) NEXT FIELD oob111_1
#             END IF
# 
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN
#                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)  
#                                    RETURNING g_errno
#                   END IF
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob111_1
#                END IF
#             END IF
#
#          END IF
#
#          BEFORE FIELD oob13_1
#            LET l_aag05=''
#            SELECT aag05 INTO l_aag05 FROM aag_file
#             WHERE aag01=g_oob_d[l_ac2].oob11_1
#               AND aag00=g_bookno1        
#            IF l_aag05='N' THEN
#               LET g_oob_d[l_ac2].oob13_1=''
#               DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
#            END IF
#            CALL t410_set_no_entry_b1_2()   
#            CALL t410_set_entry_b1_2()      
#
#        AFTER FIELD oob13_1
#          IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN
#             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob_d[l_ac2].oob13_1
#                AND gemacti='Y'   
#             IF STATUS THEN
#                CALL cl_err3("sel","gem_file",g_oob_d[l_ac2].oob13_1,"",STATUS,"","select gem",1) 
#                NEXT FIELD oob13_1
#             END IF
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET l_aag05=''   
#             SELECT aag05 INTO l_aag05 FROM aag_file
#              WHERE aag01 = g_oob_d[l_ac2].oob11_1
#                AND aag00 = g_bookno1      
#            
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN    
#                   CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)
#                                 RETURNING g_errno
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob13_1
#                END IF
#             END IF
#            
#             IF g_aza.aza63='Y' THEN 
#                LET l_aag05=''   
#                SELECT aag05 INTO l_aag05 FROM aag_file
#                 WHERE aag01 = g_oob_d[l_ac2].oob111_1
#                   AND aag00 = g_bookno2      
#                
#                LET g_errno = ' '   
#                IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
#                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                   IF g_aaz.aaz90 !='Y' THEN  
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)
#                                    RETURNING g_errno
#                   END IF
#                   IF NOT cl_null(g_errno) THEN
#                      CALL cl_err('',g_errno,0)
#                      NEXT FIELD oob13_1
#                   END IF
#                END IF
#             END IF  
#          END IF
#
#            LET l_aag05=''
#            SELECT aag05 INTO l_aag05 FROM aag_file
#               WHERE aag01=g_oob_d[l_ac2].oob11_1  
#                 AND aag00=g_bookno1       
#            IF l_aag05='Y' AND cl_null(g_oob_d[l_ac2].oob13_1) THEN
#               CALL cl_err('','aap-099',0)
#               NEXT FIELD oob13_1
#            END IF
#
#        AFTER FIELD oobud01_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud02_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud03_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud04_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud05_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud06_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud07_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud08_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud09_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud10_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud11_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud12_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud13_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud14_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud15_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        BEFORE DELETE                            #是否取消單身
#            DISPLAY "g_oob_d_t.oob02_1=",g_oob_d_t.oob02_1
#            IF g_oob_d_t.oob02_1 > 0 AND g_oob_d_t.oob02_1 IS NOT NULL THEN
#                IF NOT cl_delb(0,0) THEN
#                   LET g_success = 'N'   
#                   CANCEL DELETE
#                END IF
#                IF l_lock_sw = "Y" THEN
#                   CALL cl_err("", -263, 1)
#                   LET g_success = 'N'   
#                   CANCEL DELETE
#                END IF
#                DELETE FROM oob_file
#                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
#                IF SQLCA.sqlcode THEN
#                    CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","",1)  
#                    LET g_success = 'N'
#                    CANCEL DELETE
#                END IF
#                CALL t410_mlog('R')
#                IF g_success = 'Y' THEN
#                   IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
#                      LET l_ooa34 = '0'
#                   END IF                                   
#                   LET g_rec_b2=g_rec_b2-1
#                   DISPLAY g_rec_b2 TO FORMONLY.cn3
#                   IF cl_null(g_oob_d_t.oob02_1) THEN
#                      LET g_rec_b2=g_rec_b2-1
#                   END IF
#                   COMMIT WORK
#                ELSE
#                   ROLLBACK WORK
#                END IF
#            END IF   
#            CALL t410_bu()
# 
#        ON ROW CHANGE
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               CLOSE t410_bcl
#               ROLLBACK WORK
#               EXIT INPUT
#            END IF
#            IF l_lock_sw = 'Y' THEN
#               CALL cl_err(g_oob_d[l_ac2].oob02_1,-263,1)
#               LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               LET g_success='N'   
#            ELSE
#               CALL t410_b_move_back_2()
#               SELECT COUNT(*) INTO l_n FROM oob_file
#                WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
#               IF l_n = 0 THEN                                   
#                  IF g_oob_d[l_ac2].oob09_1 = 0 AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                     INITIALIZE g_oob_d[l_ac2].* TO NULL  #重要欄位空白,無效
#                     LET g_success='N'   
#                  END IF
#               END IF
#
#           IF g_ooz.ooz62 = 'Y' THEN  
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#           END IF
#           IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
#               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
#                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
#                  IF NOT cl_null(g_errno) THEN 
#                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                     NEXT FIELD oob06_1
#                  END IF 
#               END IF 
#            END IF   
#           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM oob_file
#                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
#                      oob15 = g_oob_d[l_ac2].oob15_1 AND
#                      oob01 = g_ooa.ooa01
#              IF p_cmd = 'a' THEN
#                 IF l_cnt > 0 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              ELSE
#                 IF l_cnt > 1 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              END IF
#              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
#                 g_oob_d_t.oob15_1 IS NULL THEN
#                 CALL t410_oob06_1_12_2()
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
#                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
#                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
#                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob06_1
#                 END IF
#              END IF
#          ELSE
#              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
#                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 CALL t410_oob06_1_item_2()
#              END IF
#          END IF 
#               
#               UPDATE oob_file SET * = b_oob.*
#                  WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","upd oob",1)  
#                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
#                  LET g_success='N'   
#               ELSE 
#                  UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
#                   WHERE ooa01 = g_ooa.ooa01 
#                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#                     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
#                     LET g_oob_d[l_ac2].* = g_oob_d_t.*
#                     LET g_success='N'   
#                  END IF
#                  DISPLAY g_user TO ooamodu
#                  DISPLAY g_today TO ooadate
#                END IF
#            END IF
#            CALL t410_mlog('U')
#            CALL t410_bu()
#            IF g_success = 'Y' THEN
#               MESSAGE 'UPDAET O.K'
#               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
#                  LET l_ooa34 = '0'
#               END IF                       
#               COMMIT WORK
#            ELSE
#               MESSAGE 'UPDATE ERR'
#               ROLLBACK WORK
#            END IF
#
#        AFTER ROW
#            LET l_ac2 = ARR_CURR()
#            LET l_ac2_t = l_ac2
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               IF p_cmd = 'u' THEN
#                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               END IF
#               CLOSE t410_bcl
#               ROLLBACK WORK
#               EXIT INPUT
#            END IF
#            CLOSE t410_bcl
#            COMMIT WORK
# 
#        ON ACTION CONTROLO                        #沿用所有欄位
#            IF INFIELD(oob02_1) AND l_ac2 > 1 THEN
#                LET g_oob_d[l_ac2].* = g_oob_d[l_ac2-1].*
#                LET g_oob_d[l_ac2].oob02_1 = NULL
#                NEXT FIELD oob02_1
#            END IF
#        ON ACTION controls                             
#         CALL cl_set_head_visible("","AUTO")           
# 
#        ON ACTION CONTROLP
#            CASE
##MOD-590452 將原本mark的部份取消
#                WHEN INFIELD(oob04_1)
#                     CALL cl_init_qry_var()
#                     LET g_qryparam.form = "q_ooc"
#                     LET g_qryparam.default1 = g_oob_d[l_ac2].oob04_1
#                     LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  
#                     CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob04_1
#                     DISPLAY BY NAME g_oob_d[l_ac2].oob04_1         
#                     NEXT FIELD oob04_1
#
#                 WHEN INFIELD(oob06_1)
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                          CALL cl_init_qry_var()
#                          LET g_qryparam.form = "q_nmh5"
#                          LET g_qryparam.arg1 = g_ooa.ooa03
#                          LET g_qryparam.arg2 = g_doc_len   
#                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
#                          NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
#                          CALL cl_init_qry_var()
#                          LET g_qryparam.form = "q_nmg"
#                          LET g_qryparam.default1 = g_oob_d[l_ac2].oob06_1
#                           LET g_qryparam.arg1 = g_ooa.ooa03   
#                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
#                          NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                         CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
#                                     g_ooa.ooa01,g_ooa.ooa03,'2*')                   
#                              RETURNING b_oob.oob06,b_oob.oob09,       
#                                        b_oob.oob10,b_oob.oob19
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                            LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19   
#                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
#                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                         CALL q_apa4( FALSE, TRUE, ' ')
#                         RETURNING b_oob.oob06
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                         IF g_ooz.ooz62='N' THEN
#                            CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
#                                        g_ooa.ooa01,g_ooa.ooa03,'1*')                    
#                                 RETURNING b_oob.oob06,b_oob.oob09,  
#                                           b_oob.oob10,b_oob.oob19
#                         ELSE
#                            CALL q_omb(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1,
#                                       g_ooa.ooa01, g_ooa.ooa03,'1%') 
#                             RETURNING b_oob.oob06,b_oob.oob15,
#                                       b_oob.oob09,b_oob.oob10
#                         END IF
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
#                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
#                            IF g_ooz.ooz62='Y' THEN
#                               LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
#                            ELSE
#                               LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19
#                            END IF
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                         CALL q_apa5( FALSE, TRUE, ' ')
#                              RETURNING b_oob.oob06
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='A' THEN
#                         CALL q_nmg(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_ooa.ooa03,
#                                    g_ooa.ooa032,g_ooa.ooa02,g_ooa.ooa23)
#                              RETURNING g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,
#                                        g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,    
#                                        g_oob_d[l_ac2].oob18_1,g_oob_d[l_ac2].oob17_1
#                         NEXT FIELD oob06_1
#                         DISPLAY BY NAME g_oob_d[l_ac2].oob18_1
#                         DISPLAY BY NAME g_oob_d[l_ac2].oob17_1
#                      END IF
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob06_1     
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob09_1    
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob10_1     
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob15_1     
#               WHEN INFIELD(oob11_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_aag'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
#                    LET g_qryparam.arg1 = g_bookno1      
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
#                    NEXT FIELD oob11_1
#
#               WHEN INFIELD(oob111_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_aag'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
#                    LET g_qryparam.arg1 = g_bookno2       
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                    NEXT FIELD oob111_1
#
#               WHEN INFIELD(oob13_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = 'q_gem'
#                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob13_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob13_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
#                    NEXT FIELD oob13_1
#               WHEN INFIELD(oob07_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_azi'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob07_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob07_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
#                    NEXT FIELD oob07_1
#
#               WHEN INFIELD(oob08_1)
#                    CALL s_rate(g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1)
#                    RETURNING g_oob_d[l_ac2].oob08_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
#                    NEXT FIELD oob08_1
#
#               WHEN INFIELD (oob17_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = 'q_nma'
#                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob17_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob17_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob17_1
#                    NEXT FIELD oob17_1
#               WHEN INFIELD (oob18_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = 'q_nmc02'
#                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob18_1
#                    LET g_qryparam.arg1 = '2'
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob18_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob18_1
#                    NEXT FIELD oob18_1
#               WHEN INFIELD (oob21_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = 'q_nml'
#                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob21_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob21_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob21_1
#                    NEXT FIELD oob21_1
#
#               OTHERWISE EXIT CASE
#            END CASE
# 
#        ON ACTION CONTROLZ
#           CALL cl_show_req_fields()
# 
#        ON ACTION CONTROLG
#           CALL cl_cmdask()
# 
#        ON ACTION receive_notes
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                    CALL cl_cmdrun_wait('anmt200') 
#                 END IF
#        ON ACTION bank_income_expense
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN   
#                    CALL cl_cmdrun_wait('anmt302')  
#                 END IF
#        ON ACTION maintain_accounts
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                    CALL cl_cmdrun_wait('axrt300')  
#                 END IF
#                 IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                    CALL cl_cmdrun_wait('axrt300')  
#                 END IF
#        ON ACTION ar_account_category
#                    CALL cl_cmdrun('axri040')
#
#        ON ACTION CONTROLF
#         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
#         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
# 
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
# 
#      ON ACTION about         
#         CALL cl_about()    
# 
#      ON ACTION help          
#         CALL cl_show_help()  
#  
#      END INPUT
#FUN-A90003--Add--End--#     
#    
#     
#     IF g_ooa.ooaconf <> 'Y' THEN            #FUN-640246
#        UPDATE ooa_file SET ooa34=l_ooa34 WHERE ooa01 = g_ooa.ooa01
#        LET g_ooa.ooa34 = l_ooa34
#        DISPLAY BY NAME g_ooa.ooa34
#     END IF
#     IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
#     IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
#     CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
#     ## END FUN-550049 ##
# 
#      IF (g_ooa.ooa23 IS NULL AND g_ooa.ooa32d != g_ooa.ooa32c) OR
#         (g_ooa.ooa23 IS NOT NULL AND
#         (g_ooa.ooa31d != g_ooa.ooa31c OR g_ooa.ooa32d != g_ooa.ooa32c)) THEN
#         LET p_row = 10 LET p_col = 27
#         OPEN WINDOW t4001_w AT p_row,p_col WITH FORM "axr/42f/axrt4101"
#               ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
# 
#         CALL cl_ui_locale("axrt4101")
# 
#         INPUT BY NAME diff_flag
#          AFTER FIELD diff_flag
#           IF diff_flag NOT MATCHES "[90E]" THEN NEXT FIELD diff_flag END IF
#           IF diff_flag MATCHES '[9]'  AND g_ooa.ooa32d > g_ooa.ooa32c THEN
#              CALL cl_err('','axr-303',0) NEXT FIELD diff_flag
#           END IF
#            ON IDLE g_idle_seconds
#               CALL cl_on_idle()
#               CONTINUE INPUT
# 
#      ON ACTION about         #MOD-4C0121
#         CALL cl_about()      #MOD-4C0121
# 
#      ON ACTION help          #MOD-4C0121
#         CALL cl_show_help()  #MOD-4C0121
# 
#      ON ACTION controlg      #MOD-4C0121
#         CALL cl_cmdask()     #MOD-4C0121
# 
# 
#         END INPUT
#         #UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today   #MOD-870147
#         # WHERE ooa01 = g_ooa.ooa01   #MOD-870147
#         IF INT_FLAG THEN LET INT_FLAG=0 LET diff_flag='0' END IF
#         CLOSE WINDOW t4001_w
#         IF diff_flag='0' THEN 
#            CALL t410_b()
#            CALL t410_b2()                  #FUN-A90003 Add  
#         END IF #GENERO 再進單身時
#      END IF
#    CLOSE t410_bcl
#    COMMIT WORK
#    IF diff_flag MATCHES "[9]" THEN
#       CALL t410_diff()
#       CALL t410_b_fill('1=1')         #FOR GENERO BUG調整
#       CALL t410_b_fill_2('1=1') #FUN-A90003 Add
#    END IF
## 新增自動確認功能 Modify by Charis 96-09-23
##    LET g_t1=g_ooa.ooa01[1,3]   #TQC-5A0089
#    LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
#    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
#    IF STATUS THEN
##      # CALL cl_err('sel ooy_file',STATUS,0)   #No.FUN-660116
#       # CALL cl_err3("sel","ooy_file",g_t1,"",STATUS,"","sel ooy_file",1)  #No.FUN-660116
#       RETURN
#    END IF
#    #-----97/05/26 modify 詢問是否產生分錄底稿
#    IF g_ooa.ooa31d>0 AND g_ooa.ooa31d=g_ooa.ooa31c AND g_ooy.ooydmy1='Y' THEN
#       IF cl_confirm('axr-309') THEN
#          CALL t410_v()
#       END IF
#    END IF
#    IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
#       THEN RETURN
#    ELSE
##FUN-580154
#       LET g_action_choice = "insert"        #FUN-640246
#       #CALL t410_y()
#       CALL t410_y_chk()          #CALL 原確認的 check 段
#       IF g_success = "Y" THEN
#          CALL t410_y_upd()       #CALL 原確認的 update 段
#       END IF
##FUN-580154 End
#    END IF
#    IF g_ooy.ooyprit='Y' THEN CALL t410_out() END IF   #單據需立即列印
#No.MOD-B50249 --end # -----------------
END FUNCTION
 
FUNCTION t410_set_entry_b()
 
    MESSAGE ''
 
    CALL cl_set_comp_entry("oob07,oob08",TRUE)
    CALL cl_set_comp_entry("oob15",TRUE)
    CALL cl_set_comp_entry("oob11",TRUE)    #No.MOD-B30255 
   ##No.FUN-680022--begin-- add
   # IF g_ooz.ooz62='N' OR g_oob[l_ac].oob04='9' THEN
   #    CALL cl_set_comp_entry("oob19",TRUE)
   # ELSE 
   #    CALL cl_set_comp_entry("oob15",TRUE)
   # END IF
   ##No.FUN-680022--end-- add
 
END FUNCTION
 
FUNCTION t410_set_no_entry_b()
 
    MESSAGE ''
    IF NOT cl_null(g_ooa.ooa23) THEN
       CALL cl_set_comp_entry("oob07",FALSE)
    END IF
    IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[1239]") OR
       (g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[1]") THEN
       CALL cl_set_comp_entry("oob07,oob08",FALSE)
    END IF
    IF INFIELD(oob04) THEN
      #IF g_oob[l_ac].oob03 <> '1' AND g_oob[l_ac].oob04 <> '2' THEN   #MOD-630069   #MOD-670042
       IF NOT (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2') THEN   #MOD-670042
          IF g_ooz.ooz62 <> 'Y' OR g_oob[l_ac].oob03<>'2' OR
             g_oob[l_ac].oob04<>'1' THEN
             CALL cl_set_comp_entry("oob15",FALSE)
          END IF
       END IF   #MOD-630069
      #str MOD-8B0210 add
      #若oob04='9'時,oob15預設值為0,無須維護
       IF g_oob[l_ac].oob04 = '9' THEN
          CALL cl_set_comp_entry("oob15",FALSE)
       END IF
      #end MOD-8B0210 add
    END IF
#MOD-5B0012
    IF g_oob[l_ac].oob07=g_aza.aza17 THEN
       CALL cl_set_comp_entry("oob08",FALSE)
       LET g_oob[l_ac].oob08=1.0
       DISPLAY BY NAME g_oob[l_ac].oob08
#MOD-940238 MARK BEGIN--
#    #MOD-910070---begin            
#    ELSE                                                                            
#       SELECT azi07 INTO t_azi07 FROM azi_file                                                                            
#        WHERE azi01 = g_oob[l_ac].oob07                                                                                   
#       LET g_oob[l_ac].oob08 = cl_digcut(g_oob[l_ac].oob08,t_azi07)                                                       
#       DISPLAY BY NAME g_oob[l_ac].oob08
#    #MOD-910070---end    
#MOD-940238 MARK END--    
    END IF
#END MOD-5B0012
#No.FUN-680022--begin-- add
#   IF g_ooz.ooz62 ='N' OR g_oob[l_ac].oob04='9' THEN
#      CALL cl_set_comp_entry("oob15",FALSE)
#   ELSE
#      CALL cl_set_comp_entry("oob19",FALSE)
#   END IF
#No.FUN-680022--end-- add
END FUNCTION
 
#No.FUN-8A0075--BEGIN--
FUNCTION t410_set_entry_b_1()
   CALL cl_set_comp_entry("oob02,oob03,oob06,oob19,oob15,oob14,oob07,
                           oob08,oob10,oob12",TRUE)
END FUNCTION
 
FUNCTION t410_set_no_entry_b_1()
 IF g_ooa.ooa34 matches '[Ss]' THEN
   CALL cl_set_comp_entry("oob02,oob03,oob06,oob19,oob15,oob14,oob07, 
                           oob08,oob10,oob12",FALSE)
 END IF
END FUNCTION
#No.FUN-8A0075--END-- 
 
#No.FUN-680022--begin-- add
FUNCTION t410_set_entry_b1()
    DEFINE l_aag05  LIKE aag_file.aag05   #MOD-920163 add
 
    IF g_oob[l_ac].oob03='1' THEN
       IF g_oob[l_ac].oob04='3' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04='4' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
#      IF g_oob[l_ac].oob04 NOT MATCHES '[34]' THEN                  #No.MOD-740406
      #IF g_oob[l_ac].oob04 NOT MATCHES '[34]' AND    #MOD-8B0210 mark
       IF g_oob[l_ac].oob04 NOT MATCHES '[349]' AND   #MOD-8B0210
          NOT(g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN  #No.MOD-740406
          CALL cl_set_comp_entry("oob15",TRUE)
       END IF
    END IF
    IF g_oob[l_ac].oob03='2' THEN
       IF g_oob[l_ac].oob04='1' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04='9' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04 NOT MATCHES '[19]' THEN
          CALL cl_set_comp_entry("oob15",TRUE)
       END IF
    END IF
 
   #str MOD-920163 add
    LET l_aag05=''
    SELECT aag05 INTO l_aag05 FROM aag_file
     WHERE aag01=g_oob[l_ac].oob11  
       AND aag00=g_bookno1        #No.FUN-730073
    IF l_aag05='Y' THEN
       CALL cl_set_comp_entry("oob13",TRUE)
    END IF
   #end MOD-920163 add
 
   #IF g_oob[l_ac].oob03='1' THEN
   #   IF g_oob[l_ac].oob04='3' OR g_oob[l_ac].oob04='4' THEN
   #      CALL cl_set_comp_entry("oob19",TRUE)
   #      IF g_ooz.ooz62 = 'Y' THEN
   #         CALL cl_set_comp_entry("oob15",TRUE)
   #      END IF
   #   ELSE
   #      CALL cl_set_comp_entry("oob15",TRUE)
   #   END IF
   #END IF
   #IF g_oob[l_ac].oob03='2' THEN
   #   IF g_oob[l_ac].oob04='1' OR g_oob[l_ac].oob04='9' THEN
   #      CALL cl_set_comp_entry("oob19",TRUE)
   #      IF g_ooz.ooz62 = 'Y' THEN
   #         CALL cl_set_comp_entry("oob15",TRUE)
   #      END IF
   #   ELSE
   #      CALL cl_set_comp_entry("oob15",TRUE)
   #   END IF
   #END IF
END FUNCTION
 
FUNCTION t410_set_no_entry_b1()
    CALL cl_set_comp_entry("oob15,oob19",FALSE)
    CALL cl_set_comp_entry("oob13",FALSE)   #MOD-920163 add
END FUNCTION
#No.FUN-680022--end-- add
 
FUNCTION t410_b_move_to()
   LET g_oob[l_ac].oob02 = b_oob.oob02
   LET g_oob[l_ac].oob03 = b_oob.oob03
   LET g_oob[l_ac].oob04 = b_oob.oob04
   CALL s_oob04(g_oob[l_ac].oob03,g_oob[l_ac].oob04)
                RETURNING g_oob[l_ac].oob04_d
   LET g_oob[l_ac].oob06 = b_oob.oob06
   LET g_oob[l_ac].oob15 = b_oob.oob15
   #FUN-960141 add begin
   LET g_oob[l_ac].oob20 = b_oob.oob20
   LET g_oob[l_ac].oob23 = b_oob.oob23
   LET g_oob[l_ac].oob17 = b_oob.oob17
   LET g_oob[l_ac].oob18 = b_oob.oob18
   LET g_oob[l_ac].oob21 = b_oob.oob21
   #FUN-960141 add end
   LET g_oob[l_ac].oob07 = b_oob.oob07
   LET g_oob[l_ac].oob08 = b_oob.oob08
   LET g_oob[l_ac].oob09 = b_oob.oob09
   LET g_oob[l_ac].oob10 = b_oob.oob10
   LET g_oob[l_ac].oob11 = b_oob.oob11
   IF g_aza.aza63='Y' THEN                  #No.FUN-670047 add
      LET g_oob[l_ac].oob111 = b_oob.oob111 #No.FUN-670047 add
   END IF                                   #No.FUN-670047 add
   LET g_oob[l_ac].oob12 = b_oob.oob12
   LET g_oob[l_ac].oob13 = b_oob.oob13
   LET g_oob[l_ac].oob14 = b_oob.oob14
   #NO.FUN-850038 --start--
   LET g_oob[l_ac].oobud01 = b_oob.oobud01
   LET g_oob[l_ac].oobud02 = b_oob.oobud02
   LET g_oob[l_ac].oobud03 = b_oob.oobud03
   LET g_oob[l_ac].oobud04 = b_oob.oobud04
   LET g_oob[l_ac].oobud05 = b_oob.oobud05
   LET g_oob[l_ac].oobud06 = b_oob.oobud06
   LET g_oob[l_ac].oobud07 = b_oob.oobud07
   LET g_oob[l_ac].oobud08 = b_oob.oobud08
   LET g_oob[l_ac].oobud09 = b_oob.oobud09
   LET g_oob[l_ac].oobud10 = b_oob.oobud10
   LET g_oob[l_ac].oobud11 = b_oob.oobud11
   LET g_oob[l_ac].oobud12 = b_oob.oobud12
   LET g_oob[l_ac].oobud13 = b_oob.oobud13
   LET g_oob[l_ac].oobud14 = b_oob.oobud14
   LET g_oob[l_ac].oobud15 = b_oob.oobud15
   #NO.FUN-850038 --end--
END FUNCTION
 
FUNCTION t410_b_move_back()
   LET b_oob.oob02 = g_oob[l_ac].oob02
   LET b_oob.oob03 = g_oob[l_ac].oob03
   LET b_oob.oob04 = g_oob[l_ac].oob04
   LET b_oob.oob06 = g_oob[l_ac].oob06
   LET b_oob.oob15 = g_oob[l_ac].oob15
   LET b_oob.oob07 = g_oob[l_ac].oob07
   LET b_oob.oob08 = g_oob[l_ac].oob08
   LET b_oob.oob09 = g_oob[l_ac].oob09
   LET b_oob.oob10 = g_oob[l_ac].oob10
   LET b_oob.oob11 = g_oob[l_ac].oob11
   IF g_aza.aza63='Y' THEN                   #No.FUN-670047 add
      LET b_oob.oob111 =  g_oob[l_ac].oob111 #No.FUN-670047 add
   END IF                                    #No.FUN-670047 add
   LET b_oob.oob12 = g_oob[l_ac].oob12
   LET b_oob.oob13 = g_oob[l_ac].oob13
   LET b_oob.oob14 = g_oob[l_ac].oob14
   LET b_oob.oob19 = g_oob[l_ac].oob19       #No.FUN-680022 add
   #No.FUN-850038 --start--
   LET b_oob.oobud01 = g_oob[l_ac].oobud01
   LET b_oob.oobud02 = g_oob[l_ac].oobud02
   LET b_oob.oobud03 = g_oob[l_ac].oobud03
   LET b_oob.oobud04 = g_oob[l_ac].oobud04
   LET b_oob.oobud05 = g_oob[l_ac].oobud05
   LET b_oob.oobud06 = g_oob[l_ac].oobud06
   LET b_oob.oobud07 = g_oob[l_ac].oobud07
   LET b_oob.oobud08 = g_oob[l_ac].oobud08
   LET b_oob.oobud09 = g_oob[l_ac].oobud09
   LET b_oob.oobud10 = g_oob[l_ac].oobud10
   LET b_oob.oobud11 = g_oob[l_ac].oobud11
   LET b_oob.oobud12 = g_oob[l_ac].oobud12
   LET b_oob.oobud13 = g_oob[l_ac].oobud13
   LET b_oob.oobud14 = g_oob[l_ac].oobud14
   LET b_oob.oobud15 = g_oob[l_ac].oobud15
   #NO.FUN-850038 --end--
   #FUN-960141 add begin
    LET b_oob.oob20 = g_oob[l_ac].oob20
    LET b_oob.oob23 = g_oob[l_ac].oob23
    LET b_oob.oob17 = g_oob[l_ac].oob17
    LET b_oob.oob18 = g_oob[l_ac].oob18
    LET b_oob.oob21 = g_oob[l_ac].oob21
   #FUN-960141 add end
    #LET b_oob.oobplant = g_plant #FUN-980011 add   #FUN-960141 mark 090824
    LET b_oob.ooblegal = g_legal #FUN-980011 add
END FUNCTION
 
FUNCTION t410_acct_code()
   DEFINE l_ool RECORD LIKE ool_file.*
   SELECT * INTO l_ool.* FROM ool_file WHERE ool01=g_ooa.ooa13
   CASE WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '5'
             LET b_oob.oob11 = l_ool.ool54
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool541    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '6'
             LET b_oob.oob11 = l_ool.ool51
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool511    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '7' AND
             g_oob[l_ac].oob10 > 0   
             LET b_oob.oob11 = l_ool.ool52
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool521    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
       #FUN-9C0168--add--str--
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = 'A'
             LET b_oob.oob11 = l_ool.ool33
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool331   
             END IF                              
       #FUN-9C0168--add--end

       #No.FUN-670047--begin-- mark
       #WHEN g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '7'
       #  #  AND g_oob[l_ac].oob10 < 0    #98/03/10 modify
       #     LET b_oob.oob11 = l_ool.ool53
       #  #  LET g_oob[l_ac].oob10= -g_oob[l_ac].oob10
       #     LET g_oob[l_ac].oob10= g_oob[l_ac].oob10
       #No.FUN-670047--end-- mark
        WHEN g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '7'
             LET b_oob.oob11 = l_ool.ool53
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool531    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '8'
             LET b_oob.oob11 = l_ool.ool23
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool231    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '2'
             LET b_oob.oob11 = l_ool.ool25
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool251    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        OTHERWISE
          #No.B093 010411 by plum add
          #LET g_oob[l_ac].oob11 = null
           IF b_oob.oob04 != g_oob[l_ac].oob04 THEN
              LET b_oob.oob11 = null
              LET b_oob.oob111= null     #No.FUN-670047 add
           END IF
           LET g_oob[l_ac].oob11 = null
           LET g_oob[l_ac].oob111= null  #No.FUN-670047 add
          
          #No.B093..end
   END CASE
    #MOD-560005
   #LET g_oob[l_ac].oob11 = b_oob.oob11
   IF cl_null(g_oob[l_ac].oob11) THEN
      LET g_oob[l_ac].oob11 = b_oob.oob11
      LET g_oob[l_ac].oob111= b_oob.oob111  #No.FUN-670047 add
      #-------------NO.MOD-5A0095 START--------------
      DISPLAY BY NAME g_oob[l_ac].oob11
      DISPLAY BY NAME g_oob[l_ac].oob111    #No.FUN-670047 add
      #-------------NO.MOD-5A0095 END----------------
   ELSE
      LET b_oob.oob11 =g_oob[l_ac].oob11
      LET b_oob.oob111=g_oob[l_ac].oob111   #No.FUN-670047 add 
   END IF
   #-
END FUNCTION
 
FUNCTION t410_oob06()
DEFINE l_nmg  RECORD LIKE nmg_file.*  #MDO-740395
  LET g_errno=' '
#MOD-740395.....begin
# SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
#  WHERE nmg00= g_oob[l_ac].oob06
#    AND (nmg20='21' OR nmg20='22')
#    AND (nmg29 ='Y')    #NO:4181
# IF STATUS THEN  
#    CALL cl_err('','axr-202',0)  #MOD-740395
#    LET g_errno='N' 
#    RETURN  #MOD-740395
# END IF 
#MOD-740395.....end
  IF g_oob[l_ac].oob03='1' THEN
     IF g_oob[l_ac].oob04='1' THEN CALL t410_oob06_11() END IF
#    IF g_oob[l_ac].oob04='2' THEN CALL t410_oob06_12() END IF   #MOD-630069
     IF g_oob[l_ac].oob04='3' THEN CALL t410_oob06_13('2') END IF
    #IF g_oob[l_ac].oob04='9' THEN CALL t410_oob06_19() END IF   #MOD-750063
     IF g_oob[l_ac].oob04='9' THEN CALL t410_oob06_19('1') END IF   #MOD-750063
  END IF
  IF g_oob[l_ac].oob03='2' THEN
     IF g_oob[l_ac].oob04='1' THEN CALL t410_oob06_13('1') END IF
    #IF g_oob[l_ac].oob04='9' THEN CALL t410_oob06_19() END IF   #MOD-750063
     IF g_oob[l_ac].oob04='9' THEN CALL t410_oob06_19('2') END IF   #MOD-750063
  END IF
  
  DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                  g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                  g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                  g_oob[l_ac].oob13,g_oob[l_ac].oob14   #MOD-8A0009
 
END FUNCTION
 
###98/07/29 add by connie,online check
 
FUNCTION t410_oob09_11(l_sw,l_cmd)                # 借方檢查 : 支票
   DEFINE l_sw      LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd     LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh02   LIKE nmh_file.nmh02
   DEFINE l_nmh32   LIKE nmh_file.nmh32
   DEFINE l_nmydmy3 LIKE nmy_file.nmydmy3
   DEFINE l_oob09,l_oob10 LIKE oob_file.oob09
   #add 030422 NO.A058
   DEFINE tot1,tot2,tot3  LIKE oob_file.oob09
   DEFINE l_nmz59         LIKE nmz_file.nmz59
   DEFINE l_sql           LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(500)   #TQC-5A0089
 
   IF g_ooz.ooz04='N' THEN RETURN TRUE END IF
 
  #No.+093 010427 by plum #若收票單別其拋轉傳票為Y,不可用來沖AR
  #SELECT nmh02,nmh32 INTO l_nmh02,l_nmh32
  #  FROM nmh_file WHERE nmh01= g_oob[l_ac].oob06
  #IF STATUS THEN
  #   LET l_nmh02 = 0
  #END IF
#TQC-5A0089
   LET l_sql=
   " SELECT nmh02,nmh32,nmydmy3 ",
   "  FROM nmh_file,nmy_file ",
   " WHERE nmh01= '",g_oob[l_ac].oob06,"' AND nmh01[1,",g_doc_len,"]=nmyslip ",
   "   AND nmh38 <> 'X' "
   PREPARE nmh_p FROM l_sql
   DECLARE nmh_c CURSOR FOR nmh_p
   OPEN nmh_c
   FETCH nmh_c INTO l_nmh02,l_nmh32,l_nmydmy3
#   SELECT nmh02,nmh32,nmydmy3 INTO l_nmh02,l_nmh32 ,l_nmydmy3
#     FROM nmh_file,nmy_file
#    WHERE nmh01= g_oob[l_ac].oob06 AND nmh01[1,3]=nmyslip
#      AND nmh38 <> 'X'
#END TQC-5A0089
   IF STATUS THEN
      LET l_nmh02 = 0
   #-----TQC-630086---------
   #str MOD-940156 mark回復
    ELSE
       IF l_nmydmy3='Y' THEN
          CALL cl_err(g_oob[l_ac].oob06,'axr-066',0)
          RETURN FALSE  #No:8326
       END IF
   #end MOD-940156 mark回復
   #-----END TQC-630086-----
   END IF
  #No.+093..end
 
   #SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file   #MOD-810222
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file   #MOD-810222
    WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '1'
     #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-950237
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
      AND oob01 = ooa01 AND ooaconf <> 'X'   #MOD-810222
      AND ooa34 <> '9'   #MOD-810222
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
 
   #add 030422  NO.A058
   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
     #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-950237
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
   IF l_sw = '1' THEN
#modify 030422 NO.A058
#     IF l_cmd = 'a' THEN    #新增
         IF (l_oob09+g_oob[l_ac].oob09) > l_nmh02 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
   ELSE
      #modify 030422 NO.A058
      SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz59 = 'N' THEN    #不做月底重評時, 依原判斷
         IF (l_oob10+g_oob[l_ac].oob10) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('4','1',g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
         IF (tot2+g_oob[l_ac].oob10) > tot3 THEN
            CALL cl_err('','axr-185',1)
            LET g_oob[l_ac].oob10 = tot3 - tot2
            RETURN FALSE
         END IF
      END IF
     #---modi end
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob09_12(l_sw,l_cmd)                # 借方檢查 : TT
   DEFINE l_sw    LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd   LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh02,l_nmh32 LIKE nmh_file.nmh02
   DEFINE l_oob09,l_oob10 LIKE oob_file.oob09
   #add 030422 NO.A058
   DEFINE l_nmz20         LIKE nmz_file.nmz20
 
   SELECT SUM(npk08),SUM(npk09) INTO l_nmh02,l_nmh32 FROM nmg_file,npk_file
    WHERE nmg00=npk00 AND nmg00= g_oob[l_ac].oob06
      AND npk01=g_oob[l_ac].oob15   #MOD-630069
      AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
      AND nmgconf <> 'X'
 
   IF cl_null(l_nmh02) THEN LET l_nmh02 = 0 LET l_nmh32 = 0 END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file   #MOD-850229 add 串ooa_file
    WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '2'
      #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-630069
      AND oob01 = ooa01 AND ooaconf <> 'X'   #MOD-850229 add
      AND oob01 <> g_ooa.ooa01    #MOD-630069
      AND oob15 = g_oob[l_ac].oob15   #MOD-630069
 
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
 
   #add 030422  NO.A058
   #須考慮未確認沖帳資料
   #-----MOD-630069---------
   #SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
   # WHERE oob06 = g_oob[l_ac].oob06
   #   AND oob01 = ooa01 AND ooaconf = 'N'
   #   AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)
   #   AND oob03 = g_oob[l_ac].oob03
   #   AND oob04 = g_oob[l_ac].oob04
   #IF cl_null(tot1) THEN LET tot1 = 0 END IF
   #IF cl_null(tot2) THEN LET tot2 = 0 END IF
   #-----END MOD-630069-----
 
   IF l_sw = '1' THEN
      IF (l_oob09+g_oob[l_ac].oob09) > l_nmh02 THEN
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      #modify 030422 NO.A058
      SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz20 = 'N' THEN      #不做月底重評時, 依原判斷
         IF (l_oob10+g_oob[l_ac].oob10) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('3','2',g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
        #IF (tot2+g_oob[l_ac].oob10) > tot3 THEN        #No.MOD-830186 mark
#         IF (l_oob10+g_oob[l_ac].oob10) > tot3 THEN     #No.MOD-830186  #MOD-940355
          IF g_oob[l_ac].oob10 > tot3 THEN               #MOD-940355
            CALL cl_err('','axr-185',1)
            LET g_oob[l_ac].oob10 = tot3 - tot2         #No.MOD-830186 mark
            LET g_oob[l_ac].oob10 = tot3 - l_oob10      #No.MOD-830186
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob09_13(l_sw,l_cmd)  # 檢查 :3:取待抵 1:取應收
   DEFINE l_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omc          RECORD LIKE omc_file.*
   DEFINE l_message      LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(70)
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE tot5,tot6      LIKE oob_file.oob09    #No.TQC-670085
   DEFINE tot7,tot8      LIKE oob_file.oob09    #No.FUN-680022 --add
   DEFINE l_oob09        LIKE oob_file.oob09
   DEFINE l_diff         LIKE oob_file.oob10
   DEFINE l_msg1,l_msg2  LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(40)
   DEFINE l_tc_hka14     LIKE tc_hka_file.tc_hka14
   LET tot1 = 0
   LET tot2 = 0
 
   SELECT * INTO l_oma.* FROM oma_file
    WHERE oma01=g_oob[l_ac].oob06 AND omavoid='N'
   IF STATUS THEN
      LET l_oma.oma54t = 0
      LET l_oma.oma56t = 0
      LET l_oma.oma55  = 0
      LET l_oma.oma57  = 0
      LET l_oma.oma61  = 0    #No.TQC-5C0086
   END IF
   #mark by andy 2017/4/21 13:03:39-----s------
   #未审核的调账单和退款单不考虑
#   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
#    WHERE oob06 = g_oob[l_ac].oob06
#    # AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)  #MOD-950237
#      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
#      AND oob01 = ooa01 AND ooaconf = 'N'
#      AND oob03 = g_oob[l_ac].oob03
#      AND oob04 = g_oob[l_ac].oob04
   #mark by andy 2017/4/21 13:03:39-----e------
   IF tot1 IS NULL THEN LET tot1=0 END IF   #No.FUN-68002 add
   IF tot2 IS NULL THEN LET tot2=0 END IF   #No.FUN-68002 add
 
   #No.TQC-670085--begin-- add
   #mark by andy 2017/4/21 13:03:39-----s------
   #未审核的调账单和退款单不考虑
#   SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file
#    WHERE oob06 = g_oob[l_ac].oob06 AND oob15 = g_oob[l_ac].oob15
#    # AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)  #MOD-950237
#      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
#      AND oob01 = ooa01 AND ooaconf = 'N'  
#      AND oob03 = g_oob[l_ac].oob03
#      AND oob04 = g_oob[l_ac].oob04
   #mark by andy 2017/4/21 13:03:39-----e------
   IF tot5 IS NULL THEN LET tot5=0 END IF
   IF tot6 IS NULL THEN LET tot6=0 END IF
   #No.TQC-670085--end--  add
 
   #No.FUN-680022--begin--  --add
   #待扺或貸方
   #mark by andy 2017/4/21 13:03:39-----s------
   #未审核的调账单和退款单不考虑
#   SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file
#    WHERE oob06 = g_oob[l_ac].oob06 AND oob19 = g_oob[l_ac].oob19
#    # AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)  #MOD-950237
#      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
#      AND oob01 = ooa01 AND ooaconf = 'N' 
#      AND oob03 = g_oob[l_ac].oob03
#      AND oob04 = g_oob[l_ac].oob04
   #mark by andy 2017/4/21 13:03:39-----e------
   IF tot7 IS NULL THEN LET tot7=0 END IF
   IF tot8 IS NULL THEN LET tot8=0 END IF
 
   SELECT * INTO l_omc.* FROM omc_file
    WHERE omc01=g_oob[l_ac].oob06 AND omc02=g_oob[l_ac].oob19
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","omc_file",g_oob[l_ac].oob06,g_oob[l_ac].oob19,SQLCA.sqlcode,"","select omc_file",1)
   END IF
   #No.FUN-680022--end-- --add
 
   IF tot1 IS NULL THEN LET tot1 = 0 END IF
   IF tot2 IS NULL THEN LET tot2 = 0 END IF
      #add by andy 2017/4/17 21:24:11-------s-----
   #cxmt100
#   SELECT SUM(tc_hka14) INTO l_tc_hka14 FROM tc_hka_file WHERE tc_hka02='-1' AND tc_hka03=g_oob[l_ac].oob06
#   IF cl_null(l_tc_hka14) THEN LET l_tc_hka14=0 END IF
   SELECT SUM(tc_nme05) INTO l_tc_hka14 FROM tc_nme_file,tc_nmg_file 
       WHERE tc_nmg01 = tc_nme01
         AND tc_nmg02 = g_ooa.ooa03
         AND tc_nmg06 = g_oob[l_ac].oob06
         AND tc_nmg04 = 'Y'
   #add by andy 2017/4/17 21:24:11-------e-----
 
   IF l_sw = '1' THEN
      IF g_ooz.ooz62 = 'Y' THEN #衝帳至項次   #No.FUN-680022 --add
         IF (tot1+g_oob[l_ac].oob09) > (l_oma.oma54t - l_oma.oma55) THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
         #add by danny 020308 期末調匯(A008)
         IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
            IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55) THEN
               #modify 030226 NO.A048
              #No.TQC-670085--begin--  modify
              IF g_ooz.ooz62 = 'Y' THEN
                 CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
#                     RETURNING g_oob[l_ac].oob10
                      RETURNING tot3                  # MOD-530302
                 #add 030422 NO.A058
                 #判斷本幣金額是否超過
                 IF (tot5+g_oob[l_ac].oob09) > tot3 THEN
                   #CALL cl_err('','axr-185',1)   #CHI-810010 mark
                    CALL cl_err('','axr-189',1)   #CHI-810010
                    LET g_oob[l_ac].oob10 = tot3 - tot2
                 END IF
              END IF
              #No.TQC-670085--end-- modify
            END IF
         END IF
     #No.FUN-680022 --begin-- add
      ELSE    #不衝賬至項次
         IF (tot7+g_oob[l_ac].oob09) > (l_omc.omc08 - l_omc.omc10-l_tc_hka14) THEN
            CALL cl_err('','axr-185',1) 
            LET g_oob[l_ac].oob09=g_oob_t.oob09
            DISPLAY g_oob[l_ac].oob09 TO oob09
            RETURN FALSE
         END IF
       # IF (tot8+g_oob[l_ac].oob10) > (l_omc.omc09 - l_omc.omc11) THEN
       #    CALL cl_err('','axr-185',1) 
       #    LET g_oob[l_ac].oob10=g_oob_t.oob10
       #    DISPLAY g_oob[l_ac].oob10 TO oob10
       #    RETURN FALSE
       # END IF
      END IF
     #NoFUN-680022 --end-- add
   ELSE
      #add by danny 020308 期末調匯(A008)
      IF g_ooz.ooz07 = 'N' OR g_oob[l_ac].oob07 = g_aza.aza17 THEN
#        IF l_cmd = 'a' THEN   #MOD-5A0024
           #IF (tot2+g_oob[l_ac].oob10) > (l_oma.oma56t - l_oma.oma57) THEN  #No.FUN-680022 --mark
            IF (tot8+g_oob[l_ac].oob10) > (l_omc.omc09  - l_omc.omc11-l_tc_hka14) THEN  #No.FUN-680022 --add
               CALL cl_err('','axr-185',1) 
               LET g_oob[l_ac].oob10=g_oob_t.oob10     #No.FUN-680022     
               DISPLAY g_oob[l_ac].oob10 TO oob10      #No.FUN-680022 
               RETURN FALSE
            END IF
           #str MOD-940262 add
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11-l_tc_hka14) THEN
               CALL cl_err('','axr-193',1)
            END IF
           #end MOD-940262 add
#MOD-5A0024
#        ELSE
#           IF (tot2+g_oob[l_ac].oob10-g_oob_t.oob10) >
#              (l_oma.oma56t - l_oma.oma57) THEN
#              CALL cl_err('','axr-185',1) RETURN FALSE
#           END IF
#        END IF
#END MOD-5A0024
         #No.+010by plum 010426 add 若非本國幣別:沖帳-立帳若只剩三元
         #(怕因匯差問題)
         IF g_aza.aza17 != g_oob[l_ac].oob07 THEN
           #LET l_diff= (l_oma.oma56t - l_oma.oma57)- (tot2+g_oob[l_ac].oob10)  #No.FUN-680022 --mark
            LET l_diff= (l_omc.omc09  - l_omc.omc11-l_tc_hka14)- (tot8+g_oob[l_ac].oob10)  #No.FUN-680022 --add
            IF l_diff <=3 AND l_diff >0 THEN
               CALL cl_getmsg('mfg-030',g_lang) RETURNING l_msg1
               CALL cl_getmsg('mfg-031',g_lang) RETURNING l_msg2
              #LET g_msg=l_msg1 CLIPPED,l_oma.oma56t USING '#######&',  #No.FUN-680022 --mark
               LET g_msg=l_msg1 CLIPPED,l_omc.omc09  USING '#######&',  #No.FUN-680022 --add
                         " ",l_msg2 CLIPPED,
                       #(l_oma.oma57+tot2+g_oob[l_ac].oob10) USING '#######&'  #No.FUN-680022 --mark
                        (l_omc.omc11+tot8+g_oob[l_ac].oob10+l_tc_hka14) USING '#######&'  #No.FUN-680022 --add
               CALL cl_err(g_msg,'mfg-012',1)
            END IF
         END IF
        #....end
      END IF
      #add 030422 NO.A058
      #判斷本幣金額是否超過
      IF g_ooz.ooz07 = 'Y' THEN   #有做月底重評時, 需判斷不可超過未沖金額
         #No.TQC-670085--begin-- modify
       # IF g_ooz.ooz62 = 'Y' THEN  #No.MOD-8A0111
          #No.FUN-680022--begin-- mark
          # CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
          #      RETURNING tot3
          #No.FUN-680022--end-- mark
           #IF (tot6+g_oob[l_ac].oob10) > tot3 THEN  #No.FUN-680022 --mark
            IF (tot8+g_oob[l_ac].oob10) > l_omc.omc13-l_tc_hka14 THEN  #No.FUN-680022 --add
               CALL cl_err('','axr-185',1)
              #LET g_oob[l_ac].oob10 = tot3 - tot2  #No.FUN-680022 --mark
               LET g_oob[l_ac].oob10 = l_omc.omc13 - tot8-l_tc_hka14 #No.FUN-680022 --add
               DISPLAY g_oob[l_ac].oob10 TO oob10         #No.FUN-680022 --add  
               RETURN FALSE
            END IF
           #str MOD-940262 add
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11-l_tc_hka14) THEN
               CALL cl_err('','axr-193',1)
            END IF
           #end MOD-940262 add
       # END IF                     #No.MOD-8A0111
         #No.TQC-670085--end-- modify
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
#FUNCTION t410_oob09_19(l_sw,l_cmd)                # 借方檢查 : A/P   #MOD-750063
FUNCTION t410_oob09_19(l_sw,l_cmd,l_sw2)           # 借/貸方檢查 : A/P   #MOD-750063
   DEFINE l_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_apa          RECORD LIKE apa_file.*
   DEFINE l_apc          RECORD LIKE apc_file.*   #MOD-750063
   DEFINE p05,p05f       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_oob09,l_oob10        LIKE oob_file.oob09
   #add 030422 NO.A058
   DEFINE l_apz27        LIKE apz_file.apz27
   DEFINE l_sw2          LIKE type_file.chr1   #MOD-750063
 
   #-----MOD-750063---------
   #SELECT * INTO l_apa.* FROM apa_file WHERE apa01= g_oob[l_ac].oob06
   SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file
     WHERE apa01=g_oob[l_ac].oob06
       AND apa01=apc01 
       AND apc02=g_oob[l_ac].oob19  
   #-----END MOD-750063-----
   IF STATUS THEN
      #-----MOD-750063---------
      #LET l_apa.apa35f = 0
      #LET l_apa.apa35  = 0
      LET l_apc.apc10 = 0
      LET l_apc.apc11  = 0
      #-----END MOD-750063-----
   END IF
 
   LET p05f = 0 LET p05 = 0
 
   #-----MOD-750063---------
   #SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05 FROM apg_file,apf_file
   # WHERE apg04=g_oob[l_ac].oob06              ## 尚未確認也視同已付,須扣除
   #   AND apg01=apf01 AND apf41='N' AND apg01 <> g_ooa.ooa01
   IF l_sw2 = '1' THEN
      SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05 FROM apg_file,apf_file
       WHERE apg04=g_oob[l_ac].oob06              ## 尚未確認也視同已付,須扣除
         AND apg06=g_oob[l_ac].oob19
         AND apg01=apf01 AND apf41='N' AND apg01 <> g_ooa.ooa01
   ELSE
      SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05 FROM aph_file,apf_file
       WHERE aph04=g_oob[l_ac].oob06              ## 尚未確認也視同已付,須扣除
         AND aph17=g_oob[l_ac].oob19
         AND aph01=apf01 AND apf41='N' AND aph01 <> g_ooa.ooa01
   END IF
   #-----END MOD-750063-----
 
   IF p05f IS NULL THEN LET p05f=0 END IF
   IF p05  IS NULL THEN LET p05 =0 END IF
 
   #-----MOD-750063---------
   #LET l_apa.apa35f=l_apa.apa35f+p05f
   #LET l_apa.apa35 =l_apa.apa35 +p05
   LET l_apc.apc10=l_apc.apc10+p05f
   LET l_apc.apc11=l_apc.apc11+p05
   #-----END MOD-750063-----
 
   #-----MOD-750063---------
   #SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
   # WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '9'
   #   AND oob01 = ooa01 AND ooaconf = 'N'     #1999/12/21 modify
   #   AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)
   IF l_sw2 = '1' THEN
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
       WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '9'
         AND oob19 = g_oob[l_ac].oob19
         AND oob01 = ooa01 AND ooaconf = 'N'     #1999/12/21 modify  #MOD-850229 mark  #MOD-8B0210 mark回復
        #AND oob01 = ooa01 AND ooaconf<> 'X'     #1999/12/21 modify  #MOD-850229       #MOD-8B0210 mark
       # AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-950237
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
   ELSE
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
       WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '2' AND oob04 = '9'
         AND oob19 = g_oob[l_ac].oob19
         AND oob01 = ooa01 AND ooaconf = 'N'     #1999/12/21 modify  #MOD-850229 mark  #MOD-8B0210 mark回復
        #AND oob01 = ooa01 AND ooaconf<> 'X'     #1999/12/21 modify  #MOD-850229       #MOD-8B0210 mark
       # AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)    #MOD-950237
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)        #MOD-950237
   END IF
   #-----END MOD-750063-----
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
   IF l_sw = '1' THEN
     #IF (l_oob09+g_oob[l_ac].oob09) > (l_apa.apa34f-l_apa.apa35f) THEN   #MOD-750063
     #例:此次帳款共1000元,在axrt400沖帳200元,執行確認後會回寫帳款已付金額(apc10),
     #   g_oob[l_ac].oob09 > (l_apc.apc08-l_apc.apc10)
     #          200        >    1000
     #   接著在付款沖帳付100元,最後在axrt400沖700元
     #          700        >    1000-200-100  <-前面的200是axrt400確認後回寫的
     #   所以只需比較這次所要沖的金額,是否超過剩餘可沖金額(apc08-apc10)
     #IF (l_oob09+g_oob[l_ac].oob09) > (l_apc.apc08-l_apc.apc10) THEN   #MOD-750063   #MOD-880177 mark
      IF g_oob[l_ac].oob09 > (l_apc.apc08-l_apc.apc10) THEN   #MOD-750063             #MOD-880177
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      #modify 030422 NO.A058
      #SELECT apz27 INTO l_apz27 FROM apz_file WHERE nmz00 = '0'   #MOD-750063
      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'   #MOD-750063
      #判斷本幣金額是否超過
      IF l_apz27 = 'N' THEN      #不做月底重評時, 依原判斷
        #IF (l_oob10+g_oob[l_ac].oob10) > (l_apa.apa34-l_apa.apa35) THEN   #MOD-750063
        #IF (l_oob10+g_oob[l_ac].oob10) > (l_apc.apc09-l_apc.apc11) THEN   #MOD-750063   #MOD-880177 mark
         IF g_oob[l_ac].oob10 > (l_apc.apc09-l_apc.apc11) THEN   #MOD-750063             #MOD-880177
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('2',l_apa.apa00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
         #IF (l_oob09+g_oob[l_ac].oob10) > tot3 THEN  #MOD-750063
         IF (l_oob10+g_oob[l_ac].oob10) > tot3 - p05 THEN  #MOD-750063
            CALL cl_err('','axr-185',1)
            #LET g_oob[l_ac].oob10 = tot3 - l_oob10   #MOD-750063
            LET g_oob[l_ac].oob10 = tot3 - p05 - l_oob10   #MOD-750063
            #-------------NO.MOD-5A0095 START--------------
            DISPLAY BY NAME g_oob[l_ac].oob10
            #-------------NO.MOD-5A0095 END----------------
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob06_11()            # 借方檢查 : 支票
  DEFINE l_nmh            RECORD LIKE nmh_file.*
  DEFINE l_nmydmy3             LIKE nmy_file.nmydmy3
  #add 030422 NO.A058
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_sql          LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(500)   #TQC-5A0089
  DEFINE l_aag05        LIKE aag_file.aag05   #MOD-730022
  DEFINE l_bookno       LIKE aag_file.aag00   #No.FUN-740184
 
  IF g_ooz.ooz04='N' THEN RETURN END IF
  #No.+093 010427 by plum #若收票單別其拋轉傳票為Y,不可用來沖AR
#TQC-5A0089
  LET l_sql="SELECT nmh_file.*,nmydmy3 FROM nmh_file,nmy_file ",
            " WHERE nmh01= '",g_oob[l_ac].oob06,"'",
            "   AND nmh01[1,",g_doc_len,"]=nmyslip"
   PREPARE nmh_p2 FROM l_sql
   DECLARE nmh_c2 CURSOR FOR nmh_p2
   OPEN nmh_c2
   FETCH nmh_c2 INTO l_nmh.*,l_nmydmy3
#   SELECT nmh_file.*,nmydmy3 INTO l_nmh.* ,l_nmydmy3 FROM nmh_file,nmy_file
#    WHERE nmh01= g_oob[l_ac].oob06 AND nmh01[1,3]=nmyslip
#END TQC-5A0089
   IF STATUS THEN CALL cl_err('sel nmh',STATUS,1) LET g_errno='N' END IF
 
   #No.FUN-740184  --Begin
   CALL s_get_bookno(YEAR(l_nmh.nmh04)) RETURNING g_flag, g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(l_nmh.nmh04,'aoo-081',1)
   END IF
   #No.FUN-740184  --End
   
   IF l_nmydmy3='Y' THEN
      #-----TQC-630086---------
     #str MOD-940156 mod
     #若收票單別其拋轉傳票為Y,不可用來沖AR,
     #待功能單FUN-940068修正完後,這邊再開放
       CALL cl_err(g_oob[l_ac].oob06,'axr-066',0)
       LET g_errno='N' RETURN
     #LET g_oob[l_ac].oob11 = l_nmh.nmh27
     #DISPLAY BY NAME g_oob[l_ac].oob11
     ##-----END TQC-630086-----
     #LET g_oob[l_ac].oob111= l_nmh.nmh271    #No.FUN-670047 add
     #DISPLAY BY NAME g_oob[l_ac].oob111      #No.FUN-670047 add
     #end MOD-940156 mod
   #-----MOD-7B0254---------
   ELSE  
      LET g_oob[l_ac].oob11 = l_nmh.nmh26   
      DISPLAY BY NAME g_oob[l_ac].oob11   
      LET g_oob[l_ac].oob111 = l_nmh.nmh261   
      DISPLAY BY NAME g_oob[l_ac].oob111   
   #-----END MOD-7B0254-----
   END IF
   #No.FUN-740184  --Begin
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
           RETURNING l_bookno,g_oob[l_ac].oob11
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
           RETURNING l_bookno,g_oob[l_ac].oob111
   END IF
   #No.FUN-740184  --End
  #str MOD-850228 add
   IF l_nmh.nmh38 = 'N' THEN
      CALL cl_err(g_oob[l_ac].oob06,'axr-194',0) LET g_errno='N' RETURN
   END IF
  #end MOD-850228 add
   IF l_nmh.nmh38 = 'X' THEN
      CALL cl_err(g_oob[l_ac].oob06,'9024',0) LET g_errno = 'N' RETURN
   END IF
  #No.+093..end
 
   #add 030422  NO.A058
   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
     #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)  #MOD-950237
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237 
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  IF l_nmh.nmh11!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh30!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh03!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_nmh.nmh17>=l_nmh.nmh02 THEN
     CALL cl_err('','axr-185',1) LET g_errno='N' END IF
  #95/12/14 by danny 判斷此參考單號之單據是否已確認
  IF l_nmh.nmh38 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  LET g_oob[l_ac].oob07=l_nmh.nmh03
  LET g_oob[l_ac].oob08=l_nmh.nmh32/l_nmh.nmh02
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
# SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07  #MOD-910070 add #MOD-940238 MARK
  LET g_oob[l_ac].oob09=l_nmh.nmh02-l_nmh.nmh17
  #modify 030422 NO.A058
  LET g_oob[l_ac].oob09=l_nmh.nmh02-l_nmh.nmh17-tot1
  #modify by nick 95/08/24
  LET g_oob[l_ac].oob10=g_oob[l_ac].oob09*g_oob[l_ac].oob08
 
  #add 030422 NO.A058
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz59 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                       #MOD-940277
        LET g_oob[l_ac].oob08 = l_nmh.nmh39
     ELSE                                            #MOD-940277
     	  LET g_oob[l_ac].oob08 = l_nmh.nmh28          #MOD-940277
     END IF                                          #MOD-940277	     
     IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
        LET g_oob[l_ac].oob08 = l_nmh.nmh28
     END IF
     CALL s_g_np('4','1',g_oob[l_ac].oob06,g_oob[l_ac].oob15) RETURNING tot3
     IF (g_oob[l_ac].oob09+tot1+l_nmh.nmh17) = l_nmh.nmh02 THEN
        LET g_oob[l_ac].oob10 = tot3 - tot2
     END IF
  END IF
 
# CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08  #No.MOD-910070 #MOD-940238 MARK
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09  #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10  #No.CHI-6A0004
  #modify by nick 95/08/24
  #LET g_oob[l_ac].oob11=l_nmh.nmh26    #TQC-630086
  #-----MOD-730022---------
  #LET g_oob[l_ac].oob13=l_nmh.nmh15
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1       #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_nmh.nmh15
  ELSE
     LET g_oob[l_ac].oob13=''
  END IF
  #-----END MOD-730022-----
  LET g_oob[l_ac].oob14=l_nmh.nmh31
  LET g_oob[l_ac].oob12=l_nmh.nmh18   #MOD-780261
END FUNCTION
 
FUNCTION t410_oob06_12()            # 借方檢查 : TT
  DEFINE l_nmg           RECORD LIKE nmg_file.*
  DEFINE l_npk           RECORD LIKE npk_file.*
  DEFINE l_cnt           LIKE type_file.num5        #No.FUN-680123 SMALLINT
  DEFINE l_sql           LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(300)
  DEFINE l_nmz20         LIKE nmz_file.nmz20
  DEFINE tot1,tot2,tot3  LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_aag05         LIKE aag_file.aag05        #MOD-730022
  DEFINE l_bookno        LIKE aag_file.aag00        #No.FUN-740184
  DEFINE l_gem10         LIKE gem_file.gem10        #MOD-910107 add
 
   IF g_ooz.ooz04='N' THEN RETURN END IF
 
  #MOD-740395.....begin
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob[l_ac].oob06
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 ='Y')    #NO:4181
  IF NOT STATUS AND g_oob[l_ac].oob04<>'3' THEN  
    #CALL cl_err('sel nmg',STATUS,0)  #MOD-740395
     CALL cl_err('','axr-202',0)  #MOD-740395
     LET g_errno='N' 
     RETURN  #MOD-740395
  END IF 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob[l_ac].oob06
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 !='Y')    #NO:4181
  #IF NOT STATUS AND g_oob[l_ac].oob04<>'3' THEN   #TQC-750177   
  IF STATUS  THEN                                  #TQC-750177
     CALL cl_err('sel nmg',STATUS,0)  
     LET g_errno='N' 
     RETURN  
  END IF 
  #MOD-740395.....end
 
   #No.FUN-740184  --Begin
   CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(l_nmg.nmg01,'aoo-081',1)
   END IF
   #No.FUN-740184  --End
   IF l_nmg.nmgconf='N' THEN 
      CALL cl_err('','axr-194',0) 
      LET g_errno='N' 
      RETURN  #MOD-740395
   END IF
   IF l_nmg.nmgconf='X' THEN 
      CALL cl_err('','9024',0) 
      LET g_errno='N' 
      RETURN  #MOD-740395
   END IF
   IF l_nmg.nmg18 !=g_ooa.ooa03 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          #No.MOD-510070
   IF l_nmg.nmg19 !=g_ooa.ooa032 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          #No.MOD-510070
   IF l_nmg.nmg23-l_nmg.nmg24 = 0 THEN
      CALL cl_err('','axr-184',1) 
      LET g_errno='N' 
      RETURN 
   END IF
   #add by danny 020315
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
      #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-630069
      AND oob01 <> g_ooa.ooa01    #MOD-630069
      AND oob15 = g_oob[l_ac].oob15   #MOD-630069
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
   #-----MOD-730022---------
   #LET g_oob[l_ac].oob13=l_nmg.nmg11   #原始部門
   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                             AND aag00=g_bookno1    #	No.FUN-730073             
   IF l_aag05 = 'Y' THEN
     #str MOD-910107 add
      LET l_gem10=s_costcenter(l_nmg.nmg11)
      IF NOT cl_null(l_gem10) THEN
         LET g_oob[l_ac].oob13=l_gem10
      ELSE
     #end MOD-910107 add
         LET g_oob[l_ac].oob13=l_nmg.nmg11
      END IF   #MOD-910107 add
   ELSE
      LET g_oob[l_ac].oob13=''
   END IF
   #-----END MOD-730022-----
   #---->為防止收支單輸入兩筆單身
   LET l_sql = "SELECT npk_file.* FROM npk_file ",
               " WHERE npk00= '",g_oob[l_ac].oob06,"'",
               "       AND npk01 ='",g_oob[l_ac].oob15,"'"   #MOD-630069
   PREPARE t410_oob06_npk FROM l_sql
   DECLARE t410_oob06_npk_c1 CURSOR FOR t410_oob06_npk
   FOREACH t410_oob06_npk_c1 INTO l_npk.*
     IF SQLCA.sqlcode THEN
        CALL cl_err('t410_oob06_npk_c1',SQLCA.sqlcode,0)
        LET g_errno = 'N' EXIT FOREACH
     END IF
     IF l_npk.npk05!=g_ooa.ooa23 THEN    #幣別與沖帳不一致
        CALL cl_err('','axr-144',1) LET g_errno='N' EXIT FOREACH
     END IF
     LET g_oob[l_ac].oob07=l_npk.npk05   #幣別
     LET g_oob[l_ac].oob08=l_npk.npk06   #匯率
     #modify by danny 020315
     #-----MOD-630069---------
     #LET g_oob[l_ac].oob09=l_nmg.nmg23-l_nmg.nmg24-tot1
     #LET g_oob[l_ac].oob10=l_nmg.nmg25-(l_nmg.nmg24*l_npk.npk06)-tot2
     LET g_oob[l_ac].oob09=l_npk.npk08 - l_nmg.nmg24 - tot1   #原幣入帳金額
     LET g_oob[l_ac].oob10=l_npk.npk09-(l_nmg.nmg24*l_npk.npk06)-tot2  #本幣入帳金額
     #-----END MOD-630069-----
     SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
#    SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07  #MOD-910070 add #MOD-940238 MARK
#    CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08     #No.MOD-910070 #MOD-940238 MARK
     CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
     CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10      #No.CHI-6A0004
    #No.+099 010502 by plum mod 暫收Y:npk071 N:npk07
    #LET g_oob[l_ac].oob11=l_npk.npk07   #科目編號
     IF l_nmg.nmg29='Y' THEN
        LET g_oob[l_ac].oob11=l_npk.npk071  #科目編號        
        IF g_aza.aza63='Y' THEN                                #No.FUN-670047 add
           LET g_oob[l_ac].oob111=l_npk.npk073  #科目二編號   #No.FUN-670047 add
        END IF                                                #No.FUN-670047 add
     ELSE
        LET g_oob[l_ac].oob11=l_npk.npk07   #科目編號
        IF g_aza.aza63='Y' THEN                               #No.FUN-670047 add
           LET g_oob[l_ac].oob111=l_npk.npk072  #科目二編號   #No.FUN-670047 add
        END IF                                                #No.FUN-670047 add
     END IF
     #No.FUN-740184  --Begin
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
             RETURNING l_bookno,g_oob[l_ac].oob11
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
             RETURNING l_bookno,g_oob[l_ac].oob111
     END IF
     #No.FUN-740184  --End
     ##add by danny 020315 期末調匯(A008)
     SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
     IF l_nmz20 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
        IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
           LET g_oob[l_ac].oob08 = l_nmg.nmg09
        ELSE                                       #MOD-940277
        	 LET g_oob[l_ac].oob08 = l_npk.npk06     #MOD-940277
        END IF                                     #MOD-940277     	    
        IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
           LET g_oob[l_ac].oob08 = l_npk.npk06
        END IF
        #modify 030226 NO.A048
        CALL s_g_np('3','2',g_oob[l_ac].oob06,g_oob[l_ac].oob15) RETURNING tot3
        #modify 030422 NO.A058
        IF (tot1+g_oob[l_ac].oob09+l_nmg.nmg24) = l_nmg.nmg23 THEN
            LET g_oob[l_ac].oob10 = tot3 - tot2
        END IF
     END IF
    #No.+099..end
     LET g_oob[l_ac].oob12=l_npk.npk10   #MOD-780261
     EXIT FOREACH
  END FOREACH
END FUNCTION
 
FUNCTION t410_oob06_item()      # 檢查待抵/應收帳款
   DEFINE p_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)                  # 2:取待抵 1:取應收
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omb          RECORD LIKE omb_file.*
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE l_omb14t       LIKE omb_file.omb14t   #CHI-840051
   DEFINE l_omb16t       LIKE omb_file.omb16t   #CHI-840051
   DEFINE l_oea61        LIKE oea_file.oea61    #No:FUN-A50103
   DEFINE l_oea1008      LIKE oea_file.oea1008  #No:FUN-A50103
   DEFINE l_per          LIKE oea_file.oea261   #No:FUN-A50103
 
  #LET g_sql="SELECT * FROM ",g_dbs_new CLIPPED,"oma_file WHERE oma01=?"
  #LET g_sql="SELECT * FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
  LET g_sql="SELECT * FROM oma_file ",#FUN-A50102
            " WHERE oma01=?"
         #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
         #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t410_oob06_item_p1 FROM g_sql
  DECLARE t410_oob06_item_c1 CURSOR FOR t410_oob06_item_p1
  OPEN t410_oob06_item_c1 USING g_oob[l_ac].oob06
  FETCH t410_oob06_item_c1 INTO l_oma.*
  IF STATUS THEN CALL cl_err('sel oma',STATUS,1) LET g_errno='N' END IF
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  #-----MOD-760119---------
  IF l_oma.omaconf='N' THEN
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
  #-----END MOD-760119-----
   LET tot1 = 0
   LET tot2 = 0
   SELECT * INTO l_omb.* FROM omb_file
    WHERE omb01 = g_oob[l_ac].oob06 AND omb03 = g_oob[l_ac].oob15
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob15 = g_oob[l_ac].oob15
      AND oob01 = ooa01 AND ooaconf = 'N'
     #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)  #MOD-950237
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF
   #-----CHI-840051---------
   #LET g_oob[l_ac].oob09 = l_omb.omb14t - l_omb.omb34 - tot1
   #LET g_oob[l_ac].oob10 = l_omb.omb16t - l_omb.omb35 - tot2
   #-----No:FUN-A50103-----
   IF l_oma.oma00='11' OR l_oma.oma00='12' OR l_oma.oma00='13' THEN
      CASE l_oma.oma00
        WHEN 11
           SELECT oea61,oea1008,oea261
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
        WHEN 12
           SELECT oea61,oea1008,oea262
             INTO l_oea61,l_oea1008,l_per 
             FROM oga_file,oea_file
            WHERE oga01 = l_oma.oma16
             AND oga16 = oea01
        WHEN 13
           SELECT oea61,oea1008,oea263
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
      END CASE

      #-----No:CHI-A70015-----
      IF cl_null(l_per) THEN
         LET l_per = 100
      END IF

      IF cl_null(l_oea1008) THEN
         LET l_oea1008 = 100
      END IF

      IF cl_null(l_oea61) THEN
         LET l_oea61 = 100
      END IF
      #-----No:CHI-A70015 END-----

      IF g_oma.oma213 = 'Y' THEN
         LET l_omb14t = l_omb.omb14t * l_per / l_oea1008
         LET l_omb16t = l_omb.omb16t * l_per / l_oea1008
      ELSE
         LET l_omb14t = l_omb.omb14t * l_per / l_oea61
         LET l_omb16t = l_omb.omb16t * l_per / l_oea61
      END IF
   ELSE
      LET l_omb14t = l_omb.omb14t
      LET l_omb16t = l_omb.omb16t
   END IF

  #CASE l_oma.oma00
  #  WHEN 11
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma161/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma161/100
  #  WHEN 12
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma162/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma162/100
  #  WHEN 13
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma163/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma163/100
  #  OTHERWISE  
  #    LET l_omb14t = l_omb.omb14t
  #    LET l_omb16t = l_omb.omb16t
  #END CASE
  ##-----No:FUN-A50103 END-----
   LET g_oob[l_ac].oob09 = l_omb14t - l_omb.omb34 - tot1
   LET g_oob[l_ac].oob10 = l_omb16t - l_omb.omb35 - tot2
   #-----END CHI-840051-----
##add by danny 020308 期末調匯(A008)
   IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
      IF g_apz.apz27 = 'Y' THEN                 #MOD-940277
         LET g_oob[l_ac].oob08 = l_omb.omb36
      ELSE                                      #MOD-940277
      	 LET g_oob[l_ac].oob08 = l_oma.oma24    #MOD-940277
      END IF                                    #MOD-940277 	    
      IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
         LET g_oob[l_ac].oob08 = l_oma.oma24
         #-------------NO.MOD-5A0095 START--------------
         DISPLAY BY NAME g_oob[l_ac].oob08
         #-------------NO.MOD-5A0095 END----------------
      END IF
      #modify 030226 NO.A048
      CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
                  RETURNING tot3
      #modify 030422 NO.A058
      #IF (tot1+g_oob[l_ac].oob09+l_omb.omb34) = l_omb.omb14t THEN   #CHI-840051
      IF (tot1+g_oob[l_ac].oob09+l_omb.omb34) = l_omb14t THEN   #CHI-840051
         LET g_oob[l_ac].oob10 = tot3 - tot2
         #-------------NO.MOD-5A0095 START--------------
         DISPLAY BY NAME g_oob[l_ac].oob10
         #-------------NO.MOD-5A0095 END----------------
      END IF
   END IF
##
  #No.MOD-910070---Begin
#  SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file   #MOD-940238
   SELECT azi04 INTO t_azi04 FROM azi_file                 #MOD-940238
   WHERE azi01 = g_oob[l_ac].oob07
#  CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08  #MOD-940238 
  #No.MOD-910070---End 
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09    #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10    #No.CHI-6A0004
  #-------------NO.MOD-5A0095 START--------------
  DISPLAY BY NAME g_oob[l_ac].oob09
  DISPLAY BY NAME g_oob[l_ac].oob10
  #-------------NO.MOD-5A0095 END----------------
END FUNCTION
 
FUNCTION t410_oob06_13(p_sw)            # 檢查待抵/應收帳款
  DEFINE p_sw             LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)                  # 2:取待抵 1:取應收
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*   #No.FUn-680022 --add
  DEFINE tot1,tot2,tot3 LIKE oob_file.oob09
  DEFINE l_oox10        LIKE oox_file.oox10
  DEFINE l_aag05        LIKE aag_file.aag05   #MOD-5B0012
  DEFINE tot4,tot4t     LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)             #TQC-5B0171
  DEFINE l_bookno       LIKE aag_file.aag00   #No.FUN-740184
  DEFINE l_tc_hka14     LIKE tc_hka_file.tc_hka14
 
 
 #LET g_sql="SELECT * FROM ",g_dbs_new CLIPPED,"oma_file WHERE oma01=?"   #No.FUN-680022 --mark
  LET g_sql="SELECT oma_file.*,omc_file.* ",   #No.FUN-680022 --add
            #"  FROM ",g_dbs_new CLIPPED,"omc_file ,",g_dbs_new CLIPPED,"oma_file ",  #No.FUN-680022 --add
            #"  FROM ",cl_get_target_table(g_plant,'omc_file'),",", #FUN-A50102
            #          cl_get_target_table(g_plant,'oma_file'),      #FUN-A50102
            "  FROM omc_file,oma_file ", #FUN-A50102
            " WHERE oma01=omc01 AND omc01=? AND omc02=?"   #No.FUN-680022 --add
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t410_oob06_13_p1 FROM g_sql
  DECLARE t410_oob06_13_c1 CURSOR FOR t410_oob06_13_p1
  OPEN t410_oob06_13_c1 USING g_oob[l_ac].oob06,g_oob[l_ac].oob19
 #FETCH t410_oob06_13_c1 INTO l_oma.*    #No.FUN-680022 --mark
  FETCH t410_oob06_13_c1 INTO l_oma.*,l_omc.*    #No.FUN-680022 --add
 #IF STATUS THEN CALL cl_err('sel oma',STATUS,1) LET g_errno='N' END IF   #No.FUN-680022 --mark
  IF STATUS THEN CALL cl_err('sel omc',"axr-031",1) LET g_errno='N' END IF   #No.FUN-680022 --add
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  #IF p_sw='1' AND l_oma.omaconf='N' THEN   #MOD-760119
  IF l_oma.omaconf='N' THEN   #MOD-760119
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
  IF p_sw='2' AND l_oma.oma00[1,1]!='2' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF p_sw='1' AND l_oma.oma00[1,1]!='1' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  #MOD-9B0043--mark--str-
  #IF l_oma.oma00='23' THEN
  #   CALL cl_err('','axr-188',1) LET g_errno='N' END IF
  #MOD-9B0043--mark--end
#No.FUN-670026  --start--  
# IF l_oma.oma03!=g_ooa.ooa03 THEN
#    CALL cl_err('','axr-139',1) {LET g_errno='N'} END IF
#    #當帳款客戶!=支票客戶,警告但不Roll back!(要改axr-139!)950825 modi by nick
# IF l_oma.oma032!=g_ooa.ooa032 THEN
#    CALL cl_err('','axr-139',0) {LET g_errno='N'} END IF
#    #當帳款客戶!=支票客戶,警告但不Roll back!(要改axr-139!)950825 modi by nick
  IF l_oma.oma68 != g_ooa.ooa03 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma69 != g_ooa.ooa032 THEN
     CALL cl_err('','axr-140',1) 
  END IF
#No.FUN-670026  --end--   
  IF l_oma.oma23!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_oma.oma54t<=l_oma.oma55 THEN
     CALL cl_err('','axr-190',1) LET g_errno='N' END IF
 #str MOD-940262 add
 #原幣沖完但本幣未沖完
  IF l_oma.oma54t=l_oma.oma55 AND l_oma.oma56t!=l_oma.oma57 THEN
     CALL cl_err('','axr-193',1) LET g_errno='N' END IF
 #end MOD-940262 add
## No.2723 modify 1998/11/05 立帳日不可比沖款日小
  IF l_oma.oma02 > g_ooa.ooa02 THEN
     CALL cl_err('','axr-371',0) LET g_errno = 'N'
  END IF
##-----------------------------------------------
  #No.FUN-740184  --Begin
  CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
  IF g_flag='1' THEN
     CALL cl_err(l_oma.oma02,'aoo-081',1)
  END IF
  #No.FUN-740184  --End  
  LET g_oob[l_ac].oob07=l_oma.oma23
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
# SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 #MOD-940238 MARK
  LET g_oob[l_ac].oob08=l_oma.oma24
 #LET g_oob[l_ac].oob09=l_oma.oma54t-l_oma.oma55
 #LET g_oob[l_ac].oob10=l_oma.oma56t-l_oma.oma57
## No.2694 modify 1998/10/31 不可沖超過
   LET tot1 = 0
   LET tot2 = 0
   #mark by andy 2017/4/21 12:53:29------s--------
   #未审核的调账单,退款单不考虑在内
#   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file 
#    WHERE oob06 = g_oob[l_ac].oob06
#      AND oob01 = ooa01 AND ooaconf = 'N' 
#      AND oob19 = g_oob[l_ac].oob19   #No.FUN-680022 --add
#     #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)   #MOD-950237
#      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
#      AND oob03 = g_oob[l_ac].oob03
#      AND oob04 = g_oob[l_ac].oob04
#   IF tot1 IS NULL THEN
#      LET tot1 = 0
#   END IF
#   IF tot2 IS NULL THEN
#      LET tot2 = 0
#   END IF
   #mark by andy 2017/4/21 12:53:29------e--------
   #add by andy 2017/4/17 21:24:11-------s-----
   #cxmt100
   #SELECT SUM(tc_hka14) INTO l_tc_hka14 FROM tc_hka_file WHERE tc_hka02='-1' AND tc_hka03=g_oob[l_ac].oob06
   SELECT SUM(tc_nme05) INTO l_tc_hka14 FROM tc_nme_file,tc_nmg_file 
       WHERE tc_nmg01 = tc_nme01
         AND tc_nmg02 = g_ooa.ooa03
         AND tc_nmg06 = g_oob[l_ac].oob06
         AND tc_nmg04 = 'Y'
   IF cl_null(l_tc_hka14) THEN LET l_tc_hka14=0 END IF
   #add by andy 2017/4/17 21:24:11-------e----- 
  #LET g_oob[l_ac].oob09 = l_oma.oma54t - l_oma.oma55 - tot1 #No.FUN-680022 --mark 
  #LET g_oob[l_ac].oob10 = l_oma.oma56t - l_oma.oma57 - tot2 #No.FUN-680022 --mark
   #LET g_oob[l_ac].oob09 = l_omc.omc08  - l_omc.omc10 - tot1 - l_tc_hka14 #No.FUN-680022 --add
   #LET g_oob[l_ac].oob10 = l_omc.omc09  - l_omc.omc11 - tot2 - l_tc_hka14 #No.FUN-680022 --ad2
   LET g_oob[l_ac].oob10 = l_omc.omc09  - l_omc.omc11 - tot2 - l_tc_hka14 #No.FUN-680022 --ad2
   LET g_oob[l_ac].oob09=g_oob[l_ac].oob10/g_oob[l_ac].oob08
##add by danny 020308 期末調匯(A008)
   IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     #LET g_oob[l_ac].oob08 = l_oma.oma60   #No.FUN-680022 --mark
      IF g_apz.apz27 = 'Y' THEN                        #MOD-940277
         LET g_oob[l_ac].oob08 = l_oma.oma60   #No.FUN-680022 --add
      ELSE                                             #MOD-940277
      	 LET g_oob[l_ac].oob08 = l_oma.oma24           #MOD-940277
      END IF                                           #MOD-940277	    
      IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
         LET g_oob[l_ac].oob08 = l_oma.oma24
      END IF
      #modify 030226 NO.A048
     #CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)     #No.FUN-680022 --mark
      #CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob19)     #No.FUN-680022   #No.FUN-7B0055
      CALL s_g_np1('1',l_oma.oma00,g_oob[l_ac].oob06,'',g_oob[l_ac].oob19)     #No.FUN-680022   #No.FUN-7B0055
           RETURNING tot3
      #No.TQC-5B0171 --start--
      #取得衝帳單的待扺金額
      CALL t410_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
      CALL cl_digcut(tot4,t_azi04) RETURNING tot4              #No.CHI-6A0004
      CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
      #未衝金額扣除待扺
      LET tot3 = tot3 - tot4t
      #No.TQC-5B0171 --end--
      #modify 030422 NO.A058
     #IF (tot1+g_oob[l_ac].oob09+l_oma.oma55) = l_oma.oma54t THEN  #No.FUN-680022 --mark
      IF (tot1+g_oob[l_ac].oob09+l_omc.omc10) = l_omc.omc08  THEN  #No.FUN-680022 --add
         LET g_oob[l_ac].oob10 = tot3 - tot2
      END IF
   END IF
##
##-----------------------------------
# CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08     #No.MOD-910070 #MOD-940238 MARK
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10     #No.CHI-6A0004
  LET g_oob[l_ac].oob11=l_oma.oma18
  IF g_aza.aza63='Y' THEN                 #No.FUN-670047 add
     LET g_oob[l_ac].oob111=l_oma.oma181  #No.FUN-670047 add
  END IF                                  #No.FUN-670047 add
#MOD-5B0012
 LET l_aag05=''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1     #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_oma.oma15
  ELSE   #MOD-730022
     LET g_oob[l_ac].oob13=''   #MOD-730022
  END IF
#  LET g_oob[l_ac].oob13=l_oma.oma15
#END MOD-5B0012
  #No.FUN-740184  --Begin
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
          RETURNING l_bookno,g_oob[l_ac].oob11
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
          RETURNING l_bookno,g_oob[l_ac].oob111
  END IF
  #No.FUN-740184  --End
 
  IF p_sw = '2' THEN
     LET g_oob[l_ac].oob14=l_oma.oma16
  ELSE
     LET g_oob[l_ac].oob14=l_oma.oma10
  END IF
##No.2878 modify 1998/12/01 oma00='25'要判斷輸入時其oma00='12'之值亦須存在
  IF p_sw = '2' THEN   #待抵
     IF l_oma.oma00 = '25' THEN
        SELECT COUNT(*) INTO g_cnt FROM oob_file
         WHERE oob06 = g_oob[l_ac].oob14
           AND oob03 = '2'
           AND oob01 = g_ooa.ooa01
        IF g_cnt <= 0 THEN
           CALL cl_err(g_oob[l_ac].oob06,'axr-353',1)
           LET g_errno = 'N'
        END IF
     END IF
  END IF
##----------------------------------------------------------------------
END FUNCTION
 
#------------------------------------------ 970123 roger AP 對沖
#FUNCTION t410_oob06_19()            # 借方檢查 : A/P   #MOD-750063
FUNCTION t410_oob06_19(l_sw)         # 借/貸方檢查 : A/P   #MOD-750063
  DEFINE l_apa            RECORD LIKE apa_file.*
  DEFINE l_apc            RECORD LIKE apc_file.*   #No.FUN-680022 add
  DEFINE p05,p05f       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_apz27        LIKE apz_file.apz27
  DEFINE l_amt3         LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_amtf,l_amt   LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  #add 030422 NO.A058
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_aag05        LIKE aag_file.aag05   #MOD-730022
  DEFINE l_bookno       LIKE aag_file.aag00   #No.FUN-740184
  DEFINE l_sw           LIKE type_file.chr1   #MOD-750063
 
 #SELECT * INTO l_apa.* FROM apa_file WHERE apa01= g_oob[l_ac].oob06     #No.FUN-680022 mark
  #-----MOD-750063---------
  IF cl_null(g_oob[l_ac].oob19) THEN LET g_oob[l_ac].oob19 = '1' END IF 
  #SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file        #No.FUN-680022 add
  # WHERE apa01= g_oob[l_ac].oob06     
  SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file 
   WHERE apa01= g_oob[l_ac].oob06 
     AND apa01=apc01 
     AND apc02= g_oob[l_ac].oob19    
  #-----END MOD-750063-----
  IF STATUS THEN 
#    CALL cl_err('sel apa',STATUS,1) #No.FUN-660116
     CALL cl_err3("sel","apa_file",g_oob[l_ac].oob06,"",STATUS,"","sel apa",1)  #No.FUN-660116  
     LET g_errno='N' 
  END IF
  IF l_apa.apa06!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當付款廠商!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa07!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當廠商名稱!=客戶名稱時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa13!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_apa.apa41 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  #No.FUN-740184  --Begin
  CALL s_get_bookno(YEAR(l_apa.apa02)) RETURNING g_flag,g_bookno1,g_bookno2
  IF g_flag='1' THEN
     CALL cl_err(l_apa.apa02,'aoo-081',1)
  END IF
  #No.FUN-740184  --End 
  #add 030422  NO.A058
  #須考慮未確認沖帳資料
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
  #WHERE oob06 = g_oob[l_ac].oob06                               #No.FUN-680022 mark
   WHERE oob06 = g_oob[l_ac].oob06 AND oob19=g_oob[l_ac].oob19   #No.FUN-680022 add
     AND oob01 = ooa01 AND ooaconf = 'N'
    #AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob[l_ac].oob02)    #MOD-950237
     AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)        #MOD-950237
     AND oob03 = g_oob[l_ac].oob03
     AND oob04 = g_oob[l_ac].oob04
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  LET p05f = 0 LET p05 = 0
  #-----MOD-750063----------
  #SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
  #  FROM apg_file,apf_file
  # WHERE apg04=g_oob[l_ac].oob06
  #   AND apg06=g_oob[l_ac].oob19   #No.FUN-680022 add
  #   AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
  IF l_sw = '1' THEN
     SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
       FROM apg_file,apf_file
      WHERE apg04=g_oob[l_ac].oob06
        AND apg06=g_oob[l_ac].oob19
        AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
  ELSE
     SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05
       FROM aph_file,apf_file
      WHERE aph04=g_oob[l_ac].oob06
        AND aph17=g_oob[l_ac].oob19
        AND aph01=apf01 AND apf41='N' AND aph01<>g_ooa.ooa01
  END IF
  #-----END MOD-750063-----
  IF p05f IS NULL THEN LET p05f=0 END IF
  IF p05  IS NULL THEN LET p05 =0 END IF
  #No.MOD-590440  --begin
  #-----MOD-750063---------
  #LET l_amtf = l_apa.apa34f-l_apa.apa35f-l_apa.apa20
  #IF g_apz.apz27 = 'N' THEN
  #   LET l_amt  = l_apa.apa34 -l_apa.apa35 -(l_apa.apa20*l_apa.apa14)
  #   IF (l_apa.apa34f-l_apa.apa35f-l_apa.apa20-p05f) > l_amtf OR
  #      (l_apa.apa34-l_apa.apa35-(l_apa.apa20*l_apa.apa14)-p05) > l_amt THEN
  #      CALL cl_err('','axr-185',1) LET g_errno='N'
  #   END IF
  #ELSE
  #   LET l_amt  = l_apa.apa73 -(l_apa.apa20*l_apa.apa72)
  #   IF (l_apa.apa34f-l_apa.apa35f-l_apa.apa20-p05f) > l_amtf OR
  #      (l_apa.apa73-(l_apa.apa20*l_apa.apa72)-p05) > l_amt THEN
  #      CALL cl_err('','axr-185',1) LET g_errno='N'
  #   END IF
  #END IF
  LET l_amtf = l_apc.apc08-l_apc.apc10-l_apc.apc16-tot1-p05f
  IF g_apz.apz27 = 'N' THEN
     LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_apc.apc16*l_apc.apc06)-tot2-p05
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  ELSE
     LET l_amt  = l_apc.apc13 -(l_apc.apc16*l_apc.apc07)-tot2-p05
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  END IF
  #-----END MOD-750063-----
  #No.MOD-590440  --end
  #------------------------------------------------
  LET g_oob[l_ac].oob07=l_apa.apa13
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077 #No.CHI-6A0004 #MOD-940238 RECUVA
# SELECT azi04,azi07 INTO t_azi04,t_azi07 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 #MOD-940238 MARK
  #LET g_oob[l_ac].oob08=l_apa.apa14   #MOD-750063
  LET g_oob[l_ac].oob08=l_apc.apc06   #MOD-750063
  LET g_oob[l_ac].oob09=l_amtf
  LET g_oob[l_ac].oob10=l_amt
# CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08     #No.MOD-910070  #MOD-940238 MARK
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10     #No.CHI-6A0004
  LET g_oob[l_ac].oob11=l_apa.apa54
  IF g_aza.aza63='Y' THEN                 #No.FUN-670047 add
     LET g_oob[l_ac].oob111=l_apa.apa541  #No.FUN-670047 add
  END IF                                  #No.FUN-670047 add
  #-----MOD-730022---------
  #LET g_oob[l_ac].oob13=l_apa.apa22
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1          #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_apa.apa22
  ELSE
     LET g_oob[l_ac].oob13=''
  END IF
  #-----END MOD-730022-----
  #No.FUN-740184  --Begin
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
          RETURNING l_bookno,g_oob[l_ac].oob11
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
          RETURNING l_bookno,g_oob[l_ac].oob111
  END IF
  #No.FUN-740184  --End
  LET g_oob[l_ac].oob14=l_apa.apa08
  LET g_oob[l_ac].oob12=l_apa.apa25   #MOD-780261
  #add by danny 020314 期末調匯(A008)
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
  #modify 030311 NO.A048
  IF l_apz27 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
        LET g_oob[l_ac].oob08 = l_apa.apa72
     ELSE                                       #MOD-940277
     	  LET g_oob[l_ac].oob08 = l_apc.apc06     #MOD-940277
     END IF                                     #MOD-940277	     
     IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
        #LET g_oob[l_ac].oob08 = l_apa.apa14   #MOD-750063
        LET g_oob[l_ac].oob08 = l_apc.apc06   #MOD-750063
     END IF
     CALL s_g_np('2',l_apa.apa00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
                 RETURNING l_amt3
     #modify 030422 NO.A058
     #未付金額-已KEY未確認-留置金額
     #IF (tot1+g_oob[l_ac].oob09+l_apa.apa35f) = l_apa.apa34f THEN   #MOD-750063
     IF (tot1+g_oob[l_ac].oob09+p05f+l_apc.apc10) = l_apc.apc08 THEN   #MOD-750063
        #LET g_oob[l_ac].oob10 = l_amt3-tot2-p05-(l_apa.apa20*l_apa.apa14)   #MOD-750063
        LET g_oob[l_ac].oob10 = l_amt3-tot2-p05-(l_apc.apc16*l_apc.apc06)   #MOD-750063
     END IF
#    CALL cl_digcut(g_oob[l_ac].oob08,t_azi07) RETURNING g_oob[l_ac].oob08  #MOD-910070 #MOD-940238 MARK
     CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10  #No.CHI-6A0004
  END IF
END FUNCTION
 
FUNCTION t410_diff()
   DEFINE l_oob10d  LIKE oob_file.oob10
   DEFINE l_oob10c  LIKE oob_file.oob10
   DEFINE l_cnt     LIKE type_file.num10       #No.FUN-680123 INTEGER #MOD-5B0292
   DEFINE l_msg     LIKE type_file.chr20       #No.FUN-680123 VARCHAR(20)
   DEFINE l_aag05   LIKE aag_file.aag05   #MOD-730022
 
   #No.FUN-740184  --Begin
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(g_ooa.ooa02,'aoo-081',1)
   END IF
   #No.FUN-740184  --End  
   IF g_ooa.ooa32d = g_ooa.ooa32c THEN RETURN END IF
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
   LET b_oob.oob07=g_ooa.ooa23
   IF b_oob.oob07 IS NULL THEN
      WHILE b_oob.oob07 IS NULL
         LET l_msg=cl_getmsg('axr-030',g_lang)  #MOD-4C0141
        PROMPT l_msg FOR b_oob.oob07
              ON IDLE g_idle_seconds
                 CALL cl_on_idle()
 
               ON ACTION about         #MOD-4C0121
                  CALL cl_about()      #MOD-4C0121
 
               ON ACTION help          #MOD-4C0121
                  CALL cl_show_help()  #MOD-4C0121
 
               ON ACTION controlg      #MOD-4C0121
                  CALL cl_cmdask()     #MOD-4C0121
        END PROMPT
        IF INT_FLAG THEN LET INT_FLAG=0 EXIT WHILE END IF
      END WHILE
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 RECUVA
   LET b_oob.oob03='1'
   LET b_oob.oob04='A'
   LET b_oob.oob10= g_ooa.ooa32c - g_ooa.ooa32d
   IF b_oob.oob10<0 THEN LET b_oob.oob10=-b_oob.oob10 END IF
   IF g_ooa.ooa31d = g_ooa.ooa31c THEN 
      LET b_oob.oob08= 1
      LET b_oob.oob09= 0
      IF g_ooa.ooa32d>g_ooa.ooa32c THEN #匯兌收入
         LET b_oob.oob03='2'
      ELSE
         LET b_oob.oob03='1'                   #匯兌損失
      END IF
   ELSE 
      LET b_oob.oob09= g_ooa.ooa31c - g_ooa.ooa31d
      LET b_oob.oob08= b_oob.oob10/b_oob.oob09
   END IF
   CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004
   CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004
 
   SELECT SUM(oob10) INTO l_oob10d FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03 ='1'
   SELECT SUM(oob10) INTO l_oob10c FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03 ='2'
   IF cl_null(l_oob10d) THEN LET l_oob10d=0 END IF
   IF cl_null(l_oob10c) THEN LET l_oob10c=0 END IF
   IF diff_flag='8' THEN
      IF l_oob10d <> l_oob10c+b_oob.oob10 THEN
         LET b_oob.oob10=l_oob10d - l_oob10c
      END IF
   ELSE
      IF l_oob10d +b_oob.oob10 <> l_oob10c THEN
         LET b_oob.oob10=l_oob10d - l_oob10c
      END IF
   END IF
  SELECT MAX(oob02)+1 INTO b_oob.oob02 FROM oob_file
         WHERE oob01=g_ooa.ooa01
   IF STATUS OR b_oob.oob02 IS NULL THEN
      IF b_oob.oob03='1' THEN LET b_oob.oob02=1 ELSE LET b_oob.oob02=5 END IF
   END IF
   CALL t410_b_move_to()
   CALL t410_acct_code()
   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                             AND aag00=g_bookno1      #No.FUN-730073
   IF l_aag05 = 'Y' THEN
      LET b_oob.oob13= g_ooa.ooa15
   ELSE
      LET b_oob.oob13= ''
   END IF
   LET b_oob.oob20='N'
   LET b_oob.oob22=0
   #FUN-960141 add
   #LET b_oob.oobplant = g_ooa.ooaplant    #FUN-960141  090824 mark
   LET b_oob.ooblegal = g_ooa.ooalegal
   #FUN-960141 end
   INSERT INTO oob_file VALUES(b_oob.*)
   IF STATUS THEN
      CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,STATUS,"","ins oob",1)  #No.FUN-660116
      BEGIN WORK LET g_success='Y'
 
      OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
      IF STATUS THEN
         CALL cl_err("OPEN t410_cl:", STATUS, 1)  
         CLOSE t410_cl
         ROLLBACK WORK
         RETURN
      END IF
      FETCH t410_cl INTO g_ooa.*       # 鎖住將被更改或取消的資料
      IF SQLCA.sqlcode THEN
          CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
          CLOSE t410_cl ROLLBACK WORK RETURN
      END IF
      CALL t410_sortb() RETURNING b_oob.oob02
      IF g_success='Y' THEN COMMIT WORK
         INSERT INTO oob_file VALUES(b_oob.*)
      ELSE
         ROLLBACK WORK
         CALL cl_err('ins oob',STATUS,1)
      END IF
   END IF
   CALL t410_bu()
END FUNCTION
 
FUNCTION t410_sortb()
DEFINE p_i,p_rnum  LIKE type_file.num5,       #No.FUN-680123 SMALLINT,
         p_oob03_t LIKE oob_file.oob03,
         p_a       LIKE type_file.chr1,       #No.FUN-680123 VARCHAR(1),
         p_oob       RECORD LIKE oob_file.*,
         x_oob      DYNAMIC ARRAY OF RECORD like oob_file.*
   #No.FUN-680123 begin    
CREATE TEMP TABLE sort_file(
oob01 LIKE oob_file.oob01,
oob02 LIKE oob_file.oob02,
oob03 LIKE oob_file.oob03,
oob04 LIKE oob_file.oob04,
#oob05 LIKE oob_file.oob05,    #FUN-990031 mark
oob06 LIKE oob_file.oob06,
oob07 LIKE oob_file.oob07,
oob08 LIKE oob_file.oob08 NOT NULL,
oob09 LIKE oob_file.oob09 NOT NULL,
oob10 LIKE oob_file.oob10 NOT NULL,
oob11 LIKE oob_file.oob11,
oob12 LIKE oob_file.oob12,
oob13 LIKE oob_file.oob13,
oob14 LIKE oob_file.oob14,
oob15 LIKE oob_file.oob15,
oob16 LIKE oob_file.oob16)
   #No.FUN-680123 end
 
       INITIALIZE p_oob.* TO NULL
       DECLARE t410_sortb_cur CURSOR FOR
        SELECT * FROM oob_file WHERE oob01=g_ooa.ooa01
        ORDER BY oob03
 
      LET p_i=1
      FOREACH t410_SORTB_CUR INTO p_oob.*
          IF STATUS THEN LET g_success='N' RETURN 0 END IF
        INSERT INTO sort_file VALUES(p_oob.*)
          IF STATUS THEN LET g_success='N' RETURN 0 END IF
      END FOREACH
            LET INT_FLAG = 0  ######add for prompt bug
        PROMPT 'any key continue...' FOR CHAR p_a
           ON IDLE g_idle_seconds
              CALL cl_on_idle()
#              CONTINUE PROMPT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
        END PROMPT
        DELETE FROM oob_file WHERE oob01=g_ooa.ooa01
      IF STATUS THEN
            LET g_success='N' RETURN 0
        END IF
      LET p_i=1
      DECLARE t410_sortc_cur CURSOR FOR
         SELECT * FROM sort_file WHERE oob01=g_ooa.ooa01 ORDER BY oob03
      LET p_oob03_t=1
      FOREACH t410_SORTC_CUR INTO p_oob.*
        IF p_oob.oob03<>p_oob03_t THEN
           LET p_rnum=p_i
           LET p_i=p_i+1
          END IF
        LET p_oob.oob02=p_i
        INSERT INTO oob_file VALUES(p_oob.*)
        IF STATUS THEN LET g_success='N' RETURN 0 END IF
          LET p_oob03_t=p_oob.oob03
        LET p_i=p_i+1
      END FOREACH
      DROP TABLE sort_file
      RETURN p_rnum
END FUNCTION
 
FUNCTION t410_mlog(p_cmd)      # Transaction Modify Log (存入 oem_file)
   DEFINE p_cmd        LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
END FUNCTION
 
FUNCTION t410_bu()
   LET g_ooa.ooa31d = 0 LET g_ooa.ooa31c = 0
   LET g_ooa.ooa32d = 0 LET g_ooa.ooa32c = 0
   SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31d,g_ooa.ooa32d
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
   SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31c,g_ooa.ooa32c
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
   IF cl_null(g_ooa.ooa31d) THEN LET g_ooa.ooa31d=0 END IF
   IF cl_null(g_ooa.ooa32d) THEN LET g_ooa.ooa32d=0 END IF
   IF cl_null(g_ooa.ooa31c) THEN LET g_ooa.ooa31c=0 END IF
   IF cl_null(g_ooa.ooa32c) THEN LET g_ooa.ooa32c=0 END IF
   #no.A010依幣別取位
   LET g_ooa.ooa32d = cl_digcut(g_ooa.ooa32d,g_azi04)  #No.CHI-6A0004
   LET g_ooa.ooa32c = cl_digcut(g_ooa.ooa32c,g_azi04)  #No.CHI-6A0004
   #(end)
   UPDATE ooa_file SET
          ooa31d=g_ooa.ooa31d,ooa31c=g_ooa.ooa31c,
          ooa32d=g_ooa.ooa32d,ooa32c=g_ooa.ooa32c
          WHERE ooa01=g_ooa.ooa01
  #No.+041 010330 by plum
  #IF STATUS THEN CALL cl_err('upd ood31,32',STATUS,0) END IF
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#     CALL cl_err('upd ood31,32',SQLCA.SQLCODE,0)  #No.FUN-660116
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.SQLCODE,"","upd ood31,32",1)  #No.FUN-660116
   END IF
  #No.+041..end
 
   CALL t410_show_amt()
END FUNCTION
 
FUNCTION t410_delall()
    SELECT COUNT(*) INTO g_cnt FROM oob_file WHERE oob01=g_ooa.ooa01
    IF g_cnt = 0 THEN                   # 未輸入單身資料, 則取消單頭資料
       CALL cl_getmsg('9044',g_lang) RETURNING g_msg
       ERROR g_msg CLIPPED
       DELETE FROM ooa_file WHERE ooa01 = g_ooa.ooa01
    END IF
END FUNCTION
 
FUNCTION t410_b_askkey()
DEFINE l_wc2           LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(200)
    CLEAR oob04_d
    #CONSTRUCT l_wc2 ON oob02,oob05,oob03,oob04,oob06,oob19,oob11,oob111,   #No.FUN-680022 add oob19 #No.FUN-680047 add oob111   #No.FUN-690090 add oob05   #FUN-990031 mark
    CONSTRUCT l_wc2 ON oob02,oob03,oob04,oob06,oob19,oob11,oob111,    #FUN-990031 del oob05
                       oob13,oob14,oob07,oob08,oob09,oob10
                      #No.FUN-850038 --start--
                      ,oobud01,oobud02,oobud03,oobud04,oobud05
                      ,oobud06,oobud07,oobud08,oobud09,oobud10
                      ,oobud11,oobud12,oobud13,oobud14,oobud15
                      #No.FUN-850038 ---end---
            #FROM s_oob[1].oob02,s_oob[1].oob05,s_oob[1].oob03,s_oob[1].oob04,  #No.FUN-690090 add oob05   #FUN-990031 mark
            FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,   #FUN-990031 del oob05
                 s_oob[1].oob06,s_oob[1].oob19,s_oob[1].oob11,s_oob[1].oob111,    #No.FUN-680022  add oob19
                 s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                 s_oob[1].oob08,s_oob[1].oob09,s_oob[1].oob10
                #No.FUN-850038 --start--
                ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
                #No.FUN-850038 ---end---
              #No.FUN-580031 --start--     HCN
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
              #No.FUN-580031 --end--       HCN
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
		#No.FUN-580031 --start--     HCN
                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
		#No.FUN-580031 --end--       HCN
    END CONSTRUCT
    IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
    CALL t410_b_fill(l_wc2)
    CALL t410_b_fill_2(l_wc2) #FUN-A90003 Add
END FUNCTION
 
FUNCTION t410_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(200)
 
    LET g_sql =
       #"SELECT oob02,oob03,oob04,'',oob06,oob15,oob11,oob13,oob14,", #No.FUN-670047 mark
       #FUN-960141 modify
       #"SELECT oob02,oob05,oob03,oob04,'',oob06,oob19,oob15,oob11,oob111,oob13,oob14,", #No.FUN-670047 add   #No.FUN-690090 add oob05
       #"SELECT oob02,oob05,oob03,oob04,'',oob06,oob19,oob15,oob20,oob23,oob17,oob18,oob21, ",   #FUN-990031 mark
       "SELECT oob02,oob03,oob04,'',oob06,oob19,oob15,oob20,oob23,oob17,oob18,oob21, ",    #FUN-990031 del oob05
        "       oob11,oob111,oob13,oob14,", #No.FUN-670047 add   #No.FUN-690090 add oob05
       #End
        "       oob07,oob08,oob09,oob10,oob12,",
        #No.FUN-850038 --start--
        "       oobud01,oobud02,oobud03,oobud04,oobud05,",
        "       oobud06,oobud07,oobud08,oobud09,oobud10,",
        "       oobud11,oobud12,oobud13,oobud14,oobud15 ",
        #No.FUN-850038 ---end---
        " FROM oob_file ",
        " WHERE oob01 ='",g_ooa.ooa01,"'",  #單頭
        " AND oob03 = '1' ",                #FUN-A90003 Add
        " AND ",p_wc2 CLIPPED,                     #單身
        " ORDER BY 1"
 
    PREPARE t410_pb FROM g_sql
    DECLARE oob_curs                       #SCROLL CURSOR
        CURSOR FOR t410_pb
    CALL g_oob.clear()
    LET g_rec_b = 0
    #LET g_chr = '0'
    LET g_cnt = 1
    FOREACH oob_curs INTO g_oob[g_cnt].*   #單身 ARRAY 填充
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        CALL s_oob04(g_oob[g_cnt].oob03,g_oob[g_cnt].oob04)
                RETURNING g_oob[g_cnt].oob04_d
       {#多塞一行空白genero先拿掉
        IF g_chr = '0' THEN LET g_chr = g_oob[g_cnt].oob03 END IF
        IF g_oob[g_cnt].oob03 != g_chr THEN            # 借貸方變號時空一行
           LET g_chr = g_oob[g_cnt].oob03
           LET g_cnt=g_cnt+1
           LET g_oob[g_cnt].*=g_oob[g_cnt-1].*
           INITIALIZE g_oob[g_cnt-1].* TO NULL
        END IF
       }
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_oob.deleteElement(g_cnt)
    LET g_rec_b=g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2
#    LET g_cnt = 0 DISPLAY g_cnt TO FORMONLY.cn3
     CALL t410_bp_refresh() #MOD-4A0036
END FUNCTION
 
FUNCTION t410_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   #No.FUN-670047--begin--
    IF g_aza.aza63 = 'N' THEN
       CALL cl_set_act_visible("entry_sheet2", FALSE)
    ELSE
       CALL cl_set_act_visible("entry_sheet2", TRUE)
    END IF
   #No.FUN-670047--end--
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED)                                           #FUN-A90003 Add
   
   DISPLAY ARRAY g_oob TO s_oob.* ATTRIBUTE(COUNT=g_rec_b)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         LET g_b_flag='1'                         #FUN-A90003 Add
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                  #No.FUN-550037
         
         
      AFTER DISPLAY                               #FUN-A90003 Add
        CONTINUE DIALOG                           #FUN-A90003 Add
        
   END DISPLAY
   #FUN-A90003 Add--Begin
   DISPLAY ARRAY g_oob_d TO s_oob_d.* ATTRIBUTE(COUNT=g_rec_b2)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         LET g_b_flag='2'                         #FUN-A90003 Add
         
      BEFORE ROW
         LET l_ac2 = ARR_CURR()
         CALL cl_show_fld_cont()               
 
      AFTER DISPLAY                              
        CONTINUE DIALOG                           
        
   END DISPLAY                                    
   #FUN-A90003 Add--End                    
 
      ON ACTION insert
         LET g_action_choice="insert"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION query
         LET g_action_choice="query"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION delete
         LET g_action_choice="delete"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION modify
         LET g_action_choice="modify"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add

#FUN-A90003--Mark--Begin--# 
#      ON ACTION first
#         CALL t410_fetch('F')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION previous
#         CALL t410_fetch('P')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION jump
#         CALL t410_fetch('/')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION next
#         CALL t410_fetch('N')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#   	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION last
#         CALL t410_fetch('L')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#           IF g_rec_b != 0 THEN
#         CALL fgl_set_arr_curr(1)  ######add in 040505
#           END IF
#	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
#FUN-A90003--Mark--End--#

#FUN-A90003--Add--Begin--#
      ON ACTION first
         CALL t410_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count) 
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
         EXIT DIALOG
 
      ON ACTION previous
         CALL t410_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)
         END IF
	       EXIT DIALOG
 
      ON ACTION jump
         CALL t410_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
	       EXIT DIALOG
 
      ON ACTION next
         CALL t410_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
   	     EXIT DIALOG
 
      ON ACTION last
         CALL t410_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
	       EXIT DIALOG 
#FUN-A90003--Add--End--#
 
      ON ACTION detail
         LET g_action_choice="detail"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
         LET l_ac = 1
 
      ON ACTION output
         LET g_action_choice="output"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION help
         LET g_action_choice="help"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION exit
         LET g_action_choice="exit"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION controlg
         LET g_action_choice="controlg"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION void  #作廢
         LET g_action_choice="void"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION gen_entry #會計分錄產生
         LET g_action_choice="gen_entry"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION entry_sheet #分錄底稿
         LET g_action_choice="entry_sheet"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
     #No.FUN-670047--begin-- add
      ON ACTION entry_sheet2 #分錄底稿
         LET g_action_choice="entry_sheet2"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
     #No.FUN-670047--end-- add
 
      ON ACTION memo  #備註
         LET g_action_choice="memo"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION easyflow_approval           #FUN-550049
         LET g_action_choice="easyflow_approval"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      #No.FUN-670060 --begin--
      ON ACTION carry_voucher #傳票拋轉
         LET g_action_choice="carry_voucher"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
    
      ON ACTION undo_carry_voucher #傳票拋轉還原
         LET g_action_choice="undo_carry_voucher"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
      #No.FUN-670060 --end--   
    
      ON ACTION confirm #確認
         LET g_action_choice="confirm"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION undo_confirm #取消確認
         LET g_action_choice="undo_confirm"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
#FUN-580154
      ON ACTION agree
         LET g_action_choice = 'agree'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION deny
         LET g_action_choice = 'deny'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION modify_flow
         LET g_action_choice = 'modify_flow'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION withdraw
         LET g_action_choice = 'withdraw'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION org_withdraw
         LET g_action_choice = 'org_withdraw'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION phrase
         LET g_action_choice = 'phrase'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
#FUN-580154 End
 
      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION cancel
             LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         #CKP
         #FUN-550049
         IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
         CALL t410_set_comb_oob04()         #FUN-A90003 Add  
         CALL t410_set_comb_oob04_1()       #FUN-A90003 Add         
         ## END FUN-550049 ##
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
#        CONTINUE DISPLAY                       #FUN-A90003 Mark
         CONTINUE DIALOG                        #FUN-A90003 Add
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
  
      #FUN-4B0017
      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
      #--
 
      ON ACTION approval_status                    #FUN-550049
         LET g_action_choice="approval_status"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION related_document                #No.FUN-6B0042  相關文件
         LET g_action_choice="related_document"          
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add 
      #No.FUN-7C0050 add
      &include "qry_string.4gl"
#  EXIT DISPLAY                       #FUN-A90003 Mark
   END DIALOG                        #FUN-A90003 Add
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
FUNCTION t410_bp_refresh()
 
   #FUN-640246
   IF g_bgjob = 'Y' THEN
      RETURN
   END IF
   #END FUN-640246
 
   DISPLAY ARRAY g_oob TO s_oob.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
   END DISPLAY
END FUNCTION
 
 
FUNCTION t410_out()
    DEFINE l_wc                LIKE type_file.chr1000   #No.FUN-680123  VARCHAR(100)
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    MENU ""
       ON ACTION brief_report_print
          CALL t410_out1()
 
       ON ACTION print_this_pay_slip
          #-----TQC-660010---------
          #LET g_msg="axrr400 '",g_ooa.ooa01,"'"
          LET g_msg = "axrr400 '' '' '",g_lang,"' 'Y' '' '' ",
                      "'ooa01 =\"",g_ooa.ooa01,"\"' 'g_ooa.ooaconf' " 
          #-----END TQC-660010-----
          CALL cl_cmdrun(g_msg)
 
       ON ACTION exit
          EXIT MENU
 
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE MENU
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
 
        -- for Windows close event trapped
        ON ACTION close   #COMMAND KEY(INTERRUPT) #FUN-9B0145  
             LET INT_FLAG=FALSE 		#MOD-570244	mars
            LET g_action_choice = "exit"
            EXIT MENU
 
    END MENU
END FUNCTION
 
FUNCTION t410_out1()
DEFINE
    l_i             LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
    sr              RECORD LIKE ooa_file.*,
    l_name          LIKE type_file.chr20,     #No.FUN-680123 VARCHAR(20),              #External(Disk) file name
    l_za05          LIKE type_file.chr1000    #No.FUN-680123 VARCHAR(40)               #
 
#No.FUN-850143-------start--
   DEFINE   l_gem02 LIKE gem_file.gem02
   DEFINE   l_aag02 LIKE aag_file.aag02
   DEFINE   l_n     LIKE type_file.num5
   DEFINE   l_ooa03 LIKE ooa_file.ooa03   #TQC-9C0179
   
   LET g_prog = 'axrt400'    #No.TQC-9C0190
   CALL cl_del_data(l_table)
   
   SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = 'axrt400'
#No.FUN-850143-------end
 
    IF g_wc IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    CALL cl_wait()
#   LET l_name = 'axrt400.out'
    #CALL cl_outnam('axrt400') RETURNING l_name  #No.FUN-850143
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    LET g_sql="SELECT * FROM ooa_file",
              " WHERE ",g_wc CLIPPED,
              "   AND ooa00 = '1' ",  #FUN-570099
#             "   AND ooa37 = 'Y' ",  #No.TQC-9C0190  #FUN-A40076 Mark
              "   AND ooa37 = '2' ",                  #FUN-A40076 Add 
              " ORDER BY 1"
    PREPARE t410_p1 FROM g_sql                # RUNTIME 編譯
    DECLARE t410_co                         # SCROLL CURSOR
        CURSOR FOR t410_p1
 
    #START REPORT t410_rep TO l_name  #No.FUN-850143
 
    FOREACH t410_co INTO sr.*
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        #No.FUN-850143----start--
        CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                               
        RETURNING g_flag,g_bookno1,g_bookno2                                                                          
        IF g_flag = '1' THEN     #抓不到帳別                                                                               
           CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                            
        END IF                                                                                                             
            
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = sr.ooa23 
        SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01 = sr.ooa15
        SELECT aag02 INTO l_aag02 FROM aag_file WHERE aag01 = sr.ooa13 
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=sr.ooa23  
        
        LET l_n = l_n +1
        LET l_ooa03 = sr.ooa03[1,6]   #TQC-9C0179
        EXECUTE insert_prep USING
              #sr.ooa01,sr.ooa02,sr.ooa03[1,6],sr.ooa032,sr.ooa15,l_gem02, #TQC-9C0179 mark
              sr.ooa01,sr.ooa02,l_ooa03,sr.ooa032,sr.ooa15,l_gem02,  #TQC-9C0179
              sr.ooa23,sr.ooa31d,sr.ooa32d,sr.ooa13,l_aag02,t_azi04,l_n         
        #OUTPUT TO REPORT t410_rep(sr.*)
        #No.FUN-850143----end 
    END FOREACH
 
    #No.FUN-850143-----start--
    #FINISH REPORT t410_rep
    LET l_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED
    
    IF g_zz05 = 'Y' THEN 
       CALL cl_wcchp(g_str,'ooa01,ooa02,ooa03,ooa032,ooa14,ooa15,ooa23,     
                     ooa13,ooa33,ooa992,ooaconf,ooamksg,ooa34,ooa31d,
                     #ooa31c,ooauser,ooagrup,ooamodu,ooadate,oob02,oob05,oob03,   #FUN-990031 mark
                     ooa31c,ooauser,ooagrup,ooamodu,ooadate,oob02,oob03,    #FUN-990031 del oob05
                     oob04,oob06,oob19,oob15,oob11,oob111,oob13,oob14,oob07,
                     oob08')
       RETURNING g_wc
    END IF
    
    LET l_str = g_wc,";",g_azi04
    
    CALL cl_prt_cs3('axrt400','axrt400',l_sql,l_str)
    CLOSE t410_co
    ERROR ""
    #CALL cl_prt(l_name,' ','1',g_len)
    #No.FUN-850143----end
   LET g_prog = 'axrt410'    #No.TQC-9C0190
END FUNCTION
 
#No.FUN-850143-----start--
#REPORT t410_rep(sr)
# DEFINE
#    l_trailer_sw    LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
#    l_i             LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
#    g_head1         STRING,
#    str             STRING,
#    l_gem02         LIKE gem_file.gem02,
#    l_aag02         LIKE aag_file.aag02,
#    sr              RECORD LIKE ooa_file.*
#   OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
#
#    ORDER BY sr.ooa01
#
#    FORMAT
#        PAGE HEADER
#            PRINT COLUMN ((g_len-FGL_WIDTH(g_company CLIPPED))/2)+1,g_company CLIPPED
#            PRINT COLUMN ((g_len-FGL_WIDTH(g_x[1]))/2)+1,g_x[1]
#            LET g_pageno = g_pageno + 1
#            LET pageno_total = PAGENO USING '<<<',"/pageno"
#            PRINT g_head CLIPPED, pageno_total
#            PRINT g_dash[1,g_len]
#            PRINT g_x[31],g_x[32],g_x[33],g_x[34],g_x[35],g_x[36],
#                  g_x[37],g_x[38],g_x[39],g_x[40],g_x[41]
#            PRINT g_dash1
#            LET l_trailer_sw = 'y'
# 
#        ON EVERY ROW
#           #NO.FUN-730073---begin---                                                                                           
#           CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                               
#           RETURNING g_flag,g_bookno1,g_bookno2                                                                          
#           IF g_flag = '1' THEN     #抓不到帳別                                                                               
#              CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                            
#           END IF                                                                                                             
#           #NO.FUN-730073---end---      
#           SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = sr.ooa23 #MOD-560077  #No.CHI-6A0004
#           SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01 = sr.ooa15
#           SELECT aag02 INTO l_aag02 FROM aag_file WHERE aag01 = sr.ooa13 
#           SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=sr.ooa23  #MOD-560077   #No.CHI-6A0004
#           PRINT COLUMN g_c[31],sr.ooa01,
#                 COLUMN g_c[32],sr.ooa02,
#                 COLUMN g_c[33],sr.ooa03[1,6],
#                 COLUMN g_c[34],sr.ooa032,
#                 COLUMN g_c[35],sr.ooa15,
#                 COLUMN g_c[36],l_gem02,
#                 COLUMN g_c[37],sr.ooa23,
#                 COLUMN g_c[38],cl_numfor(sr.ooa31d,38,t_azi04), #MOD-560077   #No.CHI-6A0004
#                 COLUMN g_c[39],cl_numfor(sr.ooa32d,39,g_azi04), #MOD-560077   #No.CHI-6A0004
#                 COLUMN g_c[40],sr.ooa13,
#                 COLUMN g_c[41],l_aag02
# 
#        ON LAST ROW
#            LET str = COUNT(*) USING '###',g_x[10] CLIPPED
#            PRINT COLUMN g_c[35],g_x[9] CLIPPED,
#                 COLUMN g_c[36],str,
#                  COLUMN g_c[38],cl_numfor(SUM(sr.ooa31d),38,t_azi04), #MOD-560077     #No.CHI-6A0004
#                  COLUMN g_c[39],cl_numfor(SUM(sr.ooa32d),39,g_azi04) #MOD-560077     #No.CHI-6A0004
#            LET l_trailer_sw = 'n'
#            PRINT g_dash[1,g_len]
#            PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[7] CLIPPED
#
#        PAGE TRAILER
#            IF l_trailer_sw = 'y'
#             THEN PRINT g_dash[1,g_len]
#                  PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[6] CLIPPED
#             ELSE SKIP 2 LINE
#            END IF
#END REPORT
#No.FUN-850143----end
FUNCTION t410_2()
   DEFINE  l_oap   RECORD LIKE oap_file.*
   DEFINE ls_tmp STRING
 
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    LET p_row = 10 LET p_col = 10
    OPEN WINDOW t4002_w AT p_row,p_col WITH FORM "axr/42f/axrt4002"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4002")
 
    LET g_buf=NULL
 
    # 2004/05/24
#   IF NOT cl_prich3(g_ooa.ooauser,g_ooa.ooagrup,'U') THEN
    LET g_action_choice="modify"
    IF NOT cl_chk_act_auth() THEN
       DISPLAY BY NAME g_ooa.ooaprsw,g_ooa.ooa20
            LET INT_FLAG = 0  ######add for prompt bug
       PROMPT ">" FOR CHAR g_chr
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
#             CONTINUE PROMPT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
       END PROMPT
       CLOSE WINDOW t4002_w
       RETURN
    END IF
    INPUT BY NAME      g_ooa.ooaprsw,g_ooa.ooa20
         WITHOUT DEFAULTS
 
#--NO.MOD-860078 start-----
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION help          
         CALL cl_show_help()  
 
      ON ACTION controlg      
         CALL cl_cmdask()     
#--NO.MOD-860078 end-------
   END INPUT
   IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t4002_w RETURN END IF
   CLOSE WINDOW t4002_w
    UPDATE ooa_file SET * = g_ooa.* WHERE ooa01 = g_ooa.ooa01
    IF SQLCA.SQLCODE THEN
#      CALL cl_err('update ooa',SQLCA.SQLCODE,0)   #No.FUN-660116
       CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","update ooa",1)  #No.FUN-660116
    END IF
END FUNCTION
 
FUNCTION t410_3()
 
   IF g_ooa.ooa01 IS NULL THEN
      RETURN
   END IF
 
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
 
   IF NOT cl_chk_act_auth() THEN
      LET g_chr='D'
   ELSE
      LET g_chr='U'
   END IF
 
    #-----No.MOD-530225-----
   BEGIN WORK
   OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
   IF STATUS THEN
      CALL cl_err("OPEN t410_cl:", STATUS, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t410_cl INTO g_ooa.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0) 
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
   #-----97-04-23 modify
  #CALL s_fsgl('AR',3,g_ooa.ooa01,0,g_ooz.ooz02b,1,g_ooa.ooaconf)                  #No.FUN-680022 mark
   CALL s_showmsg_init()             #NO.FUN-710050   
   CALL s_fsgl('AR',3,g_ooa.ooa01,0,g_ooz.ooz02b,1,g_ooa.ooaconf,'0',g_ooz.ooz02p) #No.FUN-680022 add
   CALL s_showmsg()                  #NO.FUN-710050
 
   CLOSE t410_cl
   COMMIT WORK
    #-----No.MOD-530225 END-----
 
END FUNCTION
 
FUNCTION t410_v()
   DEFINE l_wc    LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(100)
   DEFINE l_ooa01 LIKE ooa_file.ooa01
   DEFINE l_t1    LIKE ooy_file.ooyslip,   #No.FUN-680123 VARCHAR(5),  #FUN-560095
          l_ooydmy1   LIKE ooy_file.ooydmy1,
          l_ooaconf   LIKE ooa_file.ooaconf
   DEFINE only_one         LIKE type_file.chr1      #No.FUN-680123  VARCHAR(1)
   DEFINE ls_tmp      STRING
 
   IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
   END IF
   LET p_row = 8 LET p_col = 11
   OPEN WINDOW t4009_w AT p_row,p_col WITH FORM "axr/42f/axrt4009"
    ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4009")
 
   LET only_one = '1'
   INPUT BY NAME only_one WITHOUT DEFAULTS
     AFTER FIELD only_one
      IF NOT cl_null(only_one) THEN
         IF only_one NOT MATCHES "[12]" THEN NEXT FIELD only_one END IF
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
   IF INT_FLAG THEN LET INT_FLAG = 0 CLOSE WINDOW t4009_w RETURN END IF
   IF only_one = '1'
      THEN LET l_wc = " ooa01 = '",g_ooa.ooa01,"' "
   ELSE
      CONSTRUCT BY NAME l_wc ON ooa01,ooa02,ooa15
              #No.FUN-580031 --start--     HCN
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
              #No.FUN-580031 --end--       HCN
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
		#No.FUN-580031 --start--     HCN
                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
		#No.FUN-580031 --end--       HCN
      END CONSTRUCT
           IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t4009_w RETURN END IF
   END IF
   IF NOT cl_null(g_ooz.ooz09) THEN
      LET g_sql = g_sql CLIPPED," AND ooa02 >'",g_ooz.ooz09,"'"
   END IF
   CLOSE WINDOW t4009_w
   MESSAGE "WORKING !"
   LET g_sql = "SELECT ooa01,ooa20,ooaconf FROM ooa_file WHERE ",l_wc CLIPPED,
#              "   AND ooa37 = 'Y' ",  #No.TQC-9C0190  #FUN-A40076 Mark
               "   AND ooa37 = '2' ",                  #FUN-A40076 Add
               "   AND ooa00 = '1' "   #FUN-570099
   PREPARE t410_v_p FROM g_sql
   DECLARE t410_v_c CURSOR FOR t410_v_p
   LET g_success='Y' #no.5573
   BEGIN WORK  #no.5573
   CALL s_showmsg_init()              #NO.FUN-710050
   FOREACH t410_v_c INTO l_ooa01,g_chr,l_ooaconf
      IF STATUS THEN LET g_success = 'N' EXIT FOREACH END IF   #No.FUN-8A0086
#NO.FUN-710050--BEGIN                                                           
      IF g_success='N' THEN                                                    
       LET g_totsuccess='N'                                                   
       LET g_success='Y' 
      END IF                                                     
#NO.FUN-710050--END 
      IF g_chr='N' THEN CONTINUE FOREACH END IF
      #----97/08/29 modify
      IF l_ooaconf = 'Y' THEN CONTINUE FOREACH END IF
   #LET l_t1 = l_ooa01[1,3]
    LET l_t1 = s_get_doc_no(l_ooa01)  #FUN-560095
    LET l_ooydmy1= ''
    SELECT ooydmy1 INTO l_ooydmy1 FROM ooy_file
     WHERE ooyslip = l_t1
    IF STATUS THEN 
#      CALL cl_err('sel ooy',STATUS,0)   #No.FUN-660116
#      CALL cl_err3("sel","ooy_file",l_t1,"",STATUS,"","sel ooy",1)  #No.FUN-660116 #NO.FUN-710050
       CALL s_errmsg('ooyslip',l_t1,'sel ooy',STATUS,0)            #NO.FUN-710050   #No.TQC-740094
    END IF
     IF l_ooydmy1 = 'Y' THEN
       #CALL s_t400_gl(l_ooa01)         #No.FUN-670047 mark
        CALL s_t400_gl(l_ooa01,'0')     #No.FUN-670047 add
        IF g_aza.aza63='Y' THEN         #No.FUN-670047 add
           CALL s_t400_gl(l_ooa01,'1')  #No.FUN-670047 add
        END IF                          #No.FUN-670047 add
     END IF
   END FOREACH
#NO.FUN-710050--BEGIN                                                           
   IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
   END IF                                                                          
   CALL s_showmsg()               
#NO.FUN-710050--END
   IF g_success='Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF #no.5573
   MESSAGE ""
END FUNCTION
 
FUNCTION t410_b_more()
  DEFINE l_ima25          LIKE ima_file.ima25   #No.FUN-680123  VARCHAR(4)
  DEFINE ls_tmp           STRING
    LET p_row = 12 LET p_col = 10
    OPEN WINDOW t4005_w AT p_row,p_col WITH FORM "axr/42f/axrt4005"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4005")
 
   #INPUT BY NAME b_oob.oob11,b_oob.oob12,b_oob.oob13    #No.FUN-670047 mark
    INPUT BY NAME b_oob.oob11,b_oob.oob111,b_oob.oob12,b_oob.oob13    #No.FUN-670047 add
                  WITHOUT DEFAULTS
    CLOSE WINDOW t4005_w                 #結束畫面
    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
END FUNCTION
 
FUNCTION t410_m()
   IF g_ooa.ooa01 IS NULL THEN RETURN END IF
   IF NOT cl_chk_act_auth()
      THEN LET g_chr='d'
      ELSE LET g_chr='u'
   END IF
   CALL s_axm_memo(g_ooa.ooa01,0,g_chr)
END FUNCTION
 
#FUN-580154
#FUNCTION t410_y()                   # when g_ooa.ooaconf='N' (Turn to 'Y')
FUNCTION t410_y_chk()                # when g_ooa.ooaconf='N' (Turn to 'Y')
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123  SMALLINT
 #MOD-940420  --begin 
   DEFINE l_oma00    LIKE oma_file.oma00   
   DEFINE l_apa00    LIKE apa_file.apa00   
   DEFINE l_sql      STRING               
   DEFINE l_oob      RECORD      
             oob03    LIKE oob_file.oob03,
             oob04    LIKE oob_file.oob04,
             oob06    LIKE oob_file.oob06
                     END RECORD  
 #MOD-940420  --end

   DEFINE l_nmg25   LIKE nmg_file.nmg25  #No:140620
   DEFINE l_oob10   LIKE oob_file.oob10  #No:140620
   DEFINE l_tc_nme05 LIKE tc_nme_file.tc_nme05 #No:140620
   
   LET g_success = 'Y'
 
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      LET g_success = 'N'
      RETURN
   END IF
  #FUN-550049
 
   IF g_ooa.ooaconf = 'Y' THEN
      CALL cl_err('','axr-101',0)
      LET g_success = 'N'
      RETURN
   END IF
 
#  IF g_ooa.ooamksg = "Y" THEN
#     IF g_ooa.ooa34 != "1" THEN
#        CALL cl_err("","aws-078",0)
#        LET g_success = 'N'
#        RETURN
#     END IF
#  END IF
  #END FUN-550049
 
   IF g_ooa.ooa32d != g_ooa.ooa32c THEN
      CALL cl_err('','axr-203',0)
      LET g_success = 'N'
      RETURN
   END IF
 
#FUN-B50090 add begin-------------------------
#重新抓取關帳日期
   LET g_sql ="SELECT ooz09 FROM ooz_file ",
              " WHERE ooz00 = '0'"
   PREPARE t600_ooz09_p FROM g_sql
   EXECUTE t600_ooz09_p INTO g_ooz.ooz09
#FUN-B50090 add -end--------------------------
   IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
      CALL cl_err('','axr-164',0)
      LET g_success = 'N'
      RETURN
   END IF
 
   IF g_ooa.ooaconf = 'Y' THEN
      LET g_success = 'N'
      RETURN
   END IF
 
   #bugno:7341 add......................................................
   SELECT COUNT(*) INTO l_cnt FROM oob_file
    WHERE oob01 = g_ooa.ooa01
   IF l_cnt = 0 THEN
      CALL cl_err('','mfg-009',0)
      LET g_success = 'N'                      #FUN-640246
      RETURN
   END IF
   #bugno:7341 end......................................................
 
#MOD-940420  --begin   
   LET l_sql = "SELECT oob03,oob04,oob06 FROM oob_file",
               " WHERE oob01 = '",g_ooa.ooa01,"'",
               "   AND ((oob03 = '1' AND (oob04='3' OR oob04='9'))",   
               "    OR  (oob03 = '2' AND (oob04='1' OR oob04='9')))"   
   PREPARE oob06_pb FROM l_sql
   DECLARE oob06_cl CURSOR FOR oob06_pb                                 
                        
   FOREACH oob06_cl INTO l_oob.*
      IF STATUS THEN 
         CALL cl_err('Foreach:',STATUS,1)
         LET g_success = 'N'
         EXIT FOREACH 
      END IF

      IF l_oob.oob03='1' THEN                         
         IF l_oob.oob04 = '3' THEN 
            SELECT oma00 INTO l_oma00 FROM oma_file
             WHERE oma01 = l_oob.oob06
  #          IF (l_oma00 != '21') AND (l_oma00 != '22') AND (l_oma00 !='23') AND (l_oma00 != '24') THEN   #MOD-9B0043 add 23     #TQC-B10005 mark     
             IF (l_oma00 != '21') AND (l_oma00 != '22') AND (l_oma00 !='23') AND (l_oma00 != '24') AND (l_oma00 != '26') AND (l_oma00 != '27') THEN      #TQC-B10005
               CALL cl_err(l_oob.oob06,'axr-992',0)
               LET g_success = 'N'
               EXIT FOREACH                
            END IF

            #No：-------140620--------------------
            SELECT nmg25 INTO l_nmg25 FROM nmg_file WHERE nmg00=l_oob.oob06 
            IF cl_null(l_nmg25) THEN LET l_nmg25=0 END IF 

            IF l_nmg25>0 THEN
                select sum(tc_nme05) INTO l_tc_nme05 from tc_nmg_file,tc_nme_file 
                    where tc_nmg01=tc_nme01 and tc_nmg05='Y' and tc_nmg06=l_oob.oob06

                IF cl_null(l_tc_nme05) THEN LET l_tc_nme05=0 END IF 

                select sum(oob10) INTO l_oob10 from oob_file,ooa_file 
                    where oob01=ooa01 and  ooa37='2'
                    and not ooa03 is null and oob11 in ('113101','113102','218110') 
                    and oob04='3' and oob03='1' and oob06=l_oob.oob06

                IF cl_null(l_oob10) THEN LET l_oob10=0 END IF  

                IF l_nmg25<(l_tc_nme05+l_oob10) THEN
                   CALL cl_err('退款金额超过收支单未回款金额','!',0)
                   LET g_success = 'N'
                   EXIT FOREACH                      
                END IF 

            END IF 

            #-------140620---------------------
           
         END IF 
         IF l_oob.oob04 = '9' THEN 
            SELECT apa00 INTO l_apa00 FROM apa_file
             WHERE apa01 = l_oob.oob06
            IF (l_apa00 != '11') AND (l_apa00 != '12') AND (l_apa00 != '15') THEN 
               CALL cl_err(l_oob.oob06,'axr-993',0)
               LET g_success = 'N'
               EXIT FOREACH            
            END IF   
         END IF                
      END IF      
              
      IF l_oob.oob03='2' THEN
         IF l_oob.oob04 = '1' THEN 
            SELECT oma00 INTO l_oma00 FROM oma_file
             WHERE oma01 = l_oob.oob06
            IF (l_oma00 !='11') AND (l_oma00 !='12') AND
               (l_oma00 !='13') AND (l_oma00 !='14') THEN 
               CALL cl_err(l_oob.oob06,'axr-994',0)
               LET g_success = 'N'
               EXIT FOREACH            
            END IF 
         END IF 
         IF l_oob.oob04 = '9' THEN 
            SELECT apa00 INTO l_apa00 FROM apa_file
             WHERE apa01 = l_oob.oob06
#No.MOD-B50249 --begin
            IF l_apa00 NOT MATCHES '2*' THEN 
#           IF (l_apa00 !='21') AND (l_apa00 !='22') AND
#              (l_apa00 !='23') AND (l_apa00 !='24') THEN 
#No.MOD-B50249 --end
               CALL cl_err(l_oob.oob06,'axr-995',0)
               LET g_success = 'N'
               EXIT FOREACH          
            END IF   
         END IF                    
      END IF    
   END FOREACH 
   IF g_success = 'N' THEN RETURN END IF
#MOD-940420  --end 
END FUNCTION
 
FUNCTION t410_y_upd()
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123  SMALLINT
   DEFINE l_oob07  LIKE oob_file.oob07 #add by shijl 161223
   DEFINE l_oob08  LIKE oob_file.oob08 #add by shijl 161223
   DEFINE l_sum_oob09  LIKE oob_file.oob09 #add by shijl 161223
   DEFINE l_sum_oob10  LIKE oob_file.oob10 #add by shijl 161223   
   
   LET g_success = 'Y'
 
   IF g_action_choice CLIPPED = "confirm"  #執行 "確認" 功能(非簽核模式呼叫)
   OR g_action_choice CLIPPED = "insert"   #FUN-640246
   THEN
       #FUN-8A0075--BEGIN--
       IF g_action_choice="confirm" THEN 
          IF g_ooa.ooamksg='Y' THEN
             IF g_ooa.ooa34 NOT matches '[Ss1]' THEN
                   CALL cl_err('','aws-045',1)
                   LET g_success = 'N'
                   RETURN
             END IF
          END IF
       #FUN-8A0075--END-- 
       ELSE
         IF g_ooa.ooamksg='Y' THEN       #若簽核碼為 'Y' 且狀態碼不為 '1' 已同意
             IF g_ooa.ooa34 != '1' THEN
                CALL cl_err('','aws-078',1)
                LET g_success = 'N'
                RETURN
             END IF
         END IF
       END IF  #FUN-8A0075
       IF NOT cl_confirm('axr-108') THEN
          LET g_success = 'N'
          RETURN
       END IF #詢問是否執行確認功能
   END IF
 
   IF g_ooz.ooz62='Y' THEN
      #03/07/16 By Wiky #No:7616 oob15 = ' '為數值type,要拿掉oracle會產生錯!
      SELECT COUNT(*) INTO l_cnt FROM oob_file
       WHERE oob01 = g_ooa.ooa01
         AND oob03 = '2'
         AND oob04 = '1'
         AND (oob06 IS NULL OR oob06 = ' ' OR oob15 IS NULL OR oob15 <= 0 )
 
      IF cl_null(l_cnt) THEN
         LET l_cnt = 0
      END IF
 
      IF l_cnt > 0 THEN
         CALL cl_err('','axr-900',0)
         LET g_success = 'N'
         RETURN
      END IF
   END IF
 
   #No.+043 010402 by plum add
   LET g_cnt = 0
 
   SELECT COUNT(*) INTO g_cnt
     FROM oob_file,oma_file
  #str MOD-880174 mod
  # WHERE ( YEAR(oma02) > YEAR(g_ooa.ooa02)
  #    OR (YEAR(oma02) = YEAR(g_ooa.ooa02)
  #   AND MONTH(oma02) > MONTH(g_ooa.ooa02)) )
    WHERE oma02 > g_ooa.ooa02
  #end MOD-880174 mod
      AND oob03 = '2'
      AND oob04 = '1'
      AND oob06 = oma01
      AND oob01 = g_ooa.ooa01
 
   IF g_cnt >0 THEN
      CALL cl_err(g_ooa.ooa01,'axr-371',1)
      LET g_success = 'N'
      RETURN
   END IF
   #No.+043 ..end
 
   #---97/05/26 modify 檢查存在且平衡
#  IF g_ooy.ooydmy1 = 'Y' THEN  #No.FUN-670060 mark
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'N' THEN  #No.FUN-670060
     #CALL s_chknpq(g_ooa.ooa01,'AR',1)   #-->NO:0151   #No.FUN-670047 mark
     #CALL s_chknpq(g_ooa.ooa01,'AR',1,'0')                 #No.FUN-670047 add
      CALL s_chknpq(g_ooa.ooa01,'AR',1,'0',g_bookno1)       #No.FUN-730073
      IF g_aza.aza63='Y' AND g_success='Y' THEN             #No.FUN-670047 add  #No.TQC-6C0072 add g_success
#        CALL s_chknpq(g_ooa.ooa01,'AR',1,'1')              #No.FUN-670047 add
#         CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno1)    #No.FUN-730073   #No.TQC-740145
         CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno2)    #No.TQC-740145 
      END IF                                                #No.FUN-670047 add
     #LET g_dbs_new = g_dbs CLIPPED,":"   #MOD-6B0136 #TQC-950020   
      LET g_dbs_new = s_dbstring(g_dbs CLIPPED)  #TQC-950020    
   END IF
 
   IF g_success = 'N' THEN
      RETURN
   END IF
   #----
 
   BEGIN WORK
 
   OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
   IF STATUS THEN
      CALL cl_err("OPEN t410_cl:", STATUS, 1)
      LET g_success = 'N'
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t410_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       LET g_success = 'N'
       CLOSE t410_cl
       ROLLBACK WORK
       RETURN
   END IF
 
   #-----No.FUN-540046-----
#FUN-550049
#   IF g_ooa.ooamksg = 'Y' AND g_ooa.ooaconf = 'N' THEN
#     CALL t410_ef()
#   ELSE
#      IF g_ooa.ooamksg = 'N' THEN
        LET g_ooa.ooa34 = '1'
#      END IF
#   END IF
#END FUN-550049
 
   UPDATE ooa_file SET ooa34 = g_ooa.ooa34 WHERE ooa01 = g_ooa.ooa01
   IF STATUS THEN
      LET g_success = 'N'
   END IF
   #-----No.FUN-540046 END-----

   #add by shijl 161223--str-- 
   #添加记录回款明细
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM oob_file 	WHERE oob01=g_ooa.ooa01 AND oob03= '1' AND oob04= '3' 
   IF l_cnt > 0 THEN
      INITIALIZE g_tc_hka.* TO NULL   
      LET l_oob07 = g_ooa.ooa23 
      LET l_oob08 = g_ooa.ooa24 
      SELECT DISTINCT oob07,oob08 INTO l_oob07,l_oob08 FROM oob_file 
                   WHERE oob01=g_ooa.ooa01  AND oob03= '1' AND oob04= '3'
      SELECT nvl(SUM(oob09),0),nvl(SUM(oob10),0) INTO l_sum_oob09,l_sum_oob10 FROM oob_file 
                   WHERE oob01=g_ooa.ooa01  AND oob03= '1' AND oob04= '3'
      LET g_tc_hka.tc_hka01=  '6'           #来源  1.收支单，2.应收票据，3.收款调账，4.加盟商垫付款，5.借款承诺书，6.退款  key not null
      LET g_tc_hka.tc_hka02=  '1'           #方向  1.收款（调账转入金额以正数显示，调整转出金额以负数显示；退款金额以负数显示）
                                            #     -1.回款（回款金额以正数显示，红冲金额以负数显示）    key  not null
      LET g_tc_hka.tc_hka03=  g_ooa.ooa01   #来源单据单号       key  not null
      LET g_tc_hka.tc_hka04=  g_ooa.ooa02   #来源单据日期       
      LET g_tc_hka.tc_hka05=  l_oob07   #来源单据币种         
      LET g_tc_hka.tc_hka06=  l_oob08   #来源单据汇率         
      LET g_tc_hka.tc_hka07=  l_sum_oob09*-1  #来源单据原币金额       
      LET g_tc_hka.tc_hka08=  l_sum_oob10*-1  #来源单据本币金额       
      LET g_tc_hka.tc_hka09=  ' '           #cxmt100回款单号    key   not null
      LET g_tc_hka.tc_hka10=  g_ooa.ooa03   #cxmt100客户编号    key   not null   
      LET g_tc_hka.tc_hka11=  ' '           #cxmt100订单单号    key   not null
      LET g_tc_hka.tc_hka12=  ''            #cxmt100类型         
      LET g_tc_hka.tc_hka13=  0             #cxmt100原币回款金额     
      LET g_tc_hka.tc_hka14=  0             #cxmt100本币回款金额     
      LET g_tc_hka.tc_hka15=  'N'           #cxmt100红冲         
      
      INSERT INTO tc_hka_file VALUES(g_tc_hka.*)
      IF STATUS OR SQLCA.SQLCODE THEN
         CALL cl_err3("ins","tc_hka_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","ins tc_hka",1)
         LET g_success='N'
      END IF  
   END IF 
   #add by shijl 161223--end--    
  
   CALL t410_y1()
 
#   IF g_success = 'Y' THEN
#      LET g_ooa.ooaconf = 'Y'
#      COMMIT WORK
#      DISPLAY BY NAME g_ooa.ooaconf
#      DISPLAY BY NAME g_ooa.ooa34  #FUN-540046
#      CALL cl_flow_notify(g_ooa.ooa01,'Y')
      #----97/06/19 modify
      #  DELETE FROM npp_file WHERE npp01 = g_ooa.ooa01
      #  DELETE FROM npq_file WHERE npq01 = g_ooa.ooa01
      #  CALL s_t400_gl(g_ooa.ooa01)
#   ELSE
#      LET g_ooa.ooaconf = 'N'
#      LET g_ooa.ooa34   = 'N'
#      ROLLBACK WORK
#   END IF
 
#   IF g_ooa.ooaconf = 'X' THEN
#      LET g_chr = 'Y'
#   ELSE
#      LET g_chr = 'N'
#   END IF
 
    #No.FUN-670060 --begin--
    IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN
       SELECT COUNT(*) INTO l_cnt FROM npq_file 
        WHERE npq01= g_ooa.ooa01
          AND npq00= 3  
          AND npqsys= 'AR'  
          AND npq011= 1
       IF l_cnt = 0 THEN
          CALL t410_gen_glcr(g_ooa.*,g_ooy.*)
       END IF
       IF g_success = 'Y' THEN 
         #CALL s_chknpq(g_ooa.ooa01,'AR',1)     #No.FUN-670047  mark
         #CALL s_chknpq(g_ooa.ooa01,'AR',1,'0')                 #No.FUN-670047 add
          CALL s_chknpq(g_ooa.ooa01,'AR',1,'0',g_bookno1)       #No.FUN-730073
          IF g_aza.aza63='Y' AND g_success='Y' THEN             #No.FUN-670047 add  #No.TQC-6C0072 add g_success
 #           CALL s_chknpq(g_ooa.ooa01,'AR',1,'1')              #No.FUN-670047 add
#             CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno1)    #No.FUN-730073  #No.TQC-740145
             CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno2)    #No.TQC-740145
          END IF                                                #No.FUN-670047 add
         #LET g_dbs_new = g_dbs CLIPPED,":"   #MOD-6B0136 #TQC-950020 
          LET g_dbs_new = s_dbstring(g_dbs CLIPPED) #TQC-950020   
       END IF
       IF g_success = 'N' THEN 
          ROLLBACK WORK   #No.TQC-810086
          RETURN 
       END IF  #No.FUN-670047
    END IF
    #No.FUN-670060 --end--  
 
    IF g_success = 'Y' THEN
       IF g_ooa.ooamksg = 'Y' THEN #簽核模式
          CASE aws_efapp_formapproval()#呼叫 EF 簽核功能
               WHEN 0  #呼叫 EasyFlow 簽核失敗
                    LET g_ooa.ooaconf="N"
                    LET g_success = "N"
                    ROLLBACK WORK
                    RETURN
               WHEN 2  #當最後一關有兩個以上簽核者且此次簽核完成後尚未結案
                    LET g_ooa.ooaconf="N"
                    ROLLBACK WORK
                    RETURN
          END CASE
       END IF
#      CALL s_showmsg()                    #NO.FUN-710050  #No.TQC-740094
       IF g_success='Y' THEN
          LET g_ooa.ooa34='1'              #執行成功, 狀態值顯示為 '1' 已核准
          LET g_ooa.ooaconf='Y'              #執行成功, 確認碼顯示為 'Y' 已確認
          DISPLAY BY NAME g_ooa.ooaconf
          DISPLAY BY NAME g_ooa.ooa34
          COMMIT WORK
          CALL cl_flow_notify(g_ooa.ooa01,'Y')
       ELSE
          LET g_ooa.ooaconf='N'
          LET g_success = 'N'
          ROLLBACK WORK
       END IF
    ELSE
       LET g_ooa.ooaconf='N'
       LET g_success = 'N'
       ROLLBACK WORK
    END IF
 
    CALL t410_b_fill('1=1')   #No.MOD-530820
    CALL t410_b_fill_2('1=1') #FUN-A90003 Add
    
 
  SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
 
  #No.FUN-670060 --begin--
  IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
     LET g_wc_gl = 'npp01 = "',g_ooa.ooa01,'" AND npp011 = 1'
#    LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",g_ooa.ooa02,"' 'Y' '0' 'Y'"   #No.FUN-670047
    #LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",g_ooa.ooa02,"' 'Y' '0' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"   #No.FUN-670047  #No.MOD-860075
     LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",g_ooa.ooa02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"   #No.FUN-670047  #No.MOD-860075
     CALL cl_cmdrun_wait(g_str)
     SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
      WHERE ooa01 = g_ooa.ooa01
     DISPLAY BY NAME g_ooa.ooa33
  END IF
  #No.FUN-670060 --end--
 
  #FUN-550049
  IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
# IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  IF g_ooa.ooa34='1' OR
     g_ooa.ooa34='2' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  IF g_ooa.ooa34='6' THEN LET g_chr3='Y' ELSE LET g_chr3='N' END IF
# CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
  CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"",g_chr3,g_chr,"")
  ## END FUN-550049 ##
 
END FUNCTION
#FUN-580154 End
 
#-----No.FUN-540046-----
#FUN-550049
FUNCTION t410_ef()
#FUN-580154
   CALL t410_y_chk()          #CALL 原確認段的 check 段後在執行送簽
   IF g_success = "N" THEN
       RETURN
   END IF
#FUN-580154 End
 
   CALL aws_condition()#判斷送簽資料
   IF g_success = 'N' THEN
         RETURN
   END IF
##########
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########
 
   IF aws_efcli2(base.TypeInfo.create(g_ooa),base.TypeInfo.create(g_oob),'','','','')
   THEN
      LET g_success = 'Y'
      LET g_ooa.ooa34 = 'S'
      DISPLAY BY NAME g_ooa.ooa34
   ELSE
      LET g_success = 'N'
   END IF
 
END FUNCTION
 
#-----No.FUN-540046 END-----
 
FUNCTION t410_z()                   # when g_ooa.ooaconf='Y' (Turn to 'N')
 DEFINE  l_n            LIKE type_file.num5      #No.FUN-680123 SMALLINT
 DEFINE  l_aba19        LIKE aba_file.aba19   #No.FUN-670060
 DEFINE  l_dbs          STRING                #No.FUN-670060
 DEFINE  l_sql          STRING                #No.FUN-670060
 DEFINE  l_cnt          LIKE type_file.num5   #No.FUN-A40054

   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
 
   #-----No.FUN-540046-----
   IF g_ooa.ooa34 = "S" THEN
      CALL cl_err("","mfg3557",0)
      RETURN
   END IF
   #-----No.FUN-540046 END-----
 
   #FUN-960141 add 自動生成的資料不可取消審核
   IF g_ooa.ooa38<>"2" THEN
      CALL cl_err("","axr-360",0)
      RETURN
   END IF     
   #FUN-960141 end
 
   IF g_ooa.ooaconf='N' THEN RETURN END IF
#FUN-B50090 add begin-------------------------
#重新抓取關帳日期
   LET g_sql ="SELECT ooz09 FROM ooz_file ",
              " WHERE ooz00 = '0'"
   PREPARE t600_ooz09_p1 FROM g_sql
   EXECUTE t600_ooz09_p1 INTO g_ooz.ooz09
#FUN-B50090 add -end--------------------------
   IF g_ooa.ooa02<=g_ooz.ooz09 THEN CALL cl_err('','axr-164',0) RETURN END IF
   IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
   END IF
   #No.FUN-690090--begin
   IF NOT cl_null(g_ooa.ooa992) THEN
      CALL cl_err('','axr-950',1)
      LET g_success='N'
      RETURN
   END IF
   #No.FUN-690090--end  

  #No.FUN-A40054 -BEGIN-----
   SELECT COUNT(*) INTO l_cnt FROM oob_file
    WHERE oob01 = g_ooa.ooa01
      AND oob20 = 'Y'
   IF l_cnt > 0 THEN
      CALL cl_err('','axr-840',0)
      LET g_success = 'N'
      RETURN
   END IF
  #No.FUN-A40054 -END-------
 
   #No.FUN-670060 --begin--
   #取消確認時，若單據別設為"系統自動拋轉總帳",則可自動拋轉還原
   CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1 
   SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
   IF NOT cl_null(g_ooa.ooa33) THEN
      IF NOT (g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y') THEN
         CALL cl_err(g_ooa.ooa01,'axr-370',0) RETURN
      END IF
   END IF
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN
      #LET g_plant_new=g_ooz.ooz02p 
      #CALL s_getdbs() LET l_dbs=g_dbs_new
      #LET g_dbs_new = l_dbs_new
      #LET l_dbs=l_dbs.trimRight()                                                                                                    
      #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
      LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102
                  "  WHERE aba00 = '",g_ooz.ooz02b,"'",
                  "    AND aba01 = '",g_ooa.ooa33,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql #FUN-A50102
      PREPARE aba_pre FROM l_sql
      DECLARE aba_cs CURSOR FOR aba_pre
      OPEN aba_cs
      FETCH aba_cs INTO l_aba19
      IF l_aba19 = 'Y' THEN
         CALL cl_err(g_ooa.ooa33,'axr-071',1)
         RETURN
      END IF
   END IF
   #No.FUN-670060 --end--   
 
   IF NOT cl_confirm('axr-109') THEN RETURN END IF
   #-----97/05/26 modify 傳票編號不為空白,show警告訊息
 
#No.FUN-670060 --start-- mark
#  IF NOT cl_null(g_ooa.ooa33) THEN
#     CALL cl_err(g_ooa.ooa01,'axr-310',0)
#     RETURN
#  END IF
#No.FUN-670060 --end--
 
   BEGIN WORK LET g_success = 'Y'
   OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
   IF STATUS THEN
      CALL cl_err("OPEN t410_cl:", STATUS, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t410_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       CLOSE t410_cl ROLLBACK WORK RETURN
   END IF
   CALL t410_z1()
 
   #add by shijl 161222--str--
   #添加删除回款明细记录 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM oob_file 	WHERE oob01=g_ooa.ooa01 AND oob03= '1' AND oob04= '3' 
   IF l_cnt > 0 THEN    
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM tc_hka_file 
                WHERE tc_hka01 ='6' AND tc_hka02='1' AND tc_hka03 = g_ooa.ooa01 
                  AND tc_hka09 = ' ' AND tc_hka11 = ' ' AND tc_hka10=  g_ooa.ooa03 
      IF cl_null(l_cnt) THEN LET l_cnt=0 END IF
      IF l_cnt > 0 THEN
         DELETE FROM tc_hka_file WHERE tc_hka01 ='6' AND tc_hka02='1' AND tc_hka03 = g_ooa.ooa01 
                                   AND tc_hka09 = ' ' AND tc_hka11 = ' ' AND tc_hka10 = g_ooa.ooa03
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            CALL s_errmsg('tc_hka',g_ooa.ooa01,'del tc_hka_file',SQLCA.SQLCODE,1)
            LET g_success='N'
         END IF        
      END IF 
   END IF 
   #add by shijl 161222--end--  
   #-----No.FUN-540046-----
   UPDATE ooa_file SET ooa34 = '0' WHERE ooa01 = g_ooa.ooa01
   IF STATUS THEN
#     CALL cl_err('upd ooa',STATUS,1)   #No.FUN-660116
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",STATUS,"","upd ooa",1)  #No.FUN-660116
      LET g_success='N'
   END IF
   #-----No.FUN-540046 END-----
   CALL s_showmsg()                 #NO.FUN-710050
   IF g_success = 'Y' THEN
      LET g_ooa.ooaconf = 'N'
      LET g_ooa.ooa34 = "0"
      DISPLAY BY NAME g_ooa.ooaconf
      DISPLAY BY NAME g_ooa.ooa34
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF
 
   #No.FUN-670060 --begin--
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
      LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooa.ooa33,"' 'Y'"
      CALL cl_cmdrun_wait(g_str)
      SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
       WHERE ooa01 = g_ooa.ooa01
      DISPLAY BY NAME g_ooa.ooa33
   END IF
   #No.FUN-670060 --end--   
 
   #CKP
  #FUN-550049
  IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
  IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
  ## END FUN-550049 ##
  CALL t410_show()  #TQC-750177
END FUNCTION
 
FUNCTION t410_y1()
   DEFINE n       LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_cnt   LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_flag  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
  #No.MOD-B30389--add--str--
   DEFINE l_se    LIKE type_file.chr1   
   DEFINE l_oob06 LIKE oob_file.oob06  
   DEFINE l_oma00 LIKE oma_file.oma00
  #No.MOD-B30389--add--end

   UPDATE ooa_file SET ooaconf = 'Y',ooa34 = '1' WHERE ooa01 = g_ooa.ooa01  #No.TQC-9C0057
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#     CALL cl_err('upd ooaconf',SQLCA.SQLCODE,1)   #No.FUN-660116
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)  #No.FUN-660116
      LET g_success = 'N'
      RETURN
   END IF
 
   CALL t410_hu2()
 
   IF g_success = 'N' THEN
      RETURN
   END IF      #更新 ??/??
 
   #MOD-B30389--add--str--借方待抵是否都為24:暫收單據
   LET l_se = 'Y'
   DECLARE t410_oob06 CURSOR FOR SELECT oob06 FROM oob_file
                                  WHERE oob01 = g_ooa.ooa01
                                    AND oob03 = '1'
                                    AND oob04 = '3'
                                  ORDER BY oob02
   FOREACH t410_oob06 INTO l_oob06
       SELECT oma00 INTO l_oma00 FROM oma_file
        WHERE oma01 = l_oob06
       IF l_oma00<>'24' THEN
          LET l_se = 'N'
          EXIT FOREACH
       END IF 
   END FOREACH
   #MOD-B30389--add--end
   DECLARE t410_y1_c CURSOR FOR SELECT * FROM oob_file
                                 WHERE oob01 = g_ooa.ooa01
                                 ORDER BY oob02
 
   LET l_cnt = 1
   LET l_flag = '0'
   CALL s_showmsg_init()                     #NO.FUN-710050
   FOREACH t410_y1_c INTO b_oob.*         
      IF STATUS THEN
#        CALL cl_err('y1 foreach',STATUS,1)  #NO.FUN-710050
         CALL s_errmsg('oob01',g_ooa.ooa01,'y1 foreach',STATUS,1)  #NO.FUN-710050
         LET g_success = 'N'
         RETURN
      END IF 
#NO.FUN-710050--BEGIN                                                           
       IF g_success='N' THEN                                                    
         LET g_totsuccess='N'                                                   
         LET g_success='Y' 
       END IF                                                     
#NO.FUN-710050--END
 
#     LET g_plant_new = b_oob.oob05 CALL s_getdbs()
 
      IF l_flag = '0' THEN
         LET l_flag = b_oob.oob03
      END IF
 
      IF l_flag != b_oob.oob03 THEN
         LET l_cnt = l_cnt + 1
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '1' THEN
         CALL t410_bu_11('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '2' THEN
         CALL t410_bu_12('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '3' THEN
         CALL t410_bu_13('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '9' THEN
         CALL t410_bu_19('+')
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '1' THEN
         CALL t410_bu_21('+')
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '9' THEN
         CALL t410_bu_19('+')
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
         CALL t410_bu_22('+',l_cnt)
      END IF
 
      #FUN-960141 add begin
      IF b_oob.oob03 = '1' AND b_oob.oob04 = 'A' THEN
         #CALL t410_bu_1A('+')            #MOD-B30389   
         CALL t410_bu_1A('+',l_se)        #MOD-B30389
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = 'A' THEN
         CALL t410_bu_2A('+')   
      END IF
      #FUN-960141 add end
 
      LET l_cnt = l_cnt + 1
 
   END FOREACH
#NO.FUN-710050--BEGIN                                                           
  IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
  END IF                                                                          
#NO.FUN-710050--END
 
   #---------------------------------- 970124 roger A/P對沖->需自動產生apf,g,h
   #No.B184 010419 by plum mod 只要類別為9,就都INS AP:apf,g,h
   #SELECT COUNT(*) INTO n FROM oob_file
   #       WHERE oob01 = g_ooa.ooa01 AND oob03='1' AND oob04='9'
 
   SELECT COUNT(*) INTO n FROM oob_file
    WHERE oob01 = g_ooa.ooa01
      AND oob04 = '9'
 
   #No.B184 ..end
   IF n > 0 THEN
      CALL ins_apf()
   END IF
   #--------------------------------------------------------------------
   CALL s_showmsg()     #No.TQC-740094
 
END FUNCTION
 
FUNCTION t410_z1()
   DEFINE n      LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_flag LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   UPDATE ooa_file SET ooaconf = 'N',ooa34 = '0' WHERE ooa01 = g_ooa.ooa01  #No.TQC-9C0057
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#     CALL cl_err('upd ooaconf',SQLCA.SQLCODE,1)    #No.FUN-660116
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)  #No.FUN-660116
      LET g_success = 'N' 
      RETURN
   END IF
#  CALL t410_hu1() IF g_success = 'N' THEN RETURN END IF      #更新??/??
 
   #add 030311 NO.A048
   #因為在s_g_np時, 會取apf_file已確認的資料, 故在此應先將之還原
   SELECT COUNT(*) INTO n FROM oob_file
     WHERE oob01 = g_ooa.ooa01 AND oob04='9'
   IF n>0 THEN
      UPDATE apf_file SET apf41 = 'N' WHERE apf01 = g_ooa.ooa01
      IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#        CALL cl_err('upd apf41',SQLCA.SQLCODE,1)   #No.FUN-660116
         CALL cl_err3("upd","apf_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd apf41",1)  #No.FUN-660116
         LET g_success = 'N' 
         RETURN 
      END IF
   END IF
 
   DECLARE t410_z1_c CURSOR FOR
         SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 ORDER BY oob02
   LET l_cnt = 1
   LET l_flag = '0'
   CALL s_showmsg_init()                #NO.FUN-710050
   FOREACH t410_z1_c INTO b_oob.*
    IF STATUS THEN
#NO.FUN-710050--BEGIN                                                           
#      CALL cl_err('z1 foreach',STATUS,1) LET g_success = 'N' RETURN END IF #NO.FUN-710050
       CALL s_errmsg('oob01',g_ooa.ooa01,'z1 foreach',STATUS,1) 
       LET g_success = 'N' RETURN 
    END IF
    IF g_success='N' THEN                                                    
      LET g_totsuccess='N'                                                   
      LET g_success='Y' 
    END IF                                                     
#NO.FUN-710050--END  
#   LET g_plant_new = b_oob.oob05 CALL s_getdbs()
    IF l_flag = '0' THEN LET l_flag = b_oob.oob03 END IF
    IF l_flag != b_oob.oob03 THEN
       LET l_cnt = l_cnt + 1
    END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '1' THEN CALL t410_bu_11('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '2' THEN CALL t410_bu_12('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '3' THEN CALL t410_bu_13('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '9' THEN CALL t410_bu_19('-') END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '1' THEN CALL t410_bu_21('-') END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '9' THEN CALL t410_bu_19('-') END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
       CALL t410_bu_22('-',l_cnt)
    END IF
    #FUN-960141 add begin
    #IF b_oob.oob03 = '1' AND b_oob.oob04 = 'A' THEN CALL t410_bu_1A('-') END IF #MOD-B30389
    IF b_oob.oob03 = '1' AND b_oob.oob04 = 'A' THEN CALL t410_bu_1A('-','') END IF  #MOD-B30389
    IF b_oob.oob03 = '2' AND b_oob.oob04 = 'A' THEN CALL t410_bu_2A('-') END IF
    #FUN-960141 add end
    LET l_cnt = l_cnt + 1
   END FOREACH
#NO.FUN-710050--BEGIN                                                           
   IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
   END IF                                                                          
#NO.FUN-710050--END
   #---------------------------------- 970124 roger A/P對沖->需自動刪除apf,g,h
   #No.B184 010502 by plum mod 只要類別為9,就都INS AP:apf,g,h
   SELECT COUNT(*) INTO n FROM oob_file
    #WHERE oob01 = g_ooa.ooa01 AND oob03='1' AND oob04='9'
     WHERE oob01 = g_ooa.ooa01 AND oob04='9'
   #No.B184..end
   IF n>0 THEN CALL del_apf() END IF
   #--------------------------------------------------------------------
END FUNCTION
 
FUNCTION t410_hu2()            #最近交易日
   DEFINE l_occ RECORD LIKE occ_file.*
#   MESSAGE "hu2!"   #MOD-5B0012
   SELECT * INTO l_occ.* FROM occ_file WHERE occ01=g_ooa.ooa03
   IF STATUS THEN 
#     CALL cl_err('s ccc',STATUS,1)   #No.FUN-660116
      CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","s ccc",1)  #No.FUN-660116
      LET g_success='N' 
      RETURN 
   END IF
   IF l_occ.occ16 IS NULL THEN LET l_occ.occ16=g_ooa.ooa02 END IF
   IF l_occ.occ174 IS NULL OR l_occ.occ174 < g_ooa.ooa02 THEN
      LET l_occ.occ174=g_ooa.ooa02
   END IF
   UPDATE occ_file SET * = l_occ.* WHERE occ01=g_ooa.ooa03
  IF STATUS THEN 
#    CALL cl_err('u ccc',SQLCA.SQLCODE,1)   #No.FUN-660116
     CALL cl_err3("upd","occ_file",g_ooa.ooa03,"",SQLCA.sqlcode,"","u ccc",1)  #No.FUN-660116
     LET g_success='N' 
     RETURN
   END IF
END FUNCTION
 
FUNCTION t410_bu_11(p_sw)                   #更新應收票據檔 (nmh_file)
  DEFINE p_sw       LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),            # +:更新 -:還原
       l_nmh17      LIKE  nmh_file.nmh17,
       l_nmh38      LIKE  nmh_file.nmh38
  #add 030422 NO.A058
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE l_amt1,l_amt2 LIKE nmg_file.nmg25    #No.MOD-910126
 
#  MESSAGE "bu_11:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04    #MOD-5B0012
  #95/12/14 by danny 確認時,判斷此參考單號之單據是否已確認
  SELECT nmh17,nmh38 INTO l_nmh17,l_nmh38 FROM nmh_file WHERE nmh01=b_oob.oob06
  IF STATUS THEN LET l_nmh38 = 'N' END IF
  IF l_nmh38 != 'Y' THEN
#    CALL cl_err('','axr-194',1) LET g_success ='N' RETURN 
     CALL s_errmsg('nmh01',b_oob.oob06,' ','axr-194',1)   #NO.FUN-710050
  END IF
  ##add 030422 NO.A058
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz59 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     CALL s_g_np('4','1',b_oob.oob06,b_oob.oob15) RETURNING tot3
  ELSE
    #LET tot3 = 0  #No.MOD-910126 mark 
    #No.MOD-910126--begin--
    SELECT nmh32 INTO l_amt1 FROM nmh_file WHERE nmh01 = b_oob.oob06
    IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF 
    CALL cl_digcut(l_amt1,g_azi04) RETURNING l_amt1
    SELECT SUM(oob10) INTO l_amt2 FROM oob_file,ooa_file 
     WHERE ooa01 = oob01 AND ooaconf = 'Y' AND oob03 = '1' AND oob04 = '1'
       AND oob06 = b_oob.oob06
    IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
    LET tot3 = l_amt1 - l_amt2
    IF cl_null(tot3) THEN LET tot3 = 0 END IF
    #No.MOD-910126---end--- 
  END IF
 
  #@@@
  IF p_sw = '-' THEN
     ##modify 030422 NO.A058
     UPDATE nmh_file SET nmh17=nmh17-b_oob.oob09 ,nmh40 = tot3
      WHERE nmh01= b_oob.oob06
   # UPDATE nmh_file SET nmh17=nmh17-b_oob.oob09 WHERE nmh01= b_oob.oob06
     IF STATUS THEN
#       CALL cl_err('upd nmh17',STATUS,1)    #No.FUN-660116
#       CALL cl_err3("upd","nmh_file",b_oob.oob06,"",STATUS,"","upd nmh17",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17',STATUS,1)              #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
#       CALL cl_err('upd nmh17','axr-198',1) LET g_success = 'N' RETURN        #NO.FUN-710050
        CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17','axr-198',1) LET g_success = 'N' RETURN      #NO.FUN-710050
     END IF
  END IF
  IF p_sw = '+' THEN
     ##modify 030422 NO.A058
     UPDATE nmh_file SET nmh17=nmh17+b_oob.oob09 ,nmh40 = tot3
      WHERE nmh01= b_oob.oob06
    #UPDATE nmh_file SET nmh17=nmh17+b_oob.oob09 WHERE nmh01= b_oob.oob06
     IF STATUS THEN
#       CALL cl_err('upd nmh17',STATUS,1)    #No.FUN-660116
#       CALL cl_err3("upd","nmh_file",b_oob.oob06,"",STATUS,"","upd nmh17",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('nmh01',b_oob.oob06,'unp nmh17',STATUS,1)                          #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
#       CALL cl_err('upd nmh17','axr-198',1)  LET g_success = 'N' RETURN                            #NO.FUN-710050
        CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17','axr-198',1)  LET g_success = 'N' RETURN    #NO.FUN-710050
     END IF
  END IF
END FUNCTION
 
FUNCTION t410_bu_12(p_sw)             #更新TT檔 (nmg_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_nmg23        LIKE nmg_file.nmg23
  DEFINE l_nmg24        LIKE nmg_file.nmg24,
         l_nmg25        LIKE nmg_file.nmg25,        #bug NO:A053 by plum
         l_nmgconf      LIKE nmg_file.nmgconf,
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  DEFINE tot1,tot3,tot2 LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013 #bug NO:A053 by plum
  DEFINE l_nmz20        LIKE nmz_file.nmz20
  DEFINE l_str          STRING                      #FUN-640246
 
 #FUN-640246
 #MESSAGE "bu_12:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04
  LET l_str = "bu_12:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04
  CALL cl_msg(l_str) 
 #END FUN-640246
 
##No.2724 modify 1998/11/05 確認時,判斷此參考單號之單據是否已確認
  LET l_nmgconf = ' '
 #SELECT nmgconf INTO l_nmgconf    #bug NO:A053 by plum
  SELECT nmg25,nmgconf INTO l_nmg25,l_nmgconf
    FROM nmg_file WHERE nmg00= b_oob.oob06
  IF STATUS THEN LET l_nmgconf= 'N' END IF
  IF l_nmgconf != 'Y' THEN
#    CALL cl_err('','axr-194',1) LET g_success ='N' RETURN     #NO.FUN-710050
     CALL s_errmsg('nmg00',b_oob.oob06,'','axr-194',1)  LET g_success = 'N' RETURN    #NO.FUN-710050
  END IF
  IF cl_null(l_nmg25) THEN LET l_nmg25=0 END IF   #bug NO:A053 by plum
##--------------------------------------------------
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  SELECT COUNT(*) INTO l_cnt FROM oob_file
          WHERE oob01=b_oob.oob01
            AND oob02<b_oob.oob02
            AND oob03='1'
            AND oob04='2'
            AND oob06=b_oob.oob06
  IF l_cnt>0 THEN RETURN END IF
 
  LET tot1 = 0 LET tot2 = 0  #bug NO:A053 by plum
 #SELECT SUM(oob09) INTO tot1 FROM oob_file, ooa_file   #DSC:PLUM
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
          WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
            AND oob03='1'         AND oob04 = '2'
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF    #bug no:A053 by plum
  ##add by danny 020315 期末調匯(A008)
  SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz20 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     #modify 030226 NO.A048
     CALL s_g_np('3','',b_oob.oob06,b_oob.oob15) RETURNING tot3
  ELSE
     LET tot3 = 0
  END IF
 
  IF p_sw = '-' THEN
     UPDATE nmg_file SET nmg24 = tot1, nmg10 = tot3
      WHERE nmg00= b_oob.oob06
   #No.+041 010330 by plum
   #IF STATUS THEN CALL cl_err('upd nmg24',STATUS,1) RETURN END IF
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err('upd nmg24',SQLCA.SQLCODE,1)    #No.FUN-660116
#      CALL cl_err3("upd","nmg_file",b_oob.oob06,"",SQLCA.SQLCODE,"","upd nmg24",1)  #No.FUN-660116 #NO.FUN-710050
       CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24',SQLCA.SQLCODE,0)              #NO.FUN-710050
       RETURN
    END IF
   #No.+041..end
    RETURN
  END IF
  LET l_nmg24 =0
  SELECT nmg23,nmg23-nmg24 INTO l_nmg23,l_nmg24
    FROM nmg_file WHERE nmg00= b_oob.oob06
    IF STATUS THEN
#      CALL cl_err('sel nmg24',STATUS,1)    #No.FUN-660116
#      CALL cl_err3("sel","nmg_file",b_oob.oob06,"",STATUS,"","sel nmg24",1)  #No.FUN-660116 #NO.FUN-710050
       CALL s_errmsg('nmg00',b_oob.oob06,'sel nmg24',STATUS,1)              #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
    END IF
    IF l_nmg24 = 0  THEN
#      CALL cl_err('nmg24=0','axr-185',1) LET g_success='N' RETURN                                     #NO.FUN-710050
       CALL s_errmsg('nmg00',b_oob.oob06,'nmg24=0','axr-185',1) LET g_success='N' RETURN             #NO.FUN-710050
    END IF
# check 是否沖過頭了 ------------
    IF tot1>l_nmg23  THEN
#      CALL cl_err('','axr-258',1) LET g_success='N' RETURN      #NO.FUN-710050
       CALL s_errmsg('nmg00',b_oob.oob06,'','axr-258',1) LET g_success='N' RETURN                    #NO.FUN-710050
    END IF
    UPDATE nmg_file SET nmg24=tot1, nmg10 = tot3
     WHERE nmg00= b_oob.oob06
    IF STATUS THEN
#      CALL cl_err('upd nmg24',STATUS,1)    #No.FUN-660116
#      CALL cl_err3("upd","nmg_file",b_oob.oob06,"",STATUS,"","sel nmg24",1)   #No.FUN-660116 #NO.FUN-710050
       CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24',STATUS,1)               #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err('upd nmg24','axr-198',1) LET g_success = 'N' RETURN                           #NO.FUN-710050            
       CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24','axr-198',1) LET g_success = 'N' RETURN   #NO.FUN-710050
    END IF
END FUNCTION
 
FUNCTION t410_bu_13(p_sw)                  #更新待抵帳款檔 (oma_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_omaconf      LIKE oma_file.omaconf,   #No.FUN-680123 VARCHAR(1),            #
         l_omavoid      LIKE oma_file.omavoid,   #No.FUN-680123 VARCHAR(1),
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  #add 030226 NO.A048
  DEFINE l_oma00        LIKE oma_file.oma00
  DEFINE tot4,tot4t     LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #TQC-5B0171
  DEFINE tot5,tot6      LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #No.FUN-680022 add
  DEFINE tot8           LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #No.FUN-680022 add
  DEFINE l_omc10        LIKE omc_file.omc10,#No.FUN-680022 add
         l_omc11        LIKE omc_file.omc11,#No.FUN-680022 add
         l_omc13        LIKE omc_file.omc13 #No.FUN-680022 add
 
   #FUN-640246
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      DISPLAY "bu_13:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
   END IF
   #END FUN-640246
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  SELECT COUNT(*) INTO l_cnt FROM oob_file
          WHERE oob01=b_oob.oob01
            AND oob02<b_oob.oob02
            AND oob03='1'
            AND oob04='3'  #No.9047 add
            AND oob06=b_oob.oob06
  IF l_cnt>0 THEN RETURN END IF
 
 #SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
 #        WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
 #          AND oob03='1'
 #預防在收款沖帳確認前,多沖待抵貨款
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
   WHERE oob06=b_oob.oob06 AND oob01=ooa01
     AND oob03='1'  AND oob04 = '3' AND ooaconf='Y'     #No:9638
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
 #No.FUN-680022--begin-- add
  IF p_sw='+' THEN
     SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND oob19=b_oob.oob19
        AND oob03='1'  AND oob04 = '3' AND ooaconf='Y'     #No:9638
       IF cl_null(tot5) THEN LET tot5 = 0 END IF
       IF cl_null(tot6) THEN LET tot6 = 0 END IF
  END IF
 #No.FUN-680022--end-- add
 
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-560077 #No.CHI-6A0004
  CALL cl_digcut(tot1,t_azi04) RETURNING tot1    #No.CHI-6A0004
  CALL cl_digcut(tot2,g_azi04) RETURNING tot2    #No.CHI-6A0004
 
 #modify 030226 NO.A048(加oma00)
  LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t ",
            #"  FROM ",g_dbs_new CLIPPED,"oma_file",
            #"  FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
            "  FROM oma_file ", #FUN-A50102
            " WHERE oma01=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t410_bu_13_p1 FROM g_sql
  DECLARE t410_bu_13_c1 CURSOR FOR t410_bu_13_p1
  OPEN t410_bu_13_c1 USING b_oob.oob06
  #modify 030226 NO.A048
  FETCH t410_bu_13_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2
    IF p_sw='+' AND l_omavoid='Y' THEN
#      CALL cl_err(b_oob.oob06,'axr-103',0) LET g_success = 'N' RETURN #NO.FUN-710050
       CALL s_errmsg(' ',' ','b_oob.oob06','axr-103',1) LET g_success = 'N' RETURN   #NO.FUN-710050
    END IF
    IF p_sw='+' AND l_omaconf='N' THEN
#      CALL cl_err(b_oob.oob06,'axr-194',1) LET g_success='N' RETURN   #NO.FUN-710050
       CALL s_errmsg(' ',' ','b_oob.oob06','axr-104',1) LET g_success = 'N' RETURN   #NO.FUN-710050
    END IF
    IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
    IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
    #No.TQC-5B0171 --start--
    #取得衝帳單的待扺金額
    CALL t410_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4      #No.CHI-6A0004
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t    #No.CHI-6A0004
    #No.TQC-5B0171 --end--
{
    IF un_pay1 < tot1 OR un_pay2 < tot2 THEN
       CALL cl_err('un_pay<pay#1','axr-196',1) LET g_success = 'N' RETURN
    END IF
}
 
    #modify 030226 NO.A048
    IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
#      IF p_sw='+' AND (un_pay1 < tot1 OR un_pay2 < tot2) THEN
       IF p_sw='+' AND (un_pay1 < tot1+tot4 OR un_pay2 < tot2+tot4t) THEN   #TQC-5B0171
#      CALL cl_err('un_pay<pay#1','axr-196',1) LET g_success = 'N' RETURN   #NO.FUN-710050
       CALL s_errmsg(' ',' ','un_pay<pay#1','axr-196',1) LET g_success = 'N' RETURN   #NO.FUN-710050
       END IF
    END IF
 
    SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
     WHERE oob06=b_oob.oob06 AND oob01=ooa01  AND ooaconf = 'Y'
       AND oob03='1'  AND oob04 = '3'
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF
    	
    #No.FUN-680022--begin-- add
    IF p_sw='+' THEN
       SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file, ooa_file
        WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND oob19=b_oob.oob19
          AND ooaconf = 'Y' AND oob03='1'  AND oob04 = '3'
       IF cl_null(tot5) THEN LET tot5 = 0 END IF
       IF cl_null(tot6) THEN LET tot6 = 0 END IF
       
       SELECT omc10,omc11,omc13 INTO l_omc10,l_omc11,l_omc13 FROM omc_file 
        WHERE omc01=b_oob.oob06 AND omc02 = b_oob.oob19
       IF cl_null(l_omc10) THEN LET l_omc10=0 END IF
       IF cl_null(l_omc11) THEN LET l_omc11=0 END IF
       IF cl_null(l_omc13) THEN LET l_omc13=0 END IF
     END IF
    #No.FUN-680022--end-- add
 
    #add 030226 NO.A048
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       #取得未沖金額
       #CALL s_g_np('1',l_oma00,b_oob.oob06,b_oob.oob15) RETURNING tot3
       #No.9775
       CALL s_g_np('1',l_oma00,b_oob.oob06,0          ) RETURNING tot3
       #--
       #No.TQC-5B0171 --start--
       #未衝金額扣除待扺
       LET tot3 = tot3 - tot4t
       #No.TQC-5B0171 --end--
    ELSE
      #LET tot3 = 0 #bug no:A053 by plum
       #No.TQC-5B0171 --start--
       #LET tot3 = un_pay2 - tot2
       LET tot3 = un_pay2 - tot2 - tot4t
       #No.TQC-5B0171 --end--
    END IF
    #modify 030226 NO.A048
    #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"oma_file SET oma55=?,oma57=?,oma61=? ",
    #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
    LET g_sql="UPDATE oma_file ", #FUN-A50102
              " SET oma55=?,oma57=?,oma61=? ",
              " WHERE oma01=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
    PREPARE t410_bu_13_p2 FROM g_sql
    #No.FUN-680022--begin-- add
    #add upd omc_file
   #IF p_sw='+' THEN
   #   IF NOT cl_null(b_oob.oob19) THEN
   #      LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc10=?,omc11=?,omc13=? ",
   #                " WHERE omc01=? AND omc02=? "
   #      PREPARE t410_bu_13_p3 FROM g_sql
   #   END IF 
   #END IF
    #No.FUN-680022--end--add
    #No.TQC-5B0171 --start--
    LET tot1 = tot1 + tot4
    LET tot2 = tot2 + tot4t
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1        #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2        #No.CHI-6A0004
    #No.TQC-5B0171 --end--
    EXECUTE t410_bu_13_p2 USING tot1, tot2, tot3, b_oob.oob06  #NO.A048
    IF STATUS THEN
#      CALL cl_err('upd oma55,57',STATUS,1)   #No.FUN-660116
#      CALL cl_err3("upd","oma_file",b_oob.oob06,"",STATUS,"","upd oma55,57",1)  #No.FUN-660116   #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57',STATUS,1)              #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err('upd oma55,57','axr-198',1) LET g_success = 'N' RETURN  #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57','axr-198',1) LET g_success = 'N' RETURN   #NO.FUN-710050
    END IF
   #No.FUN-680022--begin-- add
    IF SQLCA.sqlcode = 0 THEN
      #CALL t410_omc(p_sw)      #No.MOD-930140 mark 
       CALL t410_omc(l_oma00)   #No.MOD-930140
    END IF
   #No.FUN-680022--end-- add
   ##No.FUN-680022--begin-- add
   #IF p_sw='+' THEN
   #   LET l_omc10 = l_omc10 + b_oob.oob09
   #   LET l_omc11 = l_omc11 + b_oob.oob10
   #   LET l_omc13 = l_omc13 - b_oob.oob10
   #   IF NOT cl_null(b_oob.oob19) THEN 
   #      EXECUTE t410_bu_13_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
   #      IF STATUS THEN
   #         CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1)
   #         LET g_success='N'
   #         RETURN
   #      END IF
   #   END IF
   #END IF
   #IF p_sw='-' THEN
   #   LET l_omc10 = l_omc10 - b_oob.oob09
   #   LET l_omc11 = l_omc11 - b_oob.oob10
   #   LET l_omc13 = l_omc13 + b_oob.oob10
   #   IF NOT cl_null(b_oob.oob19) THEN 
   #      EXECUTE t410_bu_13_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
   #      IF STATUS THEN
   #         CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1)
   #         LET g_success='N'
   #         RETURN
   #      END IF
   #   END IF
   #END IF
   ##No.FUN-680022--end-- add
END FUNCTION
 
FUNCTION t410_bu_19(p_sw)                   #更新 A/P 檔 (apa_file)
  DEFINE p_sw        LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_apa       RECORD LIKE apa_file.*
  DEFINE l_apc       RECORD LIKE apc_file.*   #No.FUN-680022 add
  DEFINE l_apz27     LIKE apz_file.apz27
  DEFINE l_tot       LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
 
  #FUN-640246
  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
     DISPLAY "bu_11:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
  END IF
  #END FUN-640246
 
  SELECT * INTO l_apa.* FROM apa_file WHERE apa01=b_oob.oob06
  IF STATUS THEN 
#    CALL cl_err('sel apa',STATUS,1)    #No.FUN-660116
#    CALL cl_err3("sel","apa_file",b_oob.oob06,"",STATUS,"","sel apa",1)  #No.FUN-660116 #NO.FUN-710050
     CALL s_errmsg('apa01',b_oob.oob06,'sel apa',STATUS,1)              #NO.FUN-710050
     LET g_success ='N' 
     RETURN 
  END IF
  IF l_apa.apa41 != 'Y' THEN
#    CALL cl_err('apa41<>Y','axr-194',1) LET g_success ='N' RETURN        #NO.FUN-710050
     CALL s_errmsg('apa01',b_oob.oob06,'apa41<>Y','axr-194',1) LET g_success ='N' RETURN   #NO.FUN-710050
  END IF
  ##add by danny 020315 期末調匯(A008)
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
  IF l_apz27 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     #modify 030311 NO.A048
     CALL s_g_np('2',l_apa.apa00,b_oob.oob06,b_oob.oob15) RETURNING tot
  ELSE
    #LET tot = 0  #bug no:A053 by plum
    # LET tot = l_apa.apa34 - l_apa.apa35     #No:9443
  END IF
  IF p_sw = '-' THEN
     LET l_apa.apa35f=l_apa.apa35f-b_oob.oob09
     LET l_apa.apa35 =l_apa.apa35 -b_oob.oob10
     #No.MOD-590440  --begin
     CALL t410_comp_oox(b_oob.oob06) RETURNING g_net
     LET tot = l_apa.apa34 - l_apa.apa35 + g_net    #No:9443
     #No.MOD-590440  --end
     UPDATE apa_file SET apa35f=l_apa.apa35f,
                         apa35 =l_apa.apa35,
                         apa73 = tot
               WHERE apa01= b_oob.oob06
     IF STATUS THEN
#       CALL cl_err('upd apa35,35f',STATUS,1)    #No.FUN-660116
#       CALL cl_err3("upd","apa_file",b_oob.oob06,"",STATUS,"","upd apa35,35f",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('apa01',b_oob.oob06,'upd apa35,35f',STATUS,1)              #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
#       CALL cl_err('upd apa35,35f','axr-198',1) LET g_success = 'N' RETURN #NO.FUN-710050
        CALL s_errmsg('apa01',b_oob.oob06,'upd apa35,35f','axr-198',1) LET g_success = 'N' RETURN    #NO.FUN-710050
     END IF
    #No.FUN-680022--begin-- add
     IF SQLCA.sqlcode = 0  THEN
        CALL t410_apc(p_sw)
     END IF
    #No.FUN-680022--begin-- add
  END IF
  IF p_sw = '+' THEN
     LET l_apa.apa35f=l_apa.apa35f+b_oob.oob09
     LET l_apa.apa35 =l_apa.apa35 +b_oob.oob10
     #No.MOD-590440  --begin
     CALL t410_comp_oox(b_oob.oob06) RETURNING g_net
     LET tot = l_apa.apa34 - l_apa.apa35 + g_net    #No:9443
     #No.MOD-590440  --end
     ##add by danny 020315 期末調匯(A008)
     IF l_apz27 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
        IF l_apa.apa35f>l_apa.apa34f OR l_apa.apa35 >l_apa.apa34 THEN
           #No.TQC-740094  --Begin
#          CALL cl_err('apa35>34','axr-190',1) LET g_success = 'N' RETURN
           CALL s_errmsg("apa35",l_apa.apa35,"apa35>apa34","axr-190",1)
           LET g_success = 'N'
           RETURN          
           #No.TQC-740094  --End  
        END IF
     END IF
     UPDATE apa_file SET apa35f=l_apa.apa35f,
                         apa35 =l_apa.apa35,
                         apa73 = tot
               WHERE apa01= b_oob.oob06
     IF STATUS THEN
#       CALL cl_err('upd apa35f,35',STATUS,1)    #No.FUN-660116
#       CALL cl_err3("upd","apa_file",b_oob.oob06,"",STATUS,"","upd apa35f,35",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('apa01',b_oob.oob06,'upd apa35f,35',STATUS,1)              #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err('upd apa35f,35','axr-198',1) LET g_success = 'N' RETURN
        CALL s_errmsg('apa01',b_oob.oob06,'upd apa35f,35','axr-198',1) LET g_success = 'N' RETURN #NO.FUN-710050
     END IF
    #No.FUN-680022--begin-- add
     IF SQLCA.sqlcode = 0  THEN
        CALL t410_apc(p_sw)
     END IF
    #No.FUN-680022--begin-- add
  END IF
END FUNCTION
 
FUNCTION t410_bu_21(p_sw)                  #更新應收帳款檔 (oma_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_omaconf      LIKE oma_file.omaconf,   #No.FUN-680123 VARCHAR(1),            #
         l_omavoid      LIKE oma_file.omavoid,   #No.FUN-680123 VARCHAR(1),
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  #add 030226 NO.A048
  DEFINE l_oma00        LIKE oma_file.oma00
  DEFINE l_omc   RECORD LIKE omc_file.*         #No.FUN-680022 add
  DEFINE l_omc10        LIKE omc_file.omc10     #No.FUN-680022 add
  DEFINE l_omc11        LIKE omc_file.omc11     #No.FUN-680022 add
  DEFINE l_omc13        LIKE omc_file.omc13     #No.FUN-680022 add
  DEFINE l_oob10        LIKE oob_file.oob10     #No.FUN-680022 add
  DEFINE l_oob09        LIKE oob_file.oob09     #No.FUN-680022 add
  DEFINE tot4,tot4t     LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)           #TQC-5B0171
  DEFINE tot5,tot6      LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)           #No.FUN-680022 add
 
  #FUN-640246
  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      DISPLAY "bu_21:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
  END IF
  #END FUN-640246
 
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  IF g_ooz.ooz62='Y' THEN
     SELECT COUNT(*) INTO l_cnt FROM oob_file
      WHERE oob01=b_oob.oob01
        AND oob02<b_oob.oob02
        AND oob03='2'
        AND oob04='1'   #98/07/23 modify
        AND oob06=b_oob.oob06 AND oob15 = b_oob.oob15
  ELSE
     SELECT COUNT(*) INTO l_cnt FROM oob_file
          WHERE oob01=b_oob.oob01
            AND oob02<b_oob.oob02
            AND oob03='2'
            AND oob19=b_oob.oob19       #No.FUN-680022
            AND oob06=b_oob.oob06
  END IF
  #IF l_cnt>0 THEN LET g_success = 'N' RETURN END IF
  IF l_cnt>0 THEN   #no:6100
#     CALL cl_err(b_oob.oob01,'axr-409',1)                #NO.FUN-710050
      LET g_showmsg=b_oob.oob06,"/",b_oob.oob01                           #NO.FUN-710050 
      CALL s_errmsg('oob06,oob01',g_showmsg,b_oob.oob01,'axr-409',1)      #NO.FUN-710050
      LET g_success = 'N'
      RETURN
  END IF
 
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
          WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
            AND oob03='2'
            AND oob04='1'   #98/07/23 modify
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF
    	
  #-----MOD-850008---------
  ##No.FUN-680022--begin-- add
  #IF p_sw='+' THEN
  #   SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file, ooa_file
  #           WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND oob19=b_oob.oob19 
  #             AND ooaconf='Y' AND oob03='2' AND oob04='1'  
  #     IF cl_null(tot5) THEN LET tot5 = 0 END IF
  #     IF cl_null(tot6) THEN LET tot6 = 0 END IF 
  #     
  #   SELECT omc10,omc11,omc13 INTO l_omc10,l_omc11,l_omc13 FROM omc_file
  #    WHERE omc01=b_oob.oob06 AND omc02=b_oob.oob19
  #   IF cl_null(l_omc10) THEN LET l_omc10=0 END IF
  #   IF cl_null(l_omc11) THEN LET l_omc11=0 END IF
  #   IF cl_null(l_omc13) THEN LET l_omc13=0 END IF 
  #END IF
  ##No.FUN-680022--end-- add
  #-----END MOD-850008-----
  
    SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-560077 #No.CHI-6A0004
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1         #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2         #No.CHI-6A0004
  #modify 030226 NO.A048(加oma00)
  LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t ",
            #"  FROM ",g_dbs_new,"oma_file",
            #"  FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
            "  FROM oma_file ",#FUN-A50102
            " WHERE oma01=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t410_bu_21_p1 FROM g_sql
  DECLARE t410_bu_21_c1 CURSOR FOR t410_bu_21_p1
  OPEN t410_bu_21_c1 USING b_oob.oob06
  #modify 030226 NO.A048(加oma00)
  FETCH t410_bu_21_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2
    IF p_sw='+' AND l_omavoid='Y' THEN
#      CALL cl_err(b_oob.oob06,'axr-103',3) LET g_success='N' RETURN #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-103',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
    END IF
    IF p_sw='+' AND l_omaconf='N' THEN
#      CALL cl_err(b_oob.oob06,'axr-194',3) LET g_success='N' RETURN #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
    END IF
    IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
    IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
    #No.TQC-5B0171 --start--
    #取得衝帳單的待扺金額
    CALL t410_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4       #No.CHI-6A0004
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
    #No.TQC-5B0171 --end--
    #add by danny 020309 期末調匯(A008)
    IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
#      IF p_sw='+' AND (un_pay1 < tot1 OR un_pay2 < tot2) THEN
       IF p_sw='+' AND (un_pay1 < tot1+tot4 OR un_pay2 < tot2+tot4t) THEN   #TQC-5B0171
#      CALL cl_err('un_pay<pay','axr-196',3) LET g_success = 'N' RETURN #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,'un_pay<pay','axr-196',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
       END IF
    END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       #取得未沖金額
       #modify 030226 NO.A048
       #CALL s_g_np('1',l_oma00,b_oob.oob06,b_oob.oob15) RETURNING tot3
       #No.9775
       CALL s_g_np('1',l_oma00,b_oob.oob06,0          ) RETURNING tot3
       #--
       #No.TQC-5B0171 --start--
       #未衝金額扣除待扺
       LET tot3 = tot3 - tot4t
       #No.TQC-5B0171 --end--
    ELSE
       #LET tot3 = 0  #bug no:A053 by plum
       #No.TQC-5B0171 --start--
       #LET tot3 = un_pay2 - tot2
       LET tot3 = un_pay2 - tot2 - tot4t
       #No.TQC-5B0171 --end--
    END IF
    #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"oma_file SET oma55=?,oma57=?,oma61=? ",
    #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
    LET g_sql="UPDATE oma_file ", #FUN-A50102
              " SET oma55=?,oma57=?,oma61=? ",
               " WHERE oma01=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
    PREPARE t410_bu_21_p2 FROM g_sql
    #No.FUN-680022--begin-- add
   #IF p_sw='+' AND NOT cl_null(b_oob.oob19) THEN
   #   LET g_sql="UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc10=?,omc11=?,omc13=? ",
   #             " WHERE omc01=? AND omc02=? "
   #   PREPARE t410_bu_21_p3 FROM g_sql
   #END IF
    #No.FUN-680022--end-- add
    #No.TQC-5B0171 --start--
    LET tot1 = tot1 + tot4
    LET tot2 = tot2 + tot4t
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1         #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2         #No.CHI-6A0004
    #No.TQC-5B0171 --end--
    EXECUTE t410_bu_21_p2 USING tot1, tot2, tot3, b_oob.oob06
    IF STATUS THEN
#      CALL cl_err('upd oma55,57',STATUS,3)  #No.FUN-660116
#      CALL cl_err3("upd","oma_file",b_oob.oob06,"",STATUS,"","upd oma55,57",1)  #No.FUN-660116 #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57',STATUS,1)              #NO.FUN-710050
       LET g_success = 'N'
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err('upd oma55,57','axr-198',3) LET g_success = 'N' RETURN #NO.FUN-710050
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57','axr-198',1) LET g_success = 'N' RETURN  #NO.FUN-710050
    END IF
   #No.FUN-680022--begin-- add
    IF SQLCA.sqlcode = 0 THEN
      #CALL t410_omc(p_sw)     #No.MOD-930140 mark
       CALL t410_omc(l_oma00)  #No.MOD-930140
    END IF
   #No.FUN-680022--end-- add
   ##No.FUN-680022--begin-- add
   #IF p_sw='+' AND NOT cl_null(b_oob.oob19) THEN
   #   LET l_omc10=l_omc10+b_oob.oob09
   #   LET l_omc11=l_omc11+b_oob.oob10
   #   LET l_omc13=l_omc13-b_oob.oob10
   #   EXECUTE t410_bu_21_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
   #   IF STATUS THEN
   #      CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1)
   #      LET g_success='N'
   #      RETURN
   #   END IF
   #END IF
   #IF p_sw='-' AND NOT cl_null(b_oob.oob19) THEN
   #   LET l_omc10=l_omc10-b_oob.oob09
   #   LET l_omc11=l_omc11-b_oob.oob10
   #   LET l_omc13=l_omc13+b_oob.oob10
   #   EXECUTE t410_bu_21_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
   #   IF STATUS THEN
   #      CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1)
   #      LET g_success='N'
   #      RETURN
   #   END IF
   #END IF
   ##No.FUN-680022--end-- add
  # 若有指定沖帳項次, 則對項次再次檢查及更新已沖金額
  IF NOT cl_null(b_oob.oob15) AND g_ooz.ooz62='Y' THEN
     LET tot1 = 0 LET tot2 = 0
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
        AND oob03='2' AND oob15 = b_oob.oob15
        AND oob04='1'
     IF cl_null(tot1) THEN LET tot1 = 0 END IF
     IF cl_null(tot2) THEN LET tot2 = 0 END IF
     #modify 030226 NO.A048(add oma00)
     LET g_sql="SELECT oma00,omaconf,omb14t,omb16t ",
               #"  FROM ",g_dbs_new CLIPPED,"omb_file,",g_dbs_new CLIPPED,"oma_file ",
               #"  FROM ",cl_get_target_table(g_plant,'omb_file'),",", #FUN-A50102
               #          cl_get_target_table(g_plant,'oma_file'),     #FUN-A50102
               "  FROM omb_file,oma_file ", #FUN-A50102
               " WHERE oma01=omb01 AND omb01=? AND omb03 = ? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t410_bu_21_p1b FROM g_sql
     DECLARE t410_bu_21_c1b CURSOR FOR t410_bu_21_p1b
     OPEN t410_bu_21_c1b USING b_oob.oob06,b_oob.oob15
     #modify 030226 NO.A048
     FETCH t410_bu_21_c1b INTO l_oma00,l_omaconf,un_pay1,un_pay2
     IF p_sw='+' AND l_omaconf='N' THEN
#       CALL cl_err(b_oob.oob06,'axr-194',3) LET g_success='N' RETURN #NO.FUN-710050
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                     #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
     END IF
     IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
     IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
     #add by danny 020309 期末調匯(A008)
     IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
        IF p_sw='+' AND (un_pay1 < tot1 OR un_pay2 < tot2) THEN
#       CALL cl_err('un_pay<pay','axr-196',3) LET g_success = 'N' RETURN #NO.FUN-710050
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'un_pay<pay','axr-196',1)  LET g_success='N' RETURN #NO.FUN-710050
        END IF
     END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       #取得未沖金額
       #modify 030226 NO.A048
       CALL s_g_np('1',l_oma00,b_oob.oob06,b_oob.oob15) RETURNING tot3
    ELSE
      #LET tot3 = 0  #bug no:A053 by plum
       LET tot3 = un_pay2  - tot2
    END IF
     #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"omb_file SET omb34=?,omb35=?,omb37=? ",
     #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'omb_file'), #FUN-A50102
     LET g_sql="UPDATE omb_file ", #FUN-A50102
               " SET omb34=?,omb35=?,omb37=? ",
               " WHERE omb01=? AND omb03=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t410_bu_21_p2b FROM g_sql
     EXECUTE t410_bu_21_p2b USING tot1, tot2, tot3, b_oob.oob06,b_oob.oob15
     IF STATUS THEN
#       CALL cl_err('upd omb34,35',STATUS,3)  #No.FUN-660116
#       CALL cl_err3("upd","omb_file",b_oob.oob06,b_oob.oob15,STATUS,"","upd omb34,35",1)  #No.FUN-660116 #NO.FUN-710050
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35',STATUS,1)   #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err('upd omb34,35','axr-198',3) LET g_success = 'N' RETURN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35','axr-198',1) LET g_success = 'N' RETURN   #NO.FUN-710050  #No.TQC-740094
     END IF
     #-----MOD-850008---------
     ##No.FUN-680022--begin-- add
     #IF p_sw='+' THEN  
     #   LET g_sql=" SELECT * FROM omc_file WHERE omc01='",b_oob.oob06,"'",
     #             " AND omc02= ",b_oob.oob19
     #   PREPARE t410_bu_21_p4 FROM g_sql
     #   DECLARE t410_bu_21_c4 CURSOR FOR t410_bu_21_p4
     #   LET l_oob10=b_oob.oob10
     #   LET l_oob09=b_oob.oob09
     #  #FETCH t410_bu_21_p4 INTO l_omc.*
     #  #
     #  #UPDATE omc_file SET omc10=l_omc.omc10,
     #  #                    omc11=l_omc.omc11,
     #  #                    omc13=l_omc.omc13
     #  # WHERE omc01=b_oob.oob06 AND omc02=b_oob.oob19
     #  #IF SQLCA.sqlcode THEN
     #  #   CALL cl_err3("sel","omc_file",l_omc.omc01,l_omc.omc02,SQLCA.sqlcode,"","",1)
     #  #   LET g_success ='N'
     #  #END IF
     #   FOREACH t410_bu_21_p4 INTO l_omc.* 
     #     IF l_oob10<l_omc.omc13 THEN
     #        LET l_omc.omc10=l_omc.omc10+l_oob09
     #        LET l_omc.omc11=l_omc.omc11+l_oob10
     #        LET l_omc.omc13=l_omc.omc13-l_oob10
     #        UPDATE omc_file SET omc10=l_omc.omc10,
     #                            omc11=l_omc.omc11,
     #                            omc13=l_omc.omc13
     #         WHERE omc01=l_omc.omc01 AND omc02=l_omc.omc02
     #        IF SQLCA.sqlcode THEN
#    #           CALL cl_err3("sel","omc_file",l_omc.omc01,l_omc.omc02,SQLCA.sqlcode,"","",1) #NO.FUN-710050
     #           LET g_showmsg=l_omc.omc01,"/",l_omc.omc02                          #NO.FUN-710050   
     #           CALL s_errmsg('omc01,omc02',g_showmsg,' ',SQLCA.sqlcode,1)         #NO.FUN-710050
     #           LET g_success ='N'
     #           EXIT FOREACH
     #        END IF
     #     ELSE
     #        LET l_omc13=l_omc.omc13                #unpay
     #        LET l_omc11=l_omc.omc08-l_omc.omc10    #unpay
     #        LET l_omc.omc10=l_omc.omc08
     #        LET l_omc.omc11=l_omc.omc09
     #        LET l_omc.omc13= 0
     #        UPDATE omc_file SET omc10=l_omc.omc10,
     #                            omc11=l_omc.omc11,
     #                            omc13=l_omc.omc13
     #         WHERE omc01=l_omc.omc01 AND omc02=l_omc.omc02
     #         IF SQLCA.sqlcode THEN
#    #            CALL cl_err3("sel","omc_file",l_omc.omc01,l_omc.omc02,SQLCA.sqlcode,"","",1) #NO.FUN-710050
     #            LET g_showmsg=l_omc.omc01,"/",l_omc.omc02                          #NO.FUN-710050   
     #            CALL s_errmsg('omc01,omc02',g_showmsg,' ',SQLCA.sqlcode,1)         #NO.FUN-710050
     #            LET g_success ='N'
     #            EXIT FOREACH
     #         ELSE
     #            LET l_oob09=l_oob09-l_omc13
     #            LET l_oob10=l_oob10-l_omc11
     #         END IF
     #     END IF
     #   
     #   END FOREACH   
     #END IF
     ##No.FUN-680022--end-- add
     #-----END MOD-850008-----
  END IF
END FUNCTION
 
FUNCTION t410_bu_22(p_sw,p_cnt)                  # 產生溢收帳款檔 (oma_file)
  DEFINE p_sw            LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:產生 -:刪除
  DEFINE p_cnt           LIKE type_file.num5      #No.FUN-680123 SMALLINT
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*
  DEFINE li_result       LIKE type_file.num5      #No.FUN-680123 SMALLINT   #FUN-560099
  ## Modify by Raymon
  #FUN-640246
  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
     IF g_gui_type MATCHES "[13]" AND fgl_getenv('GUI_VER') = '6' THEN
        MESSAGE "bu_22:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04
     ELSE
        DISPLAY "bu_22:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
     END IF
  END IF
  #END FUN-640246
###
  INITIALIZE l_oma.* TO NULL
  IF p_sw = '-' THEN
## No.2695 modify 1998/10/31 若溢收款在後已被沖帳,則不可取消確認
     IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
        SELECT COUNT(*) INTO g_cnt FROM oob_file
         WHERE oob06 = b_oob.oob06
           AND oob03 = '1' AND oob04 = '3'
        IF g_cnt > 0 THEN
#          CALL cl_err(b_oob.oob06,'axr-206',0) LET g_success = 'N' RETURN #NO.FUN-710050
           LET g_showmsg=b_oob.oob06,"/",'1',"/",'3'                       #NO.FUN-710050
           CALL s_errmsg('oob06,oob03,oob04',g_showmsg,b_oob.oob06,'axr-206',1) #NO.FUN-710050
           LET g_success = 'N' RETURN                                           #NO.FUN-710050      
        END IF
     END IF
##---------------------------------------------------------------
     SELECT * INTO l_oma.* FROM oma_file WHERE oma01=b_oob.oob06
                                           AND omavoid = 'N'
     IF l_oma.oma55 > 0 OR l_oma.oma57 > 0 THEN
#         CALL cl_err('oma55,57>0','axr-206',1) LET g_success = 'N' RETURN # NO.FUN-710050
          LET g_showmsg=b_oob.oob06,"/",'N'                                #NO.FUN-710050
          CALL s_errmsg('oma01,omavoid',g_showmsg,'oma55,57>0','axr-206',1)#NO.FUN-710050
           LET g_success = 'N' RETURN                                      #NO.FUN-710050      
     END IF
     DELETE FROM oma_file WHERE oma01 = b_oob.oob06
     IF STATUS THEN
#       CALL cl_err('del oma',STATUS,1)   #No.FUN-660116
#       CALL cl_err3("del","oma_file",b_oob.oob06,"",STATUS,"","del oma",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('oma01','b_oob.oob06','del oma',STATUS,1)              #NO.FUN-710050
        LET g_success = 'N' 
        RETURN 
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
#       CALL cl_err('del oma','axr-199',1)                                   #NO.FUN-710050
        CALL s_errmsg('oma01','b_oob.oob06','del oma','axr-199',1)           #NO.FUN-710050
        LET g_success = 'N' RETURN
     END IF
     #No.FUN-680022--begin-- add
     DELETE FROM omc_file WHERE omc01=b_oob.oob06 AND omc02=b_oob.oob19
     IF STATUS THEN
#       CALL cl_err3("del","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","del omc",1) #NO.FUN-710050
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                    #NO.FUN-710050
        CALL s_errmsg('omc01,omc02',g_showmsg,"del omc",STATUS,1)                    #NO.FUN-710050
        LET g_success ='N'
        RETURN
     END IF 
     #No.FUN-680022--end-- add
     #FUN-5A0124  --begin
     DELETE FROM oov_file WHERE oov01 = b_oob.oob06
     IF SQLCA.sqlcode THEN
#       CALL cl_err('del oov',status,1)   #No.FUN-660116
#       CALL cl_err3("del","oov_file",b_oob.oob06,"",status,"","del oov",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('oov01','b_oob.oob06','del oov',STATUS,1)              #NO.FUN-710050
        LET g_success='N'
     END IF
     #FUN-5A0124  --end
     UPDATE oob_file SET oob06=NULL
       WHERE oob01=b_oob.oob01 AND oob02=b_oob.oob02
     IF STATUS OR SQLCA.SQLCODE THEN
#      CALL cl_err('upd oob06',SQLCA.SQLCODE,1)    #No.FUN-660116
#      CALL cl_err3("upd","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","upd oob06",1)  #No.FUN-660116 #NO.FUN-710050
       LET g_showmsg=b_oob.oob01,"/",b_oob.oob02                                    #NO.FUN-710050
       CALL s_errmsg('oob01,oob02',g_showmsg,'upd oob06',SQLCA.SQLCODE,1)           #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
     ELSE        #97/08/08 modify 畫面清為空白
        LET b_oob.oob06 = NULL
        #DISPLAY b_oob.oob06 TO s_oob[p_cnt].oob06
     END IF
  END IF
  IF p_sw = '+' THEN
     IF cl_null(b_oob.oob06)
        #THEN LET l_oma.oma01 = g_ooz.ooz22,'-'    #FUN-560099
        THEN LET l_oma.oma01 = g_ooz.ooz22    #FUN-560099
        ELSE LET l_oma.oma01 = b_oob.oob06
     END IF
#FUN-560099
     CALL s_auto_assign_no("axr",l_oma.oma01,g_ooa.ooa02,"24","","","","","")
     RETURNING li_result,l_oma.oma01
     IF (NOT li_result) THEN
        LET g_success='N'
     END IF
{
     IF cl_null(l_oma.oma01[5,10]) THEN
        #---97/08/07 modify
      CALL s_axrauno(l_oma.oma01,g_ooa.ooa02,'24') RETURNING g_i,l_oma.oma01
        IF g_i THEN LET g_success='N' RETURN END IF
     END IF
}
#END FUN-560099
    #MESSAGE l_oma.oma01
     CALL cl_msg(l_oma.oma01)          #FUN-640246
 
     #轉預收時(oma00='24'),重新讀取g_ooa.*變數
     SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01=b_oob.oob01   #MOD-860002 add
 
     LET l_oma.oma00 = '24'
     LET l_oma.oma02 = g_ooa.ooa02
     LET l_oma.oma03 = g_ooa.ooa03
     LET l_oma.oma032= g_ooa.ooa032
     LET l_oma.oma13 = g_ooa.ooa13
     LET l_oma.oma14 = g_ooa.ooa14
     LET l_oma.oma15 = g_ooa.ooa15
     LET l_oma.oma16 = g_ooa.ooa01
     LET l_oma.oma18 = b_oob.oob11
     IF g_aza.aza63='Y' THEN             #No.FUN-670047 add
        LET l_oma.oma181 = b_oob.oob111  #No.FUN-670047 add
     END IF                              #No.FUN-670047 add
#    LET l_oma.oma21 = g_ooa.ooa21
     LET l_oma.oma211= 0   #MOD-850039
     LET l_oma.oma23 = b_oob.oob07
     LET l_oma.oma24 = b_oob.oob08
     LET l_oma.oma50 = 0
     LET l_oma.oma50t= 0
     LET l_oma.oma52 = 0
     LET l_oma.oma53 = 0
     LET l_oma.oma54 = b_oob.oob09
     LET l_oma.oma54t= b_oob.oob09
     LET l_oma.oma56 = b_oob.oob10
     LET l_oma.oma56t= b_oob.oob10
     LET l_oma.oma54x= 0
     LET l_oma.oma55 = 0
     LET l_oma.oma56x= 0
     LET l_oma.oma57 = 0
     LET l_oma.oma58 = 0
     LET l_oma.oma59 = 0
     LET l_oma.oma59x= 0
     LET l_oma.oma59t= 0
     #---modi by plum bug no:A053
     LET l_oma.oma60 = b_oob.oob08
     LET l_oma.oma61 = b_oob.oob10
     #--
     LET l_oma.omaconf='Y'
     LET l_oma.oma64 = '1'    #No.TQC-9C0057
     LET l_oma.omavoid='N'
     LET l_oma.omauser=g_user
     LET l_oma.omagrup=g_grup
     LET l_oma.omadate=g_today
     LET l_oma.oma12 = l_oma.oma02
     LET l_oma.oma11 = l_oma.oma02
     LET l_oma.oma65 = '1'  #FUN-5A0124
     LET l_oma.oma66 = g_plant  #FUN-630043
    #TQC-750177 begin
     LET l_oma.oma68 = g_ooa.ooa03                                                                         
     LET l_oma.oma69 = g_ooa.ooa032                                                                         
    #TQC-750177 end 
     #No.FUN-680022--begin-- add
     LET l_omc.omc01=l_oma.oma01
     LET l_omc.omc02=1
    #str MOD-890104 mod
     SELECT occ45 INTO l_oma.oma32 FROM occ_file WHERE occ01=g_ooa.ooa03
     IF cl_null(l_oma.oma32) THEN LET l_oma.oma32 = ' ' END IF
    #end MOD-890104 mod
     LET l_omc.omc03=l_oma.oma32
     LET l_omc.omc04=l_oma.oma11
     LET l_omc.omc05=l_oma.oma12
     LET l_omc.omc06=l_oma.oma24
     LET l_omc.omc07=l_oma.oma60
     LET l_omc.omc08=l_oma.oma54t
     LET l_omc.omc09=l_oma.oma56t
     LET l_omc.omc10=l_oma.oma55
     LET l_omc.omc11=l_oma.oma57
     LET l_omc.omc12=l_oma.oma10
     LET l_omc.omc13=l_omc.omc09-l_omc.omc11
     LET l_omc.omc14=l_oma.oma51f
     LET l_omc.omc15=l_oma.oma51
     #No.FUN-680022--end-- add
    
   #FUN-A60056--mod--str--
   ##No.FUN-5C0014 --start --
   # SELECT oga27 INTO l_oma.oma67 FROM oga_file WHERE oga01=l_oma.oma16
   ##No.FUN-5C0014 --end --
   LET g_sql = "SELECT oga27 FROM ",cl_get_target_table(l_oma.oma66,'oga_file'),
               " WHERE oga01='",l_oma.oma16,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,l_oma.oma66) RETURNING g_sql
   PREPARE sel_oga27 FROM g_sql
   EXECUTE sel_oga27 INTO l_oma.oma67
   #FUN-A60056--mod--end
     LET l_oma.oma930=s_costcenter(l_oma.oma15) #FUN-680006
     #FUN-960141 add
     #LET l_oma.omaplant = g_ooa.ooaplant   #FUN-960141 mark 090824
     LET l_oma.omalegal = g_ooa.ooalegal
     #LET l_omc.omcplant = g_ooa.ooaplant   #FUN-960141 mark 090824
     LET l_omc.omclegal = g_ooa.ooalegal
     #FUN-960141 end
 
     LET l_oma.omaoriu = g_user      #No.FUN-980030 10/01/04
     LET l_oma.omaorig = g_grup      #No.FUN-980030 10/01/04
#No.FUN-AB0034 --begin
    IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
    IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
    IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
     INSERT INTO oma_file VALUES(l_oma.*)
     #No.+041 010330 by plum
#   #IF STATUS THEN CALL cl_err('ins oma',STATUS,1) LET g_success = 'N' RETURN   
     IF STATUS OR SQLCA.SQLCODE THEN
#       CALL cl_err('ins oma',SQLCA.SQLCODE,1)    #No.FUN-660116
#       CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","ins oma",1)  #No.FUN-660116 #NO.FUN-710050
        CALL s_errmsg('oma02','g_ooa.ooa02','ins oma',SQLCA.SQLCODE,1)              #NO.FUN-710050
        LET g_success='N' 
        RETURN
     END IF
     
    #No.FUN-680022--begin-- add
     INSERT INTO omc_file VALUES(l_omc.*)
     IF SQLCA.sqlcode THEN
#       CALL cl_err3("ins","omc_file",l_omc.omc01,l_omc.omc02,SQLCA.sqlcode,"","ins omc",1) #NO.FUN-710050
        CALL s_errmsg('omc01','l_oma.oma01','ins omc',SQLCA.SQLCODE,1)                      #NO.FUN-710050
        LET g_success='N'
        RETURN
     END IF
    #No.FUN-680022--end-- add 
    #No.+041...end
    #UPDATE oob_file SET oob06=l_oma.oma01   #No.FUN-680022 mark
     UPDATE oob_file SET oob06=l_oma.oma01,oob19=l_omc.omc02   #No.FUN-680022 add
       WHERE oob01=b_oob.oob01 AND oob02=b_oob.oob02
     IF STATUS OR SQLCA.SQLCODE THEN
#      CALL cl_err('upd oob06',SQLCA.SQLCODE,1)    #No.FUN-660116
       CALL cl_err3("upd","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","upd oob06",1)  #No.FUN-660116
       LET g_showmsg=b_oob.oob01,"/",b_oob.oob02                                      #NO.FUN-710050 
       CALL s_errmsg('oob01,oob02',g_showmsg,'upd oob06',SQLCA.SQLCODE,1)             #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
     ELSE       #97/08/08 modify畫面顯示
       #DISPLAY l_oma.oma01 TO s_oob[p_cnt].oob06
     END IF
  END IF
END FUNCTION
 
FUNCTION ins_apf()
  DEFINE b_oob      RECORD LIKE oob_file.*
  DEFINE l_apf      RECORD LIKE apf_file.*
  DEFINE l_apg      RECORD LIKE apg_file.*
  DEFINE l_aph      RECORD LIKE aph_file.*
  DEFINE l_amt      LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_apz27    LIKE apz_file.apz27
 
  INITIALIZE l_apf.* TO NULL
  LET l_apf.apf00='33'
  LET l_apf.apf01 =g_ooa.ooa01
  LET l_apf.apf02 =g_ooa.ooa02
  LET l_apf.apf03 =g_ooa.ooa03
  LET l_apf.apf12 =g_ooa.ooa032
  LET l_apf.apf04 =g_ooa.ooa14
  LET l_apf.apf05 =g_ooa.ooa15
  LET l_apf.apf06 =g_ooa.ooa23
  LET l_apf.apf07 =1
  LET l_apf.apf08f=g_ooa.ooa31d
  LET l_apf.apf08 =g_ooa.ooa32d
  LET l_apf.apf09f=0
  LET l_apf.apf09 =0
  LET l_apf.apf10f=g_ooa.ooa31c
  LET l_apf.apf10 =g_ooa.ooa32c
  #-----MOD-6A0091---------
  LET l_apf.apf13 = ''
  SELECT pmc24 INTO l_apf.apf13 FROM pmc_file
    WHERE pmc01 = g_ooa.ooa03
  #LET l_apf.apf13 =g_ooa.ooa23
  #-----END MOD-6A0091-----
  LET l_apf.apf41 ='Y'
  LET l_apf.apf44 =g_ooa.ooa33
  LET l_apf.apfinpd =TODAY
  LET l_apf.apfmksg ='N'
  LET l_apf.apfacti ='Y'
  LET l_apf.apfuser =g_user
  LET l_apf.apfgrup =g_grup
  #FUN-960141 add
  #LET l_apf.apfplant = g_ooa.ooaplant   #FUN-960141 mark 090824
  LET l_apf.apflegal = g_ooa.ooalegal
  #FUN-960141 end
  LET l_apf.apforiu = g_user      #No.FUN-980030 10/01/04
  LET l_apf.apforig = g_grup      #No.FUN-980030 10/01/04
  INSERT INTO apf_file VALUES(l_apf.*)
 #No.+041 010330 by plum
 #IF STATUS THEN CALL cl_err('ins apf',STATUS,1)LET g_success = 'N' END IF
  IF STATUS OR SQLCA.SQLCODE THEN
#    CALL cl_err('ins apf',SQLCA.SQLCODE,1)     #No.FUN-660116
#    CALL cl_err3("ins","apf_file",l_apf.apf01,"",SQLCA.sqlcode,"","ins apf",1)  #No.FUN-660116 #NO.FUN-710050
     CALL s_errmsg('apf01','g_ooa.ooa01','ins apf',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
 #No.+041 ..end
  DECLARE ins_apf_c CURSOR FOR
    SELECT * FROM oob_file WHERE oob01=g_ooa.ooa01 ORDER BY 1,2
  FOREACH ins_apf_c INTO b_oob.*
#NO.FUN-710050--BEGIN                                                           
       IF g_success='N' THEN                                                    
         LET g_totsuccess='N'                                                   
         LET g_success='Y' 
       END IF                                                     
#NO.FUN-710050--END
    IF b_oob.oob03='1' THEN
       INITIALIZE l_apg.* TO NULL
       LET l_apg.apg01 =g_ooa.ooa01
       LET l_apg.apg02 =b_oob.oob02
       LET l_apg.apg04 =b_oob.oob06
       LET l_apg.apg05f=b_oob.oob09
       LET l_apg.apg05 =b_oob.oob10
       LET l_apg.apg06 =b_oob.oob19  #No.FUN-680022 add
       #FUN-960141 add
       #LET l_apg.apgplant = g_ooa.ooaplant    #FUN-960141 mark 090824
       LET l_apg.apglegal = g_ooa.ooalegal
       #FUN-960141 end
       INSERT INTO apg_file VALUES(l_apg.*)
      #No.+041 010330 by plum
      #IF STATUS THEN CALL cl_err('ins apg',STATUS,1)LET g_success = 'N' END IF
       IF STATUS OR SQLCA.SQLCODE THEN
#         CALL cl_err('ins apg',SQLCA.SQLCODE,1)     #No.FUN-660116
#         CALL cl_err3("ins","apg_file",l_apg.apg01,l_apg.apg02,SQLCA.sqlcode,"","ins apg",1)  #No.FUN-660116 
          LET g_showmsg=g_ooa.ooa01,"/",b_oob.oob02 
          CALL s_errmsg('apg01,apg02',g_showmsg,'ins apg',SQLCA.SQLCODE,1)   #NO.FUN-710050    #NO.FUN-710050
          LET g_success = 'N'
       END IF
      #No.+041 ..end
{modify 030311 NO.A048
      #add by danny 020314 期末調匯(A008)
      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
      IF l_apz27 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
         CALL s_g_np('2',b_oob.oob06,b_oob.oob15) RETURNING l_amt
         UPDATE apa_file SET apa73 = l_amt WHERE apa01 = b_oob.oob06
         IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
#           CALL cl_err('upd apa',SQLCA.SQLCODE,1)   #No.FUN-660116
            CALL cl_err3("upd","apa_file",b_oob.oob06,"",SQLCA.sqlcode,"","upd apa",1)  #No.FUN-660116
            LET g_success = 'N' 
         END IF
      END IF
}
    END IF
    IF b_oob.oob03='2' THEN
       INITIALIZE l_aph.* TO NULL
       LET l_aph.aph01 =g_ooa.ooa01
       LET l_aph.aph02 =b_oob.oob02
       LET l_aph.aph03 ='0'
      #No.B592 010525 by plum 若抓科目,到時aapt230,240會無法查到此沖帳記錄
      #LET l_aph.aph04 =b_oob.oob11
       LET l_aph.aph04 =b_oob.oob06
      #No.B592...end
       LET l_aph.aph05f=b_oob.oob09
       LET l_aph.aph05 =b_oob.oob10
       LET l_aph.aph13 =b_oob.oob07
       LET l_aph.aph14 =b_oob.oob08
       LET l_aph.aph17 =b_oob.oob19  #No.FUN-680022 add
       #FUN-960141 add
       #LET l_aph.aphplant = g_ooa.ooaplant   #FUN-960141 mark 090824
       LET l_aph.aphlegal = g_ooa.ooalegal
       #FUN-960141 end
       INSERT INTO aph_file VALUES(l_aph.*)
      #No.+041 010330 by plum
      #IF STATUS THEN CALL cl_err('ins aph',STATUS,1)LET g_success = 'N' END IF
       IF STATUS OR SQLCA.SQLCODE THEN
#         CALL cl_err('ins aph',SQLCA.SQLCODE,1)     #No.FUN-660116
#         CALL cl_err3("ins","aph_file",l_aph.aph01,"",SQLCA.sqlcode,"","ins aph",1)  #No.FUN-660116 
          LET g_showmsg=g_ooa.ooa01,"/",b_oob.oob02                          #NO.FUN-710050    
          CALL s_errmsg('aph01,aph02',g_showmsg,'ins aph',SQLCA.SQLCODE,1)   #NO.FUN-710050  
          LET g_success = 'N'
       END IF
      #No.+041 ..end
    END IF
  END FOREACH
#NO.FUN-710050--BEGIN                                                           
  IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
  END IF                                                                          
#NO.FUN-710050--END
END FUNCTION
 
FUNCTION del_apf()
  DELETE FROM apf_file WHERE apf01=g_ooa.ooa01
  IF STATUS OR SQLCA.SQLCODE THEN
#    CALL cl_err('del apf',SQLCA.SQLCODE,1)   #No.FUN-660116
#    CALL cl_err3("del","apf_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","del apf",1)  #No.FUN-660116 #NO.FUN-710050
     CALL s_errmsg('apf01','g_ooa.ooa01','del apf',SQLCA.SQLCODE,1)   #NO.FUN-710050
     LET g_success = 'N'
  END IF
  DELETE FROM apg_file WHERE apg01=g_ooa.ooa01
  IF STATUS OR SQLCA.SQLCODE THEN
#    CALL cl_err('del apg',SQLCA.SQLCODE,1)   #No.FUN-660116
#    CALL cl_err3("del","apg_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","del apg",1)  #No.FUN-660116 #NO.FUN-710050
     CALL s_errmsg('apg01','g_ooa.ooa01','del apg',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
  DELETE FROM aph_file WHERE aph01=g_ooa.ooa01
 #IF STATUS THEN CALL cl_err('del aph',STATUS,1)LET g_success = 'N' END IF
  IF STATUS OR SQLCA.SQLCODE THEN
#    CALL cl_err('del aph',SQLCA.SQLCODE,1)  #No.FUN-660116
#    CALL cl_err3("del","aph_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","del aph",1)  #No.FUN-660116 #NO.FUN-710050
     CALL s_errmsg('aph01','g_ooa.ooa01','del aph',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
END FUNCTION
 
FUNCTION t410_oob07(p_cmd)
DEFINE
      p_cmd        LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
      l_azi01      LIKE azi_file.azi01,
      l_aziacti    LIKE azi_file.aziacti
 
      LET g_errno = ' '
      SELECT azi01,aziacti INTO l_azi01,l_aziacti
        FROM azi_file
       WHERE azi01 = g_oob[l_ac].oob07
      CASE
          WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aap-002'
                                   LET l_azi01 = NULL
                                   LET l_aziacti = NULL
          WHEN l_aziacti = 'N' LET g_errno = '9028'
          OTHERWISE            LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
END FUNCTION
 
FUNCTION t410_x()
 
   IF s_shut(0) THEN RETURN END IF
 
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01=g_ooa.ooa01
 
   #-----No.FUN-540046-----
  IF g_ooa.ooa34 MATCHES '[Ss1]' THEN          #FUN-550049
     CALL cl_err("","mfg3557",0)
     RETURN
  END IF
 
   #-----No.FUN-540046 END-----
 
   IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
 
   BEGIN WORK
   LET g_success='Y'
 
   OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
   IF STATUS THEN
      CALL cl_err("OPEN t410_cl:", STATUS, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t410_cl INTO g_ooa.* #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)#資料被他人LOCK
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
  #-->作廢轉換01/08/02
   IF cl_void(0,0,g_ooa.ooaconf) THEN
      LET g_chr = g_ooa.ooaconf
      IF g_ooa.ooaconf ='N' THEN
         LET g_ooa.ooaconf='X'
         LET g_ooa.ooa34 = '9'    #No.FUN-540046
      ELSE
         LET g_ooa.ooaconf='N'
         LET g_ooa.ooa34 = '0'    #No.FUN-540046
      END IF
 
      UPDATE ooa_file SET ooaconf = g_ooa.ooaconf,
                          ooa34 = g_ooa.ooa34,    #No.FUN-540046
                          ooamodu = g_user,
                          ooadate = TODAY
       WHERE ooa01 = g_ooa.ooa01
 
      IF STATUS THEN
#        CALL cl_err('upd ooaconf:',STATUS,1)   #No.FUN-660116
         CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",STATUS,"","upd ooaconf:",1)  #No.FUN-660116
         LET g_success='N'
      END IF
      #-----MOD-740029---------
      DELETE FROM npp_file WHERE npp01 = g_ooa.ooa01 AND nppsys = 'AR'
                             AND npp00 = 3  AND npp011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npp_file",g_ooa.ooa01,"",STATUS,"","del npp_file",1) 
         LET g_success='N'
      END IF
      DELETE FROM npq_file WHERE npq01 = g_ooa.ooa01 AND npqsys = 'AR'
                             AND npq00 = 3 AND npq011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npq_file",g_ooa.ooa01,"",STATUS,"","del npq_file",1)
         LET g_success='N'
      END IF
      #-----END MOD-740029-----
      #FUN-B40056--add--str--
      DELETE FROM tic_file WHERE tic04 = g_ooa.ooa01
      IF STATUS THEN
         CALL cl_err3("del","tic_file",g_ooa.ooa01,"",STATUS,"","del tic:",1)
         LET g_success='N'
      END IF           
      #FUN-B40056--add--end--
 
      IF g_success='Y' THEN
         COMMIT WORK
 
         #FUN-550049
         IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
         ## END FUN-550049 ##
 
         CALL cl_flow_notify(g_ooa.ooa01,'V')
      ELSE
         ROLLBACK WORK
      END IF
 
      SELECT ooaconf,ooa34 INTO g_ooa.ooaconf,g_ooa.ooa34 FROM ooa_file   #No.FUN-540046
       WHERE ooa01 = g_ooa.ooa01
      DISPLAY BY NAME g_ooa.ooaconf,g_ooa.ooa34     #No.FUN-540046
   END IF
 
END FUNCTION
 
#No.MOD-590440  --begin
FUNCTION t410_comp_oox(p_apv03)
DEFINE l_net     LIKE apv_file.apv04
DEFINE p_apv03   LIKE apv_file.apv03
DEFINE l_apa00   LIKE apa_file.apa00
 
    LET l_net = 0
    IF g_apz.apz27 = 'Y' THEN
       SELECT SUM(oox10) INTO l_net FROM oox_file
        WHERE oox00 = 'AP' AND oox03 = p_apv03
       IF cl_null(l_net) THEN
          LET l_net = 0
       END IF
    END IF
    SELECT apa00 INTO l_apa00 FROM apa_file WHERE apa01=p_apv03
    IF l_apa00 MATCHES '1*' THEN LET l_net = l_net * ( -1) END IF
 
    RETURN l_net
END FUNCTION
#No.MOD-590440  --end
 
#No.TQC-5B0171 --start--
#取得衝帳單的待扺金額
FUNCTION t410_mntn_offset_inv(p_oob06)
   DEFINE p_oob06   LIKE oob_file.oob06,
          l_oot04t  LIKE oot_file.oot04t,
          l_oot05t  LIKE oot_file.oot05t
 
   SELECT SUM(oot04t),SUM(oot05t) INTO l_oot04t,l_oot05t
     FROM oot_file
    WHERE oot03 = p_oob06
   IF cl_null(l_oot04t) THEN LET l_oot04t = 0 END IF
   IF cl_null(l_oot05t) THEN LET l_oot05t = 0 END IF
   RETURN l_oot04t,l_oot05t
END FUNCTION
#No.TQC-5B0171 --end--
 
#No.FUN-670060 --begin--
FUNCTION t410_gen_glcr(p_ooa,p_ooy)
  DEFINE p_ooa     RECORD LIKE ooa_file.*
  DEFINE p_ooy     RECORD LIKE ooy_file.*
 
    IF cl_null(p_ooy.ooygslp) THEN
       CALL cl_err(p_ooa.ooa01,'axr-070',1)
       LET g_success = 'N'
       RETURN
    END IF       
   #CALL s_t400_gl(p_ooa.ooa01)
    CALL s_t400_gl(p_ooa.ooa01,'0')     #No.FUN-670047 add
    IF g_aza.aza63='Y' THEN         #No.FUN-670047 add
       CALL s_t400_gl(p_ooa.ooa01,'1')  #No.FUN-670047 add
    END IF                          #No.FUN-670047 add
    IF g_success = 'N' THEN RETURN END IF
 
END FUNCTION
 
FUNCTION t410_carry_voucher()
  DEFINE l_ooygslp    LIKE ooy_file.ooygslp
  DEFINE li_result    LIKE type_file.num5      #No.FUN-680123 SMALLINT 
  DEFINE l_dbs        STRING                                                                                                        
  DEFINE l_sql        STRING                                                                                                        
  DEFINE l_n          LIKE type_file.num5      #No.FUN-680123 SMALLINT 
 
    IF NOT cl_confirm('aap-989') THEN RETURN END IF
 
    CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF g_ooy.ooydmy1 = 'N' THEN RETURN END IF
#    IF g_ooy.ooyglcr = 'Y' THEN
    IF g_ooy.ooyglcr = 'Y' OR (g_ooy.ooyglcr ='N' AND NOT cl_null(g_ooy.ooygslp)) THEN      #add by zhangym 110914    
       #LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new                                                                
       #LET l_sql = " SELECT COUNT(aba00) FROM ",l_dbs,"aba_file",
       LET l_sql = " SELECT COUNT(aba00) FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102       
                   "  WHERE aba00 = '",g_ooz.ooz02b,"'",                                                                               
                   "    AND aba01 = '",g_ooa.ooa33,"'"                                                                                 
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql #FUN-A50102
       PREPARE aba_pre2 FROM l_sql                                                                                                     
       DECLARE aba_cs2 CURSOR FOR aba_pre2                                                                                             
       OPEN aba_cs2                                                                                                                    
       FETCH aba_cs2 INTO l_n                                                                                                          
       IF l_n > 0 THEN                                                                                                                 
          CALL cl_err(g_ooa.ooa33,'aap-991',1)                                                                                         
          RETURN                                                                                                                       
       END IF
 
       LET l_ooygslp = g_ooy.ooygslp
    ELSE
       CALL cl_err('','aap-992',1)                                                                                                  
       RETURN
       #開窗作業
#      LET g_plant_new= g_ooz.ooz02p
#      CALL s_getdbs()
#      LET g_dbs_gl=g_dbs_new      # 得資料庫名稱
 
#      OPEN WINDOW t200p AT 5,10 WITH FORM "axr/42f/axrt200_p" 
#           ATTRIBUTE (STYLE = g_win_style CLIPPED)
#      CALL cl_ui_locale("axrt200_p")
#       
#      INPUT l_ooygslp WITHOUT DEFAULTS FROM FORMONLY.gl_no
#   
#         AFTER FIELD gl_no
#            CALL s_check_no("agl",l_ooygslp,"","1","aac_file","aac01",g_dbs_gl) #No.FUN-560190
#                  RETURNING li_result,l_ooygslp
#            IF (NOT li_result) THEN
#               NEXT FIELD gl_no
#            END IF
#    
#         AFTER INPUT
#            IF INT_FLAG THEN
#               EXIT INPUT 
#            END IF
#            IF cl_null(l_ooygslp) THEN
#               CALL cl_err('','9033',0)
#               NEXT FIELD gl_no  
#            END IF
#   
#         ON ACTION CONTROLZ
#            CALL cl_show_req_fields()
#         ON ACTION CONTROLG
#            CALL cl_cmdask()
#         ON ACTION CONTROLP
#            IF INFIELD(gl_no) THEN
#               CALL q_m_aac(FALSE,TRUE,g_dbs_gl,l_ooygslp,'1',' ',' ','AGL') 
#               RETURNING l_ooygslp
#               DISPLAY l_ooygslp TO FORMONLY.gl_no
#               NEXT FIELD gl_no
#            END IF
#   
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
#    
#         ON ACTION about         #MOD-4C0121
#            CALL cl_about()      #MOD-4C0121
#    
#         ON ACTION help          #MOD-4C0121
#            CALL cl_show_help()  #MOD-4C0121
#    
#         ON ACTION exit  #加離開功能genero
#            LET INT_FLAG = 1
#            EXIT INPUT
 
#      END INPUT
       CLOSE WINDOW t200p  
    END IF
    IF cl_null(l_ooygslp) THEN
       CALL cl_err(g_ooa.ooa01,'axr-070',1)
       RETURN
    END IF
    #No.FUN-670047--begin
    IF g_aza.aza63 = 'Y' AND cl_null(g_ooy.ooygslp1) THEN
       CALL cl_err(g_ooa.ooa01,'axr-070',1)
       RETURN
    END IF
    #No.FUN-670047--end  
    LET g_wc_gl = 'npp01 = "',g_ooa.ooa01,'" AND npp011 = 1'
#   LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",g_ooa.ooa02,"' 'Y' '0' 'Y'"  #No.FUN-670047
   #LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",g_ooa.ooa02,"' 'Y' '0' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"  #No.FUN-670047  #No.MOD-860075
    LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_user,"' '",g_user,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",g_ooa.ooa02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"  #No.FUN-670047  #No.MOD-860075
    CALL cl_cmdrun_wait(g_str)
    SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
     WHERE ooa01 = g_ooa.ooa01
    DISPLAY BY NAME g_ooa.ooa33
    
END FUNCTION
 
FUNCTION t410_undo_carry_voucher() 
  DEFINE l_aba19    LIKE aba_file.aba19
  DEFINE l_dbs      STRING 
  DEFINE l_sql      STRING
 
    IF NOT cl_confirm('aap-988') THEN RETURN END IF
 
    CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1                                                                                   
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1                                                                          
#    IF g_ooy.ooyglcr = 'N' THEN  
    IF g_ooy.ooyglcr = 'N' AND cl_null(g_ooy.ooygslp) THEN     #add by zhangym 110914                                                                                                      
       CALL cl_err('','aap-990',1)                                                                                                  
       RETURN                                                                                                                       
    END IF  
    #LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new
    #LET g_dbs_new = l_dbs_new
    #LET l_dbs=l_dbs.trimRight()                                                                                                    
    #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
    LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102
                "  WHERE aba00 = '",g_ooz.ooz02b,"'",
                "    AND aba01 = '",g_ooa.ooa33,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql #FUN-A50102
    PREPARE aba_pre1 FROM l_sql
    DECLARE aba_cs1 CURSOR FOR aba_pre1
    OPEN aba_cs1
    FETCH aba_cs1 INTO l_aba19
    IF l_aba19 = 'Y' THEN
       CALL cl_err(g_ooa.ooa33,'axr-071',1)
       RETURN
    END IF
    LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooa.ooa33,"' 'Y'"
    CALL cl_cmdrun_wait(g_str)
    SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
     WHERE ooa01 = g_ooa.ooa01
    DISPLAY BY NAME g_ooa.ooa33
END FUNCTION
#No.FUN-670060 --end--
 
#Patch....NO.MOD-5A0095 <001,003,004,005,006,007,008,009,011> #
 
#No.FUN-670047--begin-- add
FUNCTION t410_3_1()
 
   IF g_ooa.ooa01 IS NULL THEN
      RETURN
   END IF
 
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
 
   IF NOT cl_chk_act_auth() THEN
      LET g_chr='D'
   ELSE
      LET g_chr='U'
   END IF
 
   BEGIN WORK
   OPEN t410_cl USING g_ooa.ooa01   #wujie 091021
   IF STATUS THEN
      CALL cl_err("OPEN t410_cl:", STATUS, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t410_cl INTO g_ooa.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0) 
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
   CALL s_showmsg_init()                   #NO.FUN-710050 
   CALL s_fsgl('AR',3,g_ooa.ooa01,0,g_ooz.ooz02c,1,g_ooa.ooaconf,'1',g_ooz.ooz02p) #No.FUN-680022 add
   CALL s_showmsg()                         #NO.FUN-710050
   CLOSE t410_cl 
   COMMIT WORK
 
END FUNCTION
 
#FUNCTION t410_omc(p_sw)    #No.MOD-930140 mark
FUNCTION t410_omc(p_oma00)  #No.MOD-930140
#DEFINE   l_oob      RECORD LIKE oob_file.*
DEFINE   l_omc10           LIKE omc_file.omc10
DEFINE   l_omc11           LIKE omc_file.omc11
DEFINE   l_omc13           LIKE omc_file.omc13
#DEFINE   p_sw              LIKE type_file.chr1  #No.MOD-930140 mark
DEFINE   l_oob09           LIKE oob_file.oob09   #MOD-830097
DEFINE   l_oob10           LIKE oob_file.oob10   #MOD-830097
DEFINE   l_oox10           LIKE oox_file.oox10   #No.MOD-930140
DEFINE   p_oma00           LIKE oma_file.oma00   #No.MOD-930140
 
  #No.MOD-930140--begin-- 
   LET l_oox10 = 0 
   SELECT SUM(oox10) INTO l_oox10 FROM oox_file 
    WHERE oox00 = 'AR'
      AND oox03 = b_oob.oob06 
      AND oox041 = b_oob.oob19
   IF cl_null(l_oox10) THEN LET l_oox10 = 0 END IF 
   IF p_oma00 MATCHES '2*' THEN 
      LET l_oox10 = l_oox10 * -1
   END IF 
  #No.MOD-930140---end---
 
# DECLARE t410_cs_omc CURSOR FOR 
#  SELECT * FROM oob_file 
#   WHERE oob01=b_oob.oob01 AND oob06=b_oob.oob06 
 
  #-----MOD-830097---------
  SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file, ooa_file
   WHERE oob06=b_oob.oob06 AND oob19 = b_oob.oob19 
     AND oob01=ooa01  AND ooaconf = 'Y'
     AND ((oob03='1' AND oob04='3') OR (oob03='2' AND oob04='1'))   #MOD-850027
  IF cl_null(l_oob09) THEN LET l_oob09 = 0 END IF
  IF cl_null(l_oob10) THEN LET l_oob10 = 0 END IF
     #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc10=?,omc11=?,omc13= omc09 - omc11 ",   #MOD-850008
     #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc10=?,omc11=? ",   #MOD-850008
     #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'omc_file'), #FUN-A50102
     LET g_sql=" UPDATE omc_file ",#FUN-A50102
               " SET omc10=?,omc11=? ", 
               " WHERE omc01=? AND omc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t410_bu_13_p3 FROM g_sql
     EXECUTE t410_bu_13_p3 USING l_oob09,l_oob10,b_oob.oob06,b_oob.oob19
     #-----MOD-850008---------
    #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc13=omc09-omc11",   #No.MOD-930140 mark
     #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc13=omc09-omc11+ ",l_oox10,   #No.MOD-930140 
     #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'omc_file'), #FUN-A50102
     LET g_sql=" UPDATE omc_file ", #FUN-A50102
              " SET omc13=omc09-omc11+ ",l_oox10,
               " WHERE omc01=? AND omc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t410_bu_13_p4 FROM g_sql
     EXECUTE t410_bu_13_p4 USING b_oob.oob06,b_oob.oob19
     #-----END MOD-850008-----
 
    #SELECT omc10,omc11,omc13 INTO l_omc10,l_omc11,l_omc13
    #  FROM omc_file WHERE omc01=b_oob.oob06 AND omc02=b_oob.oob19
    #IF l_omc10 IS NULL THEN LET l_omc10=0 END IF
    #IF l_omc11 IS NULL THEN LET l_omc11=0 END IF
    #IF l_omc13 IS NULL THEN LET l_omc13=0 END IF
    #IF p_sw='+' THEN
    #   LET l_omc10 = l_omc10 + b_oob.oob09
    #   LET l_omc11 = l_omc11 + b_oob.oob10
    #   LET l_omc13 = l_omc13 - b_oob.oob10
    #   IF NOT cl_null(b_oob.oob19) THEN 
    #      EXECUTE t410_bu_13_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
    #      IF STATUS THEN
#   #         CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1) #NO.FUN-710050
    #         LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                          #NO.FUN-710050
    #         CALL s_errmsg('omc01,omc02',g_showmsg,'upd omc10,11,13',STATUS,1)  #NO.FUN-710050    
    #         LET g_success='N'
    #         RETURN
    #      END IF
    #   END IF
    #END IF
    #IF p_sw='-' THEN
    #   LET l_omc10 = l_omc10 - b_oob.oob09
    #   LET l_omc11 = l_omc11 - b_oob.oob10
    #   LET l_omc13 = l_omc13 + b_oob.oob10
    #   IF NOT cl_null(b_oob.oob19) THEN 
    #      EXECUTE t410_bu_13_p3 USING l_omc10,l_omc11,l_omc13,b_oob.oob06,b_oob.oob19
    #      IF STATUS THEN
#   #         CALL cl_err3("upd","omc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd omc10,11,13",1) #NO.FUN-710050
    #         LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                          #NO.FUN-710050
    #         CALL s_errmsg('omc01,omc02',g_showmsg,'upd omc10,11,13',STATUS,1)  #NO.FUN-710050    
    #         LET g_success='N'
    #         RETURN
    #      END IF
    #   END IF
    #END IF
  #-----END MOD-830097-----
# END FOREACH
END FUNCTION
 
FUNCTION t410_apc(p_sw)
DEFINE   l_apc10           LIKE apc_file.apc10
DEFINE   l_apc11           LIKE apc_file.apc11
DEFINE   l_apc13           LIKE apc_file.apc13
DEFINE   p_sw              LIKE type_file.chr1  
 
  #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"apc_file SET apc10=?,apc11=?,apc13=? ",
  #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'apc_file'), #FUN-A50102
  LET g_sql=" UPDATE apc_file ", #FUN-A50102
            " SET apc10=?,apc11=?,apc13=? ",
            " WHERE apc01=? AND apc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t410_bu_19_p3 FROM g_sql
 
  SELECT apc10,apc11,apc13 INTO l_apc10,l_apc11,l_apc13
    FROM apc_file WHERE apc01=b_oob.oob06 AND apc02=b_oob.oob19
  IF l_apc10 IS NULL THEN LET l_apc10=0 END IF
  IF l_apc11 IS NULL THEN LET l_apc11=0 END IF
  IF l_apc13 IS NULL THEN LET l_apc13=0 END IF
  IF p_sw='+' THEN
     LET l_apc10 = l_apc10 + b_oob.oob09
     LET l_apc11 = l_apc11 + b_oob.oob10
     LET l_apc13 = l_apc13 - b_oob.oob10
     IF NOT cl_null(b_oob.oob19) THEN 
        EXECUTE t410_bu_19_p3 USING l_apc10,l_apc11,l_apc13,b_oob.oob06,b_oob.oob19
        IF STATUS THEN
#          CALL cl_err3("upd","apc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd apc10,11,13",1) #NO.FUN-710050
           LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                            #NO.FUN-710050 
           CALL s_errmsg('apc01,apc02',g_showmsg,'upd apc10,11,13',STATUS,1)                    #NO.FUN-710050
           LET g_success='N'
           RETURN
        END IF
     END IF
  END IF
  IF p_sw='-' THEN
     LET l_apc10 = l_apc10 - b_oob.oob09
     LET l_apc11 = l_apc11 - b_oob.oob10
     LET l_apc13 = l_apc13 + b_oob.oob10
     IF NOT cl_null(b_oob.oob19) THEN 
        EXECUTE t410_bu_19_p3 USING l_apc10,l_apc11,l_apc13,b_oob.oob06,b_oob.oob19
        IF STATUS THEN
#          CALL cl_err3("upd","apc_file",b_oob.oob06,b_oob.oob19,STATUS,"","upd apc10,11,13",1) #NO.FUN-710050
           LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                            #NO.FUN-710050 
           CALL s_errmsg('apc01,apc02',g_showmsg,'upd apc10,11,13',STATUS,1)                    #NO.FUN-710050
           LET g_success='N'
           RETURN
        END IF
     END IF
  END IF
END FUNCTION
#No.FUN-670047--end-- add
 
#No.TQC-810034--begin--
FUNCTION t410_oob06_chk(p_oob06,p_oob15,p_n)
DEFINE p_n           LIKE type_file.num5
DEFINE i             LIKE type_file.num5
DEFINE p_oob06       LIKE oob_file.oob06 
DEFINE p_oob15       LIKE oob_file.oob15
 
    LET g_errno = ''
    IF p_n > 1 THEN
       FOR i = 1 TO p_n-1
           IF g_ooz.ooz62 = 'N' THEN
              IF g_oob[i].oob06 = p_oob06 THEN
                 LET g_errno = 'atm-310'
                 EXIT FOR
              END IF
           ELSE
              IF g_oob[i].oob06 = p_oob06 AND 
                 g_oob[i].oob15 = p_oob15 THEN
                 LET g_errno = 'atm-310'
                 EXIT FOR
              END IF
           END IF
       END FOR
    END IF 
    
END FUNCTION
#No.TQC-810034---end---
 
#FUN-960141 add begin
FUNCTION t410_need()
   #IF g_ooa.ooa37 = 'Y' AND g_oob[l_ac].oob03 = '2'   #FUN-960140 mark
   IF  g_oob[l_ac].oob03 = '2'   #FUN-960140 add 
      AND g_oob[l_ac].oob04 = 'A' THEN
      CALL cl_set_comp_entry("oob17,oob18,oob21",TRUE)
      CALL cl_set_comp_required("oob17,oob18,oob21",TRUE)
   ELSE
      LET g_oob[l_ac].oob17 = NULL   
      LET g_oob[l_ac].oob18 = NULL   
      LET g_oob[l_ac].oob21 = NULL   
      CALL cl_set_comp_required("oob17,oob18,oob21",FALSE)
      CALL cl_set_comp_entry("oob17,oob18,oob21",FALSE)
      #IF g_ooa.ooa37 = 'Y' AND g_oob[l_ac].oob03 = '2'   #FUN-960140 mark
      IF g_oob[l_ac].oob03 = '2'   #FUN-960140 add
         AND g_oob[l_ac].oob04 = 'D'  THEN
         CALL cl_set_comp_entry("oob17",TRUE)
         CALL cl_set_comp_entry("oob23",TRUE)
      ELSE
         LET g_oob[l_ac].oob17 = NULL
         LET g_oob[l_ac].oob23 = NULL
         CALL cl_set_comp_entry("oob17",FALSE)
         CALL cl_set_comp_entry("oob23",FALSE)
      END IF 
   END IF 
END FUNCTION
 
FUNCTION t410_oob17(p_code)
   DEFINE p_code       LIKE  oob_file.oob17
   DEFINE l_nmaacti    LIKE  nma_file.nmaacti
   DEFINE l_nma01      LIKE  nma_file.nma01
   DEFINE l_nma05      LIKE  nma_file.nma05             #add by zhangym 110914 
 
   LET g_errno = ''
#   SELECT nma01,nmaacti INTO l_nma01,l_nmaacti FROM nma_file
   SELECT nma01,nmaacti,nma05 INTO l_nma01,l_nmaacti,g_oob_d[l_ac2].oob11_1 FROM nma_file    #modify by zhangym 110914
    WHERE nma01 = p_code
   CASE WHEN SQLCA.sqlcode = 100     LET g_errno = 'aap-007'
        WHEN l_nmaacti <> 'Y'        LET g_errno = 'axr-093'
        OTHERWISE LET g_errno = SQLCA.sqlcode USING '------'
    END CASE 
END FUNCTION
 
FUNCTION t410_oob18(p_code)
   DEFINE  p_code     LIKE oob_file.oob18
   DEFINE  l_nmc03    LIKE nmc_file.nmc03
   DEFINE  l_nmc05    LIKE nmc_file.nmc05
   DEFINE  l_nmcacti  LIKE nmc_file.nmcacti
 
   LET g_errno = ''
   SELECT nmc03,nmc05,nmcacti INTO l_nmc03,l_nmc05,l_nmcacti
     FROM nmc_file WHERE nmc01 = p_code
 
   CASE WHEN SQLCA.sqlcode = 100     LET g_errno = 'axr-095'
        WHEN l_nmcacti <> 'Y'        LET g_errno = 'axr-092'
        WHEN l_nmc03 <> '2'          LET g_errno = 'anm-333'
        OTHERWISE LET g_errno = SQLCA.sqlcode USING '------'
   END CASE 
 
   IF cl_null(g_errno) AND cl_null(g_oob[l_ac].oob21) THEN
      LET g_oob[l_ac].oob21 = l_nmc05
      DISPLAY BY NAME g_oob[l_ac].oob21
   END IF
END FUNCTION
 
FUNCTION t410_oob21(p_code)
   DEFINE  p_code     LIKE oob_file.oob21
   DEFINE  l_nmlacti  LIKE nml_file.nmlacti
 
   LET g_errno = '' 
   SELECT nmlacti INTO l_nmlacti FROM nml_file
    WHERE nml01 = p_code
 
   CASE WHEN SQLCA.sqlcode = 100     LET g_errno = 'anm-541'
        WHEN l_nmlacti = 'N'         LET g_errno = 'axr-097' 
        OTHERWISE  LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION
 
FUNCTION t410_show0()
   DEFINE   ls_msg  LIKE type_file.chr1000
 
   CASE g_ooa.ooa35
        WHEN '1'
          SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-505' AND ze02 = g_lang
        WHEN '2'
          SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-506' AND ze02 = g_lang
        WHEN '3'
          SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-507' AND ze02 = g_lang
        WHEN '4'
          SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-508' AND ze02 = g_lang
        OTHERWISE
          SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-502' AND ze02 = g_lang
   END CASE
       CALL cl_show_fld_cont()  
       CALL cl_set_comp_att_text("ooa36",ls_msg CLIPPED)   
END FUNCTION
  
#FUNCTION t410_bu_1A(p_sw)   #MOD-B30389 
FUNCTION t410_bu_1A(p_sw,p_se) 
   DEFINE p_sw       LIKE type_file.chr1
   DEFINE l_occ      RECORD LIKE occ_file.*
   DEFINE l_oma      RECORD LIKE oma_file.*
   DEFINE l_omc      RECORD LIKE omc_file.*
 # DEFINE l_oow18    LIKE oow_file.oow18   #TQC-B10053  mark
   DEFINE p_se       LIKE type_file.chr1   #MOD-B30389

   SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07
   INITIALIZE l_occ.* TO NULL
   INITIALIZE l_omc.* TO NULL
   IF p_sw = '+' THEN 
      INITIALIZE l_oma.* TO NULL
#TQC-B10053  ---BEGIN---
#     LET l_oow18 = ''
#     SELECT oow18 INTO l_oow18 FROM oow_file WHERE oow00 = '0'
#     IF STATUS OR cl_null(l_oow18) THEN
#        LET g_success = 'N' 
#        CALL s_errmsg('oow18','oow18 is null',b_oob.oob02,'axr-149',1) 
#        RETURN
#     END IF
#     LET l_oma.oma00 = '16' 
      LET l_oma.oma00 = '14'
#TQC-B10053  ---end---mark
      LET l_oma.oma02 = g_ooa.ooa02
      LET l_oma.oma03 = g_ooa.ooa03
      LET l_oma.oma032= g_ooa.ooa032
      LET l_oma.oma16 = g_ooa.ooa01
      SELECT * INTO l_occ.* FROM occ_file WHERE occ01=l_oma.oma03
      LET l_oma.oma68 = l_occ.occ07 
      SELECT occ02 INTO l_oma.oma69 FROM occ_file WHERE occ01 = l_oma.oma68
      LET l_oma.oma04 = l_oma.oma03 LET l_oma.oma05 = l_occ.occ08
      LET l_oma.oma23 = b_oob.oob07
      LET l_oma.oma14 = g_ooa.ooa14 LET l_oma.oma15 = g_ooa.ooa15
      LET l_oma.oma40 = l_occ.occ37 LET l_oma.oma25 = l_occ.occ43
      LET l_oma.oma32 = l_occ.occ45 LET l_oma.oma042= l_occ.occ11
      LET l_oma.oma043= l_occ.occ18 LET l_oma.oma044= l_occ.occ231
      LET g_plant2 = g_plant     #FUN-980020
      LET g_dbs2 = s_dbstring(g_dbs CLIPPED)   #FUN-9B0106
 
#     CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,l_oma.oma02,g_dbs2)   #FUN-980020 mark
      CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,l_oma.oma02,g_plant2) #FUN-980020
          RETURNING l_oma.oma11,l_oma.oma12
      #MOD-B30389--add--str--
      IF p_se = 'Y' THEN   #借方待抵都為24單據則產生的應收不含稅
      ELSE
      #MOD-B30389--add--end
         LET l_oma.oma21 = l_occ.occ41
         SELECT gec04,gec05,gec07 INTO l_oma.oma211,l_oma.oma212,l_oma.oma213
           FROM gec_file WHERE gec01=l_oma.oma21 AND gec011='2'
      END IF    #MOD-B30389
      LET l_oma.oma08  = '1'
      IF l_oma.oma23=g_aza.aza17 THEN
         LET l_oma.oma24=1
         LET l_oma.oma58=1
      ELSE
         CALL s_curr3(l_oma.oma23,l_oma.oma02,g_ooz.ooz17) RETURNING l_oma.oma24
         CALL s_curr3(l_oma.oma23,l_oma.oma09,g_ooz.ooz17) RETURNING l_oma.oma58
      END IF
      LET l_oma.oma13 = g_ooa.ooa13
      LET l_oma.oma18 = b_oob.oob11
      IF g_aza.aza63 = 'Y' THEN
         LET l_oma.oma181 = b_oob.oob111
      END IF
      LET l_oma.oma60 = b_oob.oob08
      LET l_oma.oma61 = b_oob.oob10
      LET l_oma.oma70 = '1'
      LET l_oma.oma50 = 0  LET l_oma.oma50t = 0
      LET l_oma.oma52 = 0
      LET l_oma.oma53 = 0
      LET l_oma.oma54t = b_oob.oob09
      LET l_oma.oma56t=b_oob.oob09*l_oma.oma24
      IF cl_null(l_oma.oma213) THEN  LET l_oma.oma213 = 'N' END IF
      IF cl_null(l_oma.oma211) THEN LET l_oma.oma211 = 0  END IF
      IF l_oma.oma213 = 'N' THEN
         LET l_oma.oma54 = l_oma.oma54t
         LET l_oma.oma56 = l_oma.oma56t
      ELSE
         LET l_oma.oma54 = l_oma.oma54t/(1+l_oma.oma211/100)
         LET l_oma.oma56 = l_oma.oma56t/(1+l_oma.oma211/100)
      END IF
      LET l_oma.oma54x = l_oma.oma54t - l_oma.oma54
      LET l_oma.oma56x = l_oma.oma56t - l_oma.oma56
      CALL cl_digcut(l_oma.oma54,t_azi04) RETURNING l_oma.oma54
      CALL cl_digcut(l_oma.oma54x,t_azi04) RETURNING l_oma.oma54x
      CALL cl_digcut(l_oma.oma54t,t_azi04) RETURNING l_oma.oma54t
      CALL cl_digcut(l_oma.oma56,g_azi04) RETURNING l_oma.oma56
      CALL cl_digcut(l_oma.oma56x,g_azi04) RETURNING l_oma.oma56x
      CALL cl_digcut(l_oma.oma56t,g_azi04) RETURNING l_oma.oma56t
      LET l_oma.oma51f = 0
      LET l_oma.oma51  = 0
      LET l_oma.oma55 = 0
      LET l_oma.oma57 = 0
      LET l_oma.omaconf = 'Y'
      LET l_oma.omavoid = 'N'
      LET l_oma.omauser = g_user
      LET l_oma.omagrup = g_grup
      #No.TQC-9C0057  --Begin
      #LET l_oma.oma64 = '0'
      LET l_oma.oma64 = '1'
      #No.TQC-9C0057  --End  
      LET l_oma.oma65 = '1'
      LET l_oma.oma930=s_costcenter(l_oma.oma15)
      #LET l_oma.omaplant=g_ooa.ooaplant    #FUN-960141 mark 090824
      LET l_oma.omalegal=g_ooa.ooalegal
      LET l_oma.oma66 = g_plant             #TQC-B10053 add
     #CALL s_auto_assign_no("AXR",l_oow18,l_oma.oma02,"16","oma_file","oma01","","","")      #TQC-B10053 mark 
      CALL s_auto_assign_no("AXR",g_ooz.ooz26,l_oma.oma02,"14","oma_file","oma01","","","")  #TQC-B10053 add 
            RETURNING li_result,l_oma.oma01
      IF (NOT li_result) THEN
         CALL s_errmsg('','',l_oma.oma01,'mfg-059',1)
         LET g_success = 'N'
         RETURN
      END IF 
 
      CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
      INITIALIZE l_omc.* TO NULL
      LET l_omc.omc01 = l_oma.oma01
      LET l_omc.omc02 = 1 
      LET l_omc.omc03 = l_oma.oma32
      LET l_omc.omc04 = l_oma.oma11
      LET l_omc.omc05 = l_oma.oma12
      LET l_omc.omc06 = l_oma.oma24
      LET l_omc.omc07 = l_oma.oma60
      LET l_omc.omc08 = l_oma.oma54t
      LET l_omc.omc09 = l_oma.oma56t
      LET l_omc.omc10 = 0
      LET l_omc.omc11 = 0
      LET l_omc.omc12 = l_oma.oma10
      LET l_omc.omc13 = l_omc.omc09-l_omc.omc11+g_net
      LET l_omc.omc14 = 0
      LET l_omc.omc15 = 0
      CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08
      CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09
      CALL cl_digcut(l_omc.omc13,g_azi04) RETURNING l_omc.omc13
      #LET l_omc.omcplant=g_ooa.ooaplant     #FUN-960141 mark 090824
      LET l_omc.omclegal=g_ooa.ooalegal
      #FUN-960141 add
      #LET l_oma.omaplant = g_ooa.ooaplant   #FUN-960141 mark 090824
      LET l_oma.omalegal = g_ooa.ooalegal
      #LET l_omc.omcplant = g_ooa.ooaplant   #FUN-960141 mark 090824
      LET l_omc.omclegal = g_ooa.ooalegal
      #FUN-960141 end
 
      
      LET l_oma.omaoriu = g_user      #No.FUN-980030 10/01/04
      LET l_oma.omaorig = g_grup      #No.FUN-980030 10/01/04
#No.FUN-AB0034 --begin
    IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
    IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
    IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
      INSERT INTO oma_file VALUES(l_oma.*)
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('','','ins oma err',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      INSERT INTO omc_file VALUES(l_omc.*)
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('','','ins omc err',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
       
      UPDATE oob_file SET oob06 = l_oma.oma01
       WHERE oob01 = b_oob.oob01 AND oob02 = b_oob.oob02
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('','','upd oob err',SQLCA.sqlcode,1) 
         LET g_success = 'N'
      END IF
   END IF
 
   IF p_sw = '-' THEN
      INITIALIZE l_oma.* TO NULL
      SELECT oma33,oma55,oma57 
        INTO l_oma.oma33,l_oma.oma55,l_oma.oma57 
        FROM oma_file
       WHERE oma01 = b_oob.oob06
      IF NOT cl_null(l_oma.oma33) THEN
         CALL s_errmsg('oob06','',b_oob.oob06,'axr-417',1)	
         LET g_success = 'N'
      END IF
      IF l_oma.oma55>0 OR l_oma.oma57>0 THEN 
         CALL s_errmsg('oob06','',b_oob.oob06,'alm-915',1) 
         LET g_success = 'N'
      END IF 
      DELETE FROM oma_file WHERE oma01 = b_oob.oob06
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06','','del oma',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      DELETE FROM omc_file WHERE omc01 = b_oob.oob06 
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06','','del omc',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      UPDATE oob_file SET oob06 = NULL
       WHERE oob01 = b_oob.oob01 AND oob02 = b_oob.oob02
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06','','upd oob',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
   END IF
END FUNCTION 
 
FUNCTION t410_bu_2A(p_sw) 
   DEFINE p_sw            LIKE type_file.chr1
   DEFINE l_nme  RECORD   LIKE nme_file.* 
#FUN-B30166--add--str
   DEFINE l_year     LIKE type_file.chr4
   DEFINE l_month    LIKE type_file.chr4
   DEFINE l_day      LIKE type_file.chr4
   DEFINE l_dt       LIKE type_file.chr20
   DEFINE l_date1    LIKE type_file.chr20
   DEFINE l_time     LIKE type_file.chr20
   DEFINE l_nme27    LIKE nme_file.nme27
#FUN-B30166--add--end
 
   INITIALIZE l_nme.* TO NULL
   IF p_sw = '+' THEN
      LET l_nme.nme00 = '0' 
      LET l_nme.nme01 = b_oob.oob17
      LET l_nme.nme02 = g_ooa.ooa02
      LET l_nme.nme03 = b_oob.oob18
      LET l_nme.nme04 = b_oob.oob09
      LET l_nme.nme05 = b_oob.oob12  
      LET l_nme.nme07 = g_ooa.ooa24
      LET l_nme.nme08 = b_oob.oob10
      LET l_nme.nme10 = g_ooa.ooa33
      LET l_nme.nme12 = b_oob.oob01
      LET l_nme.nme13 = g_ooa.ooa032
      LET l_nme.nme14 = b_oob.oob21
      LET l_nme.nme15 = b_oob.oob13
      LET l_nme.nme16 = g_ooa.ooa02
      LET l_nme.nmeacti='Y'
      LET l_nme.nmeuser=g_user
      LET l_nme.nmegrup=g_grup
      LET l_nme.nmedate=TODAY
      LET l_nme.nme21=b_oob.oob02
      LET l_nme.nme22='01'
      LET l_nme.nme23=b_oob.oob04
      LET l_nme.nme24='9'
      LET l_nme.nmelegal=g_ooa.ooalegal
 
      LET l_nme.nmeoriu = g_user      #No.FUN-980030 10/01/04
      LET l_nme.nmeorig = g_grup      #No.FUN-980030 10/01/04

#FUN-B30166--add--str
      LET l_date1 = g_today
      LET l_year = YEAR(l_date1)USING '&&&&'
      LET l_month = MONTH(l_date1) USING '&&'
      LET l_day = DAY(l_date1) USING  '&&'
      LET l_time = TIME(CURRENT)
      LET l_dt   = l_year CLIPPED,l_month CLIPPED,l_day CLIPPED,
                   l_time[1,2],l_time[4,5],l_time[7,8]
      SELECT MAX(nme27) + 1 INTO l_nme.nme27 FROM nme_file
       WHERE nme27[1,14] = l_dt
      IF cl_null(l_nme.nme27) THEN
         LET l_nme.nme27 = l_dt,'000001'
      END if
#FUN-B30166--add--end

      INSERT INTO nme_file VALUES(l_nme.*)
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06','','ins nme',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
   END IF
 
   IF p_sw = '-' THEN
      DELETE FROM nme_file WHERE nme12 = g_ooa.ooa01
                             AND nme21 = b_oob.oob02    #add by zhangym 120726
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06','','del nme',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      #FUN-B40056  --begin
      DELETE FROM tic_file WHERE tic04 = g_ooa.ooa01
      IF SQLCA.sqlcode THEN
         CALL s_errmsg('tic04','','del tic',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      #FUN-B40056  --end
   END IF
END FUNCTION
   
#FUN-960141 add end
 
      
#FUN-A90003--Add--Begin--# 
FUNCTION t410_b_move_to_2()
   LET g_oob_d[l_ac2].oob02_1 = b_oob.oob02
   LET g_oob_d[l_ac2].oob03_d = b_oob.oob03
   LET g_oob_d[l_ac2].oob04_1 = b_oob.oob04
   CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
                RETURNING g_oob_d[l_ac2].oob04_1_d
   LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
   LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
   LET g_oob_d[l_ac2].oob20_1 = b_oob.oob20
   LET g_oob_d[l_ac2].oob23_1 = b_oob.oob23
   LET g_oob_d[l_ac2].oob17_1 = b_oob.oob17
   LET g_oob_d[l_ac2].oob18_1 = b_oob.oob18
   LET g_oob_d[l_ac2].oob21_1 = b_oob.oob21
   LET g_oob_d[l_ac2].oob07_1 = b_oob.oob07
   LET g_oob_d[l_ac2].oob08_1 = b_oob.oob08
   LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
   LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
   LET g_oob_d[l_ac2].oob11_1 = b_oob.oob11
   IF g_aza.aza63='Y' THEN                 
      LET g_oob_d[l_ac2].oob111_1 = b_oob.oob111
   END IF                                   
   LET g_oob_d[l_ac2].oob12_1 = b_oob.oob12
   LET g_oob_d[l_ac2].oob13_1 = b_oob.oob13
   LET g_oob_d[l_ac2].oob14_1 = b_oob.oob14
   LET g_oob_d[l_ac2].oobud01_1 = b_oob.oobud01
   LET g_oob_d[l_ac2].oobud02_1 = b_oob.oobud02
   LET g_oob_d[l_ac2].oobud03_1 = b_oob.oobud03
   LET g_oob_d[l_ac2].oobud04_1 = b_oob.oobud04
   LET g_oob_d[l_ac2].oobud05_1 = b_oob.oobud05
   LET g_oob_d[l_ac2].oobud06_1 = b_oob.oobud06
   LET g_oob_d[l_ac2].oobud07_1 = b_oob.oobud07
   LET g_oob_d[l_ac2].oobud08_1 = b_oob.oobud08
   LET g_oob_d[l_ac2].oobud09_1 = b_oob.oobud09
   LET g_oob_d[l_ac2].oobud10_1 = b_oob.oobud10
   LET g_oob_d[l_ac2].oobud11_1 = b_oob.oobud11
   LET g_oob_d[l_ac2].oobud12_1 = b_oob.oobud12
   LET g_oob_d[l_ac2].oobud13_1 = b_oob.oobud13
   LET g_oob_d[l_ac2].oobud14_1 = b_oob.oobud14
   LET g_oob_d[l_ac2].oobud15_1 = b_oob.oobud15
END FUNCTION
 
FUNCTION t410_b_move_back_2()
   LET b_oob.oob02 = g_oob_d[l_ac2].oob02_1
   LET b_oob.oob03 = g_oob_d[l_ac2].oob03_d
   LET b_oob.oob04 = g_oob_d[l_ac2].oob04_1
   LET b_oob.oob06 = g_oob_d[l_ac2].oob06_1
   LET b_oob.oob15 = g_oob_d[l_ac2].oob15_1
   LET b_oob.oob07 = g_oob_d[l_ac2].oob07_1
   LET b_oob.oob08 = g_oob_d[l_ac2].oob08_1
   LET b_oob.oob09 = g_oob_d[l_ac2].oob09_1
   LET b_oob.oob10 = g_oob_d[l_ac2].oob10_1
   LET b_oob.oob11 = g_oob_d[l_ac2].oob11_1
   IF g_aza.aza63='Y' THEN                   
      LET b_oob.oob111 =  g_oob_d[l_ac2].oob111_1 
   END IF                                   
   LET b_oob.oob12 = g_oob_d[l_ac2].oob12_1
   LET b_oob.oob13 = g_oob_d[l_ac2].oob13_1
   LET b_oob.oob14 = g_oob_d[l_ac2].oob14_1
   LET b_oob.oob19 = g_oob_d[l_ac2].oob19_1       
   LET b_oob.oobud01 = g_oob_d[l_ac2].oobud01_1
   LET b_oob.oobud02 = g_oob_d[l_ac2].oobud02_1
   LET b_oob.oobud03 = g_oob_d[l_ac2].oobud03_1
   LET b_oob.oobud04 = g_oob_d[l_ac2].oobud04_1
   LET b_oob.oobud05 = g_oob_d[l_ac2].oobud05_1
   LET b_oob.oobud06 = g_oob_d[l_ac2].oobud06_1
   LET b_oob.oobud07 = g_oob_d[l_ac2].oobud07_1
   LET b_oob.oobud08 = g_oob_d[l_ac2].oobud08_1
   LET b_oob.oobud09 = g_oob_d[l_ac2].oobud09_1
   LET b_oob.oobud10 = g_oob_d[l_ac2].oobud10_1
   LET b_oob.oobud11 = g_oob_d[l_ac2].oobud11_1
   LET b_oob.oobud12 = g_oob_d[l_ac2].oobud12_1
   LET b_oob.oobud13 = g_oob_d[l_ac2].oobud13_1
   LET b_oob.oobud14 = g_oob_d[l_ac2].oobud14_1
   LET b_oob.oobud15 = g_oob_d[l_ac2].oobud15_1
    LET b_oob.oob20 = g_oob_d[l_ac2].oob20_1
    LET b_oob.oob23 = g_oob_d[l_ac2].oob23_1
    LET b_oob.oob17 = g_oob_d[l_ac2].oob17_1
    LET b_oob.oob18 = g_oob_d[l_ac2].oob18_1
    LET b_oob.oob21 = g_oob_d[l_ac2].oob21_1
    LET b_oob.ooblegal = g_legal 
END FUNCTION

FUNCTION t410_set_entry_b_2()
 
    MESSAGE ''
 
    #CALL cl_set_comp_entry("oob07_1,oob08_1",TRUE) #mark by andy 2017/4/27 14:15:30
    CALL cl_set_comp_entry("oob15_1",TRUE)
 
END FUNCTION
 
FUNCTION t410_set_no_entry_b_2()
 
    MESSAGE ''
    IF NOT cl_null(g_ooa.ooa23) THEN
       CALL cl_set_comp_entry("oob07_1",FALSE)
    END IF
    IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
       (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
       CALL cl_set_comp_entry("oob07_1,oob08_1",FALSE)
    END IF
    IF INFIELD(oob04_1) THEN
       IF NOT (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2') THEN   
          IF g_ooz.ooz62 <> 'Y' OR g_oob_d[l_ac2].oob03_d<>'2' OR
             g_oob_d[l_ac2].oob04_1<>'1' THEN
             CALL cl_set_comp_entry("oob15_1",FALSE)
          END IF
       END IF   #MOD-630069
      #若oob04_1='9'時,oob15_1預設值為0,無須維護
       IF g_oob_d[l_ac2].oob04_1 = '9' THEN
          CALL cl_set_comp_entry("oob15_1",FALSE)
       END IF
    END IF
    IF g_oob_d[l_ac2].oob07_1=g_aza.aza17 THEN
       CALL cl_set_comp_entry("oob08_1",FALSE)
       LET g_oob_d[l_ac2].oob08_1=1.0
       DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
    END IF

END FUNCTION
 
FUNCTION t410_set_entry_b_1_2()
   CALL cl_set_comp_entry("oob02_1,oob03_d,oob06_1,oob19_1,oob15_1,oob14_1,oob09_1,oob10_1,oob12_1",TRUE)  #modify by andy oob07_1,oob08_1 2017/4/27 14:16:41
END FUNCTION
 
FUNCTION t410_set_no_entry_b_1_2()
 IF g_ooa.ooa34 matches '[Ss]' THEN
   CALL cl_set_comp_entry("oob02_1,oob03_d,oob06_1,oob19_1,oob15_1,oob14_1,oob07_1, 
                           oob08_1,oob09_1,oob10_1,oob12_1",FALSE)
 END IF
END FUNCTION

FUNCTION t410_set_entry_b1_2()
    DEFINE l_aag05  LIKE aag_file.aag05   #MOD-920163 add
 
    IF g_oob_d[l_ac2].oob03_d='1' THEN
       IF g_oob_d[l_ac2].oob04_1='3' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1='4' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[349]' AND   
          NOT(g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN  
          CALL cl_set_comp_entry("oob15_1",TRUE)
       END IF
    END IF
    IF g_oob_d[l_ac2].oob03_d='2' THEN
       IF g_oob_d[l_ac2].oob04_1='1' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1='9' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[19]' THEN
          CALL cl_set_comp_entry("oob15_1",TRUE)
       END IF
    END IF

    LET l_aag05=''
    SELECT aag05 INTO l_aag05 FROM aag_file
     WHERE aag01=g_oob_d[l_ac2].oob11_1  
       AND aag00=g_bookno1        
    IF l_aag05='Y' THEN
       CALL cl_set_comp_entry("oob13_1",TRUE)
    END IF

END FUNCTION
 
FUNCTION t410_set_no_entry_b1_2()
    CALL cl_set_comp_entry("oob15_1,oob19_1",FALSE)
    CALL cl_set_comp_entry("oob13_1",FALSE)   
END FUNCTION

FUNCTION t410_need_2()
   IF  g_oob_d[l_ac2].oob03_d = '2'   
      AND g_oob_d[l_ac2].oob04_1 = 'A' THEN
      CALL cl_set_comp_entry("oob17_1,oob18_1,oob21_1",TRUE)
      CALL cl_set_comp_required("oob17_1,oob18_1,oob21_1",TRUE)
   ELSE
      LET g_oob_d[l_ac2].oob17_1 = NULL   
      LET g_oob_d[l_ac2].oob18_1 = NULL   
      LET g_oob_d[l_ac2].oob21_1 = NULL   
      CALL cl_set_comp_required("oob17_1,oob18_1,oob21_1",FALSE)
      CALL cl_set_comp_entry("oob17_1,oob18_1,oob21_1",FALSE)
      IF g_oob_d[l_ac2].oob03_d = '2'   
         AND g_oob_d[l_ac2].oob04_1 = 'D'  THEN
         CALL cl_set_comp_entry("oob17_1",TRUE)
         CALL cl_set_comp_entry("oob23_1",TRUE)
      ELSE
         LET g_oob_d[l_ac2].oob17_1 = NULL
         LET g_oob_d[l_ac2].oob23_1 = NULL
         CALL cl_set_comp_entry("oob17_1",FALSE)
         CALL cl_set_comp_entry("oob23_1",FALSE)
      END IF 
   END IF 
END FUNCTION

FUNCTION t410_oob06_1_chk_2(p_oob06_1,p_oob15_1,p_n)
DEFINE p_n           LIKE type_file.num5
DEFINE i             LIKE type_file.num5
DEFINE p_oob06_1       LIKE oob_file.oob06
DEFINE p_oob15_1       LIKE oob_file.oob15
 
    LET g_errno = ''
    IF p_n > 1 THEN
       FOR i = 1 TO p_n-1
           IF g_ooz.ooz62 = 'N' THEN
              IF g_oob_d[i].oob06_1 = p_oob06_1 THEN
                 LET g_errno = 'atm-310'
                 EXIT FOR
              END IF
           ELSE
              IF g_oob_d[i].oob06_1 = p_oob06_1 AND 
                 g_oob_d[i].oob15_1 = p_oob15_1 THEN
                 LET g_errno = 'atm-310'
                 EXIT FOR
              END IF
           END IF
       END FOR
    END IF 
    
END FUNCTION

FUNCTION t410_oob06_1_12_2()            # 借方檢查 : TT
  DEFINE l_nmg           RECORD LIKE nmg_file.*
  DEFINE l_npk           RECORD LIKE npk_file.*
  DEFINE l_cnt           LIKE type_file.num5        
  DEFINE l_sql           LIKE type_file.chr1000     
  DEFINE l_nmz20         LIKE nmz_file.nmz20
  DEFINE tot1,tot2,tot3  LIKE type_file.num20_6     
  DEFINE l_aag05         LIKE aag_file.aag05       
  DEFINE l_bookno        LIKE aag_file.aag00       
  DEFINE l_gem10         LIKE gem_file.gem10        
 
   IF g_ooz.ooz04='N' THEN RETURN END IF
 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob_d[l_ac2].oob06_1
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 ='Y')    #NO:4181
  IF NOT STATUS AND g_oob_d[l_ac2].oob04_1<>'3' THEN  
     CALL cl_err('','axr-202',0)  
     LET g_errno='N' 
     RETURN  
  END IF 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob_d[l_ac2].oob06_1
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 !='Y')   
  IF STATUS  THEN                                 
     CALL cl_err('sel nmg',STATUS,0)  
     LET g_errno='N' 
     RETURN  
  END IF 

   CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(l_nmg.nmg01,'aoo-081',1)
   END IF

   IF l_nmg.nmgconf='N' THEN 
      CALL cl_err('','axr-194',0) 
      LET g_errno='N' 
      RETURN  
   END IF
   IF l_nmg.nmgconf='X' THEN 
      CALL cl_err('','9024',0) 
      LET g_errno='N' 
      RETURN  
   END IF
   IF l_nmg.nmg18 !=g_ooa.ooa03 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          
   IF l_nmg.nmg19 !=g_ooa.ooa032 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF         
   IF l_nmg.nmg23-l_nmg.nmg24 = 0 THEN
      CALL cl_err('','axr-184',1) 
      LET g_errno='N' 
      RETURN 
   END IF
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'  
      AND oob01 <> g_ooa.ooa01   
      AND oob15 = g_oob_d[l_ac2].oob15_1   
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF

   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                             AND aag00=g_bookno1                
   IF l_aag05 = 'Y' THEN
      LET l_gem10=s_costcenter(l_nmg.nmg11)
      IF NOT cl_null(l_gem10) THEN
         LET g_oob_d[l_ac2].oob13_1=l_gem10
      ELSE
         LET g_oob_d[l_ac2].oob13_1=l_nmg.nmg11
      END IF  
   ELSE
      LET g_oob_d[l_ac2].oob13_1=''
   END IF
   #---->為防止收支單輸入兩筆單身
   LET l_sql = "SELECT npk_file.* FROM npk_file ",
               " WHERE npk00= '",g_oob_d[l_ac2].oob06_1,"'",
               "       AND npk01 ='",g_oob_d[l_ac2].oob15_1,"'"  
   PREPARE t410_oob06_1_npk FROM l_sql
   DECLARE t410_oob06_1_npk_c1 CURSOR FOR t410_oob06_1_npk
   FOREACH t410_oob06_1_npk_c1 INTO l_npk.*
     IF SQLCA.sqlcode THEN
        CALL cl_err('t410_oob06_1_npk_c1',SQLCA.sqlcode,0)
        LET g_errno = 'N' EXIT FOREACH
     END IF
     IF l_npk.npk05!=g_ooa.ooa23 THEN    #幣別與沖帳不一致
        CALL cl_err('','axr-144',1) LET g_errno='N' EXIT FOREACH
     END IF
     LET g_oob_d[l_ac2].oob07_1=l_npk.npk05   #幣別
     LET g_oob_d[l_ac2].oob08_1=l_npk.npk06   #匯率
     LET g_oob_d[l_ac2].oob09_1=l_npk.npk08 - l_nmg.nmg24 - tot1   #原幣入帳金額
     LET g_oob_d[l_ac2].oob10_1=l_npk.npk09-(l_nmg.nmg24*l_npk.npk06)-tot2  #本幣入帳金額
     SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
     CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1     
     CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1      

     IF l_nmg.nmg29='Y' THEN
        LET g_oob_d[l_ac2].oob11_1=l_npk.npk071  #科目編號        
        IF g_aza.aza63='Y' THEN                                
           LET g_oob_d[l_ac2].oob111_1=l_npk.npk073  #科目二編號   
        END IF                                                
     ELSE
        LET g_oob_d[l_ac2].oob11_1=l_npk.npk07   #科目編號
        IF g_aza.aza63='Y' THEN                               
           LET g_oob_d[l_ac2].oob111_1=l_npk.npk072  #科目二編號   
        END IF                                               
     END IF

     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
             RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
             RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
     END IF

     SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
     IF l_nmz20 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
        IF g_apz.apz27 = 'Y' THEN                
           LET g_oob_d[l_ac2].oob08_1 = l_nmg.nmg09
        ELSE                                      
        	 LET g_oob_d[l_ac2].oob08_1 = l_npk.npk06   
        END IF                                       	    
        IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
           LET g_oob_d[l_ac2].oob08_1 = l_npk.npk06
        END IF

        CALL s_g_np('3','2',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1) RETURNING tot3

        IF (tot1+g_oob_d[l_ac2].oob09_1+l_nmg.nmg24) = l_nmg.nmg23 THEN
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
        END IF
     END IF

     LET g_oob_d[l_ac2].oob12_1=l_npk.npk10  
     EXIT FOREACH
  END FOREACH
END FUNCTION

FUNCTION t410_oob06_1_item_2()      # 檢查待抵/應收帳款
   DEFINE p_sw           LIKE type_file.chr1                   
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omb          RECORD LIKE omb_file.*
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE l_omb14t       LIKE omb_file.omb14t   
   DEFINE l_omb16t       LIKE omb_file.omb16t   
   DEFINE l_oea61        LIKE oea_file.oea61    
   DEFINE l_oea1008      LIKE oea_file.oea1008  
   DEFINE l_per          LIKE oea_file.oea261   
 
  #LET g_sql="SELECT * FROM ",cl_get_target_table(g_plant,'oma_file'), 
  LET g_sql="SELECT * FROM oma_file ",#FUN-A50102
            " WHERE oma01=?"
         #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        
        #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql 
  PREPARE t410_oob06_1_item_p1 FROM g_sql
  DECLARE t410_oob06_1_item_c1 CURSOR FOR t410_oob06_1_item_p1
  OPEN t410_oob06_1_item_c1 USING g_oob_d[l_ac2].oob06_1
  FETCH t410_oob06_1_item_c1 INTO l_oma.*
  IF STATUS THEN CALL cl_err('sel oma',STATUS,1) LET g_errno='N' END IF
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  IF l_oma.omaconf='N' THEN
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
   LET tot1 = 0
   LET tot2 = 0
   SELECT * INTO l_omb.* FROM omb_file
    WHERE omb01 = g_oob_d[l_ac2].oob06_1 AND omb03 = g_oob_d[l_ac2].oob15_1
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob15 = g_oob_d[l_ac2].oob15_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)      
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF

   IF l_oma.oma00='11' OR l_oma.oma00='12' OR l_oma.oma00='13' THEN
      CASE l_oma.oma00
        WHEN 11
           SELECT oea61,oea1008,oea261
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
        WHEN 12
           SELECT oea61,oea1008,oea262
             INTO l_oea61,l_oea1008,l_per 
             FROM oga_file,oea_file
            WHERE oga01 = l_oma.oma16
             AND oga16 = oea01
        WHEN 13
           SELECT oea61,oea1008,oea263
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
      END CASE

      IF cl_null(l_per) THEN
         LET l_per = 100
      END IF

      IF cl_null(l_oea1008) THEN
         LET l_oea1008 = 100
      END IF

      IF cl_null(l_oea61) THEN
         LET l_oea61 = 100
      END IF

      IF g_oma.oma213 = 'Y' THEN
         LET l_omb14t = l_omb.omb14t * l_per / l_oea1008
         LET l_omb16t = l_omb.omb16t * l_per / l_oea1008
      ELSE
         LET l_omb14t = l_omb.omb14t * l_per / l_oea61
         LET l_omb16t = l_omb.omb16t * l_per / l_oea61
      END IF
   ELSE
      LET l_omb14t = l_omb.omb14t
      LET l_omb16t = l_omb.omb16t
   END IF

   LET g_oob_d[l_ac2].oob09_1 = l_omb14t - l_omb.omb34 - tot1
   LET g_oob_d[l_ac2].oob10_1 = l_omb16t - l_omb.omb35 - tot2

   IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
      IF g_apz.apz27 = 'Y' THEN                 
         LET g_oob_d[l_ac2].oob08_1 = l_omb.omb36
      ELSE                                      
      	 LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24    
      END IF                                    	    
      IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24
         DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
      END IF

      CALL s_g_np('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                  RETURNING tot3

      IF (tot1+g_oob_d[l_ac2].oob09_1+l_omb.omb34) = l_omb14t THEN  
         LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2

         DISPLAY BY NAME g_oob_d[l_ac2].oob10_1

      END IF
   END IF

   SELECT azi04 INTO t_azi04 FROM azi_file               
   WHERE azi01 = g_oob_d[l_ac2].oob07_1

  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1    
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1  

  DISPLAY BY NAME g_oob_d[l_ac2].oob09_1
  DISPLAY BY NAME g_oob_d[l_ac2].oob10_1

END FUNCTION

FUNCTION t410_acct_code_2()
   DEFINE l_ool RECORD LIKE ool_file.*
   SELECT * INTO l_ool.* FROM ool_file WHERE ool01=g_ooa.ooa13
   CASE WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '5'
             LET b_oob.oob11 = l_ool.ool54
             IF g_aza.aza63='Y' THEN              
                LET b_oob.oob111 = l_ool.ool541    
             END IF                               
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '6'
             LET b_oob.oob11 = l_ool.ool51
             IF g_aza.aza63='Y' THEN              
                LET b_oob.oob111 = l_ool.ool511   
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '7' AND
             g_oob_d[l_ac2].oob10_1 > 0   
             LET b_oob.oob11 = l_ool.ool52
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool521    
             END IF
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = 'A'
             LET b_oob.oob11 = l_ool.ool33
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool331   
             END IF                              

        WHEN g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '7'
             LET b_oob.oob11 = l_ool.ool53
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool531   
             END IF                               
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '8'
             LET b_oob.oob11 = l_ool.ool23
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool231   
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '2'
             LET b_oob.oob11 = l_ool.ool25
             IF g_aza.aza63='Y' THEN             
                LET b_oob.oob111 = l_ool.ool251    
             END IF                               
        OTHERWISE

           IF b_oob.oob04 != g_oob_d[l_ac2].oob04_1 THEN
              LET b_oob.oob11 = null
              LET b_oob.oob111= null     
           END IF
           LET g_oob_d[l_ac2].oob11_1 = null
           LET g_oob_d[l_ac2].oob111_1= null 

   END CASE

   IF cl_null(g_oob_d[l_ac2].oob11_1) THEN
      LET g_oob_d[l_ac2].oob11_1 = b_oob.oob11
      LET g_oob_d[l_ac2].oob111_1= b_oob.oob111 
      DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
      DISPLAY BY NAME g_oob_d[l_ac2].oob111_1    
   ELSE
      LET b_oob.oob11 =g_oob_d[l_ac2].oob11_1
      LET b_oob.oob111=g_oob_d[l_ac2].oob111_1   
   END IF

END FUNCTION

FUNCTION t410_oob06_1_2()
DEFINE l_nmg  RECORD LIKE nmg_file.*  
  LET g_errno=' '

  IF g_oob_d[l_ac2].oob03_d='1' THEN
     IF g_oob_d[l_ac2].oob04_1='1' THEN CALL t410_oob06_1_11() END IF
     IF g_oob_d[l_ac2].oob04_1='3' THEN CALL t410_oob06_1_13('2') END IF
     IF g_oob_d[l_ac2].oob04_1='9' THEN CALL t410_oob06_1_19('1') END IF   
  END IF
  IF g_oob_d[l_ac2].oob03_d='2' THEN
     IF g_oob_d[l_ac2].oob04_1='1' THEN CALL t410_oob06_1_13('1') END IF
     IF g_oob_d[l_ac2].oob04_1='9' THEN CALL t410_oob06_1_19('2') END IF  
  END IF
  
  DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                  g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                  g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                  g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1   
 
END FUNCTION

FUNCTION t410_oob18_1_2(p_code)
   DEFINE  p_code     LIKE oob_file.oob18
   DEFINE  l_nmc03    LIKE nmc_file.nmc03
   DEFINE  l_nmc05    LIKE nmc_file.nmc05
   DEFINE  l_nmcacti  LIKE nmc_file.nmcacti
 
   LET g_errno = ''
   SELECT nmc03,nmc05,nmcacti INTO l_nmc03,l_nmc05,l_nmcacti
     FROM nmc_file WHERE nmc01 = p_code
 
   CASE WHEN SQLCA.sqlcode = 100     LET g_errno = 'axr-095'
        WHEN l_nmcacti <> 'Y'        LET g_errno = 'axr-092'
        WHEN l_nmc03 <> '2'          LET g_errno = 'anm-333'
        OTHERWISE LET g_errno = SQLCA.sqlcode USING '------'
   END CASE 
 
   IF cl_null(g_errno) AND cl_null(g_oob_d[l_ac2].oob21_1) THEN
      LET g_oob_d[l_ac2].oob21_1 = l_nmc05
      DISPLAY BY NAME g_oob_d[l_ac2].oob21_1
   END IF
END FUNCTION

FUNCTION t410_oob07_1(p_cmd)
DEFINE
      p_cmd        LIKE type_file.chr1,     
      l_azi01      LIKE azi_file.azi01,
      l_aziacti    LIKE azi_file.aziacti
 
      LET g_errno = ' '
      SELECT azi01,aziacti INTO l_azi01,l_aziacti
        FROM azi_file
       WHERE azi01 = g_oob_d[l_ac2].oob07_1
      CASE
          WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aap-002'
                                   LET l_azi01 = NULL
                                   LET l_aziacti = NULL
          WHEN l_aziacti = 'N' LET g_errno = '9028'
          OTHERWISE            LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
END FUNCTION

FUNCTION t410_oob09_1_11_2(l_sw,l_cmd)                # 借方檢查 : 支票
   DEFINE l_sw      LIKE type_file.chr1      
   DEFINE l_cmd     LIKE type_file.chr1        
   DEFINE l_nmh02   LIKE nmh_file.nmh02
   DEFINE l_nmh32   LIKE nmh_file.nmh32
   DEFINE l_nmydmy3 LIKE nmy_file.nmydmy3
   DEFINE l_oob09_1,l_oob10_1 LIKE oob_file.oob09
   DEFINE tot1,tot2,tot3  LIKE oob_file.oob09
   DEFINE l_nmz59         LIKE nmz_file.nmz59
   DEFINE l_sql           LIKE type_file.chr1000   
 
   IF g_ooz.ooz04='N' THEN RETURN TRUE END IF

   LET l_sql=
   " SELECT nmh02,nmh32,nmydmy3 ",
   "  FROM nmh_file,nmy_file ",
   " WHERE nmh01= '",g_oob_d[l_ac2].oob06_1,"' AND nmh01[1,",g_doc_len,"]=nmyslip ",
   "   AND nmh38 <> 'X' "
   PREPARE nmh_p3 FROM l_sql
   DECLARE nmh_c3 CURSOR FOR nmh_p3
   OPEN nmh_c3
   FETCH nmh_c3 INTO l_nmh02,l_nmh32,l_nmydmy3

   IF STATUS THEN
      LET l_nmh02 = 0
    ELSE
       IF l_nmydmy3='Y' THEN
          CALL cl_err(g_oob_d[l_ac2].oob06_1,'axr-066',0)
          RETURN FALSE  #No:8326
       END IF
   END IF

   SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file   
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = '1' AND oob04 = '1'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)       
      AND oob01 = ooa01 AND ooaconf <> 'X'   
      AND ooa34 <> '9' 
   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0
      LET l_oob10_1 = 0
   END IF

   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)      
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
   IF l_sw = '1' THEN
         IF (l_oob09_1+g_oob_d[l_ac2].oob09_1) > l_nmh02 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
   ELSE
      SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz59 = 'N' THEN    #不做月底重評時, 依原判斷
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('4','1',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
         IF (tot2+g_oob_d[l_ac2].oob10_1) > tot3 THEN
            CALL cl_err('','axr-185',1)
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob09_1_12_2(l_sw,l_cmd)                # 借方檢查 : TT
   DEFINE l_sw    LIKE type_file.chr1        
   DEFINE l_cmd   LIKE type_file.chr1       
   DEFINE l_nmh02,l_nmh32 LIKE nmh_file.nmh02
   DEFINE l_oob09_1,l_oob10_1 LIKE oob_file.oob09
   DEFINE l_nmz20         LIKE nmz_file.nmz20
 
   SELECT SUM(npk08),SUM(npk09) INTO l_nmh02,l_nmh32 FROM nmg_file,npk_file
    WHERE nmg00=npk00 AND nmg00= g_oob_d[l_ac2].oob06_1
      AND npk01=g_oob_d[l_ac2].oob15_1  
      AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
      AND nmgconf <> 'X'
 
   IF cl_null(l_nmh02) THEN LET l_nmh02 = 0 LET l_nmh32 = 0 END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file  
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = '1' AND oob04 = '2'
      AND oob01 = ooa01 AND ooaconf <> 'X'   
      AND oob01 <> g_ooa.ooa01   
      AND oob15 = g_oob_d[l_ac2].oob15_1  
 
   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0
      LET l_oob10_1 = 0
   END IF

   IF l_sw = '1' THEN
      IF (l_oob09_1+g_oob_d[l_ac2].oob09_1) > l_nmh02 THEN
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz20 = 'N' THEN      #不做月底重評時, 依原判斷
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('3','2',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
          IF g_oob_d[l_ac2].oob10_1 > tot3 THEN              
            CALL cl_err('','axr-185',1)
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2         
            LET g_oob_d[l_ac2].oob10_1 = tot3 - l_oob10_1    
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob09_1_13_2(l_sw,l_cmd)  # 檢查 :3:取待抵 1:取應收
   DEFINE l_sw           LIKE type_file.chr1      
   DEFINE l_cmd          LIKE type_file.chr1        
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omc          RECORD LIKE omc_file.*
   DEFINE l_message      LIKE type_file.chr1000     
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE tot5,tot6      LIKE oob_file.oob09    
   DEFINE tot7,tot8      LIKE oob_file.oob09   
   DEFINE l_oob09_1        LIKE oob_file.oob09
   DEFINE l_diff         LIKE oob_file.oob10
   DEFINE l_msg1,l_msg2  LIKE type_file.chr1000     
 
   LET tot1 = 0
   LET tot2 = 0
 
   SELECT * INTO l_oma.* FROM oma_file
    WHERE oma01=g_oob_d[l_ac2].oob06_1 AND omavoid='N'
   IF STATUS THEN
      LET l_oma.oma54t = 0
      LET l_oma.oma56t = 0
      LET l_oma.oma55  = 0
      LET l_oma.oma57  = 0
      LET l_oma.oma61  = 0   
   END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)     
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF tot1 IS NULL THEN LET tot1=0 END IF   
   IF tot2 IS NULL THEN LET tot2=0 END IF   
 
   SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob15 = g_oob_d[l_ac2].oob15_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)     
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF tot5 IS NULL THEN LET tot5=0 END IF
   IF tot6 IS NULL THEN LET tot6=0 END IF

   #待扺或貸方
   SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob19 = g_oob_d[l_ac2].oob19_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)     
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF tot7 IS NULL THEN LET tot7=0 END IF
   IF tot8 IS NULL THEN LET tot8=0 END IF
 
   SELECT * INTO l_omc.* FROM omc_file
    WHERE omc01=g_oob_d[l_ac2].oob06_1 AND omc02=g_oob_d[l_ac2].oob19_1
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","omc_file",g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob19_1,SQLCA.sqlcode,"","select omc_file",1)
   END IF
 
   IF tot1 IS NULL THEN LET tot1 = 0 END IF
   IF tot2 IS NULL THEN LET tot2 = 0 END IF
 
   IF l_sw = '1' THEN
      IF g_ooz.ooz62 = 'Y' THEN #衝帳至項次  
         IF (tot1+g_oob_d[l_ac2].oob09_1) > (l_oma.oma54t - l_oma.oma55) THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
         IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
            IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55) THEN
              IF g_ooz.ooz62 = 'Y' THEN
                 CALL s_g_np('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                      RETURNING tot3                 
                 #判斷本幣金額是否超過
                 IF (tot5+g_oob_d[l_ac2].oob09_1) > tot3 THEN  
                    CALL cl_err('','axr-189',1)   
                    LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
                 END IF
              END IF
            END IF
         END IF
      ELSE    #不衝賬至項次
         IF (tot7+g_oob_d[l_ac2].oob09_1) > (l_omc.omc08 - l_omc.omc10) THEN
            CALL cl_err('','axr-185',1) 
            LET g_oob_d[l_ac2].oob09_1=g_oob_d_t.oob09_1
            DISPLAY g_oob_d[l_ac2].oob09_1 TO oob09_1
            RETURN FALSE
         END IF
      END IF
   ELSE
      IF g_ooz.ooz07 = 'N' OR g_oob_d[l_ac2].oob07_1 = g_aza.aza17 THEN
            IF (tot8+g_oob_d[l_ac2].oob10_1) > (l_omc.omc09  - l_omc.omc11) THEN
               CALL cl_err('','axr-185',1) 
               LET g_oob_d[l_ac2].oob10_1=g_oob_d_t.oob10_1        
               DISPLAY g_oob_d[l_ac2].oob10_1 TO oob10_1      
               RETURN FALSE
            END IF
            IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob_d[l_ac2].oob10_1)!= (l_omc.omc09  - l_omc.omc11) THEN
               CALL cl_err('','axr-193',1)
            END IF

         #No.+010by plum 010426 add 若非本國幣別:沖帳-立帳若只剩三元
         #(怕因匯差問題)
         IF g_aza.aza17 != g_oob_d[l_ac2].oob07_1 THEN
            LET l_diff= (l_omc.omc09  - l_omc.omc11)- (tot8+g_oob_d[l_ac2].oob10_1)  
            IF l_diff <=3 AND l_diff >0 THEN
               CALL cl_getmsg('mfg-030',g_lang) RETURNING l_msg1
               CALL cl_getmsg('mfg-031',g_lang) RETURNING l_msg2
               LET g_msg=l_msg1 CLIPPED,l_omc.omc09  USING '#######&',  
                         " ",l_msg2 CLIPPED,
                        (l_omc.omc11+tot8+g_oob_d[l_ac2].oob10_1) USING '#######&'  
               CALL cl_err(g_msg,'mfg-012',1)
            END IF
         END IF
      END IF
      #判斷本幣金額是否超過
      IF g_ooz.ooz07 = 'Y' THEN   #有做月底重評時, 需判斷不可超過未沖金額
            IF (tot8+g_oob_d[l_ac2].oob10_1) > l_omc.omc13 THEN  
               CALL cl_err('','axr-185',1)
               LET g_oob_d[l_ac2].oob10_1 = l_omc.omc13 - tot8 
               DISPLAY g_oob_d[l_ac2].oob10_1 TO oob10_1         
               RETURN FALSE
            END IF
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob_d[l_ac2].oob10_1)!= (l_omc.omc09  - l_omc.omc11) THEN
               CALL cl_err('','axr-193',1)
            END IF
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
FUNCTION t410_oob09_1_19_2(l_sw,l_cmd,l_sw2)           # 借/貸方檢查 : A/P 
   DEFINE l_sw           LIKE type_file.chr1       
   DEFINE l_cmd          LIKE type_file.chr1       
   DEFINE l_apa          RECORD LIKE apa_file.*
   DEFINE l_apc          RECORD LIKE apc_file.*  
   DEFINE p05,p05f       LIKE type_file.num20_6     
   DEFINE l_oob09_1,l_oob10_1        LIKE oob_file.oob09
   DEFINE l_apz27        LIKE apz_file.apz27
   DEFINE l_sw2          LIKE type_file.chr1  

   SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file
     WHERE apa01=g_oob_d[l_ac2].oob06_1
       AND apa01=apc01 
       AND apc02=g_oob_d[l_ac2].oob19_1  

   IF STATUS THEN
      LET l_apc.apc10 = 0
      LET l_apc.apc11  = 0
   END IF
 
   LET p05f = 0 LET p05 = 0

   IF l_sw2 = '1' THEN
      SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05 FROM apg_file,apf_file
       WHERE apg04=g_oob_d[l_ac2].oob06_1              ## 尚未確認也視同已付,須扣除
         AND apg06=g_oob_d[l_ac2].oob19_1
         AND apg01=apf01 AND apf41='N' AND apg01 <> g_ooa.ooa01
   ELSE
      SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05 FROM aph_file,apf_file
       WHERE aph04=g_oob_d[l_ac2].oob06_1              ## 尚未確認也視同已付,須扣除
         AND aph17=g_oob_d[l_ac2].oob19_1
         AND aph01=apf01 AND apf41='N' AND aph01 <> g_ooa.ooa01
   END IF

   IF p05f IS NULL THEN LET p05f=0 END IF
   IF p05  IS NULL THEN LET p05 =0 END IF

   LET l_apc.apc10=l_apc.apc10+p05f
   LET l_apc.apc11=l_apc.apc11+p05

   IF l_sw2 = '1' THEN
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
       WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = '1' AND oob04 = '9'
         AND oob19 = g_oob_d[l_ac2].oob19_1
         AND oob01 = ooa01 AND ooaconf = 'N'     
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)       
   ELSE
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
       WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = '2' AND oob04 = '9'
         AND oob19 = g_oob_d[l_ac2].oob19_1
         AND oob01 = ooa01 AND ooaconf = 'N'    
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)       
   END IF

   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0
      LET l_oob10_1 = 0
   END IF
   IF l_sw = '1' THEN

      IF g_oob_d[l_ac2].oob09_1 > (l_apc.apc08-l_apc.apc10) THEN   
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE

      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
      IF l_apz27 = 'N' THEN      #不做月底重評時, 依原判斷
         IF g_oob_d[l_ac2].oob10_1 > (l_apc.apc09-l_apc.apc11) THEN   
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('2',l_apa.apa00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > tot3 - p05 THEN  
            CALL cl_err('','axr-185',1)
            LET g_oob_d[l_ac2].oob10_1 = tot3 - p05 - l_oob10_1 
            DISPLAY BY NAME g_oob_d[l_ac2].oob10_1
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION t410_b_fill_2(p_wc3)            
DEFINE p_wc3           LIKE type_file.chr1000   
 
    LET g_sql =
       "SELECT oob02,oob03,oob04,'',oob06,oob19,oob15,oob20,oob23,oob17,oob18,oob21, ",    
        "       oob11,oob111,oob13,oob14,", 
        "       oob07,oob08,oob09,oob10,oob12,",
        "       oobud01,oobud02,oobud03,oobud04,oobud05,",
        "       oobud06,oobud07,oobud08,oobud09,oobud10,",
        "       oobud11,oobud12,oobud13,oobud14,oobud15 ",
        " FROM oob_file ",
        " WHERE oob01 ='",g_ooa.ooa01,"'",  #單頭
        " AND oob03 = '2' ",            
        " AND ",p_wc3 CLIPPED,                     #單身
        " ORDER BY 1"
 
    PREPARE t410_pb11 FROM g_sql
    DECLARE oob_curs11                       #SCROLL CURSOR
        CURSOR FOR t410_pb11
    CALL g_oob_d.clear()
    LET g_rec_b2 = 0
    LET g_cnt = 1
    FOREACH oob_curs11 INTO g_oob_d[g_cnt].*   #單身 ARRAY 填充
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        CALL s_oob04(g_oob_d[g_cnt].oob03_d,g_oob_d[g_cnt].oob04_1)
                RETURNING g_oob_d[g_cnt].oob04_1_d
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_oob_d.deleteElement(g_cnt)
    LET g_rec_b2=g_cnt - 1
    DISPLAY g_rec_b2 TO FORMONLY.cn3
     CALL t410_bp_refresh_2() 
END FUNCTION

FUNCTION t410_bp_refresh_2()

   IF g_bgjob = 'Y' THEN
      RETURN
   END IF

   DISPLAY ARRAY g_oob_d TO s_oob_d.* ATTRIBUTE(COUNT=g_rec_b2,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION help         
         CALL cl_show_help() 
 
      ON ACTION controlg     
         CALL cl_cmdask()     
 
 
   END DISPLAY
END FUNCTION

FUNCTION t410_oob06_1_11()            # 借方檢查 : 支票
  DEFINE l_nmh            RECORD LIKE nmh_file.*
  DEFINE l_nmydmy3             LIKE nmy_file.nmydmy3
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6    
  DEFINE l_sql          LIKE type_file.chr1000    
  DEFINE l_aag05        LIKE aag_file.aag05  
  DEFINE l_bookno       LIKE aag_file.aag00   
 
  IF g_ooz.ooz04='N' THEN RETURN END IF

  LET l_sql="SELECT nmh_file.*,nmydmy3 FROM nmh_file,nmy_file ",
            " WHERE nmh01= '",g_oob_d[l_ac2].oob06_1,"'",
            "   AND nmh01[1,",g_doc_len,"]=nmyslip"
   PREPARE nmh_p21 FROM l_sql
   DECLARE nmh_c21 CURSOR FOR nmh_p21
   OPEN nmh_c21
   FETCH nmh_c21 INTO l_nmh.*,l_nmydmy3

   IF STATUS THEN CALL cl_err('sel nmh',STATUS,1) LET g_errno='N' END IF

   CALL s_get_bookno(YEAR(l_nmh.nmh04)) RETURNING g_flag, g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(l_nmh.nmh04,'aoo-081',1)
   END IF

   IF l_nmydmy3='Y' THEN
     #若收票單別其拋轉傳票為Y,不可用來沖AR,
       CALL cl_err(g_oob_d[l_ac2].oob06_1,'axr-066',0)
       LET g_errno='N' RETURN
   ELSE  
      LET g_oob_d[l_ac2].oob11_1 = l_nmh.nmh26   
      DISPLAY BY NAME g_oob_d[l_ac2].oob11_1   
      LET g_oob_d[l_ac2].oob111_1 = l_nmh.nmh261   
      DISPLAY BY NAME g_oob_d[l_ac2].oob111_1   
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
           RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
           RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
   END IF
   IF l_nmh.nmh38 = 'N' THEN
      CALL cl_err(g_oob_d[l_ac2].oob06_1,'axr-194',0) LET g_errno='N' RETURN
   END IF
   IF l_nmh.nmh38 = 'X' THEN
      CALL cl_err(g_oob_d[l_ac2].oob06_1,'9024',0) LET g_errno = 'N' RETURN
   END IF

   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)   
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  IF l_nmh.nmh11!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
  IF l_nmh.nmh30!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
  IF l_nmh.nmh03!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_nmh.nmh17>=l_nmh.nmh02 THEN
     CALL cl_err('','axr-185',1) LET g_errno='N' END IF
  IF l_nmh.nmh38 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  LET g_oob_d[l_ac2].oob07_1=l_nmh.nmh03
  LET g_oob_d[l_ac2].oob08_1=l_nmh.nmh32/l_nmh.nmh02
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 LET g_oob_d[l_ac2].oob09_1=l_nmh.nmh02-l_nmh.nmh17
  LET g_oob_d[l_ac2].oob09_1=l_nmh.nmh02-l_nmh.nmh17-tot1
  LET g_oob_d[l_ac2].oob10_1=g_oob_d[l_ac2].oob09_1*g_oob_d[l_ac2].oob08_1
 
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz59 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                     
        LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh39
     ELSE                                            
     	  LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh28         
     END IF                                               
     IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
        LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh28
     END IF
     CALL s_g_np('4','1',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1) RETURNING tot3
     IF (g_oob_d[l_ac2].oob09_1+tot1+l_nmh.nmh17) = l_nmh.nmh02 THEN
        LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
     END IF
  END IF
 
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1  
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1  

  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1       
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_nmh.nmh15
  ELSE
     LET g_oob_d[l_ac2].oob13_1=''
  END IF

  LET g_oob_d[l_ac2].oob14_1=l_nmh.nmh31
  LET g_oob_d[l_ac2].oob12_1=l_nmh.nmh18   
END FUNCTION

FUNCTION t410_oob06_1_13(p_sw)            # 檢查待抵/應收帳款
  DEFINE p_sw             LIKE type_file.chr1             # 2:取待抵 1:取應收
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*   
  DEFINE tot1,tot2,tot3 LIKE oob_file.oob09
  DEFINE l_oox10        LIKE oox_file.oox10
  DEFINE l_aag05        LIKE aag_file.aag05  
  DEFINE tot4,tot4t     LIKE type_file.num20_6     
  DEFINE l_bookno       LIKE aag_file.aag00   

  LET g_sql="SELECT oma_file.*,omc_file.* ",
            #"  FROM ",cl_get_target_table(g_plant,'omc_file'),",", 
            #          cl_get_target_table(g_plant,'oma_file'),  
            "  FROM omc_file,oma_file ",#FUN-A50102 
            " WHERE oma01=omc01 AND omc01=? AND omc02=?"   
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql 
  PREPARE t410_oob06_1_13_p1 FROM g_sql
  DECLARE t410_oob06_1_13_c1 CURSOR FOR t410_oob06_1_13_p1
  OPEN t410_oob06_1_13_c1 USING g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob19_1
  FETCH t410_oob06_1_13_c1 INTO l_oma.*,l_omc.*    
  IF STATUS THEN CALL cl_err('sel omc',"axr-031",1) LET g_errno='N' END IF   
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  IF l_oma.omaconf='N' THEN  
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
  IF p_sw='2' AND l_oma.oma00[1,1]!='2' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF p_sw='1' AND l_oma.oma00[1,1]!='1' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF l_oma.oma68 != g_ooa.ooa03 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma69 != g_ooa.ooa032 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma23!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_oma.oma54t<=l_oma.oma55 THEN
     CALL cl_err('','axr-190',1) LET g_errno='N' END IF
 #原幣沖完但本幣未沖完
  IF l_oma.oma54t=l_oma.oma55 AND l_oma.oma56t!=l_oma.oma57 THEN
     CALL cl_err('','axr-193',1) LET g_errno='N' END IF
  IF l_oma.oma02 > g_ooa.ooa02 THEN
     CALL cl_err('','axr-371',0) LET g_errno = 'N'
  END IF
##-----------------------------------------------
  CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
  IF g_flag='1' THEN
     CALL cl_err(l_oma.oma02,'aoo-081',1)
  END IF
  LET g_oob_d[l_ac2].oob07_1=l_oma.oma23
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
   LET g_oob_d[l_ac2].oob08_1=l_oma.oma24
   LET tot1 = 0
   LET tot2 = 0
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file 
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob19 = g_oob_d[l_ac2].oob19_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)      
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF
   LET g_oob_d[l_ac2].oob09_1 = l_omc.omc08  - l_omc.omc10 - tot1 
   LET g_oob_d[l_ac2].oob10_1 = l_omc.omc09  - l_omc.omc11 - tot2 

   IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
      IF g_apz.apz27 = 'Y' THEN                       
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma60   
      ELSE                                            
      	 LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24           
      END IF                                               
      IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24
      END IF
      CALL s_g_np1('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,'',g_oob_d[l_ac2].oob19_1)     
           RETURNING tot3
      #取得衝帳單的待扺金額
      CALL t410_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
      CALL cl_digcut(tot4,t_azi04) RETURNING tot4              
      CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t    
      #未衝金額扣除待扺
      LET tot3 = tot3 - tot4t
      IF (tot1+g_oob_d[l_ac2].oob09_1+l_omc.omc10) = l_omc.omc08  THEN  
         LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
      END IF
   END IF
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1    
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1     
  LET g_oob_d[l_ac2].oob11_1=l_oma.oma18
  IF g_aza.aza63='Y' THEN                 
     LET g_oob_d[l_ac2].oob111_1=l_oma.oma181 
  END IF                                  

 LET l_aag05=''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1    
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_oma.oma15
  ELSE   #MOD-730022
     LET g_oob_d[l_ac2].oob13_1=''   
  END IF

  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
  END IF

  IF p_sw = '2' THEN
     LET g_oob_d[l_ac2].oob14_1=l_oma.oma16
  ELSE
     LET g_oob_d[l_ac2].oob14_1=l_oma.oma10
  END IF

  IF p_sw = '2' THEN   #待抵
     IF l_oma.oma00 = '25' THEN
        SELECT COUNT(*) INTO g_cnt FROM oob_file
         WHERE oob06 = g_oob_d[l_ac2].oob14_1
           AND oob03 = '2'
           AND oob01 = g_ooa.ooa01
        IF g_cnt <= 0 THEN
           CALL cl_err(g_oob_d[l_ac2].oob06_1,'axr-353',1)
           LET g_errno = 'N'
        END IF
     END IF
  END IF

END FUNCTION
 
FUNCTION t410_oob06_1_19(l_sw)         # 借/貸方檢查 : A/P   
  DEFINE l_apa            RECORD LIKE apa_file.*
  DEFINE l_apc            RECORD LIKE apc_file.*   
  DEFINE p05,p05f       LIKE type_file.num20_6    
  DEFINE l_apz27        LIKE apz_file.apz27
  DEFINE l_amt3         LIKE type_file.num20_6     
  DEFINE l_amtf,l_amt   LIKE type_file.num20_6    
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6   
  DEFINE l_aag05        LIKE aag_file.aag05 
  DEFINE l_bookno       LIKE aag_file.aag00   
  DEFINE l_sw           LIKE type_file.chr1  

  IF cl_null(g_oob_d[l_ac2].oob19_1) THEN LET g_oob_d[l_ac2].oob19_1 = '1' END IF 
   
  SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file 
   WHERE apa01= g_oob_d[l_ac2].oob06_1 
     AND apa01=apc01 
     AND apc02= g_oob_d[l_ac2].oob19_1    
  IF STATUS THEN 
     CALL cl_err3("sel","apa_file",g_oob_d[l_ac2].oob06_1,"",STATUS,"","sel apa",1)  
     LET g_errno='N' 
  END IF
  IF l_apa.apa06!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
  IF l_apa.apa07!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
  IF l_apa.apa13!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_apa.apa41 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  CALL s_get_bookno(YEAR(l_apa.apa02)) RETURNING g_flag,g_bookno1,g_bookno2
  IF g_flag='1' THEN
     CALL cl_err(l_apa.apa02,'aoo-081',1)
  END IF

  #須考慮未確認沖帳資料
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
   WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob19=g_oob_d[l_ac2].oob19_1   
     AND oob01 = ooa01 AND ooaconf = 'N'
     AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)       
     AND oob03 = g_oob_d[l_ac2].oob03_d
     AND oob04 = g_oob_d[l_ac2].oob04_1
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  LET p05f = 0 LET p05 = 0
  IF l_sw = '1' THEN
     SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
       FROM apg_file,apf_file
      WHERE apg04=g_oob_d[l_ac2].oob06_1
        AND apg06=g_oob_d[l_ac2].oob19_1
        AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
  ELSE
     SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05
       FROM aph_file,apf_file
      WHERE aph04=g_oob_d[l_ac2].oob06_1
        AND aph17=g_oob_d[l_ac2].oob19_1
        AND aph01=apf01 AND apf41='N' AND aph01<>g_ooa.ooa01
  END IF
  IF p05f IS NULL THEN LET p05f=0 END IF
  IF p05  IS NULL THEN LET p05 =0 END IF
  LET l_amtf = l_apc.apc08-l_apc.apc10-l_apc.apc16-tot1-p05f
  IF g_apz.apz27 = 'N' THEN
     LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_apc.apc16*l_apc.apc06)-tot2-p05
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  ELSE
     LET l_amt  = l_apc.apc13 -(l_apc.apc16*l_apc.apc07)-tot2-p05
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  END IF
  LET g_oob_d[l_ac2].oob07_1=l_apa.apa13
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
  LET g_oob_d[l_ac2].oob08_1=l_apc.apc06  
  LET g_oob_d[l_ac2].oob09_1=l_amtf
  LET g_oob_d[l_ac2].oob10_1=l_amt
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1     
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1     
  LET g_oob_d[l_ac2].oob11_1=l_apa.apa54
  IF g_aza.aza63='Y' THEN                 
     LET g_oob_d[l_ac2].oob111_1=l_apa.apa541  
  END IF                                  

  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1         
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_apa.apa22
  ELSE
     LET g_oob_d[l_ac2].oob13_1=''
  END IF

  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
  END IF

  LET g_oob_d[l_ac2].oob14_1=l_apa.apa08
  LET g_oob_d[l_ac2].oob12_1=l_apa.apa25 
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'

  IF l_apz27 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                  
        LET g_oob_d[l_ac2].oob08_1 = l_apa.apa72
     ELSE                                      
     	  LET g_oob_d[l_ac2].oob08_1 = l_apc.apc06    
     END IF                                   	     
     IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN 
        LET g_oob_d[l_ac2].oob08_1 = l_apc.apc06   
     END IF
     CALL s_g_np('2',l_apa.apa00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                 RETURNING l_amt3
     #未付金額-已KEY未確認-留置金額
     IF (tot1+g_oob_d[l_ac2].oob09_1+p05f+l_apc.apc10) = l_apc.apc08 THEN
        LET g_oob_d[l_ac2].oob10_1 = l_amt3-tot2-p05-(l_apc.apc16*l_apc.apc06)   
     END IF
     CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1 
  END IF
END FUNCTION 

FUNCTION t410_set_comb_oob04()
  DEFINE l_ooc      RECORD LIKE ooc_file.*
  DEFINE comb_value STRING
  DEFINE comb_item  LIKE type_file.chr1000    
                                                                                                           
#   LET comb_value = '1,2,3,4,5,6,7,8,9,A,E,F,Q'                #No.MOD-B30227 Mark                                                                       
    LET comb_value = '3,4,5,6,7,8,9,A,E,F,Q'                    #No.MOD-B30227 add                                                                      
                                                                                                         
    SELECT ze03 INTO comb_item FROM ze_file                                                                                      
     WHERE ze01='axr-220' AND ze02=g_lang                                                                                       

    DECLARE ooc_cs CURSOR FOR
     SELECT * FROM ooc_file
    FOREACH ooc_cs INTO l_ooc.*
        LET comb_value = comb_value CLIPPED,',',l_ooc.ooc01
        LET comb_item  = comb_item  CLIPPED,',',l_ooc.ooc01 CLIPPED,'.',
                                                l_ooc.ooc02
    END FOREACH
    CALL cl_set_combo_items('oob04',comb_value,comb_item)
END FUNCTION

FUNCTION t410_set_comb_oob04_1()
  DEFINE l_ooc      RECORD LIKE ooc_file.*
  DEFINE comb_value STRING
  DEFINE comb_item  LIKE type_file.chr1000    
                                                                                                           
    LET comb_value = '1,2,3,4,7,A,B,C,D,E,F,Q'                                                                                       
                                                                                                         
    SELECT ze03 INTO comb_item FROM ze_file                                                                                      
     WHERE ze01='axr-219' AND ze02=g_lang                                                                                       

    DECLARE ooc_cs1 CURSOR FOR
     SELECT * FROM ooc_file
    FOREACH ooc_cs1 INTO l_ooc.*
        LET comb_value = comb_value CLIPPED,',',l_ooc.ooc01
        LET comb_item  = comb_item  CLIPPED,',',l_ooc.ooc01 CLIPPED,'.',
                                                l_ooc.ooc02
    END FOREACH
    CALL cl_set_combo_items('oob04_1',comb_value,comb_item)
END FUNCTION 

FUNCTION t410_b2()
DEFINE l_ac_t          LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #未取消的ARRAY CNT
       l_row,l_col     LIKE type_file.num5,   #No.FUN-680123 SMALLINT,                     #分段輸入之行,列數
       l_n,l_cnt       LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #檢查重複用
       l_lock_sw       LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #單身鎖住否
       p_cmd           LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #處理狀態
       l_possible      LIKE type_file.num5,   #No.FUN-680123 SMALLINT, #用來設定判斷重複的可能性
       l_b2            LIKE type_file.chr1000,#No.FUN-680123 VARCHAR(30),
       l_flag          LIKE type_file.num10,  #No.FUN-680123 INTEGER,
       oob10_t         LIKE oob_file.oob10,
       l_nmh32         LIKE nmh_file.nmh32,
       l_aag07         LIKE aag_file.aag07,
       oob08_t         LIKE oob_file.oob08,  #FUN-4C0013
       oob09_t         LIKE oob_file.oob09,  #FUN-4C0013
       l_allow_insert  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可新增否
       l_allow_delete  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可刪除否
       ls_tmp          STRING,
       l_ooa34         LIKE ooa_file.ooa34,
       l_aag05         LIKE aag_file.aag05   #MOD-5B0012
DEFINE l_nmh04         LIKE nmh_file.nmh04   #FUN-660035
DEFINE l_i             LIKE type_file.num5   #TQC-6B0067
DEFINE l_oma00         LIKE oma_file.oma00   #MOD-940420
DEFINE l_apa00         LIKE apa_file.apa00   #MOD-940420
DEFINE l_ac2_t         LIKE type_file.num5   #FUN-A90003 Add
 
    LET l_ooa34 = g_ooa.ooa34      #FUN-550049
 
    LET g_action_choice = ""
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    #No.FUN-8A0075--BEGIN--
    #IF g_ooa.ooa34 matches '[Ss]' THEN       #FUN-550049
    #   CALL cl_err('','apm-030',0)
    #   RETURN
    #END IF
    #FUN-8A0075--END--
 
 
    CALL t410_g_b()                 #先由應收票據或TT自動產生借方單身
    CALL t410_b_fill_2(g_wc3)       #FUN-A90003 Add
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = " SELECT * FROM oob_file WHERE oob01=? AND oob02=? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t410_bcl1 CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
      LET l_ac_t = 0
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")
 
      INPUT ARRAY g_oob_d WITHOUT DEFAULTS FROM s_oob_d.*
            ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
 
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac2 = ARR_CURR()
            DISPLAY l_ac2 TO FORMONLY.cn3
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()
            LET g_success = 'Y'   
            BEGIN WORK
 
            OPEN t410_cl USING g_ooa.ooa01   
            IF STATUS THEN
               CALL cl_err("OPEN t410_cl:", STATUS, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF
            FETCH t410_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE t410_cl 
               ROLLBACK WORK 
               RETURN
            END IF
            IF g_rec_b2>=l_ac2 THEN
               LET p_cmd='u'
               LET g_oob_d_t.* = g_oob_d[l_ac2].*  #BACKUP
               OPEN t410_bcl1 USING g_ooa.ooa01,g_oob_d_t.oob02_1
               IF STATUS THEN
                  CALL cl_err("OPEN t410_bcl1:", STATUS, 1)
                  LET l_lock_sw = "Y"
                  CLOSE t410_bcl1
                  ROLLBACK WORK
               ELSE
                  FETCH t410_bcl1 INTO b_oob.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      CALL t410_b_move_to_2()
                  END IF
               END IF
               CALL t410_need_2()
               CALL t410_set_entry_b_2()
               CALL t410_set_entry_b_1_2()    
               CALL t410_set_no_entry_b_2()
               CALL t410_set_no_entry_b1_2()
               CALL t410_set_entry_b1_2()
               CALL t410_set_no_entry_b_1_2()    
               CALL cl_show_fld_cont()               
               CALL cl_show_fld_cont()    
            END IF
 
        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_success = 'N'   
               CANCEL INSERT
            END IF
            CALL t410_b_move_back_2()
            SELECT COUNT(*) INTO l_n FROM oob_file
             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
            IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
               IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                  (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                  IF NOT t410_oob09_1_13_2('2',p_cmd) THEN
                  END IF
               END IF
            END IF

           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
           END IF
           IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                     NEXT FIELD oob06_1
                  END IF 
               END IF 
            END IF   
           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
                      oob15 = g_oob_d[l_ac2].oob15_1 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15_1
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15_1
                 END IF
              END IF
              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
                 g_oob_d_t.oob15_1 IS NULL THEN
                 CALL t410_oob06_1_12_2()
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06_1
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 CALL t410_oob06_1_item_2()
              END IF
          END IF 
                
            INSERT INTO oob_file VALUES(b_oob.*)
            IF SQLCA.sqlcode THEN
               LET g_success = 'N'   
               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  
               CANCEL INSERT
            END IF
            CALL t410_mlog('A')
            CALL t410_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'INSERT O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
                  LET l_ooa34 = '0'
               END IF                                 
               LET g_rec_b2=g_rec_b2+1
               DISPLAY g_rec_b2 TO FORMONLY.cn3
               COMMIT WORK
            ELSE
               MESSAGE 'INSERT ERR'
               ROLLBACK WORK
            END IF
            
        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oob_d[l_ac2].* TO NULL    
            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
                LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
            END IF
            LET b_oob.oob01=g_ooa.ooa01

            LET b_oob.ooblegal=g_ooa.ooalegal

            
            #add by andy 2017/4/27 14:22:12------s-------
            LET g_oob_d[l_ac2].oob08_1=1  
            LET oob08_t=g_oob_d[l_ac2].oob08_1   #No.+010
           # 971021 TT/NR/CN/AR 不允許修改匯率
           IF g_oob_d[l_ac2].oob08_1 = 0 OR g_oob_d[l_ac2].oob08_1 = 1 OR
              cl_null(g_oob_d[l_ac2].oob08_1) THEN
              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob_d[l_ac2].oob08_1
              DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
           END IF
           LET oob08_t=g_oob_d[l_ac2].oob08_1
           #add by andy 2017/4/27 14:22:12------e-------
            LET g_oob_d[l_ac2].oob09_1=0
            LET g_oob_d[l_ac2].oob10_1=0
            LET g_oob_d[l_ac2].oob20_1='N'                 
            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料
            LET g_oob_d[l_ac2].oob03_d = '2'               #新輸入資料
            LET g_oob_d[l_ac2].oob04_1 = '1'               #新輸入資料
            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料   
            CALL t410_set_entry_b_2()
            CALL t410_set_entry_b_1_2()   
            CALL t410_set_no_entry_b_2()
            CALL t410_need_2()            
            CALL cl_show_fld_cont()     
 
            NEXT FIELD oob02_1
 
        BEFORE FIELD oob02_1                            #default 序號
           IF g_oob_d[l_ac2].oob02_1 IS NULL OR g_oob_d[l_ac2].oob02_1 = 0 THEN
                IF l_ac2>1 THEN LET g_chr=g_oob_d[l_ac2-1].oob03_d END IF
                SELECT MAX(oob02)+1 INTO g_oob_d[l_ac2].oob02_1 FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 
                IF g_oob_d[l_ac2].oob02_1 IS NULL THEN
                    LET g_oob_d[l_ac2].oob02_1 = 1
                END IF
           END IF
 
        AFTER FIELD oob02_1                        #check 序號是否重複
            IF NOT cl_null(g_oob_d[l_ac2].oob02_1) THEN
               IF g_oob_d[l_ac2].oob02_1 != g_oob_d_t.oob02_1 OR g_oob_d_t.oob02_1 IS NULL THEN
                  SELECT count(*) INTO l_n FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob_d[l_ac2].oob02_1
                  IF l_n > 0 THEN
                     LET g_oob_d[l_ac2].oob02_1 = g_oob_d_t.oob02_1
                     CALL cl_err('',-239,0) NEXT FIELD oob02_1
                  END IF
               END IF
            END IF
 
        AFTER FIELD oob03_d
           IF NOT cl_null(g_oob_d[l_ac2].oob03_d) THEN
              IF g_oob_d[l_ac2].oob03_d NOT MATCHES "[12]" THEN NEXT FIELD oob03_d END IF
              CALL t410_need_2()                                                                                             
                 IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN                                                                             
                    LET l_cnt = 0                                                                                                   
                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
                       WHERE ooc01 = g_oob_d[l_ac2].oob04_1                                                                              
                    IF l_cnt = 0 THEN                                                                                               
                       IF g_oob_d[l_ac2].oob03_d='1' THEN
                           IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,A,F]' THEN   
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04_1                                                                                       
                          END IF                                                                                                    
                       ELSE                                                                                                         
                           IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,A,C,D,E,Q]' THEN  
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04_1                                                                                       
                          END IF                                                                                                    
                       END IF                                                                                                       
                    END IF                                                                                                          
                 END IF
           END IF
 
        BEFORE FIELD oob04_1
           CALL t410_set_entry_b_2()
 
        AFTER FIELD oob04_1
           IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN
              CALL t410_need_2()
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM ooc_file
                 WHERE ooc01 = g_oob_d[l_ac2].oob04_1
              IF l_cnt = 0 THEN
                 IF g_oob_d[l_ac2].oob03_d='1' THEN
                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,A,E,F,Q]' THEN  
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04_1
                    END IF
                 ELSE
                   IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,A,B,C,D,E,Q]' THEN   
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04_1
                    END IF
                 END IF
              END IF
              SELECT azi04 INTO t_azi04 FROM azi_file                 
               WHERE azi01 = g_oob_d[l_ac2].oob07_1  
             #若oob04_1='9'時,oob15_1預設值為0,無須維護
              IF g_oob_d[l_ac2].oob04_1='9' THEN
                 LET g_oob_d[l_ac2].oob15_1=0
                 DISPLAY BY NAME g_oob_d[l_ac2].oob15_1
              END IF
              CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
                   RETURNING g_oob_d[l_ac2].oob04_1_d
              CALL t410_acct_code_2()
              IF g_oob_d[l_ac2].oob11_1 IS NULL THEN
                 SELECT ooc03 INTO g_oob_d[l_ac2].oob11_1 FROM ooc_file
                  WHERE ooc01=g_oob_d[l_ac2].oob04_1
                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1   
              END IF
              IF g_aza.aza63='Y' THEN
                 IF g_oob_d[l_ac2].oob111_1 IS NULL THEN
                    SELECT ooc04 INTO g_oob_d[l_ac2].oob111_1 FROM ooc_file
                     WHERE ooc01=g_oob_d[l_ac2].oob04_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                 END IF
              END IF
              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = "7" AND
                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN
                 CALL cl_err('','axr-204',0) NEXT FIELD oob04_1
              END IF
              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[567]" AND
                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob_d[l_ac2].oob09_1 = g_ooa31_diff
                 LET g_oob_d[l_ac2].oob10_1 = g_ooa32_diff
                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
	            	 DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
              END IF
              IF g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[23]" AND
                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob_d[l_ac2].oob09_1 = -g_ooa31_diff
                 LET g_oob_d[l_ac2].oob10_1 = -g_ooa32_diff
                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
	               DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
	               DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
	               DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
              END IF
              #MOD-B30240--add--str--
              IF g_oob_d[l_ac2].oob04_1 = 'D' THEN    #支票
                 SELECT apz13 INTO g_apz13 FROM apz_file WHERE apz00 = '0'
                 IF g_apz13 = 'Y' THEN
                    SELECT * INTO g_aps.* FROM aps_file WHERE aps01=g_ooa.ooa15
                 ELSE
                    SELECT * INTO g_aps.* FROM aps_file WHERE (aps01 = ' ' OR aps01 IS NULL)
                 END IF
                 LET g_oob_d[l_ac2].oob11_1 = g_aps.aps24
                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                 IF g_aza.aza63 = 'Y' THEN
                    LET g_oob_d[l_ac2].oob111_1 = g_aps.aps241
                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                 END IF
              END IF
              #MOD-B30240--add--end
         END IF
         CALL t410_set_no_entry_b_2()
         CALL t410_set_no_entry_b1_2()           
         CALL t410_set_entry_b1_2()               
 
        AFTER FIELD oob06_1
           IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
             #若為借方，且非待扺
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 != '3' THEN
                 IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
                       g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN  
                    CALL t410_oob06_1_2()
 
                    IF g_errno = 'N' THEN
                       NEXT FIELD oob06_1
                    END IF
                 END IF
              END IF

              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
                  WHERE nmh01 = g_oob_d[l_ac2].oob06_1
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE oma00 MATCHES '2*'
                    AND oma01 = g_oob_d[l_ac2].oob06_1 
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'1*'
                    AND apa01 = g_oob_d[l_ac2].oob06_1
              END IF
              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE  oma00 MATCHES '1*'
                    AND oma01 = g_oob_d[l_ac2].oob06_1 
              END IF
              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'2*'
                    AND apa01 = g_oob_d[l_ac2].oob06_1
              END IF 

              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='A' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
              END IF

              IF SQLCA.sqlcode THEN
                 CALL cl_err3("sel","nmh_file",g_oob_d[l_ac2].oob06_1,"",SQLCA.sqlcode,"","",0) 
              ELSE
                 IF l_nmh04 > g_ooa.ooa02 THEN
                    CALL cl_err('','axr-371',0)
                    NEXT FIELD oob06_1
                 END IF 
              END IF

              CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2
              IF g_flag='1' THEN
                 CALL cl_err(l_nmh04,'aoo-081',1)
                 NEXT FIELD oob06_1
              END IF        

             IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[39]" THEN                         
                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
                   IF g_oob_d[l_ac2].oob04_1 = '3' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
                      IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND (l_oma00!='24') THEN    #MOD-9B0043 add 23
                         CALL cl_err('','axr-992',0)
                         NEXT FIELD oob06_1
                      END IF 
                   END IF 
                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') THEN 
                         CALL cl_err('','axr-993',0)
                         NEXT FIELD oob06_1 
                      END IF   
                   END IF 
                END IF                 
             END IF 

             IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN
                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 

                   IF g_oob_d[l_ac2].oob04_1 = '1' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
                      IF (l_oma00!='11') AND (l_oma00!='12') AND
                         (l_oma00!='13') AND (l_oma00!='14') THEN 
                         CALL cl_err('','axr-994',0)
                         NEXT FIELD oob06_1
                      END IF 
                   END IF 
                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
#No.MOD-B50249 --begin
                      IF l_apa00 NOT MATCHES '2*' THEN 
#                     IF (l_apa00 !='21') AND (l_apa00 !='22') AND
#                        (l_apa00 !='23') AND (l_apa00 !='24') THEN 
#No.MOD-B50249 --end
                         CALL cl_err('','axr-995',0)
                         NEXT FIELD oob06_1 
                      END IF   
                   END IF                    

                   CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
                   IF NOT cl_null(g_errno) THEN 
                      CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                      NEXT FIELD oob06_1
                   END IF 

                  IF g_oob_d[l_ac2].oob04_1='1' THEN 
                     SELECT COUNT(*) INTO l_i FROM omc_file 
                      WHERE omc01=g_oob_d[l_ac2].oob06_1
                     IF l_i=1 THEN
                        LET g_oob_d[l_ac2].oob19_1=1
                        CALL t410_oob06_1_2()
                        IF g_errno = 'N' THEN
                           NEXT FIELD oob19_1
                        ELSE 
                        	 NEXT FIELD oob11_1
                        END IF
                     END IF 
                  END IF
                  IF g_oob_d[l_ac2].oob04_1='9' THEN 
                     SELECT COUNT(*) INTO l_i FROM apc_file
                      WHERE apc01=g_oob_d[l_ac2].oob06_1
                     IF l_i=1 THEN
                        LET g_oob_d[l_ac2].oob19_1=1
                        CALL t410_oob06_1_2()
                        IF g_errno = 'N' THEN
                           NEXT FIELD oob19_1
                        ELSE 
                        	 NEXT FIELD oob11_1
                        END IF
                     END IF 
                  END IF                   
                END IF 
              END IF
           END IF

        BEFORE FIELD oob19_1
           CALL t410_set_no_entry_b1_2()
           CALL t410_set_entry_b1_2()

        AFTER FIELD oob19_1
           IF cl_null(g_oob_d[l_ac2].oob19_1) AND 
              NOT (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='4') THEN   
              CALL cl_err("","axr-411",1)
              NEXT FIELD oob06_1 
           END IF 
           IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN
             #若為待扺，或為貸方
              IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
                  g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1 OR 
                  g_oob_d_t.oob19_1 != g_oob_d[l_ac2].oob19_1 ) THEN  
                 CALL t410_oob06_1_2()
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob19_1
                 END IF
              END IF
           END IF
           
        
        BEFORE FIELD oob15_1
           CALL t410_set_no_entry_b1_2() 
           CALL t410_set_entry_b1_2()
 
        AFTER FIELD oob15_1
            IF g_ooz.ooz62 = 'Y' THEN
               IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                  IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
                     LET l_oma00 = NULL
                     SELECT oma00 INTO l_oma00  FROM oma_file
                      WHERE oma01 = g_oob_d[l_ac2].oob06_1 
                     IF NOT cl_null(l_oma00) THEN
                        IF l_oma00 NOT MATCHES '[15,16,17,18,26,27]' THEN
                           NEXT FIELD oob15_1
                        END IF
                     ELSE
                        NEXT FIELD oob15_1  
                     END IF 
                  ELSE
                     NEXT FIELD oob15_1
                  END IF  
                END IF
            END IF  

            IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                     NEXT FIELD oob06_1
                  END IF 
               END IF 
            END IF  
           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
                      oob15 = g_oob_d[l_ac2].oob15_1 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15_1
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15_1
                 END IF
              END IF
              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
                 g_oob_d_t.oob15_1 IS NULL THEN
                 CALL t410_oob06_1_12_2()
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1 
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06_1
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 CALL t410_oob06_1_item_2()
              END IF
          END IF 

        AFTER FIELD oob17_1
           IF NOT cl_null(g_oob_d[l_ac2].oob17_1) THEN
              CALL t410_oob17(g_oob_d[l_ac2].oob17_1)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob_d[l_ac2].oob17_1 = g_oob_d_t.oob17_1
                 NEXT FIELD oob17_1
              END IF  
           END IF  
 
        AFTER FIELD oob18_1
           IF NOT cl_null(g_oob_d[l_ac2].oob18_1) THEN
              CALL t410_oob18_1_2(g_oob_d[l_ac2].oob18_1)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob_d[l_ac2].oob18_1 = g_oob_d_t.oob18_1
                 NEXT FIELD oob18_1
              END IF  
           END IF  
      
        AFTER FIELD oob21_1
           IF NOT cl_null(g_oob_d[l_ac2].oob21_1) THEN
              CALL t410_oob21(g_oob_d[l_ac2].oob21_1)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err('',g_errno,0)
                 LET g_oob_d[l_ac2].oob21_1 = g_oob_d_t.oob21_1
                 NEXT FIELD oob21_1
              END IF  
           END IF  
 
        BEFORE FIELD oob07_1
           IF cl_null(g_oob_d[l_ac2].oob07_1) AND NOT cl_null(g_ooa.ooa23) THEN
              LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
           END IF
           # 971021 TT/NR/CN/AR 不允許修改幣別
           IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
              (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
           END IF
 
        AFTER FIELD oob07_1
           IF g_oob_d[l_ac2].oob07_1 IS NULL THEN NEXT FIELD oob07_1 END IF
           IF NOT cl_null(g_oob_d[l_ac2].oob07_1) THEN
              CALL t410_oob07_1('a')
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_oob_d[l_ac2].oob07_1,g_errno,0)
                 LET g_oob_d[l_ac2].oob07_1 = g_oob_d_t.oob07_1
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
                 NEXT FIELD oob07_1
              END IF
            END IF
 
        BEFORE FIELD oob08_1

           #CALL cl_set_comp_entry("oob08_1",TRUE) #mark by andy 2017/4/27 14:09:00
           CALL t410_set_no_entry_b_2()

           LET oob08_t=g_oob_d[l_ac2].oob08_1   #No.+010
           # 971021 TT/NR/CN/AR 不允許修改匯率
           IF g_oob_d[l_ac2].oob08_1 = 0 OR g_oob_d[l_ac2].oob08_1 = 1 OR
              cl_null(g_oob_d[l_ac2].oob08_1) THEN
              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob_d[l_ac2].oob08_1
              DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
           END IF
           LET oob08_t=g_oob_d[l_ac2].oob08_1

        AFTER FIELD oob08_1
           CALL cl_set_comp_entry("oob08_1",TRUE)
           IF (oob08_t!=g_oob_d[l_ac2].oob08_1) THEN
              LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
              CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)
                   RETURNING g_oob_d[l_ac2].oob10_1
           END IF
 
        BEFORE FIELD oob09_1
           LET oob09_t=g_oob_d[l_ac2].oob09_1
 
        AFTER FIELD oob09_1
## No.2694 modify 1998/10/31 判斷金額是否沖過頭
           IF NOT cl_null(g_oob_d[l_ac2].oob09_1) THEN
              IF g_oob_d_t.oob09_1 != g_oob_d[l_ac2].oob09_1 OR
                 g_oob_d_t.oob09_1 IS NOT NULL THEN
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
                    IF NOT t410_oob09_1_11_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
                    IF NOT t410_oob09_1_12_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                    IF NOT t410_oob09_1_13_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t410_oob09_1_19_2('1',p_cmd,'1') THEN   
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t410_oob09_1_19_2('1',p_cmd,'2') THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
              END IF

              IF (oob08_t!=g_oob_d[l_ac2].oob08_1) OR (oob09_t!=g_oob_d[l_ac2].oob09_1) OR oob09_t IS NULL THEN 
                  SELECT azi04 INTO t_azi04 FROM azi_file  
                  WHERE azi01 = g_oob_d[l_ac2].oob07_1
                  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) 
                 RETURNING g_oob_d[l_ac2].oob09_1
                 LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
                  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) 
                 RETURNING g_oob_d[l_ac2].oob10_1
              END IF
              IF g_oob_d[l_ac2].oob09_1 <= 0 THEN
                 IF g_oob_d[l_ac2].oob04_1 <> '7' THEN
                    NEXT FIELD oob09_1
                 END IF
              END IF
              IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') OR
                    (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') THEN
                    IF NOT t410_oob09_1_13_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
              END IF
           END IF
 
        BEFORE FIELD oob10_1
           LET oob10_t=g_oob_d[l_ac2].oob10_1
 
        AFTER FIELD oob10_1
           IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
              IF g_oob_d_t.oob10_1 != g_oob_d[l_ac2].oob10_1 OR g_oob_d_t.oob10_1 IS NOT NULL THEN
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
                     WHERE nmh01 = g_oob_d[l_ac2].oob06_1
                       AND nmh38 <> 'X'
                    IF cl_null(l_nmh32) THEN
                       LET l_nmh32 = 0
                    END IF
                    IF g_oob_d[l_ac2].oob10_1 > l_nmh32 THEN
                       NEXT FIELD oob10_1
                    END IF
                    IF NOT t410_oob09_1_11_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
                    IF NOT t410_oob09_1_12_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                    IF NOT t410_oob09_1_13_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t410_oob09_1_19_2('2',p_cmd,'1') THEN   
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t410_oob09_1_19_2('2',p_cmd,'2') THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
              END IF
              IF oob10_t <> g_oob_d[l_ac2].oob10_1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
#                 IF cl_confirm('axr-320') THEN
                    SELECT azi04 INTO t_azi04 FROM azi_file
                     WHERE azi01 = g_oob_d[l_ac2].oob07_1
                    CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
                         RETURNING g_oob_d[l_ac2].oob10_1
                    LET g_oob_d[l_ac2].oob09_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob08_1
                    CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
                         RETURNING g_oob_d[l_ac2].oob09_1
#                 ELSE
#                    LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
#                 END IF
              END IF
              IF g_oob_d[l_ac2].oob08_1 = 1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
                 LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
              END IF
              IF g_oob_d[l_ac2].oob10_1 <= 0 THEN
                 NEXT FIELD oob10_1
              END IF
           END IF
 
        AFTER FIELD oob11_1
          IF g_oob_d[l_ac2].oob11_1 IS NULL THEN NEXT FIELD oob11_1 END IF    
          LET l_aag05=''   
          IF NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1   
                                                                   AND aag00=g_bookno1 
                                                                   AND aag07 IN ('2','3')    #FUN-B10053
                                                                   AND aag03 = '2'           #FUN-B10053
             IF STATUS THEN
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",1) 
                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",0) 
                CALL cl_init_qry_var()
                LET g_qryparam.form ='q_aag'
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
                LET g_qryparam.arg1 = g_bookno1
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob_d[l_ac2].oob11_1 CLIPPED,"%'"
                CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
                DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                #No.FUN-B10053  --End
                NEXT FIELD oob11_1
                #No.FUN-B10053  --End
                NEXT FIELD oob11_1
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob_d[l_ac2].oob11_1,'agl-015',0) NEXT FIELD oob11_1
             END IF
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob11_1
                END IF
             ELSE                                  
                LET g_oob_d[l_ac2].oob13_1=''           
                DISPLAY BY NAME g_oob_d[l_ac2].oob13_1  
             END IF
             CALL t410_set_no_entry_b1_2()   
             CALL t410_set_entry_b1_2()      
          END IF

        AFTER FIELD oob111_1
          IF g_oob_d[l_ac2].oob111_1 IS NULL THEN NEXT FIELD oob111_1 END IF   
          IF NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob111_1 
                                                                   AND aag00=g_bookno2  
                                                                   AND aag07 IN ('2','3')  #FUN-B10053
                                                                   AND aag03 = '2'         #FUN-B10053
             IF STATUS THEN
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",0)  
                CALL cl_init_qry_var()
                LET g_qryparam.form ='q_aag'
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
                LET g_qryparam.arg1 = g_bookno2
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob_d[l_ac2].oob111_1 CLIPPED,"%'"                
                CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
                DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                NEXT FIELD oob111_1
                #No.FUN-B10053  --End
                NEXT FIELD oob111_1
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob_d[l_ac2].oob111_1,'agl-015',0) NEXT FIELD oob111_1
             END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob111_1
                END IF
             END IF

          END IF

          BEFORE FIELD oob13_1
            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
             WHERE aag01=g_oob_d[l_ac2].oob11_1
               AND aag00=g_bookno1        
            IF l_aag05='N' THEN
               LET g_oob_d[l_ac2].oob13_1=''
               DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
            END IF
            CALL t410_set_no_entry_b1_2()   
            CALL t410_set_entry_b1_2()      

        AFTER FIELD oob13_1
          IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN
             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob_d[l_ac2].oob13_1
                AND gemacti='Y'   
             IF STATUS THEN
                CALL cl_err3("sel","gem_file",g_oob_d[l_ac2].oob13_1,"",STATUS,"","select gem",1) 
                NEXT FIELD oob13_1
             END IF
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET l_aag05=''   
             SELECT aag05 INTO l_aag05 FROM aag_file
              WHERE aag01 = g_oob_d[l_ac2].oob11_1
                AND aag00 = g_bookno1      
            
             LET g_errno = ' '   
             IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN    
                   CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)
                                 RETURNING g_errno
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob13_1
                END IF
             END IF
            
             IF g_aza.aza63='Y' THEN 
                LET l_aag05=''   
                SELECT aag05 INTO l_aag05 FROM aag_file
                 WHERE aag01 = g_oob_d[l_ac2].oob111_1
                   AND aag00 = g_bookno2      
                
                LET g_errno = ' '   
                IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                   IF g_aaz.aaz90 !='Y' THEN  
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)
                                    RETURNING g_errno
                   END IF
                   IF NOT cl_null(g_errno) THEN
                      CALL cl_err('',g_errno,0)
                      NEXT FIELD oob13_1
                   END IF
                END IF
             END IF  
          END IF

            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
               WHERE aag01=g_oob_d[l_ac2].oob11_1  
                 AND aag00=g_bookno1       
            IF l_aag05='Y' AND cl_null(g_oob_d[l_ac2].oob13_1) THEN
               CALL cl_err('','aap-099',0)
               NEXT FIELD oob13_1
            END IF

        AFTER FIELD oobud01_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud02_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud03_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud04_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud05_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud06_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud07_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud08_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud09_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud10_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud11_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud12_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud13_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud14_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud15_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        BEFORE DELETE                            #是否取消單身
            DISPLAY "g_oob_d_t.oob02_1=",g_oob_d_t.oob02_1
            IF g_oob_d_t.oob02_1 > 0 AND g_oob_d_t.oob02_1 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   LET g_success = 'N'   
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   LET g_success = 'N'   
                   CANCEL DELETE
                END IF
                DELETE FROM oob_file
                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
                IF SQLCA.sqlcode THEN
                    CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","",1)  
                    LET g_success = 'N'
                    CANCEL DELETE
                END IF
                CALL t410_mlog('R')
                IF g_success = 'Y' THEN
                   IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
                      LET l_ooa34 = '0'
                   END IF                                   
                   LET g_rec_b2=g_rec_b2-1
                   DISPLAY g_rec_b2 TO FORMONLY.cn3
                   IF cl_null(g_oob_d_t.oob02_1) THEN
                      LET g_rec_b2=g_rec_b2-1
                   END IF
                   COMMIT WORK
                ELSE
                   ROLLBACK WORK
                END IF
            END IF   
            CALL t410_bu()
 
        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_oob_d[l_ac2].* = g_oob_d_t.*
               CLOSE t410_bcl1
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_oob_d[l_ac2].oob02_1,-263,1)
               LET g_oob_d[l_ac2].* = g_oob_d_t.*
               LET g_success='N'   
            ELSE
               CALL t410_b_move_back_2()
               SELECT COUNT(*) INTO l_n FROM oob_file
                WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
               IF l_n = 0 THEN                                   
                  IF g_oob_d[l_ac2].oob09_1 = 0 AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                     INITIALIZE g_oob_d[l_ac2].* TO NULL  #重要欄位空白,無效
                     LET g_success='N'   
                  END IF
               END IF

           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
           END IF
           IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN   
               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
                  CALL t410_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,l_ac2)
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                     NEXT FIELD oob06_1
                  END IF 
               END IF 
            END IF   
           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND
                      oob15 = g_oob_d[l_ac2].oob15_1 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15_1
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15_1
                 END IF
              END IF
              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
                 g_oob_d_t.oob15_1 IS NULL THEN
                 CALL t410_oob06_1_12_2()
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06_1
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 CALL t410_oob06_1_item_2()
              END IF
          END IF 
               
               UPDATE oob_file SET * = b_oob.*
                  WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","upd oob",1)  
                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
                  LET g_success='N'   
               ELSE 
                  UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
                   WHERE ooa01 = g_ooa.ooa01 
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
                     LET g_oob_d[l_ac2].* = g_oob_d_t.*
                     LET g_success='N'   
                  END IF
                  DISPLAY g_user TO ooamodu
                  DISPLAY g_today TO ooadate
                END IF
            END IF
            CALL t410_mlog('U')
            CALL t410_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'UPDAET O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
                  LET l_ooa34 = '0'
               END IF                       
               COMMIT WORK
            ELSE
               MESSAGE 'UPDATE ERR'
               ROLLBACK WORK
            END IF

        AFTER ROW
            LET l_ac2 = ARR_CURR()
            LET l_ac2_t = l_ac2
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
               END IF
               CLOSE t410_bcl1
               ROLLBACK WORK
               EXIT INPUT
            END IF
            CLOSE t410_bcl1
            COMMIT WORK
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(oob02_1) AND l_ac2 > 1 THEN
                LET g_oob_d[l_ac2].* = g_oob_d[l_ac2-1].*
                LET g_oob_d[l_ac2].oob02_1 = NULL
                NEXT FIELD oob02_1
            END IF
        ON ACTION controls                             
         CALL cl_set_head_visible("","AUTO")           
 
        ON ACTION CONTROLP
            CASE
#MOD-590452 將原本mark的部份取消
                WHEN INFIELD(oob04_1)
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_ooc"
                     LET g_qryparam.default1 = g_oob_d[l_ac2].oob04_1
                     LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  
                     CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob04_1
                     DISPLAY BY NAME g_oob_d[l_ac2].oob04_1         
                     NEXT FIELD oob04_1

                 WHEN INFIELD(oob06_1)
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmh5"
                          LET g_qryparam.arg1 = g_ooa.ooa03
                          LET g_qryparam.arg2 = g_doc_len   
                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
                          NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmg"
                          LET g_qryparam.default1 = g_oob_d[l_ac2].oob06_1
                           LET g_qryparam.arg1 = g_ooa.ooa03   
                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
                          NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                         CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
                                     g_ooa.ooa01,g_ooa.ooa03,'2*')                   
                              RETURNING b_oob.oob06,b_oob.oob09,       
                                        b_oob.oob10,b_oob.oob19
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                            LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19   
                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
                         CALL q_apa4( FALSE, TRUE, ' ')
                         RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                         IF g_ooz.ooz62='N' THEN
                            CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
                                        g_ooa.ooa01,g_ooa.ooa03,'1*')                    
                                 RETURNING b_oob.oob06,b_oob.oob09,  
                                           b_oob.oob10,b_oob.oob19
                         ELSE
                            CALL q_omb(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1,
                                       g_ooa.ooa01, g_ooa.ooa03,'1%') 
                             RETURNING b_oob.oob06,b_oob.oob15,
                                       b_oob.oob09,b_oob.oob10
                         END IF
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
                            IF g_ooz.ooz62='Y' THEN
                               LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
                            ELSE
                               LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19
                            END IF
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
                         CALL q_apa5( FALSE, TRUE, ' ')
                              RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='A' THEN
                         CALL q_nmg(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_ooa.ooa03,
                                    g_ooa.ooa032,g_ooa.ooa02,g_ooa.ooa23)
                              RETURNING g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,
                                        g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,    
                                        g_oob_d[l_ac2].oob18_1,g_oob_d[l_ac2].oob17_1
                         NEXT FIELD oob06_1
                         DISPLAY BY NAME g_oob_d[l_ac2].oob18_1
                         DISPLAY BY NAME g_oob_d[l_ac2].oob17_1
                      END IF
                       DISPLAY BY NAME g_oob_d[l_ac2].oob06_1     
                       DISPLAY BY NAME g_oob_d[l_ac2].oob09_1    
                       DISPLAY BY NAME g_oob_d[l_ac2].oob10_1     
                       DISPLAY BY NAME g_oob_d[l_ac2].oob15_1     
               WHEN INFIELD(oob11_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_aag'
                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
                    LET g_qryparam.arg1 = g_bookno1      
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                    NEXT FIELD oob11_1

               WHEN INFIELD(oob111_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_aag'
                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
                    LET g_qryparam.arg1 = g_bookno2       
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                    NEXT FIELD oob111_1

               WHEN INFIELD(oob13_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_gem'
                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob13_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob13_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
                    NEXT FIELD oob13_1
               WHEN INFIELD(oob07_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_azi'
                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob07_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob07_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
                    NEXT FIELD oob07_1

               WHEN INFIELD(oob08_1)
                    CALL s_rate(g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1)
                    RETURNING g_oob_d[l_ac2].oob08_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
                    NEXT FIELD oob08_1

               WHEN INFIELD (oob17_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nma'
                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob17_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob17_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob17_1
                    NEXT FIELD oob17_1
               WHEN INFIELD (oob18_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nmc02'
                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob18_1
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob18_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob18_1
                    NEXT FIELD oob18_1
               WHEN INFIELD (oob21_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_nml'
                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob21_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob21_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob21_1
                    NEXT FIELD oob21_1

               OTHERWISE EXIT CASE
            END CASE
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION receive_notes
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                    CALL cl_cmdrun_wait('anmt200') 
                 END IF
        ON ACTION bank_income_expense
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN   
                    CALL cl_cmdrun_wait('anmt302')  
                 END IF
        ON ACTION maintain_accounts
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                    CALL cl_cmdrun_wait('axrt300')  
                 END IF
                 IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                    CALL cl_cmdrun_wait('axrt300')  
                 END IF
        ON ACTION ar_account_category
                    CALL cl_cmdrun('axri040')

        ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT
 
      ON ACTION about         
         CALL cl_about()    
 
      ON ACTION help          
         CALL cl_show_help()  
  
      END INPUT

     IF g_ooa.ooaconf <> 'Y' THEN            #FUN-640246
        UPDATE ooa_file SET ooa34=l_ooa34 WHERE ooa01 = g_ooa.ooa01
        LET g_ooa.ooa34 = l_ooa34
        DISPLAY BY NAME g_ooa.ooa34
     END IF
     IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
     IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
     CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
     ## END FUN-550049 ##
 
      IF (g_ooa.ooa23 IS NULL AND g_ooa.ooa32d != g_ooa.ooa32c) OR
         (g_ooa.ooa23 IS NOT NULL AND
         (g_ooa.ooa31d != g_ooa.ooa31c OR g_ooa.ooa32d != g_ooa.ooa32c)) THEN
         LET p_row = 10 LET p_col = 27
         OPEN WINDOW t4001_w AT p_row,p_col WITH FORM "axr/42f/axrt4101"
               ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
         CALL cl_ui_locale("axrt4101")
 
         INPUT BY NAME diff_flag
          AFTER FIELD diff_flag
           IF diff_flag NOT MATCHES "[90E]" THEN NEXT FIELD diff_flag END IF
           IF diff_flag MATCHES '[9]'  AND g_ooa.ooa32d > g_ooa.ooa32c THEN
              CALL cl_err('','axr-303',0) NEXT FIELD diff_flag
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
         #UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today   #MOD-870147
         # WHERE ooa01 = g_ooa.ooa01   #MOD-870147
         IF INT_FLAG THEN LET INT_FLAG=0 LET diff_flag='0' END IF
         CLOSE WINDOW t4001_w
         IF diff_flag='0' THEN 
            CALL t410_b()
            CALL t410_b2()                  #FUN-A90003 Add 
         END IF #GENERO 再進單身時
      END IF
    CLOSE t410_bcl1
    COMMIT WORK
    IF diff_flag MATCHES "[9]" THEN
       CALL t410_diff()
       CALL t410_b_fill('1=1')         #FOR GENERO BUG調整
       CALL t410_b_fill_2('1=1') #FUN-A90003 Add
    END IF
# 新增自動確認功能 Modify by Charis 96-09-23
#    LET g_t1=g_ooa.ooa01[1,3]   #TQC-5A0089
    LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF STATUS THEN
#      # CALL cl_err('sel ooy_file',STATUS,0)   #No.FUN-660116
       # CALL cl_err3("sel","ooy_file",g_t1,"",STATUS,"","sel ooy_file",1)  #No.FUN-660116
       RETURN
    END IF
    #-----97/05/26 modify 詢問是否產生分錄底稿
    IF g_ooa.ooa31d>0 AND g_ooa.ooa31d=g_ooa.ooa31c AND g_ooy.ooydmy1='Y' THEN
       IF cl_confirm('axr-309') THEN
          CALL t410_v()
       END IF
    END IF
    IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
       THEN RETURN
    ELSE
#FUN-580154
       LET g_action_choice = "insert"        #FUN-640246
       #CALL t410_y()
       CALL t410_y_chk()          #CALL 原確認的 check 段
       IF g_success = "Y" THEN
          CALL t410_y_upd()       #CALL 原確認的 update 段
       END IF
#FUN-580154 End
    END IF
    IF g_ooy.ooyprit='Y' THEN CALL t410_out() END IF   #單據需立即列印
# -----------------
END FUNCTION
    
#FUN-A90003--Add--End--# 
FUNCTION t410_c_chk()
DEFINE l_tc_hka08,l_tc_hka08_a,l_tc_hka08_c,l_tc_hka08_d LIKE tc_hka_file.tc_hka08
DEFINE l_oob09 LIKE oob_file.oob09
DEFINE l_oob10 LIKE oob_file.oob10
DEFINE l_tc_hka14 LIKE tc_hka_file.tc_hka14
DEFINE i     LIKE type_file.num5
DEFINE l_str,l_str1 STRING

   CALL s_showmsg_init()
    
   LET g_success = 'Y'
   FOR i=1 TO g_rec_b
     IF g_oob[i].oob04='3' THEN  #3、待抵账款
      LET l_tc_hka08=0
      LET l_tc_hka14=0
      LET l_tc_hka08_c=0
      LET l_tc_hka08_d=0
      LET l_oob09=0
      
      #axrt410(退款)
#      SELECT SUM(tc_hka08) INTO l_tc_hka08_d FROM tc_hka_file WHERE tc_hka02='1' AND tc_hka01='6'
#      AND tc_hka03 IN (SELECT ooa01 FROM ooa_file,oob_file 
#      WHERE ooa01=oob01 AND oob06=g_oob[i].oob06 AND ooa37='2' AND ooaconf='Y')     
      SELECT SUM(nvl(oob10,0)) INTO l_tc_hka08_d FROM ooa_file,oob_file 
      WHERE ooa01=oob01 AND oob06=g_oob[i].oob06 AND ooa37='2' AND ooaconf='Y'
      #anmt302(收支)
      #SELECT SUM(tc_hka08) INTO l_tc_hka08 FROM tc_hka_file WHERE tc_hka02='1' AND tc_hka03=g_oob[i].oob06
      SELECT oma56 INTO l_tc_hka08 FROM oma_file WHERE oma01=g_oob[i].oob06 AND oma03=g_ooa.ooa03 AND omaconf='Y'
      #cxmt100(回款)
      #SELECT SUM(tc_hka14) INTO l_tc_hka14 FROM tc_hka_file WHERE tc_hka02='-1' AND tc_hka03=g_oob[i].oob06
      SELECT SUM(tc_nme05) INTO l_tc_hka14 FROM tc_nme_file,tc_nmg_file 
       WHERE tc_nmg01 = tc_nme01
         AND tc_nmg02 = g_ooa.ooa03
         AND tc_nmg06 = g_oob[i].oob06
         AND tc_nmg04 = 'Y'
      #axrt401(调账)
#      SELECT SUM(tc_hka08) INTO l_tc_hka08_a FROM tc_hka_file WHERE tc_hka02='1' AND tc_hka01='3'
#      AND tc_hka03 IN (SELECT ooa01 FROM ooa_file,oob_file 
#      WHERE ooa01=oob01 AND oob06=g_oob[i].oob06 AND ooa37='3' AND ooaconf='Y')
#      AND tc_hka08 < 0
       SELECT SUM(nvl(oob10,0)) INTO l_tc_hka08_d FROM ooa_file,oob_file 
      WHERE ooa01=oob01 AND oob06=g_oob[i].oob06 AND ooa37='3' AND ooaconf='Y'
      IF cl_null(l_tc_hka08) THEN LET l_tc_hka08=0 END IF
      IF cl_null(l_tc_hka14) THEN LET l_tc_hka14=0 END IF
      IF cl_null(l_tc_hka08_a) THEN LET l_tc_hka08_a=0 END IF
      IF cl_null(l_tc_hka08_d) THEN LET l_tc_hka08_d=0 END IF
      LET l_tc_hka08_c=l_tc_hka08+l_tc_hka08_a-l_tc_hka14-l_tc_hka08_d
      SELECT SUM(oob10) INTO l_oob10 FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob06=g_oob[i].oob06
      IF cl_null(l_oob10) THEN LET l_oob09=0 END IF
      IF l_oob10 > l_tc_hka08_c THEN
         #CALL cl_err('本次退款金额大于收款单未维护金额，请修改退款金额或红冲回款单','!',1)
         LET l_str=g_ooa.ooa01,'/',g_oob[i].oob02,'/',g_oob[i].oob06
         LET l_str1='本次退款金额:',l_oob10,'大于收款单未维护金额:',l_tc_hka08_c,',请修改退款金额或红冲回款单'
         CALL s_errmsg('借方:',l_str,l_str1,'',1)
         LET g_success='N'
      END IF
     END IF
   END FOR
   CALL s_showmsg()
END FUNCTION
