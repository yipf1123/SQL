
-- 데이터 조회 명령어 - SELECT
-- SELECT 컬럼명,...
-- FROM 테이블명;
-- WHERE 조건;


-- 02
SELECT USER_ID, USERNAME
FROM ALL_USERS
WHERE USERNAME = 'HR';

-- HR(인사과리 정보) 샘플 데이터를 가져와서 실습
-- HR 계정이 없는 경우, HR계정 생성

-- HR 계정 생성하기
-- 11g 버전 이하는 어떤 이름으로도 계정생성 가능
-- 12c 버전 이상에서는 'c##' 접두어 붙여서 생성하도록 규칙을 정함

-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;
--계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한 부여
GRANT connect, resource to HR;

-- 계정 삭제
DROP USER HR CASCADE;


-- HR 계정이 잠겨 있는 경우,
-- HR 계정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;


-- hr_main.sql 실행하여 HR 샘플 데이터 가져오기
-- 1. SQL PLUS
-- 2. HR 계정으로 접속
-- 3. 명령어 입력 : @[경로]\hr_main.sql
--      @?  : @?/demo/schema/human_resources/hr_main.sql
--> 1.  : 123456[비밀번호]
--> 3.  : users [tablespace] 테이블 분류하는 영역
--> 3.  : temp [temp tablespce] 임시 테이블 영역(긴급시 사용하는)  
--> 4.  : [log 경로] - C:\human\SETUP\WINDOWS.X64_193000_db_home\demo\schema\log


-- 03
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오
-- 테이블 : 행과 열로 데이터를 관리하는 기본 구조
-- 행 = row = 레코드   : 각 속성에 대한 하나의 데이터를 의미
-- 열 = column = 속성  : 데이터 이름(특성)을 정의
DESC employees;

-- 04
-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름)을
-- 조회하는 SQL 문을 작성하시오.
SELECT employee_id, first_name
FROM employees;


-- 04
-- AS (alias ): 출력되는 컬럼명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호" --띄어쓰기가 있므면, " 로 표기
    ,first_name AS 이름
    ,last_name AS 성
    ,email AS 이메일
    ,phone_number AS 전화번호
    ,hire_date AS 입사일자
    ,salary AS 급여
    FROM employees;
    
-- 05
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고
-- 조회하는 SQL 문을 작성하시오.

SELECT DISTINCT job_id
FROM employees;

SELECT job_id
FROM employees;

-- 06
-- 테이블 EMPLOYEES의 SALARY(급여)가 6000을 초과하는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오

SELECT *
FROM employees
WHERE SALARY > 6000;

-- 07
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE SALARY = 10000;


-- 08
-- 테이블 EMPLOYEES 의 모든 속성들을
-- SALARY 를 기준으로 내림차순 정렬하고,
-- FIRST_NAME 을 기준으로 올므차순 정렬하여 조회하는 SQL 문을 작성하시오

-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC]
-- * ASC    : 오름차순
-- * DESC   : 내림차순
-- * (생략)  : 오름차순이 기본값

SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 09
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

-- 10
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT', 'IT_PROG');

-- 11
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
-- 단, IN 키워드를 사용하시오.
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT', 'IT_PROG');

-- 12
-- 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE job_id = 'IT_PROG'  and SALARY >= 6000;

-- 13
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- LIKE
-- : 대체 문자를 통해서 형식에 맞는 문자열 데이터를 조회
-- * % : 여러 글자 대체
-- * _ : 한 글자 대체

SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘s’로 끝나는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 

SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15
-- 테이블 EMPLOYEES 의 FIRST_NAME 에 ‘s’가 포함되는
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE first_name LIKE'_____';

-- LENGTH(컬럼명) : 글자 수를 반환하는 함수 
SELECT *
FROM employees
WHERE (first_name) = 5;

-- 17
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE hire_date >= '04/01/01';

-- 20
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31';

SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';
  
-- 21
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를
-- 계산하는 SQL 문을 각각 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
-- CEIL() "천장"
-- : 지정한 값보다 크거나 같은 정수 중 제일 작은 수를 반환하는 함수
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;

SELECT CEIL(12.45), CEIL(-12.45) FROM dual; 

-- 22
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를
-- 계산하는 SQL 문을 각각 작성하시오.
-- FLOOR() "바닥"
-- : 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual; 

SELECT FLOOR(12.55),FLOOR(-12.55) FROM dual;


-- 23
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오.
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD( A, B)
-- : A를 B 로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지
SELECT MOD(30, 4) FROM dual;

-- 25
-- POWER(A, B)
-- : A의 B 제곱을 구하는 함수
-- 2의 10제곱을 구하시오.
SELECT POWER(2, 10) FROM dual;

-- 2의 31제곱을 구하시오.
SELECT POWER(2, 31) FROM dual;

-- 26
-- SQRT(A)
-- : A의 제곱근을 구하는 함수
-- A는 양의 정수와 실수만 사용 가능
-- 2의 제곱근을 구하시오.
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100) FROM dual;

-- 27
-- 소수점을 절삭하기
-- TRUNC(A, B)
-- : 값 A 를 자리수 B 에서 절삭하는 함수
-
- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28 
-- ABS()
--  -20 의 절댓값을 구하시오.
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값을 구하시오
SELECT ABS(-12.456) FROM dual;


-- 29
-- 문자열 대소문자 변환함수
SELECT 'AlOhA WoRlD~!' AS 원문
    ,UPPER('AlOhA WoRlD~!') AS 대문자
    ,LOWER('AlOhA WoRlD~!') AS 소문자
    ,INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;

-- 30
-- 글자 수와 바이트를 구하는 함수
-- AS (alias ): 출력되는 컬럼명에 별명을 짓는 명령어
-- 띄어쓰기가 있므면, " 로 표기
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
    ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
    ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31 
-- 두 문자열을 연결하기
SELECT CONCAT( 'ALOHA','WORLD') AS "함수"
    ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;

-- 32
-- 문자열 부분 출력함수
-- SUBSTR( 문자열, 시작번호, 글자수)
-- 'www.alohacampus.com'
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
     ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
     ,SUBSTR('www.alohacampus.com', 17, 3) AS "3"
     ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
     
FROM dual;

-- 영문과 숫자는 동일하게 1바이트라 바이트로 해도 똑같은 값이 나온다!
SELECT SUBSTRB ('www.alohacampus.com', 1, 3) AS "1"
     ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
     ,SUBSTRB('www.alohacampus.com', 17, 3) AS "3"
     ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
     
FROM dual;

-- 'www.알로하캠퍼스.com'
-- SUBSTR, SUBSTRB 함수로 각각. 구분기호로 나누어서 출력해보세요

SELECT SUBSTR('www.알로하캠퍼스.com', 1, 3) AS "1"
     ,SUBSTR('www.알로하캠퍼스.com', 5, 6) AS "2"
     ,SUBSTR('www.알로하캠퍼스.com', 12, 3) AS "3"
    
FROM dual;

SELECT SUBSTRB ('www.알로하캠퍼스.com', 1, 3) AS "1"
     ,SUBSTRB('www.알로하캠퍼스.com', 5, 18) AS "2"
     ,SUBSTRB('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

-- 33
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR( 문자열, 찾을 문자, 시작 번호, 순서)
-- ex) 'ALOHACAMPUS'
-- 해당 문자열에서 2번째 A 의 위치를 구하시오.
-- INSTR('ALOHACAMPUS', 'A', 1, 2)

