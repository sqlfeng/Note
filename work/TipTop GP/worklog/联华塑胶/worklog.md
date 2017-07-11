     联华的连线方式：
报表服务器：218.4.65.22 
账号1：administrator

密码：dcms@123

账号2：admin1

密码：dcms@123


BPM服务器：218.4.65.22:3387

账号1：administrator

密码：dcms@123

账号2：admin1

密码：dcms@123

 
问题类型： T100 营运中心代码及名称： LH01 合约等级： B0 
案件代号： web300061908 产品别： T100 100 填写日期： 20170706 
客服代号： 08023700 客户名称： 联华塑胶 联络电话： 18068080447 
联络人： 方永彬 程序代号： abmt300 手 机： 18068080447 
部 门： 资讯 E - MAIL ： yongb_fang@ktkgroup.com 
问题描述： 集团研发ECN维护作业，ECN单号：LH1-BM11-17070005，新增料件为“参考材料”，但在abmm200集团研发产品结构中却是“主要材料”. 


ECN 单号
LH1-BM11-17070005
SN180413
PN200260
PN200107
PN600194

Select bmba_t.*
from bmba_t
where bmba001='SN180413'

Select bmfb_t.*
from bmfb_t
where bmfbdocno='LH1-BM11-17070005'


INSERT INTO bmba_t( bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba033,bmba034) 
SELECT DISTINCT  bmfb016,bmfb017,'','','',bmfb020,'1',bmfb018,COALESCE(imae021,'1'),'N',0,'',bmfb019,'CNJ-300-170700000004',bmfb014,bmfb015,bmfb021,COALESCE(imae091,'N'),'N',bmfb022,bmfb023   

FROM bmfb_t LEFT OUTER JOIN imae_t      ON imaeent = bmfbent AND imaesite = bmfbsite     AND imae001 = bmfb005  

WHERE bmfbdocno = 'CNJ-300-170700000004'     AND bmfbent = '    99'     AND bmfbsite = 'ALL'     AND bmfb003 = '1'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL 

r_success = 1
TRUE = 1
SQLCA.sqlcode = 0
l_bmfa005 = 2017-07-06 15:52:44
l_bmba019 = "1"
l_sql = " INSERT INTO bmba_t(bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010,                     bmba011,bmba012,bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,                     bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba033,bmba034)  SELECT DISTINCT '    99','ALL','3801030010',' ',bmfb005,bmfb008,to_date('2017-07-06 15:52:44','YYYY-MM-DD hh24:mi:ss'),'',bmfb009,bmfb010,bmfb004,        bmfb013,bmfb011,bmfb012,bmfb016,bmfb017,'','','',bmfb020,'1',bmfb018,COALESCE(imae021,'1'),'N',0,'',bmfb019,'CNJ-300-170700000004',bmfb014,bmfb015,bmfb021,COALESCE(imae091,'N'),'N',bmfb022,bmfb023    FROM bmfb_t LEFT OUTER JOIN imae_t      ON imaeent = bmfbent AND imaesite = bmfbsite     AND imae001 = bmfb005  WHERE bmfbdocno = 'CNJ-300-170700000004'     AND bmfbent = '    99'     AND bmfbsite = 'ALL'     AND bmfb003 = '1'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL "
l_bmfb005 = (null)
l_bmfb004 = 0


l_sql = " INSERT INTO bmba_t(bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010,                     bmba011,bmba012,bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,                     bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba033,bmba034)  SELECT DISTINCT '    99','ALL','3802240118',' ',bmfb005,bmfb008,to_date('2017-07-06 16:35:46','YYYY-MM-DD hh24:mi:ss'),'',bmfb009,bmfb010,bmfb004,        bmfb013,bmfb011,bmfb012,bmfb016,bmfb017,'','','',bmfb020,'1',bmfb018,COALESCE(imae021,'1'),'N',0,'',bmfb019,'CNJ-D46-170700000002',bmfb014,bmfb015,bmfb021,COALESCE(imae091,'N'),'N',bmfb022,bmfb023    FROM bmfb_t LEFT OUTER JOIN imae_t      ON imaeent = bmfbent AND imaesite = bmfbsite     AND imae001 = bmfb005  WHERE bmfbdocno = 'CNJ-D46-170700000002'     AND bmfbent = '    99'     AND bmfbsite = 'ALL'     AND bmfb003 = '1'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL "

