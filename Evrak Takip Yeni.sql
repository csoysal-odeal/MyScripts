Organizasyon Statüsü -- is_activated - Crm_Account
Terminal Statüsü -- terminal_status - Terminal
Org ID -- Organisation ID - Crm_Account
Cihaz MaliNo -- Serial No - Satış
Cihaz Model -- Yazar Kasa Tipi - Satış
Terminal Kanal -- Kanal - Terminal
Satış Bölgesi - ( Kayıt Sahibi Rolü ) -- 
Kayıt Sahibi ( Satışçı )
Kiva Servis Talepleri -- Servis Talepleri Son Durum
Evrak Toplama Talebi ( Talep Durumu ) -- Servis Talep Tipi Evrak Toplama, Evrak Toplama Talep Durumu
Evrak Gelme Tarihi -- Evrak Gelme Tarihi - OKC Evrak Takibi
Satış Tarihi -- Satışa Dönüştürme Tarihi - Satış
Kurulum Tarihi -- İlk Kurulum Tarihi - Terminal
Evraklar Tam mı ? -- Evraklar Tam mı? - OKC Evrak Takibi
Kurulum Servis Formu -- Servis/Kurulum Formu - OKC Evrak Takibi
Teknik Servis formu -- Servis/Teknik Destek Formu - OKC Evrak Takibi
Sözleşme Durumu -- Üye İşyeri Sözleşmesi - OKC Evrak Takibi
Tedarikçi -- Tedarikçi - Terminal
Kurulum İl -- Kurulum İl - Satış
Kurulum İlçe -- Kurulum İlçe - Satış
Yazar Kasa Talebi -- Yazak Kasa Tipi - Satış
TFŞ Sözleşme Var mı -- TFŞ Sözleşme - OKC Evrak Takibi
Üye İşyeri Tel -- Satis
Üye İşyeri Bilgileri -- CRM Account

is_activated = 1 -- AKTİF
ot.terminal_status = 1 -- AKTİF


