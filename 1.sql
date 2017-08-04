 LET l_sql = "MERGE INTO axcq761_tmp o",
                 #"  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32 ",         #MOD-D90121 mark
                  "  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32,oma76 ",   #MOD-D90121 add
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",", 
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND omaconf = 'Y' AND omavoid != 'Y' AND oma00 LIKE '1%' AND omb38 ='3' ) x ",
                 #"  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",  
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )",  #FUN-CC0157 mod                           #MOD-D90121 mark
                 # "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 AND (o.tlf905 = x.oma76 OR x.oma76 IS NULL))", #MOD-D90121 add  ##No.160924 mark 
                  "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32)", #MOD-D90121 add #No.160924 add 
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 *(-1) ",
                  "                       -(SELECT NVL(SUM(oct12),0) FROM oct_file ",
                  "                             WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                                   AND oct16='1' AND oct00='0') ",
                  "                       + (SELECT NVL(SUM(oct14),0) FROM oct_file ",
                  "                               WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                               AND oct16 = '2' ",
                  "                               AND (oct09*12)+oct10 BETWEEN ",l_bdate," AND ",l_edate,
                  "                               AND oct00 = '0')",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X') AND o.tlf10 <=0 "