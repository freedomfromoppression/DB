/*
    �������� TRIM 
     ����:LTRIM ������ : RTRIM ��������
*/
SELECT LTRIM(' ABC ') as ex1
     , RTRIM(' ABC ') as ex2
     , TRIM(' ABC ') as ex3
FROM dual;
/*  LPAD, RPAD ä���
    (���, ����, ǥ��)
*/
SELECT LPAD(123, 5, '0')    as ex1
     , LPAD(1, 5, '0')      as ex2
     , LPAD(11235, 5, '0')  as ex3
     , LPAD(112352, 5, '0') as ex4 --����� ������ 2��° �Ű����� ���� 
     , RPAD(2, 5, '*')      as ex5
FROM dual;
/* REPLACE (�ܾ� ��Ȯ�ϰ� ��Ī), TRANSLATE(�ѱ��� �� ��Ī) ��ȯ */
SELECT REPLACE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?','����','�ʸ�') as ex1
      ,TRANSLATE('���� �ʸ� �𸣴µ� �ʴ� ���� �˰ڴ°�?','����','�ʸ�') as ex2
FROM dual;
-- LENGTH ���ڿ�����, LENGTHB ���ڿ� ũ��(byte)
SELECT LENGTH('abc1')  as ex1   -- ����, Ư������, ���� 1byte
     , LENGTHB('abc1') as ex2
     , LENGTH('�ؼ�1')  as ex3
     , LENGTHB('�ؼ�1') as ex4  -- utf-8 ���� �ѱ� 3byte 
FROM dual;

/*  member ���̺� �ִ� ȸ����    (�������� ���ϸ��� ��������)
    ������ �ֺ�, ȸ���, �ڿ������� ȸ���� ����� ����Ͻÿ�  
    2500 ���� silver, 2500�ʰ� 5000 ���� gold, 5000 �ʰ� vip
*/
-- ���̺� ����(alter)  �÷��߰� ADD
-- ALTER TABLE tb_info ADD MBTI VARCHAR2(4)

SELECT mem_name
     , mem_mileage
     , CASE WHEN mem_mileage <= 2500 THEN 'silver'
            WHEN mem_mileage > 2500  AND mem_mileage <=5000  THEN 'gold'
            ELSE 'vip'
         END as ratings
     , mem_job
FROM member
WHERE mem_job IN ('�ֺ�','�ڿ���','ȸ���')
ORDER BY mem_mileage DESC;

-- TABLE ���� ALTER 
CREATE TABLE ex5_1(
    nm VARCHAR2(100) NOT NULL
   ,point NUMBER(5)
   ,gender CHAR(1)
);
-- �÷��� ���� 
ALTER TABLE ex5_1 RENAME COLUMN point TO user_point;
-- Ÿ�� ����(Ÿ�� ������ ���̺� �����Ͱ� �ִٸ� �����ؾ���)
ALTER TABLE ex5_1 MODIFY gender VARCHAR2(1);
-- �������� �߰� 
ALTER TABLE ex5_1 ADD CONSTRAINT pk_ex5 PRIMARY KEY (nm);
-- �÷� �߰� 
ALTER TABLE ex5_1 ADD create_dt DATE;
-- �÷� ���� 
ALTER TABLE ex5_1 DROP COLUMN gender;
-- tb_info ���̺� MBTI �÷��� �߰��ϼ���(type: VARCHAR2, size :4byte)
ALTER TABLE tb_info ADD MBTI VARCHAR2(4); 

SELECT *
FROM member;

/* ���� �Լ� (�Ű����� ������)
   ABS:���밪, ROUND �ݿø� TRUNC���� CEIL�ø� SQRT ������ 
   MOD(m, n) m�� n���� ���������� ������ ��ȯ
*/
SELECT ABS(-10)          as ex1
     , ABS(10)           as ex2
     , ROUND(10.5555)    as ex3 -- default ���� 
     , ROUND(10.5555, 1) AS ex4 --�Ҽ��� 2° �ڸ����� �ݿø�
     , TRUNC(10.5555, 1) AS ex5
     , MOD(4, 2)         AS ex6
     , MOD(5, 2)         AS ex7
FROM dual;
/* ��¥ �Լ� */
SELECT SYSDATE          -- ����ð� 
     , SYSTIMESTAMP 
FROM dual;
-- ADD_MONTHS(��¥, 1) ������ 
-- LAST_DAY ��������, NEXT_DAY(��¥, '����') ������� �ش���� 
SELECT ADD_MONTHS(SYSDATE, 1)    AS ex1
      ,ADD_MONTHS(SYSDATE, -1)   AS ex2
      ,LAST_DAY(SYSDATE)         AS ex3
      ,NEXT_DAY(SYSDATE,'������') AS ex4
      ,NEXT_DAY(SYSDATE,'�����') AS ex5 -- ������ ������̶�� ������ �����
      ,NEXT_DAY(SYSDATE,'�ݿ���') AS ex5
