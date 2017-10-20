# Prog. Version..: '5.30.06-13.04.22(00010)'     #
#
# Pattern name...: axmt310.4gl
# Descriptions...: 估價單資料維護作業
# Date & Author..: 00/03/01 By Melody
# Modify.........: No:7697 03/08/07 Carol 在call cl_numfor時, 位數太小會被截掉
#                                         改為使用 cl_digcut() 取位
#                                         per 欄位放大
#
# Modify.........: No:7829 03/08/18 Carol 單據程式中呼叫單據自動編號時,
#                                         應該是要包覆在 BEGIN WORK 中(transaction)
#                                         才會達到lock 的功能
# Modify.........: No:8746 03/11/25 ching 單位問題更正
# Modify.........: No.MOD-470041 04/07/19 Wiky 修改INSERT INTO...
# Modify.........: No.MOD-480130 04/08/05 Wiky copy寫法有問題
# Modify.........: #No.MOD-490217 04/09/10 by yiting 料號欄位使用like方式
# Modify.........: No.MOD-490371 04/09/23 By Kitty Controlp 未加display
# Modify.........: No.MOD-4A0252 04/10/21 By Smapmin 加入估價單號開窗功能
# Modify.........: No.FUN-4B0038 04/11/15 By pengu ARRAY轉為EXCEL檔
# Modify.........: No.FUN-4B0050 04/11/23 By Mandy 匯率加開窗功能
# Modify.........: No.FUN-4C0006 04/12/03 By Carol 單價/金額欄位放大(20),位數改為dec(20,6)
# Modify.........: No.FUN-4C0057 04/12/09 By Carol Q,U,R 加入權限控管處理
# Modify.........: No.FUN-4C0076 04/12/15 By pengu  匯率幣別欄位修改，與aoos010的aza17做判斷，
                                                    #如果二個幣別相同時，匯率強制為 1
# Modify.........: NO.FUN-530031 05/03/22 By Carol 單價/金額欄位所用的變數型態應為 dec(20,6),匯率 dec(20,10)
# Modify.........: No.FUN-550110 05/05/26 By ching 特性BOM功能修改
# Modify.........: No.FUN-550070 05/05/26 By Will 單據編號放大
# Modify.........: No.FUN-560011 05/06/07 By pengu CREATE TEMP TABLE 欄位放大
# Modify.........: No.FUN-560230 05/06/27 By Melody QPA->DEC(16,8)
# Modify.........: NO.MOD-570107 05/08/10 BY yiting 如果用滑鼠直接點擊確定，則沒辦法檢查部門是否正確和是否存在在部門維護檔中
# Modify.........: NO.MOD-590057 05/09/08 By yiting 輸入業務,部門不會帶出
# Modify.........: NO.FUN-5A0158 05/10/24 By Sarah 1.若單身該筆資料"客戶供料"欄位有勾選則該筆估價金額應不可加總到材料金額中
#                                                  2.若單身單價資料取不到時,該筆資料之參考日期應寫入SYSDATE即可
#                                                  3."有效日期"欄位應判斷不可小於"單價參考起始日期"
# Modify.........: NO.TQC-5A0098 05/10/26 By Niocla 單據性質取位修改
# Modify.........: No.FUN-5B0116 05/11/22 By Claire 修改單身後單頭的資料更改者及最近修改日應update
# Modify.........: NO.TQC-630066 06/03/07 By Kevin 流程訊息通知功能修改
# Modify.........: No.MOD-630100 06/03/24 By pengu CREATE TEMP中oqa01 的欄位太小,以致於製程資料無法產生
# Modify.........: No.MOD-650024 06/05/08 By Claire Review 所有報表程式接收的外部參數是否完整
# Modify.........: NO.TQC-660088 06/06/21 By Claire 流程訊息通知功能修改
# Modify.........: No.FUN-660167 06/06/23 By cl cl_err --> cl_err3
# Modify.........: No.TQC-670008 06/07/05 By rainy 權限修正
# Modify.........: No.FUN-660216 06/07/10 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.TQC-670096 06/08/15 By Claire 原幣幣別修改不考慮aoos010所設定的本幣
# Modify.........: No.FUN-680137 06/09/18 By bnlent 欄位型態用LIKE定義
# Modify.........: No.FUN-6A0094 06/10/25 By yjkhero l_time轉g_time
# Modify.........: No.CHI-6A0004 06/10/23 By hongmei g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.FUN-6A0092 06/11/14 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No.FUN-6B0079 06/11/24 By jamie 1.FUNCTION _q() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modify.........: No.MOD-690040 06/12/08 By pengu 已確認估價單不可再做"材/工/費分攤作業"
# Modify.........: No.TQC-6B0105 07/03/07 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.FUN-730018 07/03/26 By kim 行業別架構
# Modify.........: No.TQC-740269 07/04/23 By bnlent 1、項次不可為負；
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.TQC-770084 07/07/16 By wujie 取單位換算率時where條件有錯
# Modify.........: No.CHI-7B0023/CHI-7B0039 07/11/14 By kim 移除GP5.0行業別功能的所有程式段
# Modify.........: No.FUN-7C0050 08/01/15 By johnray 串查程序代碼添加共用 ACTION 的引用
# Modify.........: No.FUN-840041 08/04/10 By shiwuying  ccc_file增加2個Key,抓取單價時,增加條件 ccc07='1',抓實際成本算出的單價為基准
# Modify.........: No.FUN-840042 08/04/11 By TSD.Wind 自定欄位功能修改
# Modify.........: No.MOD-870213 08/07/17 By Smapmin 抓取單價時應考慮單位基準不同
# Modify.........: No.FUN-890011 08/10/14 By xiaofeizhu 在開窗選取客戶編號時，也可選擇"潛客資料(ofd_file)
# Modify.........: No.FUN-8B0035 08/11/12 By jan 下階料展BOM時，特性代碼抓ima910
# Modify.........: No.MOD-930084 09/03/09 By rainy axmt310打估價單打完單頭後依BOM表展單身元件料號時，且該客戶有使用特性代碼，資料會重覆抓取
# Modify.........: No.TQC-970312 09/07/29 By lilingyu 單身"估價金額"錄入負數沒有控管
# Modify.........: No.TQC-980062 09/08/10 By sherry 刪除一筆資料后，無法顯示下一筆資料
# Modify.........: No.FUN-980010 09/08/24 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.TQC-9B0239 09/12/11 By lilingyu 點擊"重新產生單身"按鈕,若無BOM資料,程式無任何提示
# Modify.........: No:FUN-9C0071 10/01/11 By huangrh 精簡程式
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No.FUN-A40041 10/04/20 By wujie     g_sys->AXM
# Modify.........: No:MOD-A50052 10/05/10 By Smapmin 修正TQC-770084
# Modify.........: No:MOD-A60134 10/06/21 By Carrier 自动产生单身失败
# Modify.........: No.FUN-AA0059 10/10/25 By chenying 料號開窗控管
# Modify.........: No:FUN-B30211 11/04/01 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No.FUN-B50064 11/06/03 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.CHI-B60093 11/06/30 By JoHung 依系統預設成本計算類別取得該料的成本
# Modify.........: No:MOD-B70141 11/07/14 By Carrier oqc12赋值错误
# Modify.........: No:MOD-B70186 11/07/19 By suncx 自動產生單身時過濾掉回收料
# Modify.........: No:TQC-B80189 11/08/26 By lixia 查詢欄位
# Modify.........: No:FUN-910088 11/11/22 By chenjing 增加數量欄位小數取位

# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No.CHI-C30002 12/05/25 By yuhuabao 離開單身時若單身無資料提示是否刪除單頭資料
# Modify.........: No.CHI-C30107 12/06/12 By yuhuabao  整批修改將確認的詢問窗口放到chk段的前面
# Modify.........: No:FUN-C30085 12/07/04 By nanbing CR改串GR
# Modify.........: No.TQC-C70039 12/07/05 By downheal 解決 cl_cmdrun() 無法列印的問題
# Modify.........: No.TQC-C60211 12/07/18 By zhuhao  審核時重新判斷部門編號
# Modify.........: No:FUN-C80046 12/08/14 By bart 複製後停在新料號畫面
# Modify.........: No:FUN-CB0014 12/11/09 By lixh1 增加資料清單
# Modify.........: No.CHI-C80041 12/11/28 By bart 取消單頭資料控制
# Modify.........: No.TQC-D10084 13/01/29 By xianghui 資料清單頁簽下隱藏一部分ACTION
# Modify.........: No.MOD-CB0274 13/01/31 By jt_chen 將AFTER INPUT段重複的程式Mark
# Modify.........: No:FUN-D20025 13/02/21 By chenying 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No:FUN-D30034 13/04/16 By xumm 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No:MOD-D50079 13/05/11 By zhangll 默认币种时带出币种对应的汇率
# Modify.........: No:MOD-D50083 13/05/11 By zhangll 修改单身刚录入完后显示时异常出现空行的情况
# Modify.........: No:MOD-D50086 13/05/11 By zhangll 修改金额后能根据数量更新单价
# Modify.........: No:MOD-D50087 13/05/11 By zhangll 录入数量后，有单价，金额也要带出来
# Modify.........: No:FUN-D50064 13/05/17 By zhuhao 點擊”重新生成單身”按鈕後,詢問是否重新人工制費資料,
# ................................................. 如果點否,則僅重新生成oqb,不重新生成oqc,如果點是則按原邏輯
# Modify.........: No:CHI-DC0021 13/12/18 By SunLM 如果sma118=‘Y’，则单头新增“特性代码”

DATABASE ds

GLOBALS "../../config/top.global"

#模組變數(Module Variables)
DEFINE
    g_oqa           RECORD LIKE oqa_file.*,
    g_oqa_t         RECORD LIKE oqa_file.*,
    g_oqa_o         RECORD LIKE oqa_file.*,
    g_oqa01_t       LIKE oqa_file.oqa01,
    g_oqb           DYNAMIC ARRAY OF RECORD
        oqb02       LIKE oqb_file.oqb02,
        oqb03       LIKE oqb_file.oqb03,
        oqb031      LIKE oqb_file.oqb031,
        oqb032      LIKE oqb_file.oqb032,
        oqb04       LIKE oqb_file.oqb04,
        oqb05       LIKE oqb_file.oqb05,
        oqb06       LIKE oqb_file.oqb06,
        oqb07       LIKE oqb_file.oqb07,
        oqb08       LIKE oqb_file.oqb08,
        oqb09       LIKE oqb_file.oqb09,
        oqb10       LIKE oqb_file.oqb10,
        oqb11       LIKE oqb_file.oqb11,
        oqb12       LIKE oqb_file.oqb12,
        oqb13       LIKE oqb_file.oqb13,
        oqbud01     LIKE oqb_file.oqbud01,
        oqbud02     LIKE oqb_file.oqbud02,
        oqbud03     LIKE oqb_file.oqbud03,
        oqbud04     LIKE oqb_file.oqbud04,
        oqbud05     LIKE oqb_file.oqbud05,
        oqbud06     LIKE oqb_file.oqbud06,
        oqbud07     LIKE oqb_file.oqbud07,
        oqbud08     LIKE oqb_file.oqbud08,
        oqbud09     LIKE oqb_file.oqbud09,
        oqbud10     LIKE oqb_file.oqbud10,
        oqbud11     LIKE oqb_file.oqbud11,
        oqbud12     LIKE oqb_file.oqbud12,
        oqbud13     LIKE oqb_file.oqbud13,
        oqbud14     LIKE oqb_file.oqbud14,
        oqbud15     LIKE oqb_file.oqbud15
                    END RECORD,
    g_oqb_t         RECORD
        oqb02       LIKE oqb_file.oqb02,
        oqb03       LIKE oqb_file.oqb03,
        oqb031      LIKE oqb_file.oqb031,
        oqb032      LIKE oqb_file.oqb032,
        oqb04       LIKE oqb_file.oqb04,
        oqb05       LIKE oqb_file.oqb05,
        oqb06       LIKE oqb_file.oqb06,
        oqb07       LIKE oqb_file.oqb07,
        oqb08       LIKE oqb_file.oqb08,
        oqb09       LIKE oqb_file.oqb09,
        oqb10       LIKE oqb_file.oqb10,
        oqb11       LIKE oqb_file.oqb11,
        oqb12       LIKE oqb_file.oqb12,
        oqb13       LIKE oqb_file.oqb13,
        oqbud01     LIKE oqb_file.oqbud01,
        oqbud02     LIKE oqb_file.oqbud02,
        oqbud03     LIKE oqb_file.oqbud03,
        oqbud04     LIKE oqb_file.oqbud04,
        oqbud05     LIKE oqb_file.oqbud05,
        oqbud06     LIKE oqb_file.oqbud06,
        oqbud07     LIKE oqb_file.oqbud07,
        oqbud08     LIKE oqb_file.oqbud08,
        oqbud09     LIKE oqb_file.oqbud09,
        oqbud10     LIKE oqb_file.oqbud10,
        oqbud11     LIKE oqb_file.oqbud11,
        oqbud12     LIKE oqb_file.oqbud12,
        oqbud13     LIKE oqb_file.oqbud13,
        oqbud14     LIKE oqb_file.oqbud14,
        oqbud15     LIKE oqb_file.oqbud15
                    END RECORD,
    g_wc,g_wc2,g_sql    string,  #No.FUN-580092 HCN
    g_cmd           LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(100)
    g_seq1,g_seq2   LIKE type_file.num5,    #No.FUN-680137 SMALLINT
    g_t1            LIKE oay_file.oayslip,              #No.FUN-550070  #No.FUN-680137 VARCHAR(05)
    g_rec_b         LIKE type_file.num5,                #單身筆數  #No.FUN-680137 SMALLINT
    l_cmd           LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(300)
    l_wc            LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(300)
    l_ac            LIKE type_file.num5,                #目前處理的ARRAY CNT  #No.FUN-680137 SMALLINT
    l_n             LIKE type_file.num5    #No.FUN-680137 SMALLINT
DEFINE p_row,p_col     LIKE type_file.num5    #No.FUN-680137 SMALLINT
#主程式開始
DEFINE g_forupd_sql         STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5    #No.FUN-680137 SMALLINT
DEFINE   g_chr           LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)
DEFINE   g_cnt           LIKE type_file.num10   #No.FUN-680137 INTEGER
DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose  #No.FUN-680137 SMALLINT
DEFINE   g_msg           LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(72)
DEFINE   g_row_count    LIKE type_file.num10   #No.FUN-680137 INTEGER
DEFINE   g_curs_index   LIKE type_file.num10   #No.FUN-680137 INTEGER
DEFINE   g_jump         LIKE type_file.num10   #No.FUN-680137 INTEGER
DEFINE   mi_no_ask      LIKE type_file.num5    #No.FUN-680137 SMALLINT
DEFINE   g_argv1        LIKE oqa_file.oqa01  #No.FUN-680137 VARCHAR(16)  #No.TQC-630066
DEFINE   g_argv2        STRING               #No.TQC-630066
DEFINE   b_oqb          RECORD LIKE oqb_file.*  #FUN-730018
DEFINE   g_oqb04_t      LIKE  oqb_file.oqb04  #FUN-910088--add--
#FUN-CB0014 ---------------Begin------------
DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode
DEFINE   g_action_flag  STRING
DEFINE   g_rec_b1       LIKE type_file.num10
DEFINE   l_ac1          LIKE type_file.num10
DEFINE   g_oqa_1     DYNAMIC ARRAY OF RECORD
                        oqa01_1     LIKE oqa_file.oqa01,
                        oqa02_1     LIKE oqa_file.oqa02,
                        oqa03_1     LIKE oqa_file.oqa03,
                        oqa031_1    LIKE oqa_file.oqa031,
                        oqa032_1    LIKE oqa_file.oqa032,
                        oqa05_1     LIKE oqa_file.oqa05,
                        gem02_1     LIKE gem_file.gem02,
                        oqa06_1     LIKE oqa_file.oqa06,
                        occ02_1     LIKE occ_file.occ02,
                        oqa07_1     LIKE oqa_file.oqa07,
                        gen02_1     LIKE gen_file.gen02,
                        oqa08_1     LIKE oqa_file.oqa08,
                        oqa09_1     LIKE oqa_file.oqa09,
                        oqa10_1     LIKE oqa_file.oqa10,
                        oqa11_1     LIKE oqa_file.oqa11,
                        oqa12_1     LIKE oqa_file.oqa12,
                        oqaconf_1   LIKE oqa_file.oqaconf
                      END RECORD
#FUN-CB0014 ---------------End--------------
DEFINE g_oqaud03_cmbo  STRING # add by lixwz 20170817
DEFINE g_azi01 LIKE azi_file.azi01  # add by llixwz 20170817
DEFINE g_boxprice     STRING      # add by lixwz 20170831
DEFINE g_box  ARRAY[3] OF CHAR(100)

MAIN

   OPTIONS                                #改變一些系統預設值
       INPUT NO WRAP,
       FIELD ORDER FORM                   #整個畫面會依照p_per所設定的欄位順序(忽略4gl寫的順序)  #FUN-730018

   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AXM")) THEN
      EXIT PROGRAM
   END IF

   LET g_argv1=ARG_VAL(1)           #No.TQC-630066
   LET g_argv2=ARG_VAL(2)           #No.TQC-630066

      CALL  cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0094
         RETURNING g_time    #No.FUN-6A0094

    LET g_forupd_sql = "SELECT * FROM oqa_file WHERE oqa01 = ?  FOR UPDATE"
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t310_cl CURSOR FROM g_forupd_sql

    LET p_row = 2 LET p_col = 2
    OPEN WINDOW t310_w AT p_row,p_col           #顯示畫面
         WITH FORM "axm/42f/axmt310"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_init()
    #CHI-DC0021 add begin--------------
    IF g_sma.sma118 = "N" THEN
      CALL cl_set_comp_visible("oqa18",FALSE)
    END IF
    #CHI-DC0021 add end----------------
    # add by lixwz 20170817 s
    # 生成币别下拉框item
    DECLARE t310_curoqaud03 CURSOR FOR
        SELECT UNIQUE azi01 FROM azi_file
    LET g_oqaud03_cmbo = ""
    FOREACH t310_curoqaud03 INTO g_azi01
    IF cl_null(g_oqaud03_cmbo) THEN
             LET g_oqaud03_cmbo=g_azi01
    ELSE
             LET g_oqaud03_cmbo=g_oqaud03_cmbo CLIPPED,",",g_azi01 CLIPPED
    END IF
    END FOREACH
    CALL cl_set_combo_items("oqaud03",g_oqaud03_cmbo,g_oqaud03_cmbo)
    # add by lixwz 20170717 e
    IF NOT cl_null(g_argv1) THEN
       CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t310_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t310_a()
            END IF
         OTHERWISE               #TQC-660088
               CALL t310_q()     #TQC-660088
      END CASE
     END IF

    WHILE TRUE

      LET g_action_choice = ""
      CALL t310_menu()
      IF g_action_choice = 'exit' THEN EXIT WHILE END IF
    END WHILE

    CLOSE WINDOW t310_w                 #結束畫面
      CALL  cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0094
         RETURNING g_time    #No.FUN-6A0094
END MAIN

#QBE 查詢資料
FUNCTION t310_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
    CLEAR FORM                             #清除畫面
    CALL g_oqb.clear()

    IF cl_null(g_argv1) THEN #No.TQC-630066
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

   INITIALIZE g_oqa.* TO NULL    #No.FUN-750051
    CONSTRUCT BY NAME g_wc ON                     # 螢幕上取單頭條件
        oqa01,oqa02,oqa03,oqa18,oqa031,oqa032,oqa04,oqa041,oqa042, #CHI-DC0021 add oqa18
        oqa06,oqa07,oqa05,oqa08,oqa09,oqa10,oqa11,oqa12,oqaconf,
        oqa13,oqa14,oqa15,oqa16,oqa17,
        oqauser,oqagrup,oqamodu,oqadate,oqaacti,
        oqaoriu,oqaorig,  #TQC-B80189
        oqaud01,oqaud02,oqaud03,oqaud04,oqaud05,
        oqaud06,oqaud07,oqaud08,oqaud09,oqaud10,
        oqaud11,oqaud12,oqaud13,oqaud14,oqaud15
        ,ta_oqa01 # add by lixwz 20170930
               BEFORE CONSTRUCT
                  CALL cl_qbe_init()

        ON ACTION controlp
           CASE
              WHEN INFIELD(oqa01) #單號
##MOD-4A0252估價單號開窗功能
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oqa"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oqa01
                   NEXT FIELD oqa01
              WHEN INFIELD(oqa03)
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()
#                   LET g_qryparam.state = "c"
#                   LET g_qryparam.form ="q_ima"
#                   CALL cl_create_qry() RETURNING g_oqa.oqa03
                   CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_oqa.oqa03
#FUN-AA0059---------mod------------end-----------------
                   DISPLAY BY NAME g_oqa.oqa03
                   NEXT FIELD oqa03
              WHEN INFIELD(oqa05)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_gem"
                   CALL cl_create_qry() RETURNING g_oqa.oqa05
                    DISPLAY BY NAME g_oqa.oqa05        #No.MOD-490371
                   NEXT FIELD oqa05
              WHEN INFIELD(oqa06)
                   CALL q_occ08(TRUE,TRUE)                                 #FUN-890011 Add
                   RETURNING g_qryparam.multiret                           #FUN-890011 Add
                   DISPLAY g_qryparam.multiret TO oqa06                    #FUN-890011 Add
              WHEN INFIELD(oqa07)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_gen"
                   CALL cl_create_qry() RETURNING g_oqa.oqa07
                    DISPLAY BY NAME g_oqa.oqa07        #No.MOD-490371
                   NEXT FIELD oqa07
              WHEN INFIELD(oqa08)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_azi"
                   CALL cl_create_qry() RETURNING g_oqa.oqa08
                    DISPLAY BY NAME g_oqa.oqa08        #No.MOD-490371
                   NEXT FIELD oqa08