SELECT INSTR ('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR ('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR ('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;

-- 34
-- 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 함수
-- LPAD(문자열, 칸의 수 , 채울 문자)
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움

-- RPAD(문자열, 칸의 수 , 채울 문자)
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움

SELECT LPAD('ALOHACAMPUS', 20, '#') AS "왼쪽"
    ,RPAD('ALOHACAMPUS', 20, '#') AS "오른쪽"
FROM dual;

-- 35 (교재 140p)
-- HIRE_DATE 입사일자를 날짜형식으로 지정하여 출력하시오.
-- TO_CHAR(데이터, '날짜 형식' )
-- : 특정 데이터를 문자열 형식으로 변환하는 함수

SELECT  first_name AS 이름 
    ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees;

-- 36 (교재 142p)
-- SALARY 급여의 통화형식을 지정하여 출력하시오.
SELECT first_name AS 이름
    ,TO_CHAR(salary, '$999,999,999.00') AS 급여
FROM employees;

-- 37
-- TO_DATE (데이터)
-- 문자형 데이터를 날짜형 데이터로 변환하는 함수
SELECT 20230228 AS 문자
     ,TO_DATE(20230228) AS 날짜
FROM dual;

-- 38
-- TO_NUMBER(데이터)
-- 문자형 데이터를 숫자형 데이터로 변환하는 함수
SELECT '1,200,000' AS 문자
    ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

-------------

SQL 명령어
분류
 데이터 정의어(DDL)
    : DB의 객체를 생성, 수정, 삭제하는 명령
    *객체 :  테이블, 사용자, 뷰 시퀀스 , 인덱스 ...
    * CREATE, ALTER, DROP

 데이터 조작어
    :DB의 데이터를 조회, 추가, 수정, 삭제하는 명령
    * SELECT, INSERT, UPDATE, DELETE
    
 데이터 제어어
    : 변경 사항을 적용 또는 되돌리거나, 권한을 부여하고 제거하는 명령
    * COMMIT,ROLLBACK,GRANT,REVOKE
    
    
SELECT 컬럼명1, 컬럼명2.....
FROM 테이블명
WHERE 조건
GROUP BY [그룹기준 컬럼] HAVING[그룹 조건]
ORDER BY [정렬기준 컬럼][ASC/DESC]
;

▶ SELECT 실행 순서
 FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY

-------------------------

-- 39
-- 어제, 오늘, 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 2023/03/02 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터 --> 문자 데이터 변화
SELECT sysdate FROM dual;

SELECT TO_CHAR( sysdate-1, 'YYYY/MM/DD') AS 어제
      ,TO_CHAR( sysdate, 'YYYY/MM/DD') AS 오늘
      ,TO_CHAR( sysdate+1, 'YYYY/MM/DD') AS 내일
FROM dual;

-- 40
-- 사원의 근무달수와 근속연수를 구하시오.
-- MONTHS_BETWEEN(A,B)
-- 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
-- (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)
-- TRUNC : 소수점 절삭하기 : 안쓰면 기본이 0 이므로 정수로 나옴
-- CONCAT('','') , || : 두 문자열 연결하는 함수 
-- 한 칸띄우고 쓰면 AS 쓰는거랑 동일하게 나옴
SELECT first_name 이름
      ,TO_CHAR(hire_Date , 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(sysdate , 'YYY.MM.DD') 오늘
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12) || '년' 근속연수      
FROM employees;

-- 41
-- 오늘로부터 6개월 후의 날짜를 구하시오.
-- ADD_MONTHS( 날짜, 개월 수 )
-- : 지정한 날짜로부터 해당 개월 수 후의 날짜를 반환하는 함수
SELECT SYSDATE 오늘
    ,ADD_MONTHS(sysdate, 6) "6개월후"
FROM dual;

-- 42
-- 오늘 이후 돌아오는 토요일을 구하시오
-- NEXT_DAY(날짜, 요일)
-- : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3 4  5  6  7
SELECT sysdate 오늘
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;

SELECT '2023/02/27' "DB 1일차"
     ,NEXT_DAY( sysdate,1) "다음 일요일"
     ,NEXT_DAY( sysdate,2) "다음 월요일"
     ,NEXT_DAY( sysdate,3) "다음 화요일"
     ,NEXT_DAY( sysdate,4) "다음 수요일"
     ,NEXT_DAY( sysdate,5) "다음 목요일"
     ,NEXT_DAY( sysdate,6) "다음 금요일"
     ,NEXT_DAY( sysdate,7) "다음 토요일"
FROM dual;    

-- 43
-- 오늘 날짜와 해당 월의 월초, 월말 일자를 구하시오.
-- LAST_DAY(날짜)
-- : 지정 한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : XXXXXX.YYYYYY
-- 1970년 01월 01일 00시00분00초00ms → 2023년3월02일 .....
-- 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- xxxxx.yyyyy --> 2023년 3월 20일
-- 월 단위 아래로 절삭하면, 일 단위가 1로 리셋 되므로 월초를 구할 수 있다.
SELECT sysdate 오늘
     , TRUNC( sysdate, 'MM') 월초
     , LAST_DAY(sysdate) 월말 
FROM dual;

SELECT '23/04/20' 오늘
     , TRUNC(TO_DATE('23/04/20'), 'MM') 월초
     , LAST_DAY(TO_DATE('23/04/20')) 월말 
FROM dual;

-- 44
-- 테이블 EMPLOYEES 의 COMMISSIM_PCT 를 중복없이 검색하되,
-- NULL 이면 0으로 조회하고 내림차순으로 정렬하는 SQL 문을 작성하시오.

-- NVL( 값, 대체할 값) : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC;

SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC;

-- SELECT 실행 순서가 ... → SELECT → ORDER BY 이므로
-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다

-- 45
-- EMPLOYEES의 FIRST_NAME, SALARY, COMMISION_PCT 속성을 이용하여
-- 급여, 커미션, 최종급여를 조회하시오.
-- *최종급여 = 급여 + (급여 * 커미션)
-- NVL2( 값, NULL이 아닌 때 값, NULL일 때 값)
SELECT first_name 이름
     , salary 급여
     , NVL(commission_pct, 0) 커미션    
     , NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여
FROM employees
ORDER BY 최종급여 DESC;    


-- 46
-- DEPARTMENTS 테이블을 참조하여, 사원의 이름과 부서명을 출력하시오.
-- DECODE( 컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ...)
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
SELECT first_name 이름
    , DECODE(department_id, 10,'Administration',
                            20,'Marketing',
                            30,'Puchasing',
                            40,'Human Resources',
                            50,'shipping',
                            60,'IT',
                            70,'Public Relations',
                            80,'Sales',
                            90,'Executive',
                            100,'Finance'
    ) 부서   
FROM employees;

47
-- CASE 문
-- : 조건식을 만족할 때, 출력할 값을 지정하는 구문
/*
    CASE
        WHEN 조건식1 THEN 반환값1
        WHEN 조건식2 THEN 반환값2
        WHEN 조건식3 THEN 반환값3
        ...
    END
*/
SELECT first_name 이름
    ,CASE WHEN department_id =10 THEN 'Administration'
          WHEN department_id =20 THEN 'Marketing'
          WHEN department_id =30 THEN 'Puchasing'
          WHEN department_id =40 THEN 'Human Resources'
          WHEN department_id =50 THEN 'shipping'
          WHEN department_id =60 THEN 'IT'
          WHEN department_id =70 THEN 'Public Relations'
          WHEN department_id =80 THEN 'Sales'
          WHEN department_id =90 THEN 'Executive'
          WHEN department_id =100 THEN 'Finance'
    END 부서
FROM employees;
    
-- 48
-- EMPLOTEES 테이블로 부터 전체 사원 수를 구하시오.
-- count( 컬럼명)
-- : 컬럼을 지정하여 null 을 제외한 데이터 개수를 반환하는 함수
-- * null 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
-- COUNT(*)로 개수로 구한다. 
SELECT COUNT(commission_pct) 사원수
FROM employees;

-- 49
-- 사원들의 최고급여와 최저급여를 구하시오.
SELECT MAX(salary) 최고급여
     , MIN(salary) 최저급여
FROM employees;

-- 50
-- 사원들의 급여 합계와 평균을 구하시오.
SELECT SUM(salary) 급여합계
     , ROUND(AVG(salary), 2) 급여평균
FROM  employees;

-- 51
-- 사원들의 급여 표준편차와 분산을 구하시오.
SELECT ROUND (STDDEV(salary), 2) 급여표준편차
     , ROUND(VARIANCE(salary), 2) 급여분산
FROM  employees;   


-- 52
-- MS_STUDENT 테이블을 생성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명(
        컬럼명1 타입 [NOT NULL/NULL] [제약조건],
        컬럼명2 타입 [NOT NULL/NULL] [제약조건],
        컬럼명3 타입 [NOT NULL/NULL] [제약조건],
        ...
    );
*/
-- * 테이블 삭제
/*
    DROP TABLE 테이블명;
*/
DROP TABLE MS_STUDENT;

CREATE TABLE MS_STUDENT(
    ST_NO       NUMBER         NOT NULL    PRIMARY KEY
    ,NAME       VARCHAR2(20)   NOT NULL
    ,CTZ_NO     CHAR(14)       NOT NULL
    ,EMAIL      VARCHAR2(100)  NOT NULL    UNIQUE
    ,ADDRRESS   VARCHAR2(1000) NULL
    ,DEPT_NO    NUMBER         NOT NULL
    ,MJ_NO      NUMBER         NOT NULL 
    ,REG_DATE   DATE           DEFAULT  sysdate NOT NULL    
    ,UPD_DATE   DATE           DEFAULT  sysdate NOT NULL    
    ,ETC        VARCHAR2(1000) DEFAULT '없음' NULL        
);
------------------------------- 테이블 - 새테이블

CREATE TABLE MS_STUDENT 
(
  ST_NO NUMBER NOT NULL 
, NAME VARCHAR2(20 BYTE) NOT NULL 
, CTZ_NO CHAR(14 BYTE) NOT NULL 
, EMAIL VARCHAR2(100 BYTE) NOT NULL 
, ADDRESS VARCHAR2(1000 BYTE) 
, DEPT_NO NUMBER NOT NULL 
, MJ_NO NUMBER NOT NULL 
, REG_DATE DATE DEFAULT sysdate NOT NULL 
, UPD_DATE DATE DEFAULT sysdate NOT NULL 
, ETC VARCHAR2(1000 BYTE) DEFAULT '없음' 
, CONSTRAINT MS_STUDENT_PK PRIMARY KEY 
  (
    ST_NO 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX MS_STUDENT_PK ON MS_STUDENT (ST_NO ASC) 
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

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE 
(
  EMAIL 
)
USING INDEX 
(
    CREATE UNIQUE INDEX MS_STUDENT_UK1 ON MS_STUDENT (EMAIL ASC) 
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
 ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민등록번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '학부번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 53
-- MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.

-- 테이블 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULY 기본값 [NOT NULL]
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 속성 삭제
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54
-- MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE 로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 속성 변경 - 타입 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 속성 변경 - NULL 여부 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- 속성 변경 - DEFAULT 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdate;

-- 동시에 적용 가능
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;


-- 55
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56
-- MS_STUDENT 테이블을 삭제하시오
DROP TABLE MS_STUDENT;

-- 57
CREATE TABLE MS_STUDENT 
(
  ST_NO NUMBER NOT NULL 
, NAME VARCHAR2(20 BYTE) NOT NULL 
, BIRTH DATE NOT NULL 
, EMAIL VARCHAR2(100 BYTE) NOT NULL 
, ADDRESS VARCHAR2(1000 BYTE)  
, MJ_NO VARCHAR2(10) NOT NULL
, GENDER CHAR(6) DEFAULT '기타' NOT NULL
, STATUS VARCHAR2(10)DEFAULT '대기' NOT NULL
, ADM_DATE DATE NULL
, GRD_DATE DATE NULL
, REG_DATE DATE DEFAULT sysdate NOT NULL 
, UPD_DATE DATE DEFAULT sysdate NOT NULL 
, ETC VARCHAR2(1000 BYTE) DEFAULT '없음' NULL 
, CONSTRAINT MS_STUDENT_PK PRIMARY KEY 
  (
    ST_NO 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX MS_STUDENT_PK ON MS_STUDENT (ST_NO ASC) 
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

ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE 
(
  EMAIL 
)
USING INDEX 
(
    CREATE UNIQUE INDEX MS_STUDENT_UK1 ON MS_STUDENT (EMAIL ASC) 
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
 ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58
-- MS_STUDENT 테이블에 데이터를 추가하시오.
-- * 데이터 추가
/*
    ▶ 기본문법  
    INSERT INTO [테이블명] (컬럼1, 컬럼2, ...)
    VALUES ('값1', '값2', ...);
    * 컬럼 작성 순서와, 값 작성 순서가 짝을 이루어야한다.( 일부 컬럼만 지정 가능)
    
    ▶ 컬럼명 생략
    INSERT INTO 테이블
    VALUES(값1, 값2, 값3, ...)
    *컬럼명을 생략하고 작성하면, 테이블의 컬럼 순서대로 모든 값을 지정해야 한다.
    
    ▶데이터를 조회하여 추가하기
    INSERT INTO 테이블 ( 컬럼1, 컬럼2, 컬럼3,...)
    SELECT 컬럼1, 컬럼2, 컬럼3, ...
    FROM 테이블
    [WHERE}조건;
*/

INSERT INTO MS_STUDENT (ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES('20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL);

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안', '970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;

SELECT * FROM ms_student;

-- 59
-- MS_STUDENT 테이블의 데이터를 수정하시오.
-- UPDATE
/*
    UPDATE 테이블명
        SET 컬럼1 = 변경할 값,
            컬럼2 = 변경할 값,
            ...
    [WHERE] 조건;
*/
-- 1) 학생번호가 20160001 인 학생의 주소를  '서울'로
--    재적 상태를 '휴학'으로 수정하시오.
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '휴학'       
WHERE st_no = 20160001;

-- 2) 학생번호가 20150010 인 학생의 주소를 '서울'로
--   재적 상태를 '졸업' 으로, 졸업일자 '20200220', 수정일자 현재날짜로
--   그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '졸업'
        ,grd_date = '2020/02/20'
        ,upd_date = sysdate
        ,etc = '수석'
WHERE st_no = 20150010;

-- 3) 학생번호가 20130007 인 재적 상태를  '졸업' 으로,
-- 졸업일자는 '20200220', 수정 일자는 현재날짜로 수정하시오.
UPDATE MS_STUDENT
    SET status = '졸업'
        ,grd_date = '2020/02/20'
        ,upd_date = sysdate
WHERE st_no = 20130007;

--4) 학생번호가  20110002 인 재적 상태를 '퇴학'으로,
-- 졸업일자는 '20130210', 수정일자는 현재날짜로
-- 그리고 특이사항을 '자진 퇴학' 으로 수정하시오.
UPDATE MS_STUDENT
    SET status = '퇴학'
        ,grd_date = '2013/02/10'
        ,upd_date = sysdate
        ,etc = '자진퇴학'
WHERE st_no = 20110002;

-- 60 
-- MS_STUDENT 테이블에서 학번이 20110002 인 학생을 삭제하시오.
DELETE FROM MS_STUDENT WHERE ST_NO = 20110002;

-- 61
-- MS_STUDENT 테이블의 모든 속성을 조회하시오
SELECT *
FROM MS_STUDENT;

-- 62
-- MS_STUDENT 테이블을 조회하여 MS_STUDENT_BACK 테이블로 생성하시오.
-- 백업 테이블 만들기

CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT;

-- 63
-- MS_STUDENT 테이블의 튜플을 삭제하시오
DELETE FROM MS_STUDENT;

SELECT * FROM MS_STUDENT;

-- 64
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여
-- MS_STUDENT 테이블에 삽입하시오.
INSERT INTO MS_STUDENT SELECT * FROM MS_STUDENT_BACK;

SELECT * FROM MS_STUDENT;

-- 65
-- MS_STUDENT 테이블의 성별(gender)  속성에 대하여
-- ('여','남','기타') 값만 입력가능하도록 하는 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STUDENT_GENDER_CHECK
CHECK (gender IN ('여','남', '기타'))
;


SELECT * FROM MS_STUDENT;


-- 66
-- 테이블 기술서를 참고하여 MS_USER 테이블을 생성하시오
-- SQL Developer 에서 새테이블에서 만듬
SELECT * FROM MS_USER; 

-- 67
-- 테이블 기술서를 참고하여 MS_BOARD 테이블을 생성하시오
CREATE TABLE MS_BOARD (
  BOARD_NO    NUMBER           NOT NULL PRIMARY KEY,
  TITLE       VARCHAR2(200)    NOT NULL,
  CONTENT     CLOB             NOT NULL,
  WRITER      VARCHAR2(100)    NOT NULL,
  HTI         NUMBER           NOT NULL,
  LIKE_CNT    NUMBER           NOT NULL,
  DEL_YN      CHAR(2)          NULL,
  DEL_DATE    DATE             NULL,
  REG_DATE    DATE             DEFAULT SYSDATE NOT NULL,
  UPD_DATE    DATE             DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';


-- 68
-- 테이블 기술서를 참고하여 MS_FILE 테이블을 생성하시오
-- 외래키 : 하나의 테이블에서 다른 테이블의 기본키를 참조하는 속성 = BOARD_NO
--          게시판에 글을 삭제하면 첨부되어 있는 파일도 같이 삭제되도록 함
CREATE TABLE MS_FILE (
  FILE_NO NUMBER NOT NULL PRIMARY KEY,
  BOARD_NO NUMBER NOT NULL,
  FILE_NAME VARCHAR2(2000) NOT NULL,
  FILE_DATA BLOB NOT NULL,
  REG_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPD_DATE DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE MS_FILE IS '게시판 첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.FILE_NANE IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

-- 69
CREATE TABLE MS_REPLY(
REPLY_NO NUMBER NOT NULL PRIMARY KEY,
BOARD_NO NUMBER NOT NULL,
CONTENT     VARCHAR2(2000)            NOT NULL,
WRITER NUMBER NOT NULL,
DEL_YN CHAR(2) DEFAULT 'N' NULL, 
DEL_DATE DATE NULL,
REG_DATE DATE DEFAULT SYSDATE NOT NULL,
UPD_DATE DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE MS_REPLY IS '게시판 댓글';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';

DROP TABLE MS_REPLY


-- 70
-- human 계정에 있는 모든 데이터를 human2 계정으로 가져오기 위해서
-- human.dmp 파일을 만들었다. human2 계정으로 접속하여
-- human.dmp  파일을 import 하시오.


-- 1. human, human2 계정 생성
-- 2. human.dmp 파일 import

-- 덤프파일 가져오기 (import)
-- import 시, dmp 파일을 생성한 계정과 다른 계정으로 가져올 때는
-- system 계정 또는 가져올 계정으로 접속하여 명령어를 실행해야한다.
-- *import 명령 : imp (cmd 에서 실행)
/*
    imp userid=system/123456 file=(덤프파일이 있는 곳 주소)C:\JHES\SQL\community.dmp fromuser=human tosuser=human2;
*/

-- human, human2 계정 삭제하기
DROP USER human;
DROP USER human2;


-- human 계정 생성하기(2번문제 참고)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER human IDENTIFIED BY 123456;
--계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER human QUOTA UNLIMITED ON users;
-- 계정에 권한 부여
GRANT connect, resource to human;

-- human2 계정 생성하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER human2 IDENTIFIED BY 123456;
--계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER human2 QUOTA UNLIMITED ON users;
-- 계정에 권한 부여
GRANT connect, resource to human2;

-- human 계정에 DBA 권한 부여
GRANT DBA TO human;
GRANT DBA TO human2;

-- CMD(명령프롬프터)로 임포트 하기
--imp userid=system/123456 file=C:\JHES\SQL\community.dmp fromuser=human touser=human
--imp userid=system/123456 file=C:\JHES\SQL\human.dmp fromuser=human touser=human2

-- ********************************************

-- 71.
-- human 계정이 소유하고 있는 데이터를
-- "human_exp.dmp" 덤프파일로 export 하는 명령어를 작성하시오.
exp userid=human/123456 file=C:\KHM\SQL\human_exp.dmp log=C:\KHM\SQL\human_exp.log




-- 72.
-- MS_BOARD 의 WRITER 속성을 NUMBER 타입으로 변경하고
-- MS_USER 의 USER_NO 를 참조하는 외래키로 지정하시오.

-- 1)
-- 데이터 타입 변경
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;
-- 제약조건 삭제
ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
-- 외래키 지정
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);


-- 2) 외래키 : MS_FILE (BOARD_NO)  ---->  MS_BOARD (BOARD_NO)
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);


-- 3) 외래키 : MS_REPLY (BOARD_NO)  ---->  MS_BOARD (BOARD_NO)
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 73.
-- MS_USER 테이블에 속성을 추가하시오.

ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

DESC MS_USER;


-- 74.
-- MS_USER 의 GENDER 속성이 ('여','남','기타') 값만 갖도록
-- 제약조건을 추가하시오.
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK (gender IN ('여','남','기타') )
;


-- 75.
-- MS_FILE 테이블에 확장자(EXT) 속성을 추가하시오.
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS  '확장자';



-- 76. 
MERGE INTO MS_FILE T    -- 대상 테이블 지정
-- 사용할 데이터의 자원을 지정
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F 
-- ON (update 될 조건)
ON (T.FILE_NO = F.FILE_NO)
-- 매치조건에 만족한 경우
WHEN MATCHED THEN
    -- SUBSTR( 문자열, 시작번호 )
    -- ex. SUBSTR( '/upload/강아지.png' , 12 )  --->  png
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1 )
    DELETE WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
                NOT IN (  'jpeg', 'jpg', 'gif', 'png' )
-- WHEN NOT MATCHED THEN
--   [매치가 안 될 때,]
;

-- 유저 추가
INSERT INTO MS_USER( 
        USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH, 
        TEL, ADDRESS, REG_DATE, UPD_DATE, 
        CTZ_NO, GENDER
        )
VALUES (
        1, 'ALOHA', '123456', '김휴먼', '2003/01/01', 
        '010-1234-1234', '영등포', sysdate, sysdate,
        '200101-1112222', '기타'
        );        
-- 게시글 추가
INSERT INTO MS_BOARD ( 
            BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT,
            DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
            )
VALUES (
        2, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );

-- 파일 추가
INSERT INTO MS_FILE ( 
            FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT 
            )
VALUES ( 2, 2, '강아지.png', '123', sysdate, sysdate, 'jpg' );

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;


-- 77.
-- 테이블 MS_FILE 의 EXT 속성이 
-- (‘jpg’, ‘jpeg’, ‘gif’, ‘png’) 값을 갖도록 하는 제약조건을 추가하시오.

ALTER TABLE MS_FILE 
ADD CONSTRAINT MS_FILE_EXT_CHECK 
CHECK (EXT IN ('jpg', 'jpeg', 'gif', 'png') );


-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의
-- 모든 데이터를 삭제하는 명령어를 작성하시오.
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
--    - 한 행 단위로 데이터를 삭제 처리한다
--    - COMMIT, ROLLABCK 으로 변경사항을 적용하거나 되돌릴 수 있음

-- * TRUNCATE - 데이터 정의어 (DDL)
--    - 모든 행을 삭제한다
--    - 삭제된 데이터를 되돌릴 수 없음


-- 79.
-- 테이블의 속성을 삭제하시오.
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오.
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오.

-- 1)
-- MS_BOARD 에 WRITER 속성 추가
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;

-- WRITER 속성을 외래키로 지정
-- 참조테이블 : MS_USER, 참조 속성 : USER_NO
-- + 참조테이블 데이터 삭제시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (WRITER)
REFERENCES MS_USER(USER_NO)
ON DELETE CASCADE;


-- 2)
-- MS_FILE 에 BOARD_NO 속성 추가
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;

-- BOARD_NO 속성을 외래키로 지정
-- 참조테이블 : MS_BOARD, 참조 속성 : BOARD_NO
-- + 참조테이블 데이터 삭제시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY (BOARD_NO)
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

-- 3)
-- MS_REPLY 에 BOARD_NO 속성 추가
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;

