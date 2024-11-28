SELECT * FROM odeal_talep ot

SELECT t.TABLE_NAME, c.COLUMN_NAME FROM information_schema.TABLES t
JOIN information_schema.COLUMNS c ON c.TABLE_NAME = t.TABLE_NAME
WHERE t.TABLE_NAME = "odeal_talep"

SELECT
ot.odeal_talep_id, ot.created_on as TalepOlusturulmaTarihi, ot.onay_tarihi, fd.label as HizmetTeslimSuresi, fd3.label as IstihbaratDurum,
fd4.label as MusteriyeBildirimTipi, fd5.label as OnayDurumu, fd6.label as RiskDurumu, fd7.label as SonDurum, fd8.label as TalepTipi,
ot.gorusuluyor, onay_kullanici, crm_account, su_anki_limit, talep_edilen_limit,
onaylanan_limit, CONCAT(u.firstname," ",u.lastname) as 1onay, fd2.label as IlkOnayDurumu, CONCAT(u2.firstname," ",u2.lastname) as 2onay,
onay_durumu, istihbarat_gonderildi, istihbarat_aciklama, istihbarat_durum, isyeri_puan_sorgu, risk_durumu, puan_sorgu_aciklama
FROM odeal_talep ot
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "talep" AND fd.field_data_id = ot.hizmet_teslim_suresi AND fd.field_id = "hizmet_teslim_suresi"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "talep" AND fd2.field_data_id = ot.ilk_onay_durumu AND fd2.field_id = "ilk_onay_durumu"
LEFT JOIN field_data fd3 ON fd3.os_app_id = "odeal" AND fd3.os_model_id = "talep" AND fd3.field_data_id = ot.istihbarat_durum AND fd3.field_id = "istihbarat_durum"
LEFT JOIN field_data fd4 ON fd4.os_app_id = "odeal" AND fd4.os_model_id = "talep" AND fd4.field_data_id = ot.musteriye_bildirim_tipi AND fd4.field_id = "musteriye_bildirim_tipi"
LEFT JOIN field_data fd5 ON fd5.os_app_id = "odeal" AND fd5.os_model_id = "talep" AND fd5.field_data_id = ot.onay_durumu AND fd5.field_id = "onay_durumu"
LEFT JOIN field_data fd6 ON fd6.os_app_id = "odeal" AND fd6.os_model_id = "talep" AND fd6.field_data_id = ot.risk_durumu AND fd5.field_id = "risk_durumu"
LEFT JOIN field_data fd7 ON fd7.os_app_id = "odeal" AND fd7.os_model_id = "talep" AND fd7.field_data_id = ot.son_durum AND fd7.field_id = "son_durum"
LEFT JOIN field_data fd8 ON fd8.os_app_id = "odeal" AND fd8.os_model_id = "talep" AND fd8.field_data_id = ot.talep_tipi AND fd8.field_id = "talep_tipi"
LEFT JOIN user u ON u.user_id = ot.`1onay`
LEFT JOIN user u2 ON u2.user_id = ot.`2onay`
WHERE ot.created_on >= "2024-01-01 00:00:00"

SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "talep";

SELECT * FROM information_schema.COLUMNS c

SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY LimitErtesi.record_id ORDER BY LimitErtesi.DegisimTarihi ASC) as Sira2
FROM (SELECT *, ROW_NUMBER() over (PARTITION BY LimitTablosu.record_id ORDER BY LimitTablosu.DegisimTarihi DESC) as Sira FROM (
SELECT h.history_id, hr.record_id, hr.data, h.created_on as DegisimTarihi,
       FIRST_VALUE(h.created_on) over (PARTITION BY hr.record_id ORDER BY h.created_on ASC) as IlkOlusmaTarihi,
JSON_SEARCH(NULLIF(data,''), 'one', '1onay') AS JSONSearch,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.cfd_son_durum_label')) AS EskiAramaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_son_durum_label')) AS YeniAramaDurum, otalep.crm_account, fd.label as SonDurum, ca.unvan, ca.name as Marka
FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
LEFT JOIN odeal_talep otalep ON otalep.odeal_talep_id = hr.record_id
LEFT JOIN field_data fd ON fd.field_data_id = otalep.son_durum AND fd.os_app_id = "odeal" AND fd.os_model_id = "talep" AND fd.field_id = "son_durum"
LEFT JOIN crm_account ca ON ca.crm_account_id = otalep.crm_account
WHERE h.os_app_id = "odeal" AND h.os_model_id = "talep" AND hr.record_id = 13081) as LimitTablosu) as LimitErtesi
WHERE LimitErtesi.Sira = 1 AND LimitErtesi.data IS NOT NULL) as LE WHERE LE.Sira2 = 1;

