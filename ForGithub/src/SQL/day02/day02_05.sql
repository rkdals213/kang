-- 다중행 함수
-- 그룹 함수: count, sum, avg, max, min
# customer에서 전체 고객 숫자를 조회하시오.
select count(*) from customer;
select * from staff;
-- 집계함수는 null은 빼고 동작한다
select count(picture), count(staff_id) from staff;
# rental에서 미반납 건수를 조회하시오. - return_date가 없는 녀석들
select count(*) from rental where return_date is null;
select count(return_date) from rental;

#payment에서 2005년 6월 총 렌탈 수입은 얼마인가?
select sum(amount) from payment where payment_date between '2005-06-01' and '2005-06-30 23:59:%9';
select sum(amount) from payment where year(payment_date)=2005 and month(payment_date)=6;
#payment에서 2006년 렌탈 건당 평균 수입을 소수점 두자리로 반올림해서 출력하시오.
select avg(amount), round(avg(amount),2) from payment where year(payment_date)=2006;
#film에서 가장 긴 영화시간과 가장 짧은 영화 시간은?
select max(length), min(length) from film;
#rental에서 2005년에 가장 마지막에 반납된 영화는?
select max(return_date) from rental where year(return_date)=2005;

select rental_id, max(return_date) from rental where year(return_date)=2005; #쓰레기 데이터
set sql_mode='only_full_group_by';
set sql_mode='';

-- group by
# rental에서 고객번호별 대여 수량은?
select count(rental_id) from rental; -- 전체를 하나의 그룹으로 본 경우
-- 일반 컬럼(custom_id)와 집계함수를 그냥 같이 사용하지 않는다.
select customer_id, count(rental_id) from rental group by customer_id;
select inventory_id, count(rental_id) from rental group by inventory_id with rollup;
select ifnull(inventory_id,'계'), count(rental_id) 
from rental 
where inventory_id < 10 -- 전체 모집단에 영향을 줌..
group by inventory_id 
with rollup;

-- group by having
# 렌탈료가 8달러 이상인 영화들을 빌려간 고객들의 고객별 결재 회수는?
select customer_id, count(payment_id) '수량'
from payment
where amount >= 8
group by customer_id
order by 2;
# 렌탈료가 8달러 이상인 영화들을 빌려간 고객들의 고객별 결재 회수가 5건 이상인 고객은?
select customer_id, count(payment_id) as '수량'		-- 5
from payment										-- 1
where amount >= 8									-- 2
group by customer_id								-- 3
having 수량 >= 5										-- 4  -- oracle에서는 having에서 alias 사용 불가
order by 2;											-- 6

-- DDL
/*
create table table_name(
column_name type 제약사항,
column_name type 제약사항,
column_name type 제약사항,
);

문자열 : 	char(10)	: 고정길이	'a' - 9칸이 남음, 검색속도가 빠름
		varchar(10)	: 가변길이	'a' - 1칸만 사용사고 반납, 저장공간 측면에서는 유리
        XXbinary	: 대소고분
        text		: 큰 데이터
        enum		: 지정된 문자열 중 하나 
        set			: 지정된 문자열 중 여러개
다음의 데이터를 저장하기 위한 USER_INFO 테이블을 작성하시오. 단 가입 일시에는 default 값으로 현재 시각을 사용하시오.
name: 홍길동		# 기본 키(10자)
age: 30             # null 허용하지 않음
email: abc@def.net	# 50자까지 처리
height: 170.5		# 총 다섯자리 중 소수점 1자리	
birth:1970-01-01
joined: 2000-01-01	# 기본 값 적용
*/
create table user_info(
	name varchar(10) primary key,
    age int not null,
    email varchar(50),
    height decimal(5,1),
    birth date,
    joined timestamp default current_timestamp
);
#테이블 이름 변경(user_info -> users)

# 컬럼 추가: users에 50크기의 가변형 문자열 타입인 hobby, 100 크기의 가변 문자열 addr, 180.5 형태의 값을 저장할 수 있는 weight를 추가하시오.

# 컬럼 변경 : name을 30자까지 저장할 수 있도록 변경하시오.

# 컬럼 대체: hobby를 30 크기의 가변 문자열 new_hobby로 대체하시오.

# 컬럼 삭제: new_hobby 컬럼을 삭제하시오.

# insert 문장
# insert into table_name [column1, column2....] values (value1, value2...);
# user_info 테이블에 2개 이상의 데이터를 입력하세요.
insert into user_info values('홍길동', 10, 'abc@def.net', 180.5, '2010-01-01', now());
insert into user_info (name, age) values ('임꺽정', 30);
select * from user_info;    

# user_info 테이블에 저장된 데이터를 수정하세요.
# update table_name set column_name = value, column_name = value....
#					where condition					-- 조건에 대한 고민이 꼭 필요하다
update user_info set height=150 where name='임꺽정';

# user_info 테이블의 데이터를 삭제하시오.
# delete from table_name where condition
delete from user_info where name='임꺽정';

# user_info 테이블을 삭제하시오.
