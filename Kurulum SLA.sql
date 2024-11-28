SELECT COUNT(*) AS is_gunu_sayisi
FROM (
SELECT (DATE_SUB(CURDATE(),INTERVAL 2 MONTH)) + INTERVAL daynum DAY AS gun
    FROM (
SELECT t*10+u daynum
        FROM (SELECT 0 t UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) A,
             (SELECT 0 u UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) B) as AA
WHERE (DATE_SUB(CURDATE(),INTERVAL 2 MONTH)) + INTERVAL daynum DAY BETWEEN '2024-06-01' AND '2024-06-30') AS DAYS
WHERE DAYOFWEEK(gun) NOT IN (1, 7)


SELECT * FROM (
SELECT os.organisation_id, os.mali_no, os.bekleme_nedeni, fd4.label, fd.label AS KayitTipi, IF(ISNULL(Terminal.first_activation_date)=TRUE,"Kurulmadı","Kuruldu") AS TerminalKurulum, os.evrak_tamamlanma_tarihi, DATEDIFF(Terminal.first_activation_date,COALESCE(os.fatura_tarihi,os.talep_tarihi,os.welcome_tarihi)) as Fark, COALESCE(os.fatura_tarihi,os.talep_tarihi,os.welcome_tarihi) AS Tarih,
os.sales_date, os.fatura_tarihi, os.talep_tarihi,  os.welcome_tarihi, os.aksiyon_tarihi, Terminal.first_activation_date AS KurulumTarihi,
DATE_FORMAT(os.sales_date,"%Y-%m") AS DonemSatis, 
DATE_FORMAT(Terminal.first_activation_date,"%Y-%m") AS Donem, 
IF(os.satis_iptal_edildi=0,"Hayır","Evet") AS SatisIptalDurum, fd2.label AS YazarKasaTipi, fd3.label AS SatisIptalSebebi, os.odeal_satis_id
FROM odeal_satis os
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.satis_iptal_sebebi AND fd3.os_app_id = "odeal" AND fd3.os_model_id = "satis" AND fd3.field_id = "satis_iptal_sebebi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.yazar_kasa_tipi AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os.bekleme_nedeni AND fd4.os_app_id = "odeal" AND fd4.os_model_id = "satis" AND fd4.field_id = "bekleme_nedeni"
LEFT JOIN field_data fd ON fd.field_data_id = os.save_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "save_type"
LEFT JOIN (SELECT * FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.organisation_id, ot.serial_no)) AS Terminal ON Terminal.organisation_id = os.organisation_id AND Terminal.serial_no = os.mali_no) AS Kurulumlar 
WHERE Kurulumlar.TerminalKurulum = "Kuruldu" AND Kurulumlar.KayitTipi = "Satışa Dönüştür"
AND Kurulumlar.odeal_satis_id IN (SELECT MAX(os.odeal_satis_id) FROM odeal_satis os GROUP BY os.organisation_id, os.mali_no);

SELECT DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

SELECT COUNT(*) AS is_gunu_sayisi
FROM (
SELECT (DATE_SUB(CURDATE(),INTERVAL 2 MONTH)) + INTERVAL daynum DAY AS gun
    FROM (
SELECT t*10+u daynum
        FROM (SELECT 0 t UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) A,
             (SELECT 0 u UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) B) as AA
WHERE (DATE_SUB(CURDATE(),INTERVAL 2 MONTH)) + INTERVAL daynum DAY BETWEEN '2024-06-01' AND '2024-06-30') AS DAYS
WHERE DAYOFWEEK(gun) NOT IN (1, 7)


SELECT * FROM (
SELECT os.organisation_id,
           os.mali_no,
           os.bekleme_nedeni,
           fd4.label,
           fd.label AS KayitTipi,
           IF(ISNULL(Terminal.first_activation_date)=TRUE, "Kurulmadı", "Kuruldu") AS TerminalKurulum,
           os.evrak_tamamlanma_tarihi,
           DATEDIFF(Terminal.first_activation_date, COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi)) as Fark,
           COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi) AS Tarih,
           os.sales_date,
           os.fatura_tarihi,
           os.talep_tarihi,
           os.welcome_tarihi,
           os.aksiyon_tarihi,
           Terminal.first_activation_date AS KurulumTarihi,
           DATE_FORMAT(os.sales_date,"%Y-%m") AS DonemSatis,
           DATE_FORMAT(Terminal.first_activation_date,"%Y-%m") AS Donem,
           IF(os.satis_iptal_edildi=0, "Hayır", "Evet") AS SatisIptalDurum,
           fd2.label AS YazarKasaTipi,
           fd3.label AS SatisIptalSebebi,
           Terminal.pasife_alinma_tarihi as PasifeAlınmaTarihi,
           os.odeal_satis_id,
           (
               DATEDIFF(Terminal.first_activation_date, COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi))
               - (WEEK(Terminal.first_activation_date) - WEEK(COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi))) * 2
               - IF(WEEKDAY(Terminal.first_activation_date) = 6, 1, 0)
               - IF(WEEKDAY(COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi)) = 6, 1, 0)
               - IF(WEEKDAY(Terminal.first_activation_date) = 0, 1, 0)
               - IF(WEEKDAY(COALESCE(os.fatura_tarihi, os.talep_tarihi, os.welcome_tarihi)) = 0, 1, 0)
           ) AS IsGunFark
    FROM odeal_satis os
    LEFT JOIN field_data fd3 ON fd3.field_data_id = os.satis_iptal_sebebi
                             AND fd3.os_app_id = "odeal"
                             AND fd3.os_model_id = "satis"
                             AND fd3.field_id = "satis_iptal_sebebi"
    LEFT JOIN field_data fd2 ON fd2.field_data_id = os.yazar_kasa_tipi
                             AND fd2.os_app_id = "odeal"
                             AND fd2.os_model_id = "satis"
                             AND fd2.field_id = "yazar_kasa_tipi"
    LEFT JOIN field_data fd4 ON fd4.field_data_id = os.bekleme_nedeni
                             AND fd4.os_app_id = "odeal"
                             AND fd4.os_model_id = "satis"
                             AND fd4.field_id = "bekleme_nedeni"
    LEFT JOIN field_data fd ON fd.field_data_id = os.save_type
                            AND fd.os_app_id = "odeal"
                            AND fd.os_model_id = "satis"
                            AND fd.field_id = "save_type"
    LEFT JOIN (
        SELECT *
        FROM odeal_terminal ot
        WHERE ot.odeal_terminal_id IN (
            SELECT MAX(ot.odeal_terminal_id)
            FROM odeal_terminal ot
            GROUP BY ot.organisation_id, ot.serial_no
        )
    ) AS Terminal ON Terminal.organisation_id = os.organisation_id
                 AND Terminal.serial_no = os.mali_no
) AS Kurulumlar
WHERE Kurulumlar.TerminalKurulum = "Kuruldu"
  AND Kurulumlar.KayitTipi = "Satışa Dönüştür"
  AND Kurulumlar.Donem = "2024-06"
  AND Kurulumlar.sales_date > '2024-04-01 00:00:00'
  AND Kurulumlar.odeal_satis_id IN (
      SELECT MAX(os.odeal_satis_id)
      FROM odeal_satis os
      GROUP BY os.organisation_id, os.mali_no
  );

SELECT oys.odeal_yazarkasa_sokum_id, oys.sokum_sonucu, oys.deaktif_nedenleri, oys.sokum_bekliyor, oys.sokum_durumu FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
LEFT JOIN field_data fd ON fd.field_data_id = oys.sokum_sonucu AND fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum"
GROUP BY oys.terminal)