-- BOARD_NO 속성을 외래키로 지정
-- 참조테이블 : MS_BOARD, 참조 속성 : BOARD_NO
-- + 참조테이블 데이터 삭제시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY (BOARD_NO)
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;


SELECT *
FROM MS_USER;

--
INSERT INTO MS_FILE 
       ( file_no, file_name, file_data, reg_date, upd_date, board_no)
VALUES 
       (  1, '강아지.png', '123', sysdate, sysdate, 1);
--
INSERT INTO MS_FILE 
       ( file_no, file_name, file_data, reg_date, upd_date, board_no)
VALUES 
       (  2, '고양이.jpg', '123', sysdate, sysdate, 1);
       
commit;




DELETE FROM MS_USER WHERE USER_NO = 1;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;


-- 외래키 제약조건 정리
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키 속성)
REFERENCES 참조테이블(참조 속성);
-- 옵션
-- * ON UPDATE          -- 참조 테이블 수정 시,
--   * CASCADE          : 부모 데이터 수정 시, 자식 데이터도 수정
--   * SET NULL         : 부모 데이터 수정 시, 자식 데이터는 NULL
--   * SET DEFAULT      : 부모 데이터 수정 시, 자식 데이터는 기본값으로
--   * RESTRICT         : 자식 테이블이 참조하는 경우, 부모 데이터 수정 불가
--   * NO ACTION        : 아무런 행위도 취하지 않는다 (기본값)

