SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status FROM `user` u 

SELECT * FROM (
SELECT oys.odeal_yazarkasa_sokum_id as sokumId, os5.odeal_id as odeal_abonelik_id, 
ot.ilk_kurulum_tarihi, ot.first_activation_date, ot.pasife_alinma_tarihi,
ca.name AS org,os2.odeal_satis_id,
ca.odeal_id  AS orgId,
ot.serial_no AS MaliNo,
fd.label AS sonuc,
fd2.label AS sebep, 
fd3.label AS Vadeli,
CONCAT(u.firstname," ",u.lastname) AS temsilci,
CONCAT(u2.firstname," ",u2.lastname) AS IptalTalepEden,
os2.taksite_acikmi,
ca.odeal_id,
oys.created_by,
oys.backoffice_aciklama,
oys.aciklama ,
oys.donem_ay, oys.donem_yil,
 STR_TO_DATE(CONCAT("1","-",oys.donem_ay,"-",oys.donem_yil),"%d-%m-%YY") as donem,
 oys.created_on, 
 oys.last_modified_on, 
 fd4.label AS Tedarikci,
IF(fd5.label LIKE "%mobil%","Mobil","Masaüstü") AS yazarkasa_tipi,
ROW_NUMBER() OVER (PARTITION BY ca.odeal_id, ot.serial_no ORDER BY oys.odeal_yazarkasa_sokum_id DESC) as Sira 
FROM odeal_yazarkasa_sokum oys 
LEFT JOIN odeal_subscription os on oys.abonelik = os.odeal_subscription_id 
LEFT JOIN crm_account ca on ca.crm_account_id  = oys.organizasyon 
LEFT JOIN odeal_terminal ot on oys.terminal = ot.odeal_terminal_id
LEFT JOIN odeal_subscription os3 on os3.odeal_subscription_id = oys.abonelik 
LEFT JOIN odeal_subscription os5 ON os5.odeal_subscription_id = ot.abonelik 
LEFT JOIN odeal_satis os2 on os2.mali_no = ot.serial_no and ca.odeal_id = os2.organisation_id
AND os2.odeal_satis_id = (
SELECT MAX(os4.odeal_satis_id) FROM odeal_satis os4 WHERE os4.mali_no = ot.serial_no AND
os4.created_on < oys.created_on)
LEFT JOIN crm_potential cp on cp.crm_potential_id = os2.iliskili_firsat 
LEFT JOIN field_data fd3 ON fd3.os_model_id = "potential" AND fd3.field_id = "yazar_kasa" AND fd3.field_data_id = cp.yazar_kasa 
LEFT JOIN `user` u  on os2.created_by = u.user_id 
LEFT JOIN `user` u2  on oys.created_by = u2.user_id 
LEFT JOIN field_data fd2 on fd2.field_data_id = oys.deaktif_nedenleri and fd2.field_id  = "deaktif_nedenleri" and fd2.os_model_id = "yazarkasa_sokum" 
LEFT JOIN field_data fd on fd.field_data_id = oys.sokum_sonucu  and fd.field_id = "sokum_sonucu"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os2.tedarikci AND fd4.os_model_id = "satis" AND fd4.field_id = "tedarikci"
LEFT JOIN field_data fd5 ON fd5.field_data_id = os2.yazar_kasa_tipi 
AND fd5.os_model_id = "satis" AND fd5.field_id = "yazar_kasa_tipi"
WHERE donem_yil IS NOT NULL and donem_ay IS NOT NULL AND oys.created_on >= "2024-01-01 00:00:00"
AND oys.terminal IS NOT NULL) as Iptaller WHERE Iptaller.Sira = 1 AND Iptaller.sokumId IN (97599,
96099,
96307,
96404,
97821,
97542,
97461,
97462);


101770
108525

