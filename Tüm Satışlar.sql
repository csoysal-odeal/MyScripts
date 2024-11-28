SELECT os.odeal_satis_id, os.organisation_id, os.mali_no,
       os.talep_tarihi, os.sales_date FROM odeal_satis os WHERE os.mali_no = "PAX710031815";

SELECT ot.organisation_id, ot.serial_no, ot.ilk_kurulum_tarihi, ot.first_activation_date
FROM odeal_terminal ot WHERE ot.serial_no = "PAX710031815";


SELECT ae.act_event_id as ZiyaretID, ae.subject as Aciklama,
       ae.cep_telefonu as CepTelefon,
       fd.label as ZiyaretTipi,
       fd2.label as ZiyaretDurumu,
       ae.mekan_adi as MekanAdi,
       ae.mekan_foto as MekanFoto,
       ae.mekan_lokasyon as MekanLokasyon,
       os.odeal_satis_id as SatisID,
       os.organisation_id as UyeIsyeriID, os.mali_no as MaliNo,
       os.sales_date as SatisTarihi,
       os.iliskili_firsat as IliskiliFirsat
FROM act_event ae
LEFT JOIN crm_potential cp ON ae.act_event_id = cp.ziyaret
LEFT JOIN odeal_satis os ON cp.crm_potential_id = os.iliskili_firsat
LEFT JOIN field_data fd ON fd.field_data_id = ae.event_type AND fd.os_app_id = "act" AND fd.os_model_id = "event" AND fd.field_id = "event_type"
LEFT JOIN field_data fd2 ON fd2.field_data_id = ae.event_status AND fd2.os_app_id = "act" AND fd2.os_model_id = "event" AND fd2.field_id = "event_status"
WHERE ae.created_on >= "2024-01-01 00:00:00";

SELECT * FROM (SELECT oys.odeal_yazarkasa_sokum_id, oys.created_on as KayitTarihi,
       CONCAT(u.firstname," ",u.lastname) as KayitSahibi, CONCAT(oys.donem_yil,"-",oys.donem_ay) as Donem,
       oys.terminal, ot.serial_no, oys.organizasyon,
       oys.sokum_durumu, oys.sokum_bekliyor,
       fd.label as SokumSonucu,
       fd1.label as DeaktifNedenleri,
        fd2.label as SokumDurumu
FROM odeal_yazarkasa_sokum oys
LEFT JOIN user u ON u.user_id = oys.record_owner
LEFT JOIN odeal_terminal ot ON ot.odeal_terminal_id = oys.terminal
LEFT JOIN field_data fd ON fd.field_data_id = oys.sokum_sonucu AND fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu"
LEFT JOIN field_data fd1 ON fd1.field_data_id = oys.deaktif_nedenleri AND fd1.os_app_id = "odeal" AND fd1.os_model_id = "yazarkasa_sokum" AND fd1.field_id = "deaktif_nedenleri"
LEFT JOIN field_data fd2 ON fd2.field_data_id = oys.sokum_durumu AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.field_id = "sokum_durumu"
WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.organizasyon, oys.terminal)) as Iptaller


SELECT oys.odeal_yazarkasa_sokum_id as sokumId, os5.odeal_id as odeal_abonelik_id, ot.pasife_alinma_tarihi,
ca.name AS org,
ca.odeal_id  AS orgId,
ot.serial_no AS MaliNo,
fd.label AS sonuc,
fd2.label AS sebep,
fd3.label AS Vadeli,
fd6.label as GeriOdemeTipi,
CONCAT(u.firstname," ",u.lastname) AS temsilci,
Satis.taksite_acikmi,
ca.odeal_id,
oys.backoffice_aciklama,
oys.aciklama,
oys.donem_ay, oys.donem_yil,
 STR_TO_DATE(CONCAT("1","-",oys.donem_ay,"-",oys.donem_yil),"%d-%m-%YY") as donem, oys.donem_yil as DonemYil,
 oys.created_on ,oys.last_modified_on, fd4.label AS Tedarikci,
