--프로시저(Procedure)
-- : 특정 업무를 처리하는 일련의 작업 프로그램으로 저장하여 사용하는 객체

-- 결과값 반환 없이 특정 로직을 처리
-- 테이블에서 데이터를 조회, 수정, 삭제 등을 하거나 조회 결과를 다른 테이블에 추가
CREATE OR REPLACE PROCEDURE pro_print
IS -- 선언부
    V_A NUMBER := 10; 
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN -- 실행부
    V_C := V_A + V_B;
    --
    DBMS_OUTPUT.PUT_LINE('V_C : ' ||V_C);
END;
/

SET SERVEROUTPUT ON;
-- 프로시저 실행
EXECUTE pro_print();


--
CREATE OR REPLACE PROCEDURE pro_emp_write
(
    IN_EMP_ID IN employee.emp.id%TYPE,
    IN_TITLE IN VARCHAR2,
    IN_CONTENT IN CLOB
)
IS
 V_EMP_NAME employee.emp_name%TYPE;
 BEGIN
    -- INTO :  조회결과를 변수에 대입하는 키워드
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    INSERT INTO ms_board( board_no, title, content, writer, hit, like_cnt)
    VALUES (SEQ_MS_BOARD.nextval, IN_TITLE, IN_CONTENT, V_EMP_NAME, 0, 0);
    
    DBMS_OUTPUT.PUT_LINE('제목 : ' || IN_TITLE);        
    DBMS_OUTPUT.PUT_LINE('내용 : ' || IN_CONTENT);    
    DBMS_OUTPUT.PUT_LINE('작성자 : ' || V_EMP_NAME);
END;
/

SELECT * FROM employee;
SELECT * FROM ms_board;

EXECUTE pro_emp_write( '207','제목', '내용');




--------------------------

CREATE OR REPLACE PROCEDURE pro_emp_write 
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2,
    IN_CONTENT IN CLOB
)
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    -- INTO : 조회결과를 변수에 대입하는 키워드
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;

    INSERT INTO ms_board( board_no, title, content, writer, hit, like_cnt )
    VALUES ( SEQ_MS_BOARD.nextval, IN_TITLE, IN_CONTENT, V_EMP_NAME, 0, 0 );

    DBMS_OUTPUT.PUT_LINE('제목 : ' || IN_TITLE);
    DBMS_OUTPUT.PUT_LINE('내용 : ' || IN_CONTENT);
    DBMS_OUTPUT.PUT_LINE('작성자 : ' || V_EMP_NAME);
END;
/

SELECT * FROM employee;
SELECT * FROM ms_board;

EXECUTE pro_emp_write( '200', '제목', '내용' );

