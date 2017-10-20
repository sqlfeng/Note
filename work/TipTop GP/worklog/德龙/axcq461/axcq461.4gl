# Prog. Version..: '5.30.06-13.03.12(00004)'     #
#
# Pattern name...: axcq461.4gl
# Descriptions...: 分仓进销存报表查询
# Date & Author..: add by fxw 140902

DATABASE ds


GLOBALS "../../config/top.global"
#模組變數(Module Variables)

DEFINE tm         RECORD
                   wc  	    STRING,
                   by       LIKE ccz_file.ccz01,
                   bm       LIKE ccz_file.ccz02,
                   ey       LIKE ccz_file.ccz01,
                   em       LIKE ccz_file.ccz02,
                   sy       LIKE ccz_file.ccz01,     #起止期别之前一期
                   sm       LIKE ccz_file.ccz02,
                   bdate    LIKE type_file.dat,     #起止日期
                   edate    LIKE type_file.dat      #截止日期
                  END RECORD,
       g_ccc,g_ccc_excel   DYNAMIC ARRAY OF RECORD
                   ima01   LIKE ima_file.ima01,
                   ima02   LIKE ima_file.ima02,
                   ima021  LIKE ima_file.ima021,
                   ima131  LIKE ima_file.ima131,
                   ima39   LIKE ima_file.ima39,
                   imk02   LIKE imk_file.imk02,
                   imd02   LIKE imd_file.imd02,
                   ima25   LIKE ima_file.ima25,
                   qcsl    LIKE type_file.num15_3,
                   qcdj    LIKE type_file.num20_6,
                   qcje    LIKE type_file.num15_3,
                   rksl    LIKE type_file.num15_3,
                   rkdj    LIKE type_file.num20_6,
                   rkje    LIKE type_file.num15_3,
                   cksl    LIKE type_file.num15_3,
                   ckdj    LIKE type_file.num20_6,
                   ckje    LIKE type_file.num15_3,
                   qmsl    LIKE type_file.num15_3,
                   qmdj    LIKE type_file.num20_6,
                   qmje    LIKE type_file.num15_3
                  END RECORD,
       pay_sw     LIKE type_file.num5,         # No.FUN-690028 SMALLINT
       g_wc,g_sql STRING,                      #WHERE CONDITION  #No.FUN-580092 HCN
       g_rec_b    LIKE type_file.num5, 	       #單身筆數  #No.FUN-690028 SMALLINT
       g_rec_b2   LIKE type_file.num5, 	       #單身筆數  #cy add
       g_cnt      LIKE type_file.num10         #No.FUN-690028 INTEGER
DEFINE g_msg      LIKE type_file.chr1000       #No.FUN-A320028
DEFINE l_ac       LIKE type_file.num5          #No.FUN-A320028
DEFINE l_ac1      LIKE type_file.num5          #cy add
DEFINE g_filter_wc  STRING                     #cy add
DEFINE g_flag         LIKE type_file.chr1    #FUN-C80102
DEFINE g_action_flag  LIKE type_file.chr100  #FUN-C80102
DEFINE g_comb         ui.ComboBox            #FUN-C80102
DEFINE g_cmd          LIKE type_file.chr1000 #FUN-C80102
DEFINE g_bookno       LIKE aah_file.aah00     #帳別  #FUN-D60123
DEFINE   f    ui.Form
DEFINE   page om.DomNode
DEFINE   w    ui.Window

