# Prog. Version..: '5.30.06-13.04.19(00010)'     #
#
# Pattern name...: anmp400.4gl
# Descriptions...: NM系統傳票拋轉總帳
# Date & Author..: 97/05/09 By Danny
# Modify.........: No.9028 04/01/07 By Kitty 將利息暫估合併進來
# Modify.........: No.FUN-4B0052 04/11/23 By Nicola 加入"匯率計算"功能
# Modify.........: No.FUN-4C0010 04/12/06 By Nicola 單價、金額欄位改為DEC(20,6)
# Modify.........: No.MOD-510050 05/01/10 By Kitty gl_no_b/gl_no_e的欄位變數未清除, 導致連續執行時, 傳票列印錯誤
# Modify.........: No.FUN-560011 05/06/06 By pengu CREATE TEMP TABLE 欄位放大
# Modify.........: No.FUN-560196 05/06/22 By Nicola (A19)ins aba:指定的表格'表格-名稱'不在資料庫中
# Modify.........: No.FUN-560190 05/06/28 By wujie  單據編號加大
# Modify.........: No.MOD-560179 05/07/07 By Nicola SQL語法錯誤
# Modify ........: No.FUN-570090 05/07/29 By will 增加取得傳票缺號號碼的功能 
# Modify ........: No.FUN-590111 05/10/03 By Nicola 增加拋轉類別19,20
# Modify.........: No.MOD-5C0083 05/12/15 By Smapmin 總帳傳票單別要可以輸入完整的單號
# Modify.........: No.FUN-5C0015 060102 BY GILL 多 INSERT 異動碼5~10, 關係人
# Modify.........: No.FUN-570127 06/03/08 BY yiting 批次作業背景執行
# Modify.........: No.MOD-640016 06/04/07 By Smapmin 當類別為18時,不做單別是否拋轉傳票的判斷
# Modify.........: No.MOD-640363 06/04/10 By Echo 新增至 aglt110 時須帶申請人預設值,並減何該單別是否需要簽核
# Modify.........: No.MOD-650037 06/05/12 By Smapmin 修正單號抓取方式
# Modify.........: No.FUN-660148 06/06/21 By Hellen cl_err --> cl_err3
# Modify.........: No.FUN-670006 06/07/10 By Jackho 帳別權限修改
# Modify.........: No.FUN-670039 06/07/12 By Carrier 帳別擴充為5碼
# Modify.........: No.FUN-670060 06/08/04 By wujie 只能拋轉當前庫的BUG 
# Modify.........: No.FUN-680034 06/08/17 By ice 兩套帳功能修改 
# Modify.........: No.FUN-670068 06/08/28 By Rayven 傳票缺號修改 
# Modify.........: No.FUN-680107 06/09/07 By Hellen 欄位類型修改
# Modify.........: No.FUN-690117 06/10/16 By cheunl cl_used位置調整及EXIT PROGRAM后加cl_used
# Modify.........: No.FUN-6A0082 06/11/06 By dxfwo l_time轉g_time
# Modify.........: No.MOD-6B0017 06/11/03 By Smapmin 依據單據編號長度清空變數內容
# Modify.........: No.MOD-690062 06/12/01 By Smapmin 秀出傳票編號的視窗若選擇放棄,作業成功後選擇繼續作業仍會跳開整個作業
# Modify.........: No.MOD-710053 07/01/09 By rainy l1_order l2_order 應與l_order 一樣 LIKE npp01
# Modify.........: No.FUN-710024 07/01/15 By Jackho 增加修改單身批處理錯誤統整功能
# Modify.........: No.FUN-740049 07/04/12 By hongmei 會計科目加帳套
# Modify.........: No.MOD-760129 07/06/28 By Smapmin 拋轉傳票程式應依異動碼做group的動作再放到傳票單身
# Modify.........: No.MOD-780008 07/08/03 By Smapmin 更改會計日期應區分是提出或存入
# Modify.........: No.MOD-770101 07/08/07 By Smapmin 需簽核單別不可自動確認
# Modify.........: No.MOD-790147 07/09/28 By Smapmin SELECT 'xxx' 改為30位 
# Modify.........: No.MOD-7B0104 07/11/12 By Smapmin 連續拋轉時,拋轉後自動確認的功能異常
# Modify.........: No.TQC-7B0091 07/11/15 By xufeng  憑証自動審核時,審核人欄位沒有值
# Modify.........: No.FUN-810069 08/02/27 By yaofs 項目預算取消abb15的管控    
# Modify.........: No.CHI-810018 08/03/07 By Smapmin 若存在票據立帳資料,一併update 立帳資料的傳票編號
# Modify.........: No.CHI-810019 08/04/16 By Smapmin 若存在票據立帳資料,一併update 立帳資料的傳票編號
# Modify.........: No.MOD-840238 08/04/20 By jamie q_m_aac->q_m_aac1
# Modify.........: No.MOD-840270 08/04/21 By Smapmin 若沒有任何單據拋轉傳票,應出現執行不成功
# Modify.........: No.CHI-850015 08/06/11 By Sarah 確認時自動拋轉傳票顯示傳票起迄視窗
# Modify.........: No.FUN-840125 08/06/18 By sherry q_m_aac.4gl傳入參數時，傳入帳轉性質aac03= "0.轉帳轉票"
# Modify.........: No.MOD-860157 08/06/26 By Sarah 將DISPLAY "Insert G/L voucher no:"這行mark掉
# Modify.........: No.FUN-840211 08/07/23 By sherry 拋轉的同時要產生總號(aba11)
# Modify.........: No.CHI-880014 08/08/21 By Sarah 調整傳票日期允許空白功能
# Modify.........: No.MOD-8A0135 08/10/16 By Sarah 若要拋轉傳票的單據來源是anmt302且其單頭nmg29='Y'(單據確認時會ins oma_file),應將產生的傳票號碼回寫至oma33
# Modify.........: No.CHI-850035 09/01/17 By jamie 將更新nme02段取消
# Modify.........: No.MOD-930194 09/04/07 By liuxqa 若是背景執行，則應在執行前先判斷賬款日期是否小于關帳日期，若是則退出。
# Modify.........: No.TQC-950127 09/06/09 By baofei aba20塞值時，類型不匹配
# Modify.........: No.MOD-970189 09/07/21 By mike 修改anmp400.4gl,REPORT anmp400_rep()段,先判斷gl_date為Null時才給值                
# Modify.........: No.FUN-980005 09/08/19 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.MOD-860217 09/08/28 By Carrier aba07后面多余的space去掉
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-980094 09/09/14 By TSD.hoho GP5.2 跨資料庫語法修改
# Modify.........: No.FUN-980059 09/09/17 By arman  GP5.2架構,修改SUB相關傳入參數
# Modify.........: No.FUN-990069 09/09/25 By baofei GP集團架構修改,sub相關參數
# Modify.........: No.FUN-990031 09/10/13 By lutingtingGP5.2財務營運中心欄位調整,營運中心要控制在同一法人下
# Modify.........: No.TQC-9B0039 09/11/10 By Carrier SQL STANDARDIZE
# Modify.........: No.TQC-9B0198 09/11/24 By Carrier p42的sql有问题
# Modify.........: No.TQC-9B0215 09/11/25 By wujie   单据日期空白时选不出资料 
# Modify.........: No:FUN-9C0009 09/12/02 by dxfwo  GP5.2 變更檔案權限時應使用 os.Path.chrwx 指令
# Modify.........: No:MOD-9C0143 09/12/16 By Sarah 若單別不為3碼,透過anmp400拋轉時,傳票日期空白,會檢核不出傳票日期<關帳日
# Modify.........: No.TQC-A10060 10/01/11 By wuxj   修改INSERT INTO加入oriu及orig這2個欄位
# Modify.........: No:FUN-A10006 10/01/13 By wujie  增加插入npp08的值，对应aba21
# Modify.........: No.FUN-9C0073 10/01/18 By chenls 程序精簡
# Modify.........: No:FUN-A10089 10/01/19 By wujie  增加显示选取的缺号结果
# Modify.........: No:CHI-A40016 10/04/13 By Summer 當npp00 = '18' AND nmz52 = 'Y'時,insert aba06 = 'AC'
# Modify.........: No.FUN-A50102 10/07/09 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: NO.MOD-A80017 10/08/03 BY xiaofeizhu 附件張數匯總
# Modify.........: NO.TQC-A80138 10/08/24 BY xiaofeizhu aba35賦值N
# Modify.........: No:MOD-AA0163 10/10/27 By Dido 18類別不可與其他類別合併 
# Modify.........: NO.CHI-AC0010 10/12/16 By sabrina 調整temptable名稱，改成agl_tmp_file
# Modify.........: No:MOD-B30037 11/03/07 By Dido 計數 l_cnt18 應判斷 nnmconf = 'Y' 時才需計數 
# Modify.........: No.FUN-B30211 11/04/01 By yangtingting   未加離開前得cl_used(2)
# Modify.........: No:MOD-B40057 11/04/08 By Sarah nme12原本串npo03改成串npn01
# Modify.........: No:MOD-B50085 11/05/11 By Dido nme12原本串npm03改成串npl01 
# Modify.........: No:TQC-B70021 11/07/19 By wujie 抛转tic_file
# Modify.........: No:MOD-B70277 11/08/01 By Polly 修正拋轉傳票時，單號長度抓取方式
# Modify.........: No:TQC-BA0149 11/10/25 By yinhy 拋轉總帳時附件匯總張數錯誤
# Modify.........: No:MOD-C20025 12/02/06 By Polly 依地區別來決定是否要ORDER BY nnp01與npq01
# Modify.........: No:MOD-BB0085 12/03/16 By jt_chen 當nmz52='Y'且npp00='18'時檢查輸入的是否為應計傳票單別
# Modify.........: No.TQC-C50137 12/06/11 By Elise 延續MOD-C50032 nne02 改用 nne03
# Modify.........: No:CHI-CB0004 12/11/12 By Belle 修改總號計算方式
# Modify.........: No.MOD-CC0140 12/12/17 By yinhy 默認g_j初始值為0
# Modify.........: No.CHI-C80041 12/12/24 By bart 排除作廢
# Modify.........: No.FUN-CB0096 13/01/10 by zhangweib 增加log檔記錄程序運行過程
# Modify.........: No.MOD-CC0059 12/12/22 By Polly 調整轉票總號寫入條件
# Modify.........: No:MOD-CB0120 13/02/04 By jt_chen 調整累加值變數預設，已正確的補到缺號。
# Modify.........: No:MOD-D90071 13/09/13 By yinhy 修正anmt100拋磚憑證提示無符合條件資料問題
# Modify.........: NO:FUN-DA0047 13/11/26 By wangrr 當應收npp00='1'且npp011='10'時抓取anmt100資料

IMPORT os   #No.FUN-9C0009 
DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE g_aba            RECORD LIKE aba_file.*
DEFINE g_aac            RECORD LIKE aac_file.*
DEFINE g_wc,g_sql       string  #No.FUN-580092 HCN
DEFINE g_dbs_gl 	LIKE type_file.chr21    #No.FUN-680107 VARCHAR(21)
DEFINE g_plant_gl 	LIKE type_file.chr21    #No.FUN-980059 VARCHAR(21)
DEFINE gl_no		LIKE aba_file.aba01     # 傳票單號 #No.FUN-680107 VARCHAR(16)
DEFINE gl_no2           LIKE aba_file.aba01     # 傳票單號二 #No.FUN-680034 #No.FUN-680107 VARCHAR(16)
DEFINE gl_no_b,gl_no_e	LIKE aba_file.aba01	# Generated 傳票單號    #No.FUN-680107 VARCHAR(16)
DEFINE gl_no2_b         LIKE aba_file.aba01	# Generated 傳票單號二  #No.FUN-680034 #No.FUN-680107 VARCHAR(16)
DEFINE gl_no2_e         LIKE aba_file.aba01     # Generated 傳票單號二  #No.FUN-680034 #No.FUN-680107 VARCHAR(16)
DEFINE p_plant          LIKE tmn_file.tmn01     #No.FUN-680107 VARCHAR(12)	
DEFINE p_plant_old      LIKE tmn_file.tmn01     #No.FUN-570090 --add #No.FUN-680107 VARCHAR(12)
DEFINE p_bookno         LIKE aaa_file.aaa01     #No.FUN-670039
DEFINE p_bookno2        LIKE aaa_file.aaa01     #No.FUN-670039 #No.FUN-680034
DEFINE gl_date		LIKE type_file.dat      #No.FUN-680107 DATE
DEFINE gl_date_t        LIKE type_file.dat      #MOD-970189    
DEFINE g_t1		LIKE type_file.chr5     #No.FUN-680107 VARCHAR(5) #NO:6842
                                                #No.FUN-560190
DEFINE gl_tran		LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1)
DEFINE gl_seq    	LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1) # 傳票區分項目
DEFINE b_user,e_user	LIKE npl_file.npluser   #No.FUN-680107 VARCHAR(10)
DEFINE g_yy,g_mm	LIKE type_file.num5     #No.FUN-680107 SMALLINT
DEFINE g_statu          LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1)
DEFINE g_aba01t         LIKE aac_file.aac01     #No.FUN-680107 VARCHAR(5) #No.FUN-560190
DEFINE p_row,p_col      LIKE type_file.num5     #No.FUN-680107 smallint
#------for ora修改-------------------
DEFINE g_system         LIKE aba_file.aba06     #FUN-670060 
DEFINE g_zero           LIKE aba_file.aba08     #No.FUN-680107 decimal(15,3)
DEFINE g_zero1          LIKE aba_file.abasseq   #No.FUN-680107 VARCHAR(01)
DEFINE g_N              LIKE aba_file.aba12     #No.FUN-680107 VARCHAR(1)
DEFINE g_y              LIKE aba_file.abaacti   #No.FUN-680107 VARCHAR(1)
DEFINE g_flag           LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1)
#------for ora修改-------------------
DEFINE g_aaz85          LIKE aaz_file.aaz85     #傳票是否自動確認 no.3432
DEFINE g_cnt            LIKE type_file.num10    #No.FUN-680107 INTEGER   
DEFINE g_i              LIKE type_file.num5     #No.FUN-680107 SMALLINT #count/index for any purpose
DEFINE g_j              LIKE type_file.num5     #No.FUN-680107 SMALLINT #No.FUN-570090  --add   
DEFINE g_change_lang    LIKE type_file.chr1     #No.FUN-680107 VARCHAR(01) #是否有做語言切換 No.FUN-570127
 
