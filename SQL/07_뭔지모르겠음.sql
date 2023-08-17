USE workdb;
-- 데이터 확인
SELECT * FROM tb_cancer_cd;

SELECT * FROM tb_cancer;


-- ERD로 만든 테이블에 기존의 테이블 내용을 삽입
-- tb_cancer_cd 테이블에 삽입
INSERT INTO tb_cancer_cd
SELECT 
    REPLACE(SUBSTRING_INDEX(type, '(', -1), ')', '') AS splitTypeCd,
    SUBSTRING_INDEX(type, '(', 1) AS splitTypeName
FROM tb_cancer_name
ORDER BY splitTypeCd;

SELECT * FROM tb_cancer_cd;

-- tb_cancer_age 테이블에 삽입
INSERT INTO tb_cancer_age(cancer_agename)
SELECT DISTINCT age 
FROM cancer
WHERE age != '계';

SELECT * FROM tb_cancer_age;

SELECT tb_cancer_cd.cancer_cd,
   gender,
    tb_cancer_age.cancer_ageid,
    d2019,
    d2020
FROM cancer
JOIN tb_cancer_cd ON SUBSTRING_INDEX(cancer.type, '(', 1) = tb_cancer_cd.cancer_cdname
JOIN tb_cancer_age ON cancer.age = tb_cancer_age.cancer_agename
WHERE cancer.gender != '계';

####################################################################

SELECT SUBSTRING_INDEX(type, '(', 1) AS cname,
		gender,
        age,
        y2019,
        y2020
FROM tb_cancer
JOIN tb_cancer_cd ON tb_cancer_cd.cancer_name = SUBSTRING_INDEX(tb_cancer.typ, '(', 1)
WHERE cname NOT LIKE '모든%' AND gender != '계' AND age != '계'
;

SELECT tb,
		gender,
        age,
        tb_cancer_age.cancer_ageid,
        y2019,
        y2020
FROM tb_cancer
JOIN tb_cancer_cd ON SUBSTRING_INDEX(tb_cancer.typ, '(', 1) = tb_cancer_cd.cancer_cdname
JOIN tb_cancer_age ON tb_cacner.age = tb_cancer_age.cancer_agename
WHERE tb_cancer.gender != '계' AND tb_cancer.age != '계'
;

DESC tb_cancer_age;
DESC tb_cancer_list;


INSERT INTO tb_cancer_list (cancer_cd, gender, cancer_ageid, y2019, y2020)
	SELECT SUBSTRING_INDEX(typ, '(', -1) AS cname, cancer_cd, gender, cancer_age,id y2019, y2020 
	FROM tb_cancer 
	JOIN tb_cancer_cd ON SUBSTRING_NDEX(tb_cancer.typ, '(', 1) = tb_cacner_cd.cancer_cdname
	JOIN tb_cancer_age ON tb_cancer.age = tb_cacner_age.cancer_agename
	WHERE tb_cancer.gender != '계' AND tb_cancer.age != '계'
	; # 여러 테이블에 같은 column이 있으면 '.'을 찍어서 어떤 테이블인지를 알려줘야한다.

-- 파이썬 연동을 위한 테이블 조인
SELECT tb_cancer_list.cancer_cd,
		tb_cancer_cd.cancer_cdname,
        tb_cancer_list.gender,
        tb_cancer_list.cancer_ageid,
        tb_cancer_age.cancer_agename,
        tb_cancer_list.y2019,
        tb_cancer_list.y2020
FROM tb_cancer_list 
JOIN tb_cancer_cd ON tb_cancer_list.cancer_cd = tb_cancer_cd.cancer_cd
JOIN tb_cancer_age ON tb_cancer_list.cancer_ageid = tb_cancer_age.cancer_ageid # 정렬을 위해 ageid가 필요함
ORDER BY tb_cancer_list.cancer_cd, tb_cancer_list.gender, tb_cancer_list.cancer_ageid
;



