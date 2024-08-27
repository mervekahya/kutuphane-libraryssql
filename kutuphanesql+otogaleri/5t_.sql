-- Değişken Tanımlama ve Kullanımı
DO $$
DECLARE
    sayi INT := 200;
BEGIN
    -- Değişkeni kullanarak sorgu
    RAISE NOTICE '%', (SELECT * FROM tbl_kitaplar WHERE sayfa_sayisi = sayi);

    -- Hata ve Satır Sayısı İzleme
    -- PostgreSQL'de @@ERROR ve @@ROWCOUNT'e karşılık doğrudan bir eşdeğer bulunmamaktadır
    -- Ancak, PL/pgSQL içinde EXCEPTION BLOCK ile hata yönetimi yapılabilir

    -- CASE Kullanımı
    DECLARE
        sayi2 INT := 5;
    BEGIN
        RAISE NOTICE '%', 
            CASE sayi2
                WHEN 1 THEN 'Zayıf'
                WHEN 2 THEN 'Geçer'
                WHEN 3 THEN 'Orta'
                WHEN 4 THEN 'İyi'
                WHEN 5 THEN 'Pekiyi'
                ELSE 'Aralık Dışı Değer'
            END;
    END;

    -- Tablo İçinde CASE Kullanımı
    RAISE NOTICE '%',
        (SELECT sayfa_sayisi,
                CASE 
                    WHEN sayfa_sayisi > 0 AND sayfa_sayisi <= 200 THEN 'ince'
                    WHEN sayfa_sayisi > 200 AND sayfa_sayisi <= 500 THEN 'kalın'
                    ELSE 'extra kalınlar'
                END AS "Kalınlıklar"
         FROM tbl_kitaplar);

    -- IF Kullanımı
    IF EXISTS (SELECT 1 FROM tbl_kitaplar WHERE sayfa_sayisi IS NULL) THEN
        DELETE FROM tbl_kitaplar WHERE sayfa_sayisi IS NULL;
    ELSE
        RAISE NOTICE '%', (SELECT * FROM tbl_kitaplar);
    END IF;

    -- WHILE Kullanımı
    DECLARE
        say INT := 1;
    BEGIN
        WHILE say <= 30 LOOP
            RAISE NOTICE '%', say;
            IF say = 24 THEN
                EXIT;
            END IF;
            say := say + 1;
        END LOOP;

        -- WHILE Örnek 2
        DECLARE
            sayi3 INT := 0;
        BEGIN
            WHILE sayi3 < 30 LOOP
                sayi3 := sayi3 + 1;
                IF sayi3 BETWEEN 15 AND 20 THEN
                    CONTINUE;
                END IF;
                RAISE NOTICE '%', sayi3;
            END LOOP;
        END;
    END;
END $$;

-- Açıklamalar:
-- 1. **Değişken Tanımlama ve Kullanımı**: PostgreSQL'de değişkenler `DO` blokları içinde tanımlanabilir. Değişken değerlerini sorgulamak için `RAISE NOTICE` kullanılır.
-- 2. **CASE Kullanımı**: PostgreSQL'de CASE ifadeleri doğrudan `SELECT` ifadeleri içinde kullanılabilir.
-- 3. **IF Kullanımı**: `IF` koşul ifadeleri PostgreSQL'de `PL/pgSQL` bloğu içinde kullanılabilir.
-- 4. **WHILE Kullanımı**: PostgreSQL'de `LOOP`, `EXIT` ve `CONTINUE` komutları kullanılarak döngüler kontrol edilebilir.