#CHI-DC0021 add begin-------
              WHEN INFIELD(oqa18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form = "q_bma7"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oqa18
                    NEXT FIELD oqa18
#CHI-DC0021 add end------------
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
    IF INT_FLAG THEN RETURN END IF
    LET g_wc = g_wc CLIPPED,cl_get_extra_cond('oqauser', 'oqagrup')

    CONSTRUCT g_wc2 ON oqb02,oqb03,oqb031,oqb032,oqb04,oqb05,oqb06,oqb07,oqb08,
                       oqb09,oqb10,oqb11,oqb12,oqb13,
                       oqbud01,oqbud02,oqbud03,oqbud04,oqbud05,
                       oqbud06,oqbud07,oqbud08,oqbud09,oqbud10,
                       oqbud11,oqbud12,oqbud13,oqbud14,oqbud15

            FROM s_oqb[1].oqb02,s_oqb[1].oqb03,s_oqb[1].oqb031,s_oqb[1].oqb032,
                 s_oqb[1].oqb04,s_oqb[1].oqb05,s_oqb[1].oqb06,s_oqb[1].oqb07,
                 s_oqb[1].oqb08,s_oqb[1].oqb09,s_oqb[1].oqb10,s_oqb[1].oqb11,
                 s_oqb[1].oqb12,s_oqb[1].oqb13,
                 s_oqb[1].oqbud01,s_oqb[1].oqbud02,s_oqb[1].oqbud03,
                 s_oqb[1].oqbud04,s_oqb[1].oqbud05,s_oqb[1].oqbud06,
                 s_oqb[1].oqbud07,s_oqb[1].oqbud08,s_oqb[1].oqbud09,
                 s_oqb[1].oqbud10,s_oqb[1].oqbud11,s_oqb[1].oqbud12,
                 s_oqb[1].oqbud13,s_oqb[1].oqbud14,s_oqb[1].oqbud15

		#No.FUN-580031 --start--     HCN
		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
		#No.FUN-580031 --end--       HCN

        ON ACTION controlp
           CASE
              WHEN INFIELD(oqb03)
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()
#                   LET g_qryparam.state = "c"
#                   LET g_qryparam.form ="q_ima"
#                   CALL cl_create_qry() RETURNING g_oqb[1].oqb03
                    CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_oqb[1].oqb03
#FUN-AA0059---------mod------------end-----------------
                    DISPLAY BY NAME g_oqb[1].oqb03        #No.MOD-490371
                   NEXT FIELD oqb03
              WHEN INFIELD(oqb04)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_gfe"
                   CALL cl_create_qry() RETURNING g_oqb[1].oqb04
                    DISPLAY BY NAME g_oqb[1].oqb04        #No.MOD-490371
                   NEXT FIELD oqb04
              WHEN INFIELD(oqb07)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_azi"
                   LET g_qryparam.default1 = g_oqb[1].oqb07
                   CALL cl_create_qry() RETURNING g_oqb[1].oqb07
                    DISPLAY BY NAME g_oqb[1].oqb07        #No.MOD-490371
                   NEXT FIELD oqb07
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
    ELSE
       LET g_wc =" oqa01 = '",g_argv1,"'"
       LET g_wc2=" 1=1"
    END IF

    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF

    IF g_wc2 = " 1=1" THEN			# 若單身未輸入條件
       LET g_sql = "SELECT  oqa01 FROM oqa_file ",
                   " WHERE ", g_wc CLIPPED,
                   " ORDER BY 1"
     ELSE					# 若單身有輸入條件
       LET g_sql = "SELECT UNIQUE  oqa01 ",
                   "  FROM oqa_file, oqb_file ",
                   " WHERE oqa01 = oqb01",
                   "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                   " ORDER BY 1"
    END IF

    PREPARE t310_prepare FROM g_sql
    DECLARE t310_cs                         #SCROLL CURSOR
        SCROLL CURSOR WITH HOLD FOR t310_prepare
    DECLARE t310_fill_cs CURSOR WITH HOLD FOR t310_prepare     #FUN-CB0014

    IF g_wc2 = " 1=1" THEN			# 取合乎條件筆數
        LET g_sql="SELECT COUNT(*) FROM oqa_file WHERE ",g_wc CLIPPED
    ELSE
        LET g_sql="SELECT COUNT(DISTINCT oqa01) FROM oqa_file,oqb_file WHERE ",
                  "oqb01=oqa01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
    END IF
    PREPARE t310_precount FROM g_sql
    DECLARE t310_count CURSOR FOR t310_precount
END FUNCTION

FUNCTION t310_menu()
DEFINE l_wc  LIKE type_file.chr1000         #No.MOD-650024 ADD  #No.FUN-680137 VARCHAR(200)

   WHILE TRUE
   #  CALL t310_bp("G")    #FUN-CB0014
   #FUN-CB0014 --------Begin----------
      CASE
         WHEN (g_action_flag IS NULL) OR (g_action_flag = "main")
            CALL t310_bp("G")
         WHEN (g_action_flag = "info_list")
            CALL t310_list_fill()
            CALL t310_bp1("G")
            IF NOT cl_null(g_action_choice) AND l_ac1>0 THEN #將清單的資料回傳到主畫面
               SELECT oqa_file.* INTO g_oqa.* FROM oqa_file
                WHERE oqa01=g_oqa_1[l_ac1].oqa01_1
            END IF
            IF g_action_choice!= "" THEN
               LET g_action_flag = 'main'
               LET l_ac1 = ARR_CURR()
               LET g_jump = l_ac1
               LET mi_no_ask = TRUE
               IF g_rec_b1 >0 THEN
                   CALL t310_fetch('/')
               END IF
               CALL cl_set_comp_visible("page1", FALSE)
               CALL cl_set_comp_visible("page2", FALSE)
               CALL ui.interface.refresh()
               CALL cl_set_comp_visible("page1", TRUE)
               CALL cl_set_comp_visible("page2", TRUE)
             END IF
      END CASE
   #FUN-CB0014 --------End----------
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t310_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t310_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t310_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t310_u()
            END IF
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL t310_copy()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t310_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               LET l_wc='oqa01="',g_oqa.oqa01,'"'
               #LET g_msg = "axmr310", #FUN-C30085 mark #TQC-C70039 mark
               LET g_msg = "axmg310", #FUN-C30085 add   #TQC-C70039 取消mark
                   " '",g_today CLIPPED,"' ''",
                   " '",g_lang CLIPPED,"' 'Y' '' '1'",
                   " '",l_wc CLIPPED,"' "
               CALL cl_cmdrun(g_msg)
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "lbr_ovhd_estimate"
            IF cl_chk_act_auth() THEN
               CALL t310_1()
            END IF
         WHEN "other_expense"
            IF cl_chk_act_auth() THEN
               CALL t310_2()
            END IF
         WHEN "mat_lbr_ovhd_apport_"
            IF g_oqa.oqaconf = 'X' THEN
               CALL cl_err(g_oqa.oqa01,'9024',1)
            ELSE
               IF g_oqa.oqaconf = 'Y' THEN
                  CALL cl_err(g_oqa.oqa01,'9023',1)
               ELSE
                  LET g_cmd = "axmp310 "," '",g_oqa.oqa01,"' " CLIPPED
                  CALL cl_cmdrun_wait(g_cmd)
                  CALL t310_sum()
                  CALL t310_show()
               END IF
            END IF
         WHEN "generator_detail_again"
            IF cl_chk_act_auth() THEN
               LET g_chr = 'N'    #TQC-9B0239
               CALL t310_g_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "memo"
            IF cl_chk_act_auth() THEN
               IF NOT cl_null(g_oqa.oqa01) THEN
                  LET g_msg="axmt311 '",g_oqa.oqa01,"' 0 "
                  CALL cl_cmdrun_wait(g_msg)
               END IF
            END IF
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
               CALL t310_y()
            END IF
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t310_z()
            END IF
         WHEN "void"
            IF cl_chk_act_auth() THEN
              #CALL t310_x()   #FUN-D20025
               CALL t310_x(1)  #FUN-D20025
            END IF
         #FUN-D20025--add--str--
         WHEN "undo_void"
            IF cl_chk_act_auth() THEN
              #CALL t310_x()   #FUN-D20025
               CALL t310_x(2)  #FUN-D20025
            END IF
         #FUN-D20025--add--end--
         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
             #CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_oqb),'','') #FUN-CB0014 mark
             #FUN-CB0014 -------Begin--------
               LET w = ui.Window.getCurrent()
               LET f = w.getForm()
               CASE g_action_flag
                  WHEN 'main'
                     LET page = f.FindNode("Page","page1")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_oqb),'','')
                  WHEN 'info_list'
                     LET page = f.FindNode("Page","page2")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_oqa_1),'','')
               END CASE
               LET g_action_choice = NULL
             #FUN-CB0014 -------End---------
            END IF
         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_oqa.oqa01 IS NOT NULL THEN
                 LET g_doc.column1 = "oqa01"
                 LET g_doc.value1 = g_oqa.oqa01
                 CALL cl_doc()
               END IF
         END IF
      END CASE
   END WHILE
END FUNCTION

#Add  輸入
FUNCTION t310_a()
DEFINE li_result LIKE type_file.num5                            #No.FUN-550070  #No.FUN-680137 SMALLINT

    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
   CALL g_oqb.clear()
    INITIALIZE g_oqa.* LIKE oqa_file.*             #DEFAULT 設定
    LET g_oqa01_t = NULL
    #預設值及將數值類變數清成零
    LET g_oqa_t.* = g_oqa.*
    LET g_oqa_o.* = g_oqa.*
    CALL cl_opmsg('a')
    WHILE TRUE
        IF NOT cl_null(g_argv1) AND (g_argv2 = "insert") THEN
           LET g_oqa.oqa01 = g_argv1
        END IF
        LET g_oqa.oqa13=0
        LET g_oqa.oqa14=0
        LET g_oqa.oqa15=0
        LET g_oqa.oqa16=0
        LET g_oqa.oqa17=0
        LET g_oqa.oqauser=g_user
        LET g_oqa.oqaoriu = g_user #FUN-980030
        LET g_oqa.oqaorig = g_grup #FUN-980030
        LET g_data_plant = g_plant #FUN-980030
        LET g_oqa.oqagrup=g_grup
        LET g_oqa.oqadate=g_today
        LET g_oqa.oqaacti='Y'              #資料有效
        LET g_oqa.oqa02=TODAY             #資料有效
        LET g_oqa.oqaconf='N'
        LET g_oqa.oqa07=g_user
        LET g_oqa.oqa08=g_aza.aza17
        LET g_oqa.oqa18 = ' '      #CHI-DC0021 add 特性代碼
        CALL t310_get_oqa09(g_oqa.oqa08,g_oqa.oqa02) RETURNING g_oqa.oqa09   #MOD-D50079 add

        LET g_oqa.oqaplant = g_plant
        LET g_oqa.oqalegal = g_legal

        CALL t310_i("a")                #輸入單頭
        IF INT_FLAG THEN                   #使用者不玩了
            INITIALIZE g_oqa.* TO NULL
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF
        IF g_oqa.oqa01 IS NULL THEN                # KEY 不可空白
            CONTINUE WHILE
        END IF
        BEGIN WORK   #No:7829
