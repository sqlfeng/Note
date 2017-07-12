axmr670

先选1再选3
和直接选3的计价数量（ogb917）不同
5D10-1705020060

main→ axmr670_tm→axmr670
        → axmr670


PREPARE axmr670_prepare1 FROM l_sql

SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12,        ogb13,ogb14t,oga24,'','',       azi03,azi04,azi05        ,oga10,oga23,ogb03,ogb31                                ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916               ,oga032,ogb14,ta_ogb01       ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02   FROM oga_file,ogb_file,azi_file,occ_file,oea_file  WHERE oga01 = ogb01 AND oga23 = azi01 AND ogb31 = oea01 AND oea49 = '1' AND oeaconf = 'Y' AND oga65 ='Y' AND oga09 ='2'    AND ogaconf ='Y' AND ogapost ='Y'    AND oga03 = occ01    AND oga01='5D10-1705020060'


PREPARE r670_tc_otn_p FROM l_sql

SELECT tc_otn04,azf03 FROM tc_otn_file,azf_file  WHERE tc_otn01 = ?    AND azf01 = tc_otn03 AND azf09 = 'R'  ORDER BY tc_otn03 

PREPARE r670_n_p1_1 FROM l_sql2


SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogapost = 'N'  AND oga02 > '17/07/05' "
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogb66||ogb67 IN (SELECT ogb01||ogb03 FROM ogb_file,oga_file   WHERE oga01 = ogb01 AND ogb912-ogb50 <>0 AND oga09 in ('2','3' ) AND ogapost ='Y')  AND oga02 <= '17/07/05'


	779	        PREPARE r670_n_p1_2 FROM l_sql3


SELECT COUNT(*)   FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogapost = 'N'  AND oga02 > '17/07/05' 


	789	     PREPARE r670_n_p1 FROM l_sql

tm.wc2 = " 1=1"
tm.edate = 17/07/05
l_sql3 = " SELECT COUNT(*)   FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogapost = 'N'  AND oga02 > '17/07/05' "
tm.rtype = "1"
l_sql = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogapost = 'N'  AND oga02 > '17/07/05'  ORDER BY oga01"
6


	799	     PREPARE r670_n_p2 FROM l_sql

SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogapost = 'N'  AND oga02 > '17/07/05'  ORDER BY oga01


	808	     PREPARE r670_p5 FROM l_sql

SELECT DISTINCT omb01  FROM omb_file,oma_file WHERE omb01 = oma01   AND omb31 = ?    AND omb32 = ?    AND omavoid = 'N'



SELECT SUM(ogb917)
FROM ogb_file
WHERE  ogb01 = '5N10-1705230009'  and
ogb66 = '5D10-1705020060' and  ogb67 = 1


 SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12,        ogb13,ogb14t,oga24,'','',       azi03,azi04,azi05        ,oga10,oga23,ogb03,ogb31                                ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916               ,oga032,ogb14,ta_ogb01       ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02   FROM oga_file,ogb_file,azi_file,occ_file  WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2'    AND ogaconf ='Y' AND ogapost ='Y'    AND oga03 = occ01    AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL AND  1=1)   AND oga01='5D10-1705020060'

 574
 714
 760
 978
 1017
 1044
 1079
 1096 !!
 1156
 1193
 1217
 r670_n_cur1_1

SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogb66||ogb67 IN (SELECT ogb01||ogb03 FROM ogb_file,oga_file   WHERE oga01 = ogb01 AND ogb912-ogb50 <>0 AND oga09 in ('2','3' ) AND ogapost ='Y')  AND oga02 <= '17/07/05' 

l_sql2
直接3
SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'
先选1
SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogb66||ogb67 IN (SELECT ogb01||ogb03 FROM ogb_file,oga_file   WHERE oga01 = ogb01 AND ogb912-ogb50 <>0 AND oga09 in ('2','3' ) AND ogapost ='Y')  AND oga02 <= '17/07/05' 

再选3
SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'



 l_count = 0
sr.ogb03 = 2
sr.oga01 = "5D10-1705020060"
l_ogb917 = 8200.000

