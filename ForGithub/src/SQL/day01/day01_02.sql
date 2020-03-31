-- where 조건 활용: 비교 조건
# = < > <= >= != <>
# 문자열 비교시 대문자가 없다 -> 테이블을 만들 때 컬럼의 타입에 따라서 대소 구분 가능
# 문자열, 날짜/시간 데이터 입력 시는 ''로 감싸준다

#customer에서 first_name이 Mary인 사람의 create_date 정보를 출력하시오.
select create_date, first_name
from customer
where first_name = 'Mary';
#customer에서 customer_id가 10번 이상인 사람의 first_name 정보를 출력하시오. 
select first_name, customer_id  
from customer
where customer_id >= 10;
#customer에서 ‘2006-02-01’일 이후 가입자의 customer_id를 출력하시오.
select customer_id, create_date
from customer
where create_date >= '2006-02-01';
#category에서 name이 ‘Action’이 아닌 것을 출력하시오.
select name
from category
where name != 'Action';
-- where 조건 활용: 복합 조건
# and or not
#customer에서 first_name이 KELLY이고 address_id가 71인 자료를 출력하시오.
select *
from customer
where first_name ='KELLY' and address_id = 71;
#rental에서 2005-05월에 반납된 자료를 출력하시오.
select *
from rental
where return_date <= '2005-05-31' and return_date >= '2005-05-01';
#film에서 길이가 47미만이거나 (rating이 'G'이고 rental_rate가 4 초과) 인 자료를 출력하시오.
select *
from film
where length < 47 or (rating = 'G' and rental_rate > 4) ;
# and와 or의 우선순위 -> and가 높다

-- where 조건 활용: 범위 조건
#film에서 비반환시 벌금(?)이 15 ~ 16인 정보를 출력하시오.
select *
from film
where replacement_cost between 15 and 16;
#payment에서 2005년 5월에 발생한 지급 정보를 출력하시오.
select *
from payment
where payment_date between '2005-05-01' and '2005-05-31 23:59:59';
#customer에서 first_name이 linda와 mary 사이에 있는 자료를 출력하시오.
select *
from customer
where first_name between 'linda' and 'mary';

-- where 조건 활용: 집합 조건

#city에서 country_id가 80 또는 90 또는 100인 자료를 출력하시오.
select *
from city
where country_id in (80,90,100);
#film에서 14살 손님이 부모 없이 빌릴 수 없는 자료를 출력하시오.
select *
from film
where rating not in ('G', 'PG', 'PG-13');

# 집합에 null이 들어갔을 때 not in 주의!!
select 1=1, 1=0, 1=null, nul=null;
select * from city where country_id in (80,90,100,null); -- 동등 비교의 결과가 있으면 사용
select title, rating from film where rating not in('G','PG','PG-13',null); -- null은 false로 간주 

-- where 조건 활용: 패턴 조건
# 패턴 : 문자열 찾기
# like 키워드 사용
# % : 0개 이상의 임의의 문자열  %hi --> hi로 끝나는 문자열 / hi% --> hi로 시작하는 문자열 / %hi% --> hi가 포함되는 문자열
# _ : 임의의 1글자  _hi --> Xhi / _hi_ --> XhiX
# %, _ 자체를 검색해야하는 경우 : \%, \_
# not like
#first_name이 S로 시작하는 고객의 email 정보를 출력하시오.
select *
from customer
where first_name like 'S%';
#email에 GG가 들어있는 고객의 email 정보를 출력하시오.
select *
from customer
where email like '%GG%';
#first_name의 두 번째 글자가 a인 고객의 first_name정보를 출력하시오.
select *
from customer
where first_name like '_a';
#first_name의 두 번째 글자가 _인 고객의 first_name 정보를 출력하시오.
select *
from customer
where first_name like '_\_';


-- where 조건 활용: null 체크
# null은 비교연산, 수치연산에서 언제나 null --> boolean에서는 false로 평가
# is null, is not null
#staff에서 아직 비밀번호가 설정되지 않은 직원의 정보를 출력하시오.
desc staff;
select * 
from staff
where password is null;

#address에서 address2 정보가 설정된 정보만 출력하시오.
select *
from address
where address2 is not null;  -- 나중에 null은 ifnull 함수로 대체 처리
-- 조회 결과의 정렬
# 정렬 : 조회결과를 오름차순 (asc : default)/ 내림차순(desc)
# order by column [asc|dsc] ,column2.. column3....
#film에서 rating이 G인 자료를 길이의 오름차순으로 정렬하시오.
select * 
from film
where rating='G'
order by length;
#customer에서 store_id가 2인 고객의 정보를 이메일의 내림차순으로 정렬하시오.
select *
from customer
where store_id=2
order by email desc;
#customer에서 first_name이 jam으로 시작하는 고객의 정보를 first_name의 오름차순으로 정렬하고 동일한 자료는 다시 last_name의 내림차순으로 정렬하시오.
select *
from customer
where first_name like 'jam%'
order by first_name, last_name desc; 


-- 페이징
# limit offset, row cnt : offset 생략하면 0부터
#customer 테이블에서 처음 10명의 정보만 출력하시오.
select *
from customer
limit 10;
#film 테이블에서 대여 비용이 큰 순서로 2페이지에 해당하는 정보만 출력하시오. 단 한 페이지에는 10개씩 정보가 출력된다.
select *
from film
order by rental_rate desc
limit 10, 10;