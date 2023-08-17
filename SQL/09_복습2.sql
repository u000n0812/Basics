USE workdb;

SELECT * FROM taxorigin ;

INSERT INTO taxname (tax_name) # taxname 테이블에 tax_name
	SELECT DISTINCT 세목명
    FROM taxorigin
    ORDER BY 세목명
;

SELECT * FROM taxname;

-- 납무 매체
INSERT INTO taxpay (pay_name)
	SELECT DISTINCT 납부매체
    FROM taxorigin
    ORDER BY 납부매체 
;
    
-- 납부내역
DESC taxpayer;
INSERT INTO taxpayer (tax_cd, pay_cd, electronic, cnt, amt, taxyear)
	SELECT taxorigin.세목명,
			tax_cd,
			taxorigin.납부매체,
			pay_cd,
			taxorigin.납부매체전자고지여부,
			taxorigin.납부건수,
			taxorigin.납부금액,
			taxorigin.납부년도
	FROM taxorigin
	JOIN taxname ON taxorigin.세목명 = taxname.tax_name
	JOIN taxpay ON taxorigin.납부매체 = taxpay.pay_name
;

SELECT * FROM taxpayer;    

-- 등록세 납무 매체별 납부금액이 큰 순으로 나열
SELECT tax_name, pay_name, cnt, amt 
FROM taxpayer
JOIN taxname ON taxpayer.tax_cd = taxname.tax_cd
JOIN taxpay ON taxpayer.pay_cd = taxpay.pay_cd
WHERE taxname.tax_name = '등록세'
ORDER BY amt DESC
;

-- 
SELECT cnt, tax_name, pay_name, amt 
FROM taxpayer
JOIN taxname ON taxpayer.tax_cd = taxname.tax_cd
JOIN taxpay ON taxpayer.pay_cd = taxpay.pay_cd
WHERE pay_name = '자동화'
ORDER BY cnt DESC
;

-- 
SELECT tax_name, pay_name, SUM(cnt) AS scnt, SUM(amt) AS samt 
FROM taxpayer
JOIN taxname ON taxpayer.tax_cd = taxname.tax_cd
JOIN taxpay ON taxpayer.pay_cd = taxpay.pay_cd
GROUP BY tax_name, pay_name
HAVING samt <= 100000 # GROUP BY 이후에 조건이 걸릴 때는 HAVING 사용. WHERE는 GROUP BY 앞에서 쓸 수 있다
;


