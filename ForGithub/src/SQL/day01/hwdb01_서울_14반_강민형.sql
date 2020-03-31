CREATE TABLE EMP
       (EMPNO int(4)  PRIMARY KEY,
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	MGR int(4),
	HIREDATE DATE,
	SAL decimal(7,2),
	COMM decimal(7,2),
	DEPTNO int(2));

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,cast('2010-10-19' as date),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,cast('2000-10-19' as date),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,cast('2013-05-19' as date),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,cast('2018-10-19' as date),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,cast('2008-04-19' as date),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,cast('2016-11-19' as date),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,cast('2017-10-19' as date),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,cast('2013-10-11' as date),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,cast('2014-08-19' as date),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,cast('2010-10-19' as date),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,cast('2000-09-19' as date),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,cast('2018-10-19' as date),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,cast('2003-10-19' as date),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,cast('2002-10-19' as date),1300,NULL,10);
# 1) 입사일이 2014년도인 사람의 모든 정보를 검색하세요 
select *
from emp
where HIREDATE between '2014-01-01' and '2014-12-31 23:59:59';
# 2) 이름 중 S자가 들어가 있는 사람만 모든 정보를 검색하세요. 
 select *
 from emp
 where ENAME like '%S%';
# 3) 커미션이 NULL인 사람의 정보를 검색하세요. 
 select *
 from emp
 where COMM is null;
# 4)  30번 부서의 연봉을 계산하여 이름, 부서번호, 급여, 연봉(12개월 월급여+연말보너스)을 검색하세요. 단, 연말에 급여의 150%를 보너스로 지급한다. 
 select ENAME '이름', DEPTNO '부서번호', SAL '급여', (SAL*12) + (SAL*1.5) '연봉' 
 from emp
 where DEPTNO = 30;
-- 5) 급여가 $2,000 이상인 모든 사람은 급여의 15%를 경조비로 내기로 하였다. 이름, 급여, 경조비를 검색하세요. 
select ENAME '이름', SAL '급여', SAL* 0.15 '경조비'
from emp
where SAL >= 2000;
