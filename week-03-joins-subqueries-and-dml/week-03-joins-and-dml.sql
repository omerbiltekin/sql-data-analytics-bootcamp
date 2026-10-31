-- ===============================================================
-- Hafta 3: JOIN Türleri, Alt Sorgular (Subqueries) ve DML (UPDATE)
-- Veritabanı: verianalizi
-- ===============================================================

USE verianalizi;
GO

-- Geçen hafta tekrarı: Müşteri, sipariş ve değerlendirme tablolarını birleştirme (JOIN)
SELECT * 
FROM customers AS a
JOIN customer_orders AS b ON a.customer_id = b.customer_id
JOIN customer_orders_review AS c ON a.customer_id=c.customer_id;

-- 1. customer_orders ve customers tablolarını LEFT JOIN, RIGHT JOIN ve INNER JOIN ile birleştirip tüm kayıtları listeleme (ORDER BY ile)
SELECT *
FROM customer_orders AS a
LEFT JOIN customers AS b ON a.customer_id=b.customer_id
ORDER BY a.customer_id;

SELECT *
FROM customer_orders AS a
RIGHT JOIN customers AS b ON a.customer_id=b.customer_id
ORDER BY a.customer_id;

SELECT *
FROM customer_orders AS a
JOIN customers AS b ON a.customer_id=b.customer_id
ORDER BY a.customer_id;

-- 2. Değerlendirme ve müşteri bilgilerini LEFT JOIN ve RIGHT JOIN ile yön farkını görerek birleştirme
SELECT *
FROM customer_orders_review AS a
LEFT JOIN customers AS b ON a.customer_id=b.customer_id;

SELECT *
FROM customers AS a  
RIGHT JOIN customer_orders_review AS b ON a.customer_id=b.customer_id;

-- 3. Şehir ve eyalet bazında ortalama harcama tutarlarını azalan sırada listeleme
SELECT a.[city], a.[state], AVG(total_money_spent) AS avg_money_spent
FROM customers AS a
JOIN customer_orders AS b ON a.customer_id=b.customer_id
GROUP BY a.city, a.[state]
ORDER BY avg_money_spent DESC;

-- 4. Müşteri adı, soyadı ve değerlendirme puanı bazında toplam sipariş tutarı 100'den büyük olanları listeleme (HAVING)
SELECT b.first_name, b.last_name, SUM(c.order_total) AS sum_order_total , a.[Rating 1-10]
FROM customer_orders_review AS a    
JOIN customers AS b ON a.customer_id=b.customer_id
JOIN customer_orders AS c ON a.customer_id=c.customer_id
GROUP BY b.first_name,b.last_name,a.[Rating 1-10]
HAVING SUM(c.order_total) >100 ;

-- 5. Eyaleti PA olan veya eyaleti TX olup toplam harcaması 1000'den fazla olan müşterileri filtreleme (AND / OR önceliği)
SELECT * 
FROM customers
WHERE [state] = 'PA' OR [state]= 'TX' AND total_money_spent>1000;

-- 6. ID'si 100102 olan müşterinin toplam harcama tutarını 3000 olarak güncelleme (UPDATE)
SELECT * 
FROM customers AS a

UPDATE a 
SET total_money_spent = 3000 -- SELECT *
FROM customers AS a 
WHERE a.customer_id= 100102

-- 7. ID'si 100109 olan müşterinin soyadını 'Farrow' olarak güncelleme (UPDATE)
SELECT * 
FROM customers

UPDATE a 
SET a.last_name = 'Farrow' -- SELECT *
FROM customers AS a 
WHERE a.customer_id= 100109

-- 8. En az bir siparişi olan müşterileri alt sorgu ile listeleme (Subquery - IN)
SELECT *
FROM customers AS a 
WHERE a.customer_id IN ( SELECT customer_id FROM customer_orders);

-- 9. 2022 yılından sonraki siparişleri ve müşteri bilgilerini geçici bir tabloya (#example) aktarma
DROP TABLE IF EXISTS #example
SELECT a.customer_id, a.city, a.[state],b.order_date
INTO #example
FROM customers AS a
JOIN customer_orders AS b ON a.customer_id=b.customer_id
WHERE b.order_date >'2022';

-- 10. Geçici tabloyu listeleme, customer_orders ile LEFT JOIN yapma ve alt sorgu ile eşleşen siparişleri getirme
SELECT * 
FROM #example

SELECT *
FROM #example AS a
LEFT JOIN customer_orders AS b ON a.customer_id=b.customer_id;

SELECT *
FROM customer_orders AS a
WHERE a.customer_id IN (SELECT customer_id FROM #example);

-- 11. Geçici tablodaki (#example) 100101 ID'li müşterinin şehir bilgisini 'Toronto' olarak güncelleme (UPDATE)
UPDATE a
SET city = 'Toronto' -- SELECT *
FROM #example AS a
WHERE a.customer_id = 100101;

-- 12. 100101 ID'li müşterinin ortalama sipariş tutarı 10'dan büyükse telefon bilgisi ve ortalamasını artan sırada listeleme (WHERE, HAVING ve ORDER BY ile)
SELECT a.customer_id,a.phone, AVG(b.order_total) AS avg_total
FROM customers AS a 
JOIN customer_orders AS b ON a.customer_id=b.customer_id
JOIN customer_orders_review c ON a.customer_id=c.customer_id
WHERE a.customer_id = 100101 
GROUP BY a.customer_id,a.phone
HAVING AVG(b.order_total) > 10
ORDER BY avg_total ASC;