-- * ON DELETE          -- 참조 테이블 삭제 시,
--   * CASCADE          : 부모 데이터 삭제 시, 자식 데이터도 삭제
--   * SET NULL         : 부모 데이터 삭제 시, 자식 데이터는 NULL
--   * SET DEFAULT      : 부모 데이터 삭제 시, 자식 데이터는 기본값으로
--   * RESTRICT         : 자식 테이블이 참조하는 경우, 부모 데이터 삭제 불가
--   * NO ACTION        : 아무런 행위도 취하지 않는다 (기본값)



-- ▶ 서브쿼리
/*
      : SQL 문 내부에 사용하는 SELECT 문
      * 메인쿼리 : 서브쿼리를 사용하는 최종적인 SELECT 문
      * 사용 위치에 다른 분류
      - 스칼라 서브쿼리 : SELECT 절에 사용하는 서브쿼리
      - 인라인 뷰       : FROM 절에 사용하는 서브쿼리
      - 서브 쿼리       : WHERE 절에 사용하는 서브커리
*/

-- 81.
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 사용하여
-- 스칼라 서브쿼리로 출력결과와 같이 조회하시오.
SELECT * FROM employee;    
SELECT * FROM department;
SELECT * FROM job;

-- 스칼라 서브쿼리
SELECT emp_id AS 사원번호
      ,emp_name AS 직원명
      ,(SELECT dept_title FROM department d WHERE d.dept_id = e.dept_code) 부서명
      ,(SELECT job_name FROM job j WHERE j.job_code = e.job_code ) 직급명
