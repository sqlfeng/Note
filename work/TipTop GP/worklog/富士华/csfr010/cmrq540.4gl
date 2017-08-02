################################################################################
# Prog. Version..: '1.20.02-06.02.06(00002)'     #
# Pattern name...: cmrq540.4gl
# Descriptions...: MRP 供需明細查詢
# Date & Author..: 96/05/06 By Roger
# Modify.........: No:MOD-480592 04/08/31 By Carol mss11/mss09 field 對調 
# Modify.........: NO:MOD-490217 04/09/10 by yiting 料號欄位放大
# Modify.........: No:FUN-4B0013 04/11/08 By ching add '轉Excel檔' action
# Modify.........: No:MOD-4C0087 04/12/16 By DAY  加入用"*"關閉窗口,單身翻頁顯示錯誤更正
# Modify.........: 06/07/18 Cust By Dsc.Penny
# Modify.........: 060831 By DSC.Al 修正sql, 取最大日期
# Modify.........: 060927 By DSC.Al 修正sql(060906 Nicole)
# Modify.........: 061211 By Vicky 第二次查詢時，自動帶出前次查詢版本
# 070523 Jane    : 追加顯示"即時供料註記碼" jit_code
# 070608 Joan    : 增加"安全庫存量"欄位
# add by Derrick 111018 增加預測量為需求 mst05=39 
################################################################################

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE
     g_argv1		CHAR(02),	# 版本
     g_argv2		LIKE mss_file.mss01,	# 料號 NO:MOD-490217
     g_argv3		CHAR(20),	# 廠牌
     g_mss		RECORD 
                        mss_v     LIKE mss_file.mss_v,
                        mss01     LIKE mss_file.mss01,
                        mss02     LIKE mss_file.mss02,
                        mss051    LIKE mss_file.mss051,
                        qty_5     LIKE ima_file.ima262,  #Dsc.Penny 060809
                        ima27     LIKE ima_file.ima27,   # 070608  Joan
                        ima54     LIKE ima_file.ima54,
                        ima50     LIKE ima_file.ima50,    
                        ima48     LIKE ima_file.ima48,
                        ima49     LIKE ima_file.ima49,
                        ima491    LIKE ima_file.ima491
                        END RECORD,
     g_mss_rowid        INTEGER,  #MOD-4C0087
     g_wc               CHAR(600),
     g_sql              CHAR(1000),
     g_mst  DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
            mss00    LIKE mss_file.mss00, #Dsc.Penny 060718
			mst04  	 LIKE mst_file.mst04,
			mst05  	 LIKE mst_file.mst05,
			t5_name  CHAR(10),
            src_no   LIKE pmm_file.pmm01, #Charley
            src_num  LIKE sfb_file.sfb221,#Dsc.Penny 060811
            cus_no   LIKE pmc_file.pmc03, #Charley
			mst06  	 LIKE mst_file.mst06,
			mst061 	 LIKE mst_file.mst061,
			mst06_fz LIKE mst_file.mst06_fz,
			mst07  	 LIKE mst_file.mst07,
			mst08  	 LIKE mst_file.mst08,
            mst08n   LIKE mst_file.mst08,
            mss08    lIKE mss_file.mss08,
            jit_code CHAR(1)
            END RECORD,
    g_buf           CHAR(78),              #
    l_ima25 like ima_file.ima25,
    g_rec_b         SMALLINT,              #單身筆數
    l_ac            SMALLINT,              #目前處理的ARRAY CNT
    l_sl            SMALLINT,               #目前處理的SCREEN LINE
    g_mss_v_first   LIKE mss_file.mss_v  #061211 by Vicky 紀錄第一次查詢版本

DEFINE   g_cnt           INTEGER   
DEFINE   g_msg           CHAR(72)
DEFINE   g_row_count    INTEGER
DEFINE   g_curs_index   INTEGER
DEFINE   g_jump         INTEGER
DEFINE   mi_no_ask       SMALLINT

