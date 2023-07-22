--- 5 tables, 3-5 Queries, 1 WITH, 1 Sub, 1 Agg
.open restaurant.db

.mode column
.header on
  

----------------------------------------- Create tables
CREATE TABLE menus (
  menuID int unique,
  menu text,
  price int
  );

CREATE TABLE customers(
  customerID int unique,
  name text,
  country text
  );

CREATE TABLE orders(
  customerID int,
  menuID int,
  billID int
  );

CREATE TABLE employee(
  employeeID int unique,
  firstname text,
  lastname text,
  phone text,
  nationality text
  );

CREATE TABLE bills(
  billID int unique,
  bill_date datetime,
  customerID int,
  employeeID int
  );

----------------------------------------- Insert values
insert into menus values
  (1, "Thai Tea", 55),
  (2, "Chocolate", 55),
  (3, "Fresh Milk", 55),
  (4, "Coffee", 60),
  (5, "Milk Tea", 60),
  (6, "Green Tea", 60),
  (7, "Honey Toast", 80),
  (8, "Chocolate Toast", 85)
;


insert into customers values
  (1, "Jan", "Thailand"),
  (2, "Sandy", "Thailand"),
  (3, "John", "USA"),
  (4, "Mary", "USA"),
  (5, "Yuki", "Japan")
;


insert into orders values
  (1, 2, 1),
  (1, 7, 1),
  (2, 5, 2),
  (3, 4, 3),
  (4, 1, 4),
  (5, 3, 5),
  (5, 7, 5)
;


insert into employee values
  (1, "Mana", "Boonmee", "0987654321", "Thai"),
  (2, "Manee", "Boonma", "0612345678", "Thai")
;


insert into bills values
  (1, "2023-02-01", 1, 2),
  (2, "2023-02-01", 2, 2),
  (3, "2023-02-01", 3, 1),
  (4, "2023-02-01", 4, 1),
  (5, "2023-02-01", 5, 1)
;

----------------------------------------- Query

----------------------------------------- 1. WITH รายการอาหารที่ได้ขายให้กับลูกค้า
  
WITH income AS(
  select
    customers.customerID,
    customers.country,
    menus.menuID, 
    menus.menu, 
    menus.price
  from customers
  join orders on customers.customerID = orders.customerID
  join menus on orders.menuID = menus.menuID
)

select * from income;


----------------------------------------- 2. Aggregation คนจากประเทศไหนซื้อเมนูนม และรวมยอดขายทั้งหมดเท่าไหร่

WITH income AS(
  select
    customers.customerID,
    customers.country,
    menus.menuID, 
    menus.menu, 
    menus.price
  from customers
  join orders on customers.customerID = orders.customerID
  join menus on orders.menuID = menus.menuID
)
  
select country, sum(price) as total 
from income
where menu like "Milk%" 
  or  menu like "%Milk"
group by country
;



----------------------------------------- 3. Subquery พนักงานที่ขายอาหารราคาตั้งแต่ 60 บาทขึ้นไป

select employeeID, price from (
  select * from bills
  join orders on bills.billID = orders.billID
  join menus on orders.menuID = menus.menuID
  )
where price >= 60
;


----------------------------------------- 4. ยอดขายที่พนักงานแต่ละคนทำได้
select 
  employeeID, 
  sum(price) as total_sales_price 
  from (
    select * from bills
    join orders on bills.billID = orders.billID
    join menus on orders.menuID = menus.menuID
  )
group by employeeID
;


----------------------------------------- 5. ยอดขายแต่ละเมนู
with sales as(
  select 
    menus.menu,
    menus.price,
    bills.billID
  from menus
  full join orders on menus.menuID = orders.menuID
  full join bills  on orders.billID = bills.billID
  )

  select 
    menu, 
    count(billID) as quantity, 
    price*count(billID) as total 
  from sales
  group by menu
;
