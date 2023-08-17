SHOW DATABASES;
USE workdb;
SHOW TABLES;

-- 테이블 자료 확인
DESC tass_day2022;
SELECT * FROM tass_day2022;

SELECT * FROM tass_day2022
WHERE 사고일 LIKE '사고%' and 사고월 IN ('07월', '08월')
ORDER BY '01일' 
;

-- 파이썬에서 데이터를 핸들링해보자
DROP TABLE tass_day2022;


