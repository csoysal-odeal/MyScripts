SELECT ca.odeal_id as UyeID,
ca.billing_address as Adres,
at2.town_name as Ilce,
ac.city_name as Il, 
os.mali_no as Terminal, 
os.sales_date as SatisTarih, 
os.created_on as KayitTarihi, 
os.satis_iptal_tarihi as SatisIptalTarihi,
ac2.city_name as KurulumIl, at3.town_name as KurulumIlce, os.servis_adres,
CONCAT(u.firstName," ",u.lastName) as Temsilci,
CAST(CONVERT(u.mobile, UNSIGNED INTEGER) AS CHAR) as Telefon
FROM odeal_satis os
JOIN crm_account ca ON ca.odeal_id = os.organisation_id
JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no 
JOIN `user` u ON u.user_id = os.created_by
LEFT JOIN addr_city ac ON ac.addr_city_id = ca.billing_city 
LEFT JOIN addr_town at2 ON at2.addr_town_id = ca.billing_town
LEFT JOIN addr_town at3 ON at3.addr_town_id = os.kurulum_ilce 
LEFT JOIN addr_city ac2 ON ac2.addr_city_id = os.kurulum_il 
WHERE os.sales_date IS NOT NULL 
AND os.created_on >= "2023-12-01 00:00:00" AND os.created_on <= "2023-12-15 23:59:59" 
AND ca.test_record = 0 AND os.servis_adres LIKE "%mah%"

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%location%"

SELECT os.servis_adres, SUBSTRING_INDEX(os.servis_adres,'mah',1) as OncekiKelime, SUBSTRING_INDEX(os.OncekiKelime,'MAHALLESI',1) as OncekiKelime2,
SUBSTRING_INDEX(os.servis_adres,'MAHELLESİ',1) as OncekiKelime3
FROM odeal_satis os
WHERE os.servis_adres LIKE "%mah%" OR os.servis_adres LIKE "%MAHALLESİ%" OR os.servis_adres LIKE "%MAHELLESİ%" OR os.servis_adres LIKE "%MAHALLESI%"

SELECT * FROM odeal_transaction ot 
WHERE ot.odeal_transaction_id = 84220072

76053

SELECT * FROM odeal_terminal ot 
WHERE ot.odeal_terminal_id = 76053
206535
301223874

SELECT * FROM odeal_subscription os
WHERE os.odeal_subscription_id = 263529
301223874

SELECT ot.organisation_id, ot.usage_status, ot.terminal_status, ot.serial_no FROM odeal_terminal ot 
WHERE ot.serial_no = "PAX110012519"

SELECT Kayit.organisation_id, Kayit.serial_no, Kayit.terminal_status,  COUNT(*) as Adet FROM (
SELECT os.odeal_satis_id, os.organisation_id, ot.serial_no, ot.odeal_terminal_id, oc.odeal_channel_id, oc.subject, ot.terminal_status, os.sales_date, os.satis_iptal_tarihi, 
ot.first_activation_date, ot.pasife_alinma_tarihi FROM odeal_terminal ot 
JOIN odeal_satis os ON os.organisation_id = ot.organisation_id AND os.mali_no = ot.serial_no
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
WHERE ot.terminal_status = 1 AND ot.serial_no LIKE "%PAX%") as Kayit
GROUP BY Kayit.serial_no, Kayit.terminal_status HAVING COUNT(*) > 1
ORDER BY Kayit.serial_no

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%kurulum%"

SELECT u.user_id as UserID, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status as Statu FROM user u
ORDER BY CONCAT(u.firstname," ",u.lastname)

SELECT * FROM odeal_channel oc 

SELECT ot.odeal_terminal_id, ot.first_activation_date, ot.pasife_alinma_tarihi, ot.tedarikci, 
ot.odeal_channel, ot.odeal_gun_sonu, ot.odeal_id, ot.organisation_id, ot.subscription_id, ot.serial_no, ot.created_on 
FROM odeal_terminal ot 
WHERE ot.serial_no = "PAX710012519"

SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, os.sales_date, os.satis_iptal_tarihi, os.aksiyon_tarihi, os.created_on, os.iliskili_firsat, os.satis_sureci FROM odeal_satis os 
WHERE os.mali_no = "PAX710012519"

SELECT * FROM odeal_terminal ot 
WHERE ot.serial_no = "PAX710010966"


SELECT
os.odeal_satis_id as "Satış Id",
os.organisation_id as "Organizasyon Id",
mali_no as "Mali No",
ot.odeal_id  as "Terminal Id",
os.sales_date as "Satış Tarihi",
ot.ilk_kurulum_tarihi as "Kurulum Tarihi",
os.record_owner as "Satış Temsilcisi Id",
CONCAT(u.firstname," ",u.lastname) as "Satış Temsilcisi",
oys.odeal_yazarkasa_sokum_id as "İptal Id",
oys.deaktif_nedenleri as "Deaktif Nedeni Id",
oys.aciklama as "Açıklama",
fd.label as "Deaktif Nedeni" ,
fd2.label as "Söküm Sonucu",
CASE WHEN oys.deaktif_nedenleri IN (2,12,6,11) THEN 0
ELSE 1 END AS "İptal Nedeni Sayılma Durumu"
FROM odeal_terminal ot 
LEFT JOIN odeal_satis os ON os.mali_no = ot.serial_no 
                  AND os.organisation_id = ot.organisation_id
                 AND (DATEDIFF(date(ot.created_on),date(os.sales_date))<=10)
LEFT JOIN odeal_yazarkasa_sokum oys  ON oys.terminal =ot.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = oys.deaktif_nedenleri and fd.field_id  = "deaktif_nedenleri"and fd.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd2 ON fd2.field_data_id = oys.sokum_sonucu AND fd2.field_id = "sokum_sonucu" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.os_app_id = "odeal"
LEFT JOIN `user` u ON u.user_id=os.record_owner 
WHERE os.organisation_id LIKE "301%" and mali_no is not null

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu"
