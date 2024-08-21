CREATE DATABASE db_kutuphane;

CREATE TABLE tbl_uyeler (
    uye_no INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    uye_adi NVARCHAR(50) NOT NULL,
    uye_soyadi NVARCHAR(50) NOT NULL,
    cinsiyet NVARCHAR(5),
    telefon INT NOT NULL UNIQUE,
    e_posta NVARCHAR(50) UNIQUE,
    adres_no INT
);

CREATE TABLE tbl_emanet (
    emanet_no INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    uye_no INT NOT NULL,
    kutuphane_no INT NOT NULL,
    emanet_tarihi DATETIME,
    teslim_tarihi DATETIME
);

CREATE TABLE tbl_yazarlar (
    yazar_no INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    yazar_adi VARCHAR(20),
    yazar_soyadi VARCHAR(20)
);

CREATE TABLE tbl_kutuphane (
    kutuphane_no INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    kutuphane_ismi VARCHAR(20),
    aciklama VARCHAR(20),
    adres_no INT
);

CREATE TABLE tbl_kitap_kutuphane (
    kutuphane_no INT NOT NULL,
    adet INT,
    CONSTRAINT tbl_kitap_kutuphane_pk PRIMARY KEY (kutuphane_no)
);

CREATE TABLE tbl_kitap_yazar (
    yazar_no INT NOT NULL,
    CONSTRAINT tbl_kitap_yazar_pk PRIMARY KEY (yazar_no)
);

CREATE TABLE tbl_kitap_kategori (
    kategori_no INT NOT NULL,
    CONSTRAINT ktp_ktg_pk PRIMARY KEY (kategori_no)
);

CREATE TABLE tbl_adresler (
    adres_no INT IDENTITY(1,1) PRIMARY KEY,
    cadde VARCHAR(20),
    mahalle VARCHAR(20),
    bina_no INT,
    sehir VARCHAR(20),
    posta_kodu INT,
    ulke VARCHAR(20)
);

CREATE TABLE tbl_kitaplar (
    kitap_adi VARCHAR(20),
    yayin_tarihi DATETIME,
    sayfa_sayisi INT
);

CREATE TABLE tbl_kategoriler (
    kategori_no INT IDENTITY(1,1) PRIMARY KEY,
    kategori_adi VARCHAR(20)
);

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
    FOREIGN KEY (kutuphane_no) REFERENCES tbl_kutuphane (kutuphane_no) 
    ON DELETE CASCADE;

ALTER TABLE tbl_kutuphane 
    ADD CONSTRAINT kutuphane_adresler_fk 
    FOREIGN KEY (adres_no) REFERENCES tbl_adresler (adres_no);
