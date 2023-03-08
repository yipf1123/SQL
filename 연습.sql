-- 1. system 계정 접속


-- 2.  계정 생성
--    - 계정명    : 'human_prac'  
--    - 비밀번호 : 123456

-- 계정 생성하기
-- 11g 은 세션 설정 없이 바로 계정 생성 가능
-- 12c 이상, 계정명 규칙 : 'c##계정명'  (c : common : 공통)
-- c## 없이 계정 생성


-- 3. 계정에 대한 용량 설정 
--     - 테이블스페이스 : 'users' 
--     - 용량 : 무한대



-- 4.  계정에 권한 부여
--     - 부여할 권한 DBA
-- 계정에 권한 부여 

-- 5. 'human_prac'  계정으로 접속

-- 6.  'human_user' 테이블 생성
--       - 컬럼1 :  'no'    	(타입: NUMBER,  기본키)
--       - 컬럼2 :  'name'	(타입: VARCHAR2(45), NOT NULL, 기본값: '이름없음' )
--       - 컬럼3 :  'reg_date'	(타입: DATE, NOT NULL, 기본값: sysdate )
--       - 컬럼4 :  'upd_date'	(타입: DATE, NOT NULL, 기본값: sysdate )

-- 기본키 : 중복값 불가, NULL 불가

-- 7. 'human_user' 테이블에 5행의 임의 데이터 추가하기


-- 기본값이 정해진 컬럼을 제외하고 작성
-- -> 컬럼명을 명시하지 않는 컬럼들은 기본값으로 추가된다

-- 컬럼명을 생략하고 작성
-- -> 값을 모든 컬럼에 대하여 전부 작성해야한다






-- 8. 'human_user' 테이블의 3번째 데이터에 'name' 속성을 '김휴먼'으로 수정하기
--     (이 때, upd_date 도 현재/날짜 시간으로 변경하기)


-- 9.  'human_user' 테이블에서 이름(name)이 김씨인 사람을 조회하기



-- 10. 'human_user' 테이블의 'name' 속성이 '김휴먼' 인 데이터 삭제하기

-- 11. 'human_user' 테이블의 모든 속성을 조회하기

-- 12. 'human_prac' 계정 삭제 
-- -> system 으로 접속, human_prac 접속 해제


-- DBA 권한을 가진 경우, 권한 해제 후 삭제







--1, 2, 3, 4, 5
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- 12c 이후 계정생성시 사용하는 규칙
CREATE USER human_prac IDENTIFIED BY 123456;
ALTER USER human_prac QUOTA UNLIMITED ON users;
GRANT DBA TO human_prac;

-- 6
CREATE TABLE HUMAN_USER 
(
  NO NUMBER NOT NULL 
, NAME VARCHAR2(45 BYTE) DEFAULT '이름없음' NOT NULL 
, REG_DATE DATE DEFAULT sysdate NOT NULL 
, UPD_DATE DATE DEFAULT sysdate NOT NULL 
, CONSTRAINT HUMAN_USER_PK PRIMARY KEY 
  (
    NO 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX HUMAN_USER_PK ON HUMAN_USER (NO ASC) 
      LOGGING 
      TABLESPACE USERS 
      PCTFREE 10 
      INITRANS 2 
      STORAGE 
      ( 
        BUFFER_POOL DEFAULT 
      ) 
      NOPARALLEL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NO INMEMORY 
NOPARALLEL;

----------------------------------
CREATE TABLE human_user(
    no number not null primary key,  -- 기본키 : 중복값 불가, NULL 불가 
    name varchar(45) default '이름없음' not null,
    reg_date date default sysdate not null,
    upd_date date default sysdate not null
                      );                      

-- 7
INSERT INTO human_user(no, name, reg_date, upd_date)
VALUES(1, '이은솔', sysdate, sysdate);

-- 기본값이 정해진 컬럼을 제외하고 작성
--  -> 컬럼명을 명시하지 않는 컬럼들은 기본값으로 추가된다
INSERT INTO human_user(no, name)
VALUES(2, '안이경');

-- 컬럼명을 생략하고 작성
-- -> 값을 모든 컬림에 대해 전부 작성해야 한다
INSERT INTO human_user
VALUES(3, '임현영', sysdate,sysdate);

INSERT INTO human_user(no, name, reg_date, upd_date)
VALUES(4, '김종화', sysdate,sysdate);

INSERT INTO human_user(no, name, reg_date, upd_date)
VALUES(5, '맘모스', sysdate,sysdate);

-- 8
UPDATE human_user
    SET name = '김휴먼'       
WHERE no = 3;

-- 9
SELECT *
FROM human_user
WHERE name LIKE '김%';

-- SUBSTR(name, 1, 1) = '김';

-- 10
DELETE FROM human_user WHERE name = '김휴먼';

-- 11
SELECT * FROM human_user;

-- 12
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--DBA 권한을 가진 경우, 권한 해제 후 삭제
REVOKE DBA from human-prac; 
DROP USER human_prac CASCADE;