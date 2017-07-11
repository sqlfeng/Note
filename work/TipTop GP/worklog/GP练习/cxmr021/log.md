### 报表主机ip：172.16.100.46

    administrator 
    dcms@123

### 参考程序：cxmr050、axmr310

### p_query在c:/tiptop下生成xml文件

### 在crystal report 中改写报表画面，验证数据库中加入xml文件

### 将xml和rpt文件放到服务器指定的位置

### 编写4gl代码和程序，调用报表


### 报错：没有找到报表样板，
### 查看指定位置 有没有rpt，传参是否正确


### cr报表设计时，分页问题

    将详细资料用组头包起来，节专家中在组头的后面也新建页，修改公式
    if {cxmr021.oga01} <> Previous ({cxmr021.oga01})  
    and RecordNumber <> 1 then True else False
    根据oga01分页
