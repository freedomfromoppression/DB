/* �� VIEW 338P

   �ϳ� �̻��� ���̺��� ������ ��ġ ���̺��� �� ó�� ����ϴ� ��ü
   ���� �����ʹ� �並 �����ϴ� ���̺� ��������� ���̺�ó�� ��밡��
   ������ :1. ���� ����ϴ� SQL ���� �Ź� �ۼ��� �ʿ� ���� ��� ��밡��
            2. ������ ���� ����(��õ ���̺��� ���� �� ����
   �� Ư¡ : (1) �ܼ� �� (���̺� 1���� ����)
            -�׷��Լ� ���Ұ�
            -distinct ���Ұ�
            -insert/update/delete ��밡��
            (2) ���� ��(������ ���̺�)
            -�׷� �Լ� ��밡��
            -distinct ��밡��
            -insert/update/delete ���Ұ�
*/
CREATE OR REPLACE VIEW emp_dep AS
SELECT  a.employee_id
       ,a.emp_name
       ,b.department_id
       ,b.department_name
FROM employees a, departments b
WHERE a.department_id =b. department_id;
--SYSTEM �������� java ������ �並 ������ִ� ���� �ο�
--GRANT CREATE VIEW TO JAVA;
SELECT *
FROM emp_dep;
--java�������� emp_dep�� ��ȸ�Ҽ��ִ� ������ study�������� ���� �ο�
GRANT SELECT ON emp_dep TO study;

SELECT *
FROM java.emp_dep; -- �ٸ��������� ��ȸ�� ��� ������. ���̺��[view��]

/* ���Ǿ�(synonim)��ü 354p
  �ó���� ���Ǿ�� ������ ��ü ������ ������ �̸��� ���� ���Ǿ ����°�
  public synonim : ��� ����� ����
  private synonim : Ư�� ����ڸ� ����
  public �ó���� ���� �� ������ DBA������ �ִ� ����ڸ� ����
  ������ : 1.�������� ������(id)�� ���� �߿��� ������ ��������� ��Ī�� ����
         2.���� ���Ǽ� ���� ���̺��� ������ ����Ǿ ��Ī���� 
           ����� �ߴٸ� �ڵ带 ���� ���ص���.
*/
-- �ó�� ���� ���� �ο�
GRANT SELECT TO java;
--java�������� ���Ǿ� ����
CREATE OR REPLACE SYNONYM mem FOR member; --default private �ó��
--java �������� study �������� mem �� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON mem TO study;
--study�������� ��ȸ
SELECT *
FROM java.mem;
--public synonim ���� (DBA������ �ִ� system �������� ����)
CREATE OR REPLACE PUBLIC SYNONYM mem2 FOR java.member;
SELECT *
FROM mem2;
-- �ó�� ����
DROP PUBLIC SYNONYM mem2;
/*�ñϽ� Sequence 384p : ��Ģ�� ���� �ڵ� ������ ��ȯ�ϴ� ��ü
  ����: pk�� ����� �÷��� ���� ���
       ex)�Խ����� �Խñ� ��ȣ
  ��������.CURRVAL ����������� (���ʿ��� �ȵ�)
  ��������.NEXTVAL ���� ��������
  ������ ���� DROP SEQUENCE my_seq1 ������ ������ ���������� ������ ���� ���ؼ��� �����̾ȵ�
                                   �����ϰ� �ٽ� ����°� �� ����.
 */
CREATE SEQUENCE my_seq1
INCREMENT BY 1   --��������
START WITH 1     --���ۼ���
MINVALUE     1   --�ּڰ�
MAXVALUE   99999 --�ִ밪
NOCYCLE    --�ִ볪 �ּҿ� �����ϸ� ��������(����Ʈ NOCYCLE)
NOCACHE;   --�޸𸮿� ������ ���� �̸� �Ҵ� ��������(����Ʈ NOCACHE)
SELECT my_seq1.NEXTVAL --��ȸ �ҋ����� ������.
FROM dual;
SELECT my_seq1.CURRVAL
FROM dual;
CREATE TABLE tb_click(
  seq NUMBER PRIMARY KEY
 ,dt DATE DEFAULT SYSDATE
);
INSERT INTO tb_click (seq) VALUES (my_seq1.NEXTVAL);
INSERT INTO tb_click (seq) VALUES ((SELECT MAX(NAL(seq,0)) + 1
                                         FROM tb_click));
SELECT MAX(NAL(seq,0)) + 1
FROM tb_click;
DROP SEQUENCE my_seq1;
--�ּ�1, �ִ� 9999999,1000���� �����ؼ� 2�� �����ϴ�
--info_seq �������� ����� ������
CREATE TABLE tb_number(
  seq NUMBER PRIMARY KEY
 ,dt DATE DEFAULT SYSDATE
);
INSERT INTO tb_number (seq) VALUES (MY_seq1.NEXTVAL);
SELECT MAX(NAL(seq,0)+1
FROM tb_number;