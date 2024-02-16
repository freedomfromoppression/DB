/* ��������
    2.�ζ��κ�(from��)
    select ���� ���� ����� ��ġ ���̺�ó�� ���
*/
SELECT *
FROM (SELECT �л�.�й� , �л�.�̸�, �л�.����
            , COUNT(��������.����������ȣ) ���������Ǽ�
FROM �л�, ��������
WHERE �л�.�й�= ��������.�й�(+)
GROUP BY �л�.�й�, �л�.�̸�, �л�.����
ORDER BY 4 DESC) a --FROM �������� (select��) <-- ���̺�ó�� ��밡��
WHERE ROWNUM <=1;

SELECT *
FROM(SELECT ROWNUM as rnum
    , a.* --a ���̺� ��ü�÷�
FROM(SELECT ROWNUM as subRnum, mem_id,mem_name
    FROM member
    WHERE mem_name LIKE '%%'
    ORDER BY mem_name)a
    )--where�� ����ϱ� ���� �ѹ� �� ����
WHERE rnum between 1 and 10;

--�л����� ������ ���� ���� 5�� ����Ͻÿ�
SELECT *
FROM(SELECT �̸�, ����
FROM �л�
ORDER BY ���� DESC)
WHERE ROWNUM <=5;
--5� ��ȸ
SELECT *
FROM(SELECT ROWNUM as rnum
    ,a.*
FROM(SELECT �̸�, ����
FROM �л�
ORDER BY ���� DESC)a
    )
WHERE rnum =5;
--�л����� �濵���� '����'�� '���� ����' �л��� ������ ���
SELECT *
FROM(SELECT �̸�,����, ����
FROM �л�
WHERE ���� = '����'
ORDER BY ���� DESC)
WHERE ROWNUM <= 1;
--�л����� '������' '����'�� '���� ����' �л��� ������ ���
SELECT *
FROM �л�
WHERE (����,����) IN (SELECt ����, MAX(����)
                        FROM �л�
                        GROUP BY ����);
--2000�⵵ �Ǹ�(�ݾ�)���� ����Ͻÿ�( salaes, employees)
--(�ǸŰ��� �÷� amount_sold, quantity_sold, sales_date)
--��Į�󼭺�������, �϶��κ並 ����غ�����
SELECT(select emp_name
       from employees
       where employees_id=a.employee_id) as �̸�
       , 
FROM (SELECT employees_id
            ,sum(amout_sold) as �Ǹűݾ�
            ,sum(quantity_sold) as �Ǹż���
        FROM sales
        WHERE to_char(sales_date,'YYYY') = '2000'
        GROUP BY employees_id
        ORDER BY 2 desc
        )a
WHERE rownum = 1;

--EXISTS �����ϴ��� üũ
--EXISTS ���������� ���̺� �˻������� �����Ͱ� �����ϸ�
--        �����ϴ� �����Ϳ� ���ؼ� ������������ ��ȸ
SELECT a.department_id
      ,a.department_name
FROM departments a 
WHERE NOT EXISTS (SELECT *     --NOT EXISTS �������� �ʴ�
               FROM job_history b
               WHERE b.department_id = a.department_id) ;
-- �����̷��� ���� �л��� ��ȸ�Ͻÿ�
SELECT *
FROM �л� a
WHERE NOT EXISTS (SELECT *
                  FROM ��������
                  WHERE �й� = a.�й�);
--���̺� ����
CREATE TABLE emp_temp AS
SELECT *
FROM employees;
--UPDATE �� ��ø�������
--�� ����� �޿��� ��� �ݾ����� ����
UPDATE emp_temp
SET salary = (SELECT AVG(salary)
               FROM emp_temp);
ROLLBACK;
SELECT *
FROM emp_temp;
--��� �޿����� ���� �޴� ��� ����
DELETE emp_temp
WHERE salary >=(SELECT AVG(salary)
                FROM emp_temp);

--�̱�����ǥ����ȸ ANSI, American National Standards Institute
--FROM ���� ���������� ��
--inner hoin(equi_join)�� ǥ�� ANSI JOIN �������
SELECT a.�й�
     , a.�̸�
     , b.����������ȣ
FROM �л� a
INNER JOIN �������� b
ON(a.�й� = b.�й�)
;
--���� ���̺� �߰� INNER JOIN
SELECT a.�й�
     , a.�̸�
     , b.����������ȣ
     , c.�����̸�
FROM �л� a
INNER JOIN �������� b
USING (�й�)   --�����ϴ� �÷����� ������ USING ��밡�� BUT select���� 
INNER JOIN ���� C --���̺� �� or ���̺� ��Ī�� ��žƸ� �ȵ�.
USING(�����ȣ);
-- ANSI OUTER JOIN
-- LEFT OUTER JOIN or RIGHT OUTER JOIN
SELECT *
FROM �л� a 
    ,�������� b
WHERE a.�й� = b.�й�(+); --�Ϲ� outer join

SELECT *
FROM �л� a
RIGHT OUTER JOIN
�������� b
ON (a.�й� = b.�й�); --���� ����� ����

