-- DB
USE workdb ;

-- 교통사고 데이터
SELECT * FROM tass_data ;

-- 데이터 분석
-- type1 종류
SELECT DISTINCT type1 FROM tass_data WHERE type1 != '전체사고';
 
-- type2 종류
SELECT DISTINCT type2 FROM tass_data WHERE type1 != '전체사고';

-- type1 입력
INSERT INTO taas_type1 (type1_name) 
	SELECT DISTINCT type1 FROM tass_data WHERE type1 != '전체사고';
SELECT * FROM taas_type1 ;

-- type2 입력
INSERT INTO taas_type2 (type2_name) 
	SELECT DISTINCT type2 FROM tass_data WHERE type1 != '전체사고';
SELECT * FROM taas_type2 ;


SELECT  "2018",
			taas_type1.type1_cd , 
			taas_type2.type2_cd ,
			tass_data.y2018
	FROM tass_data 
	JOIN taas_type1 ON tass_data.type1 = taas_type1.type1_name
	JOIN taas_type2 ON tass_data.type2 = taas_type2.type2_name
;


INSERT INTO taas_year_tb 
	SELECT  "2018",
			taas_type1.type1_cd , 
			taas_type2.type2_cd ,
			tass_data.y2018
	FROM tass_data 
	JOIN taas_type1 ON tass_data.type1 = taas_type1.type1_name
	JOIN taas_type2 ON tass_data.type2 = taas_type2.type2_name
;
SELECT * FROM taas_year_tb ;



-- 뷰생성 
CREATE VIEW taas_year_vw AS
	SELECT  taas_year_tb.taas_year,
			taas_year_tb.taas_type1,
			taas_type1.type1_name,
			taas_year_tb.taas_type2,
			taas_type2.type2_name,
			taas_year_tb.taas_cnt
	FROM taas_year_tb 
	JOIN taas_type1 ON taas_year_tb.taas_type1 = taas_type1.type1_cd
	JOIN taas_type2 ON taas_year_tb.taas_type2 = taas_type2.type2_cd
;

SELECT * FROM taas_type2;



-- 스토어드 프로시저 
DELIMITER $$
CREATE PROCEDURE select_type2(IN t2 VARCHAR(20))
BEGIN
	SELECT taas_year, type1_name, type2_name, taas_cnt
	FROM taas_year_vw 
	WHERE type2_name = t2 
	;
END $$
DELIMITER ;

-- 프로시저 호출
CALL select_type2('사고건수') ; 
CALL select_type2('사망자') ; 
CALL select_type2('부상자') ; 


-- 연도별 자료 스토어드 프로시저 
DELIMITER //
CREATE PROCEDURE input_year_data(IN taas_y CHAR(4)) 
BEGIN
	INSERT INTO taas_year_tb 
		SELECT  taas_y AS tyear,
				taas_type1.type1_cd , 
				taas_type2.type2_cd ,
				CASE taas_y
					WHEN "2018" THEN tass_data.y2018
                    WHEN "2019" THEN tass_data.y2019
                    WHEN "2020" THEN tass_data.y2020
                    WHEN "2021" THEN tass_data.y2021
                    WHEN "2022" THEN tass_data.y2022
				END
		FROM tass_data 
		JOIN taas_type1 ON tass_data.type1 = taas_type1.type1_name
		JOIN taas_type2 ON tass_data.type2 = taas_type2.type2_name
	;
END //
DELIMITER ;

CALL input_year_data("2019") ;

SELECT * FROM taas_year_tb ;

-- 연도별 데이터 입력 프로시저
DROP PROCEDURE call_year_data ;
DELIMITER //
CREATE PROCEDURE call_year_data() 
BEGIN
	-- 변수 선언
    DECLARE y CHAR(4) ;
    -- 변수 값 할당(초기값)
    SET y = "2020" ;
    
    -- 반복문
    WHILE y <= "2022" DO 
		CALL input_year_data(y);
        SET y = y + 1 ;
    END WHILE;
END //
DELIMITER ;

CALL call_year_data()  ;

SELECT * FROM taas_year_tb ;

-- 뷰조회
SELECT * FROM  taas_year_vw ;

SELECT type1_name , sum(taas_cnt) AS scnt
FROM  taas_year_vw
WHERE type2_name = '사고건수'
GROUP BY type1_name
;