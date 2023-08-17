-- 남자의 id, 키, 몸무게 추출
SELECT id, height, weight FROM tb_bmi
WHERE gender_code = 1;
-- 키가 180 이상인 사람 추출
SELECT * FROM tb_bmi
WHERE height >= 180;
-- 키가 170 이상이고 몸무게 90 이상인 사람 추출
SELECT * FROM tb_bmi
WHERE height >= 170 AND weight >= 90 ;
-- 몸무게 60, 80인 사람 추출
SELECT * FROM tb_bmi
WHERE weight IN (60,80) ;
-- 몸무게 60~80인 사람 추출
SELECT * FROM tb_bmi
WHERE weight BETWEEN 60 AND 80 ;