FROM employee e;

-- (실행순서)
-- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY


-- JOIN

-- INNER JOIN (내부조인)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급명
FROM employee e 
     JOIN department d ON e.dept_code = d.dept_id
     JOIN job j ON e.job_code = j.job_code
;

-- EQUI JOIN
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급명
FROM employee e, department d, job j
WHERE e.dept_code = d.dept_id
  AND e.job_code = j.job_code
;




















-- 82. 
-- 출력결과를 참고하여,
-- 인라인 뷰를 이용해 부서별로 최고급여를 받는 직원을 조회하시오.

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,e.salary 급여
      ,t.max_sal 최고급여
      ,t.min_sal 최저급여
      ,ROUND(t.avg_sal, 2) 평균급여
FROM employee e, department d,
      ( SELECT DEPT_CODE
            ,MAX(salary) MAX_SAL
            ,MIN(salary) MIN_SAL
            ,AVG(salary) AVG_SAL
      FROM employee
      GROUP BY dept_code ) t
WHERE e.dept_code = d.dept_id
  AND e.salary = t.max_sal;



-- 83.
-- 서브쿼리를 이용하여,
-- 직원명이 '이태림' 인 사원과 같은 부서의 직원들을 조회하시오.

SELECT emp_id 사원번호
      ,emp_name 직원명
      ,email 이메일
      ,phone 전화번호
FROM employee
WHERE dept_code = (
                     SELECT dept_id
                     FROM employee
                     WHERE emp_name = '이태림'
                  )
;


-- 84.
-- 사원 테이블에 존재하는 부서코드만 포함하는 부서를 조회하시오.
-- (사원이 존재하는 부서만 조회하시오.)

-- 1) 서브쿼리
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id IN (
                   SELECT DISTINCT dept_code
                   FROM employee
                   WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC
;

-- 2) EXISTS
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;



-- 85.
-- 사원 테이블에 존재하지 않는 부서코드만 포함하는 부서를 조회하시오.
-- (사원이 존재하는 부서만 조회하시오.)

-- 1) 서브쿼리
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id NOT IN (
                   SELECT DISTINCT dept_code
                   FROM employee
                   WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC
;

-- 2) EXISTS
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE NOT EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;


-- 86.
-- EMPLOYEE 테이블의 DEPT_CODE 가 'D1' 인 부서의 최대급여 보다
-- 더 큰 급여를 받는 사원을 조회하시오.

-- 1단계 - DEPT_CODE 가 'D1' 인 부서의 최대급여
SELECT MAX(salary)
FROM employee
WHERE dept_code = 'D1';

-- 2단계 - 급여 > 최대급여 큰 경우로 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > (
                  SELECT MAX(salary)
                  FROM employee
                  WHERE dept_code = 'D1'
                  )
;

-- 2)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > ALL( SELECT salary FROM employee WHERE dept_code = 'D1' )
;

-- 87.
-- EMPLOYEE 테이블의 DEPT_CODE 가 'D9' 인 부서의 최저급여 보다
-- 더 큰 급여를 받는 사원을 조회하시오.

-- 1단계 - DEPT_CODE 가 'D1' 인 부서의 최대급여
SELECT MIN(salary)
FROM employee
WHERE dept_code = 'D9';

-- 2단계 - 급여 > 최대급여 큰 경우로 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > (
                  SELECT MIN(salary)
                  FROM employee
                  WHERE dept_code = 'D9'
                  )
;

-- 2)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > ANY( SELECT salary FROM employee WHERE dept_code = 'D9' )
;


/*
      ▶조인
 : 여러 테이블을 조합하여 조회하는 방식
  * 내부 조인 (INNER JOIN)
    - 동등 조인 (EQUI JOIN)
     : 등호(=) 연산자를 사용하여 2개 이상의 테이블을 연결하여 출력하는 방식
      ex)
      SELECT *
      FROM A, B
      WHERE A.x = B.y;
      
    - INNER JOIN
      : 왼쪽 테이블과 오른쪽 테이블의 조인 조건에 일치하여,
        교집합이 되는 데이터를 조회하는 것
      
  * 외부 조인 (OUTER JOIN)
    - LEFT OUTER JOIN
     : 왼쪽 테이블을 먼저 읽어드린 후, 조인 조건에 일치하는 오른쪽 테이블을 함께 조회하는 것
      * 조건에 만족하지 않는, 오른쪽 테이블 데이터는 NULL 로 조회된다.
      
    - RIGHT OUTER JOIN
     : 오른쪽 테이블을 먼저 읽어드린 후, 조인 조건에 일치하는 왼쪽 테이블을 함께 조회하는 것
      * 조건에 만족하지 않는, 왼쪽 테이블 데이터는 NULL 로 조회된다. 
*/

-- 88.
-- EMPLOYEE 와 DEPARTMENT 테이블을 조인하여 출력하되,
-- 부서가 없는 직원도 포함하여 출력하시오.

SELECT NVL(e.emp_id, '(없음)') 사원번호
      ,NVL(e.emp_name, '(없음)') 직원명
      ,NVL(d.dept_id, '(없음)') 부서번호
      ,NVL(d.dept_title, '(없음)') 부서명
FROM employee e
     LEFT JOIN department d 
     ON ( e.dept_code = d.dept_id );

-- null 로 나오는 데이터 : 부서가 없는 사원
     

-- 89.
-- EMPLOYEE 와 DEPARTMENT 테이블을 조인하여 출력하되,
-- 직원이 없는 부서도 포함하여 출력하시오.

SELECT NVL( e.emp_id, '(없음)' ) 사원번호
      ,NVL( e.emp_name, '(없음)' ) 직원명
      ,NVL( d.dept_id, '(없음)' ) 부서번호
      ,NVL( d.dept_title, '(없음)' ) 부서명
FROM employee e
     RIGHT JOIN department d 
     ON ( e.dept_code = d.dept_id );

-- null 로 나오는 데이터 : 사원이 없는 부서



--90.
-- 직원 및 부서 유무에 상관없이 출력하는 SQL문을 작성하시오.

SELECT NVL( e.emp_id, '(없음)' ) 사원번호
      ,NVL( e.emp_name, '(없음)' ) 직원명
      ,NVL( d.dept_id, '(없음)' ) 부서번호
      ,NVL( d.dept_title, '(없음)' ) 부서명
