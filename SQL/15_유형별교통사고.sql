-- DB 확인
SHOW DATABASES ;

-- DB선택
USE workdb ;

-- 테이블 확인
SHOW TABLES ;

-- 테이블구조 확인 
DESC taas_day2022 ;

DROP TABLE taas_day2022 ;

SELECT COUNT(*) FROM taas_day2022 ;

SELECT * 
FROM taas_day2022 
WHERE 사고일 LIKE '사고%' AND 사고월 IN ('11월', '12월')
;

-- 파이썬에서 cursor생성하여 처리  
-- CREATE TABLE IF NOT EXISTS taas_day_df (
-- 	id INT PRIMARY KEY AUTO_INCREMENT,
--     type1 VARCHAR(50),
--     type2 VARCHAR(50),
--     type3 VARCHAR(50),
--     tdate DATE,
--     tcnt INT
-- ) ;

-- INSERT INTO taas_day_df (type1, type2, type3, tdate,tcnt) 
-- VALUE ('','','','',0) 
-- ;
-- INSERT INTO taas_day_df (type1, type2, type3, tdate,tcnt)                   
-- VALUE ("차대사람","횡단중","사고","2022-01-06 00:00:00",43);

SELECT * FROM taas_day_df ;

-- 테이블 구조 확인
DESC taas_day_df ;

-- 테이블 수정 
ALTER TABLE taas_day_df
ADD COLUMN tmonth CHAR(2) ,
ADD COLUMN tweek INT ;

SELECT tdate , LPAD(MONTH(tdate),2,0) AS tm , DAYOFWEEK(tdate) AS tw
FROM taas_day_df ;

UPDATE taas_day_df 
SET tmonth = LPAD(MONTH(tdate),2,0) ,
	taas_day_type1taas_day_weektaas_day_type3taas_day_type2tweek = DAYOFWEEK(tdate)  ;

INSERT INTO taas_day_type1 (type1_name) 
	SELECT DISTINCT type1 
	FROM taas_day_df
;

SELECT * FROM taas_day_type1 ; 

INSERT INTO taas_day_type2 (type2_name) 
	SELECT DISTINCT type2 
	FROM taas_day_df
;

SELECT * FROM taas_day_type2 ; 

INSERT INTO taas_day_type3 (type3_name) 
	SELECT DISTINCT type3 
	FROM taas_day_df
;

SELECT * FROM taas_day_type3 ; 

INSERT INTO taas_day_week (week_name) VALUE ('일') ;
INSERT INTO taas_day_week (week_name) VALUES
	('월'), ('화'), ('수'), ('목'), ('금'), ('토');  

SELECT * FROM taas_day_week ;

DESC taas_day  ;

SELECT *
FROM taas_day_df ;

-- AUTO_INCREMENT 열의 키값을 1부터 다시 시작
ALTER TABLE taxname AUTO_INCREMENT = 1 ;

SELECT * FROM taas_day_df WHERE tdate = '2022-01-01' ;

INSERT INTO taas_day  
	SELECT taas_day_type1.type1_cd,
			taas_day_type2.type2_cd,
			taas_day_type3.type3_cd,
			taas_day_df.tdate,
			taas_day_df.tcnt,
			taas_day_df.tmonth,
			taas_day_df.tweek
	FROM taas_day_df
	JOIN taas_day_type1 ON taas_day_type1.type1_name = taas_day_df.type1
	JOIN taas_day_type2 ON taas_day_type2.type2_name = taas_day_df.type2
	JOIN taas_day_type3 ON taas_day_type3.type3_name = taas_day_df.type3 
;

SELECT * FROM taas_day  ;

CREATE VIEW taas_day_vw AS
SELECT taas_day_type1.type1_name,
			taas_day_type2.type2_name,
			taas_day_type3.type3_name,
			taas_day.tdate,
			taas_day.tcnt,
			taas_day.tmonth,
			taas_day_week.week_name
	FROM taas_day 
	JOIN taas_day_type1 ON taas_day_type1.type1_cd = taas_day.type1_cd
	JOIN taas_day_type2 ON taas_day_type2.type2_cd = taas_day.type2_cd
	JOIN taas_day_type3 ON taas_day_type3.type3_cd = taas_day.type3_cd 
    JOIN taas_day_week ON taas_day_week.week_cd = taas_day.week_cd 
;

SELECT * FROM taas_day_vw ;

