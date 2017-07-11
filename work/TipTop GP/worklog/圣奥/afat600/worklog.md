afat600汇入excel更新盘点数量错误，
excel中维护了盘点数量，
但是汇入excel后盘点数量被更新为空，
150测试数据，固资盘点编号0629
对应规格SA010

ls_file = "C:/Users/Administrator/Desktop/afat600-0629.xlsx"
l_success = "Y"
li_i = 1
xlApp = 4
iRes = 5


	87	               CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||i||',1).Value'],[l_fca.fca01])  #盘点编号



    栏位错误