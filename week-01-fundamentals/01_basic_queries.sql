-- İlk Ders
USE verianalizi;

SELECT * FROM customers;

SELECT * FROM customers WHERE last_name='Muffin';

SELECT * FROM customers WHERE city='Scranton';

SELECT * FROM customers WHERE first_name='Kevin' AND city='Scranton';

SELECT * FROM employees;

SELECT * FROM employees WHERE salary>50000;
-- WHERE : filtreleme yapmak için kullanılır.

SELECT * FROM employees WHERE salary BETWEEN 30000 AND 60000;
-- BETWEEN : aralık seçmek için kullanılır.

SELECT first_name, last_name, salary FROM employees; 

SELECT first_name, last_name, department FROM employees WHERE department='Bakery';

SELECT AVG(salary) FROM employees;
-- AVG : ortalama almak için kullanılır.

SELECT department,AVG(salary) FROM employees GROUP BY department;
-- GROUP BY : gruplama yapmak için kullanılır.

SELECT * FROM customers;

SELECT city, AVG(total_money_spent) FROM customers GROUP BY city;

SELECT city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city;
-- as : isim atama olarak kullanılır. as koymak_istediğin_isim 

SELECT state,city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city,state;

SELECT state,city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city,state ORDER BY average_total_money_spent DESC;
-- ORDER BY : sıralama yapmak için kullanılır.
-- DESC : büyükten küçüğe sıralama yapmak için kullanılır.
-- ASC : küçükten büyüğe sıralama yapmak için kullanılır.

SELECT * FROM customers WHERE state!='TX';
-- != : eşit değil anlamına gelir. (Onu seçmek istemiyorsan kullanılır.)

SELECT * FROM customers WHERE state NOT IN ('TX','FL');
-- not in () : listede olmayanları seçmek için kullanılır.

SELECT * FROM customers WHERE state IN ('TX','FL');
-- in () : listede olanları seçmek için kullanılır.

SELECT * FROM employees WHERE salary>50000 AND department!='Bakery';