MAIN
   DEFINE l_time	LIKE type_file.chr8    #計算被使用時間  #No.FUN-690028 VARCHAR(8)
   DEFINE l_sl		LIKE type_file.num5    #No.FUN-690028 SMALLINT
   DEFINE p_row,p_col   LIKE type_file.num5    #No.FUN-690028 SMALLINT

   OPTIONS                                #改變一些系統預設值
       INPUT NO WRAP
   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AXC")) THEN
      EXIT PROGRAM
   END IF

   CALL cl_used(g_prog,g_time,1) RETURNING g_time
   LET pay_sw    = 1

   OPEN WINDOW q461_w WITH FORM "axc/42f/axcq461"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
   CALL cl_ui_init()


   INITIALIZE tm.* TO NULL
   SELECT * INTO g_ccz.* FROM ccz_file
   LET tm.by = g_ccz.ccz01
   LET tm.bm = g_ccz.ccz02
   LET tm.ey = g_ccz.ccz01
   LET tm.em = g_ccz.ccz02
   CALL q461_table()
   CALL q461_q()

   CALL q461_menu()
   DROP TABLE axcq461_tmp;
   CLOSE WINDOW q461_w               #結束畫面

   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION q461_cs()
   DEFINE   lc_qbe_sn   LIKE gbm_file.gbm01   #No.FUN-580031
   DEFINE   l_wc        STRING                #MOD-B10024

   CLEAR FORM #清除畫面
   CALL g_ccc.clear()
   CALL cl_opmsg('q')
   LET g_filter_wc = ''

   DISPLAY BY NAME tm.by,tm.bm,tm.ey,tm.em
   DIALOG ATTRIBUTES(UNBUFFERED)

   INPUT BY NAME tm.by,tm.bm,tm.ey,tm.em ATTRIBUTE (WITHOUT DEFAULTS=TRUE)

      BEFORE INPUT
         CALL cl_qbe_display_condition(lc_qbe_sn)

   END INPUT

   CONSTRUCT tm.wc ON ima01,ima131,imk02
                FROM s_ccc[1].ima01,s_ccc[1].ima131,s_ccc[1].imk02

   BEFORE CONSTRUCT
      CALL cl_qbe_init()

   END CONSTRUCT

#      AFTER DIALOG
#          IF tm.a = '1' THEN
#             CALL cl_set_comp_visible("azf01_1,azf03_1,aah04,aah04_ccc92",FALSE)  #FUN-D60123
#          END IF
#          IF tm.a = '2' THEN
#             CALL cl_set_comp_visible("ima01_1,ima02_1,ima021_1,ima25_1,ima39_1,aag02_1,azf01_2,azf03_2,aah04,aah04_ccc92",FALSE)  #FUN-D60123
#          END IF
#          IF tm.a = '3' THEN
#             CALL cl_set_comp_visible("ima01_1,ima02_1,ima021_1,ima25_1,azf01_1,azf03_1,azf01_2,azf03_2",FALSE)
#          END IF

      ON ACTION CONTROLP
         CASE
          WHEN INFIELD(ima01)
               CALL cl_init_qry_var()
               LET g_qryparam.form     = "q_ima"
               LET g_qryparam.state    = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO ima01
               NEXT FIELD ima01

          WHEN INFIELD(imk02)
               CALL cl_init_qry_var()
               LET g_qryparam.form     = "q_imd01"
               LET g_qryparam.state    = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO imk02
               NEXT FIELD imk02

         END CASE


      ON ACTION locale
         LET g_action_choice = "locale"
         CALL cl_show_fld_cont()
         CALL cl_dynamic_locale()

      ON ACTION ACCEPT
         LET INT_FLAG = 0
         ACCEPT DIALOG

      ON ACTION CANCEL
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = 1
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

      ON ACTION qbe_select
         CALL cl_qbe_list() RETURNING lc_qbe_sn
         CALL cl_qbe_display_condition(lc_qbe_sn)

   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL  cl_used(g_prog,g_time,2) RETURNING g_time  #cy add
      EXIT PROGRAM                                     #cy add
   END IF

   CALL q461()
   CALL q461_t()

END FUNCTION