FROM employee e
     FULL JOIN department d ON ( e.dept_code = d.dept_id );

-- 91.
-- 사원번호, 직원명, 부서번호, 지역명, 국가명, 급여, 입사일자를 출력하시오.

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,l.local_name 지역명
      ,n.national_name 국가명
      ,e.salary 급여
      ,e.hire_date 입사일자
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     LEFT JOIN location l ON d.location_id = l.local_code
     LEFT JOIN national n USING(national_code)
     ;

-- USING : 조인하고자 하는 두 테이블의 컬럼명이 같은 경우,
--         조인 조건을 간단하게 작성하는 키워드


-- 92.
-- 사원들 중 매니저를 출력하시오.
-- 사원번호, 직원명, 부서명, 직급, 구분('매니저')

-- 1단계
-- manager_id 컬럼이 NULL 이 아닌 사원을 중복없이 조회
-- 매니저들의 사원 번호
SELECT DISTINCT manager_id
FROM employee
WHERE manager_id IS NOT NULL;

-- 2단계
-- employee, department, job 테이블을 조인하여 조합
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;

-- 3단계
-- 조인 결과 중, emp_id 가 매니저 사원번호인 경우만을 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN (
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )
;


-- 93
-- 사원만 조회하시오.

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id NOT IN (
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )
;

-- 94.
-- UNION 키워드를 사용하여,
-- 매니저와 사원 모두를 조회하시오.
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN (
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )
UNION
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id NOT IN (
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )

;
-- ****************************************************

-- 95
-- 매니저와 사원을 구분하여 출력하시오.
-- CASE : 조건에 따라 값을 변경해주는 키워드
/*
    형식
    CASE
         WHEN 조건1 THEN 값1
         WHEN 조건1 THEN 값1
         ...
         ELSE값
    END
*/

SELECT e.emp_id 사원번호
     , e.emp_name 직원명
     , d.dept_title 부서명
     , j.job_name 직급
     --
     , CASE
        WHEN emp_id IN (
                        SELECT DISTINCT manager_id
                        FROM employee
                        WHERE manager_id IS NOT NULL
                        )
        THEN '매니저'
        ELSE '사원'
    END 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j USING(job_code)
;

-- 96
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 조인하여 조회하시오
-- 사원의 나이와 성별을 구하여 출력하고,
-- 주민등록번호 뒷자리 첫글자를 제외하고 마스킹하여 출력하시오.

SELECT e.emp_id 사원번호
     , e.emp_name 직원명
     , d.dept_title 부서명
     , j.job_name 직급
     --
     , CASE
        WHEN emp_id IN (
                        SELECT DISTINCT manager_id
                        FROM employee
                        WHERE manager_id IS NOT NULL
                        )
        THEN '매니저'
        ELSE '사원'
    END 구분
    -- 성별(주민등록번호 뒷자리 첫글자)
    -- 200101-1******
    , CASE 
        WHEN SUBSTR(emp_no, 8, 1) IN ('1', '3') THEN '남자'
        WHEN SUBSTR(emp_no, 8, 1) IN ('2', '4') THEN '여자'
    END 성별
    -- 나이
    --올해년도
    ,TO_CHAR(sysdate, 'YYYY')
    -
    (
     -- 출생년도(1995,2015)
        CASE
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
            WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
        END || SUBSTR(emp_no,1,2)
    ) 현재나이
    -- 만 나이가 아니면 +1
    ,
    TRUNC(
        MONTHS_BETWEEN (
             sysdate, 
             -- 생년월일 (19950101, 20150101)
             TO_DATE(
                        CASE
                            WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                            WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                        END || SUBSTR(emp_no,1,6)
                    )
        )
        /12
    )만나이
    -- 주민등록번호 마스킹하기
    ,RPAD(SUBSTR(emp_no, 1, 8), 14, '*') 주민등록번호
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j USING(job_code)
;

-- 97

SELECT ROWNUM 순번
     , e.emp_id 사원번호
     , e.emp_name 직원명
     , d.dept_title 부서명
     , j.job_name 직급
     --
     , CASE
        WHEN emp_id IN (
                        SELECT DISTINCT manager_id
                        FROM employee
                        WHERE manager_id IS NOT NULL
                        )
        THEN '매니저'
        ELSE '사원'
    END 구분
    -- 성별(주민등록번호 뒷자리 첫글자)
    -- 200101-1******
    , CASE 
        WHEN SUBSTR(emp_no, 8, 1) IN ('1', '3') THEN '남자'
        WHEN SUBSTR(emp_no, 8, 1) IN ('2', '4') THEN '여자'
        -- ELSE '여자'
    END 성별
    -- 나이
    --올해년도
    ,TO_CHAR(sysdate, 'YYYY')
    -
    (
     -- 출생년도(1995,2015)
        CASE
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
            WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
        END || SUBSTR(emp_no,1,2)
    ) 현재나이
    -- 만 나이가 아니면 +1
    ,
    TRUNC(
        MONTHS_BETWEEN (
             sysdate, 
             -- 생년월일 (19950101, 20150101)
             TO_DATE(
                        CASE
                            WHEN SUBSTR(emp_no, 8, 1) IN ('1','2') THEN '19'
                            WHEN SUBSTR(emp_no, 8, 1) IN ('3','4') THEN '20'
                        END || SUBSTR(emp_no,1,6)
                    )
        )
        /12
    )만나이
    , TRUNC(MONTHS_BETWEEN (sysdate,HIRE_DATE) / 12) 근속연수
    --TO_CHAR(sysdate, 'YYYY' ) - TO_CHAR(hire_date,'YYYY') 근속년수 
    -- 주민등록번호 마스킹하기
    , RPAD(SUBSTR(emp_no, 1, 8), 14, '*') 주민등록번호
    , TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') 입사일자
    , TO_CHAR(NVL2(BONUS, salary+(salary*BONUS), salary)*12, '999,999,999') 연봉
    -- TO_CHAR( (salary + NVL((salary*bonus),0))*12, '999,999,999') 년봉
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j USING(job_code)
;

--(교재  51~59p)
--#데이터베이스 객체
-- : 데이터를 저장하고 관리하기 위한 논리구조를 갖는 구성요소

    -- 테이블       : 데이터를 저장하는 공간
    -- 뷰          : 가상 테이블,
    -- 인덱스       : 색인 테이블의 검색 효율을 높이기 위한 객체
    -- 시퀀스       : 순서번호(일련번호)를 생성하는 객체
    -- 시노님       : 테이블 등 객체에 대한 별칭을 지정하는 객체
    -- 함수         : 프로그래밍 연산이 가능한, 입력과 출력이 가능한 객체
    -- 프로시저      : 프로그래밍 연산이 가능한, 특정작업을 수행하는 쿼리의 집합
    -- 패키지        : 관련 있는 프로시저와 함수를 묶어놓은 객체
    -- 트리거        : (방아쇠)테이블에 대한 이벤트를 인식해서 자동으로 실행되는 작업을 정의한 객체

-- #데이터 타입   
--  : 컬럼이 저장되는 데이터 유형
-- ▶문자 데이터 차입
-- CHAR(크기) : 고정길이 문자 (최대 2000Byte, 기본값이 1byte)★
-- VARCHAR2(크기) : 가변길이 문자(최대 2000Byte, 기본값이 1byte)★
--NCHAR(크기) : 고정길이 유니코드 문자
--NVARCHAR2(크기) : 가변길이 유니코드 문자
-- LONG : 최대 2GB의 가별길이 문자형
-- ▶문자 데이터 타입
-- NUMBER(크기, 자리)   : 가변숫자(최대 22byte)★
--FLOAT(크기)         : 가변숫자, 이진수 기준 크기지정(최대 22byte)
-- BINARY_FLOAT     : 32비트 부동소수점 수
-- BINARY_DOUBLE    : 64비트 부동소수점 수
-- ▶날짜 데이터 타입
-- DATE         : 기원전 4712년 1월 1일 ~ 9999년 12월 31일 까지★
-- TIMESTAMP     : 연, 월, 시, 분, 초, 밀리초 입력 가능(11byte)★
                    1970/01/01 ~ 2037/12/31

