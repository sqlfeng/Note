SELECT DISTINCT oga03,
        oga032,
        oga23,
        0,
        oga02,
        oga16,
        3,
        oga01,
        0,
        0,
         SUM(ogb14t)*oga24,
        SUM(ogb14t),
         0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        ''
FROM oga_file,oea_file,ogb_file
WHERE oga01=ogb01
        AND oga02
    BETWEEN '2016-06-15'
        AND '2016-06-30'
        AND oga16=oea01
        AND oea03='D000010'
        AND oga03 = ?
        AND oga032 = ?
        AND oga09 IN ('2','4','6')
        AND ogaconf != 'X'
        AND MONTH(oga02) = ?
        AND ogapost='Y'
        AND ogaconf='Y'
        AND NOT EXISTS 
    (SELECT *
    FROM oma_file,omb_file
    WHERE oma01=omb01
            AND omavoid='N'
            AND omb31=oga01 )
GROUP BY  oga03,oga032,oga23,oga24,0,oga02,oga16,oga01,oga51,oga511
UNION
SELECT DISTINCT oha03,
        oha032,
        oha23,
        0,
        oha02,
        oga16,
        11,
        oha01,
        0,
        0,
         nvl(sum(ohb14t),
        0)*-1,
        nvl(sum(ohb14t),
        0)*-1*oha24,
         0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        ''
FROM oha_file,oga_file,oea_file,ohb_file
WHERE oha01=ohb01
        AND oha02
    BETWEEN '2016-06-15'
        AND '2016-06-30'
        AND oga16=oea01
        AND oea03='D000010'
        AND oha03 = ?
        AND oha032 = ?
        AND MONTH(oha02) = ?
        AND ohaconf='Y'
        AND ohapost='Y'
        AND NOT EXISTS 
    (SELECT *
    FROM oma_file,omb_file
    WHERE oma01=omb01
            AND omavoid='N'
            AND omb31=oha01 )
        AND oha16=oga01
        AND ohaconf<>'X'
GROUP BY  oha03,oha032,oha23,oha24,0,oha02,oga16,oha01