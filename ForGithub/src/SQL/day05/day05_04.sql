use scott;
-- subQuery
select * from emp;

-- smith와 업무가 같은 직원의 정보를 조회하세요
-- where 절의 서브쿼리
select job from emp where ename = 'smith';
select * from emp where job = (select job from emp where ename = 'smith');

-- miller보다 급여 많이 받는 사원 정보
select * from emp
where sal <= (select sal from emp where ename='miller')
and deptno = (select deptno from emp where ename='miller');

select *
from emp 
where sal = (select max(sal) from emp);

-- 다중행을 리턴하는 서브쿼리
select *
from emp
where sal in (select round(max(sal)) from emp group by deptno);
/*
2917
2175
1567
*/
select *
from emp
where sal > any (select round(avg(sal)) from emp group by deptno)
order by sal;

select *
from emp
where sal < all (select round(avg(sal)) from emp group by deptno)
order by sal;

-- 다중컬럼 서브쿼리
-- 각 부서에서 급여를 제일 많이 받는 사원의 정보를 구하세요
select *
from emp
where sal in (select round(max(sal)) from emp group by deptno)
order by sal;

select *
from emp
where (deptno, sal) in (select deptno, round(max(sal)) from emp group by deptno)
order by sal;

-- from 절의 서브쿼리 (inline view)
select maxSal, minSal
from (select deptno, max(sal) as maxSal, min(sal) as minSal, avg(sal) as avgSal 
	from emp 
	group by deptno) a;
    
    
-- 이름, 급여, 자기가 속한 부서의 급여 합계, 전체 급여 합계
select ename, sal, dsum, tsum
from emp a join (select deptno, sum(sal) as dsum from emp group by deptno) b, (select sum(sal) as tsum from emp) c
where a.deptno=b.deptno;
-- ansi
select ename, sal, dsum, tsum
from emp a join (select deptno, sum(sal) as dsum from emp group by deptno) b on a.deptno=b.deptno
		   join (select sum(sal) as tsum from emp) c;
           
           
create view vsal
as 
select ename, sal, dsum, tsum
from emp a join (select deptno, sum(sal) as dsum from emp group by deptno) b on a.deptno=b.deptno
		   join (select sum(sal) as tsum from emp) c;
           
select * from vsal;

-- projection
select ename, sal, (select sum(sal) from emp) as tsum
from emp;

-- 이름, 급여, 부서급여 합, 전체급여합 단 projection 절에 서브쿼리로 구현
select ename, sal, 
(select sum(sal) from emp) as tsum, 
(select sum(sal) from emp b where a.deptno=b.deptno) as dsum
from emp a;

create index inxempname on emp(ename);
-- create
select ename, sal
from emp
where ename='smith'
;