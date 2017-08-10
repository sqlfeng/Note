#該程式未解開Section, 採用最新樣板產出!
{<section id="s_asft335.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(1900-01-01 00:00:00), PR版次:0002(2017-06-09 22:39:21)
#+ Customerized Version.: SD版次:0001(1900-01-01 00:00:00), PR版次:0002(2017-07-14 18:39:20)
#+ Build......: 000386
#+ Filename...: s_asft335
#+ Description: 報工單元件
#+ Creator....: 00537(2013-12-11 13:28:44)
#+ Modifier...: 00000 -SD/PR- topstd
 
{</section>}
 
{<section id="s_asft335.global" >}
#應用 p00 樣板自動產生(Version:3)
#add-point:註解編寫項目
#151110-00002#2 2015/11/17 BY fionchen 1.增加function,提供報工時若該工單+Rucnard+作業編號+製程序需PQC,則需控管良品數量不可大於PQC合格數量-已報工良品量
#                                      2.調整s_asft335_set_qty,報工時,若需PQC時,待處理數量應為PQC檢驗合格量
#160129-00002#7 2016/03/03 By Jessica  此資料來源為MES抛轉，不可取消確認！
#160328-00029#3 2016/04/01 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160730-00003#1 2016/07/30 By zhangllc 修正批次報工報工順序如不照工單製程相同順序打，報工結果回寫工單製程資料的在製數量、良品轉入會錯誤
#160801-00021#1 2016/08/01 By dorislai 接續 #160730-00003#1 ，此單先修正了順序
#                                      接著 修正asft330按確認後，asft301再製量、良品轉入量，錯誤的問題。(問題點：SQL抓取資料，WHERE狀態碼)
#                                           修正asft330取消確認，asft301再製量、良品轉入量，錯誤的問題。(問題點：取消確認，應該從後面的站倒著算回來)
#160804-00029#1 2016/08/04 By dorislai D-MFG-0045(允許報工)='Y，良品數量+報廢數量+當站下線+回收數量不可大於(標準產出-已轉量)
#170117-00038#1  2017/06/05 By 09640   報工的可超交率判斷s_asft335_chk_qty()
#161215-00047#1  2016/12/15 By Whitney  調用s_asft335_sffbtmp前先清空
#end add-point
 
IMPORT os
#add-point:增加匯入項目
IMPORT util  #170117-00038#1
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔

#end add-point
 
{</section>}
 
{<section id="s_asft335.free_style_variable" >}
#add-point:free_style模組變數(Module Variable)

#160730-00003#1 add--s
GLOBALS
DEFINE g_count         LIKE type_t.num10   #sffb批次报工单的总笔数——注意！！！此g_count就是用于判断已重排和未重排的依据，不可另作他用
DEFINE g_seq           LIKE sffb_t.sffbseq #报工单重排的项次
END GLOBALS
#160730-00003#1 add--e
#end add-point
 
{</section>}
 
{<section id="s_asft335.global_variable" >}
#add-point:自定義模組變數(Module Variable)
   PRIVATE type type_sfcb_next  RECORD    #用来存放审核报工当站的下一站资料 
                             chk          LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果
                             sfcbdocno    LIKE sfcb_t.sfcbdocno,
                             sfcb001      LIKE sfcb_t.sfcb001,
                             sfcb003      LIKE sfcb_t.sfcb003,
                             sfcb004      LIKE sfcb_t.sfcb004,
                             sfcb005      LIKE sfcb_t.sfcb005,     #群组性质
                             sfcb006      LIKE sfcb_t.sfcb006,     #群组
                             type         LIKE sffb_t.sffb001,     #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
                             sfcb021      LIKE sfcb_t.sfcb021,     #转出单位换算率分子
                             sfcb022      LIKE sfcb_t.sfcb022,     #转出单位换算率分母
                             amt          LIKE sfcb_t.sfcb050,     #与上面匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
                             sfcb053      LIKE sfcb_t.sfcb053,     #转入单位换算率分子
                             sfcb054      LIKE sfcb_t.sfcb054      #转入单位换算率分母
                             END RECORD
 
   PRIVATE type type_sfcb_prev  RECORD    #用来存放g_sfcb_next所有报工的上站资料，所存的资料计算后得出下站应该有多少数量
                             chk          LIKE type_t.chr1,   #去除重复使用的，N是没去过重复的，Y是去重之后的结果   
                             sfcbdocno    LIKE sfcb_t.sfcbdocno,   #工单单号
                             sfcb001      LIKE sfcb_t.sfcb001,     #RunCard单号
                             sfcb003      LIKE sfcb_t.sfcb003,     #作业编号
                             sfcb004      LIKE sfcb_t.sfcb004,     #制程序
                             sfcb005      LIKE sfcb_t.sfcb005,     #群组性质
                             sfcb006      LIKE sfcb_t.sfcb006,     #群组
                             type         LIKE sffb_t.sffb001,     #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
                             sfcb021      LIKE sfcb_t.sfcb021,     #转出单位换算率分子
                             sfcb022      LIKE sfcb_t.sfcb022,     #转出单位换算率分母
                             amt          LIKE sfcb_t.sfcb050,     #与上面type匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
                             sfcb053      LIKE sfcb_t.sfcb053,     #转入单位换算率分子
                             sfcb054      LIKE sfcb_t.sfcb054      #转入单位换算率分母
                             END RECORD  


      DEFINE g_sfcb_next          DYNAMIC ARRAY OF type_sfcb_next 
      DEFINE g_s_prevprev         DYNAMIC ARRAY OF type_sfcb_prev 
      DEFINE g_sel_sfcb_next_sql  STRING                           #存s_asft335_get_next_station递归时cursor的sql  
      DEFINE g_sel_sfcb_prev_sql  STRING                           #存s_asft335_get_prev_station递归时cursor的sql
      DEFINE g_doc_slip           LIKE sfaa_t.sfaadocno
      DEFINE g_sfhadocno          LIKE sfha_t.sfhadocno            #160511-00020 by whitney add
      DEFINE g_sffadocno          LIKE sffa_t.sffadocno            #160801-00021#1-add
      DEFINE g_sffbseq            LIKE sffb_t.sffbseq              #160804-00029#1-add
      #170117-00038#1-s
PRIVATE TYPE type_sffb_parameter RECORD
    sffbdocno  LIKE sffb_t.sffbdocno,  #報工單號
    sffbseq    LIKE sffb_t.sffbseq,    #項次
    sffb001    LIKE sffb_t.sffb001,    #報工類別  #170120-00043#1
    sffb005    LIKE sffb_t.sffb005,    #工單單號
    sffb006    LIKE sffb_t.sffb006,    #Run Card
    sffb007    LIKE sffb_t.sffb007,    #作業編號
    sffb008    LIKE sffb_t.sffb008,    #製程式
    sffb017    LIKE sffb_t.sffb017,    #良品數量
    sffb018    LIKE sffb_t.sffb018,    #報廢數量
    sffb019    LIKE sffb_t.sffb019,    #當站下線數量
    sffb020    LIKE sffb_t.sffb020     #回收數量
                END RECORD
#170117-00038#1-ef
#end add-point
 
{</section>}
 
{<section id="s_asft335.other_dialog" >}

 
{</section>}
 
{<section id="s_asft335.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 定义寻找下一站和上一站等cursor
# Memo...........:
# Usage..........: CALL s_asft335_declare_sfcb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/01/14 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_declare_sfcb()
   DEFINE l_sql    STRING
   DEFINE l_sql1   STRING
   DEFINE l_sql2   STRING
   DEFINE l_sql3   STRING
   DEFINE l_sql4   STRING
   DEFINE l_sql5   STRING

   WHENEVER ERROR CONTINUE
   LET l_sql = " INSERT INTO s_asft335_tmp01 "
   
   LET l_sql1= " SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,",
               "        CASE WHEN sfcb014 ='Y' THEN 1 WHEN sfcb015 ='Y' THEN 2 WHEN sfcb016 ='Y' THEN 3 WHEN sfcb018 ='Y' THEN 4 WHEN sfcb019 ='Y' THEN 5 ELSE 0 END,",
               "        sfcb021,sfcb022,0,sfcb053,sfcb054 ",      
               "   FROM sfcb_t,sfcc_t ",
               "  WHERE sfcbent   = ",g_enterprise,
               "    AND sfcbsite  = '",g_site CLIPPED,"'",
               "    AND sfcbdocno = sfccdocno ",
               "    AND sfcb001   = sfcc001 ",
               "    AND sfcb002   = sfcc002 ",
               "    AND sfccent   = sfccent",
               "    AND sfccsite  = sfccsite",
               "    AND sfccdocno = ? ",
               "    AND sfcc001   = ? ",
               "    AND sfcc003   = ? ",
               "    AND sfcc004   = ? " 
               
   LET l_sql2= "    AND (sfcb014  = 'Y' ",
               "    OR  sfcb015   = 'Y' ",
               "    OR  sfcb016   = 'Y' ",
               "    OR  sfcb018   = 'Y' ",
               "    OR  sfcb019   = 'Y')",
               " ORDER BY sfcb003,sfcb004 "
               
   LET l_sql3= "    AND (sfcb014  = 'N' ",
               "    AND sfcb015   = 'N' ",
               "    AND sfcb016   = 'N' ",
               "    AND sfcb018   = 'N' ",
               "    AND sfcb019   = 'N')",
               " ORDER BY sfcb003,sfcb004 "

#有报工的直接插入临时表
   LET l_sql4=l_sql,l_sql1,l_sql2
   PREPARE s_asft335_ins_sfcb_next_pb FROM l_sql4
   DECLARE s_asft335_ins_sfcb_next CURSOR FOR s_asft335_ins_sfcb_next_pb
   
#没报工的也选出来，继续找下下站
   LET l_sql5=l_sql1,l_sql3
   LET g_sel_sfcb_next_sql = l_sql5
#cursor的定义放到s_asft335_get_next_station递归时，不然foreach会关闭cursor，造成下一层递归无法使用cursor
#   PREPARE s_asft335_sel_sfcb_next_pb FROM l_sql5
#   DECLARE s_asft335_sel_sfcb_next CURSOR FOR s_asft335_sel_sfcb_next_pb

   LET l_sql = " INSERT INTO s_asft335_tmp02 "


   LET l_sql1= " SELECT 'N',A.sfcbdocno,A.sfcb001,A.sfcb003,A.sfcb004,A.sfcb005,A.sfcb006,",
               "        CASE WHEN A.sfcb019 ='Y' THEN 5 WHEN A.sfcb018 ='Y' THEN 4 WHEN A.sfcb016 ='Y' THEN 3 WHEN A.sfcb015 ='Y' THEN 2 WHEN A.sfcb014 ='Y' THEN 1 ELSE 0 END,",
               "        A.sfcb021,A.sfcb022,0,",
               "        A.sfcb053,A.sfcb054 ",
               "   FROM sfcb_t B,sfcb_t A,sfcc_t ",   #A是上一站，B是当前站，sql是要找到B站所有的上一站,接受传入参数的是B站
               "  WHERE B.sfcbent   = ",g_enterprise,
               "    AND B.sfcbsite  = '",g_site CLIPPED,"'",
               "    AND B.sfcbdocno = ? ",
               "    AND B.sfcb001   = ? ",
               "    AND B.sfcb003   = ? ",
               "    AND B.sfcb004   = ? ",
               "    AND B.sfcbent   = sfccent ",
               "    AND B.sfcbsite  = sfccsite ",
               "    AND B.sfcbdocno = sfccdocno ",
               "    AND B.sfcb001   = sfcc001 ",
               "    AND B.sfcb002   = sfcc002 ",
               "    AND A.sfcbent   = sfccent ",
               "    AND A.sfcbsite  = sfccsite ",
               "    AND A.sfcbdocno = sfccdocno ",
               "    AND A.sfcb001   = sfcc001 ",
               "    AND A.sfcb003   = sfcc003 ",
               "    AND A.sfcb004   = sfcc004 "

               
   LET l_sql2= "    AND (A.sfcb014  = 'Y' ",
               "    OR  A.sfcb015   = 'Y' ",
               "    OR  A.sfcb016   = 'Y' ",
               "    OR  A.sfcb018   = 'Y' ",
               "    OR  A.sfcb019   = 'Y')",
               " ORDER BY A.sfcb003,A.sfcb004 "
               
   LET l_sql3= "    AND (A.sfcb014  = 'N' ",
               "    AND A.sfcb015   = 'N' ",
               "    AND A.sfcb016   = 'N' ",
               "    AND A.sfcb018   = 'N' ",
               "    AND A.sfcb019   = 'N')",
               " ORDER BY A.sfcb003,A.sfcb004 "

#有报工的直接插入临时表
   LET l_sql4=l_sql,l_sql1,l_sql2

                    
   PREPARE s_asft335_ins_sfcb_prev_pb FROM l_sql4
   DECLARE s_asft335_ins_sfcb_prev CURSOR FOR s_asft335_ins_sfcb_prev_pb 
#没报工的也选出来，继续找上上站
   LET l_sql5=l_sql1,l_sql3
   LET g_sel_sfcb_prev_sql = l_sql5
#cursor的定义放到s_asft335_get_prev_station递归时，不然foreach会关闭cursor，造成下一层递归无法使用cursor
#   PREPARE s_asft335_sel_sfcb_prev_pb FROM l_sql5
#   DECLARE s_asft335_sel_sfcb_prev CURSOR FOR s_asft335_sel_sfcb_prev_pb
              
END FUNCTION
################################################################################
# Descriptions...: 删除临时表
# Memo...........: 必须用于事务外
#                  与s_asft335_cre_tmp_table对应
# Usage..........: CALL s_asft335_drop_tmp_table()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/01/15 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_drop_tmp_table()
   WHENEVER ERROR CONTINUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN 
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE s_asft335_tmp01
   DROP TABLE s_asft335_tmp02
   
END FUNCTION
################################################################################
# Descriptions...: 抓取同一站里下一个勾选的步骤
# Memo...........:
# Usage..........: CALL s_asft335_get_next_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success,r_errmsg
# Input parameter: p_sffb001      作业类型
#                : p_sfcbdocno    工单单号
#                : p_sfcb001      RunCard单号
#                : p_sfcb003      作业编号
#                : p_sfcb004      制程序
# Return code....: r_success      回传参数变量说明1
#                : r_errmsg       回传参数变量说明2
# Date & Author..: 2014/01/21 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_next_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作业类型
   DEFINE p_sfcbdocno         LIKE sfcb_t.sfcbdocno        #工单单号
   DEFINE p_sfcb001           LIKE sfcb_t.sfcb001          #RunCard单号
   DEFINE p_sfcb003           LIKE sfcb_t.sfcb003          #作业编号
   DEFINE p_sfcb004           LIKE sfcb_t.sfcb004          #制程序
   DEFINE r_success           LIKE type_t.num5
   DEFINE r_errmsg            STRING
   DEFINE l_sfcb014           LIKE sfcb_t.sfcb014
   DEFINE l_sfcb015           LIKE sfcb_t.sfcb015
   DEFINE l_sfcb016           LIKE sfcb_t.sfcb016
   DEFINE l_sfcb018           LIKE sfcb_t.sfcb018
   DEFINE l_sfcb019           LIKE sfcb_t.sfcb019
   
   LET r_success = TRUE
   LET r_errmsg  = NULL
   CASE p_sffb001
      WHEN '0'   #从上站Move Out过来的，到下下站找第一个勾选的步骤
        SELECT sfcb014,sfcb015,sfcb016,sfcb018,sfcb019 
          INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '1'   #Move In
        SELECT sfcb015,sfcb016,sfcb018,sfcb019 
          INTO l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF        
      WHEN '2'   #check In
        SELECT sfcb016,sfcb018,sfcb019 
          INTO l_sfcb016,l_sfcb018,l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '3'   #报工
        SELECT sfcb018,sfcb019 
          INTO l_sfcb018,l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '4'   #check Out
        SELECT sfcb019 
          INTO l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp01
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '5'   #Move Out
#Move Out的下一步就是下一站了，所以本函数里不做运算了,回传FALSE才会继续去走抓取下一站的函数
         LET r_success = FALSE
         RETURN r_success,r_errmsg
   END CASE  
#如果走到这里，说明一个Y都没抓到，那就是失败了，返回FALSE
   LET r_success = FALSE
   RETURN r_success,r_errmsg
END FUNCTION
################################################################################
# Descriptions...: 计算各报工站综合对下一站点的影响，合并替代群组，其余取最小值
# Memo...........:step1:根据作业编号+制程序将对应的数量写到s_asft335_tmp02里，考虑转换率
#                :step2:以替代群组为group做sum
#                :step3:全体都有，取最小值，作为传给下一站的数量
# Usage..........: CALL s_asft335_calculate()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/01/14 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_calculate()
   DEFINE l_sfcb_prev         type_sfcb_prev  
   DEFINE l_sffb017           LIKE sffb_t.sffb017
   DEFINE r_success           LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   DECLARE s_asft335_sel_sfcb_prev_tmp CURSOR FOR SELECT * FROM s_asft335_tmp02 ORDER BY sfcb003,sfcb004
   FOREACH s_asft335_sel_sfcb_prev_tmp INTO l_sfcb_prev.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF  

      IF l_sfcb_prev.sfcb021 IS NULL OR l_sfcb_prev.sfcb022 IS NULL OR l_sfcb_prev.sfcb053 IS NULL OR l_sfcb_prev.sfcb054 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00345'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
#选取报工单数量
      SELECT SUM(sffb017) INTO l_sffb017 
        FROM sffb_t
       WHERE sffbent   = g_enterprise
         AND sffbsite  = g_site
         AND sffb001   = l_sfcb_prev.type
         AND sffb005   = l_sfcb_prev.sfcbdocno
         AND sffb006   = l_sfcb_prev.sfcb001
         AND sffb007   = l_sfcb_prev.sfcb003
         AND sffb008   = l_sfcb_prev.sfcb004
         AND sffbstus  = 'Y' 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'calculate SELECT SUM(sffb017)'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 

      IF l_sffb017 IS NULL THEN LET l_sffb017 = 0 END IF
      
#Move In，Check In用转入单位分子/分母
      IF l_sfcb_prev.type MATCHES '[12]' THEN
         LET l_sfcb_prev.amt = l_sffb017/l_sfcb_prev.sfcb053/l_sfcb_prev.sfcb054
      END IF
#Move Out，Check Out，报工用转出单位分子/分母
      IF l_sfcb_prev.type MATCHES '[345]' THEN
         LET l_sfcb_prev.amt = l_sffb017/l_sfcb_prev.sfcb021/l_sfcb_prev.sfcb022
      END IF
	
      UPDATE s_asft335_tmp02
         SET amt = l_sfcb_prev.amt
       WHERE type      = l_sfcb_prev.type
         AND sfcbdocno = l_sfcb_prev.sfcbdocno
         AND sfcb001   = l_sfcb_prev.sfcb001
         AND sfcb003   = l_sfcb_prev.sfcb003
         AND sfcb004   = l_sfcb_prev.sfcb004
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'calculate update s_asft335_tmp02'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 
   END FOREACH

#将相同替代群组的累加起来
   UPDATE s_asft335_tmp02 SET chk = 'N'
    WHERE sfcb005 = '2' 
      AND sfcb006 IS NOT NULL

#其他不是替代群组的不能删掉，也要改成chk=Y
   UPDATE s_asft335_tmp02 SET chk = 'Y'
    WHERE sfcb005 != '2'


   INSERT INTO s_asft335_tmp02 
   SELECT 'Y','','','','','',sfcb006,'','','',SUM(amt),'',''
     FROM s_asft335_tmp02
    WHERE sfcb005 = '2' 
      AND sfcb006 IS NOT NULL
    GROUP BY sfcb006


    
   DELETE FROM s_asft335_tmp02 WHERE chk = 'N'   

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 检查良品数量，报废数量，当站下线数量和回收数量的逻辑
# Memo...........:
# Usage..........: CALL s_asft335_chk_qty(ls_js)
#                  RETURNING r_success
# Input parameter: ls_js
# Date & Author..: 2014/06/05 By 09640 
# Return code....: r_success      检查通过否
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/01/26 By wujie
# Modify.........:  #170117-00038#1 將傳入參數調整為字串，報工的可超交率判斷，
#                : 在依順序報工時，應用良品轉入的數量判斷，且總數不可大於標準產出量*（1+允許超交率/100)
#                : 如不照順序報工，則判斷報工總量不可超過，標準產出量*(1+允許超交率）
################################################################################
PUBLIC FUNCTION s_asft335_chk_qty(ls_js)
#170117-00038#1-s
DEFINE ls_js        STRING
DEFINE lc_param     type_sffb_parameter
DEFINE r_success    LIKE type_t.num5
DEFINE l_sfaa010    LIKE sfaa_t.sfaa010
DEFINE l_imae020    LIKE imae_t.imae020
DEFINE l_success    LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_qty        LIKE sfcb_t.sfcb050
DEFINE l_sfcb027    LIKE sfcb_t.sfcb027
DEFINE l_sfcb028    LIKE sfcb_t.sfcb028
DEFINE l_sfcb_chk   LIKE sfcb_t.sfcb028   #170213-00031#1   add
DEFINE l_sfca005    LIKE sfca_t.sfca005   #170213-00031#1   add
DEFINE l_sfcb_chk1  LIKE sfcb_t.sfcb028   #170224-00011#1   add   已報工項目
DEFINE l_sfcb007    LIKE sfcb_t.sfcb007   #170306-00002#1   add   上站作業
DEFINE l_sfcb029    LIKE sfcb_t.sfcb029   #170322-00016#1   add
DEFINE l_sfcb046    LIKE sfcb_t.sfcb046   #170322-00016#1   add
DEFINE l_sfcb047    LIKE sfcb_t.sfcb047   #170322-00016#1   add
DEFINE l_sfcb048    LIKE sfcb_t.sfcb048   #170322-00016#1   add
DEFINE l_sfcb049    LIKE sfcb_t.sfcb049   #170322-00016#1   add
DEFINE l_sfcb051    LIKE sfcb_t.sfcb051   #170322-00016#1   add
DEFINE l_sfcb_chk2  LIKE sfcb_t.sfcb047   #170322-00016#1   add
DEFINE l_sfcb021    LIKE sfcb_t.sfcb021   #170405-00004#1   add
DEFINE l_sfcb022    LIKE sfcb_t.sfcb022   #170405-00004#1   add
DEFINE l_sfcb053    LIKE sfcb_t.sfcb053   #170405-00004#1   add
DEFINE l_sfcb054    LIKE sfcb_t.sfcb054   #170405-00004#1   add

   CALL util.JSON.parse(ls_js,lc_param)

   LET r_success = TRUE
   IF lc_param.sffb005 IS NULL OR
      lc_param.sffb006 IS NULL OR
      lc_param.sffb007 IS NULL OR
      lc_param.sffb008 IS NULL THEN
      RETURN r_success
   END IF
   IF cl_null(lc_param.sffb017) THEN LET lc_param.sffb017 = 0 END IF
   IF cl_null(lc_param.sffb018) THEN LET lc_param.sffb018 = 0 END IF
   IF cl_null(lc_param.sffb019) THEN LET lc_param.sffb019 = 0 END IF
   IF cl_null(lc_param.sffb020) THEN LET lc_param.sffb020 = 0 END IF
   
   #抓取當站製程資料
   LET l_sfcb027 = 0
   LET l_sfcb028 = 0
   LET l_sfcb_chk = 0   #170213-00031#1 add
   LET l_sfcb_chk1 = 0  #170224-00011#1 add
   LET l_sfcb_chk2 = 0  #170322-00016#1 add
   #170213-00031#1-s-mod
#   SELECT sfcb027,sfcb028
#     INTO l_sfcb027,l_sfcb028
#  SELECT sfcb027,((sfcb028+sfcb029+sfcb030+sfcb031+sfcb032)-(sfcb033+sfcb034+sfcb035+sfcb036+sfcb037+sfcb038+sfcb039))   #170322-00016#1 mark
   SELECT sfcb027,(sfcb028+sfcb029+sfcb030+sfcb031+sfcb032),(sfcb033+sfcb034+sfcb035+sfcb036+sfcb037+sfcb038+sfcb039)     #170322-00016#1 add
     #170224-00011#1-s-mod
#     INTO l_sfcb027,l_sfcb_chk
         ,(sfcb033+sfcb034+sfcb035+sfcb036+sfcb037)
         ,sfcb007,sfcb028   #170306-00002#1 add
         ,sfcb029,sfcb046,sfcb047,sfcb048,sfcb049,sfcb051   #170322-00016#1 add
         ,sfcb021,sfcb022,sfcb053,sfcb054                   #170405-00004#1 add
     INTO l_sfcb027,l_sfcb_chk,l_sfcb_chk2,l_sfcb_chk1   #170322-00016#1 add l_sfcb_chk2
         ,l_sfcb007,l_sfcb028   #170306-00002#1
         ,l_sfcb029,l_sfcb046,l_sfcb047,l_sfcb048,l_sfcb049,l_sfcb051    #170322-00016#1 add
         ,l_sfcb021,l_sfcb022,l_sfcb053,l_sfcb054                   #170405-00004#1 add
         
     #170224-00011#1-e-mod
   #170213-00031#1-e-mod
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbsite  = g_site
      AND sfcbdocno = lc_param.sffb005     #單號
      AND sfcb001   = lc_param.sffb006     #RUN CARD
      AND sfcb003   = lc_param.sffb007     #本站作業
      AND sfcb004   = lc_param.sffb008     #作業序
   IF cl_null(l_sfcb027) THEN LET l_sfcb027 = 0 END IF
#   IF cl_null(l_sfcb028) THEN LET l_sfcb028 = 0 END IF   #170213-00031#1 mark
   #170213-00031#1-s-add
   
   IF cl_null(l_sfcb_chk) THEN LET l_sfcb_chk = 0 END IF
   IF cl_null(l_sfcb_chk1) THEN LET l_sfcb_chk1 = 0 END IF   #170322-00016#1 add
   IF cl_null(l_sfcb_chk2) THEN LET l_sfcb_chk2 = 0 END IF   #170322-00016#1 add
   
   
  #170322-00016#1 mark  --begin-- 
  #LET l_sfca005 = ''
  #SELECT sfca005 INTO l_sfca005
  #  FROM sfca_t
  # WHERE sfcaent = g_enterprise
  #   AND sfcadocno = lc_param.sffb005
  #   AND sfca001 = lc_param.sffb006
  #
  #IF l_sfca005 = '2' THEN
  #   IF cl_null(lc_param.sffb017) THEN LET lc_param.sffb017 = 0 END IF
  #   IF cl_null(lc_param.sffb018) THEN LET lc_param.sffb018 = 0 END IF
  #   IF cl_null(lc_param.sffb019) THEN LET lc_param.sffb019 = 0 END IF
  #   IF cl_null(lc_param.sffb020) THEN LET lc_param.sffb020 = 0 END IF
  #   LET l_sfcb_chk = l_sfcb_chk + (lc_param.sffb017+lc_param.sffb018+lc_param.sffb019+lc_param.sffb020)
  #END IF
  ##170213-00031#1-e-add
  #170322-00016#1 mark  --end--
   
   LET l_sfaa010 = ''
   SELECT sfaa010 INTO l_sfaa010
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaasite = g_site
      AND sfaadocno = lc_param.sffb005
   #容许误差率
   LET l_imae020 = 0
   SELECT imae020 INTO l_imae020
     FROM imae_t
    WHERE imaeent  = g_enterprise
      AND imaesite = g_site
      AND imae001  = l_sfaa010
   IF cl_null(l_imae020) THEN LET l_imae020 = 0 END IF
   
   #170322-00016#1 add   --begin--
   #转入*（1+超交率）-转出-待做的
   IF lc_param.sffb001 = '3' THEN
     #LET l_sfcb_chk = l_sfcb_chk*(1+l_imae020/100) - l_sfcb_chk2 - l_sfcb046 - l_sfcb047 - l_sfcb048 - l_sfcb049 - l_sfcb051
      LET l_sfcb_chk = (l_sfcb_chk*(1+l_imae020/100) - l_sfcb046 - l_sfcb047) * l_sfcb054 / l_sfcb053 * l_sfcb021 /l_sfcb022 - l_sfcb_chk2 - l_sfcb048 - l_sfcb049 - l_sfcb051  #170405-00004#1 add
   END IF
   #170322-00016#1 add   --end--
   
   LET l_qty = 0
   LET l_sql = "   FROM sffb_t ",
               "  WHERE sffbent  = ",g_enterprise,
               "    AND sffbsite = '",g_site,"' ",
               "    AND sffb005  = '",lc_param.sffb005,"' ",
               "    AND sffb006  = '",lc_param.sffb006,"' ",
               "    AND sffb007  = '",lc_param.sffb007,"' ",
               "    AND sffb008  = '",lc_param.sffb008,"' ",
               "    AND sffbstus <> 'X' "
   IF NOT cl_null(lc_param.sffbdocno) THEN
      IF cl_null(lc_param.sffbseq) THEN
         LET l_sql = l_sql," AND NOT (sffbdocno = '",lc_param.sffbdocno,"')"
      ELSE
         LET l_sql = l_sql," AND NOT (sffbdocno = '",lc_param.sffbdocno,"' AND sffbseq = '",lc_param.sffbseq,"')"
      END IF
   END IF
   #170120-00043#1-s
   IF cl_null(lc_param.sffb001) THEN  #報廢
      LET l_sql = " SELECT MAX(SUM(sffb017+sffb018+sffb019+sffb020)) ",l_sql," GROUP BY sffb001 "
   ELSE
      LET l_sql = " SELECT SUM(sffb017+sffb018+sffb019+sffb020) ",l_sql," AND sffb001 = '",lc_param.sffb001,"' "
   END IF
   #170120-00043#1-e
   PREPARE s_asft335_sffb_qty FROM l_sql
   EXECUTE s_asft335_sffb_qty INTO l_qty
   IF cl_null(l_qty) THEN LET l_qty = 0 END IF
#   #170224-00011#1-s-add
#   IF l_sfcb_chk > l_sfcb027 THEN
#      LET l_sfcb_chk = l_sfcb027
#   END IF
#   #170224-00011#1-e-add
   CALL s_aooi200_get_slip(lc_param.sffb005) RETURNING l_success,g_doc_slip
   #依順序報工
   IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
      #良品数量 + 报废数量 + 当站下线数量 + 回收数量 > 良品轉入*(1+容許誤差率)
      #170213-00031#1-s-mod
#      IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > l_sfcb028*(1+l_imae020/100) THEN
      #170224-00011#1-s-mod
#      IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > l_sfcb_chk*(1+l_imae020/100) THEN
      #170306-00002#1-s-mod
       #當有報工過時
       IF l_sfcb_chk1 > 0 THEN
         #LET l_sfcb_chk = l_sfcb027*(1+l_imae020/100) - l_sfcb_chk1  #170322-00016#1 mark
         #170322-00016#1 add   --begin--
          IF l_sfcb027*(1+l_imae020/100) + l_sfcb029 * l_sfcb054 / l_sfcb053 * l_sfcb021 /l_sfcb022 - l_sfcb_chk1 < l_sfcb_chk THEN
             LET l_sfcb_chk = l_sfcb027*(1+l_imae020/100) + l_sfcb029 * l_sfcb054 / l_sfcb053 * l_sfcb021 /l_sfcb022 - l_sfcb_chk1
          END IF
         #170322-00016#1 add   --end--
       ELSE
         #170322-00016#1 mod   --begin--
         #IF l_sfcb_chk > l_sfcb027 THEN
         #   LET l_sfcb_chk = l_sfcb027
         #END IF
         #LET l_sfcb_chk = l_sfcb_chk*(1+l_imae020/100)
          IF l_sfcb_chk > l_sfcb027*(1+l_imae020/100) + l_sfcb029 * l_sfcb054 / l_sfcb053 * l_sfcb021 /l_sfcb022 THEN
             LET l_sfcb_chk = l_sfcb027*(1+l_imae020/100) + l_sfcb029 * l_sfcb054 / l_sfcb053 * l_sfcb021 /l_sfcb022
          END IF
         #170322-00016#1 mod   --end--
       END IF
#     #當為第一站時，報工數量可以為原需求量*(1+超交率)；當不為第一站時，報工數量至多為良品轉入(上站轉入數量)
#     IF l_sfcb007 = 'INIT' THEN
#        #當有報工過時
#        IF l_sfcb_chk1 > 0 THEN
#           LET l_sfcb_chk = l_sfcb027*(1+l_imae020/100) - l_sfcb_chk1
#        ELSE
#           IF l_sfcb_chk > l_sfcb027 THEN
#              LET l_sfcb_chk = l_sfcb027
#           END IF
#           LET l_sfcb_chk = l_sfcb_chk*(1+l_imae020/100)
#        END IF
#     ELSE
#        #當有報工過時
#        IF l_sfcb_chk1 > 0 THEN
#           LET l_sfcb_chk = l_sfcb028 - l_sfcb_chk1
#        ELSE
#           LET l_sfcb_chk = l_sfcb028
#        END IF
#     END IF
#     #170306-00002#1-e-mod
      IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > l_sfcb_chk THEN
      #170224-00011#1-e-mod
      #170213-00031#1-e-mod
         #良品數量%1+報廢數量%2+當站下線數量%3+回收數量%4不可大於良品轉入數量(含容許誤差率)%5！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00010'
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = lc_param.sffb017
         LET g_errparam.replace[2] = lc_param.sffb018
         LET g_errparam.replace[3] = lc_param.sffb019
         LET g_errparam.replace[4] = lc_param.sffb020
         #170213-00031#1-s-mod
#         LET g_errparam.replace[5] = l_sfcb028*(1+l_imae020/100)
         #170224-00011#1-s-mod
#         LET g_errparam.replace[5] = l_sfcb_chk*(1+l_imae020/100)
         LET g_errparam.replace[5] = l_sfcb_chk
         #170224-00011#1-e-mod
         #170213-00031#1-e-mod
         CALL cl_err()
         LET r_success = FALSE
      ELSE         
#         #170213-00031#1-s-mod
##         IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > (l_sfcb028*(1+l_imae020/100) - l_qty) THEN
#         IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > (l_sfcb_chk*(1+l_imae020/100) - l_qty) THEN
#         #170213-00031#1-e-mod
#            #良品數量%1+報廢數量%2+當站下線數量%3+回收數量%4不可大於良品轉入數量(含容許誤差率)%5！
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'asf-00010'
#            LET g_errparam.popup = TRUE
#            LET g_errparam.replace[1] = lc_param.sffb017
#            LET g_errparam.replace[2] = lc_param.sffb018
#            LET g_errparam.replace[3] = lc_param.sffb019
#            LET g_errparam.replace[4] = lc_param.sffb020
#            #170213-00031#1-s-mod
##            LET g_errparam.replace[5] = l_sfcb028*(1+l_imae020/100) - l_qty
#            LET g_errparam.replace[5] = l_sfcb_chk*(1+l_imae020/100) - l_qty
#            #170213-00031#1-e-mod
#            CALL cl_err()
#            LET r_success = FALSE
#         END IF
         #170213-00031#1-e-mark
      END IF      
   ELSE  #允许事后报工
      IF lc_param.sffb017 + lc_param.sffb018 + lc_param.sffb019 + lc_param.sffb020 > (l_sfcb027*(1+l_imae020/100) - l_qty) THEN
         #良品數量%1+報廢數量%2+當站下線數量%3+回收數量%4不可大於其剩餘的標準產量%5
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00754'
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = lc_param.sffb017
         LET g_errparam.replace[2] = lc_param.sffb018
         LET g_errparam.replace[3] = lc_param.sffb019
         LET g_errparam.replace[4] = lc_param.sffb020
         LET g_errparam.replace[5] = (l_sfcb027*(1+l_imae020/100) - l_qty)
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   FREE s_asft335_sffb_qty
   RETURN r_success
   #170117-00038#1-e
#170117-00038#1-s
#   DEFINE p_sffb005     LIKE sffb_t.sffb005
#   DEFINE p_sffb006     LIKE sffb_t.sffb006
#   DEFINE p_sffb007     LIKE sffb_t.sffb007
#   DEFINE p_sffb008     LIKE sffb_t.sffb008
#   DEFINE p_sffb017     LIKE sffb_t.sffb017
#   DEFINE p_sffb018     LIKE sffb_t.sffb018
#   DEFINE p_sffb019     LIKE sffb_t.sffb019
#   DEFINE p_sffb020     LIKE sffb_t.sffb020
#   DEFINE p_qty         LIKE sffb_t.sffb017   
#   DEFINE l_qty         LIKE sfcb_t.sfcb050
#   DEFINE l_sfaa010     LIKE sfaa_t.sfaa010
#   DEFINE l_imae020     LIKE imae_t.imae020
#   DEFINE r_success     LIKE type_t.num5
#   DEFINE l_success     LIKE type_t.num5
#   DEFINE l_sfcb021     LIKE sfcb_t.sfcb021
#   DEFINE l_sfcb022     LIKE sfcb_t.sfcb022
#   #160804-00029#1-add-(S)
#   DEFINE l_sfcb027     LIKE sfcb_t.sfcb027  
#   DEFINE l_amt         LIKE type_t.num20_6  
#   DEFINE l_sql         STRING 
#   #160804-00029#1-add-(E)
#   
#   LET r_success = TRUE
#   LET l_qty = 0
#   IF p_qty IS NULL THEN LET p_qty = 0 END IF
#   IF p_sffb005 IS NULL THEN RETURN r_success END IF
#   IF p_sffb006 IS NULL THEN RETURN r_success END IF
#   IF p_sffb007 IS NULL THEN RETURN r_success END IF
#   IF p_sffb008 IS NULL THEN RETURN r_success END IF
#   IF p_sffb017 IS NULL THEN LET p_sffb017 = 0 END IF
#   IF p_sffb018 IS NULL THEN LET p_sffb018 = 0 END IF
#   IF p_sffb019 IS NULL THEN LET p_sffb019 = 0 END IF
#   IF p_sffb020 IS NULL THEN LET p_sffb020 = 0 END IF
##抓工单对应数量和容许误差率
#   SELECT sfaa012,sfaa010 INTO l_qty,l_sfaa010 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaasite = g_site AND sfaadocno = p_sffb005
#   IF l_qty IS NULL THEN LET l_qty = 0 END IF
#   SELECT imae020 INTO l_imae020
#     FROM imae_t
#    WHERE imaeent  = g_enterprise
#      AND imaesite = g_site
#      AND imae001  = l_sfaa010
#      
#   IF l_imae020 IS NULL THEN
#      LET l_imae020 = 0
#   END IF
#   CALL s_aooi200_get_slip(p_sffb005) RETURNING l_success,g_doc_slip
#   IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN   #允许事后报工 ='N'
##抓对应作业类别的待处理数量
#      IF p_sffb017 + p_sffb018 + p_sffb019 + p_sffb020 > p_qty*(1+l_imae020/100) THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00010'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         LET g_errparam.replace[1] = p_sffb017
#         LET g_errparam.replace[2] = p_sffb018
#         LET g_errparam.replace[3] = p_sffb019
#         LET g_errparam.replace[4] = p_sffb020
#         LET g_errparam.replace[5] = p_qty*(1+l_imae020/100)
#         CALL cl_err()
#
#         LET r_success = FALSE
#      END IF      
#   ELSE
#      #160804-00029#1-add-(S)
#      #抓取當站標準產出量   
#      SELECT sfcb027 INTO l_sfcb027
#        FROM sfcb_t
#       WHERE sfcbent = g_enterprise
#         AND sfcbsite = g_site
#         AND sfcbdocno = p_sffb005   #單號
#         AND sfcb001 = p_sffb006     #RUN CARD
#         AND sfcb003 = p_sffb007     #本站作業
#      #抓取當站已轉良品量(抓其他張<>'X' & 抓當張+排除正在輸入的項次)
#      LET l_amt = 0
#      LET l_sql = " SELECT SUM(sffb017) + SUM(sffb018) + SUM(sffb019) + SUM(sffb020) ",
#                  "   FROM sffb_t ",
#                  "  WHERE sffbent = '",g_enterprise,"'",
#                  "    AND sffbsite = '",g_site,"'",
#                  "    AND sffb005 = '",p_sffb005,"'",
#                  "    AND sffb006 = '",p_sffb006,"'",
#                  "    AND sffb007 = '",p_sffb007,"'",
#                  "    AND sffb008 = '",p_sffb008,"'",   #add by jixf 170524
#                  "    AND sffbstus <> 'X'"
#      IF g_prog MATCHES 'asft330' THEN
#         #如果是按確認的話，會沒有項次，此時只需排除自己這張單就好
#         #如果是單身的部分，需要排除當下輸入的那一行項次
#         IF NOT cl_null(g_sffbseq) AND g_sffbseq = 0 THEN
#           LET l_sql = l_sql CLIPPED , " AND (sffbdocno <> '",g_sffadocno,"') "
#         ELSE
#           LET l_sql = l_sql CLIPPED , " AND ( (sffbdocno <> '",g_sffadocno,"' ) OR (sffbdocno = '",g_sffadocno,"'  AND sffbseq <> '",g_sffbseq,"') ) "
#         END IF
#      ELSE
#         #除了asft330以外的程式，都是單一報工，排除自己的單子就好
#         LET l_sql = l_sql CLIPPED , " AND (sffbdocno <> '",g_sffadocno,"') "
#      END IF
#      PREPARE s_asft335_sffb_qty FROM l_sql
#      EXECUTE s_asft335_sffb_qty INTO l_amt
#      IF cl_null(l_amt) THEN
#         LET l_amt = 0
#      END IF
#      #asft330(良品數量+報廢數量+當站下線+回收數量) > asft301(標準產出量
#      IF p_sffb017 + p_sffb018 + p_sffb019 + p_sffb020 > (l_sfcb027 - l_amt) THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00754'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         LET g_errparam.replace[1] = p_sffb017
#         LET g_errparam.replace[2] = p_sffb018
#         LET g_errparam.replace[3] = p_sffb019
#         LET g_errparam.replace[4] = p_sffb020
#         LET g_errparam.replace[5] = (l_sfcb027 - l_amt)
#         CALL cl_err()
#     
#         LET r_success = FALSE
#      END IF
#      FREE s_asft335_sffb_qty
#      #160804-00029#1-add-(E)
##抓工单的生产数量
##把生产数量按制程的转换率分子分母转成这一站的数量
##固定这里是报工sffb001 =3，所以只需要抓转出单位分子分母
#      LET l_sfcb021 = NULL
#      LET l_sfcb022 = NULL
#      SELECT sfcb021,sfcb022 INTO l_sfcb021,l_sfcb022 
#        FROM sfcb_t
#       WHERE sfcbent  = g_enterprise
#         AND sfcbdocno = p_sffb005
#         AND sfcb001  = p_sffb006
#         AND sfcb003  = p_sffb007
#         AND sfcb004  = p_sffb008
#         
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 's_asft335_chk_qty_sel_sfcb021_sfcb022'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         LET r_success = FALSE
#         RETURN r_success
#      END IF 
#
#      LET p_qty = l_qty*l_sfcb021/l_sfcb022
#      
#      IF p_sffb017 + p_sffb018 + p_sffb019 + p_sffb020 > p_qty*(1+l_imae020/100) THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'asf-00011'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         LET r_success = FALSE
#      END IF 
#   END IF
#   RETURN r_success
#170117-00038#1-e
END FUNCTION
################################################################################
# Descriptions...: 建立临时表
# Memo...........: 必须用于事务外
# Usage..........: CALL s_asft335_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      临时表建立成功否
# Date & Author..: 2014/01/15 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_cre_tmp_table()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING    #160730-00003#1 add

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
 
 #用来存放审核报工当站的下一站资料  
   DROP TABLE s_asft335_tmp01;
   CREATE TEMP TABLE s_asft335_tmp01(
      chk          LIKE type_t.chr1,       #去除重复使用的，N是没去过重复的，Y是去重之后的结果
      sfcbdocno    LIKE sfcb_t.sfcbdocno,
      sfcb001      LIKE sfcb_t.sfcb001,
      sfcb003      LIKE sfcb_t.sfcb003,
      sfcb004      LIKE sfcb_t.sfcb004,
      sfcb005      LIKE sfcb_t.sfcb005,     #群组性质
      sfcb006      LIKE sfcb_t.sfcb006,     #群组
      type         LIKE sffb_t.sffb001,     #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
      sfcb021      LIKE sfcb_t.sfcb021,     #转出单位换算率分子
      sfcb022      LIKE sfcb_t.sfcb022,     #转出单位换算率分母
      amt          LIKE sfcb_t.sfcb050,     #与上面匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
      sfcb053      LIKE sfcb_t.sfcb053,     #转入单位换算率分子
      sfcb054      LIKE sfcb_t.sfcb054      #转入单位换算率分母 
   );
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

#用来_prevsfcb_next所有报工的上站资料，所存_prev算后得出下站应该有多少数量
   DROP TABLE s_asft335_tmp02;
   CREATE TEMP TABLE s_asft335_tmp02(
      chk          LIKE type_t.chr1,   #去除重复使用的，N是没去过重复的，Y是去重之后的结果   
      sfcbdocno    LIKE sfcb_t.sfcbdocno,   #工单单号
      sfcb001      LIKE sfcb_t.sfcb001,     #RunCard单号
      sfcb003      LIKE sfcb_t.sfcb003,     #作业编号
      sfcb004      LIKE sfcb_t.sfcb004,     #制程序
      sfcb005      LIKE sfcb_t.sfcb005,     #群组性质
      sfcb006      LIKE sfcb_t.sfcb006,     #群组
      type         LIKE sffb_t.sffb001,     #报工类型，用12345对应sfcb014，sfcb015，sfcb016，sfcb018，sfcb019
      sfcb021      LIKE sfcb_t.sfcb021,     #转出单位换算率分子
      sfcb022      LIKE sfcb_t.sfcb022,     #转出单位换算率分母
      amt          LIKE sfcb_t.sfcb050,     #与上面type匹配的sfcb046，sfcb047，sfcb048，sfcb049，sfcb050
      sfcb053      LIKE sfcb_t.sfcb053,     #转入单位换算率分子
      sfcb054      LIKE sfcb_t.sfcb054      #转入单位换算率分母
   );
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   
   #160730-00003#1 --s
   DROP TABLE s_asft335_sffbtmp;
   LET l_sql = " SELECT * FROM sffb_t ",
               "  WHERE sffbent = ",g_enterprise,
               "    AND sffbdocno  = 'xx'  ",
               "    AND sffbseq = 0 ",
               "   INTO TEMP s_asft335_sffbtmp "
   PREPARE s_asft335_cre_tmp_table_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE s_asft335_cre_tmp_table_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   EXECUTE s_asft335_cre_tmp_table_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE s_asft335_cre_tmp_table_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE s_asft335_cre_tmp_table_p1
   #160730-00003#1 --e
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 获得下一站的所有上一站报工
# Memo...........:
# Usage..........: CALL s_asft335_get_prev_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success
# Input parameter: p_sffb001      作业类型
#                : p_sfcbdocno    工单单号
#                : p_sfcb001      RunCard单号
#                : p_sfcb003      作业编号
#                : p_sfcb004      制程序
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/01/10 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_prev_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作业类型
   DEFINE p_sfcbdocno         LIKE sfcb_t.sfcbdocno        #工单单号
   DEFINE p_sfcb001           LIKE sfcb_t.sfcb001          #RunCard单号
   DEFINE p_sfcb003           LIKE sfcb_t.sfcb003          #作业编号
   DEFINE p_sfcb004           LIKE sfcb_t.sfcb004          #制程序
   DEFINE l_sfcb_prev         DYNAMIC ARRAY OF type_sfcb_prev
   DEFINE l_sfcb_prev1        DYNAMIC ARRAY OF RECORD
                              sfcb003  LIKE sfcb_t.sfcb003,
                              sfcb004  LIKE sfcb_t.sfcb004
                              END RECORD
   DEFINE l_sfcc003           DYNAMIC ARRAY OF LIKE sfcc_t.sfcc003       
   DEFINE r_success           LIKE type_t.num5
   DEFINE i                   LIKE type_t.num5
   DEFINE j                   LIKE type_t.num5
   DEFINE l_sfcb002           LIKE sfcb_t.sfcb002
   DEFINE l_sfcb006           LIKE sfcb_t.sfcb006
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_errmsg            STRING
   
   LET r_success = TRUE
   LET l_errmsg = NULL
#先看本站里前续步骤是否有勾选的，有的话插入临时表，本站没有勾选前续步骤再找上上一站
   CALL s_asft335_get_prev_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004) RETURNING l_success,l_errmsg
   IF l_success THEN
      LET r_success = TRUE
      RETURN r_success
   ELSE
      IF l_errmsg IS NOT NULL THEN
         LET r_success = l_success
         RETURN r_success
      END IF
   END IF   

#找上一站参考s_asft335_get_next_station()的逻辑，先考虑sfcc里存的是明细的作业编号+作业序，再考虑存的是群组代号
   EXECUTE s_asft335_ins_sfcb_prev USING p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'EXECUTE s_asft335_ins_sfcb_prev'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 

   PREPARE s_asft335_sel_sfcb_prev_pb FROM g_sel_sfcb_prev_sql
   DECLARE s_asft335_sel_sfcb_prev CURSOR FOR s_asft335_sel_sfcb_prev_pb
   OPEN s_asft335_sel_sfcb_prev USING p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004
   LET i = 1
   CALL l_sfcb_prev.clear()
   FOREACH s_asft335_sel_sfcb_prev INTO l_sfcb_prev[i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      LET i = i + 1 
   END FOREACH
   FREE s_asft335_sel_sfcb_prev
   CLOSE s_asft335_sel_sfcb_prev 
   CALL l_sfcb_prev.deleteElement(l_sfcb_prev.getLength())
   IF l_sfcb_prev.getLength() > 0 THEN  
      FOR i = 1 TO l_sfcb_prev.getLength()
#这站没报工，递归去找上上一站(l_sfcb_prev.*的其他变量没用到，但还是都选出来，预留可能以后会用)
         IF NOT s_asft335_get_prev_station(0,l_sfcb_prev[i].sfcbdocno,l_sfcb_prev[i].sfcb001,l_sfcb_prev[i].sfcb003,l_sfcb_prev[i].sfcb004) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF  
      END FOR
   END IF
#以上是基于sfcc里上站作业编号存的是明细的作业编号，接下来考虑存的是群组 
#先把sfcc里存的群组都找出来（sfcc004 = 0 AND sfcc003 <> 'INIT'）
#再按每个群组包含的明细作业编号+作业序找出来，这些就是我们要找的上一站
#每一个上一站都先检查是否有勾选步骤，没有的话继续找上上站
   SELECT sfcb002,sfcb006 INTO l_sfcb002,l_sfcb006 
     FROM sfcb_t
    WHERE sfcbent    = g_enterprise
      AND sfcbdocno  = p_sfcbdocno
      AND sfcb001    = p_sfcb001
      AND sfcb003    = p_sfcb003
      AND sfcb004    = p_sfcb004
      
     
   DECLARE s_asft335_sel_sfcc003 CURSOR FOR
   SELECT DISTINCT sfcc003 FROM sfcc_t,sfcb_t   #上站的下一站作业编号栏位里存的是具体的作业编号
    WHERE sfccent   = g_enterprise
      AND sfccdocno = p_sfcbdocno
      AND sfcc001   = p_sfcb001
      AND sfcc002   = l_sfcb002
      AND sfcc003 <> 'INIT'
      AND sfcc004   = '0'
      AND sfcbent   = sfccent
      AND sfcbdocno = sfccdocno
      AND sfcb001   = sfcc001
      AND sfcb006   = sfcc003
      AND sfcb005 <> '1'
      AND sfcb009   = p_sfcb003
      AND sfcb010   = p_sfcb004
   UNION
   SELECT DISTINCT sfcc003 FROM sfcc_t,sfcb_t   #上站的下一站作业编号栏位里存的是下站所在的群组
    WHERE sfccent   = g_enterprise
      AND sfccdocno = p_sfcbdocno
      AND sfcc001   = p_sfcb001
      AND sfcc002   = l_sfcb002
      AND sfcc003 <> 'INIT'
      AND sfcc004   = '0'
      AND sfcbent   = sfccent
      AND sfcbdocno = sfccdocno
      AND sfcb001   = sfcc001
      AND sfcb006   = sfcc003
      AND sfcb005 <> '1'
      AND sfcb009   = l_sfcb006   #即使l_sfcb006是null也没关系，如果是null，那这段sql本来就不该选出资料来
  

   LET i = 1  #群组用
   LET j = 1  #明细作业编号用
   CALL l_sfcc003.clear()
   CALL l_sfcb_prev1.clear()
   FOREACH s_asft335_sel_sfcc003 INTO l_sfcc003[i]   #找到群组
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      DECLARE s_asft335_sel_sfcb_prev1 CURSOR FOR
      SELECT sfcb003,sfcb004 FROM sfcb_t
       WHERE sfcbent    = g_enterprise
         AND sfcbdocno  = p_sfcbdocno
         AND sfcb001    = p_sfcb001
         AND sfcb005    <> '1'
         AND sfcb006    = l_sfcc003[i]

      FOREACH s_asft335_sel_sfcb_prev1 INTO l_sfcb_prev1[j].*  #找到明细作业编号+作业序
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
         LET j = j + 1
      END FOREACH
         
      LET i = i + 1   
   END FOREACH
   
   CALL l_sfcb_prev1.deleteElement(l_sfcb_prev1.getLength())
   IF l_sfcb_prev1.getLength() > 0 THEN
      FOR j = 1 TO l_sfcb_prev1.getLength()
#先看明细作业编号里前续步骤是否有勾选的，有的话插入临时表，本站没有勾选前续步骤再找上上一站
         LET l_errmsg = NULL
         CALL s_asft335_get_prev_action(0,p_sfcbdocno,p_sfcb001,l_sfcb_prev1[j].sfcb003,l_sfcb_prev1[j].sfcb004) RETURNING l_success,l_errmsg
         IF l_success THEN         
            LET r_success = TRUE
            CONTINUE FOR   #这笔有勾选，继续处理下一笔
         ELSE              #这笔没勾选，找他的上上站
            IF l_errmsg IS NOT NULL THEN
               LET r_success = l_success
               RETURN r_success
            END IF         
            IF NOT s_asft335_get_prev_station(0,p_sfcbdocno,p_sfcb001,l_sfcb_prev1[j].sfcb003,l_sfcb_prev1[j].sfcb004) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
      END FOR
   END IF
   
   RETURN r_success   
END FUNCTION
################################################################################
# Descriptions...: 找到下一站
# Memo...........:
# Usage..........: CALL s_asft335_get_next_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success
# Input parameter: p_sffb001      作业类型
#                : p_sfcbdocno    工单单号
#                : p_sfcb001      RunCard单号
#                : p_sfcb003      作业编号
#                : p_sfcb004      制程序
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/01/10 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_next_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作业类型
   DEFINE p_sfcbdocno         LIKE sfcb_t.sfcbdocno        #工单单号
   DEFINE p_sfcb001           LIKE sfcb_t.sfcb001          #RunCard单号
   DEFINE p_sfcb003           LIKE sfcb_t.sfcb003          #作业编号
   DEFINE p_sfcb004           LIKE sfcb_t.sfcb004          #制程序
   DEFINE l_sfcb_next         DYNAMIC ARRAY OF type_sfcb_next
   DEFINE r_success           LIKE type_t.num5
   DEFINE i                   LIKE type_t.num5
   DEFINE l_sfcc002           DYNAMIC ARRAY OF LIKE sfcc_t.sfcc002
   DEFINE l_sfcb006           LIKE sfcb_t.sfcb006
   DEFINE l_sfcb003           LIKE sfcb_t.sfcb003        
   DEFINE l_sfcb004           LIKE sfcb_t.sfcb004 
   DEFINE l_sfcb009           LIKE sfcb_t.sfcb009
   DEFINE l_sfcb010           LIKE sfcb_t.sfcb010
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_errmsg            STRING
      
   
   LET r_success = TRUE
   LET l_errmsg = NULL
#先看本站里后续步骤是否有勾选的，有的话插入临时表，本站没有勾选后续步骤再找下一站
   CALL s_asft335_get_next_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004) RETURNING l_success,l_errmsg
   IF l_success THEN
      LET r_success = TRUE
      RETURN r_success
   ELSE
      IF l_errmsg IS NOT NULL THEN
         LET r_success = l_success
         RETURN r_success
      END IF
   END IF

#本站没有后续勾选步骤，找传入参数的所有下一站的第一个勾选步骤插入临时表
#找下一站分2种情况，假设本站是A，下一站是B
#1：A的作业编号+作业序在B的上站档sfcc里存在，用sfcc003=A AND sfcc004 = A的作业序 AND B有勾选步骤，就能找到B并插入临时表,
   EXECUTE s_asft335_ins_sfcb_next USING p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'EXECUTE s_asft335_ins_sfcb_next'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 

#同上查询条件，但是5个步骤都没勾选的B站点找出来，继续找他们的下下站 
   PREPARE s_asft335_sel_sfcb_next_pb FROM g_sel_sfcb_next_sql
   DECLARE s_asft335_sel_sfcb_next CURSOR FOR s_asft335_sel_sfcb_next_pb
   OPEN s_asft335_sel_sfcb_next USING p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004
   LET i = 1
   FOREACH s_asft335_sel_sfcb_next INTO l_sfcb_next[i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      LET i = i + 1
   END FOREACH
   FREE s_asft335_sel_sfcb_next
   CLOSE s_asft335_sel_sfcb_next
   CALL l_sfcb_next.deleteElement(l_sfcb_next.getLength())
   IF l_sfcb_next.getLength() > 0  THEN  
      FOR i = 1 TO l_sfcb_next.getLength()
#这站没报工，递归去找下下一站(l_sfcb_next.*的其他变量没用到，但还是都选出来，预留可能以后会用)
         IF NOT s_asft335_get_next_station(0,l_sfcb_next[i].sfcbdocno,l_sfcb_next[i].sfcb001,l_sfcb_next[i].sfcb003,l_sfcb_next[i].sfcb004) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END FOR
   END IF
#2：（忘了情况2的请往上看几十行） 
#A存在于一个叫T1的群组之内，那有可能B的sfcc里没有记录具体的A，而是记录了群组T1
#这时候就要先找到A处于哪个群组，然后用群组+0去sfcc里找，才能找到A的所有的下一站B（可能存在多个B）
#更新一点，还要加个条件，同时A的下站作业sfcb009要是B或者B所在的群组
   LET l_sfcb006 = NULL
   SELECT sfcb006,sfcb009,sfcb010 INTO l_sfcb006,l_sfcb009,l_sfcb010
     FROM sfcb_t
    WHERE sfcbent = g_enterprise
      AND sfcbdocno = p_sfcbdocno
      AND sfcb001   = p_sfcb001
      AND sfcb003   = p_sfcb003
      AND sfcb004   = p_sfcb004
      AND sfcb005   <> '1'   #要有群组,没群组的不要
    
   IF l_sfcb006 IS NOT NULL THEN  #有群组，按群组到sfcc里去找B
      DECLARE s_asft335_sel_sfcc_next_mult CURSOR FOR 
       SELECT sfcc002                    #A的下一站存的是B本身作业编号
         FROM sfcc_t,sfcb_t
        WHERE sfccent = g_enterprise
          AND sfccdocno = p_sfcbdocno
          AND sfcc001   = p_sfcb001  
          AND sfcc003   = l_sfcb006
          AND sfcc004   = '0'
          AND sfcbent   = sfccent
          AND sfcbsite  = sfccsite
          AND sfcbdocno = sfccdocno
          AND sfcb001   = sfcc001
          AND sfcb002   = sfcc002
          AND sfcb003   = l_sfcb009
          AND sfcb004   = l_sfcb010   
      UNION
       SELECT sfcc002                     #A的下一站存的是B所在的群组
         FROM sfcc_t,sfcb_t
        WHERE sfccent = g_enterprise
          AND sfccdocno = p_sfcbdocno
          AND sfcc001   = p_sfcb001  
          AND sfcc003   = l_sfcb006
          AND sfcc004   = '0'
          AND sfcbent   = sfccent
          AND sfcbsite  = sfccsite
          AND sfcbdocno = sfccdocno
          AND sfcb001   = sfcc001
          AND sfcb002   = sfcc002
          AND sfcb005 <> '1'             
          AND sfcb006   = l_sfcb009
          
      CALL l_sfcc002.clear() 
      LET i = 1
#l_sfcc002就是A的下一站B的项次，然后先找B站的每一个步骤，看是否有勾选Y，没勾选，再递归找B的下一站
      FOREACH s_asft335_sel_sfcc_next_mult INTO l_sfcc002[i]
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
         LET i = i + 1
      END FOREACH
      FREE s_asft335_sel_sfcc_next_mult
      CLOSE s_asft335_sel_sfcc_next_mult
      CALL l_sfcc002.deleteElement(l_sfcc002.getLength())
      IF l_sfcc002.getLength() > 0  THEN       
         FOR i = 1 TO l_sfcc002.getLength()
#先找B的每一个步骤
            LET l_sfcb003 = NULL
            LET l_sfcb004 = NULL
            SELECT sfcb003,sfcb004 INTO l_sfcb003,l_sfcb004
              FROM sfcb_t
             WHERE sfcbent = g_enterprise
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb002   = l_sfcc002[i]
             
            LET l_errmsg = NULL 
            CALL s_asft335_get_next_action(0,p_sfcbdocno,p_sfcb001,l_sfcb003,l_sfcb004) RETURNING l_success,l_errmsg
            IF l_success THEN
               LET r_success = TRUE
               CONTINUE FOR   #这里不能return，因为可能有多个下一站，这行找到了勾选步骤，还要接着找下一笔的
            ELSE              #这里就是没勾选步骤，接着找下下站
               IF l_errmsg IS NOT NULL THEN    #有错误了，不做了，直接返回
                  LET r_success = l_success
                  RETURN r_success
               END IF
               IF NOT s_asft335_get_next_station(0,p_sfcbdocno,p_sfcb001,l_sfcb003,l_sfcb004) THEN
                  LET r_success = FALSE
                  RETURN r_success
               END IF            
            END IF
         END FOR 
      END IF         
   END IF   
   RETURN r_success   
END FUNCTION
################################################################################
# Descriptions...: 报工单中工单+runcard栏位带来的预设值（生产料号，工单使用制程否，RunCard单号，作业，制程序，工作站）
# Memo...........:
# Usage..........: CALL s_asft335_default_sffb056(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
#                  RETURNING r_sfaa010,r_sffb007,r_sffb008
# Input parameter: p_sffb001      报工类型
#                : p_sffb005      工单单号
#                : p_sffb006      runcard单号
#                : p_sffb007      作业编号
#                : p_sffb008      作业序
# Return code....: r_sffa010      生产料号
#                : r_sffa061      工单使用制程否
#                : r_sffb006      runcard单号
#                : r_sffb007      作业编号
#                : r_sffb008      制程序
#                : r_sffb009      工作站
# Date & Author..: 2014/01/05  By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_default_sffb056(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
   DEFINE p_sffb001       LIKE sffb_t.sffb001
   DEFINE p_sffb005       LIKE sffb_t.sffb005
   DEFINE p_sffb006       LIKE sffb_t.sffb006 
   DEFINE p_sffb007       LIKE sffb_t.sffb007
   DEFINE p_sffb008       LIKE sffb_t.sffb008
   DEFINE r_sfaa010       LIKE sfaa_t.sfaa010  
   DEFINE r_sffb006       LIKE sffb_t.sffb006   
   DEFINE r_sffb007       LIKE sffb_t.sffb007 
   DEFINE r_sffb008       LIKE sffb_t.sffb008 
   DEFINE r_sffb009       LIKE sffb_t.sffb009   
   DEFINE l_cnt           LIKE type_t.num5 
   DEFINE l_sfca001       LIKE sfca_t.sfca001   
   DEFINE l_sfcb003       LIKE sfcb_t.sfcb003 
   DEFINE l_sfcb004       LIKE sfcb_t.sfcb004
   DEFINE l_sfcb011       LIKE sfcb_t.sfcb011  
   DEFINE l_sfaa010       LIKE sfaa_t.sfaa010
   DEFINE l_sfaa061       LIKE sfaa_t.sfaa061
   DEFINE r_sffb030       LIKE sffb_t.sffb030   #fengmy151013 add
   
   WHENEVER ERROR CONTINUE
 #抓取工单号对应的料号  
   LET r_sfaa010  = NULL  
   LET r_sffb006  = NULL   
   LET r_sffb007  = NULL 
   LET r_sffb008  = NULL 
   LET r_sffb009  = NULL   
   LET l_cnt      = 0 
   LET l_sfca001  = NULL   
   LET l_sfcb003  = NULL 
   LET l_sfcb004  = NULL
   LET l_sfcb011  = NULL  
   LET l_sfaa010  = NULL
   LET l_sfaa061  = NULL  
   LET r_sffb030  = NULL  #fengmy151016
   
   IF p_sffb005 IS NULL THEN
      RETURN r_sfaa010,r_sffb006,r_sffb007,r_sffb008,r_sffb009,r_sffb030  #fengmy151016 add r_sffb030
   END IF
   
   SELECT sfaa010,sfaa061 INTO l_sfaa010,l_sfaa061 FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaasite  = g_site
      AND sfaadocno = p_sffb005

#如果使用制程，传入的作业编号，作业序是空格，就清空，可能是上次工单号是不使用制程给了空格的
   IF l_sfaa061 = 'Y' THEN
      IF p_sffb007 = ' ' THEN LET p_sffb007 = NULL END IF
      IF p_sffb008 = ' ' THEN LET p_sffb008 = NULL END IF
   END IF
 #如果传入的p_sffb006是null，则判断当工单号对应的run card是唯一的时，预设run card值
   LET l_sfca001 = NULL
   IF p_sffb006 IS NULL THEN
      SELECT COUNT(sfca001) INTO l_cnt FROM sfca_t
       WHERE sfcaent  = g_enterprise
         AND sfcasite = g_site
         AND sfcadocno= p_sffb005
      IF l_cnt = 1 THEN 
         SELECT sfca001 INTO l_sfca001 FROM sfca_t
          WHERE sfcaent  = g_enterprise
            AND sfcasite = g_site
            AND sfcadocno= p_sffb005
            
      END IF
   ELSE
      LET l_sfca001 = p_sffb006
   END IF
#若有工单和Run Card，则根据作业类别选择不同的作业编号预设值
   IF l_sfca001 IS NOT NULL AND l_sfaa061 = 'Y' AND p_sffb001 IS NOT NULL THEN
#作业编号为空
      IF p_sffb007 IS NULL THEN
         LET p_sffb006 = l_sfca001
#带出作业编号+制程序
         LET l_cnt = 0
         LET l_sfcb003 = NULL
         LET l_sfcb004 = NULL
         LET l_sfcb011 = NULL
         CASE p_sffb001
           WHEN '1'   #Move In
              SELECT COUNT(sfcb003) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb046 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb003 INTO l_sfcb003
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb046 > 0
              END IF
                 
           WHEN '2'   #Check In
              SELECT COUNT(sfcb003) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb047 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb003 INTO l_sfcb003
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb047 > 0
              END IF
           WHEN '3'   #报工
              SELECT COUNT(sfcb003) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb050 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb003 INTO l_sfcb003
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb050 > 0
              END IF
           WHEN '4'   #Check Out
              SELECT COUNT(sfcb003) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb048 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb003 INTO l_sfcb003
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb048 > 0
              END IF
           WHEN '5'   #Move Out
              SELECT COUNT(sfcb003) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb049 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb003 INTO l_sfcb003
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb049 > 0
              END IF
         END CASE
         IF l_cnt = 1 THEN
            IF p_sffb007 IS NOT NULL THEN
               LET l_sfcb003 = p_sffb007
            END IF
            LET l_cnt = 0
            SELECT COUNT(sfcb004) INTO l_cnt
              FROM sfcb_t
             WHERE sfcbent  = g_enterprise
               AND sfcbsite = g_site
               AND sfcbdocno= p_sffb005
               AND sfcb001  = p_sffb006
               AND sfcb003  = l_sfcb003
         
            IF l_cnt = 1 THEN
               LET l_sfcb004 = NULL
               LET l_sfcb011 = NULL
               SELECT sfcb004,sfcb011 INTO l_sfcb004,l_sfcb011
                 FROM sfcb_t
                WHERE sfcbent  = g_enterprise
                  AND sfcbsite = g_site
                  AND sfcbdocno= p_sffb005
                  AND sfcb001  = p_sffb006
                  AND sfcb003  = l_sfcb003
            END IF
         END IF
      END IF
#作业编号不为空
      IF p_sffb007 IS NOT NULL THEN
         LET p_sffb006 = l_sfca001
#带出制程序
         LET l_cnt = 0
         LET l_sfcb003 = NULL
         LET l_sfcb004 = NULL
         LET l_sfcb011 = NULL
         CASE p_sffb001
           WHEN '1'   #Move In
              SELECT COUNT(sfcb004) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb003  = p_sffb007
                 AND sfcb046 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb004 INTO l_sfcb004
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb003  = p_sffb007
                    AND sfcb046 > 0
              END IF
                 
           WHEN '2'   #Check In
              SELECT COUNT(sfcb004) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb003  = p_sffb007
                 AND sfcb047 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb004 INTO l_sfcb004
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb003  = p_sffb007
                    AND sfcb047 > 0
              END IF
           WHEN '3'   #报工
              SELECT COUNT(sfcb004) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb003  = p_sffb007
                 AND sfcb050 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb004 INTO l_sfcb004
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb003  = p_sffb007
                    AND sfcb050 > 0
              END IF
           WHEN '4'   #Check Out
              SELECT COUNT(sfcb004) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb003  = p_sffb007
                 AND sfcb048 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb004 INTO l_sfcb004
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb003  = p_sffb007
                    AND sfcb048 > 0
              END IF
           WHEN '5'   #Move Out
              SELECT COUNT(sfcb004) INTO l_cnt
                FROM sfcb_t
               WHERE sfcbent  = g_enterprise
                 AND sfcbsite = g_site
                 AND sfcbdocno= p_sffb005
                 AND sfcb001  = p_sffb006
                 AND sfcb003  = p_sffb007
                 AND sfcb049 > 0
              IF l_cnt = 1 THEN   
                 SELECT sfcb004 INTO l_sfcb004
                   FROM sfcb_t
                  WHERE sfcbent  = g_enterprise
                    AND sfcbsite = g_site
                    AND sfcbdocno= p_sffb005
                    AND sfcb001  = p_sffb006
                    AND sfcb003  = p_sffb007
                    AND sfcb049 > 0
              END IF
         END CASE
      END IF
   END IF 
  
   LET r_sfaa010  = l_sfaa010 
   LET r_sffb006  = l_sfca001 
   IF p_sffb007 IS NOT NULL THEN LET l_sfcb003 = p_sffb007 END IF
   IF p_sffb008 IS NOT NULL THEN LET l_sfcb004 = p_sffb008 END IF
   IF l_sfaa061 = 'Y' THEN   
      LET r_sffb007  = l_sfcb003
      LET r_sffb008  = l_sfcb004
   ELSE
      LET r_sffb007  = ' '
      LET r_sffb008  = ' '   
   END IF
   IF l_sfcb011 IS NULL THEN
      SELECT sfcb011 INTO l_sfcb011
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = r_sffb007
         AND sfcb004  = r_sffb008
   END IF
   LET r_sffb009  = l_sfcb011
   
   CALL s_asft335_default_sffb030(r_sffb009) RETURNING r_sffb030 #fengmy151013 add
   
   RETURN r_sfaa010,r_sffb006,r_sffb007,r_sffb008,r_sffb009,r_sffb030

END FUNCTION
################################################################################
# Descriptions...: 找到当前作业编号+制程序的下一站中第一个勾选的步骤并更新它的待xx数量
# Memo...........:
# Usage..........: CALL s_asft335_upd_next_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success
# Input parameter: p_cmd          审核1/取消审核-1
#                : p_sffb001      作业类型
#                : p_sfcbdocno    工单单号
#                : p_sfcb001      RunCard单号
#                : p_sfcb003      作业编号
#                : p_sfcb004      制程序
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2013/12/24 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_next_station(p_cmd,p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_cmd               LIKE type_t.num5             #审核 1/取消审核 -1   
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作业类型 0 表示从发料过来的
   DEFINE p_sfcbdocno         LIKE sfcb_t.sfcbdocno        #工单单号
   DEFINE p_sfcb001           LIKE sfcb_t.sfcb001          #RunCard单号
   DEFINE p_sfcb003           LIKE sfcb_t.sfcb003          #作业编号
   DEFINE p_sfcb004           LIKE sfcb_t.sfcb004          #制程序
   DEFINE r_success           LIKE type_t.num5
   DEFINE i                   LIKE type_t.num5
   DEFINE j                   LIKE type_t.num5
   DEFINE l_sfcb_next         type_sfcb_next    
   DEFINE l_amt               LIKE sffb_t.sffb017    
   DEFINE l_sfcb046           LIKE sfcb_t.sfcb046
   DEFINE l_sfcb047           LIKE sfcb_t.sfcb047
   DEFINE l_sfcb048           LIKE sfcb_t.sfcb048
   DEFINE l_sfcb049           LIKE sfcb_t.sfcb049
   DEFINE l_sfcb050           LIKE sfcb_t.sfcb050
   
#为后续查找上下站做cursor定义
   CALL s_asft335_declare_sfcb()
   LET r_success = TRUE
#先找到所有的下一站（但是数量栏位都是原始的未改过的，最后计算了才累加上去）
   DELETE FROM s_asft335_tmp01
   IF NOT s_asft335_get_next_station(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
#去除重复站点
   INSERT INTO s_asft335_tmp01 
   SELECT DISTINCT 'Y',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,type,sfcb021,sfcb022,amt,sfcb053,sfcb054
     FROM s_asft335_tmp01
   DELETE FROM s_asft335_tmp01 WHERE chk = 'N'
#再根据每一个下一站，找到它的所有的上站报工，也就是和现在正在审核的一个阶层的站，综合这一阶层站的数量，更新下一站的数量
   DECLARE s_asft335_sel_sfcb_next_tmp CURSOR FOR SELECT * FROM s_asft335_tmp01 ORDER BY sfcb003,sfcb004
   FOREACH s_asft335_sel_sfcb_next_tmp INTO l_sfcb_next.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      DELETE FROM s_asft335_tmp02
      IF NOT s_asft335_get_prev_station(l_sfcb_next.type,l_sfcb_next.sfcbdocno,l_sfcb_next.sfcb001,l_sfcb_next.sfcb003,l_sfcb_next.sfcb004) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
#同样去除重复
      INSERT INTO s_asft335_tmp02 
      SELECT DISTINCT 'Y',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,type,
                      sfcb021,sfcb022,amt,sfcb053,sfcb054 
        FROM s_asft335_tmp02
      DELETE FROM s_asft335_tmp02 WHERE chk = 'N'
      IF NOT s_asft335_calculate()  THEN   #计算数量，用来更新到对应的下一站点数量（含合并同一替代群组的数量）
         LET r_success = FALSE
         RETURN r_success      
      END IF
#上一站的数据都更新进去了，该取个最小值更新到下一站了
      LET l_amt = NULL
      SELECT MIN(amt) INTO l_amt FROM s_asft335_tmp02
      IF l_amt IS NULL THEN LET l_amt = 0 END IF  
#更新下一站数量到sfcb实体表
      IF NOT s_asft335_upd_sfcb(p_cmd,l_sfcb_next.*,l_amt) THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF

   END FOREACH
   FREE s_asft335_sel_sfcb_next_tmp
   CLOSE s_asft335_sel_sfcb_next_tmp
   
   RETURN r_success
   
 

END FUNCTION
################################################################################
# Descriptions...: 取得上一次的完成日期时间，回传空值表示找不到上一站或者出错了
# Memo...........:
# Usage..........: CALL s_asft335_get_prev_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
#                  RETURNING r_prev_date,r_prev_time
# Input parameter: p_sffb001      传入作业类别
#                : p_sffb005      传入工单单号
#                : p_sffb006      传入Run Card单号
#                : p_sffb007      传入作业编号
#                : p_sffb008      传入制程序
# Return code....: r_prev_sffb007      回传作业编号
#                : r_prev_sffb008      回传制程序
#                : r_prev_date    回传上次完成日期
#                : r_prev_time    回传上次完成时间
# Date & Author..: 2013/12/03 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_prev_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
   DEFINE p_sffb001        LIKE sffb_t.sffb001  #如果传‘6’进来，表示是下一站进来找上一站最后一步勾选步骤的
   DEFINE p_sffb005        LIKE sffb_t.sffb005
   DEFINE p_sffb006        LIKE sffb_t.sffb006
   DEFINE p_sffb007        LIKE sffb_t.sffb007
   DEFINE p_sffb008        LIKE sffb_t.sffb008
   DEFINE r_prev_sffb007   LIKE sffb_t.sffb007
   DEFINE r_prev_sffb008   LIKE sffb_t.sffb008
   DEFINE r_prev_date      LIKE sffb_t.sffb012
   DEFINE r_prev_time      LIKE sffb_t.sffb013
   DEFINE l_prev_step      LIKE sffb_t.sffb001
   DEFINE l_sfcb           RECORD LIKE sfcb_t.*
   DEFINE l_prev_sfcb      DYNAMIC ARRAY OF RECORD LIKE sfcb_t.*
   DEFINE l_stus           LIKE type_t.chr5   #报工有5个状态 
   DEFINE i                LIKE type_t.num5
   DEFINE l_prev_sffb001   LIKE sffb_t.sffb001
   DEFINE l_prev_sffb007   LIKE sffb_t.sffb007
   DEFINE l_prev_sffb008   LIKE sffb_t.sffb008   
   DEFINE l_prev_date      LIKE sffb_t.sffb012
   DEFINE l_prev_time      LIKE sffb_t.sffb013
   
#先获取当前这笔制程单身的状态sfcb014,sfcb015,sfcb016,sfcb018,sfcb019哪些步骤是需要做的，当前在哪一步，从而对应的上一步是什么
#若已经是当前站第一步，比如是Move In，则去找上一站，按asft301制程单身的上一站作业编号+上一站制程序去找
#同理对上一站分析有几步需要做，取最后一步
#根据取得的第几步骤资料，去找对应的报工单资料，然后取时间 
   WHENEVER ERROR CONTINUE   
   INITIALIZE l_sfcb.* TO NULL
   CALL l_prev_sfcb.clear()
   LET l_prev_step = NULL
   LET r_prev_sffb007 = NULL
   LET r_prev_sffb008 = NULL
   LET r_prev_date = NULL
   LET r_prev_time = NULL  


   
#工单，Run Card，作业，制程序不能为空   
   IF p_sffb001 IS NULL OR p_sffb005 IS NULL OR p_sffb006 IS NULL OR p_sffb007 IS NULL OR p_sffb008 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00012'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN r_prev_sffb007,r_prev_sffb008,r_prev_date,r_prev_time
   END IF

   SELECT * INTO l_sfcb.* FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbsite  = g_site
      AND sfcbdocno = p_sffb005
      AND sfcb001   = p_sffb006
      AND sfcb003   = p_sffb007
      AND sfcb004   = p_sffb008
   
   IF sqlca.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00013'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN r_prev_sffb007,r_prev_sffb008,r_prev_date,r_prev_time
   END IF 
   
#l_stus一共有5位，每一位是Y/N，表示这一站里，move in/check in/报工/check out/move out是否勾选   
   LET l_stus = null    
   IF l_sfcb.sfcb014 = 'Y' THEN
      LET l_stus = 'Y'
   ELSE
      LET l_stus = 'N'
   END IF
   IF l_sfcb.sfcb015 = 'Y' THEN
      LET l_stus = l_stus CLIPPED,'Y'
   ELSE
      LET l_stus = l_stus CLIPPED,'N'
   END IF
   IF l_sfcb.sfcb016 = 'Y' THEN
      LET l_stus = l_stus CLIPPED,'Y'
   ELSE
      LET l_stus = l_stus CLIPPED,'N'
   END IF
   IF l_sfcb.sfcb018 = 'Y' THEN
      LET l_stus = l_stus CLIPPED,'Y'
   ELSE
      LET l_stus = l_stus CLIPPED,'N'
   END IF
   IF l_sfcb.sfcb019 = 'Y' THEN
      LET l_stus = l_stus CLIPPED,'Y'
   ELSE
      LET l_stus = l_stus CLIPPED,'N'
   END IF

#根据本张报工单的sffb001状态，定位处于l_stus第几位，然后去找之前最近的一个Y，就是上一步骤
   IF p_sffb001 > 1 THEN     #Move In步骤没有上一步骤
      FOR i = 1 TO p_sffb001 - 1
          IF l_stus[p_sffb001-i,p_sffb001-i] = 'Y' THEN   #有步骤是被勾选的
             CASE p_sffb001-i    #写这个是因为l_prev_step 如果等于‘1.0’这样的，会在sffb里找不到
              WHEN 1
                LET l_prev_step = '1'
                EXIT FOR
              WHEN 2
                LET l_prev_step = '2'
                EXIT FOR
              WHEN 3
                LET l_prev_step = '3'
                EXIT FOR
              WHEN 4
                LET l_prev_step = '4'
                EXIT FOR
              WHEN 5
                LET l_prev_step = '5'
                EXIT FOR
             END CASE
          END IF    
      END FOR
   END IF

#本站内当前步骤之前没有步骤被勾选，则去找上一站的最后一个勾选步骤，如果再没有，继续上一站，递归了。。。
   IF l_prev_step IS NOT NULL THEN
#抓上一工单报工时间


#抓上一工单报工时间,可能多次报工，需要抓最大的时间
      DECLARE s_asft335_sel_max_prev_time CURSOR FOR
      SELECT sffb007,sffb008,sffb012,sffb013 
        FROM sffb_t
       WHERE sffb001 = l_prev_step
         AND sffb005 = p_sffb005
         AND sffb006 = p_sffb006
         AND sffb007 = p_sffb007
         AND sffb008 = p_sffb008
         AND sffbstus <> 'X'

      FOREACH s_asft335_sel_max_prev_time INTO l_prev_sffb007,l_prev_sffb008,l_prev_date,l_prev_time 
#第一次循环
         IF r_prev_date IS NULL THEN 
            LET r_prev_date = l_prev_date 
            LET r_prev_sffb007 = l_prev_sffb007
            LET r_prev_sffb008 = l_prev_sffb008
         END IF
         IF r_prev_time IS NULL THEN 
            LET r_prev_time = l_prev_time 
            LET r_prev_sffb007 = l_prev_sffb007
            LET r_prev_sffb008 = l_prev_sffb008
         END IF
#每次比大小，取大的保留
#日期大，就是大
         IF l_prev_date > r_prev_date THEN
            LET r_prev_sffb007 = l_prev_sffb007 
            LET r_prev_sffb008 = l_prev_sffb008                  
            LET r_prev_date = l_prev_date
            LET r_prev_time = l_prev_time
         END IF
#日期一样，再比时间,时间大，才是真的大
         IF l_prev_date = r_prev_date THEN
            IF l_prev_time > r_prev_time THEN
               LET r_prev_sffb007 = l_prev_sffb007 
               LET r_prev_sffb008 = l_prev_sffb008
               LET r_prev_date = l_prev_date
               LET r_prev_time = l_prev_time
            END IF
         END IF
      END FOREACH
      FREE s_asft335_sel_max_prev_time
      CLOSE s_asft335_sel_max_prev_time
      IF r_prev_sffb007 IS NULL THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00014'
         LET g_errparam.extend = l_sfcb.sfcb002
         LET g_errparam.popup = FALSE
         CALL cl_err()
    #报上站资料未报工
         LET r_prev_sffb007 = NULL
         LET r_prev_sffb008 = NULL
         LET r_prev_date = NULL
         LET r_prev_time = NULL
      END IF   
      
   ELSE
#本站没有找到上一步骤，去上一站找
      LET l_prev_sffb001 = '6'     #这里写6，这样才能将上一站里5个状态都遍历一次（l_stus做for那段，6-1=5）      
      CASE l_sfcb.sfcb007
        WHEN 'INIT'    #本站是第一站，再找不到，就回传空值吧
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'asf-00015'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

        OTHERWISE      #把所有上站都遍历一次，找到的时间取最大的那个
          DECLARE s_asft335_sel_sfcb_prev_time CURSOR FOR             #抓出上一站点
           SELECT B.* FROM sfcb_t A,sfcb_t B,sfcc_t                   #上站群组存的是具体作业编号的  A是本站，B是上站
            WHERE A.sfcbent   = g_enterprise 
              AND A.sfcbsite  = g_site 
              AND A.sfcbdocno = p_sffb005
              AND A.sfcb001   = p_sffb006
              AND A.sfcb003   = p_sffb007
              AND A.sfcb004   = p_sffb008
              AND A.sfcbent   = sfccent
              AND A.sfcbsite  = sfccsite
              AND A.sfcbdocno = sfccdocno
              AND A.sfcb001   = sfcc001
              AND A.sfcb002   = sfcc002
              AND B.sfcbent   = sfccent
              AND B.sfcbsite  = sfccsite
              AND B.sfcbdocno = sfccdocno 
              AND B.sfcb001   = sfcc001              
              AND B.sfcb003   = sfcc003
              AND B.sfcb004   = sfcc004
            UNION
           SELECT B.* FROM sfcb_t A,sfcb_t B,sfcc_t                   #上站群组存的是群组的  A是本站，B是上站
            WHERE A.sfcbent   = g_enterprise 
              AND A.sfcbsite  = g_site 
              AND A.sfcbdocno = p_sffb005
              AND A.sfcb001   = p_sffb006
              AND A.sfcb003   = p_sffb007
              AND A.sfcb004   = p_sffb008
              AND A.sfcbent   = sfccent
              AND A.sfcbsite  = sfccsite
              AND A.sfcbdocno = sfccdocno
              AND A.sfcb001   = sfcc001
              AND A.sfcb002   = sfcc002
              AND B.sfcbent   = sfccent
              AND B.sfcbsite  = sfccsite
              AND B.sfcbdocno = sfccdocno 
              AND B.sfcb001   = sfcc001              
              AND B.sfcb006   = sfcc003
              AND sfcc004     = '0'             

           LET r_prev_sffb007 = null
           LET r_prev_sffb008 = null
           LET r_prev_time = null 
           LET r_prev_date = null
           LET r_prev_time = null  
           LET i = 1           
           FOREACH s_asft335_sel_sfcb_prev_time INTO l_prev_sfcb[i].*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'foreach:'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 RETURN 
              END IF 
           
              LET i = i + 1
           END FOREACH
           FREE s_asft335_sel_sfcb_prev_time
           CLOSE s_asft335_sel_sfcb_prev_time
           CALL l_prev_sfcb.deleteElement(l_prev_sfcb.getLength())
           
           IF l_prev_sfcb.getLength() >0 THEN
              FOR i = 1 TO l_prev_sfcb.getLength()
                 CALL s_asft335_get_prev_time(l_prev_sffb001,p_sffb005,p_sffb006,l_prev_sfcb[i].sfcb003,l_prev_sfcb[i].sfcb004) 
                 RETURNING l_prev_sffb007,l_prev_sffb008,l_prev_date,l_prev_time
#第一次循环       
                 IF r_prev_date IS NULL THEN 
                    LET r_prev_date = l_prev_date 
                    LET r_prev_sffb007 = l_prev_sffb007
                    LET r_prev_sffb008 = l_prev_sffb008
                 END IF
                 IF r_prev_time IS NULL THEN 
                    LET r_prev_time = l_prev_time 
                    LET r_prev_sffb007 = l_prev_sffb007
                    LET r_prev_sffb008 = l_prev_sffb008
                 END IF
#每次比大小，取大的保留
#日期大，就是大
                 IF l_prev_date > r_prev_date THEN
                    LET r_prev_sffb007 = l_prev_sffb007 
                    LET r_prev_sffb008 = l_prev_sffb008                  
                    LET r_prev_date = l_prev_date
                    LET r_prev_time = l_prev_time
                 END IF
#日期一样，再比时间,时间大，才是真的大
                 IF l_prev_date = r_prev_date THEN
                    IF l_prev_time > r_prev_time THEN
                       LET r_prev_sffb007 = l_prev_sffb007 
                       LET r_prev_sffb008 = l_prev_sffb008
                       LET r_prev_date = l_prev_date
                       LET r_prev_time = l_prev_time
                    END IF
                 END IF
              END FOR
              IF r_prev_sffb007 IS NULL THEN
                 INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00014'
         LET g_errparam.extend = l_sfcb.sfcb002
         LET g_errparam.popup = FALSE
         CALL cl_err()
    #报上站资料未报工
                 LET r_prev_sffb007 = NULL
                 LET r_prev_sffb008 = NULL
                 LET r_prev_date = NULL
                 LET r_prev_time = NULL
              END IF              
           END IF             
      END CASE
   END IF
         
#不放心，再做一次格式化
   LET r_prev_time = r_prev_time[1,5]
   
   RETURN r_prev_sffb007,r_prev_sffb008,r_prev_date,r_prev_time
END FUNCTION
################################################################################
# Descriptions...: 抓取同一站里上一个勾选的步骤
# Memo...........:
# Usage..........: CALL s_asft335_get_prev_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success,r_errmsg
# Input parameter: p_sffb001      作业类型
#                : p_sfcbdocno    工单单号
#                : p_sfcb001      RunCard单号
#                : p_sfcb003      作业编号
#                : p_sfcb004      制程序
# Return code....: r_success      回传参数变量说明1
#                : r_errmsg       回传参数变量说明2
# Date & Author..: 2014/01/21 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_prev_action(p_sffb001,p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作业类型
   DEFINE p_sfcbdocno         LIKE sfcb_t.sfcbdocno        #工单单号
   DEFINE p_sfcb001           LIKE sfcb_t.sfcb001          #RunCard单号
   DEFINE p_sfcb003           LIKE sfcb_t.sfcb003          #作业编号
   DEFINE p_sfcb004           LIKE sfcb_t.sfcb004          #制程序
   DEFINE r_success           LIKE type_t.num5
   DEFINE r_errmsg            STRING
   DEFINE l_sfcb014           LIKE sfcb_t.sfcb014
   DEFINE l_sfcb015           LIKE sfcb_t.sfcb015
   DEFINE l_sfcb016           LIKE sfcb_t.sfcb016
   DEFINE l_sfcb018           LIKE sfcb_t.sfcb018
   DEFINE l_sfcb019           LIKE sfcb_t.sfcb019

   LET r_success = TRUE
   LET r_errmsg = NULL
   CASE p_sffb001
      WHEN '0'   #从下站Move In过来的，到上上站找第一个勾选的步骤1～5个步骤都要找
        SELECT sfcb014,sfcb015,sfcb016,sfcb018,sfcb019 
          INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
 
         IF l_sfcb019 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,5,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF  

         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 

         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 

         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '1'   #Move In
#Move In是第一个步骤，它的上一步就是要到上一站了，不是这里处理的，给个赞，离开吧
         LET r_success = FALSE
         RETURN r_success,r_errmsg       
      WHEN '2'   #check In
        SELECT sfcb014
          INTO l_sfcb014
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '3'   #报工
        SELECT sfcb014,sfcb015
          INTO l_sfcb014,l_sfcb015
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004

         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '4'   #check Out
        SELECT sfcb014,sfcb015,sfcb016
          INTO l_sfcb014,l_sfcb015,l_sfcb016
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
 
         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 

         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
      WHEN '5'   #Move Out
        SELECT sfcb014,sfcb015,sfcb016,sfcb018
          INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018
          FROM sfcb_t
         WHERE sfcbent   = g_enterprise
           AND sfcbsite  = g_site
           AND sfcbdocno = p_sfcbdocno
           AND sfcb001   = p_sfcb001
           AND sfcb003   = p_sfcb003
           AND sfcb004   = p_sfcb004
 
         IF l_sfcb018 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,4,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 

         IF l_sfcb016 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,3,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 

         IF l_sfcb015 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,2,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
         
         IF l_sfcb014 = 'Y' THEN
            INSERT INTO s_asft335_tmp02
            SELECT 'N',sfcbdocno,sfcb001,sfcb003,sfcb004,sfcb005,sfcb006,1,sfcb021,sfcb022,0,sfcb053,sfcb054
              FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = p_sfcbdocno
               AND sfcb001   = p_sfcb001
               AND sfcb003   = p_sfcb003
               AND sfcb004   = p_sfcb004 
             
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET r_success = FALSE
               LET r_errmsg = SQLCA.sqlcode
               RETURN r_success,r_errmsg
            END IF
            IF SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               LET r_errmsg = 100
               RETURN r_success,r_errmsg
            END IF 
            RETURN r_success,r_errmsg
         END IF 
   END CASE  
#如果走到这里，说明一个Y都没抓到，那就是失败了，返回FALSE
   LET r_success = FALSE
   RETURN r_success,r_errmsg
END FUNCTION
################################################################################
# Descriptions...: 根据完成日期和时间以及上次完成日期和时间推算本次的机时
# Memo...........:
# Usage..........: CALL s_asft335_get_working_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008,p_sffb012,p_sffb013)
#                  RETURNING r_sffb014,r_sffb015
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_sffb015      机时
# Date & Author..: 2013/12/10 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_working_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008,p_sffb012,p_sffb013)
   DEFINE p_sffb001        LIKE sffb_t.sffb001
   DEFINE p_sffb005        LIKE sffb_t.sffb005
   DEFINE p_sffb006        LIKE sffb_t.sffb006
   DEFINE p_sffb007        LIKE sffb_t.sffb007
   DEFINE p_sffb008        LIKE sffb_t.sffb008
   DEFINE p_sffb012        LIKE sffb_t.sffb012
   DEFINE p_sffb013        LIKE sffb_t.sffb013
   DEFINE r_sffb015        LIKE sffb_t.sffb015
   DEFINE l_prev_date      LIKE sffb_t.sffb012
   DEFINE l_prev_time      LIKE sffb_t.sffb013
   DEFINE l_time           LIKE sffb_t.sffb015   #最小单位分
   DEFINE l_minute         LIKE type_t.chr8
   DEFINE l_prev_minute    LIKE type_t.chr8
   DEFINE l_sffb007        LIKE sffb_t.sffb007
   DEFINE l_sffb008        LIKE sffb_t.sffb008

   WHENEVER ERROR CONTINUE
   CALL s_asft335_get_prev_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
        RETURNING l_sffb007,l_sffb008,l_prev_date,l_prev_time
   IF l_prev_date IS NOT NULL AND l_prev_time IS NOT NULL 
      AND p_sffb012 IS NOT NULL AND p_sffb013 IS NOT NULL THEN     
#全换算成分钟 
      LET l_minute = p_sffb013
      LET l_prev_minute = l_prev_time
      LET l_minute = l_minute[1,2]*60 + l_minute[4,5]
      LET l_prev_minute = l_prev_minute[1,2]*60 + l_prev_minute[4,5]
      LET l_time = (p_sffb012 - l_prev_date)*1440 + l_minute - l_prev_minute
      LET r_sffb015 = l_time
   ELSE
      LET r_sffb015 = 0
   END IF
   RETURN r_sffb015
END FUNCTION

################################################################################
# Descriptions...: 更新待XX数量到实体表sfcb_t
# Memo...........:
# Usage..........: CALL s_asft335_upd_sfcb(p_cmd,p_sfcb,p_amt)
#                  RETURNING r_success
# Input parameter: p_cmd          审核：1，取消审核：-1
#                : p_sfcb         传入需要取数的制程资料
#                : p_amt          上站传来的数量
# Return code....: r_success      成功否
# Date & Author..: 2014/03/29 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_sfcb(p_cmd,p_sfcb,p_amt)
   DEFINE p_cmd               LIKE type_t.num5             #审核 1/取消审核 -1
   DEFINE p_sfcb              type_sfcb_next         
   DEFINE p_amt               LIKE sfcb_t.sfcb050
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_sfcb              type_sfcb_next
   DEFINE l_sfcb046           LIKE sfcb_t.sfcb046
   DEFINE l_sfcb047           LIKE sfcb_t.sfcb047
   DEFINE l_sfcb048           LIKE sfcb_t.sfcb048
   DEFINE l_sfcb049           LIKE sfcb_t.sfcb049
   DEFINE l_sfcb050           LIKE sfcb_t.sfcb050
   DEFINE l_sfcb029           LIKE sfcb_t.sfcb029
   DEFINE l_sfcb034           LIKE sfcb_t.sfcb034
   DEFINE l_msg               STRING 
   DEFINE l_amt               LIKE sfcb_t.sfcb050
   DEFINE l_amt1              LIKE sfcb_t.sfcb050
   DEFINE l_sfca005           LIKE sfca_t.sfca005
   DEFINE l_sfcb046_t         LIKE sfcb_t.sfcb046
   DEFINE l_sfcb047_t         LIKE sfcb_t.sfcb047
   DEFINE l_sfcb048_t         LIKE sfcb_t.sfcb048
   DEFINE l_sfcb049_t         LIKE sfcb_t.sfcb049
   DEFINE l_sfcb050_t         LIKE sfcb_t.sfcb050
   DEFINE l_sfcb028_add       LIKE sfcb_t.sfcb028
   DEFINE l_type              LIKE sfcb_t.sfcb001
   DEFINE l_sql               STRING    #160801-00021#1-add
   
#更新到实体表sfcb_t,这里的做法是效率低的，高效的可用s_asft335_tmp01和sfcb_t做merge，但是只有oracle下可用
      LET l_sfcb046 = 0
      LET l_sfcb047 = 0
      LET l_sfcb048 = 0
      LET l_sfcb049 = 0
      LET l_sfcb050 = 0
      LET l_sfcb028_add = 0
      LET l_amt      = 0
      LET l_amt1     = 0
      LET r_success = TRUE

#更新前，先把这一站原来每个步骤的待XX数量取出来，因为最后upd sfcb046~sfcb050只是更新其中一个，其他还是要保持不变的，这里不抓一次，其他就都是0了
      SELECT sfcb046,sfcb047,sfcb048,sfcb049,sfcb050,sfcb029,sfcb034
        INTO l_sfcb046,l_sfcb047,l_sfcb048,l_sfcb049,l_sfcb050,l_sfcb029,l_sfcb034
        FROM sfcb_t
       WHERE sfcbent   = g_enterprise
         AND sfcbsite  = g_site
         AND sfcbdocno = p_sfcb.sfcbdocno
         AND sfcb001   = p_sfcb.sfcb001
         AND sfcb003   = p_sfcb.sfcb003
         AND sfcb004   = p_sfcb.sfcb004

#旧值用来计算变化量，变化量用来累计良品转入量
#l_sfcb028_add = l_xxx-l_xxx_t
#sfcb028 = sfcb028 + l_sfcb028_add
       LET l_sfcb046_t = l_sfcb046
       LET l_sfcb047_t = l_sfcb047
       LET l_sfcb048_t = l_sfcb048
       LET l_sfcb049_t = l_sfcb049
       LET l_sfcb050_t = l_sfcb050
       
#上站综合群组等因素后最后传到本站的数量，并不是直接更新成本站的待XX数量
#还要扣除本站的良品转出，重工转出，回收转出，当站报废，当站下线，以及加上回收数量（如果是回收站的话）
#如果此站处于替代群组内，要减去群组内这些数量的总和
       IF p_sfcb.sfcb005 MATCHES '[13]' THEN    #非替代群组只考虑本站
          #160801-00021#1-mod-(S)
#          SELECT SUM(sffb017) + SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_amt1    #重工转出等写完重工再来写这里(总算写完了，看下面case when '3')  这里的l_amt1是本站元件数量
#            FROM sffb_t
#           WHERE sffbent   = g_enterprise
#             AND sffbsite  = g_site
#             AND sffb005   = p_sfcb.sfcbdocno
#             AND sffb006   = p_sfcb.sfcb001
#             AND sffb007   = p_sfcb.sfcb003
#             AND sffb008   = p_sfcb.sfcb004
#             AND sffb001   = p_sfcb.type
#             AND sffbstus  = 'Y'     
          #重工转出等写完重工再来写这里(总算写完了，看下面case when '3')  这里的l_amt1是本站元件数量
          LET l_sql = " SELECT SUM(sffb017) + SUM(sffb018) + SUM(sffb019) + SUM(sffb020) ",
                      "   FROM sffb_t",
                      "  WHERE sffbent   = '",g_enterprise,"'",
                      "    AND sffbsite  = '",g_site,"'",
                      "    AND sffb005   = '",p_sfcb.sfcbdocno,"'",
                      "    AND sffb006   = '",p_sfcb.sfcb001,"'",
                      "    AND sffb007   = '",p_sfcb.sfcb003,"'",
                      "    AND sffb008   = '",p_sfcb.sfcb004,"'",
                      "    AND sffb001   = '",p_sfcb.type,"'",
                      "    AND sffbstus  = 'Y'  "
          #排除掉自己那張單
          IF g_prog MATCHES 'asft330*' THEN
             LET l_sql = l_sql CLIPPED," AND sffbdocno <> '",g_sffadocno,"'"
          END IF           
          PREPARE s_asft335_sffb_pre FROM l_sql
          EXECUTE s_asft335_sffb_pre INTO l_amt1
          #160801-00021#1-mod-(E)
  
          IF p_sfcb.type MATCHES '[12]' THEN   #换算成主件数量
              LET l_amt = l_amt * p_sfcb.sfcb054/p_sfcb.sfcb053
          END IF
          IF p_sfcb.type MATCHES '[345]' THEN
              LET l_amt = l_amt * p_sfcb.sfcb022/p_sfcb.sfcb021
          END IF 
#回收数量等写完回收作业再来写这里
       END IF
       
       IF p_sfcb.sfcb005 ='2' THEN    #同一替代群组的需要都扣除
          DECLARE s_asft335_sel_tmp01 CURSOR FOR
          SELECT * FROM s_asft335_tmp01
           WHERE sfcbdocno = p_sfcb.sfcbdocno
             AND sfcb001   = p_sfcb.sfcb001
             AND sfcb006   = p_sfcb.sfcb006 

          FOREACH s_asft335_sel_tmp01 INTO l_sfcb.*
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN 
             END IF 
             LET l_amt = 0 
             SELECT SUM(sffb017) + SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_amt
               FROM sffb_t
              WHERE sffbent   = g_enterprise
                AND sffbsite  = g_site
                AND sffb005   = l_sfcb.sfcbdocno
                AND sffb006   = l_sfcb.sfcb001
                AND sffb007   = l_sfcb.sfcb003
                AND sffb008   = l_sfcb.sfcb004
                AND sffb001   = l_sfcb.type
                AND sffbstus  = 'Y' 
                
             IF l_amt IS NULL THEN LET l_amt = 0 END IF 
#同一群组的不同站勾选的步骤也是不同的，所以统一翻成主件数量才好合计
             IF l_sfcb.type MATCHES '[12]' THEN
                 LET l_amt = l_amt * l_sfcb.sfcb054/l_sfcb.sfcb053
             END IF
             IF l_sfcb.type MATCHES '[345]' THEN
                 LET l_amt = l_amt * l_sfcb.sfcb022/l_sfcb.sfcb021
             END IF             
             LET l_amt1 = l_amt1 + l_amt            #这里的l_amt1是主件数量    
          END FOREACH
          FREE s_asft335_sel_tmp01
          CLOSE s_asft335_sel_tmp01          
       END IF
         
      IF l_amt1 IS NULL THEN LET l_amt1 = 0 END IF    
      LET p_amt = p_amt - l_amt1   #待XX数量需要扣除的本站已报工数量
      CALL s_aooi200_get_slip(p_sfcb.sfcbdocno) RETURNING l_success,g_doc_slip
      CASE p_sfcb.type 
         WHEN '1'    #Move In
            LET l_sfcb046 = p_amt * p_sfcb.sfcb053/p_sfcb.sfcb054              
#sel语句是在取消审核时,判断更新到下一站的量是否超出可更新的 
            IF p_cmd = -1 AND cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
               IF l_sfcb046 < 0 THEN
                  LET l_msg = p_sfcb.sfcbdocno,'|',p_sfcb.sfcb001,'|',p_sfcb.sfcb003,'|',p_sfcb.sfcb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00095'
                  LET g_errparam.extend = l_msg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success               
               END IF
            END IF            
         WHEN '2'    #Check In
            LET l_sfcb047 = p_amt * p_sfcb.sfcb053/p_sfcb.sfcb054              
#sel语句是在取消审核时,判断更新到下一站的量是否超出可更新的 
            IF p_cmd = -1 AND cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
               IF l_sfcb047 < 0 THEN
                  LET l_msg = p_sfcb.sfcbdocno,'|',p_sfcb.sfcb001,'|',p_sfcb.sfcb003,'|',p_sfcb.sfcb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00095'
                  LET g_errparam.extend = l_msg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success               
               END IF
            END IF  
         WHEN '3'    #报工
            LET l_sfcb050 = p_amt * p_sfcb.sfcb021/p_sfcb.sfcb022 
#这个有问题，先mark
##重工转出来了，举例ABCD四站，C站原来在制60，做重工转出4，asft338审核后，可以看到制程里，在制量56，重工转出4，重工转入0
##                          当C的重工转入制程完成后，要重新回写到C站，这时候C的在制量在制量60，重工转出4，重工转入4
##其实我想说的是，B站报工审核时更新C站的在制量，需要考虑-重工转出+重工转入
#            LET l_sfcb050 = l_sfcb050 + l_sfcb029 - l_sfcb034
##sel语句是在取消审核时,判断更新到下一站的量是否超出可更新的 
            IF p_cmd = -1 AND cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
               IF l_sfcb050 < 0 THEN
                  LET l_msg = p_sfcb.sfcbdocno,'|',p_sfcb.sfcb001,'|',p_sfcb.sfcb003,'|',p_sfcb.sfcb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00095'
                  LET g_errparam.extend = l_msg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success               
               END IF
            END IF  
         WHEN '4'    #Check Out
            LET l_sfcb048 = p_amt * p_sfcb.sfcb021/p_sfcb.sfcb022              
#sel语句是在取消审核时,判断更新到下一站的量是否超出可更新的 
            IF p_cmd = -1 AND cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
               IF l_sfcb048 < 0 THEN
                  LET l_msg = p_sfcb.sfcbdocno,'|',p_sfcb.sfcb001,'|',p_sfcb.sfcb003,'|',p_sfcb.sfcb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00095'
                  LET g_errparam.extend = l_msg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success               
               END IF
            END IF  
         WHEN '5'    #Move Out
            LET l_sfcb049 = p_amt * p_sfcb.sfcb021/p_sfcb.sfcb022              
#sel语句是在取消审核时,判断更新到下一站的量是否超出可更新的 
            IF p_cmd = -1 AND cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0045') ='N' THEN
               IF l_sfcb049 < 0 THEN
                  LET l_msg = p_sfcb.sfcbdocno,'|',p_sfcb.sfcb001,'|',p_sfcb.sfcb003,'|',p_sfcb.sfcb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00095'
                  LET g_errparam.extend = l_msg
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
                  RETURN r_success               
               END IF
            END IF  
      END CASE   

#判断本次是否是当站的首动作，如果是，再用对应的旧值和新值计算出本次良品转入量的变化量
      CALL s_asft335_get_first_action(p_sfcb.sfcbdocno,p_sfcb.sfcb001,p_sfcb.sfcb003,p_sfcb.sfcb004) RETURNING l_success,l_type
      
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_type = p_sfcb.type THEN
         CASE p_sfcb.type 
            WHEN '1'    #Move In
               LET l_sfcb028_add = l_sfcb046 - l_sfcb046_t                     
            WHEN '2'    #Check In
               LET l_sfcb028_add = l_sfcb047 - l_sfcb047_t                
            WHEN '3'    #报工
               LET l_sfcb028_add = l_sfcb050 - l_sfcb050_t    
            WHEN '4'    #Check Out
               LET l_sfcb028_add = l_sfcb048 - l_sfcb048_t                
            WHEN '5'    #Move Out
               LET l_sfcb028_add = l_sfcb049 - l_sfcb049_t              
         END CASE         
      END IF      

      UPDATE sfcb_t
         SET sfcb046 = l_sfcb046,
             sfcb047 = l_sfcb047,
             sfcb048 = l_sfcb048,
             sfcb049 = l_sfcb049,
             sfcb050 = l_sfcb050,
             sfcb028 = sfcb028 + l_sfcb028_add
       WHERE sfcbent   = g_enterprise
         AND sfcbsite  = g_site
         AND sfcbdocno = p_sfcb.sfcbdocno
         AND sfcb001   = p_sfcb.sfcb001
         AND sfcb003   = p_sfcb.sfcb003
         AND sfcb004   = p_sfcb.sfcb004

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'EXECUTE s_asft335_upd_sfcb_next'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      FREE s_asft335_sffb_pre   #160801-00021#1-add
      
      RETURN r_success
#若要把更新sfcb_t优化成megre，则放开以下2个update的mark
#      UPDATE s_asft335_tmp01 SET amt = p_amt *sfcb053/sfcb054
#       WHERE sfcbdocno = p_sfcb.sfcbdocno
#         AND sfcb001   = p_sfcb.sfcb001
#         AND sfcb003   = p_sfcb.sfcb003
#         AND sfcb004   = p_sfcb.sfcb004
#         AND type      = p_sfcb.type
#         AND (type     = '1' OR type = '2')
#
#      IF SQLCA.sqlcode THEN
#         CALL cl_err('upd_s_asft335_tmp01:',SQLCA.sqlcode,1)
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
#      
#      UPDATE s_asft335_tmp01 SET amt = p_amt *sfcb021/sfcb022
#       WHERE sfcbdocno = p_sfcb.sfcbdocno
#         AND sfcb001   = p_sfcb.sfcb001
#         AND sfcb003   = p_sfcb.sfcb003
#         AND sfcb004   = p_sfcb.sfcb004
#         AND type      = p_sfcb.type
#         AND (type     = '3' OR type = '4' OR type = '5')
#
#      IF SQLCA.sqlcode THEN
#         CALL cl_err('upd_s_asft335_tmp01:',SQLCA.sqlcode,1)
#         LET r_success = FALSE
#         RETURN r_success
#      END IF

END FUNCTION
################################################################################
# Descriptions...: 检查完成日期和时间不得小于上一步骤的完成日期时间
# Memo...........:
# Usage..........: CALL s_asft335_check_time(p_sffb012,p_sffb013,p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
#                  RETURNING 回传参数
# Input parameter: p_sffb012      待检查日期
#                : p_sffb013      待检查时间
#                : p_sffb001      报工类别
#                : p_sffb005      工单号码
#                : p_sffb006      RunCard
#                : p_sffb007      作业编号
#                : p_sffb008      作业序
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/02/17 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_check_time(p_sffb012,p_sffb013,p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
   DEFINE p_sffb012        LIKE sffb_t.sffb012
   DEFINE p_sffb013        LIKE sffb_t.sffb013
   DEFINE p_sffb001        LIKE sffb_t.sffb001
   DEFINE p_sffb005        LIKE sffb_t.sffb005
   DEFINE p_sffb006        LIKE sffb_t.sffb006
   DEFINE p_sffb007        LIKE sffb_t.sffb007
   DEFINE p_sffb008        LIKE sffb_t.sffb008  
   DEFINE l_prev_date      LIKE sffb_t.sffb012
   DEFINE l_prev_time      LIKE sffb_t.sffb013
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_sffb007        LIKE sffb_t.sffb007
   DEFINE l_sffb008        LIKE sffb_t.sffb008
   
   LET r_success = TRUE
   CALL s_asft335_get_prev_time(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
        RETURNING l_sffb007,l_sffb008,l_prev_date,l_prev_time
   IF l_prev_date IS NOT NULL AND l_prev_time IS NOT NULL THEN     
#日期大，就是大
      IF l_prev_date > p_sffb012 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00030'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
#日期一样，再比时间,时间大，才是真的大
      IF l_prev_date = p_sffb012 THEN
         IF l_prev_time > p_sffb013 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00030'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF  
   END IF
   
   RETURN r_success   
END FUNCTION
################################################################################
# Descriptions...: 报工单取消审核元件
# Memo...........:
# Usage..........: CALL s_asft335_unconf(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno        审核单号
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2013/12/25 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_unconf(p_docno)
   DEFINE p_docno     LIKE sffb_t.sffbdocno    #审核单号
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sffbstus  LIKE sffb_t.sffbstus
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5      #160129-00002#7 add
   DEFINE l_slip      LIKE ooba_t.ooba002   #160129-00002#7 add 

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00036'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
#若是asft336抛转过来的，不许取消审核，必须在asft336里取消扣帐
   SELECT COUNT(*) INTO l_cnt FROM sfga_t
    WHERE sfgaent   = g_enterprise
      AND sfgasite  = g_site
      AND sfgadocno = p_docno
      
   IF l_cnt > 0 AND g_prog <> 'asft336' THEN   #asft336取消扣帐也会调用这个元件，这种情况需要排除
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00274'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF   

#若是asft337抛转过来的，不许取消审核，必须在asft337里取消扣帐
   SELECT COUNT(*) INTO l_cnt FROM sfha_t
    WHERE sfhaent   = g_enterprise
      AND sfhasite  = g_site
      AND sfhadocno = p_docno
      
   IF l_cnt > 0 AND g_prog <> 'asft337' THEN   #asft337取消扣帐也会调用这个元件，这种情况需要排除
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00295'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
#检查为已审核的才可以
   SELECT DISTINCT(sffbstus) INTO l_sffbstus 
     FROM sffb_t
    WHERE sffbent  = g_enterprise
      AND sffbsite = g_site
      AND sffbdocno= p_docno

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'select sffb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_sffbstus != 'Y' THEN
      LET r_success = FALSE
      RETURN r_success      
   END IF   
#检查检查下一站的数量是否够本站取消审核还原的
#例如本張為報工數量100，下一動作為需Check out，則檢查待Check out數量是否大於等於100，足夠才允許取消

#开始取消审核的干活
#先更新状态码为N
   UPDATE sffb_t SET sffbstus = 'N',
                     sffbcnfdt = NULL,
                     sffbcnfid = NULL
    WHERE sffbent = g_enterprise
      AND sffbsite = g_site
      AND sffbdocno = p_docno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'updsffbstus'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00038'
      LET g_errparam.extend = 'select'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
#若是asft330调用，则多更新一个单头档   
   IF g_prog = 'asft330' OR g_prog = 'asft331' OR g_prog = 'asft332' OR g_prog = 'asft333' OR g_prog = 'asft334' THEN
      UPDATE sffa_t SET sffastus = 'N',
                       sffacnfdt = NULL,
                       sffacnfid = NULL
       WHERE sffaent = g_enterprise
         AND sffasite = g_site
         AND sffadocno = p_docno
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'updsffastus'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00038'
      LET g_errparam.extend = 'select'
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF
#调用更新工单制程进度元件
   IF NOT s_asft335_upd_routing(-1,p_docno) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160129-00002#7 ---(S)---   
   IF r_success THEN
      CALL s_aooi200_get_slip(p_docno) RETURNING l_success,l_slip
      IF cl_get_para(g_enterprise,g_site,'S-SYS-0003') = 'Y' AND cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0080') = 'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'wss-00263'
         LET g_errparam.extend = '此資料來源為MES抛轉，不可取消確認！'
         LET g_errparam.popup  = TRUE  
         CALL cl_err()      
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   #160129-00002#7 ---(E)---
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 报工单审核元件
# Memo...........:
# Usage..........: CALL s_asft335_conf(p_docno)
#                  RETURNING r_success
# Input parameter: p_codno        审核单号
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2013/12/11 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_conf(p_docno)
   DEFINE p_docno     LIKE sffb_t.sffbdocno    #审核单号
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sffbstus  LIKE sffb_t.sffbstus
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE g_time1     DATETIME YEAR TO SECOND
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET g_time1 = cl_get_current()
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00036'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
#检查为未审核的才可以
   SELECT DISTINCT(sffbstus) INTO l_sffbstus 
     FROM sffb_t
    WHERE sffbent  = g_enterprise
      AND sffbsite = g_site
      AND sffbdocno= p_docno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'select sffb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_sffbstus != 'N' THEN
      LET r_success = FALSE
      RETURN r_success      
   END IF  
#检查check in/check out必要项目都填了
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM sffc_t
    WHERE sffcent   = g_enterprise
      AND sffcsite  = g_site
      AND sffcdocno = p_docno
      AND sffc006   = 'Y'
      AND sffc005 IS NULL
    
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00037'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF 

#开始审核的干活
#先更新状态码为Y
   UPDATE sffb_t SET sffbstus  = 'Y',
                     sffbcnfdt = g_time1,
                     sffbcnfid = g_user
    WHERE sffbent = g_enterprise
      AND sffbsite = g_site
      AND sffbdocno = p_docno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'updsffbstus'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00038'
      LET g_errparam.extend = 'select'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
#若是asft330调用，则多更新一个单头档   
   IF g_prog = 'asft330' OR g_prog = 'asft331' OR g_prog = 'asft332' OR g_prog = 'asft333' OR g_prog = 'asft334' THEN
      UPDATE sffa_t SET sffastus = 'Y',
                       sffacnfdt = g_time1,
                       sffacnfid = g_user
       WHERE sffaent = g_enterprise
         AND sffasite = g_site
         AND sffadocno = p_docno
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'updsffastus'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00038'
      LET g_errparam.extend = 'select'
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF
   LET g_sffadocno = p_docno #160804-00029#1-add
#调用更新工单制程进度元件
   IF NOT s_asft335_upd_routing(1,p_docno) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根据工单制程资料产生预设的Check in/Check out资料
# Memo...........:
# Usage..........: CALL s_asft335_ins_sffc(p_sffbdocno,p_sffbseq)
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/29 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_ins_sffc(p_sffbdocno,p_sffbseq)
   DEFINE p_sffbdocno   LIKE sffb_t.sffbdocno
   DEFINE p_sffbseq     LIKE sffb_t.sffbseq
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sffb        RECORD LIKE sffb_t.*
   DEFINE l_sfcb        RECORD LIKE sfcb_t.*
   DEFINE l_sfcd        RECORD LIKE sfcd_t.*
   DEFINE l_sffc        RECORD LIKE sffc_t.*
   DEFINE l_type        LIKE sfcd_t.sfcd009

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
#必须有报工单资料   
   IF p_sffbdocno IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_sffbseq IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE l_sffc.* TO NULL
   INITIALIZE l_sfcb.* TO NULL
   INITIALIZE l_sfcd.* TO NULL
   INITIALIZE l_sffb.* TO NULL
   
   SELECT * INTO l_sffb.* 
     FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_sffbdocno
      AND sffbseq   = p_sffbseq
      
#只有check in和check out可以产生
   IF l_sffb.sffb001 NOT MATCHES '[24]' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
 
   IF l_sffb.sffb001 = '2' THEN
      LET l_type ='1'     
   END IF
 
   IF l_sffb.sffb001 = '4' THEN
      LET l_type ='2'     
   END IF
   
   SELECT * INTO l_sfcb.* FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbsite  = g_site
      AND sfcbdocno = l_sffb.sffb005
      AND sfcb001   = l_sffb.sffb006
      AND sfcb003   = l_sffb.sffb007
      AND sfcb004   = l_sffb.sffb008
 
   IF sqlca.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00013'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success 
   END IF 

   DECLARE s_asft335_sel_sfcd CURSOR FOR
   SELECT * FROM sfcd_t
    WHERE sfcdent   = g_enterprise
      AND sfcdsite  = g_site
      AND sfcddocno = l_sfcb.sfcbdocno
      AND sfcd001   = l_sfcb.sfcb001
      AND sfcd002   = l_sfcb.sfcb002
      AND sfcd009   = l_type

   IF sqlca.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success 
   END IF 
      
   FOREACH s_asft335_sel_sfcd INTO l_sfcd.*
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF
      LET l_sffc.sffcent   = l_sffb.sffbent
      LET l_sffc.sffcsite  = l_sffb.sffbsite
      LET l_sffc.sffcdocno = l_sffb.sffbdocno
      LET l_sffc.sffcseq   = l_sffb.sffbseq
      LET l_sffc.sffc001   = l_sfcd.sfcd003
      LET l_sffc.sffc002   = l_sfcd.sfcd004
      LET l_sffc.sffc003   = l_sfcd.sfcd005
      LET l_sffc.sffc004   = l_sfcd.sfcd006
      LET l_sffc.sffc005   = l_sfcd.sfcd007
      LET l_sffc.sffc006   = l_sfcd.sfcd008

      INSERT INTO sffc_t VALUES (l_sffc.*)    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sffc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success 
      END IF 
   END FOREACH
   
   RETURN r_success

END FUNCTION
################################################################################
# Descriptions...: 工单单号，RUNCARD，作业编号，制程序共用检查逻辑
# Memo...........:
# Usage..........: CALL s_asft335_chk_sffb0078(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
#                  RETURNING r_success
# Input parameter: p_sffb001      作业类别
#                : p_sffb005      工单单号
#                : p_sffb006      Runcard单号
#                : p_sffb007      作业编号
#                : p_sffb008      制程序
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2013/11/27 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_chk_sffb0078(p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
   DEFINE r_success     LIKE type_t.num5
   DEFINE p_sffb001     LIKE sffb_t.sffb001
   DEFINE p_sffb005     LIKE sffb_t.sffb005
   DEFINE p_sffb006     LIKE sffb_t.sffb006
   DEFINE p_sffb007     LIKE sffb_t.sffb007
   DEFINE p_sffb008     LIKE sffb_t.sffb008
   DEFINE l_sfcb014     LIKE sfcb_t.sfcb014
   DEFINE l_sfcb015     LIKE sfcb_t.sfcb015
   DEFINE l_sfcb016     LIKE sfcb_t.sfcb016
   DEFINE l_sfcb018     LIKE sfcb_t.sfcb018
   DEFINE l_sfcb019     LIKE sfcb_t.sfcb019
   
#检查的组合有以下几种：
#1：工单号为空
#      不检查
#2：作业编号+作业序为空
#  2.1:RUNCARD为空
#      只检查工单号是否为已审核未结案
#  2.2:RUNCARD不为空
#      检查工单+RUNCARD是否存在工单制程档内
#3：工单单号+RUNCARD不为空，作业编号OR作业序不为空
#  3.1:作业编号不为空，作业序为空
#  3.2:作业序不为空，作业编号为空
#  3.3:作业编号+作业序都不为空
#   检查工单单号+RUNCARD+作业编号（OR作业序）的组合是否存在于工单制程档内
#4：其他情况不检查
  
  
  
    WHENEVER ERROR CONTINUE
    LET r_success = TRUE
    #此段落由子樣板a19產生,检查合法性
    #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
    INITIALIZE g_chkparam.* TO NULL
#如果传入的作业编号+作业序是空的，则只检查工单+runcard
    IF p_sffb005 IS NULL THEN    #没工单，不做检查
       LET r_success = TRUE
       RETURN r_success
    END IF
    IF p_sffb007 IS NULL AND p_sffb008 IS NULL THEN   #只需要检查工单+RUNCARD
       IF p_sffb006 IS NULL THEN  #只需要检查工单,存在工单资料内，且已审核未结案
#          #設定g_chkparam.*的參數
#          LET g_chkparam.arg1 = g_site
#          LET g_chkparam.arg2 = p_sffb005
#                     
#          #呼叫檢查存在並帶值的library
#          IF cl_chk_exist("v_sfaadocno") THEN
#             #檢查成功時後續處理
#             #LET  = g_chkparam.return1
#             #DISPLAY BY NAME 
#          ELSE
#             LET r_success = FALSE
#             RETURN r_success
#          END IF
        IF NOT s_asft300_chk_stus(p_sffb005,'F') THEN
           LET r_success = FALSE
           RETURN r_success
        END IF
     ELSE                      #工单和Runcard联动检查
       #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_site
          LET g_chkparam.arg2 = p_sffb005
          LET g_chkparam.arg3 = p_sffb006

          
       #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_sfca001") THEN
          #檢查成功時後續處理
          #LET  = g_chkparam.return1
          #DISPLAY BY NAME 

          ELSE
          #檢查失敗時後續處理
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
    END IF
    IF p_sffb005 IS NOT NULL AND p_sffb006 IS NOT NULL AND (p_sffb007 IS NOT NULL OR p_sffb008 IS NOT NULL) THEN
       IF p_sffb007 IS NOT NULL AND p_sffb008 IS NULL THEN   #作业编号不为空，作业序为空
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_site
          LET g_chkparam.arg2 = p_sffb005
          LET g_chkparam.arg3 = p_sffb006
          LET g_chkparam.arg4 = p_sffb007
          
                        
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_sfcb003") THEN
             #檢查成功時後續處理
             #LET  = g_chkparam.return1
             #DISPLAY BY NAME 
	      
          ELSE
             #檢查失敗時後續處理
             LET r_success = FALSE
             RETURN r_success
          END IF          
       END IF
       IF p_sffb007 IS NULL AND p_sffb008 IS NOT NULL THEN   #作业序不为空，作业编号为空
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_site
          LET g_chkparam.arg2 = p_sffb005
          LET g_chkparam.arg3 = p_sffb006
          LET g_chkparam.arg4 = p_sffb008
          
                        
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_sfcb004") THEN
             #檢查成功時後續處理
             #LET  = g_chkparam.return1
             #DISPLAY BY NAME 
	      
          ELSE
             #檢查失敗時後續處理
             LET r_success = FALSE
             RETURN r_success
          END IF       
       END IF
       IF p_sffb007 IS NOT NULL AND p_sffb008 IS NOT NULL THEN   #作业编号+作业序都不为空
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_site
          LET g_chkparam.arg2 = p_sffb005
          LET g_chkparam.arg3 = p_sffb006
          LET g_chkparam.arg4 = p_sffb007
          LET g_chkparam.arg5 = p_sffb008 
          
                        
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_sfcb004_1") THEN
             #檢查成功時後續處理
             #LET  = g_chkparam.return1
             #DISPLAY BY NAME 
	      
          ELSE
             #檢查失敗時後續處理
             LET r_success = FALSE
             RETURN r_success
          END IF
          #检查报工单的作业类别与对应工单制程单身状态是否一致
          SELECT sfcb014,sfcb015,sfcb016,sfcb018,sfcb019
            INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019 
            FROM sfcb_t
           WHERE sfcbent  = g_enterprise
             AND sfcbsite = g_site
             AND sfcbdocno= p_sffb005
             AND sfcb001  = p_sffb006
             AND sfcb003  = p_sffb007
             AND sfcb004  = p_sffb008
	      
          CASE p_sffb001
             WHEN '1'    #Move In
               IF l_sfcb014 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00009'
                  LET g_errparam.extend = p_sffb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
               END IF
             WHEN '2'    #Check In
               IF l_sfcb015 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00009'
                  LET g_errparam.extend = p_sffb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
               END IF
             WHEN '3'    #报工
               IF l_sfcb016 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00009'
                  LET g_errparam.extend = p_sffb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
               END IF       
             WHEN '4'    #Check Out
                IF l_sfcb018 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00009'
                  LET g_errparam.extend = p_sffb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
               END IF      
             WHEN '5'    #Move Out
                IF l_sfcb019 <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00009'
                  LET g_errparam.extend = p_sffb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET r_success = FALSE
               END IF      
          END CASE
          IF NOT r_success THEN RETURN r_success END IF
       END IF
    END IF
    
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除对应报工单对应项次的检查项目sffc
# Memo...........:
# Usage..........: CALL s_asft335_del_sffc(p_sffbdocno,p_sffbseq)
#                  RETURNING r_success
# Input parameter: p_sffbdocno    报工单
#                : p_sffbseq      报工单项次
# Return code....: r_success      回传参数变量说明1
# Date & Author..: 2014/04/29 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_del_sffc(p_sffbdocno,p_sffbseq)
   DEFINE r_success       LIKE type_t.num5
   DEFINE p_sffbdocno     LIKE sffb_t.sffbdocno
   DEFINE p_sffbseq       LIKE sffb_t.sffbseq
   DEFINE l_sffb          RECORD LIKE sffb_t.*
      
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
#必须有报工单资料   
   IF p_sffbdocno IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_sffbseq IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE l_sffb.* TO NULL
   
   SELECT * INTO l_sffb.* 
     FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_sffbdocno
      AND sffbseq   = p_sffbseq
      
#只有check in和check out可以产生
   IF l_sffb.sffb001 NOT MATCHES '[24]' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   DELETE FROM sffc_t
    WHERE sffcent   = g_enterprise
      AND sffcsite  = g_site
      AND sffcdocno = p_sffbdocno
      AND sffcseq   = p_sffbseq
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del sffc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 报工单审核/取消审核时更新工单制程进度
# Memo...........:
# Usage..........: CALL s_asft335_upd_routing(p_cmd,p_docno)
#                  RETURNING r_success
# Input parameter: p_cmd          审核1/取消审核-1
#                : p_codno        报工单单号
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2013/12/17 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_routing(p_cmd,p_docno)
   DEFINE p_cmd          LIKE type_t.num5         #审核 1/取消审核 -1
   DEFINE p_docno        LIKE sffb_t.sffbdocno    #审核单号
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5  #160730-00003#1 add
   DEFINE l_sffb         RECORD LIKE sffb_t.*
   DEFINE l_sfcb         RECORD LIKE sfcb_t.*
   DEFINE l_sfcb_group   RECORD LIKE sfcb_t.*
   DEFINE l_type         LIKE sffb_t.sffb001
   DEFINE l_qty          LIKE sffb_t.sffb017
   DEFINE l_sffb016      LIKE sffb_t.sffb016
   DEFINE l_sffb017      LIKE sffb_t.sffb017  #160512-00034 by whitney add
   DEFINE l_sql          STRING   #160801-00021#1-add

   #170117-00038#1-s
   DEFINE ls_js        STRING
   DEFINE lc_param     type_sffb_parameter
   #170117-00038#1-e
   
   LET r_success = TRUE
   INITIALIZE l_sffb.* TO NULL
   INITIALIZE l_sfcb.* TO NULL
   INITIALIZE l_sfcb_group.* TO NULL
   
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00036'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF p_cmd IS NULL OR (p_cmd != 1 AND p_cmd != -1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00041'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   #160730-00003#1 --s
#   DECLARE s_asft335_sel_sffb CURSOR FOR
#   SELECT sffb_t.* 
#     FROM sffb_t
#    WHERE sffbent  = g_enterprise
#      AND sffbsite = g_site
#      AND sffbdocno= p_docno
   CALL s_asft335_deal_sffbtmp(p_docno) RETURNING l_success  #s_asft335_sffbtmp临时表对sffb表的各项次重新按报工的顺序排序
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #---160801-00021#1-mod-(S)
#   DECLARE s_asft335_sel_sffb CURSOR FOR
#   SELECT s_asft335_sffbtmp.*
#     FROM s_asft335_sffbtmp
#    WHERE sffbent  = g_enterprise
#      AND sffbsite = g_site
#      AND sffbdocno= p_docno
#    ORDER BY sffb005,sffb006,sffbseq
   LET l_sql  = " SELECT s_asft335_sffbtmp.* ",
                "   FROM s_asft335_sffbtmp ",
                "  WHERE sffbent  = '",g_enterprise,"'",
                "    AND sffbsite = '",g_site,"'",
                "    AND sffbdocno= '",p_docno,"'"
   CASE p_cmd
      WHEN '1'   #確認 (從前往後)
         LET l_sql = l_sql CLIPPED," ORDER BY sffb005,sffb006,sffbseq "
      WHEN '-1'  #取消確認 (從後往前)
         LET l_sql = l_sql CLIPPED," ORDER BY sffb005,sffb006,sffbseq DESC "
   END CASE
   PREPARE s_asft335_sel_sffb_pre  FROM l_sql
   DECLARE s_asft335_sel_sffb CURSOR FOR s_asft335_sel_sffb_pre 
   #---160801-00021#1-mod-(E) 
   #160730-00003#1 --e

   FOREACH s_asft335_sel_sffb INTO l_sffb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      IF l_sffb.sffb017 IS NULL THEN LET l_sffb.sffb017 = 0 END IF
      IF l_sffb.sffb018 IS NULL THEN LET l_sffb.sffb018 = 0 END IF
      IF l_sffb.sffb019 IS NULL THEN LET l_sffb.sffb019 = 0 END IF
      IF l_sffb.sffb020 IS NULL THEN LET l_sffb.sffb020 = 0 END IF

#每个报工单量最后做一次检查
      IF p_cmd = '1' THEN
         CALL s_asft335_set_qty(p_docno,l_sffb.sffbseq,l_sffb.sffb001,l_sffb.sffb005,l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008) RETURNING l_qty,l_sffb016
                  
         IF l_sffb.sffb001 MATCHES '[1245]' THEN
            #IF l_sffb.sffb017 > l_qty THEN  #160512-00034 by whitney mark
            #160512-00034 by whitney add start
            LET l_sffb017 = 0
            SELECT SUM(sffb017) INTO l_sffb017
              FROM sffb_t
             WHERE sffbent = g_enterprise
               AND sffb001 = l_sffb.sffb001
               AND sffb005 = l_sffb.sffb005
               AND sffb006 = l_sffb.sffb006
               AND sffb007 = l_sffb.sffb007
               AND sffb008 = l_sffb.sffb008
            IF l_sffb017 > l_qty THEN
            #160512-00034 by whitney add end
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00187'
               LET g_errparam.extend = l_sffb.sffbdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         IF l_sffb.sffb001 = '3' THEN
         #170117-00038#1-s
         # IF NOT s_asft335_chk_qty(l_sffb.sffb005,l_sffb.sffb006,l_sffb.sffb007,l_sffb.sffb008,l_sffb.sffb017,l_sffb.sffb018,l_sffb.sffb019,l_sffb.sffb020,l_qty) THEN
         #170117-00038#1-e   
              # LET r_success = FALSE  #mark by maoyy20170606
               #RETURN r_success  #mark by liusy 170613 
            #END IF
         END IF
      END IF
      
      SELECT * INTO l_sfcb.* FROM sfcb_t
       WHERE sfcbent   = g_enterprise
         AND sfcbsite  = g_site
         AND sfcbdocno = l_sffb.sffb005
         AND sfcb001   = l_sffb.sffb006
         AND sfcb003   = l_sffb.sffb007
         AND sfcb004   = l_sffb.sffb008
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel_sfcb'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success        
      END IF

#如果是在对重工制程做报工，则要判断是否是最后一站最后一个步骤，是的话，要更新asft338里记录的重工转出制程那一站的在制量和重工转入量
#审核时这个不和其他更新sfcb，sfaa一样放在后面，是因为需要用到更新之前的sfcb046～sfcb050
      IF p_cmd ='1' THEN
         IF NOT s_asft335_upd_rework_routing(1,l_sfcb.*) THEN
            LET r_success = FALSE
            RETURN r_success        
         END IF 
      END IF
      
#检查本站是否处于替代性群组中，若是的话，同群组的其他上一站和本站相同的作业编号+制程序也要减去相同的数量
#                            若不是，则只更新本站即可
      IF l_sfcb.sfcb005 = '2' THEN
         DECLARE s_asft335_sel_sfcb CURSOR FOR
            SELECT *  FROM sfcb_t
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = l_sfcb.sfcbdocno
               AND sfcb001   = l_sfcb.sfcb001
               AND sfcb005   = '2'
               AND sfcb006   = l_sfcb.sfcb006
               AND sfcb007   = l_sfcb.sfcb007
               AND sfcb008   = l_sfcb.sfcb008
         
         FOREACH s_asft335_sel_sfcb INTO l_sfcb_group.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF        
 
#更新同群组的数量
#正在审核的本站有报工类型，知道勾选了哪个步骤的
            LET l_type = NULL
            IF l_sfcb_group.sfcbdocno = l_sffb.sffb005 AND l_sfcb_group.sfcb001 = l_sffb.sffb006 AND
               l_sfcb_group.sfcb003 = l_sffb.sffb007 AND l_sfcb_group.sfcb004 = l_sffb.sffb008 THEN
               LET l_type = l_sffb.sffb001
            ELSE     #其他同群组非本站的，更新那站里第一个勾选的步骤的待XX数量,一定会有一个步骤是勾选的，asft301那里要控制
                     #而且当前审核的步骤，必须是这站第一个步骤！
               IF l_sfcb_group.sfcb019 = 'Y' THEN
                  LET l_type = '5'
               END IF
               IF l_sfcb_group.sfcb018 = 'Y' THEN
                  LET l_type = '4'
               END IF
               IF l_sfcb_group.sfcb016 = 'Y' THEN
                  LET l_type = '3'
               END IF
               IF l_sfcb_group.sfcb015 = 'Y' THEN
                  LET l_type = '2'
               END IF
               IF l_sfcb_group.sfcb014 = 'Y' THEN
                  LET l_type = '1'
               END IF
            END IF
            IF l_type IS NULL THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00200'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF             
            CASE l_type
               WHEN '1'   #Move In
                  LET l_sfcb_group.sfcb046 = l_sfcb_group.sfcb046 - p_cmd*l_sffb.sffb017
               WHEN '2'   #check In
                  LET l_sfcb_group.sfcb047 = l_sfcb_group.sfcb047 - p_cmd*l_sffb.sffb017
               WHEN '3'   #报工
                  LET l_sfcb_group.sfcb050 = l_sfcb_group.sfcb050 - (p_cmd*l_sffb.sffb017 + l_sffb.sffb018 + l_sffb.sffb019 + l_sffb.sffb020)
               WHEN '4'   #check Out
                  LET l_sfcb_group.sfcb048 = l_sfcb_group.sfcb048 - p_cmd*l_sffb.sffb017
               WHEN '5'   #Move Out
                  LET l_sfcb_group.sfcb049 = l_sfcb_group.sfcb049 - p_cmd*l_sffb.sffb017
            END CASE 
            IF l_sfcb_group.sfcb046 IS NULL THEN LET l_sfcb_group.sfcb046 = 0 END IF
            IF l_sfcb_group.sfcb047 IS NULL THEN LET l_sfcb_group.sfcb047 = 0 END IF
            IF l_sfcb_group.sfcb050 IS NULL THEN LET l_sfcb_group.sfcb050 = 0 END IF
            IF l_sfcb_group.sfcb048 IS NULL THEN LET l_sfcb_group.sfcb048 = 0 END IF
            IF l_sfcb_group.sfcb049 IS NULL THEN LET l_sfcb_group.sfcb049 = 0 END IF 
            
            UPDATE sfcb_t SET sfcb046 = l_sfcb_group.sfcb046,
                              sfcb047 = l_sfcb_group.sfcb047,
                              sfcb050 = l_sfcb_group.sfcb050,
                              sfcb048 = l_sfcb_group.sfcb048,
                              sfcb049 = l_sfcb_group.sfcb049
             WHERE sfcbent   = g_enterprise
               AND sfcbsite  = g_site
               AND sfcbdocno = l_sfcb_group.sfcbdocno
               AND sfcb001   = l_sfcb_group.sfcb001
               AND sfcb003   = l_sfcb_group.sfcb003
               AND sfcb004   = l_sfcb_group.sfcb004
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'upd_sfcb'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success        
            END IF
      
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00046'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success        
            END IF   
         END FOREACH     
         FREE s_asft335_sel_sfcb         
      ELSE
#更新当前站的数量
         CASE l_sffb.sffb001
            WHEN '1'   #Move In
              LET l_sfcb.sfcb046 = l_sfcb.sfcb046 - p_cmd*l_sffb.sffb017
            WHEN '2'   #check In
               LET l_sfcb.sfcb047 = l_sfcb.sfcb047 - p_cmd*l_sffb.sffb017
            WHEN '3'   #报工
               LET l_sfcb.sfcb050 = l_sfcb.sfcb050 - p_cmd*(l_sffb.sffb017 + l_sffb.sffb018 + l_sffb.sffb019 + l_sffb.sffb020)
            WHEN '4'   #check Out
               LET l_sfcb.sfcb048 = l_sfcb.sfcb048 - p_cmd*l_sffb.sffb017
            WHEN '5'   #Move Out
               LET l_sfcb.sfcb049 = l_sfcb.sfcb049 - p_cmd*l_sffb.sffb017
         END CASE

         IF l_sfcb.sfcb046 IS NULL THEN LET l_sfcb.sfcb046 = 0 END IF
         IF l_sfcb.sfcb047 IS NULL THEN LET l_sfcb.sfcb047 = 0 END IF
         IF l_sfcb.sfcb050 IS NULL THEN LET l_sfcb.sfcb050 = 0 END IF
         IF l_sfcb.sfcb048 IS NULL THEN LET l_sfcb.sfcb048 = 0 END IF
         IF l_sfcb.sfcb049 IS NULL THEN LET l_sfcb.sfcb049 = 0 END IF
         
         UPDATE sfcb_t SET sfcb046 = l_sfcb.sfcb046,
                           sfcb047 = l_sfcb.sfcb047,
                           sfcb050 = l_sfcb.sfcb050,
                           sfcb048 = l_sfcb.sfcb048,
                           sfcb049 = l_sfcb.sfcb049
          WHERE sfcbent   = g_enterprise
            AND sfcbsite  = g_site
            AND sfcbdocno = l_sffb.sffb005
            AND sfcb001   = l_sffb.sffb006
            AND sfcb003   = l_sffb.sffb007
            AND sfcb004   = l_sffb.sffb008
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'upd_sfcb'
               LET g_errparam.popup = TRUE
               CALL cl_err()

            LET r_success = FALSE
            RETURN r_success        
         END IF
   
         IF SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00046'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            LET r_success = FALSE
            RETURN r_success        
         END IF      
      END IF   

#sffb001=3时，更新本站的sfcb的良品转出数量，回收转出数量,当站报废，当站下线（重工有另外作业处理回写）
      IF l_sffb.sffb001 = '3' THEN
         UPDATE sfcb_t SET sfcb033 = sfcb033 + p_cmd * l_sffb.sffb017,  #因为只有sffb001=3的情况，所以不用换算了
                           sfcb035 = sfcb035 + p_cmd * l_sffb.sffb020,
                           sfcb036 = sfcb036 + p_cmd * l_sffb.sffb018,
                           sfcb037 = sfcb037 + p_cmd * l_sffb.sffb019                        
          WHERE sfcbent   = g_enterprise
            AND sfcbsite  = g_site
            AND sfcbdocno = l_sffb.sffb005
            AND sfcb001   = l_sffb.sffb006
            AND sfcb003   = l_sffb.sffb007
            AND sfcb004   = l_sffb.sffb008
	     
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd_sfcb033'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success        
         END IF
#更新回收转入数量
         UPDATE sfcb_t SET sfcb030 = sfcb030 + p_cmd * l_sffb.sffb017   #因为只有sffb001=3的情况，所以不用换算了
          WHERE sfcbent   = g_enterprise
            AND sfcbsite  = g_site
            AND sfcbdocno = l_sffb.sffb005
            AND sfcb001   = l_sffb.sffb006
            AND sfcb055   = 'Y' 
	     
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd_sfcb030'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            RETURN r_success        
         END IF
      END IF
      
#取消审核时这个需要放在更新sfcb之后，是因为需要用到更新之后的sfcb046～sfcb050
      IF p_cmd ='-1' THEN
         IF NOT s_asft335_upd_rework_routing(-1,l_sfcb.*) THEN
            LET r_success = FALSE
            RETURN r_success        
         END IF 
      END IF
      
#更新下站的良品转入，参考更新下站的待XX数量逻辑，有多上站时要考虑成套，区别是途径没有勾选5个步骤的下一站时，良品转入也要写进去
#更新工单单头当站下线量和已报废量(先累加计算，不考虑平行工艺下的情况)
      IF l_sffb.sffb001 MATCHES '[12]' THEN
         UPDATE sfaa_t SET sfaa055 = sfaa055 + p_cmd*l_sffb.sffb019*l_sfcb.sfcb054/l_sfcb.sfcb053,
                           sfaa056 = sfaa056 + p_cmd*l_sffb.sffb018*l_sfcb.sfcb054/l_sfcb.sfcb053
          WHERE sfaaent   = g_enterprise
            AND sfaasite  = g_site
            AND sfaadocno = l_sffb.sffb005
      END IF
      IF l_sffb.sffb001 MATCHES '[345]' THEN
         UPDATE sfaa_t SET sfaa055 = sfaa055 + p_cmd*l_sffb.sffb019*l_sfcb.sfcb021/l_sfcb.sfcb022,
                           sfaa056 = sfaa056 + p_cmd*l_sffb.sffb018*l_sfcb.sfcb021/l_sfcb.sfcb022
          WHERE sfaaent   = g_enterprise
            AND sfaasite  = g_site
            AND sfaadocno = l_sffb.sffb005
      END IF        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd_sfaa'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success        
      END IF
   
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00097'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success        
      END IF 
      
#更新下一动作的数量
#step1：找到当前站（命名为A）的下一个报工站（命名为B），遇到END停止
#step2：找到B站的所有上一报工站，含A站
#step3：处于相同的替代群组的站，相加合并
#step4：无顺序群组里的，取最小的出线
#step5：step3，step4的结果，与step2中剩余无群组的站，取最小数量传给B站
#
#每一站的数量为工单+Runcard+作业+制程序去找已审核报工单数量的SUM

#      LET g_sffadocno = p_docno  #160801-00021#1-add 160804-00029#1-mark
      IF NOT s_asft335_upd_next_station(p_cmd,l_sffb.sffb001,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb003,l_sfcb.sfcb004) THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF       
   END FOREACH
   FREE s_asft335_sel_sffb
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更新sffc的项次sffcseq
# Memo...........:
# Usage..........: CALL s_asft335_upd_sffc(p_sffbdocno,p_sffbseq,p_sffbseq_t)
#                  RETURNING r_success
# Input parameter: p_sffbseq      报工单项次
#                : p_sffbseq_t    报工单项次旧值
#                : p_sffb019      当站下线数量
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/29 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_sffc(p_sffbdocno,p_sffbseq,p_sffbseq_t)
   DEFINE r_success       LIKE type_t.num5
   DEFINE p_sffbdocno     LIKE sffb_t.sffbdocno
   DEFINE p_sffbseq       LIKE sffb_t.sffbseq
   DEFINE p_sffbseq_t     LIKE sffb_t.sffbseq
   DEFINE l_sffb          RECORD LIKE sffb_t.*
      
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
#必须有报工单资料   
   IF p_sffbdocno IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF p_sffbseq IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF p_sffbseq_t IS NULL THEN LET p_sffbseq_t = p_sffbseq END IF
   
   INITIALIZE l_sffb.* TO NULL
   
   SELECT * INTO l_sffb.* 
     FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_sffbdocno
      AND sffbseq   = p_sffbseq_t
      
#只有check in和check out可以产生
   IF l_sffb.sffb001 NOT MATCHES '[24]' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   UPDATE sffc_t SET sffcseq = p_sffbseq
    WHERE sffcent   = g_enterprise
      AND sffcsite  = g_site
      AND sffcdocno = p_sffbdocno
      AND sffcseq   = p_sffbseq_t
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd sffc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF

   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING r_success
# Input parameter: p_sffadocno    报工单
# Return code....: r_success      回传参数变量说明1
# Date & Author..: 2014/04/29 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_del_sffc_all(p_sffadocno)
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sffa          RECORD LIKE sffa_t.*
   DEFINE p_sffadocno     LIKE sffa_t.sffadocno
      
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
#必须有报工单资料   
   IF p_sffadocno IS NULL THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE l_sffa.* TO NULL
   
   SELECT * INTO l_sffa.* 
     FROM sffa_t
    WHERE sffaent   = g_enterprise
      AND sffasite  = g_site
      AND sffadocno = p_sffadocno
      
#只有check in和check out可以产生
   IF l_sffa.sffa001 NOT MATCHES '[24]' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   DELETE FROM sffc_t
    WHERE sffcent   = g_enterprise
      AND sffcsite  = g_site
      AND sffcdocno = p_sffadocno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del sffc_t_all"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF

   RETURN r_success 
END FUNCTION
################################################################################
# Descriptions...: 根据工单，Run Card，作业，制程序从工单制程单身抓取待处理数量
# Memo...........:
# Usage..........: CALL s_asft335_set_qty(p_sffbdocno,p_sffbseq,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
#                  RETURNING r_qty,r_sffb016
# Input parameter: p_sffbdocno    报工单号
#                : p_sffbseq      报工单项次
#                : p_sffb001      报工状态
#                : p_sffb005      工单 
#                : p_sffb006      Run Card
#                : p_sffb007      作业
#                : p_sffb008      制程序
# Return code....: r_qty          待处理数量
#                : r_sffb016      数量对应的单位
# Date & Author..: 2013/11/28 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_set_qty(p_sffbdocno,p_sffbseq,p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008)
   DEFINE p_sffbdocno   LIKE sffb_t.sffbdocno  #非报工单调用时可以传NULL进来
   DEFINE p_sffbseq     LIKE sffb_t.sffbseq
   DEFINE p_sffb001     LIKE sffb_t.sffb001
   DEFINE p_sffb005     LIKE sffb_t.sffb005
   DEFINE p_sffb006     LIKE sffb_t.sffb006
   DEFINE p_sffb007     LIKE sffb_t.sffb007
   DEFINE p_sffb008     LIKE sffb_t.sffb008
   DEFINE r_qty         LIKE sfcb_t.sfcb050
   DEFINE r_sffb016     LIKE sffb_t.sffb016
   DEFINE l_qty1        LIKE sfcb_t.sfcb050
   DEFINE l_qty2        LIKE sfcb_t.sfcb050
   DEFINE l_qty3        LIKE sfcb_t.sfcb050
   DEFINE l_qty4        LIKE sfcb_t.sfcb050
   DEFINE l_sfcb017     LIKE sfcb_t.sfcb017    #是否PQC  #151110-00002#2 add
   DEFINE l_sfaa057     LIKE sfaa_t.sfaa057    #160613-00020 by whitney add
   DEFINE l_pmdo006     LIKE pmdo_t.pmdo006    #160613-00020 by whitney add
   DEFINE l_success     LIKE type_t.num5       #160727-00022#1
   
   WHENEVER ERROR CONTINUE
   LET r_qty = 0
   LET r_sffb016 = NULL
   LET l_sfcb017 = NULL       #151110-00002#2 add
   LET l_qty1 = 0
   LET l_qty2 = 0
   LET l_qty3 = 0
   LET l_qty4 = 0
   
   IF p_sffb001 IS NULL OR p_sffb005 IS NULL OR p_sffb006 IS NULL OR p_sffb007 IS NULL OR p_sffb008 IS NULL THEN
      RETURN r_qty,r_sffb016
   END IF
#从工单制程单身里抓取待处理数量
    CASE p_sffb001
    WHEN '1' #Move In
      SELECT sfcb046,sfcb052 INTO r_qty,r_sffb016
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = p_sffb007
         AND sfcb004  = p_sffb008
      IF r_qty IS NULL THEN LET r_qty = 0 END IF
    WHEN '2' #Check In
      SELECT sfcb047,sfcb052 INTO r_qty,r_sffb016
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = p_sffb007
         AND sfcb004  = p_sffb008
      IF r_qty IS NULL THEN LET r_qty = 0 END IF
    WHEN '3' #报工
      SELECT sfcb050,sfcb020,sfcb017 INTO r_qty,r_sffb016,l_sfcb017   #151110-00002#2 add #增加取得sfcb017 是否PQC   
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = p_sffb007
         AND sfcb004  = p_sffb008
         
      #151110-00002#2 add start ----------------------
      #若有PQC,則待處理數量應取PQC檢驗合格量
      IF l_sfcb017 = 'Y' THEN
      
         #160128-00010 by whitney add (s)
         IF g_prog = 'asft338' THEN
            SELECT SUM(qcba027) INTO r_qty   #不良數
              From qcba_t
             WHERE qcbaent  = g_enterprise
               AND qcbasite = g_site
               AND qcba000  = '3'            #PQC
               AND qcba001  = p_sffb005      #來源單據
               AND qcba029  = p_sffb006      #RunCard
               AND qcba006  = p_sffb007      #作業編號
               AND qcba007  = p_sffb008      #製程序
               AND qcba022 = '3'             #判定結果(3.重工)
               AND qcbastus = 'Y'
         ELSE
         #160128-00010 by whitney add (e)
         
            #PQC檢驗合格量
            Select SUM(qcba023) INTO r_qty            #合格量
              From qcba_t
             WHERE qcbaent  = g_enterprise
               AND qcbasite = g_site
               AND qcba000  = '3'                     #PQC
               AND qcba001  = p_sffb005               #來源單據
               AND qcba029  = p_sffb006               #RunCard
               AND qcba006  = p_sffb007               #作業編號
               AND qcba007  = p_sffb008               #製程序
               AND (qcba022 = '1' or qcba022 = '4')   #判定結果(1.合格 4.特採)
               AND qcbastus = 'Y'                     #狀態碼

         END IF  #160128-00010 by whitney add

         #报工类型要多扣除当站下线，作废和回收，但是不能扣除本站的，本站的会显示在画面对应栏位上   
         SELECT SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_qty1 
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = p_sffb001
            AND sffb005  = p_sffb005
            AND sffb006  = p_sffb006
            AND sffb007  = p_sffb007
            AND sffb008  = p_sffb008
            AND sffbstus <> 'X'           

         SELECT SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_qty3    #本站的
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = p_sffb001
            AND sffb005  = p_sffb005
            AND sffb006  = p_sffb006
            AND sffb007  = p_sffb007
            AND sffb008  = p_sffb008
            AND sffbdocno = p_sffbdocno 
            AND sffbseq  = p_sffbseq
            AND sffbstus <> 'X'            
      ELSE
      #151110-00002#2 add end   ----------------------
      
         #报工类型要多扣除当站下线，作废和回收，但是不能扣除本站的，本站的会显示在画面对应栏位上
         SELECT SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_qty1 
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = p_sffb001
            AND sffb005  = p_sffb005
            AND sffb006  = p_sffb006
            AND sffb007  = p_sffb007
            AND sffb008  = p_sffb008
            AND sffbstus = 'N'           

         SELECT SUM(sffb018) + SUM(sffb019) + SUM(sffb020) INTO l_qty3    #本站的
           FROM sffb_t
          WHERE sffbent  = g_enterprise
            AND sffbsite = g_site
            AND sffb001  = p_sffb001
            AND sffb005  = p_sffb005
            AND sffb006  = p_sffb006
            AND sffb007  = p_sffb007
            AND sffb008  = p_sffb008
            AND sffbdocno = p_sffbdocno 
            AND sffbseq  = p_sffbseq
            AND sffbstus = 'N'    
      END IF   #151110-00002#2 add
      IF l_qty1 IS NULL THEN LET l_qty1 = 0 END IF
      IF l_qty3 IS NULL THEN LET l_qty3 = 0 END IF
      IF r_qty IS NULL THEN LET r_qty = 0 END IF
    WHEN '4' #Check Out
      SELECT sfcb048,sfcb020 INTO r_qty,r_sffb016
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = p_sffb007
         AND sfcb004  = p_sffb008
      IF r_qty IS NULL THEN LET r_qty = 0 END IF
    WHEN '5' #Move Out
      SELECT sfcb049,sfcb020 INTO r_qty,r_sffb016
        FROM sfcb_t
       WHERE sfcbent  = g_enterprise
         AND sfcbsite = g_site
         AND sfcbdocno= p_sffb005
         AND sfcb001  = p_sffb006
         AND sfcb003  = p_sffb007
         AND sfcb004  = p_sffb008
      IF r_qty IS NULL THEN LET r_qty = 0 END IF 
    END CASE
#扣除其他未审核报工单的良品转出量，不含本站良品转出，本站的显示在画面sffb017上
    #151110-00002#2 add start ----------------------
    IF p_sffb001 = '3' AND l_sfcb017 = 'Y' THEN
       SELECT SUM(sffb017) INTO l_qty2
         FROM sffb_t
        WHERE sffbent  = g_enterprise
          AND sffbsite = g_site
          AND sffb001  = p_sffb001
          AND sffb005  = p_sffb005
          AND sffb006  = p_sffb006
          AND sffb007  = p_sffb007
          AND sffb008  = p_sffb008
          AND sffbstus <> 'X'             
       
       SELECT SUM(sffb017) INTO l_qty4
         FROM sffb_t
        WHERE sffbent  = g_enterprise
          AND sffbsite = g_site
          AND sffb001  = p_sffb001
          AND sffb005  = p_sffb005
          AND sffb006  = p_sffb006
          AND sffb007  = p_sffb007
          AND sffb008  = p_sffb008
          AND sffbdocno = p_sffbdocno 
          AND sffbseq = p_sffbseq
          AND sffbstus <> 'X'            
    ELSE
    #151110-00002#2 add end   ----------------------
       SELECT SUM(sffb017) INTO l_qty2
         FROM sffb_t
        WHERE sffbent  = g_enterprise
          AND sffbsite = g_site
          AND sffb001  = p_sffb001
          AND sffb005  = p_sffb005
          AND sffb006  = p_sffb006
          AND sffb007  = p_sffb007
          AND sffb008  = p_sffb008
          AND sffbstus = 'N'             
       
       SELECT SUM(sffb017) INTO l_qty4
         FROM sffb_t
        WHERE sffbent  = g_enterprise
          AND sffbsite = g_site
          AND sffb001  = p_sffb001
          AND sffb005  = p_sffb005
          AND sffb006  = p_sffb006
          AND sffb007  = p_sffb007
          AND sffb008  = p_sffb008
          AND sffbdocno = p_sffbdocno 
          AND sffbseq = p_sffbseq
          AND sffbstus = 'N'                
    END IF   #151110-00002#2 add

    IF l_qty2 IS NULL THEN LET l_qty2 = 0 END IF 
    IF l_qty4 IS NULL THEN LET l_qty4 = 0 END IF    
    LET r_qty = r_qty - l_qty1 + l_qty3 - l_qty2 + l_qty4
    
    #160613-00020 by whitney add start
    #委外製程站報工時，良品數量=原邏輯-已轉委外採購數量+委外入庫數量
    LET l_sfaa057 = ''
    SELECT sfaa057 INTO l_sfaa057
      FROM sfaa_t
     WHERE sfaaent = g_enterprise
       AND sfaadocno = p_sffb005
    IF l_sfaa057 = 'Y' THEN
       LET l_pmdo006 = 0
       SELECT (pmdo006-pmdo019) INTO l_pmdo006
         FROM pmdl_t,pmdo_t
        WHERE pmdoent = g_enterprise
          AND pmdoent = pmdlent
          AND pmdodocno = pmdldocno
          AND pmdl008 = p_sffb005
          AND pmdlstus <> 'X'
       IF cl_null(l_pmdo006) THEN LET l_pmdo006 = 0 END IF
       LET r_qty = r_qty - l_pmdo006
    END IF
    #160613-00020 by whitney add end
    CALL s_aooi250_take_decimals(r_sffb016,r_qty) RETURNING l_success,r_qty #160727-00022#1
    RETURN r_qty,r_sffb016
END FUNCTION
################################################################################
# Descriptions...: 新增当站下线单头资料
# Memo...........:
# Usage..........: CALL s_asft335_ins_sfha(p_docno,p_seq,p_amt)
#                  RETURNING r_success
# Input parameter: p_docno        报工单号
#                : p_seq          报工单项次
#                : p_amt          当站下线数量
# Return code....: TRUE OR FALSE
# Date & Author..: 2014/05/25 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_ins_sfha(p_docno,p_seq,p_amt)
DEFINE p_docno      LIKE sffb_t.sffbdocno
DEFINE p_seq        LIKE sffb_t.sffbseq
DEFINE p_amt        LIKE sffb_t.sffb019
DEFINE r_success    LIKE type_t.num5
DEFINE l_sfha       RECORD LIKE sfha_t.*
DEFINE l_sffb       RECORD LIKE sffb_t.*
DEFINE l_success    LIKE type_t.num5
DEFINE l_slip       LIKE sffb_t.sffbdocno

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE

   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00300'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE l_sfha.* TO NULL
   INITIALIZE l_sffb.* TO NULL
   
   SELECT * INTO l_sffb.* FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_docno
      AND sffbseq   = p_seq
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel sffb_t",SQLERRMESSAGE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF l_sffb.sffb001 <> '3' OR p_amt IS NULL OR p_amt = 0 THEN
      RETURN r_success
   END IF
   
   LET l_sfha.sfhadocno = NULL
   IF cl_null(g_sfhadocno) THEN  #160511-00020 by whitney add
      CALL s_aooi200_get_slip(p_docno) RETURNING l_success,l_slip
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_sfha.sfhadocno = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0061')
      IF cl_null(l_sfha.sfhadocno) THEN
         #报工单别对应的当站下线单别没有维护，请至aooi200中维护报工单别（1%）的对应当站下线单别（参数D-MFG-0061）
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00680'
         LET g_errparam.extend = "GET D-MFG-0061 ERROR"
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_slip
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   #160511-00020 by whitney add start
   ELSE
      LET l_sfha.sfhadocno = g_sfhadocno
   END IF
   #160511-00020 by whitney add end
   
   LET l_sfha.sfhadocdt = l_sffb.sffbdocdt  #單據日期
   
   CALL s_aooi200_gen_docno(g_site,l_sfha.sfhadocno,l_sfha.sfhadocdt,'asft337') RETURNING l_success,l_sfha.sfhadocno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_sfhadocno = l_sfha.sfhadocno
   
   LET l_sfha.sfhaent   = g_enterprise      #企業代碼
   LET l_sfha.sfhasite  = g_site
   LET l_sfha.sfha001   = l_sffb.sffbdocdt  #過帳日期
   LET l_sfha.sfha002   = l_sffb.sffb002    #申請人員
   LET l_sfha.sfha003   = l_sffb.sffb003    #申請部門
   LET l_sfha.sfha004   = l_sffb.sffb005    #工單單號
   LET l_sfha.sfha005   = l_sffb.sffb006    #Run Card
   LET l_sfha.sfha006   = l_sffb.sffb007    #作業編號
   LET l_sfha.sfha007   = l_sffb.sffb008    #製程序
   LET l_sfha.sfha008   = p_amt             #當站下線數量
   LET l_sfha.sfha010   = p_docno           #来源单号
   LET l_sfha.sfha011   = p_seq             #来源单号项次
   LET l_sfha.sfhaownid = g_user
   LET l_sfha.sfhaowndp = g_dept
   LET l_sfha.sfhacrtid = g_user
   LET l_sfha.sfhacrtdp = g_dept
   LET l_sfha.sfhacrtdt = cl_get_current()
   LET l_sfha.sfhamodid = ""
   LET l_sfha.sfhamoddt = ""
   LET l_sfha.sfhastus  = 'N'
   
   INSERT INTO sfha_t VALUES(l_sfha.*)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins sfha_t",SQLERRMESSAGE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 同步删除sfha
# Memo...........:
# Usage..........: CALL s_asft335_del_sfha(p_docno,p_seq)
#                  RETURNING r_success
# Input parameter: p_docno        报工单号
#                : p_seq          报工单项次
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/05/25 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_del_sfha(p_docno,p_seq)
   DEFINE p_docno         LIKE sffb_t.sffbdocno
   DEFINE p_seq           LIKE sffb_t.sffbseq
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sffb          RECORD LIKE sffb_t.*

   LET r_success = TRUE

   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00300'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   INITIALIZE l_sffb.* TO NULL

   SELECT * INTO l_sffb.* FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_docno
      AND sffbseq   = p_seq
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel_sffb"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF
      
   IF l_sffb.sffb001 <> '3' OR l_sffb.sffb019 IS NULL OR l_sffb.sffb019 = 0 THEN
      LET r_success = TRUE 
      RETURN r_success
   END IF

   
   SELECT COUNT(*) INTO l_cnt
     FROM sfha_t
    WHERE sfhaent = g_enterprise
      AND sfha010 = p_docno
      AND sfha011 = p_seq
      AND sfhastus<> 'N'
    
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00245'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF       
   
   DELETE FROM sfha_t 
    WHERE sfhaent = g_enterprise
      AND sfha010 = p_docno
      AND sfha011 = p_seq  

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del sfha_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 更新当站下线单对应的项次和数量
# Memo...........:
# Usage..........: CALL s_asft335_upd_sfha(p_docno,p_seq,p_seq_t,p_amt)
#                  RETURNING r_success
# Input parameter: p_docno        报工单号
#                : p_seq          报工单项次
#                : p_seq_t        报工单项次旧值
#                : p_amt          当站下线数量
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/05/25 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_sfha(p_docno,p_seq,p_seq_t,p_amt)
   DEFINE p_docno         LIKE sffb_t.sffbdocno
   DEFINE r_success       LIKE type_t.num5
   DEFINE p_seq           LIKE sffb_t.sffbseq
   DEFINE p_seq_t         LIKE sffb_t.sffbseq
   DEFINE p_amt           LIKE sffb_t.sffb019
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sffb          RECORD LIKE sffb_t.*

   LET r_success = TRUE

   IF p_docno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00300'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   INITIALIZE l_sffb.* TO NULL

   SELECT * INTO l_sffb.* FROM sffb_t
    WHERE sffbent   = g_enterprise
      AND sffbsite  = g_site
      AND sffbdocno = p_docno
      AND sffbseq   = p_seq_t
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "sel_sffb"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF
      
   IF l_sffb.sffb001 <> '3' OR p_amt IS NULL OR p_amt = l_sffb.sffb019 THEN
      LET r_success = TRUE 
      RETURN r_success
   END IF

   SELECT COUNT(*) INTO l_cnt
     FROM sfha_t
    WHERE sfhaent = g_enterprise
      AND sfha010 = p_docno
      AND sfha011 = p_seq_t
      AND sfhastus<> 'N'
    
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00246'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF p_seq_t IS NULL THEN LET p_seq_t = p_seq END IF
#如果传入下线数量为0，则要删除原来那笔当站下线资料
   IF p_amt = 0 THEN
      IF NOT s_asft335_del_sfha(p_docno,p_seq_t) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   UPDATE sfha_t SET sfha011 = p_seq,
                     sfha008 = p_amt
    WHERE sfhaent = g_enterprise
      AND sfha010 = p_docno
      AND sfha011 = p_seq_t
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd sfha_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success      
   END IF
#更新不到，可能是原来没有下线数量，现在有了，需要新增
   IF SQLCA.sqlerrd[3] = 0 THEN
      IF NOT s_asft335_ins_sfha(p_docno,p_seq,p_amt) THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF 
   END IF 
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 若制程是重工制程，则更新原重工转出制程里那一站的在制量和重工转入量
# Memo...........:
# Usage..........: CALL s_asft335_upd_rework_routing(p_cmd,p_sfcb)
#                  RETURNING r_success
# Input parameter: p_cmd          审核1/取消审核-1
#                : p_sfcb         当站制程资料
# Return code....: r_success  回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/05/27 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_upd_rework_routing(p_cmd,p_sfcb)
   DEFINE p_cmd          LIKE type_t.num5         #审核 1/取消审核 -1
   DEFINE r_success      LIKE type_t.num5
   DEFINE p_sfcb         RECORD LIKE sfcb_t.*
   DEFINE l_sfca005      LIKE sfca_t.sfca005
   DEFINE l_qty          LIKE sfia_t.sfia007
   DEFINE l_qty1         LIKE sfia_t.sfia007
   DEFINE l_qty2         LIKE sfia_t.sfia007
   DEFINE l_sfia003      LIKE sfia_t.sfia003
   DEFINE l_sfia004      LIKE sfia_t.sfia004
   DEFINE l_sfia005      LIKE sfia_t.sfia005
   DEFINE l_sfia006      LIKE sfia_t.sfia006
   DEFINE l_sfcb021      LIKE sfcb_t.sfcb021
   DEFINE l_sfcb022      LIKE sfcb_t.sfcb022
   
#首先要判断是否是重工制程：sfca005=2 
#然后看是否是最后一站：sfcb009 = ‘END’
#再然后看本站是否处于群组
#  a：替代群组，数量取合计，注意sfcb006相同，且sfcb009 = END
#  b：无顺序群组和其他，取同是“END”的最小数量
#通过asft338的资料，找到需要更新的那个重工转出制程站
#call s_asft338_upd_routing(p_cmd,p_sfia003,p_sfia004,p_sfia005,p_sfia006,p_sfia007)更新之
   LET r_success = TRUE
   LET l_qty     = 0
   
   SELECT sfca005 INTO l_sfca005 
     FROM sfca_t
    WHERE sfcaent   = g_enterprise
      AND sfcasite  = g_site
      AND sfcadocno = p_sfcb.sfcbdocno
      AND sfca001   = p_sfcb.sfcb001
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel sfca005'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF l_sfca005 <> '2' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF   

   IF p_sfcb.sfcb009 <> 'END' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

#先取除替代群组外最小的数量
#再把同一替代群组的累积，然后取所有替代群组中最小的数量
#以上两者内再取最小的

   SELECT MIN(qty) INTO l_qty1 FROM
     (SELECT CASE WHEN sfcb019 ='Y' THEN sfcb049*sfcb022/sfcb021 WHEN sfcb018 ='Y' THEN sfcb048*sfcb022/sfcb021 WHEN sfcb016 ='Y' THEN sfcb050*sfcb022/sfcb021 WHEN sfcb015 ='Y' THEN sfcb047*sfcb054/sfcb053 WHEN sfcb014 ='Y' THEN sfcb046*sfcb054/sfcb053 ELSE 0 END qty
        FROM sfcb_t   #这是取除替代群组外最小的数量
       WHERE sfcbent   = p_sfcb.sfcbent
         AND sfcbsite  = p_sfcb.sfcbsite
         AND sfcbdocno = p_sfcb.sfcbdocno
         AND sfcb001   = p_sfcb.sfcb001
         AND sfcb005   <> '2'
         AND sfcb009   = 'END')
         
   SELECT MIN(qty) INTO l_qty2 FROM #同一替代群组的累积，然后取所有替代群组中最小的数量
      (SELECT SUM(CASE WHEN sfcb019 ='Y' THEN sfcb049*sfcb022/sfcb021 WHEN sfcb018 ='Y' THEN sfcb048*sfcb022/sfcb021 WHEN sfcb016 ='Y' THEN sfcb050*sfcb022/sfcb021 WHEN sfcb015 ='Y' THEN sfcb047*sfcb054/sfcb053 WHEN sfcb014 ='Y' THEN sfcb046*sfcb054/sfcb053 ELSE 0 END) qty,sfcb006
        FROM sfcb_t   
       WHERE sfcbent   = p_sfcb.sfcbent
         AND sfcbsite  = p_sfcb.sfcbsite
         AND sfcbdocno = p_sfcb.sfcbdocno
         AND sfcb001   = p_sfcb.sfcb001
         AND sfcb005   = '2'
         AND sfcb009   = 'END'
       GROUP BY sfcb006)
   
   IF l_qty1 IS NULL THEN LET l_qty1 = 0 END IF
   IF l_qty2 IS NULL THEN LET l_qty2 = 0 END IF
   IF l_qty1 > l_qty2 THEN
      LET l_qty = l_qty1
   ELSE
      LET l_qty = l_qty2
   END IF
   IF l_qty IS NULL THEN LET l_qty = 0 END IF

#根据参数传入的重工转入制程去找到那笔asft338资料，关联到原来的重工转出制程站，由于转入runcard是自动编号的，应该不会存在重复资料，理论上，应该是这样的。。。
   SELECT sfia003,sfia004,sfia005,sfia006
     INTO l_sfia003,l_sfia004,l_sfia005,l_sfia006
     FROM sfia_t
    WHERE sfiaent  = g_enterprise
      AND sfiasite = g_site
      AND sfia003  = p_sfcb.sfcbdocno
      AND sfia008  = p_sfcb.sfcb001

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel sfia'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
#再把数量从主件单位数量换算回在制数量
   SELECT sfcb021,sfcb022 INTO l_sfcb021,l_sfcb022
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbsite  = g_site
      AND sfcbdocno = l_sfia003
      AND sfcb001   = l_sfia004
      AND sfcb003   = l_sfia005
      AND sfcb004   = l_sfia006
      
   LET l_qty = l_qty * l_sfcb021/l_sfcb022
   
   IF NOT s_asft338_upd_routing(p_cmd,l_sfia003,l_sfia004,l_sfia005,l_sfia006,l_qty) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 找出当前站的第一个动作是哪一个
# Memo...........:
# Usage..........: CALL s_asft335_get_first_action(p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success,r_type
# Input parameter: p_sfcbdocno    传入工单编号
#                : p_sfcb001      传入RunCard
#                : p_sfcb003      传入作业编号
#                : p_sfcb004      传入作业序
# Return code....: r_success      
#                : r_type         回传1：move in 2：check in 3：报工 4：check out 5：move out
# Date & Author..: 2014/11/23 By wujie
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_get_first_action(p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno   
   DEFINE p_sfcb001    LIKE sfcb_t.sfcb001
   DEFINE p_sfcb003    LIKE sfcb_t.sfcb003
   DEFINE p_sfcb004    LIKE sfcb_t.sfcb004
   DEFINE r_success    LIKE type_t.num5
   DEFINE r_type       LIKE type_t.num5
   DEFINE l_sfcb014    LIKE sfcb_t.sfcb014
   DEFINE l_sfcb015    LIKE sfcb_t.sfcb015
   DEFINE l_sfcb016    LIKE sfcb_t.sfcb016
   DEFINE l_sfcb018    LIKE sfcb_t.sfcb018
   DEFINE l_sfcb019    LIKE sfcb_t.sfcb019
   
   
   LET r_type = 0
   LET r_success = TRUE
   IF p_sfcbdocno IS NULL OR p_sfcb001 IS NULL OR p_sfcb003 IS NULL OR p_sfcb004 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00456'
      LET g_errparam.extend = 'get first action'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      LET r_type = 0
      RETURN r_success,r_type
   END IF
   
   SELECT sfcb014,sfcb015,sfcb016,sfcb018,sfcb019 INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019 
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbdocno = p_sfcbdocno
      AND sfcb001   = p_sfcb001
      AND sfcb003   = p_sfcb003
      AND sfcb004   = p_sfcb004

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00457'
      LET g_errparam.extend = 'get first action'
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_sfcbdocno
      LET g_errparam.replace[2] = p_sfcb001
      LET g_errparam.replace[3] = p_sfcb003
      LET g_errparam.replace[4] = p_sfcb004
      CALL cl_err()
      LET r_success = FALSE
      LET r_type = 0
      RETURN r_success,r_type
   END IF
   
   IF l_sfcb019 = 'Y' THEN LET r_type = '5' END IF
   IF l_sfcb018 = 'Y' THEN LET r_type = '4' END IF
   IF l_sfcb016 = 'Y' THEN LET r_type = '3' END IF
   IF l_sfcb015 = 'Y' THEN LET r_type = '2' END IF
   IF l_sfcb014 = 'Y' THEN LET r_type = '1' END IF
   
   RETURN r_success,r_type
END FUNCTION

PUBLIC FUNCTION s_asft335_ws_confirm(p_sffbdocno)
DEFINE p_sffbdocno     LIKE sffb_t.sffbdocno
DEFINE r_success       LIKE type_t.num5

   #確認前檢核段
   CALL s_asft335_conf(p_sffbdocno) RETURNING r_success

RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 依工作站抓取默認成本中心
# Memo...........:
# Usage..........: CALL s_asft335_default_sffb030(p_sffb009)
#                  RETURNING r_sffb030
# Input parameter: p_sffb009 工作站
# Return code....: r_sffb030 成本中心
# Date & Author..: 151013 By fengmy
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_default_sffb030(p_sffb009)
DEFINE p_sffb009 LIKE sffb_t.sffb009
DEFINE r_sffb030 LIKE sffb_t.sffb030

   SELECT ecaa003 INTO r_sffb030 FROM ecaa_t 
    WHERE ecaaent = g_enterprise AND ecaasite =  g_site
      AND ecaa001 = p_sffb009
   IF cl_null(r_sffb030) THEN LET r_sffb030 = '' END IF
    
   RETURN r_sffb030
END FUNCTION

################################################################################
# Descriptions...: 成本中心檢查
# Memo...........:
# Usage..........: CALL s_asft335_sffb030_chk(p_sffb030)
#                  RETURNING r_success,r_sffb030
# Input parameter: p_sffb030 成本中心
# Return code....: r_success 成功否
#                  r_sffb030 成本中心
# Date & Author..: 151013 By fengmy
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_sffb030_chk(p_sffb030)
DEFINE p_sffb030 LIKE sffb_t.sffb030
DEFINE r_success LIKE type_t.num5
DEFINE r_sffb030 LIKE sffb_t.sffb030

   LET r_success = TRUE
   IF NOT cl_null(p_sffb030) THEN 
   #應用 a17 樣板自動產生(Version:2)
      #欄位存在檢查
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
    
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_sffb030
      LET g_errshow = TRUE                                                                                                #160328-00029#3 add
      LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125" #160328-00029#3 add
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001") THEN
         #檢查成功時後續處理
         LET r_sffb030 = p_sffb030
      ELSE
         LET r_success = FALSE
      END IF
   ELSE 
      LET r_sffb030 = ''
   END IF

   RETURN r_success,r_sffb030

END FUNCTION

################################################################################
# Descriptions...: 若有PQC,則需控管 良品數量不可大於該工單+Rucnard+作業編號+製程序的PQC合格數量-已報工良品量
# Memo...........:
# Usage..........: CALL s_asft335_chk_sffb017 (p_sffbdocno,p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008,p_sffb017)
#                  RETURNING r_success,r_sffb017
# Input parameter: p_sffbdocno   報工單號
#                : p_sffb001     作業型態
#                : p_sffb005     工單單號
#                : p_sffb006     RunCard
#                : p_sffb007     作業編號
#                : p_sffb008     製程序
#                : p_sffb017     報工良品量
# Return code....: r_success     報工量是否有超過PQC合格量
# Date & Author..: 15/11/17 By fionchen
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_chk_sffb017(p_sffbdocno,p_sffb001,p_sffb005,p_sffb006,p_sffb007,p_sffb008,p_sffb017)
   DEFINE p_sffbdocno         LIKE sffb_t.sffbdocno        #報工單號
   DEFINE p_sffb001           LIKE sffb_t.sffb001          #作業型態
   DEFINE p_sffb005           LIKE sffb_t.sffb005          #單據單號
   DEFINE p_sffb006           LIKE sffb_t.sffb006          #RunCard
   DEFINE p_sffb007           LIKE sffb_t.sffb007          #作業編號
   DEFINE p_sffb008           LIKE sffb_t.sffb008          #製程序
   DEFINE p_sffb017           LIKE sffb_t.sffb017          #報工良品量
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_sfcb017           LIKE sfcb_t.sfcb017          #是否PQC
   DEFINE l_PQC_Qty           LIKE qcba_t.qcba023          #合計PQC合格量
   DEFINE l_sffb017_Qty       LIKE sffb_t.sffb017          #合計報工良品量
   
   LET r_success = TRUE
   
   IF p_sffb017 IS NULL THEN LET p_sffb017 = 0 END IF

   IF p_sffb001 <> '3' THEN
      RETURN r_success
   END IF
   
   IF p_sffb001 IS NULL OR p_sffb005 IS NULL OR p_sffb006 IS NULL OR p_sffb007 IS NULL OR p_sffb008 IS NULL THEN
      RETURN r_success
   END IF
   
   SELECT sfcb017                          #是否PQC
     INTO l_sfcb017                       
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbsite  = g_site
      AND sfcbdocno = p_sffb005            #單據單號
      AND sfcb001   = p_sffb006            #RunCard
      AND sfcb003   = p_sffb007            #作業編號
      AND sfcb004   = p_sffb008            #製程序
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #若有PQC,則需控管 良品數量不可大於該工單+Rucnard+作業編號+作業序的PQC合格數量-已報工良品量
   IF l_sfcb017 = 'Y' THEN 
   
      #PQC檢驗合格量
      Select SUM(qcba023) INTO l_PQC_Qty        #合格量
        From qcba_t
       WHERE qcbaent  = g_enterprise
         AND qcbasite = g_site
         AND qcba000  = '3'                     #PQC
         AND qcba001  = p_sffb005               #來源單據
         AND qcba029  = p_sffb006               #RunCard
         AND qcba006  = p_sffb007               #作業編號
         AND qcba007  = p_sffb008               #製程序
         AND (qcba022 = '1' or qcba022 = '4')   #判定結果(1.合格 4.特採)
         AND qcbastus = 'Y'                     #狀態碼
   
      IF l_PQC_Qty IS NULL THEN LET l_PQC_Qty = 0 END IF
      
      #已報工良品量      
      Select SUM(sffb017) INTO l_sffb017_Qty
        From sffb_t
       WHERE sffbent   =  g_enterprise 
         AND sffbsite  =  g_site
         AND sffbdocno <> p_sffbdocno           #報工單號(其他報工單)
         AND sffb001   = '3'                    #報工類別
         AND sffb005   =  p_sffb005             #來源單號
         AND sffb006   =  p_sffb006             #RunCard 
         AND sffb007   =  p_sffb007             #作業編號
         AND sffb008   =  p_sffb008             #製程序
         AND sffbstus  <> 'X'                   #狀態碼
      
      IF l_sffb017_Qty IS NULL THEN LET l_sffb017_Qty = 0 END IF
      
      IF p_sffb017 > l_PQC_Qty - l_sffb017_Qty THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00701'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增單站下線檔
# Memo...........:
# Usage..........: CALL s_asft335_ins_shf(p_slip,p_sfha010,p_sfha011,p_sfhb003,p_sfhb004,p_sfhb)
#                  RETURNING r_success
# Input parameter: p_slip         下線單別
#                : p_sfha010      報工單號
#                : p_sfha011      報工項次
#                : p_sfhb003      下線庫別
#                : p_sfhb004      下線儲位
#                : p_sfhb.sfhb001 下線料號
#                : p_sfhb.sfhb002 產品特徵
#                : p_sfhb.sfhb008 下線數量
# Return code....: TRUE OR FALSE
# Date & Author..: 160511-00020 By whitney
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_ins_shf(p_slip,p_sfha010,p_sfha011,p_sfhb003,p_sfhb004,p_sfhb)
DEFINE p_slip       LIKE sfha_t.sfhadocno
DEFINE p_sfha010    LIKE sfha_t.sfha010
DEFINE p_sfha011    LIKE sfha_t.sfha011
DEFINE p_sfhb003    LIKE sfhb_t.sfhb003
DEFINE p_sfhb004    LIKE sfhb_t.sfhb004
DEFINE p_sfhb  DYNAMIC ARRAY OF RECORD
    sfhb001    LIKE sfhb_t.sfhb001,
    sfhb002    LIKE sfhb_t.sfhb002,
    sfhb008    LIKE sfhb_t.sfhb008
           END RECORD
DEFINE r_success    LIKE type_t.num5
DEFINE l_sfha008    LIKE sfha_t.sfha008
DEFINE l_sfhb       RECORD LIKE sfhb_t.*
DEFINE l_sfhc       RECORD LIKE sfhc_t.*
DEFINE l_success    LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_imaf061    LIKE imaf_t.imaf061
DEFINE l_imaf032    LIKE imaf_t.imaf032

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   LET g_sfhadocno = p_slip
   
   LET l_sfha008 = 0
   FOR l_n = 1 TO p_sfhb.getLength()
      IF cl_null(p_sfhb[l_n].sfhb001) THEN
         CONTINUE FOR
      END IF
      IF cl_null(p_sfhb[l_n].sfhb008) THEN
         LET p_sfhb[l_n].sfhb008 = 0
      END IF
      LET l_sfha008 = l_sfha008 + p_sfhb[l_n].sfhb008
   END FOR
   
   IF NOT s_asft335_ins_sfha(p_sfha010,p_sfha011,l_sfha008) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   FOR l_n = 1 TO p_sfhb.getLength()
      IF cl_null(p_sfhb[l_n].sfhb001) THEN
         CONTINUE FOR
      END IF
      INITIALIZE l_sfhb.* TO NULL
      LET l_sfhb.sfhbent   = g_enterprise        #企業代碼
      LET l_sfhb.sfhbsite  = g_site              #營運據點
      LET l_sfhb.sfhbdocno = g_sfhadocno         #單號
      LET l_sfhb.sfhbseq   = l_n
      LET l_sfhb.sfhb001   = p_sfhb[l_n].sfhb001
      LET l_sfhb.sfhb002   = p_sfhb[l_n].sfhb002
      LET l_sfhb.sfhb003   = p_sfhb003  #庫位
      LET l_sfhb.sfhb004   = p_sfhb004  #儲位
      LET l_sfhb.sfhb008   = p_sfhb[l_n].sfhb008
      IF NOT cl_null(l_sfhb.sfhb001) THEN
         #單位
         SELECT imaa006 INTO l_sfhb.sfhb007
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = l_sfhb.sfhb001
         #參考單位
         LET l_imaf032 = ''
         LET l_imaf061 = ''
         SELECT imaf015,imaf032,imaf061
           INTO l_sfhb.sfhb009,l_imaf032,l_imaf061
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_sfhb.sfhb001
         #生效日期
         IF l_imaf061 = '1' THEN
            LET l_sfhb.sfhb011 = cl_get_today()
            IF NOT cl_null(l_imaf032) THEN
               LET l_sfhb.sfhb011 = l_sfhb.sfhb011 + l_imaf032
            END IF
         END IF
         #參考數量
         IF NOT cl_null(l_sfhb.sfhb007) AND cl_null(l_sfhb.sfhb009) THEN
            CALL s_aooi250_convert_qty(l_sfhb.sfhb001,l_sfhb.sfhb007,l_sfhb.sfhb009,l_sfhb.sfhb008)
               RETURNING l_success,l_sfhb.sfhb010
         END IF
      END IF
      INSERT INTO sfhb_t VALUES(l_sfhb.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfhb_t",SQLERRMESSAGE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
      INITIALIZE l_sfhc.* TO NULL
      LET l_sfhc.sfhcent   = l_sfhb.sfhbent      #企業編號
      LET l_sfhc.sfhcsite  = l_sfhb.sfhbsite     #營運據點
      LET l_sfhc.sfhcdocno = l_sfhb.sfhbdocno    #單號
      LET l_sfhc.sfhcseq   = l_sfhb.sfhbseq      #項次
      LET l_sfhc.sfhcseq1  = l_sfhb.sfhbseq      #項序
      LET l_sfhc.sfhc001   = l_sfhb.sfhb001      #料件編號
      LET l_sfhc.sfhc002   = l_sfhb.sfhb002      #產品特徵
      LET l_sfhc.sfhc003   = l_sfhb.sfhb003      #庫位
      LET l_sfhc.sfhc004   = l_sfhb.sfhb004      #儲位
      LET l_sfhc.sfhc007   = l_sfhb.sfhb007      #單位
      LET l_sfhc.sfhc008   = l_sfhb.sfhb008      #數量
      LET l_sfhc.sfhc009   = l_sfhb.sfhb009      #參考單位
      LET l_sfhc.sfhc010   = l_sfhb.sfhb010      #參考數量
      LET l_sfhc.sfhc011   = l_sfhb.sfhb011      #生效日期
      INSERT INTO sfhc_t VALUES(l_sfhc.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins sfhc_t",SQLERRMESSAGE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOR
      END IF
   END FOR
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 插入s_asft335_sffbtmp临时表数据
# Memo...........: 对sffb表的各项次重新按报工的顺序排序
# Usage..........: CALL s_asft335_deal_sffbtmp(p_docno)
#                  RETURNING r_success
# Input parameter: p_docno     报工单号
# Return code....: r_success   处理状态(TRUE/FALSE)
# Date & Author..: 2016/7/30 By zhangllc 160730-00003#1
# Modify.........: 
################################################################################
PUBLIC FUNCTION s_asft335_deal_sffbtmp(p_docno)
   DEFINE p_docno         LIKE sffb_t.sffbdocno
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_sffb005       LIKE sffb_t.sffb005  #工单
   DEFINE l_sffb006       LIKE sffb_t.sffb006  #RUNCARD

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   DELETE FROM s_asft335_sffbtmp  #161215-00047#1
   #将该笔报工单的资料写入临时表
   INSERT INTO s_asft335_sffbtmp
    SELECT * FROM sffb_t WHERE sffbent = g_enterprise AND sffbdocno = p_docno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins s_asft335_sffbtmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #报工单资料重新排序--将现项次先更新为备份项次，以便后面逐个重排
   SELECT COUNT(*) INTO g_count FROM s_asft335_sffbtmp  #批次报工总笔数，此g_count就是用于判断已重排和未重排的依据，不可另作他用
   IF g_count = 1 THEN  #只有1笔则不用重排序
      RETURN r_success
   END IF
   
   UPDATE s_asft335_sffbtmp SET sffbseq = sffbseq + g_count  #先搬移原项次
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd sffbtmp：sffbseq bak'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #报工单资料重新排序--按工单+runcard分类
   LET l_sql = " SELECT UNIQUE sffb005,sffb006 FROM s_asft335_sffbtmp "
   PREPARE s_asft335_deal_sffbtmp_p1 FROM l_sql
   DECLARE s_asft335_deal_sffbtmp_c1 CURSOR FOR s_asft335_deal_sffbtmp_p1
   LET g_seq = 0
   FOREACH s_asft335_deal_sffbtmp_c1 INTO l_sffb005,l_sffb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_asft335_deal_sffbtmp_c1:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #按工单+runcard的工艺顺序走，并与s_asft335_sffbtmp匹配，能匹配到的更新项次g_seq
      CALL s_asft335_deal_sffbtmp_round('0',l_sffb005,l_sffb006,'','','','','') RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION


################################################################################
# Descriptions...: 插入s_asft335_sffbtmp临时表数据
# Memo...........: 对sffb表的各项次重新按报工的顺序排序
# Usage..........: CALL s_asft335_deal_sffbtmp_round(p_flag,p_wo,p_runcard,p_sfcb003,p_sfcb004,p_sfcb006,p_sfcb009,p_sfcb010)
#                  RETURNING r_success
# Input parameter: p_docno     报工单号
# Return code....: r_success   处理状态(TRUE/FALSE)
# Date & Author..: 2016/7/30 By zhangllc 160730-00003#1
# Modify.........: 
################################################################################
PUBLIC FUNCTION s_asft335_deal_sffbtmp_round(p_flag,p_wo,p_runcard,p_sfcb003,p_sfcb004,p_sfcb006,p_sfcb009,p_sfcb010)
DEFINE p_flag      LIKE type_t.chr1      #0首站 1递归下站
DEFINE p_wo        LIKE sfca_t.sfcadocno #工单号
DEFINE p_runcard   LIKE sfca_t.sfca001   #runcard号
DEFINE p_sfcb003   LIKE sfcb_t.sfcb003   #前一站转入的该站的：本站作业
DEFINE p_sfcb004   LIKE sfcb_t.sfcb004   #前一站转入的该站的：本站作业序
DEFINE p_sfcb006   LIKE sfcb_t.sfcb006   #群组
DEFINE p_sfcb009   LIKE sfcb_t.sfcb009   #前一站转入的该站的：下站作业
DEFINE p_sfcb010   LIKE sfcb_t.sfcb010   #前一站转入的该站的：下站作业序
DEFINE r_success     LIKE type_t.num5
DEFINE l_i,l_row     LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_sfcb        DYNAMIC ARRAY OF RECORD LIKE sfcb_t.*
DEFINE l_cnt        LIKE type_t.num10
DEFINE l_cnt_i      LIKE type_t.num10

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF p_flag = 0 THEN
      #抓出某RUN CARD各首站开始的第一个报工站
      LET l_sql = " SELECT sfcb_t.* FROM sfcb_t ",
                  "  WHERE sfcbent = ",g_enterprise,
                  "    AND sfcbdocno = '",p_wo,"' ",  #单号
                  "    AND sfcb001 = '",p_runcard,"' ",   #RUN CARD
                  "    AND (sfcb007 = 'INIT' OR sfcb007 = ' ' OR sfcb007 IS NULL) "       #上站作业=首站(非制程工单为空)
   ELSE
      #递归流转，获取下站sfcb资料
      IF NOT cl_null(p_sfcb006) THEN   #群组
         #从sfcb中获取下站，不能从sfcc以防群组中某一工艺线路也存在自己的流程，群组里面不会有MULT的情况，若有代表制程资料有误
         LET l_sql = " SELECT sfcb_t.* FROM sfcb_t ",
                     "  WHERE sfcbent = ",g_enterprise,
                     "    AND sfcbdocno = '",p_wo,"' ",  #单号
                     "    AND sfcb001 = '",p_runcard,"' ",   #RUN CARD
                     "    AND sfcb003 = '",p_sfcb009,"' ", #本站作业  = 前一站转入的该站的：下站作业
                     "    AND sfcb004 = '",p_sfcb010,"' "  #本站作业序 = 前一站转入的该站的：下站作业序
      ELSE
         #从sfcc中获取下站
         #是要找到当前站所有的下站,接受传入参数的是当前站，抓出来的是下站
         LET l_sql = " SELECT sfcb_t.* FROM sfcb_t,sfcc_t ", 
                     "  WHERE sfcbent = sfccent AND sfcbdocno = sfccdocno ",
                     "    AND sfcb001 = sfcc001 ",
                     "    AND sfcb002 = sfcc002 ",
                     "    AND sfccent = ",g_enterprise,
                     "    AND sfccdocno = '",p_wo,"' ",    #单号
                     "    AND sfcc001 = '",p_runcard,"' ", #RUN CARD
                     "    AND sfcc003 = '",p_sfcb003,"' ", #上站作业编号=前一站转入的该站的：本站作业
                     "    AND sfcc004 = '",p_sfcb004,"' "  #上站作业序  =前一站转入的该站的：本站作业序
      END IF
   END IF
   PREPARE s_asft310_get_transfer_p FROM l_sql
   DECLARE s_asft310_get_transfer_c CURSOR FOR s_asft310_get_transfer_p
   
   LET l_row = 1
   FOREACH s_asft310_get_transfer_c INTO l_sfcb[l_row].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      LET l_row = l_row + 1
   END FOREACH
   LET l_row = l_row - 1
   
   IF l_row > 0 THEN
      FOR l_i = 1 TO l_row
          #判断当站的作业+作业序是不是在sffbtmp中有，有就可以给予顺序了
          #注意，目前不支持张工单会有多个相同作业+作业序的存在，若有这样的资料，请前端卡控住
          SELECT COUNT(*) INTO l_cnt FROM s_asft335_sffbtmp
           WHERE sffbent = g_enterprise
             AND sffb005 = p_wo     #工单
             AND sffb006 = p_runcard  #runcard号
             AND sffb007 = l_sfcb[l_row].sfcb003 #作业
             AND sffb008 = l_sfcb[l_row].sfcb004 #作业序
          IF l_cnt > 0 THEN
             FOR l_cnt_i = 1 TO l_cnt   #考虑同作业+作业序分几笔报工的情况
                LET g_seq = g_seq + 1
                UPDATE s_asft335_sffbtmp SET sffbseq = g_seq
                 WHERE sffbent = g_enterprise
                   AND sffb005 = p_wo     #工单
                   AND sffb006 = p_runcard  #runcard号
                   AND sffb007 = l_sfcb[l_row].sfcb003 #作业
                   AND sffb008 = l_sfcb[l_row].sfcb004 #作业序
                   AND sffbseq > g_count  #尚未被更新过的
                   AND sffbseq = (SELECT MIN(sffbseq) FROM s_asft335_sffbtmp
                                   WHERE sffbent = g_enterprise
                                     AND sffb005 = p_wo     #工单
                                     AND sffb006 = p_runcard  #runcard号
                                     AND sffb007 = l_sfcb[l_row].sfcb003 #作业
                                     AND sffb008 = l_sfcb[l_row].sfcb004 #作业序
                                     AND sffbseq > g_count  #尚未被更新过的
                                 )
        
               IF g_seq = g_count THEN  #代表已全更新完，不用继续匹配了
                  RETURN r_success
               END IF
            END FOR
          END IF
          
          #递归找第下个工艺流
                                      #   单号                  run card            本站作业             作业序               群组                下站作业             下站作业序
          CALL s_asft335_deal_sffbtmp_round('1',l_sfcb[l_i].sfcbdocno,l_sfcb[l_i].sfcb001,l_sfcb[l_i].sfcb003,l_sfcb[l_i].sfcb004,l_sfcb[l_i].sfcb006,l_sfcb[l_i].sfcb009,l_sfcb[l_i].sfcb010)
             RETURNING l_success
          IF NOT l_success THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
      END FOR
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 接收批次報工(asft330)的單身項次
# Memo...........:
# Usage..........: CALL s_asft335_receive_sffbseq(p_sffadocno,p_sffadocno,p_sffbseq)
# Input parameter: p_sffadocno    單號
#                : p_sffbseq      項次
# Return code....: 
# Date & Author..: 2016/08/04 By dorislai (160804-00029#1)
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asft335_receive_sffbseq(p_sffadocno,p_sffbseq)
   DEFINE p_sffadocno LIKE sffa_t.sffadocno
   DEFINE p_sffbseq LIKE sffb_t.sffbseq
   
   LET g_sffadocno = p_sffadocno
   LET g_sffbseq = p_sffbseq
END FUNCTION

 
{</section>}
 