FROM dual;
SELECT SYSDATE - 1 -- <-- -1day ���갡��
     , ADD_MONTHS(SYSDATE, 1) - ADD_MONTHS(SYSDATE, -1) -- ��¥ ���갡��
FROM dual;

-- �̹����� ���� ���������?
SELECT 'd-day:' || (LAST_DAY(SYSDATE) - SYSDATE) || '��'as dday
FROM dual;

-- DECODE ǥ���� 
SELECT cust_name
     , cust_gender
     -- ����1, true��, false(�׹ۿ�)
    , DECODE(cust_gender, 'M','����', '����') as gender
     -- ����1, true��, ����2, true��, �׹ۿ�)
    , DECODE(cust_gender, 'M','����','F','����','?') as gender2
FROM customers;

-- member �� ȸ���� ������ ����Ͻÿ�.
-- member�� �������� ������ ����.
-- ȸ���̸�, ������ ��� 
-- ex) mem_regno2 �� �ֹι�ȣ ���ڸ� 
SELECT mem_name
     , DECODE(SUBSTR(mem_regno2,1,1), 1,'����',2,'����','?' ) as gender
FROM member;


SELECT distinct SUBSTR(mem_regno2,1,1)
FROM member;
SELECT mem_name
     , mem_regno2
     , DECODE(SUBSTR(mem_regno2,1,1),1,'����','����') as gender
FROM member;

/* ��ȯ�Լ�(Ÿ��) 
   TO_CAHR ���������� 
   TO_DATE ��¥������
   TO_NUMBER ���������� 
*/
SELECT TO_CHAR(123456, '999,999,999') as ex1
      ,TO_CHAR(SYSDATE, 'YYYY-MM-DD') as ex2
      ,TO_CHAR(SYSDATE, 'YYYYMMDD') as ex3
      ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') as ex4
      ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') as ex5
      ,TO_CHAR(SYSDATE, 'day') as ex6
      ,TO_CHAR(SYSDATE, 'YYYY') as ex7
      ,TO_CHAR(SYSDATE, 'YY') as ex8
      ,TO_CHAR(SYSDATE, 'dd') as ex9
      ,TO_CHAR(SYSDATE, 'd') as ex10
FROM dual;
SELECT TO_DATE('231229','YYMMDD')  as ex1
      ,TO_DATE('2023 12 29 09:10:00', 'YYYY MM DD HH24:MI:SS') as ex2
      ,TO_DATE('25','YY') as ex3
      ,TO_DATE('45','YY') as ex4
      -- RR�� ���⸦ �ڵ����� ����
      -- 50 -> 1950  
      -- 49 -> 2049 (Y2K 2000�� ����)�� ���� ����å���� ���Ե�. 
      ,TO_DATE('50','RR')as ex5
FROM dual;
CREATE TABLE ex5_2(
     title VARCHAR2(100)
    ,d_day DATE
);
INSERT INTO ex5_2 VALUES ('������', '20240614');
INSERT INTO ex5_2 VALUES ('������', '2024.06.14');
INSERT INTO ex5_2 VALUES ('������', '2024/06/14');
SELECT *
FROM ex5_2;
INSERT INTO ex5_2 VALUES ('������', '2024 06 14');
INSERT INTO ex5_2 VALUES ('������', TO_DATE('2024 06 14 09','YYYY MM DD HH24'));
CREATE TABLE ex5_3(
   seq1 VARCHAR2(100)
  ,seq2 NUMBER 
);
INSERT INTO ex5_3 VALUES('1234','1234');
INSERT INTO ex5_3 VALUES('99','99');
INSERT INTO ex5_3 VALUES('123456','123456');
SELECT *
FROM ex5_3
ORDER BY TO_NUMBER(seq1) DESC;


-- member ȸ���� ��������� �̿��Ͽ� ���̸� ����Ͻÿ� 
-- ���س⵵�� �̿��Ͽ�  (ex 2024 - 2000 => 24��) ���� ��������
SELECT   mem_name
       , mem_bir
       , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(mem_bir,'YYYY') ||'��' as ����
FROM member
ORDER BY mem_bir ASC;

/*
 �� ���̺�(CUSTOMERS)���� 
 ���� ����⵵(cust_year_of_birth) �÷��� �ִ�. 
 ������ �������� �� �÷��� Ȱ���� 30��, 40��, 50�븦 ������ ����ϰ�, 
 ������ ���ɴ�� '��Ÿ'�� ����ϴ� ������ �ۼ��غ���. 
 */
 
 
 

SELECT CUST_YEAR_OF_BIRTH
       ,(TO_CHAR(SYSDATE, 'YYYY')  - CUST_YEAR_OF_BIRTH ) as ����
--     , TRUNC((TO_CHAR(SYSDATE, 'YYYY')  - CUST_YEAR_OF_BIRTH ) / 10)
     , DECODE(TRUNC((TO_CHAR(SYSDATE, 'YYYY')  - CUST_YEAR_OF_BIRTH ) / 10), 3
                      ,'30��'
                      , 4,'40��', 5,'50��', '��Ÿ')  as ���ɴ�
FROM customers;




