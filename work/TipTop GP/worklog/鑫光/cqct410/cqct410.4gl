# Prog. Version..: '5.30.18-15.05.12(00010)'     #
# Pattern name...: cqct410.4gl
# Descriptions...: 品質檢驗紀錄維護作業
# Date & Author..: No.0000685690_06_M025 16/05/20 By TSD.james
# Modify.........: No.0000685690_06_M025 16/05/31 By TSD.pplppl
#                  增加呼叫q_mo_tt的邏輯
# Modify.........: No.0000685690_06_M025 16/06/06 By TSD.Lynn
#                  優化三色單號，未符合單別長度時，先提示訊息
# Modify.........: No.0000685690_06_M025 16/06/16 By TSD.Lynn
#                  1.修正確認時未預設核准人員
#                  2.修正 確認後仍修改單據的錯誤
#                  3.修正刪除單身異常
# Modify.........: No.0000685690_06_M025 16/06/20 By TSD.james 
#                  1.增加action,品檢報告列印(report_output)
#                  2.作業編號改為必要輸入,增加說明
#                  3.單身硬度分布實測值，檢測項目要調整為直接手動輸入,隱藏檢測項目說明                  
# Modify.........: No.0000685690_06_M025 16/06/27 By TSD.Lynn
#                  1.單身"表面實測硬度"、"心部硬度" 同"硬度分布實測"，改為手key，不帶理由碼
# Modify.........: No.0000685690_06_M031 16/07/05 By TSD.james 單頭增加5個欄位,深度性質(tc_qca23),檢測結果(tc_qca24),
#                                                              深度最小值(tc_qca25),深度最大值(tc_qca26),及一個formonly欄位
#                                                              要求規格(tc_crastr_3),增加一個單身(深度性質)
# Modify.........: No.0000685690_06_M025 16/07/07 By TSD.Lynn
#                  1.深度位置 調整為"深度性質說明、深度起、深度訖、深度單位、深度備註"
# Modify.........: No.0000685690_06_M025 16/07/14 By TSD.Lynn
#                  1.新增品檢人員
# Modify.........: No.0000685690_06_M025 16/09/02 By TSD.Lynn
#                  1.查詢時，開放部分QBE可以查詢
# Modify.........: No.0000685690_06_M045 16/11/14 By TSD.nick
#                  1.作業編號(tc_qca18)開窗時依據料號(sfb05)串查cqci100做篩選資料
#                  2.判定(tc_qca07)增加X.未判定
#                  3.間距頁籤依據cqci100帶資料#1~#20(tc_imc11~tc_imc30)
#                  4.產品類別(ima131)：依據料件編號帶出其產品類別，並帶出產品類別名稱
#                  5.新品(inbud02=Y)欄位有打勾，則呈現出新品的圖樣
# Modify.........: No.0000685690_06_M025 16/11/28 By TSD.Lynn 將單身變數於新增時清空
#                  2.審核人員，於新增時可以輸入，確認時不覆蓋
# Modify.........: No.0000685690_06_M045 16/11/29 By TSD.Lynn 產品分類是帶出 名稱
# Modify.........: No.0000685690_06_M025 16/12/02 By TSD.Lynn 三色單若為委外工單，則不需要走WIP，直接從工單取值
# Modify.........:                       16/12/06 By DSC.shihyun 修正 No.0000685690_06_M045問題:複製功能失效、跳錯誤訊息
# Modify.........: No.0000685690_06_M025 16/09/07 By TSD.Lynn
#                  1.調整 其他號碼邏輯
# Modify.........: No.0000685690_06_M025 16/10/14 By TSD.Lynn
#                  1.處理複製 key重複問題
#                  2.調整單身l_ac錯開,刪除後不應該做deleteElement
# Modify.........: No.0000685690_06_M025 16/12/07 By TSD.Lynn 
#                  1.調整複製時，部分欄位須重新預設 確認碼=N/判定=Y/品檢人員=g_user/審核人員=NULL
#                  2.產品編號需可查詢
# Modify.........: No.0000685690_06_M025 16/12/08 By TSD.Lynn 
#                  1.新增簽核圖檔
# Modify.........: No.0000685690_06_M049 16/12/16 By TSD.Jay 
#                  1.新增欄位版本[tc_qca28],由作業編號開窗帶出,不可維護但亦不可為空
#                  2.調整呼叫圖檔SUB傳遞參數
#                  3.調整執行列印未審核狀態報表時的提示訊息
# Modify.........: No.0000685690_06_M025 17/01/05 By TSD.Lynn 調整複製時，取不到檢測數量問題
# Modify.........: No.170124   BY cjy  要求规格栏位全部更改为实体栏位tc_qca29.30.31.32 
# Modify.........: 添加勾选框“新品”栏位 By ganlh 170718
DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
#M025 160523 By TSD.pplppl----START
GLOBALS
   DEFINE  g_runcard      STRING
   DEFINE  g_runcard_qry  STRING
END GLOBALS
#M025 160523 By TSD.pplppl------END
 
#模組變數(Module Variables)
DEFINE g_tc_qca             RECORD LIKE tc_qca_file.*,   
       g_tc_qca_t           RECORD LIKE tc_qca_file.*, 
       g_tc_qca_o           RECORD LIKE tc_qca_file.*, 
       g_tc_qca_1           RECORD 
          ta_inb03          LIKE inb_file.ta_inb03,
          oea03             LIKE oea_file.oea03,
          oea032            LIKE oea_file.oea032,
          sfb05             LIKE sfb_file.sfb05,
          ima02             LIKE ima_file.ima02,
          ima021            LIKE ima_file.ima021,
          ta_ima01          LIKE ima_file.ta_ima01,
          inb904            LIKE inb_file.inb904,
          inb907            LIKE inb_file.inb907,
          ima31             LIKE ima_file.ima31,
          ima31_1           LIKE ima_file.ima31,
          tc_imc07          LIKE tc_imc_file.tc_imc07,
          tc_imc06          LIKE tc_imc_file.tc_imc06,
          azf03             LIKE azf_file.azf03,
          othernum          STRING,
          azf03_1           LIKE azf_file.azf03,
          #tc_crastr         STRING,   #mod by cjy 20170124
          tc_qca29           LIKE tc_qca_file.tc_qca29,  #mod by cjy 20170124
          azf03_2           LIKE azf_file.azf03,
          #tc_crastr_1       STRING,    #mod by cjy 20170124
          tc_qca30           LIKE tc_qca_file.tc_qca30,  #mod by cjy 20170124
          azf03_3           LIKE azf_file.azf03,
          #tc_crastr_2       STRING,   #mod by cjy 20170124
          tc_qca32           LIKE tc_qca_file.tc_qca32,  #mod by cjy 20170124
          #M031 160705 By TSD.james---(S)
          azf03_9           LIKE azf_file.azf03,
         # tc_crastr_3       STRING,  #mod by cjy 20170124
         tc_qca31          LIKE tc_qca_file.tc_qca31,  #mod by cjy 20170124
          #M031 160705 By TSD.james---(E)
          tc_imc03          LIKE tc_imc_file.tc_imc03,
          tc_imc04          LIKE tc_imc_file.tc_imc04,
          tc_imc05          LIKE tc_imc_file.tc_imc05,
          tc_imc09          LIKE tc_imc_file.tc_imc09
         ,ima131            LIKE ima_file.ima131       #M045 161114 By TSD.nick
         ,oba02             LIKE oba_file.oba02,        #M045 161129 By TSD.Lynn
          inbud02           LIKE inb_file.inbud02       #mod  by ganlh 170718
                            END RECORD,
       g_tc_qca01_t         LIKE tc_qca_file.tc_qca01,
       g_tc_qcb             DYNAMIC ARRAY OF RECORD 
           tc_qcb02         LIKE tc_qcb_file.tc_qcb02,
           tc_qcb03         LIKE tc_qcb_file.tc_qcb03,
           azf03_5          LIKE azf_file.azf03,
           tc_qcb04         LIKE tc_qcb_file.tc_qcb04,
           tc_qcb05         LIKE tc_qcb_file.tc_qcb05,
           tc_qcb06         LIKE tc_qcb_file.tc_qcb06,
           tc_qcb07         LIKE tc_qcb_file.tc_qcb07,
           tc_qcb08         LIKE tc_qcb_file.tc_qcb08,
           tc_qcb09         LIKE tc_qcb_file.tc_qcb09,
           tc_qcb10         LIKE tc_qcb_file.tc_qcb10,
           tc_qcb11         LIKE tc_qcb_file.tc_qcb11,
           tc_qcb12         LIKE tc_qcb_file.tc_qcb12,
           tc_qcb13         LIKE tc_qcb_file.tc_qcb13,
           tc_qcb14         LIKE tc_qcb_file.tc_qcb14,
           tc_qcb15         LIKE tc_qcb_file.tc_qcb15,
           tc_qcb16         LIKE tc_qcb_file.tc_qcb16,
           tc_qcb17         LIKE tc_qcb_file.tc_qcb17,
           tc_qcb18         LIKE tc_qcb_file.tc_qcb18,
           tc_qcb19         LIKE tc_qcb_file.tc_qcb19,
           tc_qcb20         LIKE tc_qcb_file.tc_qcb20,
           tc_qcb21         LIKE tc_qcb_file.tc_qcb21,
           tc_qcb22         LIKE tc_qcb_file.tc_qcb22,
           tc_qcb23         LIKE tc_qcb_file.tc_qcb23
                            END RECORD,
       g_tc_qcb_t           RECORD
           tc_qcb02         LIKE tc_qcb_file.tc_qcb02,
           tc_qcb03         LIKE tc_qcb_file.tc_qcb03,
           azf03_5          LIKE azf_file.azf03,
           tc_qcb04         LIKE tc_qcb_file.tc_qcb04,
           tc_qcb05         LIKE tc_qcb_file.tc_qcb05,
           tc_qcb06         LIKE tc_qcb_file.tc_qcb06,
           tc_qcb07         LIKE tc_qcb_file.tc_qcb07,
           tc_qcb08         LIKE tc_qcb_file.tc_qcb08,
           tc_qcb09         LIKE tc_qcb_file.tc_qcb09,
           tc_qcb10         LIKE tc_qcb_file.tc_qcb10,
           tc_qcb11         LIKE tc_qcb_file.tc_qcb11,
           tc_qcb12         LIKE tc_qcb_file.tc_qcb12,
           tc_qcb13         LIKE tc_qcb_file.tc_qcb13,
           tc_qcb14         LIKE tc_qcb_file.tc_qcb14,
           tc_qcb15         LIKE tc_qcb_file.tc_qcb15,
           tc_qcb16         LIKE tc_qcb_file.tc_qcb16,
           tc_qcb17         LIKE tc_qcb_file.tc_qcb17,
           tc_qcb18         LIKE tc_qcb_file.tc_qcb18,
           tc_qcb19         LIKE tc_qcb_file.tc_qcb19,
           tc_qcb20         LIKE tc_qcb_file.tc_qcb20,
           tc_qcb21         LIKE tc_qcb_file.tc_qcb21,    
           tc_qcb22         LIKE tc_qcb_file.tc_qcb22,    
           tc_qcb23         LIKE tc_qcb_file.tc_qcb23
                            END RECORD,

       g_tc_qcc             DYNAMIC ARRAY OF RECORD 
           tc_qcc02         LIKE tc_qcc_file.tc_qcc02,
           tc_qcc03         LIKE tc_qcc_file.tc_qcc03,
           azf03_6          LIKE azf_file.azf03,
           tc_qcc04         LIKE tc_qcc_file.tc_qcc04,
           tc_qcc05         LIKE tc_qcc_file.tc_qcc05,
           tc_qcc06         LIKE tc_qcc_file.tc_qcc06,
           tc_qcc07         LIKE tc_qcc_file.tc_qcc07,
           tc_qcc08         LIKE tc_qcc_file.tc_qcc08,
           tc_qcc09         LIKE tc_qcc_file.tc_qcc09,
           tc_qcc10         LIKE tc_qcc_file.tc_qcc10,
           tc_qcc11         LIKE tc_qcc_file.tc_qcc11,
           tc_qcc12         LIKE tc_qcc_file.tc_qcc12,
           tc_qcc13         LIKE tc_qcc_file.tc_qcc13,
           tc_qcc14         LIKE tc_qcc_file.tc_qcc14,
           tc_qcc15         LIKE tc_qcc_file.tc_qcc15,
           tc_qcc16         LIKE tc_qcc_file.tc_qcc16,
           tc_qcc17         LIKE tc_qcc_file.tc_qcc17,
           tc_qcc18         LIKE tc_qcc_file.tc_qcc18,
           tc_qcc19         LIKE tc_qcc_file.tc_qcc19,
           tc_qcc20         LIKE tc_qcc_file.tc_qcc20,
           tc_qcc21         LIKE tc_qcc_file.tc_qcc21,
           tc_qcc22         LIKE tc_qcc_file.tc_qcc22,
           tc_qcc23         LIKE tc_qcc_file.tc_qcc23
                            END RECORD,
       g_tc_qcc_t           RECORD
           tc_qcc02         LIKE tc_qcc_file.tc_qcc02,
           tc_qcc03         LIKE tc_qcc_file.tc_qcc03,
           azf03_6          LIKE azf_file.azf03,
           tc_qcc04         LIKE tc_qcc_file.tc_qcc04,
           tc_qcc05         LIKE tc_qcc_file.tc_qcc05,
           tc_qcc06         LIKE tc_qcc_file.tc_qcc06,
           tc_qcc07         LIKE tc_qcc_file.tc_qcc07,
           tc_qcc08         LIKE tc_qcc_file.tc_qcc08,
           tc_qcc09         LIKE tc_qcc_file.tc_qcc09,
           tc_qcc10         LIKE tc_qcc_file.tc_qcc10,
           tc_qcc11         LIKE tc_qcc_file.tc_qcc11,
           tc_qcc12         LIKE tc_qcc_file.tc_qcc12,
           tc_qcc13         LIKE tc_qcc_file.tc_qcc13,
           tc_qcc14         LIKE tc_qcc_file.tc_qcc14,
           tc_qcc15         LIKE tc_qcc_file.tc_qcc15,
           tc_qcc16         LIKE tc_qcc_file.tc_qcc16,
           tc_qcc17         LIKE tc_qcc_file.tc_qcc17,
           tc_qcc18         LIKE tc_qcc_file.tc_qcc18,
           tc_qcc19         LIKE tc_qcc_file.tc_qcc19,
           tc_qcc20         LIKE tc_qcc_file.tc_qcc20,
           tc_qcc21         LIKE tc_qcc_file.tc_qcc21,    
           tc_qcc22         LIKE tc_qcc_file.tc_qcc22,    
           tc_qcc23         LIKE tc_qcc_file.tc_qcc23
                            END RECORD,

       g_tc_qcd             DYNAMIC ARRAY OF RECORD 
           tc_qcd02         LIKE tc_qcd_file.tc_qcd02,
           tc_qcd03         LIKE tc_qcd_file.tc_qcd03,
           azf03_7          LIKE azf_file.azf03,
           tc_qcd04         LIKE tc_qcd_file.tc_qcd04,
           tc_qcd05         LIKE tc_qcd_file.tc_qcd05,
           tc_qcd06         LIKE tc_qcd_file.tc_qcd06,
           tc_qcd07         LIKE tc_qcd_file.tc_qcd07,
           tc_qcd08         LIKE tc_qcd_file.tc_qcd08,
           tc_qcd09         LIKE tc_qcd_file.tc_qcd09,
           tc_qcd10         LIKE tc_qcd_file.tc_qcd10,
           tc_qcd11         LIKE tc_qcd_file.tc_qcd11,
           tc_qcd12         LIKE tc_qcd_file.tc_qcd12,
           tc_qcd13         LIKE tc_qcd_file.tc_qcd13,
           tc_qcd14         LIKE tc_qcd_file.tc_qcd14,
           tc_qcd15         LIKE tc_qcd_file.tc_qcd15,
           tc_qcd16         LIKE tc_qcd_file.tc_qcd16,
           tc_qcd17         LIKE tc_qcd_file.tc_qcd17,
           tc_qcd18         LIKE tc_qcd_file.tc_qcd18,
           tc_qcd19         LIKE tc_qcd_file.tc_qcd19,
           tc_qcd20         LIKE tc_qcd_file.tc_qcd20,
           tc_qcd21         LIKE tc_qcd_file.tc_qcd21,
           tc_qcd22         LIKE tc_qcd_file.tc_qcd22,
           tc_qcd23         LIKE tc_qcd_file.tc_qcd23
                            END RECORD,
       g_tc_qcd_t           RECORD
           tc_qcd02         LIKE tc_qcd_file.tc_qcd02,
           tc_qcd03         LIKE tc_qcd_file.tc_qcd03,
           azf03_7          LIKE azf_file.azf03,
           tc_qcd04         LIKE tc_qcd_file.tc_qcd04,
           tc_qcd05         LIKE tc_qcd_file.tc_qcd05,
           tc_qcd06         LIKE tc_qcd_file.tc_qcd06,
           tc_qcd07         LIKE tc_qcd_file.tc_qcd07,
           tc_qcd08         LIKE tc_qcd_file.tc_qcd08,
           tc_qcd09         LIKE tc_qcd_file.tc_qcd09,
           tc_qcd10         LIKE tc_qcd_file.tc_qcd10,
           tc_qcd11         LIKE tc_qcd_file.tc_qcd11,
           tc_qcd12         LIKE tc_qcd_file.tc_qcd12,
           tc_qcd13         LIKE tc_qcd_file.tc_qcd13,
           tc_qcd14         LIKE tc_qcd_file.tc_qcd14,
           tc_qcd15         LIKE tc_qcd_file.tc_qcd15,
           tc_qcd16         LIKE tc_qcd_file.tc_qcd16,
           tc_qcd17         LIKE tc_qcd_file.tc_qcd17,
           tc_qcd18         LIKE tc_qcd_file.tc_qcd18,
           tc_qcd19         LIKE tc_qcd_file.tc_qcd19,
           tc_qcd20         LIKE tc_qcd_file.tc_qcd20,
           tc_qcd21         LIKE tc_qcd_file.tc_qcd21,    
           tc_qcd22         LIKE tc_qcd_file.tc_qcd22,    
           tc_qcd23         LIKE tc_qcd_file.tc_qcd23
                            END RECORD,
       g_tc_qce             DYNAMIC ARRAY OF RECORD
           tc_qce02         LIKE tc_qce_file.tc_qce02,
           tc_qce03         LIKE tc_qce_file.tc_qce03,
           tc_qce04         LIKE tc_qce_file.tc_qce04
                            END RECORD,
            
       g_tc_qce_t           DYNAMIC ARRAY OF RECORD
           tc_qce02         LIKE tc_qce_file.tc_qce02,
           tc_qce03         LIKE tc_qce_file.tc_qce03,
           tc_qce04         LIKE tc_qce_file.tc_qce04
                            END RECORD,
       g_tc_qcf             RECORD LIKE tc_qcf_file.*,
       g_tc_qcf_t           RECORD LIKE tc_qcf_file.*,
       #M31 160705 By TSD.james---(S)
       g_tc_qcg             DYNAMIC ARRAY OF RECORD
           tc_qcg02         LIKE tc_qcg_file.tc_qcg02,
           tc_qcg03         LIKE tc_qcg_file.tc_qcg03,
           azf03_8          LIKE azf_file.azf03,
           tc_qcg04         LIKE tc_qcg_file.tc_qcg04,
           tc_qcg05         LIKE tc_qcg_file.tc_qcg05,
           tc_qcg06         LIKE tc_qcg_file.tc_qcg06,
           tc_qcg07         LIKE tc_qcg_file.tc_qcg07,
           tc_qcg08         LIKE tc_qcg_file.tc_qcg08,
           tc_qcg09         LIKE tc_qcg_file.tc_qcg09,
           tc_qcg10         LIKE tc_qcg_file.tc_qcg10,
           tc_qcg11         LIKE tc_qcg_file.tc_qcg11,
           tc_qcg12         LIKE tc_qcg_file.tc_qcg12,
           tc_qcg13         LIKE tc_qcg_file.tc_qcg13,
           tc_qcg14         LIKE tc_qcg_file.tc_qcg14,
           tc_qcg15         LIKE tc_qcg_file.tc_qcg15,
           tc_qcg16         LIKE tc_qcg_file.tc_qcg16,
           tc_qcg17         LIKE tc_qcg_file.tc_qcg17,
           tc_qcg18         LIKE tc_qcg_file.tc_qcg18,
           tc_qcg19         LIKE tc_qcg_file.tc_qcg19,
           tc_qcg20         LIKE tc_qcg_file.tc_qcg20,
           tc_qcg21         LIKE tc_qcg_file.tc_qcg21,    
           tc_qcg22         LIKE tc_qcg_file.tc_qcg22,    
           tc_qcg23         LIKE tc_qcg_file.tc_qcg23
                            END RECORD,
       g_tc_qcg_t           RECORD
           tc_qcg02         LIKE tc_qcg_file.tc_qcg02,
           tc_qcg03         LIKE tc_qcg_file.tc_qcg03,
           azf03_8          LIKE azf_file.azf03,
           tc_qcg04         LIKE tc_qcg_file.tc_qcg04,
           tc_qcg05         LIKE tc_qcg_file.tc_qcg05,
           tc_qcg06         LIKE tc_qcg_file.tc_qcg06,
           tc_qcg07         LIKE tc_qcg_file.tc_qcg07,
           tc_qcg08         LIKE tc_qcg_file.tc_qcg08,
           tc_qcg09         LIKE tc_qcg_file.tc_qcg09,
           tc_qcg10         LIKE tc_qcg_file.tc_qcg10,
           tc_qcg11         LIKE tc_qcg_file.tc_qcg11,
           tc_qcg12         LIKE tc_qcg_file.tc_qcg12,
           tc_qcg13         LIKE tc_qcg_file.tc_qcg13,
           tc_qcg14         LIKE tc_qcg_file.tc_qcg14,
           tc_qcg15         LIKE tc_qcg_file.tc_qcg15,
           tc_qcg16         LIKE tc_qcg_file.tc_qcg16,
           tc_qcg17         LIKE tc_qcg_file.tc_qcg17,
           tc_qcg18         LIKE tc_qcg_file.tc_qcg18,
           tc_qcg19         LIKE tc_qcg_file.tc_qcg19,
           tc_qcg20         LIKE tc_qcg_file.tc_qcg20,
           tc_qcg21         LIKE tc_qcg_file.tc_qcg21,    
           tc_qcg22         LIKE tc_qcg_file.tc_qcg22,    
           tc_qcg23         LIKE tc_qcg_file.tc_qcg23
                            END RECORD,
       #M0321 160705 By TSD.james---(E)
       g_sql                STRING,                       
       g_wc                 STRING,                       
       g_wc2                STRING,                      
       g_wc3                STRING,                     
       g_wc4                STRING,                    
       g_wc5                STRING,                    
       g_wc6                STRING,                       #M025 160902 By TSD.Lynn add
       g_wc7                STRING,                       #M025 160902 By TSD.Lynn add
       g_wc8                STRING,                       #M025 160902 By TSD.Lynn add
       g_wc9                STRING,                       #M025 160902 By TSD.Lynn add
       g_wc10               STRING,                       #M045 161207 By TSD.Lynn add
       g_wc11               STRING,                       #MOD by ganlh170718 add
       g_rec_b              LIKE type_file.num5,          #單身筆數 
       g_rec_b1             LIKE type_file.num5,          #單身筆數 
       g_rec_b2             LIKE type_file.num5,          #單身筆數 
       g_rec_b3             LIKE type_file.num5,          #單身筆數   #M031 160705 By TSD.james
       l_ac                 LIKE type_file.num5           
       #M025 161014 By TSD.Lynn add ---(S)
      ,l_ac1_t              LIKE type_file.num5
      ,l_ac2_t              LIKE type_file.num5
      ,l_ac3_t              LIKE type_file.num5
      ,l_ac1                LIKE type_file.num5
      ,l_ac2                LIKE type_file.num5
      ,l_ac3                LIKE type_file.num5
       #M025 161014 By TSD.Lynn add ---(E)
DEFINE g_forupd_sql         STRING               
DEFINE g_before_input_done  LIKE type_file.num5   
DEFINE g_cnt                LIKE type_file.num10   
DEFINE g_msg                LIKE ze_file.ze03      
DEFINE g_curs_index         LIKE type_file.num10  
DEFINE g_row_count          LIKE type_file.num10    #總筆數 
DEFINE g_jump               LIKE type_file.num10    #查詢指定的筆數
DEFINE g_no_ask             LIKE type_file.num5     #是否開啟指定筆視窗 
DEFINE g_flag               LIKE type_file.chr1     #判斷哪個單身 
 
MAIN
   OPTIONS                      
      INPUT NO WRAP
     ,FIELD ORDER FORM #M025 160902 By TSD.Lynn
   DEFER INTERRUPT             
 
   IF (NOT cl_user()) THEN   
      EXIT PROGRAM          
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log 
 
   IF (NOT cl_setup("CQC")) THEN  
      EXIT PROGRAM               
   END IF
 
   CALL cl_used(g_prog,g_time,1) RETURNING g_time
 
   LET g_forupd_sql = " SELECT *  ",
                      "   FROM tc_qca_file ",
                      "  WHERE tc_qca01 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)     
   DECLARE t410_cl CURSOR FROM g_forupd_sql          
 
   OPEN WINDOW t410_w WITH FORM "cqc/42f/cqct410"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) 
   CALL cl_ui_init()        
   
   CALL cl_set_comp_visible("azf03_7",FALSE)  #M025 160620 By TSD.james 
   CALL cl_set_comp_visible("azf03_6",FALSE)  #M025 160627 By TSD.Lynn
   CALL cl_set_comp_visible("azf03_5",FALSE)  #M025 160627 By TSD.Lynn
   CALL cl_set_comp_visible("azf03_8",FALSE)  #M031 160707 By TSD.Lynn
   CALL t410_menu()          
   CLOSE WINDOW t410_w      
 
   CALL cl_used(g_prog,g_time,2) RETURNING g_time  
