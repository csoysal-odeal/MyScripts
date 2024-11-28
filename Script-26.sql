SELECT
os.odeal_satis_id as "Satış Id",
os.organisation_id as "Organizasyon Id",
mali_no as "Mali No",
ot.odeal_id  as "Terminal Id",
os.sales_date as "Satış Tarihi",
ot.ilk_kurulum_tarihi as "Kurulum Tarihi",
os.record_owner as "Satış Temsilcisi Id",
CONCAT(u.firstname," ",u.lastname) as "Satış Temsilcisi",
YazarKasaSokum.odeal_yazarkasa_sokum_id as "İptal Id",
YazarKasaSokum.deaktif_nedenleri as "Deaktif Nedeni Id",
YazarKasaSokum.aciklama as "Açıklama",
fd.label as "Deaktif Nedeni" ,
fd2.label as "Söküm Sonucu",
YazarKasaSokum.created_on, YazarKasaSokum.donem_ay, YazarKasaSokum.donem_yil,
CASE WHEN YazarKasaSokum.deaktif_nedenleri IN (2,12,6,11) THEN 0
ELSE 1 END AS "İptal Nedeni Sayılma Durumu"
FROM odeal_terminal ot 
LEFT JOIN odeal_satis os ON os.mali_no = ot.serial_no 
                  AND os.organisation_id = ot.organisation_id
                 AND (DATEDIFF(date(ot.created_on),date(os.sales_date))<=10)
LEFT JOIN (SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.terminal)) as YazarKasaSokum ON YazarKasaSokum.terminal =ot.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = YazarKasaSokum.deaktif_nedenleri and fd.field_id  = "deaktif_nedenleri"and fd.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd2 ON fd2.field_data_id = YazarKasaSokum.sokum_sonucu AND fd2.field_id = "sokum_sonucu" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.os_app_id = "odeal"
LEFT JOIN `user` u ON u.user_id=os.record_owner 
WHERE os.organisation_id LIKE "301%" and mali_no is not null and ot.serial_no = "BCE00012555"

SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.terminal)

BCE00012555

1679
3032

SELECT
KivaSatis.odeal_satis_id as "Satış Id",
KivaSatis.organisation_id as "Organizasyon Id",
mali_no as "Mali No",
ot.odeal_id  as "Terminal Id",
KivaSatis.sales_date as "Satış Tarihi",
ot.ilk_kurulum_tarihi as "Kurulum Tarihi",
KivaSatis.record_owner as "Satış Temsilcisi Id",
CONCAT(u.firstname," ",u.lastname) as "Satış Temsilcisi",
YazarKasaSokum.odeal_yazarkasa_sokum_id as "İptal Id",
YazarKasaSokum.deaktif_nedenleri as "Deaktif Nedeni Id",
YazarKasaSokum.aciklama as "Açıklama",
fd.label as "Deaktif Nedeni" ,
fd2.label as "Söküm Sonucu",
YazarKasaSokum.created_on, YazarKasaSokum.donem_ay, YazarKasaSokum.donem_yil,
CASE WHEN YazarKasaSokum.deaktif_nedenleri IN (2,12,6,11) THEN 0
ELSE 1 END AS "İptal Nedeni Sayılma Durumu"
FROM odeal_terminal ot 
LEFT JOIN (SELECT * FROM odeal_satis os WHERE os.odeal_satis_id IN (
SELECT MAX(Satis.odeal_satis_id) FROM (
SELECT os.mali_no, os.organisation_id, os.odeal_satis_id, os.crm_account FROM odeal_satis os) as Satis
GROUP BY Satis.mali_no, Satis.organisation_id)) as KivaSatis ON KivaSatis.mali_no = ot.serial_no 
                  AND KivaSatis.organisation_id = ot.organisation_id
                 AND (DATEDIFF(date(ot.created_on),date(KivaSatis.sales_date))<=10)
