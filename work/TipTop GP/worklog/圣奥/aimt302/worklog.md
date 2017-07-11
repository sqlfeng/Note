aimt302

录入

部门编号：JT087
单据编号：W022-HN170600001
料号：001121649/4PE-LCL11B


W023-HN150600024
JT087

130	640000150	副梁


axmt670  X701-XS170600008，转应收账款转不了，没任何提示，帮忙看下，我这边系统上不去，看不了具体情况
																															 	 			
 SELECT omf00,omf01,omf02,omf03,omf04,omf05,omf051,omf06,omf061,omf07,omf08,omf22,omf24,omfpost,ta_omf01,ta_omf04  FROM omf_file  WHERE omf00='X701-XS170600008' AND omf00 LIKE 'X701%' AND  1=1 ORDER BY 1

X701-HN120900001

SELECT UNIQUE omf00,omf01,omf02,omf03,omf04,omf05,omf051,omf06,omf061,omf07,omf08,omf22,omf24,omfpost,ta_omf01, ta_omf04 FROM omf_file  WHERE omf00='X701-HN120900001' AND omf00 LIKE 'X701%' AND  1=1 ORDER BY 1
                                                                       