DEFINE g_npp00          LIKE npp_file.npp00     #CHI-A40016
#No.FUN-CB0096 ---start--- Add
DEFINE g_id     LIKE azu_file.azu00
DEFINE l_id     STRING
DEFINE l_time   LIKE type_file.chr8
DEFINE t_no     LIKE aba_file.aba01
#No.FUN-CB0096 ---end  --- Add

MAIN
    DEFINE l_flag       LIKE type_file.chr1     #No.FUN-680107 VARCHAR(01) #->No.FUN-570127
    DEFINE ls_date      STRING                  #->No.FUN-570127
    DEFINE l_tmn02      LIKE tmn_file.tmn02     #No.FUN-670068                                                                       
    DEFINE l_tmn06      LIKE tmn_file.tmn06     #No.FUN-670068 
 
    OPTIONS
        INPUT NO WRAP
    DEFER INTERRUPT
 
   INITIALIZE g_bgjob_msgfile TO NULL
 
   LET g_wc     = ARG_VAL(1)             #QBE條件
   LET b_user   = ARG_VAL(2)             #資料來源營運中心
   LET e_user   = ARG_VAL(3)             #資料來源
   LET p_plant  = ARG_VAL(4)             #總帳營運中心編號
   LET p_bookno = ARG_VAL(5)             #總帳帳別編號
   LET gl_no    = ARG_VAL(6)             #總帳傳票單別
   LET p_bookno2= ARG_VAL(7)             #總帳帳別編號二
   LET gl_no2   = ARG_VAL(8)             #總帳傳票單別二
   LET ls_date  = ARG_VAL(9)
   LET gl_date  = cl_batch_bg_date_convert(ls_date)   #總帳傳票日期
   LET gl_tran  = ARG_VAL(10)             #拋轉摘要
   LET gl_seq   = ARG_VAL(11)             #傳票匯總方式
   LET g_bgjob  = ARG_VAL(12)             #背景作業
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
 
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
 
 
   DROP TABLE agl_tmp_file    
 
   CREATE TEMP TABLE agl_tmp_file(
    tc_tmp00 LIKE type_file.chr1 NOT NULL,
    tc_tmp01 LIKE type_file.num5,  
    tc_tmp02 LIKE type_file.chr20, 
    tc_tmp03 LIKE oay_file.oayslip)
   IF STATUS THEN CALL cl_err('create tmp',STATUS,0) 
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      EXIT PROGRAM 
   END IF  
   CREATE UNIQUE INDEX tc_tmp_01 on agl_tmp_file (tc_tmp02,tc_tmp03) #No.FUN-680034 
   IF STATUS THEN CALL cl_err('create index',STATUS,0) 
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      EXIT PROGRAM 
   END IF 
    DECLARE tmn_del CURSOR FOR                                                                                                      
       SELECT tc_tmp02,tc_tmp03 FROM agl_tmp_file WHERE tc_tmp00 = 'Y'                                                               
   LET g_j = 0   #MOD-CB0120 add
   WHILE TRUE
      IF g_bgjob = "N" THEN
         CALL p400_ask()               # Ask for first_flag, data range or exist
         IF cl_sure(18,20) THEN
            CALL p400_create_tmp()
            LET g_nmz.nmz02b = p_bookno  # 得帳別  
            LET g_nmz.nmz02c = p_bookno2 # 得帳別二 
            LET g_j = 0     #MOD-CC0140
            LET g_success = 'Y'
            BEGIN WORK
            CALL s_showmsg_init()   #No.FUN-710024
            CALL p400_t('0')         #拋轉第一套帳
            IF g_aza.aza63 = 'Y' AND g_success='Y' THEN
               CALL p400_t('1')      #拋轉第二套帳
            END IF
            CALL s_showmsg()          #No.FUN-710024
            IF g_success = 'Y' THEN
               COMMIT WORK
               CALL s_m_prtgl(g_plant_gl,g_nmz.nmz02b,gl_no_b,gl_no_e)   #FUN-990069
               IF g_aza.aza63 = 'Y' THEN     #第二套帳是否打印
                  CALL s_m_prtgl(g_plant_gl,g_nmz.nmz02c,gl_no2_b,gl_no2_e) #FUN-990069
               END IF
               LET INT_FLAG = 0    #MOD-690062
               CALL cl_end2(1) RETURNING l_flag
            ELSE
               ROLLBACK WORK
               CALL cl_end2(2) RETURNING l_flag
            END IF
            IF l_flag THEN
               CONTINUE WHILE
            ELSE
               CLOSE WINDOW p400
               EXIT WHILE
            END IF
         ELSE
            CONTINUE WHILE
         END IF
      ELSE
         CALL p400_create_tmp()
         LET g_apz.apz02b = p_bookno  # 得帳別
         LET g_apz.apz02c = p_bookno2 # 得帳別 #No.FUN-680034
         LET g_success = 'Y'
         BEGIN WORK
         CALL s_showmsg_init()   #No.FUN-710024
         CALL p400_t('0')         #拋轉第一套帳
         IF g_aza.aza63 = 'Y' AND g_success='Y' THEN
            CALL p400_t('1')      #拋轉第二套帳
         END IF
         CALL s_showmsg()          #No.FUN-710024
         IF g_success = "Y" THEN
            COMMIT WORK
            CALL s_m_prtgl(g_plant_gl,g_nmz.nmz02b,gl_no_b,gl_no_e)  #FUN-990069
            IF g_aza.aza63 = 'Y' THEN     #第二套帳是否打印
               CALL s_m_prtgl(g_plant_gl,g_nmz.nmz02c,gl_no2_b,gl_no2_e)#FUN-990069
            END IF
         ELSE
            ROLLBACK WORK
         END IF
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
 
    FOREACH tmn_del INTO l_tmn02,l_tmn06                                                                                            
       DELETE FROM tmn_file                                                                                                         
       WHERE tmn01 = p_plant                                                                                                        
         AND tmn02 = l_tmn02                                                                                                        
         AND tmn06 = l_tmn06                                                                                                        
    END FOREACH 
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
    CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
END MAIN
 
 
FUNCTION p400_ask()
   DEFINE l_aaa07        LIKE aaa_file.aaa07
   DEFINE l_flag         LIKE type_file.chr1     #No.FUN-680107 VARCHAR(01)
   DEFINE li_result      LIKE type_file.num5     #No.FUN-680107 SMALLINT  #No.FUN-560190
   DEFINE l_cnt          LIKE type_file.num5     #No.FUN-680107 SMALLINT  #No.FUN-570090  -add   
   DEFINE lc_cmd         LIKE type_file.chr1000  #No.FUN-680107 VARCHAR(500) #NO.FUN-570127 
   DEFINE li_chk_bookno  LIKE type_file.num5     #No.FUN-680107 SMALLINT  #No.FUN-670006
   DEFINE l_sql          STRING                  #No.FUN-670006  -add
   DEFINE l_tmn02        LIKE tmn_file.tmn02     #No.FUN-670068                                                                       
   DEFINE l_tmn06        LIKE tmn_file.tmn06     #No.FUN-670068 
   DEFINE l_no           LIKE type_file.chr3     #No.FUN-840125                
   DEFINE l_no1          LIKE type_file.chr3     #No.FUN-840125                
   DEFINE l_aac03        LIKE aac_file.aac03     #No.FUN-840125  
   DEFINE l_aac03_1      LIKE aac_file.aac03     #No.FUN-840125  
#No.FUN-A10089 --begin
   DEFINE   l_chr1         LIKE type_file.chr20
   DEFINE   l_chr2         STRING
#No.FUN-A10089 --end
   OPEN WINDOW p400 AT p_row,p_col WITH FORM "anm/42f/anmp400" 
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
    
   CALL cl_ui_init()
   CALL cl_set_comp_visible("p_bookno2,gl_no2",g_aza.aza63='Y')
 
  WHILE TRUE
 
#No.FUN-A10089 --begin
   LET l_chr2 =' '  
   DISPLAY ' ' TO chr2   
