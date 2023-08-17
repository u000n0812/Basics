--  테이블 생성
-- INT : 정수형 / AUTO_INCREMENT : 수치를 자동으로 하나씩 올려줌 / PRIMARY KEY:  
-- CHAR(i) : i자리 문자열 / 
USE workdb;

CREATE TABLE tb_bmi (
	id INT AUTO_INCREMENT PRIMARY KEY,
    gender_code CHAR(1),
	height FLOAT,
    weight FLOAT
);
-- PRIMARY KEY 값을 AUTO_INCREMENT로 줬기 떄문에 id 변수는 자동으로 계속 하나씩 증가한다.
-- 테이블 삭제
-- DROP TABLE tb_bmi ;

-- 테이블 구조 확인
DESC tb_bmi ;

-- CRUD(C) : 새로운 행을 추가
INSERT INTO tb_bmi (gender_code, height, weight)
VALUES ('1', 170, 80) ;

-- CRUD(R) : 자료 읽어오기
SELECT * FROM tb_bmi ;

-- CRUD(U) : 자료 수정
UPDATE tb_bmi
SET gender_code = '1'
WHERE id = 4 ; 

-- CRUD(D) : 자료 삭제
DELETE FROM tb_bmi
WHERE id = 3;

DELETE FROM tb_bmi;

-- CSV 데이터 불러오기 : Schemas 탭에서 DB 선택하고 Table에서 오른쪽 마웃으 눌러 메뉴 선택(Table Data import)
-- 데이터 확인
SELECT * FROM tb_bmi;