MAIN
    DEFINE l_time          CHAR(8)
    DEFINE p_row,p_col     SMALLINT

    OPTIONS
        FORM LINE     FIRST + 2,
        MESSAGE LINE  LAST,
        PROMPT LINE   LAST,
        INPUT NO WRAP
    DEFER INTERRUPT

   IF (NOT cl_user()) THEN                                             
      EXIT PROGRAM                                                              
   END IF                                                                       
                                                                                
   WHENEVER ERROR CALL cl_err_msg_log                                           
                                                                                
   IF (NOT cl_setup("CMR")) THEN                                                
      EXIT PROGRAM                                                              
   END IF                                                                       

      CALL cl_used(g_prog,l_time,1)       #計算使用時間 (進入時間)              #No:MOD-580088  HCN 20050818
        RETURNING l_time                 

    LET g_argv1 = ARG_VAL(1)
    LET g_argv2 = ARG_VAL(2)
    LET g_argv3 = ARG_VAL(3)

    INITIALIZE g_mss.* TO NULL
    LET p_row = 2 LET p_col = 2 

    OPEN WINDOW q540_w AT p_row,p_col
         WITH FORM "cmr/42f/cmrq540" ATTRIBUTE (STYLE = g_win_style)
    
    CALL cl_ui_init()

    IF NOT cl_null(g_argv1) THEN CALL q540_q() END IF
    CALL q540_menu()
    CLOSE WINDOW q540_w
    CALL cl_used(g_prog,l_time,2) RETURNING l_time #No:MOD-580088  HCN 20050818
END MAIN

FUNCTION q540_cs()
    CLEAR FORM
   CALL g_mst.clear()
    IF cl_null(g_argv1) THEN
       CONSTRUCT BY NAME g_wc ON
              mss_v, mss01, mss02,mss051 
             #ima54, ima50, ima48, ima49, ima491
      
      #061211 by Vicky - begin       
      BEFORE CONSTRUCT
         IF NOT cl_null(g_mss_v_first) THEN
            DISPLAY g_mss_v_first TO mss_v
         END IF
      #061211 by Vicky - end
            
      ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
       
       END CONSTRUCT
     ELSE
       LET g_wc="mss_v='",g_argv1,"'"
       IF NOT cl_null(g_argv2) THEN
          LET g_wc=g_wc CLIPPED, " AND mss01='",g_argv2,"'"
       END IF
       IF NOT cl_null(g_argv3) THEN
          LET g_wc=g_wc CLIPPED, " AND mss02='",g_argv3,"'"
       END IF
    END IF
    IF INT_FLAG THEN RETURN END IF
    LET g_sql="SELECT mss_v,mss01,mss02,mss051,0, ",
              " ima27,ima54,ima50,ima48,ima49,ima491 ",
              " FROM mss_file a,ima_file ",
              " WHERE ",g_wc CLIPPED,
              "   AND mss01 = ima01 ",
              "   AND mss03 IN (SELECT MIN(mss03) FROM mss_file b ",
              "                  WHERE a.mss_v = b.mss_v AND a.mss01 = b.mss01 ",
              "                     AND ",g_wc CLIPPED,
              "                   GROUP BY mss01,mss02,mss_v )",
              " ORDER BY mss_v,mss01,mss02 "
    PREPARE q540_prepare FROM g_sql                # RUNTIME 編譯
    DECLARE q540_cs SCROLL CURSOR WITH HOLD FOR q540_prepare
    LET g_sql= "SELECT COUNT(*) FROM mss_file a ",
               " WHERE ",g_wc CLIPPED ,
              "   AND mss03 IN (SELECT MIN(mss03) FROM mss_file b ",   
              "                  WHERE a.mss_v = b.mss_v AND a.mss01 = b.mss01 ",
              "                    AND  ",g_wc CLIPPED,
              "                   GROUP BY mss01,mss02,mss_v )"
    PREPARE q540_precount FROM g_sql
    DECLARE q540_count CURSOR FOR q540_precount
END FUNCTION

FUNCTION q540_menu()

   WHILE TRUE
      CALL q540_bp("G")
      CASE g_action_choice
         WHEN "query"
            CALL q540_q() 
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()

         WHEN "exporttoexcel"
             IF cl_chk_act_auth() THEN
                CALL cl_export_to_excel
                (ui.Interface.getRootNode(),base.TypeInfo.create(g_mst),'','')
             END IF

       #@WHEN "工廠切換"
         WHEN "switch_plant"
            CALL q540_d()
      END CASE
   END WHILE
      CLOSE q540_cs
END FUNCTION

FUNCTION q540_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
   CALL cl_opmsg('q')
   MESSAGE ""
   DISPLAY '   ' TO FORMONLY.cnt
   CALL q540_cs()                          # 宣告 SCROLL CURSOR
   IF INT_FLAG THEN LET INT_FLAG = 0 CLEAR FORM RETURN END IF
   CALL g_mst.clear()
   MESSAGE " SEARCHING ! " 
   OPEN q540_count
   FETCH q540_count INTO g_row_count
   DISPLAY g_row_count TO FORMONLY.cnt
   OPEN q540_cs                            # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_mss.mss01,SQLCA.sqlcode,0)
       INITIALIZE g_mss.* TO NULL
   ELSE
       CALL q540_fetch('F')                # 讀出TEMP第一筆並顯示
   END IF

