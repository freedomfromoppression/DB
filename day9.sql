/* 서브쿼리
    2.인라인뷰(from절)
    select 문의 질의 결과를 마치 테이블처럼 사용
*/
SELECT *
FROM (SELECT 학생.학번 , 학생.이름, 학생.전공
            , COUNT(수강내역.수강내역번호) 수강내역건수
FROM 학생, 수강내역
WHERE 학생.학번= 수강내역.학번(+)
GROUP BY 학생.학번, 학생.이름, 학생.전공
ORDER BY 4 DESC) a --FROM 절에오는 (select문) <-- 테이블처럼 사용가능
WHERE ROWNUM <=1;

SELECT *
FROM(SELECT ROWNUM as rnum
    , a.* --a 테이블 전체컬럼
FROM(SELECT ROWNUM as subRnum, mem_id,mem_name
    FROM member
    WHERE mem_name LIKE '%%'
    ORDER BY mem_name)a
    )--where절 사용하기 위해 한번 더 감쌈
WHERE rnum between 1 and 10;

--학생들중 평정이 높은 상위 5명만 출력하시오
SELECT *
FROM(SELECT 이름, 평점
FROM 학생
ORDER BY 평점 DESC)
WHERE ROWNUM <=5;
--5등만 조회
SELECT *
FROM(SELECT ROWNUM as rnum
    ,a.*
FROM(SELECT 이름, 평점
FROM 학생
ORDER BY 평점 DESC)a
    )
WHERE rnum =5;
--학생들의 경영학중 '평점'이 '가장 높은' 학생의 정보를 출력
SELECT *
FROM(SELECT 이름,전공, 평점
FROM 학생
WHERE 전공 = '법학'
ORDER BY 평점 DESC)
WHERE ROWNUM <= 1;
--학생들의 '전공별' '평점'이 '가장 높은' 학생의 정보를 출력
SELECT *
FROM 학생
WHERE (전공,평점) IN (SELECt 전공, MAX(평점)
                        FROM 학생
                        GROUP BY 전공);
--2000년도 판매(금액)왕을 출력하시오( salaes, employees)
--(판매관련 컬럼 amount_sold, quantity_sold, sales_date)
--스칼라서브쿼리와, 일라인뷰를 사용해보세요
SELECT(select emp_name
       from employees
       where employees_id=a.employee_id) as 이름
       , 
FROM (SELECT employees_id
            ,sum(amout_sold) as 판매금액
            ,sum(quantity_sold) as 판매수량
        FROM sales
        WHERE to_char(sales_date,'YYYY') = '2000'
        GROUP BY employees_id
        ORDER BY 2 desc
        )a
WHERE rownum = 1;

--EXISTS 존재하는지 체크
--EXISTS 서브쿼리에 테이블에 검색조건의 데이터가 존재하면
--        존재하는 데이터에 대해서 메인쿼리에서 조회
SELECT a.department_id
      ,a.department_name
FROM departments a 
WHERE NOT EXISTS (SELECT *     --NOT EXISTS 존재하지 않는
               FROM job_history b
               WHERE b.department_id = a.department_id) ;
-- 수강이력이 없는 학생을 조회하시오
SELECT *
FROM 학생 a
WHERE NOT EXISTS (SELECT *
                  FROM 수강내역
                  WHERE 학번 = a.학번);
--테이블 복사
CREATE TABLE emp_temp AS
SELECT *
FROM employees;
--UPDATE 문 중첩쿼리사용
--전 사원의 급여를 평균 금액으로 갱신
UPDATE emp_temp
SET salary = (SELECT AVG(salary)
               FROM emp_temp);
ROLLBACK;
SELECT *
FROM emp_temp;
--평균 급여보다 많이 받는 사원 삭제
DELETE emp_temp
WHERE salary >=(SELECT AVG(salary)
                FROM emp_temp);

--미국국립표준협회 ANSI, American National Standards Institute
--FROM 절에 조인조건이 들어감
--inner hoin(equi_join)을 표준 ANSI JOIN 방법으로
SELECT a.학번
     , a.이름
     , b.수강내역번호
FROM 학생 a
INNER JOIN 수강내역 b
ON(a.학번 = b.학번)
;
--과목 테이블 추가 INNER JOIN
SELECT a.학번
     , a.이름
     , b.수강내역번호
     , c.과목이름
FROM 학생 a
INNER JOIN 수강내역 b
USING (학번)   --조인하는 컬럼명이 같을떄 USING 사용가능 BUT select에도 
INNER JOIN 과목 C --테이블 명 or 테이블 별칭이 들거아면 안됨.
USING(과목번호);
-- ANSI OUTER JOIN
-- LEFT OUTER JOIN or RIGHT OUTER JOIN
SELECT *
FROM 학생 a 
    ,수강내역 b
WHERE a.학번 = b.학번(+); --일반 outer join

SELECT *
FROM 학생 a
RIGHT OUTER JOIN
수강내역 b
ON (a.학번 = b.학번); --위에 결과가 같음