IF(fd5.label LIKE "%mobil%","Mobil","Masaüstü") AS yazarkasa_tipi
FROM odeal_yazarkasa_sokum oys
LEFT JOIN odeal_subscription os on oys.abonelik = os.odeal_subscription_id
LEFT JOIN crm_account ca on ca.crm_account_id  = oys.organizasyon
LEFT JOIN odeal_terminal ot on oys.terminal = ot.odeal_terminal_id
LEFT JOIN odeal_subscription os3 on os3.odeal_subscription_id = oys.abonelik
LEFT JOIN odeal_subscription os5 ON os5.odeal_subscription_id = ot.abonelik
LEFT JOIN (SELECT * FROM odeal_satis os2 WHERE os2.odeal_satis_id IN (SELECT MAX(os.odeal_satis_id) FROM odeal_satis os WHERE os.organisation_id IS NOT NULL GROUP BY os.organisation_id, os.mali_no)) as Satis on Satis.mali_no = ot.serial_no and ca.odeal_id = Satis.organisation_id
LEFT JOIN crm_potential cp on cp.crm_potential_id = Satis.iliskili_firsat
LEFT JOIN field_data fd3 ON fd3.os_model_id = "potential" AND fd3.field_id = "yazar_kasa" AND fd3.field_data_id = cp.yazar_kasa
LEFT JOIN `user` u  on Satis.created_by = u.user_id
LEFT JOIN field_data fd2 on fd2.field_data_id = oys.deaktif_nedenleri and fd2.field_id  = "deaktif_nedenleri" and fd2.os_model_id = "yazarkasa_sokum"
LEFT JOIN field_data fd on fd.field_data_id = oys.sokum_sonucu  and fd.field_id = "sokum_sonucu"
LEFT JOIN field_data fd4 ON fd4.field_data_id = Satis.tedarikci AND fd4.os_model_id = "satis" AND fd4.field_id = "tedarikci"
LEFT JOIN field_data fd5 ON fd5.field_data_id = Satis.yazar_kasa_tipi
AND fd5.os_model_id = "satis" AND fd5.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd6 ON fd6.field_data_id = Satis.geri_odeme_tipi AND fd6.os_app_id = 'odeal' AND fd6.os_model_id = 'satis' AND fd6.field_id = 'geri_odeme_tipi'
WHERE donem_yil IS NOT NULL and donem_ay IS NOT NULL
AND oys.terminal IS NOT NULL

SELECT MAX(os.odeal_satis_id) FROM odeal_satis os WHERE os.organisation_id IS NOT NULL GROUP BY os.organisation_id, os.mali_no

SELECT ot.organisation_id, ot.serial_no FROM odeal_terminal ot WHERE ot.serial_no = "2B25002165"

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "satis_sureci";

SELECT os.organisation_id, os.mali_no FROM odeal_satis os WHERE os.odeal_satis_id = 93518

SELECT cp.crm_potential_id, cp.ziyaret FROM crm_potential cp ORDER BY cp.crm_potential_id DESC;

SELECT ae.act_event_id FROM act_event ae ORDER BY ae.act_event_id DESC;

SELECT os.odeal_satis_id,
       os.organisation_id,
       ost.randevu_tarihi,
       ost.randevuya_cekilen_tarih,
       os.marka,
       os.firma_unvan,
       os.mali_no,
       os.sales_date,
       ost.takip_no,
       CONCAT(u.firstname, " ", u.lastname)   as KayitSahibi,
       CONCAT(u2.firstname, " ", u2.lastname) as Olusturan,
       ost.tamamlanma_tarihi                  as TalepTamamlanmaTarihi,
       ost.odeal_servis_talep_id,
       ost.durum_guncellenme_tarihi,
       ost.created_on,
       ost.last_modified_on,
       fd.label                               as ArizaTipi,
       fd1.label                              as TalepTipi,
       fd2.label                              as TalepDurumu,
       fd3.label                              as Tedarikci,
       fd4.label                              as MalzemeTuru,
       ost.aciklama, ac.city_name, at.town_name
