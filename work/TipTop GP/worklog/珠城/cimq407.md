```sql
SELECT img01,ima02,ima021,ima06,imz02,ima08,img02,imd02,img03,img04,img10,img09,nvl(imgg10,0),        imgg09,img17,ima27,imaud07,ima561,ima46,imaud03   
FROM imz_file,ima_file,img_file        
LEFT JOIN imd_file ON imd01=img02        
LEFT JOIN imgg_file ON img01 = imgg01 AND img02 = imgg02 AND img03 = imgg03 AND img04 = imgg04 
 WHERE ima01 = img01  AND img01='83090099' AND ima06 = imz01  AND imd11='Y' 
```


