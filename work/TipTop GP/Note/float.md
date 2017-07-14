<font color=3F9CD6 >

>## 2017年7月12日

圣奥 150主机，p_zta 闪退问题 

数据库thn有问题 23621 1 4057  23940

sqlplus thn/thn@toptest

>## 2017年7月13日

圣奥 150 主机

### **联华测试**

asft311  CNJ-F11-160400000003
asft321

### **圣奥的这个麻烦再处理一下**
预开票的有一个需求要调整。已发货但是没有在cxmt400上传验收单的，也可以预先开票。现在系统是已出货的预开票选不到合同号。
cxmt600开窗

![mark](http://orxqvkqju.bkt.clouddn.com/darcy/170714/Kg32AALh54.png?imageslim)


p_zta 闪退 14857 23920 24072 24143

sqlca

### **梦神**

然后先连下梦神的，看下这个问题，aglq770,画面查询USD，会把RMB的币别的数据一起显示出来，先debug找下原因


VPN地址浏览器打开https://122.227.199.54
用户名ms2  密码mengshen2
ERP浏览器打开地址：http://192.168.1.254/wtopprd/wa/r/app/gdc_azzi000?Arg=1&Arg=zh_CN
用户名/密码：tiptop/mstiptop
远程桌面可连xshell的192.168.1.253
用户administrator 密码dcms@123




### **冠龙远程桌面**

     117.184.197.3
      administrator Karon88786341
axmt700 

doc_file

axmi010

然后看下这个问题，KR库，报这个错的原因

grep -l “insert into doc_file" */4gl/*.4gl

>## 2017年7月14日

### **圣奥**

cxmt600 完全出货，在cxmt400上传了验收单的不能预开票

在after field 后加入管控
```sql
SELECT count(*) INTO l_chk FROM tc_doc_file
      WHERE tc_doc002=g_omf[l_ac].ta_omf03
IF l_chk > 0 THEN
CALL cl_err('无效合同号','!',0)
NEXT FIELD ta_omf03
END IF
```
开窗cq_oea01_1中,加入 'and oeaud02 not in (select tc_doc002 from tc_doc_file)


### **珠城**


Windows自带VPN
IP：61.164.139.170
账号密码：linxm

export FGLSERVER=192.168.2.251

服务器地址192.168.2.194 tiptop tiptop

然后看这个问题

这个sql查出来的值为什么和cimq407的不一样

```sql
select sfa03,ima02,ima021,sfa12,sum(sfa05) as sfa05,sum(sfa06) as sfa06,sum(SFA05-SFA06)as xql,ztl,sum(A.img10) as yckc,sum(B.img10) as cjkc 
from  sfb_file
left join sfa_file on sfb01=sfa01
LEFT JOIN CGZTL ON sfa03=pmn04
LEFT JOIN IMG_FILE A ON sfA03=A.img01 and A.img02='1010'  --原材料库存
LEFT JOIN IMG_FILE B ON sfA03=B.img01 and B.img02='1011'  --车间库存
left join ima_file on sfa03=ima01


where SFB04<>8 and (sfa05-SFA06)>0 and sfb87='Y' and sfa03='83090099'
group BY  sfa03,ztl,sfa03,ima02,ima021,sfa12
```
![mark](http://orxqvkqju.bkt.clouddn.com/darcy/170714/l6E451ek25.png?imageslim)

### **联华**

追单

CNJ-P10-201706220001

asft300 CNJ-P10-201707140001