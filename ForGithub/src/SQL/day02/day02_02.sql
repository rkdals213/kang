-- 문자열 함수: 대/소문자 : upper, lower
#customer의 first_name을 소문자로,  email을 대문자로 출력하시오.
select first_name, lower(first_name), upper(first_name)
from customer;
#address에서 address에 Way가 들어간 자료를 출력하시오. 단 대소문자를 구분한다.
select *
from address
where address like binary '%Way%'; -- 문자열에서 대/소문자를 구별해서 사용하고싶다 - binary

-- 문자열 함수: 길이
#city에서 도시 이름이 10글자 이상인 도시를 조회하시오. : length, char_length
select *
from city
where length(city) >= 10;
insert into actor(first_name, last_name) value('홍', 'hong');
select *, length(first_name), length(last_name), char_length(first_name), char_length(last_name) from actor where first_name = '홍';
-- 한글 unicode : 한글자가 3byte, length의 기준은 byte의 개수

-- 문자열과 문자열의 결합 : concat
#customer에서 first_name과 last_name의 합이 20자 이상인 경우를 조회하시오.
select *
from customer
where char_length(concat(first_name, last_name)) >= 20; -- 함수 결과는 출력뿐만 아니라 조건으로 사용가능

-- 문자열 함수: 잘라내기: substr(str, position), substr(str, position, length)
-- length: 생략 시 맨 뒤까지, position: 1부터 시작, 음수이면 뒤에서부터
set @name:="홍길동임꺽정장길산";
select @name, substr(@name, 4);
select @name, substr(@name, -6, 3);
#city에서 도시명의 3번째 글자가 모음인 경우를 조회하시오.
select *
from city
where substr(city, 3, 4) in ('a','e','i','o','u');

-- 문자열 함수: 잘라내기 left, right, mid
# name 에서 임꺽정, 홍길동, 장길산을 따로 출력해보자
select @name, left(@name,3), right(@name,3), mid(@name,4,3);
#address의 phone을 1234XXXXX1234의 형태로 출력하시오. -- concat, left, right, length, lpad
select concat(left(phone,4), lpad('*', length(phone)-8,'*'), right(phone,4)) as '당첨자 번호'
from address 
where length(phone) > 0;
-- 문자열 함수: 채우기: lpad / rpad
select lpad('1234567890',15,'0'), rpad('1234567890',15,'0');
#city의 도시명을 아래와 같이 출력하시오.
# [  A Corua(La Corua)] (도시명의 총 글자 수는 [] 를 포함 22자이다.)
select concat('[',lpad(city,20,' '),']')
from city;
-- 문자열 함수: 공백 지우기: trim
select '     a    ', ltrim('     a    '), rtrim('     a    '), trim('     a    ');
select trim(both '=' from '==hello=='), trim(leading '=' from '==hello=='), trim(trailing '=' from '==hello==');
#customer의 이메일 아이디만을 출력하시오.
select trim(trailing '@sakilacustomer.org' from email) as 'mail id' from customer;

-- 문자열 함수: 위치 찾기: instr
select instr('foobar', 'bar');
#customer에서 email의 도메인 주소를 중복없이 출력하시오.
select substr(email, 1, instr(email, '@')-1) from customer;
-- 문자열 함수: 대체: replace
#address의 address에서 공백을 _로 대체하시오.
select address, replace(address, ' ', '_') from address;

-- 숫자 함수: 변형: round, truncate, ceiling, floor, abs, pow, mod, greatest, least
#film의 렌탈 비용을 소수점 한자리로 반올림하시오
select rental_rate, round(rental_rate,1) from film;
-- 날짜 함수
# 현재 시각 조회
select now(), curdate(), curtime(), sysdate();
select now(), curdate(), sleep(5), now(), sysdate();
# now : 쿼리를 날린 시각, sysdate : 쿼리가 실행하고 있는 시각
-- 날짜 함수: 날짜의 특정 값 조회: year, month, dayofmonth, monthname, dayname, ...
#rental에서 반납일이 일요일인 자료를 조회하시오.
select year(now()), month(now()), dayofmonth(now()), monthname(now()), dayname(now());
select @@lc_time_names;
set lc_time_names='ko_KR';
set lc_time_names='en_US';
select dayofweek(now()), weekday(now()); -- dayofweek: 일요일이 1, weekday: 월요일이 0
select * from rental where dayname(return_date) = 'sunday';
select * from rental where dayofweek(return_date) = 1;
#rental에서 렌탈일이 7월인 자료를 조회하시오.
select * from rental
where month(rental_date) = '7';
-- 날짜 함수: 날짜의 연산 : date_add, date_sub, datediff, from_days, to_days
# customer에서 100번 고객의 가입일과 100일 기념일은?
# year|month|day|hour|minute|second
select create_date, date_add(create_date, interval 100 day) from customer;
select create_date, date_add(create_date, interval 1 year) from customer;