SELECT * FROM (
SELECT *,
            ROW_NUMBER() over (PARTITION BY LimitErtesiGun2.record_id, LimitErtesiGun2.EskiAramaDurum ORDER BY LimitErtesiGun2.KayitTarihi ASC) as Sira2 FROM (
SELECT *, IF(JSON_VALID(LimitErtesiGun.EskiAramaDurum)=TRUE,"DOĞRU","HATALI") as json_durum1,
            ROW_NUMBER() over (PARTITION BY LimitErtesiGun.record_id, LimitErtesiGun.JSONSearch ORDER BY LimitErtesiGun.KayitTarihi ASC) as Sira FROM (
SELECT h.history_id, hr.data, hr.record_id, h.created_on as KayitTarihi, h.created_by, CONCAT(u.firstname," ",u.lastname) as KayitSahibi,
       JSON_SEARCH(NULLIF(data,''), 'one', 'cfd_son_durum_label') AS JSONSearch,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.cfd_son_durum_label')) AS EskiAramaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_son_durum_label')) as YeniAramaDurum,
FIRST_VALUE(h.created_on) over (PARTITION BY hr.record_id) as IlkOlusmaTarihi,
LAST_VALUE(h.created_on) over (PARTITION BY hr.record_id) as SonKayitTarihi,
IFNULL(LAST_VALUE(JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_son_durum_label'))) over (PARTITION BY hr.record_id),JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_son_durum_label'))) as SonKayitSonDurum
FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
JOIN user u ON u.user_id = h.created_by
WHERE h.os_app_id = "odeal" AND h.os_model_id = "talep" AND hr.data IS NOT NULL AND hr.record_id = 13205) as LimitErtesiGun WHERE LimitErtesiGun.EskiAramaDurum IS NOT NULL
) as LimitErtesiGun2 WHERE LimitErtesiGun2.Sira = 1 AND LimitErtesiGun2.EskiAramaDurum = "null") as LimitErtesiGun3 WHERE LimitErtesiGun3.Sira2 = 1;

12449

SELECT * FROM odeal_invoice oi WHERE oi.e_invoice_no = "OCA2024000005196"

SELECT Ceptepos.Olusturan, COUNT(*) as Adet FROM (
SELECT ca.odeal_id, ca.name as Marka, ca.unvan as Unvan, os.odeal_id as AbonelikID,
       p.name as Plan, ser.name as Hizmet, CONCAT(u.firstname," ",u.lastname) as KayitSahibi,
       CONCAT(u2.firstname," ",u2.lastname) as Olusturan
FROM crm_account ca
JOIN odeal_subscription os ON os.organization_odeal_id = ca.odeal_id
JOIN odeal_plan p ON p.odeal_plan_id = os.plan
JOIN odeal_service ser ON ser.odeal_service_id = p.service
JOIN user u ON u.user_id = os.record_owner
JOIN user u2 ON u2.user_id = os.created_by
                                      WHERE ser.odeal_service_id = 4) as Ceptepos
GROUP BY Ceptepos.Olusturan;

SELECT * FROM user u WHERE u.firstname LIKE "%mazlum%"

