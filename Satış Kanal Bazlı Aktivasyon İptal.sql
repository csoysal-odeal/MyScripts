SELECT os.*, os.odeal_satis_id, os.organisation_id, os.mali_no, os.sales_date, os.satis_iptal_tarihi, os.satis_iptal_sebebi,fd.label, os.record_owner FROM odeal_satis os
LEFT JOIN field_data fd ON fd.field_data_id = os.satis_iptal_sebebi AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "satis_iptal_sebebi"
WHERE os.organisation_id = 301134692 AND os.mali_no = "JH20093039"

SELECT * FROM field_data fd 
WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum"


-- Satış
SELECT os.organisation_id as UyeID, os.mali_no as MaliNo, os.kurulum_il, os.kurulum_ilce, os.odeal_satis_id as SatisID, os.sales_date as SatisTarihi, os.talep_tarihi as TalepTarihi, os.fatura_tarihi as FaturaTarihi, os.satis_iptal_tarihi as SatisIptalTarihi, fd.label as SatisIptalSebebi, IF(os.satis_iptal_edildi=1,"EVET","HAYIR") as SatisIptalEdildi FROM odeal_satis os 
LEFT JOIN field_data fd ON fd.field_data_id = os.satis_iptal_sebebi AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "satis_iptal_sebebi"
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os
WHERE os.sales_date >= "2023-01-01 00:00:00" AND os.organisation_id IS NOT NULL
GROUP BY os.organisation_id, os.mali_no)

SELECT os.odeal_satis_id, os.organisation_id, os.mali_no FROM odeal_satis os 
WHERE os.mali_no = "PAX710046366" AND os.organisation_id = 301254273

SELECT * FROM history h 
JOIN history2record hr ON hr.history_id = h.history_id 
WHERE hr.record_id = 100020 AND h.created_on >= "2024-01-01 00:00:00" AND h.os_app_id = "odeal" AND h.os_model_id = "satis"

SELECT * FROM addr_city ac 

SELECT * FROM addr_town at2 

301134692	JH20093039


-- Terminal
SELECT ot.organisation_id as UyeID, ot.serial_no as MaliNo, ot.first_activation_date as IlkKurulumTarihi, fd.label as TerminalDurum, ot.subscription_id as AboneID, oc.subject as Kanal, ot.odeal_id as TerminalID 
FROM odeal_terminal ot 
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
LEFT JOIN field_data fd ON fd.field_data_id = ot.terminal_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "terminal_status"
WHERE ot.odeal_terminal_id IN (SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no) AND fd.label = "Aktif" AND ot.test = 0


-- Üye
SELECT ca.crm_account_id, ca.odeal_id as UyeID, ca.unvan, ca. ca.activation_date as AktivasyonTarihi, ca.ilk_aktivasyon_tarihi, IF(ca.is_activated=1,"AKTİF","PASİF") as UyeDurum, oc.subject as OrgKanal, ca.test_record FROM crm_account ca 
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ca.odeal_channel
WHERE ca.odeal_id IS NOT NULL

427610

SELECT ca.odeal_id as UyeID, COUNT(*) FROM crm_account ca 
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ca.odeal_channel
WHERE ca.odeal_id IS NOT NULL
GROUP BY ca.odeal_id HAVING COUNT(*)>1

-- Yazar Kasa Söküm
SELECT oys.*, oys.odeal_yazarkasa_sokum_id, oys.donem_ay, oys.donem_yil, oys.gorusen_temsilci, oys.record_owner, oys.organizasyon, oys.deaktif_tarihi, oys.deaktif_nedenleri, fd.label as SokumSonucu FROM odeal_yazarkasa_sokum oys 
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu" AND fd.field_data_id = oys.sokum_sonucu



