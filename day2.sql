/* 숫자 데이터 타입 (number)
   number(p,s) p는 소수점을 기준으로 모든 유효숫자 자릿수를 의미함. 
               s는 소수점 자리수를 의미함(디폴트 0)
               s가 2이면 소수점 2자리까지 반올림
               s가 d음수 이면 소수점 기준 왼쪽 자리수 만큼 반올림
*/
CREATE TABLE ex2_1(
     num1 number(3)      -- 정수만 3자리
    ,num2 number(3, 2)   -- 정수1자리 소수점 2자리
    ,num3 number(5, -2)  -- 십의 자리까지 반올림 (총 7자리)  
    ,num4 number  -- 38 
);
INSERT INTO ex2_1 (num1) VALUES(0.7898);
INSERT INTO ex2_1 (num1) VALUES(99.5);
INSERT INTO ex2_1 (num1) VALUES(1004);  -- 오류 

INSERT INTO ex2_1(num2) VALUES(0.7898);
INSERT INTO ex2_1(num2) VALUES(1.2345);
INSERT INTO ex2_1(num2) VALUES(9.9945);
INSERT INTO ex2_1(num2) VALUES(9.9995); -- 오류
INSERT INTO ex2_1(num2) VALUES(32);     -- 오류
INSERT INTO ex2_1(num3) VALUES(12345.2345);
INSERT INTO ex2_1(num3) VALUES(1234569.2345);
INSERT INTO ex2_1(num3) VALUES(12345699.2345);  -- 오류 7자리 넘음

INSERT INTO ex2_1(num4) VALUES(12345699.2345);
SELECT * FROM ex2_1;
/*
     날짜 데이터타입 (date 년월일시분초, timestamp 년월일시분초.밀리초
*/
CREATE TABLE ex2_2(
    date1 DATE
   ,date2 TIMESTAMP
);
-- sysdate 현재시간
INSERT INTO ex2_2(date1, date2) VALUES( SYSDATE, SYSTIMESTAMP);
SELECT *
FROM ex2_2;
/*  제약조건 
    NOT NULL 널을 허용하지 않겠다!
    UNIQUE   중복을 허용하지 않겠다!
    CHECK    특정 데이터만 받겠다.
    PRIMARY KEY 기본키(하나의 테이블에 1개만 설정가능
                      하나의 행을 구분하는 식별자 키값이라고도 하며 PK라고도함.
                      PK는 UNIQUE하며 NOT NULL임.
    FOREIGN KEY 외래키 다른 테이블의 PK를 참조하는 키 
*/
CREATE TABLE ex2_3 (
    mem_id VARCHAR2(100) NOT NULL UNIQUE
   ,mem_nm VARCHAR2(100)
   ,mem_email VARCHAR2(100) NOT NULL
   ,CONSTRAINT uq_ex2_3 UNIQUE(mem_email) -- 제약조건의 이름을 관리하고싶을때
);
INSERT INTO ex2_3 (mem_id, mem_email) 
VALUES ('a001', 'a001@gmail.com');
INSERT INTO ex2_3 (mem_id, mem_email) 
VALUES ('a001', 'a002@gmail.com');  -- 오류 a001 같음(UNIQUE)제약조건

INSERT INTO ex2_3 (mem_id) 
VALUES ('a002');  -- 오류 email 제약조건을 만족하지 않음.
SELECT * FROM ex2_3;
SELECT *
FROM user_constraints
WHERE constraint_name LIKE '%EX%';
-- check 제약조건
CREATE TABLE ex2_4(
     nm VARCHAR2(100)
    ,age NUMBER
    ,gender VARCHAR2(1) 
    ,CONSTRAINT ck_ex2_4_age CHECK(age BETWEEN 1 AND 150)
    ,CONSTRAINT ck_ex2_4_gender CHECK(gender IN ('F','M'))
);
INSERT INTO ex2_4 VALUES('팽수', 100, 'M');
INSERT INTO ex2_4 VALUES('길동', 151, 'M');  -- age check 제약조건 오류 
INSERT INTO ex2_4 VALUES('동길', 10, 'A');   -- gender check 제약조건 오류
SELECT *
FROM ex2_4;
/*
     primary key 는 한 테이블에 1개 만 설정할 수 있으며 
     한개의 pk는 여러 컬럼을 복합키로 설정가능 1 ~n 
     foreign key 는 참조하는 테이블의 컬럼은 pk로 정의 되어 있어야함.
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
INSERT INTO DEP VALUES(1, '영업', 8);
INSERT INTO DEP VALUES(2, '기획', 10);
INSERT INTO DEP VALUES(3, '개발', 9);
INSERT INTO EMP VALUES(100, '김창섭', '대리', 2);
INSERT INTO EMP VALUES(200, '박영권', '과장', 3);
INSERT INTO EMP VALUES(300, '이수민', '부장', 1);

SELECT *
FROM emp;

SELECT *
FROM dep;

SELECT emp.empnm
     , dep.deptnm
     , dep.dep_floor  -- dep <-- 테이블명, .컬럼명 
FROM emp, dep
WHERE emp.dno = dep.deptno  -- pk fk 를 이용하여 관계를 맺어 데이터를 가져옴
AND empnm = '김창섭';

-- table, column 코멘트 
COMMENT ON TABLE dep IS '부서테이블';
COMMENT ON COLUMN dep.deptno IS '부서번호';
COMMENT ON COLUMN dep.deptnm IS '부서명';

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
COMMENT ON TABLE tb_info IS '우리반';
COMMENT ON COLUMN tb_info.info_no IS '출석번호' ;
COMMENT ON COLUMN tb_info.pc_no IS '컴퓨터번호' ;
COMMENT ON COLUMN tb_info.nm IS '이름' ;
COMMENT ON COLUMN tb_info.email IS '이메일' ;
COMMENT ON COLUMN tb_info.hobby IS '취미' ;
COMMENT ON COLUMN tb_info.team IS '팀세미나그룹' ;
COMMENT ON COLUMN tb_info.create_dt IS '생성일자' ;
COMMENT ON COLUMN tb_info.update_dt IS '수정일자' ;

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
WHERE nm ='백현진';


  UPDATE tb_info
SET team = (
    SELECT team
    FROM (            
                SELECT info_no, team
                FROM TEMP_TEAM
    ) 
    WHERE tb_info.info_no = info_no
);