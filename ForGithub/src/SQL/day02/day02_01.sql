use scott;

select * from emp;

select 3, abs(3), abs(-3)
from dual;

select 3.541592, round(85.12312,-2)
from dual;

select 3.1415, truncate(3.1615,1)
from dual;

select 'A', ascii('A'), ascii(' ');

select concat('ssafy', '화이팅');

select '이름의 급여는 얼마입니다', concat(ename, '의 급여는 ', sal, ' 입니다')
from emp;

select '20200331'
,substring('20200331',1,4) as year
,substring('20200331',5,2) as month
,substring('20200331',7,2) as day
from dual;

select ' 오늘 점심음 무엇일까요 '
, length(' 오늘 점심음 무엇일까요 ')
, length('오늘 점심음 무엇일까요')
, trim(' 오늘 점심음 무엇일까요 ')
from dual;

select now(), sysdate() 
from dual;

select ename, hiredate, now(), now() - hiredate
from emp;

select ename, hiredate, now()
, datediff(now(), hiredate)
, year(hiredate)
, month(hiredate)
, day(hiredate)
from emp;

select if(3<5, 'true','false')
from dual;

select ename, comm, ifnull(comm, 0)
from emp;