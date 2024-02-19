/*
    ������ ����
    ����Ŭ���� �����ϰ� �ִ� ��� 
    ������ �����ͺ��̽��� �����ʹ� �������� �����ͷ� �����Ǿ��ִµ�
    ������ ������ ������ ������ ǥ���� �� ����
    �޴�, �μ�, ���� ���� ������������ ���� �� ����
*/
SELECT department_id
        ,LPAD(' ',3 * (LEVEL-1)) || department_name as �μ���
        ,LEVEL   --(����) Ʈ�� ������ � �ܰ迡 �ִ��� ��Ÿ���� ������
        ,parent_id
        
FROM departments
START WITH parent_id is null --����
CONNECT BY PRIOR department_id = parent_id; --������ ��� ����Ǵ���
--departments ���̺� �����͸� �����Ͻÿ�
--it��������ũ ���� �μ���
--department_id: 280
--department_name : CHATBOT��
SELECT a.employee_id
    , a.manager_id
    , LPAD(' ',3*(LEVEL -1)) || a.emp_name
    ,b.department_name
    ,a.department_id
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
AND a.department_id =30;

INSERT INTO departments(department_name, department_id,parent_id)
VALUES('CHATBOT��',280,230);

SELECT a.employee_id
    , a.manager_id
    , LPAD(' ',3*(LEVEL -1)) || a.emp_name
    ,b.department_name
    ,a.department_id
FROM employees a, departments b
WHERE a.department_id = b.department_id
START WITH a.manager_id IS NULL
CONNECT BY PRIOR a.employee_id = a.manager_id
--ORDER BY b.department_name; --������ Ʈ���� ����
ORDER SIBLINGS BY b.department_name;--Ʈ���� �����ϰ� ���� level ������


SELECT department_id
        ,LPAD(' ',3 * (LEVEL-1)) || department_name as �μ���
        ,parent_id
        ,CONNECT_BY_ROOT department_name as rootNm -- root row�� ����
        ,SYS_CONNECT_BY_PATH(department_name, '>') as pethNm
        ,CONNECT_BY_ISLEAF as leafNm --���������1,�ڽ�������0 
FROM departments
START WITH parent_id is null --����
CONNECT BY PRIOR department_id = parent_id;

CREATE table tb_level(
    �̸� VARCHAR2(50)
    ,��å VARCHAR2(50)
    ,���� number
    ,�������� number
    );

INSERT INTO tb_level VALUES('�̻���','����',1,null);
INSERT INTO tb_level VALUES('�����','����',2,1);
INSERT INTO tb_level VALUES('������','����',3,2);
INSERT INTO tb_level VALUES('�����','����',4,3);
INSERT INTO tb_level VALUES('�ڰ���','����',4,3);
INSERT INTO tb_level VALUES('�̴븮','�븮',5,4);
INSERT INTO tb_level VALUES('��븮','�븮',5,4);
INSERT INTO tb_level VALUES('�ֻ��','���',6,5);
INSERT INTO tb_level VALUES('�����','���',6,5);
INSERT INTO tb_level VALUES('�ֻ��','���',6,5);

SELECT*
FROM tb_level;

SELECT �̸�
        ,LPAD(' ',3 * (LEVEL-1)) || ��å as ��å�ܰ�
        ,����
        ,��������--(����) Ʈ�� ������ � �ܰ迡 �ִ��� ��Ÿ���� ������
FROM tb_level
START WITH �������� is null --����
CONNECT BY PRIOR ����= ��������;
/*
    ������ ���� ����(���� ������ ����)
*/
SELECT '2013'||LPAD(LEVEL,2,'0') as ���
FROM dual
CONNECT BY LEVEL <=12;

SELECT period as ���
    ,SUM (loan_jan_amt) as �����հ�
FROM kor_loan_status
WHERE period LIKE '2013%'
GROUP BY period;

SELECT a.���
    ,NVL(b.�����հ�,0) as �����հ�
FROM (SELECT '2013'||LPAD(LEVEL,2,'0') as ��� -- 1������ 12�� �޷�!!!
      FROM dual
      CONNECT BY LEVEL <=12) a

    ,(
    SELECT period as ���
    ,SUM (loan_jan_amt) as �����հ�
     FROM kor_loan_status
     WHERE period LIKE '2013%'
     GROUP BY period) b
WHERE a.��� = b.���(+)
ORDER BY 1;

--202401~202412 sysdate�� �̿��Ͽ� ����Ͻÿ�
--connect by level ���
SELECT TO_CHAR(SYSDATE, 'YYYY') || LPAD(LEVEL,2,'0') AS mm
FROM dual
CONNECT BY LEVEL <=12;
-- �̹��� 1�Ϻ��� ~ ������������ ����Ͻÿ�
-- 20240201
-- 20240202 ...

SELECT TO_CHAR(LAST_DAY(sysdate),'DD')
FROM dual
CONNECT BY LEVEL <= (SELECT TO_CHAR(LAST_DAY(sysdate), 'DD')
                    FROM dual);
-- member ȸ���� ���� (mem_bir)�� �̿��Ͽ�
-- ���� ȸ������ ����Ͻÿ�(������ ��������)
SELECT b.��
      ,NVL(a.��,0)
FROM(
SELECT TO_CHAR(mem_bir,'MM')as ��
      ,count(*) as ��
FROM member
GROUP BY TO_CHAR(mem_bir,'MM')
order by 1) a
,
(SELECT LEVEL as ��
FROM dual
CONNECT BY LEVEL <=12) b

WHERE a.��(+) = b.��
ORDER BY 1;



