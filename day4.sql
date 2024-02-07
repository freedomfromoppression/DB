-- || ���ڿ� ���ϱ� 
SELECT pc_no || '[' || nm || ']' as info
FROM tb_info;
/*
    oracle ������ �Լ� (���� �Լ�)
    ����Ŭ �Լ��� Ư¡�� select ���� ���Ǿ�� �ϱ� ������ 
    ������ ��ȯ���� ����.
    �����Լ��� �� Ÿ�Ժ� ����� �� �ִ� �Լ��� ����.
*/
-- ���ڿ� �Լ� 
-- LOWER, UPPER 
SELECT LOWER('I LIKE MAC') as lowers
    ,  UPPER('i like mac') as uppers
FROM dual ; -- �׽�Ʈ�� �ӽ� ���̺�(sql ������ ���߱�����)
SELECT emp_name, LOWER(emp_name)
FROM employees
WHERE LOWER(emp_name) = LOWER('WILLIAM SMITH');

-- select �� �������
-- (1) FROM->(2)WHERE->(3)GROUP BY->(4)HAVING->(5)SELECT->(6)ORDER BY
SELECT 'hi'
FROM employees; -- ���̺� �Ǽ���ŭ ��ȸ��.

--  employees ���� �̸� -> william ���Ե� ������ ��� ��ȸ�Ͻÿ� 
SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE '%'||UPPER('william')|| '%';

SELECT emp_name
FROM employees
WHERE UPPER(emp_name) LIKE UPPER('%william%');
-- '%WILLIAM%';
-- SUBSTR(char, pos, len) ����ڿ� char�� pos��°���� len ���̸�ŭ �ڸ�
-- pos�� 0 ���� 1�� (����Ʈ 1)
-- pos�� ������ ���� ���ڿ��� �� ������ ������ ����� ��ġ 
-- len�� �����Ǹ� pos��° ���� ������ ��� ���ڸ� ��ȯ 
SELECT SUBSTR('ABCD EFG', 1, 4)  as ex1
     , SUBSTR('ABCD EFG', 4)     as ex2
     , SUBSTR('ABCD EFG', -3, 3) as ex3   
FROM dual;

-- INSTR ��� ���ڿ��� ��ġ ã�� 
-- �Ű����� �� 4�� 2���� �ʼ� �ڿ��� ����Ʈ 1, 1 
-- (p1, p2, p3, p4) p1 ����ڿ�, p2 ã������, p3 ã�������ġ, p4ã�������� ���° ����
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����') as ex1
    ,  INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',5) as ex2
    ,  INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����',1, 2) as ex3
    ,  INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','��') as ex4 -- ������ 0
FROM dual;
-- tb_info �л��� �̸��� �̸��� �ּҸ� ����Ͻÿ� 
-- �� : �̸��� �ּҸ�  ���̵�� �������� �и��Ͽ� ����Ͻÿ� 
--     leeapgil@gmail.com ->>   ���̵�:leeapgil ������:gmail.com
SELECT nm
     , email
     , SUBSTR(email, 1, INSTR(email, '@') -1 )  as ���̵�
     , SUBSTR(email,  INSTR(email, '@') + 1) as ������
FROM tb_info; 