SELECT ocpit.odeal_cepte_pos_iptal_talebi_id,
       ca.odeal_id as UyeIsyeriId,
       ca.name as Marka,
       ca.unvan as Unvan,
       CONCAT(u.firstname," ",u.lastname) as KayitAcan,
       CONCAT(u2.firstname," ",u2.lastname) as KayitSahibi,
       ocpit.abonelik as AbonelikID,
       p.name as Plan,
       ser.name as Hizmet,
        fd.label as SokumTalebi, fd2.label as DeaktifNedeni
FROM odeal_cepte_pos_iptal_talebi ocpit
LEFT JOIN crm_account ca ON ca.crm_account_id = ocpit.organizasyon
LEFT JOIN odeal_subscription os ON os.organization_odeal_id = ca.odeal_id
LEFT JOIN odeal_plan p ON p.odeal_plan_id = os.plan
LEFT JOIN odeal_service ser ON ser.odeal_service_id = p.service
LEFT JOIN user u ON u.user_id = ocpit.created_by
LEFT JOIN user u2 ON u2.user_id = ocpit.record_owner
LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "cepte_pos_iptal_talebi" AND fd.field_data_id = ocpit.sokum_talebi AND fd.field_id = "sokum_talebi"
LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "cepte_pos_iptal_talebi" AND fd2.field_data_id = ocpit.deaktif_nedenleri AND fd2.field_id = "deaktif_nedenleri"
WHERE ocpit.created_by = 15847 AND ser.odeal_service_id = 4
ORDER BY ocpit.odeal_cepte_pos_iptal_talebi_id DESC

SELECT ot.odeal_talep_id, ot.crm_account,
       ot.onay_tarihi,
       ot.sektor,
       ot.agent_yorum,
       ot.uretilen_ciro,
       ot.islem_adedi,
       ot.su_anki_limit,
       ot.talep_edilen_limit,
       ot.onaylanan_limit,
       fd.label as SonDurum,
       fd1.label as TalepTipi,
       CONCAT(u1.firstname," ",u1.lastname) as OnayKullanici,
       CONCAT(u.firstname," ",u.lastname) as Olusturan,
       ot.created_on as OlusmaTarihi,
       CONCAT(u2.firstname," ",u2.lastname) as KayitSahibi,
       CONCAT(u3.firstname," ",u3.lastname) as SonGuncelleyen,
       ot.last_modified_on as SonGuncellenmeTarihi,
       ca.odeal_id as UyeID,
       ca.unvan as Unvan,
       ca.name as Marka,
       fd2.label as SirketTipi,
       ac.city_name as Sehir,
       fd3.label as IsyeriDurum,
       ca.account_type
FROM odeal_talep ot
LEFT JOIN user u ON u.user_id = ot.created_by
LEFT JOIN user u1 on u1.user_id = ot.onay_kullanici
LEFT JOIN user u2 ON u2.user_id = ot.record_owner
LEFT JOIN user u3 ON u3.user_id = ot.last_modified_by
LEFT JOIN field_data fd ON fd.field_data_id = ot.son_durum AND fd.os_app_id = "odeal" AND fd.os_model_id = "talep" AND fd.field_id = "son_durum"
LEFT JOIN field_data fd1 ON fd1.field_data_id = ot.talep_tipi AND fd1.os_app_id = "odeal" AND fd1.os_model_id = "talep" AND fd1.field_id = "talep_tipi"
LEFT JOIN crm_account ca ON ca.crm_account_id = ot.crm_account
LEFT JOIN field_data fd2 ON fd2.field_data_id = ca.basvuru_account_type AND fd2.os_app_id = 'crm' AND fd2.os_model_id = 'account' AND fd2.field_id = 'basvuru_account_type'
LEFT JOIN field_data fd3 ON fd3.field_data_id = ca.account_type AND fd3.os_app_id = 'crm' AND fd3.os_model_id = 'account' AND fd3.field_id = 'account_type'
LEFT JOIN addr_city ac ON ac.addr_city_id = ca.billing_city
WHERE ca.account_type = 2 AND ot.odeal_talep_id =5756;