#No.FUN-A10089 --end 
   CONSTRUCT BY NAME g_wc ON npp00,npp01,npp011,npp02 
         BEFORE CONSTRUCT
             CALL cl_qbe_init()
 
         #CHI-A40016 add --start--
         AFTER CONSTRUCT
           CALL GET_FLDBUF(npp00) RETURNING g_npp00
         #CHI-A40016 add --end--

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
      ON ACTION locale                    #genero
          LET g_change_lang = TRUE   #NO.FUN-570126
         EXIT CONSTRUCT
   
      ON ACTION exit              #加離開功能genero
         LET INT_FLAG = 1
         EXIT CONSTRUCT
 
         ON ACTION qbe_select
            CALL cl_qbe_select()
 
   END CONSTRUCT
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond(null, null) #FUN-980030
 
 
   IF g_change_lang THEN
      LET g_change_lang = FALSE
      CALL cl_dynamic_locale()
      CONTINUE WHILE
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p400
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
      EXIT PROGRAM
   END IF
 
   LET p_plant = g_nmz.nmz02p  # 工廠編號
   LET p_plant_old = p_plant      #No.FUN-570090  --add    
   LET p_bookno   = g_nmz.nmz02b  # 帳別
   LET p_bookno2  = g_nmz.nmz02c  # 帳別 #No.FUN-680034
   LET b_user  = '0'
   LET e_user  = 'Z'
   LET gl_date = g_today
   LET gl_seq  = '0'
   LET gl_tran = 'Y'
   LET g_bgjob = "N"    #NO.FUN-570127 
   INPUT BY NAME b_user,e_user,p_plant,p_bookno,gl_no,p_bookno2,     #No.FUN-680034
                 gl_no2,gl_date,gl_tran,gl_seq,g_bgjob #NO.FUN-571027  #No.FUN-680034
      WITHOUT DEFAULTS  ATTRIBUTE(UNBUFFERED)  #No.FUN-570090  --add UNBUFFERED
 
      AFTER FIELD p_plant
         IF NOT cl_null(p_plant) THEN  
            #營運中心要控制在當前法人下
            SELECT * FROM azw_file WHERE azw01 = p_plant AND azw02 = g_legal                                                        
            IF STATUS THEN                                                                                                          
               CALL cl_err3("sel","azw_file",p_plant,"","agl-171","","",1)                                                          
               NEXT FIELD p_plant                                                                                                   
            END IF                                                                                                                  
 
            # 得出總帳 database name 
            LET g_plant_new= p_plant    # 工廠編號
            CALL s_getdbs()
            LET g_dbs_gl=g_dbs_new      # 得資料庫名稱
            IF p_plant_old != p_plant THEN           
            FOREACH tmn_del INTO l_tmn02,l_tmn06                                                                                    
               DELETE FROM tmn_file                                                                                                 
               WHERE tmn01 = p_plant_old                                                                                            
                 AND tmn02 = l_tmn02                                                                                                
                 AND tmn06 = l_tmn06                                                                                                
            END FOREACH  
               DELETE FROM agl_tmp_file            
               LET p_plant_old = g_plant_new     
            END IF                              
         END IF 
 
      AFTER FIELD p_bookno
         IF NOT cl_null(p_bookno) THEN
             CALL s_check_bookno(p_bookno,g_user,p_plant) 
                  RETURNING li_chk_bookno
             IF (NOT li_chk_bookno) THEN
                NEXT FIELD p_bookno
             END IF 
             LET g_plant_new= p_plant  #工廠編號
                 CALL s_getdbs()
                 LET l_sql = "SELECT  COUNT(*)",
                             #"  FROM ",g_dbs_new CLIPPED,"aaa_file ",
                             "  FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102
                             " WHERE aaa01 = '",p_bookno,"' ",
                             "   AND aaaacti IN ('Y','y') "
 	             CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
                 PREPARE p400_pre2 FROM l_sql
                 DECLARE p400_cur2 CURSOR FOR p400_pre2
                 OPEN p400_cur2
                 FETCH p400_cur2 INTO g_cnt 
            IF g_cnt=0 THEN
               CALL cl_err('sel aaa',100,0)
               NEXT FIELD p_bookno
            END IF
            IF NOT cl_null(p_bookno2) THEN
               IF p_bookno = p_bookno2 THEN
                  CALL cl_err(p_bookno,'axr-090',0)
                  NEXT FIELD p_bookno
               END IF
            END IF
         END IF
 
      AFTER FIELD p_bookno2
         IF NOT cl_null(p_bookno2) THEN
             CALL s_check_bookno(p_bookno2,g_user,p_plant) 
                  RETURNING li_chk_bookno
             IF (NOT li_chk_bookno) THEN
                NEXT FIELD p_bookno2
             END IF 
             LET g_plant_new= p_plant  #工廠編號
                 CALL s_getdbs()
                 LET l_sql = "SELECT  COUNT(*)",
                             #"  FROM ",g_dbs_new CLIPPED,"aaa_file ",
                             "  FROM ",cl_get_target_table(g_plant_new,'aaa_file'), #FUN-A50102
                             " WHERE aaa01 = '",p_bookno2,"' ",
                             "   AND aaaacti IN ('Y','y') "
 	             CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
                 PREPARE p400_pre22 FROM l_sql
                 DECLARE p400_cur22 CURSOR FOR p400_pre22
                 OPEN p400_cur22
                 FETCH p400_cur22 INTO g_cnt 
            IF g_cnt=0 THEN
               CALL cl_err('sel aaa',100,0)
               NEXT FIELD p_bookno2
            END IF
            IF NOT cl_null(p_bookno) THEN
               IF p_bookno = p_bookno2 THEN
                  CALL cl_err(p_bookno2,'axr-090',0)
                  NEXT FIELD p_bookno2
               END IF
            END IF
         END IF
 
      AFTER FIELD e_user
         IF e_user = 'Z' THEN
            LET e_user='z' 
            DISPLAY BY NAME e_user 
         END IF
 
       #141009wudj  --Begin
      BEFORE FIELD gl_no
         IF cl_null(gl_no) THEN
            CALL s_get_slip('agl','aac_file','aac01','aac11','aacacti','1','')
                 RETURNING gl_no
            DISPLAY BY NAME gl_no
         END IF
      #141009wudj  --End
 
      AFTER FIELD gl_no
         IF NOT cl_null(gl_no) THEN
           #--------- MOD-BB0085 add start------
            IF g_nmz.nmz52 = 'Y' AND g_npp00 = '18' THEN
               CALL s_check_no("agl",gl_no,"","3","aac_file","aac01",p_plant)
               RETURNING li_result,gl_no
            ELSE
           #--------- MOD-BB0085 add end---------
               CALL s_check_no("agl",gl_no,"","1","aac_file","aac01",p_plant)     #MOD-5C0083  #FUN-980094
               RETURNING li_result,gl_no
            END IF   #No.MOD-BB0085 add
            IF (NOT li_result) THEN                                                                                                 
               NEXT FIELD gl_no             
            END IF                           #--NO:6842
        LET l_no = gl_no                                                        
        SELECT aac03 INTO l_aac03 FROM aac_file WHERE aac01= l_no               
        IF l_aac03 != '0' THEN                                                  
           CALL cl_err(gl_no,'agl-991',0)                                       
           NEXT FIELD gl_no                                                     
        END IF                                                                  
 
  
         END IF
 
      AFTER FIELD gl_no2
         IF NOT cl_null(gl_no2) THEN
           #--------- MOD-BB0085 add start------
            IF g_nmz.nmz52 = 'Y' AND g_npp00 = '18' THEN
               CALL s_check_no("agl",gl_no2,"","3","aac_file","aac01",p_plant)
               RETURNING li_result,gl_no2
            ELSE
           #--------- MOD-BB0085 add end---------
               CALL s_check_no("agl",gl_no2,"","1","aac_file","aac01",p_plant)      #MOD-5C0083 #FUN-980094
               RETURNING li_result,gl_no2
            END IF   #No.MOD-BB0085 add
            IF (NOT li_result) THEN                                                                                                 
               NEXT FIELD gl_no2            
            END IF                           #--NO:6842
            LET l_no1 = gl_no2                                                        
            SELECT aac03 INTO l_aac03_1 FROM aac_file WHERE aac01= l_no1               
            IF l_aac03_1 != '0' THEN                                                  
               CALL cl_err(gl_no2,'agl-991',0)                                       
               NEXT FIELD gl_no2                                                     
            END IF                                                                  
 
         END IF
 
      AFTER FIELD gl_date
         IF NOT cl_null(gl_date) THEN 
            SELECT aaa07 INTO l_aaa07 FROM aaa_file WHERE aaa01 = p_bookno
            IF gl_date <= l_aaa07 THEN    
               CALL cl_err('','axm-164',0) 
               NEXT FIELD gl_date
            END IF
            SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file 
             WHERE azn01 = gl_date
            IF SQLCA.sqlcode THEN
               CALL cl_err3("sel","azn_file",gl_date,"",SQLCA.sqlcode,"","read azn:",0) #No.FUN-660148
               NEXT FIELD gl_date
            END IF
         ELSE
            CALL chk_date()
            IF g_success = 'N' THEN
               LET g_flag = 'N'
               NEXT FIELD gl_date
            ELSE
               LET g_flag = 'Y'
            END IF
         END IF
         LET gl_date_t=gl_date #MOD-970189    
 
      AFTER FIELD gl_seq  
         IF NOT cl_null(gl_seq) THEN
            IF gl_seq NOT MATCHES '[012]' THEN
               NEXT FIELD gl_seq 
            END IF
         END IF
 
      AFTER INPUT
         IF INT_FLAG THEN 
            EXIT INPUT
         END IF
         IF cl_null(gl_no[1,g_doc_len]) THEN
            NEXT FIELD gl_no
         END IF
         IF g_aza.aza63 = 'Y' THEN   #MOD-690062 
            IF cl_null(gl_no2[1,g_doc_len]) THEN 
               NEXT FIELD gl_no2
            END IF
         END IF    #MOD-690062
         IF cl_null(gl_date) THEN
            LET g_flag='Y'
         END IF
         # 得出總帳 database name
         LET g_plant_new= p_plant  # 工廠編號
         CALL s_getdbs()
         LET g_dbs_gl=g_dbs_new    # 得資料庫名稱
         IF NOT cl_null(gl_date) THEN   #CHI-880014 add
            SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file
             WHERE azn01 = gl_date
            IF STATUS THEN
               CALL cl_err3("sel","azn_file",gl_date,"",SQLCA.sqlcode,"","read azn:",0) #No.FUN-660148
               NEXT FIELD gl_date
            END IF
         END IF   #CHI-880014 add
 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON ACTION CONTROLP
         IF INFIELD(gl_no) THEN  #NO:6842
            CALL s_getdbs()                                                                                                            
            LET g_dbs_gl=g_dbs_new 
            LET g_plant_gl = p_plant   #No.FUN-980059
            #CHI-A40016 mod --start--
            #CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no,'1','0',' ','AGL') #MOD-840238 mod  #No.FUN-840125 #No.FUN-980059
            #     RETURNING gl_no
            IF g_nmz.nmz52 = 'Y' AND g_npp00 = '18' THEN
              CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no,'3','0',' ','AGL') #MOD-840238 mod  #No.FUN-840125 #No.FUN-980059
                   RETURNING gl_no
            ELSE 
              CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no,'1','0',' ','AGL') #MOD-840238 mod  #No.FUN-840125 #No.FUN-980059
                   RETURNING gl_no
            END IF
            #CHI-A40016 mod --end--
            DISPLAY BY NAME gl_no
            NEXT FIELD gl_no
         END IF
 
         IF INFIELD(gl_no2) THEN  #NO:6842
            CALL s_getdbs()                                                                                                            
            LET g_dbs_gl=g_dbs_new 
            #CHI-A40016 mod --start--
            #CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no2,'1','0',' ','AGL') #MOD-840238 mod   #No.FUN-840125  #No.FUN-980059
            #     RETURNING gl_no2
            IF g_nmz.nmz52 = 'Y' AND g_npp00 = '18' THEN
               CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no2,'3','0',' ','AGL') #MOD-840238 mod   #No.FUN-840125  #No.FUN-980059
                    RETURNING gl_no2
            ELSE 
               CALL q_m_aac1(FALSE,TRUE,g_plant_gl,gl_no2,'1','0',' ','AGL') #MOD-840238 mod   #No.FUN-840125  #No.FUN-980059
                    RETURNING gl_no2
            END IF
            #CHI-A40016 mod --end--
            DISPLAY BY NAME gl_no2
            NEXT FIELD gl_no2
         END IF
 
      ON ACTION get_missing_voucher_no  
         IF cl_null(gl_no) AND cl_null(gl_no2) THEN  #No.FUN-670068 add cl_null(gl_no2)
            NEXT FIELD gl_no             
         END IF                         
         IF cl_null(gl_date) THEN
            NEXT FIELD gl_date
         END IF
         FOREACH tmn_del INTO l_tmn02,l_tmn06                                                                                    
            DELETE FROM tmn_file                                                                                                 
            WHERE tmn01 = p_plant
              AND tmn02 = l_tmn02                                                                                                
              AND tmn06 = l_tmn06                                                                                                
         END FOREACH  
         DELETE FROM agl_tmp_file 
         CALL s_agl_missingno(p_plant,g_dbs_gl,p_bookno,gl_no,p_bookno2,gl_no2,gl_date,0)  #No.FUN-670068
         SELECT COUNT(*) INTO l_cnt FROM agl_tmp_file 
          WHERE tc_tmp00='Y'                        
         IF l_cnt > 0 THEN                         
            CALL cl_err(l_cnt,'aap-501',0)        
#No.FUN-A10089 --begin
            LET l_sql = " SELECT tc_tmp02 FROM agl_tmp_file ",
                        "  WHERE tc_tmp00 ='Y'"
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
            PREPARE sel_tmp_pre   FROM l_sql
            DECLARE sel_tmp  CURSOR FOR sel_tmp_pre
            LET l_chr2 =' '  
            FOREACH sel_tmp INTO l_chr1
              IF cl_null(l_chr2) THEN
                 LET l_chr2 =l_chr1
              ELSE
                 LET l_chr2 =l_chr2 CLIPPED,'|',l_chr1
              END IF
            END FOREACH
            DISPLAY l_chr2 TO chr2
#No.FUN-A10089 --end     
         ELSE                                    
            CALL cl_err('','aap-502',0)        
         END IF                               
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION locale
         LET g_change_lang = TRUE        #->No.FUN-570127
         EXIT INPUT
 
   END INPUT
   IF g_change_lang THEN
      LET g_change_lang = FALSE
      CALL cl_dynamic_locale()
      CONTINUE WHILE
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p400
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
      EXIT PROGRAM
   END IF
   IF g_bgjob = "Y" THEN
      SELECT zz08 INTO lc_cmd FROM zz_file
       WHERE zz01 = "anmp400"
      IF SQLCA.sqlcode OR lc_cmd IS NULL THEN
          CALL cl_err('anmp400','9031',1)   
      ELSE
         LET g_wc=cl_replace_str(g_wc, "'", "\"")
         LET lc_cmd = lc_cmd CLIPPED,
                      " '",g_wc CLIPPED,"'",
                      " '",b_user CLIPPED,"'",
                      " '",e_user CLIPPED,"'",
                      " '",p_plant CLIPPED,"'",
                      " '",p_bookno CLIPPED,"'",
                      " '",gl_no CLIPPED,"'",
                      " '",p_bookno2 CLIPPED,"'",    #No.FUN-680034
                      " '",gl_no2 CLIPPED,"'",       #No.FUN-680034
                      " '",gl_date CLIPPED,"'",
                      " '",gl_tran CLIPPED,"'",
                      " '",gl_seq CLIPPED,"'",
                      " '",g_bgjob CLIPPED,"'"
         CALL cl_cmdat('anmp400',g_time,lc_cmd CLIPPED)
      END IF
      CLOSE WINDOW p400
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
      EXIT PROGRAM
   END IF
   EXIT WHILE
END WHILE
END FUNCTION
 
FUNCTION p400_t(p_npptype)                      #No.FUN-680034
   DEFINE l_npp		RECORD LIKE npp_file.*
   DEFINE l_npq		RECORD LIKE npq_file.*
   DEFINE l_order	LIKE npp_file.npp01     #No.FUN-680107 VARCHAR(30)
   DEFINE l_cmd  	LIKE type_file.chr50    #No.FUN-680107 VARCHAR(30)
   DEFINE l_remark	LIKE type_file.chr1000  #No.FUN-680107 VARCHAR(150)  #No.7319
   DEFINE l_nnm01       LIKE nnm_file.nnm01     #No:9028
   DEFINE l_nnm02       LIKE nnm_file.nnm02     #No:9028
   DEFINE l_nnm03       LIKE nnm_file.nnm03     #No:9028
   DEFINE l_name	LIKE type_file.chr20    #No.FUN-680107 VARCHAR(20)
   DEFINE nm_date	LIKE npl_file.npl02     #No.FUN-680107 DATE
   DEFINE nm_glno	LIKE npl_file.npl09     #No.FUN-680107 VARCHAR(16) #No.FUN-560190
   DEFINE nm_conf	LIKE npl_file.nplconf   #No.FUN-680107 VARCHAR(1)
   DEFINE nm_user	LIKE npl_file.npluser   #No.FUN-680107 VARCHAR(10)
   DEFINE l_flag        LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1)
   DEFINE l_yy,l_mm     LIKE type_file.num5     #No.FUN-680107 SMALLINT
   DEFINE l_msg         LIKE type_file.chr1000  #No.FUN-680107 VARCHAR(80)
   DEFINE p_npptype     LIKE npp_file.npptype   #No.FUN-680034
   DEFINE l_flag2       LIKE type_file.chr1     #No.FUN-680034 #No.FUN-680107 VARCHAR(1)
   DEFINE l_cnt         LIKE type_file.num10    #MOD-840270
   DEFINE l_aba11       LIKE aba_file.aba11     #FUN-840211
   DEFINE l_aaa07       LIKE aaa_file.aaa07     #No.MOD-930194 add
   DEFINE l_cnt18       LIKE type_file.num10    #MOD-AA0163
   DEFINE l_no_ep       LIKE type_file.num5     #No.MOD-B70277 add 單據編號的結束位置
   DEFINE l_npp01       LIKE npp_file.npp01     #TQC-BA0149
   DEFINE l_yy1         LIKE type_file.num5     #CHI-CB0004
   DEFINE l_mm1         LIKE type_file.num5     #CHI-CB0004
 
   DELETE FROM p400_tmp;
   IF p_npptype = '0' THEN
      LET gl_no_b=''
      LET gl_no_e=''
   ELSE
      LET gl_no2_b='' 
      LET gl_no2_e=''
   END IF
  #check 所選的資料中其分錄日期不可和總帳傳票日期有不同年月
   IF NOT cl_null(gl_date) THEN   #CHI-880014 add
