SELECT
os.odeal_satis_id as "Satış Id",
ca.ilk_aktivasyon_tarihi as UyeIlkAktivasyonTarih,
ca.activation_date as UyeAktivasyonTarihi,
os.organisation_id as "Organizasyon Id",
mali_no as "Mali No",
ot.odeal_id  as "Terminal Id",
os.sales_date as "Satış Tarihi",
ot.ilk_kurulum_tarihi as "Kurulum Tarihi",
ot.first_activation_date as IlkKurulumTarih,
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
LEFT JOIN crm_account ca ON ca.odeal_id = ot.organisation_id
LEFT JOIN odeal_satis os ON os.mali_no = ot.serial_no 
                  AND os.organisation_id = ot.organisation_id
                 AND (DATEDIFF(date(ot.created_on),date(os.sales_date))<=10)
LEFT JOIN odeal_yazarkasa_sokum oys  ON oys.terminal =ot.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = oys.deaktif_nedenleri and fd.field_id  = "deaktif_nedenleri"and fd.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd2 ON fd2.field_data_id = oys.sokum_sonucu AND fd2.field_id = "sokum_sonucu" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.os_app_id = "odeal"
LEFT JOIN `user` u ON u.user_id=os.record_owner 
WHERE os.organisation_id LIKE "301%" and mali_no is not null


SELECT Terminal.organisation_id as UyeID, 
Terminal.odeal_id as TerminalID,
Terminal.ilk_aktivasyon_tarihi as UyeIlkAktivasyonTarihi,
Terminal.activation_date as UyeAktivasyonTarihi, 
Terminal.serial_no as MaliNo, Terminal.first_activation_date as TerminalIlkAktivasyonTarihi, Terminal.Sira,
IF(Terminal.Sira>1,"Eski","Yeni") as TerminalDurum
FROM (
SELECT ot.serial_no, ot.odeal_terminal_id, ot.odeal_id, ot.organisation_id, ca.ilk_aktivasyon_tarihi, ca.activation_date, ot.first_activation_date,
DENSE_RANK() OVER (PARTITION BY ot.organisation_id ORDER BY ot.first_activation_date) as Sira
FROM odeal_terminal ot 
LEFT JOIN crm_account ca ON ca.odeal_id = ot.organisation_id
WHERE ot.first_activation_date IS NOT NULL AND ot.terminal_status = 1) as Terminal

SELECT ot.serial_no, ot.odeal_terminal_id,ot.odeal_id, ot.terminal_status, ot.organisation_id, ca.ilk_aktivasyon_tarihi, ca.activation_date, ot.first_activation_date,
DENSE_RANK() OVER (PARTITION BY ot.organisation_id ORDER BY ot.first_activation_date) as Sira
FROM odeal_terminal ot 
LEFT JOIN crm_account ca ON ca.odeal_id = ot.organisation_id
WHERE ot.first_activation_date IS NOT NULL AND ot.organisation_id = 301186844

SELECT ot.organisation_id, ot.serial_no, ot.is FROM odeal_terminal ot 

SELECT * FROM odeal_satis os 
WHERE os.organisation_id = 301000615

SELECT * FROM crm_account ca 

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status, ur.role_name, up.profile_name, up.parent, up.`level`  FROM user u
LEFT JOIN user_role ur ON ur.user_role_id = u.user_role_id
LEFT JOIN user_profile up ON up.user_profile_id = u.user_profile_id 
WHERE u.user_id = 15566