SELECT * FROM field_data fd WHERE fd.os_model_id = "account" AND fd.os_app_id = "crm";

SELECT ot.odeal_talep_id,
       ot.crm_account,
       ot.onay_tarihi,
       ot.sektor,
       ot.agent_yorum,
       ot.uretilen_ciro,
       ot.islem_adedi,
       ot.su_anki_limit,
       ot.talep_edilen_limit,
       ot.onaylanan_limit,
       ot.
       fd.label as SonDurum,
       fd1.label as TalepTipi,
       CONCAT(u1.firstname," ",u1.lastname) as OnayKullanici,
       CONCAT(u.firstname," ",u.lastname) as Olusturan,
       ot.created_on as OlusmaTarihi,
       CONCAT(u2.firstname," ",u2.lastname) as KayitSahibi,
       CONCAT(u3.firstname," ",u3.lastname) as SonGuncelleyen,
       ot.last_modified_on as SonGuncellenmeTarihi
FROM odeal_talep ot
LEFT JOIN user u ON u.user_id = ot.created_by
LEFT JOIN user u1 on u1.user_id = ot.onay_kullanici
LEFT JOIN user u2 ON u2.user_id = ot.record_owner
LEFT JOIN user u3 ON u3.user_id = ot.last_modified_by
LEFT JOIN field_data fd ON fd.field_data_id = ot.son_durum AND
                           fd.os_app_id = "odeal"
                               AND fd.os_model_id = "talep" AND fd.field_id = "son_durum"
LEFT JOIN field_data fd1 ON fd1.field_data_id = ot.talep_tipi AND
                            fd1.os_app_id = "odeal" AND fd1.os_model_id = "talep" AND fd1.field_id = "talep_tipi";

SELECT oi.subscription_id, oi.created_on, fd.label, oi.total_amount, oi.remaining_amount, oi.odeal_invoice_id, oi.odeal_id as FaturaID, oi.organizasyon_id, Gecmis2.* FROM odeal_invoice oi
         JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "invoice" AND fd.field_data_id = oi.invoice_status AND fd.field_id = "invoice_status"
        LEFT JOIN (SELECT * FROM (
SELECT h.created_on, hr.record_id,
ROW_NUMBER() OVER (PARTITION BY hr.record_id ORDER BY h.created_on DESC) as Sira,
FIRST_VALUE(h.created_on) over (PARTITION BY hr.record_id ORDER BY h.created_on ASC) as IlkTarih,
JSON_SEARCH(NULLIF(data,''), 'one', 'cfd_invoice_status_label') AS JSONSearch,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.invoice_status')) AS EskiFaturaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.invoice_status')) as YeniFaturaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.cfd_invoice_status_label')) AS EskiFatura,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_invoice_status_label')) as YeniFatura
       FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
WHERE h.os_app_id = "odeal" AND h.os_model_id = "invoice") as Gecmis
WHERE Gecmis.Sira = 1 AND Gecmis.JSONSearch IS NOT NULL) as Gecmis2 ON Gecmis2.record_id = oi.odeal_invoice_id
        WHERE oi.organizasyon_id = 301260283;




SELECT * FROM field_data fd WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "invoice"

SELECT * FROM (
SELECT h.created_on,
ROW_NUMBER() OVER (PARTITION BY hr.record_id ORDER BY h.created_on DESC) as Sira,
FIRST_VALUE(h.created_on) over (PARTITION BY hr.record_id ORDER BY h.created_on ASC) as IlkTarih,
JSON_SEARCH(NULLIF(data,''), 'one', 'cfd_invoice_status_label') AS JSONSearch,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.invoice_status')) AS EskiFaturaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.invoice_status')) as YeniFaturaDurum,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.cfd_invoice_status_label')) AS EskiFatura,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_invoice_status_label')) as YeniFatura
       FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
WHERE h.os_app_id = "odeal" AND h.os_model_id = "invoice" AND hr.record_id = 1127998) as Gecmis
WHERE Gecmis.Sira = 1 AND Gecmis.JSONSearch IS NOT NULL

