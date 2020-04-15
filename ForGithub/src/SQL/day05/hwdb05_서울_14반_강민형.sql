use ssafydb;
select * from emp;
commit;
# 1. 부서위치가 CHICAGO인 모든 사원에 대해 이름,업무,급여 출력하는 SQL을 작성하세요.
select ename, job, sal 
from emp join dept on emp.deptno=dept.deptno
where loc='chicago';
# 2. 부하직원이 없는 사원의 사원번호,이름,업무,부서번호 출력하는 SQL을 작성하세요.
select b.empno, b.ename, b.job, b.deptno
from emp a right outer join emp b on (a.mgr=b.empno)
join dept on b.deptno=dept.deptno
where a.ename is null;
# 3. BLAKE와 같은 상사를 가진 사원의 이름,업무,상사번호 출력하는 SQL을 작성하세요.
select ename, job, mgr
from emp
where mgr = (select mgr from emp where ename='blake');
# 4. 입사일이 가장 오래된 사람 5명을 검색하세요.
select ename, hiredate
from emp
where hiredate is not null
order by hiredate
limit 5;
# 5. JONES 의 부하 직원의 이름, 업무, 부서명을 검색하세요.
select ename, job, dept.dname
from emp join dept using(deptno)
where ename in (select a.ename
				from emp a join emp b on(a.mgr=b.empno)
				where b.ename=(select ename from emp where ename='jones')); 

-- select * from emp where mgr=7566;