FUNCTION q461()
   DEFINE bdate,edate LIKE type_file.dat
   DEFINE l_chr       LIKE type_file.chr1

   DELETE FROM axcq461_tmp
   IF cl_null(tm.wc) THEN LET tm.wc = "1=1" END IF
   IF cl_null(g_wc) THEN LET g_wc = "1=1" END IF
   IF tm.em = 1 THEN
      LET tm.sy =  tm.by - 1
      LET tm.sm = 12
   ELSE
      LET tm.sy = tm.by
      LET tm.sm = tm.bm - 1
   END IF

   CALL s_azm(tm.by,tm.bm) RETURNING l_chr,bdate,edate
   LET tm.bdate = bdate
   CALL s_azm(tm.ey,tm.em) RETURNING l_chr,bdate,edate
   LET tm.edate = edate

   CALL q461_get_tmp()
END FUNCTION

FUNCTION q461_table()
      CREATE TEMP TABLE axcq461_tmp(
                   ima01   LIKE ima_file.ima01,
                   ima02   LIKE ima_file.ima02,
                   ima021  LIKE ima_file.ima021,
                   ima131  LIKE ima_file.ima131,
                   ima39   LIKE ima_file.ima39,
                   imk02   LIKE imk_file.imk02,
                   imd02   LIKE imd_file.imd02,
                   ima25   LIKE ima_file.ima25,
                   qcsl    LIKE type_file.num15_3,
                   qcdj    LIKE type_file.num20_6,
                   qcje    LIKE type_file.num15_3,
                   rksl    LIKE type_file.num15_3,
                   rkdj    LIKE type_file.num20_6,
                   rkje    LIKE type_file.num15_3,
                   cksl    LIKE type_file.num15_3,
                   ckdj    LIKE type_file.num20_6,
                   ckje    LIKE type_file.num15_3,
                   qmsl    LIKE type_file.num15_3,
                   qmdj    LIKE type_file.num20_6,
                   qmje    LIKE type_file.num15_3)

END FUNCTION


FUNCTION q461_get_tmp()
DEFINE l_sql,l_sql1 STRING

   LET l_sql = "select ima01,ima02,ima021,ima131,ima39,imk02,imd02,ima25,sum(qcsl),0,sum(qcje),sum(rksl),0,sum(rkje),sum(cksl),0,sum(ckje),sum(qmsl),0,sum(qmje) ",