-- Üye İşyeri Kaydı
SELECT ca.crm_account_id, ca.unvan as Unvan, ca.name as Marka, ca.ilk_aktivasyon_tarihi,
ca.activation_date, ca.test_record, ca.deactivation_date, Satis.adres, Satis.town_name, Satis.city_name, 
IF(ca.is_activated=1,"Aktif","Pasif") as UyeDurum, Terminal.TerminalDurum, ca.odeal_id, Satis.odeal_satis_id, 
Satis.sales_date, Satis.KanalSatisTemsilci, Satis.KayitSahibi, Satis.sabit_telefon, Satis.alternatif_cep_telefonu, Satis.yazar_kasa_tipi, Satis.YazarKasaModel, Terminal.serial_no, Terminal.TerminalKanal,
Terminal.first_activation_date, Terminal.tedarikci, Evrak.odeal_okc_evrak_takibi_id, Evrak.organizasyon, Evrak.evraklar_tammi, Evrak.terminal, Evrak.serviskurulum_formu, Evrak.servisteknik_destek_formu,
Evrak.odeal_satis, Evrak.evrak_gelme_tarihi, Evrak.BasvuruDurumu, Evrak.EvrakToplayanTedarikci, ServisTalep.TalepTipi, ServisTalep.TalepDurum, Satis.SozlesmeDurumu, Satis.YazarKasaTalebi
FROM crm_account ca 
LEFT JOIN field_data fd ON fd.field_data_id = ca.account_status AND fd.os_app_id = "crm" AND fd.os_model_id = "account" AND fd.field_id = "account_status"
LEFT JOIN (SELECT ot.odeal_terminal_id, ot.serial_no, 
fd.label as Tedarikci, ot.first_activation_date, 
IF(ot.terminal_status=1,"Aktif","Pasif") as TerminalDurum,
ot.organisation_id,
ot.odeal_channel, oc.subject as TerminalKanal
FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.tedarikci AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "tedarikci"
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) 
FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no)) as Terminal ON Terminal.organisation_id = ca.odeal_id
JOIN (SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, os.adres, at2.town_name, ac.city_name, os.sabit_telefon, os.alternatif_cep_telefonu, os.crm_account, os.sales_date, os.yazar_kasa_tipi, 
fd.label as YazarKasaModel, CONCAT(u.firstname," ",u.lastname) as KayitSahibi, up.profile_name as KanalSatisTemsilci, os.record_owner, os.sozlesme_durumu, fd2.label AS SozlesmeDurumu,
fd3.label as YazarKasaTalebi
FROM odeal_satis os 
LEFT JOIN field_data fd ON fd.field_data_id = os.yazar_kasa_tipi AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.sozlesme_durumu AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "sozlesme_durumu"
LEFT JOIN `user` u  ON u.user_id = os.record_owner
LEFT JOIN user_profile up ON up.user_profile_id = u.user_profile_id
LEFT JOIN addr_town at2 ON at2.addr_town_id = os.kurulum_ilce 
LEFT JOIN addr_city ac ON ac.addr_city_id = os.kurulum_il
LEFT JOIN crm_potential cp ON cp.crm_potential_id = os.iliskili_firsat 
LEFT JOIN field_data fd3 ON fd3.field_data_id = cp.yazar_kasa AND fd3.os_app_id = "crm" AND fd3.os_model_id = "potential" AND fd3.field_id = "yazar_kasa"
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) 
FROM odeal_satis os 
GROUP BY os.organisation_id, os.mali_no)) as Satis ON Satis.organisation_id = Terminal.organisation_id AND Satis.mali_no = Terminal.serial_no
LEFT JOIN (SELECT ooet.odeal_okc_evrak_takibi_id, ooet.odeal_satis, 
ooet.evraklar_tammi, ooet.terminal, fd.label as BasvuruDurumu,
ooet.organizasyon, ooet.evrak_gelme_tarihi, 
ooet.serviskurulum_formu, fd2.label as EvrakToplayanTedarikci,
ooet.servisteknik_destek_formu, 
ooet.tfs_sozlesme, ooet.evrak_toplayan_tedarikci,
ooet.odeal_uye_isyeri_sozlesmesi 
FROM odeal_okc_evrak_takibi ooet
LEFT JOIN field_data fd ON fd.field_data_id = ooet.basvuru_durumu AND fd.os_app_id = "odeal" AND fd.os_model_id = "okc_evrak_takibi" AND fd.field_id = "basvuru_durumu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ooet.evrak_toplayan_tedarikci AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "okc_evrak_takibi" AND fd2.field_id = "evrak_toplayan_tedarikci") as Evrak ON Evrak.organizasyon = ca.crm_account_id AND Evrak.terminal = Terminal.odeal_terminal_id AND Evrak.odeal_satis = Satis.odeal_satis_id
LEFT JOIN (SELECT ost.odeal_servis_talep_id, ost.satis, ost.aciklama, fd.label as TalepTipi, fd2.label as TalepDurum
FROM odeal_servis_talep ost 
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "servis_talep" AND fd.field_data_id = ost.talep_tipi AND fd.field_id = "talep_tipi"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "servis_talep" AND fd2.field_data_id = ost.talep_durumu AND fd2.field_id = "talep_durumu"
WHERE ost.talep_tipi = 9) as ServisTalep ON ServisTalep.satis = Satis.odeal_satis_id
WHERE ca.odeal_id <> 301011013 AND Satis.town_name IS NOT NULL AND Satis.city_name IS NOT NULL;


SELECT os.sozlesme_durumu, os.yazar_kasa_model, os.yazar_kasa_tercihi, os.yazar_kasa_tipi, os.yazar_kasa FROM odeal_satis os;

SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "HN6401243962";

SELECT * FROM crm_account ca WHERE ca.odeal_id = 301011013;

SELECT * FROM ticket_issue ti =

SELECT * FROM odeal_transaction ot 

SELECT * FROM odeal_terminal ot WHERE ot.serial_no = "2C21023215";

301254279

301109836

SELECT * FROM field_data fd WHERE os_app_id = "odeal" AND os_model_id = "satis"


-- Son Terminal Kaydı
SELECT ot.odeal_terminal_id, ot.serial_no, 
fd.label as Tedarikci, ot.first_activation_date, 
IF(ot.terminal_status=1,"Aktif","Pasif") as TerminalDurum,
ot.organisation_id,
ot.odeal_channel, oc.subject
FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.tedarikci AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "tedarikci"
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) 
FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no)

-- Son Satış Kaydı
SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, os.adres, at2.town_name, ac.city_name, os.sabit_telefon, os.alternatif_cep_telefonu, os.crm_account, os.sales_date, os.yazar_kasa_tipi, os.sales_date,
fd.label as YazarKasaModel, CONCAT(u.firstname," ",u.lastname) as KayitSahibi, up.profile_name as KanalSatisTemsilci, os.record_owner, os.sozlesme_durumu, fd2.label AS SozlesmeDurumu,
fd3.label as YazarKasaTalebi, Terminaller.*
FROM odeal_satis os 
LEFT JOIN field_data fd ON fd.field_data_id = os.yazar_kasa_tipi AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.sozlesme_durumu AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "sozlesme_durumu"
LEFT JOIN `user` u  ON u.user_id = os.record_owner
LEFT JOIN user_profile up ON up.user_profile_id = u.user_profile_id
LEFT JOIN addr_town at2 ON at2.addr_town_id = os.kurulum_ilce 
LEFT JOIN addr_city ac ON ac.addr_city_id = os.kurulum_il
LEFT JOIN crm_potential cp ON cp.crm_potential_id = os.iliskili_firsat 
LEFT JOIN field_data fd3 ON fd3.field_data_id = cp.yazar_kasa AND fd3.os_app_id = "crm" AND fd3.os_model_id = "potential" AND fd3.field_id = "yazar_kasa"
LEFT JOIN (SELECT ot.odeal_terminal_id, ot.serial_no, 
fd.label as Tedarikci, ot.first_activation_date, ot.pasife_alinma_tarihi,
IF(ot.terminal_status=1,"Aktif","Pasif") as TerminalDurum,
ot.organisation_id,
ot.odeal_channel, oc.subject
FROM odeal_terminal ot 
LEFT JOIN field_data fd ON fd.field_data_id = ot.tedarikci AND fd.os_app_id = "odeal" AND fd.os_model_id = "terminal" AND fd.field_id = "tedarikci"
LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = ot.odeal_channel
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) 
FROM odeal_terminal ot 
GROUP BY ot.organisation_id, ot.serial_no)) AS Terminaller ON Terminaller.organisation_id = os.organisation_id AND Terminaller.serial_no = os.mali_no
WHERE os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) 
FROM odeal_satis os 
GROUP BY os.organisation_id, os.mali_no)

