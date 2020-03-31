select ename, count(sal), sum(sal), max(sal), min(sal), avg(sal)
from emp;

select ename, sal
from emp
where sal > 100;

-- 부서별 사원 급여의 합을 구하세요
select deptno, sum(sal)
from emp
group by deptno;

select distinct deptno
from emp;

-- 업무별 직원의 급여 합과 평균을 구하세요
select deptno, sum(sal) as '급여합', round(avg(sal)) as '급여평균'
from emp
group by job
order by 1 desc;

-- 업무별 직원의 급여 합과 평균을 구하세요 단 급여가 1000보다 많은 사람을 수함
select deptno, sum(sal) as '급여합', round(avg(sal)) as '급여평균'
from emp
where sal > 1000
group by job
order by 1 desc;

-- 업무별 직원의 급여 합과 평균을 구하세요 단 급여가 1000보다 많은 사람을 수함
-- 업무별 금여의 합 1100 이상인 업무만
select deptno, sum(sal) as '급여합', round(avg(sal)) as '급여평균'
from emp
where sal > 1000
group by job
having 급여합 >= 1100
order by 1 desc;

-- 사원의 부서별 업무별 급여함
select deptno, job, sum(sal)
from emp
group by deptno, job with rollup 
order by 1;

select deptno, sum(sal)
from emp
union all
select '합계', sum(sal) 
from emp;

select deptno, sum(sal)
from emp
group by deptno with rollup;