"   from ima_file left join ",
" (select imk01,imk02,sum(imk09) qcsl,sum(imk09*nvl(cca23,ccc23)) qcje,0 rksl,0 rkje,0 cksl,0 ckje,0 qmsl,0 qmje ",
#"   from imk_file,ccc_file ",          #mark by gujt151014
"   from imk_file left outer join ccc_file on imk01 = ccc01 and imk05 = ccc02 and imk06 = ccc03 ",     #add by gujt1501014
"                 left outer join cca_file on imk01 = cca01 and imk05 = cca02 and imk06 = cca03 ",
#"  where imk01 = ccc01 and imk05 = ccc02 and imk06 = ccc03 ",    #mark by gujt151014
"    where imk05 = ",tm.sy," and imk06 = ",tm.sm,                 #modify by gujt1501014 把and改为where
"    and imk02 not in (select jce02 from jce_file) ",
"  group by imk01,imk02 ",
" union all ",
" select imk01,imk02,0 qcsl,0 qcje,0 rksl,0 rkje,0 cksl,0 ckje,sum(imk09) qmsl,sum(imk09*ccc23) qmje ",
#"   from imk_file,ccc_file ",    #mark by gujt151014
"   from imk_file left outer join ccc_file on imk01 = ccc01 and imk05 = ccc02 and imk06 = ccc03 ",      #add by gujt151014
#"  where imk01 = ccc01 and imk05 = ccc02 and imk06 = ccc03 ",       #mark by gujt151014
"    where  imk05 = ",tm.ey," and imk06 = ",tm.em,                   #modify by gujt1501014 把and改为where
"    and imk02 not in (select jce02 from jce_file) ",
"  group by imk01,imk02 ",
" union all ",
" select tlf01,tlf902,",
"        0 qcsl,0 qcje,",
"        sum(decode(tlf907,1,tlf10*tlf12,0)) rksl,sum(decode(tlf907,1,decode(tlf13,'aimt324',tlf10*tlf12*ccc23,tlf21 ),0)) rkje, ",
"        sum(decode(tlf907,1,0,tlf10*tlf12)) cksl,sum(decode(tlf907,1,0,decode(tlf13,'aimt324',tlf10*tlf12*ccc23,tlf21 ))) ckje, ",
"        0 qmsl,0 qmje ",
"   from tlf_file left join ccc_file on ccc01 = tlf01 and ccc02 = year(tlf06) and ccc03 = month(tlf06) ",
"  where tlf06 between '",tm.bdate,"' and '",tm.edate,"'",
"    and tlf907 <> 0 ",
"    and tlf902 not in (select jce02 from jce_file) ",
"  group by tlf01,tlf902 ",
"  union all               ",                                                                            --axct002 成本调整
" select ccb01,'axct002',0,0,0,sum(case when ccb22>0 then ccb22 else 0 end) ,0,sum(case when ccb22>0 then 0 else ccb22 end)*(-1) ,0,",
#"0 ",   #mark by dengsy160513
"   sum(case when ccb22>0 then ccb22 else 0 end)+sum(case when ccb22>0 then 0 else ccb22 end) ",  #add by dengsy160513
"   from ccb_file ",
"  where (ccb02*12+ccb03) between (",tm.by*12+tm.em,") and (",tm.ey*12+tm.em,")",
" group by ccb01 ",
" union all ",
" select imk01,imk02,sum(imk09) qcsl,0 qcje,0 rksl,0 rkje,0 cksl,0 ckje,0 qmsl,0 qmje ",
"   from imk_file ",
"  where imk05 = ",tm.ey," and imk06 = ",tm.em,
"    and imk02 in (select jce02 from jce_file) ",
"  group by imk01,imk02 ",
" union all ",
" select imk01,imk02,0 qcsl,0 qcje,0 rksl,0 rkje,0 cksl,0 ckje,sum(imk09) qmsl,0 qmje ",
"   from imk_file ",
"  where imk05 = ",tm.ey," and imk06 = ",tm.em,
"   and imk02 in (select jce02 from jce_file) ",
"  group by imk01,imk02 ",
" union all ",
" select tlf01,tlf902,",
"        0 qcsl,0 qcje,",
"        sum(decode(tlf907,1,tlf10*tlf12,0)) rksl,0 rkje,",
"        sum(decode(tlf907,1,0,tlf10*tlf12)) cksl,0 ckje,",
"        0 qmsl,0 qmje ",
"   from tlf_file left join ccc_file on ccc01 = tlf01 and ccc02 = year(tlf06) and ccc03 = month(tlf06) ",
"  where tlf06 between '",tm.bdate,"' and '",tm.edate,"'",
"    and tlf907 <> 0 ",
"    and tlf902 in (select jce02 from jce_file) ",
"  group by tlf01,tlf902 ",
"  ) left join imd_file on imd01 = imk02 on ima01 = imk01 ",
"  where (qcsl <> 0 or rksl <> 0 or cksl <> 0 or qmsl <> 0 or qcje <> 0 or rkje <> 0 or ckje <> 0 or qmje <> 0) ",
"  group by ima01,ima02,ima021,ima131,ima39,imk02,imd02,ima25 "


   LET l_sql1 = " INSERT INTO axcq461_tmp ",
                 l_sql CLIPPED
   PREPARE q461_p FROM l_sql1
   EXECUTE q461_p

   #str--------- add by dengsy161024
   LET l_sql1 = " UPDATE axcq461_tmp ",
                "    SET        rkje = qmje+ ckje -qcje "
   PREPARE q461_p2 FROM l_sql1
   EXECUTE q461_p2

   #end--------- add by dengsy161024

   LET l_sql1 = " UPDATE axcq461_tmp ",
                "    SET qcdj = decode(qcsl,0,0,qcje/qcsl) ,",
                "        rkdj = decode(rksl,0,0,rkje/rksl) ,",
                "        ckdj = decode(cksl,0,0,ckje/cksl) ,",
                "        qmdj = decode(qmsl,0,0,qmje/qmsl) "
   PREPARE q461_p1 FROM l_sql1
   EXECUTE q461_p1



