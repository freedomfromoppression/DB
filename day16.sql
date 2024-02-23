/* 분석함수의 window절( 그룹안에 부분집합)
   ROWS :행 단위로 WINDOW 절을 지정
   RANGE : 논리적인 범위로 WINDOW를 지정
   PRECEDING : 파티션으로 구분된 첫 번째 로우가 시작점.
   FOLLOWING : 파티션으로 구분된 마지막 로우가 끝 지점
   CURRENT ROW : 현재로우
*/
SELECT department_id, emp_name, hire_date, salary
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN UNBOUNDED PRECEDING
                        AND CURRENT ROW) as first_curr
                        -- 가장 입사가 빠른 사원부터 현재 로우
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN CURRENT ROW
                        AND UNBOUNDED FOLLOWING) as curr_last  
                        --현재 로우 부터 끝       
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN 1 PRECEDING
                        AND CURRENT ROW) as rowl_curr 
                        -- 1행 이전 + 현재 로우
FROM employees
WHERE department_id IN (30, 90);

-- study 계정의 reservation, order_info 테이블을 이용하여
-- 월별 누적금액을 출력하시오
-- RATIO_TO_REPORT : 집합 내 각 항목의 비율을 계산(집합 내에서 해당 값이 차지하는 비율
SELECT t1.*
     , ROUND(RATIO_TO_REPORT(t1.sales) OVER() *100,2) || '%' as 비율
     , SUM(t1.sales) OVER(order by months
                          rows between unbounded
                          preceding and current row) as 누적집계
FROM (
SELECT SUBSTR(a.reserv_date, 1, 6) as months
     , SUM(b.sales) as sales
FROM reservation a, order_info b
WHERE a.reserv_no = b.reserv_no
GROUP BY SUBSTR(a.reserv_date, 1, 6)
ORDER BY 1
) t1;

/*
    PL/SQL 절차적 언어와집합적 언어의 특징을 모두 가지고 있음.
    특정 기능을 처리하는 함수, 프로시져, 트리거 등을 만들 수 있음.
    DB내부에 만들어져 일반 프로그래밍 언어보다 빠름.
*/
SET SERVEROUTPUT ON; 
-- PL/SPQ 실행결과를 스크립트 출력에 출력'

-- 기본 단위는 블록이라고 하며 블록은 이름부, 선언부, 실행부(예외처리부) 로 구성됨.
DECLARE --          <-익명 블록
 vi_num NUMBER;     -- 변수선언
BEGIN
 vi_num := 100; --값 할당
DBMS_OUTPUT.PUT_LINE(vi_num); --프린트
END;
-- PL/SPQ실행은 전체 블록을 잡은 뒤 실행해야함.

-- 실행부에는 DML문이 들어갈 수 있음.
DECLARE
 vs_emp_name VARCHAR2(80); -- number는 사이즈를 안써도됨. 
 vs_dep_name department.department_name%TYPE; -- 테이블 컬럼타입
BEGIN
 SELECT a.emp_name, b.department_name
  INTO vs_emp_name, vs_dep_name -- 변수에 질의결과를 담음.
 FROM employees a, departments b
 WHERE a.department_id = b.department_id
 AND a.employees_id = 100; -- 하나의 변수에는 1개의 행 값만 할당가능
 DBMS_OUTPUT.PUT_LINE(vs_emp_name || ':' || vs_dep_name);
END;

-- 선언이 필요없다면 실행부만 실행가능
BEGIN
 DBMS_OUTPUT.PUT_LINE('3 * 3 =' || 3 * 3);
END;
-- IF 문
DECLARE
 vn_num1 NUMBER := 5;
 vn_num2 NUMBER := :num;       --바인드
BEGIN
 IF vn_num1 > vn_num2 THEN
    DBMS_OUTPUT.PUT_LINE('vn_num1 더큼');
 ELSIF vn_num1 = vn_num2 THEN
    DBMS_OUTPUT.PUT_LINE('같음');
 ELSE
    NULL;
    DBMS_OUTPUT.PUT_LINE('vn_num2 더큼');
 END IF; -- end로 꼭 닫아줘야함.
END;

/* 신입생이 들어왔습니다. ^^
   학번을 만들어 줘야해요
   학생테이블의 학번중 가장 큰 학번의 앞에 4자리 (년도)가 
   조건 : 올해 년도와 다르다면 올해년도 + 00001
         같다면 해당학번 + 1 로 학번을 생성해주세요 ^^
*/
-- 신규학생 : 경영학:팽수, 법학:길동
DECLARE
 vn_this_year VARCHAR2(4) := TO_CHAR(SYSDATE,'YYYY');
 vn_max_hak_no NUMBER;
 vn_make_hak_no NUMBER;
BEGIN
 --가장큰값 조회
 SELECT MAX(학번) INTO vn_max_hak_no FROM 학생;
 --비교 및 번호생성
   DBMS_OUTPUT.PUT_LINE(SUBSTR(vn_max_hak_no, 1, 4));
  IF SUBSTR(vn_max_hak_no, 1, 4) = vn_this_year THEN
   DBMS_OUTPUT.PUT_LINE('?');
  vn_make_hak_no := vn_max_hak_no + 1;
 ELSE
  vn_make_hak_no := vn_this_year || '000001';
 END IF;
 DBMS_OUTPUT.PUT_LINE('생성번호:' || vn_make_hak_no);
 INSERT INTO 학생(학번,이름,전공) VALUES(vn_make_hak_no, :nm, :sub);
 COMMIT;
END;
SELECT *
FROM 학생