FROM odeal_satis os
         JOIN odeal_servis_talep ost ON ost.satis = os.odeal_satis_id
         JOIN addr_city ac ON ac.addr_city_id = os.kurulum_il
         JOIN addr_town at ON at.addr_town_id = os.kurulum_ilce
         LEFT JOIN field_data fd ON fd.field_data_id = ost.ariza_tipi AND fd.os_app_id = "odeal" AND
                                    fd.os_model_id = "servis_talep" AND fd.field_id = "ariza_tipi"
         LEFT JOIN field_data fd1 ON fd1.field_data_id = ost.talep_tipi AND fd1.os_app_id = "odeal" AND
                                     fd1.os_model_id = "servis_talep" AND fd1.field_id = "talep_tipi"
         LEFT JOIN field_data fd2 ON fd2.field_data_id = ost.talep_durumu AND fd2.os_app_id = "odeal" AND
                                     fd2.os_model_id = "servis_talep" AND fd2.field_id = "talep_durumu"
         LEFT JOIN field_data fd3 ON fd3.field_data_id = ost.tedarikci1 AND fd3.os_app_id = "odeal" AND
                                     fd3.os_model_id = "servis_talep" AND fd3.field_id = "tedarikci1"
         LEFT JOIN field_data fd4 ON fd4.field_data_id = ost.malzeme_turu AND fd4.os_app_id = "odeal" AND
                                     fd4.os_model_id = "servis_talep" AND fd4.field_id = "malzeme_turu"
         LEFT JOIN user u ON u.user_id = ost.record_owner
         LEFT JOIN user u2 ON u2.user_id = ost.created_by
WHERE os.mali_no = "PAX710000138"

SELECT * FROM information_schema.COLUMNS c WHERE c.COLUMN_NAME LIKE "%takip%"





