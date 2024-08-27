-- Belirli bir veritabanına bağlanma
-- PostgreSQL'de veritabanı seçme komutu yoktur. Bağlantı kurarken veritabanı seçilmelidir.
-- Bu komutu kullanırken doğru veritabanı ile bağlantı sağlanmış olmalıdır.

-- Dizin Oluşturma
CREATE INDEX i_uyeler
ON tbl_uyeler(telefon);