END MAIN
 
#QBE 查詢資料
FUNCTION t410_cs()
   DEFINE lc_qbe_sn   LIKE gbm_file.gbm01    
 
   CLEAR FORM 
   CALL g_tc_qcb.clear()
   #M025 161128 By TSD.Lynn add ---(S)
   CALL g_tc_qcc.clear()
   CALL g_tc_qcd.clear()
   CALL g_tc_qce.clear()
   CALL g_tc_qcg.clear()
   INITIALIZE g_tc_qcf.* TO NULL    
   INITIALIZE g_tc_qca_1.* TO NULL
   #M025 161128 By TSD.Lynn add ---(E)
 
   CALL cl_set_head_visible("","YES")           
   INITIALIZE g_tc_qca.* TO NULL    
   DIALOG ATTRIBUTE(UNBUFFERED) 
      #M049 161216 By TSD.Jay ---(S)---
      #CONSTRUCT BY NAME g_wc ON tc_qca01,tc_qca17,tc_qca18,tc_qca02,tc_qca05,tc_qca03,tc_qca04,tc_qca06,tc_qca07,
      CONSTRUCT BY NAME g_wc ON tc_qca01,tc_qca17,tc_qca18,tc_qca28,tc_qca02,
                                tc_qca05,tc_qca03,tc_qca04,tc_qca06,tc_qca07,
      #M049 161216 By TSD.Jay ---(E)---
                                tc_qca27,   #M025 160714 By TSD.Lynn add
                                #tc_qca08,tc_qca09,tc_qcaconf,tc_qca10,tc_qca11,tc_qca12,tc_qca13,tc_qca14,tc_qca15,  #M031 160705 By TSD.james mark
                                tc_qca08,tc_qca09,tc_qcaconf,tc_qca10,tc_qca11,tc_qca12,tc_qca13,tc_qca23,tc_qca24,tc_qca14,tc_qca15,  #M031 160705 By TSD.james
                                tc_qca16,tc_qcauser,tc_qcagrup,tc_qcamodu,tc_qcadate,tc_qcaacti 
                              
         BEFORE CONSTRUCT
            CALL cl_qbe_init()

      END CONSTRUCT

      #M025 160902 By TSD.Lynn add ---(S)
      CONSTRUCT BY NAME g_wc6 ON sfb05
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
      
      END CONSTRUCT

      CONSTRUCT BY NAME g_wc7 ON ima021,ima02,ta_ima01
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
      
      END CONSTRUCT

      #M045 161207 By TSD.Lynn add ---(S)
      CONSTRUCT BY NAME g_wc10 ON oba02

         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)

      #M045 161207 By TSD.Lynn add ---(E)
      END CONSTRUCT
      
      #M0D By ganlh170718 add ---(S)
      CONSTRUCT BY NAME g_wc11 ON inbud02

        BEFORE CONSTRUCT
           CALL cl_qbe_display_condition(lc_qbe_sn)

      #M0D By ganlh170718 add ---(E)
      END CONSTRUCT


      CONSTRUCT BY NAME g_wc8 ON oea03,oea032
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
      
      END CONSTRUCT

      CONSTRUCT BY NAME g_wc9 ON ta_inb03
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
      
      END CONSTRUCT
      #M025 160902 By TSD.Lynn add ---(E)
 
      CONSTRUCT g_wc2 ON tc_qcb02,tc_qcb03
           FROM s_tc_qcb[1].tc_qcb02,s_tc_qcb[1].tc_qcb03
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn) 
      
      END CONSTRUCT

      CONSTRUCT g_wc3 ON tc_qcc02,tc_qcc03
           FROM s_tc_qcc[1].tc_qcc02,s_tc_qcc[1].tc_qcc03
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
      
      END CONSTRUCT

      CONSTRUCT g_wc4 ON tc_qcg02,tc_qcg03
           FROM s_tc_qcg[1].tc_qcg02,s_tc_qcg[1].tc_qcg03
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn) 
      
      END CONSTRUCT

      #M031 160705 By TSD.james---(S)
      CONSTRUCT g_wc5 ON tc_qcg02,tc_qcg03
           FROM s_tc_qcg[1].tc_qcg02,s_tc_qcg[1].tc_qcg03

         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)

      END CONSTRUCT
      #M031 160705 By TSD.james---(E)

      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(tc_qca01)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="cq_tc_qca01"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca01
               NEXT FIELD tc_qca01


            #M025 160714 By TSD.Lynn add ---(S)
            WHEN INFIELD(tc_qca27) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="cq_gen02"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca27
               NEXT FIELD tc_qca27
            #M025 160714 By TSD.Lynn add ---(E)

            WHEN INFIELD(tc_qca08) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="cq_gen02"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca08
               NEXT FIELD tc_qca08

            WHEN INFIELD(tc_qca09)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="cq_gen02"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca09
               NEXT FIELD tc_qca09
    
            WHEN INFIELD(tc_qca10) 
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = 'S'
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca10
               NEXT FIELD tc_qca10

            WHEN INFIELD(tc_qca12)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = 'S'
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca12
               NEXT FIELD tc_qca12

            #M031 160705 By TSD.james---(S)
            WHEN INFIELD(tc_qca23)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = 'N'
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca23
               NEXT FIELD tc_qca23
            #M031 160705 By TSD.james---(E)

            WHEN INFIELD(tc_qca18)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="q_ecd3"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_qca18
               NEXT FIELD tc_qca18
            
            #M025 160627 By TSD.Lynn mark ---(S)
            #WHEN INFIELD(tc_qcb03)
            #   CALL cl_init_qry_var()
            #   LET g_qryparam.state = 'c'
            #   LET g_qryparam.form ="q_azf01f"
            #   LET g_qryparam.arg1 = 'S'
            #   CALL cl_create_qry() RETURNING g_qryparam.multiret
            #   DISPLAY g_qryparam.multiret TO tc_qcb03
            #   NEXT FIELD tc_qcb03

            #WHEN INFIELD(tc_qcc03)
            #   CALL cl_init_qry_var()
            #   LET g_qryparam.state = 'c'
            #   LET g_qryparam.form ="q_azf01f"
            #   LET g_qryparam.arg1 = 'S'
            #   CALL cl_create_qry() RETURNING g_qryparam.multiret
            #   DISPLAY g_qryparam.multiret TO tc_qcc03
            #   NEXT FIELD tc_qcc03
            #M025 160627 By TSD.Lynn mark ---(E)

            #M025 160620 By TSD.james---(S)
            #WHEN INFIELD(tc_qcd03)
            #   CALL cl_init_qry_var()
            #   LET g_qryparam.state = 'c'
            #   LET g_qryparam.form ="q_azf01f"
            #   LET g_qryparam.arg1 = 'S'
            #   CALL cl_create_qry() RETURNING g_qryparam.multiret
            #   DISPLAY g_qryparam.multiret TO tc_qcd03
            #   NEXT FIELD tc_qcd03
            #M025 160620 By TSD.james---(E)

            #M045 161207 By TSD.Lynn mod ---(S)
            WHEN INFIELD(oba02)
               CALL cl_init_qry_var()
               LET g_qryparam.state = 'c'
               LET g_qryparam.form ="cq_oba01"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oba02
               NEXT FIELD oba02
            #M045 161207 By TSD.Lynn mod ---(E)

            OTHERWISE EXIT CASE
         END CASE
   

      ON ACTION locale
         LET g_action_choice = "locale"
         CALL cl_show_fld_cont()
         CALL t410_pic()    #N025 161208 By TSD.Lynn add
         EXIT DIALOG

      ON ACTION controls      
         CALL cl_set_head_visible("folder01","AUTO")      
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
 
      ON ACTION about  
         CALL cl_about() 
 
      ON ACTION help    
         CALL cl_show_help()
 
      ON ACTION controlg  
         CALL cl_cmdask()  
 
      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION accept
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG=1
         EXIT DIALOG

   END DIALOG

   LET g_sql = "SELECT tc_qca01 ",
               "  FROM tc_qca_file ",
               " WHERE ", g_wc CLIPPED

   IF g_wc2 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcb_file ",
                        "              WHERE ",g_wc2 CLIPPED ,
                        "                AND tc_qcb01 = tc_qca01 )"
   END IF
 
   IF g_wc3 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcc_file ",
                        "              WHERE ",g_wc3 CLIPPED ,
                        "                AND tc_qcc01 = tc_qca01 )"
   END IF

   IF g_wc4 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcd_file ",
                        "              WHERE ",g_wc4 CLIPPED ,
                        "                AND tc_qcd01 = tc_qca01 )"
   END IF

   #M031 160705 By TSD.james---(S)
   IF g_wc5 <> " 1=1" THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcg_file ",
                        "              WHERE ",g_wc5 CLIPPED ,
                        "                AND tc_qcg01 = tc_qca01 )"
   END IF
   #M031 160705 By TSD.james---(E)
   #M025 160902 By TSD.Lynn add ---(S)
   #M045 161207 By TSD.Lynn mod ---(S)
   #IF g_wc6 <> " 1=1" OR g_wc7 <> " 1=1" OR g_wc8 <> " 1=1" OR g_wc9 <> " 1=1" THEN
   IF g_wc6 <> " 1=1" OR g_wc7 <> " 1=1" OR g_wc8 <> " 1=1" OR g_wc9 <> " 1=1" OR g_wc10 <> " 1=1" OR g_wc11<>"1=1"
   THEN
   #M045 161207 By TSD.Lynn mod ---(E)
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM sfb_file,ima_file,inb_file,oea_file ",
                        "                   ,oba_file  ",  #M045 161207 By TSD.Lynn add
                        "              WHERE sfb01 = tc_qca17 ",
                        "                AND sfb05 = ima01 ",
                        "                AND ima131 = oba01 ",  #M045 161207 By TSD.Lynn add
                        "                AND ta_inb04 = tc_qca17 ",
                        "                AND ta_inb03 = oea01 ",
                        "                AND ",g_wc6 CLIPPED ,
                        "                AND ",g_wc7 CLIPPED ,
                        "                AND ",g_wc8 CLIPPED ,
                        "                AND ",g_wc11 CLIPPED ,  #MOD by ganlh170718 add
                        "                AND ",g_wc10 CLIPPED ,  #M045 161207 By TSD.Lynn add
                        "                AND ",g_wc9 CLIPPED ,")"
   END IF
   #M025 160902 By TSD.Lynn add ---(E)

   LET g_sql = g_sql," ORDER BY tc_qca01"

   PREPARE t410_prepare FROM g_sql
   DECLARE t410_cs SCROLL CURSOR WITH HOLD FOR t410_prepare
 
   LET g_sql=" SELECT COUNT(DISTINCT tc_qca01) ",
             "   FROM tc_qca_file ",
             "  WHERE ",g_wc CLIPPED

   IF g_wc2 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcb_file ",
                        "              WHERE ",g_wc2 CLIPPED ,
                        "                AND tc_qcb01 = tc_qca01 )"
   END IF
 
   IF g_wc3 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcc_file ",
                        "              WHERE ",g_wc3 CLIPPED ,
                        "                AND tc_qcc01 = tc_qca01 )"
   END IF

   IF g_wc4 <> " 1=1" THEN        
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcd_file ",
                        "              WHERE ",g_wc4 CLIPPED ,
                        "                AND tc_qcd01 = tc_qca01 )"
   END IF

   #M031 160705 By TSD.james---(S)
   IF g_wc5 <> " 1=1" THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM tc_qcg_file ",
                        "              WHERE ",g_wc5 CLIPPED ,
                        "                AND tc_qcg01 = tc_qca01 )"
   END IF
   #M031 160705 By TSD.james---(E)

   #M025 160902 By TSD.Lynn add ---(S)
   IF g_wc6 <> " 1=1" OR g_wc7 <> " 1=1" OR g_wc8 <> " 1=1" OR g_wc9 <> " 1=1" THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 ",
                        "               FROM sfb_file,ima_file,inb_file,oea_file ",
                        "              WHERE sfb01 = tc_qca17 ",
                        "                AND sfb05 = ima01 ",
                        "                AND ta_inb04 = tc_qca17 ",
                        "                AND ta_inb03 = oea01 ",
                        "                AND ",g_wc6 CLIPPED ,
                        "                AND ",g_wc7 CLIPPED ,
                        "                AND ",g_wc8 CLIPPED ,
                        "                AND ",g_wc9 CLIPPED ,")"
   END IF
   #M025 160902 By TSD.Lynn add ---(E)

   PREPARE t410_precount FROM g_sql
   DECLARE t410_count CURSOR FOR t410_precount
 
END FUNCTION
 
FUNCTION t410_menu()
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
 
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL t410_copy()
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t410_b()
            ELSE
               LET g_action_choice = NULL
            END IF

         #確認
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
               CALL t410_confirm()
            END IF

         #取消確認
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t410_undo_confirm()
            END IF

         #金相組織圖片維護
         WHEN "pic_upd"
            IF cl_chk_act_auth() THEN
               CALL t410_pic_upd()
            END IF
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         WHEN "exporttoexcel"                       #單身匯出最多可匯三個Table資料
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_qcb),'','')
            END IF

         WHEN "related_document"                    #相關文件
              IF cl_chk_act_auth() THEN
                 IF NOT cl_null(g_tc_qca.tc_qca01) THEN
                 LET g_doc.column1 = "tc_qca01"
                 LET g_doc.value1 = g_tc_qca.tc_qca01
                 CALL cl_doc()
               END IF
         END IF

         #M025 160620 By TSD.james---(S)
         WHEN "report_output"
            IF cl_chk_act_auth() THEN
               CALL t410_report_output()
            END IF
         #M025 160620 By TSD.james---(E)
 
         OTHERWISE EXIT CASE
 
      END CASE
   END WHILE
END FUNCTION
 
FUNCTION t410_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1 
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DIALOG ATTRIBUTE(UNBUFFERED) 
      DISPLAY ARRAY g_tc_qcb TO s_tc_qcb.* ATTRIBUTE(COUNT=g_rec_b)
 
         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )
 
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL t410_b_show()
            CALL cl_show_fld_cont()
      END DISPLAY

      DISPLAY ARRAY g_tc_qcc TO s_tc_qcc.* ATTRIBUTE(COUNT=g_rec_b)

         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )

         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL t410_b_show()
            CALL cl_show_fld_cont()
      END DISPLAY

      DISPLAY ARRAY g_tc_qcd TO s_tc_qcd.* ATTRIBUTE(COUNT=g_rec_b)

         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )

         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL t410_b_show()
            CALL cl_show_fld_cont()
      END DISPLAY

      #M031 160705 By TSD.james---(S)
      DISPLAY ARRAY g_tc_qcg TO s_tc_qcg.* ATTRIBUTE(COUNT=g_rec_b)

         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )

         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL t410_b_show()
            CALL cl_show_fld_cont()
      END DISPLAY
      #M031 160705 By TSD.james---(E)
 
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DIALOG
 
      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG
 
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DIALOG
 
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DIALOG
     
      #確認 
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DIALOG

      #取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DIALOG

      #金相組織圖片維護
      ON ACTION pic_upd
         LET g_action_choice="pic_upd"
         EXIT DIALOG

      #M025 160620 By TSD.james---(S)
      #品檢報告列印
      ON ACTION report_output
         LET g_action_choice = "report_output"
         EXIT DIALOG
      #M025 160620 By TSD.james---(S)
 
      ON ACTION first
         CALL t410_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG  
 
      ON ACTION previous
         CALL t410_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG 
 
      ON ACTION jump
         CALL t410_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG
 
      ON ACTION next
         CALL t410_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG 
 
      ON ACTION last
         CALL t410_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG
 
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DIALOG
 
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DIALOG
 
      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                    
         CALL t410_pic()    #N025 161208 By TSD.Lynn add
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG=FALSE                         
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
 
      ON ACTION about         
         CALL cl_about()    
 
      ON ACTION exporttoexcel                       
         LET g_action_choice = 'exporttoexcel'
         EXIT DIALOG
 
      ON ACTION controls                            
         CALL cl_set_head_visible("folder01","AUTO")      
 
      ON ACTION related_document                    
         LET g_action_choice="related_document"          
         EXIT DIALOG

      &include "qry_string.4gl"
 
   END DIALOG 
  
   CALL t410_b_show()
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
FUNCTION t410_a()
   DEFINE l_gen02  LIKE gen_file.gen02   #M025 160714 By TSD.Lynn add
 
   MESSAGE ""
   CLEAR FORM
   CALL g_tc_qcb.clear()
   #M025 161128 By TSD.Lynn add ---(S)
   CALL g_tc_qcc.clear()
   CALL g_tc_qcd.clear()
   CALL g_tc_qce.clear()
   CALL g_tc_qcg.clear()
   INITIALIZE g_tc_qcf.* TO NULL    
   #M025 161128 By TSD.Lynn add ---(E)
   LET g_wc  = NULL 
   LET g_wc2 = NULL 
   LET g_wc3 = NULL 
   LET g_wc4 = NULL 
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   INITIALIZE g_tc_qca.* TO NULL
   INITIALIZE g_tc_qca_1.* TO NULL
   LET g_tc_qca01_t = NULL
 
   #預設值及將數值類變數清成零
   LET g_tc_qca_t.* = g_tc_qca.*
   LET g_tc_qca_o.* = g_tc_qca.*
   CALL cl_opmsg('a')
 
   WHILE TRUE
      LET g_tc_qca.tc_qcauser = g_user
      LET g_data_plant = g_plant
      LET g_tc_qca.tc_qcagrup = g_grup
      LET g_tc_qca.tc_qcadate = g_today
      LET g_tc_qca.tc_qcaacti='Y'           
      LET g_tc_qca.tc_qca02 = g_today 
      LET g_tc_qca.tc_qca03 = TIME(CURRENT)
      LET g_tc_qca.tc_qca07 = 'Y'
      LET g_tc_qca.tc_qca27 = g_user    #M025 160714 By TSD.Lynn add 
      #M025 160714 By TSD.Lynn  ---(S)
      CALL t410_chk_gen('d',g_tc_qca.tc_qca27) RETURNING l_gen02
      DISPLAY l_gen02 TO FORMONLY.gen02_3
      #M025 160714 By TSD.Lynn  ---(E)
      LET g_tc_qca.tc_qcaconf = 'N'
      LET g_tc_qca_t.* = g_tc_qca.*
      LET g_tc_qca_o.* = g_tc_qca.*
            
      CALL t410_i("a")             
 
      IF INT_FLAG THEN              
         INITIALIZE g_tc_qca.* TO NULL
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
 
      IF cl_null(g_tc_qca.tc_qca01) THEN  
         CONTINUE WHILE
      END IF
 
      INSERT INTO tc_qca_file VALUES (g_tc_qca.*)
      IF SQLCA.sqlcode THEN           
         CALL cl_err3("ins","tc_qca_file",g_tc_qca.tc_qca01,"",SQLCA.sqlcode,"","",1) 
         CONTINUE WHILE
      END IF    
 
      #M025 161128 By TSD.Lynn add ---(S)
      CALL g_tc_qcc.clear()
      CALL g_tc_qcd.clear()
      CALL g_tc_qce.clear()
      CALL g_tc_qcg.clear()
      INITIALIZE g_tc_qcf.* TO NULL    
      #M025 161128 By TSD.Lynn add ---(E)
      #M045 161114 By TSD.nick ===(s)
      #由cqci100維護資訊更新間距資料
      CALL t410_get_tc_qcf('a')
      #M045 161114 By TSD.nick ===(e)
      SELECT tc_qca01 
        INTO g_tc_qca.tc_qca01 
        FROM tc_qca_file 
       WHERE tc_qca01 = g_tc_qca.tc_qca01

      LET g_tc_qca01_t = g_tc_qca.tc_qca01  
      LET g_tc_qca_t.* = g_tc_qca.*
      CALL g_tc_qcb.clear()
 
      LET g_rec_b = 0  
      CALL t410_b()                        
      EXIT WHILE
   END WHILE
 
END FUNCTION
 
FUNCTION t410_u()
   IF s_shut(0) THEN
      RETURN
   END IF
 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file
    WHERE tc_qca01 = g_tc_qca.tc_qca01

   LET g_tc_qca_t.* = g_tc_qca.*
   LET g_tc_qca_o.* = g_tc_qca.*
 
   IF g_tc_qca.tc_qcaacti ='N' THEN    #檢查資料是否為無效
      CALL cl_err(g_tc_qca.tc_qca01,'mfg1000',1)
      RETURN
   END IF

   #M025 160616 By TSD.Lynn add ---(S)
   IF g_tc_qca.tc_qcaconf = 'Y' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'alm-027',1)  #本筆資料已確認,不可修改！
      RETURN
   END IF 

   IF g_tc_qca.tc_qcaconf = 'X' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'asf-147',1)  #此筆資料已作廢，不可修改
      RETURN
   END IF 
   #M025 160616 By TSD.Lynn add ---(E)
   
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_tc_qca01_t = g_tc_qca.tc_qca01

   BEGIN WORK
 
   OPEN t410_cl USING g_tc_qca.tc_qca01
   IF SQLCA.sqlcode THEN
      CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t410_cl INTO g_tc_qca.*  
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,1)  
       CLOSE t410_cl
       ROLLBACK WORK
       RETURN
   END IF
 
   CALL t410_show()
 
   WHILE TRUE
      LET g_tc_qca01_t = g_tc_qca.tc_qca01
      LET g_tc_qca.tc_qcamodu = g_user
      LET g_tc_qca.tc_qcadate = g_today
 
      CALL t410_i("u")                 
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_tc_qca.* = g_tc_qca_t.*
         CALL t410_show()
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF
 
      IF g_tc_qca.tc_qca01 <> g_tc_qca01_t THEN            
         UPDATE tc_qcb_file 
            SET tc_qcb01 = g_tc_qca.tc_qca01
          WHERE tc_qcb01 = g_tc_qca01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            IF SQLCA.sqlcode = 0 THEN
               LET SQLCA.sqlcode = 9050
            END IF
            CALL cl_err3("upd","tc_qcb_file",g_tc_qca01_t,"",SQLCA.sqlcode,"","tc_qcb",1)
            CONTINUE WHILE
         END IF

         UPDATE tc_qcc_file
            SET tc_qcc01 = g_tc_qca.tc_qca01
          WHERE tc_qcc01 = g_tc_qca01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            IF SQLCA.sqlcode = 0 THEN
               LET SQLCA.sqlcode = 9050
            END IF
            CALL cl_err3("upd","tc_qcc_file",g_tc_qca01_t,"",SQLCA.sqlcode,"","tc_qcc",1)  
            CONTINUE WHILE
         END IF

         UPDATE tc_qcd_file
            SET tc_qcd01 = g_tc_qca.tc_qca01
          WHERE tc_qcd01 = g_tc_qca01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            IF SQLCA.sqlcode = 0 THEN
               LET SQLCA.sqlcode = 9050
            END IF
            CALL cl_err3("upd","tc_qcd_file",g_tc_qca01_t,"",SQLCA.sqlcode,"","tc_qcd",1)  
            CONTINUE WHILE
         END IF

         UPDATE tc_qcf_file
            SET tc_qcf01 = g_tc_qca.tc_qca01
          WHERE tc_qcf01 = g_tc_qca01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            IF SQLCA.sqlcode = 0 THEN
               LET SQLCA.sqlcode = 9050
            END IF
            CALL cl_err3("upd","tc_qcf_file",g_tc_qca01_t,"",SQLCA.sqlcode,"","tc_qcf",1)
            CONTINUE WHILE
         END IF
      END IF
 
      UPDATE tc_qca_file 
         SET tc_qca_file.* = g_tc_qca.*
       WHERE tc_qca01 = g_tc_qca01_t 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
         IF SQLCA.sqlcode = 0 THEN
            LET SQLCA.sqlcode = 9050
         END IF
         CALL cl_err3("upd","tc_qca_file","","",SQLCA.sqlcode,"","",1) 
         CONTINUE WHILE
      END IF
      #M045 161114 By TSD.nick ===(s)
      #由cqci100維護資訊更新間距資料
      CALL t410_get_tc_qcf('u')
      #M045 161114 By TSD.nick ===(e)
      EXIT WHILE
   END WHILE
 
   CLOSE t410_cl
   COMMIT WORK
 
   #CALL t410_b_fill(" 1=1"," 1=1"," 1=1")  #M031 160705 By TSD.james mark
   CALL t410_b_fill(" 1=1"," 1=1"," 1=1"," 1=1")  #M031 160705 By TSD.james
   CALL t410_b_show()
END FUNCTION
 
