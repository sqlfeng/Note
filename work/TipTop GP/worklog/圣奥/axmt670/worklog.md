	7926	      SELECT COUNT(*) INTO l_n FROM omf_file	
    7927	       WHERE omf00 = g_omf_1.omf00 AND omfpost != 'Y' 
    	7928	         AND omf11 IS NOT NULL
SELECT COUNT(*) INTO l_n FROM omf_file	WHERE omf00 = "X701-XS170600008" AND omfpost != 'Y'  AND omf11 IS NOT NULL

axmt670  X701-XS170600008，转应收账款转不了，没任何提示，帮忙看下，我这边系统上不去，看不了具体情况

X701-XS170600010 转应收帐

X701-XS170600008

X701-XS170600010

g_oaz.oaz100 = "N"
g_oaz.oaz98 = "R121"
l_wc = "omf00 = \"X701-XS170600008\" AND omf01 = \"06281348\" AND omf02 = \" \""
l_str = " axrp330 '1=1' '5' '2017-06-29' 'N' 'Y' 'R121' 'Y' '' 'omf00 = \"X701-XS170600008\" AND omf01 = \"06281348\" AND omf02 = \" \"' 'axmt670'"
g_today = 2017-06-29


g_no1 = "R121"
g_bgjob = "Y"
g_no2 = (null)
g_wc3 = "omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
g_prog_type = (null)


g_wc3 = "omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
ls_n = 0
g_sql = " SELECT COUNT(*) FROM omf_file   WHERE omf10 = '9'     AND omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"


g_wc3 = "omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
ls_n = 0
g_sql = " SELECT COUNT(*) FROM omf_file   WHERE omf10! = '9' AND omf10! = '3' AND omf10! = '4'     AND omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
ls_n2 = 0

g_wc3 = "omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
ls_n = 0
g_sql = " SELECT COUNT(*) FROM omf_file   WHERE omf10 = '3'     AND omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '"
ls_n2 = 1
ls_n3 = 0


l_oga27 = " "
l_order1 = " "
l_order2 = " "
l_ogaplant = " "
g_sql = "SELECT azp01 FROM azp_file,azw_file  WHERE  1=1   AND azw01 = azp01 AND azw02 = 'XS'"


ls_n = 0
ls_n3 = 0
g_sql = "SELECT DISTINCT omf00,omf01,omf02,omf10,oga94,ogb31,'','',oga01,ogaplant,oga011,oga03,oga18,        oga05,oga21,oga15,oga14,oga23,oga02,oga11,oga27,oga08,'2' type   FROM xs.oga_file,xs.ogb_file,xs.oay_file,omf_file  WHERE 1=1   AND ogaplant = 'XS'   AND oga01=ogb01    AND ogaconf='Y'    AND oga01 like ltrim(rtrim(oayslip))||'-%' AND oay11='Y'   AND oga00 IN ('1','4','5','6','B')    AND oga09 NOT IN ('1','9') AND ogapost='Y'   AND oga65 ='N'    AND oga01 = omf11    AND omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' '   AND oga01 IN (SELECT DISTINCT omf11 FROM omf_File  WHERE omf08 = 'Y' AND omf10 = '1'    AND omf04 IS NULL    AND omf09 = 'XS'   AND omf00 = 'X701-XS170600008' AND omf01 = '06281348' AND omf02 = ' ' AND omfpost = 'Y' )"
g_oaz93 = "Y"
g_enter_account = "Y"


X301-XS170600008
X501-XS170600008

2	XS	1:出货	X501-XS170600007	1	X301-XS170600580	1	100040039	T131.700木茶几	700*450*500		Z101	A000088	1	0.000	PCS	666.666667	666.67	.00	666.67	666.670000	666.67	.00	666.67	

        



X509-XS170700383


ogb917(计价数量)  ogb13(原币单位)
ogb14(原币税前金额)	ogb14t(原币含税金额)
oga211(税率)


on row change
  CALL t600_oga50_sum()   

 AFTER ROW



t600_amount()
return l_amount 







两笔订单都有做预开票，但axmt670审核时只将第二行单身的订单预开票发票号码更新过来了，第一笔订单的未更新到axmt670发票号码栏位

rdpclip.exe 

2204