END FUNCTION

FUNCTION q540_fetch(p_flmss)
    DEFINE
        p_flmss          CHAR(1),
        l_abso          INTEGER

    CASE p_flmss
        WHEN 'N' FETCH NEXT     q540_cs INTO g_mss.*
        WHEN 'P' FETCH PREVIOUS q540_cs INTO g_mss.*
        WHEN 'F' FETCH FIRST    q540_cs INTO g_mss.*
        WHEN 'L' FETCH LAST     q540_cs INTO g_mss.*
        WHEN '/'
            IF (NOT mi_no_ask) THEN
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt mod
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
            FETCH ABSOLUTE g_jump q540_cs INTO g_mss.*
            LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN
        CALL cl_err(g_mss.mss01,SQLCA.sqlcode,0)
        RETURN
    ELSE
       CASE p_flmss
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
    
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF

    LET g_mss_v_first = g_mss.mss_v  #061211 by Vicky

    CALL q540_show()                      # 重新顯示
END FUNCTION

FUNCTION q540_show()
    DEFINE l_ima	RECORD LIKE ima_file.*
    DEFINE l_pmc	RECORD LIKE pmc_file.*
    DISPLAY BY NAME
              g_mss.mss_v, g_mss.mss01, g_mss.mss02,  
              g_mss.mss051,g_mss.ima27,
              g_mss.ima54,g_mss.ima50,g_mss.ima48,
              g_mss.ima49,g_mss.ima491
    INITIALIZE l_ima.* TO NULL
    SELECT * INTO l_ima.* FROM ima_file WHERE ima01=g_mss.mss01
    DISPLAY BY NAME l_ima.ima02
    INITIALIZE l_pmc.* TO NULL
    SELECT * INTO l_pmc.* FROM pmc_file WHERE pmc01=g_mss.mss02
    DISPLAY BY NAME l_pmc.pmc03
 #Dsc.Penny 060809 計算IQC在驗量
    SELECT SUM((rvb07-rvb29-rvb30)*pmn09) INTO g_mss.qty_5
      FROM rvb_file, rva_file, pmn_file
     WHERE rvb05 = g_mss.mss01 AND rvb01=rva01
       AND rvb04 = pmn01 AND rvb03 = pmn02
       AND rvb07 > (rvb29+rvb30)
       AND rvaconf='Y' #No.BANN
       AND rva10 !='SUB' #FUN-5B0069 將MARK拿掉
   DISPLAY BY NAME g_mss.qty_5
    CALL q540_b_fill(' 1=1')
    CALL q540_b_tot('d')
END FUNCTION

FUNCTION q540_out(p_cmd)
   DEFINE p_cmd		    CHAR(1),
          l_cmd		    CHAR(400),
          l_wc          CHAR(200)

   CALL cl_wait()
   IF p_cmd= 'a'
      THEN LET l_wc = 'mss01="',g_mss.mss01,'"' 		# ""新增""則印單張"
      ELSE LET l_wc = g_wc                     			# 其他則印多張
   END IF
   IF g_wc IS NULL THEN 
       CALL cl_err('','9057',0) RETURN END IF
   LET l_cmd = "amrr510",
               " '",g_today CLIPPED,"' ''",
               " '",g_lang CLIPPED,"' 'Y' '' '1' '",
               l_wc CLIPPED
   CALL cl_cmdrun(l_cmd)
   ERROR ' '
END FUNCTION

FUNCTION q540_d()
   DEFINE l_plant,l_dbs	CHAR(21)

            LET INT_FLAG = 0  ######add for prompt mod
   PROMPT 'PLANT CODE:' FOR l_plant
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
   
   END PROMPT
   IF l_plant IS NULL THEN RETURN END IF
   SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01 = l_plant
   IF STATUS THEN ERROR 'WRONG database!' RETURN END IF
   DATABASE l_dbs
   IF STATUS THEN ERROR 'open database error!' RETURN END IF
   LET g_plant = l_plant
   LET g_dbs   = l_dbs
END FUNCTION

FUNCTION q540_b_tot(p_cmd)
   DEFINE p_cmd		CHAR(1)
END FUNCTION

