-- ===============================================================
-- Hafta 1: Temel SQL & Veri Filtreleme
-- Veritabanı: verianalizi
-- ===============================================================

USE verianalizi;

-- 1. Tüm müşteri kayıtlarını listeleme
SELECT * FROM customers;

-- 2. Soyadı 'Muffin' olan müşteriyi bulma
SELECT * FROM customers WHERE last_name = 'Muffin';

-- 3. Scranton şehrinde yaşayan müşterileri bulma
SELECT * FROM customers WHERE city = 'Scranton';

-- 4. Scranton şehrinde yaşayan ve adı Kevin olan müşteriler
SELECT * FROM customers WHERE first_name = 'Kevin' AND city = 'Scranton';

-- 5. Tüm çalışan kayıtlarını listeleme
SELECT * FROM employees;

-- 6. Maaşı 50.000'in üzerinde olan personeller
SELECT * FROM employees WHERE salary > 50000;

-- 7. Maaşı 30.000 ile 60.000 aralığında olan personeller
SELECT * FROM employees WHERE salary BETWEEN 30000 AND 60000;

-- 8. Personellerin adı, soyadı ve maaş bilgisi
SELECT first_name, last_name, salary FROM employees;

-- 9. Fırın (Bakery) departmanında çalışan personeller
SELECT first_name, last_name, department FROM employees WHERE department = 'Bakery';

-- 10. Tüm personellerin ortalama maaşı
SELECT AVG(salary) FROM employees;

-- 11. Departman bazında ortalama maaş dağılımı
SELECT department,AVG(salary) FROM employees GROUP BY department;

SELECT * FROM customers;

SELECT city, AVG(total_money_spent) FROM customers GROUP BY city;

-- 12. Şehir bazında ortalama harcama tutarları
SELECT city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city;

SELECT state,city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city,state;

-- 13. Eyalet ve şehir bazında ortalama harcama tutarları (Azalan sırada)
SELECT state,city, AVG(total_money_spent) as average_total_money_spent FROM customers GROUP BY city,state ORDER BY average_total_money_spent DESC;

-- 14. TX (Teksas) eyaletinde olmayan müşteriler
SELECT * FROM customers WHERE state!='TX';

-- 15. TX veya FL eyaletlerinde yer almayan müşteriler
SELECT * FROM customers WHERE state NOT IN ('TX','FL');

-- 16. Sadece TX veya FL eyaletlerindeki müşteriler
SELECT * FROM customers WHERE state IN ('TX','FL');

-- 17. Bakery departmanında çalışmayıp maaşı 50.000'den yüksek olan personeller
SELECT * FROM employees WHERE salary>50000 AND department!='Bakery';