SELECT ca.crm_account_id, ca.unvan as Unvan, ca.name as Marka, ca.ilk_aktivasyon_tarihi,
ca.activation_date, ca.test_record, ca.deactivation_date, Satis.adres, Satis.town_name, Satis.city_name,
IF(ca.is_activated=1,"Aktif","Pasif") as UyeDurum, Terminal.TerminalDurum, ca.odeal_id, Satis.odeal_satis_id, Satis.SatisIptalSebebi,
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
JOIN (SELECT os.odeal_satis_id, os.organisation_id, os.mali_no, fd4.label as SatisIptalSebebi, os.adres, at2.town_name, ac.city_name, os.sabit_telefon, os.alternatif_cep_telefonu, os.crm_account, os.sales_date, os.yazar_kasa_tipi,
fd.label as YazarKasaModel, CONCAT(u.firstname," ",u.lastname) as KayitSahibi, up.profile_name as KanalSatisTemsilci, os.record_owner, os.sozlesme_durumu, fd2.label AS SozlesmeDurumu,
fd3.label as YazarKasaTalebi
FROM odeal_satis os
LEFT JOIN field_data fd ON fd.field_data_id = os.yazar_kasa_tipi AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.sozlesme_durumu AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "sozlesme_durumu"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os.satis_iptal_sebebi AND fd4.os_app_id = "odeal" AND fd4.os_model_id = "satis" AND fd4.field_id = "satis_iptal_sebebi"
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
WHERE ca.odeal_id <> 301011013 AND Satis.town_name IS NOT NULL AND Satis.city_name IS NOT NULL


-- Tüm satış kurulum iptal
SELECT Kurulumlar.SatisID, Kurulumlar.FirsatID, Kurulumlar.FirsatAdi, Kurulumlar.lead_source, Kurulumlar.UyeIsyeriID,
       Kurulumlar.crm_account_id as CrmAccountID, Kurulumlar.Unvan, Kurulumlar.Marka, Kurulumlar.VergiNo,
       Kurulumlar.TckNo, Kurulumlar.Yetkili, Kurulumlar.satis_sureci,
       Kurulumlar.SerialNo, Kurulumlar.TerminalID, Kurulumlar.Plan, Kurulumlar.Hizmet, Kurulumlar.odeal_id, fd6.label as TerminalDurum, ch.subject as TerminalKanal,
       Kurulumlar.SatisKanali, Kurulumlar.Sektor, Kurulumlar.BeklemeNedeni, Kurulumlar.KayitTipi,
       Kurulumlar.TerminalKurulmaDurumu, Kurulumlar.EvrakTamamlanmaTarihi, Kurulumlar.Fark,
       Kurulumlar.Tarih, Kurulumlar.TerminalKanalID, Kurulumlar.SatisWelcomeDurum, Kurulumlar.SatisTarihi, Kurulumlar.FaturaTarihi,
       Kurulumlar.TalepTarihi, Kurulumlar.WelcomeTarihi, Kurulumlar.AksiyonTarihi, Kurulumlar.KurulumTarihi,
       Kurulumlar.DonemSatis, Kurulumlar.KurulumDonem, Kurulumlar.SatisIptalDurum, Kurulumlar.YazarKasaTipi,
       Kurulumlar.PosTaksitDurumu, Kurulumlar.SatisIptalSebebi,
       Kurulumlar.AramaDurumu, Kurulumlar.SatisIptalTarihi, Kurulumlar.TerminalPasiflenmeTarihi, CONCAT(u.firstname," ",u.lastname) as KayitSahibi,
       Iptaller.SokumDurumu, Iptaller.SokumSonucu, Iptaller.DeaktifNedenleri, Iptaller.Donem, Iptaller.odeal_yazarkasa_sokum_id, Yardim.YardimTalebi, Yardim.TalepDurum
FROM (
SELECT
       os.odeal_satis_id as SatisID, cmp.crm_potential_id as FirsatID, cmp.potential_name as FirsatAdi, cmp.lead_source, ca.crm_account_id, ca.name as Marka, ca.unvan as Unvan, ca.tax_number as VergiNo,
       ca.test_record, Contact.TckNo, Contact.Yetkili, os.satis_sureci,
       os.organisation_id as UyeIsyeriID, os.mali_no as SerialNo, Terminal.test,
       fd5.label as SatisKanali, fd4.label as BeklemeNedeni, fd7.label as AramaDurumu,
       fd.label AS KayitTipi,
       IF(ISNULL(Terminal.first_activation_date)=TRUE,"Kurulmadı","Kuruldu") AS TerminalKurulmaDurumu,
       os.evrak_tamamlanma_tarihi as EvrakTamamlanmaTarihi,
       DATEDIFF(Terminal.first_activation_date,COALESCE(os.fatura_tarihi,os.talep_tarihi,os.welcome_tarihi)) as Fark,
       COALESCE(os.fatura_tarihi,os.talep_tarihi,os.welcome_tarihi) AS Tarih,
       Terminal.odeal_channel as TerminalKanalID,
       Terminal.odeal_terminal_id as TerminalID,
       Terminal.organizasyon,
       IF(DATE(os.sales_date)>os.welcome_tarihi,"VAR","YOK") as SatisWelcomeDurum,
       os.sales_date as SatisTarihi,
       os.fatura_tarihi as FaturaTarihi,
       os.talep_tarihi as TalepTarihi,
       os.welcome_tarihi as WelcomeTarihi,
       os.aksiyon_tarihi as AksiyonTarihi,
       Terminal.first_activation_date AS KurulumTarihi,
       Terminal.pasife_alinma_tarihi as TerminalPasiflenmeTarihi,
       os.satis_iptal_tarihi as SatisIptalTarihi,
       os.record_owner,
       DATE_FORMAT(os.sales_date,"%Y-%m") AS DonemSatis,
       DATE_FORMAT(Terminal.first_activation_date,"%Y-%m") AS KurulumDonem,
       IF(os.satis_iptal_edildi=0,"Hayır","Evet") AS SatisIptalDurum,
       Terminal.terminal_status,
       Terminal.Plan, Terminal.Hizmet,
       Terminal.odeal_id,
       fd2.label AS YazarKasaTipi,
       fd3.label AS SatisIptalSebebi,
       fd8.label as PosTaksitDurumu,
       sec.name as Sektor
FROM crm_potential cmp
LEFT JOIN odeal_satis os ON os.iliskili_firsat = cmp.crm_potential_id
LEFT JOIN crm_account ca ON ca.crm_account_id = os.crm_account
LEFT JOIN odeal_sector sec ON sec.odeal_sector_id = os.sektor
LEFT JOIN (SELECT ct.tc as TckNo, CONCAT(ct.firstname," ",ct.lastname) as Yetkili, ct.account_name FROM crm_contact ct WHERE ct.role = 1) as Contact ON Contact.account_name = ca.crm_account_id
LEFT JOIN field_data fd8 ON fd8.field_data_id = os.pos_taksit_durumu AND fd8.os_app_id = "odeal" AND fd8.os_model_id = "satis" AND fd8.field_id = "pos_taksit_durumu"
LEFT JOIN field_data fd5 ON fd5.field_data_id = os.satis_kanali AND fd5.os_app_id = "odeal" AND fd5.os_model_id = "satis" AND fd5.field_id = "satis_kanali"
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.satis_iptal_sebebi AND fd3.os_app_id = "odeal" AND fd3.os_model_id = "satis" AND fd3.field_id = "satis_iptal_sebebi"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.yazar_kasa_tipi AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_id = "yazar_kasa_tipi"
LEFT JOIN field_data fd4 ON fd4.field_data_id = os.bekleme_nedeni AND fd4.os_app_id = "odeal" AND fd4.os_model_id = "satis" AND fd4.field_id = "bekleme_nedeni"
LEFT JOIN field_data fd7 ON fd7.field_data_id = os.arama_durumu AND fd7.os_app_id = "odeal" AND fd7.os_model_id = "satis" AND fd7.field_id = "arama_durumu"
LEFT JOIN field_data fd ON fd.field_data_id = os.save_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_id = "save_type"
LEFT JOIN (SELECT ot.serial_no,ot.test, ot.first_activation_date, ot.pasife_alinma_tarihi, ot.odeal_channel, ot.odeal_terminal_id, ot.odeal_id,
                  ot.terminal_status, ot.organizasyon, ot.organisation_id, pln.name as Plan, srv.name as Hizmet FROM odeal_terminal ot
                    LEFT JOIN odeal_subscription sub ON sub.odeal_subscription_id = ot.abonelik
LEFT JOIN odeal_plan pln ON pln.odeal_plan_id = sub.plan
LEFT JOIN odeal_service srv ON srv.odeal_service_id = pln.service
WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot
GROUP BY ot.organisation_id, ot.serial_no)) AS Terminal ON Terminal.organisation_id = os.organisation_id
AND Terminal.serial_no = os.mali_no) AS Kurulumlar
LEFT JOIN (SELECT oys.odeal_yazarkasa_sokum_id, oys.created_on as KayitTarihi,
       CONCAT(u.firstname," ",u.lastname) as KayitSahibi, CONCAT(oys.donem_yil,"-",oys.donem_ay) as Donem,
       oys.terminal, ot.serial_no, oys.organizasyon,
       oys.sokum_durumu, oys.sokum_bekliyor,
       fd.label as SokumSonucu,
       fd1.label as DeaktifNedenleri,
        fd2.label as SokumDurumu
FROM odeal_yazarkasa_sokum oys
LEFT JOIN user u ON u.user_id = oys.record_owner
LEFT JOIN odeal_terminal ot ON ot.odeal_terminal_id = oys.terminal
LEFT JOIN field_data fd ON fd.field_data_id = oys.sokum_sonucu AND fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu"
LEFT JOIN field_data fd1 ON fd1.field_data_id = oys.deaktif_nedenleri AND fd1.os_app_id = "odeal" AND fd1.os_model_id = "yazarkasa_sokum" AND fd1.field_id = "deaktif_nedenleri"
LEFT JOIN field_data fd2 ON fd2.field_data_id = oys.sokum_durumu AND fd2.os_app_id = "odeal" AND fd2.os_model_id = "yazarkasa_sokum" AND fd2.field_id = "sokum_durumu"
WHERE oys.odeal_yazarkasa_sokum_id IN (
SELECT MAX(oys.odeal_yazarkasa_sokum_id) FROM odeal_yazarkasa_sokum oys
GROUP BY oys.organizasyon, oys.terminal)) as Iptaller ON Iptaller.terminal = Kurulumlar.TerminalID AND Iptaller.organizasyon = Kurulumlar.organizasyon
LEFT JOIN (SELECT * FROM (
SELECT ot.organisation_id, ot.odeal_id, ot.created_on, ot.odeal_terminal_id as TerminalID, ot.serial_no as MaliNo, IF(ISNULL(ti.ticket_issue_id),"YOK","VAR") as TalepDurum,
       IF(ISNULL(ti.ticket_issue_id),"YOK",JSON_ARRAYAGG(JSON_OBJECT('Talep Türü',ttt.subject,'Talep Tipi',tttip.subject,'Talep Alt Tipi',tatip.subject,'Yardım Talebi Açıklama',ti.subject,'Görev No',ti.issue_number,'Talep ID',ti.ticket_issue_id,'Talep Tarihi',
       DATE_FORMAT(ti.created_on,"%d-%m-%Y %hh:%ss")))) as YardimTalebi, ROW_NUMBER() over (PARTITION BY ot.organisation_id ORDER BY ot.created_on DESC) as Sira
FROM odeal_terminal ot
LEFT JOIN ticket_issue ti ON ot.odeal_terminal_id = ti.terminal
LEFT JOIN ticket_talep_turleri ttt ON ttt.ticket_talep_turleri_id = ti.talep_turu
LEFT JOIN ticket_talep_tipleri tttip ON tttip.ticket_talep_tipleri_id = ti.talep_tipi
LEFT JOIN ticket_talep_alttipleri tatip ON tatip.ticket_talep_alttipleri_id = ti.talep_alttipi
GROUP BY ti.terminal, ot.serial_no) as YT
WHERE YT.Sira = 1) as Yardim ON Yardim.MaliNo = Kurulumlar.SerialNo AND Yardim.TerminalID = Kurulumlar.TerminalID
LEFT JOIN odeal_channel ch ON ch.odeal_channel_id = Kurulumlar.TerminalKanalID
LEFT JOIN user u ON u.user_id = Kurulumlar.record_owner
LEFT JOIN field_data fd6 ON fd6.field_data_id = Kurulumlar.terminal_status AND fd6.os_app_id = "odeal" AND fd6.os_model_id = "terminal" AND fd6.field_id = "terminal_status"
WHERE Kurulumlar.KayitTipi = "Satışa Dönüştür" AND Kurulumlar.KurulumTarihi >= "2024-01-01 00:00:00"
AND Kurulumlar.SatisID IN (SELECT MAX(os.odeal_satis_id) FROM odeal_satis os GROUP BY os.organisation_id, os.mali_no);

