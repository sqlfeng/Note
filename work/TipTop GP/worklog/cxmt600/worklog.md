@李晓伟 请优先处理此问题：预开票的问题：120环境订单X301-XS161200588未出货且没有预开票，cxmt600新增该客户的预开票时ERP合同号开窗无资料，手工输入提示无效的合同号
实习生负责人-曹靖依 2017/6/26 星期一 15:54:48
明早十点前交付
实习生负责人-曹靖依 2017/6/26 星期一 15:54:51
看不懂来问我

李晓伟 2017/6/26 星期一 15:56:17
收到
15:56:40
实习生负责人-曹靖依 2017/6/26 星期一 15:56:40
程序编号：cxmt400
实习生负责人-曹靖依 2017/6/26 星期一 15:56:49
对应表结构为oea_file,oeb_file
实习生负责人-曹靖依 2017/6/26 星期一 15:57:14
在cxmt600的单身
实习生负责人-曹靖依 2017/6/26 星期一 15:57:35
先自己模拟出相同的问题来，然后debug找到原因
实习生负责人-曹靖依 2017/6/26 星期一 15:58:25
如果需要更改程序，请先备份原程序，备份规则：XXX序列号.4gl年月日ITCODE

营运中心：xs

after field ta_omf03

tc_oeg02 ='3'  发票状态、完全出货

select count(*) from oea_file,tc_oeg_file where oeaud02="X201-XS161202509" and oeaud02=tc_oeg01 and oeaconf='Y' and tc_oeg02='1'

select  tc_oeg01,tc_oeg02,tc_oeg03 from oea_file ,tc_oeg_file where oeaud02="X201-XS161202509" and oeaud02=tc_oeg01 and oeaconf='Y' 


g_argv1 = "1"
g_wc3 = " 1=1"
g_wc4 = " 1=1"
g_wc2 = " 1=1"
g_sql = "SELECT  oea01 FROM oea_file WHERE oea01='X301-XS161200588' AND oea00 IN ('1','2','3','4','6','7') ORDER BY oea01"


SELECT tc_oeg02,tc_oeg03,tc_oeg04,tc_oeg11,tc_oeg12,tc_oeg13,tc_oeg14
FROM tc_oeg_file,oea_file WHERE tc_oeg01=oea01 AND tc_oeg01 = "X301-XS161200588"



9565

	9565	   CALL t400_show_status()       #No:130722

    30635


两个程序的sql连接语句不一致

axmt410用的是  oea01=tc_oeg01
cxmt600的是   oeaud02=tc_oeg01


30642	        FROM tc_oeg_file,oea_file WHERE tc_oeg01=oea01 AND tc_oeg01=g_oea.oea01



1. cxmt600新增单身单据类型选择4.冲减预开票，ERP合同号无法开窗，测试客户A032007

2. 选择4.冲减预开票，ERP合同号手工输入时没有管控cxmt600预开票资料是否审核过账，未审核过账的订单预开票也可以做冲减预开票动作，预开票单号X702-XS170600019，冲减预开票单号X702-XS170600020

3. 冲减预开票，ERP合同手工输入时未检查数据有效性，可输入任意字符   *是否是sql连接语句问题*
也可以输入非单头客户的合同，cxmt600测试单号X702-XS170600023，或输该客户未做预开票的合同，cxmt600测试单号X702-XS170600024

4. 一笔合同可以**重复做预开票或冲减预开票**，还是客户A032007，除了上面做的预开票X702-XS170600019，又做了一笔预开票X702-XS170600021，且测试两笔都可以审核，冲减预开票除上面的X702-XS170600020也重复做了一笔，单号X702-XS170600022
修改为一笔合同只允许存在**一笔未作废的预开票或冲减预开票资料**

5. 预开票X702-XS170600008未做冲减预开票动作可直接做axmt670，单号X701-XS170600007

正常应该是有预开发票的， axmt670发票扣帐之前，必须在cxmt600做一张冲预开的发票，并扣帐转应收
此问题可将210主机axmt670更新到120主机后删除axmt670资料重新测试看看


# add by lixwz 20160627 start
```sql
    IF g_omf[l_ac].omf10 = '4' THEN
    SELECT count(*) into l_chk FROM oea_file,tc_oeg_file
        WHERE oeaud02=g_omf[l_ac].ta_omf03  and oea01=tc_oeg01
        AND oeaconf ='Y' and tc_oeg02='1'
    IF l_chk=1 THEN
        CALL cl_err('无效合同号','!',0)
        NEXT FIELD ta_omf03
    END IF
    END IF
```
# add by lixwz 20160627 end


oeaud02合约号


select omf00,omf10,omf21,omf05,ta_omf03 from omf_file where omf05="A032007"

omf08	varchar2:varchar2	1			p:标准	状态码	
X702-XS170600019	3	1	A032007	X201-XS170301632

	2239	             SELECT count(*) INTO l_chk FROM omf_file WHERE ta_omf03 = g_omf[l_ac].ta_omf03 AND omfpost='Y' AND omf10='3'


1	XS	3:预开票	X201-XS170301632	1.000		4229.000000	3614.530000	614.470000	4229.00000	4229.000000	3614.530000	614.470000	4229.000000	

A000001	X702-XS170400001	Y	3	X201-XS120700001	Y	

select count(*) from omf_file where ta_omf03="X201-XS170301632" and omfpost='Y' and omf10='3'

X702-XS170600027	4	A032007	X702-XS170600019	N	N