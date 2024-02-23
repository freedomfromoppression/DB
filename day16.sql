/* �м��Լ��� window��( �׷�ȿ� �κ�����)
   ROWS :�� ������ WINDOW ���� ����
   RANGE : ������ ������ WINDOW�� ����
   PRECEDING : ��Ƽ������ ���е� ù ��° �ο찡 ������.
   FOLLOWING : ��Ƽ������ ���е� ������ �ο찡 �� ����
   CURRENT ROW : ����ο�
*/
SELECT department_id, emp_name, hire_date, salary
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN UNBOUNDED PRECEDING
                        AND CURRENT ROW) as first_curr
                        -- ���� �Ի簡 ���� ������� ���� �ο�
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN CURRENT ROW
                        AND UNBOUNDED FOLLOWING) as curr_last  
                        --���� �ο� ���� ��       
     , SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date
                        ROWS BETWEEN 1 PRECEDING
                        AND CURRENT ROW) as rowl_curr 
                        -- 1�� ���� + ���� �ο�
FROM employees
WHERE department_id IN (30, 90);

-- study ������ reservation, order_info ���̺��� �̿��Ͽ�
-- ���� �����ݾ��� ����Ͻÿ�
-- RATIO_TO_REPORT : ���� �� �� �׸��� ������ ���(���� ������ �ش� ���� �����ϴ� ����
SELECT t1.*
     , ROUND(RATIO_TO_REPORT(t1.sales) OVER() *100,2) || '%' as ����
     , SUM(t1.sales) OVER(order by months
                          rows between unbounded
                          preceding and current row) as ��������
FROM (
SELECT SUBSTR(a.reserv_date, 1, 6) as months
     , SUM(b.sales) as sales
FROM reservation a, order_info b
WHERE a.reserv_no = b.reserv_no
GROUP BY SUBSTR(a.reserv_date, 1, 6)
ORDER BY 1
) t1;

/*
    PL/SQL ������ ���������� ����� Ư¡�� ��� ������ ����.
    Ư�� ����� ó���ϴ� �Լ�, ���ν���, Ʈ���� ���� ���� �� ����.
    DB���ο� ������� �Ϲ� ���α׷��� ���� ����.
*/
SET SERVEROUTPUT ON; 
-- PL/SPQ �������� ��ũ��Ʈ ��¿� ���'

-- �⺻ ������ ����̶�� �ϸ� ����� �̸���, �����, �����(����ó����) �� ������.
DECLARE --          <-�͸� ���
 vi_num NUMBER;     -- ��������
BEGIN
 vi_num := 100; --�� �Ҵ�
DBMS_OUTPUT.PUT_LINE(vi_num); --����Ʈ
END;
-- PL/SPQ������ ��ü ����� ���� �� �����ؾ���.

-- ����ο��� DML���� �� �� ����.
DECLARE
 vs_emp_name VARCHAR2(80); -- number�� ����� �Ƚᵵ��. 
 vs_dep_name department.department_name%TYPE; -- ���̺� �÷�Ÿ��
BEGIN
 SELECT a.emp_name, b.department_name
  INTO vs_emp_name, vs_dep_name -- ������ ���ǰ���� ����.
 FROM employees a, departments b
 WHERE a.department_id = b.department_id
 AND a.employees_id = 100; -- �ϳ��� �������� 1���� �� ���� �Ҵ簡��
 DBMS_OUTPUT.PUT_LINE(vs_emp_name || ':' || vs_dep_name);
END;

-- ������ �ʿ���ٸ� ����θ� ���డ��
BEGIN
 DBMS_OUTPUT.PUT_LINE('3 * 3 =' || 3 * 3);
END;
-- IF ��
DECLARE
 vn_num1 NUMBER := 5;
 vn_num2 NUMBER := :num;       --���ε�
BEGIN
 IF vn_num1 > vn_num2 THEN
    DBMS_OUTPUT.PUT_LINE('vn_num1 ��ŭ');
 ELSIF vn_num1 = vn_num2 THEN
    DBMS_OUTPUT.PUT_LINE('����');
 ELSE
    NULL;
    DBMS_OUTPUT.PUT_LINE('vn_num2 ��ŭ');
 END IF; -- end�� �� �ݾ������.
END;

/* ���Ի��� ���Խ��ϴ�. ^^
   �й��� ����� ����ؿ�
   �л����̺��� �й��� ���� ū �й��� �տ� 4�ڸ� (�⵵)�� 
   ���� : ���� �⵵�� �ٸ��ٸ� ���س⵵ + 00001
         ���ٸ� �ش��й� + 1 �� �й��� �������ּ��� ^^
*/
-- �ű��л� : �濵��:�ؼ�, ����:�浿
DECLARE
 vn_this_year VARCHAR2(4) := TO_CHAR(SYSDATE,'YYYY');
 vn_max_hak_no NUMBER;
 vn_make_hak_no NUMBER;
BEGIN
 --����ū�� ��ȸ
 SELECT MAX(�й�) INTO vn_max_hak_no FROM �л�;
 --�� �� ��ȣ����
   DBMS_OUTPUT.PUT_LINE(SUBSTR(vn_max_hak_no, 1, 4));
  IF SUBSTR(vn_max_hak_no, 1, 4) = vn_this_year THEN
   DBMS_OUTPUT.PUT_LINE('?');
  vn_make_hak_no := vn_max_hak_no + 1;
 ELSE
  vn_make_hak_no := vn_this_year || '000001';
 END IF;
 DBMS_OUTPUT.PUT_LINE('������ȣ:' || vn_make_hak_no);
 INSERT INTO �л�(�й�,�̸�,����) VALUES(vn_make_hak_no, :nm, :sub);
 COMMIT;
END;
SELECT *
FROM �л