-- Yardım Talebi var yok , adet, devam eden adet, (group_Concat, id, subject, türü, alt tipi) son 30 gün içerisindeki
-- Servis Talepleri, aggr(Ciro,adet, min max işlem tarihi), Aktivasyon Tarihin 2 ay

SELECT * FROM crm_account ca WHERE ca.tax_number = 2050064291

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "satis";

SELECT * FROM information_schema.COLUMNS c WHERE c.COLUMN_NAME LIKE "%lead%"

SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status FROM user u

SELECT os.odeal_satis_id, os.sales_date, os.mali_no, os.organisation_id FROM odeal_satis os WHERE os.mali_no IN ("2C16198761","BCI00001533")

SELECT ot.odeal_terminal_id, ot.serial_no, ot.ilk_kurulum_tarihi, ot.first_activation_date, ot.terminal_status FROM odeal_terminal ot WHERE ot.serial_no IN ("2C16198761","BCI00001533");

SELECT oys.odeal_yazarkasa_sokum_id, oys.created_on, fd.label as SokumSonucu, CONCAT(u.firstname," ",u.lastname) as KayitOlusturan,
CONCAT(u1.firstname," ",u1.lastname) as KayitSahibi FROM odeal_yazarkasa_sokum oys
LEFT JOIN user u ON u.user_id = oys.created_by
LEFT JOIN user u1 ON u1.user_id = oys.record_owner
LEFT JOIN field_data fd ON fd.field_data_id = oys.sokum_sonucu AND fd.os_app_id = "odeal" AND fd.os_model_id = "yazarkasa_sokum" AND fd.field_id = "sokum_sonucu"
WHERE oys.terminal IN (SELECT ot.odeal_terminal_id FROM odeal_terminal ot WHERE ot.serial_no IN ("2C16198761","BCI00001533"));

