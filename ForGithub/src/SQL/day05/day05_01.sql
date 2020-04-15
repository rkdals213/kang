use scott;
select * from emp;
select * from dept;
-- join
-- cross join
select *
from emp,dept;
-- ansi 
select * 
from emp cross join dept;

-- inner join
select *
from emp, dept
where emp.deptno=dept.deptno;

select empno, sal, ename, emp.deptno, dname
from emp, dept
where emp.deptno=dept.deptno;

select empno, sal, ename, a.deptno, dname
from emp a, dept b
where a.deptno=b.deptno;
-- ansi
select *
from emp join dept on emp.deptno = dept.deptno;
select *
from emp inner join dept on emp.deptno = dept.deptno;
select *
from emp a inner join dept b on a.deptno = b.deptno;
select *
from emp inner join dept using (deptno);

select * from salgrade;
-- 사번 이름 급여 급여등급을 구하세요
select empno, ename, sal, grade 
from emp inner join salgrade on (sal <= HISAL and sal >= LOSAL);

select empno, ename, sal, grade 
from emp inner join salgrade on (sal between losal and hisal);

select empno, ename, sal, grade 
from emp, salgrade
where 1=1
and sal between losal and hisal;

-- outer join
update emp set deptno = null where empno = 7839;
select * from emp;

select * 
from emp inner join dept on emp.deptno=dept.deptno;
-- 사원의 이름 사번 급여 부서명을 구하세요
-- left outer join
select *
from emp left outer join dept on emp.deptno=dept.deptno;
-- right outer join
select *
from emp right outer join dept on emp.deptno=dept.deptno;
-- full outer join
-- select *
-- from emp full outer join dept on emp.deptno=dept.deptno;
-- natural join
select *
from emp natural join dept;
-- self join
select a.ename, a.empno, b.ename, a.sal, b.sal -- 이름 사번 관리자이름 사원의 급여 관리자급여
from emp a, emp b
where a.mgr = b.empno;

-- ansi
select a.ename, a.empno, b.ename, a.sal, b.sal -- 이름 사번 관리자이름 사원의 급여 관리자급여
from emp a left outer join emp b on a.mgr=b.empno;