LEFT JOIN (SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.terminal)) as YazarKasaSokum ON YazarKasaSokum.terminal =ot.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = YazarKasaSokum.deaktif_nedenleri and fd.field_id  = "deaktif_nedenleri"and fd.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd2 ON fd2.field_data_id = YazarKasaSokum.sokum_sonucu AND fd2.field_id = "sokum_sonucu" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.os_app_id = "odeal"
LEFT JOIN `user` u ON u.user_id=KivaSatis.record_owner 
WHERE KivaSatis.organisation_id LIKE "301%" and mali_no is not null



SELECT ot.created_on, ot.odeal_terminal_id, ot.odeal_id, ot.serial_no, ca.test_record, IF(ot.terminal_status=1,"Aktif","Pasif") as TerminalDurum, ot.organisation_id, ot.merchant, Satis.satis_iptal_edildi, Satis.odeal_satis_id, Satis.mali_no, Satis.sales_date, os2.odeal_subscription_id, os2.plan, os2.plan_odeal_id, os3.name FROM odeal_terminal ot
LEFT JOIN (SELECT * FROM odeal_satis os WHERE os.odeal_satis_id IN (
SELECT MAX(Satis.odeal_satis_id) FROM (
SELECT os.mali_no, os.organisation_id, os.odeal_satis_id, os.crm_account FROM odeal_satis os) as Satis
GROUP BY Satis.mali_no, Satis.organisation_id)) as Satis ON Satis.mali_no = ot.serial_no AND Satis.organisation_id = ot.organisation_id AND (DATEDIFF(date(ot.created_on),date(Satis.sales_date))<=10)
LEFT JOIN odeal_subscription os2 ON os2.odeal_subscription_id = ot.abonelik
LEFT JOIN odeal_plan op ON op.odeal_plan_id = os2.plan
LEFT JOIN odeal_service os3 ON os3.odeal_service_id = op.service 
LEFT JOIN crm_account ca ON ca.crm_account_id = Satis.crm_account
WHERE op.service_odeal_id=7 AND ot.odeal_terminal_id IN (SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot GROUP BY ot.serial_no) AND Satis.satis_iptal_edildi = 0 AND ca.test_record = 0

SELECT * FROM odeal_satis os WHERE os.odeal_satis_id IN (
SELECT MAX(Satis.odeal_satis_id) FROM (
SELECT os.mali_no, os.organisation_id, os.odeal_satis_id, os.crm_account FROM odeal_satis os) as Satis
GROUP BY Satis.mali_no, Satis.organisation_id)

SELECT os.odeal_satis_id, os.crm_account, os.organisation_id, os.mali_no, os.efatura_posa_donustur, os.sadepos_efaturapos_donusumu_tamamlandi FROM odeal_satis os WHERE os.organisation_id = 301100049

SELECT * FROM crm_account ca WHERE ca.crm_account_id =314150

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "satis"

SELECT * FROM tran

SELECT ot.odeal_terminal, ot.amount, ot.odeal_id, ot.organizasyon_odeal_id, ot.transaction_status, fd.label FROM odeal_transaction ot
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "transaction" AND fd.field_id = "transaction_status" AND fd.field_data_id = ot.transaction_status


SELECT ca.crm_account_id, OdealSatis.*, fd.label as SokumSonucu, ca.unvan, ca.name as IsYeri, ca.activation_date, IF(ca.is_activated=1,"Aktif","Pasif") as UyeDurum FROM crm_account ca
LEFT JOIN (SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys GROUP BY oys.organizasyon)) as SokumTalep ON SokumTalep.organizasyon = ca.crm_account_id
LEFT JOIN field_data fd on fd.field_data_id = SokumTalep.sokum_sonucu AND fd.field_id = "sokum_sonucu" AND fd.os_model_id = "yazarkasa_sokum"
JOIN (SELECT os.odeal_satis_id, os.mali_no, os.satis_iptal_edildi, os.crm_account, os.organisation_id as UyeIsyeriId, os.sales_date as SatisaDonusmeTarihi, os.fatura_tarihi as FaturaTarihi, os.talep_tarihi as TalepTarihi, 
Terminal.ilk_kurulum_tarihi as KurulumTarihi, os.satis_iptal_tarihi, Terminal.serial_no as MaliNo , Terminal.first_activation_date, Terminal.label as TerminalDurum FROM odeal_satis os
LEFT JOIN (SELECT ot.*, fd.label FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.terminal_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "terminal_status"
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.serial_no)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id 
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
GROUP BY os.mali_no) AND os.sales_date IS NOT NULL) as OdealSatis ON OdealSatis.crm_account = ca.crm_account_id
WHERE OdealSatis.first_activation_date >= "2024-03-01 00:00:00" AND OdealSatis.first_activation_date <= "2024-03-31 23:59:59" and OdealSatis.mali_no = "2C50895224"