#判斷是否小于關帳日期
      IF p_npptype = '0' THEN
         SELECT aaa07 INTO l_aaa07 FROM aaa_file
            WHERE aaa01 = p_bookno
      ELSE
         SELECT aaa07 INTO l_aaa07 FROM aaa_file
            WHERE aaa01 = p_bookno1
      END IF
      IF gl_date <= l_aaa07 THEN
         IF g_bgjob = 'Y' THEN
            CALL s_errmsg('','','','axr-164',1)
         ELSE 
            CALL cl_err('','axr-164',0)
         END IF
         LET g_success = 'N'
         RETURN
       END IF
      LET g_sql="SELECT UNIQUE YEAR(npp02),MONTH(npp02) ",
                "  FROM npp_file,nmy_file",
                " WHERE nppsys= 'NM'  ",
                "   AND (nppglno IS NULL OR nppglno = ' ' )",
                "   AND ",g_wc CLIPPED,
                "   AND npp01 like ltrim(rtrim(nmyslip)) || '-%' ",   #MOD-640016
                "   AND ((npp00 <> '18' AND nmydmy3='Y') OR npp00 = '18')", #MOD-640016
                "   AND ( YEAR(npp02)  !=YEAR('",gl_date,"') OR ",
                "        (YEAR(npp02)   =YEAR('",gl_date,"') AND ",
                "         MONTH(npp02) !=MONTH('",gl_date,"'))) ",          #No.FUN-680034
                "   AND npptype = '",p_npptype,"' "                         #No.FUN-680034
      PREPARE p400_prechk FROM g_sql
      IF SQLCA.sqlcode THEN
         CALL cl_err('p400_prechk',STATUS,1)  
         LET g_success = 'N'
         RETURN
      END IF
      DECLARE p400_chkdate CURSOR WITH HOLD FOR p400_prechk
      IF SQLCA.sqlcode THEN
         CALL cl_err('declare p400_chkdate',STATUS,1)
         LET g_success = 'N'
         RETURN
      END IF
 
      LET l_flag='N'
      FOREACH p400_chkdate INTO l_yy,l_mm
         LET l_flag='Y'  EXIT FOREACH
      END FOREACH
      IF l_flag ='Y' THEN
         CALL cl_err('err:','axr-061',1)
         LET g_success = 'N'
         RETURN
      END IF
   END IF   #CHI-880014 add
 
  IF g_aaz.aaz81 = 'Y' THEN
     LET l_yy1 = YEAR(gl_date)    #CHI-CB0004
     LET l_mm1 = MONTH(gl_date)   #CHI-CB0004
    #IF g_aza.aza63 = 'Y' THEN                                                                      #MOD-CC0059 mark
     IF p_npptype = '0' THEN
         #LET g_sql = "SELECT MAX(aba11)+1 FROM ",g_dbs_gl,"aba_file",
         LET g_sql = "SELECT MAX(aba11)+1 FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                     " WHERE aba00 =  '",p_bookno,"'"
                    ,"   AND aba19 <> 'X' "  #CHI-C80041
                    ,"   AND YEAR(aba02) = '",l_yy1,"' AND MONTH(aba02) = '",l_mm1,"'"  #CHI-CB0004
     ELSE
         #LET g_sql = "SELECT MAX(aba11)+1 FROM ",g_dbs_gl,"aba_file",
         LET g_sql = "SELECT MAX(aba11)+1 FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                     " WHERE aba00 =  '",p_bookno2,"'"
                    ,"   AND aba19 <> 'X' "  #CHI-C80041
                    ,"   AND YEAR(aba02) = '",l_yy1,"' AND MONTH(aba02) = '",l_mm1,"'"  #CHI-CB0004
     END IF
    #END IF                                                                                         #MOD-CC0059 mark
     
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
     PREPARE aba11_pre FROM g_sql
     EXECUTE aba11_pre INTO l_aba11
    #CHI-CB0004--(B)
     IF cl_null(l_aba11) OR l_aba11 = 1 THEN
        LET l_aba11 = YEAR(gl_date)*1000000+MONTH(gl_date)*10000+1
     END IF
    #CHI-CB0004--(E)
    #IF cl_null(l_aba11) THEN LET l_aba11 = 1 END IF  #CHI-CB0004
     LET g_aba.aba11 = l_aba11
  ELSE 
     LET g_aba.aba11 = ' '        
     
  END IF      
  
   #no.3432 (是否自動傳票確認)
   #LET g_sql = "SELECT aaz85 FROM ",g_dbs_gl CLIPPED,"aaz_file",
   LET g_sql = "SELECT aaz85 FROM ",cl_get_target_table(g_plant_new,'aaz_file'), #FUN-A50102
               " WHERE aaz00 = '0' "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
   PREPARE aaz85_pre FROM g_sql
   DECLARE aaz85_cs CURSOR FOR aaz85_pre
   OPEN aaz85_cs 
   IF STATUS THEN
      CALL cl_err('open aaz85_cs',STATUS,1)
      RETURN
   END IF
 
   FETCH aaz85_cs INTO g_aaz85
   IF STATUS THEN 
      CALL cl_err('fetch aaz85',STATUS,1)
      RETURN
   END IF
   #no.3432(end)
 
   LET g_sql="SELECT npp_file.*,npq_file.* ", 
             "  FROM npp_file,npq_file,nmy_file",
             " WHERE nppsys= 'NM'  ",
             "   AND npptype = '",p_npptype,"' ",  #No.FUN-680034
             "   AND npptype = npqtype ",          #No.FUN-680034
             "   AND (nppglno IS NULL OR nppglno = ' ' )",
             "   AND nppsys= npqsys AND npp00=npq00",
             "   AND npp01 = npq01 AND npp011=npq011",
             "   AND ",g_wc CLIPPED,
             "   AND npp01 like ltrim(rtrim(nmyslip)) || '-%' ",   #MOD-640016
             "   AND ((npp00 <> '18' AND nmydmy3='Y') OR npp00 = '18')"  #MOD-640016
   PREPARE p400_1_p0 FROM g_sql
   IF STATUS THEN 
       CALL cl_err('p400_1_p0',STATUS,1) 
       CALL cl_batch_bg_javamail("N")     # No.FUN-570127
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690117
       EXIT PROGRAM 
   END IF
   DECLARE p400_1_c0 CURSOR WITH HOLD FOR p400_1_p0
 
   CALL cl_outnam('anmp400') RETURNING l_name
   IF p_npptype = '0' THEN
      START REPORT anmp400_rep TO l_name
   ELSE
      START REPORT anmp400_1_rep TO l_name
   END IF
   LET l_cnt = 0     #MOD-840270
   LET l_cnt18 = 0   #MOD-AA0163
   WHILE TRUE
      LET l_flag2 = 'N'   #No.FUN-680034
      FOREACH p400_1_c0 INTO l_npp.*,l_npq.*
         IF STATUS THEN
            CALL s_errmsg('','','foreach:',STATUS,1)
            LET g_success = 'N' 
            EXIT FOREACH
         END IF
         IF g_success="N" THEN                                                                                                         
            LET g_totsuccess="N"     
            LET g_success='Y'                                                                                                        
         END IF 
         LET l_flag2 = 'Y'   #No.FUN-680034
         CASE WHEN l_npp.nppsys='NM' AND l_npp.npp00=1
                   #FUN-DA0047--add--str--
                   IF l_npp.npp011=10 THEN #應付票據
                      SELECT nmd07,nmd27,nmd30,nmduser
                        INTO nm_date,nm_glno,nm_conf,nm_user
                        FROM nmd_file
                       WHERE nmd01=l_npp.npp01
                      IF STATUS THEN
                         CALL s_errmsg('nmd01',l_npp.npp01,'sel nmd:',STATUS,1)
                         LET g_success='N'
                      END IF
                   ELSE
                   #FUN-DA0047--add--end
                      SELECT npl02,npl09,nplconf,npluser
                        INTO nm_date,nm_glno,nm_conf,nm_user
                        FROM npl_file 
                       WHERE npl01=l_npp.npp01
                      IF STATUS THEN
                         CALL s_errmsg('npl01',l_npp.npp01,'sel npl:',STATUS,1)
                        LET g_success='N'
                      END IF
                   END IF #FUN-DA0047
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=2
                  IF l_npp.npp011=1 THEN #應收票據
                     SELECT nmh04,nmh33,nmh38,nmhuser
                       INTO nm_date,nm_glno,nm_conf,nm_user
                       FROM nmh_file WHERE nmh01=l_npp.npp01
                     IF STATUS THEN
                        CALL s_errmsg('nmh01',l_npp.npp01,'sel nmh:',STATUS,1)
                        LET g_success='N'
                     END IF
                  ELSE
                     SELECT npn02,npn09,npnconf,npnuser
                       INTO nm_date,nm_glno,nm_conf,nm_user
                       FROM npn_file WHERE npn01=l_npp.npp01
                     IF STATUS THEN
                        CALL s_errmsg('npn01',l_npp.npp01,'sel npn:',STATUS,1)
                        LET g_success='N'
                     END IF
                  END IF
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=3 AND l_npp.npp011=1 
                   SELECT nmg01,nmg13,nmgconf,nmguser
                     INTO nm_date,nm_glno,nm_conf,nm_user
                     FROM nmg_file WHERE nmg00=l_npp.npp01
                   IF STATUS THEN
                      CALL s_errmsg('nmg01',l_npp.npp01,'sel nmg:',STATUS,1)
                      LET g_success='N' 
                   END IF
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=6       #還息
                   SELECT nni02,nniglno,nniconf,nniuser
                     INTO nm_date,nm_glno,nm_conf,nm_user
                     FROM nni_file WHERE nni01=l_npp.npp01
                   IF STATUS THEN
                      CALL s_errmsg('nni01',l_npp.npp01,'sel nni:',STATUS,1)
                      LET g_success='N' 
                   END IF
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=7       #還本
                   SELECT nnk02,nnkglno,nnkconf,nnkuser
                     INTO nm_date,nm_glno,nm_conf,nm_user
                     FROM nnk_file WHERE nnk01=l_npp.npp01
                   IF STATUS THEN
                      CALL s_errmsg('nnk01',l_npp.npp01,'sel nnk:',STATUS,1)
                      LET g_success='N'
                   END IF
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=16      #短期融資
                  #SELECT nne02,nneglno,nneconf,nneuser      #TQC-C50137 mark
                   SELECT nne03,nneglno,nneconf,nneuser      #TQC-C50137
                     INTO nm_date,nm_glno,nm_conf,nm_user
                     FROM nne_file WHERE nne01=l_npp.npp01
                   IF STATUS THEN
                      CALL s_errmsg('nne01',l_npp.npp01,'sel nne:',STATUS,1)
                      LET g_success='N'
                   END IF
              WHEN l_npp.nppsys='NM' AND l_npp.npp00=17      #中長貸
                   SELECT nng02,nngglno,nngconf,nnguser
                     INTO nm_date,nm_glno,nm_conf,nm_user
                     FROM nng_file WHERE nng01=l_npp.npp01
                   IF STATUS THEN
                      CALL s_errmsg('nng01',l_npp.npp01,'sel nng:',STATUS,1)
                      LET g_success='N' 
                   END IF
             WHEN l_npp.nppsys='NM' AND l_npp.npp00 = 18  #利息暫估
                   CALL p400_no_ep() RETURNING l_no_ep    #No.MOD-B70277 add
                   LET l_nnm01=l_npp.npp01[1,l_no_ep]     #No.MOD-B70277 add
                  #LET l_nnm01=l_npp.npp01[1,g_no_ep]     #No.MOD-B70277 mark
                   LET l_nnm02=YEAR(l_npp.npp02)
                   LET l_nnm03=MONTH(l_npp.npp02)
                  SELECT nnm06,nnmglno,nnmconf,nnmuser
                    INTO nm_date,nm_glno,nm_conf,nm_user
                    FROM nnm_file
                   WHERE nnm01=l_nnm01 AND nnm02=l_nnm02 AND nnm03=l_nnm03
                  IF STATUS THEN
                     LET g_showmsg=l_nnm01,"/",l_nnm02,"/",l_nnm03
                     CALL s_errmsg('nnm01,nnm02,nnm03',g_showmsg,'sel nnm:',STATUS,1)
                     LET g_success='N'
                  END IF
                  IF nm_conf = 'Y' THEN          #MOD-B30037
                     LET l_cnt18 = l_cnt18 + 1   #MOD-AA0163
                  END IF                         #MOD-B30037
             WHEN l_npp.nppsys='NM' AND l_npp.npp00 = 19   #購入
                  SELECT gsh02,gsh21,gshconf,gshuser
                    INTO nm_date,nm_glno,nm_conf,nm_user
                    FROM gsh_file WHERE gsh01=l_npp.npp01
                  IF STATUS THEN
                     CALL s_errmsg('gsh01',l_npp.npp01,'sel gsh:',STATUS,1)
                     LET g_success='N'
                  END IF
             WHEN l_npp.nppsys='NM' AND l_npp.npp00 = 20   #平倉
                  SELECT gse02,gse21,gseconf,gseuser
                    INTO nm_date,nm_glno,nm_conf,nm_user
                    FROM gse_file WHERE gse01=l_npp.npp01
                  IF STATUS THEN
                     CALL s_errmsg('gse01',l_npp.npp01,'sel gse:',STATUS,1)
                     LET g_success='N'
                  END IF
              OTHERWISE CONTINUE FOREACH
         END CASE
         IF nm_conf='N' THEN CONTINUE FOREACH END IF
         IF nm_conf='X' THEN CONTINUE FOREACH END IF #已作廢 01/08/16
         IF nm_user<b_user OR nm_user>e_user THEN CONTINUE FOREACH END IF
         IF nm_glno IS NOT NULL AND p_npptype = '0' THEN CONTINUE FOREACH END IF  #No.FUN-680034
         IF l_npp.npp011=1 AND nm_date<>l_npp.npp02 THEN
            LET l_msg= "Date differ:",nm_date,'-',l_npp.npp02,
                       "  * Press any key to continue ..."
            CALL cl_msgany(19,4,l_msg)
            LET INT_FLAG = 0  ######add for prompt bug
         END IF
         IF l_npq.npq04 = ' ' THEN LET l_npq.npq04 = NULL END IF
         IF gl_tran = 'N' THEN 
              LET l_npq.npq04 = NULL 
              LET l_remark = l_npq.npq11 CLIPPED,l_npq.npq12 CLIPPED,
                             l_npq.npq13 CLIPPED,l_npq.npq14 CLIPPED,
                             l_npq.npq31 clipped,l_npq.npq32 clipped,
                             l_npq.npq33 clipped,l_npq.npq34 clipped,
                             l_npq.npq35 clipped,l_npq.npq36 clipped,
                             l_npq.npq37 clipped,
                             l_npq.npq15 CLIPPED,l_npq.npq08 CLIPPED
         ELSE 
              LET l_remark = l_npq.npq04 CLIPPED,l_npq.npq11 CLIPPED,
                             l_npq.npq12 CLIPPED,l_npq.npq13 CLIPPED,
                             l_npq.npq14 CLIPPED,
                             l_npq.npq31 clipped,l_npq.npq32 clipped,
                             l_npq.npq33 clipped,l_npq.npq34 clipped,
                             l_npq.npq35 clipped,l_npq.npq36 clipped,
                             l_npq.npq37 clipped,
                             l_npq.npq15 CLIPPED,
                             l_npq.npq08 CLIPPED
         END IF
         CASE WHEN gl_seq = '0' LET l_order = ' '         # 傳票區分項目
              WHEN gl_seq = '1' LET l_order = l_npp.npp01 # 依單號
              WHEN gl_seq = '2' LET l_order = l_npp.npp02 # 依日期
              OTHERWISE         LET l_order = ' '
         END CASE
         #資料丟入temp file 排序
         INSERT INTO p400_tmp VALUES(l_order,l_npp.*,l_npq.*,l_remark)
         IF STATUS THEN
            CALL s_errmsg('p400_tmp.order1',l_order,'ins tmp:',STATUS,1)
            LET g_success='N' 
            CONTINUE FOREACH
         END IF
         LET l_cnt = l_cnt + 1   #MOD-840270
      END FOREACH
     #-MOD-AA0163-add-
      IF l_cnt18 > 0 AND l_cnt <> l_cnt18 THEN
         CALL s_errmsg('','','','anm-092',1)
         LET g_success='N' 
      END IF
     #-MOD-AA0163-end-
      IF g_totsuccess="N" THEN                                                                                                         
         LET g_success="N"                                                                                                             
      END IF 
      IF l_flag2 = 'N' THEN 
         CALL s_errmsg('','','foreach:',100,1)
         LET g_success = 'N' 
      END IF                 
      LET l_npp01 = NULL   #No.TQC-BA0149
     #-----------------------------MOD-C20025--------------------------------------start
     DECLARE p400_tmpcs CURSOR FOR
        SELECT * FROM p400_tmp 
         ORDER BY order1,npq06,npq03,npq05,   #No.TQC-BA0149 add npp01
                  npq24,npq25,remark,npq01

     #IF g_aza.aza26=2 THEN
     #   LET g_sql = "SELECT * FROM p400_tmp ",
     #               "ORDER BY order1,npp01,npq06,npq03,npq05, ",
     #               "         npq24,npq25,remark,npq01"
     #ELSE
     #   LET g_sql = "SELECT * FROM p400_tmp ",
     #               "ORDER BY order1,npq06,npq03,npq05,npq24, ",
     #               "         npq25,remark"
     #END IF
     #PREPARE p400_tmpp FROM g_sql
     #DECLARE p400_tmpcs CURSOR WITH HOLD FOR p400_tmpp
     #-----------------------------MOD-C20025----------------------------------------end
      FOREACH p400_tmpcs INTO l_order,l_npp.*,l_npq.*,l_remark
         IF STATUS THEN
            CALL s_errmsg('','','for tmp:',STATUS,1)
            LET g_success='N'
            EXIT FOREACH
         END IF
         #No.TQC-BA0149  --Begin
         IF NOT cl_null(l_npp01) AND l_npp01 = l_npp.npp01 THEN
            LET l_npp.npp08 = 0
         END IF
         LET l_npp01 = l_npp.npp01
         #No.TQC-BA0149  --End
         IF p_npptype = '0' THEN
            OUTPUT TO REPORT anmp400_rep(l_order,l_npp.*,l_npq.*,l_remark)
         ELSE
            OUTPUT TO REPORT anmp400_1_rep(l_order,l_npp.*,l_npq.*,l_remark)
         END IF
      END FOREACH
      EXIT WHILE
   END WHILE
   IF p_npptype = '0' THEN
      FINISH REPORT anmp400_rep
   ELSE
      FINISH REPORT anmp400_1_rep
   END IF
   IF os.Path.chrwx(l_name CLIPPED,511) THEN END IF   #No.FUN-9C0009
   IF l_cnt = 0  THEN                                                                                                              
       CALL s_errmsg('','','','aap-129',1)        
      LET g_success = 'N'                                                                                                           
   END IF 
 
