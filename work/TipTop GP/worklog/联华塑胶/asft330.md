SELECT sfcb050,sfcb020,sfcb017 
 FROM sfcb_t
where sfcbdocno='CNJ-P10-201707140001'


在制数sfcb050为负数


asft330录入之后
审核时候，根据良品数量和报废数量，生成在制数。
sfcb050=-（良品数量+报废数量）。

录入的的时候，只在after filed的时候做了是否大于0的判断，直接accept，可以录入负数。


grep -l '#170302-00004#1' */4gl/*.4gl



CNJ-P10-201707000028



#170421-00073#1


l_sffbseq,l_sffbstus,l_sffb014,l_sffb017,l_sffb018,l_sffb019,l_sffb005 


 #170421-00073#1 add(s)
      LET l_sffd002_sum = 0
      SELECT SUM(sffd002) INTO l_sffd002_sum
        FROM sffd_t
       WHERE sffdent = g_enterprise
         AND sffddocno = p_docno
         AND sffdseq = l_sffbseq
      IF cl_null(l_sffd002_sum) THEN LET l_sffd002_sum = 0 END IF
      IF l_sffd002_sum > l_sffb017+l_sffb018+l_sffb019 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ""
         LET g_errparam.code = 'asf-00856'
         LET g_errparam.popup = TRUE 
         CALL cl_err() 
         LET r_success = FALSE        
      END IF
#170421-00073#1 add(e)