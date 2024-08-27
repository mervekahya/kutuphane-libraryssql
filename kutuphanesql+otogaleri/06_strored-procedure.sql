-- Parametreli Fonksiyon Oluşturma
CREATE OR REPLACE FUNCTION stp_kitap_bilgi(isbn INT)
RETURNS TABLE(isbn INT, kitap_adi TEXT, sayfa_sayisi INT) AS $$
BEGIN
    -- Belirtilen ISBN'ye sahip kitap bilgilerini döndürür
    RETURN QUERY
    SELECT isbn, kitap_adi, sayfa_sayisi
    FROM tbl_kitaplar
    WHERE isbn = isbn;
END;
$$ LANGUAGE plpgsql;

-- Fonksiyonu çalıştırma
SELECT * FROM stp_kitap_bilgi(123456780);

-- Fonksiyonu Silme
-- Fonksiyonu silmek için aşağıdaki komutu kullanabilirsiniz:
-- DROP FUNCTION stp_kitap_bilgi;

-- Fonksiyonu Değiştirme
-- Fonksiyonu değiştirmek için yeniden tanımlama yapılır.
CREATE OR REPLACE FUNCTION stp_kitap_bilgi()
RETURNS TABLE(isbn INT, kitap_adi TEXT, sayfa_sayisi INT) AS $$
BEGIN
    -- Güncellenmiş sorgu: ISBN parametresi kaldırıldı, tüm kitap bilgilerini getirir
    RETURN QUERY
    SELECT isbn, kitap_adi, sayfa_sayisi
    FROM tbl_kitaplar;
END;
$$ LANGUAGE plpgsql;

-- Güncellenmiş fonksiyonu çalıştırma
SELECT * FROM stp_kitap_bilgi();