END FUNCTION
 
REPORT anmp400_rep(l1_order,l1_npp,l1_npq,l1_remark)
  DEFINE l1_order	LIKE npp_file.npp01     #MOD-710053    
  DEFINE l_npk		RECORD LIKE npk_file.*
  DEFINE l_nnm01        LIKE nnm_file.nnm01     #No:9028
  DEFINE l_nnm02        LIKE nnm_file.nnm02     #No.MOD-560179
  DEFINE l_nnm03        LIKE nnm_file.nnm03     #No.MOD-560179
  DEFINE l1_npp		RECORD LIKE npp_file.*
  DEFINE l1_npq		RECORD LIKE npq_file.*
  DEFINE l_seq          LIKE type_file.num5     #No.FUN-680107 SMALLINT # 傳票項次
  DEFINE l_nmg01        LIKE nmg_file.nmg01
  DEFINE l_credit,l_debit,l_amt,l_amtf LIKE type_file.num20_6  #No.FUN-680107 DECIMAL(20,6) #No.FUN-4C0010
  DEFINE l1_remark      LIKE type_file.chr1000  #No.FUN-680107 VARCHAR(150) #No.7319
  DEFINE li_result      LIKE type_file.num5     #No.FUN-680107 SMALLINT  #No.FUN-560190
  DEFINE l_missingno    LIKE aba_file.aba01     #No.FUN-570090  --add
  DEFINE l_flag1        LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1) #No.FUN-570090  --add 
  DEFINE l_apa01        LIKE apa_file.apa01     #CHI-810018
  DEFINE l_oma01        LIKE oma_file.oma01     #CHI-810019
  DEFINE l_nmg20        LIKE nmg_file.nmg20     #MOD-8A0135 add
  DEFINE l_nmg29        LIKE nmg_file.nmg29     #MOD-8A0135 add
  DEFINE l_legal        LIKE aba_file.abalegal  #FUN-980005 
  DEFINE l_npp08        LIKE npp_file.npp08     #MOD-A80017 Add
  DEFINE l_success      LIKE type_file.num5    #No.TQC-B70021 
  DEFINE l_no_ep        LIKE type_file.num5     #No.MOD-B70277 add 單據編號的結束位置
  DEFINE l_date         LIKE type_file.dat
  DEFINE l_time         LIKE type_file.chr10
  DEFINE l_user         LIKE type_file.chr10
  DEFINE l_tc_agl03     LIKE tc_agl_file.tc_agl03
  DEFINE l_count        LIKE type_file.num5
   
  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER EXTERNAL BY l1_order,l1_npq.npq06,l1_npq.npq03,l1_npq.npq05,
           l1_npq.npq24,l1_npq.npq25,l1_npq.npq08,
           l1_remark,l1_npq.npq01
  FORMAT
  #--------- Insert aba_file ---------------------------------------------
 
   BEFORE GROUP OF l1_order
   # 得出總帳 database name                                                                                                         
    IF g_flag = 'Y' THEN                                                         
       LET gl_date = l1_npp.npp02                                                 
       SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file WHERE azn01=gl_date   #MOD
    END IF  
    LET g_plant_new= p_plant  # 工廠編號                                                                                            
    CALL s_getdbs()                                                                                                                 
    LET g_dbs_gl=g_dbs_new CLIPPED                                                                                                  
   #缺號使用               
   LET l_flag1='N'         
   LET l_missingno = NULL 
   LET g_j=g_j+1         
   SELECT tc_tmp02 INTO l_missingno    
     FROM agl_tmp_file                 
    WHERE tc_tmp01=g_j AND tc_tmp00 = 'Y'     
      AND tc_tmp03=p_bookno                #No.FUN-680034
   IF NOT cl_null(l_missingno) THEN          
      LET l_flag1='Y'                       
      LET gl_no=l_missingno                
      DELETE FROM agl_tmp_file WHERE tc_tmp02 = gl_no AND tc_tmp03 = p_bookno  #No.FUN-680034 
   END IF                                               
   #重新抓取g_yy,g_mm
   IF g_aza.aza63 = 'Y' THEN
      LET g_sql = "SELECT aznn02,aznn04 ",
                  #"  FROM ",g_dbs_gl CLIPPED,"aznn_file ",
                  "  FROM ",cl_get_target_table(g_plant_new,'aznn_file'), #FUN-A50102
                  " WHERE aznn01 = '",gl_date,"' ",
                  "   AND aznn00 = '",p_bookno,"' "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p400_aznn_pre FROM g_sql
      DECLARE p400_aznn_cs CURSOR FOR p400_aznn_pre
      OPEN p400_aznn_cs
      FETCH p400_aznn_cs INTO g_yy,g_mm
   ELSE
      IF cl_null(gl_date_t) THEN LET gl_date = l1_npp.npp02 END IF #MOD-970189   
      SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file
       WHERE azn01 = gl_date
   END IF
                                                       
   #缺號使用完，再在流水號最大的編號上增加            
   IF l_flag1='N' THEN                               
     #No.FUN-CB0096 ---start--- Add  #yinhy131010 mark
      #LET t_no = Null
      #CALL s_log_check(l1_order) RETURNING t_no
      #IF NOT cl_null(t_no) THEN
      #   LET gl_no = t_no
      #   LET li_result = '1'
      #ELSE
     #No.FUN-CB0096 ---start--- Add
     CALL s_auto_assign_no("agl",gl_no,gl_date,"","","",p_plant,"",g_nmz.nmz02b)  #FUN-980094
          RETURNING li_result,gl_no                                                                                                 
     #END IF   #No.FUN-CB0096   Add
     PRINT "Get max TR-no:",gl_no," Return code(li_result):",li_result                                                                    
     IF li_result = 0 THEN LET g_success = 'N' END IF      
     PRINT "Insert aba:",g_nmz.nmz02b,' ',gl_no,' From:',l1_order
   END IF  #No.FUN-570090  -add     
     #LET g_sql="INSERT INTO ",g_dbs_gl CLIPPED,"aba_file",
     LET g_sql="INSERT INTO ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                       "(aba00,aba01,aba02,aba03,aba04,aba05,",
                       " aba06,aba07, ",
                       " aba08,aba09,aba12,aba19,aba20,",
                       " abamksg,abapost,",
                       " abaprno,abaacti,abauser,abagrup,abadate,",
                       " abasign,abadays,abaprit,abasmax,abasseq,aba24,aba11,",     #FUN-840211 add aba11 #MOD-640363
                       " abalegal,abaoriu,abaorig,aba21,aba35) ", #FUN-980005   #TQC-A10060 add abaoriu,abaorig FUN-A10006 add aba21 #TQC-A80138 Add aba35
                  " VALUES(?,?,?,?,?,?, ?,?, ",
                  "        ?,?,?,?,?, ?,?,?,?,?,?,?, ?,?,?,?,?,?,?,", #FUN-840211 add ?      #MOD-640363
                  "        ?,?,?,?,?) "       #TQC-A10060 add ?,? FUN-A10006 add ? #TQC-A80138 Add ?
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
     PREPARE p400_1_p4 FROM g_sql
## ----
     #自動賦予簽核等級
     LET g_aba.aba01=gl_no
     LET g_aba01t = s_get_doc_no(gl_no)
     SELECT aac08,aacatsg,aacdays,aacprit,aacsign  #簽核處理 (Y/N)
       INTO g_aba.abamksg,g_aac.aacatsg,g_aba.abadays,
            g_aba.abaprit,g_aba.abasign
       FROM aac_file WHERE aac01 = g_aba01t
     IF g_aba.abamksg MATCHES  '[Yy]'
        THEN
        IF g_aac.aacatsg matches'[Yy]'   #自動付予
           THEN
           CALL s_sign(g_aba.aba01,4,'aba01','aba_file')
                RETURNING g_aba.abasign
        END IF
        SELECT COUNT(*) INTO g_aba.abasmax
            FROM azc_file
            WHERE azc01=g_aba.abasign
     END IF
## ----
    #----------------------  for ora修改 ------------------------------------
     #CHI-A40016 mod --start--
     #LET g_system = 'NM'
     IF g_nmz.nmz52 = 'Y' AND l1_npp.npp00 = '18' THEN
        LET g_system = 'AC'
     ELSE
        LET g_system = 'NM'
     END IF
     #CHI-A40016 mod --end--
     LET g_zero   = 0
     LET g_zero1  = '0'
     LET g_N      = 'N'
     LET g_Y      = 'Y'
     CALL s_getlegal(p_plant) RETURNING l_legal  
     LET g_aba.abalegal = l_legal 

     LET g_aba.abaoriu = g_user   #TQC-A10060  add
     LET g_aba.abaorig = g_grup   #TQC-A10060  add 
     LET l1_order = l1_order CLIPPED
     IF cl_null(l1_order) THEN LET l1_order = ' ' END IF
 
     EXECUTE p400_1_p4 USING g_nmz.nmz02b,gl_no,gl_date,g_yy,g_mm,g_today,
                             g_system,l1_order,g_zero,g_zero,g_N,g_N,g_zero1,    #TQC-950127 
                             g_aba.abamksg,g_N,
                             g_zero,g_Y,g_user,g_grup,g_today,
                             g_aba.abasign,g_aba.abadays,g_aba.abaprit,
                             g_aba.abasmax,g_zero1,g_user,g_aba.aba11   #FUN-840211 add aba11        #MOD-640363
                            ,g_aba.abalegal,g_aba.abaoriu,g_aba.abaorig,l1_npp.npp08  #TQC-A10060 add g_aba.abaoriu,g_aba.abaorig   #FUN-980005  FUN-A10006 add npp08
                            ,g_N                                        #TQC-A80138 Add
    #----------------------  for ora修改 ------------------------------------
     IF SQLCA.sqlcode THEN
        LET g_showmsg=g_nmz.nmz02b,"/",gl_no
        CALL s_errmsg('aba00,aba01',g_showmsg,'ins aba:',SQLCA.sqlcode,1)
         LET g_success = 'N'
     END IF
     #str----add by jixf 20140924
     IF g_success='Y' THEN 
        LET l_time=TIME 
        LET l_date=g_today
        LET l_user=g_user
        LET l_count=0
        SELECT COUNT(*) INTO l_count FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02b AND tc_agl01=gl_no AND tc_agl02='INS'
        IF l_count=0 THEN
           INSERT INTO tc_agl_file VALUES (g_nmz.nmz02b,gl_no,'INS','N','','','','','',0,0)
        END IF 
     END IF 
     #end----add by jixf 20140924
     DELETE FROM tmn_file WHERE tmn01 = p_plant AND tmn02 = gl_no AND tmn06 = p_bookno #No.FUN-570090 #No.FUN-680034 --add  
     IF gl_no_b IS NULL THEN LET gl_no_b = gl_no END IF
     LET gl_no_e = gl_no
     LET l_credit = 0 LET l_debit  = 0
     LET l_seq = 0
   #------------------ Update gl-no To original file --------------------------
   AFTER GROUP OF l1_npq.npq01
     IF cl_null(gl_date_t) THEN LET gl_date = l1_npp.npp02 END IF #MOD-970189              
     CASE WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=1
               #FUN-DA0047--add--str--
               IF l1_npp.npp011=10 THEN  #應付票據
                  UPDATE nmd_file SET nmd27 = gl_no,nmd28=gl_date
                   WHERE nmd01=l1_npq.npq01
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                     CALL s_errmsg('nmd01',l1_npq.npq01,'up nmd_file',SQLCA.sqlcode,1)
                     LET g_success = 'N'
                  END IF
               ELSE
               #FUN-DA0047--add--end
                  UPDATE npl_file SET npl09 = gl_no WHERE npl01 = l1_npq.npq01
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                     CALL s_errmsg('npl01',l1_npq.npq01,'upd npl_file',SQLCA.sqlcode,1)
                     LET g_success = 'N'
                  END IF
                  DECLARE apa_c CURSOR FOR
                    SELECT apa01 FROM apa_file WHERE apa25=l1_npq.npq01
                  FOREACH apa_c INTO l_apa01
                     UPDATE apa_file SET apa44 = gl_no WHERE apa01 = l_apa01
                     IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                        CALL s_errmsg('apa01',l_apa01,'upd apa_file',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                     END IF
                  END FOREACH
               END IF #FUN-DA0047
               CALL p400_upglno(l1_npq.npq01,1,gl_no,l1_npp.npp02,l1_npp.npp011)
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=2
               IF l1_npp.npp011=1 THEN #收票
                  UPDATE nmh_file SET nmh33 = gl_no ,nmh34=gl_date
                    WHERE nmh01 = l1_npq.npq01
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                     CALL s_errmsg('nmh01',l1_npq.npq01,'up nmh_file',SQLCA.sqlcode,1) 
                     LET g_success = 'N'
                  END IF
               ELSE
                  UPDATE npn_file SET npn09 = gl_no WHERE npn01 = l1_npq.npq01
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                     CALL s_errmsg('npn01',l1_npq.npq01,'up npn_file',SQLCA.sqlcode,1) 
                     LET g_success = 'N'
                  END IF
                  DECLARE oma_c CURSOR FOR 
                    SELECT oma01 FROM oma_file WHERE oma16=l1_npq.npq01
                  FOREACH oma_c INTO l_oma01
                     UPDATE oma_file SET oma33 = gl_no WHERE oma01 = l_oma01
                     IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                        CALL s_errmsg('oma01',l_oma01,'upd oma_file',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                     END IF
                  END FOREACH
               END IF
               CALL p400_upglno(l1_npq.npq01,2,gl_no,l1_npp.npp02,l1_npp.npp011)
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=3
               UPDATE nmg_file SET nmg13 = gl_no ,   #CHI-880014 mod
                                   nmg14 = gl_date   #CHI-880014 mod
                WHERE nmg00 = l1_npq.npq01
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] =0 THEN
                  CALL s_errmsg('nmg00',l1_npq.npq01,'up nmg_file',SQLCA.sqlcode,1) 
                  LET g_success = 'N'
               END IF
              #將產生的傳票號碼寫入oma33
               SELECT nmg20,nmg29 INTO l_nmg20,l_nmg29
                 FROM nmg_file
                WHERE nmg00 = l1_npq.npq01
               IF l_nmg20 MATCHES '2[1-2]' AND l_nmg29='Y' THEN
                  LET g_cnt = 0
                  SELECT COUNT(*) INTO g_cnt FROM oma_file
                   WHERE oma01=l1_npq.npq01
                  IF g_cnt > 0 THEN
                     UPDATE oma_file SET oma33=gl_no
                      WHERE oma01=l1_npq.npq01
                     IF STATUS THEN
                        CALL s_errmsg('oma00',l1_npq.npq01,'up oma_file',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                     END IF
                  END IF
               END IF
               CALL p400_upglno(l1_npq.npq01,3,gl_no,l1_npp.npp02,l1_npp.npp011)
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=6    #還息
               UPDATE nni_file SET nniglno = gl_no WHERE nni01 = l1_npq.npq01
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=7    #還本
               UPDATE nnk_file SET nnkglno = gl_no WHERE nnk01 = l1_npq.npq01
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=16   #短期融資
               UPDATE nne_file SET nneglno = gl_no WHERE nne01 = l1_npq.npq01
               CALL p400_upglno(l1_npq.npq01,16,gl_no,l1_npp.npp02,l1_npp.npp011)
          WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=17   #中長貸
               UPDATE nng_file SET nngglno = gl_no WHERE nng01 = l1_npq.npq01
               CALL p400_upglno(l1_npq.npq01,17,gl_no,l1_npp.npp02,l1_npp.npp011)
        WHEN l1_npq.npq00 = 18
              CALL p400_no_ep() RETURNING l_no_ep   #No.MOD-B70277 add
              LET l_nnm01=l1_npp.npp01[1,l_no_ep]    #No.MOD-B70277 add
             #LET l_nnm01=l1_npp.npp01[1,g_no_ep]    #No.MOD-B70277 mark
              LET l_nnm02=YEAR(l1_npp.npp02)
              LET l_nnm03=MONTH(l1_npp.npp02)
             UPDATE nnm_file SET (nnmglno) = (gl_no)
               WHERE nnm01=l_nnm01 AND nnm02=l_nnm02 AND nnm03=l_nnm03   #No.MOD-560179
             IF SQLCA.SQLERRD[3] = 0 OR SQLCA.sqlcode THEN
                LET g_showmsg=l_nnm01,"/",l_nnm02,"/",l_nnm03 
                CALL s_errmsg('nnm01,nnm02,nnm03',g_showmsg,'upd nnm:',SQLCA.sqlcode,1) 
                LET g_success = 'N'
             END IF
         WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=19   #購入
             UPDATE gsh_file SET gsh21 = gl_no,
                                 gsh22 = gl_date
              WHERE gsh01 = l1_npq.npq01
             IF SQLCA.SQLERRD[3] = 0 OR SQLCA.sqlcode THEN
                CALL s_errmsg('gsh01',l1_npq.npq01,'upd gsh:',SQLCA.sqlcode,1) 
                LET g_success = 'N'
             END IF
             CALL p400_upglno(l1_npq.npq01,19,gl_no,l1_npp.npp02,l1_npp.npp011)
         WHEN l1_npp.nppsys='NM' AND l1_npp.npp00=20   #平倉
             UPDATE gse_file SET gse21 = gl_no,
                                 gse22 = gl_date
              WHERE gse01 = l1_npq.npq01
             IF SQLCA.SQLERRD[3] = 0 OR SQLCA.sqlcode THEN
                CALL s_errmsg('gse01',l1_npq.npq01,'upd gse:',SQLCA.sqlcode,1) 
                LET g_success = 'N'
             END IF
             CALL p400_upglno(l1_npq.npq01,20,gl_no,l1_npp.npp02,l1_npp.npp011)
     END CASE
     IF SQLCA.sqlcode THEN
        CALL s_errmsg('','','upd nm?13/14:',SQLCA.sqlcode,1) 
        LET g_success = 'N'
     END IF
     UPDATE npp_file SET npp03 = gl_date,nppglno=gl_no,
            npp06=p_plant,npp07= g_nmz.nmz02b
       WHERE npp01 = l1_npp.npp01
         AND npp011= l1_npp.npp011
         AND npp00 = l1_npp.npp00
         AND nppsys= l1_npp.nppsys
         AND npptype = '0'       #No.FUN-680034
     IF SQLCA.sqlcode THEN
        LET g_showmsg=l1_npp.npp01,"/",l1_npp.npp011,"/",l1_npp.npp00,"/",l1_npp.nppsys,"/",'0'
        CALL s_errmsg('npp01,npp011,npp00,nppsys,npptype',g_showmsg,'upd npp03/gl_no',SQLCA.sqlcode,1) 
        LET g_success = 'N'
     END IF
 
   #------------------ Insert into abb_file ---------------------------------
   AFTER GROUP OF l1_remark   
     LET l_seq = l_seq + 1
     DISPLAY "Seq:",l_seq AT 2,1
     CALL s_getlegal(p_plant) RETURNING l_legal  
     #LET g_sql = "INSERT INTO ",g_dbs_gl CLIPPED,"abb_file",
     LET g_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'abb_file'), #FUN-A50102
                        "(abb00,abb01,abb02,abb03,abb04,",
                        " abb05,abb06,abb07f,abb07, ",
                        " abb08,abb11,abb12,abb13,abb14, ",             #No.FUN-810069    
                        " abb24,abb25,",
          
                        "abb31,abb32,abb33,abb34,abb35,abb36,abb37",
                        ",abblegal " , #FUN-980005 
                        " )",
                 " VALUES(?,?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?",          #No.FUN-810069   
                 "       ,?,?,?,?,?, ?,?,?)" #FUN-5C0015 BY GILL
     LET l_amtf= GROUP SUM(l1_npq.npq07f)
     LET l_amt = GROUP SUM(l1_npq.npq07)
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
     PREPARE p400_1_p5 FROM g_sql
     EXECUTE p400_1_p5 USING 
                g_nmz.nmz02b,gl_no,l_seq,l1_npq.npq03,l1_npq.npq04,
                l1_npq.npq05,l1_npq.npq06,l_amtf,l_amt,
                l1_npq.npq08,l1_npq.npq11,l1_npq.npq12,l1_npq.npq13,
                l1_npq.npq14,l1_npq.npq24,l1_npq.npq25,    #No.FUN-810069        
 
                l1_npq.npq31,l1_npq.npq32,l1_npq.npq33,l1_npq.npq34,
                l1_npq.npq35,l1_npq.npq36,l1_npq.npq37                  #No.FUN-810069   
                ,l_legal    #FUN-980005 
 
     IF SQLCA.sqlcode THEN
        LET g_showmsg=g_nmz.nmz02b,"/",gl_no,"/",l_seq
        CALL s_errmsg('abb00,abb01,abb02',g_showmsg,'ins abb:',SQLCA.sqlcode,1)
        LET g_success='N'
     END IF
     IF l1_npq.npq06 = '1'
        THEN LET l_debit  = l_debit  + l_amt
        ELSE LET l_credit = l_credit + l_amt
     END IF
   #------------------ Update aba_file's debit & credit amount --------------
   AFTER GROUP OF l1_order
      LET l_npp08 = GROUP SUM(l1_npp.npp08)                           #MOD-A80017 Add
      PRINT "update debit&credit:",l_debit,' ',l_credit," For:",gl_no
      #LET g_sql = "UPDATE ",g_dbs_gl,"aba_file SET aba08 = ?,aba09 = ? ",   #CHI-880014 mod
      LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                  " SET aba08 = ?,aba09 = ? ",
                  "    ,aba21=? ",                                 #MOD-A80017 Add
                  " WHERE aba01 = ? AND aba00 = ?"
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p400_1_p6 FROM g_sql
      EXECUTE p400_1_p6 USING l_debit,l_credit,l_npp08,gl_no,g_nmz.nmz02b  #MOD-A80017 Add l_npp08
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET g_showmsg=gl_no,"/",g_nmz.nmz02b
         CALL s_errmsg('aba01,aba00',g_showmsg,'upd aba08/09',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      PRINT
#自動確認
     CALL s_flows('2',g_nmz.nmz02b,gl_no,gl_date,g_N,'',TRUE)   #No.TQC-B70021   

IF g_aaz85 = 'Y' THEN 
      #若有立沖帳管理就不做自動確認
      #LET g_sql = "SELECT COUNT(*) FROM ",g_dbs_gl CLIPPED," abb_file,aag_file",
      LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'abb_file')," ,aag_file", #FUN-A50102      
                  " WHERE abb01 = '",gl_no,"'",
                  "   AND abb00 = '",g_nmz.nmz02b,"'",
                  "   AND abb03 = aag01  ",
                  "   AND aag20 = 'Y' ",
                  "   AND abb00 = aag00  "       #No.FUN-740049
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE count_pre FROM g_sql
      DECLARE count_cs CURSOR FOR count_pre
      OPEN count_cs 
      FETCH count_cs INTO g_cnt
      CLOSE count_cs
      IF g_cnt = 0 THEN
         IF cl_null(g_aba.aba18) THEN LET g_aba.aba18='0' END IF
         IF g_aba.abamksg='N' THEN   #MOD-7B0104
            LET g_aba.aba20='1' 
            LET g_aba.aba19 = 'Y'
            #LET g_sql = " UPDATE ",g_dbs_gl CLIPPED,"aba_file",
#No.TQC-B70021 --begin 
            CALL s_chktic (g_nmz.nmz02b,gl_no) RETURNING l_success  
            IF NOT l_success THEN  
               LET g_aba.aba20 ='0' 
               LET g_aba.aba19 ='N' 
            END IF   
#No.TQC-B70021 --end
            LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                        "    SET abamksg = ? ,",
                               " abasign = ? ,", 
                               " aba18   = ? ,",
                               " aba19   = ? ,",
                               " aba20   = ? ,",
                               " aba37   = ?  ",    #No.TQC-7B0091
                         " WHERE aba01 = ? AND aba00 = ? "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE upd_aba19 FROM g_sql
            EXECUTE upd_aba19 USING g_aba.abamksg,g_aba.abasign,
                                    g_aba.aba18  ,g_aba.aba19,
                                    g_aba.aba20  ,
                                    g_user,        #No.TQC-7B0091
                                    gl_no        ,g_nmz.nmz02b
            IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
               LET g_showmsg=gl_no,"/",g_nmz.nmz02b
               CALL s_errmsg('aba01,aba00',g_showmsg,'upd aba19',STATUS,1)
               LET g_success='N'
            END IF
         END IF   #MOD-770101
      END IF
END IF     
       #No.FUN-CB0096 ---start--- Add
        LET l_time = TIME
        LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
        CALL s_log_data('I','113',g_id,'2',l_time,gl_no,l1_order)
        IF g_aba.abamksg = 'N' THEN
           LET l_time = TIME
           LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
           CALL s_log_data('I','107',g_id,'2',l_time,gl_no,l1_order)
        END IF
       #No.FUN-CB0096 ---end  --- Add
      LET gl_no[g_no_sp,g_no_ep]=''    #MOD-6B0017
END REPORT
   
FUNCTION p400_upglno(p_no,p_type,p_glno,p_date,p_npp011)
 DEFINE p_no     LIKE npq_file.npq01
 DEFINE p_glno   LIKE nme_file.nme12
 DEFINE p_date   LIKE nmi_file.nmi02
 DEFINE p_npp011 LIKE npp_file.npp011
 DEFINE p_type   LIKE type_file.num5     #No.FUN-680107 SMALLINT 
 DEFINE l_npn02  LIKE npn_file.npn02
 DEFINE l_npn03  LIKE npn_file.npn03
 DEFINE l_npm03  LIKE npm_file.npm03
 DEFINE l_npm07  LIKE npm_file.npm07
 DEFINE l_npl03  LIKE npl_file.npl03
 DEFINE l_npo03  LIKE npo_file.npo03
 DEFINE l_npo07  LIKE npo_file.npo07
 
     CASE 
       WHEN  p_type = 1   #N/P
         #FUN-DA0047--add--str--
         IF p_npp011 =10 THEN   #應付票據anmt100
            UPDATE nmf_file SET nmf11 = gl_no, nmf13 = gl_date
             WHERE nmf01 = p_no AND nmf02 = p_date
            IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
               LET g_showmsg=p_no,"/",p_date
               CALL s_errmsg('nmf01,nmf02',g_showmsg,'upd nmf_file',STATUS,1)
               LET g_success = 'N'
            END IF
         END IF
         IF p_npp011 !=10 THEN
         #FUN-DA0047--add--end
            DECLARE npm_curs CURSOR FOR
             SELECT npm03,npm07 FROM npm_file WHERE npm01 = p_no 
            FOREACH npm_curs INTO l_npm03,l_npm07
               IF STATUS THEN
                  CALL s_errmsg('npm01',p_no,'foreach:',STATUS,1) 
                  LET g_success = 'N'    
                  EXIT FOREACH
               END IF
               IF l_npm07 = '1' THEN
                  UPDATE nmd_file SET nmd27 = gl_no
                   WHERE nmd01 = l_npm03 AND (nmd27 IS NULL OR nmd27 = '')
                  IF STATUS THEN
                     CALL s_errmsg('nmd01',l_npm03,'upd nmd',STATUS,1) 
                     LET g_success = 'N'
                     EXIT FOREACH
                  END IF
               END IF
               SELECT npl03 INTO l_npl03 FROM npl_file
                WHERE npl01= p_no
               IF l_npl03 = '8' OR (l_npl03='7' AND l_npm07='8') OR
                  (l_npl03='9' AND l_npm07='8') THEN
                  IF l_npl03='8' THEN
                     UPDATE nme_file SET nme10 = gl_no,
                                         nme16 = gl_date
                                  #WHERE nme12 = l_npm03       #參考單號 #MOD-B50085 mark
                                   WHERE nme12 = p_no          #參考單號 #MOD-B50085
                                     AND nme03 IN (Select nmc01 from nmc_file where nmc03='2')
                  ELSE
                     UPDATE nme_file SET nme10 = gl_no,
                                         nme16 = gl_date
                                  #WHERE nme12 = l_npm03       #參考單號 #MOD-B50085 mark
                                   WHERE nme12 = p_no          #參考單號 #MOD-B50085
                                     AND nme03 IN (Select nmc01 from nmc_file where nmc03='1')
                  END IF
                  IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
                   #CALL s_errmsg('nme12',l_npm03,'upd nme_file',STATUS,1) #MOD-B50085 mark 
                    CALL s_errmsg('nme12',p_no,'upd nme_file',STATUS,1)    #MOD-B50085 
                       LET g_success = 'N' EXIT FOREACH 
                  END IF 
               END IF
               IF l_npl03 MATCHES '[56789]' THEN
                  UPDATE nmf_file SET nmf11 = gl_no,
                                      nmf13 = gl_date
                                WHERE nmf01 = l_npm03       #參考單號
                                  AND nmf02 = p_date 
                  IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
                    LET g_showmsg=l_npm03,"/",p_date 
                    CALL s_errmsg('nmf01,nmf02',g_showmsg,'upd nmf_file',STATUS,1) 
                    LET g_success = 'N' EXIT FOREACH 
                  END IF 
               END IF
           END FOREACH 
         END IF #FUN-DA0047
       WHEN  p_type = 2   #應收票據
        IF p_npp011 =1 THEN   #收票anmt200
           UPDATE nmi_file SET nmi10 = gl_no, nmi11 = gl_date
            WHERE nmi01 = p_no AND nmi02 = p_date
           IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
              LET g_showmsg=p_no,"/",p_date 
              CALL s_errmsg('nmi01,nmi02',g_showmsg,'upd nmi_file',STATUS,1) 
              LET g_success = 'N' 
           END IF
        END IF
        IF p_npp011 !=1 THEN   #收票anmt200
            DECLARE npo_curs CURSOR FOR
             SELECT npo03,npo07 FROM npo_file WHERE npo01 = p_no 
            FOREACH npo_curs INTO l_npo03,l_npo07 
               IF STATUS THEN
                  CALL s_errmsg('npo01',p_no,'foreach:',STATUS,1) 
                  LET g_success = 'N'   
                  EXIT FOREACH
               END IF
               SELECT npn03,npn02 INTO l_npn03,l_npn02 FROM npn_file
                WHERE npn01= p_no
               #依異動別來 update
               IF l_npn03 = '8' THEN  #兌現
                  UPDATE nme_file SET nme10 = gl_no,
                                      nme16 = gl_date
                   #WHERE nme12 = l_npo03 AND nme03 = g_nmz.nmz33   #MOD-B40057 mark
                    WHERE nme12 = p_no AND nme03 = g_nmz.nmz33      #MOD-B40057
                  IF STATUS OR SQLCA.sqlerrd[3]=0 THEN
                     LET g_showmsg=p_no,"/",g_nmz.nmz33   #MOD-B40057 mod l_npn03->p_no
                     CALL s_errmsg('nme12,nme03',g_showmsg,'upd nme(1)',SQLCA.sqlcode,1)
                     LET g_success='N' EXIT FOREACH
                  END IF
               END IF
               IF l_npn03 = '7' AND l_npo07 ='8' THEN #兌現後退票
                  UPDATE nme_file SET nme10 = gl_no,
                                      nme16 = gl_date
                  #WHERE nme12 = l_npo03 AND nme03 = g_nmz.nmz34   #MOD-B40057 mark
                   WHERE nme12 = p_no AND nme03 = g_nmz.nmz34      #MOD-B40057
                  IF STATUS OR SQLCA.sqlerrd[3]=0 THEN
                     LET g_showmsg=gl_no,"/",gl_date
                     CALL s_errmsg('nme10,nme16',g_showmsg,'upd nme(2)',SQLCA.sqlcode,1)
                     LET g_success='N' EXIT FOREACH
                  END IF
                END IF
               UPDATE nmi_file SET nmi10 = gl_no,
                                   nmi11 = gl_date
                             WHERE nmi01 = l_npo03     
                               AND nmi02 = p_date
               IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
                 LET g_showmsg=l_npo03,"/",p_date
                 CALL s_errmsg('nmi01,nmi02',g_showmsg,'upd nmi_file',SQLCA.sqlcode,1)
                    LET g_success = 'N' EXIT FOREACH 
               END IF 
           END FOREACH 
         END IF
       WHEN  p_type = 3 OR p_type = 16 OR p_type = 17 OR p_type = 19 OR p_type = 20   #No.FUN-590111
               UPDATE nme_file SET nme10 = gl_no,
                                   nme16 = gl_date
                             WHERE nme12 = p_no         
               IF STATUS THEN
                 CALL s_errmsg('nme12',p_no,'upd nme_file',SQLCA.sqlcode,1)
                    LET g_success = 'N' 
               END IF 
       OTHERWISE EXIT CASE 
       END CASE 
END FUNCTION

#------------------------No.MOD-B70277---------------------------------start
FUNCTION p400_no_ep()
  DEFINE l_aza41        LIKE aza_file.aza41
  DEFINE l_aza42        LIKE aza_file.aza42
  DEFINE l_aza100       LIKE aza_file.aza100
  DEFINE l_no_ep        LIKE type_file.num5
  DEFINE l_doc_len      LIKE type_file.num5

  SELECT aza41,aza42,aza100 INTO l_aza41,l_aza42,l_aza100 FROM aza_file
  CASE l_aza41
     WHEN "1"   LET l_doc_len = 3
     WHEN "2"   LET l_doc_len = 4
     WHEN "3"   LET l_doc_len = 5
  END CASE
  CASE l_aza42
     WHEN "1"   LET l_no_ep = l_doc_len + 1 + l_aza100 + 8
     WHEN "2"   LET l_no_ep = l_doc_len + 1 + l_aza100 + 9
     WHEN "3"   LET l_no_ep = l_doc_len + 1 + l_aza100 + 10
  END CASE
  RETURN l_no_ep
END FUNCTION
#------------------------No.MOD-B70277-----------------------------------end
 
FUNCTION p400_create_tmp()
 DROP TABLE p400_tmp;
 SELECT chr30 order1, npp_file.*,npq_file.*,
        chr1000 remark    #MOD-770020
   FROM npp_file,npq_file,type_file
  WHERE npp01 = npq01 AND npp01 = '@@@@'
    AND 1=0
   INTO TEMP p400_tmp
 IF SQLCA.SQLCODE THEN
    LET g_success='N'
    CALL cl_err3("ins","p400_tmp","","",SQLCA.sqlcode,"","crezte p400_tmp",0) #No.FUN-660148
 END IF
 DELETE FROM p400_tmp WHERE 1=1
END FUNCTION
 
REPORT anmp400_1_rep(l2_order,l2_npp,l2_npq,l2_remark)
   DEFINE l2_order       LIKE npp_file.npp01     #MOD-710053
   DEFINE l2_npk	 RECORD LIKE npk_file.*
   DEFINE l2_nnm01       LIKE nnm_file.nnm01     #No:9028
   DEFINE l2_nnm02       LIKE nnm_file.nnm02     #No.MOD-560179
   DEFINE l2_nnm03       LIKE nnm_file.nnm03     #No.MOD-560179
   DEFINE l2_npp	 RECORD LIKE npp_file.*
   DEFINE l2_npq	 RECORD LIKE npq_file.*
   DEFINE l2_seq1        LIKE type_file.num5     #No.FUN-680107 SMALLINT # 傳票項次
   DEFINE l2_nmg01       LIKE nmg_file.nmg01
   DEFINE l2_credit,l2_debit,l2_amt,l2_amtf LIKE type_file.num20_6 #No.FUN-680107 DECIMAL(20,6) #No.FUN-4C0010
   DEFINE l2_remark      LIKE type_file.chr1000  #No.FUN-680107 VARCHAR(150)  #No.7319
   DEFINE li_result      LIKE type_file.num5     #No.FUN-680107 SMALLINT  #No.FUN-560190
   DEFINE l2_missingno   LIKE aba_file.aba01     #No.FUN-570090  --add
   DEFINE l2_flag1       LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1) #No.FUN-570090  --add 
   DEFINE l_legal        LIKE aba_file.abalegal  #FUN-980005  
   DEFINE l_npp08        LIKE npp_file.npp08     #MOD-A80017 Add
   DEFINE l_success      LIKE type_file.num5    #No.TQC-B70021
   DEFINE l_date         LIKE type_file.dat
   DEFINE l_time         LIKE type_file.chr10
   DEFINE l_user         LIKE type_file.chr10
   DEFINE l_tc_agl03     LIKE tc_agl_file.tc_agl03
   DEFINE l_count        LIKE type_file.num5
    
   OUTPUT 
      TOP MARGIN g_top_margin 
      LEFT MARGIN g_left_margin 
      BOTTOM MARGIN g_bottom_margin 
      PAGE LENGTH g_page_line
 
   ORDER EXTERNAL BY l2_order,l2_npq.npq06,l2_npq.npq03,l2_npq.npq05,
                     l2_npq.npq24,l2_npq.npq25,l2_npq.npq08,
                     l2_remark,l2_npq.npq01
   FORMAT
   #--------- Insert aba_file ---------------------------------------------
 
   BEFORE GROUP OF l2_order
      IF cl_null(gl_date) THEN LET gl_date = l2_npp.npp02 END IF   #CHI-880014 add
      # 得出總帳 database name                                                                                                         
      LET g_plant_new= p_plant  # 工廠編號                                                                                            
      CALL s_getdbs()                                                                                                                 
      LET g_dbs_gl=g_dbs_new CLIPPED                                                                                                  
      #缺號使用               
      LET l2_flag1='N'         
      LET l2_missingno = NULL 
      LET g_j=g_j+1         
      SELECT tc_tmp02 INTO l2_missingno    
        FROM agl_tmp_file                 
       WHERE tc_tmp01=g_j AND tc_tmp00 = 'Y'     
         AND tc_tmp03=p_bookno2
      IF NOT cl_null(l2_missingno) THEN          
         LET l2_flag1='Y'                       
         LET gl_no2=l2_missingno                
         DELETE FROM agl_tmp_file WHERE tc_tmp02 = gl_no2 AND tc_tmp03 = p_bookno2
      END IF                                               
      #重新抓取g_yy,g_mm
      IF g_aza.aza63 = 'Y' THEN
         LET g_sql = "SELECT aznn02,aznn04 ",
                     #"  FROM ",g_dbs_gl CLIPPED,"aznn_file ",
                     "  FROM ",cl_get_target_table(g_plant_new,'aznn_file'), #FUN-A50102
                     " WHERE aznn01 = '",gl_date,"' ",
                     "   AND aznn00 = '",p_bookno2,"' "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
         PREPARE p400_aznn_pre2 FROM g_sql
         DECLARE p400_aznn_cs2 CURSOR FOR p400_aznn_pre2
         OPEN p400_aznn_cs2
         FETCH p400_aznn_cs2 INTO g_yy,g_mm
      ELSE
         SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file
          WHERE azn01 = gl_date
      END IF
                                                       
      #缺號使用完，再在流水號最大的編號上增加            
      IF l2_flag1='N' THEN                               
        #No.FUN-CB0096 ---start--- Add   #yinhy131010 mark
         #LET t_no = Null
         #CALL s_log_check(l2_order) RETURNING t_no
         #IF NOT cl_null(t_no) THEN
         #   LET gl_no2 = t_no
         #   LET li_result = '1'
         #ELSE
        #No.FUN-CB0096 ---start--- Add
         CALL s_auto_assign_no("agl",gl_no2,gl_date,"","","",p_plant,"",g_nmz.nmz02c)  #FUN-980094
            RETURNING li_result,gl_no2                                                   
         #END IF    #No.FUN-CB0096   Add
         PRINT "Get max TR-no:",gl_no2," Return code(li_result):",li_result                                                                    
         IF li_result = 0 THEN LET g_success = 'N' END IF      
         PRINT "Insert aba:",g_nmz.nmz02c,' ',gl_no2,' From:',l2_order
      END IF  #No.FUN-570090  -add     
      #LET g_sql="INSERT INTO ",g_dbs_gl CLIPPED,"aba_file",
      LET g_sql="INSERT INTO ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                       "(aba00,aba01,aba02,aba03,aba04,aba05,",
                       " aba06,aba07, ",
                       " aba08,aba09,aba12,aba19,aba20,",
                       " abamksg,abapost,",
                       " abaprno,abaacti,abauser,abagrup,abadate,",
                       " abasign,abadays,abaprit,abasmax,abasseq,aba24,aba11,",     #FUN-840211 add aba11  #MOD-640363  #No.TQC-9B0198
                       " abalegal,abaoriu,abaorig,aba21,aba35) ",   #FUN-980005  #TAC-A10060  add abaoriu,abaorig FUN-A10006 add aba21 #TQC-A80138 Add aba35
                  " VALUES(?,?,?,?,?,?, ?,?, ",
                  "        ?,?,?,?,?, ?,?,?,?,?,?,?, ?,?,?,?,?,?,?,",  #FUN-840211 add ?     #MOD-640363
                  "        ?,?,?,?,?)"     #TAC-A10060  add ?,?  FUN-A10006 add ? #TQC-A80138 Add ?
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p400_1_p42 FROM g_sql
      ## ----
      #自動賦予簽核等級
      LET g_aba.aba01=gl_no2
      LET g_aba01t = s_get_doc_no(gl_no2)
      SELECT aac08,aacatsg,aacdays,aacprit,aacsign  #簽核處理 (Y/N)
        INTO g_aba.abamksg,g_aac.aacatsg,g_aba.abadays,
             g_aba.abaprit,g_aba.abasign
        FROM aac_file WHERE aac01 = g_aba01t
      IF g_aba.abamksg MATCHES '[Yy]' THEN
         IF g_aac.aacatsg MATCHES '[Yy]' THEN  #自動付予
            CALL s_sign(g_aba.aba01,4,'aba01','aba_file')
               RETURNING g_aba.abasign
         END IF
         SELECT COUNT(*) INTO g_aba.abasmax
           FROM azc_file
          WHERE azc01=g_aba.abasign
      END IF
      ## ----
      #----------------------  for ora修改 ------------------------------------
      #CHI-A40016 mod --start--
      #LET g_system = 'NM'
      IF g_nmz.nmz52 = 'Y' AND l2_npp.npp00 = '18' THEN
         LET g_system = 'AC'
      ELSE
         LET g_system = 'NM'
      END IF
      #CHI-A40016 mod --end--
      LET g_zero   = 0
      LET g_zero1  = '0'
      LET g_N      = 'N'
      LET g_Y      = 'Y'
      CALL s_getlegal(p_plant) RETURNING l_legal  
      LET g_aba.abalegal = l_legal 
 
      LET g_aba.abaoriu = g_user  # TQC-A10060   add
      LET g_aba.abaorig = g_grup  # TQC-A10060   add
      LET l2_order = l2_order CLIPPED
      IF cl_null(l2_order) THEN LET l2_order = ' ' END IF
 
      EXECUTE p400_1_p42 USING g_nmz.nmz02c,gl_no2,gl_date,g_yy,g_mm,g_today,
                               g_system,l2_order,g_zero,g_zero,g_N,g_N,g_zero,
                               g_aba.abamksg,g_N,
                               g_zero,g_Y,g_user,g_grup,g_today,
                               g_aba.abasign,g_aba.abadays,g_aba.abaprit,
                               g_aba.abasmax,g_zero1,g_user,g_aba.aba11,#No.FUN-840211 add aba11           #MOD-640363
                               g_aba.abalegal,g_aba.abaoriu,g_aba.abaorig,l2_npp.npp08   #TQC-A10060  #FUN-980005  FUN-A10006 add npp08
                               ,g_N                                     #TQC-A80138 Add
      IF SQLCA.sqlcode THEN
         CALL cl_err('ins aba:',SQLCA.sqlcode,1)
         LET g_success = 'N'
      END IF
      #str----add by jixf 20140924
     IF g_success='Y' THEN 
        LET l_time=TIME 
        LET l_date=g_today
        LET l_user=g_user
        LET l_count=0
        SELECT COUNT(*) INTO l_count FROM tc_agl_file WHERE tc_agl00=g_nmz.nmz02c AND tc_agl01=gl_no2 AND tc_agl02='INS'
        IF l_count=0 THEN
           INSERT INTO tc_agl_file VALUES (g_nmz.nmz02c,gl_no2,'INS','N','','','','','',0,0)
        END IF 
     END IF 
     #end----add by jixf 20140924
      DELETE FROM tmn_file WHERE tmn01 = p_plant AND tmn02 = gl_no2 AND tmn06 = p_bookno2 #No.FUN-570090 --add  
      IF gl_no2_b IS NULL THEN LET gl_no2_b = gl_no2 END IF
      LET gl_no2_e = gl_no2                                   #No.FUN-680034
      LET l2_credit = 0 LET l2_debit  = 0
      LET l2_seq1 = 0
 
   #------------------ Update gl-no To original file --------------------------
   AFTER GROUP OF l2_npq.npq01   #CHI-880014 add
      IF cl_null(gl_date) THEN LET gl_date = l2_npp.npp02 END IF   #CHI-880014 add
      UPDATE npp_file SET npp03 = gl_date,nppglno=gl_no2,
             npp06=p_plant,npp07= g_nmz.nmz02c
       WHERE npp01 = l2_npp.npp01
         AND npp011= l2_npp.npp011
         AND npp00 = l2_npp.npp00
         AND nppsys= l2_npp.nppsys
         AND npptype = '1'       #No.FUN-680034
      IF SQLCA.sqlcode THEN
         CALL cl_err3("upd","npp_file",l2_npp.npp01,l2_npp.npp011,SQLCA.sqlcode,"","upd npp03/glno:",1) #No.FUN-660148
         LET g_success = 'N'
      END IF
 
   #------------------ Insert into abb_file ---------------------------------
   AFTER GROUP OF l2_remark   
      LET l2_seq1 = l2_seq1 + 1
      DISPLAY "Seq:",l2_seq1 AT 2,1
      #LET g_sql = "INSERT INTO ",g_dbs_gl CLIPPED,"abb_file",
      LET g_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'abb_file'), #FUN-A50102
                        "(abb00,abb01,abb02,abb03,abb04,",
                        " abb05,abb06,abb07f,abb07, ",
                        " abb08,abb11,abb12,abb13,abb14, ",                   #No.FUN-810069   
                        " abb24,abb25,",
                        "abb31,abb32,abb33,abb34,abb35,abb36,abb37",
                        ",abblegal",  #FUN-980005 
                        " )",
                 " VALUES(?,?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?",                #No.FUN-810069   
                 "       ,?,?,?,?,?, ?,?,?)" #FUN-5C0015 BY GILL
      LET l2_amtf= GROUP SUM(l2_npq.npq07f)
      LET l2_amt = GROUP SUM(l2_npq.npq07)
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      CALL s_getlegal(p_plant) RETURNING l_legal  
      PREPARE p400_1_p52 FROM g_sql
      EXECUTE p400_1_p52 USING 
                 g_nmz.nmz02c,gl_no2,l2_seq1,l2_npq.npq03,l2_npq.npq04,
                 l2_npq.npq05,l2_npq.npq06,l2_amtf,l2_amt,
                 l2_npq.npq08,l2_npq.npq11,l2_npq.npq12,l2_npq.npq13,
                 l2_npq.npq14,l2_npq.npq24,l2_npq.npq25,         #No.FUN-810069   
                 l2_npq.npq31,l2_npq.npq32,l2_npq.npq33,l2_npq.npq34,
                 l2_npq.npq35,l2_npq.npq36,l2_npq.npq37
                ,l_legal    #FUN-980005 
      IF SQLCA.sqlcode THEN
         CALL cl_err('ins abb:',SQLCA.sqlcode,1) LET g_success = 'N'
      END IF
      IF l2_npq.npq06 = '1' THEN
         LET l2_debit  = l2_debit  + l2_amt
      ELSE 
         LET l2_credit = l2_credit + l2_amt
      END IF
 
   #------------------ Update aba_file's debit & credit amount --------------
   AFTER GROUP OF l2_order
      LET l_npp08 = GROUP SUM(l2_npp.npp08)                           #MOD-A80017 Add
      PRINT "update debit&credit:",l2_debit,' ',l2_credit," For:",gl_no2
      #LET g_sql = "UPDATE ",g_dbs_gl CLIPPED,"aba_file SET (aba08,aba09) = (?,?)",
      LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
#                 " SET (aba08,aba09) = (?,?)",                    #MOD-A80017 Mark
                  " SET aba08=?,aba09 =? ",                        #MOD-A80017 Add  
                  "    ,aba21=? ",                                 #MOD-A80017 Add                  
                  " WHERE aba01 = ? AND aba00 = ?"
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE p400_1_p62 FROM g_sql
      EXECUTE p400_1_p62 USING l2_debit,l2_credit,l_npp08,gl_no2,g_nmz.nmz02c  #MOD-A80017 Add l_npp08
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_err('upd aba08/09:',SQLCA.sqlcode,1) LET g_success = 'N'
      END IF
      PRINT
      CALL s_flows('2',g_nmz.nmz02c,gl_no2,gl_date,g_N,'',TRUE)   #No.TQC-B70021

      #no.3432 自動確認
      IF g_aaz85 = 'Y' THEN 
      #若有立沖帳管理就不做自動確認
      #LET g_sql = "SELECT COUNT(*) FROM ",g_dbs_gl CLIPPED," abb_file,aag_file",
      LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'abb_file')," ,aag_file", #FUN-A50102      
                  " WHERE abb01 = '",gl_no2,"'",
                  "   AND abb00 = '",g_nmz.nmz02c,"'",
                  "   AND abb03 = aag01  ",
                  "   AND aag20 = 'Y' ",
                  "   AND abb00 = aag00  "       #No.FUN-740049 
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE count_pre2 FROM g_sql
      DECLARE count_cs2 CURSOR FOR count_pre2
      OPEN count_cs2 
      FETCH count_cs2 INTO g_cnt
      CLOSE count_cs2
      IF g_cnt = 0 THEN
         IF cl_null(g_aba.aba18) THEN LET g_aba.aba18='0' END IF
         IF g_aba.abamksg='N' THEN   #MOD-7B0104
            LET g_aba.aba20='1' 
            LET g_aba.aba19 = 'Y'
            #LET g_sql = " UPDATE ",g_dbs_gl CLIPPED,"aba_file",