END FUNCTION

FUNCTION q461_t()

   CLEAR FORM
   CALL g_ccc.clear()
   CALL g_ccc_excel.clear()
   CALL q461_show()
   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION q461_show()
   DISPLAY tm.by TO by
   DISPLAY tm.bm TO bm
   DISPLAY tm.ey TO ey
   DISPLAY tm.em TO em

   CALL q461_b_fill()

END FUNCTION

FUNCTION q461_b_fill()
#str-------- add by dengsy161024
DEFINE l_qcsl    LIKE type_file.num15_3,
       l_qcje    LIKE type_file.num15_3,
       l_rksl    LIKE type_file.num15_3,
       l_rkje    LIKE type_file.num15_3,
       l_cksl    LIKE type_file.num15_3,
       l_ckje    LIKE type_file.num15_3,
       l_qmsl    LIKE type_file.num15_3,
       l_qmje    LIKE type_file.num15_3
DEFINE l_azi04   LIKE azi_file.azi04 # add by lixwz 20171011
       LET l_qcsl=0
       LET l_qcje=0
       LET l_rksl=0
       LET l_rkje=0
       LET l_cksl=0
       LET l_ckje=0
       LET l_qmsl=0
       LET l_qmje=0
#end-------- add by dengsy161024


   LET g_sql = "SELECT * ",
               " FROM axcq461_tmp ",
               " WHERE ",tm.wc CLIPPED,
               " AND imk02<>'axct002' " ,           #add by liyjf160630
               " ORDER BY imk02 desc,ima01 "

   PREPARE axcq461_pb1 FROM g_sql
   DECLARE ccc_curs1  CURSOR FOR axcq461_pb1        #CURSOR

   CALL g_ccc.clear()
   CALL g_ccc_excel.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   SELECT UNIQUE azi04 INTO l_azi04 FROM azi_file
      WHERE azi01 ='RMB' # add by lixwz 20171011

   FOREACH ccc_curs1 INTO g_ccc_excel[g_cnt].*
     IF SQLCA.sqlcode THEN
        CALL cl_err('foreach_ccc:',SQLCA.sqlcode,1)
        EXIT FOREACH
     END IF
     #str-------- add by dengsy161024
     LET l_qcsl= l_qcsl+ nvl(g_ccc_excel[g_cnt].qcsl,0)
       LET l_qcje= l_qcje+ nvl(g_ccc_excel[g_cnt].qcje,0)
       LET l_rksl= l_rksl+ nvl(g_ccc_excel[g_cnt].rksl,0)
       LET l_rkje= l_rkje+ nvl(g_ccc_excel[g_cnt].rkje,0)
       LET l_cksl= l_cksl+ nvl(g_ccc_excel[g_cnt].cksl,0)
       LET l_ckje= l_ckje+ nvl(g_ccc_excel[g_cnt].ckje,0)
       LET l_qmsl= l_qmsl+ nvl(g_ccc_excel[g_cnt].qmsl,0)
       LET l_qmje= l_qmje+ nvl(g_ccc_excel[g_cnt].qmje,0)
     #end-------- add by dengsy161024
     # add by lixwz 20171011 s
     LET g_ccc_excel[g_cnt].qcje = cl_digcut(g_ccc_excel[g_cnt].qcje,l_azi04)
     LET g_ccc_excel[g_cnt].rkje = cl_digcut(g_ccc_excel[g_cnt].rkje,l_azi04)
     LET g_ccc_excel[g_cnt].ckje = cl_digcut(g_ccc_excel[g_cnt].ckje,l_azi04)
     LET g_ccc_excel[g_cnt].qmje = cl_digcut(g_ccc_excel[g_cnt].qmje,l_azi04)
     # add by lixwz 20171011 e
     IF g_cnt <= g_max_rec THEN
        LET g_ccc[g_cnt].* = g_ccc_excel[g_cnt].*
     END IF
     LET g_cnt = g_cnt + 1

   END FOREACH
   IF g_cnt <= g_max_rec THEN
      CALL g_ccc.deleteElement(g_cnt)
   END IF
   CALL g_ccc_excel.deleteElement(g_cnt)
   #LET g_rec_b = g_cnt - 1  #mark by dengsy161024
   #str------- add by dengsy161024
   LET g_ccc_excel[g_cnt].imd02= "合计："
   LET g_ccc_excel[g_cnt].qcsl = l_qcsl
       LET g_ccc_excel[g_cnt].qcje = l_qcje
       LET g_ccc_excel[g_cnt].rksl = l_rksl
       LET g_ccc_excel[g_cnt].rkje = l_rkje
       LET g_ccc_excel[g_cnt].cksl = l_cksl
       LET g_ccc_excel[g_cnt].ckje = l_ckje
       LET g_ccc_excel[g_cnt].qmsl = l_qmsl
       LET g_ccc_excel[g_cnt].qmje = l_qmje
   LET g_ccc[g_cnt].* = g_ccc_excel[g_cnt].*
   #end------- add by dengsy161024
   # add by lixwz 20171011 s
   LET g_ccc_excel[g_cnt].qcje = cl_digcut(g_ccc_excel[g_cnt].qcje,l_azi04)
   LET g_ccc_excel[g_cnt].rkje = cl_digcut(g_ccc_excel[g_cnt].rkje,l_azi04)
   LET g_ccc_excel[g_cnt].ckje = cl_digcut(g_ccc_excel[g_cnt].ckje,l_azi04)
   LET g_ccc_excel[g_cnt].qmje = cl_digcut(g_ccc_excel[g_cnt].qmje,l_azi04)
   # add by lixwz 20171011 e
   IF g_cnt > g_max_rec THEN  # modify by lixwz 171011  g_rec_b -> g_cnt
      CALL cl_err_msg(NULL,"axc-131",g_rec_b||"|"||g_max_rec,10)
      LET g_cnt = g_max_rec
   END IF
   DISPLAY g_cnt TO FORMONLY.cnt
