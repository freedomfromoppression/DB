
/*DML : INSERT ������ ����*/
-- 1.�⺻���� �÷��� ���
DROP TABLE ex3_1;
CREATE TABLE ex3_1(
     co11 VARCHAR2(100)
    ,CO12 NUMBER
    ,CO13 DATE
);
INSERT INTO ex3_1 (CO11, CO12, CO13)
VALUES ('nick', 10, SYSDATE);
-- ���ڿ�Ÿ���� '' ���ڴ� �׳� ���ڷ� ������ '10'�� �޾���.
INSERT INTO ex3_1(co11, co12) -- Ư���÷��� �����ҋ��� ������ �÷��� �ۼ�
VALUES('judy', 9_);
INSERT INTO ex3_1 (co11, co12)  -- Ư���÷��� �����ҋ��� ������ �÷��� �ۼ�
VALUES('jack','20');
--2. ���̺� �ִ� ��ü�÷��� ���ؼ� �����Ҷ��� �Ƚᵵ��.
INSERT INTO ex3_1 VALUES('�ؼ�', 10, SYSDATE);
--3. select ~ insert ��ȸ����� ����
INSERT INTO ex3_1(co11, co12)
SELECT emp_name, employee_id
FROM employees;


--�Ʒ� ��ȸ����� ex3_1 ���̺� �����ϼ���
INSERT INTO ex3_1 (co11,co12)
SELECT nm, team
FROM tb_info;

--DML: UPDATE ������ ����
UPDATE ex3_1
SET co12 = 20  --�����ϰ����ϴ� �÷��� ������
   ,co13 = SYSDATE --�����ؾ��ϴ� �ø��� ��������� , �� �߰��߰�
WHERE coll = 'nick'; --�����Ǿ����� �࿡���� ����

UPDATE tb_info
set hobby ='sleep'
WHERE = nm '�����';

SELECT * FROM tb_info;

-- DML:DELETE �����ͻ���
DELETE ex3_1; --��ü ����
DELETE ex3_1
WHERE co11 = 'nick'; --Ư�� ������ ����
DELETE dep
WHERE deptno = 3; --emp���� �����ϰ� �־ ������ �ȵ�.
SELECT *
FROM emp;
DELETE emp
WHERE empno = 200; --dep �����ϰ� �ִ� emp ������ ���� ���� �� ��������

DELETE dep;
--�������ǵ� ���� �� ���̺� ����(�����ϴ� ���̺��� �־ ������ �ȵɶ�
DROP TABLE dep CASCADE CONSTRAINTS;


--�ǻ��÷� (���̺��� ������ �ִ°�ó�� ���
SELECT ROWNUM as rnum
            , pc_no
            , nm
            , hobby
FROM tb_info
WHERE ROWNUM <= 10;
--�ߺ����� (DISTINCT)
SELECT DISTINCT cust_gender
FROM customers;
--ǥ����(���̺� Ư�� �������� ǥ���� �ٲٰ� ������ ���
SELECT cust_name
      ,CASE WHEN cust_gender = 'M' THEN '����'
            WHEN cust_gender = 'F' THEN '����'
        ELSE '?'
        END as gender
FROM customers;
--  salary 10000 �̻� ��׿���, �������� ����
SELECT emp_name
      ,salary
      ,CASE WHEN salary >= 10000 THEN '��׿���'
           ELSE '����'
        END as salary
FROM employees;
-- NULL ���ǽİ� �����ǽ�(AND,OR,NOT)
SELECT *
FROM departments
WHERE parent_id IS NULL; --�÷��� ���� null��
--NULL�� �ƴ��� IS NOT NULL
SELECT *
FROM departments
WHERE parent_id IS NOT NULL; --�÷��� ���� NULL�� �ƴ�
-- IN ���ǽ�(������ or �� �ʿ��Ҷ�)
-- ex)30��,60��,80�� �μ� ��ȸ
SELECT emp_name, department_id
FROM employees
WHERE department_id IN (30,60,80);
--LIKE �˻� ���ڿ� ���ϰ˻�
SELECT *
FROM tb_info
WHERE nm LIKE '��%'; --������ �����ϴ� ���
WHERE nm LIKE '%��%'; --���� ���Ե� ����  
--tb_info ���� email�� 94 ���Ե� �л��� ��ȸ�Ͻÿ�
SELECT *
FROM tb_info
WHERE email LIKE '%94%';

-- || ���ڿ� ���ϱ�
SELECT pc_no || '[' || nm ||']' as info
FROM tb_info;

/* 
    oracle ������ �Լ� (���� �Լ�)
    ����Ŭ �Լ��� Ư¡�� select ���� ���Ǿ�� �ϱ� ������
    ������ ��ȯ���� ����.
    �����Լ��� �� Ÿ�Ժ� ����� �� �ִ� �Լ��� ����.
*/
--���ڿ� �Լ�
--LOWER, UPPER
SELECT LOWER('I LIKE MAC') as lowers
      , UPPER('i like mac') as uppers
FROM dual ; --�׽�Ʈ�� �ӽ� ���̺�(sql ������ ���߱� ����
SELECT emp_name
FROM employees
WHERE LOWER(emp_name) = LOWER('WILLIAM SMITH');

--SELECT �� �������
-- (1) FROM ->(2)WHERE ->(3)GROUP BY ->(4)HAVING ->(5)SELECT->(6)ORDER BY

--employees ���� �̸� ->william ���Ե� ������ ��� ��ȸ�Ͻÿ�
SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER('william')|| '%';
-- '%WILLIAM%';
--SUBSTR(char, pos, len) ����ڿ� char�� pos�������� len ���̸�ŭ �ڸ�
--pos�� 0�� ���� 1�� (����Ʈ1)
--pos�� ������ ���� ���ڿ��� �� ������ ������ ����� ��ġ
--len�� �����Ǹ� pos�������� ������ ��� ���ڸ� ��ȯ
SELECT SUBSTR('ABCD EFG', 1, 4)   as ex1
      , SUBSTR('ABCD EFG', 4)     as ex2
      , SUBSTR('ABCD EFG', -3, 3) as ex3
FROM dual;

--INSTR ��� ���ڿ��� ��ġ ã��
--�Ű����� �� 4�� 2���� �ʼ� �ڿ��� ����Ʈ 1,1
--(p1,p2,p3,p4) p1 ����ڿ�, p2ã������, p3ã�������ġ, p4ã�������� ���° ����
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����') as ex1
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',5) as ex2
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',1,2) as ex3
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','��') as ex4 --������ 0
FROM dual;
--tb_info �л��� �̸��� �̸��� �ּҸ� ����Ͻÿ�
--�� : �̸��� �ּҸ� ���̵�� �������� �Ҹ��Ͽ� ����Ͻÿ�
--      leeapgil@gamil.com ->> ���̵�:leeapgil ������:gamil.com

SELECT email 
FROM tb_info;


SELECT SUBSTR(email,1 ,INSTR(email, '@')-1) as ������
     , SUBSTR(email, INSTR(email, '@')+1) as �̸���
FROM tb_infO;