#No.TQC-B70021 --begin 
            CALL s_chktic (g_nmz.nmz02c,gl_no2) RETURNING l_success  
            IF NOT l_success THEN  
               LET g_aba.aba20 ='0' 
               LET g_aba.aba19 ='N' 
            END IF   
#No.TQC-B70021 --end
            LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                        "    SET abamksg = ? ,",
                               " abasign = ? ,", 
                               " aba18   = ? ,",
                               " aba19   = ? ,",
                               " aba20   = ? ,",
                               " aba37   = ?  ",    #No.TQC-7B0091
                         " WHERE aba01 = ? AND aba00 = ? "
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE upd_aba192 FROM g_sql
            EXECUTE upd_aba192 USING g_aba.abamksg,g_aba.abasign,
                                     g_aba.aba18  ,g_aba.aba19,
                                     g_aba.aba20  ,
                                     g_user,    #No.TQC-7B0091
                                     gl_no2        ,g_nmz.nmz02c
            IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
               CALL cl_err('upd aba19',STATUS,1) LET g_success = 'N'
            END IF
         END IF   #MOD-770101
      END IF
   END IF     
       #No.FUN-CB0096 ---start--- Add
        LET l_time = TIME
        LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
        CALL s_log_data('I','113',g_id,'2',l_time,gl_no2,l2_order)
        IF g_aba.abamksg = 'N' THEN
           LET l_time = TIME
           LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
           CALL s_log_data('I','107',g_id,'2',l_time,gl_no2,l2_order)
        END IF
       #No.FUN-CB0096 ---end  --- Add
   LET gl_no2[4,12]=''
