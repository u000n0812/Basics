-- 교통사고 데이터
SELECT * FROM taas_data;

-- 데이터 분석
-- type1 종류
SELECT DISTINCT type1 FROM taas_data
WHERE type1 != '전체사고'
;

-- type2 종류
SELECT DISTINCT type2 FROM taas_data
WHERE type2 != '전체사고'
;

INSERT INTO taas_type1 (type1_name)
	SELECT DISTINCT type1 FROM taas_data WHERE type1 != '전체사고'
;
INSERT INTO taas_type2 (type2_name)
	SELECT DISTINCT type2 FROM taas_data WHERE type2 != '전체사고'
;

SELECT * FROM taas_type2;

INSERT INTO taas_year_tb
	SELECT  "2018",
			taas_type1.type1_cd,
			taas_type2.type2_cd,
			taas_data.y2018
	FROM  taas_data
	JOIN taas_type1 ON taas_data.type1 = taas_type1.type1_name
	JOIN taas_type2 ON taas_data.type2 = taas_type2.type2_name
;


-- Stored Procedure : SQL 문을 논리 단위로 묶어 저장한 object
-- 자주 쓰는 쿼리 문장을 함수 형태로 만드는 것
-- 함수 형태로 사용
DELIMITER $$
CREATE PROCEDURE input_year_data (IN ty CHAR(4))
BEGIN 
	SELECT * FROM taas_data ;
END $$
DELIMITER ; # 세미 콜론(;)을 2개 이상 쓰면 프로르램이 헷갈려함. 그래서 delimiter 사용

CALL input_year_data() ; # 스토어드 프로시져 불러오기

 