SELECT ct.tc as TCKNO, CONCAT(ct.firstname," ",ct.lastname) as Yetkili, ct.account_name FROM crm_contact ct
                         WHERE ct.account_name = 1386 AND ct.role = 1;

LEFT JOIN (SELECT ti.terminal as TerminalID, ot.serial_no as MaliNo,
       JSON_ARRAYAGG(JSON_OBJECT('Yardım Talebi Açıklama',ti.subject,'Görev No',ti.issue_number,'Talep ID',ti.ticket_issue_id,'Talep Tarihi',
       DATE_FORMAT(ti.created_on,"%d-%m-%Y %hh:%ss"))) as YardimTalebi
FROM ticket_issue ti
LEFT JOIN odeal_terminal ot ON ot.odeal_terminal_id = ti.terminal
WHERE ti.crm_account_id IS NOT NULL AND ti.terminal IS NOT NULL
GROUP BY ti.terminal, ot.serial_no) as Yardim ON Yardim.MaliNo = Kurulumlar.SerialNo AND Yardim.TerminalID = Kurulumlar.TerminalID

SELECT * FROM (
SELECT ot.organisation_id, ot.odeal_id, ot.created_on, ot.odeal_terminal_id as TerminalID, ot.serial_no as MaliNo, IF(ISNULL(ti.ticket_issue_id),"YOK","VAR") as TalepDurum,
       IF(ISNULL(ti.ticket_issue_id),"YOK",JSON_ARRAYAGG(JSON_OBJECT('Talep Türü',ttt.subject,'Talep Tipi',tttip.subject,'Talep Alt Tipi',tatip.subject,'Yardım Talebi Açıklama',ti.subject,'Görev No',ti.issue_number,'Talep ID',ti.ticket_issue_id,'Talep Tarihi',
       DATE_FORMAT(ti.created_on,"%d-%m-%Y %hh:%ss")))) as YardimTalebi, ROW_NUMBER() over (PARTITION BY ot.organisation_id ORDER BY ot.created_on DESC) as Sira
FROM odeal_terminal ot
LEFT JOIN ticket_issue ti ON ot.odeal_terminal_id = ti.terminal
LEFT JOIN ticket_talep_turleri ttt ON ttt.ticket_talep_turleri_id = ti.talep_turu
LEFT JOIN ticket_talep_tipleri tttip ON tttip.ticket_talep_tipleri_id = ti.talep_tipi
LEFT JOIN ticket_talep_alttipleri tatip ON tatip.ticket_talep_alttipleri_id = ti.talep_alttipi
WHERE ot.serial_no = "BCE00016703"
GROUP BY ti.terminal, ot.serial_no) as YT
WHERE YT.Sira = 1;

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "terminal";