END REPORT
 
FUNCTION chk_date()  #傳票日期抓npp02時要判斷的日期
  DEFINE l_npp     RECORD LIKE npp_file.*
  DEFINE l_npq     RECORD LIKE npq_file.*
  DEFINE l_aaa07   LIKE aaa_file.aaa07
 
  LET g_sql="SELECT npp_file.*,npq_file.* ",
            "  FROM npp_file,npq_file,nmy_file",
            " WHERE nppsys= 'NM'  AND nppglno IS NULL",
            "   AND npp01 = npq01 AND npp011=npq011",
            "   AND npp00 = npq00 ",
            "   AND ",g_wc CLIPPED,
            "   AND npp01 like ltrim(rtrim(nmyslip)) || '-%' AND nmydmy3='Y'", #MOD-9C0143
            "   AND nppsys=npqsys "
   PREPARE p400_1_p10 FROM g_sql
   IF STATUS THEN
      CALL cl_err('p400_1_p10',STATUS,1)
      CALL p400_tmn_del()
     #No.FUN-CB0096 ---start--- add
      LET l_time = TIME
      LET l_time = l_time[1,2],l_time[4,5],l_time[7,8]
      CALL s_log_data('U','100',g_id,'1',l_time,'','')
     #No.FUN-CB0096 ---end  --- add
      CALL cl_used(g_prog,g_time,2) RETURNING g_time      #FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE p400_1_c10 CURSOR WITH HOLD FOR p400_1_p10
   FOREACH p400_1_c10 INTO l_npp.*,l_npq.*
      IF STATUS THEN
         CALL cl_err('foreach:',STATUS,1) LET g_success = 'N' EXIT FOREACH
      END IF
      SELECT aaa07 INTO l_aaa07 FROM aaa_file WHERE aaa01=p_bookno
      IF l_npp.npp02 <= l_aaa07 THEN
         CALL cl_err(l_npp.npp01,'axm-164',0)
         LET g_success = 'N'
      END IF
      SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file WHERE azn01=l_npp.npp02
      IF STATUS THEN
         CALL cl_err3("sel","azn_file",l_npp.npp02,"",SQLCA.sqlcode,"","read azn",0)
         LET g_success = 'N'
      END IF
   END FOREACH
END FUNCTION
 
FUNCTION p400_tmn_del()
   DEFINE l_tmn02 LIKE tmn_file.tmn02
   DEFINE l_tmn06 LIKE tmn_file.tmn06
 
   FOREACH tmn_del INTO l_tmn02,l_tmn06
      DELETE FROM tmn_file
      WHERE tmn01 = p_plant
        AND tmn02 = l_tmn02
        AND tmn06 = l_tmn06
   END FOREACH
END FUNCTION
#No.FUN-9C0073 -----------------By chenls 10/01/18
#CHI-AC0010