END FUNCTION

#中文的MENU
FUNCTION q461_menu()
DEFINE g_cmd  STRING
DEFINE l_sql  STRING
   WHILE TRUE
      CALL q461_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL q461_q()
            END IF

            #add by renjj 160518--str
           WHEN "aimp620"
            IF cl_chk_act_auth() THEN
               LET l_ac = ARR_CURR()
              IF l_ac != 0 THEN
                IF NOT cl_null(g_ccc[l_ac].ima01) THEN
                  LET l_sql='ima01 = "',g_ccc[l_ac].ima01, '"'
                  LET g_cmd="aimp620 '",l_sql CLIPPED,"' '' '' 'N' '' 'N' 'N'"
                  CALL cl_cmdrun_wait(g_cmd)
                ELSE
                  CALL cl_err('','ggl-943',1)
                END IF
              END IF
            END IF
            #add by renjj 160518--end

         WHEN "help"
            CALL cl_show_help()
            LET g_action_choice = " "  #FUN-C80102
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
            LET g_action_choice = " "  #FUN-C80102
         WHEN "exporttoexcel"
             #LET w = ui.Window.getCurrent()
             #LET f = w.getForm()
             IF cl_chk_act_auth() THEN
                CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_ccc_excel),'','')
             END IF
            LET g_action_choice = " "  #FUN-C80102
         WHEN "related_document"  #相關文件
            IF cl_chk_act_auth() THEN
               LET g_doc.column1 = "ima01"
               LET g_doc.value1 = ''
               CALL cl_doc()
            END IF
            LET g_action_choice = " "
      END CASE
   END WHILE
