# Prog. Version..: '5.10.03-08.08.20(00009)'     #
# Pattern name...: cimp003.4gl
# Descriptions...: 簽核人員
# Date & Author..: 16/11/10 zhengq
# 定时执行数据更新

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"	

DEFINE g_head  RECORD 
  jhjc_check   LIKE type_file.chr1,  #计划叫车
  hdp_check   LIKE type_file.chr1,    #活动品更新
  mq_cpxx     LIKE type_file.chr1,     #名气产品气源渠道信息更新
  crm_pj_jx   LIKE type_file.chr1,
  need_stok_notice LIKE type_file.chr1  #是否通知
END RECORD

DEFINE g_forupd_sql,g_sql    STRING
DEFINE g_before_input_done   LIKE type_file.num5          #判斷是否已執行 Before Input指令
DEFINE g_chr                 VARCHAR(1)
DEFINE g_cnt,l_ac            LIKE type_file.num10
DEFINE g_i                   LIKE type_file.num5 
DEFINE g_msg                 LIKE type_file.chr1000 
DEFINE g_curs_index          LIKE type_file.num10  
DEFINE g_row_count           LIKE type_file.num10         #總筆數  
DEFINE g_jump                LIKE type_file.num10         #查詢指定的筆數
DEFINE mi_no_ask             LIKE type_file.num5          #是否開啟指定筆視窗 
DEFINE g_posdbs              LIKE type_file.chr10 
DEFINE g_auto_storage_cost   LIKE imn_file.imn15   #成本仓库
DEFINE g_auto_storage_uncost LIKE imn_file.imn15   #非成本仓库
DEFINE g_date                LIKE type_file.chr10                                                       

DEFINE g_argv1     LIKE type_file.chr1
DEFINE g_argv2     LIKE type_file.chr2
DEFINE g_argv3     LIKE type_file.chr3
DEFINE g_argv4     LIKE type_file.chr4
DEFINE g_argv5     LIKE type_file.chr5
DEFINE g_argv6     LIKE type_file.chr6
DEFINE g_argv7     LIKE type_file.chr7
DEFINE g_having    LIKE type_file.num5
DEFINE g_in_work   LIKE type_file.chr1         #add by leo 130320
DEFINE am_msg,am_status,am_result STRING 
                                                        
MAIN
    OPTIONS
        FORM LINE     FIRST + 2,               #畫面開始的位置
        MESSAGE LINE  LAST,                    #訊息顯示的位置
        PROMPT LINE   LAST,                    #提示訊息的位置
        INPUT NO WRAP                          #輸入的方式: 不打轉
    DEFER INTERRUPT                            #擷取中斷鍵

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("CIM")) THEN
      EXIT PROGRAM
   END IF

   CALL  cl_used(g_prog,g_time,1) RETURNING g_time
   LET g_bgjob=ARG_VAL(1)
   LET g_argv2=ARG_VAL(2)   
   LET g_argv3=ARG_VAL(3)
   LET g_argv4=ARG_VAL(4)   
   LET g_argv5=ARG_VAL(5)   
   LET g_argv6=ARG_VAL(6)   
   LET g_argv7=ARG_VAL(7) 
	 INITIALIZE g_head.* TO NULL   
	 
   LET g_date = g_today USING "YYYYMMDD" 
   
   IF g_bgjob = 'Y' THEN
	   LET g_head.jhjc_check = g_argv2
	   LET g_head.hdp_check = g_argv3
	   LET g_head.mq_cpxx = g_argv4
	   LET g_head.crm_pj_jx = g_argv5
	   LET g_head.need_stok_notice = g_argv6
	   #直接运行更新函数
	   CALL autoUpdate()
   ELSE
	   OPEN WINDOW p001_w  WITH FORM "cim/42f/cimp003"
	       ATTRIBUTE (STYLE = g_win_style CLIPPED)
	   CALL cl_ui_init()
	   LET g_action_choice = ""
	   #初始化全局变量
	   LET g_head.jhjc_check = 'N'
	   LET g_head.hdp_check = 'N'
	   LET g_head.mq_cpxx = 'N'
	   LET g_head.crm_pj_jx = 'N'
	   LET g_head.need_stok_notice = 'N'
	   CALL p001_menu()
	   CLOSE WINDOW p001_w
	 END IF
   CALL  cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION p001_menu()
   DEFINE l_cmd  LIKE type_file.chr1000 
    MENU ""
        BEFORE MENU
           CALL cl_navigator_setting(g_curs_index, g_row_count)

        ON ACTION modify
             CALL p001_i()

        ON ACTION  download_up
             IF cl_sure(18,20) THEN 
             		CALL autoUpdate() 
             END IF 
        ON ACTION close   
            LET INT_FLAG=FALSE 
            EXIT MENU
    
        ON ACTION help
           CALL cl_show_help()
        ON ACTION exit
           EXIT MENU
        ON ACTION controlg
           CALL cl_cmdask()
        ON ACTION locale
           CALL cl_dynamic_locale()
           CALL cl_show_fld_cont()
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE MENU
    END MENU
