-- Tetikleyici fonksiyonunu oluştur
CREATE OR REPLACE FUNCTION fn_update_emanet_tarihi()
RETURNS TRIGGER AS $$
BEGIN
    -- Yeni kitap eklenmişse, emanet_tarihi'ni güncelle
    UPDATE tbl_emanet
    SET emanet_tarihi = CURRENT_TIMESTAMP
    WHERE emanet_tarihi IS NULL;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Tetikleyiciyi oluştur
CREATE TRIGGER tgr_kitapEmanet
AFTER INSERT ON tbl_kitaplar
FOR EACH ROW
EXECUTE FUNCTION fn_update_emanet_tarihi();