FUNCTION q540_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           CHAR(200)
DEFINE last_qty        INTEGER
DEFINE qty1,qty2,bal   LIKE mst_file.mst08
DEFINE g_mss08         LIKE mss_file.mss08
DEFINE l_sfb02         LIKE sfb_file.sfb02   #Dsc.Penny 060811
DEFINE l_flag          LIKE type_file.chr1

    LET g_mss08 = 0
    LET g_sql =
        "SELECT mss00,mst04,mst05, '','','','',mst06,mst061,mst06_fz,mst07,mst08,0,mss08 ",
        " FROM mst_file,mss_file",
        " WHERE mst_v ='",g_mss.mss_v,"'",
        "   AND mst_v = mss_v ",
        "   AND mst01 = mss01 ",
        "   AND mst02 = mss02 ",
        "   AND mst03 = mss03 ",
      #  #add by zl 170104  begin    #不显示51类型  #有问题MARK by zl 170206
      #  "   AND mst05 <> '51' ",    
      #  #add by zl 170104  end 
        "   AND mst01 ='",g_mss.mss01,"' AND mst02 ='",g_mss.mss02,"'",
        " ORDER BY mss00,mst04,mst05 DESC,mst06 " #MOD-4C0087
    PREPARE q540_pb FROM g_sql
    DECLARE mss_curs CURSOR FOR q540_pb

    FOR g_cnt = 1 TO g_mst.getLength()           #單身 ARRAY 乾洗
       INITIALIZE g_mst[g_cnt].* TO NULL
    END FOR
    LET g_rec_b = 0
    LET g_cnt = 1
   # LET l_flag = 'N'
    FOREACH mss_curs INTO g_mst[g_cnt].*   #單身 ARRAY 填充
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        IF g_cnt>1 OR l_flag = 'Y' THEN
           LET g_mst[g_cnt].mss08 = g_mss08
        END IF

        LET qty1 = 0
        LET qty2 = 0
        #IF g_mst[g_cnt].mst05 MATCHES '4*' THEN
        IF g_mst[g_cnt].mst05 MATCHES '4*' OR  g_mst[g_cnt].mst05 ='39' THEN
           LET qty1 = g_mst[g_cnt].mst08
           LET qty2 = 0
           LET g_mst[g_cnt].mst08  = g_mst[g_cnt].mst08 * -1
           LET g_mst[g_cnt].mst08n = 0
           IF g_cnt=1 THEN
              LET g_mst[g_cnt].mss08=g_mst[g_cnt].mst08
           END IF
        ELSE
           LET qty2 = g_mst[g_cnt].mst08
           LET qty1 = 0
           LET g_mst[g_cnt].mst08n = g_mst[g_cnt].mst08 
           LET g_mst[g_cnt].mst08  = 0
           IF g_cnt=1 THEN
              LET g_mst[g_cnt].mss08=g_mst[g_cnt].mst08n
           END IF
        END IF
        IF g_mst[g_cnt].mst05 = '44' OR
           g_mst[g_cnt].mst05 = '45' OR
           g_mst[g_cnt].mst05 = '64' THEN
           LET g_mst[g_cnt].src_no = NULL
           SELECT sfb22,sfb221,sfb02
             INTO g_mst[g_cnt].src_no,g_mst[g_cnt].src_num,l_sfb02
             FROM sfb_file
             WHERE sfb01 = g_mst[g_cnt].mst06
           IF l_sfb02 = '7' THEN
              SELECT MAX(pmn01) INTO g_mst[g_cnt].src_no FROM pmn_file
                 WHERE pmn41 = g_mst[g_cnt].mst06
              IF NOT cl_null(g_mst[g_cnt].src_no) THEN
                 SELECT MAX(pmn02) INTO g_mst[g_cnt].src_num FROM pmn_file
                    WHERE pmn01 = g_mst[g_cnt].src_no
                    AND pmn41 = g_mst[g_cnt].mst06
                 SELECT pmm09 INTO g_mst[g_cnt].cus_no FROM pmm_file
                  WHERE pmm01 = g_mst[g_cnt].src_no
              END IF
           ELSE
              IF NOT cl_null(g_mst[g_cnt].src_no) THEN
                 LET g_mst[g_cnt].cus_no = NULL
                 SELECT occ02 INTO g_mst[g_cnt].cus_no FROM oea_file,occ_file    #mod by mengyye 120216
                    WHERE oea01 = g_mst[g_cnt].src_no
                      AND occ01=oea04    #add by mengyye 120216
              END IF
           END IF  
           SELECT * FROM sfa_file,sfb_file  ##070523 Jane
              WHERE sfa01 = sfb01
              AND sfa01 = g_mst[g_cnt].mst06
              AND sfb95 = 'Y'
              AND sfa30 = 'JIT'
              AND sfa03 = g_mss.mss01
           IF STATUS != NOTFOUND THEN
              LET g_mst[g_cnt].jit_code = '*'
           ELSE
              LET g_mst[g_cnt].jit_code = NULL
           END IF
        END IF
        IF g_mst[g_cnt].mst05 = '42' THEN
           LET g_mst[g_cnt].cus_no = NULL
           SELECT occ02 INTO g_mst[g_cnt].cus_no FROM oea_file,occ_file    #mod by mengyye 120220
            WHERE oea01 = g_mst[g_cnt].mst06
             AND occ01=oea04    #add by mengyye 120220
        END IF
        IF g_mst[g_cnt].mst05 = '62' OR
           g_mst[g_cnt].mst05 = '63' THEN
           LET g_mst[g_cnt].cus_no = NULL
           SELECT pmc03 INTO g_mst[g_cnt].cus_no FROM pmm_file,pmc_file
              WHERE pmm09=pmc01
              AND pmm01 = g_mst[g_cnt].mst06
           SELECT * FROM pmm_file,sfa_file,sfb_file  ##070523 Jane
              WHERE pmm01 = g_mst[g_cnt].mst06
              AND pmm05 = sfb01
              AND sfa01 = sfb01
              AND sfb95 = 'Y'
              AND sfa30 = 'JIT'
              AND sfa03 = g_mss.mss01
           IF STATUS != NOTFOUND THEN
              LET g_mst[g_cnt].jit_code = '*'
           ELSE
              LET g_mst[g_cnt].jit_code = NULL
           END IF
        END IF
        IF g_mst[g_cnt].mst05 = '61' THEN  ##070523 Jane
           SELECT * FROM pmk_file,sfa_file,sfb_file
              WHERE pmk01 = g_mst[g_cnt].mst06
              AND pmk05 = sfb01
              AND sfa01 = sfb01
              AND sfb95 = 'Y'
              AND sfa30 = 'JIT'
              AND sfa03 = g_mss.mss01
           IF STATUS != NOTFOUND THEN
              LET g_mst[g_cnt].jit_code = '*'
           ELSE
              LET g_mst[g_cnt].jit_code = NULL
           END IF
        END IF
        IF g_cnt>1 THEN
           LET g_mst[g_cnt].mss08 = g_mst[g_cnt].mss08 - qty1 +qty2
        END IF
        LET g_mss08 = g_mst[g_cnt].mss08
        LET g_mst[g_cnt].t5_name=s_mst05(g_lang,g_mst[g_cnt].mst05)
     #   IF g_mst[g_cnt].mst05 = '51' THEN
     #      LET l_flag = 'Y'
     #      INITIALIZE g_mst[g_cnt].* TO NULL
     #      LET g_cnt = g_cnt - 1
     #   END IF
        LET g_cnt = g_cnt + 1
        # genero shell add g_max_rec check START
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
        # genero shell add g_max_rec check END
    END FOREACH
    CALL g_mst.deleteELEMENT(g_cnt)
    IF STATUS THEN CALL cl_err('foreach:',STATUS,1) END IF
    LET g_rec_b=(g_cnt-1)
    DISPLAY g_rec_b TO FORMONLY.cn2
    LET g_cnt = 0
