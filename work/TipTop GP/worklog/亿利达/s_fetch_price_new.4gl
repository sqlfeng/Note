# Prog. Version..: '5.25.02-11.03.23(00000)'     #
#                                                                                                                                   
# Program Name...: s_fetch_price_new.4gl                                                                                                
# Descriptions...: 取單價                                                                                                     
# Date & Author..: NO.FUN-960130 2009/08/12 By Sunyanchun                                                                                               
# Input Parameter: p_cust     客戶編號                                                                                                 
#                  p_item     產品編號                                                                                                 
#                  p_unit     單位                                                                                                     
#                  p_date     日期                                                                                                     
#                  p_type     類型:1.訂單 2.出貨單 3.銷退單             
#                                  4.artt262使用            #FUN-B60067 ADD
#                  p_plant    機構別
#                  p_curr     幣別 
#                  p_term     價格條件
#                  p_payment  收款條件                                                                                       
#                  p_flag     單據類型
#                  p_no       單據編號  
#                  p_no1      提案單號
#                  p_cmd      用戶動作 a:新增 b:修改 d:刪除 e:結束錄入 b:订单变更 
#                  p_count    數量                                                                                                  
# Return Code....: l_price    單價                                                                                                   
#                  l_no       定價編號                                                                                               
#                  l_success  執行成功否
# Modify.........: No.FUN-980020 09/09/23 By douzh GP集團架構修改,sub相關參數
# Modify.........: No.FUN-TQC-9A0109 09/10/23 By sunyanchun  post to area 32
# Modify.........: No.FUN-9B0016 09/11/08 By Sunyanchun post no
# Modify.........: No.FUN-9B0157 09/12/01 By bnlent ins rxc变数不足
# Modify.........: No:FUN-9C0068 09/12/14 By mike 补充抓取价格条件,更新报错讯息，修改跨库写法 
# Modify.........: No:FUN-9C0083 09/12/17 By mike C3等FUNCTION缺少传单据类型的参数
# Modify.........: No:MOD-9C0173 09/12/26 By mike 增加基础取价A3-A6
# Modify.........: No:FUN-A10016 10/01/05 By bnlent 删除单身时折价删除纠正 
# Modify.........: No:FUN-A10106 10/01/21 By destiny 增加价格区间促销和满额促销2种取价方式
# Modify.........: No:FUN-A50102 10/06/25 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:MOD-A60195 10/07/07 By liuxqa s_fetch_price_new,回傳值錯誤
# Modify.........: No:FUN-A70123 10/07/29 By bnlent 報錯方式更改
# Modify.........: No:FUN-AA0065 10/10/15 By shenyang 修改s_fetch_price_new中的 s_fetch_price_C2,添加返回基礎價格         
# Modify.........: No:FUN-AA0065 10/11/03 By shenyang 修改insert依次對應
# Modify.........: No:FUN-AB0083 10/11/19 By suncx 價格代碼取消抓取rzz_file
# Modify.........: No:FUN-AB0102 10/11/25 By shenyang  s_fetch_price_new 中的s_fetch_price_C4() 在INSERT INTO rxc_file之前先DELETE
# Modify.........: No:FUN-B10014 11/01/07 By shiwuying 增加訂單變更的邏輯
# Modify.........: No:MOD-AB0237 11/01/11 By shenyang  相關取價資料取得來源有訂單,出貨單,銷退單
# Modify.........: No:FUN-B10024 11/01/12 By shenyang  加入有效碼判斷
# Modify.........: No:TQC-B20021 11/02/14 By shenyang  改bug
# Modify.........: MOD-B20078 11/02/18 By shenyang 會員卡折扣率調整
# Modify.........: No:MOD-B30045 11/03/08 By baogc 有關全角字符的修改 
# Modify.........: No:MOD-B30225 11/03/12 By lixia arti121增加匯率換算
# Modify.........: No.MOD-B30234 11/03/17 By chenmoyan 修改C4的取法
# Modify.........: No.MOD-B30402 11/03/18 By suncx 參數數量不符BUG修正
# Modify.........: No:FUN-B30012 11/03/10 By baogc 組合促銷和滿額促銷新增有關rxd_file的插入操作
# Modify.........: No:FUN-B30012 11/03/10 By baogc 單價和金額小數位bug修改
# Modify.........: No:MOD-B20087 11/03/25 By baogc 有關會員卡和會員卡折扣邏輯的修改
# Modify.........: No:MOD-B30045 11/04/02 By baogc 增加滿額促銷中滿量的邏輯
# Modify.........: No:TQC-B40014 11/04/11 By baogc 修改A2中會員價格的取法
# Modify.........: No:TQC-B60015 11/06/03 By baogc A2中增加rxc_file記錄的邏輯
# Modify.........: No:FUN-B60067 11/06/10 By baogc A2中增加artt262調用時候的判斷
# Modify.........: No:TQC-B60055 11/06/11 By Summer 修正TQC-B60015,FUNCTION s_fetch_price_A2需回傳兩個值

DATABASE ds
GLOBALS "../../config/top.global"
DEFINE g_term           LIKE ohi_file.ohi01      #NO.FUN-9B0016
DEFINE g_member         LIKE rxc_file.rxc11
DEFINE g_leater_price   LIKE oeb_file.oeb13
DEFINE g_cmd            LIKE type_file.chr1
DEFINE g_cust           LIKE occ_file.occ01
DEFINE g_payment        LIKE oea_file.oea32
DEFINE g_flg            LIKE type_file.chr1         #FUN-AA0065
DEFINE l_sx             LIKE type_file.num5         #FUN-AA0065 
DEFINE l_sx_1           LIKE type_file.num5         #FUN-AA0065
DEFINE t_azi03          LIKE azi_file.azi03
DEFINE t_azi04          LIKE azi_file.azi04
DEFINE g_oea            RECORD LIKE oea_file.*
DEFINE g_oga            RECORD LIKE oga_file.*
DEFINE g_oha            RECORD LIKE oha_file.*
FUNCTION s_fetch_price_new(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd)
DEFINE p_cust       LIKE tqo_file.tqo01,     #客戶編號
       p_item       LIKE tqn_file.tqn03,     #料件編號
       p_unit       LIKE tqn_file.tqn04,     #單位
       p_date       LIKE type_file.dat,      #日期
       p_type       LIKE type_file.chr1,     #單據類型
       p_cmd        LIKE type_file.chr1,     #用戶動作
       p_curr       LIKE azi_file.azi01,     #幣別
       p_plant      LIKE azp_file.azp01,     #機構別
       p_term       LIKE oah_file.oah01,     #價格條件
       p_payment    LIKE oea_file.oea32,     #付款條件
       p_no1        LIKE tqx_file.tqx01,     #提案單號
       p_no         LIKE oea_file.oea01,     #單據編號
       p_line       LIKE oeb_file.oeb03,     #項次
       p_count      LIKE xmd_file.xmd08,     #料件數量
       l_success    LIKE type_file.chr1
DEFINE l_dbs       LIKE azp_file.azp03
DEFINE l_sql       STRING
DEFINE l_n         LIKE type_file.num5
DEFINE l_price     LIKE oeb_file.oeb13
DEFINE l_a2_price  LIKE oeb_file.oeb13       #TQC-B60015 ADD
DEFINE l_ohi03     LIKE ohi_file.ohi03
DEFINE l_ohi02     LIKE ohi_file.ohi02
DEFINE l_ohi04     LIKE ohi_file.ohi04
DEFINE l_rate1     LIKE xmh_file.xmh03
DEFINE l_rate2     LIKE xmh_file.xmh03
DEFINE l_rate      LIKE xmh_file.xmh03
DEFINE l_no        LIKE oea_file.oea01
#DEFINE l_rzz03     LIKE rzz_file.rzz03      #FUN-ABOO83 mark
DEFINE l_oah04     LIKE oah_file.oah04
DEFINE l_oah05     LIKE oah_file.oah05
DEFINE l_oah06     LIKE oah_file.oah06
DEFINE l_c1_price  LIKE oeb_file.oeb13
DEFINE l_c2_price  LIKE oeb_file.oeb13
DEFINE l_c3_price  LIKE oeb_file.oeb13
DEFINE l_c4_rate  LIKE oeb_file.oeb13
DEFINE l_a1_price  LIKE oeb_file.oeb13
DEFINE l_old_price  LIKE oeb_file.oeb13
DEFINE l_b1_flag   LIKE type_file.chr1
DEFINE l_b2_flag   LIKE type_file.chr1
DEFINE l_c1_flag   LIKE type_file.chr1
DEFINE l_c2_flag   LIKE type_file.chr1
DEFINE l_c3_flag   LIKE type_file.chr1
DEFINE l_c4_flag   LIKE type_file.chr1
DEFINE l_sum       LIKE rxc_file.rxc06
DEFINE l_rxc00     LIKE rxc_file.rxc00
DEFINE l_rxc03     LIKE rxc_file.rxc03
DEFINE l_oeb03     LIKE oeb_file.oeb03
DEFINE l_cnt       LIKE type_file.num5
DEFINE l_n1        LIKE type_file.num5
DEFINE l_price_new  LIKE oeb_file.oeb13   #FUN-AA0065  
DEFINE l_price_1    DYNAMIC ARRAY OF   LIKE oeb_file.oeb13
DEFINE l_rxc15_1    DYNAMIC ARRAY OF   LIKE rxc_file.rxc15
DEFINE l_rxc06_1    DYNAMIC ARRAY OF   LIKE rxc_file.rxc06
DEFINE l_rxc03_1    DYNAMIC ARRAY OF   LIKE rxc_file.rxc03
DEFINE l_tmp        DYNAMIC ARRAY OF RECORD
                        no    LIKE oeb_file.oeb01,
                        line  LIKE oeb_file.oeb03,
                        item  LIKE ima_file.ima01,
                        unit  LIKE oeb_file.oeb05,
                        price LIKE oeb_file.oeb13,
                        qty   LIKE oeb_file.oeb12,
                        qty2  LIKE oeb_file.oeb12
                     END  RECORD      
DEFINE g_oeb       DYNAMIC ARRAY OF RECORD
                        oeb917  LIKE oeb_file.oeb917
                     END  RECORD
DEFINE d_oeb     DYNAMIC ARRAY OF RECORD  
                     oeb14     LIKE oeb_file.oeb14,   
                     oeb14t    LIKE oeb_file.oeb14t   
                 END RECORD  
DEFINE d_ogb     DYNAMIC ARRAY OF RECORD 
                     ogb14     LIKE ogb_file.ogb14,   
                     ogb14t    LIKE ogb_file.ogb14t   
                 END RECORD 
DEFINE d_ohb     DYNAMIC ARRAY OF RECORD  
                     ohb14     LIKE ohb_file.ohb14,   
                     ohb14t    LIKE ohb_file.ohb14t   
                 END RECORD
DEFINE g_rxc_str LIKE type_file.chr1                #MOD-B30045 ADD
DEFINE l_rxc_n   LIKE type_file.num5                #MOD-B30045 ADD

   WHENEVER ERROR CONTINUE
 
   IF p_count = 0 THEN RETURN 0,0 END IF      #NO.TQC-9A0109 #FUN-AA0065
   IF p_item IS NULL THEN RETURN 0,0 END IF     #FUN-AA0065
   IF p_unit IS NULL THEN RETURN 0,0 END IF     #FUN-AA0065
 
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0,0                                   #FUN-AA0065
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   #判斷價格條件是否存在
  #FUN-9C0068   ---start 
   IF cl_null(p_term) THEN
      #LET l_sql = "SELECT occ44 FROM ",l_dbs,"occ_file ",
      LET l_sql = "SELECT occ44 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  " WHERE occ01 = '",p_cust,"' ",
                  "   AND occ1004='1' ",
                  "   AND occacti='Y' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
      PREPARE pre_sel_occ1 FROM l_sql
      EXECUTE pre_sel_occ1 INTO p_term
      IF SQLCA.SQLCODE THEN
         CALL cl_err('sel occ_file','sub-221',1)
         RETURN 0,0                                           #FUN-AA0065
      END IF
   END IF 
  #FUN-9C0068    ---end   
   #LET l_sql = "SELECT oah04,oah05,oah06 FROM ",l_dbs,"oah_file ",
   LET l_sql = "SELECT oah04,oah05,oah06 FROM ",cl_get_target_table(g_plant_new,'oah_file'), #FUN-A50102
               "   WHERE oah01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_sel_oah FROM l_sql
   EXECUTE pre_sel_oah INTO l_oah04,l_oah05,l_oah06 
   IF SQLCA.SQLCODE THEN
     #CALL cl_err('sel oah_file',SQLCA.SQLCODE,1) #FUN-9C0068
      CALL cl_err('sel oah_file','sub-221',1) #FUN-9C0068
      RETURN 0,0                              #FUN-AA0065
   END IF
   IF p_type = 1 THEN LET l_rxc00 = '01' END IF
   IF p_type = 2 THEN LET l_rxc00 = '02' END IF
   IF p_type = 3 THEN LET l_rxc00 = '03' END IF
   IF p_cmd = 'd' THEN
      #LET l_sql = "SELECT rxc03 FROM ",l_dbs,"rxc_file ",
      LET l_sql = "SELECT rxc03 FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
                  "   WHERE rxc00 = '",l_rxc00,"'",
                  "   AND rxc01 = '",p_no,"' AND rxc02 = '",p_line,"'"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
      PREPARE pre_sel_rxc13 FROM l_sql
      EXECUTE pre_sel_rxc13 INTO l_rxc03
      IF l_rxc03 IS NULL THEN LET l_rxc03 = ' ' END IF
      IF l_rxc03 = '99' THEN 
         #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file WHERE rxc00 = '",l_rxc00,"'",
         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
                     " WHERE rxc00 = '",l_rxc00,"'",
                     "   AND rxc01 = '",p_no,"' AND rxc03 = '99'"
      ELSE
         #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file WHERE rxc00 = '",l_rxc00,"'",
         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
                     " WHERE rxc00 = '",l_rxc00,"'",
                     "   AND rxc01 = '",p_no,"' AND rxc02 = '",p_line,"'"
      END IF
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
      PREPARE pre_del_rxc05 FROM l_sql
      EXECUTE pre_del_rxc05
      IF SQLCA.SQLCODE THEN
         CALL cl_err('',SQLCA.SQLCODE,1)
         RETURN 0,0               #FUN-AA0065
      END IF
     #RETURN 0,0  #No.FUN-A10016  #FUN-AA0065 #FUN-B10014 Mark
   END IF
   LET g_term = p_term
   LET g_cmd = p_cmd
   LET g_payment = p_payment
 
   IF l_oah04 IS NULL THEN LET l_oah04 = ' ' END IF
   IF l_oah05 IS NULL THEN LET l_oah05 = ' ' END IF
   IF l_oah06 IS NULL THEN LET l_oah06 = ' ' END IF
 
   LET l_old_price = 0
   LET l_c1_price = 0
   LET l_c2_price = 0
   LET l_c3_price = 0
   LET l_c4_rate = 100
   LET l_rate = 100
   LET l_rate1 = 100
   LET l_rate2 = 100
   LET l_price = 0 
   LET l_a1_price = 0 
   LET g_leater_price = 0
   LET l_b1_flag = 'N'
   LET l_b2_flag = 'N'
   LET l_c1_flag = 'N'
   LET l_c2_flag = 'N'
   LET l_c3_flag = 'N'
   LET l_c4_flag = 'N'
   LET l_sx = 0           #FUN-AA0065
   LET l_sx_1 = -1        #FUN-AA0065

###-MOD-B30045- ADD - BEGIN -----------------------------------------------
   IF p_cmd = 'd' THEN
      LET g_rxc_str = 'N'
      LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                  " WHERE rxc03 IN ('01','02','03','12') "	,
                  "   AND rxc01 = '",p_no,"' "
      CASE p_type
         WHEN '1'
            LET l_sql = l_sql," AND rxc00 = '01'"
         WHEN '2'
            LET l_sql = l_sql," AND rxc00 = '02'"
         WHEN '3'
            LET l_sql = l_sql," AND rxc00 = '03'"
      END CASE
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
      PREPARE pre_sel_rxc_del FROM l_sql
      EXECUTE pre_sel_rxc_del INTO l_rxc_n
      IF l_rxc_n > 0 THEN
         LET g_rxc_str = 'Y'
      END IF
   END IF
###-MOD-B30045- ADD -  END  -----------------------------------------------

   #LET l_sql = "SELECT COUNT(*) FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "  WHERE ohi01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_sel_ohi FROM l_sql
   EXECUTE pre_sel_ohi INTO l_n
   IF l_n IS NULL OR l_n = 0 THEN
      CALL cl_err('','',1)
      RETURN 0,0                                               #FUN-AA0065
   END IF
   #取出指定價格條件的各個組
   #LET l_sql = "SELECT ohi02 FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT ohi02 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "   WHERE ohi01 = '",p_term,"'",
               "     GROUP BY ohi02 "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_ohi1 FROM l_sql
   DECLARE ohi1_cur CURSOR FOR pre_sel_ohi1
   LET l_price = 0
   FOREACH ohi1_cur INTO l_ohi02
      #LET l_c1_price = 0
      #LET l_c2_price = 0
      #LET l_c3_price = 0
      #LET l_c4_rate = 0
      #LET l_rate = 0
      #LET l_rate1 = 0
      #LET l_rate2 = 0
      #LET l_price = 0 
      IF l_ohi02 IS NULL THEN CONTINUE FOREACH END IF
      #LET l_sql = "SELECT ohi03 FROM ",l_dbs,"ohi_file ",
      LET l_sql = "SELECT ohi03 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
                  "   WHERE ohi01 ='",p_term,"'",
                  "     AND ohi02 ='",l_ohi02,"'",
                  "     ORDER BY ohi03 "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
      PREPARE pre_sel_ohi03 FROM l_sql
      DECLARE cur_ohi03 CURSOR FOR pre_sel_ohi03
      FOREACH cur_ohi03 INTO l_ohi03
         IF l_ohi03 IS NULL THEN CONTINUE FOREACH END IF
         #取出價格代碼
         #LET l_sql = "SELECT ohi04 FROM ",l_dbs,"ohi_file ",
         LET l_sql = "SELECT ohi04 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
                     "   WHERE ohi01 = '",p_term,"'",
                     "     AND ohi02 = '",l_ohi02,"'",
                     "     AND ohi03 = '",l_ohi03,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
         PREPARE pre_sel_ohi04 FROM l_sql
         EXECUTE pre_sel_ohi04 INTO l_ohi04
         #根據價格代碼取出價格的類別
         #LET l_sql = "SELECT rzz03 FROM ",l_dbs,"rzz_file ",
         #            "   WHERE rzz00 = '2' AND rzz01 = '",l_ohi04,"'"
         #PREPARE pre_sel_rzz03 FROM l_sql
         #EXECUTE pre_sel_rzz03 INTO l_rzz03
         #B/C類型價格不互斥
         IF l_oah05 = 'N' THEN
            IF l_oah06 = 'N' THEN    #同組同類型價格不互斥
               #B/C類型價格不互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3' 
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4' 
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6' 
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant) 
                        RETURNING l_price    
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1'
                     CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                        RETURNING l_rate
                  WHEN l_ohi04 = 'B2'
                     CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                        RETURNING l_rate1,l_rate2
                  WHEN l_ohi04 = 'C1'
                     CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
#                       RETURNING l_price    #MOD-B30234
                        RETURNING l_c1_price #MOD-B30234
                  WHEN l_ohi04 = 'C2'
                     CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
#                       RETURNING l_price    #MOD-B30234
                        RETURNING l_c2_price #MOD-B30234
                  WHEN l_ohi04 = 'C3' 
                     CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
#                       RETURNING l_price    #MOD-B30234
                        RETURNING l_c3_price #MOD-B30234
                  WHEN l_ohi04 = 'C4'
                     CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
#                       RETURNING l_price    #MOD-B30234
                        RETURNING l_c4_rate  #MOD-B30234
               END CASE
            ELSE                     #同組價格互斥
               #B/C類型價格不互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                  #  CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr) #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2' 
                     IF l_b1_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                      END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_c2_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2' 
                     IF l_c1_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         ELSE     #B/C類型價格互斥
            IF l_oah06 = 'Y' THEN    #同組價格互斥
               #B/C類型價格互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr) #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_b1_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            ELSE                     #同組價格不互斥
               #B/C類型價格互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)    #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         END IF
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' THEN #MOD-9C0173
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN #MOD-9C0173 #TQC-B60015 MARK
         IF l_ohi04 = 'A1' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN #TQC-B60015 ADD 
            LET l_a1_price = l_price
         END IF
###TQC-B60015 - ADD - BEGIN ------------------------------------
         IF l_ohi04 = 'A2' THEN
            LET l_a1_price =  l_a2_price
         END IF
###TQC-B60015 - ADD -  END  ------------------------------------
         IF l_c1_price != 0 THEN LET l_price = l_c1_price END IF
         IF l_c2_price != 0 THEN LET l_price = l_c2_price END IF
         IF l_c3_price != 0 THEN LET l_price = l_c3_price END IF
         IF l_c4_rate != 0 THEN LET l_price = l_price*l_c4_rate/100 END IF
         IF l_rate != 0 THEN LET l_price = l_price*l_rate/100 END IF
         IF l_rate1 != 0 THEN LET l_price = l_price*l_rate1/100 END IF
         IF l_rate2 != 0 THEN LET l_price = l_price*l_rate2/100 END IF
         IF l_ohi04 != 'B1' AND l_ohi04 != 'B2' AND l_ohi04 != 'C4' AND l_price != 0 THEN
            LET g_leater_price = l_price
         END IF
         IF l_price = 0 OR l_price IS NULL THEN LET l_price = l_old_price END IF
         IF l_price != 0 AND l_price IS NOT NULL THEN LET l_old_price = l_price END IF
         IF l_rate != 100 AND l_rate != 0 THEN      #表示已取到B1類價格
            LET l_b1_flag = 'Y'
         END IF
         #若B2類價格已經取到
         IF l_rate1 != 100 OR l_rate2 != 100 THEN
            LET l_b2_flag = 'Y'
         END IF
	 IF l_c1_price != 0 THEN LET l_c1_flag = 'Y' END IF
         IF l_c2_price != 0 THEN LET l_c2_flag = 'Y' END IF
         IF l_c3_price != 0 THEN LET l_c3_flag = 'Y' END IF
         IF l_c4_rate != 100 THEN LET l_c4_flag = 'Y' END IF
         LET l_rate = 100
         LET l_rate1 = 100
         LET l_rate2 = 100
         LET l_c1_price = 0 
         LET l_c2_price = 0 
         LET l_c3_price = 0 
         LET l_c4_rate = 100 
      END FOREACH
      IF l_price != 0 THEN EXIT FOREACH END IF
   END FOREACH
#FUN-AA0065-----add-- begin--   
   LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
               " WHERE rxc01 = '",p_no,"' ",
  #FUN-B10014 Begin---
               "   AND rxc00 = '",l_rxc00,"' ",
               "   AND rxc03 IN ('01','02','03') "
   IF p_cmd <> 'd' THEN
      LET l_sql = l_sql CLIPPED,"   AND rxc02 = '",p_line,"'  "
   END IF
  #FUN-B10014 End-----
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
   PREPARE pre_sel_rxc1 FROM l_sql
   EXECUTE pre_sel_rxc1 INTO l_n1
#  IF l_n1 >0 AND g_azw.azw04 = '2' THEN                        #MOD-B30045 MARK
   IF (l_n1 > 0 OR g_rxc_str = 'Y') AND g_azw.azw04 = '2' THEN  #MOD-B30045 ADD
      LET l_cnt=1
      CASE p_type
        WHEN '1'
           LET l_sql = "SELECT no,line,item,unit,oeb37,qty,qty2,oeb917 FROM s_price_c2,   ",
                       cl_get_target_table(g_plant_new,'oeb_file'),
                       "   WHERE oeb01 = '",p_no,"' ",
                       "   AND oeb01 = no AND line = oeb03 "
        WHEN '2'
           LET l_sql = "SELECT no,line,item,unit,ogb37,qty,qty2,ogb917 FROM s_price_c2,   ",
                       cl_get_target_table(g_plant_new,'ogb_file'),
                       "   WHERE ogb01 = '",p_no,"' ",
                       "   AND ogb01 = no AND line = ogb03 "
        WHEN '3'
           LET l_sql = "SELECT no,line,item,unit,ohb37,qty,qty2,ohb917 FROM s_price_c2,   ",
                       cl_get_target_table(g_plant_new,'ohb_file'),
                       "   WHERE ohb01 = '",p_no,"' ",
                       "   AND ohb01 = no AND line = ohb03 "
      END CASE
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
      PREPARE pre_del_line1 FROM l_sql
      DECLARE cur_scale_1 CURSOR FOR pre_del_line1
      FOREACH cur_scale_1 INTO l_tmp[l_cnt].* ,g_oeb[l_cnt].oeb917
         IF l_tmp[l_cnt].line <> p_line THEN 
            CALL s_fetch_price_new2(p_cust,l_tmp[l_cnt].item,l_tmp[l_cnt].unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,l_tmp[l_cnt].no,l_tmp[l_cnt].line,l_tmp[l_cnt].qty,p_no1,p_cmd,'2')
            RETURNING l_price_new,g_flg
         END IF 
         LET l_sql = "SELECT SUM(rxc06) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                     "   WHERE rxc01 = '",l_tmp[l_cnt].no,"' ",
                     "   AND  rxc02 = '",l_tmp[l_cnt].line,"'  "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
         PREPARE pre_sel_rxc2 FROM l_sql
         EXECUTE pre_sel_rxc2 INTO l_rxc06_1[l_cnt]
###-MOD-B30045- ADD - BEGIN ---------------------------------
         IF cl_null(l_rxc06_1[l_cnt]) THEN
            LET l_rxc06_1[l_cnt] = 0
         END IF
###-MOD-B30045- ADD -  END  ---------------------------------
         LET l_price_1[l_cnt] = (l_tmp[l_cnt].price*l_tmp[l_cnt].qty -l_rxc06_1[l_cnt])/l_tmp[l_cnt].qty
         LET l_sql = "SELECT rxc03 FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                     "   WHERE rxc01 = '",l_tmp[l_cnt].no,"' ",
                     "   AND  rxc02 = '",l_tmp[l_cnt].line,"'  "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
         PREPARE pre_sel_rxc3 FROM l_sql
         EXECUTE pre_sel_rxc3 INTO l_rxc03_1[l_cnt]
    #    IF l_tmp[l_cnt].qty > l_tmp[l_cnt].qty2 THEN                         #MOD-B30045 MARK
         IF (l_tmp[l_cnt].qty > l_tmp[l_cnt].qty2) OR (g_rxc_str = 'Y') THEN  #MOD-B30045 ADD
              CASE p_type
                 WHEN '1'
                    SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
                    SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                    WHERE azi01=g_oea.oea23 
       #            CALL cl_digcut(l_rxc06_1[l_cnt],t_azi03) RETURNING l_rxc06_1[l_cnt]    #FUN-B30012 MARK
                    CALL cl_digcut(l_rxc06_1[l_cnt],t_azi04) RETURNING l_rxc06_1[l_cnt]    #FUN-B30012 ADD
                    CALL cl_digcut(l_price_1[l_cnt],t_azi03) RETURNING l_price_1[l_cnt]  #FUN-B30012 ADD
                    IF g_oea.oea213 = 'N' THEN
                       LET d_oeb[l_cnt].oeb14 =g_oeb[l_cnt].oeb917*l_price_1[l_cnt]  
                       CALL cl_digcut(d_oeb[l_cnt].oeb14,t_azi04) RETURNING d_oeb[l_cnt].oeb14  
                       LET d_oeb[l_cnt].oeb14t=d_oeb[l_cnt].oeb14*(1+g_oea.oea211/100)   
                       CALL cl_digcut(d_oeb[l_cnt].oeb14t,t_azi04)RETURNING d_oeb[l_cnt].oeb14t   
                    ELSE
                       LET d_oeb[l_cnt].oeb14t=g_oeb[l_cnt].oeb917*l_price_1[l_cnt]   
                       CALL cl_digcut(d_oeb[l_cnt].oeb14t,t_azi04)RETURNING d_oeb[l_cnt].oeb14t   
                       LET d_oeb[l_cnt].oeb14 =d_oeb[l_cnt].oeb14t/(1+g_oea.oea211/100)   
                       CALL cl_digcut(d_oeb[l_cnt].oeb14,t_azi04) RETURNING d_oeb[l_cnt].oeb14     
                    END IF  
        #              CALL cl_digcut(l_price_1[l_cnt],t_azi04) RETURNING l_price_1[l_cnt]  #FUN-B30012 MARK
                       UPDATE oeb_file SET oeb13=l_price_1[l_cnt],
                                           oeb14=d_oeb[l_cnt].oeb14,
                                           oeb14t=d_oeb[l_cnt].oeb14t,
                                           oeb47 = l_rxc06_1[l_cnt] 
                       WHERE oeb01=g_oea.oea01
                       AND oeb03=l_tmp[l_cnt].line
                    IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                       CALL cl_err3("upd","oeb_file",g_oea.oea01,"",SQLCA.sqlcode,"","",1)  
                    END IF 
                 WHEN '2'
                    SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
                    SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                    WHERE azi01=g_oga.oga23
                    CALL cl_digcut(l_rxc06_1[l_cnt],t_azi04) RETURNING l_rxc06_1[l_cnt]
                    CALL cl_digcut(l_price_1[l_cnt],t_azi03) RETURNING l_price_1[l_cnt]     #MOD-B20087 ADD
                    IF g_oga.oga213 = 'N' THEN
                       LET d_ogb[l_cnt].ogb14 =g_oeb[l_cnt].oeb917*l_price_1[l_cnt]  
                       CALL cl_digcut(d_ogb[l_cnt].ogb14,t_azi04) RETURNING d_ogb[l_cnt].ogb14  
                       LET d_ogb[l_cnt].ogb14t=d_ogb[l_cnt].ogb14*(1+g_oga.oga211/100)   
                       CALL cl_digcut(d_ogb[l_cnt].ogb14t,t_azi04)RETURNING d_ogb[l_cnt].ogb14t   
                    ELSE
                       LET d_ogb[l_cnt].ogb14t=g_oeb[l_cnt].oeb917*l_price_1[l_cnt]   
                       CALL cl_digcut(d_ogb[l_cnt].ogb14t,t_azi04)RETURNING d_ogb[l_cnt].ogb14t   
                       LET d_ogb[l_cnt].ogb14 =d_ogb[l_cnt].ogb14t/(1+g_oga.oga211/100)   
                       CALL cl_digcut(d_ogb[l_cnt].ogb14,t_azi04) RETURNING d_ogb[l_cnt].ogb14     
                    END IF
         #             CALL cl_digcut(l_price_1[l_cnt],t_azi03) RETURNING l_price_1[l_cnt]   #MOD-B20087 MARK
                       UPDATE ogb_file SET ogb13=l_price_1[l_cnt],
                                           ogb14=d_ogb[l_cnt].ogb14,
                                           ogb14t=d_ogb[l_cnt].ogb14t,
                                           ogb47 = l_rxc06_1[l_cnt] 
                       WHERE ogb01=g_oga.oga01
                       AND ogb03=l_tmp[l_cnt].line
                    IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                       CALL cl_err3("upd","ogb_file",g_oga.oga01,"",SQLCA.sqlcode,"","",1)  
                    END IF  
                 WHEN '3'
                    SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
                    SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                    WHERE azi01=g_oha.oha23
                    CALL cl_digcut(l_rxc06_1[l_cnt],t_azi04) RETURNING l_rxc06_1[l_cnt]
                    CALL cl_digcut(l_price_1[l_cnt],t_azi03) RETURNING l_price_1[l_cnt]      #MOD-B20087 ADD
                    IF g_oha.oha213 = 'N' THEN
                       LET d_ohb[l_cnt].ohb14 =g_oeb[l_cnt].oeb917*l_price_1[l_cnt]  
                       CALL cl_digcut(d_ohb[l_cnt].ohb14,t_azi04) RETURNING d_ohb[l_cnt].ohb14  
                       LET d_ohb[l_cnt].ohb14t=d_ohb[l_cnt].ohb14*(1+g_oha.oha211/100)   
                       CALL cl_digcut(d_ohb[l_cnt].ohb14t,t_azi04)RETURNING d_ohb[l_cnt].ohb14t   
                    ELSE
                       LET d_ohb[l_cnt].ohb14t=g_oeb[l_cnt].oeb917*l_price_1[l_cnt]   
                       CALL cl_digcut(d_ohb[l_cnt].ohb14t,t_azi04)RETURNING d_ohb[l_cnt].ohb14t   
                       LET d_ohb[l_cnt].ohb14 =d_ohb[l_cnt].ohb14t/(1+g_oha.oha211/100)   
                       CALL cl_digcut(d_ohb[l_cnt].ohb14,t_azi04) RETURNING d_ohb[l_cnt].ohb14     
                    END IF
          #            CALL cl_digcut(l_price_1[l_cnt],t_azi03) RETURNING l_price_1[l_cnt]   #MOD-B20087 MARK
                       UPDATE ohb_file SET ohb13=l_price_1[l_cnt],
                                           ohb14=d_ohb[l_cnt].ohb14,
                                           ohb14t=d_ohb[l_cnt].ohb14t,
                                           ohb67 = l_rxc06_1[l_cnt] 
                       WHERE ohb01=g_oha.oha01
                       AND ohb03=l_tmp[l_cnt].line
                    IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                       CALL cl_err3("upd","ohb_file",g_oha.oha01,"",SQLCA.sqlcode,"","",1)  
                    END IF
              END CASE
          END IF 
      END FOREACH 
  #END IF   #FUN-B10014
   ELSE     #FUN-B10014
#FUN-AA0065-----add-- end--    
   IF p_cmd = 'e' OR p_cmd = 'd' OR p_cmd = 'u' THEN 
      IF p_type = '1' THEN
         LET l_rxc00 = '01'
         #LET l_sql = "SELECT oeb03 FROM ",l_dbs,"oeb_file WHERE oeb01 = '",p_no,"'"
         LET l_sql = "SELECT oeb03 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                     " WHERE oeb01 = '",p_no,"'"
      END IF 
      IF p_type = '2' THEN
         LET l_rxc00 = '02'
         #LET l_sql = "SELECT ogb03 FROM ",l_dbs,"ogb_file WHERE ogb01 = '",p_no,"'"
         LET l_sql = "SELECT ogb03 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                     " WHERE ogb01 = '",p_no,"'"
      END IF 
      IF p_type = '3' THEN
         LET l_rxc00 = '03'
         #LET l_sql = "SELECT ohb03 FROM ",l_dbs,"ohb_file WHERE ohb01 = '",p_no,"'"
         LET l_sql = "SELECT ohb03 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                     " WHERE ohb01 = '",p_no,"'"
      END IF
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102    
      PREPARE pre_sel_oeb_ohb FROM l_sql
      DECLARE cur_oeb_ohb CURSOR FOR pre_sel_oeb_ohb
      FOREACH cur_oeb_ohb INTO l_oeb03
         #LET l_sql = "SELECT SUM(rxc06) FROM ",l_dbs,"rxc_file ",
         LET l_sql = "SELECT SUM(rxc06) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
                     "   WHERE rxc00 = '",l_rxc00,"' AND rxc01 = '",p_no,"'",
                     "     AND rxc02 = '",l_oeb03,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
         PREPARE pre_sel_sum FROM l_sql
         EXECUTE pre_sel_sum INTO l_sum
         IF l_sum IS NULL THEN LET l_sum = 0 END IF
         IF p_type = '1' THEN
            #LET l_sql = "UPDATE ",l_dbs,"oeb_file SET oeb47 = '",l_sum,"'",
            LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                          " SET oeb47 = '",l_sum,"'",
                        "  WHERE oeb01 = '",p_no,"' AND oeb03 = '",l_oeb03,"'"
         END IF
         IF p_type = '2' THEN
            #LET l_sql = "UPDATE ",l_dbs,"ogb_file SET ogb47 = '",l_sum,"'",
            LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                          " SET ogb47 = '",l_sum,"'",
                        "  WHERE ogb01 = '",p_no,"' AND ogb03 = '",l_oeb03,"'"
         END IF
         IF p_type = '3' THEN
            #LET l_sql = "UPDATE ",l_dbs,"ohb_file SET ohb67 = '",l_sum,"'",
            LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                          " SET ohb67 = '",l_sum,"'",
                        "  WHERE ohb01 = '",p_no,"' AND ohb03 = '",l_oeb03,"'"
         END IF
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
         PREPARE pre_upd_oeb6 FROM l_sql
         EXECUTE pre_upd_oeb6
         IF SQLCA.SQLCODE THEN
            CALL cl_err('',SQLCA.SQLCODE,1)
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
  END IF  #FUN-B10014 End-----
  #FUN-B10014 Begin---
   IF g_azw.azw04 <> '2' THEN
      LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                  " WHERE rxc00 = '",l_rxc00,"'",
                  "   AND rxc01 = '",p_no,"' "
      PREPARE pre_del_rxc FROM l_sql
      EXECUTE pre_del_rxc
      IF SQLCA.SQLCODE THEN
         CALL cl_err('',SQLCA.SQLCODE,1)
      END IF
   END IF
  #FUN-B10014 End-----
   #RETURN l_a1_price   #No.MOD-A60195 mark
   RETURN l_price,l_a1_price    #No.MOD-A60195 mod  #FUN-AA0065
END FUNCTION
FUNCTION s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
DEFINE p_cust       LIKE tqo_file.tqo01,  
       p_item       LIKE tqn_file.tqn03, 
       p_unit       LIKE tqn_file.tqn04,
       p_date       LIKE type_file.dat,  
       p_type       LIKE type_file.chr1000,  
       p_curr       LIKE azi_file.azi01,
       p_plant      LIKE azp_file.azp01,
       l_sql        LIKE type_file.chr1000,
       l_success    LIKE type_file.chr1
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_occ37      LIKE occ_file.occ37
DEFINE l_tqo03      LIKE tqo_file.tqo03
DEFINE l_no         LIKE tqo_file.tqo01
DEFINE l_price      LIKE oeb_file.oeb13
DEFINE l_result     LIKE type_file.num5
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
  
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   SELECT occ37 INTO l_occ37 FROM occ_file WHERE occ01 = p_cust
   LET l_success='Y'
   
   LET l_sql="SELECT tqo03,tqn01,tqn05",                                                                                          
             #"  FROM ",l_dbs,"tqn_file,",l_dbs,"tqo_file,",l_dbs,"tqm_file ",
             "  FROM ",cl_get_target_table(g_plant_new,'tqn_file'),",", #FUN-A50102
                       cl_get_target_table(g_plant_new,'tqo_file'),",", #FUN-A50102
                       cl_get_target_table(g_plant_new,'tqm_file'),     #FUN-A50102           
             "  WHERE tqo01 = '",p_cust CLIPPED,"'",                                                                             
             "    AND tqo02 = tqn01",                                                                                             
             "    AND tqm01 = tqn01",                                                                                             
             "    AND tqn03 = '",p_item CLIPPED,"'",                                                                              
             "    AND tqn04 = '",p_unit CLIPPED,"'",                                                                              
             "    AND tqn06<= '",p_date,"'",                                                                                      
             "    AND tqm05 = '",p_curr,"'",                                                                                      
             "    AND (tqn07 is null OR tqn07>= '",p_date,"')",    
             "    AND tqoacti = 'Y'",           
             "    AND tqm04 ='1'"
   IF l_occ37 = 'Y' THEN
      LET l_sql=l_sql CLIPPED," AND tqm06 ='4' ORDER By tqo03"
   ELSE
      LET l_sql=l_sql CLIPPED," AND (tqm06 ='1' or tqm06='5') ORDER By tqo03"
   END IF
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE tqn_pl  FROM l_sql
   DECLARE tqn_cur SCROLL CURSOR FOR tqn_pl
   OPEN tqn_cur
   FETCH FIRST tqn_cur INTO l_tqo03,l_no,l_price
   IF SQLCA.sqlcode THEN
      CALL cl_is_multi_feature_manage(p_item) RETURNING l_result
      IF l_result = 1 THEN
         IF g_bgerr THEN 
            CALL s_errmsg('','','','atm-257',0)     
         ELSE                          
            CALL cl_err('','atm-257',0) 
         END IF
      END IF
      LET l_success='N'
   END IF
   CLOSE tqn_cur
   IF cl_null(l_no) THEN          
      CALL cl_is_multi_feature_manage(p_item) RETURNING l_result   
      IF l_result = 1 THEN        
         IF g_bgerr THEN    
            CALL s_errmsg('','','','atm-257',0) 
         ELSE     
            CALL cl_err('','atm-257',0)   
         END IF    
      END IF                                                                                                                   
      LET l_success='N' 
   END IF            
   IF cl_null(l_price) THEN LET l_price=0  END IF                                                                              
   RETURN l_price
END FUNCTION
#FUNCTION s_fetch_price_A2(p_item,p_unit,p_plant)
#FUNCTION s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225   #TQC-B40014 MARK
#FUNCTION s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)     #TQC-B40014 ADD #TQC-B60015
FUNCTION s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)     #TQC-B60015 ADD
DEFINE p_plant      LIKE azp_file.azp01,  
       p_item       LIKE tqn_file.tqn03, 
       p_unit       LIKE tqn_file.tqn04,
       l_sql        LIKE type_file.chr1000
DEFINE l_rtz05      LIKE rtz_file.rtz05
DEFINE l_rtg05      LIKE rtg_file.rtg05
DEFINE l_rtg08      LIKE rtg_file.rtg08
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_rth04      LIKE rth_file.rth04
DEFINE p_curr       LIKE azi_file.azi01   #MOD-B30225
DEFINE l_exrate     LIKE azj_file.azj03   #MOD-B30225
###-TQC-B40014- ADD - BEGIN ---------------------------------------------
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_lpj02      LIKE lpj_file.lpj02
DEFINE l_lph04      LIKE lph_file.lph04
DEFINE l_rtg06      LIKE rtg_file.rtg06
DEFINE l_rth05      LIKE rth_file.rth05
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_type       LIKE type_file.chr1
###-TQC-B40014- ADD -  END  ---------------------------------------------
DEFINE l_rxc        RECORD LIKE rxc_file.* #TQC-B60015 ADD
DEFINE p_line       LIKE oeb_file.oeb03    #TQC-B60015 ADD
DEFINE p_count      LIKE xmd_file.xmd08    #TQC-B60015 ADD

  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

#MOD-B30225--add--str--
   IF g_aza.aza17 <> p_curr THEN
      LET l_exrate = s_curr3(p_curr,g_today,g_sma.sma904)
   ELSE
      LET l_exrate=1
   END IF
#MOD-B30225--add--end--

###-TQC-B40014- ADD - BEGIN ---------------------------------------------
   INITIALIZE l_oea87,l_lpj02,l_lph04 TO NULL
   IF p_type <> '4' THEN   #FUN-B60067 ADD
      CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   END IF                  #FUN-B60067 ADD
   IF NOT cl_null (l_oea87) THEN
      SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
      SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
   END IF
###-TQC-B40014- ADD -  END  ---------------------------------------------

###-TQC-B60015- ADD - BEGIN ----------------------------
   IF l_lph04 = 'Y' THEN
      IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
      IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
      IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
      LET l_rxc.rxc01 = p_no
      LET l_rxc.rxc02 = p_line
      LET l_rxc.rxc03 = '06'
      LET l_rxc.rxc04 = ' '
      LET l_rxc.rxc05 = ''
      LET l_rxc.rxc07 = 0
      LET l_rxc.rxc08 = ''
      LET l_rxc.rxc09 = 0
      LET l_rxc.rxc10 = ''
      LET l_rxc.rxc11 = g_member
      LET l_rxc.rxcplant = p_plant
      LET l_rxc.rxc15 = p_count
      SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new

      LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                  "   WHERE rxc00 = '",l_rxc.rxc00,"'",
                  "     AND rxc01 = '",l_rxc.rxc01,"'",
                  "     AND rxc02 = '",l_rxc.rxc02,"'",
                  "     AND rxc03 = '",l_rxc.rxc03,"'"

      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
      PREPARE a2_del_rxc_pre FROM l_sql
      EXECUTE a2_del_rxc_pre

      LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",
                  "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                  "rxc07,rxc08,rxc09,rxc10,rxcplant,rxclegal,rxc11,rxc12,rxc13,rxc14,rxc15)",
                  "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
      PREPARE a2_ins_rxc_pre FROM l_sql
   END IF
###-TQC-B60015- ADD -  END  ----------------------------

###-TQC-B60015- MARK - BEGIN ---------------------------
#  IF SQLCA.SQLCODE THEN
#     CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#     RETURN 0
#  END IF
###-TQC-B60015- MARK -  END  ---------------------------
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   #若該機構沒有價格策略，則A2類基礎價格不與處理
   SELECT rtz05 INTO l_rtz05 FROM rtz_file WHERE rtz01 = p_plant
  #IF cl_null(l_rtz05) THEN RETURN 0 END IF   #TQC-B60055 mark
   IF cl_null(l_rtz05) THEN RETURN 0,0 END IF #TQC-B60055
#  SELECT rtg05,rtg08 INTO l_rtg05,l_rtg08 FROM rtg_file               #TQC-B40014 MARK
   SELECT rtg05,rtg06,rtg08 INTO l_rtg05,l_rtg06,l_rtg08 FROM rtg_file #TQC-B40014 ADD
      WHERE rtg01 = l_rtz05 AND rtg03 = p_item
        AND rtg04 = p_unit
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel rtg_file',SQLCA.SQLCODE,0)  #No.FUN-A70123 
   #  RETURN 0     #-TQC-B60015 MARK
      RETURN 0,0   #-TQC-B60015 ADD
   END IF 
   IF cl_null(l_rtg08) THEN LET l_rtg08 = ' ' END IF
   IF l_rtg08 = 'Y' THEN
#     SELECT rth04 INTO l_rth04 FROM rth_file WHERE rth01 = p_item AND rth02 = p_unit                #TQC-B40014 MARK
      SELECT rth04,rth05 INTO l_rth04,l_rth05 FROM rth_file WHERE rth01 = p_item AND rth02 = p_unit  #TQC-B40014 ADD
          AND rthacti = 'Y' AND rthplant = p_plant          #TQC-B20021 
      IF cl_null(l_rth04) THEN LET l_rth04 = l_rtg05 END IF #No.FUN-9B0157 取不到自定价取价格策略价
      IF cl_null(l_rth05) THEN LET l_rth05 = l_rtg06 END IF #TQC-B40014 ADD
      LET l_rth04 = l_rth04 * l_exrate    #MOD-B30225
      LET l_rth05 = l_rth05 * l_exrate    #TQC-B40014 ADD
###-TQC-B40014- ADD - BEGIN ---------------------------------------------
      IF l_lph04 = 'Y' THEN
      #  RETURN l_rth05            ###-TQC-B60015 MARK
###-TQC-B60015- ADD - BEGIN ----------------------------
         #<<<<若是會員,且勾選會員價則新增一筆資料至 rxc >>>#
         LET l_rxc.rxc06 = (l_rth04 - l_rth05) * p_count
         EXECUTE a2_ins_rxc_pre USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                      l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                      l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,
                                      l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15

         IF SQLCA.SQLCODE THEN
            CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
            RETURN 0,0
         END IF
         RETURN l_rth05,l_rth04
###-TQC-B60015- ADD -  END  ----------------------------
      ELSE
###-TQC-B40014- ADD -  END  ---------------------------------------------
         RETURN l_rth04,l_rth04  #TQC-B60015- MOD
      END IF  #TQC-B40014 ADD
   END IF
   LET l_rtg05 = l_rtg05 * l_exrate    #MOD-B30225
   LET l_rtg06 = l_rtg06 * l_exrate    #TQC-B40014 ADD
###-TQC-B40014- ADD - BEGIN ---------------------------------------------
   IF l_lph04 = 'Y' THEN
###-TQC-B60015- ADD - BEGIN ----------------------------
      #<<<<若是會員,且勾選會員價則新增一筆資料至 rxc >>>#
      LET l_rxc.rxc06 = (l_rtg05 - l_rtg06) * p_count
      EXECUTE a2_ins_rxc_pre USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                   l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                   l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,
                                   l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15

      IF SQLCA.SQLCODE THEN
         CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
         RETURN 0,0
      END IF
      RETURN l_rtg06,l_rtg05
###-TQC-B60015- ADD -  END  ----------------------------
   #  RETURN l_rtg06   #TQC-B60015- MARK
   ELSE
###-TQC-B40014- ADD -  END  ---------------------------------------------
      RETURN l_rtg05,l_rtg05     #TQC-B60015- MOD
   END IF     #TQC-B40014 ADD
END FUNCTION

#MOD-9C0173   ---start
FUNCTION s_fetch_price_A3(p_item,p_no,p_plant,p_type)
DEFINE p_plant  LIKE azp_file.azp01 
DEFINE p_item   LIKE oeb_file.oeb04 
DEFINE p_no     LIKE oeb_file.oeb01
DEFINE p_type   LIKE type_file.chr1
DEFINE l_oea213 LIKE oea_file.oea213
DEFINE l_oea24  LIKE oea_file.oea24
DEFINE l_price  LIKE oeb_file.oeb13
DEFINE l_dbs    LIKE azp_file.azp03
DEFINE l_sql    STRING
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   
   #LET l_sql = "SELECT oea213,oea24 FROM ",l_dbs,"oea_file WHERE oea01='",p_no,"' "
  # LET l_sql = "SELECT oea213,oea24 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102  #FUN-AA0065
  #             " WHERE oea01='",p_no,"' "                                                            #FUN-AA0065
#FUN-AA0065---add--begin--
 IF p_type = '1' THEN 
      LET l_sql = "SELECT oea213,oea24 ",
                  #"   FROM ",l_dbs,"oea_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oea_file'),         #FUN-A50102
                  "  WHERE oea01 = '",p_no,"'"
   END IF
   IF p_type = '2' THEN
      LET l_sql = "SELECT oga213,oga24 ",
                  #"   FROM ",l_dbs,"oga_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oga_file'),         #FUN-A50102
                  "  WHERE oga01 = '",p_no,"'"
   END IF
   IF p_type = '3' THEN
      LET l_sql = "SELECT oha213,oha24 ",
                  #"   FROM ",l_dbs,"oha_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oha_file'),         #FUN-A50102
                  "  WHERE oha01 = '",p_no,"'"
   END IF
#FUN-AA0065---add--begin--              
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
   PREPARE A3_pre FROM l_sql
   DECLARE A3_cs SCROLL CURSOR FOR A3_pre
   OPEN A3_cs
   FETCH FIRST A3_cs INTO l_oea213,l_oea24
   CLOSE A3_cs     
   IF l_oea213 = 'Y' THEN                                                                                                   
      SELECT ima128 INTO l_price FROM ima_file WHERE ima01 = p_item                                                        
   ELSE                                                                                                                     
      SELECT ima127 INTO l_price FROM ima_file WHERE ima01 = p_item                                                       
   END IF                                                                                                                   
   LET l_price = l_price/l_oea24   
   IF cl_null(l_price) THEN LET l_price=0 END IF 
   RETURN l_price   
END FUNCTION

FUNCTION s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)
DEFINE l_price  LIKE oeb_file.oeb13
DEFINE p_cust   LIKE oea_file.oea03 
DEFINE p_unit   LIKE oeb_file.oeb05
DEFINE p_plant  LIKE azp_file.azp01
DEFINE p_no     LIKE oea_file.oea01
DEFINE p_line   LIKE oeb_file.oeb03
DEFINE p_term   LIKE oea_file.oea31
DEFINE p_type   LIKE type_file.chr1   #MOD-AB0237
DEFINE p_curr   LIKE oea_file.oea23
DEFINE l_oeb916 LIKE oeb_file.oeb916
DEFINE l_ima131 LIKE ima_file.ima131
DEFINE p_item   LIKE oeb_file.oeb04
DEFINE l_occ20  LIKE occ_file.occ20
DEFINE l_occ21  LIKE occ_file.occ21
DEFINE l_occ22  LIKE occ_file.occ22  
DEFINE l_oea25  LIKE oea_file.oea25
DEFINE l_oea21  LIKE oea_file.oea21
DEFINE l_sql    STRING
DEFINE l_dbs    LIKE azp_file.azp03
  
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
#MOD-AB0237--add--begin
   IF p_type = '2' THEN
      LET l_sql = "SELECT oga21,oga25 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                  " WHERE oga01='",p_no,"' "
   END IF
   IF p_type = '3' THEN
      LET l_sql = "SELECT oha21,oha25 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                  " WHERE oha01='",p_no,"' "
   END IF
   IF p_type = '1' THEN
#MOD-AB0237--add--end
   #LET l_sql = "SELECT oea21,oea25 FROM ",l_dbs,"oea_file WHERE oea01='",p_no,"' "
   LET l_sql = "SELECT oea21,oea25 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
               " WHERE oea01='",p_no,"' "
   END IF                                                    #MOD-AB0237
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE A4_pre FROM l_sql
   DECLARE A4_cs SCROLL CURSOR FOR A4_pre
   OPEN A4_cs
   FETCH FIRST A4_cs INTO l_oea21,l_oea25
   CLOSE A4_cs
#MOD-AB0237--add--begin
   IF p_type = '2' THEN
      LET l_sql = "SELECT ogb916 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  " WHERE ogb01='",p_no,"' AND ogb03='",p_line,"' "
   END IF
   IF p_type = '3' THEN
      LET l_sql = "SELECT ohb916 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                  " WHERE ohb01='",p_no,"' AND ohb03='",p_line,"' "
   END IF
   IF p_type = '1' THEN
#MOD-AB0237--add--end  
   #LET l_sql = "SELECT oeb916 FROM ",l_dbs,"oeb_file WHERE oeb01='",p_no,"' AND oeb03='",p_line,"' "
   LET l_sql = "SELECT oeb916 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
               " WHERE oeb01='",p_no,"' AND oeb03='",p_line,"' "
   END IF                                                    #MOD-AB0237
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
   PREPARE A4_pre1 FROM l_sql
   DECLARE A4_cs1 SCROLL CURSOR FOR A4_pre1
   OPEN A4_cs1 
   FETCH FIRST A4_cs1 INTO l_oeb916
   CLOSE A4_cs1 
   IF cl_null(l_oeb916) THEN                                                                                                
      LET l_oeb916 = p_unit                                                                                                
   END IF                                                                                                                   
   SELECT ima131 INTO l_ima131 FROM ima_file                                                                                
    WHERE ima01 = p_item                                                                                             
   SELECT occ20,occ21,occ22 INTO l_occ20,l_occ21,l_occ22 FROM occ_file                                                      
    WHERE occ01 = p_cust                                                                                                  
      AND occacti = 'Y'                                                                                                     
   LET l_sql = "SELECT obg21,obg01,obg02,obg03,obg04,obg05,  ",                                                                         
               "       obg06,obg22,obg07,obg08,obg09,obg10   ",                                                                         
               #"  FROM ",l_dbs,"obg_file      ",
               "  FROM ",cl_get_target_table(g_plant_new,'obg_file'), #FUN-A50102              
               " WHERE (obg01 = '",l_ima131,"' OR obg01 = '*') ",                                                                             
               "   AND (obg02 = '",p_item,"'  OR obg02 = '*' ) ",                                                                              
               "   AND (obg03 = '",l_oeb916,"') ",                                                                                             
               "   AND (obg04 = '",l_oea25,"'  OR obg04 = '*') ",                                                                             
               "   AND (obg05 = '",p_term,"'   OR obg05 = '*') ",                                                                             
               "   AND (obg06 = '",p_cust,"'   OR obg06 = '*') ",                                                                             
               "   AND (obg22 = '",l_occ22,"'  OR obg22 = '*') ",                                                                             
               "   AND (obg07 = '",l_occ21,"'  OR obg07 = '*') ",                                                                             
               "   AND (obg08 = '",l_occ20,"'  OR obg08 = '*') ",                                                                              
               "   AND (obg09 = '",p_curr,"'                )  ",                                                                            
               "   AND (obg10 = '",l_oea21,"'  OR obg10 = '*') ",     
               "  ORDER BY obg01 DESC,obg02 DESC,obg03 DESC,obg04 DESC, ",                                                             
               "           obg05 DESC,obg06 DESC,obg07 DESC,obg08 DESC, ",                                                             
               "           obg09 DESC,obg10 DESC "   
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
   PREPARE A4_pre2 FROM l_sql
   DECLARE A4_cs2 CURSOR FOR A4_pre2                                                                                 
   FOREACH A4_cs2 INTO l_price                                                                                    
      IF STATUS THEN CALL cl_err('foreach obg',STATUS,1) END IF                                                              
      EXIT FOREACH                                                                                                           
   END FOREACH  
   IF cl_null(l_price) THEN LET l_price=0 END IF                 
   RETURN l_price
END FUNCTION

FUNCTION s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
DEFINE p_plant LIKE azp_file.azp01
DEFINE p_item LIKE oeb_file.oeb04
DEFINE p_cust LIKE oea_file.oea03
DEFINE p_curr LIKE oea_file.oea23
DEFINE l_price LIKE oeb_file.oeb13
DEFINE l_sql STRING
DEFINE l_dbs LIKE azp_file.azp03
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   #LET l_sql = "SELECT obk08 FROM ",l_dbs,"obk_file ",
   LET l_sql = "SELECT obk08 FROM ",cl_get_target_table(g_plant_new,'obk_file'), #FUN-A50102  
               " WHERE obk01 = '",p_item,"' AND obk02 = '",p_cust,"'  ",                                                                        
               "   AND obk05 = '",p_curr,"' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
   PREPARE A5_pre FROM l_sql
   DECLARE A5_cs CURSOR FOR A5_pre
   FOREACH A5_cs INTO l_price
      IF STATUS THEN CALL cl_err('foreach obk',STATUS,1) END IF
      EXIT FOREACH
   END FOREACH
   IF cl_null(l_price) THEN LET l_price=0 END IF
   RETURN l_price     
END FUNCTION

FUNCTION s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
DEFINE p_plant LIKE azp_file.azp01
DEFINE p_term LIKE oea_file.oea31
DEFINE p_curr LIKE oea_file.oea23
DEFINE p_item LIKE oeb_file.oeb04
DEFINE p_unit LIKE oeb_file.oeb05
DEFINE p_date LIKE oea_file.oea02 
DEFINE l_price LIKE oeb_file.oeb13
DEFINE l_tmp1 LIKE xmf_file.xmf07
DEFINE l_tmp2 LIKE xmf_file.xmf08
DEFINE l_sql STRING
DEFINE l_dbs LIKE azp_file.azp03

   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   LET l_sql = "SELECT xmf07,xmf08 ",
               #"  FROM ",l_dbs,"xme_file,",l_dbs,"xmf_file ",
               "  FROM ",cl_get_target_table(g_plant_new,'xme_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'xmf_file'),     #FUN-A50102
               " WHERE xme01 = xmf01 AND xme02 = xmf02 ",
               "   AND xmf01 = '",p_term,"' ",
               "   AND xmf02 = '",p_curr,"' ",
               "   AND xmf03 = '",p_item,"' ",
               "   AND xmf04 = '",p_unit,"' ",
               "   AND xmf05 <= '",p_date,"' ",
               "   AND xme00 = '1' ",
               " ORDER BY xmf05 DESC,xmf07,xmf08 "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE A6_pre FROM l_sql
   DECLARE A6_cs CURSOR FOR A6_pre
   IF STATUS THEN
      CALL cl_err('A6_cs',STATUS,1) RETURN 0
   END IF
   LET l_price = 0
   FOREACH A6_cs INTO l_tmp1,l_tmp2
      IF STATUS THEN CALL cl_err('sel xmf',STATUS,1) RETURN 0 END IF
      IF cl_null(l_tmp1) THEN LET l_tmp1 = 0 END IF
      IF cl_null(l_tmp2) THEN LET l_tmp2 = 0 END IF
      LET l_price = l_tmp1 * (l_tmp2 / 100)
      IF cl_null(l_price) THEN LET l_price = 0 END IF
      EXIT FOREACH
   END FOREACH
   RETURN l_price
END FUNCTION 
#MOD-9C0173   ---end

FUNCTION s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,p_price,p_no,p_line,p_type)
DEFINE p_item       LIKE tqn_file.tqn03, 
       p_unit       LIKE tqn_file.tqn04,
       p_curr       LIKE azi_file.azi01,  
       p_date       LIKE type_file.dat,  
       p_no         LIKE oeb_file.oeb01,  
       p_line       LIKE oeb_file.oeb03,  
       p_price      LIKE oeb_file.oeb13,
       p_term       LIKE oah_file.oah01, 
       p_count      LIKE oeb_file.oeb12, 
       p_plant      LIKE azp_file.azp01,
       p_type       LIKE type_file.chr1,
       l_sql        STRING 
DEFINE l_xmg06     LIKE xmg_file.xmg06
DEFINE l_xmg07     LIKE xmg_file.xmg07
DEFINE l_dbs       LIKE azp_file.azp03
DEFINE l_cn        LIKE type_file.num5
DEFINE l_n         LIKE type_file.num5
DEFINE l_rxc       RECORD LIKE rxc_file.*
DEFINE l_oea87     LIKE oea_file.oea87
 
   IF p_count <= 0 OR p_count IS NULL THEN RETURN 100 END IF
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
 
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 100
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   LET l_sql = "SELECT xmg06,xmg07 ",
               #"  FROM ",l_dbs,"xme_file,",l_dbs,"xmg_file ",
               "  FROM ",cl_get_target_table(g_plant_new,'xme_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'xmg_file'),     #FUN-A50102
               " WHERE xme01 = xmg01 AND xme02 = xmg02 ",
               "   AND xmg01 = '",p_term,"'", 
               "   AND xmg02 = '",p_curr,"'", 
               "   AND xmg03 = '",p_item,"'", 
               "   AND xmg04 = '",p_unit,"'",
               "   AND xmg05 <= '",p_date,"'",
               "   AND xmg06 > 0 ", 
               "   AND xme00 = '2' ",  #MOD-9C0173
               "  ORDER BY xmg05 DESC,xmg06 DESC,xmg07"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
   PREPARE pre_sel_xmg FROM l_sql
   DECLARE x4_curs CURSOR FOR pre_sel_xmg  
   LET l_cn = 0
   FOREACH x4_curs INTO l_xmg06,l_xmg07
      IF STATUS THEN CALL cl_err('sel xmg',STATUS,1) RETURN 100 END IF
      IF l_xmg06 IS NULL THEN LET l_xmg06 = 0 END IF
      IF p_count >= l_xmg06 THEN
         LET l_cn = 1
         EXIT FOREACH
      END IF 
   END FOREACH
   IF l_xmg07 IS NULL THEN RETURN 100 END IF
   IF l_cn = 0 THEN RETURN 100 END IF
   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
   LET l_rxc.rxc01 = p_no
   LET l_rxc.rxc02 = p_line
   LET l_rxc.rxc03 = '08'
   LET l_rxc.rxc04 = ' '
   LET l_rxc.rxc05 = ''
   LET l_rxc.rxc06 = (p_price*(100-l_xmg07)/100)*p_count
   LET l_rxc.rxc07 = 0
   LET l_rxc.rxc08 = ''
   LET l_rxc.rxc09 = 0
   LET l_rxc.rxc10 = 0
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   LET l_rxc.rxc11 = g_member
   LET l_rxc.rxcplant = p_plant
   LET l_rxc.rxc15 = p_count         #FUN-AA0065 
   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),     #FUN-A50102
               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
               "     AND rxc01 = '",l_rxc.rxc01,"'",
               "     AND rxc02 = '",l_rxc.rxc02,"'",
               "     AND rxc03 = '",l_rxc.rxc03,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
   PREPARE pre_del_rxc2 FROM l_sql
   EXECUTE pre_del_rxc2
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",     #FUN-A50102   
               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
               "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,rxc12,rxc13,rxc14,rxc15)", #FUN-AA0065 
               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"                           #FUN-AA0065 
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
   PREPARE pre_ins_rxc10 FROM l_sql
   EXECUTE pre_ins_rxc10 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,   #FUN-AA0065
                               l_rxc.rxc07,l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,l_rxc.rxc11,         #FUN-AA0065
                               l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14 , l_rxc.rxc15   #FUN-AA0065                                               #FUN-AA0065 
   IF SQLCA.SQLCODE THEN 
      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
      RETURN 100 
   END IF
   RETURN l_xmg07
END FUNCTION
 
FUNCTION s_fetch_price_B2(p_cust,p_item,p_plant,p_price,p_no,p_line,p_count,p_type)
DEFINE p_cust       LIKE tqo_file.tqo01,
       p_no         LIKE oeb_file.oeb01,  
       p_line       LIKE oeb_file.oeb03,  
       p_item       LIKE tqn_file.tqn03, 
       p_plant      LIKE azp_file.azp01,
       p_price      LIKE oeb_file.oeb13,
       p_count      LIKE oeb_file.oeb12, 
       p_type       LIKE type_file.chr1,
       l_sql        LIKE type_file.chr1000
DEFINE l_occ32      LIKE occ_file.occ32
DEFINE l_xmh03      LIKE xmh_file.xmh03
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_oea87      LIKE oea_file.oea87
 
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
 
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN -1,-1 
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   #取客戶分類/產品分類折扣 
   LET l_sql = "SELECT xmh03 ",
               #"   FROM ",l_dbs,"xmh_file,",l_dbs,"occ_file,",l_dbs,"ima_file ",
               "   FROM ",cl_get_target_table(g_plant_new,'xmh_file'),",",     #FUN-A50102
                          cl_get_target_table(g_plant_new,'occ_file'),",",     #FUN-A50102
                          cl_get_target_table(g_plant_new,'ima_file'),         #FUN-A50102
               "  WHERE xmh01 = occ03 AND xmh02 = ima131 ",
               "    AND occ01 = '",p_cust,"' AND ima01 = '",p_item,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
   PREPARE pre_sel_xmh FROM l_sql
   EXECUTE pre_sel_xmh INTO l_xmh03 
   IF STATUS THEN 
      #CALL cl_err('sel xmh_file',STATUS,1)
      LET l_xmh03 = 100 
   END IF      
   IF cl_null(l_xmh03) THEN LET l_xmh03 = 100 END IF 
 
   #取客戶主檔上的折扣率%
   LET l_occ32 = NULL
   #LET l_sql = "SELECT occ32 FROM ",l_dbs,"occ_file WHERE occ01 = '",p_cust,"'"
   LET l_sql = "SELECT occ32 FROM ",cl_get_target_table(g_plant_new,'occ_file'),         #FUN-A50102
               " WHERE occ01 = '",p_cust,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
   PREPARE pre_sel_occ FROM l_sql
   EXECUTE pre_sel_occ INTO l_occ32
   IF STATUS THEN 
      #CALL cl_err('sel occ_file',STATUS,1)
      LET l_occ32 = 100 
   END IF      
   IF l_occ32 IS NULL THEN LET l_occ32 = 100 END IF
   IF l_occ32 = 100 AND l_xmh03 = 100 THEN RETURN l_xmh03,l_occ32 END IF
   
   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
   LET l_rxc.rxc01 = p_no
   LET l_rxc.rxc02 = p_line
   LET l_rxc.rxc03 = '07'
   LET l_rxc.rxc04 = ' '
   LET l_rxc.rxc05 = ''
   LET l_rxc.rxc06 = p_price*(100-l_xmh03*l_occ32/100)/100*p_count     #FUN-AA0065 ADD *p_count
   LET l_rxc.rxc07 = 0
   LET l_rxc.rxc08 = ''
   LET l_rxc.rxc09 = '0'
   LET l_rxc.rxc10 = ''
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   LET l_rxc.rxc11 = g_member
   LET l_rxc.rxcplant = p_plant
   LET l_rxc.rxc15 = p_count  #FUN-AA0065 
   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),         #FUN-A50102
               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
               "     AND rxc01 = '",l_rxc.rxc01,"'",
               "     AND rxc02 = '",l_rxc.rxc02,"'",
               "     AND rxc03 = '",l_rxc.rxc03,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_del_rxc3 FROM l_sql
   EXECUTE pre_del_rxc3
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",     #FUN-A50102   
               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
               "rxc07,rxc08,rxc09,rxc10,rxcplant,rxclegal,rxc11,rxc12,rxc13,rxc14,rxc15)",#FUN-AA0065 
               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"  #FUN-AA0065 
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_ins_rxc12 FROM l_sql
   EXECUTE pre_ins_rxc12 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,   #FUN-AA0065
                               l_rxc.rxc07,l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc11,         #FUN-AA0065
                               l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15  #FUN-AA0065                                                     #FUN-AA0065 
   IF SQLCA.SQLCODE THEN 
      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
      RETURN 100,100 
   END IF
   RETURN l_xmh03,l_occ32
END FUNCTION
 
FUNCTION s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,p_price,p_plant,p_no1,p_type,p_count)
DEFINE p_cust       LIKE occ_file.occ01   
DEFINE p_no1        LIKE tqx_file.tqx01   #提案單號
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_line       LIKE oeb_file.oeb03
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_type       LIKE type_file.chr1
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE l_price      LIKE oeb_file.oeb13
DEFINE l_oea1002    LIKE oea_file.oea1002
DEFINE l_oea213     LIKE oea_file.oea213
DEFINE l_oea211     LIKE oea_file.oea211
DEFINE l_tqz06      LIKE tqz_file.tqz06
DEFINE l_tqz07      LIKE tqz_file.tqz07
DEFINE l_tqy38      LIKE tqy_file.tqy38
DEFINE l_tqx13      LIKE tqx_file.tqx13
DEFINE l_tqx14      LIKE tqx_file.tqx14
DEFINE l_tqx16      LIKE tqx_file.tqx16
DEFINE l_tqz09      LIKE tqz_file.tqz09
DEFINE l_tqz08      LIKE tqz_file.tqz08
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_msg        LIKE type_file.chr50
DEFINE l_flag       LIKE type_file.chr1
DEFINE l_rate       LIKE type_file.num20_6
DEFINE l_n          LIKE type_file.num5
DEFINE l_sql        STRING
DEFINE l_ima135     LIKE ima_file.ima135
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_plant     LIKE azp_file.azp01          #FUN-980020
DEFINE l_rty05      LIKE rty_file.rty05
DEFINE l_rtv13     LIKE rtv_file.rtv13
 
   IF cl_null(p_no1) THEN RETURN 0 END IF 
 
   LET l_plant = g_plant                        #FUN-980020
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
 
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0 
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   IF p_type = '1' THEN 
      LET l_sql = "SELECT oea1002,oea213,oea211 ",
                  #"   FROM ",l_dbs,"oea_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oea_file'),         #FUN-A50102
                  "  WHERE oea01 = '",p_no,"'"
   END IF
   IF p_type = '2' THEN
      LET l_sql = "SELECT oga1002,oga213,oga211 ",
                  #"   FROM ",l_dbs,"oga_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oga_file'),         #FUN-A50102
                  "  WHERE oga01 = '",p_no,"'"
   END IF
   IF p_type = '3' THEN
      LET l_sql = "SELECT oha1002,oha213,oha211 ",
                  #"   FROM ",l_dbs,"oha_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oha_file'),         #FUN-A50102
                  "  WHERE oha01 = '",p_no,"'"
   END IF
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_oea FROM l_sql
   #EXECUTE pre_sel_oea INTO l_oea1002,l_oea213             #No.MOD-A60195 mark
   EXECUTE pre_sel_oea INTO l_oea1002,l_oea213,l_oea211     #No.MOD-A60195 mod
 
   LET l_sql = "SELECT COUNT(*) ", 
               #"   FROM ",l_dbs,"tqx_file,",l_dbs,"tqy_file,",
               #           l_dbs,"tqz_file,",l_dbs,"tsa_file ",
               "   FROM ",cl_get_target_table(g_plant_new,'tqx_file'),",",      #FUN-A50102
                          cl_get_target_table(g_plant_new,'tqy_file'),",",      #FUN-A50102
                          cl_get_target_table(g_plant_new,'tqz_file'),",",      #FUN-A50102
                          cl_get_target_table(g_plant_new,'tsa_file'),          #FUN-A50102
               "  WHERE tqx01 = '",p_no1,"'",
               "    AND tqx01 = tqy01 ",
               "    AND tqx01 = tqz01 ",
               "    AND tqx01 = tsa01 ",
               "    AND tqy02 = tsa02 ",
               "    AND tqz02 = tsa03 ",
               "    AND tqy03 = '",p_cust,"'",  
               "    AND tqz03 = '",p_item,"'",
               "    AND tqz06 <= '",p_date,"'",
               "    AND tqz07 >= '",p_date,"'",
               "    AND tqy37 ='Y' ",
               "    AND tqy38 <= '",p_date,"'",
               "    AND tqx13 = '",l_oea1002,"'",
               "    AND tqx09 = '",p_curr,"'",  
               "    AND tqxacti='Y' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_tqx FROM l_sql
   EXECUTE pre_sel_tqx INTO l_n
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel tqx_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   IF l_n = 0 THEN      #提案單中沒有符合該料件的資料，通過料件條形碼再次查找
      #LET l_sql = "SELECT ima135 FROM ",l_dbs,"ima_file WHERE ima01 = '",p_item,"'"
      LET l_sql = "SELECT ima135 FROM ",cl_get_target_table(g_plant_new,'ima_file'), #FUN-A50102
                  " WHERE ima01 = '",p_item,"'"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
      PREPARE pre_sel_ima135 FROM l_sql
      EXECUTE pre_sel_ima135 INTO l_ima135
      IF cl_null(l_ima135) THEN RETURN 0 END IF
      LET l_sql = "SELECT tqz06,tqz07,tqy38,tqx13 ",
                  #"   FROM ",l_dbs,"tqx_file,",l_dbs,"tqy_file,",
                  #           l_dbs,"tqz_file,",l_dbs,"tsa_file,",
                  #           l_dbs,"ima_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'tqx_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'tqy_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'tqz_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'tsa_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
                  "  WHERE tqx01 = '",p_no1,"'",
                  "    AND tqx01 = tqy01 ",
                  "    AND tqx01 = tqz01 ",
                  "    AND tqx01 = tsa01 ",
                  "    AND tqy02 = tsa02 ",
                  "    AND tqz02 = tsa03 ",
                  "    AND tqy03 = '",p_cust,"'",
                  "    AND tqz03 = ima01 ",
                  "    AND ima135 = '",l_ima135,"'",
                  "    AND tqy37 = 'Y' ",
                  "    AND tqx09 = '",p_curr,"'",
                  "    AND tqxacti='Y' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
      PREPARE pre_sel_tqx2 FROM l_sql
      EXECUTE pre_sel_tqx2 INTO l_tqz06,l_tqz07,l_tqy38,l_tqx13
      CASE WHEN SQLCA.SQLCODE = 100
              CALL cl_err('sel tqz_file','100',1) RETURN 0
           WHEN l_tqz06>p_date OR l_tqz07<p_date           
              CALL cl_err('sel tqz_file','atm-038',1)
           WHEN l_tqx13 ! = l_oea1002
              CALL cl_err('sel tqz_file','atm-039',1) RETURN 0
           WHEN SQLCA.SQLCODE != 0
              CALL cl_err('sel tqz_file',SQLCA.SQLCODE,0) RETURN 0
      END CASE
   ELSE                   #提案單中有符合條件的資料
      LET l_sql = "SELECT UNIQUE tqz09,tqx14,tqx16,tqz08 ",
                  #"   FROM ",l_dbs,"tqx_file,",l_dbs,"tqy_file,",l_dbs,"tqz_file ",
                  "   FROM ",cl_get_target_table(g_plant_new,'tqx_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'tqy_file'),",", #FUN-A50102
                             cl_get_target_table(g_plant_new,'tqz_file'),     #FUN-A50102
                  "  WHERE tqx01 = '",p_no1,"'",      
                  "    AND tqz03 = '",p_item,"'",      
                  "    AND tqz06<= '",p_date,"'",
                  "    AND tqz07>= '",p_date,"'",
                  "    AND tqx01=tqy01 ",
                  "    AND tqx01=tqz01 ",
                  "    AND tqx09='",p_curr,"'",
                  "    AND tqxacti='Y' ",
                  "    AND ",p_cust," IN ", 
                  "(SELECT tqy03 ",
                  #"  FROM ",l_dbs,"tqy_file,",l_dbs,"tqx_file,",l_dbs,"tqz_file ",
                  "  FROM ",cl_get_target_table(g_plant_new,'tqy_file'),",", #FUN-A50102
                            cl_get_target_table(g_plant_new,'tqx_file'),",", #FUN-A50102
                            cl_get_target_table(g_plant_new,'tqz_file'),     #FUN-A50102
                  " WHERE tqx01= '",p_no1,"'",
                  "   AND tqx13= '",l_oea1002,"'",
                  "   AND tqz03= '",p_item,"'", 
                  "   AND tqz06<='",p_date,"'",
                  "   AND tqz07>= '",p_date,"'",
                  "   AND tqx01=tqy01 ",
                  "   AND tqx01=tqz01 ", 
                  "   AND tqx09='",p_curr,"'",
                  "   AND tqy37='Y' ",
                  "   AND tqy38<='",p_date,"')"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
      PREPARE pre_sel_tqx05 FROM l_sql
      EXECUTE pre_sel_tqx05 INTO l_tqz09,l_tqx14,l_tqx16,l_tqz08
      IF SQLCA.SQLCODE THEN
         IF SQLCA.SQLCODE != 100 THEN 
            CALL cl_err('sel tqx_file',SQLCA.SQLCODE,1) 
            RETURN 0
         END IF
         LET l_sql = " SELECT UNIQUE tqz09,tqx14,tqx16,tqz08 ",
                     #"    FROM ",l_dbs,"tqx_file,",l_dbs,"tqy_file,",
                     #            l_dbs,"tqz_file,",l_dbs,"ima_file ",
                     "    FROM ",cl_get_target_table(g_plant_new,'tqx_file'),",", #FUN-A50102
                                 cl_get_target_table(g_plant_new,'tqy_file'),",", #FUN-A50102
                                 cl_get_target_table(g_plant_new,'tqz_file'),",", #FUN-A50102
                                 cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
                     "   WHERE tqx01= '",p_no1,"'",       
                     "     AND tqz03=ima01 ",
                     "     AND ima135 = '",l_ima135,"'",    
                     "     AND tqz06<= '",p_date,"'", 
                     "     AND tqz07>= '",p_date,"'",
                     "     AND tqx01 = tqy01 ",
                     "     AND tqx01 = tqz01 ",
                     "     AND tqx09 = '",p_curr,"'",
                     "     AND tqxacti='Y' ",
                     "     AND ",p_cust," IN  ",
                     " (SELECT tqy03 ",
                     #     "FROM ",l_dbs,"tqy_file,",l_dbs,"tqx_file,",
                     #             l_dbs,"tqz_file,",l_dbs,"ima_file ",
                          "FROM ",cl_get_target_table(g_plant_new,'tqy_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'tqx_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'tqz_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
                     "    WHERE tqx01= '",p_no1,"'", 
                     "      AND tqx13= '",l_oea1002,"'",       
                     "      AND tqz03=ima01 ",
                     "      AND ima135='",l_ima135,"'",      
                     "      AND tqz06<= '",p_date,"'",     
                     "      AND tqz07>= '",p_date,"'",  
                     "      AND tqx01=tqy01  ",            
                     "      AND tqx01=tqz01  ",   
                     "      AND tqx09='",p_curr,"'",
                     "      AND tqy37='Y' ",
                     "      AND tqy38<='",p_date,"')"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
         PREPARE pre_sel_tqx06 FROM l_sql
         EXECUTE pre_sel_tqx06 INTO l_tqz09,l_tqx14,l_tqx16,l_tqz08
      END IF
   END IF  
   IF cl_null(l_tqz08) THEN LET l_tqz08 = ' ' END IF
   #檢查提案單中維護料件的單位是否與銷售單位一致
   IF l_tqz08 != p_unit THEN 
#     CALL s_umfchkm(p_item,p_unit,l_tqz08,l_dbs) RETURNING l_flag,l_rate     #FUN-980020 mark
      CALL s_umfchkm(p_item,p_unit,l_tqz08,l_plant) RETURNING l_flag,l_rate   #FUN-980020 
      IF l_flag = '0' THEN
         LET l_tqz09 = l_tqz09*l_rate
      ELSE 
         LET l_msg = p_unit,"->",l_tqz08
         CALL cl_err(l_msg,'apm-120',1)
         RETURN 0
      END IF
   END IF
   IF l_oea213 = 'N' THEN    #訂單維護的稅種不含稅
      IF l_tqx16 ='Y' THEN   #提案單為含稅
         LET l_price = l_tqz09/(1+l_tqx14/100)
      ELSE
         LET l_price = l_tqz09
      END IF
   ELSE                      #訂單維護的稅種含稅
      IF l_tqx16 = 'Y' THEN  #提案單為含稅
         LET l_price = l_tqz09/(1+l_tqx14/100)*(1+l_oea211/100)
      ELSE
         LET l_price = l_tqz09*(1+l_oea211/100)
      END IF
   END IF
   LET l_price = cl_digcut(l_price,t_azi03)
   IF l_price IS NULL THEN LET l_price = 0 END IF
   #記錄折價
   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
   LET l_rxc.rxc01 = p_no
   LET l_rxc.rxc02 = p_line
   LET l_rxc.rxc03 = '09'
   LET l_rxc.rxc04 = ' '
   LET l_rxc.rxc05 = ''
   LET l_rxc.rxc06 = (p_price - l_price)*p_count
   LET l_rxc.rxc07 = 0
   LET l_rxc.rxc08 = ''
   LET l_rxc.rxc09 = '0'
   LET l_rxc.rxc10 = ''
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   LET l_rxc.rxc11 = g_member
   LET l_rxc.rxcplant = p_plant
   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
               "     AND rxc01 = '",l_rxc.rxc01,"'",
               "     AND rxc02 = '",l_rxc.rxc02,"'",
               "     AND rxc03 = '",l_rxc.rxc03,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_del_rxc4 FROM l_sql
   EXECUTE pre_del_rxc4
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
               "rxc07,rxc08,rxc09,rxc10,rxcplant,rxclegal,rxc11,rxc12,rxc13,rxc14)",
               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_ins_rxc13 FROM l_sql
   EXECUTE pre_ins_rxc13 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,   #FUN-AA0065
                               l_rxc.rxc07,l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc11,         #FUN-AA0065
                               l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14                                                    #FUN-AA0065 
   IF SQLCA.SQLCODE THEN 
      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
      RETURN 0 
   END IF
   RETURN l_price
END FUNCTION
 
FUNCTION s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,p_price,p_count,p_team,p_cmd)
#FUN-AA0065   ---start  -add
DEFINE p_item       LIKE tqn_file.tqn03 
DEFINE p_cust       LIKE occ_file.occ01   
DEFINE p_cmd        LIKE type_file.chr1
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_line       LIKE oeb_file.oeb03
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_term       LIKE oah_file.oah01
DEFINE p_type       LIKE type_file.chr1
DEFINE l_sql        STRING
DEFINE l_no         LIKE oea_file.oea01
DEFINE l_line       LIKE oeb_file.oeb03
DEFINE l_time       LIKE type_file.chr8
DEFINE l_plant      LIKE azp_file.azp01
DEFINE l_rtz11      LIKE rtz_file.rtz11
DEFINE l_raa07      LIKE raa_file.raa07
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_i          LIKE type_file.num5
DEFINE l_cnt        LIKE type_file.num5
DEFINE l_price      LIKE oeb_file.oeb13
DEFINE l_rxc15      LIKE rxc_file.rxc15
DEFINE l_rxc06      LIKE rxc_file.rxc06
DEFINE l_a1_price   LIKE oeb_file.oeb13
DEFINE p_payment    LIKE oea_file.oea32     #付款條件
DEFINE p_no1        LIKE tqx_file.tqx01     #提案單號
   IF l_sx_1 <> l_sx THEN
   CALL s_fetch_price_new2(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd,'1')
   RETURNING  l_price,g_flg
      IF g_flg ='N' THEN 
         RETURN l_price
      END IF
   END IF
   IF l_sx_1 = l_sx THEN
      LET l_sql = "SELECT no,line FROM s_price_c2 WHERE item ='",p_item,"' AND line = '",p_line,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
      PREPARE pre_del_line2 FROM l_sql
      EXECUTE pre_del_line2 INTO l_no,l_line  
      LET l_sql = "SELECT SUM(rxc06) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                  "   WHERE rxc01 = '",l_no,"' ",
                  "   AND  rxc02 = '",l_line,"'  ",
                  " AND rxc03 IN ('01','02','03') "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
      PREPARE pre_sel_rxc121 FROM l_sql
      EXECUTE pre_sel_rxc121 INTO l_rxc06
###-MOD-B30045- ADD - BEGIN ----------------------------------
      IF cl_null(l_rxc06) THEN
         LET l_rxc06 = 0
      END IF
###-MOD-B30045- ADD -  END  ----------------------------------
      LET l_price = (p_price*p_count -l_rxc06)/p_count
      CALL cl_digcut(l_price,t_azi03)RETURNING l_price
      RETURN l_price
   END IF 
#抓取最近的档期活动设置的顺序,当前默认为'213'（组合促销->一般促销->满额促销），预留这段逻辑 
   SELECT raa07 INTO l_raa07 FROM raa_file
    WHERE raaacti='Y' AND raaconf = 'Y'
          AND raa05 >= g_today
          AND raa06 <= g_today

   IF cl_null(l_raa07) THEN LET l_raa07 = '213' END IF
#參數設定需要重新審核，以當前機構活動代碼為准;否則以拋轉資料為主
   SELECT rtz11 INTO l_rtz11 FROM rtz_file WHERE rtz01=p_plant
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87   
   CALL s_fetch_price_create_temp_table()
   CALL s_fetch_price_ins_temp_table(p_price,p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd)
   CASE p_type
       WHEN '1'
           LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                 #     " WHERE rxc03 IN ('01','02','03') ",                 #MOD-B20087 MARK
                       " WHERE rxc03 IN ('01','02','03','12') ",            #MOD-B20087 ADD
                       " AND   rxc00 = '01' AND rxc01 = '",p_no,"' "
       WHEN '2'                
           LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                 #     " WHERE rxc03 IN ('01','02','03') ",                 #MOD-B20087 MARK
                       " WHERE rxc03 IN ('01','02','03','12') ",            #MOD-B20087 ADD
                       " AND   rxc00 = '02' AND rxc01 = '",p_no,"' "
       WHEN '3'                 
           LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                 #     " WHERE rxc03 IN ('01','02','03') ",                 #MOD-B20087 MARK
                       " WHERE rxc03 IN ('01','02','03','12') ",            #MOD-B20087 ADD
                       " AND   rxc00 = '03' AND rxc01 = '",p_no,"' "  
    END CASE                   
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              						
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
           PREPARE pre_del_rxc6 FROM l_sql
           EXECUTE pre_del_rxc6

###-FUN-B30012 - ADD - BEGIN ---------------------------------------------
###先刪除rxd_file###
   CASE p_type
      WHEN '1'
         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxd_file'), 
                     " WHERE rxd02 IN ('2','3') ",
                     " AND   rxd00 = '01' AND rxd01 = '",p_no,"' "
      WHEN '2'
         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxd_file'), 
                     " WHERE rxd02 IN ('2','3') ",
                     " AND   rxd00 = '02' AND rxd01 = '",p_no,"' "
      WHEN '3'
         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxd_file'), 
                     " WHERE rxd02 IN ('2','3') ",
                     " AND   rxd00 = '03' AND rxd01 = '",p_no,"' "
   END CASE
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
   PREPARE pre_del_rxd FROM l_sql
   EXECUTE pre_del_rxd
###-FUN-B30012 - ADD -  END  ---------------------------------------------
    
   FOR l_i = 1 TO 3
      CASE l_raa07[l_i,l_i]
         WHEN '1'             #一般促销
            CALL s_price1(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team) 
         WHEN '2'
            CALL s_price2(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team) 
         WHEN '3'
            CALL s_price3(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team) 
      END CASE
   END FOR  
   LET l_sql = "SELECT no,line FROM s_price_c2 WHERE item ='",p_item,"' AND line = '",p_line,"' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
   PREPARE pre_del_line FROM l_sql
   EXECUTE pre_del_line INTO l_no,l_line  
   LET l_sql = "SELECT SUM(rxc06) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                  "   WHERE rxc01 = '",l_no,"' ",
                  "   AND  rxc02 = '",l_line,"'  ",
                  " AND rxc03 IN ('01','02','03') "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
   PREPARE pre_sel_rxc12 FROM l_sql
   EXECUTE pre_sel_rxc12 INTO l_rxc06
   LET l_price = (p_price*p_count -l_rxc06)/p_count
   CALL cl_digcut(l_price,t_azi03)RETURNING l_price

   RETURN l_price

    
#FUN-AA0065   ---end  --add 
    

#FUN-AA0065   ---start --mark
#DEFINE p_team       LIKE ohi_file.ohi02
#DEFINE p_cust       LIKE occ_file.occ01   
#DEFINE p_item       LIKE ima_file.ima01
#DEFINE p_cmd        LIKE type_file.chr1
#DEFINE p_unit       LIKE ima_file.ima25
#DEFINE p_date       LIKE type_file.dat
#DEFINE p_curr       LIKE azi_file.azi01
#DEFINE p_no         LIKE oea_file.oea01
#DEFINE p_line       LIKE oeb_file.oeb03
#DEFINE p_price      LIKE oeb_file.oeb13
#DEFINE p_count      LIKE oeb_file.oeb12
#DEFINE p_plant      LIKE azp_file.azp01
#DEFINE p_term       LIKE oah_file.oah01
#DEFINE p_type       LIKE type_file.chr1
#DEFINE l_sql        STRING
#DEFINE l_sql1       STRING
#DEFINE l_sql2       STRING
#DEFINE l_sql3       STRING
#DEFINE l_sql4       STRING                        #No.FUN-A10106
#DEFINE l_sql5       STRING                        #No.FUN-A10106
#DEFINE l_dbs        LIKE azp_file.azp03
#DEFINE l_success    LIKE type_file.chr1
#DEFINE l_plant      LIKE azp_file.azp01
#DEFINE l_rtz11      LIKE rtz_file.rtz11
#DEFINE l_time       LIKE type_file.chr8
#DEFINE l_rwa01      LIKE rwa_file.rwa01
#DEFINE l_rwa02      LIKE rwa_file.rwa02
#DEFINE l_rwa05      LIKE rwa_file.rwa05
#DEFINE l_rwa06      LIKE rwa_file.rwa06
#DEFINE l_rwa07      LIKE rwa_file.rwa07
#DEFINE l_n          LIKE type_file.num5
#DEFINE l_i          LIKE type_file.num5
#DEFINE l_price      LIKE oeb_file.oeb13
#DEFINE l_rxc        RECORD LIKE rxc_file.*
#DEFINE l_baseprice  LIKE oeb_file.oeb13 
#DEFINE l_baseamt    LIKE rxc_file.rxc06

#  #FUN-9C0068   ---start
#  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
#   LET g_plant_new = p_plant
#   CALL s_gettrandbs()
#   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

#   IF SQLCA.SQLCODE THEN
#      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#      RETURN 0 
#   END IF
#   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
#   SELECT rtz11 INTO l_rtz11 FROM rtz_file WHERE rtz01 = p_plant
#   IF l_rtz11 IS NULL THEN LET l_rtz11 = 'N' END IF
#   LET l_time = TIME
#   #No.FUN-A10106 --begin
#   CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
#               RETURNING l_baseprice
#   LET l_baseamt=p_count*l_baseprice
#   #No.FUN-A10106 --end
#   #找出商品特價促銷單中所有滿足條件的檔期活動代碼
#   #LET l_sql1 = "SELECT DISTINCT rwb01,rwb02 FROM ",l_dbs,"rwc_file,",
#   #              l_dbs,"rwb_file,",l_dbs,"rwq_file ",
#   LET l_sql1 = "SELECT DISTINCT rwb01,rwb02 FROM ",cl_get_target_table(g_plant_new,'rwc_file'),",", #FUN-A50102
#                                                    cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                    cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                "  WHERE rwc06 = '",p_item,"' ",
#                "    AND rwc09 = '",p_unit,"' ",
#                "    AND rwb01 = rwc01 AND rwb02 = rwc02 ",
#                "    AND rwb03 = rwc03 AND rwb04 = rwc04 ",
#                "    AND rwb01 = rwq01 AND rwb02 = rwq02 ",
#                "    AND rwb03 = rwq03 AND rwb04 = rwq04 ",
#                "    AND rwq06 = '",p_plant,"' AND rwbconf = 'Y' ",
#                "    AND '",p_date,"' BETWEEN rwc19 AND rwc20 ",
#                "    AND '",l_time,"' BETWEEN rwc21 AND rwc22 "
#   #找出品類特價促銷單中所有滿足條件的檔期活動代碼
#   #LET l_sql2 = " SELECT DISTINCT rwb01,rwb02 FROM ",l_dbs,"rwd_file,",
#   #               l_dbs,"ima_file,",l_dbs,"rwb_file,",l_dbs,"rwq_file ",
#    LET l_sql2 = " SELECT DISTINCT rwb01,rwb02 FROM ",cl_get_target_table(g_plant_new,'rwd_file'),",", #FUN-A50102
#                                                      cl_get_target_table(g_plant_new,'ima_file'),",", #FUN-A50102
#                                                      cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                      cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                "   WHERE rwd06 = ima131 ",
#                "    AND ima01 = '",p_item,"'",
#                "    AND rwb01 = rwd01 AND rwb02 = rwd02 ",
#                "    AND rwb03 = rwd03 AND rwb04 = rwd04 ",
#                "    AND rwb01 = rwq01 AND rwb02 = rwq02 ",
#                "    AND rwb03 = rwq03 AND rwb04 = rwq04 ",
#                "    AND rwq06 = '",p_plant,"' AND rwbconf = 'Y' ",
#                "    AND '",p_date,"' BETWEEN rwd13 AND rwd14 ",
#                "    AND '",l_time,"' BETWEEN rwd15 AND rwd16 "
   
#   #找出組合促銷單中所有滿足條件的檔期活動代碼
#   #LET l_sql3 = " SELECT DISTINCT rwf01,rwf02 FROM ",l_dbs,"rwf_file,",
#   #               l_dbs,"rwg_file,",l_dbs,"rwq_file ",
#   LET l_sql3 = " SELECT DISTINCT rwf01,rwf02 FROM ",cl_get_target_table(g_plant_new,'rwf_file'),",", #FUN-A50102
#                                                     cl_get_target_table(g_plant_new,'rwg_file'),",", #FUN-A50102
#                                                     cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                "   WHERE rwg06 = '",p_item,"' AND rwg09 = '",p_unit,"' ",         
#                "    AND rwf01 = rwg01 AND rwf02 = rwg02 ",
#                "    AND rwf03 = rwg03 AND rwf04 = rwg04 ",
#                "    AND rwf01 = rwq01 AND rwf02 = rwq02 ",
#                "    AND rwf03 = rwq03 AND rwf04 = rwq04 ",
#                "    AND rwq06 = '",p_plant,"' AND rwfconf = 'Y' ",
#                "    AND '",p_date,"' BETWEEN rwf06 AND rwf07 ",
#                "    AND '",l_time,"' BETWEEN rwf08 AND rwf09 "
#   #No.FUN-A10106 --begin             
#   #找出價格區間促銷單中符合條件的檔期活動代碼
#   #LET l_sql4=" SELECT DISTINCT rwb01,rwb02 FROM ",l_dbs,"rwb_file,",l_dbs,
#   #           "rwq_file,",l_dbs,"rwe_file,",l_dbs,"rwo_file WHERE rwb01=rwq01 " ,
#   LET l_sql4=" SELECT DISTINCT rwb01,rwb02 FROM ",cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwq_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwe_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwo_file'),     #FUN-A50102
#              " WHERE rwb01=rwq01 " ,
#              " AND rwb02=rwq02 AND rwb03=rwq03 AND rwb04=rwq04 AND rwbplant=rwqplant ",
#              " AND rwb01=rwe01 AND rwb02=rwe02 AND rwb03=rwe03 AND rwb04=rwe04 ",
#              " AND rwbplant=rweplant AND rwo01=rwb01 AND rwo02=rwb02 AND rwo03=rwb03 ",
#              " AND rwo04=rwb04 AND rwoplant=rwbplant AND rwbconf='Y' AND ((rwb14='1' AND rwb15 ='1' ",
#              #" AND (SELECT count(*) FROM ",l_dbs,"rwo_file WHERE rwo07='",p_item,"')>0)",
#              " AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE rwo07='",p_item,"')>0)",
#              #"  OR (rwb14='1' AND rwb15='2' AND (SELECT count(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file ",
#              "  OR (rwb14='1' AND rwb15='2' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                         cl_get_target_table(g_plant_new,'ima_file'),      #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)>0) OR (rwb14='3') ",
#              #" OR (rwb14='2' AND rwb15 ='1' AND (SELECT count(*) FROM ",l_dbs,"rwo_file WHERE",
#              " OR (rwb14='2' AND rwb15 ='1' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE",
#              #" rwo07='",p_item,"')=0) OR (rwb14='2' AND rwb15='2' AND (SELECT count(*) FROM ",l_dbs,
#              #"rwo_file,",l_dbs,"ima_file WHERE ima01='",p_item,"' AND ima131=rwo07)=0)) AND rwq06 ='",p_plant,"' ",
#              " rwo07='",p_item,"')=0) OR (rwb14='2' AND rwb15='2' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                                               cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)=0)) AND rwq06 ='",p_plant,"' ",
#              " AND ('",l_baseprice,"' between rwe06 AND rwe07 ) AND ('",p_date,"' between rwe14 AND rwe15)  ",
#              " AND ('",l_time,"' between rwe16 AND rwe17) "

#   #找出滿額促銷單中符合條件的檔期活動代碼
#   #LET l_sql5=" SELECT DISTINCT rwi01,rwi02 FROM ",l_dbs,"rwi_file,",l_dbs,"rwo_file,",l_dbs,"rwj_file,",l_dbs,"rwq_file",
#   LET l_sql5=" SELECT DISTINCT rwi01,rwi02 FROM ",cl_get_target_table(g_plant_new,'rwi_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwj_file'),",", #FUN-A50102
#                                                   cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#              " WHERE rwi01=rwq01 AND rwi02=rwq02 AND rwi03=rwq03 AND rwi04=rwq04 AND rwiplant=rwqplant ",
#              " AND rwi01=rwj01 AND rwi02=rwj02 AND rwi03=rwj03 AND rwi04=rwj04 AND rwiplant=rwjplant ",
#              " AND rwi01=rwo01 AND rwi02=rwo02 AND rwi03=rwo03 AND rwi04=rwo04 AND rwiplant=rwoplant AND rwiconf='Y' ",
#              #" AND ((rwi13='1' AND rwi14='1' AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file WHERE rwo07='",p_item,"')>0) ",
#              #" OR (rwi13='1' AND rwi14='2' AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file ",
#              " AND ((rwi13='1' AND rwi14='1' AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE rwo07='",p_item,"')>0) ",
#              " OR (rwi13='1' AND rwi14='2' AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                        cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)>0) OR (rwi13='2' AND rwi14='1' AND ",
#              #" (SELECT COUNT(*) FROM ",l_dbs,"rwo_file where rwo07 ='",p_item,"')=0) OR (rwi13='2' AND rwi14='2' ",
#              #" AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file WHERE ima01 ='",p_item,"' AND ima131=rwo07)=0)",
#             " (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " where rwo07 ='",p_item,"')=0) OR (rwi13='2' AND rwi14='2' ",
#              " AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                            cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01 ='",p_item,"' AND ima131=rwo07)=0)",
#              " OR (rwi13='3')) AND rwq06='",p_plant,"' AND ('",l_baseamt,"'>=rwj06 ) AND ('",p_date,"' BETWEEN rwi06 AND rwi07)",
#              " AND ('",l_time,"' BETWEEN rwi08 AND rwi09) AND ((rwi10='2') OR (rwi10='3') OR (rwi10='4' AND rwi19='1')",
#              " OR (rwi10='5' AND rwi19='1')) " 
#   #No.FUN-A10106 --end
#   #得到所有促銷單中所有滿足條件的檔期活動代碼
#   LET l_sql = l_sql1," UNION ",l_sql2," UNION ",l_sql3," UNION ",l_sql4," UNION ",l_sql5
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102    
#   PREPARE pre_sel_scale FROM l_sql
#   DECLARE cur_scale CURSOR FOR pre_sel_scale
#   LET l_success = 'N'
 
#   FOREACH cur_scale INTO l_rwa01,l_rwa02
#      IF l_rwa02 IS NULL THEN CONTINUE FOREACH END IF
#      #LET l_sql1 = "SELECT COUNT(*) FROM ",l_dbs,"rwa_file ",
#      LET l_sql1 = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwa_file'), #FUN-A50102
#                   "   WHERE rwa02 = '",l_rwa02,"' ",
#                   "     AND rwaconf = 'Y' "
#      CALL cl_replace_sqldb(l_sql1) RETURNING l_sql1              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql1,g_plant_new) RETURNING l_sql1 #FUN-A50102                 
#      PREPARE pre_sel_count FROM l_sql1
#     EXECUTE pre_sel_count INTO l_n 
#      #參數設定需要重新審核，以當前機構活動代碼為准;否則以拋轉資料為主 
#      IF l_n > 1 AND l_rtz11 = 'Y' THEN   
#         LET l_plant = p_plant
#      ELSE
#         LET l_plant = l_rwa01
#      END IF 
#      #LET l_sql1 = "SELECT rwa05,rwa06 FROM ",l_dbs,"rwa_file ",
#      LET l_sql1 = "SELECT rwa05,rwa06 FROM ",cl_get_target_table(g_plant_new,'rwa_file'), #FUN-A50102
#                   "   WHERE rwa02 = '",l_rwa02,"' ",
#                   "     AND rwa01 = '",l_plant,"' ",
#                   "     AND rwaconf = 'Y' "
#      CALL cl_replace_sqldb(l_sql1) RETURNING l_sql1              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql1,g_plant_new) RETURNING l_sql1 #FUN-A50102    
#      PREPARE pre_sel_rwa FROM l_sql1
#      DECLARE cur_rwa CURSOR FOR pre_sel_rwa
#      FOREACH cur_rwa INTO l_rwa05,l_rwa06
#	 IF l_rwa05 IS NULL THEN CONTINUE FOREACH END IF
#         IF l_rwa06 IS NULL THEN CONTINUE FOREACH END IF
#         IF l_rwa05 <= p_date AND l_rwa06 >= p_date THEN
#            LET l_success = 'Y'
#            EXIT FOREACH
#         END IF
#      END FOREACH 
#      IF l_success = 'Y' THEN EXIT FOREACH END IF
#   END FOREACH
#   #若檔期代碼沒有適合p_date的其始日期和結束日期,那就找出最大的結素日期的活動代碼
#   IF l_success = 'N' THEN
#      LET l_rwa02 = NULL
#      LET l_rwa01 = NULL
#      #LET l_sql = "SELECT DISTINCT rwa01,rwa02 FROM ",l_dbs,"rwa_file ",
#      LET l_sql = "SELECT DISTINCT rwa01,rwa02 FROM ",cl_get_target_table(g_plant_new,'rwa_file'), #FUN-A50102
#                 #"   WHERE rwaconf = 'Y' AND rwaplant = '",p_plant,"' AND rwa06 = ",
#                  "   WHERE rwaconf = 'Y'  AND rwa06 = ",
#                  " (SELECT MAX(rwa06) FROM rwa_file WHERE rwaconf = 'Y')"
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
#      PREPARE pre_sel_rwa02 FROM l_sql
#      EXECUTE pre_sel_rwa02 INTO l_rwa01,l_rwa02
#      IF SQLCA.SQLCODE THEN
#         #CALL cl_err('sel max rwa06',SQLCA.SQLCODE,1) 
#         RETURN 0
#      END IF
#      LET l_plant = l_rwa01
#   END IF
#   IF cl_null(l_rwa02) OR cl_null(l_rwa01) THEN RETURN 0 END IF
#   #取得促銷順序
#   #LET l_sql = "SELECT rwa07 FROM ",l_dbs,"rwa_file ",
#   LET l_sql = "SELECT rwa07 FROM ",cl_get_target_table(g_plant_new,'rwa_file'), #FUN-A50102
#               "   WHERE rwa02 = '",l_rwa02,"' AND rwa01 = '",l_plant,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
#   PREPARE pre_sel_rwa07 FROM l_sql
#   EXECUTE pre_sel_rwa07 INTO l_rwa07
#   IF cl_null(l_rwa07) THEN RETURN 0 END IF
#   LET g_member = 'N' 
#   LET l_success = 'Y'
#   LET l_n = LENGTH(l_rwa07)
#   FOR l_i = 1 TO l_n
#      CASE
#         WHEN l_rwa07[l_i] = '1'    #商品特價促銷
#            CALL s_price1(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,'1',p_count,p_team) 
#               RETURNING l_success,l_price 
#         WHEN l_rwa07[l_i] = '2'    #品類特價促銷
#            CALL s_price1(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,'2',p_count,p_team) 
#               RETURNING l_success,l_price 
#         WHEN l_rwa07[l_i] = '3' 
#            CALL s_price3(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team) 
#              RETURNING l_success,l_price   #價格區間特價
#         WHEN l_rwa07[l_i] = '4'    #組合促銷
#           #CALL s_price4(p_cust,p_curr,p_date,p_no,p_plant,l_rwa02,l_plant,p_type,p_team,p_cmd,p_price) #MOD-9C0173
#            CALL s_price4(p_cust,p_curr,p_date,p_no,p_plant,l_rwa02,l_plant,p_type,p_team,p_cmd,p_price,p_term,p_line) #MOD-9C0173
#               RETURNING l_success
#         WHEN l_rwa07[l_i] = '5' 
#            CALL s_price5(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team) 
#              RETURNING l_success,l_price   #滿額促銷
#      END CASE
#      IF l_success = 'Y' THEN EXIT FOR END IF
#   END FOR
 
#   RETURN l_price
#FUN-AA0065  ---end--mark
END FUNCTION
#FUN-AA0065   ---start --add
FUNCTION  s_price1(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team)
DEFINE p_cust        LIKE occ_file.occ01
DEFINE p_team        LIKE ohi_file.ohi02
DEFINE p_item        LIKE ima_file.ima01
DEFINE p_unit        LIKE ima_file.ima25
DEFINE p_date        LIKE type_file.dat
DEFINE p_term        LIKE oah_file.oah01
DEFINE p_curr        LIKE azi_file.azi01
DEFINE p_no          LIKE oea_file.oea01
DEFINE p_line        LIKE oeb_file.oeb03
DEFINE p_price       LIKE oeb_file.oeb13
DEFINE p_type        LIKE type_file.chr1
DEFINE p_flag        LIKE type_file.chr1
DEFINE p_count       LIKE oeb_file.oeb12
DEFINE p_plant       LIKE azp_file.azp01
DEFINE l_oea87       LIKE oea_file.oea87
DEFINE l_time        LIKE type_file.chr8
DEFINE l_cnt         LIKE type_file.num5
DEFINE l_sql1        STRING
DEFINE l_sql2        STRING
DEFINE g_sql         STRING
DEFINE l_sql         STRING
DEFINE l_rac         RECORD LIKE rac_file.*
DEFINE l_rxc         RECORD LIKE rxc_file.*
DEFINE l_rxc06       LIKE rxc_file.rxc06
DEFINE l_rab         RECORD LIKE rab_file.*
DEFINE l_n           LIKE type_file.num5   
DEFINE l_rap06       LIKE rap_file.rap06
DEFINE l_rap07       LIKE rap_file.rap07
DEFINE l_rap08       LIKE rap_file.rap08
DEFINE l_price       LIKE oeb_file.oeb13
DEFINE l_price1      LIKE rac_file.rac05
DEFINE l_price2      LIKE rac_file.rac06
DEFINE l_price3      LIKE rac_file.rac07
DEFINE l_rtu01       LIKE rtu_file.rtu01
DEFINE l_rtv02       LIKE rtv_file.rtv02
DEFINE l_rtv13       LIKE rtv_file.rtv13
DEFINE l_rtu05       LIKE rtu_file.rtu05
DEFINE l_lpj11       LIKE lpj_file.lpj11
DEFINE l_lpk10       LIKE lpk_file.lpk10
DEFINE l_rtz11       LIKE rtz_file.rtz11
DEFINE l_plant       LIKE azp_file.azp01
DEFINE l_flg1        LIKE type_file.chr1
DEFINE l_flg2        LIKE type_file.chr1
DEFINE l_type        LIKE type_file.chr1
DEFINE q_item        LIKE ima_file.ima01
DEFINE l_tmp         RECORD
                        no    LIKE oeb_file.oeb01,
                        line  LIKE oeb_file.oeb03,
                        item  LIKE ima_file.ima01,
                        unit  LIKE ima_file.ima25,
                        price LIKE oeb_file.oeb13,
                        qty   LIKE oeb_file.oeb12,
                        qty1  LIKE oeb_file.oeb12,
                        qty2  LIKE oeb_file.oeb12,
                        raf03 LIKE raf_file.raf03
                     END  RECORD
DEFINE l_rtu07       LIKE rtu_file.rtu07
DEFINE l_rtu08       LIKE rtu_file.rtu08
### -MOD-B20087- ADD - BEGIN --------------------------------
DEFINE l_lpj02       LIKE lpj_file.lpj02
DEFINE l_lph04       LIKE lph_file.lph04
DEFINE l_lph36       LIKE lph_file.lph36
### -MOD-B20087- ADD -  END  --------------------------------

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM s_price_c2 
   WHERE qty2 > 0
   IF l_cnt = 0 THEN RETURN END IF
   LET l_time = TIME
   LET l_sql1 = "SELECT DISTINCT rac_file.*,raq06,raq07 ",
                "  FROM ",cl_get_target_table(g_plant_new,'rab_file'),",",
                          cl_get_target_table(g_plant_new,'rac_file'),",",
                          cl_get_target_table(g_plant_new,'raq_file'),
                " WHERE rab01 = rac01 AND rab02 = rac02",
                "   AND rab01 = raq01 AND rab02 = raq02",
                "   AND rabplant=racplant AND rabplant=raqplant",
                "   AND raq03 = '1' AND raq04 = '",p_plant,"'",
                "   AND raq05 = 'Y'",                                           #MOD-B20087  ADD
                "   AND ((rac12 < '",p_date,"' AND rac13 > '",p_date,"')",
                "    OR (rac12 = '",p_date,"' AND rac14 <= '",l_time,"')",
                "    OR (rac13 = '",p_date,"' AND rac15 >= '",l_time,"'))",
                "   AND rabacti = 'Y' AND rabconf = 'Y' ",
                "   AND racacti = 'Y' AND raqacti = 'Y' ",        #FUN-B10024
                " ORDER BY raq06 DESC,raq07 DESC,rac03 " #By shi
           #    " ORDER BY rac03 "
           #    " ORDER BY rab901 DESC,rab902 DESC,rac03 "
   CALL cl_replace_sqldb(l_sql1) RETURNING l_sql1             							
   CALL cl_parse_qry_sql(l_sql1,g_plant_new) RETURNING l_sql1  
   PREPARE s_sel_rac_pre FROM l_sql1
   DECLARE s_sel_rac_cs CURSOR FOR s_sel_rac_pre
   FOREACH s_sel_rac_cs INTO l_rac.*
#更新本次消耗数量为0
   UPDATE s_price_c2 SET qty1 = 0
   IF STATUS THEN
      CALL cl_err("upd s_price_c2",STATUS,1) 
      LET g_success = 'N'
      RETURN
   END IF
   SELECT rtz11 INTO l_rtz11 FROM rtz_file WHERE rtz01=p_plant
   IF l_rtz11='Y' THEN 
      LET g_plant_new = p_plant
   ELSE
      LET g_plant_new = l_rac.rac01
   END IF 
   LET l_sql = "SELECT * ",	
               "  FROM ",cl_get_target_table(g_plant_new,'rab_file'),	
               " WHERE rab01 = '",l_rac.rac01,"' AND rab02 = '",l_rac.rac02,"'",	
               "   AND rabplant = '",g_plant_new,"'",	
               "   AND rabacti = 'Y' "	
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql           
   PREPARE s_sel_rab_pre FROM l_sql
   DECLARE s_sel_rab_cs CURSOR FOR s_sel_rab_pre
   EXECUTE s_sel_rab_cs INTO l_rab.*
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87 
   IF l_rab.rab04 = 'Y'  AND  l_oea87 IS NULL THEN 
      CONTINUE FOREACH 
   END IF   
   IF l_rac.rac08 = 'Y' THEN     
      LET l_sql = "SELECT lpk10 ",
                  "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
                            cl_get_target_table(g_plant_new,'lpj_file'),
                  " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
      PREPARE pre_del_lpk01 FROM l_sql
      EXECUTE pre_del_lpk01 INTO l_lpk10
      LET l_sql = "SELECT rap06,rap07,rap08 ",
                  "  FROM ",cl_get_target_table(g_plant_new,'rap_file'),
                  " WHERE rap01='",l_rac.rac01,"' AND rap02='",l_rac.rac02,"'  ",
                  " AND rapplant='",l_rac.racplant,"' AND rap05='",l_lpk10,"' AND rapacti='Y' AND rap03='1' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
      PREPARE pre_del_rap01 FROM l_sql
      EXECUTE pre_del_rap01 INTO l_rap06,l_rap07,l_rap08
      IF STATUS = 100 THEN             #取一般的特卖价、折扣率、折让金额 
           LET l_rap06 = l_rac.rac05
           LET l_rap07 = l_rac.rac06
           LET l_rap08 = l_rac.rac07 
      END IF
### -MOD-B20087- ADD - BEGIN ----------------------------------------
###-取一般的特卖价、折扣率、折让金额-###
      IF l_oea87 IS NOT NULL  THEN
         INITIALIZE l_lpj02,l_lph04 TO NULL
         SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
         SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
         IF l_lph04 <> 'Y' THEN
            LET l_rap06 = l_rac.rac05
            LET l_rap07 = l_rac.rac06
            LET l_rap08 = l_rac.rac07
         END IF
      END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
      CASE l_rac.rac04
            WHEN '1'
                LET l_price1 = l_rap06
            WHEN '2'   
                LET l_price2 = l_rap07
            WHEN '3'   
                LET l_price3 = l_rap08
      END CASE
   ELSE
      IF l_oea87 IS NOT NULL  THEN
### -MOD-B20087- ADD - BEGIN ----------------------------------------
         INITIALIZE l_lpj02,l_lph04 TO NULL
         SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
         SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
         IF l_lph04 = 'Y' THEN
### -MOD-B20087- ADD -  END  ----------------------------------------
            CASE l_rac.rac04
               WHEN '1'
                  LET l_price1 = l_rac.rac09
               WHEN '2'   
                  LET l_price2 = l_rac.rac10
               WHEN '3'   
                  LET l_price3 = l_rac.rac11
            END CASE
### -MOD-B20087- ADD - BEGIN ----------------------------------------
         ELSE
            CASE l_rac.rac04
               WHEN '1'
                  LET l_price1 = l_rac.rac05
               WHEN '2'
                  LET l_price2 = l_rac.rac06
               WHEN '3'
                  LET l_price3 = l_rac.rac07
            END CASE
         END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
      ELSE
          CASE l_rac.rac04
             WHEN '1'
                 LET l_price1 = l_rac.rac05
             WHEN '2'   
                 LET l_price2 = l_rac.rac06
             WHEN '3'   
                 LET l_price3 = l_rac.rac07
           END CASE    
      END IF 
   END IF 

   LET g_sql = "SELECT * FROM s_price_c2 WHERE qty2 > 0  "
   PREPARE s_fetch_price_c2_prepare3 FROM g_sql                                                
   DECLARE s_fetch_price_c2_curs3 CURSOR FOR s_fetch_price_c2_prepare3   
   FOREACH s_fetch_price_c2_curs3 INTO l_tmp.*               
      IF SQLCA.sqlcode != 0 THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF 
      # 找當前的料號在單身二對應的組中是否满足促销条件 
      IF NOT s_fetch_price_chk('1',l_rac.rac01,l_rac.rac02,l_rac.rac03,g_plant_new,l_tmp.item) THEN
         CONTINUE FOREACH
      END IF
      UPDATE s_price_c2 SET qty1 = l_tmp.qty2,qty2 = 0  WHERE item = l_tmp.item AND line = l_tmp.line   #本次消耗数量，剩余数量  #MOD-B30045 MOD
      CASE l_rac.rac04	
         WHEN '1'
	        LET l_rxc06 = l_tmp.price - l_price1
            LET l_price = l_price1
	     WHEN '2'
	        LET l_rxc06 = l_tmp.price * (1-l_price2/100)
            LET l_price = l_tmp.price *l_price2/100
	     WHEN '3'
	        LET l_rxc06 = l_price3
            LET l_price = l_tmp.price-l_price3
       END CASE	
       LET l_rxc06 = l_rxc06 * l_tmp.qty2	       
       IF l_rab.rab07 = 'Y'  THEN	
           LET l_flg1 = 'N'	
           LET l_flg2 = 'N'	
           IF l_rab.rab07 = 'Y' THEN LET l_flg2 = 'Y' END IF	
           IF l_rab.rab10 = 'Y' THEN LET l_flg1 = 'Y' END IF
          LET l_sql = "INSERT INTO s_price_c2_1 ",
                  "(no,line,item,type,cx_no,price,qty,qty1,qty2,flg1,flg2 )", 
                  "VALUES(?,?,?,?,?,?, ?,?,?,?,?)"                          
                  PREPARE pre_ins_no3 FROM l_sql
                  EXECUTE pre_ins_no3 USING l_tmp.no,l_tmp.line,l_tmp.item,'1',l_rab.rab02,l_price,l_tmp.qty2,                              
                                                    '0',l_tmp.qty2,l_flg1,l_flg2                  #一般促销后可参加满额促销的数量	
       END IF	
###-MOD-B20087- MARK - BEGIN --------------------------------------------------------
###-MARK掉原来会员卡折扣的部分-###
#      IF l_rab.rab10 = 'Y' AND l_rab.rab07 = 'N' AND l_oea87 IS NOT NULL THEN 	   #    在本次促销的基础上，加上会员卡的折扣
#       #  LET l_sql = "SELECT lpj11 ",
#       #              "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
#       #                        cl_get_target_table(g_plant_new,'lpj_file'),
#       #              " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
#       #  CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
#       #  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
#       #  PREPARE pre_del_lpk07 FROM l_sql
#       #  EXECUTE pre_del_lpk07 INTO l_lpj11 
#       #  IF cl_null(l_lpj11) THEN 
#       #     LET l_lpj11 = 100
#       #  END IF  
#          CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11      #MOD-B20078
#          CASE l_rac.rac04	
#             WHEN '1'
#                    LET l_rxc06 = l_tmp.price - l_price1*l_lpj11/100
#                 WHEN '2'
#                    LET l_rxc06 = l_tmp.price * (1-l_price2/100*l_lpj11/100)
#                 WHEN '3'
#                    LET l_rxc06 = l_tmp.price - (l_tmp.price - l_price3)*l_lpj11/100
#          END CASE
#          LET l_rxc06 = l_rxc06 * l_tmp.qty2
#      END IF	
###-MOD-B20087- MARK -  END  --------------------------------------------------------
#计算rxc_file相关值，INSERT INTO rxc_file
       IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
       IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
       IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
       LET l_sql = "SELECT rtu01,rtv02,rtv13,rtu05,rtu07,rtu08 ",
                   "  FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", 
                             cl_get_target_table(g_plant_new,'rtv_file'),    
                   " WHERE rtu01=rtv01 AND rtu02 = rtv02  ",     
                  #"   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                   "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 ",
                   "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
                   "   AND rtuplant = rtvplant AND rtuplant = '",g_plant_new,"'"
       CALL cl_replace_sqldb(l_sql) RETURNING l_sql             							
       CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
       PREPARE pre_sel3_rtv13 FROM l_sql
       EXECUTE pre_sel3_rtv13 INTO l_rtu01,l_rtv02,l_rtv13,l_rtu05,l_rtu07,l_rtu08
       IF cl_null(l_rtv13) OR l_rtv13 = 0 OR (l_rtu07<>'1' OR (l_rtu07='1' AND l_rtu08<>l_rab.rab02)) THEN
           LET l_sql = "SELECT A.rto01,A.rto03,A.rto05,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'),
                       "   WHERE A.rto05 = '",l_rtu05,"'",
                       "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                       "     AND A.rtoplant = '",g_plant_new,"'",
                       "     AND A.rtoconf = 'Y' ",
                       "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), 
                       "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant) "
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
           PREPARE pre_sel_rto10 FROM l_sql
           EXECUTE pre_sel_rto10 INTO l_rtu01,l_rtv02,l_rtu05,l_rtv13 
      END IF
      IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
      LET l_rxc.rxc01 = p_no
      LET l_rxc.rxc02 = l_tmp.line
      LET l_rxc.rxc03 = '01'
      LET l_rxc.rxc04 = l_rab.rab02
      LET l_rxc.rxc05 = ''
      IF p_type = '1' THEN
         SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
         SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
         WHERE azi01=g_oea.oea23
      END IF
      IF p_type = '2' THEN
          SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
         SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
         WHERE azi01=g_oga.oga23
      END IF
      IF p_type = '3' THEN
         SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
         SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
         WHERE azi01=g_oha.oha23
      END IF
      CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
      LET l_rxc.rxc06 = l_rxc06
      LET l_rxc.rxc07 = l_rtv13
      LET l_rxc.rxc08 = ''
      LET l_rxc.rxc09 = 0
      LET l_rxc.rxc10 = 0
      LET l_rxc.rxc11 = g_member   #是否會員
      LET l_rxc.rxc12 = l_rtv02
      LET l_rxc.rxc13 = l_rtu05
      LET l_rxc.rxc14 = l_rtu01
      LET l_rxc.rxcplant = p_plant
      LET l_rxc.rxc15 = l_tmp.qty2
      SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new
      LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",   
                  "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                  "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                  "rxc12,rxc13,rxc14,rxc15) ",
                  "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
      PREPARE pre_ins_rxc14 FROM l_sql
      EXECUTE pre_ins_rxc14 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, 
                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
      IF SQLCA.SQLCODE THEN 
          CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
###-MOD-B20087- ADD - BEGIN ---------------------------------------------------------
###-添加新的會員卡折扣邏輯###
      ELSE
         IF l_rab.rab10 = 'Y' AND l_rab.rab07 = 'N' AND l_oea87 IS NOT NULL THEN
            INITIALIZE l_lpj02,l_lph36 TO NULL
            SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
            SELECT lph36 INTO l_lph36 FROM lph_file WHERE lph01 = l_lpj02
            IF l_lph36 = 'Y' THEN
               CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11
               LET l_rxc06 = l_price - l_price*l_lpj11/100
               LET l_rxc06 = l_rxc06 * l_tmp.qty2
               CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
               LET l_rxc.rxc06 = l_rxc06
               LET l_rxc.rxc03 = '12'
               LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",   
                           "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                           "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                           "rxc12,rxc13,rxc14,rxc15) ",
                           "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
               CALL cl_replace_sqldb(l_sql) RETURNING l_sql 
               CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
               PREPARE pre_ins_rxc_p1 FROM l_sql
               EXECUTE pre_ins_rxc_p1 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,
                                            l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                                            l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                                            l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
               IF SQLCA.SQLCODE THEN
                  CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
               END IF
            END IF
         END IF
###-MOD-B20087- ADD -  END  ---------------------------------------------------------
      END IF
#     RETURN 'Y',l_price
      END FOREACH
   END FOREACH
END FUNCTION


FUNCTION  s_price2(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team)
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_term       LIKE oah_file.oah01
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_line       LIKE oeb_file.oeb03
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_type       LIKE type_file.chr1
DEFINE p_flag       LIKE type_file.chr1
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE p_plant      LIKE azp_file.azp01
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_time       LIKE type_file.chr8
DEFINE l_cnt         LIKE type_file.num5
DEFINE l_sql1        STRING
DEFINE l_sql2        STRING
DEFINE g_sql         STRING
DEFINE l_sql         STRING
DEFINE l_rae         RECORD LIKE rae_file.*
DEFINE l_rxc         RECORD LIKE rxc_file.*
DEFINE l_rxc06       LIKE rxc_file.rxc06
DEFINE l_raf03       LIKE raf_file.raf03
DEFINE l_raf04       LIKE raf_file.raf04
DEFINE l_raf05       LIKE raf_file.raf05
DEFINE l_raf05_1     LIKE raf_file.raf05
DEFINE l_sum         LIKE type_file.num5
DEFINE l_sum1        LIKE type_file.num5
DEFINE l_sum2        LIKE type_file.num5
DEFINE l_sum3        LIKE type_file.num5
DEFINE g_cnt         LIKE type_file.num5
DEFINE l_zu          LIKE type_file.num5
DEFINE l_zuzo        LIKE type_file.num5
DEFINE l_zu1         LIKE type_file.num5
DEFINE l_zu1_t       LIKE type_file.num5
DEFINE l_zu2         LIKE type_file.num5 
#--FUN-B30045 ----- MARK -- BEGIN -------------
#DEFINE l_qty         LIKE type_file.num5 
#DEFINE l_qty1        LIKE type_file.num5 
#DEFINE l_qty1_1      LIKE type_file.num5 
#DEFINE l_qty2        LIKE type_file.num5 
#DEFINE l_qty2_1      LIKE type_file.num5 
#DEFINE l_qty2_11     LIKE type_file.num5 
#--FUN-B30045 ----- MARK --  END  -------------
#--FUN-B30045 ----- ADD  -- BEGIN -------------
DEFINE l_qty         LIKE oeb_file.oeb12
DEFINE l_qty1        LIKE oeb_file.oeb12
DEFINE l_qty1_1      LIKE oeb_file.oeb12
DEFINE l_qty2        LIKE oeb_file.oeb12
DEFINE l_qty2_1      LIKE oeb_file.oeb12
DEFINE l_qty2_11     LIKE oeb_file.oeb12
#--FUN-B30045 ----- ADD  --  END  -------------
DEFINE l_price1      LIKE rac_file.rac05
DEFINE l_price2      LIKE rac_file.rac06
DEFINE l_price3      LIKE rac_file.rac07
DEFINE l_item        LIKE tqn_file.tqn03 
#DEFINE l_sum_qty2    LIKE type_file.num5 #FUN-B30045 MARK
DEFINE l_sum_qty2    LIKE oeb_file.oeb12  #FUN-B30045 ADD
DEFINE l_rap06       LIKE rap_file.rap06
DEFINE l_rap07       LIKE rap_file.rap07
DEFINE l_rap08       LIKE rap_file.rap08 
DEFINE l_price       LIKE oeb_file.oeb13
DEFINE l_rtu01       LIKE rtu_file.rtu01
DEFINE l_rtv02       LIKE rtv_file.rtv02
DEFINE l_rtv13       LIKE rtv_file.rtv13
DEFINE l_rtu05       LIKE rtu_file.rtu05
DEFINE l_lpj11       LIKE lpj_file.lpj11
DEFINE l_lpk10       LIKE lpk_file.lpk10
DEFINE l_rtz11       LIKE rtz_file.rtz11
DEFINE l_plant       LIKE azp_file.azp01
DEFINE l_rae01       LIKE rae_file.rae01
DEFINE l_rae02       LIKE rae_file.rae02
DEFINE l_rae03       LIKE rae_file.rae03
DEFINE l_flg1        LIKE type_file.chr1
DEFINE l_flg2        LIKE type_file.chr1
DEFINE q_item        LIKE ima_file.ima01
DEFINE l_n2          LIKE type_file.num5
DEFINE l_tmp1        RECORD
                        no    LIKE oeb_file.oeb01,
                        line  LIKE oeb_file.oeb03,
                        item  LIKE ima_file.ima01,
                        unit  LIKE ima_file.ima25,
                        price LIKE oeb_file.oeb13,
                        qty   LIKE oeb_file.oeb12,
                        qty1  LIKE oeb_file.oeb12,
                        qty2  LIKE oeb_file.oeb12,
                        raf03 LIKE raf_file.raf03
                     END  RECORD  
DEFINE l_tmp        DYNAMIC ARRAY OF RECORD
                        no    LIKE oeb_file.oeb01,
                        line  LIKE oeb_file.oeb03,
                        item  LIKE ima_file.ima01,
                        unit  LIKE ima_file.ima25,
                        price LIKE oeb_file.oeb13,
                        qty   LIKE oeb_file.oeb12,
                        qty1  LIKE oeb_file.oeb12,
                        qty2  LIKE oeb_file.oeb12,
                        raf03 LIKE raf_file.raf03
                     END  RECORD 
DEFINE l_rtu07       LIKE rtu_file.rtu07        #FUN-B10024
DEFINE l_rtu08       LIKE rtu_file.rtu08        #FUN-B10024                   
DEFINE l_rxd         RECORD LIKE rxd_file.*  #FUN-B30012 ADD
### -MOD-B20087- ADD - BEGIN --------------------------------
DEFINE l_lpj02       LIKE lpj_file.lpj02
DEFINE l_lph04       LIKE lph_file.lph04
DEFINE l_lph36       LIKE lph_file.lph36
### -MOD-B20087- ADD -  END  --------------------------------
#剩余数量>0，才可以走下面的逻辑
    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt FROM s_price_c2 
    WHERE qty2 > 0
    IF l_cnt = 0 THEN RETURN END IF  
#更新本次消耗数量为0
    UPDATE s_price_c2 SET qty1 = 0,raf03 = 0
    IF STATUS THEN
       CALL cl_err("upd s_price_c2",STATUS,1)  
       LET g_success = 'N'
       RETURN
    END IF
    LET l_time = TIME
    LET l_sql1 = "SELECT DISTINCT rae_file.*,raq06,raq07 ",
                 "  FROM ",cl_get_target_table(g_plant_new,'rae_file'),",",
                           cl_get_target_table(g_plant_new,'raf_file'),",",
                           cl_get_target_table(g_plant_new,'raq_file'),
                 " WHERE rae01 = raf01 AND rae02 = raf02",
                 "   AND rae01 = raq01 AND rae02 = raq02",
                 "   AND raeplant=rafplant AND raeplant=raqplant",
                 "   AND raq03 = '2' AND raq04 = '",p_plant,"'",
                 "   AND raq05 = 'Y'",                                           #MOD-B20087  ADD
                 "   AND ((rae04 < '",p_date,"' AND rae05 > '",p_date,"' )",
                 "    OR (rae04 = '",p_date,"' AND rae06 <= '",l_time,"')",
                 "    OR (rae05 = '",p_date,"' AND rae07 >= '",l_time,"'))",
                 "   AND raeacti = 'Y' AND raeconf = 'Y' ",
                 "   AND raqacti = 'Y' ",                          #FUN-B10024
                 " ORDER BY raq06 DESC,raq07 DESC "  #By shi
          #      "   ORDER BY rae02 DESC " 
          #      " ORDER BY rae901,rae902 DESC " 
    CALL cl_replace_sqldb(l_sql1) RETURNING l_sql1              							
    CALL cl_parse_qry_sql(l_sql1,g_plant_new) RETURNING l_sql1           
    PREPARE s_sel_rae_pre FROM l_sql1
    DECLARE s_sel_rae_cs CURSOR FOR s_sel_rae_pre
    FOREACH s_sel_rae_cs INTO l_rae.*
        SELECT rtz11 INTO l_rtz11 FROM rtz_file WHERE rtz01=p_plant
        IF l_rtz11='Y' THEN 
            LET g_plant_new = p_plant
        ELSE
            LET g_plant_new = l_rae.rae01
        END IF
        CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87 
        IF l_rae.rae11 = 'Y'  AND  l_oea87 IS NULL THEN 
           CONTINUE FOREACH 
        END IF
        IF l_rae.rae12 = 'Y' THEN
            LET l_sql = "SELECT lpk10 ",
                        "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
                                  cl_get_target_table(g_plant_new,'lpj_file'),
                        " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
            PREPARE pre_del_lpk02 FROM l_sql
            EXECUTE pre_del_lpk02 INTO l_lpk10
            LET l_sql = "SELECT rap06,rap07,rap08 ",
                        "  FROM ",cl_get_target_table(g_plant_new,'rap_file'),
                        " WHERE rap01='",l_rae.rae01,"' AND rap02='",l_rae.rae02,"'  ",
                        " AND rapplant='",l_rae.raeplant,"' AND rap05='",l_lpk10,"' AND rapacti='Y' AND rap03='2' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
            PREPARE pre_del_rap02 FROM l_sql
            EXECUTE pre_del_rap02 INTO l_rap06,l_rap07,l_rap08
            IF STATUS = 100 THEN             #取一般的特卖价、折扣率、折让金额 
               LET l_rap06 = l_rae.rae15
               LET l_rap07 = l_rae.rae16
               LET l_rap08 = l_rae.rae17
            END IF
### -MOD-B20087- ADD - BEGIN ----------------------------------------
###-取一般的特卖价、折扣率、折让金额-###
            IF l_oea87 IS NOT NULL  THEN
               INITIALIZE l_lpj02,l_lph04 TO NULL
               SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
               SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
               IF l_lph04 <> 'Y' THEN
                  LET l_rap06 = l_rae.rae15
                  LET l_rap07 = l_rae.rae16
                  LET l_rap08 = l_rae.rae17
               END IF
            END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
            CASE l_rae.rae10
               WHEN '1'
                  LET l_price1 = l_rap06
               WHEN '2'   
                  LET l_price2 = l_rap07
               WHEN '3'   
                  LET l_price3 = l_rap08
             END CASE
          
        ELSE
           IF l_oea87 IS NOT NULL  THEN
### -MOD-B20087- ADD - BEGIN -------------------------------------
              INITIALIZE l_lpj02,l_lph04 TO NULL
              SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
              SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
              IF l_lph04 = 'Y' THEN
### -MOD-B20087- ADD -  END  -------------------------------------
                 CASE l_rae.rae10
                    WHEN '1'
                       LET l_price1 = l_rae.rae18
                    WHEN '2'   
                       LET l_price2 = l_rae.rae19 
                    WHEN '3'   
                       LET l_price3 = l_rae.rae20
                 END CASE
### -MOD-B20087- ADD - BEGIN -------------------------------------
              ELSE
                 CASE l_rae.rae10
                    WHEN '1'
                       LET l_price1 = l_rae.rae15
                    WHEN '2'
                       LET l_price2 = l_rae.rae16
                    WHEN '3'
                       LET l_price3 = l_rae.rae17
                 END CASE
              END IF
### -MOD-B20087- ADD -  END  -------------------------------------
           ELSE
              CASE l_rae.rae10
                 WHEN '1'
                    LET l_price1 = l_rae.rae15
                 WHEN '2'   
                    LET l_price2 = l_rae.rae16 
                 WHEN '3'   
                    LET l_price3 = l_rae.rae17
              END CASE    
           END IF      
        END IF
        LET l_zu = 0
        LET l_zu1 = 0
        LET l_zu1_t = 0
        LET l_zu2 = 0
        LET l_qty2 = 0   
        LET l_qty2_1 = 0
        LET l_raf03 =''
        LET l_sum_qty2 = 0
        UPDATE s_price_c2 SET raf03 = ''  
        LET g_sql = "SELECT item,SUM(qty2) FROM s_price_c2 ",	
                    " WHERE qty2 > 0 ",	
                    " GROUP BY item "	
        PREPARE s_fetch_price_c2_prepare1 FROM g_sql                                                
        DECLARE s_fetch_price_c2_curs1 CURSOR FOR s_fetch_price_c2_prepare1   
        FOREACH s_fetch_price_c2_curs1 INTO l_item,l_sum_qty2
            IF SQLCA.sqlcode != 0 THEN
                CALL cl_err('foreach:',SQLCA.sqlcode,1)
                EXIT FOREACH
            END IF
            LET l_sql = "SELECT raf03,raf04,raf05 ",	
                        "  FROM ",cl_get_target_table(g_plant_new,'raf_file'),	
                        " WHERE raf01 = '",l_rae.rae01,"' AND raf02 = '",l_rae.rae02,"'",	
                        "   AND rafplant = '",g_plant_new,"'",	
                        "   AND rafacti = 'Y' "	
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql           
            PREPARE s_sel_raf_pre FROM l_sql
            DECLARE s_sel_raf_cs CURSOR FOR s_sel_raf_pre
            FOREACH s_sel_raf_cs INTO l_raf03,l_raf04,l_raf05	
               IF NOT s_fetch_price_chk('2',l_rae.rae01,l_rae.rae02,l_raf03,g_plant_new,l_item) THEN	
                   CONTINUE FOREACH	
               END IF	
               UPDATE s_price_c2 SET raf03 = l_raf03 WHERE item = l_item 		
               IF l_raf04 = '1' THEN  #必选	
                       SELECT SUM(qty2) INTO l_qty2 FROM s_price_c2
	                    WHERE raf03 = l_raf03 AND raf03 IS NOT NULL
	               IF cl_null(l_qty2) THEN LET l_qty2 = 0 END IF
	               LET l_zu1 = l_qty2/l_raf05
                   IF cl_null(l_zu1_t) OR l_zu1_t = 0  THEN LET l_zu1_t = l_zu1 END IF
	               IF l_zu1 >= l_zu1_t THEN
                       LET l_zu1 = l_zu1_t
                   END IF     
	           ELSE
	              LET l_qty2_1 = l_qty2_1 + l_sum_qty2  
               END IF
             EXIT FOREACH              
           END FOREACH   
        END FOREACH	
        IF l_zu1 = 0 THEN CONTINUE FOREACH END IF
        LET l_sql = "SELECT count(*) ",	
                    "  FROM ",cl_get_target_table(g_plant_new,'raf_file'),	
                    " WHERE raf01 = '",l_rae.rae01,"' AND raf02 = '",l_rae.rae02,"'",	
                    "   AND rafplant = '",g_plant_new,"'  AND  raf04 = '1'",	
                    #"   AND (raf03 NOT IN (select raf03 from s_price_c2 )) AND rafacti = 'Y' "	   #MOD-B30402 mark
                    "   AND (raf03 NOT IN (select raf03 from s_price_c2 WHERE raf03 IS NOT NULL )) ", #MOD-B30402 add
                    "   AND rafacti = 'Y' "         #MOD-B30402 add
        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql           
        PREPARE s_sel_raf01_cs FROM l_sql
        EXECUTE s_sel_raf01_cs INTO l_n2
        IF l_n2 >0 THEN 
           CONTINUE FOREACH
        END IF
           LET l_sql = "SELECT SUM(raf05) ",	
                        "  FROM ",cl_get_target_table(g_plant_new,'raf_file'),	
                        " WHERE raf01 = '",l_rae.rae01,"' AND raf02 = '",l_rae.rae02,"' ",	
                        "  AND  raf04 = '1'  AND rafplant = '",g_plant_new,"' ",	
                        "   AND rafacti = 'Y' "	
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql           
           PREPARE s_sel_raf05_pre FROM l_sql
           EXECUTE s_sel_raf05_pre INTO l_raf05_1  
        IF l_rae.rae21 = 0 OR l_rae.rae21 = l_raf05_1 OR cl_null(l_rae.rae21)  THEN	
           LET l_zu = l_zu1	
        ELSE
           LET l_zu2 = l_qty2_1 / (l_rae.rae21 - l_raf05_1)
           IF   l_zu1 <=  l_zu2 THEN     #  满足的组数l_zu 取l_zu1和l_zu2中小的
               LET l_zu = l_zu1
           ELSE	
               LET l_zu = l_zu2
           END IF   	
        END IF	
        IF l_zu = 0 THEN CONTINUE FOREACH END IF
        UPDATE s_price_c2 SET qty1 = 0
        LET g_sql = "SELECT * FROM s_price_c2 WHERE qty2 > 0 AND raf03 IS NOT NULL order by line "	  
        PREPARE s_fetch_price_c2_prepare2 FROM g_sql                                                
        DECLARE s_fetch_price_c2_curs2 CURSOR FOR s_fetch_price_c2_prepare2   
        FOREACH s_fetch_price_c2_curs2 INTO l_tmp1.*
            IF SQLCA.sqlcode != 0 THEN
                CALL cl_err('foreach:',SQLCA.sqlcode,1)
                EXIT FOREACH
            END IF 
    #        SELECT SUM(qty2) INTO l_qty2 FROM s_price_c2 
    #           WHERE raf03= l_zu
            LET l_sql = "SELECT raf04,raf05 ",
                        "  FROM ",cl_get_target_table(g_plant_new,'raf_file'),
                        " WHERE raf01 = '",l_rae.rae01,"' AND raf02 = '",l_rae.rae02,"' ",	
                        "  AND  raf03='",l_tmp1.raf03,"'  AND rafplant = '",g_plant_new,"' ",	
                        "   AND rafacti = 'Y' "	
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
            PREPARE pre_del_raf04 FROM l_sql
            EXECUTE pre_del_raf04 INTO  l_raf04,l_raf05
            IF l_raf04 = '1' THEN  
               LET   l_zuzo = l_raf05 * l_zu        #該組滿足用到的個數
                  SELECT SUM(qty1) INTO l_qty1 FROM s_price_c2  WHERE item = l_tmp1.item  AND raf03 IS NOT NULL
                  IF l_qty1 >= l_zuzo THEN
                     CONTINUE FOREACH
                  END IF
                  IF l_tmp1.qty2 >= l_zuzo - l_qty1 THEN 
                     LET l_tmp1.qty1 = l_zuzo - l_qty1  #該項次料件本次消耗數量
                  ELSE 
                     LET l_tmp1.qty1 = l_tmp1.qty2      #該項次料件本次消耗數量
                  END IF
               LET l_tmp1.qty2  = l_tmp1.qty2 - l_tmp1.qty1       #該項次料件本次剩餘數量                   
            ELSE
                LET   l_zuzo = (l_rae.rae21-l_raf05_1) * l_zu        #該組滿足用到的個數
                  SELECT SUM(qty1) INTO l_qty1 FROM s_price_c2  WHERE item = l_tmp1.item  AND raf03 IS NOT NULL
                  IF l_qty1 >= l_zuzo THEN
                     CONTINUE FOREACH
                  END IF
                  IF l_tmp1.qty2 >= l_zuzo - l_qty1 THEN 
                     LET l_tmp1.qty1 = l_zuzo - l_qty1  #該項次料件本次消耗數量
                  ELSE 
                     LET l_tmp1.qty1 = l_tmp1.qty2      #該項次料件本次消耗數量
                  END IF
               LET l_tmp1.qty2  = l_tmp1.qty2 - l_tmp1.qty1       #該項次料件本次剩餘數量 
            END IF   
            UPDATE s_price_c2 SET qty1 = l_tmp1.qty1,qty2 = l_tmp1.qty2  WHERE item = l_tmp1.item AND line=l_tmp1.line	
             
            SELECT SUM(qty1) INTO l_qty1 FROM s_price_c2 WHERE  raf03 IS NOT NULL
            IF cl_null(l_rae.rae21) OR l_rae.rae21= 0 THEN
               SELECT SUM(raf05*l_zu) INTO l_sum
               FROM raf_file
               WHERE raf01 = l_rae.rae01 AND raf02 = l_rae.rae02
               AND  raf04='1' AND rafplant = g_plant_new	
               AND rafacti = 'Y' 	
            ELSE 
 	       LET l_sum  = l_rae.rae21*l_zu  
            END IF 
            IF l_sum > l_qty1 THEN
               CONTINUE FOREACH
            ELSE
               EXIT FOREACH
            END IF   
        END FOREACH  
        SELECT SUM(qty1*price) INTO l_sum1 FROM s_price_c2 WHERE qty1 > 0 AND raf03 IS NOT NULL
        LET l_cnt = 1
        LET l_sum2 = 0  
        LET g_sql = "SELECT * FROM s_price_c2 WHERE qty1 > 0 AND raf03 IS NOT NULL  ORDER  BY item   "
        PREPARE s_fetch_price_c2_prepare6 FROM g_sql                                                
        DECLARE s_fetch_price_c2_curs6 CURSOR FOR s_fetch_price_c2_prepare6 
        FOREACH s_fetch_price_c2_curs6 INTO l_tmp[l_cnt].*   #by 每筆單身算本次消耗數量
           CASE l_rae.rae10	
               WHEN '1'
                  SELECT SUM(qty1*price) INTO l_sum3 FROM s_price_c2 
                  WHERE qty1 > 0 AND item =l_tmp[l_cnt].item AND line =l_tmp[l_cnt].line
                  LET l_rxc06 = (l_sum1 - l_price1*l_zu)*l_sum3/l_sum1
                  LET l_price = l_price1*l_zu*l_sum3/l_sum1/l_tmp[l_cnt].qty1
	           WHEN '2'
	              LET l_rxc06 = l_tmp[l_cnt].price * (1-l_price2/100)
                  LET l_price = l_tmp[l_cnt].price * l_price2/100
                  LET l_rxc06 = l_rxc06 *l_tmp[l_cnt].qty1
	           WHEN '3'
                  SELECT count(*)  INTO g_cnt FROM s_price_c2 WHERE qty1 > 0 
                  IF l_cnt <> g_cnt THEN  
	                  LET l_rxc06 = (l_price3*l_zu)*(l_tmp[l_cnt].price*l_tmp[l_cnt].qty1)/l_sum1
                      LET l_price = l_tmp[l_cnt].price - l_rxc06/l_tmp[l_cnt].qty1
                      LET l_sum2 = l_sum2 + l_rxc06
                  ELSE
                      LET l_rxc06 = l_price3*l_zu - l_sum2
                      LET l_price = l_tmp[l_cnt].price - l_rxc06/l_tmp[l_cnt].qty1
                  END IF   
           END CASE	
           IF l_rae.rae23 = 'Y' OR (l_rae.rae26 = 'Y' AND l_oea87 IS NOT NULL) THEN
               IF l_rae.rae23 = 'Y' THEN LET l_flg2 = 'Y' ELSE LET l_flg2 = 'N' END IF
               IF l_rae.rae26 = 'Y' THEN LET l_flg1 = 'Y' ELSE LET l_flg1 = 'N' END IF
               LET l_sql = "INSERT INTO s_price_c2_1 ",
                  "(no,line,item,type,cx_no,price,qty,qty1,qty2,flg1,flg2 )", 
                  "VALUES(?,?,?,?,?,?, ?,?,?,?,?)"                          
                  PREPARE pre_ins_no2 FROM l_sql
                  EXECUTE pre_ins_no2 USING l_tmp[l_cnt].no,l_tmp[l_cnt].line,l_tmp[l_cnt].item,'2',l_rae.rae02,l_price,l_tmp[l_cnt].qty1,                              
                                                         '0',l_tmp[l_cnt].qty1,l_flg1,l_flg2
           END IF
###-MOD-B20087- MARK - BEGIN ----------------------------------------------------------
###-MARK掉原來會員卡折扣部份###
#          IF l_rae.rae23 = 'N' AND l_rae.rae26 = 'Y' AND l_oea87 IS NOT NULL THEN     #  在現在的基礎上加上會員卡的折扣
#           #  LET l_sql = "SELECT lpj11 ",
#           #              "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
#           #                        cl_get_target_table(g_plant_new,'lpj_file'),
#           #              " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
#           #  CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
#           #  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
#           #  PREPARE pre_del_lpk08 FROM l_sql
#           #  EXECUTE pre_del_lpk08 INTO l_lpj11
#           #  IF cl_null(l_lpj11) THEN 
#           #     LET l_lpj11 = 100
#           #  END IF
#              CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11      #MOD-B20078 
#              CASE l_rae.rae10	
#                 WHEN '1'
#                    SELECT SUM(qty1*price) INTO l_sum3 FROM s_price_c2 
#                    WHERE qty1 > 0 AND item =l_tmp[l_cnt].item AND line =l_tmp[l_cnt].line
#                    LET l_rxc06 = (l_sum1- l_price1*l_zu*l_lpj11/100)*l_sum3/l_sum1
#                    LET l_price = l_price1*l_zu*l_lpj11/100*l_sum3/l_sum1/l_tmp[l_cnt].qty1
#                     WHEN '2'
#                        LET l_rxc06 = l_tmp[l_cnt].price * (1-l_price2/100*l_lpj11/100)
#                    LET l_rxc06 = l_rxc06 *l_tmp[l_cnt].qty1
#                     WHEN '3'
#                    SELECT count(*)  INTO g_cnt FROM s_price_c2 WHERE qty1 > 0 
#                    IF l_cnt <> g_cnt THEN  
#                           LET l_rxc06 =l_tmp[l_cnt].price- (l_tmp[l_cnt].price-(l_price3*l_zu)*(l_tmp[l_cnt].price*l_tmp[l_cnt].qty1)/l_sum1/l_tmp[l_cnt].qty1)*l_lpj11/100
#                       LET l_rxc06 = l_rxc06 *l_tmp[l_cnt].qty1
#                       LET l_sum2 = l_sum2 + l_rxc06
#                    ELSE
#                       LET l_rxc06 = l_price3*l_zu - l_sum2
#                    END IF  
#               END CASE
#          END IF
###-MOD-B20087- MARK -  END  ------------------------------------------------------------
           IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
           IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
           IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
           LET l_sql = "SELECT rtu01,rtv02,rtv13,rtu05,rtu07,rtu08  FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", 
                                                               cl_get_target_table(g_plant_new,'rtv_file'),    
                       " WHERE rtu01=rtv01 AND rtu02 = rtv02  ",     
                      #"   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                       "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 ",
                       "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
                       "   AND rtuplant = rtvplant AND rtuplant = '",g_plant_new,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql             							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
           PREPARE pre_sel4_rtv13 FROM l_sql
           EXECUTE pre_sel4_rtv13 INTO l_rtu01,l_rtv02,l_rtv13,l_rtu05,l_rtu07,l_rtu08 
           IF cl_null(l_rtv13) OR l_rtv13 = 0 OR (l_rtu07<>'2' OR (l_rtu07='2' AND l_rtu08<>l_rae.rae02)) THEN    #FUN-B10024
               LET l_sql = "SELECT A.rto01,A.rto03,A.rto05,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'),
                           "   WHERE A.rto05 = '",l_rtu05,"'",
                           "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                           "     AND A.rtoplant = '",g_plant_new,"'",
                           "     AND A.rtoconf = 'Y' ",
                           "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), 
                           "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant) "
               CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
               CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
               PREPARE pre_sel_rto11 FROM l_sql
               EXECUTE pre_sel_rto11 INTO l_rtu01,l_rtv02,l_rtu05,l_rtv13 
           END IF
           IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
           LET l_rxc.rxc01 = p_no
           LET l_rxc.rxc02 = l_tmp[l_cnt].line
           LET l_rxc.rxc03 = '02'
           LET l_rxc.rxc04 = l_rae.rae02
           LET l_rxc.rxc05 = ''
           IF p_type = '1' THEN
              SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
              WHERE azi01=g_oea.oea23
           END IF
           IF p_type = '2' THEN
              SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
              WHERE azi01=g_oga.oga23
           END IF
           IF p_type = '3' THEN
              SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
              WHERE azi01=g_oha.oha23
           END IF
           CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
           LET l_rxc.rxc06 = l_rxc06
           LET l_rxc.rxc07 = l_rtv13
           LET l_rxc.rxc08 = ''
           LET l_rxc.rxc09 = 0
           LET l_rxc.rxc10 = 0
           LET l_rxc.rxc11 = g_member   #是否會員
           LET l_rxc.rxc12 = l_rtv02
           LET l_rxc.rxc13 = l_rtu05
           LET l_rxc.rxc14 = l_rtu01
           LET l_rxc.rxcplant = p_plant
           LET l_rxc.rxc15 = l_tmp[l_cnt].qty1
           SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new
           LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",   
                       "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                       "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                       "rxc12,rxc13,rxc14,rxc15) ",
                       "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
           PREPARE pre_ins_rxc141 FROM l_sql
           EXECUTE pre_ins_rxc141 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, 
                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
           IF SQLCA.SQLCODE THEN 
              CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
###-MOD-B20087- ADD - BEGIN -----------------------------------------------------
###-添加新的會員卡折扣邏輯-###
           ELSE
              IF l_rae.rae23 = 'N' AND l_rae.rae26 = 'Y' AND l_oea87 IS NOT NULL THEN
                 INITIALIZE l_lpj02,l_lph36 TO NULL
                 SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                 SELECT lph36 INTO l_lph36 FROM lph_file WHERE lph01 = l_lpj02
                 IF l_lph36 = 'Y' THEN
                    CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11
                    LET l_rxc06 = l_price * (1-l_lpj11/100)
                    LET l_rxc06 = l_rxc06 * l_tmp[l_cnt].qty1
                    CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
                    LET l_rxc.rxc06 = l_rxc06
                    LET l_rxc.rxc03 = '12'
                    LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",
                                "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                                "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                                "rxc12,rxc13,rxc14,rxc15) ",
                                "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                    PREPARE pre_ins_rxc_p2 FROM l_sql
                    EXECUTE pre_ins_rxc_p2 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,
                                                 l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                                                 l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                                                 l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
                    IF SQLCA.SQLCODE THEN
                       CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
                    END IF 
                 END IF
              END IF
###-MOD-B20087- ADD -  END  -----------------------------------------------------
           END IF
           LET l_cnt = l_cnt+1
        END FOREACH
####-FUN-B30012-ADD----BEGIN-----------------------------------------------------
####換贈的條件下新增一筆資料到rxd_file####
        IF l_rae.rae27 = 'Y' THEN
           IF p_type = '1' THEN LET l_rxd.rxd00 = '01' END IF
           IF p_type = '2' THEN LET l_rxd.rxd00 = '02' END IF
           IF p_type = '3' THEN LET l_rxd.rxd00 = '03' END IF
           LET l_rxd.rxd01 = p_no
           LET l_rxd.rxd02 = '2'
           LET l_rxd.rxd03 = l_rae.rae02
           LET l_rxd.rxd04 = 0
           LET l_rxd.rxd05 = l_zu
           LET l_rxd.rxdplant = p_plant
           SELECT azw02 INTO l_rxd.rxdlegal FROM azw_file WHERE azw01 = g_plant_new
           LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxd_file'),"(",
                       "rxd00,rxd01,rxd02,rxd03,rxd04,rxd05,",
                       "rxdplant,rxdlegal) ",
                       "VALUES(?,?,?,?,?,?,?,?)"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
           PREPARE pre_ins_rxd_2 FROM l_sql
           EXECUTE pre_ins_rxd_2 USING l_rxd.rxd00,l_rxd.rxd01,l_rxd.rxd02,l_rxd.rxd03,
                                       l_rxd.rxd04,l_rxd.rxd05,
                                       l_rxd.rxdplant,l_rxd.rxdlegal
           IF SQLCA.SQLCODE THEN
              CALL cl_err('ins rxd',SQLCA.SQLCODE,1)
           END IF
        END IF
####-FUN-B30012-ADD-----END------------------------------------------------------
    END FOREACH
#   RETURN l_price
END FUNCTION


FUNCTION  s_price3(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team)
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_term       LIKE oah_file.oah01
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_line       LIKE oeb_file.oeb03
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_type       LIKE type_file.chr1
DEFINE p_flag       LIKE type_file.chr1
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE p_plant      LIKE azp_file.azp01
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_time       LIKE type_file.chr8
DEFINE l_cnt        LIKE type_file.num5
DEFINE l_cnt1       LIKE type_file.num5
DEFINE l_cnt2       LIKE type_file.num5
DEFINE l_sql1        STRING
DEFINE l_sql2        STRING
DEFINE g_sql         STRING
DEFINE l_sql         STRING
DEFINE l_rah         RECORD LIKE rah_file.*
DEFINE l_rai         DYNAMIC ARRAY OF RECORD LIKE rai_file.*
DEFINE l_rai1        RECORD LIKE rai_file.*
DEFINE l_rxc         RECORD LIKE rxc_file.*
DEFINE l_rxc06       LIKE rxc_file.rxc06
DEFINE l_rai04       LIKE rai_file.rai04
DEFINE l_n           LIKE type_file.num5
DEFINE l_m           LIKE type_file.num5
DEFINE l_no          LIKE oea_file.oea01
DEFINE l_fg          LIKE type_file.chr1
DEFINE l_line        LIKE oeb_file.oeb03 
DEFINE l_sub         LIKE type_file.num5 
DEFINE l_rap06       LIKE rap_file.rap06
DEFINE l_rap07       LIKE rap_file.rap07
DEFINE l_rap08       LIKE rap_file.rap08
DEFINE l_price2      LIKE rai_file.rai05
DEFINE l_price3      LIKE rai_file.rai06
DEFINE l_price21     DYNAMIC ARRAY OF LIKE rai_file.rai05
DEFINE l_price31     DYNAMIC ARRAY OF LIKE rai_file.rai06
DEFINE l_item        LIKE tqn_file.tqn03
##--FUN-B30045-- MARK -- BEGIN ---------------------
#DEFINE l_qty         LIKE type_file.num5
#DEFINE l_qty1        LIKE type_file.num5 
#DEFINE l_qty2        LIKE type_file.num5
##--FUN-B30045-- MARK --  END  ---------------------
##--FUN-B30045-- ADD  -- BEGIN ---------------------
DEFINE l_qty         LIKE oeb_file.oeb12
DEFINE l_qty1        LIKE oeb_file.oeb12
DEFINE l_qty2        LIKE oeb_file.oeb12
##--FUN-B30045-- ADD  --  END  ---------------------
DEFINE l_type        LIKE type_file.chr1
DEFINE p_flg1        LIKE type_file.chr1
DEFINE l_amt         LIKE type_file.num5
DEFINE l_amt1        DYNAMIC ARRAY OF LIKE type_file.num5
DEFINE l_price       LIKE oeb_file.oeb13
DEFINE l_rtu01       LIKE rtu_file.rtu01
DEFINE l_rtv02       LIKE rtv_file.rtv02
DEFINE l_rtv13       LIKE rtv_file.rtv13
DEFINE l_rtu05       LIKE rtu_file.rtu05 
DEFINE l_lpj11       LIKE lpj_file.lpj11
DEFINE l_lpk10       LIKE lpk_file.lpk10
DEFINE l_rtz11       LIKE rtz_file.rtz11
DEFINE l_plant       LIKE azp_file.azp01
DEFINE l_rah01       LIKE rah_file.rah01
DEFINE l_rah02       LIKE rah_file.rah02
DEFINE l_rah03       LIKE rah_file.rah03
DEFINE l_flg1        LIKE type_file.chr1
DEFINE l_flg2        LIKE type_file.chr1 
DEFINE q_item        LIKE ima_file.ima01 
DEFINE l_cx_no       LIKE rab_file.rab02  
DEFINE l_rtu07       LIKE rtu_file.rtu07     #FUN-B10024
DEFINE l_rtu08       LIKE rtu_file.rtu08     #FUN-B10024 
DEFINE l_rxd         RECORD LIKE rxd_file.*  #FUN-B30012 ADD
### -MOD-B20087- ADD - BEGIN --------------------------------
DEFINE l_lpj02       LIKE lpj_file.lpj02
DEFINE l_lph04       LIKE lph_file.lph04
DEFINE l_lph36       LIKE lph_file.lph36
### -MOD-B20087- ADD -  END  --------------------------------
#剩余数量>0，才可以走下面的逻辑
    LET l_cnt = 0
    LET l_cnt1 = 0
    LET l_cnt2 = 0
    SELECT COUNT(*) INTO l_cnt1 FROM s_price_c2 
    WHERE qty2 > 0
    SELECT COUNT(*) INTO l_cnt2 FROM s_price_c2_1 
    WHERE qty2 > 0
    LET l_cnt = l_cnt1 + l_cnt2
    IF l_cnt = 0 THEN RETURN END IF
    LET l_time = TIME
    LET l_sql1 = "SELECT DISTINCT rah_file.*,raq06,raq07 ",
                 "  FROM ",cl_get_target_table(g_plant_new,'rah_file'),",",
                           cl_get_target_table(g_plant_new,'rai_file'),",",
                           cl_get_target_table(g_plant_new,'raq_file'),
                 " WHERE rah01 = rai01 AND rah02 = rai02",
                 "   AND rah01 = raq01 AND rah02 = raq02",
                 "   AND rahplant=raiplant AND rahplant=raqplant",
                 "   AND raq03 = '3' AND raq04 = '",p_plant,"'",
                 "   AND raq05 = 'Y'",                                           #MOD-B20087  ADD
                 "   AND ((rah04 < '",p_date,"' AND rah05 > '",p_date,"')",
                 "    OR (rah04 = '",p_date,"' AND rah06 <= '",l_time,"')",
                 "    OR (rah05 = '",p_date,"' AND rah07 >= '",l_time,"'))",
                 "   AND rahacti = 'Y' AND rahconf = 'Y' ",
                 "   AND raqacti = 'Y'  ",            #FUN-B10024
                 " ORDER BY raq06 DESC,raq07 DESC "   #By shi
         #       " ORDER BY rah02 DESC "
         #       " ORDER BY rah901,rah902 DESC "
    CALL cl_replace_sqldb(l_sql1) RETURNING l_sql1              							
    CALL cl_parse_qry_sql(l_sql1,g_plant_new) RETURNING l_sql1           
    PREPARE s_sel_rah_pre FROM l_sql1
    DECLARE s_sel_rah_cs CURSOR FOR s_sel_rah_pre
    FOREACH s_sel_rah_cs INTO l_rah.*
#更新本次消耗数量为0
       UPDATE s_price_c2 SET qty1 = 0
       IF STATUS THEN
          CALL cl_err("upd s_price_c2",STATUS,1) 
          LET g_success = 'N'
          RETURN
       END IF
       SELECT rtz11 INTO l_rtz11 FROM rtz_file WHERE rtz01=p_plant
       IF l_rtz11='Y' THEN 
          LET g_plant_new = p_plant
       ELSE
          LET g_plant_new = l_rah.rah01
       END IF 
       CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87   
       IF l_rah.rah13 = 'Y'  AND  l_oea87 IS NULL THEN 
          CONTINUE FOREACH 
       END IF
#算出剩余数量部分 达到多少金额
       LET l_amt = 0 
       LET l_sql = "SELECT '1',line,item,price,qty2,'' ",
                   "  FROM s_price_c2",
                   " WHERE qty2 > 0",
                   " UNION ",
                   "SELECT '2',line,item,price,qty2,cx_no ",
                   "  FROM s_price_c2_1",
                   " WHERE qty2 > 0 AND flg2 = 'Y' "
       PREPARE s_fetch_price_c2_prepare4 FROM l_sql                                                
       DECLARE s_fetch_price_c2_curs4 CURSOR FOR s_fetch_price_c2_prepare4   
       FOREACH s_fetch_price_c2_curs4 INTO l_fg,l_line,l_item,l_price,l_qty2,l_cx_no
           IF SQLCA.sqlcode != 0 THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF 
           IF l_rah.rah11 = '2' THEN
              IF NOT s_fetch_price_chk('3',l_rah.rah01,l_rah.rah02,'',g_plant_new,l_item ) THEN
                  CONTINUE FOREACH
              END IF
           END IF
###-MOD-B30045- ADD - BEGIN --------------------------------------------------
           CASE l_rah.rah25
              WHEN "1"
###-MOD-B30045- ADD -  END  --------------------------------------------------
                 LET l_amt = l_amt+l_price * l_qty2 # 滿足滿額促銷數量，達到的金額數
###-MOD-B30045- ADD - BEGIN --------------------------------------------------
              WHEN "2"
                 LET l_amt = l_amt + l_qty2   # 滿足滿額促銷的數量
           END CASE
###-MOD-B30045- ADD -  END  --------------------------------------------------
           CASE l_fg
              WHEN '1'
                 UPDATE s_price_c2   SET qty1 = l_qty2  WHERE item = l_item AND line = l_line
              WHEN '2'
                 UPDATE s_price_c2_1  SET qty1 = l_qty2  WHERE item = l_item AND line = l_line AND cx_no = l_cx_no
           END CASE   
       END FOREACH
       LET l_sql2 = "SELECT MAX(rai04) ",	
                    "  FROM ",cl_get_target_table(g_plant_new,'rai_file'),	
                    " WHERE rai01 = '",l_rah.rah01,"' AND rai02 = '",l_rah.rah02,"'",	
                    "   AND raiplant = '",g_plant_new,"'",	
                    "   AND rai04 <=  '",l_amt,"' AND raiacti = 'Y' "    #FUN-B10024
       CALL cl_replace_sqldb(l_sql2) RETURNING l_sql2              							
       CALL cl_parse_qry_sql(l_sql2,g_plant_new) RETURNING l_sql2              
       PREPARE pre_del_rai FROM l_sql2
       EXECUTE pre_del_rai INTO l_rai04          
       IF STATUS = 100 THEN	
          CONTINUE FOREACH	
       END IF	
       LET l_cnt = 1
 #     LET  i = 1
       IF l_rah.rah12 = 'Y' THEN
          LET l_sql = "SELECT * ",
                      "  FROM ",cl_get_target_table(g_plant_new,'rai_file'),
                      " WHERE rai01 = '",l_rah.rah01,"' AND rai02 = '",l_rah.rah02,"'",
                      "   AND raiplant = '",g_plant_new,"'",
                      "   AND rai04 <= '",l_amt,"'  AND raiacti = 'Y' ",     #FUN-B10024
                      "   ORDER BY rai04 "
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql          
          PREPARE s_sel_rai_pre FROM l_sql
          DECLARE s_sel_rai_cs CURSOR FOR s_sel_rai_pre
          FOREACH s_sel_rai_cs INTO l_rai[l_cnt].* 
              IF l_rai[l_cnt].rai07 = 'Y' THEN	
#按照会员等级设置	
                 LET l_sql = "SELECT lpk10 ",
                             "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
                                       cl_get_target_table(g_plant_new,'lpj_file'),
                             " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
                 PREPARE pre_del_lpk10 FROM l_sql
                 EXECUTE pre_del_lpk10 INTO l_lpk10
                 LET l_sql = "SELECT rap06,rap07,rap08 ",
                             "  FROM ",cl_get_target_table(g_plant_new,'rap_file'),
                             " WHERE rap01='",l_rah.rah01,"' AND rap02='",l_rah.rah02,"'  ",
                             " AND rapplant='",l_rah.rahplant,"' AND rap05='",l_lpk10,"' AND rapacti='Y' AND rap03='3' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
                 PREPARE pre_del_rap03 FROM l_sql
                 EXECUTE pre_del_rap03 INTO l_rap06,l_rap07,l_rap08
                 IF STATUS = 100 THEN             #取一般的特卖价、折扣率、折让金额 
                     LET l_rap07 = l_rai[l_cnt].rai05
                     LET l_rap08 = l_rai[l_cnt].rai06
                 END IF 
### -MOD-B20087- ADD - BEGIN ----------------------------------------
###-取一般的特卖价、折扣率、折让金额-###
                 IF l_oea87 IS NOT NULL  THEN
                    INITIALIZE l_lpj02,l_lph04 TO NULL
                    SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                    SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
                    IF l_lph04 <> 'Y' THEN
                       LET l_rap07 = l_rai[l_cnt].rai05
                       LET l_rap08 = l_rai[l_cnt].rai06
                    END IF
                 END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
                 CASE l_rah.rah10
                    WHEN '2'   
                       LET l_price21[l_cnt] = l_rap07
                    WHEN '3'   
                       LET l_price31[l_cnt] = l_rap08
                 END CASE
              ELSE	
                 IF l_oea87 IS NOT NULL  THEN
### -MOD-B20087- ADD - BEGIN ----------------------------------------
                    INITIALIZE l_lpj02,l_lph04 TO NULL
                    SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                    SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
                    IF l_lph04 = 'Y' THEN
### -MOD-B20087- ADD -  END  ----------------------------------------
                       CASE l_rah.rah10
                          WHEN '2'   
                             LET l_price21[l_cnt] = l_rai[l_cnt].rai08
                          WHEN '3'   
                             LET l_price31[l_cnt] = l_rai[l_cnt].rai09
                       END CASE
### -MOD-B20087- ADD - BEGIN ----------------------------------------
                    ELSE
                       CASE l_rah.rah10
                          WHEN '2'   
                             LET l_price21[l_cnt] = l_rai[l_cnt].rai05
                          WHEN '3'   
                             LET l_price31[l_cnt] = l_rai[l_cnt].rai06
                       END CASE
                    END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
                 ELSE
                    CASE l_rah.rah10
                       WHEN '2'   
                          LET l_price21[l_cnt] = l_rai[l_cnt].rai05
                       WHEN '3'   
                          LET l_price31[l_cnt] = l_rai[l_cnt].rai06
                    END CASE    
                 END IF  
              END IF
              LET l_cnt = l_cnt + 1  
  #           LET i = i + 1
          END FOREACH	
       ELSE
          LET l_sql = "SELECT * ",	
                      "  FROM ",cl_get_target_table(g_plant_new,'rai_file'),	
                      " WHERE rai01 = '",l_rah.rah01,"' AND rai02 = '",l_rah.rah02,"'",	
                      "   AND raiplant = '",g_plant_new,"' ",	
                      "   AND rai04 = '",l_rai04,"'  AND raiacti = 'Y' "    #FUN-B10024
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
          PREPARE pre_del_rai1 FROM l_sql
          EXECUTE pre_del_rai1 INTO l_rai1.*
          IF l_rai[l_cnt].rai07 = 'Y' THEN	
         #按照会员等级设置	
             LET l_sql = "SELECT lpk10 ",
                         "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
                                   cl_get_target_table(g_plant_new,'lpj_file'),
                         " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"'"
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
             PREPARE pre_del_lpk03 FROM l_sql
             EXECUTE pre_del_lpk03 INTO l_lpk10
             LET l_sql = "SELECT rap06,rap07,rap08 ",
                         "  FROM ",cl_get_target_table(g_plant_new,'rap_file'),
                         " WHERE rap01='",l_rah.rah01,"' AND rap02='",l_rah.rah02,"'  ",
                         " AND rapplant='",l_rah.rahplant,"' AND rap05='",l_lpk10,"' AND rapacti='Y' AND rap03='3' "
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
             PREPARE pre_del_rap04 FROM l_sql
             EXECUTE pre_del_rap04 INTO l_rap06,l_rap07,l_rap08
             IF STATUS = 100 THEN             #取一般的特卖价、折扣率、折让金额 
                 LET l_rap07 = l_rai1.rai05
                 LET l_rap08 = l_rai1.rai06
             END IF	
             CASE l_rah.rah10
                WHEN '2'   
                    LET l_price2 = l_rap07
                WHEN '3'   
                    LET l_price3 = l_rap08
             END CASE
          ELSE	
             IF  l_oea87 IS NOT NULL  THEN
### -MOD-B20087- ADD - BEGIN ----------------------------------------
                INITIALIZE l_lpj02,l_lph04 TO NULL
                SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                SELECT lph04 INTO l_lph04 FROM lph_file WHERE lph01 = l_lpj02
                IF l_lph04 = 'Y' THEN
### -MOD-B20087- ADD -  END  ----------------------------------------
                   CASE l_rah.rah10
                      WHEN '2'   
                         LET l_price2 = l_rai1.rai08
                      WHEN '3'   
                         LET l_price3 = l_rai1.rai09
                   END CASE
### -MOD-B20087- ADD - BEGIN ----------------------------------------
                ELSE
                   CASE l_rah.rah10
                      WHEN '2'
                         LET l_price2 = l_rai1.rai05
                      WHEN '3'
                         LET l_price3 = l_rai1.rai06
                   END CASE
                END IF
### -MOD-B20087- ADD -  END  ----------------------------------------
             ELSE
                CASE l_rah.rah10
                   WHEN '2'   
                      LET l_price2 = l_rai1.rai05
                   WHEN '3'   
                      LET l_price3 = l_rai1.rai06
                END CASE    
             END IF  
          END IF
       END IF  
       LET l_sql = "SELECT count(*) ",
                   "  FROM ",cl_get_target_table(g_plant_new,'rai_file'),
                   " WHERE rai01 = '",l_rah.rah01,"' AND rai02 = '",l_rah.rah02,"'",
                   "   AND raiplant = '",g_plant_new,"'",
                   "   AND rai04 <= '",l_amt,"' AND raiacti = 'Y' ", #FUN-B10024
                   "  order by rai04 "
       CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
       CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql          
       PREPARE s_sel_rai01_pre FROM l_sql
       EXECUTE s_sel_rai01_pre INTO l_n
       IF l_n = 0 THEN 
          UPDATE s_price_c2    SET qty1 = 0  WHERE item = l_item AND line = l_line
          UPDATE s_price_c2_1  SET qty1 = 0  WHERE item = l_item AND line = l_line 
          CONTINUE FOREACH
       END IF   
       LET l_sub = 0
       LET l_sql = "SELECT '1',line,item,price,qty1,qty2,'N','','' ",
                   "  FROM s_price_c2 ",
                   " WHERE qty2 > 0 AND qty1 > 0 ",
                   " UNION ",
                   "SELECT '2',line,item,price,qty1,qty2,flg1,type,cx_no ",
                   "  FROM s_price_c2_1 ",
                   " WHERE qty2 > 0 AND qty1 > 0 "
       PREPARE s_fetch_price_c2_prepare5 FROM l_sql                                                
       DECLARE s_fetch_price_c2_curs5 CURSOR FOR s_fetch_price_c2_prepare5   
       FOREACH s_fetch_price_c2_curs5 INTO l_fg,l_line,l_item,l_price,l_qty1,l_qty2,l_flg1,l_type,l_cx_no
          IF SQLCA.sqlcode != 0 THEN
             CALL cl_err('foreach:',SQLCA.sqlcode,1)
             EXIT FOREACH
          END IF      
          IF  l_rah.rah12 = 'Y' THEN
              CASE l_rah.rah10 
                 WHEN '2'
                    LET l_sub = 0
                    FOR l_cnt=1 TO l_n-1
                       LET l_sub = (l_rai[l_cnt+1].rai04 - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100) +l_sub
                    END FOR
                    LET l_cnt = l_n
                    LET l_sub = (l_amt - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100) +l_sub
                    LET l_rxc06 = l_sub*l_price*l_qty1/l_amt 
                 WHEN '3'
                    LET l_sub = 0 
                    FOR l_cnt=1 TO l_n
                       LET l_sub = l_price31[l_cnt]+l_sub
                    END FOR
                    LET l_rxc06 = l_sub*l_price*l_qty1/l_amt
               END CASE
            ELSE
               CASE l_rah.rah10 
                  WHEN '2'
                     LET  l_rxc06 = (1-l_price2/100)*l_price*l_qty1
                  WHEN '3'
                     LET  l_rxc06 = l_price3*l_price*l_qty1/l_amt
               END CASE
            END IF 
###-MOD-B20087- MARK - BEGIN -----------------------------------------------------------
###-MARK掉原來會員卡折扣部份-###
#           CASE l_fg
#              WHEN '1'
#                 IF l_rah.rah18 = 'Y'  AND l_oea87 IS NOT NULL THEN     #  在原折扣的基础上加上会员卡的折扣
#                 #  LET l_sql = "SELECT lpj11 ",
#                 #              "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
#                 #               cl_get_target_table(g_plant_new,'lpj_file'),
#                 #               " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
#                 #  CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
#                 #  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
#                 #  PREPARE pre_del_lpk09 FROM l_sql
#                 #  EXECUTE pre_del_lpk09 INTO l_lpj11
#                 #  IF cl_null(l_lpj11) THEN 
#                 #     LET l_lpj11 = 100
#                 #  END IF
#                    CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11      #MOD-B20078
#                    IF l_rah.rah12 = 'Y' THEN
#                       CASE l_rah.rah10 
#                          WHEN '2'
#                             LET l_sub = 0
#                             FOR l_cnt=1 TO l_n-1
#                                LET l_sub = (l_rai[l_cnt+1].rai04 - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100*l_lpj11/100) +l_sub
#                             END FOR
#                             LET l_cnt = l_n
#                             LET l_sub = (l_amt - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100*l_lpj11/100) +l_sub
#                             LET l_rxc06 = l_sub*l_price*l_qty1/l_amt 
#                          WHEN '3'
#                             LET l_sub = 0
#                             FOR l_cnt=1 TO l_n
#                                LET l_sub = l_price31[l_cnt]+l_sub
#                             END FOR
#                             LET l_rxc06 = l_price*l_qty1-(l_price*l_qty1-l_sub*l_price*l_qty1/l_amt)*l_lpj11/100
#                             END CASE
#                    ELSE
#                       CASE l_rah.rah10 
#                          WHEN '2'
#                             LET  l_rxc06 = (1-l_price2/100*l_lpj11/100)*l_price*l_qty1
#                          WHEN '3'
#                             LET  l_rxc06 = l_price*l_qty1-(l_price*l_qty1-l_price3*l_price*l_qty1/l_amt)*l_lpj11/100
#                       END CASE
#                    END IF
#                 END IF   
#              WHEN '2'     
#                 IF (l_type = '' OR l_flg1 = 'Y') AND l_rah.rah18 = 'Y' AND l_oea87 IS NOT NULL THEN     #  在原折扣的基础上加上会员卡的折扣
#                  # LET l_sql = "SELECT lpj11 ",
#                  #             "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
#                  #              cl_get_target_table(g_plant_new,'lpj_file'),
#                  #              " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
#                  # CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
#                  # CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
#                  # PREPARE pre_del_lpk05 FROM l_sql
#                  # EXECUTE pre_del_lpk05 INTO l_lpj11
#                  # IF cl_null(l_lpj11) THEN 
#                  #    LET l_lpj11 = 100
#                  # END IF
#                    CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11      #MOD-B20078
#                    IF l_rah.rah12 = 'Y' THEN
#                       CASE l_rah.rah10 
#                          WHEN '2'
#                             LET l_sub = 0
#                             FOR l_cnt=1 TO l_n-1
#                                LET l_sub = (l_rai[l_cnt+1].rai04 - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100*l_lpj11/100) +l_sub
#                             END FOR
#                             LET l_cnt = l_n
#                             LET l_sub = (l_amt - l_rai[l_cnt].rai04)*(1-l_price21[l_cnt]/100*l_lpj11/100) +l_sub
#                             LET l_rxc06 = l_sub*l_price*l_qty1/l_amt 
#                          WHEN '3'
#                             LET l_sub = 0
#                             FOR l_cnt=1 TO l_n
#                                LET l_sub = l_price31[l_cnt]+l_sub
#                             END FOR
#                             LET l_rxc06 = l_price*l_qty1-(l_price*l_qty1-l_sub*l_price*l_qty1/l_amt)*l_lpj11/100
#                          END CASE
#                    ELSE
#                       CASE l_rah.rah10 
#                          WHEN '2'
#                             LET  l_rxc06 = (1-l_price2/100*l_lpj11/100)*l_price*l_qty1
#                          WHEN '3'
#                             LET  l_rxc06 = l_price*l_qty1-(l_price*l_qty1-l_price3*l_price*l_qty1/l_amt)*l_lpj11/100
#                       END CASE
#                    END IF 
#                 END IF
#           END CASE      
###-MOD-B20087- MARK -  END  ------------------------------------------------------------------
            LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                        "   WHERE rxc01 = '",p_no,"' ",
                        "   AND  rxc02 = '",l_line,"' AND rxc03 = '03' AND  rxc04 = '",l_rah.rah02,"' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
            PREPARE pre_sel_rxc15 FROM l_sql
            EXECUTE pre_sel_rxc15 INTO l_m
            IF l_m > 0 THEN
               UPDATE rxc_file SET rxc06 = rxc06 + l_rxc06,
                                   rxc15 = rxc15 + l_qty1
               WHERE rxc01 = p_no AND  rxc02 = l_line AND rxc03 = '03' AND  rxc04 = l_rah.rah02
               CASE l_fg
                  WHEN '1'
                     UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                  WHEN '2'
                     UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND  cx_no = l_cx_no
               END CASE
            ELSE  
               IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
               IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
               IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
               LET l_sql = "SELECT rtu01,rtv02,rtv13,rtu05,rtu07,rtu08  FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", 
                                                                 cl_get_target_table(g_plant_new,'rtv_file'),    
                           " WHERE rtu01=rtv01 AND rtu02 = rtv02  ",     
                         # "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                           "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 ",           #FUN-B10024 
                           "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
                           "   AND rtuplant = rtvplant AND rtuplant = '",g_plant_new,"'"
               CALL cl_replace_sqldb(l_sql) RETURNING l_sql             							
               CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
               PREPARE pre_sel5_rtv13 FROM l_sql
               EXECUTE pre_sel5_rtv13 INTO l_rtu01,l_rtv02,l_rtv13,l_rtu05,l_rtu07,l_rtu08   #FUN-B10024 
               IF cl_null(l_rtv13) OR l_rtv13 = 0 OR (l_rtu07<>'3' OR (l_rtu07='3' AND l_rtu08<>l_rah.rah02)) THEN  #FUN-B10024
                  LET l_sql = "SELECT A.rto01,A.rto03,A.rto05,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'),
                              "   WHERE A.rto05 = '",l_rtu05,"'",
                              "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                              "     AND A.rtoplant = '",g_plant_new,"'",
                              "     AND A.rtoconf = 'Y' ",
                              "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), 
                              "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant) "
                  CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
                  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
                  PREPARE pre_sel_rto12 FROM l_sql
                  EXECUTE pre_sel_rto12 INTO l_rtu01,l_rtv02,l_rtu05,l_rtv13
               END IF
               IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
               LET l_rxc.rxc01 = p_no
               LET l_rxc.rxc02 = l_line
               LET l_rxc.rxc03 = '03'
               LET l_rxc.rxc04 = l_rah.rah02
               LET l_rxc.rxc05 = ''
               IF p_type = '1' THEN
                  SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
                  SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                  WHERE azi01=g_oea.oea23
               END IF
               IF p_type = '2' THEN
                  SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
                  SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                  WHERE azi01=g_oga.oga23
               END IF
               IF p_type = '3' THEN
                  SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
                  SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                  WHERE azi01=g_oha.oha23
               END IF
               CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
               LET l_rxc.rxc06 = l_rxc06   
               LET l_rxc.rxc07 = l_rtv13
               LET l_rxc.rxc08 = ''
               LET l_rxc.rxc09 = 0
               LET l_rxc.rxc10 = 0
               LET l_rxc.rxc11 = g_member   #是否會員
               LET l_rxc.rxc12 = l_rtv02
               LET l_rxc.rxc13 = l_rtu05
               LET l_rxc.rxc14 = l_rtu01
               LET l_rxc.rxcplant = p_plant
               LET l_rxc.rxc15 = l_qty1
               SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new
               LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",   
                           "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                           "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                           "rxc12,rxc13,rxc14,rxc15) ",
                           "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
               CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
               CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
               PREPARE pre_ins_rxc142 FROM l_sql
               EXECUTE pre_ins_rxc142 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, 
                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
               IF SQLCA.SQLCODE THEN 
                  CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
               END IF
               CASE l_fg
                 WHEN '1'
                    UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                 WHEN '2'
                    UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND cx_no = l_cx_no
               END CASE
            END IF   
###-MOD-B20087- ADD - BEGIN --------------------------------------------------------------
###-添加新的會員卡折扣邏輯-###
            CASE l_fg
               WHEN '1'
                  IF l_rah.rah18 = 'Y'  AND l_oea87 IS NOT NULL THEN
                     INITIALIZE l_lpj02,l_lph36 TO NULL
                     SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                     SELECT lph36 INTO l_lph36 FROM lph_file WHERE lph01 = l_lpj02
                     IF l_lph36 = 'Y' THEN
                        CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11
                        LET l_rxc06 = (l_price*l_qty1 - l_rxc06)*(1 - l_lpj11/100)
                        CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
                        LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                                    "   WHERE rxc01 = '",p_no,"' ",
                                    "   AND  rxc02 = '",l_line,"' AND rxc03 = '12' AND  rxc04 = '",l_rah.rah02,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                        PREPARE pre_sel_rxc_p1 FROM l_sql
                        EXECUTE pre_sel_rxc_p1 INTO l_m
                        IF l_m > 0 THEN
                           UPDATE rxc_file SET rxc06 = rxc06 + l_rxc06,
                                               rxc15 = rxc15 + l_qty1
                           WHERE rxc01 = p_no AND  rxc02 = l_line AND rxc03 = '12' AND  rxc04 = l_rah.rah02
                           CASE l_fg
                              WHEN '1'
                                 UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                              WHEN '2'
                                 UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND  cx_no = l_cx_no
                           END CASE
                        ELSE
                           IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
                           IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
                           IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
                           LET l_sql = "SELECT rtu01,rtv02,rtv13,rtu05,rtu07,rtu08  FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",",
                                                                                           cl_get_target_table(g_plant_new,'rtv_file'),
                                       " WHERE rtu01=rtv01 AND rtu02 = rtv02  ",
                                       "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 ",           #FUN-B10024
                                       "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
                                       "   AND rtuplant = rtvplant AND rtuplant = '",g_plant_new,"'"
                           CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                           PREPARE pre_sel_rtv13_p1 FROM l_sql
                           EXECUTE pre_sel_rtv13_p1 INTO l_rtu01,l_rtv02,l_rtv13,l_rtu05,l_rtu07,l_rtu08   #FUN-B10024
                           IF cl_null(l_rtv13) OR l_rtv13 = 0 OR (l_rtu07<>'3' OR (l_rtu07='3' AND l_rtu08<>l_rah.rah02)) THEN  #FUN-B10024
                              LET l_sql = "SELECT A.rto01,A.rto03,A.rto05,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'),
                                          "   WHERE A.rto05 = '",l_rtu05,"'",
                                          "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                                          "     AND A.rtoplant = '",g_plant_new,"'",
                                          "     AND A.rtoconf = 'Y' ",
                                          "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '),
                                          "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant) "
                              CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                              PREPARE pre_sel_rto12_p1 FROM l_sql
                              EXECUTE pre_sel_rto12_p1 INTO l_rtu01,l_rtv02,l_rtu05,l_rtv13
                           END IF
                           IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
                           LET l_rxc.rxc01 = p_no
                           LET l_rxc.rxc02 = l_line
                           LET l_rxc.rxc03 = '12'
                           LET l_rxc.rxc04 = l_rah.rah02
                           LET l_rxc.rxc05 = ''
                           IF p_type = '1' THEN
                              SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oea.oea23
                           END IF
                           IF p_type = '2' THEN
                              SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oga.oga23
                           END IF
                           IF p_type = '3' THEN
                              SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oha.oha23
                           END IF
                           CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
                           LET l_rxc.rxc06 = l_rxc06
                           LET l_rxc.rxc07 = l_rtv13
                           LET l_rxc.rxc08 = ''
                           LET l_rxc.rxc09 = 0
                           LET l_rxc.rxc10 = 0
                           LET l_rxc.rxc11 = g_member   #是否會員
                           LET l_rxc.rxc12 = l_rtv02
                           LET l_rxc.rxc13 = l_rtu05
                           LET l_rxc.rxc14 = l_rtu01
                           LET l_rxc.rxcplant = p_plant
                           LET l_rxc.rxc15 = l_qty1
                           SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new
                           LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",
                                       "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                                       "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                                       "rxc12,rxc13,rxc14,rxc15) ",
                                       "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
                           CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                           PREPARE pre_ins_rxc_p3 FROM l_sql
                           EXECUTE pre_ins_rxc_p3 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,
                                                        l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                                                        l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                                                        l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
                           IF SQLCA.SQLCODE THEN
                              CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
                           END IF
                           CASE l_fg
                             WHEN '1'
                                UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                             WHEN '2'
                                UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND cx_no = l_cx_no
                           END CASE
                        END IF
                     END IF
                  END IF
               WHEN '2'
                  IF (l_type = '' OR l_flg1 = 'Y') AND l_rah.rah18 = 'Y' AND l_oea87 IS NOT NULL THEN
                     INITIALIZE l_lpj02,l_lph36 TO NULL
                     SELECT lpj02 INTO l_lpj02 FROM lpj_file WHERE lpj03 = l_oea87
                     SELECT lph36 INTO l_lph36 FROM lph_file WHERE lph01 = l_lpj02
                     IF l_lph36 = 'Y' THEN
                        CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11
                        LET l_rxc06 = (l_price*l_qty1 - l_rxc06)*(1 - l_lpj11/100)
                        CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
                        LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                                    "   WHERE rxc01 = '",p_no,"' ",
                                    "   AND  rxc02 = '",l_line,"' AND rxc03 = '12' AND  rxc04 = '",l_rah.rah02,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                        PREPARE pre_sel_rxc_p2 FROM l_sql
                        EXECUTE pre_sel_rxc_p2 INTO l_m
                        IF l_m > 0 THEN
                           UPDATE rxc_file SET rxc06 = rxc06 + l_rxc06,
                                               rxc15 = rxc15 + l_qty1
                           WHERE rxc01 = p_no AND  rxc02 = l_line AND rxc03 = '12' AND  rxc04 = l_rah.rah02
                           CASE l_fg
                              WHEN '1'
                                 UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                              WHEN '2'
                                 UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND  cx_no = l_cx_no
                           END CASE
                        ELSE
                           IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
                           IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
                           IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
                           LET l_sql = "SELECT rtu01,rtv02,rtv13,rtu05,rtu07,rtu08  FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",",
                                                                                           cl_get_target_table(g_plant_new,'rtv_file'),
                                       " WHERE rtu01=rtv01 AND rtu02 = rtv02  ",
                                       "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 ",           #FUN-B10024
                                       "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
                                       "   AND rtuplant = rtvplant AND rtuplant = '",g_plant_new,"'"
                           CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                           PREPARE pre_sel_rtv13_p2 FROM l_sql
                           EXECUTE pre_sel_rtv13_p2 INTO l_rtu01,l_rtv02,l_rtv13,l_rtu05,l_rtu07,l_rtu08   #FUN-B10024
                           IF cl_null(l_rtv13) OR l_rtv13 = 0 OR (l_rtu07<>'3' OR (l_rtu07='3' AND l_rtu08<>l_rah.rah02)) THEN  #FUN-B10024
                              LET l_sql = "SELECT A.rto01,A.rto03,A.rto05,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'),
                                          "   WHERE A.rto05 = '",l_rtu05,"'",
                                          "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                                          "     AND A.rtoplant = '",g_plant_new,"'",
                                          "     AND A.rtoconf = 'Y' ",
                                          "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '),
                                          "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant) "
                              CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                              PREPARE pre_sel_rto12_p2 FROM l_sql
                              EXECUTE pre_sel_rto12_p2 INTO l_rtu01,l_rtv02,l_rtu05,l_rtv13
                           END IF
                           IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
                           LET l_rxc.rxc01 = p_no
                           LET l_rxc.rxc02 = l_line
                           LET l_rxc.rxc03 = '12'
                           LET l_rxc.rxc04 = l_rah.rah02
                           LET l_rxc.rxc05 = ''
                           IF p_type = '1' THEN
                              SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oea.oea23
                           END IF
                           IF p_type = '2' THEN
                              SELECT * INTO g_oga.* FROM oga_file WHERE oga01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oga.oga23
                           END IF
                           IF p_type = '3' THEN
                              SELECT * INTO g_oha.* FROM oha_file WHERE oha01 = p_no
                              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                              WHERE azi01=g_oha.oha23
                           END IF
                           CALL cl_digcut(l_rxc06,t_azi04) RETURNING l_rxc06
                           LET l_rxc.rxc06 = l_rxc06
                           LET l_rxc.rxc07 = l_rtv13
                           LET l_rxc.rxc08 = ''
                           LET l_rxc.rxc09 = 0
                           LET l_rxc.rxc10 = 0
                           LET l_rxc.rxc11 = g_member   #是否會員
                           LET l_rxc.rxc12 = l_rtv02
                           LET l_rxc.rxc13 = l_rtu05
                           LET l_rxc.rxc14 = l_rtu01
                           LET l_rxc.rxcplant = p_plant
                           LET l_rxc.rxc15 = l_qty1
                           SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = g_plant_new
                           LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(",
                                       "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
                                       "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
                                       "rxc12,rxc13,rxc14,rxc15) ",
                                       "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"
                           CALL cl_replace_sqldb(l_sql) RETURNING l_sql
                           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
                           PREPARE pre_ins_rxc_p4 FROM l_sql
                           EXECUTE pre_ins_rxc_p4 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,
                                                        l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
                                                        l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
                                                        l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15
                           IF SQLCA.SQLCODE THEN
                              CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
                           END IF
                           CASE l_fg
                             WHEN '1'
                                UPDATE s_price_c2   SET qty2 = 0  WHERE item = l_item AND line = l_line
                             WHEN '2'
                                UPDATE s_price_c2_1 SET qty2 = 0  WHERE item = l_item  AND line = l_line AND cx_no = l_cx_no
                           END CASE
                        END IF
                     END IF
                  END IF
            END CASE
###-MOD-B20087- ADD -  END  --------------------------------------------------------------
         END FOREACH       
####-FUN-B30012--ADD----BEGIN------------------------------------------------
####換贈的條件下新增一筆資料到rxd_file####
         IF l_rah.rah19 = 'Y' THEN
            IF p_type = '1' THEN LET l_rxd.rxd00 = '01' END IF
            IF p_type = '2' THEN LET l_rxd.rxd00 = '02' END IF
            IF p_type = '3' THEN LET l_rxd.rxd00 = '03' END IF
            LET l_rxd.rxd01 = p_no
            LET l_rxd.rxd02 = '3'
            LET l_rxd.rxd03 = l_rah.rah02
            LET l_rxd.rxd04 = l_amt
            LET l_rxd.rxd05 = 0
            LET l_rxd.rxdplant = p_plant
            SELECT azw02 INTO l_rxd.rxdlegal FROM azw_file WHERE azw01 = g_plant_new
            LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxd_file'),"(",
                        "rxd00,rxd01,rxd02,rxd03,rxd04,rxd05,",
                        "rxdplant,rxdlegal) ",    
                        "VALUES(?,?,?,?,?,?,?,?)"   
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
            PREPARE pre_ins_rxd_3 FROM l_sql            
            EXECUTE pre_ins_rxd_3 USING l_rxd.rxd00,l_rxd.rxd01,l_rxd.rxd02,l_rxd.rxd03, 
                                        l_rxd.rxd04,l_rxd.rxd05, 
                                        l_rxd.rxdplant,l_rxd.rxdlegal 
            IF SQLCA.SQLCODE THEN
               CALL cl_err('ins rxd',SQLCA.SQLCODE,1)
            END IF
         END IF
####-FUN-B30012--ADD-----END-------------------------------------------------
     END FOREACH
     IF NOT cl_null(l_oea87)  THEN
      # LET l_sql = "SELECT lpj11 ",
      #             "  FROM ",cl_get_target_table(g_plant_new,'lpk_file'),",",
      #                           cl_get_target_table(g_plant_new,'lpj_file'),
      #             " WHERE lpk01=lpj01 AND lpj03 = '",l_oea87,"' "
      # CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      # CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
      # PREPARE pre_del_lpk04 FROM l_sql
      # EXECUTE pre_del_lpk04 INTO l_lpj11
      # IF cl_null(l_lpj11) THEN 
      #    LET l_lpj11 = 100
      # END IF
        CALL s_discount_amt1(l_oea87,p_item) RETURNING  l_lpj11      #MOD-B20078
        LET l_sql ="SELECT no,line,cx_no,item,price,qty,qty2,flg1,type ",
                   "  FROM s_price_c2_1",
                   " WHERE qty2 > 0 "
        PREPARE s_fetch_price_c2_prepare7 FROM l_sql                                                
        DECLARE s_fetch_price_c2_curs7 CURSOR FOR s_fetch_price_c2_prepare7   
        FOREACH s_fetch_price_c2_curs7 INTO l_no,l_line,l_cx_no,l_item,l_price,l_qty,l_qty2,l_flg1,l_type
           IF l_qty2 >0 AND l_flg1 = 'Y' THEN
              LET l_rxc06 = l_price*l_qty2*(1 - l_lpj11/100) 
              UPDATE rxc_file SET rxc06 = rxc06 + l_rxc06 
              WHERE rxc01 = l_no AND rxc02 = l_line  AND rxc04 = l_cx_no
           END IF
       END FOREACH 
    END IF  
 #   RETURN l_price
END FUNCTION


FUNCTION s_fetch_price_create_temp_table()
 DROP TABLE s_price_c2
 CREATE TEMP TABLE s_price_c2(					
   no    LIKE oeb_file.oeb01,                   	#單號，訂單單號/出貨單號/銷退單單	
   line  LIKE oeb_file.oeb03,				#項次	
   item  LIKE ima_file.ima01,				#料號
   unit  LIKE ima_file.ima25,               #單位 
   price LIKE oeb_file.oeb13,				#單價，開始算促銷傳過來的單價	
   qty   LIKE oeb_file.oeb12,				#數量，單據中的數量，傳過來的數量	
   qty1  LIKE oeb_file.oeb12,				#已消耗的數量，本次促銷消耗的數量，用於計算rxc_file用，每一次促銷之前改為0	
   qty2  LIKE oeb_file.oeb12,				#剩餘數量，預設值為qty，每參加一次促銷減去對應本次消耗的數量，用於下一個促銷計算	
   raf03 LIKE raf_file.raf03)			    #組別	

 DROP TABLE s_price_c2_1
 CREATE TEMP TABLE s_price_c2_1(					
   no    LIKE oeb_file.oeb01,                   	#單號，訂單單號/出貨單號/銷退單單	
   line  LIKE oeb_file.oeb03,				#項次	
   item  LIKE ima_file.ima01,				#料號 
   type  LIKE type_file.chr1,               #1.一般促銷 2.組合促銷 
   cx_no LIKE rab_file.rab02,               #促銷單號
   price LIKE oeb_file.oeb13,				#單價，開始算促銷傳過來的單價
   qty   LIKE oeb_file.oeb12,				#數量，單據中的數量，傳過來的數量	
   qty1  LIKE oeb_file.oeb12,				#已消耗的數量，本次促銷消耗的數量，用於計算rxc_file用，每一次促銷之前改為0	
   qty2  LIKE oeb_file.oeb12,				#剩餘數量，預設值為qty，每參加一次促銷減去對應本次消耗的數量，用於下一個促銷計算	
   flg1  LIKE type_file.chr1,              #是否可參加會員卡折扣  Y-參加，N-不參加
   flg2  LIKE type_file.chr1)               #是否參加滿額促銷，    Y-參加，N-不參加 
			   

END FUNCTION

FUNCTION s_fetch_price_ins_temp_table(p_price,p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd)
DEFINE p_type       LIKE type_file.chr1
DEFINE l_sql        STRING
DEFINE p_cmd        LIKE type_file.chr1
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_item       LIKE ima_file.ima01	
DEFINE p_term       LIKE oah_file.oah01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_line       LIKE oeb_file.oeb03
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE p_plant      LIKE azp_file.azp01
DEFINE l_no         LIKE oeb_file.oeb01				
DEFINE l_line       LIKE oeb_file.oeb03					
DEFINE l_item       LIKE ima_file.ima01				
DEFINE l_unit       LIKE ima_file.ima25             
DEFINE l_price      LIKE oeb_file.oeb13					
DEFINE l_qty        LIKE oeb_file.oeb12				
DEFINE l_qty1       LIKE oeb_file.oeb12				
DEFINE l_qty2       LIKE oeb_file.oeb12				
DEFINE l_raf03      LIKE raf_file.raf03
DEFINE l_a1_price  LIKE oeb_file.oeb13
DEFINE p_payment    LIKE oea_file.oea32     #付款條件
DEFINE p_no1        LIKE tqx_file.tqx01     #提案單號
DEFINE p_date       LIKE type_file.dat      #日期
DEFINE p_curr       LIKE azi_file.azi01     #幣別
 
   CASE p_type
      WHEN '1'
#       LET l_sql = "SELECT oeb01,oeb03,oeb04,oeb05,oeb37,oeb12,'','','' ",
        LET l_sql = "SELECT oeb01,oeb03,oeb04,oeb05,oeb12,'','','' ",   #MOD-B30045 MOD
                     "  FROM ",cl_get_target_table(g_plant_new,'oeb_file'),
                     " WHERE oeb01 = '",p_no,"'  " 
      WHEN '2'
#        LET l_sql = "SELECT ogb01,ogb03,ogb04,ogb05,ogb37,ogb12,'','','' ",
         LET l_sql = "SELECT ogb01,ogb03,ogb04,ogb05,ogb12,'','','' ",  #MOD-B30045 MOD
                     "  FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                     " WHERE ogb01 = '",p_no,"' " 
      WHEN '3'
#        LET l_sql = "SELECT ohb01,ohb03,ohb04,ohb05,ohb37,ohb12,'','','' ",
         LET l_sql = "SELECT ohb01,ohb03,ohb04,ohb05,ohb37,ohb12,'','','' ",  #MOD-B30045 MOD
                     "  FROM ",cl_get_target_table(g_plant_new,'ohb_file'),
                     " WHERE ohb01 = '",p_no,"' " 
   END CASE
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql    
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql 
   PREPARE pre_sel_s_price_c2 FROM l_sql
   DECLARE pre_cus_s_price_c2 CURSOR FOR pre_sel_s_price_c2
#  FOREACH pre_cus_s_price_c2 INTO l_no,l_line,l_item,l_unit,l_price,l_qty,l_qty1,l_qty2,l_raf03 
   FOREACH pre_cus_s_price_c2 INTO l_no,l_line,l_item,l_unit,l_qty,l_qty1,l_qty2,l_raf03
     #FUN-B10014 Begin---
      IF l_line = p_line AND p_cmd = 'd' THEN
         CONTINUE FOREACH
      END IF
      IF l_line = p_line THEN
         LET l_unit = p_unit
      END IF
     #FUN-B10014 End-----
      IF l_line = p_line THEN
         LET l_qty = p_count
      END IF
      CALL s_fetch_price_new2(p_cust,l_item,l_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,l_no,l_line,l_qty,p_no1,p_cmd,'1')
      RETURNING  l_price,g_flg
      LET l_price = l_price
      LET l_sql = "INSERT INTO s_price_c2 ",
                  "(no,line,item,unit,price,qty,qty1,qty2,raf03)", 
                  "VALUES(?,?,?,?,?, ?,?,?,?)"                          
      PREPARE pre_ins_no FROM l_sql
      EXECUTE pre_ins_no USING l_no,l_line,l_item,l_unit,l_price,l_qty,l_qty1,l_qty,l_raf03
   END FOREACH
   IF p_cmd = 'a' THEN
     #把新增状态下的这笔资料也要INSERT 到临时表
      LET l_sql = "INSERT INTO s_price_c2 ",
                  "(no,line,item,unit,price,qty,qty1,qty2,raf03)", 
                  "VALUES(?,?,?,?,?, ?,?,?,?)"                          
      PREPARE pre_ins_no1 FROM l_sql
      EXECUTE pre_ins_no1 USING p_no,p_line,p_item,p_unit,p_price,p_count,'',p_count,''
   END IF
   
END FUNCTION

FUNCTION  s_fetch_price_chk(l_type,p_rac01,p_rac02,p_rac03,p_plant,p_item)	
DEFINE l_type          LIKE type_file.chr1   #促銷類型：1-一般促銷，2-組合促銷，3-滿額促銷
DEFINE p_rac01         LIKE rac_file.rac01   #p_rac01 指定機構 
DEFINE p_rac02         LIKE rac_file.rac02   #p_rac02 促銷單號 
DEFINE p_rac03         LIKE rac_file.rac03   #p_rac03 組別
DEFINE p_item          LIKE oeb_file.oeb04   #料件編號
DEFINE l_rax04         LIKE rad_file.rad04   
DEFINE l_rax05         LIKE rad_file.rad05
DEFINE l_rax06         LIKE rad_file.rad06
DEFINE l_rax03         LIKE rad_file.rad03
DEFINE l_flag          LIKE type_file.chr1 
DEFINE p_plant         LIKE azp_file.azp01
DEFINE l_sql           STRING 
DEFINE l_rax03_t       LIKE rad_file.rad03
DEFINE l_ima131        LIKE ima_file.ima131
DEFINE l_ima1004       LIKE ima_file.ima1004
DEFINE l_ima1005       LIKE ima_file.ima1005
DEFINE l_ima1006       LIKE ima_file.ima1006
DEFINE l_ima1007       LIKE ima_file.ima1007
DEFINE l_ima1008       LIKE ima_file.ima1008
DEFINE l_ima1009       LIKE ima_file.ima1009
DEFINE l_ima33         LIKE ima_file.ima33
DEFINE l_tqa05         LIKE tqa_file.tqa05
DEFINE l_tqa06         LIKE tqa_file.tqa06
DEFINE i               LIKE type_file.num5 
   LET i = 0      #FUN-B10024 	
   CASE l_type	
      WHEN '1'	#组内交集
         LET l_sql = "SELECT rad03,rad04,rad05,rad06 ",	
                     "  FROM ",cl_get_target_table(g_plant_new,'rad_file'),	
                     " WHERE rad01='",p_rac01,"'",	
                     "   AND rad02='",p_rac02,"'",	
                     "   AND rad03='",p_rac03,"'",	
                     "   AND radacti = 'Y'"	
      WHEN '2'	#组内并集
         LET l_sql = "SELECT rag03,rag04,rag05,rag06 ",	
                     "  FROM ",cl_get_target_table(g_plant_new,'rag_file'),	
                     " WHERE rag01='",p_rac01,"'",	
                     "   AND rag02='",p_rac02,"'",	
                     "   AND rag03='",p_rac03,"'",	
                     "   AND ragacti = 'Y' "	
      WHEN '3'	#组内交集，组间并集
         LET l_sql = "SELECT raj03,raj04,raj05,raj06 ",	
                     "  FROM ",cl_get_target_table(g_plant_new,'raj_file'),	
                     " WHERE raj01='",p_rac01,"'",	
                     "   AND raj02='",p_rac02,"'",	
                     "   AND rajacti = 'Y'"	,
                      " ORDER BY raj03,raj04 "
   END CASE	
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql 
   PREPARE s_sel_rad04_pre FROM l_sql
   DECLARE s_sel_rad04_cs CURSOR FOR s_sel_rad04_pre
   FOREACH s_sel_rad04_cs INTO l_rax03,l_rax04,l_rax05,l_rax06  
      LET i = i + 1      #FUN-B10024 	
      IF l_type = '3' THEN
         IF cl_null(l_rax03_t) THEN LET l_rax03_t = l_rax03 END IF
         IF l_rax03<>l_rax03_t AND l_flag = 'Y' THEN EXIT  FOREACH END IF
         IF l_rax03=l_rax03_t  AND l_flag = 'N' THEN CONTINUE FOREACH END IF
         IF l_rax03<>l_rax03_t THEN LET l_rax03_t = l_rax03 END IF
      END IF
      CASE l_rax04	
         WHEN '01'	
	       CASE l_type
              WHEN '1'              
                  IF  p_item = l_rax05  THEN  
                       CONTINUE FOREACH       # 已滿足組內的一個條件，繼續走看是否滿足組內其它條件
                  ELSE
                       RETURN FALSE         #不滿足組內的一個條件，跳出foreach
                  END IF     
              WHEN '2'          
                  IF  p_item = l_rax05  THEN   
                       RETURN TRUE          # 滿足組內的這個條件，符合組合促銷，跳出foreach
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH      # 不滿足組內的這個條件，繼續走看是否滿足組內其他條件
                  END IF 
              WHEN '3'              
                  IF  p_item = l_rax05  THEN 
                     LET  l_flag = 'Y'       # 滿足組內的這個條件， 
                     CONTINUE FOREACH
                  ELSE
                     LET  l_flag = 'N'       #不滿足組內的這個條件
                     CONTINUE FOREACH
                  END IF 
           END CASE   
         WHEN '02'	        
              LET l_sql = "SELECT ima131 FROM ",cl_get_target_table(g_plant_new,'ima_file'), #FUN-A50102
                  " WHERE ima01 = '",p_item,"'"
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
              PREPARE pre_sel_ima131 FROM l_sql
              EXECUTE pre_sel_ima131 INTO l_ima131
            CASE l_type
              WHEN '1'         
                  IF  l_ima131 = l_rax05  THEN  
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE 
                  END IF 
              WHEN '2'             
                  IF  l_ima131 = l_rax05  THEN   
                       RETURN TRUE                
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH                
                  END IF 
              WHEN '3'           
                  IF  l_ima131 = l_rax05  THEN   
                       LET  l_flag = 'Y'
                       CONTINUE FOREACH  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH   
                  END IF 
           END CASE 
              
         WHEN '03'	
           LET l_sql = "SELECT ima1004 FROM ",cl_get_target_table(g_plant_new,'ima_file'),
                            " WHERE ima01 = '",p_item,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_ima1004 FROM l_sql
           EXECUTE pre_sel_ima1004 INTO l_ima1004
	       CASE l_type
              WHEN '1'          
                  IF  l_ima1004 = l_rax05  THEN  
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE
                  END IF 
              WHEN '2'            
                  IF  l_ima1004 = l_rax05  THEN
                       RETURN TRUE  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH
                  END IF
              WHEN '3'        
                  IF  l_ima1004 = l_rax05  THEN   
                       LET  l_flag = 'Y'
                       CONTINUE FOREACH  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH 
                  END IF
           END CASE 
         WHEN '04'	
           LET l_sql = "SELECT ima1005 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_ima1005 FROM l_sql
           EXECUTE pre_sel_ima1005 INTO l_ima1005
	       CASE l_type
              WHEN '1'        
                  IF  l_ima1005 = l_rax05  THEN  
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE   
                  END IF
              WHEN '2'           
                  IF  l_ima1005 = l_rax05  THEN  
                       RETURN TRUE   
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH
                  END IF
              WHEN '3'           
                  IF  l_ima1005 = l_rax05  THEN   
                       LET  l_flag = 'Y'
                       CONTINUE FOREACH  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH 
                  END IF
           END CASE 
         WHEN '05'	
          LET l_sql = "SELECT ima1006 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
          PREPARE pre_sel_ima1006 FROM l_sql
          EXECUTE pre_sel_ima1006 INTO l_ima1006
	       CASE l_type          
              WHEN '1'               
                  IF  l_ima1006 = l_rax05  THEN  
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE    
                  END IF
              WHEN '2'               
                  IF  l_ima1006 = l_rax05  THEN  
                       RETURN TRUE   
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH
                  END IF
              WHEN '3'         
                  IF  l_ima1006 = l_rax05  THEN   
                         LET  l_flag = 'Y'
                         CONTINUE FOREACH  
                  ELSE
                         LET  l_flag = 'N'
                         CONTINUE FOREACH  
                  END IF
           END CASE 
         WHEN '06'
          LET l_sql = "SELECT ima1007 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
          PREPARE pre_sel_ima1007 FROM l_sql
          EXECUTE pre_sel_ima1007 INTO l_ima1007 
	       CASE l_type
              WHEN '1'
                  IF  l_ima1007 = l_rax05  THEN  
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE  
                  END IF
              WHEN '2'      
                  IF  l_ima1007 = l_rax05  THEN 
                       RETURN TRUE  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH
                  END IF
              WHEN '3'    
                  IF  l_ima1007 = l_rax05  THEN   
                       LET  l_flag = 'Y'
                       CONTINUE FOREACH  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH 
                  END IF
           END CASE 
         WHEN '07'
           LET l_sql = "SELECT ima1008 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_ima1008 FROM l_sql
           EXECUTE pre_sel_ima1008 INTO l_ima1008 
	       CASE l_type
              WHEN '1'             
                  IF  l_ima1008 = l_rax05  THEN 
                       CONTINUE FOREACH
                  ELSE
                       RETURN FALSE
                  END IF
              WHEN '2'     
                  IF  l_ima1008 = l_rax05  THEN 
                       RETURN TRUE 
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH    
                  END IF
              WHEN '3'
                  IF  l_ima1008 = l_rax05  THEN   
                        LET  l_flag = 'Y'
                        CONTINUE FOREACH  
                  ELSE
                        LET  l_flag = 'N'
                        CONTINUE FOREACH 
                  END IF
           END CASE 
         WHEN '08'	
           LET l_sql = "SELECT ima1009 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_ima1009 FROM l_sql
           EXECUTE pre_sel_ima1009 INTO l_ima1009
	       CASE l_type
              WHEN '1'
                  IF  l_ima1009 = l_rax05  THEN   
                      CONTINUE FOREACH
                  ELSE
                      RETURN FALSE  
                  END IF
              WHEN '2'   
                  IF  l_ima1009 = l_rax05  THEN   
                       RETURN TRUE 
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH
                  END IF
              WHEN '3'     
                  IF  l_ima1009 = l_rax05  THEN   
                       LET  l_flag = 'Y'
                       CONTINUE FOREACH  
                  ELSE
                       LET  l_flag = 'N'
                       CONTINUE FOREACH 
                  END IF
           END CASE 
         WHEN '09'	
           LET l_sql = "SELECT ima33 FROM ",cl_get_target_table(g_plant_new,'ima_file'), 
                            " WHERE ima01 = '",p_item,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_ima33 FROM l_sql
           EXECUTE pre_sel_ima33 INTO l_ima33
           LET l_sql = "SELECT tqa05,tqa06 FROM ",cl_get_target_table(g_plant_new,'tqa_file'),
                            " WHERE tqa01 = '",l_rax05,"'"
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
           PREPARE pre_sel_tqa05 FROM l_sql
           EXECUTE pre_sel_tqa05 INTO l_tqa05,l_tqa06      
	       CASE l_type
              WHEN '1'
                IF l_ima33 >= l_tqa05 AND l_ima33 <= l_tqa06 THEN
                    CONTINUE FOREACH
                ELSE
                    RETURN FALSE  
                END IF
              WHEN '2'
                IF l_ima33 >= l_tqa05 AND l_ima33 <= l_tqa06 THEN
                    RETURN TRUE
                ELSE
                    LET  l_flag = 'N'
                    CONTINUE FOREACH           
                END IF
              WHEN '3'
                 IF l_ima33 >= l_tqa05 AND l_ima33 <= l_tqa06 THEN
                     LET  l_flag = 'Y'
                     CONTINUE FOREACH  
                 ELSE
                     LET  l_flag = 'N'
                     CONTINUE FOREACH
                 END IF
           END CASE 
      END CASE
   END FOREACH
#FUN-B10024--add--begin   
    IF i = 0 THEN 
       RETURN FALSE
    END IF
#FUN-B10024--add--end 
    IF l_type = '3' THEN
      IF l_flag = 'Y' THEN
         RETURN TRUE    #滿足促銷條件 
      ELSE
         RETURN FALSE  #不滿足促銷條件
      END IF
   END IF
   IF l_type = '2' THEN
      IF l_flag = 'N' THEN
         RETURN FALSE  #不滿足促銷條件
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#FUN-AA0065   ---end  --add 
#查找會員卡號
FUNCTION s_find_member(p_no,p_type,p_plant)
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_type       LIKE type_file.chr1
DEFINE p_plant      LIKE azp_file.azp01
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_sql        STRING
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 'N',0 
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   IF p_type = '1' THEN     #訂單
      #LET l_sql = "SELECT oea87 FROM ",l_dbs,"oea_file ",
      LET l_sql = "SELECT oea87 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                  "  WHERE oea01 = '",p_no,"'"
   END IF
   IF p_type = '2' THEN     #出貨單
      #LET l_sql = "SELECT oga87 FROM ",l_dbs,"oga_file ",
      LET l_sql = "SELECT oga87 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                  "  WHERE oga01 = '",p_no,"'"
   END IF
   IF p_type = '3' THEN     #銷退單
      #LET l_sql = "SELECT oha87 FROM ",l_dbs,"oha_file ",
      LET l_sql = "SELECT oha87 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                  "  WHERE oha01 = '",p_no,"'"
   END IF
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102    
   PREPARE pre_sel_oha87 FROM l_sql
   EXECUTE pre_sel_oha87 INTO l_oea87
   IF l_oea87 IS NULL THEN 
      LET g_member = 'N'
   ELSE
      LET g_member = 'Y'
   END IF
 
   RETURN l_oea87
END FUNCTION

#FUN-AA0065  ---begin--mark
#從商品特價促銷單中取價格
#FUNCTION s_price1(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_flag,p_count,p_team)
#DEFINE p_cust       LIKE occ_file.occ01
#DEFINE p_team       LIKE ohi_file.ohi02
#DEFINE p_item       LIKE ima_file.ima01
#DEFINE p_unit       LIKE ima_file.ima25
#DEFINE p_date       LIKE type_file.dat
#DEFINE p_term       LIKE oah_file.oah01
#DEFINE p_curr       LIKE azi_file.azi01
#DEFINE p_no         LIKE oea_file.oea01
#DEFINE p_line       LIKE oeb_file.oeb03
#DEFINE p_price      LIKE oeb_file.oeb13
#DEFINE p_type       LIKE type_file.chr1
#DEFINE p_flag       LIKE type_file.chr1
#DEFINE p_count      LIKE oeb_file.oeb12
#DEFINE p_plant      LIKE azp_file.azp01
#DEFINE l_dbs        LIKE azp_file.azp03
#DEFINE l_oea87      LIKE oea_file.oea87
#DEFINE l_time       LIKE type_file.chr8
#DEFINE l_sql        STRING
#DEFINE l_rwc13      LIKE rwc_file.rwc13
#DEFINE l_rwc15      LIKE rwc_file.rwc15
#DEFINE l_price      LIKE oeb_file.oeb13
#DEFINE l_lph04       LIKE lph_file.lph04
#DEFINE l_lph05       LIKE lph_file.lph05
#DEFINE l_lph06       LIKE lph_file.lph06
#DEFINE l_lph08       LIKE lph_file.lph08
#DEFINE l_rwd08       LIKE rwd_file.rwd08
#DEFINE l_rwd09       LIKE rwd_file.rwd09
#DEFINE l_rxc         RECORD LIKE rxc_file.*
#DEFINE l_rwc04       LIKE rwc_file.rwc04
#DEFINE l_rtv13       LIKE rtv_file.rtv13
#DEFINE l_rty05      LIKE rty_file.rty05
#DEFINE l_rtv01      LIKE rtv_file.rtv01
#DEFINE l_rtv02      LIKE rtv_file.rtv02
#DEFINE l_rtu07      LIKE rtu_file.rtu07

#  #FUN-9C0068   ---start
#  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
#   LET g_plant_new = p_plant
#   CALL s_gettrandbs()
#   LET l_dbs=g_dbs_tra
#  #FUN-9C0068   ---END

#   IF SQLCA.SQLCODE THEN
#      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   LET l_dbs = s_dbstring(l_dbs CLIPPED)
#   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
#   LET l_time = TIME
#   IF p_flag = '1' THEN
#      #LET l_sql = "SELECT DISTINCT rwc04,rwc13,rwc15 FROM ",l_dbs,"rwc_file,",
#      #              l_dbs,"rwb_file,",l_dbs,"rwq_file ",
#      LET l_sql = "SELECT DISTINCT rwc04,rwc13,rwc15 FROM ",cl_get_target_table(g_plant_new,'rwc_file'),",", #FUN-A50102
#                                                            cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                            cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                   "  WHERE rwc06 = '",p_item,"' ",
#                   "    AND rwc09 = '",p_unit,"' ",
#                   "    AND rwb01 = rwc01 AND rwb02 = rwc02 ",
#                   "    AND rwb03 = rwc03 AND rwb04 = rwc04 ",
#                   "    AND rwb01 = rwq01 AND rwb02 = rwq02 ",
#                   "    AND rwb03 = rwq03 AND rwb04 = rwq04 ",
#                   "    AND rwq06 = '",p_plant,"' AND rwbconf = 'Y' ",
#                   "    AND rwbplant = '",p_plant,"'",
#                   "    AND '",p_date,"' BETWEEN rwc19 AND rwc20 ",
#                   "    AND '",l_time,"' BETWEEN rwc21 AND rwc22 "
#   ELSE
#      #LET l_sql = " SELECT DISTINCT rwd04,rwd08,rwd09 FROM ",l_dbs,"rwd_file,",
#      #               l_dbs,"ima_file,",l_dbs,"rwb_file,",l_dbs,"rwq_file ",
#      LET l_sql = " SELECT DISTINCT rwd04,rwd08,rwd09 FROM ",cl_get_target_table(g_plant_new,'rwd_file'),",", #FUN-A50102
#                                                             cl_get_target_table(g_plant_new,'ima_file'),",", #FUN-A50102
#                                                             cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                             cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                   "   WHERE rwd06 = ima131 ",
#                   "    AND ima01 = '",p_item,"'",
#                   "    AND rwb01 = rwd01 AND rwb02 = rwd02 ",
#                   "    AND rwb03 = rwd03 AND rwb04 = rwd04 ",
#                   "    AND rwb01 = rwq01 AND rwb02 = rwq02 ",
#                   "    AND rwb03 = rwq03 AND rwb04 = rwq04 ",
#                   "    AND rwq06 = '",p_plant,"' AND rwbconf = 'Y' ",
#                   "    AND rwbplant = '",p_plant,"'",
#                   "    AND '",p_date,"' BETWEEN rwd13 AND rwd14 ",
#                   "    AND '",l_time,"' BETWEEN rwd15 AND rwd16 "
#   END IF
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
#   PREPARE pre_sel_rwb10 FROM l_sql
#   EXECUTE pre_sel_rwb10 INTO l_rwc04,l_rwc13,l_rwc15
#   IF SQLCA.SQLCODE THEN
#      IF SQLCA.SQLCODE = -284 THEN
#         CALL cl_err('','axm-543',1)
#         RETURN 'N',0
#      END IF
#      #CALL cl_err('sel rwc',SQLCA.SQLCODE,1)
#      RETURN 'N',0  
#   END IF
#   IF l_rwc13 IS NULL THEN LET l_rwc13 = 0 END IF
#   IF l_rwc15 IS NULL THEN LET l_rwc15 = 0 END IF
#   IF cl_null(l_oea87) THEN   #不是會員
#      IF p_flag = '1' THEN    #商品特價
#         LET l_price = l_rwc13
#      ELSE                    #品類促銷
#         #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) 
#         #   RETURNING l_price
#         #LET l_price = (l_price*l_rwc13)/100
#         LET l_price = (p_price*l_rwc13)/100
#      END IF   
#   ELSE                       #是會員
#      SELECT lph04,lph05,lph06,lph08 INTO l_lph04,l_lph05,l_lph06,l_lph08 
#         FROM lph_file
#        WHERE lph01=(SELECT lpj02 FROM lpj_file WHERE lpj03=l_oea87)
#      IF l_lph04 IS NULL THEN LET l_lph04 = 'N' END IF
#      IF l_lph05 IS NULL THEN LET l_lph05 = 'N' END IF
#      IF l_lph08 IS NULL THEN LET l_lph08 = 100 END IF
#      IF l_lph04 = 'Y' THEN
#         IF p_flag = '1' THEN    #商品特價
#            LET l_price = l_rwc15 
#         ELSE                    #品類促銷
#           #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
#            CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
#               RETURNING l_price
#            LET l_price = (l_price*l_rwd09)/100
#         END IF
#      END IF
#      IF l_lph05 = 'Y' THEN  #該會員的卡是可折扣的卡,取基礎價格
#        #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
#         CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
#            RETURNING l_price
#         LET l_price = (l_price*l_lph08)/100
#      END IF
#   END IF
#   #記錄折價
#   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
#   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
#   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
#   IF p_flag = '1' THEN
#      IF l_price != 0 THEN
#         #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file WHERE rxc00 = '",l_rxc.rxc00,"'",
#         LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
#                     " WHERE rxc00 = '",l_rxc.rxc00,"'",
#                     "   AND rxc01 = '",p_no,"' AND rxc02 = '",p_line,"'",
#                     "   AND rxc03 IN ('07','08','11') "
#        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
#         PREPARE pre_del_rxc6 FROM l_sql
#         EXECUTE pre_del_rxc6
#         LET p_price = g_leater_price
#      END IF
#   END IF
#   #從促銷協議中抓廠商分攤比率
#   #No.FUN-A10106 --begin
#   IF p_flag='1' THEN 
#      LET l_rtu07 ='01'
#   ELSE
#      LET l_rtu07='02'
#   END IF 
#   #No.FUN-A10106 --end
#   #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
#   LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
#                                                       cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
#              #" WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '4' ",                #No.FUN-A10106
#               " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '",l_rtu07,"' ",      #No.FUN-A10106
#               "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
#               "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
#               "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'",
#               "   AND rtu08='",l_rwc04,"' "        #No.FUN-A10106
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
#   PREPARE pre_sel3_rtv13 FROM l_sql
#   EXECUTE pre_sel3_rtv13 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
#   IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
#      SELECT rty05 INTO l_rty05 FROM rty_file 
#         WHERE rty01 = p_plant AND rty02 = p_item
#      #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
#      LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
#                  "   WHERE A.rto05 = '",l_rty05,"'",
#                  "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
#                  "     AND A.rtoplant = '",p_plant,"'",
#                  "     AND A.rtoconf = 'Y' ",
#                  #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
#                  "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
#                  "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
#      PREPARE pre_sel_rto12 FROM l_sql
#      EXECUTE pre_sel_rto12 INTO l_rtv01,l_rtv02,l_rtv13
#   END IF
#   IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
#   LET l_rxc.rxc01 = p_no
#   LET l_rxc.rxc02 = p_line
#   IF p_flag = '1' THEN 
#      LET l_rxc.rxc03 = '01'
#   ELSE
#      LET l_rxc.rxc03 = '02'
#   END IF
#   LET l_rxc.rxc04 = l_rwc04
#   LET l_rxc.rxc05 = ''
#   LET l_rxc.rxc06 = (p_price - l_price)*p_count
#   LET l_rxc.rxc07 = l_rtv13
#   LET l_rxc.rxc08 = ''
#   LET l_rxc.rxc09 = '0'
#   LET l_rxc.rxc10 = 0
#   LET l_rxc.rxc11 = g_member   #是否會員
#   LET l_rxc.rxc12 = l_rtv02
#   LET l_rxc.rxc13 = l_rty05
#   LET l_rxc.rxc14 = l_rtv01
#   LET l_rxc.rxcplant = p_plant
#   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
#   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
#   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
#               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
#               "     AND rxc01 = '",l_rxc.rxc01,"'",
#               "     AND rxc02 = '",l_rxc.rxc02,"'",
#               "     AND rxc03 = '",l_rxc.rxc03,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
#   PREPARE pre_del_rxc5 FROM l_sql
#   EXECUTE pre_del_rxc5
#   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
#   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
#               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
#               "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
#               "rxc12,rxc13,rxc14) ",
#               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
#   PREPARE pre_ins_rxc14 FROM l_sql
#   EXECUTE pre_ins_rxc14 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, #No.FUN-9B0157
#                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
#                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
#                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14
#   IF SQLCA.SQLCODE THEN 
#      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   RETURN 'Y',l_price
#END FUNCTION
#FUN-AA0065  ---end--mark

#根據價格條件取A類基礎價格 
#FUNCTION s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
#FUNCTION s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK
FUNCTION s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #MOD-9C0173 #TQC-B60015 ADD
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_term       LIKE oah_file.oah01
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_type       LIKE type_file.chr1
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_line       LIKE oeb_file.oeb03 #MOD-9C0173
DEFINE p_no         LIKE oea_file.oea01 #MOD-9C0173
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_sql        STRING
DEFINE l_ohi04      LIKE ohi_file.ohi04
DEFINE l_price      LIKE oeb_file.oeb13
DEFINE l_a2_price   LIKE oeb_file.oeb13 #TQC-B60015 ADD
DEFINE p_code       LIKE rwf_file.rwf02
DEFINE p_count      LIKE xmd_file.xmd08 #TQC-B60015 ADD

  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
 
   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 'N',0 
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   #LET l_sql = "SELECT ohi04 FROM ",l_dbs,"rzz_file,",l_dbs,"ohi_file ",
   #FUN-AB0083 mark Begin-----------------------------
   #LET l_sql = "SELECT ohi04 FROM ",cl_get_target_table(g_plant_new,'rzz_file'),",", #FUN-A50102
   #                                 cl_get_target_table(g_plant_new,'ohi_file'),     #FUN-A50102
   #            "   WHERE rzz01 = ohi04 AND rzz00 = '2' ",
   #            "     AND ohi01 = '",g_term,"' AND rzz03 = 'A' ",
   #            "     AND ohi02 = '",p_team,"'"
   #FUN-AB0083 mark End  -----------------------------
   #FUN-AB0083 add Begin-----------------------------
   LET l_sql = "SELECT ohi04 FROM ",cl_get_target_table(g_plant_new,'ohi_file'),     
               "   WHERE ohi01 = '",g_term,"' AND ohi04 LIKE 'A%' ",
               "     AND ohi02 = '",p_team,"'"
   #FUN-AB0083 add End  -----------------------------
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_sel_ohi04_1 FROM l_sql
   DECLARE cur_ohi04_1 CURSOR FOR pre_sel_ohi04_1
   FOREACH cur_ohi04_1 INTO l_ohi04
      CASE 
         WHEN l_ohi04 = 'A1' 
            CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
               RETURNING l_price
         WHEN l_ohi04 = 'A2'
            #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
        #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
        #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
            CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
               RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
        #MOD-9C0173   ---start
         WHEN l_ohi04 = 'A3'
            CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
               RETURNING l_price
         WHEN l_ohi04 = 'A4'
            CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
               RETURNING l_price
         WHEN l_ohi04 = 'A5'
            CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
               RETURNING l_price
         WHEN l_ohi04 = 'A6'
            CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
               RETURNING l_price
        #MOD-9C0173   ---end
      END CASE
      IF l_price > 0 THEN EXIT FOREACH END IF
   END FOREACH 
 
   IF l_price IS NULL THEN LET l_price = 0 END IF
   RETURN l_price
END FUNCTION
#FUN-AA0065  ---begin--mark
##FUNCTION s_price4(p_cust,p_curr,p_date,p_no,p_plant,p_code,p_plant1,p_type,p_team,p_cmd,p_price) #MOD-9C0173
#FUNCTION s_price4(p_cust,p_curr,p_date,p_no,p_plant,p_code,p_plant1,p_type,p_team,p_cmd,p_price,p_term,p_line) #MOD-9C0173
#DEFINE p_cust       LIKE occ_file.occ01
#DEFINE p_team       LIKE ohi_file.ohi02
#DEFINE p_item       LIKE ima_file.ima01
#DEFINE p_unit       LIKE ima_file.ima25
#DEFINE p_date       LIKE type_file.dat
#DEFINE p_term       LIKE oah_file.oah01
#DEFINE p_curr       LIKE azi_file.azi01
#DEFINE p_no         LIKE oea_file.oea01
#DEFINE p_plant      LIKE azp_file.azp01
#DEFINE p_plant1     LIKE azp_file.azp01
#DEFINE p_type       LIKE type_file.chr1
#DEFINE p_price      LIKE oeb_file.oeb13
#DEFINE p_cmd        LIKE type_file.chr1
#DEFINE p_code       LIKE rwa_file.rwa02
#DEFINE p_count      LIKE type_file.num5
#DEFINE p_line       LIKE oeb_file.oeb03   #MOD-9C0173
#DEFINE l_dbs        LIKE azp_file.azp03
#DEFINE l_oea87      LIKE oea_file.oea87
#DEFINE l_rwf        RECORD LIKE rwf_file.*
#DEFINE l_time       LIKE type_file.chr8
#DEFINE l_sql        STRING
#DEFINE l_tmp        RECORD
#                      oeb03      LIKE oeb_file.oeb03,
#                      oeb04      LIKE oeb_file.oeb04,
#                      oeb05      LIKE oeb_file.oeb05,
#                      oeb12      LIKE oeb_file.oeb12
#                    END RECORD
#DEFINE l_success    LIKE type_file.chr1
 
#   #只有用戶結束錄入或者刪除單身資料時，才會進行組合促銷取價
#   IF p_cmd != 'e' THEN RETURN 'N' END IF
#   SELECT oeb03,oeb04,oeb05,oeb12 FROM oeb_file WHERE 1=0 INTO TEMP oeb_tmp
#  #FUN-9C0068   ---start
#  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
#   LET g_plant_new = p_plant
#   CALL s_gettrandbs()
#   LET l_dbs=g_dbs_tra
#  #FUN-9C0068   ---END
# 
#   IF SQLCA.SQLCODE THEN
#      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#      RETURN 'N'
#   END IF
#   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
#   LET l_time = TIME
    
#   LET l_sql = " SELECT DISTINCT rwf_file.* ",
#               # " FROM ",l_dbs,"rwf_file,",
#               #   l_dbs,"rwg_file,",l_dbs,"rwq_file ",
#               " FROM ",cl_get_target_table(g_plant_new,'rwf_file'),",", #FUN-A50102
#                        cl_get_target_table(g_plant_new,'rwg_file'),",", #FUN-A50102
#                        cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#                "   WHERE ",
#                "    rwf01 = rwg01 AND rwf02 = rwg02 ",
#                "    AND rwf03 = rwg03 AND rwf04 = rwg04 ",
#                "    AND rwf01 = rwq01 AND rwf02 = rwq02 ",
#                "    AND rwf03 = rwq03 AND rwf04 = rwq04 ",
#                "    AND rwf01 = '",p_plant1,"' AND rwf02 = '",p_code,"' ",
#                "    AND rwf03 = '4' AND rwfplant = '",p_plant,"' ",
#                "    AND rwf23 = '1' ",
#                "    AND rwq06 = '",p_plant,"' AND rwfconf = 'Y' ",
#                "    AND '",p_date,"' BETWEEN rwf06 AND rwf07 ",
#                "    AND '",l_time,"' BETWEEN rwf08 AND rwf09 "
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
#   PREPARE pre_sel_rwf01 FROM l_sql 
#   #EXECUTE pre_sel_rwf01 INTO l_rwf.*
#   #IF SQLCA.SQLCODE THEN
#   #   RETURN 'N'
#   #END IF
#   DECLARE cur_rwf010 CURSOR FOR pre_sel_rwf01
#   FOREACH cur_rwf010 INTO l_rwf.*
#      IF l_rwf.rwf11 = '0' THEN    #變動組合
#        #CALL s_dynamic(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_type,p_plant,l_rwf.*,p_team,p_price) RETURNING l_success #MOD-9C0173
#         CALL s_dynamic(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_type,p_plant,l_rwf.*,p_team,p_price,p_term,p_line) RETURNING l_success #MOD-9C0173
#      ELSE                     #固定組合
#        #CALL s_fix(p_cust,p_item,p_unit,p_type,p_curr,p_date,p_plant,p_no,p_count,l_rwf.*,p_team,p_price) RETURNING l_success #MOD-9C0173
#         CALL s_fix(p_cust,p_item,p_unit,p_type,p_curr,p_date,p_plant,p_no,p_count,l_rwf.*,p_team,p_price,p_term,p_line) RETURNING l_success #MOD-9C0173
#      END IF 
#   END FOREACH
#   RETURN l_success
#END FUNCTION
#FUN-AA0065  ---end--mark
#變動組合
#FUNCTION s_dynamic(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_type,p_plant,p_rwf,p_team,p_price) #MOD-9C0173
#FUNCTION s_dynamic(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_type,p_plant,p_rwf,p_team,p_price,p_term,p_line) #MOD-9C0173 #TQC-B60015 MARK
FUNCTION s_dynamic(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_type,p_plant,p_rwf,p_team,p_price,p_term,p_line,p_count) #TQC-B60015 ADD
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_type       LIKE type_file.chr1
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_rwf        RECORD LIKE rwf_file.*
DEFINE p_term       LIKE oea_file.oea31    #MOD-9C0173
DEFINE p_line       LIKE oeb_file.oeb03    #MOD-9C0173 
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_sql        STRING
DEFINE l_sql1       STRING
DEFINE l_count      LIKE type_file.num5
DEFINE l_sum        LIKE type_file.num5
DEFINE l_sum1       LIKE type_file.num5
DEFINE l_ac         LIKE type_file.num5
DEFINE l_mod        LIKE type_file.num5
DEFINE l_n          LIKE type_file.num5
DEFINE l_total      LIKE type_file.num5
DEFINE l_total1     LIKE type_file.num5
DEFINE l_buy_price  LIKE oeb_file.oeb13
DEFINE l_sum_price  LIKE oeb_file.oeb13
DEFINE l_cheap_price  LIKE oeb_file.oeb13
DEFINE l_price      LIKE oeb_file.oeb13
DEFINE l_rtv13      LIKE rtv_file.rtv13
DEFINE l_oea87      LIKE oea_file.oea87
DEFINE l_oeb03      LIKE oeb_file.oeb03
DEFINE l_oeb04      LIKE oeb_file.oeb04
DEFINE l_oeb05      LIKE oeb_file.oeb05
DEFINE l_oeb12      LIKE oeb_file.oeb12
DEFINE l_result     LIKE type_file.num5
DEFINE l_legal      LIKE azw_file.azw02
DEFINE l_tmp        RECORD
                      oeb03      LIKE oeb_file.oeb03,
                      oeb04      LIKE oeb_file.oeb04,
                      oeb05      LIKE oeb_file.oeb05,
                      oeb12      LIKE oeb_file.oeb12
                    END RECORD
DEFINE l_times      LIKE type_file.num5
DEFINE l_rty05      LIKE rty_file.rty05
DEFINE l_rtv01      LIKE rtv_file.rtv01
DEFINE l_rtv02      LIKE rtv_file.rtv02
DEFINE p_count      LIKE xmd_file.xmd08 ##TQC-B60015 ADD

  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 'N'
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   IF p_type = '1' THEN     #訂單
      LET l_rxc.rxc00 = '01'
      #LET l_sql = "SELECT oeb03,oeb04,oeb05,oeb12 FROM ",l_dbs,"oeb_file ",
      LET l_sql = "SELECT oeb03,oeb04,oeb05,oeb12 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                  "   WHERE oeb01 = '",p_no,"' AND  (oeb04,oeb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"')"
   END IF
   IF p_type = '2' THEN     #出貨單
      LET l_rxc.rxc00 = '02'
      #LET l_sql = "SELECT ogb03,ogb04,ogb05,ogb12 FROM ",l_dbs,"ogb_file ",
      LET l_sql = "SELECT ogb03,ogb04,ogb05,ogb12 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  "   WHERE ogb01 = '",p_no,"' AND  (ogb04,ogb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"') "
   END IF
   IF p_type = '3' THEN     #銷退單
      LET l_rxc.rxc00 = '03'
      #LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",l_dbs,"ohb_file ",
      LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                  "   WHERE ohb01 = '",p_no,"' AND  (ohb04,ohb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"') "
   END IF
   LET l_sql = l_sql," INTO TEMP oeb_tmp "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
   PREPARE pre_sel_ohb FROM l_sql
   EXECUTE pre_sel_ohb 
   SELECT COUNT(*) INTO l_n FROM oeb_tmp
   IF l_n = 0 OR l_n IS NULL THEN RETURN 'N' END IF 
   #創建一個臨時表用來存放沒有參加組合促銷的商品信息
   SELECT * FROM oeb_tmp WHERE 1=0 INTO TEMP oeb_tmp1
   #DECLARE cur_ohb CURSOR FOR pre_sel_ohb
   
   #PREPARE pre_upd_oeb FROM l_sql1
   #把折價信息記錄到銷售折價明細檔中
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(rxc00,rxc01,rxc02,rxc03,",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               "(rxc00,rxc01,rxc02,rxc03,",
               "rxc04,rxc05,rxc06,rxc07,rxc08,rxc09,rxc10,rxc11,rxcplant,rxclegal,",
               "rxc12,rxc13,rxc14) ",
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
   PREPARE pre_ins_rxc FROM l_sql
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file WHERE rxc00 = ? AND rxc01 = ? AND rxc02 = ? "
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               " WHERE rxc00 = ? AND rxc01 = ? AND rxc02 = ? "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
   PREPARE pre_del_rxc01 FROM l_sql
   SELECT azw02 INTO l_legal FROM azw_file WHERE azw01 = p_plant
   LET l_sum = 0
   LET l_count = 0
   LET l_ac = 1 
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   IF l_oea87 IS NULL THEN
      LET l_rxc.rxc11 = 'N'
   ELSE
      LET l_rxc.rxc11 = 'Y'
   END IF
   #組合促銷特價
   IF p_rwf.rwf10 = '1' THEN   
      SELECT SUM(oeb12) INTO l_sum FROM oeb_tmp
      IF l_sum IS NULL THEN LET l_sum = 0 END IF
      LET l_mod = l_sum MOD p_rwf.rwf16     #計算未參加組合促銷的數量
      LET l_result = l_sum - l_mod          #計算已參加組合促銷的數量
      IF l_mod > 0 THEN
         DECLARE cur_tmp CURSOR FOR SELECT * FROM oeb_tmp ORDER BY oeb03 DESC
         FOREACH cur_tmp INTO l_tmp.*
            IF l_mod >= l_tmp.oeb12 THEN
               DELETE FROM oeb_tmp WHERE oeb03 = l_tmp.oeb03
               LET l_mod = l_mod - l_tmp.oeb12
               INSERT INTO oeb_tmp1 VALUES(l_tmp.*)
            END IF
            IF l_mod < l_tmp.oeb12 THEN
               UPDATE oeb_tmp SET oeb12 = l_tmp.oeb12-l_mod WHERE oeb03 = l_tmp.oeb03
               INSERT INTO oeb_tmp1 VALUES(l_tmp.oeb03,l_tmp.oeb04,l_tmp.oeb05,l_mod)
               LET l_mod = 0
            END IF
            IF l_mod = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      #計算所有商品的基礎類總金額
      DECLARE cur_tmp8 CURSOR FOR SELECT * FROM oeb_tmp
      LET l_total = 0
      FOREACH cur_tmp8 INTO l_tmp.*
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK
          CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD 
             RETURNING l_buy_price
          LET l_total = l_total + l_tmp.oeb12*l_buy_price
      END FOREACH
      #計算實際金額
      SELECT SUM(oeb12) INTO l_sum FROM oeb_tmp
      IF l_sum IS NULL THEN LET l_sum = 0 END IF
     #CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team) RETURNING l_price #MOD-9C0173
      CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team,p_term,p_line,p_no) RETURNING l_price #MOD-9C0173 
      LET l_total1 = (l_sum/p_rwf.rwf16)*l_price
      #計算折價
      FOREACH cur_tmp8 INTO l_tmp.*
        #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
        #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK
         CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD 
            RETURNING l_buy_price
         LET l_cheap_price =((l_tmp.oeb12*l_buy_price)/l_total)*(l_total - l_total1)
         #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
         LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
                                                            cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
                     " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '4' ",
                     "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                     "   AND rtv04 = '",l_tmp.oeb04,"' AND rtv14 = '",l_tmp.oeb05,"'",
                     "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
         PREPARE pre_sel_rtv08 FROM l_sql
         EXECUTE pre_sel_rtv08 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
         IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
            SELECT rty05 INTO l_rty05 FROM rty_file 
               WHERE rty01 = p_plant AND rty02 = p_item
            #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
            LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                        "   WHERE A.rto05 = '",l_rty05,"'",
                        "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                        "     AND A.rtoplant = '",p_plant,"'",
                        "     AND A.rtoconf = 'Y' ",
                        #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                        "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                        "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
            PREPARE pre_sel99_rto12 FROM l_sql
            EXECUTE pre_sel99_rto12 INTO l_rtv01,l_rtv02,l_rtv13
         END IF
         IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
          #把折價信息記錄到銷售折價明細檔中
          LET l_rxc.rxc01 = p_no
          LET l_rxc.rxc02 = l_tmp.oeb03
          LET l_rxc.rxc03 = '04'
          LET l_rxc.rxc04 = p_rwf.rwf04
          LET l_rxc.rxc05 = ''
          LET l_rxc.rxc06 = l_cheap_price
          LET l_rxc.rxc07 = l_rtv13
          LET l_rxc.rxc08 = ''
          LET l_rxc.rxc09 = '0'
          LET l_rxc.rxc10 = '0'
          LET l_rxc.rxc12 = l_rtv02
          LET l_rxc.rxc13 = l_rty05
          LET l_rxc.rxc14 = l_rtv01
          LET l_rxc.rxcplant = p_plant
          LET l_rxc.rxclegal = l_legal
          EXECUTE pre_del_rxc01 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
          IF SQLCA.SQLCODE THEN
             CALL cl_err('',SQLCA.SQLCODE,1)
             RETURN 'N'
          END IF
          EXECUTE pre_ins_rxc USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                    l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                    l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                    l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,l_rxc.rxc13,
                                    l_rxc.rxc14
          IF SQLCA.SQLCODE THEN
             CALL cl_err('',SQLCA.SQLCODE,1)
             RETURN 'N'
          END IF
      END FOREACH
      #給沒有能參加組合促銷的商品取價
      DECLARE cur_tmp5 CURSOR FOR SELECT * FROM oeb_tmp1 WHERE oeb12 > 0
      FOREACH cur_tmp5 INTO l_tmp.*
         CALL s_fetch_price_new1(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,
                         p_curr,g_term,g_payment,p_no,l_tmp.oeb03,l_tmp.oeb12,'','a')
            RETURNING l_price
      END FOREACH
   END IF
 
   #組合促銷折扣
   IF p_rwf.rwf10 = '2' THEN   
      SELECT SUM(oeb12) INTO l_sum FROM oeb_tmp
      IF l_sum IS NULL THEN LET l_sum = 0 END IF
      LET l_mod = l_sum MOD p_rwf.rwf16     #計算未參加組合促銷的數量
      LET l_result = l_sum - l_mod          #計算已參加組合促銷的數量
      IF l_mod > 0 THEN
         DECLARE cur_tmp11 CURSOR FOR SELECT * FROM oeb_tmp ORDER BY oeb03 DESC
         FOREACH cur_tmp11 INTO l_tmp.*
            IF l_mod >= l_tmp.oeb12 THEN
               DELETE FROM oeb_tmp WHERE oeb03 = l_tmp.oeb03
               LET l_mod = l_mod - l_tmp.oeb12
               INSERT INTO oeb_tmp1 VALUES(l_tmp.*)
            END IF
            IF l_mod < l_tmp.oeb12 THEN
               UPDATE oeb_tmp SET oeb12 = l_tmp.oeb12-l_mod WHERE oeb03 = l_tmp.oeb03
               INSERT INTO oeb_tmp1 VALUES(l_tmp.oeb03,l_tmp.oeb04,l_tmp.oeb05,l_mod)
               LET l_mod = 0
            END IF
            IF l_mod = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      #計算所有商品的基礎類總金額
      DECLARE cur_tmp9 CURSOR FOR SELECT * FROM oeb_tmp
      LET l_total = 0
      FOREACH cur_tmp9 INTO l_tmp.*
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK
          CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD 
             RETURNING l_buy_price
          LET l_total = l_total + l_tmp.oeb12*l_buy_price
      END FOREACH
      #計算實際金額
      SELECT SUM(oeb12) INTO l_sum FROM oeb_tmp
      IF l_sum IS NULL THEN LET l_sum = 0 END IF
      #CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team) RETURNING l_price #MOD-9C0173
      CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team,p_term,p_line,p_no) RETURNING l_price #MOD-9C0173 
      LET l_total1 = l_total*l_price/100
 
      #計算折價
      FOREACH cur_tmp9 INTO l_tmp.*
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
         #CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK
          CALL s_base_price(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD 
             RETURNING l_buy_price
          LET l_cheap_price =((l_tmp.oeb12*l_buy_price)/l_total)*(l_total - l_total1)
          #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
          LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
                                                             cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
                      " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '4' ",
                      "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                      "   AND rtv04 = '",l_oeb04,"' AND rtv14 = '",l_oeb05,"'",
                      "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'"
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
          PREPARE pre_sel_rtv14 FROM l_sql
          EXECUTE pre_sel_rtv14 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
          IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
             SELECT rty05 INTO l_rty05 FROM rty_file 
                WHERE rty01 = p_plant AND rty02 = p_item
             #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
             LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                         "   WHERE A.rto05 = '",l_rty05,"'",
                         "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                         "     AND A.rtoplant = '",p_plant,"'",
                         "     AND A.rtoconf = 'Y' ",
                         #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                         "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                         "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
             PREPARE pre_sel3_rto12 FROM l_sql
             EXECUTE pre_sel3_rto12 INTO l_rtv01,l_rtv02,l_rtv13
          END IF
          IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
          #把折價信息記錄到銷售折價明細檔中
          LET l_rxc.rxc01 = p_no
          LET l_rxc.rxc02 = l_tmp.oeb03
          LET l_rxc.rxc03 = '04'
          LET l_rxc.rxc04 = p_rwf.rwf04
          LET l_rxc.rxc05 = ''
          LET l_rxc.rxc06 = l_cheap_price
	  LET l_rxc.rxc07 = l_rtv13
          LET l_rxc.rxc08 = ''
          LET l_rxc.rxc09 = '0'
          LET l_rxc.rxc10 = '0'
          LET l_rxc.rxc12 = l_rtv02
          LET l_rxc.rxc13 = l_rty05
          LET l_rxc.rxc14 = l_rtv01
          LET l_rxc.rxcplant = p_plant
          LET l_rxc.rxclegal = l_legal
          EXECUTE pre_del_rxc01 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
          IF SQLCA.SQLCODE THEN
             CALL cl_err('',SQLCA.SQLCODE,1)
             RETURN 'N'
          END IF
          EXECUTE pre_ins_rxc USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                    l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                    l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                    l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,
                                    l_rxc.rxc13,l_rxc.rxc14
          IF SQLCA.SQLCODE THEN
             CALL cl_err('',SQLCA.SQLCODE,1)
             RETURN 'N'
          END IF
      END FOREACH
      #給沒有能參加組合促銷的商品取價
      DECLARE cur_tmp10 CURSOR FOR SELECT * FROM oeb_tmp1 WHERE oeb12 > 0
      FOREACH cur_tmp10 INTO l_tmp.*
         CALL s_fetch_price_new1(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,
                         p_curr,g_term,g_payment,p_no,l_tmp.oeb03,l_tmp.oeb12,'','a')
            RETURNING l_price
      END FOREACH
   END IF
   #組合促銷加價購
   IF p_rwf.rwf10 = '5' THEN   
      SELECT SUM(oeb12) INTO l_sum FROM oeb_tmp
      IF l_sum IS NULL THEN LET l_sum = 0 END IF
      LET l_mod = l_sum MOD p_rwf.rwf16     #計算未參加組合促銷的數量
      LET l_result = l_sum - l_mod          #計算已參加組合促銷的數量
      #把不符合條件參加組合促銷的商品從oeb_tmp移到oeb_tmp1中
      IF l_mod > 0 THEN
         DECLARE cur_tmp15 CURSOR FOR SELECT * FROM oeb_tmp ORDER BY oeb03 DESC
         FOREACH cur_tmp15 INTO l_tmp.*
            IF l_mod >= l_tmp.oeb12 THEN
               DELETE FROM oeb_tmp WHERE oeb03 = l_tmp.oeb03
               LET l_mod = l_mod - l_tmp.oeb12
               INSERT INTO oeb_tmp1 VALUES(l_tmp.*)
            END IF
            IF l_mod < l_tmp.oeb12 THEN
               UPDATE oeb_tmp SET oeb12 = l_tmp.oeb12-l_mod WHERE oeb03 = l_tmp.oeb03
               INSERT INTO oeb_tmp1 VALUES(l_tmp.oeb03,l_tmp.oeb04,l_tmp.oeb05,l_mod)
               LET l_mod = 0
            END IF
            IF l_mod = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
 
      #計算折價
      FOREACH cur_tmp9 INTO l_tmp.*
         #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
         LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
                                                            cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
                     " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '4' ",
                     "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
                     "   AND rtv04 = '",l_tmp.oeb04,"' AND rtv14 = '",l_tmp.oeb05,"'",
                     "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
         PREPARE pre_sel_rtv01 FROM l_sql
         EXECUTE pre_sel_rtv01 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
         IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
            SELECT rty05 INTO l_rty05 FROM rty_file 
               WHERE rty01 = p_plant AND rty02 = p_item
            #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
            LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                        "   WHERE A.rto05 = '",l_rty05,"'",
                        "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                        "     AND A.rtoplant = '",p_plant,"'",
                        "     AND A.rtoconf = 'Y' ",
                        #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                        "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                        "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
            PREPARE pre_sel4_rto12 FROM l_sql
            EXECUTE pre_sel4_rto12 INTO l_rtv01,l_rtv02,l_rtv13
         END IF
         IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
         #把折價信息記錄到銷售折價明細檔中
         LET l_rxc.rxc01 = p_no
         LET l_rxc.rxc02 = l_tmp.oeb03
         LET l_rxc.rxc03 = '99'
         LET l_rxc.rxc04 = p_rwf.rwf04
         LET l_rxc.rxc05 = ''
         LET l_rxc.rxc06 = 0
         LET l_rxc.rxc07 = l_rtv13
         LET l_rxc.rxc08 = ''
         LET l_rxc.rxc09 = '0'
         LET l_rxc.rxc10 = '0'
         LET l_rxc.rxc12 = l_rtv02
         LET l_rxc.rxc13 = l_rty05
         LET l_rxc.rxc14 = l_rtv01
         LET l_rxc.rxcplant = p_plant
         LET l_rxc.rxclegal = l_legal
         EXECUTE pre_del_rxc01 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
         IF SQLCA.SQLCODE THEN
            CALL cl_err('',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         EXECUTE pre_ins_rxc USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                   l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                   l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                   l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,
                                   l_rxc.rxc13,l_rxc.rxc14
         IF SQLCA.SQLCODE THEN
            CALL cl_err('',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
      END FOREACH
      #給沒有能參加組合促銷的商品取價
      DECLARE cur_tmp16 CURSOR FOR SELECT * FROM oeb_tmp1 WHERE oeb12 > 0
      FOREACH cur_tmp16 INTO l_tmp.*
         CALL s_fetch_price_new1(p_cust,l_tmp.oeb04,l_tmp.oeb05,p_date,p_type,p_plant,
                         p_curr,g_term,g_payment,p_no,l_tmp.oeb03,l_tmp.oeb12,'','a')
            RETURNING l_price
      END FOREACH
   END IF
 
   DROP TABLE oeb_tmp 
   DROP TABLE oeb_tmp1 
  
   RETURN 'Y'
END FUNCTION
#FUNCTION s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_member,p_price1,p_price2,p_flag,p_team) #MOD-9C0173
FUNCTION s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_member,p_price1,p_price2,p_flag,p_team,p_term,p_line,p_no) #MOD-9C0173
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_date       LIKE type_file.dat
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_type       LIKE type_file.chr1
DEFINE p_code       LIKE rwa_file.rwa02
DEFINE p_count      LIKE type_file.num5
DEFINE p_member      LIKE oea_file.oea87    #會員編號
DEFINE p_price1      LIKE oeb_file.oeb13
DEFINE p_price2      LIKE oeb_file.oeb13
DEFINE p_flag        LIKE type_file.chr1
DEFINE p_term        LIKE oea_file.oea31 #MOD-9C0173
DEFINE p_line        LIKE oeb_file.oeb03 #MOD-9C0173
DEFINE l_lph04       LIKE lph_file.lph04
DEFINE l_lph05       LIKE lph_file.lph05
DEFINE l_lph06       LIKE lph_file.lph06
DEFINE l_lph08       LIKE lph_file.lph08
DEFINE l_price       LIKE oeb_file.oeb13
DEFINE l_price2      LIKE oeb_file.oeb13
 
   IF cl_null(p_member) THEN     #不是會員的情況
      LET l_price = p_price1
   ELSE                          #是會員的情況
      SELECT lph04,lph05,lph06,lph08 INTO l_lph04,l_lph05,l_lph06,l_lph08 
         FROM lph_file
        WHERE lph01=(SELECT lpj02 FROM lpj_file WHERE lpj03=p_member)
      IF l_lph04 IS NULL THEN LET l_lph04 = 'N' END IF
      IF l_lph05 IS NULL THEN LET l_lph05 = 'N' END IF
      IF l_lph08 IS NULL THEN LET l_lph08 = 100 END IF
      IF l_lph04 = 'Y' THEN   #會員價
         IF p_flag = '1' THEN    #特價情況
            LET l_price = p_price2
         END IF
         IF p_flag = '2' THEN    #折扣情況
           #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
           #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
            CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
               RETURNING l_price
            LET l_price = (l_price*l_lph08)/100
         END IF
      END IF
      IF l_lph05 = 'Y' THEN   #該會員的卡是可折扣的卡,取基礎價格
        #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
        #CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
         CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
            RETURNING l_price
         LET l_price = (l_price*l_lph08)/100
      END IF
   END IF
   IF l_price IS NULL THEN LET l_price = 0 END IF
   RETURN l_price
END FUNCTION
#固定組合
#FUNCTION s_fix(p_cust,p_item,p_unit,p_type,p_curr,p_date,p_plant,p_no,p_count,p_rwf,p_team,p_price) #MOD-9C0173
FUNCTION s_fix(p_cust,p_item,p_unit,p_type,p_curr,p_date,p_plant,p_no,p_count,p_rwf,p_team,p_price,p_term,p_line) #MOD-9C0173
DEFINE p_cust       LIKE occ_file.occ01
DEFINE p_team       LIKE ohi_file.ohi02
DEFINE p_item       LIKE ima_file.ima01
DEFINE p_unit       LIKE ima_file.ima25
DEFINE p_curr       LIKE azi_file.azi01
DEFINE p_type       LIKE type_file.chr1
DEFINE p_plant      LIKE azp_file.azp01
DEFINE p_price      LIKE oeb_file.oeb13
DEFINE p_date       LIKE oea_file.oea02
DEFINE p_no         LIKE oea_file.oea01
DEFINE p_count      LIKE oeb_file.oeb12
DEFINE p_term       LIKE oea_file.oea31 #MOD-9C0173
DEFINE p_line       LIKE oeb_file.oeb03 #MOD-9C0173
DEFINE p_rwf        RECORD LIKE rwf_file.*
DEFINE l_legal      LIKE azw_file.azw02
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_min        LIKE type_file.num5
DEFINE l_cn         LIKE type_file.num5
DEFINE l_n          LIKE type_file.num5
DEFINE l_sum        LIKE type_file.num5
DEFINE l_count      LIKE type_file.num5
DEFINE l_ac         LIKE type_file.num5
DEFINE l_money      LIKE oeb_file.oeb13
DEFINE l_total_money  LIKE oeb_file.oeb13
DEFINE l_times        LIKE type_file.num5
DEFINE l_oeb03        LIKE oeb_file.oeb03
DEFINE l_oeb04        LIKE oeb_file.oeb04
DEFINE l_oeb05        LIKE oeb_file.oeb05
DEFINE l_oeb12        LIKE oeb_file.oeb12
DEFINE l_base_price   LIKE oeb_file.oeb13
DEFINE l_price        LIKE oeb_file.oeb13
DEFINE l_sql          STRING
DEFINE l_sql1         STRING
DEFINE l_rwg11        LIKE rwg_file.rwg11
DEFINE l_cheap_price  LIKE oeb_file.oeb13
DEFINE l_minus_price  LIKE oeb_file.oeb13
DEFINE l_total_price  LIKE oeb_file.oeb13
DEFINE l_use_sum      LIKE oeb_file.oeb12
DEFINE l_nouse_sum    LIKE oeb_file.oeb12
DEFINE l_oea87        LIKE oea_file.oea87
DEFINE l_dbs          LIKE azp_file.azp03
DEFINE l_rty05      LIKE rty_file.rty05
DEFINE l_rtv13      LIKE rtv_file.rtv13
DEFINE l_rtv01      LIKE rtv_file.rtv01
DEFINE l_rtv02      LIKE rtv_file.rtv02
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 'N'
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
 
   #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
   LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05 FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
                                                      cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
               " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '4' ",
               "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
               "   AND rtv04 = ? AND rtv14 = ? ",
               "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE pre_sel_rtv130 FROM l_sql
   IF p_type = '1' THEN     #訂單
      #LET l_sql = "SELECT oeb04,oeb05 FROM ",l_dbs,"oeb_file ",
      LET l_sql = "SELECT oeb04,oeb05 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                  "   WHERE oeb01 = '",p_no,"'"
   END IF
   IF p_type = '2' THEN     #出貨單
      #LET l_sql = "SELECT ogb04,ogb05 FROM ",l_dbs,"ogb_file ",
      LET l_sql = "SELECT ogb04,ogb05 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  "   WHERE ogb01 = '",p_no,"' "
   END IF
   IF p_type = '3' THEN     #出貨單
      #LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",l_dbs,"ohb_file ",
      LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                  "   WHERE ohb01 = '",p_no,"'"
   END IF
   #LET l_sql = "(SELECT rwg06,rwg09 FROM ",l_dbs,"rwg_file ",
   LET l_sql = "(SELECT rwg06,rwg09 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
               "  WHERE rwg01 = '",p_rwf.rwf01,"' AND rwg02 = '",p_rwf.rwf02,"' ",
               "    AND rwg03 = '",p_rwf.rwf03,"' AND rwg04 = '",p_rwf.rwf04,"')",
               "   MINUS (",l_sql,")"
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE pre_sel_oeb045 FROM l_sql
   EXECUTE pre_sel_oeb045 INTO l_n
   IF l_n IS NULL THEN LET l_n = 0 END IF
   #只有l_n = 0的情況才滿足固定組合促銷
   IF l_n > 0 THEN
      RETURN 'N'
   END IF
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               "   WHERE rxc00 = ? AND rxc01 = ? AND rxc02 = ? "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE pre_del_rxc02 FROM l_sql
   IF p_type = '1' THEN     #訂單
      LET l_rxc.rxc00 = '01'
      #LET l_sql = "SELECT oeb03,oeb04,oeb05,oeb12 FROM ",l_dbs,"oeb_file ",
      LET l_sql = "SELECT oeb03,oeb04,oeb05,oeb12 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                  "   WHERE oeb01 = '",p_no,"' AND  (oeb04,oeb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"') ORDER BY oeb03"
   END IF
   IF p_type = '2' THEN     #出貨單
      LET l_rxc.rxc00 = '02'
      #LET l_sql = "SELECT ogb03,ogb04,ogb05,ogb12 FROM ",l_dbs,"ogb_file ",
      LET l_sql = "SELECT ogb03,ogb04,ogb05,ogb12 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  "   WHERE ogb01 = '",p_no,"' AND  (ogb04,ogb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"') ORDER BY ogb03"
   END IF
   IF p_type = '3' THEN     #銷退單
      LET l_rxc.rxc00 = '03'
      #LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",l_dbs,"ohb_file ",
      LET l_sql = "SELECT ohb03,ohb04,ohb05,ohb12 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                  "   WHERE ohb01 = '",p_no,"' AND  (ohb04,ohb05) IN ",
                  " (SELECT rwg06,rwg09 ",
                  #"  FROM ",l_dbs,"rwg_file WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "  FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  " WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"') ORDER BY ohb03"
   END IF
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE pre_sel_ohb1 FROM l_sql
   DECLARE cur_ohb1 CURSOR FOR pre_sel_ohb1
   LET l_min = 0      #每個商品都可以參加商品組合促銷的次數
   LET l_times = 0
   LET l_cn = 0       #表示第一次進foreach
   #計算該銷售單可以參加多少次固定組合促銷
   FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
      #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
      LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                  "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                  "   AND rwg02 = '",p_rwf.rwf02,"' ",
                  "   AND rwg03 = '",p_rwf.rwf03,"' ",
                  "   AND rwg04 = '",p_rwf.rwf04,"'",
                  "   AND rwg06 = '",l_oeb04,"' ",
                  "   AND rwg09 = '",l_oeb05,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
      PREPARE pre_sel_rwg11 FROM l_sql
      EXECUTE pre_sel_rwg11 INTO l_rwg11
      IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
      IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
      LET l_times = l_oeb12/l_rwg11 
      IF l_times = 0 THEN RETURN 'N' END IF
      IF l_cn = 0 THEN LET l_min = l_times END IF
      IF l_times < l_min THEN LET l_min = l_times END IF
      LET l_cn = l_cn + 1
   END FOREACH
 
   #把折價信息記錄到銷售折價明細檔中
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(rxc00,rxc01,rxc02,rxc03,",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               "(rxc00,rxc01,rxc02,rxc03,",
               "rxc04,rxc05,rxc06,rxc07,rxc08,rxc09,rxc10,rxc11,rxcplant,rxclegal,rxc12,rxc13,rxc14)",
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
   PREPARE pre_ins_rxc1 FROM l_sql
   SELECT azw02 INTO l_legal FROM azw_file WHERE azw01 = p_plant
   LET l_sum = 0
   LET l_count = 0
   LET l_ac = 1 
   LET l_money = 0
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   IF l_oea87 IS NULL THEN
      LET l_rxc.rxc11 = 'N'
   ELSE
      LET l_rxc.rxc11 = 'Y' 
   END IF
   LET l_total_money = 0
   #組合促銷特價
   IF p_rwf.rwf10 = '1' THEN  
     #CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team) RETURNING l_price #MOD-9C0173
      CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf12,p_rwf.rwf13,'1',p_team,p_term,p_line,p_no) RETURNING l_price #MOD-9C0173
      LET l_money = l_min*l_price       #參加組合促銷商品的促銷金額
      FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
         #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
         LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                     "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                     "   AND rwg02 = '",p_rwf.rwf02,"' ",
                     "   AND rwg03 = '",p_rwf.rwf03,"' ",
                     "   AND rwg04 = '",p_rwf.rwf04,"'",
                     "   AND rwg06 = '",l_oeb04,"' ",
                     "   AND rwg09 = '",l_oeb05,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
         PREPARE pre_sel_rwg114 FROM l_sql
         EXECUTE pre_sel_rwg114 INTO l_rwg11
         IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
         IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
         LET l_nouse_sum = l_oeb12 - l_use_sum    #不可以參加組合促銷的商品數量
         IF l_use_sum > 0 THEN
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
            CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
               RETURNING l_base_price
            LET l_total_money = l_total_money + l_base_price*l_use_sum   #參加組合促銷商品的金額
         END IF
         #IF l_nouse_sum > 0 THEN 
         #   CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
         #                    p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
         #      RETURNING l_price
         #END IF
      END FOREACH
      LET l_minus_price = l_total_money - l_money
      FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
         #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
         LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                     "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                     "   AND rwg02 = '",p_rwf.rwf02,"' ",
                     "   AND rwg03 = '",p_rwf.rwf03,"' ",
                     "   AND rwg04 = '",p_rwf.rwf04,"'",
                     "   AND rwg06 = '",l_oeb04,"' ",
                     "   AND rwg09 = '",l_oeb05,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
         PREPARE pre_sel_rwg113 FROM l_sql
         EXECUTE pre_sel_rwg113 INTO l_rwg11
         IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
         IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
        #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
        #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
         CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
            RETURNING l_base_price
         LET l_cheap_price = ((l_base_price*l_use_sum)/l_total_money)*l_minus_price
         EXECUTE pre_sel_rtv130 USING l_oeb03,l_oeb04 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05
         IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
            SELECT rty05 INTO l_rty05 FROM rty_file 
               WHERE rty01 = p_plant AND rty02 = p_item
            #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
            LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                        "   WHERE A.rto05 = '",l_rty05,"'",
                        "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                        "     AND A.rtoplant = '",p_plant,"'",
                        "     AND A.rtoconf = 'Y' ",
                        #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                        "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                        "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
            PREPARE pre_sel5_rto12 FROM l_sql
            EXECUTE pre_sel5_rto12 INTO l_rtv01,l_rtv02,l_rtv13
         END IF
         IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
         #把折價信息記錄到銷售折價明細檔中
         LET l_rxc.rxc01 = p_no
         LET l_rxc.rxc02 = l_oeb03
         LET l_rxc.rxc03 = '04'
         LET l_rxc.rxc04 = p_rwf.rwf04
         LET l_rxc.rxc05 = ''
         LET l_rxc.rxc06 = l_cheap_price
	 LET l_rxc.rxc07 = l_rtv13
         LET l_rxc.rxc08 = ''
         LET l_rxc.rxc09 = '0'
         LET l_rxc.rxc10 = '0'
         LET l_rxc.rxc12 = l_rtv02
         LET l_rxc.rxc13 = l_rty05
         LET l_rxc.rxc14 = l_rtv01
         LET l_rxc.rxcplant = p_plant
         LET l_rxc.rxclegal = l_legal
         EXECUTE pre_del_rxc02 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
         IF SQLCA.SQLCODE THEN
            CALL cl_err('del rxc_fildel rxc_filee',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         EXECUTE pre_ins_rxc1 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                   l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                   l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                   l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,
                                   l_rxc.rxc13,l_rxc.rxc14
         IF SQLCA.SQLCODE THEN
            CALL cl_err('ins rxc_file',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         #給沒有參加組合促銷的商品取價
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
         LET l_nouse_sum = l_oeb12 - l_use_sum    #不可以參加組合促銷的商品數量
         IF l_nouse_sum > 0 THEN 
            CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
                             p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
               RETURNING l_price
         END IF
      END FOREACH
   END IF
   IF p_rwf.rwf10 = '2' THEN  
     #CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf14,p_rwf.rwf15,'2',p_team) RETURNING l_price #MOD-9C0173
      CALL s_get_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,l_oea87,p_rwf.rwf14,p_rwf.rwf15,'2',p_team,p_term,p_line,p_no) RETURNING l_price #MOD-9C0173
      LET l_money = l_min*l_price*p_price/100       #參加組合促銷商品的促銷金額
      FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
         #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
         LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                     "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                     "   AND rwg02 = '",p_rwf.rwf02,"' ",
                     "   AND rwg03 = '",p_rwf.rwf03,"' ",
                     "   AND rwg04 = '",p_rwf.rwf04,"'",
                     "   AND rwg06 = '",l_oeb04,"' ",
                     "   AND rwg09 = '",l_oeb05,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
         PREPARE pre_sel_rwg112 FROM l_sql
         EXECUTE pre_sel_rwg112 INTO l_rwg11
         IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
         IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
         LET l_nouse_sum = l_oeb12 - l_use_sum    #不可以參加組合促銷的商品數量
         IF l_use_sum > 0 THEN
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
            CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
               RETURNING l_base_price
            LET l_total_money = l_total_money + l_base_price*l_use_sum   #參加組合促銷商品的金額
         END IF
         #IF l_nouse_sum > 0 THEN 
         #   CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
         #                    p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
         #      RETURNING l_price
         #END IF
      END FOREACH
      LET l_minus_price = l_total_money - l_money
      FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
         #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
         LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                     "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                     "   AND rwg02 = '",p_rwf.rwf02,"' ",
                     "   AND rwg03 = '",p_rwf.rwf03,"' ",
                     "   AND rwg04 = '",p_rwf.rwf04,"'",
                     "   AND rwg06 = '",l_oeb04,"' ",
                     "   AND rwg09 = '",l_oeb05,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
         PREPARE pre_sel_rwg111 FROM l_sql
         EXECUTE pre_sel_rwg111 INTO l_rwg11
         IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
         IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
        #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
        #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
         CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
            RETURNING l_base_price
         LET l_cheap_price = ((l_base_price*l_use_sum)/l_total_money)*l_minus_price
         EXECUTE pre_sel_rtv130 USING l_oeb03,l_oeb04 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05
         IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
            SELECT rty05 INTO l_rty05 FROM rty_file 
               WHERE rty01 = p_plant AND rty02 = p_item
            #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
            LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                        "   WHERE A.rto05 = '",l_rty05,"'",
                        "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                        "     AND A.rtoplant = '",p_plant,"'",
                        "     AND A.rtoconf = 'Y' ",
                        #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                        "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                        "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
            PREPARE pre_sel6_rto12 FROM l_sql
            EXECUTE pre_sel6_rto12 INTO l_rtv01,l_rtv02,l_rtv13
         END IF
         IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
         #把折價信息記錄到銷售折價明細檔中
         LET l_rxc.rxc01 = p_no
         LET l_rxc.rxc02 = l_oeb03
         LET l_rxc.rxc03 = '04'
         LET l_rxc.rxc04 = p_rwf.rwf04
         LET l_rxc.rxc05 = ''
         LET l_rxc.rxc06 = l_cheap_price
	 LET l_rxc.rxc07 = l_rtv13
         LET l_rxc.rxc08 = ''
         LET l_rxc.rxc09 = '0'
         LET l_rxc.rxc10 = '0'
         LET l_rxc.rxc12 = l_rtv02
         LET l_rxc.rxc13 = l_rty05
         LET l_rxc.rxc14 = l_rtv01
         LET l_rxc.rxcplant = p_plant
         LET l_rxc.rxclegal = l_legal
         EXECUTE pre_del_rxc02 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
         IF SQLCA.SQLCODE THEN
            CALL cl_err('del rxc_file ',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         EXECUTE pre_ins_rxc1 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                   l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                   l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                   l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,
                                   l_rxc.rxc13,l_rxc.rxc14
         IF SQLCA.SQLCODE THEN
            CALL cl_err('ins rxc_file',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
         LET l_nouse_sum = l_oeb12 - l_use_sum    #不可以參加組合促銷的商品數量
         IF l_use_sum > 0 THEN
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team) #MOD-9C0173
           #CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 #TQC-B60015 MARK 
            CALL s_base_price(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no,p_count) #TQC-B60015 ADD
               RETURNING l_base_price
            LET l_total_money = l_total_money + l_base_price*l_use_sum   #參加組合促銷商品的金額
         END IF
         IF l_nouse_sum > 0 THEN 
            CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
                             p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
               RETURNING l_price
         END IF
      END FOREACH
   END IF
   #固定組合促銷加價購
   IF p_rwf.rwf10 = '5' THEN   
      FOREACH cur_ohb1 INTO l_oeb03,l_oeb04,l_oeb05,l_oeb12
         #LET l_sql = "SELECT rwg11 FROM ",l_dbs,"rwg_file ",
         LET l_sql = "SELECT rwg11 FROM ",cl_get_target_table(g_plant_new,'rwg_file'), #FUN-A50102
                     "   WHERE rwg01 = '",p_rwf.rwf01,"'",
                     "   AND rwg02 = '",p_rwf.rwf02,"' ",
                     "   AND rwg03 = '",p_rwf.rwf03,"' ",
                     "   AND rwg04 = '",p_rwf.rwf04,"'",
                     "   AND rwg06 = '",l_oeb04,"' ",
                     "   AND rwg09 = '",l_oeb05,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
         PREPARE pre_sel_rwg12 FROM l_sql
         EXECUTE pre_sel_rwg12 INTO l_rwg11
         IF SQLCA.SQLCODE = 100 THEN CONTINUE FOREACH END IF
         IF l_rwg11 IS NULL OR l_rwg11 = 0 THEN CONTINUE FOREACH END IF
         LET l_use_sum = l_min*l_rwg11            #可以參加組合促銷的商品數量
         LET l_nouse_sum = l_oeb12 - l_use_sum    #不可以參加組合促銷的商品數量
         #IF l_nouse_sum > 0 THEN 
         #   CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
         #                    p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
         #      RETURNING l_price
         #END IF
         EXECUTE pre_sel_rtv130 USING l_oeb03,l_oeb04 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05
         IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
            SELECT rty05 INTO l_rty05 FROM rty_file 
               WHERE rty01 = p_plant AND rty02 = p_item
            #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
            LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
                        "   WHERE A.rto05 = '",l_rty05,"'",
                        "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
                        "     AND A.rtoplant = '",p_plant,"'",
                        "     AND A.rtoconf = 'Y' ",
                        #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
                        "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
                        "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
            PREPARE pre_sel7_rto12 FROM l_sql
            EXECUTE pre_sel7_rto12 INTO l_rtv01,l_rtv02,l_rtv13
         END IF
         IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
         #把折價信息記錄到銷售折價明細檔中
         LET l_rxc.rxc01 = p_no
         LET l_rxc.rxc02 = l_oeb03
         LET l_rxc.rxc03 = '99'
         LET l_rxc.rxc04 = p_rwf.rwf04
         LET l_rxc.rxc05 = ''
         LET l_rxc.rxc06 = 0
         LET l_rxc.rxc07 = l_rtv13
         LET l_rxc.rxc08 = ''
         LET l_rxc.rxc09 = '0'
         LET l_rxc.rxc10 = '0'
         LET l_rxc.rxc12 = l_rtv02
         LET l_rxc.rxc13 = l_rty05
         LET l_rxc.rxc14 = l_rtv01
         LET l_rxc.rxcplant = p_plant
         LET l_rxc.rxclegal = l_legal
         EXECUTE pre_del_rxc01 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02
         IF SQLCA.SQLCODE THEN
            CALL cl_err('',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         EXECUTE pre_ins_rxc1 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,
                                   l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,
                                   l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxc11,
                                   l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc12,
                                   l_rxc.rxc13,l_rxc.rxc14
         IF SQLCA.SQLCODE THEN
            CALL cl_err('',SQLCA.SQLCODE,1)
            RETURN 'N'
         END IF
         IF l_nouse_sum > 0 THEN 
            CALL s_fetch_price_new1(p_cust,l_oeb04,l_oeb05,p_date,p_type,p_plant,
                             p_curr,g_term,g_payment,p_no,l_oeb03,l_nouse_sum,'','a')
               RETURNING l_price
         END IF
      END FOREACH
   END IF
 
   RETURN 'Y'
END FUNCTION
 
FUNCTION s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_price,p_count,p_type) #FUN-9C0083 add p_type
DEFINE p_cust       LIKE tqo_file.tqo01,     #客戶編號
       p_item       LIKE tqn_file.tqn03,     #料件編號
       p_unit       LIKE tqn_file.tqn04,     #單位
       p_date       LIKE type_file.dat,      #日期
       p_type       LIKE type_file.chr1,     #單據類型
       p_curr       LIKE azi_file.azi01,     #幣別
       p_plant      LIKE azp_file.azp01,     #機構別
       p_term       LIKE oah_file.oah01,     #價格條件
       p_no         LIKE oea_file.oea01,
       p_count      LIKE oeb_file.oeb12,
       p_line       LIKE oeb_file.oeb01,
       p_price      LIKE oeb_file.oeb13,
       p_payment    LIKE oea_file.oea32      #付款條件
DEFINE l_xmc08      LIKE xmc_file.xmc08       
DEFINE l_xmc09      LIKE xmc_file.xmc09      
DEFINE l_price      LIKE xmc_file.xmc08       
DEFINE l_sql        STRING
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_oea87      LIKE oea_file.oea87
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END
 
    IF SQLCA.SQLCODE THEN
       CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
       RETURN 0 
    END IF
    LET l_dbs = s_dbstring(l_dbs CLIPPED)
    #先取特賣產品價格折扣     
    LET l_sql = "SELECT xmc08,xmc09 ",  
                #"  FROM ",l_dbs,"xmb_file,",l_dbs,"xmc_file ",
                "  FROM ",cl_get_target_table(g_plant_new,'xmb_file'),",", #FUN-A50102
                          cl_get_target_table(g_plant_new,'xmc_file'),     #FUN-A50102
                " WHERE xmb01 = xmc01 AND xmb02 = xmc02 ",
                "   AND xmb03 = xmc03 AND xmb04 = xmc04 ",
                "   AND xmb05 = xmc05 ",  
                "   AND xmc01 = '",p_term,"'",                         #價格條件       
                "   AND xmc02 = '",p_curr,"'",                         #幣別          
                "   AND (xmc04 = '",p_cust,"' OR xmc04 = ' ')",        #客戶編號     
                "   AND (xmc05 = '",p_payment,"' OR xmc05 = ' ')",     #收款條件    
                "   AND xmc06 = '",p_item,"'",                         #料件編號   
                "   AND xmc07 = '",p_unit,"'",                         #單位      
                "   AND xmb03 <= '",p_date,"'",
                "   AND xmb06 >= '",p_date,"'",                       #生效/失效日  
                "   AND xmb00 = '1' ",                  #MOD-9C0173
                " ORDER BY 1,2 "      
    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102   
    PREPARE pre_sel_xmbc FROM l_sql
    DECLARE x1_curs CURSOR FOR pre_sel_xmbc
    IF STATUS THEN      
       CALL cl_err('x1_curs',STATUS,1) RETURN 0
    END IF 
    FOREACH x1_curs INTO l_xmc08,l_xmc09                                                                                              
       IF STATUS THEN CALL cl_err('sel xmc',STATUS,1) RETURN 0 END IF                                                               
       IF cl_null(l_xmc08) THEN LET l_xmc08 = 0 END IF                                                                                
       IF cl_null(l_xmc09) THEN LET l_xmc09 = 0 END IF                                                                                
       LET l_price = (l_xmc08 * l_xmc09)/100
    END FOREACH
    IF l_price IS NULL THEN LET l_price = 0 END IF
   #記錄折價
   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
   LET l_rxc.rxc01 = p_no
   LET l_rxc.rxc02 = p_line
   LET l_rxc.rxc03 = '10'
   LET l_rxc.rxc04 = ' '
   LET l_rxc.rxc05 = ''
   LET l_rxc.rxc06 = (p_price - l_price)*p_count
   LET l_rxc.rxc07 = 0
   LET l_rxc.rxc08 = ''
   LET l_rxc.rxc09 = '0'
   LET l_rxc.rxc10 = ''
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   LET l_rxc.rxc11 = g_member
   LET l_rxc.rxcplant = p_plant
   LET l_rxc.rxc15 = p_count        #FUN-AA0065
   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
               "     AND rxc01 = '",l_rxc.rxc01,"'",
               "     AND rxc02 = '",l_rxc.rxc02,"'",
               "     AND rxc03 = '",l_rxc.rxc03,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_del_rxc1 FROM l_sql
   EXECUTE pre_del_rxc1
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
               "rxc07,rxc08,rxc09,rxc10,rxcplant,rxclegal,rxc11,rxc12,rxc13,rxc14,rxc15)",  #FUN-AA0065
               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"   #FUN-AA0065
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_ins_rxc15 FROM l_sql
   EXECUTE pre_ins_rxc15 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,   #FUN-AA0065
                               l_rxc.rxc07,l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc11,         #FUN-AA0065
                               l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15  #FUN-AA0065                                                  #FUN-AA0065 
   IF SQLCA.SQLCODE THEN 
      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
      RETURN 0 
   END IF
   RETURN l_price
END FUNCTION
FUNCTION s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,p_price,p_type)
DEFINE p_cust       LIKE tqo_file.tqo01,     #客戶編號
       p_item       LIKE tqn_file.tqn03,     #料件編號
       p_unit       LIKE tqn_file.tqn04,     #單位
       p_date       LIKE type_file.dat,      #日期
       p_type       LIKE type_file.chr1,     #單據類型
       p_curr       LIKE azi_file.azi01,     #幣別
       p_plant      LIKE azp_file.azp01,     #機構別
       p_count      LIKE oeb_file.oeb12,     #數量
       p_no         LIKE oeb_file.oeb01,     #單號
       p_line       LIKE oeb_file.oeb03,     #項次
       p_price      LIKE oeb_file.oeb13,     #價格
       p_term       LIKE oah_file.oah01,     #價格條件
       p_payment    LIKE oea_file.oea32      #付款條件
DEFINE l_sql        STRING
DEFINE l_xmc08      LIKE xmc_file.xmc08      #數量
DEFINE l_xmc09      LIKE xmc_file.xmc09      #折扣
DEFINE l_cn         LIKE type_file.num5
DEFINE l_dbs        LIKE azp_file.azp03
DEFINE l_rxc        RECORD LIKE rxc_file.*
DEFINE l_oea87      LIKE oea_file.oea87
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 'N',0 
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   #取特賣產品價格折扣
   #LET l_sql = "SELECT xmc08,xmc09 FROM ",l_dbs,"xmb_file,",l_dbs,"xmc_file ",
#  LET l_sql = "SELECT xmc08,xmc09 FROM ",cl_get_target_table(g_plant_new,'xmb_file'),",", #FUN-A50102 #MOD-B30234
#                                         cl_get_target_table(g_plant_new,'xmc_file'),     #FUN-A50102 #MOD-B30234
   LET l_sql = "SELECT xmd08,xmd09 FROM ",cl_get_target_table(g_plant_new,'xmb_file'),",", #MOD-B30234
                                          cl_get_target_table(g_plant_new,'xmd_file'),     #MOD-B30234
#MOD-B30234 --Begin mark
#              "   WHERE xmb01 = xmc01 AND xmb02 = xmc02 ",
#              "     AND xmb03 = xmc03 AND xmb04 = xmc04 ",
#              "     AND xmb05 = xmc05 AND xmc01 = '",p_term,"'",         #價格條件
#              "     AND xmc02 = '",p_curr,"' ",                          #幣別
#              "     AND (xmc04 = '",p_cust,"' OR xmc04 = ' ') ",         #客戶編號
#              "     AND (xmc05 = '",p_payment,"' OR xmc05 = ' ')",       #收款條件
#              "     AND xmc06 = '",p_item,"' AND xmc07 = '",p_unit,"'",  
#              "     AND xmb03 <= '",p_date,"' AND xmb06 >= '",p_date,"'",
#              "     AND xmb00 = '2' ",  #MOD-9C0173
#              "  ORDER BY xmc08 DESC"
#MOD-B30234 --End mark
#MOD-B30234 --Begin
               "   WHERE xmb01 = xmd01 AND xmb02 = xmd02 ",
               "     AND xmb03 = xmd03 AND xmb04 = xmd04 ",
               "     AND xmb05 = xmd05 AND xmd01 = '",p_term,"'",         #價格條件
               "     AND xmd02 = '",p_curr,"' ",                          #幣別
               "     AND (xmd04 = '",p_cust,"' OR xmd04 = ' ') ",         #客戶編號
               "     AND (xmd05 = '",p_payment,"' OR xmd05 = ' ')",       #收款條件
               "     AND xmd06 = '",p_item,"' AND xmd07 = '",p_unit,"'",  
               "     AND xmb03 <= '",p_date,"' AND xmb06 >= '",p_date,"'",
               "     AND xmb00 = '2' ",
               "  ORDER BY xmd08 DESC"
#MOD-B30234 --End
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_xmc11 FROM l_sql
   DECLARE x9_curs CURSOR FOR pre_sel_xmc11
   LET l_cn = 0
 
   FOREACH x9_curs INTO l_xmc08,l_xmc09
      IF STATUS THEN CALL cl_err('sel xmg',STATUS,1) RETURN 100 END IF
      IF l_xmc08 IS NULL THEN LET l_xmc08 = 0 END IF
      IF p_count >= l_xmc08 THEN
         LET l_cn = 1
         EXIT FOREACH
      END IF 
   END FOREACH
   IF l_cn = 0 THEN RETURN 100 END IF
   IF l_xmc09 IS NULL THEN RETURN 100 END IF
 
   #記錄折價
   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
   LET l_rxc.rxc01 = p_no
   LET l_rxc.rxc02 = p_line
   LET l_rxc.rxc03 = '11'
   LET l_rxc.rxc04 = ' '
   LET l_rxc.rxc05 = ''
   LET l_rxc.rxc06 = (p_price*(100-l_xmc09)/100)*p_count
   LET l_rxc.rxc07 = 0
   LET l_rxc.rxc08 = ''
   LET l_rxc.rxc09 = '0'
   LET l_rxc.rxc10 = ''
   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
   LET l_rxc.rxc11 = g_member
   LET l_rxc.rxcplant = p_plant
   LET l_rxc.rxc15 = p_count  #FUN-AB0102
   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
#FUN-AB0102 --add--begin   
   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
               "     AND rxc01 = '",l_rxc.rxc01,"'",
               "     AND rxc02 = '",l_rxc.rxc02,"'",
               "     AND rxc03 = '",l_rxc.rxc03,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
   PREPARE pre_del_rxc11 FROM l_sql
   EXECUTE pre_del_rxc11
#FUN-AB0102 ---add---end--   
   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
               "rxc07,rxc08,rxc09,rxc10,rxcplant,rxclegal,rxc11,rxc12,rxc13,rxc14,rxc15)",  #FUN-AB0102
               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?)"   #FUN-AB0102
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_ins_rxc17 FROM l_sql
   EXECUTE pre_ins_rxc17 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04,l_rxc.rxc05,l_rxc.rxc06,   #FUN-AA0065
                               l_rxc.rxc07,l_rxc.rxc08,l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxcplant,l_rxc.rxclegal,l_rxc.rxc11,         #FUN-AA0065
                               l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14,l_rxc.rxc15    #FUN-AB0102                                               #FUN-AA0065 
   IF SQLCA.SQLCODE THEN 
      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
      RETURN 0 
   END IF
   RETURN l_xmc09
END FUNCTION
FUNCTION s_fetch_price_new1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd)
DEFINE p_cust       LIKE tqo_file.tqo01,     #客戶編號
       p_item       LIKE tqn_file.tqn03,     #料件編號
       p_unit       LIKE tqn_file.tqn04,     #單位
       p_date       LIKE type_file.dat,      #日期
       p_type       LIKE type_file.chr1,     #單據類型
       p_cmd        LIKE type_file.chr1,     #用戶動作
       p_curr       LIKE azi_file.azi01,     #幣別
       p_plant      LIKE azp_file.azp01,     #機構別
       p_term       LIKE oah_file.oah01,     #價格條件
       p_payment    LIKE oea_file.oea32,     #付款條件
       p_no1        LIKE tqx_file.tqx01,     #提案單號
       p_no         LIKE oea_file.oea01,     #單據編號
       p_line       LIKE oeb_file.oeb03,     #項次
       p_count      LIKE xmd_file.xmd08,     #料件數量
       l_success    LIKE type_file.chr1
DEFINE l_dbs       LIKE azp_file.azp03
DEFINE l_sql       STRING
DEFINE l_n         LIKE type_file.num5
DEFINE l_price     LIKE oeb_file.oeb13
DEFINE l_a2_price  LIKE oeb_file.oeb13       #TQC-B60015 ADD
DEFINE l_ohi03     LIKE ohi_file.ohi03
DEFINE l_ohi02     LIKE ohi_file.ohi02
DEFINE l_ohi04     LIKE ohi_file.ohi04
DEFINE l_rate1     LIKE xmh_file.xmh03
DEFINE l_rate2     LIKE xmh_file.xmh03
DEFINE l_rate      LIKE xmh_file.xmh03
DEFINE l_no        LIKE oea_file.oea01
#DEFINE l_rzz03     LIKE rzz_file.rzz03      #FUN-AB0083 mark
DEFINE l_oah04     LIKE oah_file.oah04
DEFINE l_oah05     LIKE oah_file.oah05
DEFINE l_oah06     LIKE oah_file.oah06
DEFINE l_c1_price  LIKE oeb_file.oeb13
DEFINE l_c2_price  LIKE oeb_file.oeb13
DEFINE l_c3_price  LIKE oeb_file.oeb13
DEFINE l_c4_rate  LIKE oeb_file.oeb13
DEFINE l_a1_price  LIKE oeb_file.oeb13
DEFINE l_old_price  LIKE oeb_file.oeb13
DEFINE l_b1_flag   LIKE type_file.chr1
DEFINE l_b2_flag   LIKE type_file.chr1
DEFINE l_c1_flag   LIKE type_file.chr1
DEFINE l_c2_flag   LIKE type_file.chr1
DEFINE l_c3_flag   LIKE type_file.chr1
DEFINE l_c4_flag   LIKE type_file.chr1
DEFINE l_sum       LIKE rxc_file.rxc06
DEFINE l_rxc00     LIKE rxc_file.rxc00
DEFINE l_oeb03     LIKE oeb_file.oeb03
 
   WHENEVER ERROR CONTINUE
 
   IF p_count = 0 THEN RETURN 0 END IF
   IF p_item IS NULL THEN RETURN 0 END IF
   IF p_unit IS NULL THEN RETURN 0 END IF
  #FUN-9C0068   ---start
  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra
  #FUN-9C0068   ---END

   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
      RETURN 0
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   #判斷價格條件是否存在
   #FUN-9C0068   ---start
   IF cl_null(p_term) THEN
      #LET l_sql = "SELECT occ44 FROM ",l_dbs,"occ_file ",
      LET l_sql = "SELECT occ44 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  " WHERE occ01 = '",p_cust,"' ",
                  "   AND occ1004='1' ",
                  "   AND occacti='Y' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
      PREPARE pre_sel_occ2 FROM l_sql
      EXECUTE pre_sel_occ2 INTO p_term
      IF SQLCA.SQLCODE THEN
         CALL cl_err('sel occ_file','sub-221',1)
         RETURN 0
      END IF
   END IF
  #FUN-9C0068    ---end
 
   #LET l_sql = "SELECT oah04,oah05,oah06 FROM ",l_dbs,"oah_file ",
   LET l_sql = "SELECT oah04,oah05,oah06 FROM ",cl_get_target_table(g_plant_new,'oah_file'), #FUN-A50102
               "   WHERE oah01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_oah1 FROM l_sql
   EXECUTE pre_sel_oah1 INTO l_oah04,l_oah05,l_oah06 
   IF SQLCA.SQLCODE THEN
     #CALL cl_err('sel oah_file',SQLCA.SQLCODE,1) #FUN-9C0068
      CALL cl_err('sel oah_file','sub-221',1) #FUN-9C0068
      RETURN 0
   END IF
 
   IF l_oah04 IS NULL THEN LET l_oah04 = ' ' END IF
   IF l_oah05 IS NULL THEN LET l_oah05 = ' ' END IF
   IF l_oah06 IS NULL THEN LET l_oah06 = ' ' END IF
 
   LET l_old_price = 0
   LET l_c1_price = 0
   LET l_c2_price = 0
   LET l_c3_price = 0
   LET l_c4_rate = 100
   LET l_rate = 100
   LET l_rate1 = 100
   LET l_rate2 = 100
   LET l_price = 0 
   LET l_a1_price = 0 
   LET g_leater_price = 0
   LET l_b1_flag = 'N'
   LET l_b2_flag = 'N'
   LET l_c1_flag = 'N'
   LET l_c2_flag = 'N'
   LET l_c3_flag = 'N'
   LET l_c4_flag = 'N'
   #LET l_sql = "SELECT COUNT(*) FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "  WHERE ohi01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
   PREPARE pre_sel_ohi10 FROM l_sql
   EXECUTE pre_sel_ohi10 INTO l_n
   IF l_n IS NULL OR l_n = 0 THEN
      CALL cl_err('','',1)
      RETURN 0
   END IF
   #取出指定價格條件的各個組
   #LET l_sql = "SELECT ohi02 FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT ohi02 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "   WHERE ohi01 = '",p_term,"'",
               "     GROUP BY ohi02 "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE pre_sel_ohi11 FROM l_sql
   DECLARE ohi11_cur CURSOR FOR pre_sel_ohi11
   LET l_price = 0
   FOREACH ohi11_cur INTO l_ohi02
      #LET l_c1_price = 0
      #LET l_c2_price = 0
      #LET l_c3_price = 0
      #LET l_c4_rate = 0
      #LET l_rate = 0
      #LET l_rate1 = 0
      #LET l_rate2 = 0
      #LET l_price = 0 
      IF l_ohi02 IS NULL THEN CONTINUE FOREACH END IF
      #LET l_sql = "SELECT ohi03 FROM ",l_dbs,"ohi_file ",
      LET l_sql = "SELECT ohi03 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
                  "   WHERE ohi01 ='",p_term,"'",
                  "     AND ohi02 ='",l_ohi02,"'",
                  "     ORDER BY ohi03 "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
      PREPARE pre_sel_ohi031 FROM l_sql
      DECLARE cur_ohi031 CURSOR FOR pre_sel_ohi031
      FOREACH cur_ohi031 INTO l_ohi03
         IF l_ohi03 IS NULL THEN CONTINUE FOREACH END IF
         #取出價格代碼
         #LET l_sql = "SELECT ohi04 FROM ",l_dbs,"ohi_file ",
         LET l_sql = "SELECT ohi04 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
                     "   WHERE ohi01 = '",p_term,"'",
                     "     AND ohi02 = '",l_ohi02,"'",
                     "     AND ohi03 = '",l_ohi03,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
         PREPARE pre_sel_ohi041 FROM l_sql
         EXECUTE pre_sel_ohi041 INTO l_ohi04
         #根據價格代碼取出價格的類別
         #LET l_sql = "SELECT rzz03 FROM ",l_dbs,"rzz_file ",
         #            "   WHERE rzz00 = '2' AND rzz01 = '",l_ohi04,"'"
         #PREPARE pre_sel_rzz031 FROM l_sql
         #EXECUTE pre_sel_rzz031 INTO l_rzz03
         #B/C類型價格不互斥
         IF l_oah05 = 'N' THEN
            IF l_oah06 = 'N' THEN    #同組同類型價格不互斥
               #B/C類型價格不互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1'
                     CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                        RETURNING l_rate
                  WHEN l_ohi04 = 'B2'
                     CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                        RETURNING l_rate1,l_rate2
                  WHEN l_ohi04 = 'C1'
                     CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
#                       RETURNING l_price     #MOD-B30234
                        RETURNING l_c1_price  #MOD-B30234
                  WHEN l_ohi04 = 'C2'
                     CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
#                       RETURNING l_price     #MOD-B30234
                        RETURNING l_c2_price  #MOD-B30234
                  WHEN l_ohi04 = 'C3' 
                     CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
#                       RETURNING l_price     #MOD-B30234
                        RETURNING l_c3_price  #MOD-B30234
                  WHEN l_ohi04 = 'C4'
                     CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
#                       RETURNING l_price #MOD-B30234
                        RETURNING l_c4_rate #MOD-B30234
               END CASE
            ELSE                     #同組價格互斥
               #B/C類型價格不互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)  #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2' 
                     IF l_b1_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                      END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_c2_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2' 
                     IF l_c1_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         ELSE     #B/C類型價格互斥
            IF l_oah06 = 'Y' THEN    #同組價格互斥
               #B/C類型價格互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_b1_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            ELSE                     #同組價格不互斥
               #B/C類型價格互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)    #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_c2_price
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         END IF
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' THEN  #MOD-9C0173
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN  #MOD-9C0173 #TQC-B60015 MARK
         IF l_ohi04 = 'A1' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN #TQC-B60015 ADD
            LET l_a1_price = l_price
         END IF
###TQC-B60015 - ADD - BEGIN ------------------------------------
         IF l_ohi04 = 'A2' THEN
            LET l_a1_price = l_a2_price
         END IF
###TQC-B60015 - ADD -  END  ------------------------------------
         IF l_c1_price != 0 THEN LET l_price = l_c1_price END IF
         IF l_c2_price != 0 THEN LET l_price = l_c2_price END IF
         IF l_c3_price != 0 THEN LET l_price = l_c3_price END IF
         IF l_c4_rate != 0 THEN LET l_price = l_price*l_c4_rate/100 END IF
         IF l_rate != 0 THEN LET l_price = l_price*l_rate/100 END IF
         IF l_rate1 != 0 THEN LET l_price = l_price*l_rate1/100 END IF
         IF l_rate2 != 0 THEN LET l_price = l_price*l_rate2/100 END IF
         IF l_ohi04 != 'B1' AND l_ohi04 != 'B2' AND l_ohi04 != 'C4' AND l_price != 0 THEN
            LET g_leater_price = l_price
         END IF
         IF l_price = 0 THEN LET l_price = l_old_price END IF
         IF l_price != 0 AND l_price IS NOT NULL THEN LET l_old_price = l_price END IF
         IF l_rate != 100 AND l_rate != 0 THEN      #表示已取到B1類價格
            LET l_b1_flag = 'Y'
         END IF
         #若B2類價格已經取到
         IF l_rate1 != 100 OR l_rate2 != 100 THEN
            LET l_b2_flag = 'Y'
         END IF
	 IF l_c1_price != 0 THEN LET l_c1_flag = 'Y' END IF
         IF l_c2_price != 0 THEN LET l_c2_flag = 'Y' END IF
         IF l_c3_price != 0 THEN LET l_c3_flag = 'Y' END IF
         IF l_c4_rate != 100 THEN LET l_c4_flag = 'Y' END IF
         LET l_rate = 100
         LET l_rate1 = 100
         LET l_rate2 = 100
         LET l_c1_price = 0 
         LET l_c2_price = 0 
         LET l_c3_price = 0 
         LET l_c4_rate = 100 
      END FOREACH
      IF l_price != 0 THEN EXIT FOREACH END IF
   END FOREACH
   RETURN l_a1_price 
END FUNCTION

#FUN-AA0065  ---begin--mark
##No.FUN-A10106 --begin
##從價格區間促銷單取出商品價格
#FUNCTION s_price3(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team)
#DEFINE p_cust       LIKE occ_file.occ01
#DEFINE p_team       LIKE ohi_file.ohi02
#DEFINE p_item       LIKE ima_file.ima01
#DEFINE p_unit       LIKE ima_file.ima25
#DEFINE p_date       LIKE type_file.dat
#DEFINE p_term       LIKE oah_file.oah01
#DEFINE p_curr       LIKE azi_file.azi01
#DEFINE p_no         LIKE oea_file.oea01
#DEFINE p_line       LIKE oeb_file.oeb03
#DEFINE p_price      LIKE oeb_file.oeb13
#DEFINE p_type       LIKE type_file.chr1
#DEFINE p_flag       LIKE type_file.chr1
#DEFINE p_count      LIKE oeb_file.oeb12
#DEFINE p_plant      LIKE azp_file.azp01
#DEFINE l_dbs        LIKE azp_file.azp03
#DEFINE l_oea87      LIKE oea_file.oea87
#DEFINE l_time       LIKE type_file.chr8
#DEFINE l_sql        STRING
#DEFINE l_rwc13      LIKE rwc_file.rwc13
#DEFINE l_rwc15      LIKE rwc_file.rwc15
#DEFINE l_price      LIKE oeb_file.oeb13
#DEFINE l_lph04      LIKE lph_file.lph04
#DEFINE l_lph05      LIKE lph_file.lph05
#DEFINE l_lph06      LIKE lph_file.lph06
#DEFINE l_lph08      LIKE lph_file.lph08
#DEFINE l_rwd08      LIKE rwd_file.rwd08
#DEFINE l_rwd09      LIKE rwd_file.rwd09
#DEFINE l_rxc        RECORD LIKE rxc_file.*
#DEFINE l_rwe04      LIKE rwe_file.rwe04
#DEFINE l_rwe08      LIKE rwe_file.rwe08
#DEFINE l_rwe09      LIKE rwe_file.rwe09
#DEFINE l_rwe10      LIKE rwe_file.rwe10
#DEFINE l_rwe11      LIKE rwe_file.rwe11
#DEFINE l_rwe12      LIKE rwe_file.rwe12
#DEFINE l_rtv13      LIKE rtv_file.rtv13
#DEFINE l_rty05      LIKE rty_file.rty05
#DEFINE l_rtv01      LIKE rtv_file.rtv01
#DEFINE l_rtv02      LIKE rtv_file.rtv02
#DEFINE l_baseprice  LIKE oeb_file.oeb13
#DEFINE l_amt        LIKE rxc_file.rxc06
#DEFINE l_success    LIKE type_file.chr1

#   LET g_plant_new = p_plant
#   CALL s_gettrandbs()
#   LET l_dbs=g_dbs_tra

#   IF SQLCA.SQLCODE THEN
#      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   LET l_dbs = s_dbstring(l_dbs CLIPPED)
#   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
#   LET l_time = TIME
      
#   CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
#               RETURNING l_baseprice
   
#   #LET l_sql = " SELECT DISTINCT rwe04,rwe08,rwe09,rwe10,rwe11,rwe12 FROM ",l_dbs,"rwb_file,",l_dbs,
#   #           "rwq_file,",l_dbs,"rwe_file,",l_dbs,"rwo_file WHERE rwb01=rwq01 " ,
#   LET l_sql = " SELECT DISTINCT rwe04,rwe08,rwe09,rwe10,rwe11,rwe12 FROM ",cl_get_target_table(g_plant_new,'rwb_file'),",", #FUN-A50102
#                                                                            cl_get_target_table(g_plant_new,'rwq_file'),",", #FUN-A50102
#                                                                            cl_get_target_table(g_plant_new,'rwe_file'),",", #FUN-A50102
#                                                                            cl_get_target_table(g_plant_new,'rwo_file'),     #FUN-A50102
#              " WHERE rwb01=rwq01 " ,
#              " AND rwb02=rwq02 AND rwb03=rwq03 AND rwb04=rwq04 AND rwbplant=rwqplant ",
#              " AND rwb01=rwe01 AND rwb02=rwe02 AND rwb03=rwe03 AND rwb04=rwe04 ",
#              " AND rwbplant=rweplant AND rwo01=rwb01 AND rwo02=rwb02 AND rwo03=rwb03 ",
#              " AND rwo04=rwb04 AND rwoplant=rwbplant AND rwbconf='Y' AND ((rwb14='1' AND rwb15 ='1' ",
#              #" AND (SELECT count(*) FROM ",l_dbs,"rwo_file WHERE rwo07='",p_item,"')>0)",
#              #"  OR (rwb14='1' AND rwb15='2' AND (SELECT count(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file ",
#              " AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE rwo07='",p_item,"')>0)",
#              "  OR (rwb14='1' AND rwb15='2' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                         cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)>0) OR (rwb14='3') ",
#              #" OR (rwb14='2' AND rwb15 ='1' AND (SELECT count(*) FROM ",l_dbs,"rwo_file WHERE",
#              #" rwo07='",p_item,"')=0) OR (rwb14='2' AND rwb15='2' AND (SELECT count(*) FROM ",l_dbs,
#              #"rwo_file,",l_dbs,"ima_file WHERE ima01='",p_item,"' AND ima131=rwo07)=0)) AND rwq06 ='",p_plant,"' ",
#              " OR (rwb14='2' AND rwb15 ='1' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE",
#              " rwo07='",p_item,"')=0) OR (rwb14='2' AND rwb15='2' AND (SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                                               cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)=0)) AND rwq06 ='",p_plant,"' ",
#              " AND ('",l_baseprice,"' between rwe06 AND rwe07 ) AND ('",p_date,"' between rwe14 AND rwe15)  ",
#              " AND ('",l_time,"' between rwe16 AND rwe17) "
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
#   PREPARE pre_sel_rwe04 FROM l_sql
#   EXECUTE pre_sel_rwe04 INTO l_rwe04,l_rwe08,l_rwe09,l_rwe10,l_rwe11,l_rwe12
#   IF SQLCA.SQLCODE THEN
#      IF SQLCA.SQLCODE = -284 THEN
#         CALL cl_err('','axm-543',1)
#         RETURN 'N',0
#      END IF
#      RETURN 'N',0  
#   END IF
#   IF l_rwe11 IS NULL THEN LET l_rwe11 = 0 END IF
#   IF l_rwe12 IS NULL THEN LET l_rwe12 = 0 END IF
#   IF l_rwe09 IS NULL THEN LET l_rwe09 =100 END IF
#   IF l_rwe10 IS NULL THEN LET l_rwe10 =100 END IF
#   IF cl_null(l_oea87) THEN   #不是會員
#      IF l_rwe08 = '3' THEN    #折價
#         LET l_price = l_rwe11
#      END IF 
#      IF l_rwe08='2' THEN 
#         LET l_price=(p_price*l_rwe09)/100
#      END IF 
#   ELSE                       #是會員
#      SELECT lph04,lph05,lph06,lph08 INTO l_lph04,l_lph05,l_lph06,l_lph08 
#         FROM lph_file
#        WHERE lph01=(SELECT lpj02 FROM lpj_file WHERE lpj03=l_oea87)
#      IF l_lph04 IS NULL THEN LET l_lph04 = 'N' END IF
#      IF l_lph05 IS NULL THEN LET l_lph05 = 'N' END IF
#      IF l_lph08 IS NULL THEN LET l_lph08 = 100 END IF
#      IF l_lph04 = 'Y' THEN
#         IF l_rwe08 = '3' THEN    #會員特價
#            LET l_price = l_rwe12 
#         END IF 
#         IF l_rwe08='2' THEN 
#            LET l_price=(p_price*l_rwe10)/100
#         END IF 
#      END IF
#      IF l_lph05 = 'Y' THEN  #該會員的卡是可折扣的卡,取基礎價格
##         CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
##            RETURNING l_price
##         LET l_price = (l_price*l_lph08)/100
#          LET l_amt=l_baseprice*p_count
#          CALL s_discount_amt(l_oea87,p_item,l_amt) RETURNING l_success,l_amt
#      END IF
#  END IF
#   #記錄折價
#  IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
#   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
#   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
##   IF p_flag = '1' THEN
##      IF l_price != 0 THEN
##         LET l_sql = "DELETE FROM ",l_dbs,"rxc_file WHERE rxc00 = '",l_rxc.rxc00,"'",
##                     "   AND rxc01 = '",p_no,"' AND rxc02 = '",p_line,"'",
##                     "   AND rxc03 IN ('07','08','11') "
##         PREPARE pre_del_rxc6 FROM l_sql
##         EXECUTE pre_del_rxc6
##         LET p_price = g_leater_price
##      END IF
##   END IF
#   #從促銷協議中抓廠商分攤比率
#   #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
#   LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
#                                                       cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
#               " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '3' ",
#               "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
#               "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
#               "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'",
#               "   AND rtu08='",l_rwe04,"' "
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
#   PREPARE pre_sel3_rtv14 FROM l_sql
#   EXECUTE pre_sel3_rtv14 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
#   IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
#      SELECT rty05 INTO l_rty05 FROM rty_file 
#         WHERE rty01 = p_plant AND rty02 = p_item
#      #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
#      LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
#                  "   WHERE A.rto05 = '",l_rty05,"'",
#                  "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
#                  "     AND A.rtoplant = '",p_plant,"'",
#                  "     AND A.rtoconf = 'Y' ",
#                  #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
#                  "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
#                  "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102  
#      PREPARE pre_sel_rto14 FROM l_sql
#      EXECUTE pre_sel_rto14 INTO l_rtv01,l_rtv02,l_rtv13
#   END IF
#   IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
#   LET l_rxc.rxc01 = p_no
#   LET l_rxc.rxc02 = p_line
#   LET l_rxc.rxc03 = '03'
#   LET l_rxc.rxc04 = l_rwe04
#   LET l_rxc.rxc05 = ''
#   IF NOT cl_null(l_oea87) THEN 
#      IF l_lph05 = 'Y' THEN
#         LET l_rxc.rxc06=l_amt
#      ELSE 
#         LET l_rxc.rxc06 = (p_price - l_price)*p_count
#      END IF 
#   ELSE 
#      LET l_rxc.rxc06 = (p_price - l_price)*p_count
#   END IF 
#   LET l_rxc.rxc07 = l_rtv13
#   LET l_rxc.rxc08 = ''
#   LET l_rxc.rxc09 = '0'
#   LET l_rxc.rxc10 = 0
#   LET l_rxc.rxc11 = g_member   #是否會員
#   LET l_rxc.rxc12 = l_rtv02
#   LET l_rxc.rxc13 = l_rty05
#   LET l_rxc.rxc14 = l_rtv01
#   LET l_rxc.rxcplant = p_plant
#   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
#   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
#   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
#               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
#               "     AND rxc01 = '",l_rxc.rxc01,"'",
#               "     AND rxc02 = '",l_rxc.rxc02,"'",
#               "     AND rxc03 = '",l_rxc.rxc03,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
#   PREPARE pre_del_rxc53 FROM l_sql
#   EXECUTE pre_del_rxc53
#   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
#   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
#               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
#               "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
#               "rxc12,rxc13,rxc14) ",
#               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
#   PREPARE pre_ins_rxc143 FROM l_sql
#   EXECUTE pre_ins_rxc143 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, #No.FUN-9B0157
#                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
#                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
#                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14
#   IF SQLCA.SQLCODE THEN 
#      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   RETURN 'Y',l_price
#END FUNCTION

#從滿額促銷單取出商品價格
#FUNCTION s_price5(p_cust,p_item,p_unit,p_date,p_no,p_line,p_price,p_type,p_plant,p_term,p_curr,p_count,p_team)
#DEFINE p_cust       LIKE occ_file.occ01
#DEFINE p_team       LIKE ohi_file.ohi02
#DEFINE p_item       LIKE ima_file.ima01
#DEFINE p_unit       LIKE ima_file.ima25
#DEFINE p_date       LIKE type_file.dat
#DEFINE p_term       LIKE oah_file.oah01
#DEFINE p_curr       LIKE azi_file.azi01
#DEFINE p_no         LIKE oea_file.oea01
#DEFINE p_line       LIKE oeb_file.oeb03
#DEFINE p_price      LIKE oeb_file.oeb13
#DEFINE p_type       LIKE type_file.chr1
#DEFINE p_flag       LIKE type_file.chr1
#DEFINE p_count      LIKE oeb_file.oeb12
#DEFINE p_plant      LIKE azp_file.azp01
#DEFINE l_dbs        LIKE azp_file.azp03
#DEFINE l_oea87      LIKE oea_file.oea87
#DEFINE l_time       LIKE type_file.chr8
#DEFINE l_sql        STRING
#DEFINE l_sql1       STRING 
#DEFINE l_rwc13      LIKE rwc_file.rwc13
#DEFINE l_rwc15      LIKE rwc_file.rwc15
#DEFINE l_price      LIKE oeb_file.oeb13
#DEFINE l_lph04      LIKE lph_file.lph04
#DEFINE l_lph05      LIKE lph_file.lph05
#DEFINE l_lph06      LIKE lph_file.lph06
#DEFINE l_lph08      LIKE lph_file.lph08
#DEFINE l_rwd08      LIKE rwd_file.rwd08
#DEFINE l_rwd09      LIKE rwd_file.rwd09
#DEFINE l_rxc        RECORD LIKE rxc_file.*
#DEFINE l_rwj        DYNAMIC ARRAY OF RECORD
#                    rwj05   LIKE rwj_file.rwj05,
#                    rwj06   LIKE rwj_file.rwj06
#                    END RECORD
#DEFINE l_rwj01      LIKE rwj_file.rwj01
#DEFINE l_rwj02      LIKE rwj_file.rwj02
#DEFINE l_rwj04      LIKE rwj_file.rwj04
#DEFINE l_rwi10      LIKE rwi_file.rwi10                    
#DEFINE l_rwj07      LIKE rwj_file.rwj07
#DEFINE l_rwj08      LIKE rwj_file.rwj08
#DEFINE l_rwj09      LIKE rwj_file.rwj09
#DEFINE l_rwj10      LIKE rwj_file.rwj10                      
#DEFINE l_rtv13      LIKE rtv_file.rtv13
#DEFINE l_rty05      LIKE rty_file.rty05
#DEFINE l_rtv01      LIKE rtv_file.rtv01
#DEFINE l_rtv02      LIKE rtv_file.rtv02
#DEFINE l_baseprice  LIKE oeb_file.oeb13
#DEFINE l_baseamt    LIKE rxc_file.rxc06
#DEFINE l_success    LIKE type_file.chr1
#DEFINE l_amt        LIKE rxc_file.rxc06
#DEFINE l_bmt        LIKE rxc_file.rxc06
#DEFINE l_cmt        LIKE rxc_file.rxc06
#DEFINE l_n          LIKE type_file.num5
#DEFINE l_a          LIKE type_file.num5
#DEFINE i            LIKE type_file.num5
#DEFINE a            LIKE type_file.num5
#DEFINE b            LIKE type_file.num5
#DEFINE c            LIKE type_file.num5
#DEFINE l_min        LIKE rwj_file.rwj06
#DEFINE l_b          LIKE type_file.num5
#DEFINE l_t          DYNAMIC ARRAY OF RECORD
#                    rwj06  like rwj_file.rwj06
#                    END RECORD
             
#   LET g_plant_new = p_plant
#   CALL s_gettrandbs()
#   LET l_dbs=g_dbs_tra

#   IF SQLCA.SQLCODE THEN
#      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   LET l_dbs = s_dbstring(l_dbs CLIPPED)
#   CALL s_find_member(p_no,p_type,p_plant) RETURNING l_oea87
#   SELECT lph04,lph05,lph06,lph08 INTO l_lph04,l_lph05,l_lph06,l_lph08 
#     FROM lph_file
#    WHERE lph01=(SELECT lpj02 FROM lpj_file WHERE lpj03=l_oea87)
#   IF l_lph04 IS NULL THEN LET l_lph04 = 'N' END IF
#   IF l_lph05 IS NULL THEN LET l_lph05 = 'N' END IF
#   IF l_lph08 IS NULL THEN LET l_lph08 = 100 END IF
#   LET l_time = TIME
      
#   CALL s_base_price(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_team,p_term,p_line,p_no) #MOD-9C0173 
#               RETURNING l_baseprice
#   LET l_baseamt=l_baseprice*p_count  
#   #LET l_sql = " SELECT DISTINCT rwj01,rwj02,rwj04,rwi10 FROM ",l_dbs,"rwi_file,",l_dbs,"rwo_file,",l_dbs,"rwj_file,",l_dbs,"rwq_file",
#   LET l_sql = " SELECT DISTINCT rwj01,rwj02,rwj04,rwi10 FROM ",cl_get_target_table(g_plant_new,'rwi_file'),",", #FUN-A50102
#                                                                cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                cl_get_target_table(g_plant_new,'rwj_file'),",", #FUN-A50102
#                                                                cl_get_target_table(g_plant_new,'rwq_file'),     #FUN-A50102
#              " WHERE rwi01=rwq01 AND rwi02=rwq02 AND rwi03=rwq03 AND rwi04=rwq04 AND rwiplant=rwqplant ",
#              " AND rwi01=rwj01 AND rwi02=rwj02 AND rwi03=rwj03 AND rwi04=rwj04 AND rwiplant=rwjplant ",
#              " AND rwi01=rwo01 AND rwi02=rwo02 AND rwi03=rwo03 AND rwi04=rwo04 AND rwiplant=rwoplant AND rwiconf='Y' ",
#              #" AND ((rwi13='1' AND rwi14='1' AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file WHERE rwo07='",p_item,"')>0) ",
#              " AND ((rwi13='1' AND rwi14='1' AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " WHERE rwo07='",p_item,"')>0) ",
#              #" OR (rwi13='1' AND rwi14='2' AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file ",
#              " OR (rwi13='1' AND rwi14='2' AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                                                        cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01='",p_item,"' AND ima131=rwo07)>0) OR (rwi13='2' AND rwi14='1' AND ",
#              #" (SELECT COUNT(*) FROM ",l_dbs,"rwo_file where rwo07 ='",p_item,"')=0) OR (rwi13='2' AND rwi14='2' ",
#              " (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'), #FUN-A50102
#              " where rwo07 ='",p_item,"')=0) OR (rwi13='2' AND rwi14='2' ",
#              #" AND (SELECT COUNT(*) FROM ",l_dbs,"rwo_file,",l_dbs,"ima_file WHERE ima01 ='",p_item,"' AND ima131=rwo07)=0)",
#              " AND (SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rwo_file'),",", #FUN-A50102
#                                            cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#              " WHERE ima01 ='",p_item,"' AND ima131=rwo07)=0)",
#              " OR (rwi13='3')) AND rwq06='",p_plant,"' AND ('",l_baseamt,"'>=rwj06 ) AND ('",p_date,"' BETWEEN rwi06 AND rwi07)",
#              " AND ('",l_time,"' BETWEEN rwi08 AND rwi09) AND ((rwi10='2') OR (rwi10='3') OR (rwi10='4' AND rwi19='1')",
#              " OR (rwi10='5' AND rwi19='1')) " 
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
#   PREPARE pre_sel_rwj01 FROM l_sql
#   EXECUTE pre_sel_rwj01 INTO l_rwj01,l_rwj02,l_rwj04,l_rwi10
#   IF SQLCA.SQLCODE THEN
#      IF SQLCA.SQLCODE = -284 THEN
#         CALL cl_err('','axm-543',1)
#         RETURN 'N',0
#      END IF
#      RETURN 'N',0  
#   END IF
#   #根據活動代號和促銷單號選出促銷單單身所有的滿額金額
#   LET l_sql1=" SELECT rwj05,rwj06 FROM rwj_file ",
#              " WHERE rwj01='",l_rwj01,"' AND rwj02='",l_rwj02,"' AND rwj03='6' AND rwj04='",l_rwj04,"' "
#   PREPARE pre_sel_rwj011 FROM l_sql1
#   DECLARE cl_sel_rwj011 CURSOR FOR pre_sel_rwj011
#   #當促銷單特價方式為'2'或'3'時才需要算折價金額，贈品時折價金額都為0
#   IF l_rwi10='2' OR l_rwi10='3' THEN 
#      LET l_n=1 
#      FOREACH cl_sel_rwj011 INTO l_rwj[l_n].* 
#          LET l_n=l_n+1 
##          IF l_rwj[l_n].rwj06>l_baseprice THEN 
##             CONTINUE FOREACH 
##          END IF 
#      END FOREACH 
#      CALL l_rwj.deleteElement(l_n)
#      LET l_a=l_rwj.getLength()
#      FOR i=1 TO l_a
#          LET l_t[i].rwj06=l_rwj[i].rwj06
##          LET l_t[i].n=0
#      END FOR 
#      #有多筆滿額金額，需要計算每筆滿額金額的折價次數
#      IF l_a>1 THEN 
#         #排序將最大的滿額金額放在數組的第一位，次大的放在第二位，以此類推
#         FOR a=1 TO l_a
#         FOR b=1 TO l_a-1
#             IF l_t[b].rwj06<l_t[b+1].rwj06 THEN 
#                LET l_min=l_t[b].rwj06
#                LET l_t[b].rwj06=l_t[b+1].rwj06
#                LET l_t[b+1].rwj06=l_min
#             END IF 
#         END FOR 
#         END FOR 
#         LET l_amt=l_baseprice*p_count
#         LET l_bmt=0 
#         #算出每一筆滿額金額的對應的折價次數
#         FOR c=1 TO l_a 
#             LET l_b=l_amt/l_t[c].rwj06
#             IF l_b>=1 THEN 
##                LET l_t[c].n=l_b
#                #根據當前的滿額金額以及對應的折價方式，算出對應的折價金額
#                SELECT rwj07,rwj08,rwj09,rwj10 INTO l_rwj07,l_rwj08,l_rwj09,l_rwj10
#                  FROM rwj_file
#                 WHERE rwj01=l_rwj01 AND rwj02=l_rwj02 AND rwj03='6' AND rwj04=l_rwj04
#                   AND rwj06=l_t[c].rwj06
#                IF cl_null(l_oea87) THEN    #不是會員               
#                   IF l_rwi10 = '3' THEN    #折價                  
#                      LET l_price = l_rwj09
#                      LET l_bmt=l_rwj09*l_b+l_bmt                        
#                   END IF                                          
#                   IF l_rwi10='2' THEN         
#                      LET l_price=(l_t[c].rwj06*l_rwj07)/100                    
#                      LET l_bmt=(l_t[c].rwj06-(l_t[c].rwj06*l_rwj07)/100)*l_b+l_bmt            
#                   END IF        
#                ELSE 
#                   IF l_lph04 = 'Y' THEN       #是會員價
#                      IF l_rwi10 = '3' THEN    #折價                  
#                         LET l_price = l_rwj10
#                         LET l_bmt=l_rwj10*l_b+l_bmt                        
#                      END IF                                          
#                      IF l_rwi10='2' THEN         
#                         LET l_price=(l_t[c].rwj06*l_rwj08)/100                    
#                         LET l_bmt=(l_t[c].rwj06-(l_t[c].rwj06*l_rwj08)/100)*l_b+l_bmt            
#                      END IF      
#                   END IF 
#                END IF
#                #當當前金額大於滿額金額時算出折價的次數和折價后剩餘的金額，再繼續于剩下的滿額金額比較       
#                IF l_b>1 THEN 
#                   LET l_amt=l_amt mod l_t[c].rwj06
#                   CONTINUE FOR 
#                ELSE
#                	 EXIT FOR 
#                END IF 
#             ELSE
#             	  IF c=l_a THEN 
#             	     EXIT FOR 
#             	  ELSE 
#             	  	 CONTINUE FOR
#             	  END IF 
#             END IF 
#         END FOR 
#      ELSE
#      	 #只有一筆滿額金額
#      	 LET l_b=l_amt/l_t[1].rwj06
#         SELECT rwj07,rwj08,rwj09,rwj10 INTO l_rwj07,l_rwj08,l_rwj09,l_rwj10
#           FROM rwj_file
#          WHERE rwj01=l_rwj01 AND rwj02=l_rwj02 AND rwj03='6' AND rwj04=l_rwj04
#            AND rwj06=l_t[1].rwj06
#         IF cl_null(l_oea87) THEN        #不是會員               
#            IF l_rwi10 = '3' THEN        #折價                  
#               LET l_price = l_rwj09
#               LET l_bmt=l_rwj09*l_b                    
#            END IF                                          
#            IF l_rwi10='2' THEN         
#               LET l_price=(l_t[1].rwj06*l_rwj07)/100                    
#               LET l_bmt=(l_t[1].rwj06-(l_t[1].rwj06*l_rwj07)/100)*l_b          
#            END IF        
#         ELSE 
#         	  IF l_lph04 = 'Y' THEN         #是會員價
#         	     IF l_rwi10 = '3' THEN      #折價                  
#                   LET l_price = l_rwj10
#                   LET l_bmt=l_rwj10*l_b                       
#                END IF                                          
#                IF l_rwi10='2' THEN                         
#                   LET l_price=(l_t[1].rwj06*l_rwj07)/100      
#                   LET l_bmt=(l_t[1].rwj06-(l_t[1].rwj06*l_rwj08)/100)*l_b          
#                END IF      
#         	  END IF 
#         END IF 
#      END IF   
#   END IF 
##   IF l_rwe11 IS NULL THEN LET l_rwe11 = 0 END IF
##   IF l_rwe12 IS NULL THEN LET l_rwe12 = 0 END IF
##   IF l_rwe09 IS NULL THEN LET l_rwe09 =100 END IF
##   IF l_rwe10 IS NULL THEN LET l_rwe10 =100 END IF
#   #該會員的卡是可折扣的卡,取基礎價格
#   IF NOT cl_null(l_oea87) THEN 
#      IF l_lph05 = 'Y' THEN 
#         LET l_cmt=l_baseprice*p_count
#         CALL s_discount_amt(l_oea87,p_item,l_cmt) RETURNING l_success,l_cmt
#      END IF 
#   END IF 
#   #記錄折價
#   IF p_type = '1' THEN LET l_rxc.rxc00 = '01' END IF
#   IF p_type = '2' THEN LET l_rxc.rxc00 = '02' END IF
#   IF p_type = '3' THEN LET l_rxc.rxc00 = '03' END IF
#   #從促銷協議中抓廠商分攤比率
#   #LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",l_dbs,"rtu_file,",l_dbs,"rtv_file ",
#   LET l_sql = "SELECT rtv01,rtv02,rtv13,rtu05, FROM ",cl_get_target_table(g_plant_new,'rtu_file'),",", #FUN-A50102
#                                                       cl_get_target_table(g_plant_new,'rtv_file'),     #FUN-A50102
#               " WHERE rtu01=rtv01 AND rtu02 = rtv02 AND rtu07 = '6' ",
#               "   AND '",p_date,"' BETWEEN rtu09 AND rtu10 AND rtu11>'",p_date,"'",
#               "   AND rtv04 = '",p_item,"' AND rtv14 = '",p_unit,"'",
#               "   AND rtuplant = rtvplant AND rtuplant = '",p_plant,"'",
#               "   AND rtu08='",l_rwj10,"' "
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
#   PREPARE pre_sel3_rtv15 FROM l_sql
#   EXECUTE pre_sel3_rtv15 INTO l_rtv01,l_rtv02,l_rtv13,l_rty05 
#   IF cl_null(l_rtv13) OR l_rtv13 = 0 THEN
#      SELECT rty05 INTO l_rty05 FROM rty_file 
#         WHERE rty01 = p_plant AND rty02 = p_item
#      #LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",l_dbs,"rto_file A",
#      LET l_sql = "SELECT A.rto01,A.rto03,A.rto12 FROM ",cl_get_target_table(g_plant_new,'rto_file A'), #FUN-A50102
#                  "   WHERE A.rto05 = '",l_rty05,"'",
#                  "     AND '",p_date,"' BETWEEN A.rto08 AND A.rto09 ",
#                  "     AND A.rtoplant = '",p_plant,"'",
#                  "     AND A.rtoconf = 'Y' ",
#                  #"     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",l_dbs,"rto_file B ",
#                  "     AND A.rto02 = (SELECT MAX(B.rto02) FROM ",cl_get_target_table(g_plant_new,'rto_file B '), #FUN-A50102
#                  "    WHERE A.rto01=B.rto01 AND A.rto03=B.rto03 AND A.rtoplant = B.rtoplant "
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
#      PREPARE pre_sel_rto15 FROM l_sql
#      EXECUTE pre_sel_rto15 INTO l_rtv01,l_rtv02,l_rtv13
#   END IF
#   IF l_rtv13 IS NULL THEN LET l_rtv13 = 0 END IF
#   LET l_rxc.rxc01 = p_no
#   LET l_rxc.rxc02 = p_line
#   IF l_rwi10='4' OR l_rwi10='5' THEN 
#      LET l_rxc.rxc03 = '98'
#   ELSE 
#   	  LET l_rxc.rxc03 = '05'   
#   END IF 
#   LET l_rxc.rxc04 = l_rwj04
#   LET l_rxc.rxc05 = ''
#   #贈品或換贈
#   IF l_rwi10='4' OR l_rwi10='5' THEN
#      LET l_rxc.rxc06=0
#   ELSE 
#      IF NOT cl_null(l_oea87) THEN 
#         #消費可折扣
#         IF l_lph05 = 'Y' THEN
#            LET l_rxc.rxc06=l_cmt
#         ELSE 
#           LET l_rxc.rxc06 =l_bmt
#         END IF 
#      ELSE 
#         LET l_rxc.rxc06 = l_bmt
#      END IF 
#   END IF 
#   LET l_rxc.rxc07 = l_rtv13
#   LET l_rxc.rxc08 = ''
#   LET l_rxc.rxc09 = '0'
#   LET l_rxc.rxc10 = 0
#   LET l_rxc.rxc11 = g_member   #是否會員
#   LET l_rxc.rxc12 = l_rtv02
#   LET l_rxc.rxc13 = l_rty05
#   LET l_rxc.rxc14 = l_rtv01
#  LET l_rxc.rxcplant = p_plant
#   SELECT azw02 INTO l_rxc.rxclegal FROM azw_file WHERE azw01 = p_plant
#   #LET l_sql = "DELETE FROM ",l_dbs,"rxc_file ",
#   LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), #FUN-A50102
#               "   WHERE rxc00 = '",l_rxc.rxc00,"'",
#              "     AND rxc01 = '",l_rxc.rxc01,"'",
#               "     AND rxc02 = '",l_rxc.rxc02,"'",
#               "     AND rxc03 = '",l_rxc.rxc03,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
#   PREPARE pre_del_rxc55 FROM l_sql
#   EXECUTE pre_del_rxc55
#   #LET l_sql = "INSERT INTO ",l_dbs,"rxc_file(",
#   LET l_sql = "INSERT INTO ",cl_get_target_table(g_plant_new,'rxc_file'),"(", #FUN-A50102   
#               "rxc00,rxc01,rxc02,rxc03,rxc04,rxc05,rxc06,",
#               "rxc07,rxc08,rxc09,rxc10,rxclegal,rxcplant,rxc11,",
#              "rxc12,rxc13,rxc14) ",
#               "VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?)"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
#   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
#   PREPARE pre_ins_rxc145 FROM l_sql
#   EXECUTE pre_ins_rxc145 USING l_rxc.rxc00,l_rxc.rxc01,l_rxc.rxc02,l_rxc.rxc03,l_rxc.rxc04, #No.FUN-9B0157
#                               l_rxc.rxc05,l_rxc.rxc06,l_rxc.rxc07,l_rxc.rxc08,
#                               l_rxc.rxc09,l_rxc.rxc10,l_rxc.rxclegal,l_rxc.rxcplant,
#                               l_rxc.rxc11,l_rxc.rxc12,l_rxc.rxc13,l_rxc.rxc14
#   IF SQLCA.SQLCODE THEN 
#      CALL cl_err('ins rxc',SQLCA.SQLCODE,1)
#      RETURN 'N',0 
#   END IF
#   RETURN 'Y',l_price
#END FUNCTION
##No.FUN-A10106 --end
##NO.FUN-960130----end-----
#FUN-AA0065  ---end--mark
#FUN-AA0065 --add--begin
FUNCTION s_fetch_price_new2(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr,p_term,p_payment,p_no,p_line,p_count,p_no1,p_cmd,l_p1)
DEFINE p_cust       LIKE tqo_file.tqo01,     #客戶編號
       p_item       LIKE tqn_file.tqn03,     #料件編號
       p_unit       LIKE tqn_file.tqn04,     #單位
       p_date       LIKE type_file.dat,      #日期
       p_type       LIKE type_file.chr1,     #單據類型
       p_cmd        LIKE type_file.chr1,     #用戶動作
       p_curr       LIKE azi_file.azi01,     #幣別
       p_plant      LIKE azp_file.azp01,     #機構別
       p_term       LIKE oah_file.oah01,     #價格條件
       p_payment    LIKE oea_file.oea32,     #付款條件
       p_no1        LIKE tqx_file.tqx01,     #提案單號
       p_no         LIKE oea_file.oea01,     #單據編號
       p_line       LIKE oeb_file.oeb03,     #項次
       p_count      LIKE xmd_file.xmd08,     #料件數量
       l_success    LIKE type_file.chr1
DEFINE l_dbs       LIKE azp_file.azp03
DEFINE l_sql       STRING
DEFINE l_n         LIKE type_file.num5
DEFINE l_price     LIKE oeb_file.oeb13
DEFINE l_a2_price  LIKE oeb_file.oeb13       #TQC-B60015 ADD
DEFINE l_ohi03     LIKE ohi_file.ohi03
DEFINE l_ohi02     LIKE ohi_file.ohi02
DEFINE l_ohi04     LIKE ohi_file.ohi04
DEFINE l_rate1     LIKE xmh_file.xmh03
DEFINE l_rate2     LIKE xmh_file.xmh03
DEFINE l_rate      LIKE xmh_file.xmh03
DEFINE l_no        LIKE oea_file.oea01
#DEFINE l_rzz03     LIKE rzz_file.rzz03     
DEFINE l_oah04     LIKE oah_file.oah04
DEFINE l_oah05     LIKE oah_file.oah05
DEFINE l_oah06     LIKE oah_file.oah06
DEFINE l_c1_price  LIKE oeb_file.oeb13
DEFINE l_c2_price  LIKE oeb_file.oeb13
DEFINE l_c3_price  LIKE oeb_file.oeb13
DEFINE l_c4_rate  LIKE oeb_file.oeb13
DEFINE l_a1_price  LIKE oeb_file.oeb13
DEFINE l_old_price  LIKE oeb_file.oeb13
DEFINE l_b1_flag   LIKE type_file.chr1
DEFINE l_b2_flag   LIKE type_file.chr1
DEFINE l_c1_flag   LIKE type_file.chr1
DEFINE l_c2_flag   LIKE type_file.chr1
DEFINE l_c3_flag   LIKE type_file.chr1
DEFINE l_c4_flag   LIKE type_file.chr1
DEFINE l_sum       LIKE rxc_file.rxc06
DEFINE l_rxc00     LIKE rxc_file.rxc00
DEFINE l_oeb03     LIKE oeb_file.oeb03
DEFINE l_p1        LIKE type_file.chr1
DEFINE l_B1        LIKE type_file.num5
DEFINE l_B2        LIKE type_file.num5
DEFINE l_m         LIKE type_file.num5
   WHENEVER ERROR CONTINUE
 
#MOD-B30402 --Begin
#  IF p_count = 0 THEN RETURN 0 END IF
#  IF p_item IS NULL THEN RETURN 0 END IF
#  IF p_unit IS NULL THEN RETURN 0 END IF
   IF p_count = 0 THEN RETURN 0,' ' END IF
   IF p_item IS NULL THEN RETURN 0,' ' END IF
   IF p_unit IS NULL THEN RETURN 0,' ' END IF
#MOD-B30402 --End

  #SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = p_plant
   LET g_plant_new = p_plant
   CALL s_gettrandbs()
   LET l_dbs=g_dbs_tra


   IF SQLCA.SQLCODE THEN
      CALL cl_err('sel azp_file',SQLCA.SQLCODE,1)
     #RETURN 0      #MOD-B30402 mark
      RETURN 0,' '   #MOD-B30402
   END IF
   LET l_dbs = s_dbstring(l_dbs CLIPPED)
   #判斷價格條件是否存在
   #FUN-9C0068   ---start
   IF cl_null(p_term) THEN
      #LET l_sql = "SELECT occ44 FROM ",l_dbs,"occ_file ",
      LET l_sql = "SELECT occ44 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  " WHERE occ01 = '",p_cust,"' ",
                  "   AND occ1004='1' ",
                  "   AND occacti='Y' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql 
      PREPARE pre_sel_occ22 FROM l_sql
      EXECUTE pre_sel_occ22 INTO p_term
      IF SQLCA.SQLCODE THEN
         CALL cl_err('sel occ_file','sub-221',1)
        #RETURN 0      #MOD-B30402 mark
         RETURN 0,' '   #MOD-B30402
      END IF
   END IF
 
   #LET l_sql = "SELECT oah04,oah05,oah06 FROM ",l_dbs,"oah_file ",
   LET l_sql = "SELECT oah04,oah05,oah06 FROM ",cl_get_target_table(g_plant_new,'oah_file'), 
               "   WHERE oah01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql             							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql 
   PREPARE pre_sel_oah12 FROM l_sql
   EXECUTE pre_sel_oah12 INTO l_oah04,l_oah05,l_oah06 
   IF SQLCA.SQLCODE THEN
     #CALL cl_err('sel oah_file',SQLCA.SQLCODE,1) #FUN-9C0068
      CALL cl_err('sel oah_file','sub-221',1) #FUN-9C0068
     #RETURN 0       #MOD-B30402 mark
      RETURN 0,' '   #MOD-B30402
   END IF
 
   IF l_oah04 IS NULL THEN LET l_oah04 = ' ' END IF
   IF l_oah05 IS NULL THEN LET l_oah05 = ' ' END IF
   IF l_oah06 IS NULL THEN LET l_oah06 = ' ' END IF
 
   LET l_old_price = 0
   LET l_c1_price = 0
   LET l_c2_price = 0
   LET l_c3_price = 0
   LET l_c4_rate = 100
   LET l_rate = 100
   LET l_rate1 = 100
   LET l_rate2 = 100
   LET l_price = 0 
   LET l_a1_price = 0 
   LET g_leater_price = 0
   LET l_b1_flag = 'N'
   LET l_b2_flag = 'N'
   LET l_c1_flag = 'N'
   LET l_c2_flag = 'N'
   LET l_c3_flag = 'N'
   LET l_c4_flag = 'N'
   #LET l_sql = "SELECT COUNT(*) FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "  WHERE ohi01 = '",p_term,"'"
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql 
   PREPARE pre_sel_ohi102 FROM l_sql
   EXECUTE pre_sel_ohi102 INTO l_n
   IF l_n IS NULL OR l_n = 0 THEN
      CALL cl_err('','',1)
     #RETURN 0       #MOD-B30402 mark
      RETURN 0,' '   #MOD-B30402
   END IF
   #取出指定價格條件的各個組
   #LET l_sql = "SELECT ohi02 FROM ",l_dbs,"ohi_file ",
   LET l_sql = "SELECT ohi02 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), #FUN-A50102
               "   WHERE ohi01 = '",p_term,"'",
               "     GROUP BY ohi02 "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql            							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql             
   PREPARE pre_sel_ohi12 FROM l_sql
   DECLARE ohi11_cur2 CURSOR FOR pre_sel_ohi12
   LET l_price = 0
   FOREACH ohi11_cur2 INTO l_ohi02
      #LET l_c1_price = 0
      #LET l_c2_price = 0
      #LET l_c3_price = 0
      #LET l_c4_rate = 0
      #LET l_rate = 0
      #LET l_rate1 = 0
      #LET l_rate2 = 0
      #LET l_price = 0 
      IF l_ohi02 IS NULL THEN CONTINUE FOREACH END IF
      LET l_sx = 0
      LET l_sx_1 = -1
      #LET l_sql = "SELECT ohi03 FROM ",l_dbs,"ohi_file ",
      LET l_sql = "SELECT ohi03 FROM ",cl_get_target_table(g_plant_new,'ohi_file'), 
                  "   WHERE ohi01 ='",p_term,"'",
                  "     AND ohi02 ='",l_ohi02,"'",
                  "     ORDER BY ohi03 "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
      CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  
      PREPARE pre_sel_ohi032 FROM l_sql
      DECLARE cur_ohi032 CURSOR FOR pre_sel_ohi032
      FOREACH cur_ohi032 INTO l_ohi03
         IF l_ohi03 IS NULL THEN CONTINUE FOREACH END IF
         #取出價格代碼
         #LET l_sql = "SELECT ohi04 FROM ",l_dbs,"ohi_file ",
         LET l_sql = "SELECT ohi04 FROM ",cl_get_target_table(g_plant_new,'ohi_file'),
                     "   WHERE ohi01 = '",p_term,"'",
                     "     AND ohi02 = '",l_ohi02,"'",
                     "     AND ohi03 = '",l_ohi03,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
         PREPARE pre_sel_ohi042 FROM l_sql
         EXECUTE pre_sel_ohi042 INTO l_ohi04
         LET l_sx = l_ohi03
         IF l_p1 ='2' THEN
            IF  l_ohi04 = 'C2' THEN
                LET l_sx_1 = l_sx
            END IF
            IF  l_ohi04 = 'B1' THEN
                LET l_B1 = l_ohi03
            END IF
            IF  l_ohi04 = 'B2' THEN
                LET l_B2 = l_ohi03
            END IF
         END IF 
         #根據價格代碼取出價格的類別
         #LET l_sql = "SELECT rzz03 FROM ",l_dbs,"rzz_file ",
         #            "   WHERE rzz00 = '2' AND rzz01 = '",l_ohi04,"'"
         #PREPARE pre_sel_rzz031 FROM l_sql
         #EXECUTE pre_sel_rzz031 INTO l_rzz03
         #B/C類型價格不互斥
         IF l_oah05 = 'N' THEN
            IF l_oah06 = 'N' THEN    #同組同類型價格不互斥
               #B/C類型價格不互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     LET g_flg ='N'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     LET g_flg ='N'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     LET g_flg ='N'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     LET g_flg ='N'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr) #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     LET g_flg ='N'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     LET g_flg ='N'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1'
                     LET g_flg ='N'
                     CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                        RETURNING l_rate
                  WHEN l_ohi04 = 'B2'
                     LET g_flg ='N'
                     CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                        RETURNING l_rate1,l_rate2
                  WHEN l_ohi04 = 'C1'
                     LET g_flg ='N'
                     CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                        RETURNING l_price
                  WHEN l_ohi04 = 'C2'
                     IF l_ohi04 = 'C2' THEN
                        IF l_p1 = '1' THEN
                           LET g_flg ='Y'
                           EXIT FOREACH
                        ELSE
                           LET g_flg ='N'
                           CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_price
                        END IF
                     END IF
                  WHEN l_ohi04 = 'C3'
                     LET g_flg ='N' 
                     CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                        RETURNING l_price
                  WHEN l_ohi04 = 'C4'
                     LET g_flg ='N'
                     CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                        RETURNING l_price
               END CASE
            ELSE                     #同組價格互斥
               #B/C類型價格不互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     LET g_flg ='N' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     LET g_flg ='N'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     LET g_flg ='N'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     LET g_flg ='N'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     LET g_flg ='N'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     LET g_flg ='N'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2' 
                     IF l_b1_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                      END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_c2_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2' 
                     IF l_c1_flag = 'N' AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        IF l_p1 = '1' THEN
                           LET g_flg ='Y'
                           EXIT FOREACH
                        ELSE
                           LET g_flg ='N'
                           CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_price
                        END IF 
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         ELSE     #B/C類型價格互斥
            IF l_oah06 = 'Y' THEN    #同組價格互斥
               #B/C類型價格互斥,同組同類型價格互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     LET g_flg ='N'
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     LET g_flg ='N'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     LET g_flg ='N'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     LET g_flg ='N'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)   #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     LET g_flg ='N'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     LET g_flg ='N'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_b2_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_b1_flag = 'N' AND l_c1_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c2_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c3_flag = 'N' AND l_c4_flag = 'N' THEN
                        IF l_p1 = '1' THEN
                           LET g_flg ='Y'
                           EXIT FOREACH
                        ELSE
                           LET g_flg ='N'
                           CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_price
                        END IF
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4'
                     IF l_b1_flag = 'N' AND l_b2_flag = 'N' AND l_c1_flag = 'N'
                        AND l_c2_flag = 'N' AND l_c3_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            ELSE                     #同組價格不互斥
               #B/C類型價格互斥,同組同類型價格不互斥
               CASE
                  WHEN l_ohi04 = 'A1'
                     LET g_flg ='N' 
                     CALL s_fetch_price_A1(p_cust,p_item,p_unit,p_date,p_type,p_plant,p_curr)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A2'
                     LET g_flg ='N'
                     #CALL s_fetch_price_A2(p_item,p_unit,p_plant)
                 #   CALL s_fetch_price_A2(p_item,p_unit,p_plant,p_curr)  #MOD-B30225  #TQC-B40014 MARK
                 #   CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr)   #TQC-B40014 ADD #TQC-B60015 MARK
                     CALL s_fetch_price_A2(p_no,p_type,p_item,p_unit,p_plant,p_curr,p_line,p_count)   #TQC-B60015 ADD
                        RETURNING l_price,l_a2_price  #TQC-B60015 ADD l_a2_price
                 #MOD-9C0173   ---start
                  WHEN l_ohi04 = 'A3'
                     LET g_flg ='N'
                     CALL s_fetch_price_A3(p_item,p_no,p_plant,p_type)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A4'
                     LET g_flg ='N'
                     CALL s_fetch_price_A4(p_type,p_unit,p_plant,p_line,p_no,p_item,p_cust,p_term,p_curr)  #MOD-AB0237
                        RETURNING l_price
                  WHEN l_ohi04 = 'A5'
                     LET g_flg ='N'
                     CALL s_fetch_price_A5(p_item,p_cust,p_curr,p_plant)
                        RETURNING l_price
                  WHEN l_ohi04 = 'A6'
                     LET g_flg ='N'
                     CALL s_fetch_price_A6(p_term,p_curr,p_item,p_unit,p_date,p_plant)
                        RETURNING l_price
                 #MOD-9C0173   ---end
                  WHEN l_ohi04 = 'B1' 
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B1(p_item,p_unit,p_date,p_plant,p_curr,p_term,p_count,l_price,p_no,p_line,p_type)
                           RETURNING l_rate
                     END IF
                  WHEN l_ohi04 = 'B2'
                     IF l_c1_flag = 'N' AND l_c2_flag = 'N' AND l_c3_flag = 'N'
                        AND l_c4_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_B2(p_cust,p_item,p_plant,l_price,p_no,p_line,p_count,p_type)
                           RETURNING l_rate1,l_rate2
                     END IF
                  WHEN l_ohi04 = 'C1' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C1(p_cust,p_item,p_unit,p_date,p_curr,p_no,p_line,l_price,p_plant,p_no1,p_type,p_count)
                           RETURNING l_c1_price
                     END IF
                  WHEN l_ohi04 = 'C2'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        IF l_p1 = '1' THEN
                           LET g_flg ='Y'
                           EXIT FOREACH 
                        ELSE
                           LET g_flg ='N'
                           CALL s_fetch_price_C2(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_type,p_no,p_line,l_price,p_count,l_ohi02,p_cmd)
                           RETURNING l_price
                        END IF
                     END IF
                  WHEN l_ohi04 = 'C3'
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C3(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_no,p_line,l_price,p_count,p_type) #FUN-9C0083 add p_type
                           RETURNING l_c3_price
                     END IF
                  WHEN l_ohi04 = 'C4' 
                     IF l_b1_flag='N' AND l_b2_flag = 'N' THEN
                        LET g_flg ='N'
                        CALL s_fetch_price_C4(p_cust,p_item,p_unit,p_date,p_plant,p_curr,p_term,p_payment,p_count,p_no,p_line,l_price,p_type)
                           RETURNING l_c4_rate
                     END IF
               END CASE
            END IF
         END IF
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' THEN  #MOD-9C0173
        #IF l_ohi04 = 'A1' OR l_ohi04 = 'A2' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN  #MOD-9C0173 #TQC-B60015 MARK
         IF l_ohi04 = 'A1' OR l_ohi04 = 'A3' OR l_ohi04 = 'A4' OR l_ohi04 = 'A5' OR l_ohi04 = 'A6' THEN #TQC-B60015 ADD
            LET l_a1_price = l_price
         END IF
###TQC-B60015 - ADD - BEGIN ------------------------------------
         IF l_ohi04 = 'A2' THEN
            LET l_a1_price = l_a2_price
         END IF
###TQC-B60015 - ADD -  END  ------------------------------------
         IF l_c1_price != 0 THEN LET l_price = l_c1_price END IF
         IF l_c2_price != 0 THEN LET l_price = l_c2_price END IF
         IF l_c3_price != 0 THEN LET l_price = l_c3_price END IF
         IF l_c4_rate != 0 THEN LET l_price = l_price*l_c4_rate/100 END IF
         IF l_rate != 0 THEN LET l_price = l_price*l_rate/100 END IF
         IF l_rate1 != 0 THEN LET l_price = l_price*l_rate1/100 END IF
         IF l_rate2 != 0 THEN LET l_price = l_price*l_rate2/100 END IF
         IF l_ohi04 != 'B1' AND l_ohi04 != 'B2' AND l_ohi04 != 'C4' AND l_price != 0 THEN
            LET g_leater_price = l_price
         END IF
         IF l_price = 0 THEN LET l_price = l_old_price END IF
         IF l_price != 0 AND l_price IS NOT NULL THEN LET l_old_price = l_price END IF
         IF l_rate != 100 AND l_rate != 0 THEN      #表示已取到B1類價格
            LET l_b1_flag = 'Y'
         END IF
         #若B2類價格已經取到
         IF l_rate1 != 100 OR l_rate2 != 100 THEN
            LET l_b2_flag = 'Y'
         END IF
	 IF l_c1_price != 0 THEN LET l_c1_flag = 'Y' END IF
         IF l_c2_price != 0 THEN LET l_c2_flag = 'Y' END IF
         IF l_c3_price != 0 THEN LET l_c3_flag = 'Y' END IF
         IF l_c4_rate != 100 THEN LET l_c4_flag = 'Y' END IF
         LET l_rate = 100
         LET l_rate1 = 100
         LET l_rate2 = 100
         LET l_c1_price = 0 
         LET l_c2_price = 0 
         LET l_c3_price = 0 
         LET l_c4_rate = 100 
      END FOREACH
      IF l_price != 0 THEN EXIT FOREACH END IF
   END FOREACH
   IF l_p1 = '2' THEN 
     IF l_oah05 = 'Y' THEN
       LET l_m = 0
       LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                  "   WHERE rxc01 = '",p_no,"' ",
                  "   AND  rxc02 = '",p_line,"'  ",
                  " AND rxc03 IN ('01','02','03') "
       CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
       CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
       PREPARE pre_sel_rxc16 FROM l_sql
       EXECUTE pre_sel_rxc16 INTO l_m 
       IF l_m > 0 THEN 
           CASE p_type
              WHEN '1'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                             " WHERE rxc03 IN ('07','08') ",
                             " AND   rxc00 = '01' AND rxc01 = '",p_no,"' "
              WHEN '2'                
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                           # " WHERE rxc03 IN ('07','02') ",
                             " WHERE rxc03 IN ('07','08') ",            #MOD-B20078
                             " AND   rxc00 = '02' AND rxc01 = '",p_no,"' "
             WHEN '3'                 
                LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                            " WHERE rxc03 IN ('07','08') ",
                            " AND   rxc00 = '03' AND rxc01 = '",p_no,"' "  
           END CASE                   
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              						
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
           PREPARE pre_del_rxc17 FROM l_sql
           EXECUTE pre_del_rxc17
           IF l_B1 < l_B2 THEN
              CASE p_type
              WHEN '1'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                             " WHERE rxc03 IN ('07') ",
                             " AND   rxc00 = '01' AND rxc01 = '",p_no,"' "
              WHEN '2'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                       #     " WHERE rxc03 IN ('09') ",
                             " WHERE rxc03 IN ('07') ",                #MOD-B20078
                             " AND   rxc00 = '02' AND rxc01 = '",p_no,"' "
             WHEN '3'
                LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                        #   " WHERE rxc03 IN ('09') ",
                            " WHERE rxc03 IN ('07') ",                 #MOD-B20078
                            " AND   rxc00 = '03' AND rxc01 = '",p_no,"' "
             END CASE
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
             PREPARE pre_del_rxc20 FROM l_sql
             EXECUTE pre_del_rxc20
          ELSE
             CASE p_type
              WHEN '1'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                        #    " WHERE rxc03 IN ('07') ",
                             " WHERE rxc03 IN ('08') ",                 #MOD-B20078
                             " AND   rxc00 = '01' AND rxc01 = '",p_no,"' "
              WHEN '2'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                        #    " WHERE rxc03 IN ('09') ",
                             " WHERE rxc03 IN ('08') ",                 #MOD-B20078
                             " AND   rxc00 = '02' AND rxc01 = '",p_no,"' "
             WHEN '3'
                LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'),
                        #   " WHERE rxc03 IN ('09') ",
                            " WHERE rxc03 IN ('08') ",                   #MOD-B20078
                            " AND   rxc00 = '03' AND rxc01 = '",p_no,"' "
             END CASE
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
             PREPARE pre_del_rxc21 FROM l_sql
             EXECUTE pre_del_rxc21
          END IF
       END IF
     END IF
     IF l_oah06 = 'Y' THEN
        LET l_m = 0
       LET l_sql = "SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                  "   WHERE rxc01 = '",p_no,"' ",
                  "   AND  rxc02 = '",p_line,"'  ",
                  " AND rxc03 IN ('01','02','03') "
       CALL cl_replace_sqldb(l_sql) RETURNING l_sql             						
       CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql            
       PREPARE pre_sel_rxc18 FROM l_sql
       EXECUTE pre_sel_rxc18 INTO l_m 
       IF l_m > 0 THEN 
           CASE p_type
              WHEN '1'
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                             " WHERE rxc03 IN ('09','10','11') ",
                             " AND   rxc00 = '01' AND rxc01 = '",p_no,"' "
              WHEN '2'                
                 LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                             " WHERE rxc03 IN ('09','10','11') ",
                             " AND   rxc00 = '02' AND rxc01 = '",p_no,"' "
             WHEN '3'                 
                LET l_sql = "DELETE FROM ",cl_get_target_table(g_plant_new,'rxc_file'), 
                            " WHERE rxc03 IN ('09','10','11') ",
                            " AND   rxc00 = '03' AND rxc01 = '",p_no,"' "  
           END CASE                   
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              						
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql              
           PREPARE pre_del_rxc19 FROM l_sql
           EXECUTE pre_del_rxc19
       END IF
     END IF
   END IF
   RETURN l_price,g_flg
END FUNCTION
#FUN-AA0065--add--end