FUNCTION t410_i(p_cmd)
   DEFINE l_n         LIKE type_file.num5    
   DEFINE p_cmd       LIKE type_file.chr1     #a:輸入 u:更改  
   DEFINE l_cnt       LIKE type_file.num5
   DEFINE l_chk      LIKE type_file.num5
   DEFINE l_time      STRING 
   DEFINE l_gen02     LIKE gen_file.gen02   #M025 160714 By TSD.Lynn add
   DEFINE l_sfb02     LIKE sfb_file.sfb02   #M025 161202 By TSD.Lynn add 
   DEFINE l_sfb08     LIKE sfb_file.sfb08   #M025 161202 By TSD.Lynn add 
   

   IF s_shut(0) THEN
      RETURN
   END IF
 
   DISPLAY BY NAME g_tc_qca.tc_qcauser,g_tc_qca.tc_qcamodu,g_tc_qca.tc_qcagrup,g_tc_qca.tc_qcadate,
                   g_tc_qca.tc_qcaacti,g_tc_qca.tc_qca07,g_tc_qca.tc_qcaconf
 
   CALL cl_set_head_visible("","YES")

   #M025 160714 By TSD.Lynn add ---(S)
   #INPUT BY NAME g_tc_qca.tc_qca01,g_tc_qca.tc_qca17,g_tc_qca.tc_qca18,g_tc_qca.tc_qca02,g_tc_qca.tc_qca05,g_tc_qca.tc_qca03,
   #              g_tc_qca.tc_qca04,g_tc_qca.tc_qca06,g_tc_qca.tc_qca08,g_tc_qca.tc_qca10,g_tc_qca.tc_qca11,g_tc_qca.tc_qca12,
   #              #g_tc_qca.tc_qca13,g_tc_qca.tc_qca14,g_tc_qca.tc_qca15,g_tc_qca.tc_qca16 WITHOUT DEFAULTS  #M031 160705 By TSD.james mark
   #              g_tc_qca.tc_qca13,g_tc_qca.tc_qca23,g_tc_qca.tc_qca24,g_tc_qca.tc_qca14,g_tc_qca.tc_qca15,g_tc_qca.tc_qca16 WITHOUT DEFAULTS #M031 160705 By TSD.james
   #M049 161216 By TSD.Jay ---(S)---
   #INPUT BY NAME g_tc_qca.tc_qca01,g_tc_qca.tc_qca17,g_tc_qca.tc_qca18,g_tc_qca.tc_qca02,g_tc_qca.tc_qca03,g_tc_qca.tc_qca04,
   INPUT BY NAME g_tc_qca.tc_qca01,g_tc_qca.tc_qca17,g_tc_qca.tc_qca18,g_tc_qca.tc_qca28,
                 g_tc_qca.tc_qca02,g_tc_qca.tc_qca03,g_tc_qca.tc_qca04,
   #M049 161216 By TSD.Jay ---(E)---
                 g_tc_qca.tc_qca05,g_tc_qca.tc_qca06,g_tc_qca.tc_qca07,g_tc_qca.tc_qca27,g_tc_qca.tc_qca08,g_tc_qca.tc_qca09,
                 g_tc_qca.tc_qcaconf,g_tc_qca.tc_qca10,g_tc_qca.tc_qca11,g_tc_qca.tc_qca19,g_tc_qca.tc_qca20,g_tc_qca.tc_qca12,
                 g_tc_qca.tc_qca13,g_tc_qca.tc_qca21,g_tc_qca.tc_qca22,g_tc_qca.tc_qca23,g_tc_qca.tc_qca24,g_tc_qca.tc_qca25,
                 g_tc_qca.tc_qca26,g_tc_qca.tc_qca14,g_tc_qca.tc_qca15,g_tc_qca.tc_qca16,
                 g_tc_qca.tc_qcauser,g_tc_qca.tc_qcamodu,g_tc_qca.tc_qcagrup,g_tc_qca.tc_qcadate,
                 g_tc_qca.tc_qcaacti
                 WITHOUT DEFAULTS 
   #M025 160714 By TSD.Lynn add ---(E)
 
      BEFORE INPUT
         LET g_before_input_done = FALSE
         CALL t410_set_entry(p_cmd)
         CALL t410_set_no_entry(p_cmd)
         LET g_before_input_done = TRUE

      AFTER FIELD tc_qca01
         IF NOT cl_null(g_tc_qca.tc_qca01) THEN
            IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qca.tc_qca01 <> g_tc_qca01_t) THEN
               LET l_cnt = 0
               SELECT COUNT(*)
                 INTO l_cnt
                 FROM tc_qca_file
                WHERE tc_qca01 = g_tc_qca.tc_qca01
               IF l_cnt > 0 THEN
                  CALL cl_err('','-239',1)
                  NEXT FIELD tc_qca01
               END IF 
            END IF
            IF (g_tc_qca.tc_qca01 <> g_tc_qca_o.tc_qca01) OR cl_null(g_tc_qca_o.tc_qca01)  THEN
               #M025 161202 By TSD.Lynn add ---(S)
               LET l_sfb02 = NULL
               LET l_sfb08 = NULL
               SELECT sfb02,sfb08
                 INTO l_sfb02,l_sfb08
                 FROM sfb_file
                WHERE sfb01 = g_tc_qca.tc_qca01
               IF l_sfb02 MATCHES '[78]' THEN   #委外工單
                  IF cl_null(l_sfb08) OR l_sfb08 =0 THEN
                     #查無此三色工單的數量!
                     CALL cl_err('','TSD0043',1)
                     NEXT FIELD tc_qca01
                  ELSE
                     LET g_tc_qca.tc_qca17 = g_tc_qca.tc_qca01
                     LET g_tc_qca.tc_qca04 = l_sfb08
                  END IF
               ELSE
               #M025 161202 By TSD.Lynn add ---(E)
                  #M025 160531 By TSD.pplppl--------------------------START
                  #長度大於系統的單據長度才處理
                  IF LENGTH(g_tc_qca.tc_qca01) >= g_aza.aza41+g_aza.aza42+10 THEN
                     LET g_tc_qca.tc_qca17 = g_tc_qca.tc_qca01[1,g_aza.aza41+g_aza.aza42+10]
                     LET g_runcard = g_tc_qca.tc_qca01
                     IF aws_sftcli('','q_mo_tt',g_tc_qca.tc_qca17,'') = 0 THEN
                        IF cl_null(g_runcard_qry) THEN
                           #查無此三色工單的數量!
                           CALL cl_err('','TSD0043',1)
                           NEXT FIELD tc_qca01
                        ELSE
                           LET g_tc_qca.tc_qca04 = g_runcard_qry
                        END IF
                     ELSE
                        LET g_tc_qca.tc_qca17 = ''
                        LET g_tc_qca.tc_qca04 = ''
                        NEXT FIELD tc_qca01
                     END IF
                     DISPLAY BY NAME g_tc_qca.tc_qca17,g_tc_qca.tc_qca04
                  #M025 160606 By TSD.Lynn add ---(S)
                  ELSE 
                     CALL cl_err('','TSD0044',1)  #单号长度与系统设定不同，请新输入!
                     NEXT FIELD tc_qca01
                  #M025 160606 By TSD.Lynn add ---(E)
                  END IF
                  #M025 160531 By TSD.pplppl----------------------------END
               END IF        #M025 161202 By TSD.Lynn add 
               CALL t410_to_value(p_cmd)
               #M045 161114 By TSD.nick ===(s)
               CALL t410_chk_tc_imc()
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_tc_qca.tc_qca18,g_errno,1)
                  NEXT FIELD tc_qca01
               END IF
               #M045 161114 By TSD.nick ===(e)
            END IF
            #add by cjy 20170519
            SELECT ina07 INTO g_tc_qca.tc_qca06 FROM ina_file,inb_file WHERE ina01=inb01 AND ta_inb04=g_tc_qca.tc_qca01
            DISPLAY BY NAME g_tc_qca.tc_qca06
            #end add by cjy 20170519
         ELSE
            LET g_tc_qca.tc_qca17 =NULL
            DISPLAY BY NAME g_tc_qca.tc_qca17
            INITIALIZE g_tc_qca_1.* TO NULL
            DISPLAY BY NAME g_tc_qca_1.* 
            #M049 161216 By TSD.Jay ---(S)---
            #CALL cs_get_fld_doc('1',' ',' ') 
            CALL cs_get_fld_doc('1',' ',' ',' ') 
            #M049 161216 By TSD.Jay ---(E)---
         END IF
         LET g_tc_qca_o.tc_qca01 = g_tc_qca.tc_qca01
 
      AFTER FIELD tc_qca03
         IF NOT cl_null(g_tc_qca.tc_qca03) THEN
            LET l_time = g_tc_qca.tc_qca03
            IF l_time.getLength() <> 8 THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF l_time.getCharAt(3) NOT MATCHES ':' OR l_time.getCharAt(6) NOT MATCHES ':' THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF l_time.getCharAt(1) NOT MATCHES '[012]' THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF (l_time.getCharAt(1) MATCHES '[01]' AND l_time.getCharAt(2) NOT MATCHES '[0123456789]') OR
               (l_time.getCharAt(1) MATCHES '2' AND l_time.getCharAt(2) NOT MATCHES '[01234]') THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF l_time.getCharAt(4) NOT MATCHES '[012345]' THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF (l_time.getCharAt(4) MATCHES '[012345]' AND l_time.getCharAt(5) NOT MATCHES '[0123456789]') OR 
               (l_time.getCharAt(4) MATCHES '6')THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF l_time.getCharAt(7) NOT MATCHES '[012345]' THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF

            IF (l_time.getCharAt(7) MATCHES '[012345]' AND l_time.getCharAt(8) NOT MATCHES '[0123456789]') OR
               (l_time.getCharAt(7) MATCHES '6') THEN
               CALL cl_err('','art-209',1)       #時間格式不正確！請重新輸入！
               NEXT FIELD tc_qca03
            END IF
         END IF
         
      AFTER FIELD tc_qca17 
         IF NOT cl_null(g_tc_qca.tc_qca17) THEN
            IF (g_tc_qca.tc_qca17 <> g_tc_qca_o.tc_qca17) OR cl_null(g_tc_qca_o.tc_qca17) THEN
               CALL t410_to_value(p_cmd)
            END IF
         ELSE
            INITIALIZE g_tc_qca_1.* TO NULL
            DISPLAY BY NAME g_tc_qca_1.*
         END IF
         LET g_tc_qca_o.tc_qca17 = g_tc_qca.tc_qca17

      #M025 160714 By TSD.Lynn add ---(S)
      AFTER FIELD tc_qca27
         IF NOT cl_null(g_tc_qca.tc_qca27) THEN
            CALL t410_tc_qca08(g_tc_qca.tc_qca27)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca27,g_errno,1)
               NEXT FIELD tc_qca27
            END IF
            CALL t410_chk_gen(p_cmd,g_tc_qca.tc_qca27) RETURNING l_gen02
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca27,g_errno,1)
               NEXT FIELD tc_qca27
            END IF
            DISPLAY l_gen02 TO FORMONLY.gen02_3
         ELSE
            DISPLAY '' TO FORMONLY.gen02_3
         #M025 160714 By TSD.Lynn add ---(E)
         END IF
      #M025 160714 By TSD.Lynn add ---(E)

      AFTER FIELD tc_qca08
         IF NOT cl_null(g_tc_qca.tc_qca08) THEN
            CALL t410_tc_qca08(g_tc_qca.tc_qca08)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca08,g_errno,1)
               NEXT FIELD tc_qca08
            END IF
         #M025 160714 By TSD.Lynn add ---(S)
            CALL t410_chk_gen(p_cmd,g_tc_qca.tc_qca08) RETURNING l_gen02
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca08,g_errno,1)
               NEXT FIELD tc_qca08
            END IF
            DISPLAY l_gen02 TO FORMONLY.gen02_1
         ELSE
            DISPLAY '' TO FORMONLY.gen02_1
         #M025 160714 By TSD.Lynn add ---(E)
         END IF

      #M025 161128 By TSD.Lynn add ---(S)
      AFTER FIELD tc_qca09
         IF NOT cl_null(g_tc_qca.tc_qca09) THEN
            CALL t410_tc_qca08(g_tc_qca.tc_qca09)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca09,g_errno,1)
               NEXT FIELD tc_qca09
            END IF
            CALL t410_chk_gen('a',g_tc_qca.tc_qca09) RETURNING l_gen02
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca09,g_errno,1)
               NEXT FIELD tc_qca09
            END IF
            DISPLAY l_gen02 TO FORMONLY.gen02_2
         ELSE
            DISPLAY '' TO FORMONLY.gen02_2
         END IF
      #M025 161128 By TSD.Lynn add ---(E)


      AFTER FIELD tc_qca10
         IF NOT cl_null(g_tc_qca.tc_qca10) THEN
            CALL t410_tc_qca10(g_tc_qca.tc_qca10) RETURNING g_tc_qca_1.azf03_1
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca10,g_errno,1)
               NEXT FIELD tc_qca10
            END IF
            CALL t410_to_value('d')   #mod by cjy 20170124
            DISPLAY g_tc_qca_1.azf03_1 TO FORMONLY.azf03_1
         ELSE
            LET g_tc_qca_1.azf03_1 = NULL
            DISPLAY g_tc_qca_1.azf03_1 TO FORMONLY.azf03_1
         END IF

      AFTER FIELD tc_qca12
         IF NOT cl_null(g_tc_qca.tc_qca12) THEN
            CALL t410_tc_qca10(g_tc_qca.tc_qca12) RETURNING g_tc_qca_1.azf03_2
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca12,g_errno,1)
               NEXT FIELD tc_qca12
            END IF
            CALL t410_to_value('d')   #mod by cjy 20170124
            DISPLAY g_tc_qca_1.azf03_2 TO FORMONLY.azf03_2
         ELSE
            LET g_tc_qca_1.azf03_2 = NULL
            DISPLAY g_tc_qca_1.azf03_2 TO FORMONLY.azf03_2
         END IF

      #M031 160705 By TSD.james---(S)
      AFTER FIELD tc_qca23
         IF NOT cl_null(g_tc_qca.tc_qca23) THEN
            CALL t410_tc_qca23(p_cmd)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca23,g_errno,1)
               NEXT FIELD tc_qca23
            END IF
           CALL t410_to_value('d')   #mod by cjy 20170124
         ELSE
            LET g_tc_qca_1.azf03_9 = NULL
            DISPLAY g_tc_qca_1.azf03_9 TO FORMONLY.azf03_9
         END IF
      #M031 160705 By TSD.james---(E)
 
      AFTER FIELD tc_qca18
         IF NOT cl_null(g_tc_qca.tc_qca18) THEN
            #CALL t410_tc_qca18()  #M025 160620 By TSD.james mark
            CALL t410_tc_qca18(p_cmd)   #M025 160620 By TSD.james
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca18,g_errno,1)
               NEXT FIELD tc_qca18
            END IF
            #M045 161114 By TSD.nick ===(s)
            CALL t410_chk_tc_imc()
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca18,g_errno,1)
               NEXT FIELD tc_qca18
            END IF
            #M045 161114 By TSD.nick ===(e)
            #M019 161216 By TSD.Jay ---(S)---
            #IF (g_tc_qca.tc_qca18 <> g_tc_qca_o.tc_qca18) OR cl_null(g_tc_qca_o.tc_qca18)  THEN
            IF ((g_tc_qca.tc_qca18 <> g_tc_qca_o.tc_qca18) OR cl_null(g_tc_qca_o.tc_qca18)) OR
               ((g_tc_qca.tc_qca28 <> g_tc_qca_o.tc_qca28) OR cl_null(g_tc_qca_o.tc_qca28)) THEN
            #M019 161216 By TSD.Jay ---(E)---
               CALL t410_to_value(p_cmd)
            END IF
         ELSE
            DISPLAY ' ' TO FORMONLY.tc_imc03
            DISPLAY ' ' TO FORMONLY.tc_imc04
            DISPLAY ' ' TO FORMONLY.tc_imc05
            DISPLAY ' ' TO FORMONLY.tc_imc06
            DISPLAY ' ' TO FORMONLY.tc_imc07
            DISPLAY ' ' TO FORMONLY.tc_imc09
            DISPLAY ' ' TO FORMONLY.azf03
            DISPLAY ' ' TO FORMONLY.azf03_3
            DISPLAY ' ' TO FORMONLY.ecd02   #M025 160620 By TSD.james
            #M049 161216 By TSD.Jay ---(S)---
            LET g_tc_qca.tc_qca28 = NULL
            DISPLAY BY NAME g_tc_qca.tc_qca28
            #CALL cs_get_fld_doc('1',' ',' ') 
            CALL cs_get_fld_doc('1',' ',' ',' ')
            #M049 161216 By TSD.Jay ---(E)---
         END IF
         LET g_tc_qca_o.tc_qca18 = g_tc_qca.tc_qca18
         LET g_tc_qca_o.tc_qca28 = g_tc_qca.tc_qca28 #M019 161216 By TSD.Jay

      #M049 161216 By TSD.Jay ---(S)---
      AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF
         IF cl_null(g_tc_qca.tc_qca28) THEN
            CALL cl_err('','TSD0070',1) #版本不得為空，請檢查此料件+作業編號+版本是否已正確維護品保資料(cqci100)
            NEXT FIELD tc_qca18
         END IF
      #M049 161216 By TSD.Jay ---(E)---
      #add by cjy 20170612
         LET l_chk = 0
         SELECT COUNT(*) INTO l_chk FROM sfb_file WHERE sfb01=g_tc_qca.tc_qca17
         IF l_chk = 0 THEN
            CALL cl_err('','asf-312',1)
            NEXT FIELD tc_qca01
         END IF
        #end add by cjy 20170612

      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(tc_qca08) 
               CALL cl_init_qry_var()
               LET g_qryparam.form ="cq_gen02"
               LET g_qryparam.default1 = g_tc_qca.tc_qca08
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca08
               DISPLAY BY NAME g_tc_qca.tc_qca08
               NEXT FIELD tc_qca08        
            #M025 161128 By TSD.Lyn add ---(S)
            WHEN INFIELD(tc_qca09)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="cq_gen02"
               LET g_qryparam.default1 = g_tc_qca.tc_qca09
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca09
               DISPLAY BY NAME g_tc_qca.tc_qca09
               NEXT FIELD tc_qca09 
            #M025 161128 By TSD.Lyn add ---(E)

            #M025 160714 By TSD.Lynn add ---(S)
            WHEN INFIELD(tc_qca27) 
               CALL cl_init_qry_var()
               LET g_qryparam.form ="cq_gen02"
               LET g_qryparam.default1 = g_tc_qca.tc_qca27
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca27
               DISPLAY BY NAME g_tc_qca.tc_qca27
               NEXT FIELD tc_qca27        
            #M025 160714 By TSD.Lynn add ---(E)

            WHEN INFIELD(tc_qca10) 
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = "M"
               LET g_qryparam.default1 = g_tc_qca.tc_qca10
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca10
               DISPLAY BY NAME g_tc_qca.tc_qca10
               CALL t410_tc_qca10(g_tc_qca.tc_qca10) RETURNING g_tc_qca_1.azf03_1
               DISPLAY g_tc_qca_1.azf03_1 TO FORMONLY.azf03_1
               NEXT FIELD tc_qca10

            WHEN INFIELD(tc_qca12)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = "M"
               LET g_qryparam.default1 = g_tc_qca.tc_qca12
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca12
               DISPLAY BY NAME g_tc_qca.tc_qca12
               CALL t410_tc_qca10(g_tc_qca.tc_qca12) RETURNING g_tc_qca_1.azf03_2
               DISPLAY g_tc_qca_1.azf03_2 TO FORMONLY.azf03_2
               NEXT FIELD tc_qca12

            #M031 160705 By TSD.james---(S)
            WHEN INFIELD(tc_qca23)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_azf01f"
               LET g_qryparam.arg1 = "N"
               LET g_qryparam.default1 = g_tc_qca.tc_qca23
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca23
               DISPLAY BY NAME g_tc_qca.tc_qca23
               CALL t410_tc_qca10(g_tc_qca.tc_qca23) RETURNING g_tc_qca_1.azf03_2
               DISPLAY g_tc_qca_1.azf03_2 TO FORMONLY.azf03_2
               NEXT FIELD tc_qca23
            #M031 160705 By TSD.james---(E)

            WHEN INFIELD(tc_qca18) 
               CALL cl_init_qry_var()
               #M045 161114 By TSD.nick ===(s)
               #LET g_qryparam.form ="q_ecd3"
               #改串cqci100(tc_imc_file)
               LET g_qryparam.form ="cq_tc_imc01"
               LET g_qryparam.where = "tc_imc01 = '",g_tc_qca_1.sfb05,"' "
               #M045 161114 By TSD.nick ===(e)
               LET g_qryparam.default1 = g_tc_qca.tc_qca18
               LET g_qryparam.default2 = g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca18
                                             ,g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
               DISPLAY BY NAME g_tc_qca.tc_qca18
                              ,g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
               NEXT FIELD tc_qca18
 
            OTHERWISE EXIT CASE
          END CASE
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about    
         CALL cl_about()  
 
      ON ACTION help       
         CALL cl_show_help()
 
   END INPUT
 
END FUNCTION
 
FUNCTION t410_q()
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   MESSAGE ""
   CALL cl_opmsg('q')
   CLEAR FORM
   CALL g_tc_qcb.clear()
   #M025 161128 By TSD.Lynn add ---(S)
   CALL g_tc_qcc.clear()
   CALL g_tc_qcd.clear()
   CALL g_tc_qce.clear()
   CALL g_tc_qcg.clear()
   INITIALIZE g_tc_qcf.* TO NULL    
   #M025 161128 By TSD.Lynn add ---(E)
   INITIALIZE g_tc_qca.* TO NULL
   INITIALIZE g_tc_qca_1.* TO NULL
   DISPLAY ' ' TO FORMONLY.cnt
 
   CALL t410_cs()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_tc_qca.* TO NULL
      RETURN
   END IF
 
   OPEN t410_cs                            
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_tc_qca.* TO NULL
   ELSE
      OPEN t410_count
      FETCH t410_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
 
      CALL t410_fetch('F')                  
   END IF
 
END FUNCTION
 
FUNCTION t410_fetch(p_flag)
   DEFINE p_flag          LIKE type_file.chr1                  
 
   CASE p_flag
      WHEN 'N' FETCH NEXT     t410_cs INTO g_tc_qca.tc_qca01
      WHEN 'P' FETCH PREVIOUS t410_cs INTO g_tc_qca.tc_qca01
      WHEN 'F' FETCH FIRST    t410_cs INTO g_tc_qca.tc_qca01
      WHEN 'L' FETCH LAST     t410_cs INTO g_tc_qca.tc_qca01
      WHEN '/'
         IF (NOT g_no_ask) THEN   
             CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
             LET INT_FLAG = 0
             PROMPT g_msg CLIPPED,': ' FOR g_jump
                ON IDLE g_idle_seconds
                   CALL cl_on_idle()
 
                ON ACTION about 
                   CALL cl_about()
 
                ON ACTION help   
                   CALL cl_show_help()
 
                ON ACTION controlg   
                   CALL cl_cmdask() 
 
             END PROMPT
             IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
             END IF
         END IF
         FETCH ABSOLUTE g_jump t410_cs INTO g_tc_qca.tc_qca01
         LET g_no_ask = FALSE 
   END CASE
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)
      INITIALIZE g_tc_qca.* TO NULL    
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
      DISPLAY g_curs_index TO FORMONLY.idx   
   END IF
 
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file 
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","tc_qca_file","","",SQLCA.sqlcode,"","",1)
      INITIALIZE g_tc_qca.* TO NULL
      RETURN
   END IF
 
   LET g_data_owner = g_tc_qca.tc_qcauser      
   LET g_data_group = g_tc_qca.tc_qcagrup     
   LET g_data_keyvalue = g_tc_qca.tc_qca01  
   CALL t410_show()
 
END FUNCTION
 
#將資料顯示在畫面上
FUNCTION t410_show()
   DEFINE l_gen02     LIKE gen_file.gen02   #M025 160714 By TSD.Lynn add

   LET g_tc_qca_t.* = g_tc_qca.*    
   DISPLAY BY NAME g_tc_qca.tc_qca01,g_tc_qca.tc_qca02,g_tc_qca.tc_qca03,g_tc_qca.tc_qca04,g_tc_qca.tc_qca05,g_tc_qca.tc_qca06,
                   g_tc_qca.tc_qca07,g_tc_qca.tc_qca08,g_tc_qca.tc_qca09,g_tc_qca.tc_qca10,g_tc_qca.tc_qca11,g_tc_qca.tc_qca12,
                   g_tc_qca.tc_qca13,g_tc_qca.tc_qca14,g_tc_qca.tc_qca15,g_tc_qca.tc_qca16,g_tc_qca.tc_qca17,g_tc_qca.tc_qca18,
                   g_tc_qca.tc_qcauser,g_tc_qca.tc_qcagrup,g_tc_qca.tc_qcamodu,g_tc_qca.tc_qcadate,g_tc_qca.tc_qcaconf,g_tc_qca.tc_qcaacti,
                   g_tc_qca.tc_qca19,g_tc_qca.tc_qca20,g_tc_qca.tc_qca21,g_tc_qca.tc_qca22
                   ,g_tc_qca.tc_qca23,g_tc_qca.tc_qca24,g_tc_qca.tc_qca25,g_tc_qca.tc_qca26  #M031 160705 By TSD.james
                   ,g_tc_qca.tc_qca27  #M025 160714 By TSD.Lynn add
                   ,g_tc_qca.tc_qca28  #M049 161216 By TSD.Jay
   CALL t410_to_value('d')
   #add by cjy 20170124
   SELECT tc_qca29,tc_qca30,tc_qca31,tc_qca32 
     INTO g_tc_qca.tc_qca29,g_tc_qca.tc_qca30,g_tc_qca.tc_qca31,g_tc_qca.tc_qca32
     FROM tc_qca_file 
    WHERE tc_qca01 = g_tc_qca.tc_qca01
    DISPLAY g_tc_qca.tc_qca29 TO FORMONLY.tc_crastr 
    DISPLAY g_tc_qca.tc_qca30 TO FORMONLY.tc_crastr_1 
    DISPLAY g_tc_qca.tc_qca31 TO FORMONLY.tc_crastr_3
    DISPLAY g_tc_qca.tc_qca32 TO FORMONLY.tc_crastr_2
   #end add by cjy 20170124 
  
   CALL t410_tc_qca18('d')  #M025 160620 By TSD.james
   #M025 160714 By TSD.Lynn add ---(S)
   CALL t410_chk_gen('d',g_tc_qca.tc_qca08) RETURNING l_gen02
   DISPLAY l_gen02 TO FORMONLY.gen02_1
   CALL t410_chk_gen('d',g_tc_qca.tc_qca09) RETURNING l_gen02
   DISPLAY l_gen02 TO FORMONLY.gen02_2
   CALL t410_chk_gen('d',g_tc_qca.tc_qca27) RETURNING l_gen02
   DISPLAY l_gen02 TO FORMONLY.gen02_3
   #M025 160714 By TSD.Lynn add ---(E)
   #M049 161216 By TSD.Jay ---(S)---
   #CALL cs_get_fld_doc('1',g_tc_qca_1.sfb05,g_tc_qca.tc_qca18) 
   CALL cs_get_fld_doc('1',g_tc_qca_1.sfb05,g_tc_qca.tc_qca18,g_tc_qca.tc_qca28)
   #M049 161216 By TSD.Jay ---(E)---
   #CALL t410_b_fill(g_wc2,g_wc3,g_wc4)                 #單身
   CALL t410_b_fill(g_wc2,g_wc3,g_wc4,g_wc5)            #M031 160705 By TSD.james
   CALL t410_b_show()
   CALL cl_show_fld_cont()     
   CALL t410_pic()   #M025 161208 By TSD.Lynn add