SELECT DISTINCT bmfb005,bmfb008,bmfb009,bmfb010,bmfb004,bmfb013,bmfb011,bmfb012,bmfb016,bmfb017,bmfb020,bmfb018,bmfb019,bmfb014,bmfb015,bmfb021,bmfb022,bmfb023   
FROM bmfb_t LEFT OUTER JOIN imae_t      ON imaeent = bmfbent AND imaesite = bmfbsite     AND imae001 = bmfb005  
WHERE bmfbdocno = 'LH1-BM11-17070005'     AND bmfbent = '    88'     AND bmfbsite = 'ALL'     AND bmfb003 = '1'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL



l_sql = " INSERT INTO bmba_t(bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010,                     bmba011,bmba012,bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,                     bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba033,bmba034)  SELECT DISTINCT '    99','NJQC1000','3802240118',' ',COALESCE(bmfb006,bmfb005),bmfb008,to_date('2017-07-06 16:35:46','YYYY-MM-DD hh24:mi:ss'),'',bmfb009,bmfb010,bmfb004,        bmfb013,bmfb011,bmfb012,bmfb016,COALESCE(bmfb017,'N'),bmba015,bmba016,'',COALESCE(bmfb020,'N'),'1',COALESCE(bmfb018,'N'),bmba021,COALESCE(bmba022,'N'),bmba023,bmba024,COALESCE(bmfb019,'N'),'CNJ-D46-170700000002',COALESCE(bmfb014,'N'),bmfb015,bmba029,COALESCE(bmba030,'N'),COALESCE(bmba031,'N')         ,bmfb022,bmfb023    FROM bmfb_t,bmba_t  WHERE bmfbdocno = 'CNJ-D46-170700000002'     AND bmfbent = '    99'     AND bmfbsite = 'ALL'     AND bmfb003 = '2'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL     AND bmbaent = bmfbent     AND bmbasite = 'NJQC1000'     AND bmba001 = '3802240118'     AND bmba002 = ' '     AND bmba003 = bmfb005     AND bmba009 = bmfb004     AND bmba005 <= to_date('2017-07-06 16:35:46','YYYY-MM-DD hh24:mi:ss')     AND (bmba006 >= to_date('2017-07-06 16:35:46','YYYY-MM-DD hh24:mi:ss') OR bmba006 IS NULL) "
SQLCA.sqlcode = 0
NULL = (null)
p_bmfadocno = "CNJ-D46-170700000002"
l_bmfb.bmfb002 = 1
l_success = 0
l_ooff013 = (null)



l_sql = " INSERT INTO bmba_t(bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,bmba008,bmba009,bmba010,                     bmba011,bmba012,bmba013,bmba014,bmba015,bmba016,bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,                     bmba023,bmba024,bmba025,bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba033,bmba034)  SELECT DISTINCT '    99','ALL','2001.10.1001','TX1',bmfb005,bmfb008,to_date('2017-07-06 17:31:24','YYYY-MM-DD hh24:mi:ss'),'',bmfb009,bmfb010,bmfb004,        bmfb013,bmfb011,bmfb012,bmfb016,bmfb017,'','','',bmfb020,'1',bmfb018,COALESCE(imae021,'1'),'N',0,'',bmfb019,'CNJ-ecn-170700000001',bmfb014,bmfb015,bmfb021,COALESCE(imae091,'N'),'N',bmfb022,bmfb023    FROM bmfb_t LEFT OUTER JOIN imae_t      ON imaeent = bmfbent AND imaesite = bmfbsite     AND imae001 = bmfb005  WHERE bmfbdocno = 'CNJ-ecn-170700000001'     AND bmfbent = '    99'     AND bmfbsite = 'ALL'     AND bmfb003 = '1'     AND bmfb008 IS NOT NULL     AND bmfb009 IS NOT NULL     AND bmfb010 IS NOT NULL "


asft321 工单成套退料维护
CNJ-P41-201706270001