SELECT ot.odeal_terminal_id, ot.organizasyon, ot.odeal_id, ot.organisation_id, ot.serial_no FROM odeal_terminal ot WHERE ot.organisation_id = 301001089

SELECT * FROM crm_account ca WHERE ca.odeal_id  = 301001089

SELECT * FROM odeal_servis_talep ost WHERE ost.satis = 92307

SELECT os.organisation_id, os.mali_no, os.odeal_satis_id, ost.odeal_servis_talep_id FROM odeal_satis os 
LEFT JOIN odeal_servis_talep ost ON ost.satis = os.odeal_satis_id
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os
GROUP BY os.organisation_id, os.mali_no) AND os.organisation_id = 301001089;
WHERE os.mali_no = "FT30057274"



SELECT * FROM history h 
JOIN history2record hr ON hr.history_id = h.history_id 
LIMIT 10

SELECT * FROM history2record hr LIMIT 10

SELECT ot.serial_no, ot.first_activation_date, ot.ilk_kurulum_tarihi, ot.odeal_id, ot.odeal_terminal_id FROM odeal_terminal ot WHERE ot.serial_no = "BCJ00005920"

SELECT cp.crm_potential_id, cp.yazar_kasa, fd.label AS YazarKasaTalebi FROM crm_potential cp 
LEFT JOIN field_data fd ON fd.field_data_id = cp.yazar_kasa AND fd.os_app_id = "crm" AND fd.os_model_id = "potential" AND fd.field_id = "yazar_kasa"
WHERE cp.crm_potential_id = 123770

SELECT os.iliskili_firsat, os.organisation_id, os.mali_no FROM odeal_satis os WHERE os.organisation_id = 301265540 AND os.mali_no = "2C51194972"

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "servis_talep" AND fd.field_id = "talep_tipi"

SELECT ost.satis, ost.status, ost.talep_tipi FROM odeal_servis_talep ost WHERE ost.satis = 98703

SELECT os.odeal_satis_id, os.mali_no, os.organisation_id  FROM odeal_satis os WHERE os.mali_no = "PAX710045958"

SELECT ot.transaction_no AS "İşlem No", ot.organizasyon_odeal_id AS "Org. Id.",
ca.unvan AS "Unvan", ca.name AS "Marka",ot.description AS "Açıklama", fd.label AS "İtiraz Statü", ot.card_number  AS "Kart Num.",
fd4.label AS "İşlem Tipi",
ot.harcama_itirazi_tarihi AS "Harcama İtirazı Tarihi",
ot.transaction_date AS "İşlem Tarihi" , fd2.label AS "Ödeme Emri",
ot.harcama_itirazi  ,CONCAT(u.firstname," ", u.lastname) AS "Son Güncelleyen" ,
ot.amount AS "Tutar", ot.installment_count AS "Taksit Sayısı", fd3.label AS "POS"
FROM odeal_transaction ot
JOIN `user` u ON u.user_id = ot.last_modified_by
LEFT JOIN crm_account ca ON ca.crm_account_id = ot.account_name
LEFT JOIN field_data fd ON fd.field_data_id = ot.harcama_statu
AND fd.os_model_id = "transaction" AND fd.field_id = "harcama_statu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ot.odeme_emri
AND fd2.os_model_id = "transaction" AND fd2.field_id = "odeme_emri"
LEFT JOIN field_data fd3 ON fd3.field_data_id = ot.pos
AND fd3.os_model_id = "transaction" AND fd3.field_id = "pos"
LEFT JOIN field_data fd4 ON fd4.field_data_id = ot.transaction_type AND fd4.field_id = "transaction_type"
AND fd4.os_model_id = "transaction"
WHERE ot.harcama_itirazi = 1 AND ot.transaction_date >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH ), "%Y-%m-01")


 SELECT ca.odeal_id,
       Terminal.odeal_terminal_id as TerminalId,
       Terminal.serial_no as MaliNo,
       YazarKasaSokum.odeal_yazarkasa_sokum_id as YazarKasaSokumId,
       fd.label as DeaktifNedeni,
       fd2.label as SokumSonucu
FROM crm_account ca
JOIN (SELECT ot.organisation_id, ot.serial_no, ot.odeal_terminal_id, ot.abonelik, ot.terminal_status, ot.test FROM odeal_terminal ot 
			WHERE ot.odeal_terminal_id IN (SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot GROUP BY ot.organisation_id, ot.serial_no)) as Terminal ON Terminal.organisation_id = ca.odeal_id
JOIN (SELECT * FROM odeal_yazarkasa_sokum oys
                    WHERE odeal_yazarkasa_sokum_id IN(
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
JOIN odeal_terminal ot ON ot.odeal_terminal_id = oys.terminal
GROUP BY ot.serial_no)) as YazarKasaSokum ON YazarKasaSokum.terminal = Terminal.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = YazarKasaSokum.deaktif_nedenleri AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "deaktif_nedenleri"
LEFT JOIN field_data fd2 ON fd2.field_data_id = YazarKasaSokum.sokum_sonucu AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.field_id = "sokum_sonucu"
WHERE ca.crm_account_id IN (SELECT MAX(ca.crm_account_id) FROM crm_account ca GROUP BY ca.odeal_id) AND Terminal.test = 0 AND ca.test_record = 0 AND ca.odeal_id <> 0



UNION
SELECT ca.odeal_id,
       "CEPTEPOS" as TerminalId,
       CONCAT("CEPTEPOS"," - ",ca.odeal_id) as MaliNo,
       "CEPTEPOS" as YazarKasaSokumId,
       "CEPTEPOS" as DeaktifNedeni,
       "CEPTEPOS" as SokumSonucu,
       ca.deactivation_date,
       os.cancelled_at as CeptePosIptal
FROM crm_account ca
JOIN odeal_subscription os ON os.organization_odeal_id = ca.odeal_id
JOIN odeal_plan op ON op.odeal_plan_id = os.plan AND op.service_odeal_id = 3
WHERE os.odeal_subscription_id IN (SELECT MAX(os.odeal_subscription_id) FROM crm_account ca
JOIN odeal_subscription os ON os.organization_odeal_id = ca.odeal_id
JOIN odeal_plan op ON op.odeal_plan_id = os.plan AND op.service_odeal_id = 3
GROUP BY ca.odeal_id)
AND ca.test_record = 0 AND ca.odeal_id <> 0
GROUP BY ca.odeal_id) AS Iptaller WHERE Iptaller.odeal_id = 301000162

SELECT ca.odeal_id, os.organization_odeal_id, ca.is_activated, os.odeal_subscription_id, os.subscription_status FROM crm_account ca
JOIN odeal_subscription os ON os.organization_odeal_id = ca.odeal_id
JOIN odeal_plan op ON op.odeal_plan_id = os.plan AND op.service_odeal_id = 3
WHERE ca.odeal_id = 301000162
GROUP BY ca.odeal_id


SELECT ot.serial_no, ot.terminal_status, ot.organisation_id, ot.subscription_id, ot.abonelik FROM odeal_terminal ot WHERE ot.serial_no = "PAX710025956"

SELECT * FROM odeal_subscription os 
JOIN odeal_plan op ON op.odeal_plan_id = os.plan
WHERE os.organization_odeal_id = 301124937

SELECT * FROM odeal_sub






