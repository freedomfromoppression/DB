
ALTER TABLE 학생 ADD CONSTRAINT PK_학생_학번 PRIMARY KEY (학번);
ALTER TABLE 수강내역 ADD CONSTRAINT PK_수강내역_수강내역번호 PRIMARY KEY (수강내역번호);
ALTER TABLE 과목 ADD CONSTRAINT PK_과목내역_과목번호 PRIMARY KEY (과목번호);
ALTER TABLE 교수 ADD CONSTRAINT PK_교수_교수번호 PRIMARY KEY (교수번호);

ALTER TABLE 수강내역 
ADD CONSTRAINT FK_학생_학번 FOREIGN KEY(학번)
REFERENCES 학생(학번);

ALTER TABLE 수강내역 
ADD CONSTRAINT FK_과목_과목번호 FOREIGN KEY(과목번호)
REFERENCES 과목(과목번호);

ALTER TABLE 강의내역 
ADD CONSTRAINT FK_교수_교수번호 FOREIGN KEY(교수번호)
REFERENCES 교수(교수번호);

ALTER TABLE 강의내역 
ADD CONSTRAINT FK_과목_과목번호2 FOREIGN KEY(과목번호)
REFERENCES 과목(과목번호);



COMMIT;


/* INNER JOIN 내부조인 (동등조인) */
SELECT *
FROM 학생;

SELECT *
FROM 수강내역;

SELECT 학생.이름
     , 학생.평점
     , 학생.학번 
     , 수강내역.수강내역번호
     , 수강내역.과목번호
     , 과목.과목이름
FROM 학생, 수강내역, 과목
WHERE 학생.학번 = 수강내역.학번
AND   수강내역.과목번호 = 과목.과목번호 
AND 학생.이름 = '양지운';

--학생의 수강내역 건수를 조회하시오(평점 소수점 2째자리 까지 표현,이름정렬)




SELECT 학생.이름
     , ROUND(학생.평점,2) as 평점
     , 학생.학번 
     , COUNT(수강내역.수강내역번호) as 수강건수
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번
GROUP BY 학생.이름, 학생.평점, 학생.학번
ORDER BY 1 ;


/* outer join 외부조인 null값을 포함시키고 싶을때*/
SELECT 학생.이름
     , ROUND(학생.평점,2) as 평점
     , 학생.학번 
     , COUNT(수강내역.수강내역번호) as 수강건수
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번(+) -- null값을포함시킬 쪽에 (+)
GROUP BY 학생.이름, 학생.평점, 학생.학번
ORDER BY 1 ;
SELECT 학생.이름
     , ROUND(학생.평점,2) as 평점
     , 학생.학번 
     , 수강내역.수강내역번호 as 수강건수
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번(+) -- null값을포함시킬 쪽에 (+)
ORDER BY 1 ;
-- 학생의 수강내역수와 총 수강학점을 출력하시오 
SELECT 학생.이름
     , ROUND(학생.평점,2) as 평점
     , 학생.학번 
     , COUNT(수강내역.수강내역번호) as 수강건수
     ,SUM(NVL(과목.학점,0)) as 총수강학점
FROM 학생, 수강내역, 과목
WHERE 학생.학번 = 수강내역.학번(+) 
AND   수강내역.과목번호 = 과목.과목번호(+)
GROUP BY 학생.이름, ROUND(학생.평점,2), 학생.학번 
ORDER BY 1 ;


SELECT count(*)
FROM 학생, 수강내역; -- cross join (주의해야함) 
                   -- 9 * 17 = 153
SELECT count(*)
FROM 학생, 수강내역
WHERE 학생.학번 = 수강내역.학번;