sr.oga02 = 17/05/02
sr.oga01 = "5D10-1705020060"
sr.oga03 = "F0018"
sr.oga14 = "150619"
sr.oga15 = "BD"
sr.ogb04 = "PF001800002"
sr.ogb06 = "7N0886-0360"
sr.ima021 = (null)
sr.ogb12 = 16362.000
sr.ogb13 = 10.000000
sr.ogb14t = 441.780000
sr.oga24 = 1.0000000000
sr.ogb13_1 = (null)
sr.ogb14t_1 = (null)
sr.azi03 = 4
sr.azi04 = 2
sr.azi05 = 2
sr.oga10 = (null)
sr.oga23 = "CNY"
sr.ogb03 = 1
sr.ogb31 = "5510-1704240148"
sr.ogb05 = "PCS"
sr.ogb910 = "PCS"
sr.ogb912 = 16362.000
sr.ogb913 = "KG"
sr.ogb915 = 0.000
sr.ogb916 = "KG"


3

axmr670_curs1
g_priv3 = "0"
tm.rtype = "3"
l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12,        ogb13,ogb14t,oga24,'','',       azi03,azi04,azi05        ,oga10,oga23,ogb03,ogb31                                ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916               ,oga032,ogb14,ta_ogb01       ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02   FROM oga_file,ogb_file,azi_file,occ_file  WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2'    AND ogaconf ='Y' AND ogapost ='Y'    AND oga03 = occ01    AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL AND  1=1)   AND oga01='5D10-1705020060'"
tm.edate = (null)
tm.wc2 = " 1=1"


tm.rtype = "3"
tm.wc = "oga01='5D10-1705020060'"
tm.s = "123"
tm.t = "NNN"
tm.u = "NNN"
tm.edate = (null)
tm.more = "N"
tm.wc2 = " 1=1"


l_count = 0
sr.ogb03 = 2
sr.oga01 = "5D10-1705020060"
l_oga01a = (null)
l_oga02a = (null)


tm.rtype = "3"
l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12,        ogb13,ogb14t,oga24,'','',       azi03,azi04,azi05        ,oga10,oga23,ogb03,ogb31                                ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916               ,oga032,ogb14,ta_ogb01       ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02   FROM oga_file,ogb_file,azi_file,occ_file  WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2'    AND ogaconf ='Y' AND ogapost ='Y'    AND oga03 = occ01    AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL AND  1=1)   AND oga01='5D10-1705020060'"
tm.edate = (null)
tm.wc2 = " 1=1"
SQLCA.sqlcode = 0

l_tc_cra03 = "A"
sr.ogb03 = 1
sr.oga01 = "v "
l_oga01a = (null)
l_oga02a = (null)



760/1096

l_count = 0
sr.ogb03 = 1
sr.oga01 = "5D10-1705020060"
l_ogb917 = 44.178
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'"



l_count = 0
sr.ogb03 = 2
sr.oga01 = "5D10-1705020060"
l_ogb917 = 8200.000
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogb66||ogb67 IN (SELECT ogb01||ogb03 FROM ogb_file,oga_file   WHERE oga01 = ogb01 AND ogb912-ogb50 <>0 AND oga09 in ('2','3' ) AND ogapost ='Y')  AND oga02 <= '17/07/05' "



l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'"

l_count = 0
sr.ogb03 = 1
sr.oga01 = "5D10-1705020060"
l_ogb917 = 44.178
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'"

l_count = 0
sr.ogb03 = 2
sr.oga01 = "5D10-1705020060"
l_ogb917 = 8200.000
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X' AND ogb66||ogb67 IN (SELECT ogb01||ogb03 FROM ogb_file,oga_file   WHERE oga01 = ogb01 AND ogb912-ogb50 <>0 AND oga09 in ('2','3' ) AND ogapost ='Y')  AND oga02 <= '17/07/05' "


l_count = 0
sr.ogb03 = 0
sr.oga01 = (null)
l_ogb917 = (null)
l_sql2 = "SELECT DISTINCT oga01,oga02  FROM oga_file,ogb_file WHERE oga01 = ogb01    AND (ogb67 = ? AND  ogb66  = ? )   AND oga09 = '8'   AND oga01 = ogb01   AND ogaconf <> 'X'"



