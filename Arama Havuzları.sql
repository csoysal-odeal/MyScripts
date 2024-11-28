SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%bkm%"

SELECT ca.odeal_id, ca.bkm_id FROM crm_account ca 
WHERE ca.bkm_id IS NOT NULL AND ca.bkm_id <> " "

SELECT * FROM callcenter_lead_pool clp -- pool, call_type

SELECT * FROM callcenter_call cc -- call_type, pool

SELECT * FROM callcenter_assigned_contact cac -- last_call_type, pool

SELECT * FROM callcenter_call_type cct -- callcenter_call_type_id

SELECT * FROM odeal_web_form owf 

SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, os.sales_date, os.created_by, os.record_owner, CONCAT(u.firstname,' ',u.lastname) as Oluşturan, CONCAT(u2.firstname,' ',u2.lastname) as KayitSahibi, u.phone, u2.phone FROM odeal_satis os
JOIN `user` u ON u.user_id = os.created_by
JOIN `user`u2 ON u2.user_id = os.record_owner 
WHERE os.organisation_id IS NOT NULL AND os.sales_date >= "2023-12-02 00:00:00" AND os.sales_date <= "2023-12-02 23:59:59"

SELECT os.organisation_id, os.arama_durumu FROM odeal_satis os WHERE os.organisation_id IS NOT NULL

SELECT * FROM crm_contact cc 

SELECT * FROM odeal_terminal ot 

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.reg_date, u.last_login, u.status FROM `user` u 


SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%donem%"

SELECT * FROM `user` u 
JOIN user_profile up ON up.user_profile_id = u.user_profile_id

SELECT DISTINCT ca.unvan, ca.name, ca.odeal_id, ca.organisation_id, ca.activation_date, ca.crm_account_id, ca.mobile FROM crm_account ca 
WHERE ca.odeal_id = 301121568

SELECT * FROM (
SELECT ca.crm_account_id, ca.odeal_id, ca.organisation_id,cac.durumu, cac.description, cac.status, cac.callcenter_assigned_contact_id, cc.callcenter_call_id, 
ca.activation_date, cc.call_result, ccr.result_name, cct.type_name as AramaTipi, cc.call_type, 
CONCAT(u.firstname," ",u.lastname) as KayitSahibi, cc.created_on, CONCAT(u2.firstname," ",u2.lastname) as SonGuncelleyen,
 cac.account_name, cac.last_call_type, cct2.type_name as SonAramaTipi, cac.last_call_status, fd.label as SonAramaDurumu, cac.last_call_result, ccr2.result_name as SonAramaSonucu, cac.last_call_date, 
ca.name as Marka, ca.unvan as Unvan, cc.pool, clp.pool_name as HavuzAdi,
ROW_NUMBER() OVER (PARTITION BY ca.odeal_id, clp.pool_name, cct2.type_name ORDER BY cac.last_call_date DESC) as Sira
FROM callcenter_call cc 
JOIN callcenter_assigned_contact cac ON cac.account_name = cc.account_name AND cc.assigned_pool_record = cac.callcenter_assigned_contact_id 
JOIN crm_account ca ON ca.crm_account_id = cc.account_name
JOIN callcenter_lead_pool clp ON clp.callcenter_lead_pool_id = cc.pool 
LEFT JOIN callcenter_call_result ccr ON ccr.callcenter_call_result_id = cc.call_result
LEFT JOIN callcenter_call_result ccr2 ON ccr2.callcenter_call_result_id = cac.last_call_result 
LEFT JOIN callcenter_call_type cct ON cct.callcenter_call_type_id = cc.call_type 
LEFT JOIN callcenter_call_type cct2 ON cct2.callcenter_call_type_id = cac.last_call_type
LEFT JOIN field_data fd ON fd.os_app_id = "callcenter" AND fd.os_model_id = "assigned_contact" AND fd.field_data_id = cac.last_call_status AND fd.field_id = "last_call_status"
LEFT JOIN `user` u ON u.user_id = cc.created_by
LEFT JOIN `user` u2 ON u2.user_id = cc.last_modified_by
WHERE ca.odeal_id IS NOT NULL AND ca.odeal_id = 301236899) as AramaHavuzlari
WHERE AramaHavuzlari.Sira = 1


SELECT * FROM callcenter_assigned_contact cac 
WHERE cac.account_name = 384050 -- cac.callcenter_assigned_contact_id = 999321233+

SELECT * FROM callcenter_call cc 
WHERE cc.account_name = 405865

SELECT * FROM callcenter_call_result ccr 

SELECT * FROM callcenter_lead_pool clp 

SELECT * FROM crm_potential cp 

SELECT * FROM act_call ac 

SELECT * FROM callcenter_cdr cc 


ÜYE ŞUBAT 2024 YANINDA 3 TERMİNAL ALDI 1.YENİ DİĞERLERİ MEVCUT

BİR ÜYE ŞUBAT 2024 MEVCUT AMA BU ÜYE İŞYERİ 2022 DE GELDİ 2022 GELDİĞİ ZAMAN İLK ALDIĞI TERMİNALE BİZ YENİ DİYORDUK.


SELECT ac.call_type, ac.* FROM act_call ac 

SELECT ccr.call_type, ccr.result_name, ccr.call_status FROM callcenter_call_result ccr 

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%organisation_id%"

SELECT * FROM field_data fd WHERE fd.os_app_id = "callcenter" AND fd.os_model_id = "call_type"

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%next_call%"

SELECT * FROM odeal_transaction ot 
WHERE ot.organizasyon_odeal_id = 301121568

SELECT os.organisation_id , os.mali_no, os.sales_date, Terminal.first_activation_date FROM odeal_satis os
LEFT JOIN (SELECT ot.organisation_id, ot.serial_no, ot.first_activation_date  FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no)) as Terminal ON Terminal.organisation_id = os.organisation_id AND Terminal.serial_no = os.mali_no 
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
WHERE os.sales_date >= "2023-12-01 00:00:00"
GROUP BY os.organisation_id, os.mali_no )

SELECT ot.organisation_id, ot.serial_no, ot.first_activation_date  FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no) 

SELECT * FROM odeal_terminal ot 
WHERE ot.serial_no = "PAX710017154"

SELECT ca.organisation_id, ca.odeal_id, ca.bkm_id, ca.name, ca.unvan FROM crm_account ca 
WHERE ca.odeal_id IN ( select s.organization_odeal_id from odeal_subscription s
        join odeal_plan p on p.odeal_plan_id = s.plan
        join odeal_service sv on sv.odeal_service_id = p.service
        where s.status = 1 and s.subscription_status = 2 and p.status = 1 and sv.name = 'CEPPOS')
AND ca.account_status = 2 AND (ca.bkm_id IS NOT NULL AND ca.bkm_id <> '')

SELECT * FROM odeal_okc_evrak_takibi ooet 


SELECT * FROM user u
WHERE u.user_profile_id = 11

SELECT * FROM user_profile up 

SELECT up.user_profile_id, up.profile_name, up2.user_profile_id, up2.profile_name, u.user_id, u.firstname, u.lastname FROM user_profile up 
LEFT JOIN user_profile up2 ON up2.parent = up.user_profile_id
LEFT JOIN user u ON u.user_profile_id = up2.user_profile_id 
WHERE up.user_profile_id = 9