-- Evrak Takip
SELECT ooet.odeal_okc_evrak_takibi_id, ooet.odeal_satis, 
ooet.evraklar_tammi, ooet.terminal, fd.label as BasvuruDurumu,
ooet.organizasyon, ooet.evrak_gelme_tarihi, 
ooet.serviskurulum_formu, fd2.label as EvrakToplayanTedarikci,
ooet.servisteknik_destek_formu, 
ooet.tfs_sozlesme, ooet.evrak_toplayan_tedarikci,
ooet.odeal_uye_isyeri_sozlesmesi 
FROM odeal_okc_evrak_takibi ooet
LEFT JOIN field_data fd ON fd.field_data_id = ooet.basvuru_durumu AND fd.os_app_id = "odeal" AND fd.os_model_id = "okc_evrak_takibi" AND fd.field_id = "basvuru_durumu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ooet.evrak_toplayan_tedarikci AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "okc_evrak_takibi" AND fd2.field_id = "evrak_toplayan_tedarikci"
WHERE ooet.odeal_okc_evrak_takibi_id = 57806

SELECT os.nace_kodu, os.sales_date FROM odeal_satis os WHERE os.nace_kodu IS NULL

SELECT ot.odeal_terminal_id, ot.serial_no, ot.odeal_id FROM odeal_terminal ot WHERE ot.odeal_terminal_id = 32568

SELECT os.odeal_satis_id, os.mali_no, os.organisation_id FROM odeal_satis os WHERE os.mali_no = "BCJ00053522"

SELECT * FROM odeal_service os 

SELECT ost.odeal_servis_talep_id, ost.satis, ost.aciklama, fd.label, fd2.label , ost.talep_tipi
FROM odeal_servis_talep ost 
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "servis_talep" AND fd.field_data_id = ost.talep_tipi AND fd.field_id = "talep_tipi"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "servis_talep" AND fd2.field_data_id = ost.talep_durumu AND fd2.field_id = "talep_durumu"
WHERE ost.satis = 56998

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "servis_talep" AND fd.field_id = "talep_tipi";
SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "servis_talep" AND fd.field_id = "talep_durumu";

SELECT * FROM odeal_okc_evrak_takibi ooet 
WHERE ooet.odeal_satis = 58034;

SELECT ca.odeal_id, ca.billing_address, at2.town_name, ac.city_name FROM crm_account ca
LEFT JOIN addr_town at2 ON at2.addr_town_id = ca.billing_town 
LEFT JOIN addr_city ac ON ac.addr_city_id = ca.billing_city
WHERE ca.crm_account_id = 4563

301178954

-- Birden Fazla Satış 
SELECT os.organisation_id, os.mali_no, COUNT(os.odeal_satis_id) FROM odeal_satis os
WHERE os.organisation_id IS NOT NULL AND os.sales_date IS NOT NULL
GROUP BY os.organisation_id, os.mali_no HAVING COUNT(os.odeal_satis_id) > 1

SELECT u.user_id, u.firstname, u.lastname, up.profile_name FROM `user` u
LEFT JOIN user_profile up ON up.user_profile_id = u.user_profile_id WHERE u.user_id = 15645

SELECT ca.ilk_aktivasyon_tarihi, ca.activation_date, ca.deactivation_date FROM crm_account ca 

SELECT * FROM (
SELECT ca.odeal_id, ca.ilk_aktivasyon_tarihi, ca.activation_date, ca.deactivation_date, 
fd.label as AccountStatus, IF(ca.is_activated=1,"Aktif","Pasif") as UyeDurum FROM crm_account ca 
LEFT JOIN field_data fd ON fd.field_data_id = ca.account_status AND fd.os_app_id = "crm" 
AND fd.os_model_id = "account" AND fd.field_id = "account_status"
) as Uye
WHERE Uye.UyeDurum = "Pasif" 
AND Uye.AccountStatus = "Aktif" 
AND Uye.ilk_aktivasyon_tarihi IS NULL 
AND Uye.activation_date IS NULL 
AND Uye.deactivation_date IS NULL AND Uye.odeal_id NOT IN (301014131,301018262,301026131)

SELECT * FROM odeal_yazarkasa_sokum oys 
