SELECT ca.crm_account_id, ca.odeal_id FROM crm_account ca WHERE ca.odeal_id = 301256238 -- Üye İşyeri

SELECT os.crm_account, os.organisation_id, os.mali_no, os.odeal_satis_id FROM odeal_satis os WHERE os.odeal_satis_id IN (90890,90890) -- Satış

SELECT ot.odeal_id, ot.organisation_id, ot.organizasyon, ot.serial_no, ot.odeal_terminal_id FROM odeal_terminal ot WHERE ot.serial_no  = "BCJ00019500" -- Terminal

SELECT * FROM odeal_okc_evrak_takibi ooet WHERE ooet.odeal_satis = 17743

SELECT os.organisation_id, ot.organisation_id, os.mali_no, ot.odeal_terminal_id, ot.odeal_id, os.odeal_satis_id FROM odeal_satis os 
LEFT JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
WHERE os.mali_no = "BCJ00019500"

SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "JI20111240"

SELECT os.odeal_satis_id, ooet.odeal_okc_evrak_takibi_id, ot.odeal_id  AS "Terminal Id", ot.serial_no, ot.organisation_id, ooet.basvuru_durumu,fd3.label AS "Başvuru Durumu",
ooet.odeal_satis, ooet.record_owner, ooet.last_modified_by, os.kurma_gonderildi , os.aktivasyon_gonderildi, cp.firstname, cp.second_name, fd.label AS "Komisyon Tipi",
ooet.evraklar_tammi , cp.yazar_kasa , fd2.label AS "Yazar Kasa Talebi", fd4.label AS "Pos Taksit Durumu", CONCAT(u.firstname," ", u.lastname) as KayitSahibi,
ooet.tfs_sozlesme,
ooet.aciklama,
ooet.created_on,
ooet.last_modified_on,
ooet.pos_sozlesmesi, os.sales_date, ot.first_activation_date, ca.unvan, 
os.finansmanli_satis, os.satis_iptal_sebebi, fd5.label as SatisIptalSebebi,
fd6.label as FinansmanliSatis, ooet.last_modified_by, CONCAT(u2.firstname," ",u2.lastname) as SonGuncelleyen
FROM odeal_satis os 
LEFT JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
LEFT JOIN odeal_okc_evrak_takibi ooet ON ooet.terminal = ot.odeal_terminal_id
LEFT JOIN crm_potential cp ON cp.crm_potential_id = os.iliskili_firsat
LEFT JOIN crm_account ca ON ca.odeal_id = os.organisation_id 
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "komisyon_tipi" AND fd.field_data_id = os.komisyon_tipi
LEFT JOIN field_data fd2 ON fd2.os_app_id = "crm" AND fd2.os_model_id = "potential" AND fd2.field_id = "yazar_kasa" AND fd2.field_data_id = cp.yazar_kasa 
LEFT JOIN field_data fd3 ON fd3.os_app_id = "odeal" AND fd3.os_model_id = "okc_evrak_takibi" AND fd3.field_id = "basvuru_durumu" AND fd3.field_data_id = ooet.basvuru_durumu 
LEFT JOIN field_data fd4 ON fd4.os_app_id = "odeal" AND fd4.os_model_id = "satis" AND fd4.field_id = "pos_taksit_durumu" AND fd4.field_data_id = os.pos_taksit_durumu
LEFT JOIN field_data fd5 ON fd5.field_data_id = os.satis_iptal_sebebi AND fd5.os_app_id = "odeal" AND fd5.os_model_id = "satis" AND fd5.field_id = 'satis_iptal_sebebi'
LEFT JOIN field_data fd6 ON fd6.field_data_id = os.finansmanli_satis AND fd6.os_app_id = "odeal" AND fd6.os_model_id = "satis" AND fd6.field_id = 'finansmanli_satis'
LEFT JOIN user u ON u.user_id = ooet.record_owner 
LEFT JOIN user u2 ON u2.user_id = ooet.last_modified_by
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
GROUP BY os.organisation_id, os.mali_no) AND os.mali_no = "BCJ00019500"


SELECT * FROM crm_potential cp 

SELECT * FROM field_data fd 
WHERE fd.field_id = "satis_iptal_sebebi"

SELECT ooet.odeal_okc_evrak_takibi_id, ooet.created_on , os.sales_date, ot.first_activation_date, os.kurma_gonderildi , ca.unvan , CONCAT(u.firstname," ",u.lastname) as "Kayıt Sahibi", 
ooet.tfs_sozlesme , ooet.basvuru_durumu , ooet.record_owner ,ooet.odeal_satis, ooet.evraklar_tammi, os.odeal_satis_id , os.finansmanli_satis  , os.mali_no , os.organisation_id, os.satis_iptal_sebebi 
FROM odeal_okc_evrak_takibi ooet
LEFT JOIN odeal_satis os ON os.odeal_satis_id = ooet.odeal_satis 
LEFT JOIN crm_account ca ON ca.odeal_id = os.organisation_id 
LEFT JOIN odeal_terminal ot ON ot.odeal_terminal_id = ooet.terminal
LEFT JOIN field_data fd ON fd.field_data_id = os.satis_iptal_sebebi AND fd.field_id = 'satis_iptal_sebebi'
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.finansmanli_satis AND fd.field_id = 'finansmanli_satis'
LEFT JOIN field_data fd3 ON fd3.field_data_id = ooet.basvuru_durumu AND fd.field_id = 'basvuru_durumu'
LEFT JOIN `user` u ON u.user_id = ooet.record_owner 
WHERE  os.mali_no = "JI20111240"