/* ���� ������ Ÿ�� (number)
   number(p,s) p�� �Ҽ����� �������� ��� ��ȿ���� �ڸ����� �ǹ���. 
               s�� �Ҽ��� �ڸ����� �ǹ���(����Ʈ 0)
               s�� 2�̸� �Ҽ��� 2�ڸ����� �ݿø�
               s�� d���� �̸� �Ҽ��� ���� ���� �ڸ��� ��ŭ �ݿø�
*/
CREATE TABLE ex2_1(
     num1 number(3)      -- ������ 3�ڸ�
    ,num2 number(3, 2)   -- ����1�ڸ� �Ҽ��� 2�ڸ�
    ,num3 number(5, -2)  -- ���� �ڸ����� �ݿø� (�� 7�ڸ�)  
    ,num4 number  -- 38 
);
INSERT INTO ex2_1 (num1) VALUES(0.7898);
INSERT INTO ex2_1 (num1) VALUES(99.5);
INSERT INTO ex2_1 (num1) VALUES(1004);  -- ���� 

INSERT INTO ex2_1(num2) VALUES(0.7898);
INSERT INTO ex2_1(num2) VALUES(1.2345);
INSERT INTO ex2_1(num2) VALUES(9.9945);
INSERT INTO ex2_1(num2) VALUES(9.9995); -- ����
INSERT INTO ex2_1(num2) VALUES(32);     -- ����
INSERT INTO ex2_1(num3) VALUES(12345.2345);
INSERT INTO ex2_1(num3) VALUES(1234569.2345);
INSERT INTO ex2_1(num3) VALUES(12345699.2345);  -- ���� 7�ڸ� ����

INSERT INTO ex2_1(num4) VALUES(12345699.2345);
SELECT * FROM ex2_1;
/*
     ��¥ ������Ÿ�� (date ����Ͻú���, timestamp ����Ͻú���.�и���
*/
CREATE TABLE ex2_2(
    date1 DATE
   ,date2 TIMESTAMP
);
-- sysdate ����ð�
INSERT INTO ex2_2(date1, date2) VALUES( SYSDATE, SYSTIMESTAMP);
SELECT *
FROM ex2_2;
/*  �������� 
    NOT NULL ���� ������� �ʰڴ�!
    UNIQUE   �ߺ��� ������� �ʰڴ�!
    CHECK    Ư�� �����͸� �ްڴ�.
    PRIMARY KEY �⺻Ű(�ϳ��� ���̺� 1���� ��������
                      �ϳ��� ���� �����ϴ� �ĺ��� Ű���̶�� �ϸ� PK�����.
                      PK�� UNIQUE�ϸ� NOT NULL��.
    FOREIGN KEY �ܷ�Ű �ٸ� ���̺��� PK�� �����ϴ� Ű 
*/
CREATE TABLE ex2_3 (
    mem_id VARCHAR2(100) NOT NULL UNIQUE
   ,mem_nm VARCHAR2(100)
   ,mem_email VARCHAR2(100) NOT NULL
   ,CONSTRAINT uq_ex2_3 UNIQUE(mem_email) -- ���������� �̸��� �����ϰ������
);
INSERT INTO ex2_3 (mem_id, mem_email) 
VALUES ('a001', 'a001@gmail.com');
INSERT INTO ex2_3 (mem_id, mem_email) 
VALUES ('a001', 'a002@gmail.com');  -- ���� a001 ����(UNIQUE)��������

INSERT INTO ex2_3 (mem_id) 
VALUES ('a002');  -- ���� email ���������� �������� ����.
SELECT * FROM ex2_3;
SELECT *
FROM user_constraints
WHERE constraint_name LIKE '%EX%';
-- check ��������
CREATE TABLE ex2_4(
     nm VARCHAR2(100)
    ,age NUMBER
    ,gender VARCHAR2(1) 
    ,CONSTRAINT ck_ex2_4_age CHECK(age BETWEEN 1 AND 150)
    ,CONSTRAINT ck_ex2_4_gender CHECK(gender IN ('F','M'))
);
INSERT INTO ex2_4 VALUES('�ؼ�', 100, 'M');
INSERT INTO ex2_4 VALUES('�浿', 151, 'M');  -- age check �������� ���� 
INSERT INTO ex2_4 VALUES('����', 10, 'A');   -- gender check �������� ����
SELECT *
FROM ex2_4;
/*
     primary key �� �� ���̺� 1�� �� ������ �� ������ 
     �Ѱ��� pk�� ���� �÷��� ����Ű�� �������� 1 ~n 
     foreign key �� �����ϴ� ���̺��� �÷��� pk�� ���� �Ǿ� �־����.
*/