--�ų� ��������(Americasm, Asia)�� ���Ǹűݾ��� ����Ͻÿ�
--sales, customers, countries ���̺� ���
--������ country_region, �Ǹűݾ��� amout_sold
--�Ϲ� join ��� or ANSI join ���

SELECT to_char(a.sales_date, 'YYYY') as years
      ,c.country_region
      ,SUM(a.amount_sold) �Ǹűݾ�
FROM SALES a, CUSTOMERS b, COUNTRIES c
WHERE a.cust_id = b.cust_id
AND b.country_id = c.country_id
AND c.country_region IN ('Americas' , 'Asia')
GROUP BY to_char(a.sales_date, 'YYYY')
          ,c.country_region_id, c.country_region
ORDER BY 2;

/* MERGE(����)
   Ư�� ���ǿ� ���� ��� ���̺� ���� 
   INSERT or UPDATE or DELETE�� �ؾ��Ҷ� 1���� SQL�� ó������
*/
-- ���� ���̺�
-- �ӽŷ��� ������ ������ INSERT ����2�� 
--               �ִٸ� UPDATE ����3����
SELECT MAX(NVL(�����ȣ, 0)) + 1
FROM ����;
--MERGE 1.������̺��� �����̺��� ���
MERGE INTO ���� a
USING DUAL --�� ���̺� DUAL�� ������̺��� �����̺��϶�
ON (a.�����̸� ='�ӽŷ���') --MATCH ����
WHEN MATCHED THEN
 UPDATE SET a.���� = 3     --MERGE�� INSERT �� UPDATE(WHERE)�� ���̺� ���� ����
WHEN FOR MATCHED THEN
 INSERT(a.�����ȣ, a.�����̸�, a.����)
 VALUES( (SELECT MAX(NVL(�����ȣ, 0)) + 1
         FROM ����)
         ,'�ӽŷ���',2);
--MERGE 2.�ٸ� ���̺� MATCH ������ �� ���
--(1) ������̺� ������ ��� 146�� ��� ��ȣ�� ��ġ�ϴ�
      --������ ���ʽ� �ݾ��� �޿��� 1%�� ������Ʈ
      --����� ��ġ�ϴ°� ���ٸ� �޿��� 8000 �̸��� ����� 0.1%�� �μ�Ʈ 
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

--�Ŵ��� ����� 146 ������Ʈ ����
SELECT a.employee_id, a.salary * 0.01, a.manager_id
FROM employees a
WHERE manager_id = 146
AND a.employee_id IN (SELECT emp_id
                     FROM emp_info);
-- INSERT ����                    
SELECT a.employee_id, a.salary * 0.01, a.manager_id
FROM employees a
WHERE manager_id = 146
AND a.employee_id NOT IN (SELECT emp_id
                     FROM emp_info);
MERGE INTO emp_info a
USING (SELECT employee_id, salary, manager_id
       FROM employees
       WHERE manger_id = 146) b
    ON(a.emp_id = b.employee_id)    -- match ����
WHEN MATCHED THEN
  UPDATE SET a.bonus = a.bonus + b.salary * 0.01
WHEN NOT MATCHED THEN
  INSERT (a.emp_id, a.bonus) VALUES (b.employee_id, b.salary * 0.001)
  WHERE (b.salary < 8000);
  
-- ������ MBTI, TEAM UPDATE
-- ������ INSERT SSAM
MERGE INTO TB_INFO a
USING (SELECT INFO_NO
             ,TEAM
             ,MBTI
        FROM INFO) b
ON (a.INFO_NO = b.INFO_NO) --match ����
WHEN MATCHED THEN
 update SET a.MBTI = b.MBTI
           ,a.TEAM = b.TEAM
;
ALTER TABLE TB_INFO ADD MBTI VARCHAR2(4);
SELECT *
FROM TB_INFO;

SELECT *
FROM INFO;


--����1 �츮�� MBTI�� ����ϼ���
--���� 2 ���
SELECT nm
      ,mbti
     , DECODE(SUBSTR(mbti,1,1),'I', '������', 'E', '������') as ���������
     , DECODE(SUBSTR(mbti,2,1),'S', '������', 'N', '������') as �νı��
     , DECODE(SUBSTR(mbti,3,1),'F', '������', 'T', '�����') as �Ǵܱ��
     , DECODE(SUBSTR(mbti,4,1),'P', '�ν���', 'J', '�Ǵ���') as ��Ȱ���
FROM tb_info
WHERE MBTI != '?';

SELECT SUBSTR(mbti,1,1) as ���������
      ,SUBSTR(mbti,2,1) as �νı��
      ,SUBSTR(mbti,3,1) as �Ǵܱ��
      ,SUBSTR(mbti,4,1) as ��Ȱ���
      ,COUNT (*) as mbti_count
FROM tb_info
WHERE mbti !='?'
GROUP BY SUBSTR(mbti,1,1),SUBSTR(mbti,2,1),SUBSTR(mbti,3,1),SUBSTR(mbti,4,1);
GROUP BY 1;

      




