-- Veritabanı oluşturma
CREATE DATABASE db_otogaleri;

-- Veritabanını kullanma
\c db_otogaleri

-- Tablo tanımlamaları
CREATE TABLE tbl_arac (
    arac_no SERIAL PRIMARY KEY,
    model VARCHAR(20),
    marka VARCHAR(20),
    plaka VARCHAR(20),
    fiyati INT
);

CREATE TABLE tbl_musteri (
    musteri_no SERIAL PRIMARY KEY,
    ad VARCHAR(20),
    soyad VARCHAR(20),
    adres VARCHAR(20),
    telefon INT
);

CREATE TABLE tbl_satıs (
    satis_no SERIAL PRIMARY KEY,
    musteri_no INT,
    arac_no INT,
    satis_tarih TIMESTAMP,
    fiyati INT,
    FOREIGN KEY (musteri_no) REFERENCES tbl_musteri(musteri_no),
    FOREIGN KEY (arac_no) REFERENCES tbl_arac(arac_no)
);

CREATE TABLE tbl_alım (
    alim_no SERIAL PRIMARY KEY,
    musteri_no INT,
    arac_no INT,
    alim_tarih TIMESTAMP,
    fiyati INT,
    FOREIGN KEY (musteri_no) REFERENCES tbl_musteri(musteri_no),
    FOREIGN KEY (arac_no) REFERENCES tbl_arac(arac_no)
);

-- Tabloya veri ekleme
INSERT INTO tbl_musteri (ad, soyad, adres, telefon) VALUES 
('Turgut', 'Özseven', 'Meram/Konya', 12345),
('Mustafa', 'Çağlayan', 'Meram/Konya', 99345),
('Ayşe', 'Uçar', 'Taşova/Amasya', 88345),
('Elif', 'Kurt', 'Beşiktaş/Istanbul', 77345),
('Murat', 'Beyaz', 'Turhal/Tokat', 66345),
('Bület', 'Ayar', 'Turhal/Tokat', 55345),
('Ahmet', 'Kara', 'Zile/Tokat', 33345);

INSERT INTO tbl_arac (model, marka, plaka, fiyati) VALUES
('Fiat', '60TT6060', 16000),
('Renault', '60TT6061', 14000),
('Ford', '60TT6062', 12000),
('Volkswagen', '60TT6063', 26000),
('Opel', '60TT6064', 17000);

INSERT INTO tbl_satıs (musteri_no, arac_no, satis_tarih, fiyati) VALUES
(3, 26, '2010-05-04', 16000),
(4, 27, '2010-06-05', 14000),
(9, 29, '2010-07-02', 26000);

INSERT INTO tbl_alım (musteri_no, arac_no, alim_tarih, fiyati) VALUES
(3, 26, '2010-05-04', 16000),
(4, 27, '2010-06-05', 14000),
(9, 29, '2010-07-02', 26000);

-- Sorgular

-- En yüksek fiyatlı satışları ve ilgili araçları ve müşterileri gösterir
SELECT a.model, a.marka, a.fiyati, m.ad, m.soyad, s.satis_tarih
FROM tbl_satıs s
INNER JOIN tbl_arac a ON s.arac_no = a.arac_no
INNER JOIN tbl_musteri m ON s.musteri_no = m.musteri_no
WHERE s.fiyati = (SELECT MAX(fiyati) FROM tbl_satıs);

-- Güncelleme ve Değişiklik
-- Her aracın modelini INT türüne çevirir (bu işlem uygun olmayabilir, dikkat!)
-- ALTER TABLE tbl_arac ALTER COLUMN model TYPE INT;

-- Tablo üzerindeki kısıtlamalar
-- PostgreSQL’de CHECK kısıtlamaları regex desteklemez. Onları kaldırıyoruz.
-- ALTER TABLE tbl_arac DROP CONSTRAINT chk_model;
-- ALTER TABLE tbl_arac DROP CONSTRAINT chk_plaka;
-- ALTER TABLE tbl_arac DROP CONSTRAINT chk_plaka2;

