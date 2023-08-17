USE workdb;

SELECT * FROM tb_cancer;

-- Unique한 항목 불러오기 (Distinct)
SELECT DISTINCT typ FROM tb_cancer
WHERE typ = '모든 암(C00-C96)';

SELECT DISTINCT typ FROM tb_cancer
WHERE typ NOT LIKE '모든%'
ORDER BY typ
;

-- 가지고 있는 데이터를 쪼개고 붙일 수 있는 작업이 중요하다.
-- RDB의 Query에도 주요 문자열 함수가 제공된다.
-- LEFT(), RIGHT(), SUBSTRING(), LENGTH(), CHAR_LENGTH()
CREATE TABLE tb_cancer_name AS
	SELECT DISTINCT typ FROM tb_cancer
	WHERE typ NOT LIKE '모든%'
;

SELECT * FROM tb_cancer_name;
DESC tb_cancer_name;
DESC tb_cancer;

-- 문자열 함수
SELECT typ, 
		LEFT(typ,4) AS LEFTTYPE ,
        RIGHT(typ,4) AS RIGHTTYPE ,
        SUBSTRING(typ,4,3) AS SUBSTRTYPE,
        LENGTH(typ) AS LENTYPE,
        CHAR_LENGTH(typ) AS CLENTYPE
FROM tb_cancer_name;

SELECT typ, 
        SUBSTRING(typ, CHAR_LENGTH(typ)-3,3) AS codeType
FROM tb_cancer_name
ORDER BY codeType; # 여기에는 새로 만든 변수를 ORDER로 활용할 수 있다.

-- 주요 문자열 함수-2
-- TRIM() : 공백 제거 / REPALCE() : 문자열 치환 / SUBSTRING_INDEX() : 특정 문자 기준으로 자름alter
-- CONCAT() : 잘라줌
SELECT TRIM(typ) AS trimType,
		SUBSTRING_INDEX(typ, '(', 1) AS splitTypeName,
        REPLACE(SUBSTRING_INDEX(typ, '(', -1), ')', '') AS splitTypeCd ## SUBSTRING_INDEX 결과에서 )를 빈칸으로 바꾸겠다
FROM tb_cancer_name
ORDER BY splitTypeCd;

SELECT REPLACE(SUBSTRING_INDEX(typ, '(', -1), ')', '') AS splitTypeCd ,
				SUBSTRING_INDEX(typ, '(', 1) AS splitTypeName,
                CONCAT(REPLACE(SUBSTRING_INDEX(typ, '(', -1), ')', ''),
                ':',
                SUBSTRING_INDEX(typ, '(', 1)
                ) AS concatType
FROM tb_cancer_name
ORDER BY splitTypeCd;

SELECT DISTINCT age FROM tb_cancer
WHERE age != '계';

DESC tb_cancer;




