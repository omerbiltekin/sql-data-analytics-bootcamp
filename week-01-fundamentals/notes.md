# Hafta 1: SQL Temelleri & Özet Notlar

### 1. Temel Filtreleme (`WHERE`)
* **`WHERE`**: Tablodaki satırları belirli şartlara göre filtreler.
* **`BETWEEN ... AND ...`**: Belirli iki sınır arasındaki değerleri seçer (sınırlar dahildir).
* **`IN (...)`**: Değerin belirtilen liste içinde olup olmadığını kontrol eder.
* **`NOT IN (...)`**: Değerin belirtilen listede yer almadığı durumları seçer.
* **`<>` (veya `!=`)**: Eşit değildir anlamına gelir.

### 2. Kümeleme ve Gruplama (Aggregation)
* **`AVG()`**: Sayısal sütunların aritmetik ortalamasını alır.
* **`AS`**: Sütunlara veya hesaplama sonuçlarına takma isim (alias) verir.
* **`GROUP BY`**: Verileri belirli sütunlardaki değerlere göre kategorize eder.

### 3. Sıralama (`ORDER BY`)
* **`ORDER BY`**: Çıktıyı belirli bir sütuna göre sıralar.
* **`ASC`**: Küçükten büyüğe sıralama (varsayılandır).
* **`DESC`**: Büyükten küçüğe sıralama.