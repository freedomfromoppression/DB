-- || 문자열 더하기 
SELECT pc_no || '[' || nm || ']' as info
FROM tb_info;
/*
    oracle 단일행 함수 (내장 함수)
    오라클 함수의 특징은 select 문에 사용되어야 하기 때문에 
    무조건 반환값이 있음.
    내장함수는 각 타입별 사용할 수 있는 함수가 있음.
*/
-- 문자열 함수 
-- LOWER, UPPER 
SELECT LOWER('I LIKE MAC') as lowers
    ,  UPPER('i like mac') as uppers
FROM dual ; -- 테스트용 임시 테이블(sql 문법을 맞추기위함)
SELECT emp_name, LOWER(emp_name)
FROM employees
WHERE LOWER(emp_name) = LOWER('WILLIAM SMITH');

-- select 문 실행순서
-- (1) FROM->(2)WHERE->(3)GROUP BY->(4)HAVING->(5)SELECT->(6)ORDER BY
SELECT 'hi'
FROM employees; -- 테이블 건수만큼 조회됨.

--  employees 에서 이름 -> william 포함된 직원을 모두 조회하시오 
SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER('william')|| '%';

SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE UPPER('%william%');
-- '%WILLIAM%';
-- SUBSTR(char, pos, len) 대상문자열 char의 pos번째부터 len 길이만큼 자름
-- pos에 0 오면 1로 (디폴트 1)
-- pos에 음수가 오면 문자열의 맨 끝에서 시작한 상대적 위치 
-- len이 생략되면 pos번째 부터 나머지 모든 문자를 반환 
SELECT SUBSTR('ABCD EFG', 1, 4)  as ex1
     , SUBSTR('ABCD EFG', 4)     as ex2
     , SUBSTR('ABCD EFG', -3, 3) as ex3   
FROM dual;

-- INSTR 대상 문자열의 위치 찾기 
-- 매개변수 총 4개 2개는 필수 뒤에는 디폴트 1, 1 
-- (p1, p2, p3, p4) p1 대상문자열, p2 찾을문자, p3 찾기시작위치, p4찾을문자의 몇번째 출현
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약') as ex1
    ,  INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약',5) as ex2
    ,  INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약',1, 2) as ex3
    ,  INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','나') as ex4 -- 없으면 0
FROM dual;
-- tb_info 학생의 이름과 이메일 주소를 출력하시오 
-- 단 : 이메일 주소를  아이디와 도메인을 분리하여 출력하시오 
--     leeapgil@gmail.com ->>   아이디:leeapgil 도메인:gmail.com
SELECT nm
     , email
     , SUBSTR(email, 1, INSTR(email, '@') -1 )  as 아이디
     , SUBSTR(email,  INSTR(email, '@') + 1) as 도메인
FROM tb_info; 

