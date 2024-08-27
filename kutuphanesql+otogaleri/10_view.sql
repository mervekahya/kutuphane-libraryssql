-- Görünümü oluştur
CREATE VIEW vw_yazarkitapSayfa AS
SELECT 
    y.yazar_adi,
    y.yazar_soyadi,
    k.kitap_adi,
    SUM(k.sayfa_sayisi) AS "sayfa sayisi"
FROM 
    tbl_yazarlar y
INNER JOIN 
    tbl_kitap_yazar ky ON ky.yazar_no = y.yazar_no
INNER JOIN 
    tbl_kitaplar k ON k.isbn = ky.isbn
GROUP BY 
    y.yazar_adi,
    y.yazar_soyadi,
    k.kitap_adi;