SELECT os.mali_no, os.organisation_id, fd2.label as CihazTipi, fd.label as SatisTipi, fd3.label as Kampanya, oc.subject as Kanal FROM odeal_satis os
JOIN crm_potential cp ON cp.crm_potential_id = os.iliskili_firsat
LEFT JOIN field_data fd ON fd.os_app_id = "crm" AND fd.os_model_id = "potential" AND fd.field_data_id = cp.yazar_kasa AND fd.field_id = "yazar_kasa"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_data_id = os.yazar_kasa_tipi AND fd2.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd3 ON fd3.os_app_id = "odeal" AND fd3.os_model_id = "satis" AND fd3.field_data_id = os.campaigns AND fd3.field_id = "campaigns"
LEFT JOIN (SELECT * FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.serial_no)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = Terminal.odeal_channel
WHERE os.odeal_satis_id IN (SELECT MAX(os2.odeal_satis_id) FROM odeal_satis os2 GROUP BY os2.mali_no)

select * from field_data fd where fd.os_app_id = "odeal" AND fd.os_model_id = "satis"

SELECT ot.odeal_terminal_id, ot.odeal_channel, ot.odeal_id, ot.organisation_id, ot.serial_no, 
ot.subscription_id, 
IF(ot.terminal_status=1,"Aktif","Pasif") as TerminalDurum, 
ot.first_activation_date FROM odeal_terminal ot WHERE ot.serial_no = "2C50895224"

SELECT * FROM odeal_yazarkasa_sokum oys WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys GROUP BY oys.organizasyon)

SELECT * FROM odeal_satis os

SELECT os.odeal_satis_id, os.mali_no, os.campaigns, os.satis_iptal_edildi, os.crm_account, os.organisation_id as UyeIsyeriId, os.sales_date as SatisaDonusmeTarihi, os.fatura_tarihi as FaturaTarihi, os.talep_tarihi as TalepTarihi, 
Terminal.ilk_kurulum_tarihi as KurulumTarihi, os.satis_iptal_tarihi, Terminal.serial_no as MaliNo , Terminal.first_activation_date, Terminal.label as TerminalDurum FROM odeal_satis os
LEFT JOIN (SELECT ot.*, fd.label FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.terminal_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "terminal_status"
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.serial_no)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id 
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
GROUP BY os.mali_no) AND os.sales_date IS NOT NULL

os.mali_no as MaliNo, ost.odeal_servis_talep_id, ost.satis, fd3.label as Tedarikci, os.setup_key, ost.created_on,
os.fiziksel_seri_no, os.fiziksel_cihaz_numarasi, ost.servis_mesaji,
fd.label as TalepTipi, fd2.label as TalepDurumu