END FUNCTION

{负责从界面构造g_head}
FUNCTION p001_i()
   DEFINE   p_cmd     LIKE type_file.chr1,
            l_n       LIKE type_file.num5

   LET g_head.jhjc_check = 'N'
   LET g_head.hdp_check = 'N'
   LET g_head.mq_cpxx = 'N'
   LET g_head.crm_pj_jx = 'N'
   LET g_head.need_stok_notice = 'N'
      
   DISPLAY BY NAME
   g_head.jhjc_check,g_head.hdp_check,g_head.mq_cpxx,g_head.crm_pj_jx,g_head.need_stok_notice
  
   INPUT BY NAME
     g_head.jhjc_check,g_head.hdp_check,g_head.mq_cpxx,g_head.crm_pj_jx,g_head.need_stok_notice
      WITHOUT DEFAULTS

      BEFORE INPUT
 
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLG
         CALL cl_cmdask()

      ON ACTION CONTROLF                        # 欄位說明
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
END FUNCTION

{
	desc:自动执行的核心函数，
	1.根据参数判断对应的功能是否执行
	2.g_msg在对应的子函数中进行设置
	3.将g_msg保存到日志表中
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION autoUpdate()

		INITIALIZE g_msg to null
		
		#ima1022体积为空的数据，进行更新，强制更新
    CALL ima_vol_atuoUpdate()
    
    #自动清理WCG_file.PDM-->ERP的错误日志记录
    CALL wcg_atuo_delete()
		
		#计划叫车单更新到imm上面
		IF g_head.jhjc_check="Y" THEN
				CALL jhjcUpdateSjcx()
		END IF
		
		#零售赠品三个月的数据自动结案	
		IF g_head.hdp_check="Y" THEN
				CALL hdpAutonOver()
		END IF
			
	  #名气产品气源信息自动从老板电器中更新	
		IF g_head.mq_cpxx="Y" THEN
				CALL mq_productInfo_atuoUpdate()
		END IF
			
		#OA_ERP 料号名称规格更新
	  CALL oa_erp_ima_upd()
		
		IF g_head.crm_pj_jx="Y" THEN
	  	CALL fw_pj_jx()
	  END IF
	  
	  IF g_head.need_stok_notice='Y' THEN
	  	CALL stok_notice()
	  END IF
		
		#记录日志
	  CALL p001_show()
END FUNCTION


{
	desc:记录日志，并根据是否前台执行，将执行消息显示到界面上面
	1.删除1个月前的日志信息
	2.保存日志信息到tc_msg_file
	3.判断是否显示日志到前台
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION p001_show()
    
    #只保留一个月的日志数据
    DELETE FROM tc_msg_file WHERE tc_msg03<=sysdate-30
    
    #消息为空，设置为ok
    IF cl_null(g_msg) THEN
    	LET g_msg="ok"
    END IF
    
    #IF g_bgjob = 'Y',意为后台自动运行，不用提示消息
	  IF g_bgjob = 'Y' THEN
	    CALL p100_insert_msg(g_msg)
	  ELSE
	  	LET g_msg =g_msg,'手工'
	  	#前台执行，除了记录日志外，还需要显示到前台
	  	CALL p100_insert_msg(g_msg)
		  CALL s_errmsg("cimp003",g_msg,"","!",1)
	    CALL s_showmsg()
	  END IF
END FUNCTION 

{
	desc:记录日志，并根据是否前台执行，将执行消息显示到界面上面
	1.删除1个月前的日志信息
	2.保存日志信息到tc_msg_file
	3.判断是否显示日志到前台
	author:zhengq
	date:2016/11/11
	input:
		1：l_msg String，要保存的日志信息
	return:null
}
FUNCTION p100_insert_msg(l_msg)
   DEFINE l_msg    STRING
   DEFINE l_date   LIKE type_file.chr20
   DEFINE l_sql 	 STRING
   
   #实际执行中HH24miss，无效,改为在数据库insert中插入
   #LET l_date = g_today USING "YYYYMMDDHH24miss"

   LET l_sql = "INSERT INTO tc_MSG_file (tc_msg01,tc_msg02,tc_msg03,tc_msg04) ",
   			"values (to_char(sysdate,'YYYYMMDDHH24MISS')||'03','cimp003',sysdate,'",l_msg,"')"

   PREPARE l_msg_ins FROM l_sql
 	 EXECUTE l_msg_ins 
END FUNCTION


{
	@desc:
	cimt528,cimt529,aimt324,aimt3241,aimt301等作业中的车型，
	immud21修改为tc_jhjc14,同时更新单价immud07。
	
	@desc详细说明：
	tc_jhjc_file表为cimi907，cimi908等程序中进行更新，
	记录信息为 物流叫车信息：包含叫车单号、发货地区、车型、运费单价、车牌号等
	实际车型、运费单价为新颜物流所填写；
	
	所修改的数据，为绑定这些叫车信息的排货单； 
	因为，排货时所记录的叫车单为物流填写的信息，与新颜物流实际可能发生出入，
	所以这里编写了一个自动化函数，对以上信息进行自动更新。
	
	
	需要处理4个地方，
	DS05 imm_file
	DS05 INA_FILE
	DS07 imm_file
	DS05 INA_FILE
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION jhjcUpdateSjcx()
 			DEFINE l_sql STRING
      DEFINE l_cnt LIKE type_file.num10
			DEFINE l_jhjc DYNAMIC ARRAY OF RECORD
        imm01      LIKE imm_file.imm01,
        tc_jhjc14  LIKE tc_jhjc_file.tc_jhjc14,
        tc_yfd03   LIKE tc_yfd_file.tc_yfd03
      END RECORD
     
		#1 DS05 IMM_FILE
		#des:单号相同，但是车型不同，并且是10天内的数据，那么进行更新
		LET l_sql="select imm01,tc_jhjc14,tc_yfd03",
			" from imm_file,tc_jhjc_file,tc_yfd_file",
			" where immud24=tc_jhjc01 and immud21<>tc_jhjc14",
			" and tc_jhjc02=tc_yfd01 and tc_jhjc14=tc_yfd04",
			" and tc_jhjc14 is not null and to_date(tc_jhjc08,'yyyy-MM-dd HH24:MI:SS')>=sysdate-10"
		CALL l_jhjc.clear()
    LET l_cnt = 1
		PREPARE i_imm1_pb FROM l_sql
    DECLARE i_imm1_curs CURSOR FOR i_imm1_pb
    FOREACH i_imm1_curs INTO l_jhjc[l_cnt].*   #單身 ARRAY 填充
       UPDATE IMM_FILE 
       	SET immud21=l_jhjc[l_cnt].tc_jhjc14,immud07=l_jhjc[l_cnt].tc_yfd03 WHERE IMM01=l_jhjc[l_cnt].imm01
       LET g_msg = g_msg," \n",l_jhjc[l_cnt].imm01,"-update"
       LET l_cnt=l_cnt+1
    END FOREACH
    CLOSE i_imm1_curs
    CLOSE i_imm1_pb
    CALL l_jhjc.deleteElement(l_cnt)
    LET l_cnt=l_cnt-1
    
   	#DS07 IMM_FILE，说明同上
    LET l_sql="select imm01,tc_jhjc14,tc_yfd03",
			" from ds07.imm_file,tc_jhjc_file,tc_yfd_file",
			" where immud24=tc_jhjc01 and immud21<>tc_jhjc14",
			" and tc_jhjc02=tc_yfd01 and tc_jhjc14=tc_yfd04",
			" and tc_jhjc14 is not null and to_date(tc_jhjc08,'yyyy-MM-dd HH24:MI:SS')>=sysdate-10"
		CALL l_jhjc.clear()
    LET l_cnt = 1
		PREPARE i_imm2_pb FROM l_sql
    DECLARE i_imm2_curs CURSOR FOR i_imm2_pb
    FOREACH i_imm2_curs INTO l_jhjc[l_cnt].*   #單身 ARRAY 填充
       UPDATE DS07.IMM_FILE 
       	SET immud21=l_jhjc[l_cnt].tc_jhjc14,immud07=l_jhjc[l_cnt].tc_yfd03 WHERE IMM01=l_jhjc[l_cnt].imm01
       LET g_msg = g_msg," \n",l_jhjc[l_cnt].imm01,"-update"
       LET l_cnt=l_cnt+1
    END FOREACH
    CLOSE i_imm2_curs
    CLOSE i_imm2_pb
    

    #3.DS05 杂发单 
    LET l_sql="select ina01,tc_jhjc14,tc_yfd03",
			" from ina_file,tc_jhjc_file,tc_yfd_file",
			" where inaud06=tc_jhjc01 and inaud05<>tc_jhjc14",
			" and tc_jhjc02=tc_yfd01 and tc_jhjc14=tc_yfd04",
			" and tc_jhjc14 is not null and to_date(tc_jhjc08,'yyyy-MM-dd HH24:MI:SS')>=sysdate-10"
		CALL l_jhjc.clear()
    LET l_cnt = 1
		PREPARE i_ina1_pb FROM l_sql
    DECLARE i_ina1_curs CURSOR FOR i_ina1_pb
    FOREACH i_ina1_curs INTO l_jhjc[l_cnt].*   #單身 ARRAY 填充
       UPDATE INA_FILE 
       	SET INAUD05=l_jhjc[l_cnt].tc_jhjc14,INAUD07=l_jhjc[l_cnt].tc_yfd03 WHERE INA01=l_jhjc[l_cnt].imm01
       LET g_msg = g_msg," \n",l_jhjc[l_cnt].imm01,"-update"
       LET l_cnt=l_cnt+1
    END FOREACH
    CLOSE i_ina1_curs
    CLOSE i_ina1_pb
    
    #4.DS07 杂发单 
    LET l_sql="select ina01,tc_jhjc14,tc_yfd03",
			" from ds07.ina_file,tc_jhjc_file,tc_yfd_file",
			" where inaud06=tc_jhjc01 and inaud05<>tc_jhjc14",
			" and tc_jhjc02=tc_yfd01 and tc_jhjc14=tc_yfd04",
			" and tc_jhjc14 is not null and to_date(tc_jhjc08,'yyyy-MM-dd HH24:MI:SS')>=sysdate-10"
		CALL l_jhjc.clear()
    LET l_cnt = 1
		PREPARE i_ina2_pb FROM l_sql
    DECLARE i_ina2_curs CURSOR FOR i_ina2_pb
    FOREACH i_ina2_curs INTO l_jhjc[l_cnt].*   #單身 ARRAY 填充
       UPDATE ds07.INA_FILE 
       	SET INAUD05=l_jhjc[l_cnt].tc_jhjc14,INAUD07=l_jhjc[l_cnt].tc_yfd03 WHERE INA01=l_jhjc[l_cnt].imm01
       LET g_msg = g_msg," \n",l_jhjc[l_cnt].imm01,"-update"
       LET l_cnt=l_cnt+1
    END FOREACH
    CLOSE i_ina2_curs
    CLOSE i_ina2_pb
END FUNCTION


{
	desc:3个月以上的零售活动品申请自动结案
	这边处理是有一个小小的bug，判断日期为 年月+28日，这是为了简单处理
	因为每月最小天数为28天
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION hdpAutonOver()
		DEFINE l_sql STRING
  
		LET l_sql = "update tc_jia_file set tc_jia003='4' where tc_jia001 in ",
			"(select tc_jia001 from tc_jia_file",
			" where tc_jia000='6' and tc_jiaud03='cxmt2004' and tc_jia003<>'4'",
			" and to_date(tc_jia006||'-'||tc_jia007||'-28','yyyy-MM-dd')<=sysdate-90)"
	
		PREPARE l_jia_ins FROM l_sql
 	 	EXECUTE l_jia_ins 
 	 	
 	 	IF SQLCA.SQLCODE  THEN
 	 		LET g_msg = g_msg,"tc_jia has err,err no: ",SQLCA.SQLCODE
 	 	ELSE
 	 		LET g_msg = g_msg,"tc_jia has ",SQLCA.SQLERRD[3],"rows atuo over"
 	 	END IF
 	 		
 	 	CLOSE l_jia_ins
END FUNCTION


{
	desc:自动更新名气产品信息库，从tc_mqa_file 更新到DS07的tc_jhg_file中
	该表的信息为：
	料号编码、渠道、气源等
	
	为了简单起见，每次都覆盖式更新，
	一删除全部数据
	二进行更新 
	更新语句如下：
	insert into ds07.tc_jhg_file 
	(tc_jhg001,tc_jhg002,tc_jhg003,tc_jhg004,tc_jhg005,tc_jhg006,tc_jhg007,tc_jhg008,
		tc_jhgacti,tc_jhgmodu,tc_jhgdate)
	select tc_mqa001,tc_mqa002,tc_mqa003,'N','Y','N','N','N','Y',
		'tiptop',sysdate from ds05.tc_mqa_file
		where tc_mqaacti='Y' 
		--and not exists (select 1 from ds07.tc_jhg_file where tc_jhg001=tc_mqa001)
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION mq_productInfo_atuoUpdate()
		DEFINE l_sql STRING
		
		#先删除所有数据，然后再一次性插入
		LET l_sql = "DELETE FROM DS07.tc_jhg_file "
		PREPARE l_jhg_del FROM l_sql
 	 	EXECUTE l_jhg_del
 	 	CLOSE l_jhg_del
 	 	
 	 	#删除后插入 	
 	 	LET l_sql = "insert into ds07.tc_jhg_file ",
 	 		"(tc_jhg001,tc_jhg002,tc_jhg003,tc_jhg004,tc_jhg005,tc_jhg006,tc_jhg007,tc_jhg008,",
 	 		"tc_jhgacti,tc_jhgmodu,tc_jhgdate)",
 	 		" select tc_mqa001,tc_mqa002,tc_mqa003,'N','Y','N','N','N',tc_mqaacti,",
 	 		" 'tiptop',sysdate from ds05.tc_mqa_file"
 	 		
 	  PREPARE l_jhg_ins FROM l_sql
 	 	EXECUTE l_jhg_ins
 	 		
		IF SQLCA.SQLCODE  THEN
 	 		LET g_msg = g_msg,";insert DS07.tc_jhg_file err,no: ",SQLCA.SQLCODE
 	 	ELSE
 	 		LET g_msg = g_msg,";DS07.tc_jhg_files ",SQLCA.SQLERRD[3],"rows insert"
 	 	END IF
 	 		
 	 	CLOSE l_jhg_ins
END FUNCTION


{
	自动计算体积
	跟新ima1022,如果ima1022为空或者为0，且ima1019,ima1020,ima1021都不为空，且不为0的情况下，
	将 ima1022 = ima1019×ima1020×ima1021
	
	更新语句为：
	update ima_file set ima1022=ima1019*ima1020*ima1021
			where (ima1022 is null or ima1022=0)
			and ima1019 is not null and ima1019>0 
			and ima1020 is not null and ima1020>0 
			and ima1021 is not null and ima1021>0
	
	author:zhengq
	date:2016/11/25
	input:null
	return:null
}
FUNCTION ima_vol_atuoUpdate()
		DEFINE l_sql STRING
		DEFINE l_Basesql STRING
		
		#需要更新老板和名气两个数据库，所以将sql语句的公共部分提取出来
		LET l_Basesql = "set ima1022=ima1019*ima1020*ima1021",
			" where (ima1022 is null or ima1022=0)",
			" and ima1019 is not null and ima1019>0",
			" and ima1020 is not null and ima1020>0",
			" and ima1021 is not null and ima1021>0"
		
		#更新老板电器数据库DS05的体积
		LET l_sql = "UPDATE ima_file ",l_Basesql
		PREPARE l_ima_robam_upd FROM l_sql
 	 	EXECUTE l_ima_robam_upd
 	 	CLOSE l_ima_robam_upd
 	 	
		IF SQLCA.SQLCODE  THEN
 	 		LET g_msg = g_msg,";upd ima1022 err,no:",SQLCA.SQLCODE
 	 	ELSE
 	 		LET g_msg = g_msg,";upd ima1022 ",SQLCA.SQLERRD[3],"rows"
 	 	END IF
 	 		
 	 	#更新名气电器数据库DS07的体积
 	 	LET l_sql = "UPDATE ds07.ima_file ",l_Basesql
		PREPARE l_ima_mq_upd FROM l_sql
 	 	EXECUTE l_ima_mq_upd
 	 	CLOSE l_ima_mq_upd
 	 	
 	 	IF SQLCA.SQLCODE  THEN
 	 		LET g_msg = g_msg,";upd ds07.ima1022 err,no:",SQLCA.SQLCODE
 	 	ELSE
 	 		LET g_msg = g_msg,";upd ds07.ima1022 ",SQLCA.SQLERRD[3],"rows"
 	 	END IF
END FUNCTION


{
	WCG_file为PDM-->ERP的错误日志记录
	现在鼎捷的PDM有bug，发生错误后，会持续性的发送信息给ERP
	
	导致WCG_file文件过大，现在每次cimp003执行，都自动将前3天之前的日志删除
	以避免数据量过大。
	
	注：该日志没有什么用处
	
	author:zhengq
	date:2016/11/25
	input:null
	return:null
}
FUNCTION wcg_atuo_delete()
	DEFINE l_sql STRING
	
	LET l_sql="DELETE from wcg_file where wcg02<=sysdate-3"
	PREPARE l_wcg_del FROM l_sql
 	EXECUTE l_wcg_del
 	CLOSE l_wcg_del
END FUNCTION

{
	泛微OA与ERP的接口继承方式，
	因为安全原因，不建议使用直接修改数据的方式，
	所以改为采用中间库对接的方式。
	泛微OA将料号更新信息同步到中间库dsasx的OA_ERP_IMA_UPD表中，
	ERP定时读取这些数据更新到DS05中
}
FUNCTION oa_erp_ima_upd()
			DEFINE l_sql STRING
			DEFINE l_upd STRING
      DEFINE l_cnt LIKE type_file.num10
      DEFINE l_n   LIKE type_file.num10
			DEFINE l_ima DYNAMIC ARRAY OF RECORD
        ima01      LIKE ima_file.ima01,
        tc_ima12   LIKE ima_file.ima02,
        tc_ima13   LIKE ima_file.ima021
      END RECORD
      
     LET l_upd = "UPDATE dsasx.OA_ERP_IMA_UPD SET status=? WHERE tc_ima01=? and status='0'" 
     PREPARE l_ima_upd FROM l_upd
      
		#中间库dsasx的OA_ERP_IMA_UPD表中，
		LET l_sql="select tc_ima01,tc_ima12,tc_ima13 from dsasx.OA_ERP_IMA_UPD where status='0' order by createtime"
		CALL l_ima.clear() 
    LET l_cnt = 1
		PREPARE i_ima_pb FROM l_sql
    DECLARE i_ima_curs CURSOR FOR i_ima_pb
    FOREACH i_ima_curs INTO l_ima[l_cnt].*   #單身 ARRAY 填充
    	SELECT count(*) into l_n FROM ima_file WHERE ima01=l_ima[l_cnt].ima01 and imaacti='Y'
    	IF l_n=1 THEN
    		UPDATE IMA_FILE 
    			SET ima02=l_ima[l_cnt].tc_ima12,ima021=l_ima[l_cnt].tc_ima13 WHERE ima01=l_ima[l_cnt].ima01 and imaacti='Y'
    		EXECUTE l_ima_upd USING  '1',l_ima[l_cnt].ima01	
    	ELSE
    		EXECUTE l_ima_upd USING  '2',l_ima[l_cnt].ima01
    	END IF
      LET l_cnt=l_cnt+1
    END FOREACH
    CLOSE i_ima_curs
    CLOSE i_ima_pb
END FUNCTION

{
	#新建的两个辅助表
	create table robam_ima_f (
		fima01 varchar2(40) primary key
	)
	create table robam_pj_jx (
    xh varchar2(40),
    pj varchar2(40),
    stauts varchar2(1),
    createtime date,
    primary key  (xh,pj)
)

	配件适用机型  robam_ima_f 配件只有一个料号。
	先执行下面语句
	insert into robam_ima_f (fima01)
	select ima01 from ima_file where imaacti='Y' and ima1010='1' and substr(ima01,-1)='F'
	and not exists (select 1 from robam_ima_f f where f.fima01=ima01)
	
	#查询要处理的料号，限制数据：无库存，且料号的更新日期在90天之前
	select ima01 from ima_file,bma_File
	where ima01=bma01 and ima1010='1' and imaacti='Y'
	and substr(ima01,0,1)='1'
	and ( exists (select 1 from img_file where img10>0)
	or imadate>sysdate-90)
	
	#批量执行下面的语句，?处，需要输入1开头的料号，一次批量执行上万次数据
	#限制数据：无库存，且料号的更新日期在90天之前
	insert into erp_pj_jx (xh,pj,status,createtime)
    select distinct bmb01,bmb03||'F','0',sysdate from
    (select  CONNECT_BY_ROOT(bmb01) bmb01,bmb03
     from bma_file,bmb_file,ima_file a,ima_file b
    where bma01=a.ima01 and bma01=bmb01 and bmb03=b.ima01
    and a.imaacti='Y' and b.imaacti='Y'
    and bmaacti='Y'
    START WITH bmb01='?'
    CONNECT BY PRIOR bmb03=bmb01
    ) x
    where exists (select 1 from robam_ima_f)
    and not exists (select 1 from erp_pj_jx p where p.xh=bmb01 and p.pj=bmb03||'F')
    
}
FUNCTION fw_pj_jx()
	  DEFINE l_sql STRING
	  DEFINE l_ima DYNAMIC ARRAY OF RECORD
        ima01      LIKE ima_file.ima01
    END RECORD
    DEFINE l_ima01 LIKE ima_file.ima01
	  DEFINE l_mid_db  LIKE  type_file.chr100
	  
	  LET l_mid_db = 'dsasx'
	###先执行F料号数据
	LET l_sql="insert into ",l_mid_db,".robam_ima_f (fima01)",
		" select ima01 from ima_file where imaacti='Y' and ima1010='1' and substr(ima01,-1)='F'",
		" and not exists (select 1 from ",l_mid_db,".robam_ima_f f where f.fima01=ima01)"
	PREPARE l_f_ins FROM l_sql
	EXECUTE l_f_ins
	 	
	 	#先预编译sql语句
	 	
	 	LET l_sql="insert into ",l_mid_db,".erp_pj_jx (xh,pj,status,createtime)",
		  #" select distinct bmb01,bmb03||'F','0',sysdate from",
		   " select distinct goods_sales_code,bmb03||'F','0',sysdate from",
		   " (select  CONNECT_BY_ROOT(bmb01) bmb01,bmb03",
		   "  from bma_file,bmb_file,ima_file a,ima_file b",
		   " where bma01=a.ima01 and bma01=bmb01 and bmb03=b.ima01",
		   " and a.imaacti='Y' and b.imaacti='Y'",
		   " and bmaacti='Y'",
		   " START WITH bmb01=?",
		   " CONNECT BY PRIOR bmb03=bmb01",
		   " ) x,",l_mid_db,".FX_PDM_MATERIANO_GOODS ",
		   " where exists (select 1 from ",l_mid_db,".robam_ima_f where fima01=bmb03||'F')",
		   " and not exists (select 1 from ",l_mid_db,".erp_pj_jx p where p.xh=bmb01 and p.pj=bmb03||'F')",
                   " and bmb01 = production_materia"
	 	PREPARE l_pj_jx_ins FROM l_sql
	 	
	 	#查询BOM料号
	 	LET l_sql="select ima01 from ima_file,bma_File",
	 			" where ima01=bma01 and ima1010='1' and imaacti='Y'",
	 			" and substr(ima01,0,1)='1'",
	 			" and ( exists (select 1 from img_file where img10>0)",
	 			" or imadate>sysdate-90)"
 		
		PREPARE i_ima_pb_jx FROM l_sql
    DECLARE i_ima_curs_jx CURSOR FOR i_ima_pb_jx
    	
    #批次执行
    FOREACH i_ima_curs_jx INTO l_ima01   #單身 ARRAY 填充
        EXECUTE l_pj_jx_ins USING l_ima01	
    END FOREACH
    CLOSE i_ima_curs_jx
    CLOSE i_ima_pb_jx
END FUNCTION



{
	零售4万台，工程1.5万台，电商3.5万台，外贸0.4万台，名气1万台
	select sum(img10) from img_file,tc_jhg_file,ima_file where img01=tc_jhg001 and img01=ima01 and img02='D1' and ima131='A1'
}
FUNCTION stok_notice()
 		DEFINE l_ls  LIKE type_file.num10
 		DEFINE l_gc  LIKE type_file.num10
 		DEFINE l_ds  LIKE type_file.num10
 		DEFINE l_wm  LIKE type_file.num10
 		DEFINE l_mq  LIKE type_file.num10
 		DEFINE l_sum LIKE type_file.num10
    DEFINE l_mess STRING   #需要通知的消息
    
    #总库存
    SELECT sum(img10) INTO l_sum
    	FROM img_file,ima_file 
    	WHERE img01=ima01 AND img02='D1' AND ima131='A1'
    	
    #零售
    SELECT sum(img10)INTO l_ls
    	 FROM img_file,tc_jhg_file,ima_file 
    	 WHERE img01=tc_jhg001 AND img01=ima01 AND img02='D1' AND ima131='A1' 
    	 AND tc_jhg005='Y'
    	 
    #工程
    SELECT sum(img10)INTO l_gc
    	 FROM img_file,tc_jhg_file,ima_file 
    	 WHERE img01=tc_jhg001 AND img01=ima01 AND img02='D1' AND ima131='A1' 
    	 AND tc_jhg004='Y' AND tc_jhg005<>'Y'
    	 
    #电商
    SELECT sum(img10)INTO l_ds
    	 FROM img_file,tc_jhg_file,ima_file 
    	 WHERE img01=tc_jhg001 AND img01=ima01 AND img02='D1' AND ima131='A1' 
    	 AND tc_jhg006='Y'
   
    #外贸
    SELECT sum(img10)INTO l_wm
    	 FROM img_file,tc_jhg_file,ima_file 
    	 WHERE img01=tc_jhg001 AND img01=ima01 AND img02='D1' AND ima131='A1' 
    	 AND tc_jhg007='Y'
    	 
     #名气
     SELECT sum(img10) INTO l_mq
    	FROM DS07.img_file,DS07.ima_file 
    	WHERE img01=ima01 AND img02='D1' AND ima131='A1'
    
    #LET l_sum=l_sum+l_mq
    	 
    LET l_mess="油烟机物流立体库库存当前情况：\r",
    						"老板:",l_sum,"\r",
    						"零售:",l_ls,"\r",
    						"工程:",l_gc,"\r",
    						"电商:",l_ds,"\r",
    						"外贸:",l_wm,"\r",
    						"名气:",l_mq,"\r",
    						"因为同一产品存在多渠道情况，所以以上渠道合计可能大于老板电器总库存"
    CALL IDDSendMessage('text',"2492|3911",l_mess) RETURNING am_status,am_result
END FUNCTION


{
	该程序与需求不符合，暂时停用，
	D1仓库库存超过安全库存时，通知相关人员
	select img01,sumnum,tc_imh06 from
	(select img01,sum(img10) sumnum,tc_imh06 from img_file where img02='D1' group by img01 having sum(img10)>0) a,
	tc_imh_file b
	where a.img01=tc_imh01 and tc_imh02='D1' and tc_imh06 is not null
	and sumnum>tc_imh06
}
FUNCTION stok_notice_bak()
 DEFINE l_notice_ary  DYNAMIC ARRAY OF RECORD
				 img01    LIKE    img_file.img01,
         sumnum   LIKE    img_file.img10,
         tc_imh06    LIKE    tc_imh_file.tc_imh06
    END RECORD
    
    DEFINE l_sql STRING
    DEFINE l_from_where STRING
    
    DEFINE l_mess STRING   #需要通知的消息
    DEFINE l_index LIKE type_file.num5
    DEFINE l_count LIKE type_file.num5
    DEFINE l_i     LIKE type_file.num5
    
    LET l_from_where=" from ",
     "(select img01,sum(img10) sumnum from img_file where img02='D1' group by img01 having sum(img10)>0) a,",
     " tc_imh_file b",
     " where a.img01=tc_imh01 and tc_imh02='D1' and tc_imh06 is not null",
     " and sumnum>tc_imh06"
     
     #先判断是否有数据需要通知
     LET l_sql = "select count(*) ",l_from_where
     PREPARE t003_notice_count_pre FROM l_sql
	   DECLARE t003_notice_count_cs CURSOR FOR t003_notice_count_pre
	   FOREACH t003_notice_count_cs INTO l_count
	   END FOREACH  
	   CLOSE t003_notice_count_cs
	   CLOSE t003_notice_count_pre
	   
	   #开始通知
	   IF l_count>0 THEN
	   		LET l_sql = " select img01,sumnum,tc_imh06 ", l_from_where
	   		PREPARE t003_notice_pre FROM l_sql
	   		DECLARE t003_notice_cs CURSOR FOR t003_notice_pre
	   		LET l_index=1
	   		FOREACH t003_notice_cs INTO l_notice_ary[l_index].*
	   			 LET l_index=l_index+1
	   		END FOREACH
	   		CALL l_notice_ary.deleteElement(l_index)
	   		LET l_index=l_index-1
	   		CLOSE t003_notice_cs
	   		CLOSE t003_notice_pre
	   			
	   		FOR l_i=1 to l_index
	    		LET l_mess="料号:",l_notice_ary[l_i].img01,"当前库存:",l_notice_ary[l_i].sumnum,"超过最高库存:",l_notice_ary[l_i].tc_imh06
	    		CALL IDDSendMessage('text',"2492|3911",l_mess) RETURNING am_status,am_result
	      END FOR	   		
	   END IF
END FUNCTION