# 오늘은 올해 1월 1일로부터 몇일이 지났는가?
select datediff(now(), '2020-01-01');
# rental에서 rental_id가 15000~16000인 자료의 rental_id와 각 rental_id별 렌탈 기간을 대여기간으로 정렬하시오.
select rental_id, datediff(return_date, rental_date) as '대여기간' from rental
where rental_id between 15000 and 16000
#order by 2;
order by 대여기간;

-- 형변환

-- 형변환: 문자열 <==> 날짜: date_format, str_to_date
#customer 의 create_date를 2016/02/14(화) 형태로 출력하시오.
select create_date, date_format(create_date, '%Y/%c/%d(%a)') as '가입일' from customer;
# https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format

#’2016-02-14 18:30'을 날짜 형태로 출력하시오. 
select '2016-02-14 18:30', str_to_date('2016-02-14 18:30', '%Y-%c-%d %H:%i');
-- 형변화: 문자열 <==> 숫자: format
-- #, ##, ###.##  두번째 파라미터의 의미는?? 반올림
select format(12345.6789,2);

-- 형변환: 문자열 --> 원하는 형태(date, datetime, decimal...)로 변환(변환 가능한 부분까지 만 변환)
select cast('12,345.68' as decimal(10,2)), cast(replace('12,345.68',',','') as decimal(10,2));
select cast('2020-03-31' as datetime);

-- 논리함수: case
/*
	simple case		case value when 비교값 then 대체값  - value와 비교값 동등 비교
							   when 비교값 then 대체값
                               when 비교값 then 대체값
							   else 대체값
					end
    serched case	case when 비교조건 then 대체값
						 when 비교조건 then 대체값
                         when 비교조건 then 대체값
                         else 대체값
					end
*/
#film의 rating 을 등급에 대한 설명으로 대체하시오.(G ->general Audiences)
select title, rating, case rating when 'G' then 'general audiences'
								  when 'PG' then '부모동반'
								  when 'PG-13' then '13세 주의'
                                  when 'R' then '제한적'
                                  else '미성년 관람 불가'
					  end as '등급설명'
from film;

#film의 대여 기간이 6일 이상이면 장기대여, 4일이상이면 일반대여, 나머지는 단기대여로 표시하시오.
-- 대여기간 : film의 rental_duration
 select title, rental_duration, case when rental_duration >= 6 then '장기대여'
									 when rental_duration >= 4 then '일반대여'
                                     else '단기대여'
								end as '대여기간'
 from film;
 
-- 기타함수: if, ifnull, nullif
# if(논리식, true일 경우, 거짓일 경우) - 삼항연산자
#staff의 사진이 아직 없으면 미제출, 있으면 제출완료라고 표현하시오.
select * from staff;
select first_name, picture, if(picture is null, '미제출','제출완료') as '사진제출여부'
from staff;
# ifnull(값1, 값2) : 값1이 null이면 값2로 출력

#rental에서 rental_id가 15850 ~ 15900 사이인 자료의 rental_id, rental_date, return_date를 출력하시오. 단 아직 반납 안된 자료를 return_date에 미반납이라고 출력한다.
select rental_id, rental_date, return_date, ifnull(return_date, '미반납')
from rental
where rental_id between 15850 and 15900;
#위 조건에서 렌탈 기간을 출력하시오. 단 아직 미반납인 경우 오늘 까지로 계산한다.
select rental_id, datediff(return_date, rental_date), datediff(ifnull(return_date, now()), rental_date)
from rental
where rental_id between 15850 and 15900;

-- cast : 문자열 --> 원하는 타입으로 변경
select cast('12,345.67' as decimal(10,2)), cast(replace('12,345.68',',','') as decimal(10,2));