SELECT os.mali_no as MaliNo, ost.odeal_servis_talep_id, ost.satis, fd3.label as Tedarikci, os.setup_key, ost.created_on,
os.fiziksel_seri_no, os.fiziksel_cihaz_numarasi, ost.servis_mesaji,
fd.label as TalepTipi, fd2.label as TalepDurumu FROM odeal_servis_talep ost 
JOIN odeal_satis os ON os.odeal_satis_id = ost.satis
LEFT JOIN field_data fd ON fd.field_data_id = ost.talep_tipi AND fd.os_model_id = "servis_talep" AND fd.field_id = "talep_tipi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ost.talep_durumu AND fd2.os_model_id = "servis_talep" AND fd2.field_id = "talep_durumu"
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.tedarikci AND fd3.os_model_id = "satis" AND fd3.field_id = "tedarikci"
WHERE ost.odeal_servis_talep_id IN (
SELECT MAX(ost.odeal_servis_talep_id) FROM odeal_servis_talep ost
JOIN odeal_satis os ON os.odeal_satis_id = ost.satis
LEFT JOIN field_data fd ON fd.field_data_id = ost.talep_tipi AND fd.os_model_id = "servis_talep" AND fd.field_id = "talep_tipi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ost.talep_durumu AND fd2.os_model_id = "servis_talep" AND fd2.field_id = "talep_durumu"
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.tedarikci AND fd3.os_model_id = "satis" AND fd3.field_id = "tedarikci"
GROUP BY ost.satis)


SELECT * FROM crm_account ca 

SELECT * FROM odeal_servis_talep ost WHERE ost.odeal_servis_talep_id IN (
SELECT MAX(ost.odeal_servis_talep_id) FROM odeal_servis_talep ost 
GROUP BY ost.satis)

SELECT * FROM odeal_terminal ot 

SELECT * FROM `user` u WHERE u.status = 1

SELECT * FROM odeal_subscription os 

SELECT * FROM odeal_plan op 

SELECT * FROM odeal_service os 

SELECT * FROM odeal_cepte_pos_iptal_talebi ocpit 

SELECT * FROM odeal_yazarkasa_sokum oys 

SELECT os.odeal_satis_id, os.mali_no, os.satis_iptal_edildi, os.crm_account, Terminal os.organisation_id as UyeIsyeriId, os.sales_date as SatisaDonusmeTarihi, os.fatura_tarihi as FaturaTarihi, os.talep_tarihi as TalepTarihi, 
Terminal.ilk_kurulum_tarihi as KurulumTarihi, os.satis_iptal_tarihi, Terminal.serial_no as MaliNo , Terminal.first_activation_date, Terminal.label as TerminalDurum FROM odeal_satis os
LEFT JOIN (SELECT ot.*, fd.label FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.terminal_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "terminal_status"
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.serial_no)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id 
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os 
GROUP BY os.mali_no) AND os.sales_date IS NOT NULL

SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "2C51589191"

SELECT * FROM odeal_satis os WHERE os.mali_no = "2C51589191"

 SELECT odeal_yazarkasa_sokum.odeal_yazarkasa_sokum_id AS churn_id,
       rel_terminal.odeal_id                                                                                          AS terminal_id,
       rel_terminal.subscription_id                                                                                   AS subscription_id,
       CAST(rel_organizasyon.odeal_id AS SIGNED )                                                                     AS merchant_id,
       rel_terminal.serial_no                                                                                         AS terminal_serial_no,
       odeal_yazarkasa_sokum.sokum_sonucu as churn_result_type,
       cfd_sokum_sonucu.label   as churn_result_text,
       odeal_yazarkasa_sokum.ikna_yontemleri1 as persuasion_type,
       cfd_ikna_yontemleri1.label as persuasion_text,
       odeal_yazarkasa_sokum.deaktif_nedenleri as inactive_type,
       cfd_deaktif_nedenleri.label    as inactive_text,
       odeal_yazarkasa_sokum.backoffice_aciklama as backoffice_description,
       odeal_yazarkasa_sokum.aciklama as description,
       odeal_yazarkasa_sokum.risk_yonetim_aciklama as risk_management_description,
       odeal_yazarkasa_sokum.donem_ay as period_month,
       odeal_yazarkasa_sokum.donem_yil as period_year,
       odeal_yazarkasa_sokum.last_modified_on                                                                              AS last_modified_on,
       odeal_yazarkasa_sokum.gorusme_durumu as meeting_status,
       cfd_gorusme_durumu.label as meeting_text,
       odeal_yazarkasa_sokum.last_modified_by as updated_by,
       odeal_yazarkasa_sokum.created_by,
       odeal_yazarkasa_sokum.created_on                                                                            AS created_on