-- Sorgular
SELECT model, marka, fiyati FROM tbl_arac WHERE model <= 2004;
SELECT model, marka, fiyati FROM tbl_arac WHERE model BETWEEN 2000 AND 2900;
SELECT * FROM tbl_satıs WHERE satis_tarih > '2010-05-01' AND fiyati > 10000;
SELECT * FROM tbl_musteri WHERE ad ILIKE '%y%' AND adres = 'Turhal';
SELECT arac_no, model, plaka, fiyati FROM tbl_arac WHERE (marka = 'Fiat' OR marka = 'Opel') AND (model > 2000);
SELECT * FROM tbl_musteri ORDER BY ad;
SELECT * FROM tbl_arac ORDER BY model DESC, fiyati ASC;
SELECT arac_no, satis_tarih, fiyati AS "Satış fiyatı" FROM tbl_satıs;
SELECT * FROM tbl_arac WHERE fiyati > 16000 ORDER BY fiyati ASC;
SELECT * FROM tbl_satıs WHERE fiyati > 10000 OR musteri_no = 4;
SELECT * FROM tbl_satıs WHERE satis_tarih >= '2010-05-01';
SELECT alim_tarih, fiyati, arac_no FROM tbl_alım
WHERE alim_tarih BETWEEN '2010-01-02' AND '2010-06-01' AND fiyati > 10000
ORDER BY alim_tarih, fiyati ASC;
SELECT * FROM tbl_satıs WHERE fiyati BETWEEN 10000 AND 20000 AND musteri_no IN (4, 2);
SELECT * FROM tbl_satıs WHERE musteri_no IN (SELECT musteri_no FROM tbl_musteri WHERE adres ILIKE '%turhal%');
SELECT * FROM tbl_musteri WHERE adres ILIKE '%tokat%' AND telefon::TEXT ILIKE '%6%';
SELECT adres, telefon FROM tbl_musteri WHERE ad ILIKE '%A%';
SELECT model, marka, fiyati FROM tbl_arac WHERE marka IN ('Opel', 'Fiat') ORDER BY marka ASC;
SELECT * FROM tbl_arac WHERE model IN (1998, 2005, 2007);

-- Aritmetik Operatörler ve Fonksiyonlar
SELECT *, fiyati * 0.20 AS "%20 Artırılmış Fiyat" FROM tbl_arac;
SELECT *, EXTRACT(YEAR FROM CURRENT_DATE) - model AS "Yeni Tarih" FROM tbl_arac WHERE EXTRACT(YEAR FROM CURRENT_DATE) - model <= 3;
SELECT ad || ' ' || soyad AS "Ad Soyad" FROM tbl_musteri ORDER BY "Ad Soyad";
SELECT UPPER(SUBSTRING(ad, 1, 1)) || '.' || soyad AS adSoyad FROM tbl_musteri;
SELECT * FROM tbl_alım ORDER BY fiyati DESC, EXTRACT(MONTH FROM alim_tarih) ASC;
SELECT UPPER(SUBSTRING(ad, 1, 1)) || SUBSTRING(soyad, 1, 5) AS "Ad Soyad" FROM tbl_musteri WHERE LENGTH(soyad) > 5;
SELECT SUBSTRING(adres FROM POSITION('/' IN adres) + 1) AS "İl" FROM tbl_musteri ORDER BY "İl" ASC;
SELECT * FROM tbl_satıs WHERE (EXTRACT(YEAR FROM satis_tarih) = 2008 OR EXTRACT(YEAR FROM satis_tarih) = 2010) AND (EXTRACT(MONTH FROM satis_tarih) = 3 OR EXTRACT(MONTH FROM satis_tarih) = 4);
SELECT SUM(fiyati) AS "2008 ve 2010 Yılları Arası 4. ve 3. Ay Toplam Fiyat" FROM tbl_satıs WHERE (EXTRACT(YEAR FROM satis_tarih) = 2008 OR EXTRACT(YEAR FROM satis_tarih) = 2010) AND (EXTRACT(MONTH FROM satis_tarih) = 3 OR EXTRACT(MONTH FROM satis_tarih) = 4);
SELECT SUM(fiyati) AS "Fiyat", AVG(fiyati) AS "Ortalama", (SUM(fiyati) - AVG(fiyati)) AS "Toplam - Ortalama = Fark" FROM tbl_satıs WHERE (EXTRACT(YEAR FROM satis_tarih) = 2008 OR EXTRACT(YEAR FROM satis_tarih) = 2010) AND (EXTRACT(MONTH FROM satis_tarih) = 1 OR EXTRACT(MONTH FROM satis_tarih) = 8);
SELECT model, marka, fiyati FROM tbl_arac WHERE fiyati = (SELECT MAX(fiyati) FROM tbl_arac);
SELECT MAX(fiyati) - MIN(fiyati) FROM tbl_arac;
SELECT * FROM tbl_arac WHERE fiyati <= (SELECT MAX(fiyati) - MIN(fiyati) FROM tbl_arac);
SELECT COUNT(*) FROM tbl_alım WHERE EXTRACT(YEAR FROM alim_tarih) = 2010;
SELECT * FROM tbl_satıs WHERE satis_tarih BETWEEN '2010-03-01' AND '2010-12-31';
SELECT * FROM tbl_alım WHERE EXTRACT(MONTH FROM alim_tarih) > 6;
SELECT TO_CHAR(satis_tarih, 'Day') AS "Satılan Günler", TO_CHAR(satis_tarih, 'Day') FROM tbl_satıs;
