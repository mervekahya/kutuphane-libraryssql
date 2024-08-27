-- Tablo oluşturma işlemleri
CREATE TABLE tbl_adresler (
    adres_no SERIAL PRIMARY KEY,
    cadde VARCHAR(20),
    mahalle VARCHAR(20),
    bina_no INT,
    sehir VARCHAR(20),
    posta_kodu INT,
    ulke VARCHAR(20)
);

CREATE TABLE tbl_uyeler (
    uye_no SERIAL PRIMARY KEY,
    uye_adi VARCHAR(50) NOT NULL,
    uye_soyadi VARCHAR(50) NOT NULL,
    cinsiyet CHAR(1),
    telefon BIGINT NOT NULL UNIQUE,
    e_posta VARCHAR(50) UNIQUE,
    adres_no INT,
    FOREIGN KEY (adres_no) REFERENCES tbl_adresler (adres_no) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE tbl_emanet (
    emanet_no SERIAL PRIMARY KEY,
    isbn BIGINT NOT NULL,
    uye_no INT NOT NULL,
    kutuphane_no INT NOT NULL,
    emanet_tarihi TIMESTAMP,
    teslim_tarihi TIMESTAMP,
    FOREIGN KEY (uye_no) REFERENCES tbl_uyeler (uye_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (kutuphane_no) REFERENCES tbl_kutuphane (kutuphane_no) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_yazarlar (
    yazar_no SERIAL PRIMARY KEY,
    yazar_adi VARCHAR(20),
    yazar_soyadi VARCHAR(20)
);

CREATE TABLE tbl_kutuphane (
    kutuphane_no SERIAL PRIMARY KEY,
    kutuphane_ismi VARCHAR(20),
    aciklama VARCHAR(20),
    adres_no INT,
    FOREIGN KEY (adres_no) REFERENCES tbl_adresler (adres_no)
);

CREATE TABLE tbl_kitap_kutuphane (
    kutuphane_no INT NOT NULL,
    isbn BIGINT NOT NULL,
    adet INT,
    PRIMARY KEY (kutuphane_no, isbn),
    FOREIGN KEY (kutuphane_no) REFERENCES tbl_kutuphane (kutuphane_no) ON DELETE CASCADE,
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn) ON DELETE CASCADE
);

CREATE TABLE tbl_kitap_yazar (
    isbn BIGINT NOT NULL,
    yazar_no INT NOT NULL,
    PRIMARY KEY (isbn, yazar_no),
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (yazar_no) REFERENCES tbl_yazarlar (yazar_no) ON DELETE CASCADE
);

CREATE TABLE tbl_kitap_kategori (
    isbn BIGINT NOT NULL,
    kategori_no INT NOT NULL,
    PRIMARY KEY (isbn, kategori_no),
    FOREIGN KEY (isbn) REFERENCES tbl_kitaplar (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (kategori_no) REFERENCES tbl_kategoriler (kategori_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_adresler (
    adres_no SERIAL PRIMARY KEY,
    cadde VARCHAR(20),
    mahalle VARCHAR(20),
    bina_no INT,
    sehir VARCHAR(20),
    posta_kodu INT,
    ulke VARCHAR(20)
);

CREATE TABLE tbl_kitaplar (
    isbn BIGINT PRIMARY KEY,
    kitap_adi VARCHAR(20),
    yayin_tarihi TIMESTAMP,
    sayfa_sayisi INT
);

CREATE TABLE tbl_kategoriler (
    kategori_no SERIAL PRIMARY KEY,
    kategori_adi VARCHAR(20)
);

-- Tabloya veri ekleme işlemleri
INSERT INTO tbl_adresler (cadde, mahalle, bina_no, sehir, posta_kodu, ulke)
VALUES ('Orhangazi', 'Esentepe', 5, 'Tokat', 60100, 'Türkiye'),
       ('Sivas', 'Kemer', 34, 'Tokat', 60100, 'Türkiye'),
       (NULL, 'Evrenköy', 21, 'Tokat', 60100, 'Türkiye'),
       (NULL, 'Cumhuriyet', 56, 'Tokat', 60100, 'Türkiye'),
       ('Atatürk', 'Barbaros', 142, 'İstanbul', 34200, 'Türkiye'),
       ('C.Gürsel', 'Tuna', 65, 'İzmir', 35600, 'Türkiye'),
       ('Sipahi', 'Şamlar', 85, 'Amasya', 05200, 'Türkiye'),
       (NULL, 'Kızılay', 114, 'Ankara', 06400, 'Türkiye');

INSERT INTO tbl_uyeler (uye_adi, uye_soyadi, cinsiyet, adres_no, telefon, e_posta)
VALUES ('Ayşe', 'Kara', 'F', 1, 123456789, 'ak@mail.com'),
       ('Ali', 'Uçar', 'M', 1, 123456780, 'au@mail.com'),
       ('Ahmet', 'Davut', 'M', 1, 123456781, 'ad@mail.com'),
       ('Murat', 'Sönmez', 'M', 1, 123456782, 'ms@mail.com'),
       ('Burak', 'Torun', 'M', 1, 123456783, 'bto@mail.com'),
       ('Ayla', 'Yılmaz', 'F', 1, 123456784, 'ay@mail.com'),
       ('Mustafa', 'Demir', 'M', 1, 123456785, 'md@mail.com'),
       ('Turgut', 'Özseven', 'M', 1, 123456786, 'to@mail.com'),
       ('Elif', 'Uymaz', 'F', 1, 123456787, 'eu@mail.com');

INSERT INTO tbl_kutuphane (kutuphane_ismi, aciklama, adres_no)
VALUES ('Merkez', 'Merkez kütüphane', 1),
       ('Zile', 'Zile kütüphane', 3),
       ('Turhal', 'Turhal kütüphane', 4),
       ('Amasya', 'Amasya kütüphane', 7);

INSERT INTO tbl_kategoriler (kategori_adi)
VALUES ('Bilgisayar'),
       ('Ekonomi'),
       ('Eğitim'),
       ('Edebiyat'),
       ('Matematik'),
       ('Psikoloji'),
       ('Kültür'),
       ('Muhasebe'),
       ('Bilim'),
       ('Diğer');

INSERT INTO tbl_yazarlar (yazar_adi, yazar_soyadi)
VALUES ('Turgut', 'Özseven'),
       ('Ebubekir', 'Yaşar'),
       ('Çebi', 'Bal'),
       ('Fahri', 'Özkan'),
       ('Murat', 'Can'),
       ('Ötügen', 'Sengen'),
       ('Ali', 'Feyiz'),
       ('Ramazan', 'İnal'),
       ('Gökhan', 'Çuval'),
       ('Salih', 'Özkan'),
       ('Christian', 'Marazzi'),
       ('Hatice', 'Ergin'),
       ('Armağan', 'Yıldız'),
       ('Rıza', 'Özel'),
       ('Anne', 'Taylor'),
       ('Paul', 'Lunda'),
       ('Kathryn', 'Wilkinson'),
       ('Turgut', 'Akıl'),
       ('Mehmet', 'Asi');

INSERT INTO tbl_kitaplar (isbn, kitap_adi, yayin_tarihi, sayfa_sayisi)
VALUES (123456780, 'Algoritma', '2010-01-01', 300),
       (123456781, 'Internet 1', '2000-02-09', 200),
       (123456782, 'Internet 2', '2011-01-05', 350),
       (123456783, 'Bilgisayar 1', '2019-06-05', 109),
       (123456784, 'Muhasebe', '2013-03-03', 360),
       (123456785, 'Sermaye ve Dil', '2009-07-07', 240),
       (123456786, 'Gelişim Psikolojisi', '2017-06-06', 167),
       (123456787, 'Şifreler', '2010-01-01', 753),
       (123456788, 'Ticari Matematik', '2012-12-12', 399);

INSERT INTO tbl_kitap_kutuphane (kutuphane_no, isbn, adet)
VALUES (1, 123456780, 3),
       (2, 123456781, 4),
       (3, 123456782, 5),
       (4, 123456783, 6),
       (1, 123456784, 3),
       (2, 123456785, 2),
       (3, 123456786, 36),
       (4, 123456787, 38),
       (1, 123456788, 9);

INSERT INTO tbl_emanet (isbn, uye_no, kutuphane_no, emanet_tarihi, teslim_tarihi)
VALUES (123456789, 3, 3, '2009-10-12', '2009-10-12'),
       (123456788, 5, 1, '2009-11-09', '2009-11-09'),
       (123456787, 1, 1, '2012-06-05', '2012-06-05'),
       (123456786, 7, 3, '2013-04-12', '2013-04-12'),
       (123456785, 4, 2, '2014-01-15', '2014-01-15'),
       (123456784, 2, 4, '2016-07-07', '2016-07-07'),
       (123456783, 8, 2, '2018-05-10', '2018-05-10'),
       (123456782, 6, 2, '2020-03-21', '2020-03-21'),
       (123456781, 1, 4, '2021-02-28', '2021-02-28'),
       (123456780, 3, 1, '2023-01-30', '2023-01-30');

INSERT INTO tbl_kitap_yazar (isbn, yazar_no)
VALUES (123456780, 9),
       (123456781, 11),
       (123456782, 12),
       (123456783, 13),
       (123456784, 14),
       (123456785, 15),
       (123456786, 10),
       (123456787, 8),
       (123456788, 1);

INSERT INTO tbl_kitap_kategori (isbn, kategori_no)
VALUES (123456780, 1),
       (123456781, 2),
       (123456782, 3),
       (123456783, 4),
       (123456784, 5),
       (123456785, 6),
       (123456786, 7),
       (123456787, 8),
       (123456788, 9);