SELECT ot.organisation_id, ot.serial_no, ot.ilk_kurulum_tarihi, ot.first_activation_date FROM odeal_terminal ot 
LEFT JOIN 
WHERE ot.first_activation_date >= "2024-03-01 00:00:00"




SELECT os.mali_no as MaliNo, ost.odeal_servis_talep_id, ost.satis, fd3.label as Tedarikci, os.setup_key, ost.created_on,
os.fiziksel_seri_no, os.fiziksel_cihaz_numarasi, ost.servis_mesaji, ost.takip_no,
CASE WHEN fd.label = "Kurulum" THEN "KURULUM"
	 WHEN fd.label = "Arıza" THEN "ARIZA"
	 WHEN fd.label = "İptal" THEN "GERİALIM"
	 WHEN fd.label = "Evrak Toplama" THEN "EVRAK"
	 WHEN fd.label = "Malzeme" THEN "MALZEME"
	 WHEN fd.label = "Versiyon" THEN "VERSİYON"
	 WHEN fd.label = "Hızlı Kurulum" THEN "HIZLIKURULUM"
	 ELSE "Diğer" END as TalepTipi, fd2.label as TalepDurumu FROM odeal_servis_talep ost 
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
GROUP BY ost.satis) AND ost.created_on <= "2024-06-24 09:50:00"


SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "PAX710007239"

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status FROM user u 


SELECT os.organisation_id, os.mali_no, os.save_type, os.welcome_tarihi, os.aksiyon_tarihi, os.satis_iptal_edildi, os.satis_iptal_tarihi, os.fatura_tarihi, os.sales_date, os.talep_tarihi 
FROM odeal_satis os WHERE os.sales_date >= "2024-04-01 00:00:00" AND os.sales_date <= "2024-04-30 23:59:59"

SELECT ot.organisation_id, ot.serial_no, ot.first_activation_date FROM odeal_terminal ot WHERE ot.first_activation_date >= "2024-04-01 00:00:00" AND ot.first_activation_date <= "2024-04-30 23:59:59"



SELECT * FROM (
SELECT os.organisation_id, os.mali_no, fd.label AS KayitTipi, IF(ISNULL(Terminal.first_activation_date)=TRUE,"Kurulmadı","Kuruldu") AS TerminalKurulum, COALESCE(os.fatura_tarihi,os.talep_tarihi) AS Tarih, 
os.sales_date, os.fatura_tarihi, os.talep_tarihi,  os.welcome_tarihi, os.aksiyon_tarihi, Terminal.first_activation_date AS KurulumTarihi,
DATE_FORMAT(os.sales_date,"%Y-%m") AS DonemSatis, 
DATE_FORMAT(Terminal.first_activation_date,"%Y-%m") AS Donem, 
IF(os.satis_iptal_edildi=0,"Hayır","Evet") AS SatisIptalDurum, fd2.label AS YazarKasaTipi, fd3.label AS SatisIptalSebebi FROM odeal_satis os
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.satis_iptal_sebebi AND fd3.os_app_id = "odeal" AND fd3.os_model_id = "satis" AND fd3.field_id = "satis_iptal_sebebi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.yazar_kasa_tipi AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd ON fd.field_data_id = os.save_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "save_type"
LEFT JOIN (SELECT * FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.organisation_id, ot.serial_no)) AS Terminal ON Terminal.organisation_id = os.organisation_id AND Terminal.serial_no = os.mali_no) AS Kurulumlar 
WHERE Kurulumlar.TerminalKurulum = "Kuruldu" AND Kurulumlar.KayitTipi = "Satışa Dönüştür" AND Kurulumlar.Donem = "2024-04"

Kurulumlar.TerminalKurulum = "Kuruldu" AND Kurulumlar.KayitTipi = "Satışa Dönüştür" AND

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "satis"

SELECT ot.organisation_id, ot.serial_no, ot.ilk_kurulum_tarihi, ot.first_activation_date FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.organisation_id, ot.serial_no)

