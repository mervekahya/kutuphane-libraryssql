-- Alt sorgularla işlemlerde EXISTS kullanımı
SELECT * FROM tbl_kitaplar
WHERE sayfa_sayisi > (
    SELECT MIN(sayfa_sayisi)
    FROM tbl_kitaplar
    GROUP BY kitap_adi
    HAVING kitap_adi LIKE '%aa%'
);

SELECT * FROM tbl_kitaplar
WHERE sayfa_sayisi > ALL (
    SELECT sayfa_sayisi
    FROM tbl_kitap_yazar ky
    INNER JOIN tbl_kitaplar k ON k.isbn = ky.isbn
    INNER JOIN tbl_yazarlar y ON y.yazar_no = ky.yazar_no
    WHERE y.yazar_adi LIKE '%ç%' AND y.yazar_soyadi LIKE '%as%'
);

SELECT * FROM tbl_yazarlar
WHERE NOT EXISTS (
    SELECT 1
    FROM tbl_kitap_yazar
    WHERE tbl_yazarlar.yazar_no = tbl_kitap_yazar.yazar_no
);

SELECT * FROM tbl_kategoriler
WHERE NOT EXISTS (
    SELECT 1
    FROM tbl_kitap_kategori
    WHERE tbl_kategoriler.kategori_no = tbl_kitap_kategori.kategori_no
);

SELECT * FROM tbl_kitaplar k
WHERE NOT EXISTS (
    SELECT 1
    FROM tbl_emanet e
    WHERE e.isbn = k.isbn
);

SELECT * FROM tbl_yazarlar y
WHERE NOT EXISTS (
    SELECT 1
    FROM tbl_kitap_yazar ky
    WHERE y.yazar_no = ky.yazar_no
    GROUP BY ky.yazar_no
    HAVING COUNT(*) >= 5
);

-- Bilgisayar kategorisinde kitap yazan yazarlar
SELECT * FROM tbl_yazarlar y
WHERE EXISTS (
    SELECT 1
    FROM tbl_kitap_yazar ky
    INNER JOIN tbl_kitap_kategori kk ON kk.isbn = ky.isbn
    INNER JOIN tbl_kategoriler ka ON ka.kategori_no = kk.kategori_no
    WHERE ka.kategori_adi = 'Bilgisayar' AND y.yazar_no = ky.yazar_no
);

-- Aynı adrese sahip üyelerin olup olmadığının kontrolü
SELECT DISTINCT 'Aynı adrese sahip üye vardır'
WHERE EXISTS (
    SELECT 1
    FROM tbl_uyeler
    GROUP BY adres_no
    HAVING COUNT(*) > 1
);

-- Kitap adı ve yazar bilgisi
SELECT kitap_adi, (
    SELECT yazar_adi
    FROM tbl_yazarlar
    INNER JOIN tbl_kitap_yazar ON tbl_kitap_yazar.yazar_no = tbl_yazarlar.yazar_no
    WHERE tbl_kitaplar.isbn = tbl_kitap_yazar.isbn
) AS "Yazar"
FROM tbl_kitaplar;

-- Kitapların kategorilerini listeleyen SQL sorgusu
SELECT (
    SELECT kategori_adi
    FROM tbl_kategoriler
    WHERE kategori_no = tbl_kitap_kategori.kategori_no
) AS "Kategori",
(
    SELECT kitap_adi
    FROM tbl_kitaplar
    WHERE isbn = tbl_kitap_kategori.isbn
) AS "Kitap"
FROM tbl_kitap_kategori
ORDER BY kategori;

-- Turhal kütüphanesinde bulunan yazarların kitap sayısını listeleyen SQL sorgusu
SELECT yazar_adi, yazar_soyadi,
    (
        SELECT SUM(adet)
        FROM tbl_kitap_yazar
        INNER JOIN tbl_kitap_kutuphane ON tbl_kitap_kutuphane.isbn = tbl_kitap_yazar.isbn
        WHERE yazar_no = tbl_yazarlar.yazar_no
        AND kutuphane_no = (
            SELECT kutuphane_no
            FROM tbl_kutuphane
            WHERE kutuphane_ismi = 'Turhal'
        )
    ) AS "Kitap Sayısı"
FROM tbl_yazarlar
ORDER BY yazar_adi;

-- Her üyenin kütüphanelerini kaç kez kullandığını listeleyen SQL sorgusu
SELECT uye_adi, uye_soyadi,
    (
        SELECT COUNT(*)
        FROM tbl_emanet
        WHERE tbl_uyeler.uye_no = tbl_emanet.uye_no
    ) AS "Alınan Kitap Sayısı"
FROM tbl_uyeler;

-- Yazarların en fazla kitap sayısına sahip yazarın kitap sayısı
SELECT MAX(yzr.kitap_sayisi) AS en_fazla_kitap
FROM (
    SELECT COUNT(*) AS kitap_sayisi
    FROM tbl_kitap_yazar
    GROUP BY yazar_no
) yzr;