--매년 국가지역(Americasm, Asia)의 총판매금액을 출력하시오
--sales, customers, countries 테이블 사용
--국가는 country_region, 판매금액은 amout_sold
--일반 join 사용 or ANSI join 사용

SELECT to_char(a.sales_date, 'YYYY') as years
      ,c.country_region
      ,SUM(a.amount_sold) 판매금액
FROM SALES a, CUSTOMERS b, COUNTRIES c
WHERE a.cust_id = b.cust_id
AND b.country_id = c.country_id
AND c.country_region IN ('Americas' , 'Asia')
GROUP BY to_char(a.sales_date, 'YYYY')
          ,c.country_region_id, c.country_region
ORDER BY 2;

/* MERGE(병합)
   특정 조건에 따라 대상 테이블에 대해 
   INSERT or UPDATE or DELETE를 해야할때 1개의 SQL로 처리가능
*/
-- 과목 테이블에
-- 머신러닝 과목이 없으면 INSERT 학점2로 
--               있다면 UPDATE 학점3으로
SELECT MAX(NVL(과목번호, 0)) + 1
FROM 과목;
--MERGE 1.대상테이블이 비교테이블인 경우
MERGE INTO 과목 a
USING DUAL --비교 테이블 DUAL은 대상테이블이 비교테이블일때
ON (a.과목이름 ='머신러닝') --MATCH 조건
WHEN MATCHED THEN
 UPDATE SET a.학점 = 3     --MERGE문 INSERT 와 UPDATE(WHERE)는 테이블 기입 안함
WHEN FOR MATCHED THEN
 INSERT(a.과목번호, a.과목이름, a.학점)
 VALUES( (SELECT MAX(NVL(과목번호, 0)) + 1
         FROM 과목)
         ,'머신러닝',2);
--MERGE 2.다른 테이블에 MATCH 조건이 들어갈 경우
--(1) 사원테이블에 관리자 사번 146인 사원 번호가 일치하는
      --직원의 보너스 금액을 급여의 1%로 업데이트
      --사번과 일치하는게 없다면 급여가 8000 미만인 사원만 0.1%로 인서트 
CREATE TABLE emp_info(
   emp_id NUMBER
  ,bonus NUMBER default 0
);
INSERT INTO emp_info(emp_id)
SELECT a.employee_id
FROM employees a
WHERE a.emp_name LIKE 'L%';
SELECT *
FROM emp_info;

--매니저 사번이 146 업데이트 대상건
SELECT a.employee_id, a.salary * 0.01, a.manager_id
FROM employees a
WHERE manager_id = 146
AND a.employee_id IN (SELECT emp_id
                     FROM emp_info);
-- INSERT 대상건                    
SELECT a.employee_id, a.salary * 0.01, a.manager_id
FROM employees a
WHERE manager_id = 146
AND a.employee_id NOT IN (SELECT emp_id
                     FROM emp_info);
MERGE INTO emp_info a
USING (SELECT employee_id, salary, manager_id
       FROM employees
       WHERE manger_id = 146) b
    ON(a.emp_id = b.employee_id)    -- match 조건
WHEN MATCHED THEN
  UPDATE SET a.bonus = a.bonus + b.salary * 0.01
WHEN NOT MATCHED THEN
  INSERT (a.emp_id, a.bonus) VALUES (b.employee_id, b.salary * 0.001)
  WHERE (b.salary < 8000);
  
-- 있으면 MBTI, TEAM UPDATE
-- 없으면 INSERT SSAM
MERGE INTO TB_INFO a
USING (SELECT INFO_NO
             ,TEAM
             ,MBTI
        FROM INFO) b
ON (a.INFO_NO = b.INFO_NO) --match 조건
WHEN MATCHED THEN
 update SET a.MBTI = b.MBTI
           ,a.TEAM = b.TEAM
;
ALTER TABLE TB_INFO ADD MBTI VARCHAR2(4);
SELECT *
FROM TB_INFO;

SELECT *
FROM INFO;


--문제1 우리반 MBTI를 출력하세요
--문제 2 통계
SELECT nm
      ,mbti
     , DECODE(SUBSTR(mbti,1,1),'I', '내향형', 'E', '외향형') as 에너지기능
     , DECODE(SUBSTR(mbti,2,1),'S', '직관형', 'N', '감각형') as 인식기능
     , DECODE(SUBSTR(mbti,3,1),'F', '감성형', 'T', '사고형') as 판단기능
     , DECODE(SUBSTR(mbti,4,1),'P', '인식형', 'J', '판단형') as 생활양식
FROM tb_info
WHERE MBTI != '?';

SELECT SUBSTR(mbti,1,1) as 에너지기능
      ,SUBSTR(mbti,2,1) as 인식기능
      ,SUBSTR(mbti,3,1) as 판단기능
      ,SUBSTR(mbti,4,1) as 생활양식
      ,COUNT (*) as mbti_count
FROM tb_info
WHERE mbti !='?'
GROUP BY SUBSTR(mbti,1,1),SUBSTR(mbti,2,1),SUBSTR(mbti,3,1),SUBSTR(mbti,4,1);
GROUP BY 1;

      