#       CALL s_auto_assign_no(g_sys,g_oqa.oqa01,g_oqa.oqa02,"80","oqa_file","oqa01","","","")
        CALL s_auto_assign_no("axm",g_oqa.oqa01,g_oqa.oqa02,"80","oqa_file","oqa01","","","")   #No.FUN-A40041
          RETURNING li_result,g_oqa.oqa01
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY BY NAME g_oqa.oqa01
        INSERT INTO oqa_file VALUES (g_oqa.*)
        IF SQLCA.sqlcode THEN   			#置入資料庫不成功
            CALL cl_err3("ins","oqa_file",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
            ROLLBACK WORK  #No:7829
            CONTINUE WHILE
        END IF
        COMMIT WORK  #No:7829
        CALL cl_flow_notify(g_oqa.oqa01,'I')

        SELECT oqa01 INTO g_oqa.oqa01 FROM oqa_file WHERE oqa01=g_oqa.oqa01

        LET g_oqa01_t = g_oqa.oqa01        #保留舊值
        LET g_oqa_t.* = g_oqa.*

        CALL g_oqb.clear()
        LET g_rec_b = 0
        IF NOT cl_null(g_oqa.oqa03) THEN
            CALL t310_g_b()
        END IF
        CALL t310_b()                   #輸入單身
        EXIT WHILE
    END WHILE

END FUNCTION

FUNCTION t310_u()
    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
    IF g_oqa.oqaacti ='N' THEN    #檢查資料是否為無效
       CALL cl_err(g_oqa.oqa01,9027,0) RETURN
    END IF
    # IF g_oqa.oqaconf='Y' THEN CALL cl_err(g_oqa.oqa01,'axm-101',0) RETURN END IF add by lixwz 20170817
    IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF

    MESSAGE ""

    CALL cl_opmsg('u')
    LET g_oqa01_t = g_oqa.oqa01
    LET g_oqa_o.* = g_oqa.*

    BEGIN WORK

    OPEN t310_cl USING g_oqa.oqa01
    IF STATUS THEN
       CALL cl_err("OPEN t310_cl:", STATUS, 1)
       CLOSE t310_cl
       ROLLBACK WORK
       RETURN
    END IF

    FETCH t310_cl INTO g_oqa.*            # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)      # 資料被他人LOCK
        CLOSE t310_cl ROLLBACK WORK RETURN
    END IF
    CALL t310_show()

    WHILE TRUE
        LET g_oqa01_t = g_oqa.oqa01
        LET g_oqa.oqamodu=g_user
        LET g_oqa.oqadate=g_today
        # add by lixwz 20170928 s
        IF g_oqa.oqaconf = 'Y' THEN
          CALL t310_i_c("u")
        ELSE
          CALL t310_i("u")
        END IF                      #欄位更改
        # add by lixwz 20170928 e
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_oqa.*=g_oqa_t.*
            CALL t310_show()
            CALL cl_err('','9001',0)
            EXIT WHILE
        END IF
        IF g_oqa.oqa01 != g_oqa01_t THEN
            UPDATE oqb_file SET oqb01=g_oqa.oqa01 WHERE oqb01 = g_oqa01_t
            IF SQLCA.sqlcode THEN
                CALL cl_err3("upd","oqb_file",g_oqa01_t,"",SQLCA.sqlcode,"","oqb",1)  CONTINUE WHILE #No.FUN-660167
            END IF
        END IF

        UPDATE oqa_file SET oqa_file.* = g_oqa.*
         WHERE oqa01 = g_oqa.oqa01
        IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
           CALL cl_err3("upd","oqa_file",g_oqa01_t,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
           CONTINUE WHILE
        END IF

        EXIT WHILE

    END WHILE

    CLOSE t310_cl
    COMMIT WORK
    CALL cl_flow_notify(g_oqa.oqa01,'U')

END FUNCTION

#處理INPUT
FUNCTION t310_i(p_cmd)
DEFINE
    l_flag          LIKE type_file.chr1,                 #判斷必要欄位是否有輸入  #No.FUN-680137 VARCHAR(1)
    l_misc          LIKE type_file.chr4,    #No.FUN-680137 VARCHAR(04)
    p_cmd           LIKE type_file.chr1,                 #a:輸入 u:更改  #No.FUN-680137 VARCHAR(1)
    li_result       LIKE type_file.num5                 #No.FUN-550070  #No.FUN-680137 SMALLINT
DEFINE
    l_gem02         LIKE gem_file.gem02,
    l_occ02         LIKE occ_file.occ02,
    l_gen02         LIKE gen_file.gen02,
    l_gen03         LIKE gen_file.gen03  #NO.MOD-590057
DEFINE l_cnt        LIKE type_file.num5           #No.FUN-890011
DEFINE l_chk        LIKE type_file.chr1 # add by lixwz 20170822

    DISPLAY BY NAME
        g_oqa.oqa01,g_oqa.oqa02,g_oqa.oqa03,g_oqa.oqa031,g_oqa.oqa032,
        g_oqa.oqa04,g_oqa.oqa041,g_oqa.oqa042,
        g_oqa.oqa06,g_oqa.oqa07, g_oqa.oqa05,
        g_oqa.oqa08,g_oqa.oqa09,g_oqa.oqa10,g_oqa.oqa11,
        g_oqa.oqa12,g_oqa.oqa17,g_oqa.oqa13,g_oqa.oqa14,g_oqa.oqa15,
        g_oqa.oqa16,g_oqa.oqaconf,
        g_oqa.oqauser,g_oqa.oqagrup,g_oqa.oqamodu,g_oqa.oqadate,g_oqa.oqaacti
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    INPUT  g_oqa.oqaoriu,g_oqa.oqaorig,
        g_oqa.oqa01,g_oqa.oqa02,g_oqa.oqa03,g_oqa.oqa18,g_oqa.oqa031,g_oqa.oqa032, #CHI-DC0021 add oqa18,
        g_oqa.oqa04,g_oqa.oqa041,g_oqa.oqa042,
        g_oqa.oqa06,g_oqa.oqa07,g_oqa.oqa05,
        g_oqa.oqa08,g_oqa.oqa09,g_oqa.oqa10,g_oqa.oqa11,
        g_oqa.oqa12,g_oqa.oqa17,g_oqa.oqa13,g_oqa.oqa14,g_oqa.oqa15,
        g_oqa.oqa16,g_oqa.oqaconf,
        g_oqa.oqauser,g_oqa.oqagrup,g_oqa.oqamodu,g_oqa.oqadate,g_oqa.oqaacti,
        g_oqa.oqaud01,g_oqa.oqaud02,g_oqa.oqaud03,g_oqa.oqaud04,
        g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,
        g_oqa.oqaud09,g_oqa.oqaud10,g_oqa.oqaud11,g_oqa.oqaud12,
        g_oqa.oqaud13,g_oqa.oqaud14,g_oqa.oqaud15,g_oqa.ta_oqa01,g_boxprice
        WITHOUT DEFAULTS
        FROM oqaoriu,oqaorig,
        oqa01,oqa02,oqa03,oqa18,oqa031,oqa032, #CHI-DC0021 add oqa18,
        oqa04,oqa041,oqa042,
        oqa06,oqa07,oqa05,
        oqa08,oqa09,oqa10,oqa11,
        oqa12,oqa17,oqa13,oqa14,oqa15,
        oqa16,oqaconf,
        oqauser,oqagrup,oqamodu,oqadate,oqaacti,
        oqaud01,oqaud02,oqaud03,oqaud04,
        oqaud05,oqaud06,oqaud07,oqaud08,
        oqaud09,oqaud10,oqaud11,oqaud12,
        oqaud13,oqaud14,oqaud15,ta_oqa01,boxprice


        BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL t310_set_entry(p_cmd)
            CALL t310_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE
            CALL cl_set_docno_format("oqa01")     #No.FUN-550070

        AFTER FIELD oqa01
            IF NOT cl_null(g_oqa.oqa01) THEN
#           CALL s_check_no(g_sys,g_oqa.oqa01,g_oqa_t.oqa01,"80","oqa_file","oqa01","")
            CALL s_check_no("axm",g_oqa.oqa01,g_oqa_t.oqa01,"80","oqa_file","oqa01","")   #No.FUN-A40041
              RETURNING li_result,g_oqa.oqa01
            DISPLAY BY NAME g_oqa.oqa01
            IF (NOT li_result) THEN
    	       NEXT FIELD oqa01
            END IF
            END IF

        AFTER FIELD oqa02
            IF NOT cl_null(g_oqa.oqa02) THEN
               LET g_oqa_o.oqa02 = g_oqa.oqa02
            END IF

        BEFORE FIELD oqa03
            CALL t310_set_entry(p_cmd)

        AFTER FIELD oqa03
        #CHI-DC0021 add begin-----------
           IF p_cmd = 'u' THEN
              IF NOT cl_null(g_oqa.oqa03) THEN
                 IF g_oqa_o.oqa03 != g_oqa.oqa03 THEN
                    SELECT COUNT(*) INTO l_cnt FROM bma_file
                     WHERE bma01 = g_oqa.oqa03
                       AND bma06 = g_oqa.oqa18
                       AND imaacti='Y' AND bmaacti='Y'
                    IF l_cnt = 0 THEN
                       CALL cl_err('','abm-618',1)
                       NEXT FIELD oqa03
                    ELSE
                       IF cl_confirm('aap-701') THEN
                          UPDATE oqa_file SET oqa_file.* = g_oqa.*
                           WHERE oqa01 = g_oqa.oqa01
                          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                             CALL cl_err3("upd","oqa_file",g_oqa01_t,"",SQLCA.sqlcode,"","",1)
                             NEXT FIELD oqa03
                          ELSE
                             CALL t310_g_b()
                             IF NOT INT_FLAG THEN
                                EXIT INPUT
                             END IF
                          END IF
                       END IF
                    END IF
                 END IF
              END IF
           END IF
        #CHI-DC0021 add end------------
            IF NOT cl_null(g_oqa.oqa03) THEN
#FUN-AA0059 ---------------------start----------------------------
              IF NOT s_chk_item_no(g_oqa.oqa03,"") THEN
                 CALL cl_err('',g_errno,1)
                 LET g_oqa.oqa03= g_oqa_t.oqa03
                NEXT FIELD oqa03
              END IF
#FUN-AA0059 ---------------------end-------------------------------

               LET l_misc=g_oqa.oqa03[1,4]
               IF g_oqa.oqa03[1,4]='MISC' THEN  #NO:6808
                   SELECT COUNT(*) INTO l_n FROM ima_file
                    WHERE ima01=l_misc
                      AND ima01='MISC'
                       AND imaacti = 'Y'  #MOD-570107
                   IF l_n=0 THEN
                      CALL cl_err('','aim-806',0)
                      NEXT FIELD oqa03
                   END IF
                END IF
                SELECT ima02,ima021 INTO g_oqa.oqa031,g_oqa.oqa032
                  FROM ima_file WHERE ima01=g_oqa.oqa03
                    AND imaacti = 'Y'  #MOD-570107
                IF STATUS  AND g_oqa.oqa03[1,4] !='MISC' THEN #NO:6808
                   CALL cl_err3("sel","ima_file",g_oqa.oqa03,"",'mfg0002',"","",1)  #No.FUN-660167
                   NEXT FIELD oqa03
                END IF
                DISPLAY BY NAME g_oqa.oqa031,g_oqa.oqa032
                LET g_oqa_o.oqa03 = g_oqa.oqa03
                CALL t310_set_no_entry(p_cmd)
             END IF
        #CHI-DC0021 add begin-----------
        # add by lixwz 20170904 s
        AFTER FIELD oqa042
           IF NOT cl_null (g_oqa.oqa042) THEN
              IF g_oqa.oqa042 > 0 THEN
                  IF  NOT cl_null(g_oqa.oqaud01) AND NOT cl_null(g_oqa.oqaud04) THEN
                      CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                      DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                  END IF
              ELSE
                  CALL cl_err(g_oqa.oqa042,'mfg5034',0)
                  NEXT FIELD oqa042
              END IF
           END IF
        # add by lixwz 20170904 e
        AFTER FIELD oqa18
           IF p_cmd = 'u' THEN
              IF NOT cl_null(g_oqa.oqa18) THEN
                 IF g_oqa_o.oqa18 != g_oqa.oqa18 THEN
                    SELECT COUNT(*) INTO l_cnt FROM bma_file
                     WHERE bma01 = g_oqa.oqa03
                       AND bma06 = g_oqa.oqa18
                       AND imaacti='Y' AND bmaacti='Y'
                    IF l_cnt = 0 THEN
                       CALL cl_err('','abm-618',1)
                       NEXT FIELD oqa18
                    ELSE
                       IF cl_confirm('aap-701') THEN
                          UPDATE oqa_file SET oqa_file.* = g_oqa.*
                           WHERE oqa01 = g_oqa.oqa01
                          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                             CALL cl_err3("upd","oqa_file",g_oqa01_t,"",SQLCA.sqlcode,"","",1)
                             NEXT FIELD oqa18
                          ELSE
                             CALL t310_g_b()
                             IF NOT INT_FLAG THEN
                                EXIT INPUT
                             END IF
                          END IF
                       END IF
                    END IF
                 END IF
              END IF
           END IF
        #CHI-DC0021 add end------------
        AFTER FIELD oqa05
            IF NOT cl_null(g_oqa.oqa05) THEN
               SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01=g_oqa.oqa05
                  AND gemacti='Y'   #NO:6950
               IF STATUS THEN
                  CALL cl_err3("sel","gem_file",g_oqa.oqa05,"",'mfg4001',"","",1)  #No.FUN-660167
                  NEXT FIELD oqa05
               END IF
               DISPLAY l_gem02 TO FORMONLY.gem02
               LET g_oqa_o.oqa05 = g_oqa.oqa05
            END IF

        AFTER FIELD oqa06
            IF NOT cl_null(g_oqa.oqa06) THEN
              SELECT COUNT(*) INTO l_cnt FROM occ_file WHERE occ01=g_oqa.oqa06
              IF l_cnt <> 0 THEN
                 SELECT occ02 INTO l_occ02
                   FROM occ_file WHERE occ01=g_oqa.oqa06
                    AND occacti = 'Y'
                IF STATUS THEN
                   CALL cl_err3("sel","occ_file",g_oqa.oqa06,"",'mfg2732',"","",1)
                   NEXT FIELD oqa06
                END IF
              ELSE
                 SELECT ofd02 INTO l_occ02
                   FROM ofd_file WHERE ofd01=g_oqa.oqa06
                    AND ofdacti = 'Y'
                IF STATUS THEN
                   CALL cl_err3("sel","ofd_file",g_oqa.oqa06,"",'mfg2732',"","",1)
                   NEXT FIELD oqa06
                END IF
              END IF
               DISPLAY l_occ02 TO FORMONLY.occ02
               LET g_oqa_o.oqa06 = g_oqa.oqa06
            END IF

        AFTER FIELD oqa07
            IF NOT cl_null(g_oqa.oqa07) THEN
                SELECT gen02,gen03 INTO l_gen02,l_gen03
                 FROM gen_file WHERE gen01=g_oqa.oqa07
                   AND genacti = 'Y'  #MOD-570107
                IF STATUS THEN
                   CALL cl_err3("sel","gen_file",g_oqa.oqa07,"",'mfg1312',"","",1)  #No.FUN-660167
                   NEXT FIELD oqa07
                END IF
                DISPLAY l_gen02 TO FORMONLY.gen02
                LET g_oqa.oqa05 = l_gen03
                SELECT gem02 INTO l_gem02
                  FROM gem_file
                 WHERE gem01=g_oqa.oqa05
                   AND gemacti='Y'   #NO:6950
                DISPLAY l_gem02 TO FORMONLY.gem02

                IF g_oqa_o.oqa07 <> g_oqa.oqa07 THEN
                   LET g_oqa.oqa05 = l_gen03
                   DISPLAY l_gen02 TO FORMONLY.gen02
                   SELECT gem02 INTO l_gem02
                     FROM gem_file
                    WHERE gem01=g_oqa.oqa05
                      AND gemacti='Y'   #NO:6950
                   IF STATUS THEN
                      CALL cl_err3("sel","gem_file",g_oqa.oqa05,"",'mfg4001',"","",1)  #No.FUN-660167
                      NEXT FIELD oqa05
                   END IF
                   DISPLAY BY NAME g_oqa.oqa05
                   DISPLAY l_gem02 TO FORMONLY.gem02
                END IF

                LET g_oqa_o.oqa07 = g_oqa.oqa07
            END IF

        AFTER FIELD oqa08
            IF NOT cl_null(g_oqa.oqa08) THEN
               CALL t310_oqa08(g_oqa.oqa08)
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_oqa.oqa08,g_errno,0)
                  LET g_oqa.oqa08 = g_oqa_o.oqa08
                  DISPLAY BY NAME g_oqa.oqa08
                  NEXT FIELD oqa08
               END IF
              #MOD-D50079 mod
              #IF g_aza.aza17 = g_oqa.oqa08 THEN   #本幣
              #   LET g_oqa.oqa09 = 1
              #ELSE
              #   CALL s_curr3(g_oqa.oqa08,g_oqa.oqa02,g_oaz.oaz52) RETURNING g_oqa.oqa09
              #END IF
               CALL t310_get_oqa09(g_oqa.oqa08,g_oqa.oqa02) RETURNING g_oqa.oqa09
              #MOD-D50079 mod--end
               DISPLAY BY NAME g_oqa.oqa09
               LET g_oqa_o.oqa08 = g_oqa.oqa08
            END IF

         AFTER FIELD oqa09                      #匯率
            IF NOT cl_null(g_oqa.oqa09) THEN
               IF g_oqa.oqa09 <= 0 THEN
                  CALL cl_err(g_oqa.oqa09,'mfg5034',0)
                  LET g_oqa.oqa09 = g_oqa_o.oqa09
                  DISPLAY BY NAME g_oqa.oqa09
                  NEXT FIELD oqa09
               END IF

               LET g_oqa_o.oqa09 = g_oqa.oqa09
            END IF

         AFTER FIELD oqa10
            IF NOT cl_null(g_oqa.oqa10) THEN
               IF g_oqa.oqa10 <= 0 THEN
                  CALL cl_err(g_oqa.oqa10,'mfg9243',0)
                  LET g_oqa.oqa10 = g_oqa_o.oqa10
                  DISPLAY BY NAME g_oqa.oqa10
                  NEXT FIELD oqa10
               END IF
               LET g_oqa_o.oqa10 = g_oqa.oqa10
            END IF

        #  add by lixwz 20170816 s


        #  add by lixwz 29170816 e
         AFTER FIELD oqaud01
            #IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            IF ( NOT cl_null(g_oqa.oqaud01)) THEN
                IF g_oqa.oqaud01>=0 THEN ELSE
                    CALL cl_err(g_oqa.oqaud01,'mfg5034',0)
                    NEXT FIELD  oqaud01
                END IF
            ELSE
                LET g_oqa.oqaud01 = 0
            END IF
            IF  NOT cl_null(g_oqa.oqaud01)  THEN
                IF NOT cl_null(g_oqa.oqaud04) THEN
                    CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                    DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                END IF
            END IF
            LET l_chk = '0'
         AFTER FIELD oqaud02
           # IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            IF NOT cl_null(g_oqa.oqaud02) THEN
                IF g_oqa.oqaud02 <= 0 THEN
                    CALL cl_err(g_oqa.oqa02,'mfg5034',0)
                    NEXT FIELD  oqaud02
                ELSE
                    CALL t310_sum()
                    CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                    DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                END IF
            END IF
         AFTER FIELD oqaud03
           # IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            IF   cl_null(g_oqa.oqaud03) THEN
                    CALL cl_err(g_oqa.oqa03,'mfg5034',0)
                    NEXT FIELD  oqaud03
            END IF
         AFTER FIELD oqaud04
            #IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            IF (  cl_null(g_oqa.oqaud04)) THEN
                    #CALL cl_err(g_oqa.oqa02,'mfg5034',0)
                    LET g_oqa.oqaud04 = 0
                   # NEXT FIELD  oqaud04
            END IF
            IF NOT cl_null(g_oqa.oqaud01)  THEN
                IF   NOT cl_null(g_oqa.oqaud04)  THEN
                    CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                    DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                END IF
            ELSE
                LET g_oqa.oqaud04 = 0
            END IF
         AFTER FIELD oqaud05
            IF cl_null(g_oqa.oqaud05) THEN
                LET g_oqa.oqaud05 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud06
            IF cl_null(g_oqa.oqaud06) THEN
                LET g_oqa.oqaud06 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud07
            IF cl_null(g_oqa.oqaud07) THEN
                LET g_oqa.oqaud07 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud08
            IF cl_null(g_oqa.oqaud08) THEN
                LET g_oqa.oqaud08 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud09

            IF ( NOT cl_null(g_oqa.oqaud09)) THEN
                IF g_oqa.oqaud09 < 0  THEN
                    CALL cl_err(g_oqa.oqa09,'mfg5034',0)
                    NEXT FIELD  oqaud09
                END IF
            END IF
            CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'1') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
            DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            LET l_chk = '1'
         AFTER FIELD oqaud10
            IF cl_null(g_oqa.oqaud10) THEN
                LET g_oqa.oqaud10 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud11
            IF cl_null(g_oqa.oqaud11) THEN
                LET g_oqa.oqaud11 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud12
            IF cl_null(g_oqa.oqaud12) THEN
                LET g_oqa.oqaud12 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud13
            IF cl_null(g_oqa.oqaud13) THEN
                LET g_oqa.oqaud13 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud14
            IF cl_null(g_oqa.oqaud14) THEN
                LET g_oqa.oqaud14 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqaud15
            IF cl_null(g_oqa.oqaud15) THEN
                LET g_oqa.oqaud15 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD ta_oqa01
            IF cl_null(g_oqa.ta_oqa01) THEN
                LET g_oqa.ta_oqa01 = 0
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF

        AFTER INPUT
           LET g_oqa.oqauser = s_get_data_owner("oqa_file") #FUN-C10039
           LET g_oqa.oqagrup = s_get_data_group("oqa_file") #FUN-C10039
            IF INT_FLAG THEN EXIT INPUT END IF
            LET l_misc=g_oqa.oqa03[1,4]
            IF g_oqa.oqa03[1,4]='MISC' THEN  #NO:6808
                SELECT COUNT(*) INTO l_n FROM ima_file
                 WHERE ima01=l_misc
                   AND ima01='MISC'
                   AND imaacti = 'Y'
                IF l_n=0 THEN
                   CALL cl_err('','aim-806',0)
                   NEXT FIELD oqa03
                END IF
            END IF
            # add by lixwz 170911 s
            # 规格品名为空时才命名为MISC
            IF cl_null(g_oqa.oqa031) THEN
                SELECT ima02 INTO g_oqa.oqa031
                  FROM ima_file
                 WHERE ima01=g_oqa.oqa03
                   AND imaacti = 'Y'
                IF STATUS  AND g_oqa.oqa03[1,4] !='MISC' THEN #NO:6808
                   CALL cl_err3("sel","ima_file",g_oqa.oqa03,"",'mfg0002',"","",1)  #No.FUN-660167
                   NEXT FIELD oqa03
                END IF
            END IF
            IF cl_null(g_oqa.oqa032) THEN
                SELECT ima021 INTO g_oqa.oqa032
                  FROM ima_file
                 WHERE ima01=g_oqa.oqa03
                   AND imaacti = 'Y'
                IF STATUS  AND g_oqa.oqa03[1,4] !='MISC' THEN #NO:6808
                   CALL cl_err3("sel","ima_file",g_oqa.oqa03,"",'mfg0002',"","",1)  #No.FUN-660167
                   NEXT FIELD oqa03
                END IF
            END IF
            # add by lixwz 170911 e
            SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01=g_oqa.oqa05
               AND gemacti='Y'   #NO:6950
            # add by lixwz 20170821 s
            IF cl_null(l_chk) THEN
                LET l_chk ='0'
            END IF
            IF cl_null(g_oqa.oqaud01 ) THEN
                LET g_oqa.oqaud01  = 0
            END IF
            IF cl_null(g_oqa.oqaud02 ) THEN
                LET g_oqa.oqaud02  = 1
            END IF
            IF cl_null(g_oqa.oqaud03 ) THEN
                LET g_oqa.oqaud03  = 'RMB'
            END IF
            IF cl_null(g_oqa.oqaud04 ) THEN
                LET g_oqa.oqaud04 = 0
            END IF
            DISPLAY by NAME   g_oqa.oqaud01,g_oqa.oqaud02,g_oqa.oqaud03,g_oqa.oqaud04
            IF  NOT cl_null(g_oqa.oqaud01)  THEN
                IF NOT cl_null(g_oqa.oqaud04) THEN
                    CALL  t310_get_oqaud1(g_oqa.*,g_oqb,l_chk) RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                    DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                END IF
            END IF
            # add by lixwz 20170821 e
           #MOD-CB0274 -- mark start --   #重複段程式 Mark
           #IF g_oqa.oqa03[1,4]='MISC' THEN  #NO:6808
           #    SELECT COUNT(*) INTO l_n FROM ima_file
           #     WHERE ima01=l_misc
           #       AND ima01='MISC'
           #       AND imaacti = 'Y'
           #    IF l_n=0 THEN
           #       CALL cl_err('','aim-806',0)
           #       NEXT FIELD oqa03
           #    END IF
           #END IF
           #SELECT ima02,ima021 INTO g_oqa.oqa031,g_oqa.oqa032
           #  FROM ima_file
           # WHERE ima01=g_oqa.oqa03
           #   AND imaacti = 'Y'
           #IF STATUS  AND g_oqa.oqa03[1,4] !='MISC' THEN #NO:6808
           #   CALL cl_err3("sel","ima_file",g_oqa.oqa03,"",'mfg0002',"","",1)  #No.FUN-660167
           #   NEXT FIELD oqa03
           #END IF
           #SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01=g_oqa.oqa05
           #   AND gemacti='Y'   #NO:6950
           #MOD-CB0274 -- mark end --
            IF STATUS THEN
               CALL cl_err3("sel","gem_file",g_oqa.oqa05,"",'mfg4001',"","",1)  #No.FUN-660167
               NEXT FIELD oqa05
            END IF
            SELECT COUNT(*) INTO l_cnt FROM occ_file WHERE occ01=g_oqa.oqa06
            IF l_cnt <> 0 THEN
               SELECT occ02 INTO l_occ02
                 FROM occ_file WHERE occ01=g_oqa.oqa06
                  AND occacti = 'Y'
              IF STATUS THEN
                 CALL cl_err3("sel","occ_file",g_oqa.oqa06,"",'mfg2732',"","",1)
                 NEXT FIELD oqa06
              END IF
            ELSE
               SELECT ofd02 INTO l_occ02
                 FROM ofd_file WHERE ofd01=g_oqa.oqa06
                  AND ofdacti = 'Y'
              IF STATUS THEN
                 CALL cl_err3("sel","ofd_file",g_oqa.oqa06,"",'mfg2732',"","",1)
                 NEXT FIELD oqa06
              END IF
            END IF
            SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01=g_oqa.oqa07
              AND genacti = 'Y'
            IF STATUS THEN
               CALL cl_err3("sel","gen_file",g_oqa.oqa07,"",'mfg1312',"","",1)  #No.FUN-660167
               NEXT FIELD oqa07
            END IF
            CALL t310_oqa08(g_oqa.oqa08)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_oqa.oqa08,g_errno,0)
               LET g_oqa.oqa08 = g_oqa_o.oqa08
               DISPLAY BY NAME g_oqa.oqa08
               NEXT FIELD oqa08
            END IF
            IF g_oqa.oqa09 <= 0 THEN
               CALL cl_err(g_oqa.oqa09,'mfg5034',0)
               LET g_oqa.oqa09 = g_oqa_o.oqa09
               DISPLAY BY NAME g_oqa.oqa09
               NEXT FIELD oqa09
            END IF
            IF g_oqa.oqa10 <= 0 THEN
               CALL cl_err(g_oqa.oqa10,'mfg9243',0)
               LET g_oqa.oqa10 = g_oqa_o.oqa10
               DISPLAY BY NAME g_oqa.oqa10
               NEXT FIELD oqa10
              END IF
            IF g_oqa.oqa12 < g_oqa.oqa11 THEN
               CALL cl_err('','axm-513',0)
               NEXT FIELD oqa12
            END IF


        ON ACTION controlp
           CASE
              WHEN INFIELD(oqa01) #單號
                   LET g_t1=s_get_doc_no(g_oqa.oqa01)     #No.FUN-550070
                   CALL q_oay(FALSE,TRUE,g_t1,'80','AXM') RETURNING g_t1   #TQC-670008
                   LET g_oqa.oqa01 = g_t1
                   DISPLAY BY NAME g_oqa.oqa01
                   NEXT FIELD oqa01
              WHEN INFIELD(oqa03)
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()
#                   LET g_qryparam.form ="q_ima"
#                   LET g_qryparam.default1 = g_oqa.oqa03
#                   CALL cl_create_qry() RETURNING g_oqa.oqa03
                 CALL q_sel_ima(FALSE, "q_ima","",g_oqa.oqa03,"","","","","",'' )
                 RETURNING  g_oqa.oqa03

#FUN-AA0059---------mod------------end-----------------
                   DISPLAY BY NAME g_oqa.oqa03
                   NEXT FIELD oqa03
              WHEN INFIELD(oqa05)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gem"
                   LET g_qryparam.default1 = g_oqa.oqa05
                   CALL cl_create_qry() RETURNING g_oqa.oqa05
                   DISPLAY BY NAME g_oqa.oqa05
                   NEXT FIELD oqa05
              WHEN INFIELD(oqa06)
                   CALL q_occ08(FALSE,TRUE)                                #FUN-890011 Add
                   RETURNING g_oqa.oqa06                                   #FUN-890011 Add
                   DISPLAY BY NAME g_oqa.oqa06                             #FUN-890011 Add
              WHEN INFIELD(oqa07)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gen"
                   LET g_qryparam.default1 = g_oqa.oqa07
                   CALL cl_create_qry() RETURNING g_oqa.oqa07
                   DISPLAY BY NAME g_oqa.oqa07
                   NEXT FIELD oqa07
              WHEN INFIELD(oqa08)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_azi"
                   LET g_qryparam.default1 = g_oqa.oqa08
                   CALL cl_create_qry() RETURNING g_oqa.oqa08
                   DISPLAY BY NAME g_oqa.oqa08
                   NEXT FIELD oqa08
              WHEN INFIELD(oqa09)
                   CALL s_rate(g_oqa.oqa08,g_oqa.oqa09) RETURNING g_oqa.oqa09
                   DISPLAY BY NAME g_oqa.oqa09
                   NEXT FIELD oqa09
