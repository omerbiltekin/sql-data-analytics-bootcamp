# Hafta 2: İleri Düzey Filtreleme, Geçici Tablolar ve JOIN Mimarisi

### 1. `HAVING` vs `WHERE`
* **`WHERE`**: Satır bazlı filtreleme yapar. Veriler henüz gruplanmadan önce çalışır; bu nedenle `SUM()`, `AVG()` gibi kümeleme (aggregate) fonksiyonlarıyla doğrudan kullanılamaz.
* **`HAVING`**: `GROUP BY` ile oluşturulan grupların filtrelenmesinde kullanılır. Kümeleme fonksiyonlarının (`AVG(...) > 2000` gibi) sonuçlarına filtre uygulamak için şarttır.

### 2. Geçici Tablolar (Temporary Tables)
* **`#tablo_adi`**: Önüne tek `#` işareti konularak oturuma (session) özel geçici tablolar üretilir.
* Sadece bağlantı açıkken bellekte/tempdb üzerinde yaşar, bağlantı koptuğunda otomatik temizlenir.
* `SELECT ... INTO #temp_table FROM ...`: Sorgu sonucundan anında geçici tablo üretir.

### 3. Desen Arama (`LIKE`)
* **`%`**: Sıfır veya daha fazla sayıda herhangi bir karakteri temsil eder.
  * `'%Hilly%'`: İçinde "Hilly" geçen tüm kayıtlar.
  * `'North%'`: "North" ile başlayan kayıtlar.

### 4. Tablo Birleştirmeleri (JOIN)
* **`JOIN` (veya `INNER JOIN`)**: Her iki tabloda da birleşme koşulunu (`ON`) sağlayan kesişim kayıtlarını getirir.
* **`LEFT JOIN`**: Sol tablodaki tüm satırları getirir; sağ tabloda eşleşmeyen satırlar için `NULL` değer basar.
* **`DISTINCT`**: Sonuç kümesindeki mükerrer (tekrar eden) satırları tekilleştirir.