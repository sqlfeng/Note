&lt;
1、安装soapUI-1.6 打开配置地址，然后双击出服务名，把XML替换到？的位置。
2、r.d2+ aws_ttsrv2
3、CTRL+D
4、输入：b 空格 接口的函数名字  点OK
5、再输入 run -S 8888  点OK
6、回到SOAPUI把最上面的WS地址从端口号开始到最后全部替换成8888
7、按UI里面的绿色三角箭头
8、这个时候回到debug界面开始跟吧。


Get过程 Service端
 1.aws_ttcfg2 注册服务
 2.aws_ttsrv2_service.4gl中写调入服务函数的名称
 3.aws_ttsrv2_service.4gl中调用解析函数
 4.发布 执行exe2 aws_ttsrv2 -W http://192.168.1.238:6384/ws/r/aws_ttsrv2?WSDL命令 产生wsdl文件
 5.startws
 6.书写解析函数，执行逻辑过程（重点解析，然后逻辑处理解析数据）


查进程ps -ef | grep aws_ttsrv2
杀进程kill -9 进程号