
SELECT ocpit.odeal_cepte_pos_iptal_talebi_id, ocpit.organizasyon, ocpit.created_by, CONCAT(u.firstname," ",u.lastname) as KayitAcan,
       CONCAT(u1.firstname," ",u1.lastname) as KayitSahibi,
       ocpit.abonelik, ocpit.organizasyon, ocpit.aciklama, ocpit.donem_ay, ocpit.donem_yil,
       ocpit.sokum_talebi, fd.label as SokumTalebi, fd2.label as DeaktifNedeni
FROM odeal_cepte_pos_iptal_talebi ocpit
LEFT JOIN user u ON u.user_id = ocpit.created_by
LEFT JOIN user u1 ON u1.user_id = ocpit.record_owner
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "cepte_pos_iptal_talebi" AND fd.field_data_id = ocpit.sokum_talebi AND fd.field_id = "sokum_talebi"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "cepte_pos_iptal_talebi" AND fd2.field_data_id = ocpit.deaktif_nedenleri AND fd2.field_id = "deaktif_nedenleri"
ORDER BY ocpit.odeal_cepte_pos_iptal_talebi_id DESC

SELECT * FROM odeal_ceptepos


SELECT * FROM field_data fd 
WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "cepte_pos_iptal_talebi" AND fd.field_id = "deaktif_nedenleri"

SELECT * FROM crm_account ca 
WHERE ca.odeal_id = 301000009

SELECT * FROM odeal_subscription os 
WHERE os.odeal_subscription_id = 288467

SELECT Riskli.organisation_id, COUNT(*) FROM (
SELECT os.organisation_id, os.sektor, os.mali_no, os.mcc_kod FROM odeal_satis os
WHERE os.organisation_id IS NOT NULL AND os.sales_date IS NOT NULL AND os.mcc_kod IN (5944,7011)
AND os.sales_date >= "2023-01-01 00:00:00" AND os.sales_date <= "2023-12-31 23:59:59"
) as Riskli
GROUP BY Riskli.organisation_id

SELECT * FROM odeal_cepte_pos_iptal_talebi ocpit 

561

SELECT * FROM odeal_satis os 

SELECT ooet.evraklar_tammi FROM odeal_okc_evrak_takibi ooet
JOIN odeal_terminal ot ON ot.odeal_terminal_id = ooet.terminal 
WHERE ot.serial_no = "PAX710048006"

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%mernis%"

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status FROM `user` u

SELECT ot.serial_no, ot.first_activation_date, os.sales_date FROM odeal_terminal ot
LEFT JOIN odeal_satis os ON os.mali_no = ot.serial_no AND os.organisation_id = ot.organisation_id
WHERE  DATE(ot.first_activation_date) = "2024-03-22"
and ot.terminal_status = 1