END FUNCTION

#間距顯示
FUNCTION t410_b_show()
   INITIALIZE g_tc_qcf.* TO NULL   #M025 161207 By TSD.Lynn add
   SELECT *
     INTO g_tc_qcf.*
     FROM tc_qcf_file
    WHERE tc_qcf01 = g_tc_qca.tc_qca01
   DISPLAY BY NAME g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,
                   g_tc_qcf.tc_qcf07,g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,
                   g_tc_qcf.tc_qcf13,g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,
                   g_tc_qcf.tc_qcf19,g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21
END FUNCTION
 
FUNCTION t410_r()
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err("",-400,0)
      RETURN
   END IF
 
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file
    WHERE tc_qca01 = g_tc_qca.tc_qca01

   #M025 160616 By TSD.Lynn add ---(S)
   IF g_tc_qca.tc_qcaacti ='N' THEN    
      CALL cl_err(g_tc_qca.tc_qca01,'aic-201',1)  #此筆資料已無效, 不可刪除
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'Y' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'abm-881',1)  #此筆資料已確認不可刪除
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'X' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'9024',1)     #此筆資料已作廢
      RETURN
   END IF 
   #M025 160616 By TSD.Lynn add ---(E)

   BEGIN WORK
 
   OPEN t410_cl USING g_tc_qca.tc_qca01
   IF SQLCA.sqlcode THEN
      CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t410_cl INTO g_tc_qca.*               
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)          
      CLOSE t410_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   CALL t410_show()
 
   IF cl_delh(0,0) THEN                   
      INITIALIZE g_doc.* TO NULL 
      LET g_doc.column1 = "tc_qca01" 
      LET g_doc.value1 = g_tc_qca.tc_qca01   
      CALL cl_del_doc()     
         
      DELETE FROM tc_qca_file 
       WHERE tc_qca01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         IF SQLCA.sqlcode = 0 THEN
            LET SQLCA.sqlcode = 9051
         END IF
         CALL cl_err3("del","tc_qca_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      DELETE FROM tc_qcb_file 
       WHERE tc_qcb01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qcb_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      DELETE FROM tc_qcc_file 
       WHERE tc_qcc01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qcc_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      DELETE FROM tc_qcd_file 
       WHERE tc_qcd01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qcd_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      DELETE FROM tc_qcf_file
       WHERE tc_qcf01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qcf_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      #M031160705 By TSD.james---(S)
      DELETE FROM tc_qce_file
       WHERE tc_qce01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qce_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF

      DELETE FROM tc_qcg_file
       WHERE tc_qcg01 = g_tc_qca.tc_qca01
      IF SQLCA.sqlcode THEN
         CALL cl_err3("del","tc_qcg_file","","",SQLCA.sqlcode,"","",1)
         ROLLBACK WORK   #M031 160711 By TSD.Lynn add
         RETURN          #M031 160711 By TSD.Lynn add
      END IF
      #M031160705 By TSD.james---(E)

      CLEAR FORM
      CALL g_tc_qcb.clear()
      #M025 161128 By TSD.Lynn add ---(S)
      CALL g_tc_qcc.clear()
      CALL g_tc_qcd.clear()
      CALL g_tc_qce.clear()
      CALL g_tc_qcg.clear()
      INITIALIZE g_tc_qcf.* TO NULL    
      INITIALIZE g_tc_qca_1.* TO NULL
      #M025 161128 By TSD.Lynn add ---(E)
      OPEN t410_count
      IF SQLCA.sqlcode THEN
         CLOSE t410_count
         COMMIT WORK
         RETURN
      END IF

      FETCH t410_count INTO g_row_count
      IF SQLCA.sqlcode OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
         CLOSE t410_count
         COMMIT WORK
         RETURN
      END IF

      DISPLAY g_row_count TO FORMONLY.cnt
      OPEN t410_cs
      IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL t410_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET g_no_ask = TRUE 
         CALL t410_fetch('/')
      END IF
   END IF
 
   CLOSE t410_cl
   COMMIT WORK
END FUNCTION
 
#單身
FUNCTION t410_b()
   DEFINE l_ac_t          LIKE type_file.num5,    
          l_n             LIKE type_file.num5,   
          l_n1            LIKE type_file.num5,  
          l_cnt           LIKE type_file.num5, 
          l_lock_sw       LIKE type_file.chr1, 
          p_cmd           LIKE type_file.chr1, 
          l_allow_insert  LIKE type_file.num5, 
          l_allow_delete  LIKE type_file.num5 
 
   LET g_action_choice = ""
 
   IF s_shut(0) THEN
      RETURN
   END IF
 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      RETURN
   END IF
 
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file
    WHERE tc_qca01=g_tc_qca.tc_qca01

   #M025 160616 By TSD.Lynn add ---(S)
   IF g_tc_qca.tc_qcaacti ='N' THEN    #檢查資料是否為無效
      CALL cl_err(g_tc_qca.tc_qca01,'mfg1000',1)
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'Y' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'alm-027',1)  #本筆資料已確認,不可修改！
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'X' THEN
      CALL cl_err(g_tc_qca.tc_qca01,'asf-147',1)  #此筆資料已作廢，不可修改
      RETURN
   END IF
   #M025 160616 By TSD.Lynn add ---(E)
 
   CALL cl_opmsg('b')
 
   LET g_forupd_sql = "SELECT tc_qcb02,tc_qcb03,'',tc_qcb04,tc_qcb05,tc_qcb06,tc_qcb07,tc_qcb08,tc_qcb09, ",
                      "       tc_qcb10,tc_qcb11,tc_qcb12,tc_qcb13,tc_qcb14,tc_qcb15,tc_qcb16,tc_qcb17, ",
                      "       tc_qcb18,tc_qcb19,tc_qcb20,tc_qcb21,tc_qcb22,tc_qcb23 ",
                      "  FROM tc_qcb_file",
                      "  WHERE tc_qcb01 = ? ",
                      "    AND tc_qcb02 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_bcl CURSOR FROM g_forupd_sql    

   LET g_forupd_sql = "SELECT tc_qcc02,tc_qcc03,'',tc_qcc04,tc_qcc05,tc_qcc06,tc_qcc07,tc_qcc08,tc_qcc09, ",
                      "       tc_qcc10,tc_qcc11,tc_qcc12,tc_qcc13,tc_qcc14,tc_qcc15,tc_qcc16,tc_qcc17, ",
                      "       tc_qcc18,tc_qcc19,tc_qcc20,tc_qcc21,tc_qcc22,tc_qcc23 ",
                      "  FROM tc_qcc_file",
                      "  WHERE tc_qcc01 = ? ",    
                      "    AND tc_qcc02 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_bc2 CURSOR FROM g_forupd_sql 

   LET g_forupd_sql = "SELECT tc_qcd02,tc_qcd03,'',tc_qcd04,tc_qcd05,tc_qcd06,tc_qcd07,tc_qcd08,tc_qcd09, ",
                      "       tc_qcd10,tc_qcd11,tc_qcd12,tc_qcd13,tc_qcd14,tc_qcd15,tc_qcd16,tc_qcd17, ",
                      "       tc_qcd18,tc_qcd19,tc_qcd20,tc_qcd21,tc_qcd22,tc_qcd23 ",
                      "  FROM tc_qcd_file",
                      "  WHERE tc_qcd01 = ? ",
                      "    AND tc_qcd02 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_bc3 CURSOR FROM g_forupd_sql 

   LET g_forupd_sql = "SELECT tc_qcf02,tc_qcf03,tc_qcf04,tc_qcf05,tc_qcf06,tc_qcf07,tc_qcf08,tc_qcf09, ",
                      "       tc_qcf10,tc_qcf11,tc_qcf12,tc_qcf13,tc_qcf14,tc_qcf15,tc_qcf16,tc_qcf17, ",
                      "       tc_qcf18,tc_qcf19,tc_qcf20,tc_qcf21 ",
                      "  FROM tc_qcf_file",
                      "  WHERE tc_qcf01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_bc4 CURSOR FROM g_forupd_sql 
 
   #M031 160705 By TSD.james---(S)
   LET g_forupd_sql = "SELECT tc_qcg02,tc_qcg03,'',tc_qcg04,tc_qcg05,tc_qcg06,tc_qcg07,tc_qcg08,tc_qcg09, ",
                      "       tc_qcg10,tc_qcg11,tc_qcg12,tc_qcg13,tc_qcg14,tc_qcg15,tc_qcg16,tc_qcg17, ",
                      "       tc_qcg18,tc_qcg19,tc_qcg20,tc_qcg21,tc_qcg22,tc_qcg23 ",
                      "  FROM tc_qcg_file",
                      "  WHERE tc_qcg01 = ? ",
                      "    AND tc_qcg02 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_bc5 CURSOR FROM g_forupd_sql
   #M031 160705 By TSD.james---(E)
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")

   DIALOG ATTRIBUTE(UNBUFFERED)
      INPUT ARRAY g_tc_qcb FROM s_tc_qcb.*
           ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,INSERT ROW=l_allow_insert,
                     DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
         BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
 
         BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t410_cl USING g_tc_qca.tc_qca01
            IF SQLCA.sqlcode THEN
               CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t410_cl INTO g_tc_qca.*            
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)      
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF

            IF g_rec_b >= l_ac THEN
               LET p_cmd='u' 
               OPEN t410_bcl USING g_tc_qca.tc_qca01,g_tc_qcb[l_ac].tc_qcb02
               IF SQLCA.sqlcode THEN
                  CALL cl_err("OPEN t410_bcl:", SQLCA.sqlcode, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t410_bcl INTO g_tc_qcb[l_ac].*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_qcb_t.tc_qcb02,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  LET g_errno = ' '
                  #M025 160627 By TSD.Lynn mark ---(S)
                  #SELECT azf03
                  #  INTO g_tc_qcb[l_ac].azf03_5
                  #  FROM azf_file
                  # WHERE azf01 = g_tc_qcb[l_ac].tc_qcb03
                  #   AND azf02 = '2'
                  #M025 160627 By TSD.Lynn mark ---(E)
               END IF
               LET g_tc_qcb_t.* = g_tc_qcb[l_ac].* 
               CALL cl_show_fld_cont() 
            END IF
 
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_qcb[l_ac].* TO NULL 
            CALL cl_show_fld_cont()    
            NEXT FIELD tc_qcb02
 
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
           
            LET l_n1 = 0
            SELECT COUNT(*)
              INTO l_n1
              FROM tc_qcb_file
             WHERE tc_qcb01 = g_tc_qca.tc_qca01
               AND tc_qcb02 = g_tc_qcb[l_ac].tc_qcb02
            IF l_n1 > 0 THEN
               CALL cl_err('','-239',1)
               NEXT FIELD tc_qcb02
            END IF
 
            INSERT INTO tc_qcb_file(tc_qcb01,tc_qcb02,tc_qcb03,tc_qcb04,tc_qcb05,tc_qcb06,tc_qcb07,tc_qcb08,tc_qcb09,tc_qcb10,tc_qcb11,tc_qcb12,
                                    tc_qcb13,tc_qcb14,tc_qcb15,tc_qcb16,tc_qcb17,tc_qcb18,tc_qcb19,tc_qcb20,tc_qcb21,tc_qcb22,tc_qcb23)
            VALUES(g_tc_qca.tc_qca01,g_tc_qcb[l_ac].tc_qcb02,g_tc_qcb[l_ac].tc_qcb03,g_tc_qcb[l_ac].tc_qcb04,g_tc_qcb[l_ac].tc_qcb05,
                   g_tc_qcb[l_ac].tc_qcb06,g_tc_qcb[l_ac].tc_qcb07,g_tc_qcb[l_ac].tc_qcb08,g_tc_qcb[l_ac].tc_qcb09,g_tc_qcb[l_ac].tc_qcb10,
                   g_tc_qcb[l_ac].tc_qcb11,g_tc_qcb[l_ac].tc_qcb12,g_tc_qcb[l_ac].tc_qcb13,g_tc_qcb[l_ac].tc_qcb14,g_tc_qcb[l_ac].tc_qcb15,
                   g_tc_qcb[l_ac].tc_qcb16,g_tc_qcb[l_ac].tc_qcb17,g_tc_qcb[l_ac].tc_qcb18,g_tc_qcb[l_ac].tc_qcb19,g_tc_qcb[l_ac].tc_qcb20,
                   g_tc_qcb[l_ac].tc_qcb21,g_tc_qcb[l_ac].tc_qcb22,g_tc_qcb[l_ac].tc_qcb23)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_qcb_file",g_tc_qca.tc_qca01,g_tc_qcb[l_ac].tc_qcb02,SQLCA.sqlcode,"","",1)  
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               COMMIT WORK
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cn2
            END IF
         
         BEFORE FIELD tc_qcb02
            IF cl_null(g_tc_qcb[l_ac].tc_qcb02) OR g_tc_qcb[l_ac].tc_qcb02 = 0 THEN
               SELECT MAX(tc_qcb02)+ 1
                 INTO g_tc_qcb[l_ac].tc_qcb02
                 FROM tc_qcb_file
                WHERE tc_qcb01 = g_tc_qca.tc_qca01

               IF cl_null(g_tc_qcb[l_ac].tc_qcb02) OR  g_tc_qcb[l_ac].tc_qcb02= 0 THEN
                  LET g_tc_qcb[l_ac].tc_qcb02 = 1
               END IF
            END IF

         AFTER FIELD tc_qcb02
            IF NOT cl_null(g_tc_qcb[l_ac].tc_qcb02) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qcb[l_ac].tc_qcb02 <> g_tc_qcb_t.tc_qcb02) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*)
                    INTO l_n1
                    FROM tc_qcb_file
                   WHERE tc_qcb01 = g_tc_qca.tc_qca01
                     AND tc_qcb02 = g_tc_qcb[l_ac].tc_qcb02
                  IF l_n1 > 0 THEN
                     CALL cl_err('','-239',1)
                     NEXT FIELD tc_qcb02
                  END IF
               END IF
            END IF

          AFTER FIELD tc_qcb03
             #M025 160627 By TSD.Lynn mark ---(S)
             #IF NOT cl_null(g_tc_qcb[l_ac].tc_qcb03) THEN
             #   CALL t410_tc_qcb03(g_tc_qcb[l_ac].tc_qcb03) RETURNING g_tc_qcb[l_ac].azf03_5
             #   IF NOT cl_null(g_errno) THEN
             #      CALL cl_err(g_tc_qcb[l_ac].tc_qcb03,g_errno,1)
             #      NEXT FIELD tc_qcb03
             #   END IF  
             #   DISPLAY g_tc_qcb[l_ac].azf03_5 TO azf03_5
             #ELSE
             #   LET g_tc_qcb[l_ac].azf03_5 = NULL
             #   DISPLAY g_tc_qcb[l_ac].azf03_5 TO azf03_5
             #END IF
             #M025 160627 By TSD.Lynn mark ---(E)
 
          BEFORE DELETE                      
             IF g_tc_qcb_t.tc_qcb02 > 0 AND NOT cl_null(g_tc_qcb_t.tc_qcb02) THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF
                DELETE FROM tc_qcb_file
                 WHERE tc_qcb01 = g_tc_qca.tc_qca01
                   AND tc_qcb02 = g_tc_qcb_t.tc_qcb02
                IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                   IF SQLCA.sqlcode = 0 THEN
                      LET SQLCA.sqlcode = 9051
                   END IF
                   CALL cl_err3("del","tc_qcb_file",g_tc_qca.tc_qca01,g_tc_qcb_t.tc_qcb02,SQLCA.sqlcode,"","",1) 
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b=g_rec_b-1
                #CALL g_tc_qcb.deleteElement(l_ac)  #M025 161014 By TSD.Lynn mark
                DISPLAY g_rec_b TO FORMONLY.cn2
             END IF
             COMMIT WORK
 
          ON ROW CHANGE
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                LET g_tc_qcb[l_ac].* = g_tc_qcb_t.*
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             IF l_lock_sw = 'Y' THEN
                CALL cl_err(g_tc_qcb[l_ac].tc_qcb02,-263,1)
                LET g_tc_qcb[l_ac].* = g_tc_qcb_t.*
             ELSE
                IF g_tc_qcb[l_ac].tc_qcb02 <> g_tc_qcb_t.tc_qcb02 THEN
                   LET l_n1 = 0
                   SELECT COUNT(*)
                     INTO l_n1
                     FROM tc_qcb_file
                    WHERE tc_qcb01 = g_tc_qca.tc_qca01
                      AND tc_qcb02 = g_tc_qcb[l_ac].tc_qcb02
                   IF l_n1 > 0 THEN
                      CALL cl_err('','-239',1)     
                      NEXT FIELD tc_qcb02 
                   END IF
                END IF 
                UPDATE tc_qcb_file 
                   SET tc_qcb02 = g_tc_qcb[l_ac].tc_qcb02,
                       tc_qcb03 = g_tc_qcb[l_ac].tc_qcb03,
                       tc_qcb04 = g_tc_qcb[l_ac].tc_qcb04,
                       tc_qcb05 = g_tc_qcb[l_ac].tc_qcb05,
                       tc_qcb06 = g_tc_qcb[l_ac].tc_qcb06,
                       tc_qcb07 = g_tc_qcb[l_ac].tc_qcb07,
                       tc_qcb08 = g_tc_qcb[l_ac].tc_qcb08,
                       tc_qcb09 = g_tc_qcb[l_ac].tc_qcb09,
                       tc_qcb10 = g_tc_qcb[l_ac].tc_qcb10,  
                       tc_qcb11 = g_tc_qcb[l_ac].tc_qcb11,  
                       tc_qcb12 = g_tc_qcb[l_ac].tc_qcb12,  
                       tc_qcb13 = g_tc_qcb[l_ac].tc_qcb13, 
                       tc_qcb14 = g_tc_qcb[l_ac].tc_qcb14,  
                       tc_qcb15 = g_tc_qcb[l_ac].tc_qcb15,  
                       tc_qcb16 = g_tc_qcb[l_ac].tc_qcb16,  
                       tc_qcb17 = g_tc_qcb[l_ac].tc_qcb17,  
                       tc_qcb18 = g_tc_qcb[l_ac].tc_qcb18,  
                       tc_qcb19 = g_tc_qcb[l_ac].tc_qcb19,  
                       tc_qcb20 = g_tc_qcb[l_ac].tc_qcb20,  
                       tc_qcb21 = g_tc_qcb[l_ac].tc_qcb21,  
                       tc_qcb22 = g_tc_qcb[l_ac].tc_qcb22,  
                       tc_qcb23 = g_tc_qcb[l_ac].tc_qcb23
                 WHERE tc_qcb01 = g_tc_qca.tc_qca01
                   AND tc_qcb02 = g_tc_qcb_t.tc_qcb02
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_qcb_file",g_tc_qca.tc_qca01,g_tc_qcb_t.tc_qcb02,SQLCA.sqlcode,"","",1)
                   LET g_tc_qcb[l_ac].* = g_tc_qcb_t.*
                ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
                END IF
             END IF
 
          AFTER ROW
             LET l_ac = ARR_CURR()
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                IF p_cmd = 'u' THEN
                   LET g_tc_qcb[l_ac].* = g_tc_qcb_t.*
                ELSE
                   CALL g_tc_qcb.deleteElement(l_ac)
                   IF g_rec_b != 0 THEN
                      LET g_action_choice = "detail"
                      LET l_ac = l_ac_t
                   END IF
                END IF
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             LET l_ac_t = l_ac  
             CLOSE t410_bcl
             COMMIT WORK

      END INPUT
   
      INPUT ARRAY g_tc_qcc FROM s_tc_qcc.*
           ATTRIBUTE(COUNT=g_rec_b1,MAXCOUNT=g_max_rec,INSERT ROW=l_allow_insert,
                     DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
         BEFORE INPUT
            IF g_rec_b1 != 0 THEN
               CALL fgl_set_arr_curr(l_ac1)
            END IF
 
         BEFORE ROW
            LET p_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET l_lock_sw = 'N'            
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t410_cl USING g_tc_qca.tc_qca01
            IF SQLCA.sqlcode THEN
               CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t410_cl INTO g_tc_qca.*            
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)      
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF
 
            IF g_rec_b1 >= l_ac1 THEN
               LET p_cmd='u'
               OPEN t410_bc2 USING g_tc_qca.tc_qca01,g_tc_qcc[l_ac1].tc_qcc02
               IF SQLCA.sqlcode THEN
                  CALL cl_err("OPEN t410_bcl:", SQLCA.sqlcode, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t410_bc2 INTO g_tc_qcc[l_ac1].*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_qcc_t.tc_qcc02,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  LET g_errno = ' '
                  #M025 160627 By TSD.Lynn mark ---(S)
                  #SELECT azf03
                  #  INTO g_tc_qcc[l_ac1].azf03_6
                  #  FROM azf_file
                  # WHERE azf01 = g_tc_qcc[l_ac1].tc_qcc03
                  #   AND azf02 = '2'
                  #M025 160627 By TSD.Lynn mark ---(E)
               END IF
               LET g_tc_qcc_t.* = g_tc_qcc[l_ac1].* 
               CALL cl_show_fld_cont() 
            END IF
 
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_qcc[l_ac1].* TO NULL 
            CALL cl_show_fld_cont()    
            NEXT FIELD tc_qcc02
 
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
           
            LET l_n1 = 0
            SELECT COUNT(*)
              INTO l_n1
              FROM tc_qcc_file
             WHERE tc_qcc01 = g_tc_qca.tc_qca01
               AND tc_qcc02 = g_tc_qcc[l_ac1].tc_qcc02
            IF l_n1 > 0 THEN
               CALL cl_err('','-239',1)
               NEXT FIELD tc_qcc02
            END IF
 
            INSERT INTO tc_qcc_file(tc_qcc01,tc_qcc02,tc_qcc03,tc_qcc04,tc_qcc05,tc_qcc06,tc_qcc07,tc_qcc08,tc_qcc09,tc_qcc10,tc_qcc11,tc_qcc12,
                                    tc_qcc13,tc_qcc14,tc_qcc15,tc_qcc16,tc_qcc17,tc_qcc18,tc_qcc19,tc_qcc20,tc_qcc21,tc_qcc22,tc_qcc23)
            VALUES(g_tc_qca.tc_qca01,g_tc_qcc[l_ac1].tc_qcc02,g_tc_qcc[l_ac1].tc_qcc03,g_tc_qcc[l_ac1].tc_qcc04,g_tc_qcc[l_ac1].tc_qcc05,
                   g_tc_qcc[l_ac1].tc_qcc06,g_tc_qcc[l_ac1].tc_qcc07,g_tc_qcc[l_ac1].tc_qcc08,g_tc_qcc[l_ac1].tc_qcc09,g_tc_qcc[l_ac1].tc_qcc10,
                   g_tc_qcc[l_ac1].tc_qcc11,g_tc_qcc[l_ac1].tc_qcc12,g_tc_qcc[l_ac1].tc_qcc13,g_tc_qcc[l_ac1].tc_qcc14,g_tc_qcc[l_ac1].tc_qcc15,
                   g_tc_qcc[l_ac1].tc_qcc16,g_tc_qcc[l_ac1].tc_qcc17,g_tc_qcc[l_ac1].tc_qcc18,g_tc_qcc[l_ac1].tc_qcc19,g_tc_qcc[l_ac1].tc_qcc20,
                   g_tc_qcc[l_ac1].tc_qcc21,g_tc_qcc[l_ac1].tc_qcc22,g_tc_qcc[l_ac1].tc_qcc23)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_qcc_file",g_tc_qca.tc_qca01,g_tc_qcc[l_ac1].tc_qcc02,SQLCA.sqlcode,"","",1)  
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               COMMIT WORK
               LET g_rec_b1=g_rec_b1+1
               DISPLAY g_rec_b1 TO FORMONLY.cn2
            END IF
         
         BEFORE FIELD tc_qcc02
            IF cl_null(g_tc_qcc[l_ac1].tc_qcc02) OR g_tc_qcc[l_ac1].tc_qcc02 = 0 THEN
               SELECT MAX(tc_qcc02)+ 1
                 INTO g_tc_qcc[l_ac1].tc_qcc02
                 FROM tc_qcc_file
                WHERE tc_qcc01 = g_tc_qca.tc_qca01

               IF cl_null(g_tc_qcc[l_ac1].tc_qcc02) OR  g_tc_qcc[l_ac1].tc_qcc02= 0 THEN
                  LET g_tc_qcc[l_ac1].tc_qcc02 = 1
               END IF
            END IF

         AFTER FIELD tc_qcc02
            IF NOT cl_null(g_tc_qcc[l_ac1].tc_qcc02) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qcc[l_ac1].tc_qcc02 <> g_tc_qcc_t.tc_qcc02) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*)
                    INTO l_n1
                    FROM tc_qcc_file
                   WHERE tc_qcc01 = g_tc_qca.tc_qca01
                     AND tc_qcc02 = g_tc_qcc[l_ac1].tc_qcc02
                  IF l_n1 > 0 THEN
                     CALL cl_err('','-239',1)
                     NEXT FIELD tc_qcc02
                  END IF
               END IF
            END IF

          AFTER FIELD tc_qcc03
             #M025 160627 By TSD.Lynn mark ---(S)
             #IF NOT cl_null(g_tc_qcc[l_ac1].tc_qcc03) THEN
             #   CALL t410_tc_qcb03(g_tc_qcc[l_ac1].tc_qcc03) RETURNING g_tc_qcc[l_ac1].azf03_6
             #   IF NOT cl_null(g_errno) THEN
             #      CALL cl_err(g_tc_qcc[l_ac1].tc_qcc03,g_errno,1)
             #      NEXT FIELD tc_qcc03
             #   END IF  
             #   DISPLAY g_tc_qcc[l_ac1].azf03_6 TO azf03_6
             #ELSE
             #   LET g_tc_qcc[l_ac1].azf03_6 = NULL
             #   DISPLAY g_tc_qcc[l_ac1].azf03_6 TO azf03_6
             #END IF
             #M025 160627 By TSD.Lynn mark ---(E)
 
          BEFORE DELETE                      
             IF g_tc_qcc_t.tc_qcc02 > 0 AND NOT cl_null(g_tc_qcc_t.tc_qcc02) THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF
                DELETE FROM tc_qcc_file
                 WHERE tc_qcc01 = g_tc_qca.tc_qca01
                   AND tc_qcc02 = g_tc_qcc_t.tc_qcc02
                IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                   IF SQLCA.sqlcode = 0 THEN
                      LET SQLCA.sqlcode = 9051
                   END IF
                   CALL cl_err3("del","tc_qcc_file",g_tc_qca.tc_qca01,g_tc_qcc_t.tc_qcc02,SQLCA.sqlcode,"","",1) 
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b1=g_rec_b1-1
                #M025 1616 By TSD.Lynn mod ---(S)
                #CALL g_tc_qcb.deleteElement(l_ac1)  
                CALL g_tc_qcc.deleteElement(l_ac1)  
                #M025 1616 By TSD.Lynn mod ---(E)
                DISPLAY g_rec_b1 TO FORMONLY.cn2
             END IF
             COMMIT WORK
             CLOSE t410_bc2
 
          ON ROW CHANGE
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                LET g_tc_qcc[l_ac1].* = g_tc_qcc_t.*
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             IF l_lock_sw = 'Y' THEN
                CALL cl_err(g_tc_qcc[l_ac1].tc_qcc02,-263,1)
                LET g_tc_qcc[l_ac1].* = g_tc_qcc_t.*
             ELSE
                IF g_tc_qcc[l_ac1].tc_qcc02 <> g_tc_qcc_t.tc_qcc02 THEN
                   LET l_n1 = 0
                   SELECT COUNT(*)
                     INTO l_n1
                     FROM tc_qcc_file
                    WHERE tc_qcc01 = g_tc_qca.tc_qca01
                      AND tc_qcc02 = g_tc_qcc[l_ac1].tc_qcc02
                   IF l_n1 > 0 THEN
                      CALL cl_err('','-239',1)     
                      NEXT FIELD tc_qcc02 
                   END IF
                END IF 
                UPDATE tc_qcc_file 
                   SET tc_qcc02 = g_tc_qcc[l_ac1].tc_qcc02,
                       tc_qcc03 = g_tc_qcc[l_ac1].tc_qcc03,
                       tc_qcc04 = g_tc_qcc[l_ac1].tc_qcc04,
                       tc_qcc05 = g_tc_qcc[l_ac1].tc_qcc05,
                       tc_qcc06 = g_tc_qcc[l_ac1].tc_qcc06,
                       tc_qcc07 = g_tc_qcc[l_ac1].tc_qcc07,
                       tc_qcc08 = g_tc_qcc[l_ac1].tc_qcc08,
                       tc_qcc09 = g_tc_qcc[l_ac1].tc_qcc09,
                       tc_qcc10 = g_tc_qcc[l_ac1].tc_qcc10,  
                       tc_qcc11 = g_tc_qcc[l_ac1].tc_qcc11,  
                       tc_qcc12 = g_tc_qcc[l_ac1].tc_qcc12,  
                       tc_qcc13 = g_tc_qcc[l_ac1].tc_qcc13, 
                       tc_qcc14 = g_tc_qcc[l_ac1].tc_qcc14,  
                       tc_qcc15 = g_tc_qcc[l_ac1].tc_qcc15,  
                       tc_qcc16 = g_tc_qcc[l_ac1].tc_qcc16,  
                       tc_qcc17 = g_tc_qcc[l_ac1].tc_qcc17,  
                       tc_qcc18 = g_tc_qcc[l_ac1].tc_qcc18,  
                       tc_qcc19 = g_tc_qcc[l_ac1].tc_qcc19,  
                       tc_qcc20 = g_tc_qcc[l_ac1].tc_qcc20,  
                       tc_qcc21 = g_tc_qcc[l_ac1].tc_qcc21,  
                       tc_qcc22 = g_tc_qcc[l_ac1].tc_qcc22,  
                       tc_qcc23 = g_tc_qcc[l_ac1].tc_qcc23
                 WHERE tc_qcc01 = g_tc_qca.tc_qca01
                   AND tc_qcc02 = g_tc_qcc_t.tc_qcc02
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_qcc_file",g_tc_qca.tc_qca01,g_tc_qcc_t.tc_qcc02,SQLCA.sqlcode,"","",1)
                   LET g_tc_qcc[l_ac1].* = g_tc_qcc_t.*
                ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
                   CLOSE t410_bc2
                END IF
             END IF
 
          AFTER ROW
             LET l_ac1 = ARR_CURR()
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                IF p_cmd = 'u' THEN
                   LET g_tc_qcc[l_ac1].* = g_tc_qcc_t.*
                ELSE
                   CALL g_tc_qcc.deleteElement(l_ac1)
                   IF g_rec_b1 != 0 THEN
                      LET g_action_choice = "detail"
                      LET l_ac1 = l_ac1_t
                   END IF
                END IF
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             LET l_ac1_t = l_ac1  
             CLOSE t410_bcl
             COMMIT WORK

      END INPUT
   
      INPUT ARRAY g_tc_qcd FROM s_tc_qcd.*
           ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,INSERT ROW=l_allow_insert,
                     DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
         BEFORE INPUT
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
 
         BEFORE ROW
            LET p_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t410_cl USING g_tc_qca.tc_qca01
            IF SQLCA.sqlcode THEN
               CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t410_cl INTO g_tc_qca.*            
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)      
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF
 
            IF g_rec_b2 >= l_ac2 THEN
               LET p_cmd='u'
               OPEN t410_bc3 USING g_tc_qca.tc_qca01,g_tc_qcd[l_ac2].tc_qcd02
               IF SQLCA.sqlcode THEN
                  CALL cl_err("OPEN t410_bcl:", SQLCA.sqlcode, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t410_bc3 INTO g_tc_qcd[l_ac2].*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_qcd_t.tc_qcd02,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  LET g_errno = ' '
                  SELECT azf03
                    INTO g_tc_qcd[l_ac2].azf03_7
                    FROM azf_file
                   WHERE azf01 = g_tc_qcd[l_ac2].tc_qcd03
                     AND azf02 = '2'
               END IF
               LET g_tc_qcd_t.* = g_tc_qcd[l_ac2].* 
               CALL cl_show_fld_cont() 
            END IF
 
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_qcd[l_ac2].* TO NULL 
            CALL cl_show_fld_cont()    
            NEXT FIELD tc_qcd02
 
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
           
            LET l_n1 = 0
            SELECT COUNT(*)
              INTO l_n1
              FROM tc_qcd_file
             WHERE tc_qcd01 = g_tc_qca.tc_qca01
               AND tc_qcd02 = g_tc_qcd[l_ac2].tc_qcd02
            IF l_n1 > 0 THEN
               CALL cl_err('','-239',1)
               NEXT FIELD tc_qcd02
            END IF
 
            INSERT INTO tc_qcd_file(tc_qcd01,tc_qcd02,tc_qcd03,tc_qcd04,tc_qcd05,tc_qcd06,tc_qcd07,tc_qcd08,tc_qcd09,tc_qcd10,tc_qcd11,tc_qcd12,
                                    tc_qcd13,tc_qcd14,tc_qcd15,tc_qcd16,tc_qcd17,tc_qcd18,tc_qcd19,tc_qcd20,tc_qcd21,tc_qcd22,tc_qcd23)
            VALUES(g_tc_qca.tc_qca01,g_tc_qcd[l_ac2].tc_qcd02,g_tc_qcd[l_ac2].tc_qcd03,g_tc_qcd[l_ac2].tc_qcd04,g_tc_qcd[l_ac2].tc_qcd05,
                   g_tc_qcd[l_ac2].tc_qcd06,g_tc_qcd[l_ac2].tc_qcd07,g_tc_qcd[l_ac2].tc_qcd08,g_tc_qcd[l_ac2].tc_qcd09,g_tc_qcd[l_ac2].tc_qcd10,
                   g_tc_qcd[l_ac2].tc_qcd11,g_tc_qcd[l_ac2].tc_qcd12,g_tc_qcd[l_ac2].tc_qcd13,g_tc_qcd[l_ac2].tc_qcd14,g_tc_qcd[l_ac2].tc_qcd15,
                   g_tc_qcd[l_ac2].tc_qcd16,g_tc_qcd[l_ac2].tc_qcd17,g_tc_qcd[l_ac2].tc_qcd18,g_tc_qcd[l_ac2].tc_qcd19,g_tc_qcd[l_ac2].tc_qcd20,
                   g_tc_qcd[l_ac2].tc_qcd21,g_tc_qcd[l_ac2].tc_qcd22,g_tc_qcd[l_ac2].tc_qcd23)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_qcd_file",g_tc_qca.tc_qca01,g_tc_qcd[l_ac2].tc_qcd02,SQLCA.sqlcode,"","",1)  
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               COMMIT WORK
               LET g_rec_b2=g_rec_b2+1
               DISPLAY g_rec_b2 TO FORMONLY.cn2
            END IF
         
         BEFORE FIELD tc_qcd02
            IF cl_null(g_tc_qcd[l_ac2].tc_qcd02) OR g_tc_qcd[l_ac2].tc_qcd02 = 0 THEN
               SELECT MAX(tc_qcd02)+ 1
                 INTO g_tc_qcd[l_ac2].tc_qcd02
                 FROM tc_qcd_file
                WHERE tc_qcd01 = g_tc_qca.tc_qca01

               IF cl_null(g_tc_qcd[l_ac2].tc_qcd02) OR  g_tc_qcd[l_ac2].tc_qcd02= 0 THEN
                  LET g_tc_qcd[l_ac2].tc_qcd02 = 1
               END IF
            END IF

         AFTER FIELD tc_qcd02
            IF NOT cl_null(g_tc_qcd[l_ac2].tc_qcd02) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qcd[l_ac2].tc_qcd02 <> g_tc_qcd_t.tc_qcd02) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*)
                    INTO l_n1
                    FROM tc_qcd_file
                   WHERE tc_qcd01 = g_tc_qca.tc_qca01
                     AND tc_qcd02 = g_tc_qcd[l_ac2].tc_qcd02
                  IF l_n1 > 0 THEN
                     CALL cl_err('','-239',1)
                     NEXT FIELD tc_qcd02
                  END IF
               END IF
            END IF

          #M025 160620 By TSD.james---(S)
          #AFTER FIELD tc_qcd03
          #   IF NOT cl_null(g_tc_qcd[l_ac2].tc_qcd03) THEN
          #      CALL t410_tc_qcb03(g_tc_qcd[l_ac2].tc_qcd03) RETURNING g_tc_qcd[l_ac2].azf03_7
          #      IF NOT cl_null(g_errno) THEN
          #         CALL cl_err(g_tc_qcd[l_ac2].tc_qcd03,g_errno,1)
          #         NEXT FIELD tc_qcd03
          #      END IF  
          #      DISPLAY g_tc_qcd[l_ac2].azf03_7 TO azf03_7
          #   ELSE
          #      LET g_tc_qcd[l_ac2].azf03_7 = NULL
          #      DISPLAY g_tc_qcd[l_ac2].azf03_7 TO azf03_7
          #   END IF
          #M025 160620 By TSD.james---(E)
 
          BEFORE DELETE                      
             IF g_tc_qcd_t.tc_qcd02 > 0 AND NOT cl_null(g_tc_qcd_t.tc_qcd02) THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF
                DELETE FROM tc_qcd_file
                 WHERE tc_qcd01 = g_tc_qca.tc_qca01
                   AND tc_qcd02 = g_tc_qcd_t.tc_qcd02
                IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                   IF SQLCA.sqlcode = 0 THEN
                      LET SQLCA.sqlcode = 9051
                   END IF
                   CALL cl_err3("del","tc_qcd_file",g_tc_qca.tc_qca01,g_tc_qcd_t.tc_qcd02,SQLCA.sqlcode,"","",1) 
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b2=g_rec_b2-1
                #M025 1616 By TSD.Lynn mod ---(S)
                #CALL g_tc_qcb.deleteElement(l_ac2)
                #CALL g_tc_qcd.deleteElement(l_ac2) #M025 161014 By TSD.Lynn mark
                #M025 1616 By TSD.Lynn mod ---(E)
                DISPLAY g_rec_b2 TO FORMONLY.cn2
             END IF
             COMMIT WORK
             CLOSE t410_bc3
 
          ON ROW CHANGE
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                LET g_tc_qcd[l_ac2].* = g_tc_qcd_t.*
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             IF l_lock_sw = 'Y' THEN
                CALL cl_err(g_tc_qcd[l_ac2].tc_qcd02,-263,1)
                LET g_tc_qcd[l_ac2].* = g_tc_qcd_t.*
             ELSE
                IF g_tc_qcd[l_ac2].tc_qcd02 <> g_tc_qcd_t.tc_qcd02 THEN
                   LET l_n1 = 0
                   SELECT COUNT(*)
                     INTO l_n1
                     FROM tc_qcd_file
                    WHERE tc_qcd01 = g_tc_qca.tc_qca01
                      AND tc_qcd02 = g_tc_qcd[l_ac2].tc_qcd02
                   IF l_n1 > 0 THEN
                      CALL cl_err('','-239',1)     
                      NEXT FIELD tc_qcd02 
                   END IF
                END IF 
                UPDATE tc_qcd_file 
                   SET tc_qcd02 = g_tc_qcd[l_ac2].tc_qcd02,
                       tc_qcd03 = g_tc_qcd[l_ac2].tc_qcd03,
                       tc_qcd04 = g_tc_qcd[l_ac2].tc_qcd04,
                       tc_qcd05 = g_tc_qcd[l_ac2].tc_qcd05,
                       tc_qcd06 = g_tc_qcd[l_ac2].tc_qcd06,
                       tc_qcd07 = g_tc_qcd[l_ac2].tc_qcd07,
                       tc_qcd08 = g_tc_qcd[l_ac2].tc_qcd08,
                       tc_qcd09 = g_tc_qcd[l_ac2].tc_qcd09,
                       tc_qcd10 = g_tc_qcd[l_ac2].tc_qcd10,  
                       tc_qcd11 = g_tc_qcd[l_ac2].tc_qcd11,  
                       tc_qcd12 = g_tc_qcd[l_ac2].tc_qcd12,  
                       tc_qcd13 = g_tc_qcd[l_ac2].tc_qcd13, 
                       tc_qcd14 = g_tc_qcd[l_ac2].tc_qcd14,  
                       tc_qcd15 = g_tc_qcd[l_ac2].tc_qcd15,  
                       tc_qcd16 = g_tc_qcd[l_ac2].tc_qcd16,  
                       tc_qcd17 = g_tc_qcd[l_ac2].tc_qcd17,  
                       tc_qcd18 = g_tc_qcd[l_ac2].tc_qcd18,  
                       tc_qcd19 = g_tc_qcd[l_ac2].tc_qcd19,  
                       tc_qcd20 = g_tc_qcd[l_ac2].tc_qcd20,  
                       tc_qcd21 = g_tc_qcd[l_ac2].tc_qcd21,  
                       tc_qcd22 = g_tc_qcd[l_ac2].tc_qcd22,  
                       tc_qcd23 = g_tc_qcd[l_ac2].tc_qcd23
                 WHERE tc_qcd01 = g_tc_qca.tc_qca01
                   AND tc_qcd02 = g_tc_qcd_t.tc_qcd02
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_qcd_file",g_tc_qca.tc_qca01,g_tc_qcd_t.tc_qcd02,SQLCA.sqlcode,"","",1)
                   LET g_tc_qcd[l_ac2].* = g_tc_qcd_t.*
                ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
                   CLOSE t410_bc3
                END IF
             END IF
 
          AFTER ROW
             LET l_ac2 = ARR_CURR()
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                IF p_cmd = 'u' THEN
                   LET g_tc_qcd[l_ac2].* = g_tc_qcd_t.*
                ELSE
                   CALL g_tc_qcd.deleteElement(l_ac2)
                   IF g_rec_b2 != 0 THEN
                      LET g_action_choice = "detail"
                      LET l_ac2 = l_ac2_t
                   END IF
                END IF
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             LET l_ac2_t = l_ac2  
             CLOSE t410_bcl
             COMMIT WORK

      END INPUT

      #M031 160705 By TSD.james---(S)
      INPUT ARRAY g_tc_qcg FROM s_tc_qcg.*
           ATTRIBUTE(COUNT=g_rec_b3,MAXCOUNT=g_max_rec,INSERT ROW=l_allow_insert,
                     DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
         BEFORE INPUT
            IF g_rec_b3 != 0 THEN
               CALL fgl_set_arr_curr(l_ac3)
            END IF
 
         BEFORE ROW
            LET p_cmd = ''
            LET l_ac3 = ARR_CURR()
            LET l_lock_sw = 'N'            
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t410_cl USING g_tc_qca.tc_qca01
            IF SQLCA.sqlcode THEN
               CALL cl_err("OPEN t410_cl:", SQLCA.sqlcode, 1)
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t410_cl INTO g_tc_qca.*            
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_tc_qca.tc_qca01,SQLCA.sqlcode,0)      
               CLOSE t410_cl
               ROLLBACK WORK
               RETURN
            END IF
 
            IF g_rec_b3 >= l_ac3 THEN
               LET p_cmd='u'
               OPEN t410_bc5 USING g_tc_qca.tc_qca01,g_tc_qcg[l_ac3].tc_qcg02
               IF SQLCA.sqlcode THEN
                  CALL cl_err("OPEN t410_bc5:", SQLCA.sqlcode, 1)
                  LET l_lock_sw = "Y"
                  CLOSE t410_bc5
               ELSE
                  FETCH t410_bc5 INTO g_tc_qcg[l_ac3].*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_qcg_t.tc_qcg02,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                     CLOSE t410_bc5
                  END IF
                  LET g_errno = ' '
               END IF
               LET g_tc_qcg_t.* = g_tc_qcg[l_ac3].* 
               CALL cl_show_fld_cont() 
            END IF
 
         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_qcg[l_ac3].* TO NULL 
            CALL cl_show_fld_cont()    
            NEXT FIELD tc_qcg02
 
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
           
            LET l_n1 = 0
            SELECT COUNT(*)
              INTO l_n1
              FROM tc_qcg_file
             WHERE tc_qcg01 = g_tc_qca.tc_qca01
               AND tc_qcg02 = g_tc_qcg[l_ac3].tc_qcg02
            IF l_n1 > 0 THEN
               CALL cl_err('','-239',1)
               NEXT FIELD tc_qcg02
            END IF
 
            INSERT INTO tc_qcg_file(tc_qcg01,tc_qcg02,tc_qcg03,tc_qcg04,tc_qcg05,tc_qcg06,tc_qcg07,tc_qcg08,tc_qcg09,tc_qcg10,tc_qcg11,tc_qcg12,
                                    tc_qcg13,tc_qcg14,tc_qcg15,tc_qcg16,tc_qcg17,tc_qcg18,tc_qcg19,tc_qcg20,tc_qcg21,tc_qcg22,tc_qcg23)
            VALUES(g_tc_qca.tc_qca01,g_tc_qcg[l_ac3].tc_qcg02,g_tc_qcg[l_ac3].tc_qcg03,g_tc_qcg[l_ac3].tc_qcg04,g_tc_qcg[l_ac3].tc_qcg05,
                   g_tc_qcg[l_ac3].tc_qcg06,g_tc_qcg[l_ac3].tc_qcg07,g_tc_qcg[l_ac3].tc_qcg08,g_tc_qcg[l_ac3].tc_qcg09,g_tc_qcg[l_ac3].tc_qcg10,
                   g_tc_qcg[l_ac3].tc_qcg11,g_tc_qcg[l_ac3].tc_qcg12,g_tc_qcg[l_ac3].tc_qcg13,g_tc_qcg[l_ac3].tc_qcg14,g_tc_qcg[l_ac3].tc_qcg15,
                   g_tc_qcg[l_ac3].tc_qcg16,g_tc_qcg[l_ac3].tc_qcg17,g_tc_qcg[l_ac3].tc_qcg18,g_tc_qcg[l_ac3].tc_qcg19,g_tc_qcg[l_ac3].tc_qcg20,
                   g_tc_qcg[l_ac3].tc_qcg21,g_tc_qcg[l_ac3].tc_qcg22,g_tc_qcg[l_ac3].tc_qcg23)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_qcg_file",g_tc_qca.tc_qca01,g_tc_qcg[l_ac3].tc_qcg02,SQLCA.sqlcode,"","",1)  
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               COMMIT WORK
               LET g_rec_b3=g_rec_b3+1
               DISPLAY g_rec_b3 TO FORMONLY.cn2
            END IF
         
         BEFORE FIELD tc_qcg02
            IF cl_null(g_tc_qcg[l_ac3].tc_qcg02) OR g_tc_qcg[l_ac3].tc_qcg02 = 0 THEN
               SELECT MAX(tc_qcg02)+ 1
                 INTO g_tc_qcg[l_ac3].tc_qcg02
                 FROM tc_qcg_file
                WHERE tc_qcg01 = g_tc_qca.tc_qca01

               IF cl_null(g_tc_qcg[l_ac3].tc_qcg02) OR  g_tc_qcg[l_ac3].tc_qcg02= 0 THEN
                  LET g_tc_qcg[l_ac3].tc_qcg02 = 1
               END IF
            END IF

         AFTER FIELD tc_qcg02
            IF NOT cl_null(g_tc_qcg[l_ac3].tc_qcg02) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qcg[l_ac3].tc_qcg02 <> g_tc_qcg_t.tc_qcg02) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*)
                    INTO l_n1
                    FROM tc_qcg_file
                   WHERE tc_qcg01 = g_tc_qca.tc_qca01
                     AND tc_qcg02 = g_tc_qcg[l_ac3].tc_qcg02
                  IF l_n1 > 0 THEN
                     CALL cl_err('','-239',1)
                     NEXT FIELD tc_qcg02
                  END IF
               END IF
            END IF

          AFTER FIELD tc_qcg03
             IF NOT cl_null(g_tc_qcg[l_ac3].tc_qcg03) THEN
             END IF
 
          BEFORE DELETE                      
             IF g_tc_qcg_t.tc_qcg02 > 0 AND NOT cl_null(g_tc_qcg_t.tc_qcg02) THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF
                DELETE FROM tc_qcg_file
                 WHERE tc_qcg01 = g_tc_qca.tc_qca01
                   AND tc_qcg02 = g_tc_qcg_t.tc_qcg02
                IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                   IF SQLCA.sqlcode = 0 THEN
                      LET SQLCA.sqlcode = 9051
                   END IF
                   CALL cl_err3("del","tc_qcg_file",g_tc_qca.tc_qca01,g_tc_qcg_t.tc_qcg02,SQLCA.sqlcode,"","",1) 
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b3=g_rec_b3-1
                #CALL g_tc_qcg.deleteElement(l_ac3)  #M025 161014 By TSD.Lynn mark
                DISPLAY g_rec_b3 TO FORMONLY.cn2
             END IF
             COMMIT WORK
             CLOSE t410_bc5
 
          ON ROW CHANGE
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                LET g_tc_qcg[l_ac3].* = g_tc_qcg_t.*
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             IF l_lock_sw = 'Y' THEN
                CALL cl_err(g_tc_qcg[l_ac3].tc_qcg02,-263,1)
                LET g_tc_qcg[l_ac3].* = g_tc_qcg_t.*
             ELSE
                IF g_tc_qcg[l_ac3].tc_qcg02 <> g_tc_qcg_t.tc_qcg02 THEN
                   LET l_n1 = 0
                   SELECT COUNT(*)
                     INTO l_n1
                     FROM tc_qcg_file
                    WHERE tc_qcg01 = g_tc_qca.tc_qca01
                      AND tc_qcg02 = g_tc_qcg[l_ac3].tc_qcg02
                   IF l_n1 > 0 THEN
                      CALL cl_err('','-239',1)     
                      NEXT FIELD tc_qcg02 
                   END IF
                END IF 
                UPDATE tc_qcg_file 
                   SET tc_qcg02 = g_tc_qcg[l_ac3].tc_qcg02,
                       tc_qcg03 = g_tc_qcg[l_ac3].tc_qcg03,
                       tc_qcg04 = g_tc_qcg[l_ac3].tc_qcg04,
                       tc_qcg05 = g_tc_qcg[l_ac3].tc_qcg05,
                       tc_qcg06 = g_tc_qcg[l_ac3].tc_qcg06,
                       tc_qcg07 = g_tc_qcg[l_ac3].tc_qcg07,
                       tc_qcg08 = g_tc_qcg[l_ac3].tc_qcg08,
                       tc_qcg09 = g_tc_qcg[l_ac3].tc_qcg09,
                       tc_qcg10 = g_tc_qcg[l_ac3].tc_qcg10,  
                       tc_qcg11 = g_tc_qcg[l_ac3].tc_qcg11,  
                       tc_qcg12 = g_tc_qcg[l_ac3].tc_qcg12,  
                       tc_qcg13 = g_tc_qcg[l_ac3].tc_qcg13, 
                       tc_qcg14 = g_tc_qcg[l_ac3].tc_qcg14,  
                       tc_qcg15 = g_tc_qcg[l_ac3].tc_qcg15,  
                       tc_qcg16 = g_tc_qcg[l_ac3].tc_qcg16,  
                       tc_qcg17 = g_tc_qcg[l_ac3].tc_qcg17,  
                       tc_qcg18 = g_tc_qcg[l_ac3].tc_qcg18,  
                       tc_qcg19 = g_tc_qcg[l_ac3].tc_qcg19,  
                       tc_qcg20 = g_tc_qcg[l_ac3].tc_qcg20,  
                       tc_qcg21 = g_tc_qcg[l_ac3].tc_qcg21,  
                       tc_qcg22 = g_tc_qcg[l_ac3].tc_qcg22,  
                       tc_qcg23 = g_tc_qcg[l_ac3].tc_qcg23
                 WHERE tc_qcg01 = g_tc_qca.tc_qca01
                   AND tc_qcg02 = g_tc_qcg_t.tc_qcg02
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_qcg_file",g_tc_qca.tc_qca01,g_tc_qcg_t.tc_qcg02,SQLCA.sqlcode,"","",1)
                   LET g_tc_qcg[l_ac3].* = g_tc_qcg_t.*
                ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
                   CLOSE t410_bc5
                END IF
             END IF
 
          AFTER ROW
             LET l_ac3 = ARR_CURR()
             IF INT_FLAG THEN
                CALL cl_err('',9001,0)
                LET INT_FLAG = 0
                IF p_cmd = 'u' THEN
                   LET g_tc_qcg[l_ac3].* = g_tc_qcg_t.*
                ELSE
                   CALL g_tc_qcg.deleteElement(l_ac3)
                   IF g_rec_b3 != 0 THEN
                      LET g_action_choice = "detail"
                      LET l_ac3 = l_ac3_t
                   END IF
                END IF
                CLOSE t410_bcl
                ROLLBACK WORK
                EXIT DIALOG
             END IF
             LET l_ac3_t = l_ac3  
             CLOSE t410_bcl
             COMMIT WORK

      END INPUT
      #M031 160705 By TSD.james---(E)

      INPUT BY NAME g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,g_tc_qcf.tc_qcf07,
                    g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,g_tc_qcf.tc_qcf13,
                    g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,g_tc_qcf.tc_qcf19,
                    g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21
         ATTRIBUTE(WITHOUT DEFAULTS=TRUE)   #M045 161114 By TSD.nick

         BEFORE INPUT 
            LET l_n1 = 0
            SELECT COUNT(*)
              INTO l_n1
              FROM tc_qcf_file
             WHERE tc_qcf01 = g_tc_qca.tc_qca01

            IF l_n1 > 0 THEN
               LET p_cmd = 'u'

               BEGIN WORK
               OPEN t410_bc4 USING g_tc_qca.tc_qca01
               IF SQLCA.sqlcode THEN
                  CALL cl_err("OPEN t410_bc4:", SQLCA.sqlcode, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  #M045 161114 By TSD.nick ===(s)
                  #FETCH t410_bc4 INTO g_tc_qcf.*
                  #原變數定義是整個table，會與SELECT語法對不上
                  FETCH t410_bc4 INTO g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,
                                      g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,g_tc_qcf.tc_qcf07,
                                      g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,
                                      g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,g_tc_qcf.tc_qcf13,
                                      g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,
                                      g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,g_tc_qcf.tc_qcf19,
                                      g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21

                  DISPLAY BY NAME 
                     g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,
                     g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,g_tc_qcf.tc_qcf07,
                     g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,
                     g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,g_tc_qcf.tc_qcf13,
                     g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,
                     g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,g_tc_qcf.tc_qcf19,
                     g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21
                  #M045 161114 By TSD.nick ===(e)
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_qcf_t.tc_qcf02,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
               END IF

            ELSE
               LET p_cmd = 'a'
            END IF

         AFTER INPUT 
            IF p_cmd = 'a' THEN
               INSERT INTO tc_qcf_file
               VALUES(g_tc_qca.tc_qca01,g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,
                      g_tc_qcf.tc_qcf07,g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,
                      g_tc_qcf.tc_qcf13,g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,
                      g_tc_qcf.tc_qcf19,g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21)
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("ins","tc_qcd_file",g_tc_qca.tc_qca01,g_tc_qcd[l_ac].tc_qcd02,SQLCA.sqlcode,"","",1)
                  EXIT DIALOG
               ELSE
                  DISPLAY 1 TO FORMONLY.cn2
               END IF
            END IF
            IF p_cmd = 'u' THEN
               UPDATE tc_qcf_file 
                  SET tc_qcf01 = g_tc_qca.tc_qca01,
                      tc_qcf02 = g_tc_qcf.tc_qcf02,
                      tc_qcf03 = g_tc_qcf.tc_qcf03,
                      tc_qcf04 = g_tc_qcf.tc_qcf04,
                      tc_qcf05 = g_tc_qcf.tc_qcf05,
                      tc_qcf06 = g_tc_qcf.tc_qcf06,
                      tc_qcf07 = g_tc_qcf.tc_qcf07,
                      tc_qcf08 = g_tc_qcf.tc_qcf08,
                      tc_qcf09 = g_tc_qcf.tc_qcf09,
                      tc_qcf10 = g_tc_qcf.tc_qcf10,
                      tc_qcf11 = g_tc_qcf.tc_qcf11,
                      tc_qcf12 = g_tc_qcf.tc_qcf12,
                      tc_qcf13 = g_tc_qcf.tc_qcf13,
                      tc_qcf14 = g_tc_qcf.tc_qcf14,
                      tc_qcf15 = g_tc_qcf.tc_qcf15,
                      tc_qcf16 = g_tc_qcf.tc_qcf16,
                      tc_qcf17 = g_tc_qcf.tc_qcf17,
                      tc_qcf18 = g_tc_qcf.tc_qcf18,
                      tc_qcf19 = g_tc_qcf.tc_qcf19,
                      tc_qcf20 = g_tc_qcf.tc_qcf20,
                      tc_qcf21 = g_tc_qcf.tc_qcf21
                WHERE tc_qcf01 = g_tc_qca.tc_qca01
                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                   CALL cl_err3("upd","tc_qcf_file",g_tc_qca.tc_qca01,g_tc_qcf_t.tc_qcf02,SQLCA.sqlcode,"","",1)
                   LET g_tc_qcf.* = g_tc_qcf_t.*
                ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
                   CLOSE t410_bc4
                END IF
            END IF
      END INPUT
 
      ON ACTION CONTROLO   
         IF INFIELD(tc_qcb02) AND l_ac > 1 THEN
            LET g_tc_qcb[l_ac].* = g_tc_qcb[l_ac-1].*
            LET g_tc_qcb[l_ac].tc_qcb02 = g_rec_b + 1
            NEXT FIELD tc_qcb02
         END IF
 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON ACTION CONTROLP
         #M025 160627 By TSD.Lynn mark ---(S)
         #CASE
         #  WHEN INFIELD(tc_qcb03) 
         #    CALL cl_init_qry_var()
         #    LET g_qryparam.form ="q_azf01f" 
         #    LET g_qryparam.arg1 = 'S'
         #    LET g_qryparam.default1 = g_tc_qcb[l_ac].tc_qcb03
         #    CALL cl_create_qry() RETURNING g_tc_qcb[l_ac].tc_qcb03
         #    DISPLAY BY NAME g_tc_qcb[l_ac].tc_qcb03
         #    NEXT FIELD tc_qcb03
 
         #  WHEN INFIELD(tc_qcc03)
         #    CALL cl_init_qry_var()
         #    LET g_qryparam.form ="q_azf01f" 
         #    LET g_qryparam.arg1 = 'S'
         #    LET g_qryparam.default1 = g_tc_qcc[l_ac].tc_qcc03
         #    CALL cl_create_qry() RETURNING g_tc_qcc[l_ac].tc_qcc03
         #    DISPLAY BY NAME g_tc_qcc[l_ac].tc_qcc03
         #    NEXT FIELD tc_qcc03

         #  #M025 160620 By TSD.james---(S) 
         #  #WHEN INFIELD(tc_qcd03)
         #  #  CALL cl_init_qry_var()
         #  #  LET g_qryparam.form ="q_azf01f" 
         #  #  LET g_qryparam.arg1 = 'S'
         #  #  LET g_qryparam.default1 = g_tc_qcd[l_ac].tc_qcd03
         #  #  CALL cl_create_qry() RETURNING g_tc_qcd[l_ac].tc_qcd03
         #  #  DISPLAY BY NAME g_tc_qcd[l_ac].tc_qcd03
         #  #  NEXT FIELD tc_qcd03
         #  #M025 160620 By TSD.james---(S) 
 
         #    OTHERWISE EXIT CASE
         # END CASE
         #M025 160627 By TSD.Lynn mark ---(E)

      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
 
      ON ACTION about         
         CALL cl_about()     
 
      ON ACTION help        
         CALL cl_show_help()
 
      ON ACTION locale
         LET g_action_choice = "locale"
         CALL cl_show_fld_cont()
         CALL t410_pic()    #N025 161208 By TSD.Lynn add
         EXIT DIALOG
         
      ON ACTION controls
         CALL cl_set_head_visible("folder01","AUTO")
         
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
         
      ON ACTION exit
         IF p_cmd = 'a' THEN  #M025 170105 By TSD.Lynn add
            CALL g_tc_qcb.deleteElement(l_ac)
         END IF   #M025 170105 By TSD.Lynn add
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         IF p_cmd = 'a' THEN  #M025 170105 By TSD.Lynn add
            CALL g_tc_qcb.deleteElement(l_ac)
         END IF   #M025 170105 By TSD.Lynn add
         LET INT_FLAG=1
         EXIT DIALOG 
  

   END DIALOG

   #M025 170105 By TSD.Lynn add ---(S)
   IF INT_FLAG=1 THEN
      LET INT_FLAG=0
   END IF
   #M025 170105 By TSD.Lynn add ---(E)
 
   LET g_tc_qca.tc_qcamodu = g_user
   LET g_tc_qca.tc_qcadate = g_today
   UPDATE tc_qca_file SET tc_qcamodu = g_tc_qca.tc_qcamodu,tc_qcadate = g_tc_qca.tc_qcadate
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   DISPLAY BY NAME g_tc_qca.tc_qcamodu,g_tc_qca.tc_qcadate

   #M025 160531 By TSD.Lynn add ---(S)
   CALL t410_get_tc_qcb_min_max()
   CALL t410_get_tc_qcc_min_max()
   #M025 160531 By TSD.Lynn add ---(E)

   #M031 160705 By TSD.james---(S)
   CALL t410_get_tc_qcg_min_max()
   #M031 160705 By TSD.james---(E)
   CLOSE t410_bcl
   COMMIT WORK

END FUNCTION
 
#FUNCTION t410_b_fill(p_wc2,p_wc3,p_wc4)  #M031 160705 By TSD.james mark
FUNCTION t410_b_fill(p_wc2,p_wc3,p_wc4,p_wc5)  #M031 160705 By TSD.james
   DEFINE p_wc2      STRING
   DEFINE p_wc3      STRING
   DEFINE p_wc4      STRING
   DEFINE p_wc5      STRING   #M031 160705 By TSD.james

   #單身1 
   LET g_sql = "SELECT tc_qcb02,tc_qcb03,'',tc_qcb04,tc_qcb05,tc_qcb06,tc_qcb07,tc_qcb08,tc_qcb09,tc_qcb10, ",
               "       tc_qcb11,tc_qcb12,tc_qcb13,tc_qcb14,tc_qcb15,tc_qcb16,tc_qcb17,tc_qcb18,tc_qcb19, ",
               "       tc_qcb20,tc_qcb21,tc_qcb22,tc_qcb23 ",
               "  FROM tc_qcb_file",
               " WHERE tc_qcb01 ='",g_tc_qca.tc_qca01,"' "   #單頭
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF

   LET g_sql=g_sql CLIPPED," ORDER BY tc_qcb02"
 
   PREPARE t410_pb FROM g_sql
   DECLARE tc_qcb_cs CURSOR FOR t410_pb

   #單身2
   LET g_sql = "SELECT tc_qcc02,tc_qcc03,'',tc_qcc04,tc_qcc05,tc_qcc06,tc_qcc07,tc_qcc08,tc_qcc09,tc_qcc10, ",
               "       tc_qcc11,tc_qcc12,tc_qcc13,tc_qcc14,tc_qcc15,tc_qcc16,tc_qcc17,tc_qcc18,tc_qcc19, ",
               "       tc_qcc20,tc_qcc21,tc_qcc22,tc_qcc23 ",
               "  FROM tc_qcc_file",
               " WHERE tc_qcc01 ='",g_tc_qca.tc_qca01,"' "   #單頭
 
   IF NOT cl_null(p_wc3) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc3 CLIPPED
   END IF

   LET g_sql=g_sql CLIPPED," ORDER BY tc_qcc02"
 
   PREPARE t410_pb1 FROM g_sql
   DECLARE tc_qcc_cs CURSOR FOR t410_pb1
 
   #單身3
   LET g_sql = "SELECT tc_qcd02,tc_qcd03,'',tc_qcd04,tc_qcd05,tc_qcd06,tc_qcd07,tc_qcd08,tc_qcd09,tc_qcd10, ",
               "       tc_qcd11,tc_qcd12,tc_qcd13,tc_qcd14,tc_qcd15,tc_qcd16,tc_qcd17,tc_qcd18,tc_qcd19, ",
               "       tc_qcd20,tc_qcd21,tc_qcd22,tc_qcd23 ",
               "  FROM tc_qcd_file",
               " WHERE tc_qcd01 ='",g_tc_qca.tc_qca01,"' "   #單頭
 
   IF NOT cl_null(p_wc4) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc4 CLIPPED
   END IF

   LET g_sql=g_sql CLIPPED," ORDER BY tc_qcd02"
 
   PREPARE t410_pb2 FROM g_sql
   DECLARE tc_qcd_cs CURSOR FOR t410_pb2

   #M031 160705 By TSD.james---(S)
   LET g_sql = "SELECT tc_qcg02,tc_qcg03,'',tc_qcg04,tc_qcg05,tc_qcg06,tc_qcg07,tc_qcg08,tc_qcg09,tc_qcg10, ",
               "       tc_qcg11,tc_qcg12,tc_qcg13,tc_qcg14,tc_qcg15,tc_qcg16,tc_qcg17,tc_qcg18,tc_qcg19, ",
               "       tc_qcg20,tc_qcg21,tc_qcg22,tc_qcg23 ",
               "  FROM tc_qcg_file",
               " WHERE tc_qcg01 ='",g_tc_qca.tc_qca01,"' "   #單頭

   IF NOT cl_null(p_wc5) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc5 CLIPPED
   END IF

   LET g_sql=g_sql CLIPPED," ORDER BY tc_qcg02"
   PREPARE t410_pb3 FROM g_sql
   DECLARE tc_qcg_cs CURSOR FOR t410_pb3
   #M031 160705 By TSD.james---(E)

   CALL g_tc_qcb.clear()
   CALL g_tc_qcc.clear()
   CALL g_tc_qcd.clear()
   #M025 161128 By TSD.Lynn add ---(S)
   CALL g_tc_qce.clear()
   CALL g_tc_qcg.clear()
   #M025 161128 By TSD.Lynn add ---(E)
   LET g_cnt = 1

   FOREACH tc_qcb_cs INTO g_tc_qcb[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_errno = ' '
  
      #M025 160627 By TSD.Lynn mark ---(S)
      #SELECT azf03
      #  INTO g_tc_qcb[g_cnt].azf03_5
      #  FROM azf_file
      # WHERE azf01 = g_tc_qcb[g_cnt].tc_qcb03
      #   AND azf02 = '2'
      #   AND azf09 = 'S'
      #M025 160627 By TSD.Lynn mark ---(E)

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_qcb.deleteElement(g_cnt)
   LET g_rec_b=g_cnt-1

   LET g_cnt = 1
   FOREACH tc_qcc_cs INTO g_tc_qcc[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_errno = ' '

      #M025 160627 By TSD.Lynn mark ---(S)
      #SELECT azf03
      #  INTO g_tc_qcc[g_cnt].azf03_6
      #  FROM azf_file
      # WHERE azf01 = g_tc_qcc[g_cnt].tc_qcc03
      #   AND azf02 = '2'
      #   AND azf09 = 'S'
      #M025 160627 By TSD.Lynn mark ---(E)

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_qcc.deleteElement(g_cnt)
   LET g_rec_b1=g_cnt-1

   LET g_cnt = 1
   FOREACH tc_qcd_cs INTO g_tc_qcd[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_errno = ' '

      SELECT azf03
        INTO g_tc_qcd[g_cnt].azf03_7
        FROM azf_file
       WHERE azf01 = g_tc_qcd[g_cnt].tc_qcd03
         AND azf02 = '2'
         AND azf09 = 'S'

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_qcd.deleteElement(g_cnt)

   LET g_rec_b2=g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0

   #M031 160705 By TSD.james---(S)
   LET g_cnt = 1
   FOREACH tc_qcg_cs INTO g_tc_qcg[g_cnt].*   #單身 ARRAY 填充
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_errno = ' '

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_tc_qcg.deleteElement(g_cnt)

   LET g_rec_b3=g_cnt-1
   #M031 160705 By TSD.james---(E)
 
END FUNCTION
 
FUNCTION t410_copy()
   DEFINE l_newno     LIKE tc_qca_file.tc_qca01,
          l_oldno     LIKE tc_qca_file.tc_qca01
   DEFINE l_cnt       LIKE type_file.num5 
   DEFINE l_tc_qca17  LIKE tc_qca_file.tc_qca17 #M025 160531 By TSD.pplppl
   DEFINE l_tc_qca04  LIKE tc_qca_file.tc_qca04 #M025 160531 By TSD.pplppl
   DEFINE l_sfb02     LIKE sfb_file.sfb02   #M025 161202 By TSD.Lynn add 
   DEFINE l_sfb08     LIKE sfb_file.sfb08   #M025 161202 By TSD.Lynn add 

   IF s_shut(0) THEN 
      RETURN 
   END IF
 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   LET g_before_input_done = FALSE
   CALL t410_set_entry('a')
 
   CALL cl_set_head_visible("","YES")       
   INPUT l_newno FROM tc_qca01
      BEFORE INPUT
         CALL cl_set_docno_format("tc_qca01")
 
      AFTER FIELD tc_qca01
        #M025 161014 By TSD.Lynn mod ---(S)
        #IF NOT cl_null(g_tc_qca.tc_qca01) THEN
        IF NOT cl_null(l_newno) THEN
        #M025 161014 By TSD.Lynn mod ---(E)
           LET l_cnt = 0
           SELECT COUNT(*)
             INTO l_cnt
             FROM tc_qca_file
            #WHERE tc_qca01 = g_tc_qca.tc_qca01      # Modify.........:16/12/06 By DSC.shihyun mark
            WHERE tc_qca01 = l_newno       # Modify.........:16/12/06 By DSC.shihyun add
           IF l_cnt > 0 THEN
              CALL cl_err('','-239',1)
              NEXT FIELD tc_qca01
           END IF
           #M025 161202 By TSD.Lynn add ---(S)
           LET l_sfb02 = NULL
           LET l_sfb08 = NULL
           SELECT sfb02,sfb08
             INTO l_sfb02,l_sfb08
             FROM sfb_file
            WHERE sfb01 = l_newno
           IF l_sfb02 MATCHES '[78]' THEN   #委外工單
              IF cl_null(l_sfb08) OR l_sfb08 =0 THEN
                 #查無此三色工單的數量!
                 CALL cl_err('','TSD0043',1)
                 NEXT FIELD tc_qca01
              ELSE
                 LET l_tc_qca17 = l_newno
                 LET l_tc_qca04 = l_sfb08
              END IF
           ELSE
           #M025 161202 By TSD.Lynn add ---(E)
              #M025 160531 By TSD.pplppl--------------------------START
              #長度大於系統的單據長度才處理
              IF LENGTH(l_newno) >= g_aza.aza41+g_aza.aza42+10 THEN
                 LET l_tc_qca17 = l_newno[1,g_aza.aza41+g_aza.aza42+10]
                 LET g_runcard = l_newno    #M025 170105 By TSD.Lynn add
                 IF aws_sftcli('','q_mo_tt',l_tc_qca17,'') = 0 THEN
                    LET l_tc_qca04 = g_runcard_qry
                 ELSE
                    LET l_tc_qca17 = ''
                    LET l_tc_qca04 = ''
                    NEXT FIELD tc_qca01
                 END IF
              END IF
              #M025 160531 By TSD.pplppl----------------------------END
           END IF #M025 161202 By TSD.Lynn add
        END IF 

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about    
         CALL cl_about() 
 
      ON ACTION help    
         CALL cl_show_help()
 
      ON ACTION controlg  
         CALL cl_cmdask()  
 
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      DISPLAY BY NAME g_tc_qca.tc_qca01
      RETURN
   END IF

   BEGIN WORK
 
   DROP TABLE y
 
   SELECT * 
     FROM tc_qca_file         #單頭複製
    WHERE tc_qca01 = g_tc_qca.tc_qca01
     INTO TEMP y
 
   UPDATE y
       SET tc_qca01=l_newno,    #新的鍵值
           tc_qca17=l_tc_qca17, #M025 160531 By TSD.pplppl
           tc_qca04=l_tc_qca04, #M025 160531 By TSD.pplppl
           tc_qcauser=g_user,   #資料所有者
           tc_qcagrup=g_grup,   #資料所有者所屬群
           tc_qcamodu=NULL,     #資料修改日期
           tc_qcadate=g_today,  #資料建立日期
           tc_qcaacti='Y'       #有效資料
          ,tc_qcaconf = 'N'     #確認碼    #M025 161207 BY TSD.Lynn add
          ,tc_qca07   = 'Y'     #判定      #M025 161207 BY TSD.Lynn add
          ,tc_qca27   = g_user  #品檢人員  #M025 161207 BY TSD.Lynn add
          ,tc_qca09   = NULL    #審核人員  #M025 161207 BY TSD.Lynn add
 
   INSERT INTO tc_qca_file 
   SELECT * 
     FROM y

   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qca_file","","",SQLCA.sqlcode,"","",1) 
      ROLLBACK WORK
      RETURN
   END IF
 
   DROP TABLE x
   SELECT * 
     FROM tc_qcb_file         #單身複製
    WHERE tc_qcb01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x 
      SET tc_qcb01=l_newno
 
   INSERT INTO tc_qcb_file
   SELECT * 
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qcb_file","","",SQLCA.sqlcode,"","",1)  
      ROLLBACK WORK
      RETURN
   END IF

   DROP TABLE x
   SELECT * 
     FROM tc_qcc_file         #單身2複製
    WHERE tc_qcc01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x 
      SET tc_qcc01=l_newno

   INSERT INTO tc_qcc_file
   SELECT * 
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qcc_file","","",SQLCA.sqlcode,"","",1)  
      ROLLBACK WORK 
      RETURN
   END IF

   DROP TABLE x
   SELECT * 
     FROM tc_qcd_file         #單身3複製
    WHERE tc_qcd01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x 
      SET tc_qcd01=l_newno

   INSERT INTO tc_qcd_file
   SELECT * 
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qcd_file","","",SQLCA.sqlcode,"","",1)  
      ROLLBACK WORK 
      RETURN
   END IF

   DROP TABLE x
   SELECT * 
     FROM tc_qcf_file         #單身4複製
    WHERE tc_qcf01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x 
      SET tc_qcf01=l_newno

   INSERT INTO tc_qcf_file
   SELECT * 
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qcf_file","","",SQLCA.sqlcode,"","",1)  
      ROLLBACK WORK 
      RETURN
   END IF

   #M025 161207 BY TSD.Lynn add ---(S)
   DROP TABLE x
   SELECT * 
     FROM tc_qce_file         #單身4複製
    WHERE tc_qce01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x 
      SET tc_qce01=l_newno

   INSERT INTO tc_qce_file
   SELECT * 
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qce_file","","",SQLCA.sqlcode,"","",1)  
      ROLLBACK WORK 
      RETURN
   END IF

   DROP TABLE x
   SELECT *
     FROM tc_qcg_file         #單身4複製
    WHERE tc_qcg01 = g_tc_qca.tc_qca01
     INTO TEMP x

   UPDATE x
      SET tc_qcg01=l_newno

   INSERT INTO tc_qcg_file
   SELECT *
     FROM x
   IF SQLCA.sqlcode THEN
      CALL cl_err3("ins","tc_qcg_file","","",SQLCA.sqlcode,"","",1)
      ROLLBACK WORK
      RETURN
   END IF
   #M025 161207 BY TSD.Lynn add ---(E)

  
   LET l_oldno = g_tc_qca.tc_qca01
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file 
    WHERE tc_qca01 = l_newno

   CALL t410_show()    #M025 161207 By TSD.Lynn add

   CALL t410_u()
   CALL t410_b()
   COMMIT WORK
END FUNCTION

FUNCTION t410_set_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1  
 
  IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
     CALL cl_set_comp_entry("tc_qca01",TRUE)
  END IF
END FUNCTION
 
FUNCTION t410_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    
 
  IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
     CALL cl_set_comp_entry("tc_qca01",FALSE)
  END IF
END FUNCTION
 
#人員檢核
FUNCTION t410_tc_qca08(p_gen01)
   DEFINE p_gen01       LIKE gen_file.gen01
   DEFINE l_genacti     LIKE gen_file.genacti

   LET g_errno = NULL
   LET l_genacti  = NULL

   SELECT genacti
     INTO l_genacti
     FROM gen_file
    WHERE gen01 = p_gen01

    CASE
       WHEN SQLCA.sqlcode=100   LET g_errno='mfg3096'     #無此人員代碼,請重新輸入 
       WHEN l_genacti = 'N'     LET g_errno='art-733'     #此員工編號無效          
       OTHERWISE                LET g_errno=SQLCA.sqlcode USING '------'
    END CASE
END FUNCTION

#單頭代碼檢核
FUNCTION t410_tc_qca10(p_azf01)
   DEFINE l_azfacti     LIKE azf_file.azfacti
   DEFINE l_azf03       LIKE azf_file.azf03
   DEFINE l_azf09       LIKE azf_file.azf09
   DEFINE p_azf01       LIKE azf_file.azf01

   LET g_errno = NULL
   LET l_azfacti  = NULL
   LET l_azf03  = NULL
   LET l_azf09  = NULL

   SELECT azf03,azf09,azfacti
     INTO l_azf03,l_azf09,l_azfacti 
     FROM azf_file
    WHERE azf01 = p_azf01
      AND azf02 = '2'

   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'aic-040'  #無此理由碼, 請重新輸入
      WHEN l_azfacti <> 'Y'       LET g_errno = 'alm1105'  #理由碼無效！
      WHEN l_azf09 <> 'M'         LET g_errno = 'TSD0041'  #理由碼不為M:硬度性質
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE

   IF NOT cl_null(g_errno)  THEN
      LET l_azf03  = NULL
   END IF

   RETURN l_azf03
END FUNCTION

#M031 160705 By TSD.james---(S)
FUNCTION t410_tc_qca23(p_cmd)
   DEFINE l_azfacti     LIKE azf_file.azfacti
   DEFINE l_azf03       LIKE azf_file.azf03
   DEFINE l_azf09       LIKE azf_file.azf09
   DEFINE p_cmd         LIKE type_file.chr1

   LET g_errno = NULL
   LET l_azfacti  = NULL
   LET l_azf03  = NULL
   LET l_azf09  = NULL

   SELECT azf03,azf09,azfacti
     INTO l_azf03,l_azf09,l_azfacti
     FROM azf_file
    WHERE azf01 = g_tc_qca.tc_qca23
      AND azf02 = '2'
   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'aic-040'  #無此理由碼, 請重新輸入
                                  LET l_azf03 = NULL
      WHEN l_azfacti <> 'Y'       LET g_errno = 'alm1105'  #理由碼無效！
      WHEN l_azf09 <> 'N'         LET g_errno = 'TSD0045'  #理由碼用途不為N:深度性質
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE

   IF cl_null(g_errno) OR p_cmd = 'd' THEN
      LET g_tc_qca_1.azf03_9 = l_azf03
      DISPLAY g_tc_qca_1.azf03_9 TO FORMONLY.azf03_9
   END IF

END FUNCTION
#M031 160705 By TSD.james---(E)

#單身代碼檢核
FUNCTION t410_tc_qcb03(p_azf01)
   DEFINE l_azfacti     LIKE azf_file.azfacti
   DEFINE l_azf03       LIKE azf_file.azf03
   DEFINE l_azf09       LIKE azf_file.azf09
   DEFINE p_azf01       LIKE azf_file.azf01

   LET g_errno = NULL
   LET l_azfacti  = NULL
   LET l_azf03  = NULL
   LET l_azf09  = NULL

   SELECT azf03,azf09,azfacti
     INTO l_azf03,l_azf09,l_azfacti
     FROM azf_file
    WHERE azf01 = p_azf01
      AND azf02 = '2'

   CASE
      WHEN SQLCA.sqlcode = 100    LET g_errno = 'aic-040'  #無此理由碼, 請重新輸入
      WHEN l_azfacti <> 'Y'       LET g_errno = 'alm1105'  #理由碼無效！
      WHEN l_azf09 <> 'S'         LET g_errno = 'TSD0042'  #理由碼不為S:品檢報告檢測項目
      OTHERWISE                   LET g_errno = SQLCA.sqlcode USING '------'
   END CASE

   IF NOT cl_null(g_errno)  THEN
      LET l_azf03  = NULL
   END IF

   RETURN l_azf03
END FUNCTION

#作業編號檢核
#M025 160620 By TSD.james---(S)
#FUNCTION t410_tc_qca18() 
FUNCTION t410_tc_qca18(p_cmd)
   DEFINE p_cmd        LIKE type_file.chr1 
   DEFINE l_ecd02      LIKE ecd_file.ecd02
#M025 160620 By TSD.james---(E)
   DEFINE l_ecdacti    LIKE ecd_file.ecdacti

   LET l_ecdacti = NULL
   LET g_errno = NULL
   #M025 160620 By TSD.james---(S)
   #SELECT ecdacti
   #  INTO l_ecdacti
   #  FROM ecd_file
   # WHERE ecd01 = g_tc_qca.tc_qca18
   LET l_ecd02 = NULL
   SELECT ecdacti,ecd02
     INTO l_ecdacti,l_ecd02
     FROM ecd_file
    WHERE ecd01 = g_tc_qca.tc_qca18
   #M025 160620 By TSD.james---(E)
   CASE
      WHEN SQLCA.sqlcode = 100   LET g_errno = 'mfg4009'  #無此作業編號,請重新輸入
                                 LET l_ecd02 = NULL  #M025 160620 By TSD.james
      WHEN l_ecdacti <> 'Y'      LET g_errno = '9028'     #此筆資料已無效, 不可使用
      OTHERWISE                  LET g_errno = SQLCA.sqlcode USING '------'
   END CASE
   #M025 160620 By TSD.james---(S)
   IF cl_null(g_errno) OR p_cmd = 'd' THEN
      DISPLAY l_ecd02 TO FORMONLY.ecd02
   END IF
   #M025 160620 By TSD.james---(E)

END FUNCTION 

#tc_qca17,tc_qca18帶值
FUNCTION t410_to_value(p_cmd)
   DEFINE p_cmd          LIKE type_file.chr1
   DEFINE l_tc_otn03     LIKE tc_otn_file.tc_otn03
   DEFINE l_tc_otn04     LIKE tc_otn_file.tc_otn04
   DEFINE l_ta_inb01     LIKE inb_file.ta_inb01
   DEFINE l_tc_cra05     LIKE tc_cra_file.tc_cra05
   DEFINE l_tc_cra06     LIKE tc_cra_file.tc_cra06
   DEFINE l_tc_cra07     LIKE tc_cra_file.tc_cra07
   DEFINE l_tc_cra09     LIKE tc_cra_file.tc_cra09
   DEFINE l_tc_cra10     LIKE tc_cra_file.tc_cra10
   DEFINE l_tc_cra11     LIKE tc_cra_file.tc_cra11
   DEFINE l_tc_cra12     LIKE tc_cra_file.tc_cra12
   DEFINE l_tc_cra13     LIKE tc_cra_file.tc_cra13
   DEFINE l_tc_cra14     LIKE tc_cra_file.tc_cra14
   DEFINE l_tc_cra15     LIKE tc_cra_file.tc_cra15
   DEFINE l_tc_cra16     LIKE tc_cra_file.tc_cra16
   DEFINE l_azf03        LIKE azf_file.azf03
   DEFINE l_azf03_1      LIKE azf_file.azf03
   DEFINE l_azf03_9      LIKE azf_file.azf03   ##M031 160705 By TSD.james
   DEFINE l_sql          STRING
   DEFINE l_tc_qca10     LIKE tc_qca_file.tc_qca10
   DEFINE l_tc_qca12     LIKE tc_qca_file.tc_qca12
   DEFINE l_tc_qca23     LIKE tc_qca_file.tc_qca23   #M031 160705 By TSD.james
   DEFINE l_str          STRING
   DEFINE l_str1         STRING
   DEFINE l_str2         STRING
  # DEFINE l_inbud02      LIKE inb_file.inbud02  #M045 161114 By TSD.nick #mark by ganlh170718
   #M025 160907 By TSD.Lynn 調整其他號碼---(S)
   DEFINE l_inb01       LIKE inb_file.inb01
   DEFINE l_tc_otn_str  STRING
   DEFINE l_tc_otn      RECORD LIKE tc_otn_file.*
   #M025 160907 By TSD.Lynn 調整其他號碼---(E)

   LET l_tc_otn03  = NULL
   LET l_tc_otn04  = NULL
   LET l_ta_inb01  = NULL
   LET l_tc_cra05  = NULL
   LET l_tc_cra06  = NULL
   LET l_tc_cra07  = NULL
   LET l_tc_cra09  = NULL
   LET l_tc_cra10  = NULL
   LET l_tc_cra11  = NULL
   LET l_tc_cra12  = NULL
   LET l_tc_cra13  = NULL
   LET l_tc_cra14  = NULL
   LET l_tc_cra15  = NULL
   LET l_tc_cra16  = NULL
   LET l_azf03     = NULL
   LET l_azf03_1   = NULL
   LET l_azf03_9   = NULL   #M031 160705 By TSD.james
   LET l_tc_qca10  = NULL
   LET l_tc_qca12  = NULL
   LET l_tc_qca23  = NULL   #M031 160705 By TSD.james
   INITIALIZE g_tc_qca_1.* TO NULL
   #廠內料號
   SELECT sfb05
     INTO g_tc_qca_1.sfb05
     FROM sfb_file
    WHERE sfb01 = g_tc_qca.tc_qca17
   DISPLAY g_tc_qca_1.sfb05 TO FORMONLY.sfb05

   #品名/客戶料號,規格,材質,單位
   SELECT ima02,ima021,ta_ima01
         ,ima131                 #M045 161114 By TSD.nick
     INTO g_tc_qca_1.ima02,g_tc_qca_1.ima021,g_tc_qca_1.ta_ima01
         ,g_tc_qca_1.ima131      #M045 161114 By TSD.nick
     FROM ima_file
    WHERE ima01 = g_tc_qca_1.sfb05
   DISPLAY g_tc_qca_1.ima02 TO FORMONLY.ima02
   DISPLAY g_tc_qca_1.ima021 TO FORMONLY.ima021
   DISPLAY g_tc_qca_1.ta_ima01 TO FORMONLY.ta_ima01
   #DISPLAY g_tc_qca_1.ima131 TO FORMONLY.ima131   #M045 161114 By TSD.nick  #M045 161129 By TSD.Lynn add

   #M045 161129 By TSD.Lynn add ---(S)
   SELECT oba02
     INTO g_tc_qca_1.oba02
     FROM oba_file
    WHERE oba01 = g_tc_qca_1.ima131
   DISPLAY g_tc_qca_1.oba02  TO FORMONLY.oba02    #M045 161129 By TSD.Lynn add
   #M045 161129 By TSD.Lynn add ---(E)

   LET l_inb01 = NULL   #M025 160907 By TSD.Lynn add
   #抓訂單,收料數量,參考數量
   LET l_sql = " SELECT ta_inb03,inb904,inb907,ta_inb01,inb902,inb905 ",
               "       ,inbud02                                       ",  #M045 161114 By TSD.nick
               "        ,inb01 ",   #M025 160907 By TSD.Lynn add
               "   FROM inb_file ",
               "  WHERE ta_inb04 = ? "
   PREPARE t410_sel_inb_pre FROM l_sql
   DECLARE t410_sel_inb_cs CURSOR FOR t410_sel_inb_pre
   LET g_tc_qca_1.inbud02 = 'N'
   OPEN t410_sel_inb_cs USING g_tc_qca.tc_qca17
   FETCH t410_sel_inb_cs INTO g_tc_qca_1.ta_inb03,g_tc_qca_1.inb904,g_tc_qca_1.inb907,
                              l_ta_inb01,g_tc_qca_1.ima31,g_tc_qca_1.ima31_1
                             ,g_tc_qca_1.inbud02    #M045 161114 By TSD.nick #mod by ganlh170718
                             ,l_inb01   #M025 160907 By TSD.Lynn add
   DISPLAY g_tc_qca_1.ta_inb03 TO FORMONLY.ta_inb03
   DISPLAY g_tc_qca_1.inb904 TO FORMONLY.inb904
   DISPLAY g_tc_qca_1.inb907 TO FORMONLY.inb907
   DISPLAY g_tc_qca_1.ima31 TO FORMONLY.ima31
   DISPLAY g_tc_qca_1.ima31_1 TO FORMONLY.ima31_1
   DISPLAY g_tc_qca_1.inbud02 TO FORMONLY.inbud02
   CLOSE t410_sel_inb_cs

   #客戶編號/名稱
   SELECT oea03,oea032
     INTO g_tc_qca_1.oea03,g_tc_qca_1.oea032
     FROM oea_file
    WHERE oea01 = g_tc_qca_1.ta_inb03
   DISPLAY g_tc_qca_1.oea03 TO FORMONLY.oea03
   DISPLAY g_tc_qca_1.oea032 TO FORMONLY.oea032

   #硬化深度測試荷重,硬化深度派定基準
   SELECT tc_imc07,tc_imc06,tc_imc05,tc_imc03,tc_imc04,tc_imc09
     INTO g_tc_qca_1.tc_imc07,g_tc_qca_1.tc_imc06,g_tc_qca_1.tc_imc05,
          g_tc_qca_1.tc_imc03,g_tc_qca_1.tc_imc04,g_tc_qca_1.tc_imc09
     FROM tc_imc_file
    WHERE tc_imc01 = g_tc_qca_1.sfb05
      AND tc_imc02 = g_tc_qca.tc_qca18
      AND tc_imc31 = g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay


   SELECT azf03
     INTO g_tc_qca_1.azf03
     FROM azf_file
    WHERE azf01 = g_tc_qca_1.tc_imc07
      AND azf02 = '2'
      AND azf09 = 'M'
   DISPLAY g_tc_qca_1.tc_imc07 TO FORMONLY.tc_imc07
   DISPLAY g_tc_qca_1.tc_imc06 TO FORMONLY.tc_imc06
   DISPLAY g_tc_qca_1.azf03 TO FORMONLY.azf03
   DISPLAY g_tc_qca_1.tc_imc05 TO FORMONLY.tc_imc05
   DISPLAY g_tc_qca_1.tc_imc04 TO FORMONLY.tc_imc04
   DISPLAY g_tc_qca_1.tc_imc03 TO FORMONLY.tc_imc03
   DISPLAY g_tc_qca_1.tc_imc09 TO FORMONLY.tc_imc09

   #其他號碼

   #M025 160907 By TSD.Lynn 調整其他號碼---(S)
   #SELECT tc_otn03,tc_otn04
   #  INTO l_tc_otn03,l_tc_otn04
   #  FROM tc_otn_file
   # WHERE tc_otn01 = g_tc_qca.tc_qca17

   #SELECT azf03
   #  INTO l_azf03
   #  FROM azf_file
   # WHERE azf01 = l_tc_otn03
   #   AND azf02 = '2'
   #   AND azf09 = 'R'

   #LET g_tc_qca_1.othernum = l_azf03," ",l_tc_otn04

   LET l_tc_otn_str = ''

   #取其他號碼
   LET l_sql = "SELECT tc_otn_file.*,azf03 FROM tc_otn_file,azf_file ",
               " WHERE tc_otn01 = ? ",
               "   AND azf01 = tc_otn03 AND azf09 = 'R' ",
               " ORDER BY tc_otn03 "
   DECLARE t410_sel_tc_otn_c1 SCROLL CURSOR FROM l_sql

   FOREACH t410_sel_tc_otn_c1 USING l_inb01 INTO l_tc_otn.*,l_azf03
      IF STATUS THEN
         EXIT FOREACH
      END IF
      IF cl_null(l_tc_otn_str) THEN
         LET l_tc_otn_str = l_azf03 CLIPPED," ",l_tc_otn.tc_otn04
      ELSE
         LET l_tc_otn_str = l_tc_otn_str CLIPPED, l_azf03 CLIPPED," ",l_tc_otn.tc_otn04 CLIPPED,ASCII(13)
      END IF
      LET l_azf03 = ''
      INITIALIZE l_tc_otn.* TO NULL
   END FOREACH

   LET g_tc_qca_1.othernum = l_tc_otn_str
   #M025 160907 By TSD.Lynn 調整其他號碼---(E)
   DISPLAY g_tc_qca_1.othernum TO FORMONLY.othernum

   #表面實測硬度性質代碼需求規格,說明
   SELECT tc_cra04,tc_cra05,tc_cra06,tc_cra07,tc_cra08,tc_cra09,tc_cra10,tc_cra11,tc_cra12,
          tc_cra13,tc_cra14,tc_cra15,tc_cra16
     INTO l_tc_qca10,l_tc_cra05,l_tc_cra06,l_tc_cra07,l_tc_qca12,l_tc_cra09,l_tc_cra10,l_tc_cra11,
          l_tc_cra12,l_tc_cra13,l_tc_cra14,l_tc_cra15,l_tc_cra16
     FROM tc_cra_file
    WHERE tc_cra01 = l_ta_inb01

   IF p_cmd = 'd' THEN
      LET l_tc_qca10 = g_tc_qca.tc_qca10
      LET l_tc_qca12 = g_tc_qca.tc_qca12
      LET l_tc_qca23 = g_tc_qca.tc_qca23   #M031 160705 By TSD.james
   ELSE
      LET g_tc_qca.tc_qca10 = l_tc_qca10
      LET g_tc_qca.tc_qca12 = l_tc_qca12
      LET g_tc_qca.tc_qca23 = l_tc_cra12   #M031 160705 By TSD.james
      LET l_tc_qca23 = l_tc_cra12          #M031 160705 By TSD.james
   END IF

   SELECT azf03
     INTO g_tc_qca_1.azf03_1
     FROM azf_file
    WHERE azf01 = l_tc_qca10
      AND azf02 = '2'
      AND azf09 = 'M'

   DISPLAY l_tc_qca10 TO tc_qca10
   DISPLAY l_tc_qca12 TO tc_qca12
   DISPLAY l_tc_qca23 TO tc_qca23          #M031 160705 By TSD.james

   IF cl_null(l_tc_cra05) AND cl_null(l_tc_cra06) THEN
      LET l_str = " "
   ELSE
      LET l_str1 = l_tc_cra05
      LET l_str1 = l_str1.trim()
      LET l_str2 = l_tc_cra06
      LET l_str2 = l_str2.trim()
      LET l_str = l_str1 CLIPPED,"-",l_str2 CLIPPED
   END IF

  # LET g_tc_qca_1.tc_crastr = g_tc_qca_1.azf03_1," ",l_str," ",l_tc_cra07 #mod BY cjy 20170124
   LET g_tc_qca.tc_qca29 = g_tc_qca_1.azf03_1," ",l_str," ",l_tc_cra07   #ADD BY cjy 20170124
   DISPLAY g_tc_qca_1.azf03_1 TO FORMONLY.azf03_1
  # DISPLAY g_tc_qca_1.tc_crastr TO FORMONLY.tc_crastr
  DISPLAY g_tc_qca.tc_qca29 TO FORMONLY.tc_crastr  #mod BY cjy 20170124

   #心部硬度性質代碼需求規格,說明
   SELECT azf03
     INTO g_tc_qca_1.azf03_2
     FROM azf_file
    WHERE azf01 = l_tc_qca12
      AND azf02 = '2'
      AND azf09 = 'M'

   IF cl_null(l_tc_cra09) AND cl_null(l_tc_cra10) THEN
      LET l_str = " "
   ELSE
      LET l_str1 = l_tc_cra09
      LET l_str1 = l_str1.trim()
      LET l_str2 = l_tc_cra10
      LET l_str2 = l_str2.trim()
      LET l_str = l_str1 CLIPPED,"-",l_str2 CLIPPED
   END IF

   #LET g_tc_qca_1.tc_crastr_1 = g_tc_qca_1.azf03_2," ",l_str," ",l_tc_cra11
   LET g_tc_qca.tc_qca30  = g_tc_qca_1.azf03_2," ",l_str," ",l_tc_cra11  #mod by cjy 20170124
   DISPLAY g_tc_qca_1.azf03_2 TO FORMONLY.azf03_2
   #DISPLAY g_tc_qca_1.tc_crastr_1 TO FORMONLY.tc_crastr_1 #mod by cjy 20170124
   DISPLAY g_tc_qca.tc_qca30 TO FORMONLY.tc_crastr_1  #mod by cjy 20170124

   #硬度分布實測值需求規格,說明
   SELECT azf03
     INTO g_tc_qca_1.azf03_3
     FROM azf_file
    WHERE azf01 = g_tc_qca_1.tc_imc05
      AND azf02 = '2'
      AND azf09 = 'U'

   LET l_azf03_1 = NULL
   SELECT azf03
     INTO l_azf03_1
     FROM azf_file
    WHERE azf01 = l_tc_cra12
      AND azf02 = '2'

   IF cl_null(l_tc_cra15) AND cl_null(l_tc_cra16) THEN
      LET l_str = " "
   ELSE
      LET l_str1 = l_tc_cra13
      LET l_str1 = l_str1.trim()
      LET l_str2 = l_tc_cra14
      LET l_str2 = l_str2.trim()
      LET l_str = l_str1 CLIPPED,"-",l_str2 CLIPPED
   END IF
   
   #M025 160707 By TSD.Lynn mod ---(S)
   #LET g_tc_qca_1.tc_crastr_2 = l_azf03_1," ",l_tc_cra15," ",l_str," ",l_tc_cra16
   #LET g_tc_qca_1.tc_crastr_2 = l_azf03_1," ",l_str," ",l_tc_cra15," ",l_tc_cra16 #MOD by cjy 20170124
   #M025 160707 By TSD.Lynn mod ---(E)
   LET g_tc_qca.tc_qca32 = l_azf03_1," ",l_str," ",l_tc_cra15," ",l_tc_cra16  #add by cjy 20170124
   DISPLAY g_tc_qca_1.azf03_3 TO FORMONLY.azf03_3
   DISPLAY g_tc_qca.tc_qca32 TO FORMONLY.tc_crastr_2

   #M031 160705 By TSD.james---(S)
   #深度硬度需求規格,說明
   SELECT azf03
     INTO g_tc_qca_1.azf03_9
     FROM azf_file
    WHERE azf01 = g_tc_qca.tc_qca23
      AND azf02 = '2'
      AND azf09 = 'N'

   LET l_azf03_9 = NULL
   SELECT azf03
     INTO l_azf03_9
     FROM azf_file
    WHERE azf01 = l_tc_qca23
      AND azf02 = '2'

   IF cl_null(l_tc_cra15) AND cl_null(l_tc_cra16) THEN
      LET l_str = " "
   ELSE
      LET l_str1 = l_tc_cra13
      LET l_str1 = l_str1.trim()
      LET l_str2 = l_tc_cra14
      LET l_str2 = l_str2.trim()
      LET l_str = l_str1 CLIPPED,"-",l_str2 CLIPPED
   END IF

   #M025 160707 By TSD.Lynn mod ---(S)
   #LET g_tc_qca_1.tc_crastr_3 = l_azf03_9," ",l_tc_cra15," ",l_str," ",l_tc_cra16
   #LET g_tc_qca_1.tc_crastr_3 = l_azf03_9," ",l_str," ",l_tc_cra15," ",l_tc_cra16   #MOD by cjy 20170124
   #M025 160707 By TSD.Lynn mod ---(E)
   LET g_tc_qca.tc_qca31 = l_azf03_9," ",l_str," ",l_tc_cra15," ",l_tc_cra16    #add by cjy 20170124
   DISPLAY g_tc_qca_1.azf03_9 TO FORMONLY.azf03_9
   DISPLAY g_tc_qca.tc_qca31 TO FORMONLY.tc_crastr_3
   #M031 160705 By TSD.james---(E)

   CALL cs_product_type_pic(g_tc_qca_1.inbud02)    #M045 161114 By TSD.nick
   #M049 161216 By TSD.Jay ---(S)---
   #CALL cs_get_fld_doc('1',g_tc_qca_1.sfb05,g_tc_qca.tc_qca18)
   CALL cs_get_fld_doc('1',g_tc_qca_1.sfb05,g_tc_qca.tc_qca18,g_tc_qca.tc_qca28)
   #M049 161216 By TSD.Jay ---(E)---
END FUNCTION

#確認
FUNCTION t410_confirm()
   DEFINE l_gen02     LIKE gen_file.gen02   #M025 160714 By TSD.Lynn add
   DEFINE l_msg       LIKE type_file.chr1000 #chuck add 160906
   DEFINE l_cmd       LIKE type_file.chr1000 #chuck add 160906

   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'Y' THEN
      CALL cl_err('','atm-158','1')  #此筆資料已確認，不可再次確認！
      RETURN
   END IF

   IF NOT cl_confirm('aim-301') THEN      #是否確定執行確認(Y/N)?
      RETURN
   END IF

   #M025 160616 By TSD.Lynn mark ---(S)
   #LET g_tc_qca.tc_qca09 = g_user
   #DISPLAY g_tc_qca.tc_qca09 TO tc_qca09 
   #M025 160616 By TSD.Lynn mark ---(E)

   BEGIN WORK
   OPEN t410_cl USING g_tc_qca.tc_qca01
   IF SQLCA.sqlcode THEN
      CALL cl_err("OPEN t410_cl",SQLCA.sqlcode,'1')
      close t410_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t410_cl INTO g_tc_qca.*
   IF SQLCA.sqlcode THEN
      CALL cl_err("FETCH t410_cl",SQLCA.sqlcode,'1')
      close t410_cl
      ROLLBACK WORK
      RETURN
   END IF

   #M025 160616 By TSD.Lynn 給核准人員 ---(S)
   LET g_tc_qca.tc_qca09 = g_user
   DISPLAY g_tc_qca.tc_qca09 TO tc_qca09 
   #M025 160714 By TSD.Lynn add ---(S)
   CALL t410_chk_gen('d',g_tc_qca.tc_qca09) RETURNING l_gen02
   DISPLAY l_gen02 TO FORMONLY.gen02_2
   #M025 160714 By TSD.Lynn add ---(E)
   #M025 160616 By TSD.Lynn 給核准人員 ---(E)

   #M025 160714 By TSD.Lynn  ---(S)
   #LET g_tc_qca.tc_qca27 = g_user
   #DISPLAY g_tc_qca.tc_qca27 TO tc_qca27
   #CALL t410_chk_gen('d',g_tc_qca.tc_qca27) RETURNING l_gen02
   #DISPLAY l_gen02 TO FORMONLY.gen02_3
   CALL cl_set_comp_entry("tc_qca07,tc_qca09,tc_qca27",TRUE)
   #M025 160714 By TSD.Lynn  ---(E)

   #M025 160714 By TSD.Lynn  ---(S)
   INPUT BY NAME g_tc_qca.tc_qca07,g_tc_qca.tc_qca09
   #INPUT BY NAME g_tc_qca.tc_qca07,g_tc_qca.tc_qca27,g_tc_qca.tc_qca09
   #M025 160714 By TSD.Lynn  ---(E)
       WITHOUT DEFAULTS  #M025 160616 By TSD.Lynn add 

      #M025 160714 By TSD.Lynn add ---(S)
      #AFTER FIELD tc_qca27
      #   IF NOT cl_null(g_tc_qca.tc_qca27) THEN
      #      CALL t410_tc_qca08(g_tc_qca.tc_qca27)
      #      IF NOT cl_null(g_errno) THEN
      #         CALL cl_err(g_tc_qca.tc_qca27,g_errno,1)
      #         NEXT FIELD tc_qca27
      #      END IF
      #      CALL t410_chk_gen('a',g_tc_qca.tc_qca27) RETURNING l_gen02
      #      IF NOT cl_null(g_errno) THEN
      #         CALL cl_err(g_tc_qca.tc_qca27,g_errno,1)
      #         NEXT FIELD tc_qca27
      #      END IF
      #      DISPLAY l_gen02 TO FORMONLY.gen02_3
      #   ELSE
      #      DISPLAY '' TO FORMONLY.gen02_3
      #   END IF
      #M025 160714 By TSD.Lynn add ---(E)

      AFTER FIELD tc_qca09
         IF NOT cl_null(g_tc_qca.tc_qca09) THEN
            CALL t410_tc_qca08(g_tc_qca.tc_qca09)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca09,g_errno,1)
               NEXT FIELD tc_qca09
            END IF
         #M025 160714 By TSD.Lynn add ---(S)
            CALL t410_chk_gen('a',g_tc_qca.tc_qca09) RETURNING l_gen02
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_tc_qca.tc_qca09,g_errno,1)
               NEXT FIELD tc_qca09
            END IF
            DISPLAY l_gen02 TO FORMONLY.gen02_2
         ELSE
            DISPLAY '' TO FORMONLY.gen02_2
         #M025 160714 By TSD.Lynn add ---(E)
         END IF

      ON ACTION CONTROLP 
         CASE
            WHEN INFIELD(tc_qca09)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_gen02"
               LET g_qryparam.default1 = g_tc_qca.tc_qca09
               CALL cl_create_qry() RETURNING g_tc_qca.tc_qca09
               DISPLAY BY NAME g_tc_qca.tc_qca09
               NEXT FIELD tc_qca09 

            #M027 169714 By TSD.Lynn add ---(S)
            #WHEN INFIELD(tc_qca27)
            #   CALL cl_init_qry_var()
            #   LET g_qryparam.form ="q_gen02"
            #   LET g_qryparam.default1 = g_tc_qca.tc_qca27
            #   CALL cl_create_qry() RETURNING g_tc_qca.tc_qca27
            #   DISPLAY BY NAME g_tc_qca.tc_qca27
            #   NEXT FIELD tc_qca27 
            #M027 169714 By TSD.Lynn add ---(E)

            OTHERWISE EXIT CASE

         END CASE
  
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()
   END INPUT
   #CALL cl_set_comp_entry("tc_qca07,tc_cqa09,tc_cqa27",FALSE)   #M025 160714 By TSD.Lynn add
   CALL cl_set_comp_entry("tc_qca07,tc_qca09",FALSE)   #M025 160714 By TSD.Lynn add

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #INITIALIZE g_tc_qca.* TO NULL  #160616 By TSD.Lynn mark
      ROLLBACK WORK
      RETURN
   END IF

   UPDATE tc_qca_file
      SET tc_qcaconf = 'Y',
          tc_qca07 = g_tc_qca.tc_qca07,
          tc_qca27 = g_tc_qca.tc_qca27, #M025 160714 By TSD.Lynn add
          tc_qca09 = g_tc_qca.tc_qca09
    WHERE tc_qca01 = g_tc_qca.tc_qca01

   IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
      IF SQLCA.sqlcode = 0 THEN
         LET SQLCA.sqlcode = 9050
      END IF
      CALL cl_err3("upd","tc_qca_file",g_tc_qca_t.tc_qca01,g_tc_qca_t.tc_qca02,SQLCA.sqlcode,"","",1)
      close t410_cl
      ROLLBACK WORK
      RETURN 
   END IF 

   #chuck add 160906 [S] 增加確認時，把品檢報告產生到CR指定目錄中

   LET l_msg=' tc_qca01="',g_tc_qca.tc_qca01 CLIPPED,'"'
   LET l_cmd = "cqcr411",
       " '",TODAY,"' ''",
       " '",g_lang CLIPPED,"' 'Y' '' '1'",
       " '",l_msg CLIPPED,"' ",
       " '' '' '' '' ",
       " 'Y' '",g_tc_qca.tc_qca01,"' "
      #" 'Y' '",g_dbs CLIPPED,"_",g_tc_qca.tc_qca01,"' " #chuck add 160907 之後WIP改好，要加上營運中心的呈現
   CALL cl_cmdrun(l_cmd)

   #chuck add 160906 [E]

   COMMIT WORK
   LET g_tc_qca.tc_qcaconf = 'Y'
   DISPLAY BY NAME g_tc_qca.tc_qcaconf

   #M025 161208 By TSD.Lynn add ---(S)
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   CALL t410_show()
   #M025 161208 By TSD.Lynn add ---(E)
END FUNCTION

#取消確認
FUNCTION t410_undo_confirm()
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   IF g_tc_qca.tc_qcaconf = 'N' THEN
      CALL cl_err('','9025','1')  #此筆資料尚未確認, 不可取消確認
      RETURN
   END IF

   IF NOT cl_confirm('aco-729') THEN   #是否執行取消確認?
      RETURN
   END IF

   BEGIN WORK
   OPEN t410_cl USING g_tc_qca.tc_qca01
   IF SQLCA.sqlcode THEN
      CALL cl_err("OPEN t410_cl",SQLCA.sqlcode,'1')
      close t410_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t410_cl INTO g_tc_qca.*
   IF SQLCA.sqlcode THEN
      CALL cl_err("FETCH t410_cl",SQLCA.sqlcode,'1')
      close t410_cl
      ROLLBACK WORK
      RETURN
   END IF

   UPDATE tc_qca_file
      SET tc_qcaconf = 'N'
    WHERE tc_qca01 = g_tc_qca.tc_qca01

   IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
      IF SQLCA.sqlcode = 0 THEN
         LET SQLCA.sqlcode = 9050
      END IF
      CALL cl_err3("upd","tc_qca_file",g_tc_qca_t.tc_qca01,g_tc_qca_t.tc_qca02,SQLCA.sqlcode,"","",1)
      close t410_cl
      ROLLBACK WORK
      RETURN 
   END IF  
   COMMIT WORK
   LET g_tc_qca.tc_qcaconf = 'N'
   DISPLAY BY NAME g_tc_qca.tc_qcaconf
   #M025 161208 By TSD.Lynn add ---(S)
   SELECT * 
     INTO g_tc_qca.* 
     FROM tc_qca_file
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   CALL t410_show()
   #M025 161208 By TSD.Lynn add ---(E)
END FUNCTION

#金相組織圖片維護
FUNCTION t410_pic_upd()
   DEFINE l_cmd    STRING
 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('','-400',0)
      RETURN
   END IF

   #M045 161207 By TSD.Lynn mod --(S)
   #IF g_tc_qca.tc_qcaconf = 'Y' THEN
   #   CALL cl_err('','aim1006',1)   #此筆資料已確認不可修改!
   #   RETURN 
   #END IF 
   #M045 161207 By TSD.Lynn mod --(E)

   CALL t410_1_main_pic(g_tc_qca.tc_qca01)
END FUNCTION


#M025 160531 By TSD.Lynn add ---(S)
FUNCTION t410_get_tc_qcb_min_max()
   DEFINE l_min        LIKE tc_qca_file.tc_qca19
   DEFINE l_max        LIKE tc_qca_file.tc_qca20
   DEFINE l_tc_qca19   LIKE tc_qca_file.tc_qca19
   DEFINE l_tc_qca20   LIKE tc_qca_file.tc_qca20
   DEFINE l_i          LIKE type_file.num5
   DEFINE l_sql        STRING
   DEFINE l_field      LIKE ztb_file.ztb03

   LET l_min = NULL
   LET l_MAX = NULL
   
   FOR l_i = 4 TO 23      
    
      LET l_field = 'tc_qcb',l_i USING '&&' 
      LET l_sql ="SELECT MIN(",l_field,"), MAX(",l_field,")",
                 "  FROM tc_qcb_file ", 
                 " WHERE tc_qcb01 = '",g_tc_qca.tc_qca01,"'"

      PREPARE t410_sel_min_max_p1 FROM l_sql

      LET l_tc_qca19 =NULL
      LET l_tc_qca20 =NULL
      EXECUTE t410_sel_min_max_p1 INTO l_tc_qca19,l_tc_qca20
   
      IF l_tc_qca19 < l_min OR cl_null(l_min) THEN
         LET l_min = l_tc_qca19
      END IF
   
      IF l_tc_qca20 > l_max OR cl_null(l_max) THEN
         LET l_max = l_tc_qca20
      END IF 
   
   END FOR

   UPDATE tc_qca_file SET tc_qca19 = l_min,
                          tc_qca20 = l_max
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      IF SQLCA.sqlcode = 0 THEN LET SQLCA.sqlcode = 9050 END IF
      CALL cl_err3("upd","tc_qca_file",g_tc_qca.tc_qca01,"",SQLCA.sqlcode,"","",1)
   END IF

   LET g_tc_qca.tc_qca19 = l_min
   LET g_tc_qca.tc_qca20 = l_max
   DISPLAY BY NAME g_tc_qca.tc_qca19
   DISPLAY BY NAME g_tc_qca.tc_qca20
END FUNCTION

#心部硬度最小值&最大值
FUNCTION t410_get_tc_qcc_min_max()
   DEFINE l_min        LIKE tc_qca_file.tc_qca21
   DEFINE l_max        LIKE tc_qca_file.tc_qca22
   DEFINE l_tc_qca21   LIKE tc_qca_file.tc_qca21
   DEFINE l_tc_qca22   LIKE tc_qca_file.tc_qca22
   DEFINE l_i          LIKE type_file.num5
   DEFINE l_sql        STRING
   DEFINE l_field      LIKE ztb_file.ztb03

   LET l_min = NULL
   LET l_MAX = NULL

   FOR l_i = 4 TO 23

      LET l_field = 'tc_qcc',l_i USING '&&'
      LET l_sql ="SELECT MIN(",l_field,"), MAX(",l_field,")",
                 "  FROM tc_qcc_file ",
                 " WHERE tc_qcc01 = '",g_tc_qca.tc_qca01,"'"

      PREPARE t410_sel_min_max_p2 FROM l_sql

      LET l_tc_qca21 =NULL
      LET l_tc_qca22 =NULL
      EXECUTE t410_sel_min_max_p2 INTO l_tc_qca21,l_tc_qca22

      IF l_tc_qca21 < l_min OR cl_null(l_min) THEN
         LET l_min = l_tc_qca21
      END IF

      IF l_tc_qca22 > l_max OR cl_null(l_max) THEN
         LET l_max = l_tc_qca22
      END IF

   END FOR

   UPDATE tc_qca_file SET tc_qca21 = l_min,
                          tc_qca22 = l_max
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      IF SQLCA.sqlcode = 0 THEN LET SQLCA.sqlcode = 9050 END IF
      CALL cl_err3("upd","tc_qca_file",g_tc_qca.tc_qca01,"",SQLCA.sqlcode,"","",1)
   END IF
   LET g_tc_qca.tc_qca21 = l_min
   LET g_tc_qca.tc_qca22 = l_max
   DISPLAY BY NAME g_tc_qca.tc_qca21
   DISPLAY BY NAME g_tc_qca.tc_qca22

END FUNCTION
#M025 160531 By TSD.Lynn add ---(E)

#M025 160620 By TSD.james---(S)
FUNCTION t410_report_output()
   DEFINE l_cmd     STRING
   DEFINE l_str     STRING 
   IF cl_null(g_tc_qca.tc_qca01) THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF

   #M025 161207 By TSD.Lynn add ---(S)
   IF g_tc_qca.tc_qcaconf = 'Y' THEN
   ELSE
      #M049 161216 By TSD.Jay ---(S)---
      #CALL cl_err('','TSD0066',1)   #TSD0066:未審核無法產生報告!
      CALL cl_err('','TSD0068',1)   #品檢報告未審核，不可打印
      #M049 161216 By TSD.Jay ---(E)---
      RETURN 
   END IF 
   #M025 161207 By TSD.Lynn add ---(E)
   
   LET l_str = "tc_qca01 = '",g_tc_qca.tc_qca01,"'"
   LET l_str = cl_replace_str(l_str,"'","\"")
   LET l_cmd = "cqcr410 ","' ' ","' ' ","' ' ","' ' ","' ' ","' ' ","'",l_str,"' ","' ' ","' ' ","' ' ","' ' "
   CALL cl_cmdrun_wait(l_cmd)
END FUNCTION
#M025 160620 By TSD.james---(E)

#M031 160705 By TSD.james---(S)
FUNCTION t410_get_tc_qcg_min_max()
   DEFINE l_min        LIKE tc_qca_file.tc_qca25
   DEFINE l_max        LIKE tc_qca_file.tc_qca26
   DEFINE l_tc_qca25   LIKE tc_qca_file.tc_qca25
   DEFINE l_tc_qca26   LIKE tc_qca_file.tc_qca26
   DEFINE l_i          LIKE type_file.num5
   DEFINE l_sql        STRING
   DEFINE l_field      LIKE ztb_file.ztb03

   LET l_min = NULL
   LET l_MAX = NULL

   FOR l_i = 4 TO 23
      LET l_field = 'tc_qcg',l_i USING '&&'
      LET l_sql ="SELECT MIN(",l_field,"), MAX(",l_field,")",
                 "  FROM tc_qcg_file ",
                 " WHERE tc_qcg01 = '",g_tc_qca.tc_qca01,"'"

      PREPARE t410_sel_min_max_p3 FROM l_sql

      LET l_tc_qca25 =NULL
      LET l_tc_qca26 =NULL
      EXECUTE t410_sel_min_max_p3 INTO l_tc_qca25,l_tc_qca26

      IF l_tc_qca25 < l_min OR cl_null(l_min) THEN
         LET l_min = l_tc_qca25
      END IF

      IF l_tc_qca26 > l_max OR cl_null(l_max) THEN
         LET l_max = l_tc_qca26
      END IF
   END FOR

   UPDATE tc_qca_file SET tc_qca25 = l_min,
                          tc_qca26 = l_max
    WHERE tc_qca01 = g_tc_qca.tc_qca01
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      IF SQLCA.sqlcode = 0 THEN LET SQLCA.sqlcode = 9050 END IF
      CALL cl_err3("upd","tc_qca_file",g_tc_qca.tc_qca01,"",SQLCA.sqlcode,"","",1)
   END IF
   LET g_tc_qca.tc_qca25 = l_min
   LET g_tc_qca.tc_qca26 = l_max
   DISPLAY BY NAME g_tc_qca.tc_qca25
   DISPLAY BY NAME g_tc_qca.tc_qca26
END FUNCTION
#M031 160705 By TSD.james---(E)

#M025 160714 By TSD.Lynn add ---(S)
#人員檢核
FUNCTION t410_chk_gen(p_cmd,p_gen01)
   DEFINE p_cmd         LIKE type_file.chr1
   DEFINE p_gen01       LIKE gen_file.gen01
   DEFINE l_gen02       LIKE gen_file.gen02
   DEFINE l_genacti     LIKE gen_file.genacti

   LET g_errno = NULL
   LET l_gen02    = NULL
   LET l_genacti  = NULL

   SELECT gen02,genacti
     INTO l_gen02,l_genacti
     FROM gen_file
    WHERE gen01 = p_gen01

   CASE
      WHEN SQLCA.sqlcode=100   LET g_errno='mfg3096'     #無此人員代碼,請重新輸入
      WHEN l_genacti = 'N'     LET g_errno='art-733'     #此員工編號無效
      OTHERWISE                LET g_errno=SQLCA.sqlcode USING '------'
   END CASE

   RETURN l_gen02
END FUNCTION
#M025 160714 By TSD.Lynn add ---(E)

#M045 161114 By TSD.nick ===(s)
#由cqci100取得間距資料
FUNCTION t410_get_tc_qcf(p_cmd)
   DEFINE p_cmd        LIKE type_file.chr1
   DEFINE l_sfb05      LIKE sfb_file.sfb05
   DEFINE l_cnt        LIKE type_file.num5


   IF g_tc_qca.tc_qca01 <> g_tc_qca_t.tc_qca01 OR
      cl_null(g_tc_qca_t.tc_qca01) OR
      g_tc_qca.tc_qca18 <> g_tc_qca_t.tc_qca18 OR
      cl_null(g_tc_qca_t.tc_qca18) THEN
     
      #廠內料號
      LET l_sfb05 = ''
      SELECT sfb05
        INTO l_sfb05
        FROM sfb_file
       WHERE sfb01 = g_tc_qca.tc_qca17
      
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt
        FROM tc_imc_file
       WHERE tc_imc01 = l_sfb05
         AND tc_imc02 = g_tc_qca.tc_qca18
         AND tc_imc31 = g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
      IF cl_null(l_cnt) THEN LET l_cnt=0 END IF
      
      #如果不存在cqci100直接離開
      IF l_cnt = 0 THEN RETURN END IF
      
      INITIALIZE g_tc_qcf.* TO NULL
      SELECT tc_imc11,tc_imc12,tc_imc13,tc_imc14,tc_imc15,
             tc_imc16,tc_imc17,tc_imc18,tc_imc19,tc_imc20,
             tc_imc21,tc_imc22,tc_imc23,tc_imc24,tc_imc25,
             tc_imc26,tc_imc27,tc_imc28,tc_imc29,tc_imc30
        INTO g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,
             g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,g_tc_qcf.tc_qcf07,
             g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,
             g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,g_tc_qcf.tc_qcf13,
             g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,
             g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,g_tc_qcf.tc_qcf19,
             g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21 
        FROM tc_imc_file
       WHERE tc_imc01 = l_sfb05
         AND tc_imc02 = g_tc_qca.tc_qca18
         AND tc_imc31 = g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
      
      LET g_tc_qcf.tc_qcf01 = g_tc_qca.tc_qca01
      
      CASE p_cmd
         WHEN 'a'
            INSERT INTO tc_qcf_file VALUES (g_tc_qcf.*)
            IF SQLCA.sqlcode THEN           
               CALL cl_err3("ins","tc_qcf_file",g_tc_qcf.tc_qcf01,"",SQLCA.sqlcode,"","",1) 
               RETURN
            END IF    
         WHEN 'u'
            LET l_cnt = 0
            SELECT COUNT(1) INTO l_cnt
              FROM tc_qcf_file
             WHERE tc_qcf01 = g_tc_qca.tc_qca01
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
        
            IF l_cnt > 0 THEN
               IF cl_confirm('TSD0057') THEN   #是否要更新間距資料?
                  UPDATE tc_qcf_file SET tc_qcf_file.* = g_tc_qcf.*
                   WHERE tc_qcf01 = g_tc_qcf.tc_qcf01
                  IF SQLCA.sqlcode THEN           
                     CALL cl_err3("ins","tc_qcf_file",g_tc_qcf.tc_qcf01,"",SQLCA.sqlcode,"","",1) 
                     RETURN
                  END IF    
               ELSE
                  RETURN
               END IF    
            END IF    
         OTHERWISE EXIT CASE
      END CASE
      
      DISPLAY BY NAME 
         g_tc_qcf.tc_qcf02,g_tc_qcf.tc_qcf03,g_tc_qcf.tc_qcf04,
         g_tc_qcf.tc_qcf05,g_tc_qcf.tc_qcf06,g_tc_qcf.tc_qcf07,
         g_tc_qcf.tc_qcf08,g_tc_qcf.tc_qcf09,g_tc_qcf.tc_qcf10,
         g_tc_qcf.tc_qcf11,g_tc_qcf.tc_qcf12,g_tc_qcf.tc_qcf13,
         g_tc_qcf.tc_qcf14,g_tc_qcf.tc_qcf15,g_tc_qcf.tc_qcf16,
         g_tc_qcf.tc_qcf17,g_tc_qcf.tc_qcf18,g_tc_qcf.tc_qcf19,
         g_tc_qcf.tc_qcf20,g_tc_qcf.tc_qcf21
   END IF
END FUNCTION

FUNCTION t410_chk_tc_imc()
   DEFINE l_cnt      LIKE type_file.num5

   LET g_errno = ''

   #M049 161222 By TSD.Lynn add ---(S)
   IF NOT cl_null(g_tc_qca.tc_qca01) AND 
      NOT cl_null(g_tc_qca.tc_qca18) AND
       cl_null(g_tc_qca.tc_qca28) THEN
      LET g_errno = 'TSD0070'   #版本不得為空，請檢查此料件+作業編號+版本是否已正確維護品保資料(cqci100)
   END IF
   #M049 161222 By TSD.Lynn add ---(E)
   
   IF cl_null(g_tc_qca.tc_qca01) OR
      cl_null(g_tc_qca.tc_qca28) OR #M049 161216 By TSD.Jay
      cl_null(g_tc_qca.tc_qca18) THEN
      RETURN
   END IF

   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt
     FROM tc_imc_file
    WHERE tc_imc01 = g_tc_qca_1.sfb05
      AND tc_imc02 = g_tc_qca.tc_qca18
      AND tc_imc31 = g_tc_qca.tc_qca28 #M049 161216 By TSD.Jay
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      #M049 161216 By TSD.Jay ---(S)---
      #LET g_errno = 'TSD0059'   #該作業編號+料號不存在"料件品保基本資料維護作業"(cqci100)。
      LET g_errno = 'TSD0069'   #此料件+作業編號+版本，未建立品保資料(cqci100)，請確認!
      #M049 161216 By TSD.Jay ---(E)---
      RETURN
   END IF
END FUNCTION
#M045 161114 By TSD.nick ===(e)

#M025 161208 By TSD.Lynn add ---(S)
FUNCTION t410_pic()
     DEFINE l_chr1      LIKE type_file.chr1

     IF g_tc_qca.tc_qcaconf = 'Y' THEN
        LET l_chr1 = 'Y'
     ELSE
        LET l_chr1 = 'N'
     END IF

     CALL cl_set_field_pic1(l_chr1,"","","","","","","")
END FUNCTION
#M025 161208 By TSD.Lynn add ---(E)
