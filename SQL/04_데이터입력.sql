-- DB 선택
USE workdb;

-- Table 생성
DROP TABLE health ;
CREATE TABLE tb_health(
   id INT AUTO_INCREMENT PRIMARY KEY,
    시도코드 INT,
    성별코드 INT,
   연령코드 INT,
    허리둘레 FLOAT,
    수축기혈압 INT,
    이완기혈압 INT,
    공복혈당 INT,
    트리글리세라이드 INT,
    HDL콜레스테롤 INT
);

-- Table 확인
SHOW TABLES ;

-- 데이터 입력 (C)
INSERT INTO tb_health
VALUE (1, 36, 1, 9, 72.1, 127, 79, 90, 58, 58);

INSERT INTO tb_health (시도코드, 성별코드)
VALUES(36,1) ;

-- 데이터 확인(R)
SELECT * FROM tb_health;

-- 데이터 수정(U)
UPDATE tb_health
SET 연령코드 = 10 ; # 이렇게 하면 모든 연령 코드가 10으로 바뀜. 그래서 Preferences에서 체크를 해두는것

UPDATE tb_health
SET 연령코드 = 9
WHERE id=1; # 이렇게 해야 id=1만 연령 코드가 바뀐다.

-- 데이터 삭제(D)
DELETE FROM tb_health
WHERE id=2 ;

# 이제 데이터를 tb_health에 넣자
-- 데이터 불러오기 확인
SELECT COUNT(*)
FROM tb_health;

-- 테이블 column 추가
ALTER TABLE tb_health
ADD COLUMN 고혈압 INT,
ADD COLUMN 고혈당 INT,
ADD COLUMN 중성지방 INT,
ADD COLUMN 저콜레스테롤 INT,
ADD COLUMN 복부비만 INT,
ADD COLUMN 대사증후군 INT,
ADD COLUMN 판별 VARCHAR(10) ;

-- 테이블 구조 확인
DESC tb_health;
SELECT * FROM tb_health;

-- 테이블 수정
UPDATE tb_health
SET 고혈압 = CASE
			WHEN 수축기혈압 >= 130 AND 이완기혈압 >= 85 THEN 1
			ELSE 0
			END
;

UPDATE tb_health
SET 고혈당 = CASE
			WHEN 공복혈당 >= 100 THEN 1
			ELSE 0
			END
;

UPDATE tb_health # 3개 항목 한번에 업데이트
SET 중성지방 = CASE
			WHEN 트리글리세라이드 >= 150 THEN 1
			ELSE 0
			END,
저콜레스테롤 = CASE
			WHEN ((성별코드=1) AND (HDL콜레스테롤 <40)) OR ((성별코드=2) AND (HDL콜레스테롤 <50)) THEN 1
			ELSE 0
			END,
복부비만 = CASE
			WHEN ((성별코드=1) AND (허리둘레 >90)) OR ((성별코드=2) AND (허리둘레 >85)) THEN 1
			ELSE 0
			END
;

UPDATE tb_health
SET 대사증후군 = 고혈압 + 고혈당 + 중성지방 + 복부비만 + 저콜레스테롤,
판별 = CASE
		WHEN 대사증후군=0 THEN '정상'
		WHEN 대사증후군<=2 AND 대사증후군>0 THEN '주의군'
        ELSE '위험'
        END 
;

-- 대사 증후군이 많은 순서대로 정렬
SELECT CASE 성별코드 WHEN 1 THEN "남자"
					ELSE "여자"
					END AS 성별
			, 대사증후군, 판별
FROM tb_health
ORDER BY 대사증후군 DESC, 성별코드;

-- 성별에 따라 판별 결과가 30개 이상인 경우만 선택
SELECT CASE 성별코드 WHEN 1 THEN "남자"
					ELSE "여자"
					END AS 성별
		, 판별, COUNT(*) AS 인원수
FROM tb_health
GROUP BY 성별, 판별
HAVING 인원수  >= 30
ORDER BY 성별,
	CASE 판별 WHEN '정상' THEN 1
			WHEN '위험군' THEN 2
			ELSE 3
    END
;


-- workdb에 AGE TABLE 추가
DESC tb_age;

ALTER TABLE tb_age
CHANGE COLUMN 연령대 연령대 VARCHAR(10) ;

SELECT * FROM tb_age ; 

-- SIDO TABLE
desc TB_SIDO ;

ALTER TABLE tb_sido
CHANGE COLUMN 시도명 시도명 VARCHAR(20) ;

SELECT * FROM tb_sido; 