CREATE TABLE dep(
    deptno NUMBER(3) PRIMARY KEY
   ,deptnm VARCHAR2(20)
   ,dep_floor NUMBER(5)
);
CREATE TABLE emp(
    empno NUMBER(5) 
   ,empnm VARCHAR2(20)
   ,title VARCHAR2(20)
   ,dno NUMBER(3) CONSTRAINT emp_fk REFERENCES dep(deptno)
);
INSERT INTO DEP VALUES(1, '����', 8);
INSERT INTO DEP VALUES(2, '��ȹ', 10);
INSERT INTO DEP VALUES(3, '����', 9);
INSERT INTO EMP VALUES(100, '��â��', '�븮', 2);
INSERT INTO EMP VALUES(200, '�ڿ���', '����', 3);
INSERT INTO EMP VALUES(300, '�̼���', '����', 1);

SELECT *
FROM emp;

SELECT *
FROM dep;

SELECT emp.empnm
     , dep.deptnm
     , dep.dep_floor  -- dep <-- ���̺��, .�÷��� 
FROM emp, dep
WHERE emp.dno = dep.deptno  -- pk fk �� �̿��Ͽ� ���踦 �ξ� �����͸� ������
AND empnm = '��â��';

-- table, column �ڸ�Ʈ 
COMMENT ON TABLE dep IS '�μ����̺�';
COMMENT ON COLUMN dep.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dep.deptnm IS '�μ���';

SELECT *
FROM all_tab_comments 
WHERE OWNER = 'JAVA';
SELECT *
FROM TB_INFO;
delete TB_INFO;
CREATE TABLE TB_INFO(
   INFO_NO	NUMBER(2) NOT NULL UNIQUE
 , PC_NO		VARCHAR2(10) NOT NULL UNIQUE
 , NM		    VARCHAR2(20) NOT NULL
 , EMAIL		VARCHAR2(50) NOT NULL
 , HOBBY		VARCHAR2(1000)
 , TEAM	 	     NUMBER(2) 
 , CREATE_DT	 	DATE DEFAULT SYSDATE
 , UPDATE_DT	 	DATE DEFAULT SYSDATE
);
COMMENT ON TABLE tb_info IS '�츮��';
COMMENT ON COLUMN tb_info.info_no IS '�⼮��ȣ' ;
COMMENT ON COLUMN tb_info.pc_no IS '��ǻ�͹�ȣ' ;
COMMENT ON COLUMN tb_info.nm IS '�̸�' ;
COMMENT ON COLUMN tb_info.email IS '�̸���' ;
COMMENT ON COLUMN tb_info.hobby IS '���' ;
COMMENT ON COLUMN tb_info.team IS '�����̳��׷�' ;
COMMENT ON COLUMN tb_info.create_dt IS '��������' ;
COMMENT ON COLUMN tb_info.update_dt IS '��������' ;

SELECT *
FROM TEMP_TEAM;
drop table TEMP_TEAM;

CREATE TABLE TEMP_TEAM AS
SELECT t1.info_no
     , t1.pc_no
     , t1.nm
     , NTILE(5) OVER (ORDER BY rnum) AS team
FROM  (
        SELECT ROWNUM AS rnum 
             , a.*
        FROM (
                SELECT info_no
                     , pc_no
                     , nm
                FROM tb_info
                ORDER BY DBMS_RANDOM.RANDOM
                ) a
        ) t1;
        
        
    
    UPDATE tb_info
SET team = (
    SELECT buket
    FROM (
        SELECT t1.info_no, NTILE(5) OVER (ORDER BY rnum) AS buket
        FROM (
            SELECT ROWNUM AS rnum, a.info_no
            FROM (
                SELECT info_no
                FROM tb_info
                ORDER BY DBMS_RANDOM.RANDOM
            ) a
        ) t1
    ) 
    WHERE tb_info.info_no = info_no
);



select *
from tb_info;

UPDATE TEMP_TEAM
SET team = 5
WHERE nm ='������';


  UPDATE tb_info
SET team = (
    SELECT team
    FROM (            
                SELECT info_no, team
                FROM TEMP_TEAM
    ) 
    WHERE tb_info.info_no = info_no
);