FROM odeal_yazarkasa_sokum
         LEFT JOIN crm_account AS rel_organizasyon
                   ON rel_organizasyon.crm_account_id = odeal_yazarkasa_sokum.organizasyon
         LEFT JOIN odeal_terminal AS rel_terminal ON rel_terminal.odeal_terminal_id = odeal_yazarkasa_sokum.terminal
         LEFT JOIN user AS rel_record_owner ON odeal_yazarkasa_sokum.record_owner = rel_record_owner.user_id
         LEFT JOIN user AS rel_created_by ON odeal_yazarkasa_sokum.created_by = rel_created_by.user_id
         LEFT JOIN field_data AS cfd_sokum_sonucu
                   ON cfd_sokum_sonucu.os_app_id = 'odeal' AND cfd_sokum_sonucu.os_model_id = 'yazarkasa_sokum' AND
                      cfd_sokum_sonucu.field_id = 'sokum_sonucu' AND
                      cfd_sokum_sonucu.field_data_id = odeal_yazarkasa_sokum.sokum_sonucu
         LEFT JOIN field_data AS cfd_ikna_yontemleri1 ON cfd_ikna_yontemleri1.os_app_id = 'odeal' AND
                                                         cfd_ikna_yontemleri1.os_model_id = 'yazarkasa_sokum' AND
                                                         cfd_ikna_yontemleri1.field_id = 'ikna_yontemleri1' AND
                                                         cfd_ikna_yontemleri1.field_data_id =
                                                         odeal_yazarkasa_sokum.ikna_yontemleri1
         LEFT JOIN field_data AS cfd_deaktif_nedenleri ON cfd_deaktif_nedenleri.os_app_id = 'odeal' AND
                                                          cfd_deaktif_nedenleri.os_model_id = 'yazarkasa_sokum' AND
                                                          cfd_deaktif_nedenleri.field_id = 'deaktif_nedenleri' AND
                                                          cfd_deaktif_nedenleri.field_data_id =
                                                          odeal_yazarkasa_sokum.deaktif_nedenleri
         LEFT JOIN field_data AS cfd_donem_ay
                   ON cfd_donem_ay.os_app_id = 'odeal' AND cfd_donem_ay.os_model_id = 'yazarkasa_sokum' AND
                      cfd_donem_ay.field_id = 'donem_ay' AND cfd_donem_ay.field_data_id = odeal_yazarkasa_sokum.donem_ay
         LEFT JOIN field_data AS cfd_donem_yil
                   ON cfd_donem_yil.os_app_id = 'odeal' AND cfd_donem_yil.os_model_id = 'yazarkasa_sokum' AND
                      cfd_donem_yil.field_id = 'donem_yil' AND
                      cfd_donem_yil.field_data_id = odeal_yazarkasa_sokum.donem_yil
         LEFT JOIN field_data AS cfd_gorusme_durumu
                   ON cfd_gorusme_durumu.os_app_id = 'odeal' AND cfd_gorusme_durumu.os_model_id = 'yazarkasa_sokum' AND
                      cfd_gorusme_durumu.field_id = 'gorusme_durumu' AND
                      cfd_gorusme_durumu.field_data_id = odeal_yazarkasa_sokum.gorusme_durumu
WHERE odeal_yazarkasa_sokum.status = '1'
   and odeal_yazarkasa_sokum.last_modified_on>CURRENT_DATE()
   
   
SELECT oys.odeal_yazarkasa_sokum_id, 
oys.organizasyon, oys.organizasyon_id, oys.terminal, oys.sokum_sonucu, oys.created_on, oys.last_modified_on, oys.donem_yil, oys.donem_ay, fd.label
FROM odeal_yazarkasa_sokum oys 
LEFT JOIN field_data fd ON fd.field_data_id = oys.sokum_sonucu AND fd.os_app_id = "odeal" 
AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu"
WHERE oys.odeal_yazarkasa_sokum_id = 97630

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) AS UserName FROM `user` u WHERE u.user_id = 15734