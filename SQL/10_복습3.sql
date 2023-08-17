USE workdb;

SELECT * FROM tb_cancer;

SELECT cancer_cd, SUM(y2019) AS s2019, SUM(y2020) AS s2020
FROM tb_cancer_list
GROUP BY cancer_cd
HAVING s2019 < s2020
;

SELECT *
FROM tb_cancer_cd
WHERE cancer_cd IN (
	SELECT cancer_cd
    FROM tb_cancer_list
    GROUP BY cancer_cd
    HAVING SUM(y2019) < SUM(y2020)
)
;

SELECT *
FROM tb_cancer_list
WHERE y2020 = (SELECT MAX(y2020) FROM tb_cancer_list)
;


SELECT tb_cancer_cd.cancer_cdname, 
		tb_cancer_age.cancer_agename,
        tb_cancer_list.gender,
        tb_cancer_list.y2019,
        tb_cancer_list.y2020
FROM tb_cancer_list
JOIN tb_cancer_cd ON tb_cancer_list.cancer_cd = tb_cancer_cd.cancer_cd
JOIN tb_cancer_age ON tb_cancer_list.cancer_ageid = tb_cancer_age.cnacer_ageid
WHERE tb_cancer_list.y2020 = (SELECT MAX(y2020) FROM tb_cancer_list )
;

CREATE VIEW tb_cancer_vw AS
	SELECT  tb_cancer_list.cancer_cd, 
			tb_cancer_cd.cancer_cdname, 
			tb_cancer_age.cancer_agename,
			tb_cancer_list.gender,
			tb_cancer_list.y2019,
			tb_cancer_list.y2020
	FROM tb_cancer_list
	JOIN tb_cancer_cd ON tb_cancer_list.cancer_cd = tb_cancer_cd.cancer_cd
	JOIN tb_cancer_age ON tb_cancer_list.cancer_ageid = tb_cancer_age.cancer_ageid
	;