#CHI-DC0021 add begin---------------
              WHEN INFIELD(oqa18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_bma7"
                    LET g_qryparam.default1 = g_oqa.oqa18
                    LET g_qryparam.arg1 = g_oqa.oqa03
                    CALL cl_create_qry() RETURNING g_oqa.oqa18
                    DISPLAY BY NAME g_oqa.oqa18
                    NEXT FIELD oqa18
#CHI-DC0021 add end-----------------
            END CASE

        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913


        ON ACTION CONTROLR
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

    # add by lixwz 20170831 s
    # 输入纸箱单价
    #INPUT  g_boxprice FROM boxprice
    #  AFTER FIELD boxprice
    #    IF NOT cl_null(g_boxprice) THEN
    #        IF g_boxprice < 0 THEN
    #        END IF
    #    END IF
    #END INPUT
    # add by lixwz 20170831 e
END FUNCTION

FUNCTION t310_set_entry(p_cmd)
 DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("oqa01",TRUE)
    END IF

    IF INFIELD(oqa03) OR (NOT g_before_input_done) THEN
       CALL cl_set_comp_entry("oqa031,oqa032",TRUE)
    END IF

END FUNCTION

FUNCTION t310_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("oqa01",FALSE)
    END IF

    IF INFIELD(oqa03) OR (NOT g_before_input_done) THEN
       IF g_oqa.oqa03[1,4] != 'MISC' THEN
          CALL cl_set_comp_entry("oqa031,oqa032",FALSE)
       END IF
    END IF

END FUNCTION

#Query 查詢
FUNCTION t310_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_oqa.* TO NULL              #No.FUN-6B0079  add
    CALL cl_opmsg('q')
    MESSAGE ""
    CLEAR FORM
   CALL g_oqb.clear()
    DISPLAY '   ' TO FORMONLY.cnt
    CALL t310_cs()
    IF INT_FLAG THEN
        LET INT_FLAG = 0
        RETURN
    END IF
    MESSAGE " SEARCHING ! "

    OPEN t310_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_oqa.* TO NULL
    ELSE
        OPEN t310_count
        FETCH t310_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL t310_fetch('F')                  # 讀出TEMP第一筆並顯示
        CALL t310_list_fill()                 #FUN-CB0014
    END IF

    MESSAGE ""
END FUNCTION

#處理資料的讀取
FUNCTION t310_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1                  #處理方式  #No.FUN-680137 VARCHAR(1)

    CASE p_flag
        WHEN 'N' FETCH NEXT     t310_cs INTO g_oqa.oqa01
        WHEN 'P' FETCH PREVIOUS t310_cs INTO g_oqa.oqa01
        WHEN 'F' FETCH FIRST    t310_cs INTO g_oqa.oqa01
        WHEN 'L' FETCH LAST     t310_cs INTO g_oqa.oqa01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
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
                    EXIT CASE
                END IF
             END IF
             FETCH ABSOLUTE g_jump t310_cs INTO g_oqa.oqa01
             LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN
        CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)
        INITIALIZE g_oqa.* TO NULL  #TQC-6B0105
        LET g_oqa.oqa01 = NULL      #TQC-6B0105
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
    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01 = g_oqa.oqa01
    IF SQLCA.sqlcode THEN
        CALL cl_err3("sel","oqa_file",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
        INITIALIZE g_oqa.* TO NULL
        RETURN
    END IF
    LET g_data_owner = g_oqa.oqauser      #FUN-4C0057 add
    LET g_data_group = g_oqa.oqagrup      #FUN-4C0057 add
    LET g_data_plant = g_oqa.oqaplant #FUN-980030
    CALL t310_show()
END FUNCTION

#將資料顯示在畫面上
FUNCTION t310_show()
   DEFINE
    l_gem02         LIKE gem_file.gem02,
    l_occ02         LIKE occ_file.occ02,
    l_gen02         LIKE gen_file.gen02
   DEFINE l_cnt  LIKE type_file.num5
   DEFINE l_oqb_s   LIKE oqa_file.oqaud10
   DEFINE l_oqa             RECORD
                      p_oqaud10  LIKE type_file.chr10,
                      p_oqaud11  LIKE type_file.chr10,
                      p_oqaud12  LIKE type_file.chr10,
                      p_oqaud13  LIKE type_file.chr10,
                      p_oqaud14  LIKE type_file.chr10,
                      p_oqaud15  LIKE type_file.chr10,
                      p_ta_oqa01 LIKE type_file.chr10
                             END RECORD
# add by lixwz 20170817 s

    LET g_oqa_t.* = g_oqa.*                #保存單頭舊值
    # add by lixwz 20170817 s
    # 更新百分比到画面
    LET l_oqb_s = g_oqa.oqaud10 + g_oqa.oqaud11 + g_oqa.oqaud12 + g_oqa.oqaud13 + g_oqa.oqaud14 + g_oqa.oqaud15
    LET l_oqa.p_oqaud10 = cl_replace_str(g_oqa.oqaud10/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud11 = cl_replace_str(g_oqa.oqaud11/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud12 = cl_replace_str(g_oqa.oqaud12/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud13 = cl_replace_str(g_oqa.oqaud13/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud14 = cl_replace_str(g_oqa.oqaud14/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud15 = cl_replace_str(g_oqa.oqaud15/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_ta_oqa01 = cl_replace_str(g_oqa.ta_oqa01/l_oqb_s *100," ","") , "%" # add by lixwz 20170930
    # add by lixwz 20170817 e
    DISPLAY BY NAME g_oqa.oqaoriu,g_oqa.oqaorig,                              # 顯示單頭值


        g_oqa.oqa01,g_oqa.oqa02,g_oqa.oqa03,g_oqa.oqa18,g_oqa.oqa031,g_oqa.oqa032,   #CHI-DC0021 add oqa18
        g_oqa.oqa04,g_oqa.oqa041,g_oqa.oqa042,g_oqa.oqa05,g_oqa.oqa06,
        g_oqa.oqa07,g_oqa.oqa08,g_oqa.oqa09,g_oqa.oqa10,g_oqa.oqa11,
        g_oqa.oqa12,g_oqa.oqa17,g_oqa.oqa13,g_oqa.oqa14,g_oqa.oqa15,
        g_oqa.oqa16,g_oqa.oqaconf,
        g_oqa.oqauser,g_oqa.oqagrup,g_oqa.oqamodu,g_oqa.oqadate,g_oqa.oqaacti,
        g_oqa.oqaud01,g_oqa.oqaud02,g_oqa.oqaud03,g_oqa.oqaud04,
        g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,
        g_oqa.oqaud09,g_oqa.oqaud10,g_oqa.oqaud11,g_oqa.oqaud12,
        g_oqa.oqaud13,g_oqa.oqaud14,g_oqa.oqaud15,g_oqa.ta_oqa01
        #   add by lixwz 20170817 s
        ,l_oqa.p_oqaud10,l_oqa.p_oqaud11,l_oqa.p_oqaud12
        ,l_oqa.p_oqaud13,l_oqa.p_oqaud14,l_oqa.p_oqaud15
        ,l_oqa.p_ta_oqa01
        #  add by lixwz 20170817 e
    #CKP
    IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF  #FUN-730018 解除remark
    CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")  #FUN-730018 解除remark

    SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01=g_oqa.oqa05
    DISPLAY l_gem02 TO FORMONLY.gem02
    SELECT occ02 INTO l_occ02 FROM occ_file WHERE occ01=g_oqa.oqa06
    DISPLAY l_occ02 TO FORMONLY.occ02
    SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01=g_oqa.oqa07
    DISPLAY l_gen02 TO FORMONLY.gen02

    CALL t310_b_fill(g_wc2)                 #單身
    CALL t310_list_fill()                   #FUN-CB0014
    CALL cl_show_fld_cont()                 #No.FUN-550037 hmf
END FUNCTION

#取消整筆 (所有合乎單頭的資料)
FUNCTION t310_r()
    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err("",-400,0) RETURN END IF

    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
    IF g_oqa.oqaacti ='N' THEN    #檢查資料是否為無效
       CALL cl_err(g_oqa.oqa01,9027,0) RETURN
    END IF

    IF g_oqa.oqaconf='Y' THEN CALL cl_err(g_oqa.oqa01,'axm-101',0) RETURN END IF
    IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF

    BEGIN WORK

    OPEN t310_cl USING g_oqa.oqa01
    IF STATUS THEN
       CALL cl_err("OPEN t310_cl:", STATUS, 1)
       CLOSE t310_cl
       ROLLBACK WORK
       RETURN
    END IF

    FETCH t310_cl INTO g_oqa.*               # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)          #資料被他人LOCK
        CLOSE t310_cl ROLLBACK WORK RETURN
    END IF

    CALL t310_show()
    IF cl_delh(0,0) THEN                   #確認一下
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "oqa01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_oqa.oqa01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                #No.FUN-9B0098 10/02/24
       DELETE FROM oqa_file WHERE oqa01 = g_oqa.oqa01
       DELETE FROM oqb_file WHERE oqb01 = g_oqa.oqa01
       DELETE FROM oqc_file WHERE oqc01 = g_oqa.oqa01
       DELETE FROM oqd_file WHERE oqd01 = g_oqa.oqa01
       DELETE FROM oqe_file WHERE oqe01 = g_oqa.oqa01
       INITIALIZE g_oqa.* TO NULL
       CLEAR FORM
       CALL g_oqb.clear()
    END IF

    #TQC-980062---Begin
    OPEN t310_count
    #FUN-B50064-add-start--
    IF STATUS THEN
       CLOSE t310_cs
       CLOSE t310_count
       COMMIT WORK
       RETURN
    END IF
    #FUN-B50064-add-end--
    FETCH t310_count INTO g_row_count
    #FUN-B50064-add-start--
    IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
       CLOSE t310_cs
       CLOSE t310_count
       COMMIT WORK
       RETURN
    END IF
    #FUN-B50064-add-end--
    DISPLAY g_row_count TO FORMONLY.cnt
    OPEN t310_cs
    IF g_curs_index = g_row_count + 1 THEN
       LET g_jump = g_row_count
       CALL t310_fetch('L')
    ELSE
       LET g_jump = g_curs_index
       LET mi_no_ask = TRUE
       CALL t310_fetch('/')
    END IF
    CLOSE t310_cl
    COMMIT WORK
    CALL cl_flow_notify(g_oqa.oqa01,'D')

END FUNCTION

#單身
FUNCTION t310_b()
DEFINE
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT  #No.FUN-680137 SMALLINT
    l_n,l_cnt,l_num,l_numcr,l_numma,l_nummi LIKE type_file.num5,     #檢查重複用  #No.FUN-680137 SMALLINT
    l_lock_sw       LIKE type_file.chr1,                 #單身鎖住否  #No.FUN-680137 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,                 #處理狀態  #No.FUN-680137 VARCHAR(1)
    l_misc          LIKE type_file.chr4,    #No.FUN-680137 VARCHAR(04)
    l_allow_insert  LIKE type_file.num5,                #可新增否  #No.FUN-680137 SMALLINT
    l_allow_delete  LIKE type_file.num5                 #可刪除否  #No.FUN-680137 SMALLINT
# add by lixwz 20170929 s
DEFINE l_str        STRING
DEFINE l_azj02      LIKE azj_file.azj02
DEFINE tok          base.StringTokenizer
DEFINE l_tok        LIKE type_file.num5
DEFINE l_oqa01      LIKE oqa_file.oqa01
DEFINE l_oqa        RECORD LIKE oqa_file.*
DEFINE l_tc_ohi05   LIKE tc_ohi_file.tc_ohi05
#  add by lixwz 20170929 s

    LET g_action_choice = ""
    IF s_shut(0) THEN RETURN END IF
    IF cl_null(g_oqa.oqa01) THEN RETURN END IF

    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
    IF g_oqa.oqaacti ='N' THEN    #檢查資料是否為無效
        CALL cl_err(g_oqa.oqa01,'aom-000',0) RETURN
    END IF
    IF g_oqa.oqaconf='Y' THEN CALL cl_err(g_oqa.oqa01,'axm-101',0) RETURN END IF
    IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF

    SELECT azi03,azi04,azi05        #估價幣別
      INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oqa.oqa08

    CALL cl_opmsg('b')

    LET g_forupd_sql =
         "SELECT * FROM oqb_file ",
         " WHERE oqb01= ? AND oqb02= ?  FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t310_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    CALL cl_set_comp_entry("oqb11",FALSE) # 估价金额 不能修改

    INPUT ARRAY g_oqb WITHOUT DEFAULTS FROM s_oqb.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

        BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF

            LET l_oqa01 ='' # add by lixwz 20170930

        BEFORE ROW
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t310_cl USING g_oqa.oqa01
            IF STATUS THEN
               CALL cl_err("OPEN t310_cl:", STATUS, 1)
               CLOSE t310_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t310_cl INTO g_oqa.*            # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)      # 資料被他人LOCK
               CLOSE t310_cl ROLLBACK WORK RETURN
            END IF

            IF g_rec_b >= l_ac THEN
               LET p_cmd='u'
               LET g_oqb_t.* = g_oqb[l_ac].*  #BACKUP
               LET g_oqb04_t = g_oqb[l_ac].oqb04   #FUN-910088--add--

               OPEN t310_bcl USING g_oqa.oqa01,g_oqb_t.oqb02
               IF STATUS THEN
                  CALL cl_err("OPEN t310_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t310_bcl INTO b_oqb.* #FUN-730018
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(b_oqb.oqb01,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  ELSE
                     CALL t310_b_move_to() #FUN-730018
                  END IF
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)

            END IF

        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oqb[l_ac].* TO NULL      #900423
            LET g_oqb[l_ac].oqb06='N'
            LET g_oqb[l_ac].oqb07=g_aza.aza17
            LET g_oqb_t.* = g_oqb[l_ac].*         #新輸入資料
            LET g_oqb04_t = NULL   #FUN-910088--add--
            CALL cl_show_fld_cont()     #FUN-550037(smin)
            NEXT FIELD oqb02

        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            IF g_oqb[l_ac].oqb05 IS NULL THEN LET g_oqb[l_ac].oqb05=0 END IF
            IF g_oqb[l_ac].oqb08 IS NULL THEN LET g_oqb[l_ac].oqb08=1 END IF
            IF g_oqb[l_ac].oqb09 IS NULL THEN LET g_oqb[l_ac].oqb09=0 END IF
            IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
            IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF

            CALL t310_b_move_back() #FUN-730018

            LET b_oqb.oqbplant = g_plant
            LET b_oqb.oqblegal = g_legal

            INSERT INTO oqb_file VALUES(b_oqb.*)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","oqb_file",g_oqa.oqa01,g_oqb[l_ac].oqb02,SQLCA.sqlcode,"","",1)  #No.FUN-660167
               CANCEL INSERT
            ELSE
               CALL t310_sum()
               MESSAGE 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cn2
            END IF

        BEFORE FIELD oqb02                        #default 序號
            IF g_oqb[l_ac].oqb02 IS NULL OR
               g_oqb[l_ac].oqb02 = 0 THEN
                SELECT max(oqb02)+1 INTO g_oqb[l_ac].oqb02
                  FROM oqb_file WHERE oqb01 = g_oqa.oqa01
                IF g_oqb[l_ac].oqb02 IS NULL THEN
                   LET g_oqb[l_ac].oqb02 = 1
                END IF
            END IF

       AFTER FIELD oqb02
            IF NOT cl_null(g_oqb[l_ac].oqb02) THEN
               IF g_oqb[l_ac].oqb02 != g_oqb_t.oqb02 OR
                  g_oqb_t.oqb02 IS NULL THEN
                  SELECT COUNT(*) INTO l_n FROM oqb_file
                      WHERE oqb01 = g_oqa.oqa01
                        AND oqb02 = g_oqb[l_ac].oqb02
                  IF l_n > 0 THEN
                     LET g_oqb[l_ac].oqb02 = g_oqb_t.oqb02
                     CALL cl_err('',-239,0) NEXT FIELD oqb02
                  END IF
               END IF
               IF g_oqb[l_ac].oqb02 < 0 THEN
                  CALL cl_err(g_oqb[l_ac].oqb02,"axr-610",0)
                  NEXT FIELD oqb02
               END IF
            END IF
            #NEXT FIELD oqbud01

       BEFORE FIELD oqb03
            CALL t310_set_entry_b(p_cmd)

       AFTER FIELD oqb03
            IF NOT cl_null(g_oqb[l_ac].oqb03) AND g_oqb[l_ac].oqbud01 !='7' THEN
#FUN-AA0059 ---------------------start----------------------------
               IF NOT s_chk_item_no(g_oqb[l_ac].oqb03,"") THEN
                  CALL cl_err('',g_errno,1)
                  LET g_oqb[l_ac].oqb03= g_oqb_t.oqb03
                  NEXT FIELD oqb03
               END IF
#FUN-AA0059 ---------------------end-------------------------------

               IF cl_null(g_oqb_t.oqb03) OR
                 (g_oqb[l_ac].oqb03<>g_oqb_t.oqb03) THEN  #NO:6808
                  LET l_misc=g_oqb[l_ac].oqb03[1,4]
                  IF g_oqb[l_ac].oqb03[1,4]='MISC' THEN  #NO:6808
                      SELECT COUNT(*) INTO l_n FROM ima_file
                       WHERE ima01=l_misc
                         AND ima01='MISC'
                      IF l_n=0 THEN
                          CALL cl_err('','aim-806',0)
                          NEXT FIELD oqb03
                      END IF
                  END IF
                  SELECT ima02,ima021,ima25
                    INTO g_oqb[l_ac].oqb031,g_oqb[l_ac].oqb032,g_oqb[l_ac].oqb04
                    FROM ima_file WHERE ima01=g_oqb[l_ac].oqb03
                  IF SQLCA.SQLCODE THEN
                      IF g_oqb[l_ac].oqb03[1,4] !='MISC' THEN
                           CALL cl_err3("sel","ima_file",g_oqb[l_ac].oqb03,"",'mfg0002',"","",1)  #No.FUN-660167
                           NEXT FIELD oqb03
                      ELSE
                           LET g_oqb[l_ac].oqb031=NULL
                           LET g_oqb[l_ac].oqb032=NULL
                           LET g_oqb[l_ac].oqb04 =NULL
                      END IF
                  END IF
                  DISPLAY BY NAME g_oqb[l_ac].oqb031
                  DISPLAY BY NAME g_oqb[l_ac].oqb032
                  DISPLAY BY NAME g_oqb[l_ac].oqb04
                   # add by lixwz 20170817 s
                   SELECT pmj07t  INTO g_oqb[l_ac].oqbud08 FROM
                        (SELECT pmj07t FROM pmj_file WHERE pmj03=g_oqb[l_ac].oqb03 ORDER BY pmj09 DESC )
                         WHERE rownum=1
                    IF cl_null(g_oqb[l_ac].oqbud08) THEN
                        LET g_oqb[l_ac].oqbud08 = 0
                    END IF
                    DISPLAY BY NAME g_oqb[l_ac].oqbud08
                   # add by lixwz 20170817 e
               END IF
               IF g_oqb[l_ac].oqb03[1,4] !='MISC' THEN   #NO:6808
                  #yemy 20130513  --Begin
                  #IF p_cmd='a' THEN
                  IF cl_null(g_oqb_t.oqb03) OR
                    (g_oqb[l_ac].oqb03<>g_oqb_t.oqb03) THEN
                  #yemy 20130513  --End
                     CALL t310_get_price(g_oqb[l_ac].oqb03,g_oqb[l_ac].oqb04)   #MOD-870213
                          RETURNING g_oqb[l_ac].oqb07,
                                    g_oqb[l_ac].oqb09,
                                    g_oqb[l_ac].oqb12,
                                    g_oqb[l_ac].oqb13

                     SELECT azi03,azi04,azi05          #原幣幣別
                       INTO t_azi03,t_azi04,t_azi05     #No.CHI-6A0004
                       FROM azi_file
                      WHERE azi01 = g_oqb[l_ac].oqb07
                     # add by lixwz 20171009 s
                     # 美元料件优先取cxmi001 中的单价
                     IF g_oqb[l_ac].oqb07 ='USD' THEN
                        SELECT tc_ohi05 INTO l_tc_ohi05 FROM tc_ohi_file
                          WHERE tc_ohi01 = g_oqb[l_ac].oqb03 AND tc_ohi04 = g_oqb[l_ac].oqb07
                        IF NOT cl_null(l_tc_ohi05) THEN LET g_oqb[l_ac].oqb09 = l_tc_ohi05 END IF
                     END IF
                     # add by lixwz 20171009 e
                     IF g_oqb[l_ac].oqb09 IS NULL THEN LET g_oqb[l_ac].oqb09=0 END IF
                     LET g_oqb[l_ac].oqb09 = cl_digcut(g_oqb[l_ac].oqb09,t_azi03)       #No.CHI-6A0004

                     # CALL s_curr3(g_oqb[l_ac].oqb07,g_oqa.oqa02,g_oaz.oaz52) mark by lixwz 171013
                     CALL s_curr3(g_oqb[l_ac].oqb07,g_oqa.oqa02,g_oqa.oqa02)
                          RETURNING g_oqb[l_ac].oqb08
                     # add by lixwz 20170829 s
                     # 汇率
                     IF cl_null(g_oqb[l_ac].oqb13) THEN
                        LET g_oqb[l_ac].oqb13 = TODAY
                     END IF
                     IF MONTH(g_oqb[l_ac].oqb13) > 9 THEN
                        LET l_str = YEAR(g_oqb[l_ac].oqb13),MONTH(g_oqb[l_ac].oqb13)
                     ELSE
                        LET l_str = YEAR(g_oqb[l_ac].oqb13),'0',MONTH(g_oqb[l_ac].oqb13)
                     END IF
                     LET l_azj02 = cl_replace_str(l_str," ","")
                     #IF g_oqb[l_ac].oqb07 = 'USD' THEN
                     #   SELECT azj07 INTO g_oqb[l_ac].oqb08 FROM azj_file
                     #     WHERE azj02 = l_azj02 AND azj01 = g_oqb[l_ac].oqb07
                     #END IF
                     IF g_oqb[l_ac].oqb07 = 'RMB' THEN
                        LET g_oqb[l_ac].oqb08 = 1
                     ELSE
                        LET g_oqb[l_ac].oqb08 = g_oqa.oqaud02
                     END IF
                     # add by lixwz 20170829 e
                     #LET g_oqb[l_ac].oqb08=g_oqb[l_ac].oqb08/g_oqa.oqa09
                     #估價單價
                     LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
                     # add by lixwz 20171013 s
                     # 当项目为”5运费/消毒“时,估价金额=原币单价/单头中（40HQ装箱量）/单头中（装箱量）
                     IF g_oqb[l_ac].oqbud01 = '5' THEN
                        IF g_oqa.oqa042 != 0 AND g_oqa.oqaud01 != 0 THEN
                            LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb09 / g_oqa.oqa042 / g_oqa.oqaud01
                        ELSE
                            LET g_oqb[l_ac].oqb10 = 0
                            CALL cl_err('40HQ装箱量和装箱量不可为0','!',1)
                        END IF
                     END IF
                     # add by lixwz 20171013 e
                     IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
                     LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

                     #估價金額
                     LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05
                     IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
                     LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
                     DISPLAY BY NAME g_oqb[l_ac].oqb07
                     DISPLAY BY NAME g_oqb[l_ac].oqb09
                     DISPLAY BY NAME g_oqb[l_ac].oqb10
                     DISPLAY BY NAME g_oqb[l_ac].oqb11
                     DISPLAY BY NAME g_oqb[l_ac].oqb12
                     DISPLAY BY NAME g_oqb[l_ac].oqb13
                  END IF
               END IF
               LET g_oqb_t.oqb03 = g_oqb[l_ac].oqb03
               CALL t310_set_no_entry_b(p_cmd)
            ELSE
            # add by lixwz 20170930  s
                INITIALIZE l_oqa.* TO NULL
                SELECT * INTO l_oqa.* FROM oqa_file
                  WHERE oqa01 = g_oqb[l_ac].oqb03
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","oqa_file",g_oqa.oqa01,g_oqb_t.oqb02,SQLCA.sqlcode,"","",1)
                END IF
                LET g_oqb[l_ac].oqb031 = l_oqa.oqa031
                LET g_oqb[l_ac].oqb032 = l_oqa.oqa032
                LET g_oqb[l_ac].oqb04 = 'PCS'
                LET g_oqb[l_ac].oqbud07 = 0
                LET g_oqb[l_ac].oqb07 = l_oqa.oqaud03
                LET g_oqb[l_ac].oqb08 = l_oqa.oqaud02
                LET g_oqb[l_ac].oqb09 = l_oqa.oqaud09
                LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb09 * g_oqb[l_ac].oqb08
                LET g_oqb[l_ac].oqb12 = l_oqa01
                LET g_oqb[l_ac].oqb13 = l_oqa.oqa02
                LET l_oqa01 = ''
            # add by lixwz 20170930  e
            END IF
            #NEXT FIELD oqbud07

       BEFORE FIELD oqb031
            IF g_oqb[l_ac].oqb03[1,4] !='MISC' THEN
               NEXT FIELD oqb04
            END IF
       # add by lixwz 20170831
       # 带出40HQ装箱量和纸箱价格
       AFTER FIELD oqb032
            IF NOT cl_null(g_oqb[l_ac].oqb032) AND g_oqb[l_ac].oqb031 LIKE "外箱%" THEN
                LET tok = base.StringTokenizer.create(g_oqb[l_ac].oqb032,"X")
                LET l_tok = 1
                WHILE tok.hasMoreTokens()
                  LET g_box[l_tok] = tok.nextToken()
                  LET g_box[l_tok] = cl_replace_str(g_box[l_tok],'"',"")
                  LET l_tok = l_tok + 1
                END WHILE
                IF NOT cl_null(g_boxprice) AND g_boxprice > 0THEN
                  IF g_oqb[l_ac].oqb03[1,4] ='MISC' AND  ( cl_null(g_oqb[l_ac].oqb09) OR g_oqb[l_ac].oqb09 = 0) THEN
                      #（（长*0.0254+宽*0.0254*2）+0.07）*（宽*0.0254+高*0.0254+0.03）*原纸的平方米单价带出纸箱单价
                    LET l_str ="SELECT ","((",g_box[1] CLIPPED,"*0.0254+",g_box[2] CLIPPED,"*0.0254)*2+0.07)*(",
                                g_box[2] CLIPPED,"*0.0254+",g_box[3] CLIPPED,"*0.0254+0.03)*",g_boxprice CLIPPED,
                                " FROM dual"
                    PREPARE t310_oqb09 FROM l_str
                    EXECUTE t310_oqb09 INTO g_oqb[l_ac].oqb09
                    IF cl_null(g_oqb[l_ac].oqb09) THEN LET g_oqb[l_ac].oqb09 = 0 END IF
                    DISPLAY BY NAME g_oqb[l_ac].oqb09
                  END IF
                END IF
                IF ( cl_null(g_oqa.oqaud01) OR g_oqa.oqaud01 = 0) THEN
                    LET l_str =" SELECT FLOOR((2250/(",g_box[1] CLIPPED,"*",g_box[2] CLIPPED,"*",
                                g_box[3] CLIPPED,"/1728))-1) FROM dual"
                    #2250/（长*宽*高/1728）
                    PREPARE t310_oqaud01 FROM l_str
                    EXECUTE t310_oqaud01 INTO g_oqa.oqaud01
                    IF cl_null(g_oqa.oqaud01) THEN LET g_oqa.oqaud01 = 0 END IF
                    IF  NOT cl_null(g_oqa.oqaud01) AND NOT cl_null(g_oqa.oqaud04) THEN
                        CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                    END IF
                    UPDATE oqa_file SET oqaud01 = g_oqa.oqaud01,
                        oqaud04 = g_oqa.oqaud04,
                        oqaud05 = g_oqa.oqaud05,
                        oqaud06 = g_oqa.oqaud06,
                        oqaud07 = g_oqa.oqaud07,
                        oqaud08 = g_oqa.oqaud08,
                        oqaud09 = g_oqa.oqaud09
                        WHERE oqa01 = g_oqa.oqa01
                    DISPLAY BY NAME g_oqa.oqaud01,g_oqa.oqaud04,g_oqa.oqaud05,
                                    g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
                END IF
            END IF
            NEXT FIELD oqbud07
       # add by lixwz 20170831
       AFTER FIELD oqb04
            IF NOT cl_null(g_oqb[l_ac].oqb04) THEN
               SELECT * FROM gfe_file WHERE gfe01=g_oqb[l_ac].oqb04
               IF STATUS THEN
                  CALL cl_err3("sel","gfe_file",g_oqb[l_ac].oqb04,"",'mfg0019',"","",1)  #No.FUN-660167
                  NEXT FIELD oqb04
               END IF
           #FUN-910088--add--start
               IF NOT t310_oqb05_check(p_cmd) THEN
                  LET g_oqb04_t = g_oqb[l_ac].oqb04
                  NEXT FIELD oeq05
               END IF
               LET g_oqb04_t = g_oqb[l_ac].oqb04
           #FUN-910088--add--end--
            END IF
           # NEXT FIELD oqbud07 # add by lixwz 20170831

       AFTER FIELD oqb05
           IF NOT t310_oqb05_check(p_cmd) THEN NEXT FIELD oqb05 END IF  #FUN-910088--add--
        #FUN-910088--mark--start--
        #   IF NOT cl_null(g_oqb[l_ac].oqb05) THEN
        #      IF g_oqb[l_ac].oqb05<=0 THEN
        #         CALL cl_err(g_oqb[l_ac].oqb05,'mfg9243',0)
        #         NEXT FIELD oqb05
        #      END IF

        #      IF p_cmd = 'u' THEN
        #         #估價單價
        #         LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
        #         IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
        #          LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

        #          #估價金額
        #          LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05
        #          IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF

        #          LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
        #      END IF
        #   END IF
        #FUN-910088--mark--end--
      # add by lixwz 20170829 s
       ON CHANGE oqb05
           IF NOT t310_oqb05_check(p_cmd) THEN NEXT FIELD oqb05 END IF  #FUN-910088--add--
      # add by lixwz 20170829 e

       AFTER FIELD oqb06
            IF NOT cl_null(g_oqb[l_ac].oqb06) THEN
               IF g_oqb[l_ac].oqb06 NOT MATCHES '[YN]' THEN
                  NEXT FIELD oqb06
               END IF
            END IF

      AFTER FIELD oqb11
            IF NOT cl_null(g_oqb[l_ac].oqb11) THEN
                IF g_oqb[l_ac].oqb11 < 0 THEN
                   CALL cl_err('','aim-223',0)
                   NEXT FIELD oqb11
                END IF
                #MOD-D50086 add
                IF NOT cl_null(g_oqb[l_ac].oqb05) AND g_oqb[l_ac].oqb05 !=0 THEN
                   #估價單價
                   LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb11 / g_oqb[l_ac].oqb05
                   LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)
                   #原币單價
                   IF NOT cl_null(g_oqb[l_ac].oqb08) AND g_oqb[l_ac].oqb08 !=0 THEN
                      LET g_oqb[l_ac].oqb09 = g_oqb[l_ac].oqb10 / g_oqb[l_ac].oqb08
                      LET g_oqb[l_ac].oqb09 = cl_digcut(g_oqb[l_ac].oqb09,t_azi03)
                   END IF
                END IF
                #MOD-D50086 add--end
            END IF

       AFTER FIELD oqb07
            IF NOT cl_null(g_oqb[l_ac].oqb07) THEN
               CALL t310_oqa08(g_oqb[l_ac].oqb07)
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_oqb[l_ac].oqb07,g_errno,0)
                  NEXT FIELD oqb07
               END IF
               #CALL s_curr3(g_oqb[l_ac].oqb07,g_oqa.oqa02,g_oaz.oaz52) mark by lixwz 20171013
               CALL s_curr3(g_oqb[l_ac].oqb07,g_oqa.oqa02,g_oqa.oqa02)
                    RETURNING g_oqb[l_ac].oqb08
               # add by lixwz 20170829 s
               # 汇率
               IF cl_null(g_oqb[l_ac].oqb13) THEN
                  LET g_oqb[l_ac].oqb13 = TODAY
               END IF
               IF MONTH(g_oqb[l_ac].oqb13) > 9 THEN
                  LET l_str = YEAR(g_oqb[l_ac].oqb13),MONTH(g_oqb[l_ac].oqb13)
               ELSE
                  LET l_str = YEAR(g_oqb[l_ac].oqb13),'0',MONTH(g_oqb[l_ac].oqb13)
               END IF
               LET l_azj02 = cl_replace_str(l_str," ","")
               IF g_oqb[l_ac].oqb07 = 'USD' THEN
                  SELECT azj07 INTO g_oqb[l_ac].oqb08 FROM azj_file
                    WHERE azj02 = l_azj02 AND azj01 = g_oqb[l_ac].oqb07
               END IF
               IF g_oqb[l_ac].oqb07 = 'RMB' THEN
                  LET g_oqb[l_ac].oqb08 = 1
               ELSE
               # 估价单价取单头
                  LET g_oqb[l_ac].oqb08 = g_oqa.oqaud02
               END IF
               #　add by lixwz 20170829 e
               #LET g_oqb[l_ac].oqb08=g_oqb[l_ac].oqb08/g_oqa.oqa09
               IF p_cmd = 'u' THEN
                   #估價單價
                   LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
                   # add by lixwz 20171013 s
                   # 当项目为”5运费/消毒“时,估价金额=原币单价/单头中（40HQ装箱量）/单头中（装箱量）
                   IF g_oqb[l_ac].oqbud01 = '5' THEN
                      IF g_oqa.oqa042 != 0 AND g_oqa.oqaud01 != 0 THEN
                          LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb09 / g_oqa.oqa042 / g_oqa.oqaud01
                      ELSE
                          LET g_oqb[l_ac].oqb10 = 0
                          CALL cl_err('40HQ装箱量和装箱量不可为0','!',1)
                      END IF
                   END IF
                   # add by lixwz 20171013 e
                   IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
                   LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

                   #估價金額
                    #LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05 # mark by lixwz 20170830
                   LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqbud07 # add by lixwz 20170830
                   IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF

                   LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
               END IF
            END IF

         AFTER FIELD oqb08
            IF NOT cl_null(g_oqb[l_ac].oqb08) THEN
               IF g_oqb[l_ac].oqb08 <= 0 THEN
                  CALL cl_err(g_oqb[l_ac].oqb08,'mfg5034',0)
                  NEXT FIELD oqb08
               END IF
               IF p_cmd = 'u' THEN
                   #估價單價
                   LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
                   # add by lixwz 20171013 s
                   # 当项目为”5运费/消毒“时,估价金额=原币单价/单头中（40HQ装箱量）/单头中（装箱量）
                   IF g_oqb[l_ac].oqbud01 = '5' THEN
                      IF g_oqa.oqa042 != 0 AND g_oqa.oqaud01 != 0 THEN
                          LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb09 / g_oqa.oqa042 / g_oqa.oqaud01
                      ELSE
                          LET g_oqb[l_ac].oqb10 = 0
                          CALL cl_err('40HQ装箱量和装箱量不可为0','!',1)
                      END IF
                   END IF
                   # add by lixwz 20171013 e
                   IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
                   LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

                   #估價金額
                   #LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05 # mark by lixwz 20170830
                   LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqbud07 # add by lixwz 20170830
                   IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
                   LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)

               END IF
            END IF

         AFTER FIELD oqb09
            IF NOT cl_null(g_oqb[l_ac].oqb09) THEN
               CALL t310_oqa08(g_oqb[l_ac].oqb07)

               LET g_oqb[l_ac].oqb09 = cl_digcut(g_oqb[l_ac].oqb09,t_azi03)     #No.CHI-6A0004

               IF g_oqb[l_ac].oqb09 < 0 THEN
                  CALL cl_err(g_oqb[l_ac].oqb09,'mfg5034',0)
                  NEXT FIELD oqb09
               END IF

               IF p_cmd='a' OR (g_oqb[l_ac].oqbud07!=g_oqb_t.oqbud07 OR # mod oqb05 ->oqbud07
                                g_oqb[l_ac].oqb08!=g_oqb_t.oqb08 OR
                                g_oqb[l_ac].oqb09!=g_oqb_t.oqb09) THEN
                  #----------------------------- 估價單身
                  #估價單價
                  LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
                  # add by lixwz 20171013 s
                  # 当项目为”5运费/消毒“时,估价金额=原币单价/单头中（40HQ装箱量）/单头中（装箱量）
                  IF g_oqb[l_ac].oqbud01 = '5' THEN
                     IF g_oqa.oqa042 != 0 AND g_oqa.oqaud01 != 0 THEN
                         LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb09 / g_oqa.oqa042 / g_oqa.oqaud01
                     ELSE
                         LET g_oqb[l_ac].oqb10 = 0
                         CALL cl_err('40HQ装箱量和装箱量不可为0','!',1)
                     END IF
                  END IF
                 # add by lixwz 20171013 e
                  IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
                  LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

                  #估價金額
                   #LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05 # mark by lixwz 20170830
                   LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqbud07 # add by lixwz 20170830
                  IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
                  LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
		   DISPLAY BY NAME g_oqb[l_ac].oqb10
		   DISPLAY BY NAME g_oqb[l_ac].oqb11
               END IF
            END IF

         AFTER FIELD oqb10
            IF NOT cl_null(g_oqb[l_ac].oqb10) THEN
               IF g_oqb[l_ac].oqb10 < 0 THEN
                  CALL cl_err(g_oqb[l_ac].oqb10,'mfg5034',0)
                  NEXT FIELD oqb10
               END IF
               #估價單價
               LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)
               #估價金額
               #LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05 # mark by lixwz 20170830
                   LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqbud07 # add by lixwz 20170830
               IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
               LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
               #MOD-D50086 add
               #原币單價
               IF NOT cl_null(g_oqb[l_ac].oqb08) AND g_oqb[l_ac].oqb08 !=0 THEN
                  LET g_oqb[l_ac].oqb09 = g_oqb[l_ac].oqb10 / g_oqb[l_ac].oqb08
                  LET g_oqb[l_ac].oqb09 = cl_digcut(g_oqb[l_ac].oqb09,t_azi03)
               END IF
               #MOD-D50086 add--end
               # add by lixwz 20171013 s
               #当项目为”5运费/消毒“时，估价金额=原币单价/单头中（40HQ装箱量）/单头中（装箱量）
               IF g_oqb[l_ac].oqbud01 = '5' THEN
                  LET g_oqb[l_ac].oqb09 = g_oqb[l_ac].oqb10 * g_oqa.oqa042 * g_oqa.oqaud01
                  LET g_oqb[l_ac].oqb09 = cl_digcut(g_oqb[l_ac].oqb09,t_azi03)
               END IF
               # add by lixwz 20171013 e
            END IF

         AFTER FIELD oqbud01
            #IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            #NEXT FIELD oqb03
         AFTER FIELD oqbud02
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud03
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud04
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud05
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud06
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud07
            IF  NOT cl_null(g_oqb[l_ac].oqbud07) THEN
                IF g_oqb[l_ac].oqbud07 < 0 THEN
                    CALL cl_err(g_oqb[l_ac].oqbud07,'mfg5034',0)
                    NEXT FIELD  oqbud07
                END IF
            ELSE
                LET g_oqb[l_ac].oqbud07 = 0
            END IF
            IF NOT t310_oqb05_check(p_cmd) THEN NEXT FIELD oqbud07 END IF
            # IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
            #NEXT FIELD oqb09
         AFTER FIELD oqbud08
            IF  NOT cl_null(g_oqb[l_ac].oqbud08) THEN
                IF g_oqb[l_ac].oqbud08 < 0 THEN
                    CALL cl_err(g_oqb[l_ac].oqbud08,'mfg5034',0)
                    NEXT FIELD  oqbud08
                END IF
            END IF
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud09
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud10
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud11
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud12
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud13
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud14
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
         AFTER FIELD oqbud15
            IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF

        BEFORE DELETE                            #是否取消單身
            IF g_oqb_t.oqb02 > 0 AND
               g_oqb_t.oqb02 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF

                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF

                DELETE FROM oqb_file
                 WHERE oqb01 = g_oqa.oqa01
                   AND oqb02 = g_oqb_t.oqb02
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("del","oqb_file",g_oqa.oqa01,g_oqb_t.oqb02,SQLCA.sqlcode,"","",1)  #No.FUN-660167
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b=g_rec_b-1
                DISPLAY g_rec_b TO FORMONLY.cn2
                CALL t310_sum()
                COMMIT WORK

            END IF

        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_oqb[l_ac].* = g_oqb_t.*
               CLOSE t310_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_oqb[l_ac].oqb02,-263,1)
               LET g_oqb[l_ac].* = g_oqb_t.*
            ELSE
               #IF g_oqb[l_ac].oqb05 IS NULL THEN LET g_oqb[l_ac].oqb05=0 END IF
               # add by lixwz 20170831 s
               IF g_oqb[l_ac].oqb05 IS NULL THEN LET g_oqb[l_ac].oqb05=g_oqb[l_ac].oqbud07 END IF
               IF g_oqb[l_ac].oqbud07 IS NULL THEN LET g_oqb[l_ac].oqbud07=0 END IF
               # add by lixwz 20170831 e
               IF g_oqb[l_ac].oqb08 IS NULL THEN LET g_oqb[l_ac].oqb08=1 END IF
               IF g_oqb[l_ac].oqb09 IS NULL THEN LET g_oqb[l_ac].oqb09=0 END IF
               IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
               IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
               CALL t310_b_move_back() #FUN-730018
               UPDATE oqb_file SET * = b_oqb.*
                WHERE oqb01=g_oqa.oqa01
                  AND oqb02=g_oqb_t.oqb02
               IF SQLCA.sqlcode THEN
                   CALL cl_err3("upd","oqb_file",g_oqa.oqa01,g_oqb_t.oqb02,SQLCA.sqlcode,"","",1)  #No.FUN-660167
                   LET g_oqb[l_ac].* = g_oqb_t.*
               ELSE
                   CALL t310_sum()
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
               END IF

            END IF

        AFTER ROW
            LET l_ac = ARR_CURR()
           #LET l_ac_t = l_ac      #FUN-D30034 Mark
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_oqb[l_ac].* = g_oqb_t.*
               #FUN-D30034--add--str--
               ELSE
                  CALL g_oqb.deleteElement(l_ac)
                  IF g_rec_b != 0 THEN
                     LET g_action_choice = "detail"
                     LET l_ac = l_ac_t
                  END IF
               #FUN-D30034--add--end--
               END IF
               CLOSE t310_bcl
               ROLLBACK WORK
               EXIT INPUT
            ELSE
              #MOD-D50083 mark  此处会使显示异常，此段在AFTER FIELD处控制即可
              #IF NOT cl_null(g_oqb[l_ac].oqb11) THEN
              #  IF g_oqb[l_ac].oqb11 < 0 THEN
              #     CALL cl_err('','aim-223',0)
              #     NEXT FIELD oqb11
              #  END IF
              #END IF
              #MOD-D50083 mark--end
            END IF
            LET l_ac_t = l_ac      #FUN-D30034 Add
            CLOSE t310_bcl
            COMMIT WORK

        ON ACTION CONTROLN
            CALL t310_b_askkey()
            EXIT INPUT
        ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

        ON ACTION controlp
            CASE
               WHEN INFIELD(oqb03)
#FUN-AA0059---------mod------------str-----------------
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ="q_ima"
#                    LET g_qryparam.default1 = g_oqb[l_ac].oqb03
#                    CALL cl_create_qry() RETURNING g_oqb[l_ac].oqb03
                     # add by lixwz 20170930 s
                     IF g_oqb[l_ac].oqbud01 = '7' THEN
                        CALL cl_init_qry_var()
                        LET g_qryparam.form ="q_oqa2"
                        LET g_qryparam.default1 = g_oqb[l_ac].oqb03
                        CALL cl_create_qry() RETURNING g_oqb[l_ac].oqb03
                        #带出没有料号，默认MISC
                        #IF cl_null(g_oqb[l_ac].oqb03) THEN LET g_oqb[l_ac].oqb03 = 'MISC' END IF
                     ELSE
                        CALL q_sel_ima(FALSE, "q_ima","",g_oqb[l_ac].oqb03,"","","","","",'' )
                        RETURNING  g_oqb[l_ac].oqb03
                     END IF
                     # add by lixwz 20170930 e
#FUN-AA0059---------mod------------end-----------------
                     DISPLAY BY NAME g_oqb[l_ac].oqb03     #No.MOD-490371
                    NEXT FIELD oqb03
               WHEN INFIELD(oqb04)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_gfe"
                    LET g_qryparam.default1 = g_oqb[l_ac].oqb04
                    CALL cl_create_qry() RETURNING g_oqb[l_ac].oqb04
                     DISPLAY BY NAME g_oqb[l_ac].oqb04     #No.MOD-490371
                    NEXT FIELD oqb04
               WHEN INFIELD(oqb07)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_azi"
                    LET g_qryparam.default1 = g_oqb[l_ac].oqb07
                    CALL cl_create_qry() RETURNING g_oqb[l_ac].oqb07
                     DISPLAY BY NAME g_oqb[l_ac].oqb07     #No.MOD-490371
                    NEXT FIELD oqb07
            END CASE

        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(oqb02) AND l_ac > 1 THEN
                LET g_oqb[l_ac].* = g_oqb[l_ac-1].*
                LET g_oqb[l_ac].oqb02 = NULL
                NEXT FIELD oqb02
            END IF

        ON ACTION CONTROLR
           CALL cl_show_req_fields()

        ON ACTION CONTROLG
            CALL cl_cmdask()

        ON ACTION enter_memo
                 IF NOT cl_null(g_oqb[l_ac].oqb02) THEN
                      LET g_msg="axmt311 '",g_oqa.oqa01,"' ",g_oqb[l_ac].oqb02
                      CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
                 END IF

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

    LET g_oqa.oqamodu = g_user
    LET g_oqa.oqadate = g_today
    UPDATE oqa_file SET oqamodu = g_oqa.oqamodu,oqadate = g_oqa.oqadate
     WHERE oqa01 = g_oqa.oqa01
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
       CALL cl_err3("upd","oqa_file",g_oqa.oqa01,"",SQLCA.SQLCODE,"","upd oqa",1)  #No.FUN-660167
    END IF
    DISPLAY BY NAME g_oqa.oqamodu,g_oqa.oqadate

    CLOSE t310_bcl
    COMMIT WORK
    CALL t310_delHeader()     #CHI-C30002 add

END FUNCTION

#CHI-C30002 -------- add -------- begin
FUNCTION t310_delHeader()
   DEFINE l_action_choice    STRING               #CHI-C80041
   DEFINE l_cho              LIKE type_file.num5  #CHI-C80041
   DEFINE l_num              LIKE type_file.num5  #CHI-C80041
   DEFINE l_slip             LIKE type_file.chr5  #CHI-C80041
   DEFINE l_sql              STRING               #CHI-C80041
   DEFINE l_cnt              LIKE type_file.num5  #CHI-C80041

   IF g_rec_b = 0 THEN
      #CHI-C80041---begin
     CALL s_get_doc_no(g_oqa.oqa01) RETURNING l_slip
      LET l_sql = " SELECT COUNT(*) FROM oqa_file ",
                  "  WHERE oqa01 LIKE '",l_slip,"%' ",
                  "    AND oqa01 > '",g_oqa.oqa01,"'"
      PREPARE t310_pb1 FROM l_sql
      EXECUTE t310_pb1 INTO l_cnt

      LET l_action_choice = g_action_choice
      LET g_action_choice = 'delete'
      IF cl_chk_act_auth() AND l_cnt = 0 THEN
         CALL cl_getmsg('aec-130',g_lang) RETURNING g_msg
         LET l_num = 3
      ELSE
         CALL cl_getmsg('aec-131',g_lang) RETURNING g_msg
         LET l_num = 2
      END IF
      LET g_action_choice = l_action_choice
      PROMPT g_msg CLIPPED,': ' FOR l_cho
         ON IDLE g_idle_seconds
            CALL cl_on_idle()

         ON ACTION about
            CALL cl_about()

         ON ACTION help
            CALL cl_show_help()

         ON ACTION controlg
            CALL cl_cmdask()
      END PROMPT
      IF l_cho > l_num THEN LET l_cho = 1 END IF
      IF l_cho = 2 THEN
        #CALL t310_x()   #FUN-D20025
         CALL t310_x(1)  #FUN-D20025
      END IF

      IF l_cho = 3 THEN
         DELETE FROM oqc_file WHERE oqc01 = g_oqa.oqa01
         DELETE FROM oqd_file WHERE oqd01 = g_oqa.oqa01
         DELETE FROM oqe_file WHERE oqe01 = g_oqa.oqa01
      #CHI-C80041---end
      #IF cl_confirm("9042") THEN  #CHI-C80041
         DELETE FROM oqa_file WHERE oqa01 = g_oqa.oqa01
         INITIALIZE g_oqa.* TO NULL
         CLEAR FORM
      END IF
   END IF
END FUNCTION
#CHI-C30002 -------- add -------- end

FUNCTION t310_set_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF INFIELD(oqb03) THEN
       CALL cl_set_comp_entry("oqb031,oqb032",TRUE)
    END IF

END FUNCTION

FUNCTION t310_set_no_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF INFIELD(oqb03) THEN
       IF g_oqb[l_ac].oqb03[1,4] !='MISC' THEN
          CALL cl_set_comp_entry("oqb031,oqb032",FALSE)
       END IF
    END IF

END FUNCTION

FUNCTION t310_b_askkey()
DEFINE
    l_wc2           LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(200)

    CONSTRUCT l_wc2 ON oqb02,oqb03,oqb031,oqb032,oqb04,oqb05,oqb06,oqb07,oqb08,
                       oqb09,oqb10,oqb11,oqb12,oqb13,
                       oqbud01,oqbud02,oqbud03,oqbud04,oqbud05,
                       oqbud06,oqbud07,oqbud08,oqbud09,oqbud10,
                       oqbud11,oqbud12,oqbud13,oqbud14,oqbud15
            FROM s_oqb[1].oqb02,s_oqb[1].oqb03,s_oqb[1].oqb031,s_oqb[1].oqb032,
                 s_oqb[1].oqb04,s_oqb[1].oqb05,s_oqb[1].oqb06,s_oqb[1].oqb07,
                 s_oqb[1].oqb08,s_oqb[1].oqb09,s_oqb[1].oqb10,s_oqb[1].oqb11,
                 s_oqb[1].oqb12,s_oqb[1].oqb13,
                 s_oqb[1].oqbud01,s_oqb[1].oqbud02,s_oqb[1].oqbud03,
                 s_oqb[1].oqbud04,s_oqb[1].oqbud05,s_oqb[1].oqbud06,
                 s_oqb[1].oqbud07,s_oqb[1].oqbud08,s_oqb[1].oqbud09,
                 s_oqb[1].oqbud10,s_oqb[1].oqbud11,s_oqb[1].oqbud12,
                 s_oqb[1].oqbud13,s_oqb[1].oqbud14,s_oqb[1].oqbud15

              BEFORE CONSTRUCT
                 CALL cl_qbe_init()

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
    IF INT_FLAG THEN
        LET INT_FLAG = 0
        RETURN
    END IF
    CALL t310_b_fill(l_wc2)
END FUNCTION

FUNCTION t310_b_fill(p_wc2)              #BODY FILL UP
DEFINE
    p_wc2           LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(200)

    IF p_wc2 IS NULL THEN LET p_wc2=" 1=1 " END IF
    LET g_sql =
        "SELECT oqb02,oqb03,oqb031,oqb032,oqb04,oqb05,oqb06,oqb07,oqb08,",
        "       oqb09,oqb10,oqb11,oqb12,oqb13,  ",
        "       oqbud01,oqbud02,oqbud03,oqbud04,oqbud05,",
        "       oqbud06,oqbud07,oqbud08,oqbud09,oqbud10,",
        "       oqbud11,oqbud12,oqbud13,oqbud14,oqbud15",

        " FROM oqb_file ",
        " WHERE oqb01 ='",g_oqa.oqa01,"'",
        "   AND ",p_wc2 CLIPPED,
        " ORDER BY 1"
    PREPARE t310_pb FROM g_sql
    DECLARE oqb_curs  CURSOR FOR t310_pb   #CURSOR

    CALL g_oqb.clear()

    LET g_rec_b = 0
    LET g_cnt = 1
    FOREACH oqb_curs INTO g_oqb[g_cnt].*   #單身 ARRAY 填充
        LET g_rec_b = g_rec_b + 1
        IF SQLCA.sqlcode THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_oqb.deleteElement(g_cnt)

    LET g_rec_b = g_cnt-1
    DISPLAY g_rec_b TO FORMONLY.cn2
    LET g_cnt = 0

END FUNCTION

FUNCTION t310_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
#  CALL t310_list_fill()
   DISPLAY ARRAY g_oqb TO s_oqb.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )

      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
      ON ACTION first
         CALL t310_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION previous
         CALL t310_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION jump
         CALL t310_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION next
         CALL t310_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION last
         CALL t310_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         #CKP
         IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")
         LET g_action_choice = 'locale'
         EXIT DISPLAY
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

      ON ACTION info_list                 #FUN-CB0014
         LET g_action_flag="info_list"    #FUN-CB0014
         EXIT DISPLAY                     #FUN-CB0014

#@    ON ACTION 人工製費估價資料維護
      ON ACTION lbr_ovhd_estimate
         LET g_action_choice="lbr_ovhd_estimate"
         EXIT DISPLAY
#@    ON ACTION 其他費用資料維護
      ON ACTION other_expense
         LET g_action_choice="other_expense"
         EXIT DISPLAY
#@    ON ACTION 材/工/費分攤作業
      ON ACTION mat_lbr_ovhd_apport_
         LET g_action_choice="mat_lbr_ovhd_apport_"
         EXIT DISPLAY
#@    ON ACTION 單身資料重新產生
      ON ACTION generator_detail_again
         LET g_action_choice="generator_detail_again"
         EXIT DISPLAY
#@    ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY
#@    ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
#@    ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY
#@    ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
#FUN-D20025--add--str--
#@    ON ACTION 取消作廢
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
#FUN-D20025--add--end--

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION exporttoexcel       #FUN-4B0038
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document                #No.FUN-6B0079  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      &include "qry_string.4gl"
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION


#FUN-CB0014 -----------------Begin---------------
FUNCTION t310_bp1(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_oqa_1 TO s_oqa_1.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         CALL fgl_set_arr_curr(g_curs_index)

      BEFORE ROW
         LET l_ac1 = ARR_CURR()
         LET g_curs_index = l_ac1
         CALL cl_show_fld_cont()

      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################

      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
      ON ACTION first
         CALL t310_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
         ACCEPT DISPLAY

      ON ACTION previous
         CALL t310_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
	     ACCEPT DISPLAY

      ON ACTION jump
         CALL t310_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
	     ACCEPT DISPLAY

      ON ACTION next
         CALL t310_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
	     ACCEPT DISPLAY

      ON ACTION last
         CALL t310_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
	     ACCEPT DISPLAY

      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
      #TQC-D10084--mark--str--
      #ON ACTION detail
      #   LET g_action_choice="detail"
      #   LET l_ac = 1
      #   EXIT DISPLAY
      #TQC-D10084--mark--end--
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()
         #CKP
         IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")
         LET g_action_choice = 'locale'
         EXIT DISPLAY
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION main
         LET g_action_flag = 'main'
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
             CALL t310_fetch('/')
         END IF
         CALL cl_set_comp_visible("page1", FALSE)
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page1", TRUE)
         CALL cl_set_comp_visible("page2", TRUE)
         EXIT DISPLAY

      ON ACTION accept
         LET g_action_flag = 'main'
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         CALL t310_fetch('/')
         CALL cl_set_comp_visible("page2", FALSE)
         CALL cl_set_comp_visible("page2", TRUE)
         CALL cl_set_comp_visible("page1", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page1", TRUE)
         EXIT DISPLAY

#@    ON ACTION 人工製費估價資料維護
      ON ACTION lbr_ovhd_estimate
         LET g_action_choice="lbr_ovhd_estimate"
         EXIT DISPLAY
#@    ON ACTION 其他費用資料維護
      ON ACTION other_expense
         LET g_action_choice="other_expense"
         EXIT DISPLAY
#@    ON ACTION 材/工/費分攤作業
      ON ACTION mat_lbr_ovhd_apport_
         LET g_action_choice="mat_lbr_ovhd_apport_"
         EXIT DISPLAY
#@    ON ACTION 單身資料重新產生
      ON ACTION generator_detail_again
         LET g_action_choice="generator_detail_again"
         EXIT DISPLAY
#@    ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY
#@    ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
#@    ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY
#@    ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY

#FUN-D20025--add--str--
#@    ON ACTION 取消作廢
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
#FUN-D20025--add--end--

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION about
         CALL cl_about()

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      &include "qry_string.4gl"
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

FUNCTION t310_list_fill()
DEFINE l_cnt          LIKE type_file.num10
DEFINE l_oqa01        LIKE oqa_file.oqa01
   CALL g_oqa_1.clear()

   LET l_cnt = 1
   FOREACH t310_fill_cs INTO l_oqa01
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach item_cur',SQLCA.sqlcode,1)
         CONTINUE FOREACH
      END IF
      SELECT oqa01,oqa02,oqa03,oqa031,oqa032,oqa05,gem02,oqa06,occ02,oqa07,gen02,oqa08,oqa09,oqa10,oqa11,oqa12,oqaconf
        INTO g_oqa_1[l_cnt].*
        FROM oqa_file LEFT OUTER JOIN occ_file ON oqa06 = occ01
                      LEFT OUTER JOIN gem_file ON oqa05 = gem01
                      LEFT OUTER JOIN gen_file ON oqa07 = gen01
       WHERE oqa01 = l_oqa01
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
          END IF
          EXIT FOREACH
       END IF
    END FOREACH
    LET g_rec_b1 = l_cnt - 1

    DISPLAY ARRAY g_oqa_1 TO s_oqa_1.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
       BEFORE DISPLAY
          EXIT DISPLAY
    END DISPLAY

END FUNCTION
#FUN-CB0014 -----------------End-----------------


FUNCTION t310_y()
DEFINE l_cnt      LIKE type_file.num5    #No.FUN-680137 SMALLINT
DEFINE l_gemacti  LIKE gem_file.gemacti  #TQC-C60211
#CHI-C30107 ----------------- add ----------------- begin
   IF g_oqa.oqaconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF
   IF NOT cl_confirm('axm-108') THEN RETURN END IF
#CHI-C30107 ----------------- add ----------------- end
#TQC-C60211 -- add -- begin
   SELECT gemacti INTO l_gemacti FROM gem_file
    WHERE gem01 = g_oqa.oqa05
   IF l_gemacti = 'N' THEN
      CALL cl_err(g_oqa.oqa05,'asf-472',0)
      RETURN
   END IF
#TQC-C60211 -- add -- end

   SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
   IF g_oqa.oqaconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF

#---BUGNO:7379---無單身資料不可確認
   LET l_cnt=0
   SELECT COUNT(*) INTO l_cnt
     FROM oqb_file
    WHERE oqb01=g_oqa.oqa01
   IF l_cnt=0 OR l_cnt IS NULL THEN
      CALL cl_err('','mfg-009',0)
      RETURN
   END IF

#  IF NOT cl_confirm('axm-108') THEN RETURN END IF #CHI-C30107 mark

   BEGIN WORK

   OPEN t310_cl USING g_oqa.oqa01
   IF STATUS THEN
      CALL cl_err("OPEN t310_cl:", STATUS, 1)
      CLOSE t310_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t310_cl INTO g_oqa.*            # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)      # 資料被他人LOCK
      CLOSE t310_cl ROLLBACK WORK RETURN
   END IF
   LET g_success = 'Y'

   UPDATE oqa_file SET oqaconf='Y' WHERE oqa01=g_oqa.oqa01
   IF SQLCA.sqlerrd[3]=0 THEN
      LET g_success='N'
   END IF

   IF g_success = 'Y' THEN
      LET g_oqa.oqaconf='Y'
      COMMIT WORK
      CALL cl_flow_notify(g_oqa.oqa01,'Y')
      DISPLAY BY NAME g_oqa.oqaconf
   ELSE
      ROLLBACK WORK
   END IF
    #CKP
    IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")

END FUNCTION

FUNCTION t310_z() #取消確認
   DEFINE l_n LIKE type_file.num5    #No.FUN-680137 SMALLINT

   SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
   IF g_oqa.oqaconf = 'N' THEN RETURN END IF
   IF g_oqa.oqaconf = 'X' THEN CALL cl_err(g_oqa.oqa01,'9024',0) RETURN END IF

   #mandy 01/08/03 估價單已轉入訂單資料的不能取消確認
   SELECT COUNT(*) INTO l_n FROM oea_file
       WHERE oea12    = g_oqa.oqa01
         AND oea11    = '4' #訂單來源 '4'.估價單轉入
         AND oeaconf  != 'X'

   IF l_n >0 THEN
     #估價單已轉入訂單資料的不能取消確認!
      CALL cl_err(g_oqa.oqa01,'axm-003',0)
      RETURN
   END IF

   IF NOT cl_confirm('axm-109') THEN RETURN END IF

   BEGIN WORK

   OPEN t310_cl USING g_oqa.oqa01
   IF STATUS THEN
      CALL cl_err("OPEN t310_cl:", STATUS, 1)
      CLOSE t310_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t310_cl INTO g_oqa.*            # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)      # 資料被他人LOCK
      CLOSE t310_cl ROLLBACK WORK RETURN
   END IF

   LET g_success = 'Y'
   UPDATE oqa_file SET oqaconf='N' WHERE oqa01=g_oqa.oqa01
   IF SQLCA.sqlerrd[3]=0 THEN
      LET g_success='N'
   END IF

   IF g_success = 'Y' THEN
      LET g_oqa.oqaconf='N'
      COMMIT WORK
      DISPLAY BY NAME g_oqa.oqaconf
   ELSE
      ROLLBACK WORK
   END IF
    #CKP
    IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")

END FUNCTION

FUNCTION t310_oqa08(l_azi01)  #-------幣別
    DEFINE l_aziacti LIKE azi_file.aziacti
    DEFINE l_azi01   LIKE azi_file.azi01

    LET  g_errno = " "
    SELECT azi03,azi04,azi05,aziacti
      INTO t_azi03,t_azi04,t_azi05,l_aziacti     #No.CHI-6A0004
      FROM azi_file
     WHERE azi01 = l_azi01
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3008'
                                   LET l_aziacti = 0
         WHEN l_aziacti='N' LET g_errno = '9028'
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
END FUNCTION

FUNCTION t310_g_b()

   DEFINE l_ima910   LIKE ima_file.ima910   #FUN-550110

    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
    IF g_oqa.oqaacti ='N' THEN    #檢查資料是否為無效
       CALL cl_err(g_oqa.oqa01,9027,0) RETURN
    END IF
    IF g_oqa.oqaconf='Y' THEN CALL cl_err(g_oqa.oqa01,'axm-101',0) RETURN END IF

    IF g_oqa.oqa03[1,4] ='MISC' THEN RETURN END IF

    SELECT azi03,azi04,azi05        #估價幣別
      INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oqa.oqa08

    #--------- 自動產生單身
    IF NOT cl_confirm('aap-701') THEN RETURN END IF
    DELETE FROM oqb_file WHERE oqb01=g_oqa.oqa01
    DELETE FROM oqc_file WHERE oqc01=g_oqa.oqa01
    DROP TABLE t310_temp
    CREATE TEMP TABLE t310_temp(
           oqa01  LIKE oqa_file.oqa01,
           llevel LIKE type_file.num5,
           bma01  LIKE bma_file.bma01,
           bmb06  LIKE bmb_file.bmb06);
    LET g_seq1=0 LET g_seq2=0
    #--------- 生產料號
    INSERT INTO t310_temp
                VALUES(g_oqa.oqa01,0,g_oqa.oqa03,g_oqa.oqa10)
    LET l_ima910=''
    SELECT ima910 INTO l_ima910 FROM ima_file WHERE ima01=g_oqa.oqa03
    IF cl_null(l_ima910) THEN LET l_ima910=' ' END IF
    #CHI-DC0021 add begin-------
    IF g_sma.sma118 ='Y' THEN
       IF NOT cl_null(g_oqa.oqa18) THEN
          LET l_ima910 = g_oqa.oqa18
       END IF
    END IF
    #CHI-DC0021 add end---------
    CALL t310_bom(0,g_oqa.oqa03,l_ima910,g_oqa.oqa10)  #FUN-550110
    IF cl_confirm('axm-698') THEN                     #FUN-D50064 add
       CALL t310_ins_oqc()
    END IF                                            #FUN-D50064 add
    CALL t310_sum()
    CALL t310_show()
END FUNCTION

FUNCTION t310_bom(p_level,p_key,p_key2,p_total)  #FUN-550110
   DEFINE p_level	LIKE type_file.num5,    #No.FUN-680137 SMALLINT
          p_key		LIKE bma_file.bma01,
          p_key2        LIKE ima_file.ima910,   #FUN-550110
          p_total       LIKE oqa_file.oqa10,
          l_fac         LIKE bmb_file.bmb10_fac,
          l_gfe03       LIKE gfe_file.gfe03,
          m_ac,m	LIKE type_file.num5,    #No.FUN-680137 SMALLINT
          arrno		LIKE type_file.num5,    #No.FUN-680137 SMALLINT
          l_chr		LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
          sr DYNAMIC ARRAY OF RECORD           #每階存放資料
              level	LIKE type_file.num5,    #No.FUN-680137 SMALLINT
              bmb02     LIKE bmb_file.bmb02,    #項次
              bmb03     LIKE bmb_file.bmb03,    #元件料號
              bmb10     LIKE bmb_file.bmb10,    #元件料號No.8746
              bmb06     LIKE bmb_file.bmb06,    #QPA/BASE
              #yemy 20130513  --Begin
              bmb08     LIKE bmb_file.bmb08,
              bmb081    LIKE bmb_file.bmb081,
              bmb082    LIKE bmb_file.bmb082,
              #yemy 20130513  --End
              bmb13     LIKE bmb_file.bmb13,    #插件位置
              bma01     LIKE bma_file.bma01,    #No.MOD-490217
              ima02     LIKE ima_file.ima02,
              ima021    LIKE ima_file.ima021,
              ima25     LIKE ima_file.ima25,
              ima55     LIKE ima_file.ima55     #No.8746
          END RECORD,
          l_cmd	    LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(600)
          l_oqb07   LIKE oqb_file.oqb07,
          l_oqb08   LIKE oqb_file.oqb08, #匯率 #FUN-4B0050 DEFINE 匯率時用LIKE的方式
          l_oqb09   LIKE oqb_file.oqb09,
          l_oqb10   LIKE oqb_file.oqb10,
          l_oqb11   LIKE oqb_file.oqb11,
          l_oqb12   LIKE oqb_file.oqb12,
          l_oqb13   LIKE oqb_file.oqb13,
          l_azi03   LIKE azi_file.azi03,
          l_azi04   LIKE azi_file.azi04,
          l_azi05   LIKE azi_file.azi05
    DEFINE l_oqbud08  LIKE oqb_file.oqbud08
    DEFINE l_ima910    DYNAMIC ARRAY OF LIKE ima_file.ima910          #No.FUN-8B0035
    #yemy 20130513  --Begin
    DEFINE l_total       LIKE sfa_file.sfa07
    DEFINE l_ActualQPA   LIKE bmb_file.bmb06
    DEFINE l_QPA         LIKE bmb_file.bmb06
    #yemy 20130513  --End
    DEFINE l_str        STRING  # add by lixwz 20170829
    DEFINE l_azj02      LIKE azj_file.azj02  # add by lixwz 20170829
    DEFINE l_oqbud01    LIKE oqb_file.oqbud01 # add by lixwz 20170929
    DEFINE l_tc_ohi05   LIKE tc_ohi_file.tc_ohi05

    IF p_level > 20 THEN CALL cl_err('','mfg2733',1) RETURN END IF
    LET p_level = p_level + 1
    LET arrno = 600
    #No.MOD-A60134  --Begin
    #LET l_cmd= "SELECT 0,bmb02,bmb03,bmb10,(bmb06/bmb07),bmb13,bma01,",
    #           "       ima02,ima021,ima25,ima55 ",
    #           #"  FROM bmb_file LEFT OUTER JOIN bma_file ON bmb_file.bmb03=bma_file.bma01 LEFT OUTER JOIN ima_file ON bmb_file.bmb01=ima_file.ima01  ",   #MOD-A50052
    #           "  FROM bmb_file LEFT OUTER JOIN bma_file ON bmb_file.bmb03=bma_file.bma01 LEFT OUTER JOIN ima_file ON bmb_file.bmb03=ima_file.ima01  ",   #MOD-A50052
    #           " WHERE bmb01='", p_key,"'",
    #           "   AND bmb29 ='",p_key2,"' ",  #FUN-550110
    #           "   AND bmb29 = bma_file.bma06 "  #MOD-930084
    LET l_cmd= "SELECT 0,bmb02,bmb03,bmb10,(bmb06/bmb07),bmb08,bmb081,bmb082,bmb13,bma01,",   #yemy 20130513
               "       ima02,ima021,ima25,ima55 ",
               "  FROM bmb_file LEFT OUTER JOIN bma_file ON bmb_file.bmb03=bma_file.bma01 ",
               "                                        AND bmb_file.bmb29=bma_file.bma06 ", #MOD-930084
               "                LEFT OUTER JOIN ima_file ON bmb_file.bmb03=ima_file.ima01 ",   #MOD-A50052
               " WHERE bmb01='", p_key,"'",
               "   AND bmb29 ='",p_key2,"' ",  #FUN-550110
               "   AND bmb14 <> '2' "     #MOD-B70186
    #No.MOD-A60134  --End
    #---->生效日及失效日的判斷
    LET l_cmd=l_cmd CLIPPED,
               " AND (bmb04 <='",g_today,"' OR bmb04 IS NULL)",
               " AND (bmb05 > '",g_today,"' OR bmb05 IS NULL)"
    LET l_cmd = l_cmd CLIPPED," ORDER BY bmb02"
    PREPARE t310_precur FROM l_cmd
    IF SQLCA.sqlcode THEN CALL cl_err('P1:',STATUS,1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
    END IF
    DECLARE t310_cur CURSOR FOR t310_precur
    LET m_ac = 1
    FOREACH t310_cur INTO sr[m_ac]. *     	# 先將BOM單身存入BUFFER
        LET g_chr = 'Y'     #TQC-9B0239
        LET l_ima910[m_ac]=''
        LET l_ima910[m_ac]= g_oqa.oqa18 #CHI-DC0021 ADD
        #SELECT ima910 INTO l_ima910[m_ac] FROM ima_file WHERE ima01=sr[m_ac].bmb03 #CHI-DC0021 mark
        IF cl_null(l_ima910[m_ac]) THEN LET l_ima910[m_ac]=' ' END IF
        LET m_ac = m_ac + 1
        IF m_ac > arrno THEN EXIT FOREACH END IF
    END FOREACH
    IF g_chr = 'N' THEN
       CALL cl_err('','axm-503',0)
    END IF
    FOR m = 1 TO m_ac-1    	        	# 讀BUFFER傳給REPORT
        LET sr[m].level = p_level

        #yemy 20130513  --Begin
        #LET sr[m].bmb06=p_total*sr[m].bmb06
        CALL cralc_rate(p_key,sr[m].bmb03,p_total,sr[m].bmb081,sr[m].bmb08,sr[m].bmb082,sr[m].bmb06,1)
             RETURNING l_total,l_QPA,l_ActualQPA
        LET sr[m].bmb06=l_total
        #yemy 20130513  --End

        IF sr[m].bma01 IS NOT NULL THEN         # 若為主件
           #發料單位 -> 生產單位  #No.8746
           CALL s_umfchk(sr[m].bmb03,sr[m].bmb10,sr[m].ima55)
           RETURNING g_i,l_fac
           IF g_i THEN LET l_fac=1 END IF
           LET sr[m].bmb06=sr[m].bmb06*l_fac
           INSERT INTO t310_temp
                  VALUES(g_oqa.oqa01,p_level,sr[m].bmb03,sr[m].bmb06)
           CALL t310_bom(p_level,sr[m].bmb03,l_ima910[m],sr[m].bmb06)  #FUN-8B0035
        ELSE
           LET g_seq1= g_seq1+ 1
           #發料單位 -> 庫存單位  #No.8746
           CALL s_umfchk(sr[m].bmb03,sr[m].bmb10,sr[m].ima25)
           RETURNING g_i,l_fac
           IF g_i THEN LET l_fac=1 END IF
           LET sr[m].bmb06=sr[m].bmb06*l_fac
           #-->考慮單位小數取位
           LET l_gfe03=''
           # mark by lixwz 20170830
           # 保留4位小数
           #SELECT gfe03 INTO l_gfe03 FROM gfe_file WHERE gfe01 =sr[m].ima25
           #IF SQLCA.sqlcode OR cl_null(l_gfe03) THEN LET l_gfe03 = 0 END IF
           # mark by lixwz 20170830
           LET l_gfe03 = 4  # add by lixwz 20170830
           CALL cl_digcut(sr[m].bmb06,l_gfe03) RETURNING sr[m].bmb06
           CALL t310_get_price(sr[m].bmb03,sr[m].ima25)   #MOD-870213
                RETURNING l_oqb07,l_oqb09,l_oqb12,l_oqb13

           SELECT azi03,azi04,azi05       #原幣幣別
             INTO t_azi03,t_azi04,t_azi05        #No.CHI-6A0004
             FROM azi_file
            WHERE azi01 = l_oqb07
           # add by lixwz 20171009 s
           # 美元料件优先取cxmi001 中的单价
           IF l_oqb07 ='USD' THEN
              SELECT tc_ohi05 INTO l_tc_ohi05 FROM tc_ohi_file
                WHERE tc_ohi01 = sr[m].bmb03 AND tc_ohi04 = l_oqb07
              IF NOT cl_null(l_tc_ohi05) THEN LET l_oqb09 = l_tc_ohi05 END IF
           END IF
           # add by lixwz 20171009 e
           #原幣單價
           IF l_oqb09 IS NULL THEN LET l_oqb09=0 END IF
           LET l_oqb09 = cl_digcut(l_oqb09,t_azi03)     #No.CHI-6A0004

           # CALL s_curr3(l_oqb07,l_oqb13,g_oaz.oaz52) RETURNING l_oqb08 mark by lixwz 20171013
           CALL s_curr3(l_oqb07,l_oqb13,g_oqa.oqa02) RETURNING l_oqb08
           # add by lixwz 20170829 s
           # 汇率
           IF cl_null(l_oqb13) THEN
              LET l_oqb13 = TODAY
           END IF
           IF MONTH(l_oqb13) > 9 THEN
              LET l_str = YEAR(l_oqb13),MONTH(l_oqb13)
           ELSE
              LET l_str = YEAR(l_oqb13),'0',MONTH(l_oqb13)
           END IF
           LET l_azj02 = cl_replace_str(l_str," ","")
           # mark  by lixwz 20171010 s
           # 单身的估价汇率取单头的报价汇率
           #IF l_oqb07 = 'USD' THEN
           #   SELECT azj07 INTO l_oqb08 FROM azj_file
           #     WHERE azj02 = l_azj02 AND azj01 = l_oqb07
           #END IF
           # mark  by lixwz 20171010 e
           IF l_oqb07 = 'RMB' THEN
              LET l_oqb08 = 1
           ELSE
           # 单身的估价汇率取单头的报价汇率
              LET l_oqb08 = g_oqa.oqaud02
           END IF
           #　add by lixwz 20170829 e
           LET l_oqb08=l_oqb08/g_oqa.oqa09
           #估價單價
           LET l_oqb10=l_oqb08*l_oqb09
           IF l_oqb10 IS NULL THEN LET l_oqb10=0 END IF
           #LET l_oqb10 = cl_digcut(l_oqb10,t_azi03) # mark by lixwz 20170830

           #估價金額
           LET l_oqb11=l_oqb10*sr[m].bmb06
           IF l_oqb11 IS NULL THEN LET l_oqb11=0 END IF
           #LET l_oqb11 = cl_digcut(l_oqb11,t_azi04) mark by lixwz 201708230
           SELECT ima02,ima021,ima25 INTO sr[m].ima02,sr[m].ima021,sr[m].ima25
             FROM ima_file WHERE ima01=sr[m].bmb03
           # add by lixwz 20170929 s
           # 项目
           CASE sr[m].bmb03[1,1]
              WHEN '1'
                 LET l_oqbud01 = '1'
              WHEN '2'
                 LET l_oqbud01 = '2'
              WHEN '3'
                 LET l_oqbud01 = '3'
              OTHERWISE
                 LET l_oqbud01 = ''
           END CASE
           # add by lixwz 20170929 e

           INSERT INTO oqb_file(oqb01,oqb02,oqb03,oqb031,oqb032,
                                oqb04,oqb05,oqb06,oqb07,oqb08,
                                 oqb09,oqb10,oqb11,oqb12,oqb13,  #No.MOD-470041
                                oqbplant,oqblegal,oqbud01,oqbud07)    #FUN-980010 add plant & legal # mod by lixwz 20170817 add oqaud01,oqaud07
                         VALUES(g_oqa.oqa01,g_seq1,sr[m].bmb03,
                                sr[m].ima02,sr[m].ima021,sr[m].ima25,
                                sr[m].bmb06,'N',l_oqb07,
                                l_oqb08,l_oqb09,l_oqb10,
                                l_oqb11,l_oqb12,l_oqb13,
                                g_plant,g_legal,l_oqbud01,sr[m].bmb06)   #FUN-980010 # mod by lixwz 20170817 add oqaud01,oqaud07
        END IF
    END FOR
END FUNCTION

FUNCTION t310_get_price(p_bmb03,p_bmb10)   #MOD-870213
    DEFINE p_bmb03    LIKE ima_file.ima01,
           p_bmb10    LIKE bmb_file.bmb10,   #MOD-870213
           p_oqb07    LIKE oqb_file.oqb07,
           p_oqb09    LIKE oqb_file.oqb09,
           p_oqb12    LIKE oqb_file.oqb12,
           p_oqb13    LIKE oqb_file.oqb13,
           l_date     LIKE type_file.dat,     #No.FUN-680137 DATE
           l_ccc02    LIKE ccc_file.ccc02,
           l_ccc03    LIKE ccc_file.ccc03
    DEFINE l_p        VARCHAR(04),
           l_flag     SMALLINT,
           l_fac      DECIMAL(16,8)
    # add by lixwz 20170829 s
    #pmj05,pmj07t,pmj01,pmj09
    SELECT * INTO p_oqb07,p_oqb09,p_oqb12,p_oqb13 FROM
        ( SELECT pmj05,pmj07t,pmj01,pmj09 FROM pmj_file WHERE pmj03=p_bmb03 ORDER BY pmj09 DESC ,pmj07t DESC )
         WHERE rownum=1
    #IF cl_null(l_oqbud08) THEN
    #    LET l_oqbud08 = 0
    #END IF
    IF SQLCA.sqlcode THEN
    # add by lixwz 20170829 e
        #--------- 1.抓最近採購單價  2.抓 ccc_file 單價  3.依市價
        DECLARE t310_price1 CURSOR FOR
           SELECT pmm01,pmm04,pmm22,pmn31,pmn86 FROM pmm_file,pmn_file   #MOD-870213
            WHERE pmm01=pmn01 AND pmm18 <> 'X'
              AND pmm04>=g_oqa.oqa11
              AND pmn04=p_bmb03
           ORDER BY pmm04 DESC, pmm01 DESC
        OPEN t310_price1
        FETCH t310_price1 INTO p_oqb12,p_oqb13,p_oqb07,p_oqb09,l_p   #MOD-870213
        IF SQLCA.sqlcode THEN
           SELECT ima25 INTO l_p FROM ima_file    #MOD-870213
             WHERE ima01 = p_bmb03   #MOD-870213
           SELECT ccz28 INTO g_ccz.ccz28 FROM ccz_file WHERE ccz00='0'
           DECLARE t310_price2 CURSOR FOR
    #         SELECT ccc23,ccc02,ccc03 FROM ccc_file        #CHI-B60093 mark
              SELECT AVG(ccc23),ccc02,ccc03 FROM ccc_file   #CHI-B60093
               WHERE ccc01=p_bmb03
    #            AND ccc07='1'               #No.FUN-840041 #CHI-B60093 mark
                 AND ccc07=g_ccz.ccz28                      #CHI-B60093
              GROUP BY ccc01,ccc02,ccc03                    #CHI-B60093 add
              ORDER BY ccc02 DESC, ccc03 DESC
           OPEN t310_price2
           FETCH t310_price2 INTO p_oqb09,l_ccc02,l_ccc03
           IF SQLCA.sqlcode THEN
              IF g_sma.sma116 = '0' OR g_sma.sma116 = '2' THEN
                 SELECT ima44 INTO l_p FROM ima_file
                   WHERE ima01 = p_bmb03
              ELSE
                 SELECT ima908 INTO l_p FROM ima_file
                   WHERE ima01 = p_bmb03
              END IF
              SELECT ima531,ima532 INTO p_oqb09,p_oqb13 FROM ima_file
               WHERE ima01=p_bmb03
              IF STATUS THEN
                 LET p_oqb07=' '
                 LET p_oqb09=0
                 LET p_oqb12=' '
                 LET p_oqb13=' '
              ELSE
                 LET p_oqb07=g_aza.aza17
                 LET p_oqb12='IMA-999999'
              END IF
           ELSE
              LET p_oqb07=g_aza.aza17
              LET p_oqb12='CCC-999999'
              CALL s_azn01(l_ccc02,l_ccc03) RETURNING l_date,p_oqb13
           END IF
        END IF
        CALL s_umfchk(p_bmb03,p_bmb10,l_p)
          RETURNING l_flag,l_fac
        IF l_flag THEN LET l_fac=1 END IF
        LET p_oqb09 = p_oqb09 * l_fac
    END IF

    IF p_oqb13 IS NULL THEN LET p_oqb13=g_today END IF   #FUN-5A0158
    RETURN p_oqb07,p_oqb09,p_oqb12,p_oqb13
END FUNCTION

FUNCTION t310_ins_oqc()
    DEFINE l_bma01    LIKE bma_file.bma01,
           l_bmb06    LIKE bmb_file.bmb06,  #FUN-560230
           l_level    LIKE type_file.num5,    #No.FUN-680137 SMALLINT
           l_ima571   LIKE ima_file.ima571,
           l_ima94    LIKE ima_file.ima94,
           l_oqf02    LIKE oqf_file.oqf02,
           l_oqf03    LIKE oqf_file.oqf03
    DEFINE l_ecb06    LIKE ecb_file.ecb06,
           l_ecb08    LIKE ecb_file.ecb08,
           l_ecb18    LIKE ecb_file.ecb18,
           l_ecb19    LIKE ecb_file.ecb19,
           l_ecb20    LIKE ecb_file.ecb20,
           l_ecb21    LIKE ecb_file.ecb21,
           l_ecb03    LIKE ecb_file.ecb03,
           l_ecd02    LIKE ecd_file.ecd02
    DEFINE l_oqc07    LIKE oqc_file.oqc07,
           l_oqc08    LIKE oqc_file.oqc08,
           l_oqc11    LIKE oqc_file.oqc11,
           l_oqc12    LIKE oqc_file.oqc12,
           l_oqc13    LIKE oqc_file.oqc13,
           l_oqc14    LIKE oqc_file.oqc14,
           l_azi04    LIKE azi_file.azi04

    SELECT azi03,azi04,azi05#估價幣別
      INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oqa.oqa08


    DECLARE oqc_cur CURSOR FOR
       SELECT bma01,bmb06,llevel FROM t310_temp
        WHERE oqa01=g_oqa.oqa01 ORDER BY llevel DESC

    FOREACH oqc_cur INTO l_bma01,l_bmb06,l_level
       SELECT ima571,ima94 INTO l_ima571,l_ima94
         FROM ima_file WHERE ima01=l_bma01
       IF STATUS THEN CONTINUE FOREACH END IF

       DECLARE ecb_cur CURSOR FOR
          SELECT ecb06,ecb08,ecb18,ecb19,ecb20,ecb21,ecb03 FROM ecb_file
           WHERE ecb01=l_ima571 AND ecb02=l_ima94
           ORDER BY ecb03
       FOREACH ecb_cur INTO l_ecb06,l_ecb08,l_ecb18,l_ecb19,l_ecb20,l_ecb21,l_ecb03

          LET g_seq2=g_seq2+g_oaz.oaz25

          SELECT ecd02 INTO l_ecd02 FROM ecd_file WHERE ecd01=l_ecb06
          IF STATUS THEN LET l_ecd02='' END IF

          SELECT oqf02,oqf03 INTO l_oqf02,l_oqf03
            FROM oqf_file WHERE oqf01=l_ecb08
          IF STATUS THEN LET l_oqf02=0 LET l_oqf03=0 END IF
          IF l_oqf02 IS NULL THEN LET l_oqf02=0 END IF
          IF l_oqf03 IS NULL THEN LET l_oqf03=0 END IF

          LET l_oqc07= l_ecb18/3600+(l_bmb06*l_ecb19/3600)
          LET l_oqc08= l_ecb20/3600+(l_bmb06*l_ecb21/3600)

          LET l_oqc11= l_oqf02*(l_ecb18/3600+(l_bmb06*l_ecb19/3600))
          LET l_oqc11 = cl_digcut(l_oqc11,g_azi04)      #No.CHI-6A0004

          LET l_oqc12= l_oqf03*(l_ecb20/3600+(l_bmb06*l_ecb21/3600))
          #No.MOD-B70141  --Begin
         #LET l_oqc12 = cl_digcut(l_oqc11,g_azi04)      #No.CHI-6A0004
          LET l_oqc12 = cl_digcut(l_oqc12,g_azi04)
          #No.MOD-B70141  --End

          LET l_oqc13= l_oqc11/g_oqa.oqa09
          LET l_oqc13 = cl_digcut(l_oqc13,t_azi04)

          LET l_oqc14= l_oqc12/g_oqa.oqa09
         #LET l_oqc14 = cl_numfor(l_oqc14,7,t_azi04)
          LET l_oqc14 = cl_digcut(l_oqc14,t_azi04)

          INSERT INTO oqc_file(oqc01,oqc02,oqc03,oqc031,oqc04,
                               oqc05,oqc06,oqc07,oqc08,oqc09,
                                oqc10,oqc11,oqc12,oqc13,oqc14,oqc15, #No.MOD-470041
                               oqcplant,oqclegal)  #FUN-980010 add plant & legal
                        VALUES(g_oqa.oqa01,g_seq2,l_ecb06,l_ecd02,l_bma01,
                               l_bmb06,l_ecb08,l_oqc07,l_oqc08,l_oqf02,
                               l_oqf03,l_oqc11,l_oqc12,l_oqc13,l_oqc14, '',
                               g_plant,g_legal)  #FUN-980010
       END FOREACH
    END FOREACH
END FUNCTION

FUNCTION t310_copy()
    DEFINE l_newno         LIKE oqa_file.oqa01,
	   p_stat          LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(01)
	   l_oldno         LIKE oqa_file.oqa01,
           li_result       LIKE type_file.num5                 #No.FUN-550070  #No.FUN-680137 SMALLINT

    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-420,0) RETURN END IF

    BEGIN WORK   #No:7829
     LET g_before_input_done = FALSE #MOD-480130
     CALL t310_set_entry('a')        #MOD-480130
     LET g_before_input_done = TRUE  #MOD-480130
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    INPUT l_newno WITHOUT DEFAULTS FROM oqa01
          BEFORE INPUT
                CALL cl_set_docno_format("oqa01")     #No.FUN-550070

          AFTER FIELD oqa01
                IF l_newno IS NULL THEN
                   NEXT FIELD oqa01
                END IF
#               CALL s_check_no(g_sys,l_newno,"","80","oqa_file","oqa01","")
                CALL s_check_no("axm",l_newno,"","80","oqa_file","oqa01","")   #No.FUN-A40041
                   RETURNING li_result,l_newno
                DISPLAY l_newno to g_oqa.oqa01
                IF (NOT li_result) THEN
         	    NEXT FIELD oqa01
                END IF

                BEGIN WORK
#               CALL s_auto_assign_no(g_sys,l_newno,g_oqa.oqa02,"80","oqa_file","oqa01","","","")
                CALL s_auto_assign_no("axm",l_newno,g_oqa.oqa02,"80","oqa_file","oqa01","","","")   #No.FUN-A40041
                  RETURNING li_result,l_newno
                IF (NOT li_result) THEN
                    NEXT FIELD oqa01
                END IF
                DISPLAY l_newno to oqa01

        ON ACTION controlp
           CASE
              WHEN INFIELD(oqa01) #單號
                   LET g_t1=s_get_doc_no(g_oqa.oqa01)    #No.FUN-550070
                   CALL q_oay(FALSE,TRUE,g_t1,'80','AXM') RETURNING g_t1   #TQC-670008
                   LET l_newno=g_t1                      #No.FUN-550070
                   DISPLAY l_newno TO oqa01
                   NEXT FIELD oqa01
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


    END INPUT

    IF INT_FLAG THEN
       LET INT_FLAG = 0
       ROLLBACK WORK         #No.FUN-550070
       DISPLAY BY NAME g_oqa.oqa01
       RETURN
    END IF

    DROP TABLE y
    SELECT * FROM oqa_file         #單頭複製
        WHERE oqa01=g_oqa.oqa01 INTO TEMP y
    UPDATE y
	SET oqa01=l_newno,    #新的鍵值
            oqa02=g_today,    #單據日期
            oqaconf='N',
            oqauser=g_user,   #資料所有者
            oqagrup=g_grup,   #資料所有者所屬群
            oqamodu=NULL,     #資料修改日期
            oqadate=g_today,  #資料建立日期
            oqaacti='Y'       #有效資料
    INSERT INTO oqa_file
        SELECT * FROM y

    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","oqa_file",l_newno,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       ROLLBACK WORK
       RETURN
    END IF
    COMMIT WORK

    DROP TABLE x
    SELECT * FROM oqb_file WHERE oqb01=g_oqa.oqa01 INTO TEMP x
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","x",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF
    UPDATE x
	SET oqb01=l_newno
    INSERT INTO oqb_file
	SELECT * FROM x
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","oqb_file",l_newno,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF

    DROP TABLE z
    SELECT * FROM oqc_file WHERE oqc01=g_oqa.oqa01 INTO TEMP z
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","z",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF
    UPDATE z
	SET oqc01=l_newno
    INSERT INTO oqc_file
	SELECT * FROM z
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","oqc_file",l_newno,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF

    DROP TABLE w
    SELECT * FROM oqd_file WHERE oqd01=g_oqa.oqa01 INTO TEMP w
    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","oqd_file",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF
    UPDATE w
	SET oqd01=l_newno
    INSERT INTO oqd_file
	SELECT * FROM w
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","oqd_file",l_newno,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF

    DROP TABLE u
    SELECT * FROM oqe_file WHERE oqe01=g_oqa.oqa01 INTO TEMP u
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","u",g_oqa.oqa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF
    UPDATE u
	SET oqe01=l_newno
    INSERT INTO oqe_file
	SELECT * FROM u
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","oqe_file",l_newno,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
       RETURN
    END IF

    LET g_cnt=SQLCA.SQLERRD[3]
    MESSAGE '(',g_cnt USING '##&',') ROW of (',l_newno,') OK'

    LET l_oldno = g_oqa.oqa01
    SELECT oqa_file.* INTO g_oqa.* FROM oqa_file
       WHERE oqa01 = l_newno
    CALL t310_u()
    #SELECT oqa_file.* INTO g_oqa.* FROM oqa_file  #FUN-C80046
    #   WHERE oqa01 = l_oldno                      #FUN-C80046
    CALL t310_show()
    DISPLAY BY NAME g_oqa.oqa01
END FUNCTION

FUNCTION t310_1()
    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01

    SELECT azi03,azi04,azi05        #估價幣別
      INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oqa.oqa08

    LET g_chr='u'
    IF g_oqa.oqaacti ='N' OR g_oqa.oqaconf='Y' THEN LET g_chr='d' END IF
    CALL saxmt3101(g_oqa.oqa01,g_chr,g_oqa.oqa09)
    CALL t310_sum()
END FUNCTION

FUNCTION t310_2()
    IF s_shut(0) THEN RETURN END IF
    IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
    LET g_chr='u'
    IF g_oqa.oqaacti ='N' OR g_oqa.oqaconf='Y' THEN LET g_chr='d' END IF
    CALL saxmt3102(g_oqa.oqa01,g_chr)
    CALL t310_sum()
END FUNCTION

FUNCTION t310_sum()
# add by lixwz 20170817 s
DEFINE l_cnt  LIKE type_file.num5
DEFINE l_oqb_s   LIKE oqa_file.oqaud10
DEFINE l_oqa             RECORD
                      p_oqaud10  LIKE type_file.chr10,
                      p_oqaud11  LIKE type_file.chr10,
                      p_oqaud12  LIKE type_file.chr10,
                      p_oqaud13  LIKE type_file.chr10,
                      p_oqaud14  LIKE type_file.chr10,
                      p_oqaud15  LIKE type_file.chr10,
                      p_ta_oqa01  LIKE type_file.chr10
                             END RECORD
# add by lixwz 20170817 s

    SELECT azi03,azi04,azi05          #估價幣別
      INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oqa.oqa08

    SELECT SUM(oqb11) INTO g_oqa.oqa13 FROM oqb_file
     WHERE oqb01=g_oqa.oqa01
       AND oqb06!='Y'   #FUN-5A0158
    IF g_oqa.oqa13 IS NULL THEN LET g_oqa.oqa13=0 END IF

    SELECT SUM(oqc13),SUM(oqc14) INTO g_oqa.oqa14,g_oqa.oqa15
      FROM oqc_file WHERE oqc01=g_oqa.oqa01
    IF g_oqa.oqa14 IS NULL THEN LET g_oqa.oqa14=0 END IF
    IF g_oqa.oqa15 IS NULL THEN LET g_oqa.oqa15=0 END IF

    SELECT SUM(oqd04) INTO g_oqa.oqa16 FROM oqd_file WHERE oqd01=g_oqa.oqa01
    IF g_oqa.oqa16 IS NULL THEN LET g_oqa.oqa16=0 END IF

    LET g_oqa.oqa13 = cl_digcut(g_oqa.oqa13,t_azi05)
    LET g_oqa.oqa14 = cl_digcut(g_oqa.oqa14,t_azi05)
    LET g_oqa.oqa15 = cl_digcut(g_oqa.oqa15,t_azi05)
    LET g_oqa.oqa16 = cl_digcut(g_oqa.oqa16,t_azi05)

    LET g_oqa.oqa17=g_oqa.oqa13+g_oqa.oqa14+g_oqa.oqa15+g_oqa.oqa16

    LET g_oqa.oqa17 = cl_digcut(g_oqa.oqa17,t_azi05)

    UPDATE oqa_file SET oqa13=g_oqa.oqa13,
                        oqa14=g_oqa.oqa14,
                        oqa15=g_oqa.oqa15,
                        oqa16=g_oqa.oqa16,
                        oqa17=g_oqa.oqa17
       WHERE oqa01=g_oqa.oqa01

    DISPLAY BY NAME g_oqa.oqa17,g_oqa.oqa13,g_oqa.oqa14,
                    g_oqa.oqa15,g_oqa.oqa16

    # add by lixwz 20170817 s
    # 计算oqaud10~pqaud15的值
    IF cl_null(g_oqb[1].oqb02) THEN
        CALL t310_b_fill(" 1=1")
    END IF
    LET g_oqa.oqaud10 = 0
    LET g_oqa.oqaud11 = 0
    LET g_oqa.oqaud12 = 0
    LET g_oqa.oqaud13 = 0
    LET g_oqa.oqaud14 = 0
    LET g_oqa.oqaud15 = 0
    LET g_oqa.ta_oqa01 = 0
    FOR l_cnt=1 TO g_oqb.getlength()
        IF NOT cl_null(g_oqb[l_cnt].oqbud01) THEN
            CASE g_oqb[l_cnt].oqbud01
                WHEN  "1"
                    LET g_oqa.oqaud10 = g_oqa.oqaud10 + g_oqb[l_cnt].oqb11 # 主料
                WHEN  "2"
                    LET g_oqa.oqaud11 = g_oqa.oqaud11 + g_oqb[l_cnt].oqb11 # 辅料
                WHEN  "3"
                    LET g_oqa.oqaud12 = g_oqa.oqaud12 + g_oqb[l_cnt].oqb11 # 包装
                WHEN  "4"
                    LET g_oqa.oqaud13 = g_oqa.oqaud13 + g_oqb[l_cnt].oqb11 # 加工
                WHEN  "5"
                    LET g_oqa.oqaud14 = g_oqa.oqaud14 + g_oqb[l_cnt].oqb11 # 运费/消毒
                WHEN  "7"
                    LET g_oqa.ta_oqa01 = g_oqa.ta_oqa01 + g_oqb[l_cnt].oqb11 # 配件
                OTHERWISE
                    LET g_oqa.oqaud15 = g_oqa.oqaud15 + g_oqb[l_cnt].oqb11 # 估价金额
            END CASE
        ELSE
            CONTINUE FOR
        END IF
    END FOR
    IF NOT cl_null(g_oqa.oqaud02) AND g_oqa.oqaud02 != 0 THEN
        LET g_oqa.oqaud10 = g_oqa.oqaud10/g_oqa.oqaud02
        LET g_oqa.oqaud11 = g_oqa.oqaud11/g_oqa.oqaud02
        LET g_oqa.oqaud12 = g_oqa.oqaud12/g_oqa.oqaud02
        LET g_oqa.oqaud13 = g_oqa.oqaud13/g_oqa.oqaud02
        LET g_oqa.oqaud14 = g_oqa.oqaud14/g_oqa.oqaud02
        LET g_oqa.oqaud15 = g_oqa.oqaud15/g_oqa.oqaud02
        LET g_oqa.ta_oqa01 = g_oqa.ta_oqa01/g_oqa.oqaud02
    END IF
    LET l_oqb_s = g_oqa.oqaud10 + g_oqa.oqaud11 + g_oqa.oqaud12 + g_oqa.oqaud13 + g_oqa.oqaud14 + g_oqa.oqaud15 + g_oqa.ta_oqa01
    LET l_oqa.p_oqaud10 = cl_replace_str(g_oqa.oqaud10/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud11 = cl_replace_str(g_oqa.oqaud11/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud12 = cl_replace_str(g_oqa.oqaud12/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud13 = cl_replace_str(g_oqa.oqaud13/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud14 = cl_replace_str(g_oqa.oqaud14/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_oqaud15 = cl_replace_str(g_oqa.oqaud15/l_oqb_s *100," ","") , "%"
    LET l_oqa.p_ta_oqa01 = cl_replace_str(g_oqa.ta_oqa01/l_oqb_s *100," ","") , "%"

    CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
    UPDATE oqa_file SET oqaud04=g_oqa.oqaud04,
                    oqaud05=g_oqa.oqaud05,
                    oqaud06=g_oqa.oqaud06,
                    oqaud07=g_oqa.oqaud07,
                    oqaud08=g_oqa.oqaud08,
                    oqaud09=g_oqa.oqaud09,
                    oqaud10=g_oqa.oqaud10,
                    oqaud11=g_oqa.oqaud11,
                    oqaud12=g_oqa.oqaud12,
                    oqaud13=g_oqa.oqaud13,
                    oqaud14=g_oqa.oqaud14,
                    oqaud15=g_oqa.oqaud15,
                    ta_oqa01=g_oqa.ta_oqa01
    WHERE oqa01=g_oqa.oqa01
    DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09,g_oqa.oqaud10,g_oqa.oqaud11,g_oqa.oqaud12,
                    g_oqa.oqaud13,g_oqa.oqaud14,g_oqa.oqaud15,g_oqa.ta_oqa01,l_oqa.*

    # add by lixwz 20170817 e
END FUNCTION

#01/08/03 mandy 新增作廢/作廢還原功能
#FUNCTION t310_x()       #FUN-D20025
FUNCTION t310_x(p_type)  #FUN-D20025
   DEFINE p_type    LIKE type_file.num5     #FUN-D20025
   DEFINE l_flag    LIKE type_file.chr1     #FUN-D20025
   DEFINE l_n LIKE type_file.num5    #No.FUN-680137 SMALLINT

   IF s_shut(0) THEN RETURN END IF
   SELECT * INTO g_oqa.* FROM oqa_file WHERE oqa01=g_oqa.oqa01
   IF g_oqa.oqa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_oqa.oqaconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF

   #mandy 01/08/03 估價單已轉入訂單資料的不能作廢
   SELECT COUNT(*) INTO l_n FROM oea_file
    WHERE oea12    = g_oqa.oqa01
      AND oea11    = '4' #訂單來源 '4'.估價單轉入
      AND oeaconf != 'X'

   IF l_n > 0 THEN
      #估價單已轉入訂單資料的不能作廢!
      CALL cl_err(g_oqa.oqa01,'axm-004',0)
      RETURN
   END IF
   #FUN-D20025--add--str--
   IF p_type = 1 THEN
      IF g_oqa.oqaconf='X' THEN RETURN END IF
   ELSE
      IF g_oqa.oqaconf<>'X' THEN RETURN END IF
   END IF
   #FUN-D20025--add--end--

   BEGIN WORK

   OPEN t310_cl USING g_oqa.oqa01
   IF STATUS THEN
      CALL cl_err("OPEN t310_cl:", STATUS, 1)
      CLOSE t310_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t310_cl INTO g_oqa.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oqa.oqa01,SQLCA.sqlcode,0)
      CLOSE t310_cl
      ROLLBACK WORK
      RETURN
   END IF

#  IF cl_void(0,0,g_oqa.oqaconf) THEN  #FUN-D20025
   IF p_type = 1 THEN LET l_flag = 'N' ELSE LET l_flag = 'X' END IF  #FUN-D20025
   IF cl_void(0,0,l_flag) THEN         #FUN-D20025
      LET g_chr = g_oqa.oqaconf
#     IF g_oqa.oqaconf = 'N' THEN  #FUN-D20025
      IF p_type = 1 THEN           #FUN-D20025
         LET g_oqa.oqaconf = 'X'
      ELSE
         LET g_oqa.oqaconf = 'N'
      END IF

      UPDATE oqa_file SET oqaconf=g_oqa.oqaconf,
                          oqamodu=g_user,
                          oqadate=g_today
       WHERE oqa01 = g_oqa.oqa01
       IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          CALL cl_err3("upd","oqa_file",g_oqa.oqa01,"",SQLCA.sqlcode,"","up oqaconf",1)  #No.FUN-660167
          LET g_oqa.oqaconf = g_chr
          ROLLBACK WORK
       END IF
       DISPLAY BY NAME g_oqa.oqaconf
   END IF

   CLOSE t310_cl
   COMMIT WORK

    #CKP
    IF g_oqa.oqaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    CALL cl_set_field_pic(g_oqa.oqaconf,"","","",g_chr,"")

   CALL cl_flow_notify(g_oqa.oqa01,'V')

END FUNCTION

FUNCTION t310_b_move_to() #FUN-730018
   LET g_oqb[l_ac].oqb02  = b_oqb.oqb02
   LET g_oqb[l_ac].oqb03  = b_oqb.oqb03
   LET g_oqb[l_ac].oqb031 = b_oqb.oqb031
   LET g_oqb[l_ac].oqb032 = b_oqb.oqb032
   LET g_oqb[l_ac].oqb04  = b_oqb.oqb04
   LET g_oqb[l_ac].oqb05  = b_oqb.oqb05
   LET g_oqb[l_ac].oqb06  = b_oqb.oqb06
   LET g_oqb[l_ac].oqb07  = b_oqb.oqb07
   LET g_oqb[l_ac].oqb08  = b_oqb.oqb08
   LET g_oqb[l_ac].oqb09  = b_oqb.oqb09
   LET g_oqb[l_ac].oqb10  = b_oqb.oqb10
   LET g_oqb[l_ac].oqb11  = b_oqb.oqb11
   LET g_oqb[l_ac].oqb12  = b_oqb.oqb12
   LET g_oqb[l_ac].oqbud01 = b_oqb.oqbud01
   LET g_oqb[l_ac].oqbud02 = b_oqb.oqbud02
   LET g_oqb[l_ac].oqbud03 = b_oqb.oqbud03
   LET g_oqb[l_ac].oqbud04 = b_oqb.oqbud04
   LET g_oqb[l_ac].oqbud05 = b_oqb.oqbud05
   LET g_oqb[l_ac].oqbud06 = b_oqb.oqbud06
   LET g_oqb[l_ac].oqbud07 = b_oqb.oqbud07
   LET g_oqb[l_ac].oqbud08 = b_oqb.oqbud08
   LET g_oqb[l_ac].oqbud09 = b_oqb.oqbud09
   LET g_oqb[l_ac].oqbud10 = b_oqb.oqbud10
   LET g_oqb[l_ac].oqbud11 = b_oqb.oqbud11
   LET g_oqb[l_ac].oqbud12 = b_oqb.oqbud12
   LET g_oqb[l_ac].oqbud13 = b_oqb.oqbud13
   LET g_oqb[l_ac].oqbud14 = b_oqb.oqbud14
   LET g_oqb[l_ac].oqbud15 = b_oqb.oqbud15

END FUNCTION

FUNCTION t310_b_move_back()  #FUN-730018
   LET b_oqb.oqb01  = g_oqa.oqa01
   LET b_oqb.oqb02  = g_oqb[l_ac].oqb02
   LET b_oqb.oqb03  = g_oqb[l_ac].oqb03
   LET b_oqb.oqb031 = g_oqb[l_ac].oqb031
   LET b_oqb.oqb032 = g_oqb[l_ac].oqb032
   LET b_oqb.oqb04  = g_oqb[l_ac].oqb04
   LET b_oqb.oqb05  = g_oqb[l_ac].oqb05
   LET b_oqb.oqb06  = g_oqb[l_ac].oqb06
   LET b_oqb.oqb07  = g_oqb[l_ac].oqb07
   LET b_oqb.oqb08  = g_oqb[l_ac].oqb08
   LET b_oqb.oqb09  = g_oqb[l_ac].oqb09
   LET b_oqb.oqb10  = g_oqb[l_ac].oqb10
   LET b_oqb.oqb11  = g_oqb[l_ac].oqb11
   LET b_oqb.oqb12  = g_oqb[l_ac].oqb12
   LET b_oqb.oqbud01 = g_oqb[l_ac].oqbud01
   LET b_oqb.oqbud02 = g_oqb[l_ac].oqbud02
   LET b_oqb.oqbud03 = g_oqb[l_ac].oqbud03
   LET b_oqb.oqbud04 = g_oqb[l_ac].oqbud04
   LET b_oqb.oqbud05 = g_oqb[l_ac].oqbud05
   LET b_oqb.oqbud06 = g_oqb[l_ac].oqbud06
   LET b_oqb.oqbud07 = g_oqb[l_ac].oqbud07
   LET b_oqb.oqbud08 = g_oqb[l_ac].oqbud08
   LET b_oqb.oqbud09 = g_oqb[l_ac].oqbud09
   LET b_oqb.oqbud10 = g_oqb[l_ac].oqbud10
   LET b_oqb.oqbud11 = g_oqb[l_ac].oqbud11
   LET b_oqb.oqbud12 = g_oqb[l_ac].oqbud12
   LET b_oqb.oqbud13 = g_oqb[l_ac].oqbud13
   LET b_oqb.oqbud14 = g_oqb[l_ac].oqbud14
   LET b_oqb.oqbud15 = g_oqb[l_ac].oqbud15

END FUNCTION
#No:FUN-9C0071--------精簡程式-----
#FUN-910088--add--start--
FUNCTION t310_oqb05_check(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1
   # mark by lixwz 20170819 s
   # 所有单位都可以输入小数
   #IF NOT cl_null(g_oqb[l_ac].oqb04) AND NOT cl_null(g_oqb[l_ac].oqb05) THEN
   #   IF cl_null(g_oqb04_t) OR cl_null(g_oqb_t.oqb05) OR g_oqb04_t != g_oqb[l_ac].oqb04 OR g_oqb_t.oqb05 != g_oqb[l_ac].oqb05 THEN
   #      LET g_oqb[l_ac].oqb05 = s_digqty(g_oqb[l_ac].oqb05,g_oqb[l_ac].oqb04)
   #      DISPLAY BY NAME g_oqb[l_ac].oqb05
   #   END IF
   #END IF
   # mark by lixwz 20170829 e
   #IF NOT cl_null(g_oqb[l_ac].oqb05) THEN
    IF NOT cl_null(g_oqb[l_ac].oqbud07) THEN
      IF g_oqb[l_ac].oqbud07<0 THEN
         CALL cl_err(g_oqb[l_ac].oqbud07,'mfg9243',0)
         RETURN FALSE
      END IF

      IF p_cmd = 'u' THEN
         #估價單價
         LET g_oqb[l_ac].oqb10 = g_oqb[l_ac].oqb08*g_oqb[l_ac].oqb09
         IF g_oqb[l_ac].oqb10 IS NULL THEN LET g_oqb[l_ac].oqb10=0 END IF
          LET g_oqb[l_ac].oqb10 = cl_digcut(g_oqb[l_ac].oqb10,t_azi03)

         #MOD-D50087 mark 移到IF外面
         ##估價金額
         #LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqb05
         #IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF

         #LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
         #MOD-D50087 mark--end
      END IF
      #MOD-D50087 add 从上面面移来
      #估價金額
      IF NOT cl_null(g_oqb[l_ac].oqb10) THEN
         LET g_oqb[l_ac].oqb11=g_oqb[l_ac].oqb10 * g_oqb[l_ac].oqbud07
         IF g_oqb[l_ac].oqb11 IS NULL THEN LET g_oqb[l_ac].oqb11=0 END IF
         LET g_oqb[l_ac].oqb11 = cl_digcut(g_oqb[l_ac].oqb11,t_azi04)
      END IF
      #MOD-D50087 add--end
   END IF
   RETURN TRUE
END FUNCTION
#FUN-910088--add--end--

#MOD-D50079 add
FUNCTION t310_get_oqa09(p_oqa08,p_date)
DEFINE p_oqa08    LIKE oqa_file.oqa08
DEFINE p_date     LIKE type_file.dat
DEFINE l_oqa09    LIKE oqa_file.oqa09

   IF g_aza.aza17 = p_oqa08 THEN   #本幣
      LET l_oqa09 = 1
   ELSE
      CALL s_curr3(p_oqa08,p_date,g_oaz.oaz52) RETURNING l_oqa09
   END IF
   RETURN l_oqa09
END FUNCTION
#MOD-D50079 add--end
# add by lixwz 20170816 s
FUNCTION t310_get_oqaud1(l_oqa,l_oqb,l_chk)
DEFINE
    l_oqa           RECORD LIKE oqa_file.*,
    l_oqb           DYNAMIC ARRAY OF RECORD
        oqb02       LIKE oqb_file.oqb02,
        oqb03       LIKE oqb_file.oqb03,
        oqb031      LIKE oqb_file.oqb031,
        oqb032      LIKE oqb_file.oqb032,
        oqb04       LIKE oqb_file.oqb04,
        oqb05       LIKE oqb_file.oqb05,
        oqb06       LIKE oqb_file.oqb06,
        oqb07       LIKE oqb_file.oqb07,
        oqb08       LIKE oqb_file.oqb08,
        oqb09       LIKE oqb_file.oqb09,
        oqb10       LIKE oqb_file.oqb10,
        oqb11       LIKE oqb_file.oqb11,
        oqb12       LIKE oqb_file.oqb12,
        oqb13       LIKE oqb_file.oqb13,
        oqbud01     LIKE oqb_file.oqbud01,
        oqbud02     LIKE oqb_file.oqbud02,
        oqbud03     LIKE oqb_file.oqbud03,
        oqbud04     LIKE oqb_file.oqbud04,
        oqbud05     LIKE oqb_file.oqbud05,
        oqbud06     LIKE oqb_file.oqbud06,
        oqbud07     LIKE oqb_file.oqbud07,
        oqbud08     LIKE oqb_file.oqbud08,
        oqbud09     LIKE oqb_file.oqbud09,
        oqbud10     LIKE oqb_file.oqbud10,
        oqbud11     LIKE oqb_file.oqbud11,
        oqbud12     LIKE oqb_file.oqbud12,
        oqbud13     LIKE oqb_file.oqbud13,
        oqbud14     LIKE oqb_file.oqbud14,
        oqbud15     LIKE oqb_file.oqbud15
                    END RECORD
DEFINE l_i            LIKE type_file.num5
DEFINE l_sum      LIKE oqa_file.oqaud15
DEFINE l_chk       LIKE type_file.chr1

  LET l_sum = l_oqa.oqaud10+l_oqa.oqaud11+l_oqa.oqaud12+l_oqa.oqaud13+l_oqa.oqaud14+l_oqa.oqaud15 + l_oqa.ta_oqa01
  LET l_oqa.oqaud07 = 0
  FOR l_i =1 TO l_oqb.getlength()
              IF l_oqb[l_i].oqb07='RMB' THEN
                  IF l_oqb[l_i].oqbud01 ='1' OR l_oqb[l_i].oqbud01 ='2' OR l_oqb[l_i].oqbud01 ='3' THEN
                      LET l_oqa.oqaud07 = l_oqa.oqaud07+ l_oqb[l_i].oqb11
                  END IF
              END IF
  END FOR
  IF NOT cl_null(l_oqa.oqaud02) AND l_oqa.oqaud02 != 0 THEN
     LET  l_oqa.oqaud07 =  l_oqa.oqaud07 / l_oqa.oqaud02 * 0.15 * l_oqa.oqaud01# mode by lixwz 170920
     IF   l_oqa.oqa042  > 0 THEN LET l_oqa.oqaud07 = l_oqa.oqaud07 * l_oqa.oqa042 END IF # add by lixwz 170929
  END IF
  IF l_chk='0' THEN
      #LET l_oqa.oqaud07 =  (l_oqa.oqaud10+l_oqa.oqaud11+l_oqa.oqaud12)*0.15
      LET l_oqa.oqaud08 = (l_sum)*l_oqa.oqaud04/100 # mod by lixwz 170929
      LET l_oqa.oqaud09 = l_oqa.oqaud08+ l_sum
      LET l_oqa.oqaud05 =  l_oqa.oqaud01*l_oqa.oqaud08
      LET l_oqa.oqaud06 =  l_oqa.oqaud01*l_oqa.oqaud09
      IF l_oqa.oqa042 > 0 THEN
          LET l_oqa.oqaud06 = l_oqa.oqaud06 * l_oqa.oqa042
      END IF
  ELSE
      IF l_sum != 0 THEN
          LET l_oqa.oqaud04 = (l_oqa.oqaud09 - l_sum)/l_sum*100 # mod by lixwz 170929
      END IF
      LET l_oqa.oqaud08 = (l_sum)*l_oqa.oqaud04/100 # mod by lixwz 170929
      LET l_oqa.oqaud05 =  l_oqa.oqaud01*l_oqa.oqaud08
      LET l_oqa.oqaud06 =  l_oqa.oqaud01*l_oqa.oqaud09
      IF l_oqa.oqa042 > 0 THEN
          LET l_oqa.oqaud06 = l_oqa.oqaud06 * l_oqa.oqa042
      END IF
  END IF
  {LET l_oqa.oqaud04 = 0
  LET l_oqa.oqaud05 = 0
  LET l_oqa.oqaud06 = 0
  LET l_oqa.oqaud07 = 0
  LET l_oqa.oqaud08 = 0
  LET l_oqa.oqaud09 = 0}

  RETURN l_oqa.oqaud04,l_oqa.oqaud05,l_oqa.oqaud06,l_oqa.oqaud07,l_oqa.oqaud08,l_oqa.oqaud09
END FUNCTION
# add by llixwz 20170816 e

FUNCTION t310_i_c(p_cmd)
DEFINE
    l_flag          LIKE type_file.chr1,                 #判斷必要欄位是否有輸入  #No.FUN-680137 VARCHAR(1)
    l_misc          LIKE type_file.chr4,    #No.FUN-680137 VARCHAR(04)
    p_cmd           LIKE type_file.chr1,                 #a:輸入 u:更改  #No.FUN-680137 VARCHAR(1)
    li_result       LIKE type_file.num5                 #No.FUN-550070  #No.FUN-680137 SMALLINT
DEFINE
    l_gem02         LIKE gem_file.gem02,
    l_occ02         LIKE occ_file.occ02,
    l_gen02         LIKE gen_file.gen02,
    l_gen03         LIKE gen_file.gen03  #NO.MOD-590057
DEFINE l_cnt        LIKE type_file.num5           #No.FUN-890011
DEFINE l_chk        LIKE type_file.chr1 # add by lixwz 20170822

    DISPLAY BY NAME g_oqa.oqa03,g_oqa.oqa031
    CALL cl_set_head_visible("","YES")

    INPUT g_oqa.oqa03,g_oqa.oqa031,g_oqa.oqa032,g_oqa.oqaud04 WITHOUT DEFAULTS
    FROM  oqa03,oqa031,oqa032,oqaud04

    BEFORE INPUT
        LET g_before_input_done = FALSE
        CALL t310_set_entry(p_cmd)
        CALL t310_set_no_entry(p_cmd)
        LET g_before_input_done = TRUE
        CALL cl_set_docno_format("oqa01")
    BEFORE FIELD oqa03
        CALL t310_set_entry(p_cmd)
    #AFTER FIELD oqa03

    AFTER FIELD oqaud04
    IF (  cl_null(g_oqa.oqaud04)) THEN
        #CALL cl_err(g_oqa.oqa02,'mfg5034',0)
        LET g_oqa.oqaud04 = 0
       # NEXT FIELD  oqaud04
    END IF
    IF NOT cl_null(g_oqa.oqaud01)  THEN
        IF   NOT cl_null(g_oqa.oqaud04)  THEN
            CALL  t310_get_oqaud1(g_oqa.*,g_oqb,'0') RETURNING g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
            DISPLAY BY NAME g_oqa.oqaud04,g_oqa.oqaud05,g_oqa.oqaud06,g_oqa.oqaud07,g_oqa.oqaud08,g_oqa.oqaud09
        END IF
    ELSE
        LET g_oqa.oqaud04 = 0
    END IF

    AFTER INPUT
        UPDATE oqa_file SET oqa_file.* = g_oqa.*
          WHERE oqa01 = g_oqa.oqa01
        IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
           CALL cl_err3("upd","oqa_file",g_oqa01_t,"",SQLCA.sqlcode,"","",1)
           NEXT FIELD oqa03
        ELSE
           CALL t310_g_b()
           IF NOT INT_FLAG THEN
              EXIT INPUT
           END IF
        END IF

    ON ACTION controlp
        CASE
            WHEN INFIELD(oqa03)
               CALL q_sel_ima(FALSE, "q_ima","",g_oqa.oqa03,"","","","","",'' )
               RETURNING  g_oqa.oqa03
               DISPLAY BY NAME g_oqa.oqa03
               NEXT FIELD oqa03
        END CASE

    ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913


    ON ACTION CONTROLR
        CALL cl_show_req_fields()

    ON ACTION CONTROLG
        CALL cl_cmdask()
    ON IDLE g_idle_seconds
       CALL cl_on_idle()
       CONTINUE INPUT

    ON ACTION about         #MOD-4C0121
       CALL cl_about()      #MOD-4C0121

    ON ACTION help          #MOD-4C0121
       CALL cl_show_help()  #MOD-4C012

    END INPUT
END FUNCTION