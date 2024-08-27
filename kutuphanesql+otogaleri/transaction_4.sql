-- Transaction Yönetimi
BEGIN;

-- Kitapların sayfa sayısını sıfırla
UPDATE tbl_kitaplar SET sayfa_sayisi = 0;

-- Kitap adlarını 'Deneme' olarak güncelle
UPDATE tbl_kitaplar SET kitap_adi = 'Deneme';

-- Güncellenmiş tabloyu gör
SELECT * FROM tbl_kitaplar;

-- İşlemi geri al
ROLLBACK;

-- İşlemi geri aldıktan sonra tabloyu tekrar gör
SELECT * FROM tbl_kitaplar;

-- Transaction'ın Kalıcı Hale Getirilmesi
BEGIN;

-- Kitapların sayfa sayısını sıfırla
UPDATE tbl_kitaplar SET sayfa_sayisi = 0;

-- Kitap adlarını 'Deneme' olarak güncelle
UPDATE tbl_kitaplar SET kitap_adi = 'Deneme';

-- Güncellenmiş tabloyu gör
SELECT * FROM tbl_kitaplar;

-- İşlemi kalıcı hale getir
COMMIT;

-- İşlemi commit ettikten sonra tabloyu tekrar gör
SELECT * FROM tbl_kitaplar;

-- Savepoint Kullanımı
BEGIN;

-- Savepoint oluştur
SAVEPOINT deneme;

-- Kitapların sayfa sayısını sıfırla
UPDATE tbl_kitaplar SET sayfa_sayisi = 0;

-- Güncellenmiş tabloyu gör
SELECT * FROM tbl_kitaplar;

-- Savepoint'e geri dön
ROLLBACK TO SAVEPOINT deneme;

-- Savepoint'e geri döndükten sonra tabloyu tekrar gör
SELECT * FROM tbl_kitaplar;

-- Kitap adlarını 'Deneme' olarak güncelle
UPDATE tbl_kitaplar SET kitap_adi = 'Deneme';

-- Güncellenmiş tabloyu gör
SELECT * FROM tbl_kitaplar;

-- İşlemi kalıcı hale getir
COMMIT;

-- İşlemi commit ettikten sonra tabloyu tekrar gör
SELECT * FROM tbl_kitaplar;
