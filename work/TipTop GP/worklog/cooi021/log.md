<font color=red>**配置文件/环境：**</font>

    主机：172.16.100.45  

    数据库密码：manager/sys

    参考程序 ：axmt410、axmt360、cooi111

    数据表：tc_stf_file员工信息数据
            tc_spc_file员工刷卡信息

### 1. 链接时候出错：
ERROR(-1338):The function 'cl_set_act_visiable' has not been defined in any module in the program.

拼错了！！

### 2. 找不到数据库

解决方法：抛转
    
    1. 在p_zta中，使用同步建立Synonym，在其他数据库主机中建立数据库表。
    由于有的主机是空主机，可能会报错.
   
    2.生成单一SCH档，再点击汇入CREATE的SQL

### 3.直接跳出input循环

解决方法：修改画面档对应字段属性

### 4. 开窗无查询的icon

解决方法：修改画面档
    
    修改开窗字段image属性设置为zoom

### tips：
    错误信息维护工具：p_ze
    开窗维护工具p_qry
