SELECT gubun
      ,SUM(loan_jan_amt) as �հ�
FROM kor_loan_status
GROUP BY ROLLUP(gubun);
--member ������ ���ϸ����� �հ�� ��ü �Ѱ踦 ���Ͻÿ�
SELECT mem_job
      ,SUM(mem_mileage) �հ�
FROM member
GROUP BY ROLLUP(mem_job);

SELECT period
      , gubun
      , sum(loan_jan_amt) �հ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY ROLLUP(gubun,period); --period�� �Ұ�
--employees ���̺��� ������ ��
--�μ��� �������� ��ü �������� ����Ͻÿ�

--grouping_id
SELECT CASE WHEN department_id IS NULL AND grouping_id(department_id)=0 THEN '�μ�����'
            WHEN department_id IS NULL AND grouping_id(department_id)=1 THEN '�Ѱ�'
            ELSE TO_CHAR(department_id)
            END AS �μ�
      ,count(*) as ������
FROM employees
GROUP BY ROLLUP(department_id);
member ȸ���� ���������� ȸ���� ������ �ο����� ���ϸ��� �հ� �ݾ��� ��� ����Ͻÿ�(�Ѱ赵)
SELECT NVL(mem_job,'�� ��') as ����
      , COUNT(*) as ȸ����
      , SUM(mem_mileage) as ���ϸ����հ�
FROM member
WHERE mem_add1 LIKE '%����'
GROUP BY ROLLUP(mem_job);


--���� UNION(������), UNION ALL ��ü����, MINUS ������ INTERSECT ������
--��ȸ����� �÷����� Ÿ���� ������ �������밡��(������ �������� ����)
SELECT seq, goods
FROM exp_goods_asia
WHERE country='�ѱ�'
UNION
SELECT 1, 'hi'
FROM dual;
SELECT seq, goods
FROM exp_goods_asia
WHERE country='�Ϻ�';

SELECT mem_job
      ,SUM(mem_mileage) as �հ�
FROM member
GROUP BY mem_job
UNION
SELECT '�հ�'
      ,SUM(mem_mileage)
FROM member
ORDER BY 2 asc;
--������ �̹� ������ commission_pct ��ŭ �߰����� �Ϸ��� �մϴ�.
--���ް�, �߰��ݾ�, �ջ�ݾ��� ����Ͻÿ�
--NVL(����, ���氪) ������ null �� ��� ���氪���� ��ü
SELECT emp_name 
      ,salary ����
      ,salary * NVL(commission_pct, 0) as ��
      ,salary + ( salary * NVL(commission_pct, 0)) as �ջ�ݾ� 
FROM employees;


SELECT *
FROM member
WHERE mem_name='Ź����';

SELECT *
FROM cart
WHERE cart_member='n001';
--INNER JOIN (��������) (���������̶�� ��.)
SELECT member.mem_id
      ,member.mem_name
      ,cart.cart_member
      ,cart.cart_prod
      ,cart.cart_qty
FROM member, cart
WHERE member.mem_id= cart.cart_member 
AND member.mem_name ='������'; --mem_id �� cart_member ���� �����Ҷ� ����

SELECT member.mem_id
      ,member.mem_name
      ,cart.cart_member
      ,cart.cart_qty ��ǰ���ż�
FROM member, cart
WHERE member.mem_id= cart.cart_member(+) --OUTER JOIN �ܺ�����  --NULL���� ���Խ��Ѿ� �� �� (+) ���  
--������ �̸��� �μ����� ����Ͻÿ�                
SELECT employees.emp_name
      ,employees.department_id
FROM employees;
SELECT departments.department_id
      ,departments.department_name
FROM departments;
--������ �ҋ��� ���� �����̺��� �ʿ��� �÷��� ��ȸ SELECT�� �ۼ�
--�� ������ �����Ͱ� �´��� Ȯ�� ��
--������ �̿��� SELECT�� �ۼ�
SELECT employees.emp_name
      ,departments.department_name
FROM employees, departments
WHERE employees.department_id=departments.department_id;

SELECT a.emp_name
      ,b.department_name
FROM employees a, departments b --���̺� ��Ī
WHERE a.department_id = b.department_id;

SELECT emp_name             --�� ���̺� ���ʿ��� �ִ� �÷��� ���̺���� ���� �ʾƵ���
      ,department_name
      ,a.department_id      --�� ���̺� ������ �÷��� �ִٸ� ��������� ���������.
FROM employees a, departments b --���̺� ��Ī
WHERE a.department_id = b.department_id;

--employees, jobs ���̺��� �̿��Ͽ�
--������ ������ ����Ͻÿ�
SELECT *
FROM jobs;

SELECT a.employee_id                --���
      ,a.emp_name                   --�̸�
      ,a.salary                     --�޿�
      ,b.job_title                  --������
FROM employees a, jobs b            --�������̺�
WHERE a.job_id = b.job_id           --�������̺�
ORDER BY 1;

      