END FUNCTION

FUNCTION q540_bp(p_ud)
   DEFINE   p_ud   CHAR(1)


   IF p_ud <> "G" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
    DISPLAY ARRAY g_mst TO s_mst.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED) #MOD-520097

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )

      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION first 
         CALL q540_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
          EXIT DISPLAY  #MOD-4C0087                              

      ON ACTION previous
         CALL q540_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
          EXIT DISPLAY  #MOD-4C0087                              
                              

      ON ACTION jump 
         CALL q540_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
          EXIT DISPLAY  #MOD-4C0087                              
                              

      ON ACTION next
         CALL q540_fetch('N') 
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
          EXIT DISPLAY  #MOD-4C0087                              
                              

      ON ACTION last 
         CALL q540_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
          EXIT DISPLAY  #MOD-4C0087                              
                              

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 #MOD-4C0087--begin
   ON ACTION cancel
      LET INT_FLAG=FALSE 		#MOD-570244	mars
      LET g_action_choice="exit"
      EXIT DISPLAY
 #MOD-4C0087--end

      ON ACTION controlg 
         LET g_action_choice="controlg"
         EXIT DISPLAY
    #@ON ACTION 工廠切換
      ON ACTION switch_plant
         LET g_action_choice="switch_plant"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 

      #FUN-4B0013
      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
      #--
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION
FUNCTION q540_bp_refresh()
   DISPLAY ARRAY g_mst TO s_mst.*
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

