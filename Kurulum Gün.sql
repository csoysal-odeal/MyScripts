SELECT os.organisation_id, os.mali_no, os.record_owner FROM odeal_satis os
WHERE os.organisation_id = 301184957 AND os.mali_no = "PAX710030526"

SELECT os.organisation_id, os.mali_no, os.record_owner, CONCAT(u.firstname," ",u.lastname) as SatisTemsilcisi FROM odeal_satis os
LEFT JOIN user u ON u.user_id = os.record_owner
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os
GROUP BY os.mali_no )



-- Kurulum Gün
SELECT os.odeal_satis_id, 
os.marka, os.mali_no,
os.sales_date, 
os.fatura_tarihi, 
ot.first_activation_date, 
ot.ilk_kurulum_tarihi, 
os.saha_satis_kuracak, 
os.record_owner, ot.tedarikci, oc.subject, COALESCE(os.fatura_tarihi,os.sales_date) as Tarih,
DATEDIFF(ot.first_activation_date, COALESCE(os.fatura_tarihi,os.sales_date)) as FarkGun, 
ot.odeal_channel, DATE_FORMAT(ot.first_activation_date,"%Y-%m") as Donem FROM odeal_satis os 
LEFT JOIN odeal_terminal ot ON ot.serial_no = os.mali_no AND ot.organisation_id = os.organisation_id
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel 
WHERE DATE_FORMAT(ot.first_activation_date,"%Y-%m")="2024-01"
AND os.odeal_satis_id IN (SELECT MAX(os2.odeal_satis_id) FROM odeal_satis os2 GROUP BY os2.organisation_id, os2.mali_no)


SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%iban%"


os.odeal_satis_id IN (SELECT MAX(os2.odeal_satis_id) FROM odeal_satis os2 GROUP BY os2.organisation_id, os2.mali_no)

SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, os.sales_date FROM odeal_satis os
WHERE os.mali_no = "2C50003821" AND os.organisation_id = 301250019;

SELECT ot.serial_no, ot.organisation_id, ot.first_activation_date, ot.ilk_kurulum_tarihi, ot.tedarikci, ot.odeal_channel FROM odeal_terminal ot 
WHERE ot.serial_no = "2B20122717" AND ot.organisation_id = 301239254

SELECT * FROM odeal_satis os 
JOIN odeal_terminal ot ON
WHERE os.mali_no = "2B20122717" AND os.odeal_satis_id IN (SELECT MAX(os2.odeal_satis_id) FROM odeal_satis os2 WHERE os2.mali_no = "2B20122717" GROUP BY os2.mali_no)


SELECT ooet.odeal_okc_evrak_takibi_id, ot.odeal_id  AS "Terminal Id", ot.serial_no,ot.organisation_id,ooet.basvuru_durumu,fd.label AS "Başvuru Durumu",
ooet.odeal_satis,ooet.record_owner, ooet.last_modified_by, os.kurma_gonderildi , os.aktivasyon_gonderildi, cp.firstname, cp.second_name, fd2.label AS "Komisyon Tipi",
ooet.evraklar_tammi , cp.yazar_kasa , fd3.label AS "Yazar Kasa Talebi", fd4.label AS "Pos Taksit Durumu", CONCAT(u.firstname," ", u.lastname) ,
ooet.tfs_sozlesme,
ooet.aciklama,
ooet.created_on,
ooet.last_modified_on,
ooet.pos_sozlesmesi
FROM odeal_okc_evrak_takibi ooet 
LEFT JOIN odeal_terminal ot ON ot.odeal_terminal_id = ooet.terminal 
LEFT JOIN field_data fd ON fd.field_data_id = ooet.basvuru_durumu AND fd.field_id = "basvuru_durumu" AND os_model_id = "okc_evrak_takibi"
LEFT JOIN odeal_satis os ON os.odeal_satis_id = ooet.odeal_satis 
LEFT JOIN crm_potential cp ON os.iliskili_firsat = cp.crm_potential_id 
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.komisyon_tipi AND fd2.field_id = "komisyon_tipi" AND fd2.os_model_id ="satis"
LEFT JOIN field_data fd3 ON fd3.field_data_id = cp.yazar_kasa AND fd3.field_id = "yazar_kasa" AND fd3.os_model_id ="potential"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os.pos_taksit_durumu AND fd4.field_id ="pos_taksit_durumu" AND fd4.os_model_id ="satis"
LEFT JOIN user u ON ooet.record_owner = u.user_id 
WHERE ot.serial_no = "BCJ00014423"
ORDER BY ooet.odeal_okc_evrak_takibi_id DESC

SELECT * FROM odeal_satis os
WHERE os.mali_no ="JI20111240"
