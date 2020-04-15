use ssafydb;
-- join?
-- 모델링(정규화) --> 데이터의 중복을 방지 --> 여기 저기 흩어지는 데이터...
-- 흩어진 데이터를 연결해서(FK 관계로) 조회하는 것--> join

-- 정규화 - 역정규화

# 1. emp와 dept를 join 해서 이름, 급여, 부서명을 검색하시오.
select empno, sal, dname
from emp, dept
where emp.deptno = dept.deptno;

-- 여러 테이블에서 동일한 이름의 컬럼이 있을 경우에는 소속이 필요하다.
select empno, sal, dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno;	-- mysql, oracle 같은 DB 종속적인 쿼리

select * from emp;

-- ansi 쿼리
select empno, sal, dname, e.deptno
from emp e join dept d on e.deptno = d.deptno; -- ansi 형태의 쿼리(모든 DB 적용)

select empno, sal, dname, e.deptno
from emp e join dept d using(deptno);

select empno, sal, dname, e.deptno
from emp e natural join dept d ;	-- 치명적 문제점: 이름 같으면 무조건 조건에 넣어버림

-- inner join: 조인하려는 테이블 양쪽에 모두 데이터가 있어야 한다.
# 2 이름이 King(emp)인 사원의 부서명(deot)을 검색하세요.
select d.dname, e.ename
from emp e, dept d
where e.deptno=d.deptno and e.ename='smith';

# 3 dept에 있는 모든 부서를 출력하고 empTable에 있는 data와 join 하여 모든 사원의
#  이름, 부서번호, 부서명, 급여를 출력하라.
select e.ename, e.deptno, d.dname, e.sal
from emp e right join dept d on e.deptno=d.deptno;

# 4. scott의 메니저는 jones이다.
select * from emp;
-- self join 
select concat(e.ename ,'의 관리자는', m.ename ) as  정보, mm.ename as 관관
from emp e join emp m on e.mgr = m.empno
           join emp mm on m.mgr = mm.empno ;

select e.ename as 직원, m.ename as 관리자, mm.ename as 관관
from emp e join emp m join emp mm on e.mgr=m.empno and m.mgr=mm.empno;

#5. scott의 직무와 같은 사람의 이름, 부서명, 급여, 직무는?
use ssafydb;

select job from emp where ename='scott';

select ename, dname, sal, job
from emp e join dept d on e.deptno=d.deptno
where job=(select job from emp where ename='scott'); -- sub query는 () 묶어주기

-- update 에서의  sub query
use sakila;
select * from users;
-- 임꺽정의 키를 film 테이블의 length 중 max 값으로 수정하시오.
-- sub query: 변경할 값 찾기
select max(length) from film;
-- main query: update
update users set height = (select max(length) from film) 
where name='임꺽정';

-- 홍길동의 키를 users의 키의 평균으로 수정하세요.
-- mysql에서는 자신 테이블을 직접적으로 사용 불가
update users set height = (select avg(height) from users)
where name ='홍길동';

update users set height = (select avg(height) from (select * from users) as sub)
where name ='홍길동';

-- users에서 이름이 10글자가 넘는 사용자를 삭제하시오.
delete from users where length(name)>10;
-- users에서 이름의 길이가 film 테이블의 최소 length 보다 큰 녀석을 삭제하시오.
select min(length) from film;
delete from users where length(name)>(select min(length) from film);

-- users에서 이름의 길이가 users의 평균 나이보다 길면 삭제하시오.
delete from users where length(name)>(select avg(age) from (select * from users) as sub);

-- 다중행 서브쿼리의 연산자: in, any, all
/*
 value > all(1,2,3) : value가 모두보다 커야한다. 3과만 비교하면 땡!! --> 최대값
 value < all(1,2,3) : all이 다 커야 한다.        1과만 비교하면 땡!! --> 최소값
 value > any(1,2,3) : 하나보다만 크면 된다.      1과만 비교하면 땡!! --> 최소값
 value < any(1,2,3) : 하나보다만 작으면 된다.    3과만 비교하면 땡!! --> 최대값
*/

use ssafydb;
select * from dept;
select * from emp;

# 6. scott이 속한 부서의 모든 사람의 사번, 이름, 입사일, 급여
select deptno from emp where ename='scott';

select e.empno, e.ename, e.hiredate, e.sal, e.deptno
from emp e
where e.deptno=(select deptno from emp where ename='scott');

# 7. 전체 직원의 평균 급여보다 급여가 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여
select avg(sal) from emp; -- 단일행 서브쿼리

select empno, ename, dname, hiredate, loc, sal
from emp e join dept d on e.deptno = d.deptno
where sal > (select avg(sal) from emp);

# 8 30번 부서와 같은 일을 하는 사원의 사번, 이름, 부서명, 지역, 급여를 급여 많은 순으로
select distinct(job) from emp where deptno=30; -- 다중행 서브쿼리 : in, any, all

select e.empno, e.ename, d.dname, d.loc, sal, job
from emp e join dept d on e.deptno = d.deptno
where e.job in (select distinct(job) from emp where deptno=30)
order by sal desc;

# 9. 10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원의 사번, 이름, 부서명, 입사일, 지역
select distinct(job) from emp where deptno=30;

select e.empno, e.ename, d.dname, hiredate, d.loc
from emp e join dept d on e.deptno = d.deptno
where e.deptno=10
-- not in 사용 할 때 주의할 점.........
and e.job not in (select distinct(job) from emp where deptno=30);

#10. king이나 james의 급여와 같은 사원의 사번, 이름, 급여
select distinct sal from emp where ename in ('king','james');

select empno, ename, sal
from emp
where sal in (select distinct sal from emp where ename in ('king','james'));

# 11. 급여가 30번 부서의 최고 급여보다 높은 사원의 사번, 이름, 급여
select max(sal) from emp where deptno=30;

select empno, ename, sal
from emp
where sal  > (select max(sal) from emp where deptno=30);

# 12. 인덱스 생성 - 기본키,유니크 컬럼은 자동 인덱스
-- 인덱스를 쓰면 언제나 쿼리의 속도가 향상된다?
-- 인덱스는 생성 시 별도의 공간을 차지하고 매번 정렬도 되어야 한다. - 자주 insert/update/delete가 일어나면 역효과
create index eidx on emp(ename);

# 13. 이름이 allen인 사원의 입사연도가 같은 사원의 이름과 급여
select year(hiredate) from emp where ename='allen';
select ename, sal from emp
where year(hiredate) in (select year(hiredate) from emp where ename='allen');

# 14. 부서별 급여의 합계 view
create or replace view eview
as 
select deptno, sum(sal) sal
from emp
group by deptno
order by sal;

# 15. 14번의 뷰에서 1~3번의 자료 조회
select * from eview limit 3;


