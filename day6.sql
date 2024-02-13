/* �����Լ� ��� �����͸� Ư�� �׷����� ���� ���� �׷쿡 ����
   ����,���,�ִ�,�ּڰ� ���� ���ϴ� �Լ�.
*/
--CONUT �ο� ���� ��ȯ�ϴ� �����Լ�
SELECT COUNT(*)                                 -- NULL����
      ,COUNT(department_id)                     --DEFAULT ALL
      ,COUNT(ALL department_id)                 --�ߺ�����, NULLX
      ,COUNT(DISTINCT department_id)            --�ߺ�����
      ,COUNT(employee_id)      
FROM employees;
SELECT COUNT(mem_id)
      ,COUNT(*)
FROM member;
SELECT SUM(salary)          as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary)          as �ִ�
      ,MIN(salary)          as �ּ�
      ,COUNT(employee_id)   as ������
FROM employees;
--�μ��� ���� <-- �׷��� ��� �μ�
SELECT department_id
      ,SUM(salary)          as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary)          as �ִ�
      ,MIN(salary)          as �ּ�
      ,COUNT(employee_id)   as ������
FROM employees
GROUP BY department_id
ORDER BY 1;
--30, 60, 90�μ��� ����
SELECT department_id
      ,SUM(salary)          as �հ�
      ,ROUND(AVG(salary),2) as ���
      ,MAX(salary)          as �ִ�
      ,MIN(salary)          as �ּ�
      ,COUNT(employee_id)   as ������
FROM employees
WHERE department_id IN(30, 60, 90)
GROUP BY department_id
GROUP BY 1;
--member ȸ���� ������ ���ϸ����� �հ�,���,�ִ�,�ּҰ��� ȸ������ ����Ͻÿ�
SELECT mem_job
         ,SUM(mem_mileage)          as ���ϸ����հ�
         ,ROUND(AVG(mem_mileage),2) as ���ϸ������
         ,MAX(mem_mileage)          as ���ϸ����ִ�
         ,MIN(mem_mileage)          as ���ϸ����ּ�
         ,COUNT(mem_mileage)        as ȸ����
FROM member
GROUP BY mem_job
ORDER BY 4 DESC;

--kor_loan_status ���̺� loan_jan_amt �÷��� Ȱ���Ͽ�
--2013�⵵ �Ⱓ�� �� �����ܾ��� ����Ͻÿ�
SELECT PERIOD
      , SUM(loan_jan_amt) as ���հ�
FROM kor_loan_status
WHERE period LIKE '2013%';
GROUP BY PERIOD
ORDER BY 1 ;
--�Ⱓ��, ������, �������հ踦 ����Ͻÿ�
SELECT   period
       , region
       , SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
GROUP BY period
        ,region
ORDER BY 1;
--�⵵��, ������ �����հ�
SELECT SUBSTR (period,1,4) as �⵵
       , region
       , SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
WHERE region ='����'
GROUP BY SUBSTR (period,1,4)
        ,region
ORDER BY 1;

-- employees �������� �Ի�⵵�� �������� ����Ͻÿ�

SELECT TO_CHAR(hire_date,'YYYY') as �⵵
        , COUNT(*) AS ������
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY �⵵;
--���� �����Ϳ� ���ؼ� �˻������� ����Ϸ��� HAVING ���
--�Ի������� 10�� �̻��� �⵵�� ������ ���
--select�� �������
--from -> where -> group by -> having -> select -> order by
SELECT TO_CHAR(hire_date,'YYYY') as �⵵
        , COUNT(*) AS ������
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
HAVING COUNT(*) >= 10
ORDER BY �⵵;

--member ���̺��� Ȱ���Ͽ�
--������ ���ϸ��� ��ձݾ��� ���Ͻÿ�
--(�Ҽ��� 2° �ڸ����� �ݿø��Ͽ� ���)
--(1) ���� ��ո��ϸ��� ��������
--(2) ��� ���ϸ����� 3000�̻��� �����͸� ���
SELECT mem_job
       ,ROUND(AVG(mem_mileage),2) as ���
FROM member
GROUP BY mem_job
HAVING ROUND(AVG(mem_mileage),2) >= 3000
ORDER BY ��� DESC;
--customers ȸ������ ��ü ȸ����, ����ȸ����, ����ȸ������ ����Ͻÿ� 

SELECT 
  COUNT(CUST_GENDER) as ��ü -- CUST_GENDER �÷��� ���� �ִ� ��� ���� ���� ���� ��ü ȸ�� ���� ��Ÿ���ϴ�.
  , SUM (DECODE(CUST_GENDER, 'M', 1, 0)) as ���� -- CUST_GENDER �÷��� ���� 'M'�� ��� 1��, �ƴ� ��� 0�� ��ȯ�Ͽ� ��� ���� ���� ȸ�� ���� ��Ÿ���ϴ�.
  , SUM (DECODE(CUST_GENDER, 'F', 1, 0)) as ���� -- CUST_GENDER �÷��� ���� 'F'�� ��� 1��, �ƴ� ��� 0�� ��ȯ�Ͽ� ��� ���� ���� ȸ�� ���� ��Ÿ���ϴ�.
FROM customers; -- customers ���̺��� ���� ���ǿ� �´� �����͸� �����ɴϴ�.
        