END FUNCTION

FUNCTION q461_q()
    MESSAGE ""
    CALL cl_opmsg('q')
    CALL ui.interface.refresh()
    CALL g_ccc.clear()
    CALL g_ccc_excel.clear()
    LET g_action_choice = " "
    CALL q461_cs()


END FUNCTION

FUNCTION q461_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-690028 VARCHAR(1)

   IF p_ud <> "G" THEN
      RETURN
   END IF

   LET g_action_choice = " "
   LET g_flag = ' '

   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY BY NAME tm.by,tm.bm,tm.ey,tm.em

      DISPLAY ARRAY g_ccc TO s_ccc.* ATTRIBUTE(COUNT=g_rec_b)
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL cl_show_fld_cont()

      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

       #add by renjj 160518--str
       ON ACTION aimp620
         LET g_action_choice="aimp620"
         EXIT DISPLAY
       #add by renjj 160518--end

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         EXIT DISPLAY

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION controlg
         LET g_action_choice="controlg"
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

   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

{
FUNCTION q461_detail_fill(p_ac)
DEFINE p_ac   LIKE type_file.num5
DEFINE l_tot11   LIKE ccc_file.ccc31
DEFINE l_tot21   LIKE ccc_file.ccc31
DEFINE l_tot31   LIKE ccc_file.ccc31
DEFINE l_tot41   LIKE ccc_file.ccc31
DEFINE l_tot51   LIKE ccc_file.ccc31
DEFINE l_tot61   LIKE ccc_file.ccc31
DEFINE l_tot71   LIKE ccc_file.ccc31
DEFINE l_tot81   LIKE ccc_file.ccc31
DEFINE l_tot91   LIKE ccc_file.ccc31
DEFINE l_yymm    STRING
DEFINE l_yy      STRING
DEFINE l_mm1     STRING
DEFINE l_mm2     STRING

   LET l_tot11 = 0
   LET l_tot21 = 0
   LET l_tot31 = 0
   LET l_tot41 = 0
   LET l_tot51 = 0
   LET l_tot61 = 0
   LET l_tot71 = 0
   LET l_tot81 = 0
   LET l_tot91 = 0

   CASE tm.a
     WHEN "1"
        LET g_sql = "SELECT * FROM axcq461_tmp ",
                    " WHERE ima01 = '",g_ccc_1[p_ac].ima01_1,"' ",
                    " ORDER BY ima01 "
        PREPARE axcq461_pb_detail1 FROM g_sql
        DECLARE ccc_curs_detail1  CURSOR FOR axcq461_pb_detail1        #CURSOR
        CALL g_ccc.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH ccc_curs_detail1 INTO g_ccc[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN "2"
        LET g_sql = "SELECT * FROM axcq461_tmp ",
                    " WHERE azf01 = '",g_ccc_1[p_ac].azf01_1,"' ",
                    " ORDER BY azf01 "
        PREPARE axcq461_pb_detail2 FROM g_sql
        DECLARE ccc_curs_detail2  CURSOR FOR axcq461_pb_detail2        #CURSOR
        CALL g_ccc.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH ccc_curs_detail2 INTO g_ccc[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN "3"

           LET g_sql = "SELECT * FROM axcq461_tmp ",
                       " WHERE ima39 = '",g_ccc_1[p_ac].ima39_1,"' ",
                       " ORDER BY ima39 "

           PREPARE axcq461_pb_detail3 FROM g_sql
           DECLARE ccc_curs_detail3  CURSOR FOR axcq461_pb_detail3        #CURSOR

        CALL g_ccc.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH ccc_curs_detail3 INTO g_ccc[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET g_cnt = g_cnt + 1
        END FOREACH
   END CASE

   CALL g_ccc.deleteElement(g_cnt)
   LET g_rec_b = g_cnt -1
   DISPLAY g_rec_b TO FORMONLY.cnt
END FUNCTION
}
