-- PostgreSQL'de fonksiyon oluşturma
CREATE OR REPLACE FUNCTION fn_emanetSayisi(uye_no INT)
RETURNS INT AS $$
DECLARE
    toplam_emanet INT;
BEGIN
    -- Toplam emanet sayısını hesapla
    SELECT COUNT(*) INTO toplam_emanet
    FROM tbl_emanet
    WHERE uye_no = uye_no;
    
    -- Hesaplanan değeri döndür
    RETURN toplam_emanet;
END;
$$ LANGUAGE plpgsql;

-- Fonksiyonu test etme
SELECT fn_emanetSayisi(3);