-- ▶LOB 타입(Large Object)
-- : 대용량 데이터를 저장할 수 있는 데이터 타입
-- CLOB         : 문자형 대용량 객체, 고정길이/ 가변길이
-- NCLOB : 다국어를 지원하는 문자형 대용량 객체
-- BLOB : 이진형 대용량 객체 (파일)
-- BFILE : 대용량 이진 파일에 파일 위치/이름 등을 저장하는 타입(최대 4GB)

-- VIEW 연습 (자주 조회하는 것들을 )
-- 뷰 생성
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT e.emp_id
     , e.emp_name 
     , d.dept_id
     , d.dept_title 
FROM employee e
   , department d
WHERE e.dept_code = d.dept_id ;

-- 뷰 삭제
DROP VIEW v_emp_dept;

SELECT*
FROM v_emp_dept;

-- 98
-- VE_EMP_DEPT 를 생성하시오
CREATE OR REPLACE VIEW VE_EMP_DEPT AS
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
     , e.email
     , e.phone
     -- 주민등록번호 마스킹
     ,RPAD(SUBSTR(emp_NO, 1 , 8), 14 ,'*') emp_no
     -- 입사일자 
     ,TO_CHAR(hire_date, 'YYYY.MM.DD') hire_date
     -- 급여
     ,TO_CHAR(salary, '999,999,999') salary
     -- 연봉
     ,TO_CHAR ((salary + NVL(salary*bonus,0))*12, '999,999,999,999') yr_salary
FROM employee e
    LEFT JOIN department d ON( e.dept_code = d.dept_id);

SELECT *
FROM VE_EMP_DEPT;

/* 
    시퀀스
    : 자동 순번을 반환하는 DB 객체
    
    - 시퀀스 생성
    CREATE SEQUENCE 시퀀스명
    INCREMENT BY 증감숫자
    START WITH 시작숫자
    MINVALUE 최솟값
    MAXVALUE 최댓값;
*/

CREATE SEQUENCE my_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
;

-- 시퀀스 삭제
DROP SEQUENCE my_seq;

-- 현재 순번
SELECT my_seq.currval FROM dual;

-- 다음 순번
SELECT my_seq.nextval FROM dual;

--99
-- 시퀀스를 생성하시오.
-- SEQ_MS_USER
-- SEQ_MS_BOARD
-- SEQ_MS_FILE
-- SEQ_MS_REPLY
-- (시작:1, 증가값 :1, 최솟값:1, 최댓값:1000000)
-- 시퀀스 생성
CREATE SEQUENCE SEQ_MS_USER
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000
;

CREATE SEQUENCE SEQ_MS_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000
;

CREATE SEQUENCE SEQ_MS_FILE
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000000
;

CREATE SEQUENCE SEQ_MS_REPLY INCREMENT BY 1 MAXVALUE 1000000 MINVALUE 1 CACHE 20;
-- 시퀀스 - 새 시퀀스

-- 100
SELECT SEQ_MS_USER.nextval FROM dual;
SELECT SEQ_MS_USER.currval FROM dual;


-- 101
-- SEQ_MS_USER  삭제하는 SQL 문을 작성하시오.
DROP SEQUENCE SEQ_MS_USER;

CREATE SEQUENCE SEQ_MS_USER
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000000;

-- 102
-- 시퀀스 SEQ_MS_USER를 적용하여 MS_USER 의
-- USER_NO 가 증분되어 추가되도록 예시와 같이 데이터를 추가하는 SQL 문을 작성하시오

INSERT INTO MS_USER( user_no, user_id, user_pw, user_name,
                    birth, tel, address, reg_date, upd_date)
VALUES( SEQ_MS_USER.nextval, 'ALOHA', '123456', '김휴먼', 
        '2002/01/01', '010-1234-1234', '서울 영등포', sysdate, sysdate
        );
        
INSERT INTO MS_USER( user_no, user_id, user_pw, user_name,
                    birth, tel, address, reg_date, upd_date)
VALUES( SEQ_MS_USER.nextval, 'human', '123456', '박휴먼', 
        '2002/01/01', '010-3688-3688', '서울 여의도', sysdate, sysdate
        );
        
SELECT * FROM ms_user;

-- 103
-- 시퀀스 SEQ_MS_USER 의 최댓값을 100,000,000 로 수정하시오.
ALTER SEQUENCE SEQ_MS_USER MAXVALUE 100000000;


-- 104
-- 인덱스 정보를 조회하시오.
-- USER_IND_COLUMS 테이블 INDEX_NAME, TABLE_NAME, COLUMN_NAME 속성의 조회하시오
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM user_ind_columns;

-- 105
-- MS_USER 테이블의 USER_NAME 에 대한
-- 인덱스 IDX_MS_USER_NAME 을 생성하시오.

-- 인덱스 생성
CREATE INDEX IDX_MS_USER_NAME ON MS_USER(user_name);

-- 인덱스 삭제
DROP INDEX IDX_MS_USER_NAME;

SELECT*FROM MS_USER;



-- 그룹 관련 함수 정리

--ROLLUP
-- * ROLLUP 미사용
SELECT dept_code, job_code
    , COUNT(*), MAX(salary),SUM(salary),TRUNC(AVG(salary),2)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code;
-- * ROLLUP 사용
-- : 그룹 기준으로 집계한 결과와 추가적으로 총 집계 정보 출력하는 함수
SELECT dept_code, job_code
    , COUNT(*), MAX(salary),SUM(salary),TRUNC(AVG(salary),2)
FROM employee
GROUP BY ROLLUP (dept_code, job_code)
ORDER BY dept_code, job_code;

-- CUBE 사용
--  : 가능한 모든 조합별로의 집계정보를 출력하는 함수
SELECT dept_code, job_code
    , COUNT(*), MAX(salary),SUM(salary),TRUNC(AVG(salary),2)
FROM employee
GROUP BY CUBE (dept_code, job_code)
ORDER BY dept_code, job_code;

-- GROUPING SETS()
-- : 그룹컬럼이 여러 개 일 때, 집계한 정보를 컬럼별로 출력하는 함수

-- 특정 부서의 직급별 인원 수
SELECT dept_code, job_code, COUNT(*)
FROM employee
GROUP BY GROUPING SETS (dept_code, job_code)
ORDER BY dept_code, job_code;

/*GROUPING
  : 그룹화한 컬럼들이 그룹화가 이루어진 상태인지 여부를 출력하는 함수
   -그룹화 O :  출력결과 0
   -그룹화 X :  출력결과 1

SELECT 컬럼1, 컬럼2, 컬럼3,...
        ,GROUPING 그룹화 여부를 확인할 컬럼,...
FROM 테이블명
GROUP BY[ROLLUP || CUBE] 그룹컬럼; */

SELECT dept_code
     , job_code
     , MAX(salary)
     , SUM(salary)
     , TRUNC(AVG(salary),2)
     , GROUPING(dept_code) "부서코드 그룹여부"
     , GROUPING(job_code) "직급코드 그룹여부"
FROM employee
WHERE dept_code IS NOT NULL
     AND job_code IS NOT NULL
GROUP BY CUBE(dept_code, job_code)
ORDER BY dept_code
;
     
/*
    -LISTAGG(컬럼,[구분자])
    -> LIST+ Aggregate
      : 데이터 목록 + 합쳐서 출력하는 함수
     WITHIN GROUP  (ORDER BY 정렬기준 컬럼)
      : 그룹컬럼을 기준으로,
        그룹화된 데이터를 하나의 열에 가로로 나열하여 출력하는 함수
*/

SELECT dept_code 부서코드
     , LISTAGG(emp_name', ')
       WITHIN GROUP (ORDER BY emp_name) "부서별 사원이름목록"
FROM employee
GROUP BY dept_code
ORDER BY dept_code
;


-- PIVOT
-- : 그룹화할 행 데이터를 열로 바꾸어서 출력하는 함수

SELECT dept_code, job_code
     , LISTAGG(emp_name, ', ')
     WITHIN GROUP(ORDER BY salary DESC) "부서별 사원목록"
     , MAX(salary) 최대급여
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;


