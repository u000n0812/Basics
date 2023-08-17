USE workdb;

-- 테이블 생성
DROP TABLE A;
CREATE TABLE A (
	id INT PRIMARY KEY,
	item VARCHAR(10)
);

CREATE TABLE B (
	id INT PRIMARY KEY,
	item VARCHAR(10)
);

-- CRUD(C)
INSERT INTO A VALUES (1, '사과') ;
INSERT INTO A VALUES (2, '바나나') ;
INSERT INTO A VALUES (3, '수박') ;

INSERT INTO B VALUES (3, '오징어') ;
INSERT INTO B VALUES (4, '문어') ;
INSERT INTO B VALUES (5, '한치') ;

SELECT * FROM A;
SELECT * FROM B;

-- JOIN
-- 관계형 데이터베이스는 반드시 JOIN에 대한 개념이 필요하다.
SELECT A.id, A.item AS 과일, B.item AS 기타 FROM A
JOIN B # JOIN의 기본은 INNER JOIN이다. 여기서 INNER를 붙여도 결과는 똑같음
ON A.id = B.id ;

SELECT A.id, A.item AS 과일, B.item AS 기타 FROM A
LEFT JOIN B 
ON A.id = B.id ;

SELECT * FROM A
LEFT JOIN B
ON A.id = B.id
WHERE B.id IS NULL; # A에 있는 거만 보겠다

SELECT B.id, B.item AS 기타, A.item AS 과일 FROM A
RIGHT JOIN B
ON A.id = B.id
WHERE A.id IS NULL
;

SELECT B.id, B.item AS 기타 FROM B
LEFT JOIN A
ON A.id = B.id
WHERE A.id IS NULL
;
SELECT * FROM tb_health;
DROP TABLE sido;
CREATE TABLE tb_age (
	연령코드 INT,
    나이 VARCHAR(10)
);
CREATE TABLE tb_sido (
	시도코드 INT,
    시도명 VARCHAR(10)
);

SELECT * FROM tb_health
INNER JOIN tb_sido
ON tb_health.시도코드 = tb_sido.시도코드
;

CREATE TABLE tb_health_sido AS
SELECT tb_sido.시도명 AS 시도명, TB_HEALTH.판별 AS 판별, COUNT(*) AS 인원수
FROM tb_health
INNER JOIN tb_sido
ON tb_health.시도코드 = tb_sido.시도코드
GROUP BY 시도명, 판별
ORDER BY 시도명,
	CASE 판별
	WHEN '정상' THEN 1
    WHEN '주의군' THEN 2
    ELSE 3
    END
;

SELECT * FROM tb_health_sido ;

-- 테이블 구조 확인
DESC tb_health_sido;

-- 테이블 구조 변경
ALTER TABLE tb_health_sido
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE tb_health_sido
CHANGE COLUMN 인원수 인원수 INT ; # 인원수가 원래 BIG INT였는데 INT로 구조를 바꿔줌

-- 시도별 인원수
SELECT * FROM tb_health_sido;
SELECT 시도명, SUM(인원수) FROM tb_health_sido
GROUP BY 시도명
;

SELECT 시도명, SUM(인원수) AS 인원 FROM tb_health_sido
GROUP BY 시도명 ;

-- 암발생률 자료 가져오기
USE workdb;
CREATE TABLE tb_cancer (
	typ VARCHAR(20),
    gender VARCHAR(20),
    age VARCHAR(20),
    y2019 INT,
    y2020 INT
)
;
ALTER TABLE tb_cancer
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
SELECT * FROM tb_cancer;

CREATE TABLE tb_cancer_c00 AS
SELECT id, age, y2019, y2020 FROM tb_cancer
WHERE typ LIKE '모든 암%' AND gender = '계' AND age != '계' ; 
SELECT * FROM tb_cancer_c00 ; 

SELECT age, (y2020-y2019) AS increment FROM tb_cancer_c00
WHERE (y2020-y2019) > 0
ORDER BY increment DESC
;

ALTER TABLE tb_cancer_c00
ADD age_step VARCHAR(20) ;
desc tb_cancer_c00 ;

UPDATE tb_cancer_c00
SET age_step = CASE age
				WHEN '0-4세' THEN '30세 미만'
                WHEN '5-9세' THEN '30세 미만'
                WHEN '10-14세' THEN '30세 미만'
                WHEN '15-19세' THEN '30세 미만'
                WHEN '20-24세' THEN '30세 미만'
                WHEN '25-29세' THEN '30세 미만'
                WHEN '30-34세' THEN '30대~40대'
                WHEN '35-39세' THEN '30대~40대'
                WHEN '40-44세' THEN '30대~40대'
                WHEN '45-49세' THEN '30대~40대'
                WHEN '50-54세' THEN '50대~60대'
                WHEN '55-59세' THEN '50대~60대'
                WHEN '60-64세' THEN '50대~60대'
                WHEN '65-69세' THEN '50대~60대'
                ELSE '70세 이상'
				END
;
SELECT age_step, sum(y2020) AS 발생자수 FROM tb_cancer_c00
GROUP BY age_step
;