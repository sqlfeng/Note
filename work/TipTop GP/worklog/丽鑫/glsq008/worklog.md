
屏幕剪辑的捕获时间: 2017/6/8 星期四 22:19 

aapq700 

屏幕剪辑的捕获时间: 2017/6/9 星期五 14:33 

http://192.168.1.8/gas/wa/r/gdc-toptest-udm-intranet 
http://192.168.1.8/gas/wa/r/gdc-toptest-udm-intranet


0 置 原 因 护 作 业 叩 il 仍 丌 丽 （ 试 月 [ LS 讒 试 1 阀 日 ： 17 / 05 / 09 （ GMT ） *F:TipTop 画 面 墩 不 料 劌 發 0 语 言 资 料 复 制 资 下 叫 貼 上 录 入 删 复 制 里 身 打 印 工 出 E c 基 本 资 料 留 置 原 因 码 留 苎 因 1 “ 一 年 后 支 付 00 已 1 “ 半 年 后 支 付 ？ 00 


SELECT '',sfb01,sfb05,sfb08,sfa03,ima02,ima021,sfa05,sfa06,0,0,0,0 FROM sfb_file,sfa_file,ima_file 

WHERE sfb01=sfa01 AND sfa03=ima01 AND sfb87='Y' AND sfb04 NOT IN ('1','8') 

称料室数量： 

SELECT sum(img10) FROM img_file WHERE img02='LF10' and img01=物料编码 
 
材料仓库数： 

SELECT sum(img10) FROM img_file WHERE img02='LF15' and img01=物料编码 

需要调拨量： 

需要调拨量=欠料料-称料室数量 


欠料量是使用这个子函数实现的 
CALL s_shortqty(g_sfb.sfb01,g_sfa[g_cnt].sfa03,g_sfa[g_cnt].sfa08, #工单号/发料号/作业编号 
                      g_sfa[g_cnt].sfa12,g_sfa[g_cnt].sfa27,       #发料单位/被替代料号 
                      g_sfa[g_cnt].sfa012,g_sfa[g_cnt].sfa013)     #工艺段号/工艺序 
              RETURNING g_short_qty  


 
CGLSCGLS	glsq035	$CUST/cgls/42m/cgls_glsq035.42m	Y:是	5.25.02-11.05.11(00010)


1	XS	3:预开票	X201-XS170600530	1.000		10000.000000	8547.010000	1452.990000	10000.0000	10000.000000	8547.010000	1452.990000	10000.000000	R144-XS170600005	


select omf11,ogb31
from omf_file,ogb_file
where omf01=' /0628CES1'and ogb01=omf11


SELECT sfb01,sfb05,sfb08,sfa03,ima02,ima021,sfa05,sfa06,'',''
FROM sfb_file 
left join sfa_file on sfb01=sfa01
left join ima_file on sfa03=ima01
WHERE  sfb87='Y' AND  sfb04 NOT IN ('1','8')

SELECT sfb01,sfb05,sfb08,sfa03,ima02,ima021,sfa05,sfa06,sum(img10) as qry1,count(unique img02) as qry2
FROM sfb_file 
left join sfa_file on sfb01=sfa01
left join ima_file on sfa03=ima01
left join img_file on ima01=img01
WHERE  sfb87='Y' AND  sfb04 NOT IN ('1','8')


| a| a|
|--|--|
|1|2|