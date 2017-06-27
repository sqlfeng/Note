 ## 作业名称须为
『模块名称』+『一码程序类别』+『三码流水号』
  程序类别

        以下为常用
        I：建檔(维护作業)T：处理(事务处理)P：批处理
        Q：查询作业S：参数设定R：报表作业
            R和T联合使用
            以下很少用  
        M：选单(目录选單)O：其他(辅助工具 U：更新
            流水号(概略区分，同一模块下不可有同一流水号即可)
### 000-400系统参数、采购  
### 401-700生产作业 
### 701-999销退及后端处理，系统参数

###   作业名称为aimi100
	   『aim』模块名
	   『i』类作业：建檔(维护作業)
	   『流水号』：100
 ###  作业名称为aimi1001或aimi100_a
	应为aimi100的子作业
    作业名称为saimi100
	应为aimi100的子程序
 ###  函式名称须为
    『程序名称(扣除模块名)』+『此函式功用』 
    作业中通常有下列函式
	   _a( )数据新增处理
	   _i ( )数据输入处理
	   _b( )单身数据处理(含输入)
	   _cs( )或_curs( )处理画面上QBE资料条件
	   _fetch( )单身或单头的资料抓取
	   _copy( )复制功能处理
	   _out( )报表打印功能处理
	   _show( )单文件或单头数据呈现于画面
	   _menu( )功能选单
	   _u( )更新函数
	   _set_entry( )及_set_no_entry( )处理字段可否输入变换
  ###  全局变量(Global Variable)或模块变量(Module Variable)
    以『 g_ 』开头命名，后方跟上功能用途 
    局部变量(Local Variable)
    以『 l_ 』开头命名，后方跟上功能用途
    传递用的变数(Passive Variable) 
    以『 p_ 』开头命名，后方跟上功能用途
    以上用于4gl， 以下定义于per
    屏幕数组变量(Screen Array Variable) 
    以『 s_ 』开头命名，后方跟上主要table名称
    模块代码须為三至四码英文组成
    『a』为系统基本模块
        Example：agl、apy、axr、azz
    『g』为大陆版修改模块             Example：ggl、gpy、gxr
    『c』为客制模块
        Example：cgl、cggl、cpy、cgpy、clib
    『lib、sub、qry』三组系统函式除外
	   lib函式名称须为『 cl_ 』+『此函式功用』 
	   sub函式名称须为『 s_ 』 +『此函式功用』
	   qry函式名称须为『 q_ 』+『此函式查询的主要table名称』

 ### 必须在客制目录（clib、csub、cqry）下新建共享函式
    新函式程序名称及内含的函式名称，不可与标准系统模块名称相同 
        如：$CLIB下，函式名称為『 ccl_』+『函式功用』
        $CSUB下，函式名称為『 cs_』+『函式功用』
        $CQRY下，函式名称為『 cq_』+『函式功用』
    透过『程序链结记录维护作业(p_link)』登录新函式

###   将原有函式复制到客制目录（clib、csub、cqry）下修改
    函式程序名称及内含的函式名称，不需修改，维持原名 
    透过『程序链结记录维护作业(p_link)』，修改原来登录的数据，将模块代码替换成CLIB、CSUB或CQRY
    修改过的共享模块必须重新制作42x；有用到的程序也要重新link


 ###  表格档案（table）名称须为
    『二码到四码英文流水號（一般为三码） （可含数字） 』+『_file（固定用法）』 
    例如：
    ima_file记录料件数据用
    gay_file记录系统可用语言别数据
    zz_file记录每支作业基本数据用
    r140_file报表用暂存记录文件
    取用时应由该模块特定区段优先选用
    如im*_file区段属aim模块
    表格档案可利用『档案架构记录修整维护作业(p_zta)』进行开启或毁弃工作

 ###  字段（field）名称须为
    『表格名稱（去除_file）』+『两码到三码流水号』 
    例如：
    ima01记录料件代码用ima02记录料件名称
    gay01记录语言别代码gay02记录语言别名称
    若有特定用途字段，则定义尾端用字以资统一
    acti数据有效码post资料过账否mksg资料签核否
    conf资料结案否prsw数据打印次数prnt立即打印否

### slip单别desc单据名称type单据性质
    myno已用单号sign签核等级conf自动确认否 
    
    user数据建立人modu数据修改人grup建立/修改人部门
    date数据维护日
    索引（index）名称须为
    『表格名稱（去除_file）』+『 _』+『两码流水号』 
    例如：
    ima_01
    gay_01
 ###  客制一个不存在的表格档案（table）名称，须为
    『tc_（固定用法）』+『三码英文（可含数字）流水号』+『_file（固定用法）』 
    例如（范例）：
    tc_ima_file辅助ima_file用
    tc_gae_file辅助gae_file用

    ® 在原有的表格加客制字段命名原则
    字段（field）名称须为
    『ta_ 』+『表格名称（去除_file）』+『三码流水号』 
    例如：
    ta_ima001或ta_ima020 
    ta_gay010或ta_gay002
    若有特定用途字段，比照package使用标准尾端用字
    字段须循序新增，不得有插在原字段中间的情形发生。
### ® 客制索引命名原则
    字段（field）名称须为
    『 tic_ 』+『表格名稱（去除_file）』+『三码流水号』 
    例如：
    tic_ima_001或tic_ima_002 
    tic_gay_001或tic_gay_002 
    不管是修改已存在table的索引或是新table的索引，
        只要是客制修正/新增的索引，一律使用此规则

### ® 基本环境变量

    $TOP	指向安装TIPTOP的路径
    $TOPCONFIG	指向TIPTOP下的config
    $CUST	指向客制模块的路径
    $XXX / $XXXi	分别为指向系统模块/系统模块下的42r
        每个模块都有各自对应的环境变量
    $TEMPDIR	指向报表产出的存放路径
    $FGLASIP	记录Web开启时的前置路径字符串
    $DBDATE	记录日期格式显示的样式
    $ORALE_SID	存放ORACLEinstance名称实例名

### ® Shell命令


|  命令        | 功能           | 
| ------------- |-------------| 
| r.c2      | 编译程序 |
| r.l2      | 链接程序，打包生成（42r和42x）      |
| r.f2      | 编译画面，生成per档      |
| r.gf      | 预览画面档      |   
| exe2 | 执行作业（任意路径下）      |
| r.r2 | 执行作业（在4gl模块下）      |
| r.r2d | 这姓作业后，若SQL错误则会留下log档      |
| r.d2 | r.d2+ Debug工具      |
| r.s2 | 产生schema档，数据库修改之后      |
| rebuild | 系统重新编译      |   



### 常用程序
p_link	客制原有函数名
p_zta	数据表维护
p_zz	4ad,4tm,4st,4tb
p_zm	4sm
	
	

### ® Genero Studio per转换为.4fd格式的方法整理   
    ® File Browser
        在.per文件上按鼠标右键，选
        [Import in Form Designer]
    ® Form Designer
        在TopMenu的File中，选取ImportForm
        在Toolbar中，点選Import a .perfile图示
    ® 注意事项
        有用到SCEHMA的.per檔，要先用Database Browser
    建立Schema

### 画面档控件名称	功能说明
    Folder	以分页方式显示数据
    Grid	简易空白画布
    Group	将外层加上框线
    HRec	置放空白分格组件用
    ScrollGrid	有滚动条的空白画布
    Table	以表格方式显示数组数据
    Tree	以树形图方式显示数组数据
    VBOX	将内含的对象以垂直方式排列
    HBOX	将内含的对象以水平方式排列

### Genero Studio help帮助文档。

画面档
双档

### 常用函数
    bp（）等待action
    交互指令：
    menu:
    _i（）->inputbyname
    _b( )input
    _show( ) display
    _u() 更新函数
    cs（）游标定义Index
    fetch（）取单头数据
    b_fill（）变量组和

### ® 程序内重要变量：
	   g_forupd_sql在updatecursor内用来组sql的string变数
	   g_before_input_done字段控制变量﹙有使用到才加﹚
	   g_curs_index单头目前指标
	   g_row_count单头总笔数
	   g_rec_b  单身总笔数
	   l_ac单身目前指标

cl_ui_init（）画面初始化

```SQL
® MAIN
```SQL
MAIN
    OPTIONS
          INPUT NO WRAP#输入的方式:不打转
    DEFER INTERRUPT#撷取中断键
    LET g_argv1=ARG_VAL(1)   程序运行前传参，固定用法  #单据编号
    LET g_argv2=ARG_VAL(2)                     #使用功能
    LET g_argv3=ARG_VAL(3)
    IF (NOTcl_user()) THEN
        EXIT PROGRAM
    END IF
    WHENEVER ERRORCALL cl_err_msg_log
  
   IF (NOTcl_setup("APM")) THEN
       EXIT PROGRAM
   END IF
```

bp（()
CALL fgl_set_arr_curr(1) 将光标固定到第一行
```

有数据
before raw
before insert
before field
after field
```

before field
after field
ater

我