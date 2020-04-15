use sakila;
# city에서 1번 도시의 이름과 국가의 이름은?
select city, country 
from city join country using(country_id)
where city_id=1;
# address에서 92번 주소의 도시 이름은?
select city 
from city join address on city.city_id=address.city_id
where address_id=92;
# film에서 1번 영화의 title과 언어 이름은?
select title, film.language_id, language.name
from film join language on film.language_id=language.language_id
where film_id=1;
### 3개 이상의 테이블 join

# 1번 staff이 살고 있는 도시는?
select city 
from city join address on city.city_id=address.city_id
		  join staff on address.city_id=staff.address_id
where staff_id = 1;
# 대출 기한을 넘겨서 아직 반납하지 않은 영화를 제목의 오름차순으로 상위 5개만 고객의 이름, 전화번호와 함께 출력하시오.
select customer.last_name, customer.first_name, address.phone, film.title
from customer join address using(address_id)
join rental using(customer_id)
join inventory using(inventory_id)
join film using(film_id)
where rental.return_date is null and date_add(rental.rental_date, interval film.rental_duration day) < current_date()
order by 4
limit 5;

# rental_id 1번의 정보와 렌탈한 고객의 email은?
select email 
from customer join rental on customer.customer_id=rental.customer_id
where rental_id=1;
# 1번 staff의 email과 사는 주소는?
select email, address
from staff join address on staff.address_id=address.address_id
where staff_id=1;
# 99번 고객의 이메일과 사는 나라는?
select email, country
from customer join address on customer.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
where customer_id=99;
#99번 고객의 결재건의 고객 이메일과 담당 스텝의 first_name
select customer.email, staff.first_name
from payment join customer on payment.customer_id=customer.customer_id
join staff on payment.staff_id=staff.staff_id
where payment_id=99;
# 1번 영화의 제목과 이 영화에에 참여한 배우의 이름?
select title, actor.last_name 
from film join film_actor on film.film_id=filmcustomer_list_actor.film_id
join actor on film_actor.actor_id=actor.actor_id
where film.film_id=1; 

# view - 필요한 정보를 뫃아놓은 가상의 테이블
select * from customer_list;

-- outer join 
DROP TABLE IF EXISTS JTHISTORY;
DROP TABLE IF EXISTS JTUSER ;

CREATE TABLE IF NOT EXISTS JTHISTORY(
	history_id int primary key,
	user_id varchar(20),
	product_name varchar(30)
);


CREATE TABLE IF NOT EXISTS JTUSER(
	user_id varchar(20) primary key,
	user_name varchar(20) NOT NULL
);
Insert into JTUSER (USER_ID,USER_NAME) values ('user_id_1','user_name_1');
Insert into JTUSER (USER_ID,USER_NAME) values ('user_id_2','user_name_2');
Insert into JTUSER (USER_ID,USER_NAME) values ('user_id_3','user_name_3');
Insert into JTUSER (USER_ID,USER_NAME) values ('user_id_4','user_name_4');
Insert into JTUSER (USER_ID,USER_NAME) values ('user_id_5','user_name_5');

Insert into JTHISTORY (history_id, user_id,product_name) values (1, 'user_id_1','product_1');
Insert into JTHISTORY (history_id, user_id,product_name) values (2, 'user_id_2','product_2');
Insert into JTHISTORY (history_id, user_id,product_name) values (3, 'user_id_2','product_3');
Insert into JTHISTORY (history_id, user_id,product_name) values (4, 'user_id_6','product_4');
Insert into JTHISTORY (history_id, user_id,product_name) values (5, 'user_id_4','product_5');


select * from jthistory;
select * from jtuser;

-- inner join : 두 테이블에 모두 데이터가 있어야함
select u.user_id, u.user_name, h.history_id, h.product_name
from jtuser u, jthistory h
where u.user_id=h.user_id;
-- 
select u.user_id, u.user_name, h.history_id, h.product_name
from jtuser u left outer join jthistory h
on u.user_id=h.user_id;
--
select u.user_id, u.user_name, h.history_id, h.product_name
from jtuser u right outer join jthistory h
on u.user_id=h.user_id;

 /* sub query */
-- scalar sub query: select 절에 사용된 sub query, outer join 과 동일한 결과, 데이터가 적으면 subquery 가 속도적으로 유리, 많으면 join
# city와 그 city가 소속된 국가의 이름을 출력하시오

# film에서 film_id, title, length를 film들의 평균 length와 함께 출력하시오.

# 1번 고객의 이메일과 주소를 출력하시오.

#1번 영화의 title, rental_duration을 전체 평균, 전체 최대, 전체 최소와 함께 출력하시오.

-- inline view: from 절에서 사용된 sub query로 가상의 테이블 역할
# 영화의 제목, 렌탈 기간을 등급별 최대, 최소, 평균 렌탈 기간과 함께 출력하시오.


-- nested sub query(condition query): where 절에 사용된 sub query
-- 단일행 서브쿼리: 서브쿼리가 리턴하는 결과가 하나의 컬럼인 경우
# film에서 평균 length 보다 긴 영화의 film_id, title, length를 length, title에 대한 오름차순으로 정렬하시오.
 
# country에서 South Korea에 속한 도시의 이름을 출력하시오.

# 등급별 평균 렌탈료가 전체 평균 렌탈료보다 비싼 영화의 등급은?

-- 다중행 서브 쿼리: nested sub query에서 반환하는 행이 2개 이상인 경우
# 2005-06-15일 반납한 사람들과 같은 동네에 사는 customer의 정보는?

# Aurora에 사는 사람들이 렌탈한 영화의 제목은?

# NC-17등급의 가장 긴 영화보다 긴 영화들을 출력하시오.





