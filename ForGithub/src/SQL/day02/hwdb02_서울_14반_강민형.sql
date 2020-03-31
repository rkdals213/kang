use ssafydb;
# 1. 상품정보를 저장할 수 있는 테이블을 구성하여 보자.
create table product(
	product_code varchar(10) primary key,
    product_name varchar(20),
    product_price int
);
# 2. 상품 데이터를 5개 이상 저장하는 SQL을 작성하여 보자.
insert into product values('10001','TV',500);
insert into product values('20001','냉장고',1000);
insert into product values('30001','노트북',100);
insert into product values('40001','컴퓨터',1200);
insert into product values('50001','모니터',50);

select * from product;
# 3. 상품을 세일하려고 한다. 15% 인하된 가격의 상품 정보를 출력하세요.
select product_code, product_name, product_price*0.85 from product;
# 4. TV 관련 상품을 가격을 20% 인하하여 저장하세요. 그 결과를 출력하세요.
SET SQL_SAFE_UPDATES = 0;
update product set product_price=product_price*0.8
where product_name='TV';
select * from product;
# 5. 저장된 상품 가격의 총 금액을 출력하는 SQL 문장을 작성하세요.
select sum(product_price) as '총금액' from product;