-- PIVOT 함수를 이용해서 직급은 행에, 부서는 열에 그룹화하여 최고급여를 출력하시오.
SELECT *
FROM (
    SELECT dept_code, job_code, salary
    FROM employee
    )
    PIVOT(
        MAX(salary)
        -- 컬럼으로 올릴 속성들
        FOR dept_code IN('D1','D2','D3','D4','D5','D6','D7','D8','D9')
        )
ORDER BY job_code;


SELECT *
FROM (
    SELECT dept_code, job_code, salary
    FROM employee
    )
    PIVOT(
        MAX(salary)
        -- 컬럼으로 올릴 속성들
        FOR job_code IN('J1','J2','J3','J4','J5','J6','J7')
        )
ORDER BY dept_code;

-- UNPIVOT
-- : 그룹화된 결과인 열을 행 데이터로 바꾸어 출력하는 함수
SELECT *
FROM (
        SELECT dept_code
             , MAX(DECODE(job_code, 'J1', salary)) J1 -- "대표 최대급여"
             , MAX(DECODE(job_code, 'J2', salary)) J2 -- "부사장 최대급여"
             , MAX(DECODE(job_code, 'J3', salary)) J3 -- "부장 최대급여"
             , MAX(DECODE(job_code, 'J4', salary)) J4 -- "차장 최대급여"
             , MAX(DECODE(job_code, 'J5', salary)) J5 -- "과장 최대급여"
             , MAX(DECODE(job_code, 'J6', salary)) J6 -- "대리 최대급여"
             , MAX(DECODE(job_code, 'J7', salary)) J7 -- "사원최대급여"
        FROM employee
        GROUP BY dept_code
        ORDER BY dept_code
    )
    UNPIVOT(
        salary
        FOR job_code IN( J1, J2, J3, J4, J5, J6, J7)
    )
;

-- 조인(176p~

-- 내부조인
--  동등조인 : 등호(+)연산자를 사용하여 2개 이상의 테이블을 조합하여 조회하는 방식
SELECT e.emp_name, d.dept_title, e.salary
  FROM employee e
     , department d
WHERE e.dept_code = d.dept_id;

-- INNER JOIN (동등조인과 대응)
SELECT e.emp_name, d.dept_title, e.salary
  FROM employee e
       INNER JOIN department d ON (e.dept_code = d.dept_id);

--  세미조인 : 서브 쿼리에 존재하는 데이터만 메인 쿼리에서 추출하여 출력하는 방식
--           * IN 또는 EXISTS 연산자를 사용한 조인
--          급여가 300000 이상인 부서를 출력하시오.
SELECT *
FROM department d
WHERE EXISTS (
                SELECT *
                FROM employee e
                WHERE e.dept_code = d.dept_id
                  AND salary >= 3000000
             )
;
                  
SELECT *
FROM department d
WHERE dept_id  IN ( 
                    SELECT dept_code
                    FROM employee e
                    WHERE e.dept_code = d.dept_id
                    AND salary >= 3000000
               )
;
--  안티조인 : 서브 쿼리에 존재하는 데이터만 제외하고, 메인 쿼리에서 추출하여 조회하는 방식
SELECT *
FROM department d
WHERE NOT EXISTS (
                SELECT *
                FROM employee e
                WHERE e.dept_code = d.dept_id
                  AND salary >= 3000000
             )
;
                  
SELECT *
FROM department d
WHERE dept_id NOT IN ( 
                    SELECT dept_code
                    FROM employee e
                    WHERE e.dept_code = d.dept_id
                    AND salary >= 3000000
               )
;
--  셀프조인 : 동일한 하나의 테이블을 2번 이상 조합하여 출력하는 방식

-- 같은 부서의 사원에 대한 매니저를 출력하시오.
SELECT b.emp_id 사원번호
    , b.emp_name 사원명
    , a.emp_name 매니저명
FROM employee a,
     employee b
WHERE a.emp_id = b.manager_id
  AND a.dept_code = b.dept_code
;

-- 외부 조인(OUTER JOIN)
-- LEFT OUTER JOIN : 왼쪽 테이블을 먼저 읽어들인 후, 
--                   조인 조건에 일치하는 오른쪽 테이블도 함꼐 조회하는 것
--                  * 조건에 불일치하는 오른쪽 테이블은 NULL로 조회된다.
-- 1) ANSI 조인
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e LEFT OUTER JOIN department d
               ON e.dept_code = d.dept_id
;

-- 2) 기존 조인 : 조인 조건에서 데이터가 없는 테이블의 컬럼에(+) 기호를 붙여준다
-- WHERE A.공통컬럼 = B.공통컬럼(+);
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e 
    ,department d
WHERE e.dept_code = d.dept_id (+);



-- RIGHT OUTER JOIN :오른쪽 테이블을 먼저 읽어들인 후,
--                   조인 조건에 일치하는 왼쪽 테이블도 함꼐 조회하는 것
--                  * 조건에 불일치하는 왼쪽 테이블은 NULL로 조회된다.
-- 1) ANSI 조인
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e right OUTER JOIN department d
               ON e.dept_code = d.dept_id
;

-- 2) 기존 조인 : 조인 조건에서 데이터가 없는 테이블의 컬럼에(+) 기호를 붙여준다
-- WHERE A.공통컬럼(+) = B.공통컬럼;
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e 
    ,department d
WHERE e.dept_code(+) = d.dept_id ;


-- FULL OUTER JOIN
-- : 조인 조건에 일치하는 왼쪽 테이블과 오른쪽 테이블의 교집합이 되는 데이터
--  - 조인 조건에 일치하지 않는 왼쪽 테이블 데이터(오른쪽 테이블 데이터 NULL)
--  - 조인 조건에 일치하지 않는 오른쪽 테이블 데이터(왼쪽 테이블 데이터 NULL)

-- *ANSI 조인만 있다.
SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e FULL OUTER JOIN department d
                ON e.dept_code = d.dept_id;

SELECT e.emp_id
     , e.emp_name
     , d.dept_id
     , d.dept_title
FROM employee e 
    ,department d
WHERE e.dept_code(+) = d.dept_id(+); --불가능

-- 카테시안 조인
-- : 하나의 테이블 A와 다른 하나의 테이블 B의 모든 행을 조회하는 방식
-- (A 행의 수) X (B행의 수) = (조회 결과의 행의 수)

SELECT *
FROM employee e
    , department d
;


SELECT ROWNUM   -- 행번호 
     , e.*
     , d.*
FROM employee e
    , department d
;
-- CROSS 조인
-- : 카테시안 조인은 ANSI 문법으로 사용한 조회
SELECT *
FROM employee e
     cross join department d;
/*
PL/SQL
SQL을 절차적으로 프로그래미잉 가능하도록 확장한 언어
PL/SQL 기본 구조 : 블록
블록형태

DECLARE
	필요한 요소를 선언; 		-- 선언부
	BEGIN
	   실행 명령어;	 	-- 실행부
	EXCEPTION
	예외를 처리하는 부분	-- 예외처리부
END;

------------------------
SET SERVEROUTPUT ON; -- 실행결과 출력하도록 설정

BEGIN
    DBNS_OUTPUT.PUT_LINE('실행결과를 출력합니다.');
END;
/

기본 문법사항
- 블록의 부분을 지정하는 명렁어에는 ;세미콜론을 사용하지 않는다
 (DECLARE, BEGIN, EXCEPTION)
- 블록의 각 부분에서 실행하는 문장에는 ;세미콜론을 사용한다.
- 한 줄주석(--), 여러줄 주석
- PL/SQL 작성후 실행 시, 마지막에 / 를 사용


변수와 상수
- 변수 선언
   변수명 데이터타입 := 값;

- 상수 선언
    상수명 CONSTANT 데이터타입 := 값;

- 변수의 기본값 지정
    변수명 데이터타입 DEFAULT 값;

- 변수의 NOT NULL 지정
    변수명 데이터타입 NOT NULL := 값;


데이터 타입
- 스칼라형 : NUMBER, CHAR, VARCHAR2, DATE, BOOLEAN
- 참조형 : 이미 테이블의 정의된 컬럼의 타입을 참조
	*변수명 테이블.컬럼%TYPE := 값;

제어문
-조건문 :  IF , CASE
-반복문 : LOOP , WHILE LOOP , FOR LOOP
-기타 제어문 : EXIT , CONTINUE
*/
































