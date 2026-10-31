# Hafta 3: JOIN Mimarisi, Alt Sorgular (Subqueries) ve DML (UPDATE)

### 1. JOIN Türleri ve Yön Mantığı
* **`INNER JOIN`**: Yalnızca her iki tabloda da birleşme koşulunu (`ON`) sağlayan kesişim kayıtlarını döndürür.
* **`LEFT JOIN`**: Sol tablodaki tüm satırları korur[cite: 5]. Sağ tabloda eşleşen bir kayıt yoksa sağ tarafın alanları `NULL` döner.
* **`RIGHT JOIN`**: Sağ tablodaki tüm satırları korur[cite: 5]. Sol tabloda eşleşmeyen alanlar `NULL` döner.
* **Yön Eşdeğerliği:** `TabloA LEFT JOIN TabloB` sorgusu ile `TabloB RIGHT JOIN TabloA` sorgusu aynı sonuç kümesini üretir.

### 2. Mantıksal Operatör Önceliği (`AND` vs `OR`)
* SQL sorgularında `AND` operatörünün işlem önceliği `OR` operatöründen yüksektir.
* `WHERE state = 'PA' OR state = 'TX' AND total_money_spent > 1000` ifadesi SQL motoru tarafından şu şekilde yorumlanır:
  * `state = 'PA'` olan herkes **VEYA** (`state = 'TX'` VE `total_money_spent > 1000` olanlar).
* Gruplamanın net olması için her zaman parantez `( ... )` kullanımı tavsiye edilir.

### 3. Alt Sorgular (Subqueries - `IN`)
* Bir sorgunun sonucunu, başka bir ana sorgunun filtre (`WHERE`) koşuluna dinamik liste olarak beslemeye yarar.
* Örnek: `WHERE customer_id IN (SELECT customer_id FROM customer_orders)` ifadesi, sipariş tablosundaki tekil ID listesini çıkarıp ana müşteri tablosundan bu kişileri çeker.

### 4. T-SQL ile Veri Güncelleme (`UPDATE ... FROM`)
* T-SQL'de ilişkili veya takma adlı (alias) tablolarda güncelleme yaparken `UPDATE alias SET ... FROM Tablo alias WHERE ...` yapısı kullanılır.
* **Güvenlik İpucu:** `UPDATE` çalıştırmadan önce `SET` satırını yorum satırına alıp `-- SELECT *` şeklinde çalıştırarak hangi satırların etkileneceğini önceden doğrulamak veri kaybını önler.

### 5. Geçici Tablolarda DML
* `#` ile açılan oturuma özel geçici tablolar üzerinde tıpkı kalıcı tablolarda olduğu gibi `SELECT`, `UPDATE`, `DELETE` ve `JOIN` işlemleri tam yetkiyle çalıştırılabilir.