use scott;

create table ssafy(name varchar(20), age int, birth date);
insert into ssafy(name, age, birth) 
values('홍길동', 21, cast('20010101' as date));

insert into ssafy(name, age, birth) 
values('둘리', 5, cast('20010101' as date));

select * from ssafy;

update ssafy set age = 22 
where age = 21;

select name, age, date_add(birth,interval 10 day)
from ssafy
where 1=1
and age > round(20);

delete from ssafy
where age = 22;

alter table ssafy add addr varchar(10);

select * from ssafy;

alter table ssafy drop addr;

select * from ssafy;

drop table ssafy;