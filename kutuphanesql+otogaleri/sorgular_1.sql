-- Veri tabanı oluşturulması
CREATE DATABASE db_kutuphane;

-- Veritabanına bağlan
\c db_kutuphane;

-- Tablo oluşturma işlemleri
CREATE TABLE tbl_uyeler (
    uye_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    uye_adi VARCHAR(50) NOT NULL, -- `nvarchar` yerine `VARCHAR` kullanıldı
    uye_soyadi VARCHAR(50) NOT NULL, -- `nvarchar` yerine `VARCHAR` kullanıldı
    cinsiyet VARCHAR(5),
    telefon BIGINT NOT NULL UNIQUE, -- `int` yerine `BIGINT` kullanıldı
    e_posta VARCHAR(50) UNIQUE, -- `nvarchar` yerine `VARCHAR` kullanıldı
    adres_no INT
);

CREATE TABLE tbl_emanet (
    emanet_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    isbn BIGINT NOT NULL, -- `int` yerine `BIGINT` kullanıldı
    uye_no INT NOT NULL,
    kutuphane_no INT NOT NULL,
    emanet_tarihi TIMESTAMP, -- `datetime` yerine `TIMESTAMP` kullanıldı
    teslim_tarihi TIMESTAMP -- `datetime` yerine `TIMESTAMP` kullanıldı
);

CREATE TABLE tbl_yazarlar (
    yazar_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    yazar_adi VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    yazar_soyadi VARCHAR(20) -- `varchar` yerine `VARCHAR` kullanıldı
);

CREATE TABLE tbl_kutuphane (
    kutuphane_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    kutuphane_ismi VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    aciklama VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    adres_no INT
);

CREATE TABLE tbl_kitap_kutuphane (
    kutuphane_no INT NOT NULL,
    isbn BIGINT NOT NULL, -- `int` yerine `BIGINT` kullanıldı
    adet INT,
    PRIMARY KEY(kutuphane_no, isbn)
);

CREATE TABLE tbl_kitap_yazar (
    isbn BIGINT NOT NULL, -- `int` yerine `BIGINT` kullanıldı
    yazar_no INT NOT NULL,
    PRIMARY KEY(isbn, yazar_no)
);

CREATE TABLE tbl_kitap_kategori (
    isbn BIGINT NOT NULL, -- `int` yerine `BIGINT` kullanıldı
    kategori_no INT NOT NULL, 
    PRIMARY KEY(isbn, kategori_no)
);

CREATE TABLE tbl_adresler (
    adres_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    cadde VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    mahalle VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    bina_no INT,
    sehir VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    posta_kodu INT,
    ulke VARCHAR(20) -- `varchar` yerine `VARCHAR` kullanıldı
);

CREATE TABLE tbl_kitaplar (
    isbn BIGINT PRIMARY KEY, -- `int` yerine `BIGINT` kullanıldı
    kitap_adi VARCHAR(20), -- `varchar` yerine `VARCHAR` kullanıldı
    yayin_tarihi TIMESTAMP, -- `datetime` yerine `TIMESTAMP` kullanıldı
    sayfa_sayisi INT
);

CREATE TABLE tbl_kategoriler (
    kategori_no SERIAL PRIMARY KEY, -- `SERIAL` yerine `identity(1,1)` kullanıldı
    kategori_adi VARCHAR(20) -- `varchar` yerine `VARCHAR` kullanıldı
);

-- Yabancı anahtar tanımlamaları ve cascade işlemleri
ALTER TABLE tbl_uyeler 
ADD CONSTRAINT adresler_uyeler_fk
    FOREIGN KEY (adres_no) REFERENCES tbl_adresler (adres_no)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE tbl_emanet 
ADD CONSTRAINT uyeler_emanet_fk
    FOREIGN KEY (uye_no) REFERENCES tbl_uyeler (uye_no)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_emanet 
ADD CONSTRAINT kutuphane_emanet_fk
    FOREIGN KEY (kutuphane_no) REFERENCES tbl_kutuphane (kutuphane_no)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_kitap_kategori 
ADD CONSTRAINT kategoriler_kitap_kategori_fk
    FOREIGN KEY (kategori_no) REFERENCES tbl_kategoriler (kategori_no)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_kitap_yazar 
ADD CONSTRAINT yazarlar_kitap_yazar_fk
    FOREIGN KEY (yazar_no) REFERENCES tbl_yazarlar (yazar_no)
    ON DELETE CASCADE;

ALTER TABLE tbl_kitap_kutuphane 
ADD CONSTRAINT kitaplar_kitap_kutuphane_fk
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn)
    ON DELETE CASCADE;

ALTER TABLE tbl_kutuphane 
ADD CONSTRAINT kutuphane_adresler_fk
    FOREIGN KEY (adres_no) REFERENCES tbl_adresler (adres_no);

ALTER TABLE tbl_emanet 
ADD CONSTRAINT emanet_kitaplar_fk
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_kitap_kategori 
ADD CONSTRAINT kitap_kategori_kitaplar_fk
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_kitap_yazar 
ADD CONSTRAINT kitap_yazar_kitaplar_fk
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE tbl_kitap_kutuphane 
ADD CONSTRAINT kitap_kutuphane_kutuphane_fk
    FOREIGN KEY (kutuphane_no) REFERENCES tbl_kutuphane(kutuphane_no)
    ON DELETE CASCADE;

-- Değişiklikler:
-- 1. `identity(1,1)` yerine PostgreSQL'de `SERIAL` veri türü kullanıldı.
-- 2. `nvarchar` yerine PostgreSQL'de `VARCHAR` veri türü kullanıldı.
-- 3. `datetime` yerine PostgreSQL'de `TIMESTAMP` veri türü kullanıldı.
-- 4. `int` yerine `BIGINT` kullanıldı, çünkü `INT` yeterli olmayabilir.