49540

SELECT os.organisation_id as UyeIsyeriID, os.mali_no as MaliNo, os.invoice_total,
       os.sales_date as SatisTarih FROM odeal_satis os WHERE os.organisation_id IS NOT NULL;

SELECT ot.odeal_terminal, MIN(ot.transaction_date) as IlkIslemTarihi, MAX(ot.transaction_date) as SonIslemTarihi,
       MAX(ot.commision_rate) as SonIslemKomisyon,
       SUM(ot.amount) as Ciro, COUNT(ot.odeal_transaction_id) as IslemAdet FROM odeal_transaction ot
         JOIN field_data fd ON fd.field_data_id = ot.transaction_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "transaction" AND fd.field_id = "transaction_status"
         WHERE ot.transaction_status = 1 AND ot.odeal_terminal IS NOT NULL
GROUP BY ot.odeal_terminal

SELECT ot.odeal_terminal, ot.transaction_status,  MIN(ot.transaction_date) as IlkIslemTarihi, MAX(ot.transaction_date) as SonIslemTarihi,
       MAX(ot.commision_rate) as SonIslemKomisyon,
       SUM(ot.amount) as Ciro, COUNT(ot.odeal_transaction_id) as IslemAdet FROM odeal_transaction ot
         JOIN field_data fd ON fd.field_data_id = ot.transaction_status AND fd.os_app_id = "odeal" AND fd.os_model_id = "transaction" AND fd.field_id = "transaction_status"
         WHERE ot.odeal_terminal = 49540 AND fd.label = "Başarılı"
GROUP BY ot.odeal_terminal, ot.transaction_status

SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 2 MONTH),"%Y-%m-01 00:00:00")

SELECT * FROM odeal_web_form owf
         LEFT JOIN field_data fd ON fd.field_data_id = owf.contact_type AND fd.os_app_id = "odeal" AND fd.os_model_id = "web_form" AND fd.field_id = "contact_type"
         WHERE owf.webform_referer IS NULL ORDER BY owf.created_on DESC

SELECT os.web_form_numarasi, os.sales_date, os.mali_no, os.organisation_id, os.lead, owf.odeal_web_form_id, owf.utm_source,owf.ip FROM odeal_satis os
                                                                                    LEFT JOIN odeal_web_form owf ON owf.odeal_web_form_id = os.web_form_numarasi WHERE owf.ip IS NOT NULL
                                                                                    ORDER BY os.web_form_numarasi DESC