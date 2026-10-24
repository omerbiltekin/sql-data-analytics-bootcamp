-- ===============================================================
-- Hafta 2: İleri Düzey Gruplama, Geçici Tablolar ve JOIN İşlemleri
-- Veritabanı: verianalizi
-- ===============================================================

USE verianalizi;
GO

-- 1. Ürün bazında minimum ve maksimum sipariş tutarları
SELECT product_id, MIN(order_total) AS min_order_total, MAX(order_total) AS max_order_total 
FROM customer_orders 
GROUP BY product_id;

-- 2. Ortalama müşteri harcaması 2000'in üzerinde olan şehirler
SELECT city, AVG(total_money_spent) 
FROM customers 
GROUP BY city 
HAVING AVG(total_money_spent)>2000;

-- 3. 2000'den fazla harcama yapan müşterileri listeleme
SELECT * 
FROM customers 
WHERE total_money_spent>2000;

-- 4. Ortalama harcaması 2000'den büyük şehirleri artan sırada listeleme
SELECT city, AVG(total_money_spent) AS avg_total_money 
FROM customers 
GROUP BY city 
HAVING AVG(total_money_spent) > 2000 
ORDER BY avg_total_money;

-- 5. Ortalama harcaması 2000'den büyük şehirleri azalan sırada listeleme
SELECT city, AVG(total_money_spent) AS avg_total_money 
FROM customers 
GROUP BY city 
HAVING AVG(total_money_spent) > 2000 
ORDER BY avg_total_money DESC;

-- 6. Ortalama maaşı 55.000'den yüksek olan departmanlar
SELECT department, AVG(salary) 
FROM employees 
GROUP BY department 
HAVING AVG(salary) > 55000;


-- 7. Scranton şehrindeki müşterileri geçici tabloya (#city) alma ve sorgulama
DROP TABLE IF EXISTS #city
SELECT * 
INTO #city
FROM customers
WHERE city = 'Scranton';

SELECT * 
FROM #city;

-- 8. Adresinde 'Hilly' kelimesi geçen müşteriler
SELECT * 
FROM customers 
WHERE address like '%Hilly%';

-- 9. Sipariş tutarı 20'den büyük VEYA bahşişi 2'den fazla olan siparişler
SELECT * 
FROM customer_orders 
WHERE order_total > 20 
OR tip > 2; 

-- 10. Müşteri ve sipariş bilgilerini birleştirme (JOIN)
SELECT * FROM customers;
SELECT * FROM customer_orders;

SELECT * 
FROM customers AS a
JOIN customer_orders AS b ON a.customer_id = b.customer_id;

-- 11. Müşteri ve sipariş bilgilerini sol tablo bazlı birleştirme (LEFT JOIN)
SELECT * 
FROM customers AS a
LEFT JOIN customer_orders AS b ON a.customer_id = b.customer_id;

-- 12. Müşteri ID'leri ile müşteri siparişlerini birleştirme ve tekilleştirme (DISTINCT)
SELECT DISTINCT customer_id
FROM customer_orders; 

-- 13. Müşteri, sipariş ve değerlendirme bilgilerini birleştirme
SELECT * 
FROM customer_orders_review;

SELECT *
FROM customers;

SELECT *
FROM customer_orders;

SELECT * 
FROM customers AS a
JOIN customer_orders_review AS b ON a.customer_id = b.customer_id
JOIN customer_orders AS c ON a.customer_id = c.customer_id;

-- 14. Müşteri, sipariş ve değerlendirme bilgilerini birleştirerek, müşteri bilgileri ile birlikte sipariş ve değerlendirme detaylarını listeleme
SELECT a.*, c.[tip] , b.[Rating 1-10] 
FROM customers AS a
JOIN customer_orders_review AS b ON a.customer_id = b.customer_id
JOIN customer_orders AS c ON a.customer_id = c.customer_id;

-- 15. Müşteri, sipariş ve değerlendirme bilgilerini birleştirerek, müşteri bilgileri ile birlikte sipariş ve değerlendirme detaylarını listeleme. Sadece değerlendirme puanı 5'ten büyük olan ve toplam harcaması 20'den fazla olan müşterileri listeleme
SELECT * 
FROM customers AS a
JOIN customer_orders_review AS b ON a.customer_id = b.customer_id
JOIN customer_orders AS c ON a.customer_id = c.customer_id
WHERE b.[Rating 1-10] > 5 
AND a.total_money_spent > 20;

-- 16. Adresinde 'North' geçen müşterileri ve bu müşterilerin sipariş ve değerlendirme detaylarını listeleme
SELECT * 
FROM customers AS a 
JOIN customer_orders_review AS b ON a.customer_id = b.customer_id
WHERE address like '%North%';

-- 17. Müşteri, sipariş ve değerlendirme bilgilerini birleştirerek, müşteri bilgileri ile birlikte sipariş ve değerlendirme detaylarını listeleme. Sadece değerlendirme puanı 5'ten büyük olan ve toplam harcaması 20'den fazla olan müşterileri listeleme. Sadece müşteri adı, soyadı, adres ve ortalama sipariş tutarını listeleme
SELECT a.first_name, a.last_name, a.address, AVG(b.order_total) AS avg_order_total
FROM customers AS a 
JOIN customer_orders AS b ON a.customer_id = b.customer_id 
JOIN customer_orders_review AS c ON a.customer_id = c.customer_id
GROUP BY a.first_name, a.last_name, a.address; 