-- Adres değişikliği
UPDATE tbl_uyeler SET adres_no = 7 WHERE uye_no = 3;

-- Tokat ikamet eden üyelerin ad soyad bilgilerini listeleyen SQL sorgusu
SELECT uye_adi, uye_soyadi
FROM tbl_uyeler
INNER JOIN (
    SELECT adres_no
    FROM tbl_adresler
    WHERE sehir LIKE '%Tokat%'
) adres ON adres.adres_no = tbl_uyeler.adres_no;

-- Ortalama sayfa sayısından daha fazla sayfaya sahip olan kitapları listeleyen SQL sorgusu
SELECT * FROM tbl_kitaplar
WHERE sayfa_sayisi > (
    SELECT AVG(sayfa_sayisi)
    FROM tbl_kitaplar
);

-- Gruplandırarak sorgulama
SELECT kategori_no, COUNT(isbn) AS "Kitap Sayısı"
FROM tbl_kitap_kategori
GROUP BY kategori_no;

SELECT uye_no, COUNT(kutuphane_no) AS "Kullanım Adedi"
FROM tbl_emanet
GROUP BY uye_no
ORDER BY "Kullanım Adedi";

SELECT COUNT(isbn) AS adet, yazar_no
FROM tbl_kitap_yazar
GROUP BY yazar_no;

SELECT kutuphane_no, AVG(EXTRACT(DAY FROM (teslim_tarihi - emanet_tarihi))) AS "Emanet Süresi"
FROM tbl_emanet
GROUP BY kutuphane_no;

SELECT kutuphane_no, COUNT(isbn) AS "Kitap Sayısı"
FROM tbl_kitap_kutuphane
WHERE adet = 1
GROUP BY kutuphane_no;

SELECT kutuphane_no, SUM(adet) AS "Toplam Kitap Sayısı"
FROM tbl_kitap_kutuphane
GROUP BY kutuphane_no;

SELECT kutuphane_no, COUNT(isbn) AS "Kitap Sayısı"
FROM tbl_kitap_kutuphane
GROUP BY kutuphane_no;

SELECT adres_no, COUNT(*) AS "Adres Sayısı"
FROM tbl_uyeler
GROUP BY adres_no
HAVING COUNT(*) > 1;

SELECT isbn, COUNT(*)
FROM tbl_kitap_kategori
GROUP BY isbn
HAVING COUNT(*) >= 1;

SELECT COUNT(yazar_no), isbn
FROM tbl_kitap_yazar
GROUP BY isbn
HAVING COUNT(yazar_no) = 1;

SELECT isbn, COUNT(uye_no) AS "Emanet Sayısı"
FROM tbl_emanet
GROUP BY isbn
HAVING COUNT(uye_no) > 3;

SELECT kategori_no, COUNT(*) AS "Kitap Sayısı"
FROM tbl_kitap_kategori
GROUP BY kategori_no
HAVING COUNT(*) > 3;

SELECT kategori_no, COUNT(isbn) AS "Kitap Sayısı"
FROM tbl_kitap_kategori
GROUP BY kategori_no;

SELECT isbn, uye_no, COUNT(uye_no) AS "Üye Adedi"
FROM tbl_emanet
GROUP BY isbn, uye_no;

SELECT kutuphane_no, isbn
FROM tbl_emanet
GROUP BY kutuphane_no, isbn
ORDER BY kutuphane_no, isbn;

-- Birden fazla tablo üzerinde sorgulamalar
SELECT isbn, yazar_adi, yazar_soyadi
FROM tbl_kitap_yazar ky
INNER JOIN tbl_yazarlar y ON ky.yazar_no = y.yazar_no;

SELECT isbn, kategori_adi
FROM tbl_kitap_kategori kk
INNER JOIN tbl_kategoriler k ON kk.kategori_no = k.kategori_no;

SELECT isbn, yazar_adi, yazar_soyadi
FROM tbl_yazarlar y
INNER JOIN tbl_kitap_yazar ky ON y.yazar_no = ky.yazar_no
ORDER BY yazar_adi, yazar_soyadi;

SELECT kitap_adi, kk.isbn, kk.kutuphane_no
FROM tbl_kitaplar
INNER JOIN tbl_kitap_kutuphane kk ON tbl_kitaplar.isbn = kk.isbn;

SELECT kategori_adi, SUM(adet) AS "Kitap Sayısı"
FROM tbl_kitap_kutuphane kk
INNER JOIN tbl_kitap_kategori kkt ON kk.isbn = kkt.isbn
INNER JOIN tbl_kategoriler kkg ON kkg.kategori_no = kkt.kategori_no
GROUP BY kategori_adi;

SELECT y.yazar_adi, y.yazar_soyadi, SUM(sayfa_sayisi) AS "Sayfa Sayısı"
FROM tbl_yazarlar y
INNER JOIN tbl_kitap_yazar ky ON ky.yazar_no = y.yazar_no
INNER JOIN tbl_kitaplar k ON
