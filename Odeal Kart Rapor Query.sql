-- Ana Sorgu

SELECT s.account_no,
       s.merchant_id,
       s.transferred_account_id,
       s.id as SourceID,
       s.terminal_id,
       t.serial_no,
       s.tckn,
       s.masked_card_number as KartNo,
       CASE WHEN s.status = 'ACTIVATED' THEN 'AKTİF'
            WHEN s.status = 'OTHER' THEN 'DİĞER'
            WHEN s.status = 'WAITING_VERIFICATION' THEN 'DOĞRULAMA BEKLENİYOR'
            WHEN s.status = 'CANCELED' THEN 'İPTAL'
       END as KartBasvuruDurum,
       s.reason as KartDurum,
       s.request_date as TalepTarihi,
       s.group_date as BasimTarihi,
       s.available_amount as KartBakiyesi,
       DATEDIFF(DATE(s.group_date), DATE(s.request_date)) as Talep_BasimGunFark,
       s._createdDate
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
LEFT JOIN (SELECT s.id as SourceID,
       s.tckn,
       s.vkn,
       s.merchant_id,
       s.terminal_id,
       s.status,
       log.entity_id,
       log.error_message,
       log.trace_id
FROM payout_source.source s
JOIN (SELECT * FROM payout_source.request_response_logs r WHERE r.id IN (
SELECT MAX(r.id) FROM payout_source.request_response_logs r
GROUP BY r.entity_id)) as log ON s.id = log.entity_id
WHERE s.type='FIBACARD' AND status='WAITING_VERIFICATION') as Hata ON Hata.tckn = s.tckn
WHERE s.type = 'FIBACARD' AND s.merchant_id <> 301196774
AND s.merchant_id NOT IN (301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032,301160192)
AND s.status <> 'CANCELED'
AND Hata.tckn IS NOT NULL) as ANA GROUP BY ANA.merchant_id;

SELECT s.id as SourceID,
       s.tckn,
       s.vkn,
       s.merchant_id,
       s.terminal_id,
       s.status,
       log.entity_id,
       log.error_message,
       log.trace_id
FROM payout_source.source s
JOIN (SELECT * FROM payout_source.request_response_logs r WHERE r.id IN (
SELECT MAX(r.id) FROM payout_source.request_response_logs r
GROUP BY r.entity_id)) as log ON s.id = log.entity_id
WHERE s.type='FIBACARD' AND status='WAITING_VERIFICATION'


SELECT
COUNT(DISTINCT AktifKart.KartSifreUyeID) as AktifAdet,
DATE(AktifKart.PinSetDate) as Gun
FROM payout_source.source s
JOIN (SELECT s.tckn, s.merchant_id as KartSifreUyeID, s.account_no,
       MAX(COALESCE(cd.first_pin_set_date,cd.last_pin_set_date)) as PinSetDate
FROM payout_source.source s
JOIN payout_source.card_detail cd ON cd.tckn = s.tckn
WHERE cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.tckn)
AND s.type = 'FIBACARD'
AND s.merchant_id NOT IN (301196774,301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032)
AND s.status <> 'CANCELED' GROUP BY s.tckn, s.merchant_id, s.account_no) as AktifKart ON AktifKart.KartSifreUyeID = s.merchant_id
WHERE s.type = 'FIBACARD'
AND s.merchant_id NOT IN (301196774,301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032)
AND s.status <> 'CANCELED'
GROUP BY DATE(AktifKart.PinSetDate)

-- Başvuru Form
SELECT os.organisation_id, os.mali_no, os.created_by, os.record_owner,
       CONCAT(u2.firstname," ",u2.lastname) as SatisTemsilcisi,
       ur.role_name, up.profile_name as KayitSahibiRolu,
       os.sales_date,  IF(os.fibakart_fiziki_formu_gonderildi=1,"Fiziki Form Gönderildi","Fiziki Form Gönderilmedi") AS FormDurumu, Terminal.ilk_kurulum_tarihi as KurulumTarihi, fd4.label as AramaDurumu,
os.fibakart_fiziki_formu_son_gonderilme_tarihi as FizikiFormGonderilmeTarihi
FROM odeal_satis os
JOIN (SELECT ot.odeal_terminal_id, ot.serial_no, ot.organisation_id, ot.ilk_kurulum_tarihi, ot.odeal_channel FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot GROUP BY ot.serial_no, ot.organisation_id)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id
LEFT JOIN user u ON u.user_id = os.created_by
LEFT JOIN user u2 ON u2.user_id = os.record_owner
LEFT JOIN user_role ur ON ur.user_role_id = u.user_role_id
LEFT JOIN user_profile up ON up.user_profile_id = u2.user_profile_id
LEFT JOIN field_data fd4 ON fd4.field_data_id = os.arama_durumu AND fd4.os_app_id = 'odeal' AND fd4.os_model_id = 'satis' AND fd4.field_id = 'arama_durumu'
WHERE os.sales_date IS NOT NULL AND os.odeal_satis_id IN (SELECT MAX(os.odeal_satis_id) FROM odeal_satis os
GROUP BY os.organisation_id, os.mali_no)

-- Hata
SELECT s.id as SourceID,
       s.tckn,
       s.vkn,
       s.merchant_id,
       s.terminal_id,
       s.status,
       log.entity_id,
       log.error_message,
       log.trace_id
FROM payout_source.source s
JOIN (SELECT * FROM payout_source.request_response_logs r WHERE r.id IN (
SELECT MAX(r.id) FROM payout_source.request_response_logs r
GROUP BY r.entity_id)) as log ON s.id = log.entity_id
WHERE s.type='FIBACARD' AND status='WAITING_VERIFICATION'

-- IBAN
SELECT bi.*
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
LEFT JOIN odeal.BankInfo bi ON bi.organisationId = s.merchant_id
WHERE bi.status = 1

-- KART HAREKETLERİ
SELECT o.id as UyeID,
       t.serial_no as MaliNo,
       ct.transaction_date as IslemTarihi,
       ct.transaction_type as IslemDurum,
       ct.description as IslemTanimi,
       ct.amount as IslemTutar,
       s.account_no as KartNo,
       CASE WHEN ct.direction = 'INCOMING' THEN 'Karta Yatan'
            WHEN ct.direction = 'OUTGOING' THEN 'Harcanan' END as KartHareketi
FROM payout_source.source s
LEFT JOIN payout_source.card_transaction ct ON ct.merchant_id = s.merchant_id AND ct.card_number = s.account_no
LEFT JOIN odeal.Organisation o ON o.id = s.merchant_id
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
WHERE s.type = 'FIBACARD' AND s.merchant_id
NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622);

-- KART ŞİFRE DETAY
SELECT cd.first_pin_set_date as firstPinSetDate,
       cd.last_pin_change_date as LastPinChangeDate,
       cd.last_pin_set_date as LastPinSetDate,
COALESCE(cd.first_pin_set_date,cd.last_pin_set_date) as PinSetDate,
       s.merchant_id,
       s.tckn
FROM payout_source.card_detail cd
JOIN payout_source.source s ON s.tckn = cd.tckn
WHERE s.type = "FIBACARD" AND s.status <> "CANCELED"
AND s.merchant_id NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)
AND cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.tckn)


-- KART ŞİFRE DETAY - TCKN
SELECT cd.first_pin_set_date as firstPinSetDate,
       cd.last_pin_change_date as LastPinChangeDate,
       cd.last_pin_set_date as LastPinSetDate,
COALESCE(cd.first_pin_set_date,cd.last_pin_set_date) as PinSetDate,
       s.terminal_id,
       s.merchant_id
FROM payout_source.card_detail cd
JOIN payout_source.source s ON s.merchant_id = cd.merchant_id
WHERE cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.merchant_id)

SELECT cd.first_pin_set_date as firstPinSetDate,
       cd.last_pin_change_date as LastPinChangeDate,
       cd.last_pin_set_date as LastPinSetDate,
COALESCE(cd.first_pin_set_date,cd.last_pin_set_date) as PinSetDate,
       s.terminal_id,
       s.merchant_id,
       s.tckn
FROM payout_source.card_detail cd
JOIN payout_source.source s ON s.tckn = cd.tckn
WHERE cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.tckn)

SELECT * FROM payout_source.source s WHERE s.type = "SEKERCARD"

SELECT * FROM payout_source.card_transaction ct WHERE ct.tckn = 26818206564;

-- KURYE BİLGİLERİ
SELECT *
FROM (
SELECT cch.id,
       cch.tckn,
       s.merchant_id,
       cch.card_number,
       cch.type,
       s.available_amount,
       s.terminal_id,
       JSON_UNQUOTE(s.metadata->'$.customerNumber') AS CustomerNumber,
       JSON_UNQUOTE(s.metadata->'$.cardRefNumber') AS cardRefNumber,
       cch.courier_company,
       cch.courier_date,
       cch.courier_main_status as KuryeDurum,
       cch.courier_detail_status as KuryeDetayDurum,
       cch.barcode_number as GonderiNo,
ROW_NUMBER() over (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS SonTarih,
STR_TO_DATE(IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS DagitimTarihi,
STR_TO_DATE(IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
         JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1;

SELECT * FROM (
SELECT *, IF(Kontrol.SonID<>Kontrol.SonID2,"Farklı","Eşit") as IDDurum, IF(Kontrol.SonTarih<>Kontrol.SonTarih2,"Farklı","Eşit") as TarihDurum FROM (
SELECT Kurye.merchant_id, Kurye.card_number, MAX(Kurye.id) as SonID, MAX(Kurye.SonTarih) as SonTarih, MAX(Kurye.SonDurum) as SonDurum,
       MAX(Kurye2.id) as SonID2, MAX(Kurye2.SonTarih) as SonTarih2, MAX(Kurye2.SonDurum) as SonDurum2 FROM (
SELECT *
FROM (
SELECT cch.id,
       cch.tckn,
       s.merchant_id,
       cch.card_number,
       cch.type,
       s.available_amount,
       s.terminal_id,
       JSON_UNQUOTE(s.metadata->'$.customerNumber') AS CustomerNumber,
       JSON_UNQUOTE(s.metadata->'$.cardRefNumber') AS cardRefNumber,
       cch.courier_company,
       cch.courier_date,
       cch.courier_main_status as KuryeDurum,
       cch.courier_detail_status as KuryeDetayDurum,
       cch.barcode_number as GonderiNo,
ROW_NUMBER() over (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS SonTarih,
STR_TO_DATE(IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS DagitimTarihi,
STR_TO_DATE(IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
         JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1) as Kurye
LEFT JOIN (SELECT *
FROM (
SELECT cch.id,
       cch.tckn,
       s.merchant_id,
       cch.card_number,
       cch.type,
       s.available_amount,
       s.terminal_id,
       JSON_UNQUOTE(s.metadata->'$.customerNumber') AS CustomerNumber,
       JSON_UNQUOTE(s.metadata->'$.cardRefNumber') AS cardRefNumber,
       cch.courier_company,
       cch.courier_date,
       cch.courier_main_status as KuryeDurum,
       cch.courier_detail_status as KuryeDetayDurum,
       cch.barcode_number as GonderiNo,
ROW_NUMBER() over (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.id DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS SonTarih,
STR_TO_DATE(IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS DagitimTarihi,
STR_TO_DATE(IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
         JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1) as Kurye2
    ON Kurye2.merchant_id = Kurye.merchant_id
           AND Kurye2.terminal_id = Kurye.terminal_id
           AND Kurye2.tckn = Kurye.tckn
GROUP BY Kurye.merchant_id, Kurye.card_number) as Kontrol) as Kontrol2 WHERE Kontrol2.IDDurum = "Farklı" OR Kontrol2.TarihDurum = "Farklı";


SELECT * FROM payout_source.card_courier_history cch WHERE cch.card_number = "1201241930005744785"

SELECT * FROM odeal.Terminal t
         JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
         JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
         WHERE t.organisation_id = 301277233

SELECT * FROM odeal.BinInfo bi;

SELECT ct.tckn, ct.card_number, ct.amount, ct.transaction_date, ct.description
FROM payout_source.card_transaction ct
WHERE ct.tckn = 26818206564
AND ct.type = "FIBACARD"
AND ct.transaction_type = "CURRENT"
AND ct.direction = "INCOMING";

SELECT t.deactivationDate, t.serial_no, t.firstActivationDate, t.organisation_id FROM odeal.Terminal t WHERE t.serial_no = "2B25002165"

SELECT *
FROM (
SELECT cch.id,
       cch.tckn,
       s.merchant_id,
       CASE WHEN o.businessType = 0 THEN "BİREYSEL"
           WHEN o.businessType = 1 THEN "ŞAHIS"
           WHEN o.businessType = 2 THEN "TÜZEL"
           WHEN o.businessType = 3 THEN "DERNEK, APT. YÖNETİCİLİĞİ" END as IsyeriTipi,
       s.status,
       s.metadata,
       cch.card_number,
       cch.type,
       cch.courier_company,
       cch.courier_date,
       cch.courier_main_status as KuryeDurum,
       cch.courier_detail_status as KuryeDetayDurum,
       cch.barcode_number as GonderiNo,
ROW_NUMBER() over (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS SonTarih,
STR_TO_DATE(IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS DagitimTarihi,
STR_TO_DATE(IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
JOIN odeal.Organisation o ON o.id = s.merchant_id
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1;


SELECT * FROM odeal.Terminal t WHERE t.serial_no = "PAX710065911";

SELECT * FROM odeal.MerchantEnvelopeHistory meh WHERE meh.merchant_id = 301276793;

301000859 48715825426 1201242050005766539
301001218 12085580728 1101243020006039141

-- KURYE DAĞITIM DETAY
SELECT KuryeTarih.tckn, KuryeTarih.merchant_id, KuryeTarih.card_number, KuryeTarih.type, KuryeTarih.courier_company, KuryeTarih.barcode_number,
KuryeTarih.courier_main_status,
KuryeTarih.courier_detail_status, KuryeTarih.courier_date, KuryeTarih.SonTarih, KuryeTarih.TeslimTarihi, KuryeTarih.IlkKuryeTarih,
KuryeTarih.SonDurum, KuryeTarih.SonDurumDetay, DATEDIFF(KuryeTarih.SonTarih,KuryeTarih.courier_date) as FarkGun,
KuryeTarih.Sira
FROM (
SELECT s.tckn,s.merchant_id, cch.card_number, s.type, cch.courier_company, cch.barcode_number, cch.courier_main_status, cch.courier_detail_status, cch.courier_date,
ROW_NUMBER() OVER (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date) as Sira,
FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number) AS IlkKuryeTarih,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonTarih,
IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number)),"%Y-%m-%d %H:%i:%s"),null) AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
) as KuryeTarih WHERE KuryeTarih.Sira = 1
AND KuryeTarih.tckn NOT IN (SELECT s.tckn FROM payout_source.source s WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622))
ORDER BY KuryeTarih.tckn, KuryeTarih.courier_date;

SELECT s.tckn FROM payout_source.source s WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)

-- MÜŞTERİ NO
SELECT s.merchant_id,
       s.terminal_id,
       s.account_no,
       s.reason,
       s.tckn,
       JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"')) as MusteriNo
FROM payout_source.source s
WHERE JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"')) IN
(SELECT MAX(JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"'))) FROM payout_source.source s GROUP BY s.merchant_id)

-- TERMINAL ABONELIK
SELECT t.serial_no as MaliNo,
       t.id as TerminalID,
       t.organisation_id as UyeIsyeriID,
       IF(t.terminalStatus=1,'Aktif','Pasif') as TerminalDurumu,
       t.firstActivationDate as TerminalAktivasyonTarihi,
       s.id as AbonelikID,
       s.activationDate as AbonelikAktivasyonTarihi,
       s.cancelledAt as AbonelikIptalTarihi,
       p.id as PlanID,
       ser.name as Hizmet,
       p.name as PlanAd,
       sor.merchant_id,
       sor.terminal_id
FROM payout_source.source sor
JOIN odeal.Terminal t ON sor.terminal_id = t.id AND sor.merchant_id = t.organisation_id
JOIN subscription.Subscription s ON t.subscription_id = s.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId

-- ÜYE İŞYERİ
SELECT o.id as UyeIsyeriID,
       o.unvan,
       o.marka,
       IF(o.isActivated = 1,'Aktif','Pasif') as OrgDurum,
       CONCAT(m.firstName,' ',m.LastName) as Yetkili,
       m.phone as Iletisim
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0 AND o.id IN (SELECT DISTINCT s.merchant_id FROM payout_source.source s WHERE s.type = "FIBACARD")

-- IŞLEMLER
SELECT DISTINCT t.organisation_id as UyeIsyeriID,
       t.serial_no as MaliNo,
       t.id as TerminalID,
       LAST_VALUE(bp.signedDate) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SonIslemTarihi,
       SUM(bp.amount) OVER (PARTITION BY s.merchant_id, s.terminal_id) as ToplamTutar,
       SUM(CASE WHEN bp.appliedRate = 0 THEN bp.amount END) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SifirKomisyonCiro,
       s.merchant_id,
       s.terminal_id
FROM payout_source.source s
JOIN odeal.Terminal t ON t.organisation_id = s.merchant_id AND t.id = s.terminal_id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= t.firstActivationDate
WHERE s.type = 'FIBACARD'


-- KART HAREKETLERİ
SELECT ct.merchant_id as UyeID,
       ct.transaction_date as IslemTarihi,
       ct.transaction_type as IslemDurum,
       ct.description as IslemTanimi,
       ct.amount as IslemTutar,
       ct.card_number as KartNo,
       CASE WHEN ct.direction = 'INCOMING' THEN 'Karta Yatan'
            WHEN ct.direction = 'OUTGOING' THEN 'Harcanan' END as KartHareketi
FROM payout_source.card_transaction ct
WHERE ct.merchant_id NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)

SELECT Kanal.merchant_id, GROUP_CONCAT(Kanal.name), COUNT(*) FROM (
SELECT s.merchant_id, s.type, s.status, s.account_no, s.terminal_id, t.serial_no, c.name FROM payout_source.source s
JOIN odeal.Terminal t ON t.id = s.terminal_id
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE s.status <> "CANCELED" AND s.type = "FIBACARD" AND s.merchant_id = 301160192) as Kanal
GROUP BY Kanal.merchant_id;

SELECT
    s.merchant_id, s.terminal_id, c.name,
    COALESCE(
        -- İlgili merchant_id'ye ait terminallerdeki channel_id'ler arasında en yüksek olanı döndür
        (SELECT MAX(c2.name)
         FROM odeal.Terminal t2
         JOIN odeal.Channel c2 ON c2.id = t2.channelId
         JOIN payout_source.source s2 ON s2.terminal_id = t2.id
         WHERE t2.organisation_id = s.merchant_id
         AND c2.id IN (332, 333, 334, 343, 356, 357, 313)),
        'Diğer'
    ) AS Kanal
FROM
    payout_source.source s
JOIN
    odeal.Terminal t ON t.id = s.terminal_id
LEFT JOIN
    odeal.Channel c ON c.id = t.channelId
WHERE
    s.status <> 'CANCELED'
    AND s.type = 'FIBACARD' AND s.merchant_id = 301160192
GROUP BY
    s.merchant_id, s.terminal_id;

SELECT t.organisation_id, GROUP_CONCAT(" ",c.name," - ",t.serial_no) as Kanallar FROM odeal.Terminal t
JOIN odeal.Channel c ON c.id = t.channelId
JOIN payout_source.source s ON s.terminal_id = t.id AND s.type = "FIBACARD"
GROUP BY t.organisation_id

SELECT * FROM odeal.Terminal t WHERE t.organisation_id =

 SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, o.activatedAt as UyeAktivasyonTarihi, t.serial_no as MaliNo, t.id as TerminalID, t.firstActivationDate as TerminalAktivasyonTarihi,
IF(t.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum, s2.name AS Hizmet, s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi, s.cancelledAt as AbonelikIptalTarihi,
p.id as PlanID, p.name as Plan,
IF(ISNULL(TerminalOzelKomisyon.TekCekimTerminalKomisyon) = FALSE, TerminalOzelKomisyon.TekCekimTerminalKomisyon,
    IF (ISNULL(UyeOzelKomisyon.TekCekimUyeKomisyon) = FALSE, UyeOzelKomisyon.TekCekimUyeKomisyon,
        IF (ISNULL(p.commissionRates) = FALSE, JSON_UNQUOTE(JSON_EXTRACT(p.commissionRates, '$."1"')), BazKomisyon.TekCekimBazKomisyon))) as TekCekimKomisyon,
    IF(ISNULL(TerminalOzelKomisyon.OlusmaTarihi) = FALSE, TerminalOzelKomisyon.OlusmaTarihi,
    IF (ISNULL(UyeOzelKomisyon.OlusmaTarihi) = FALSE, UyeOzelKomisyon.OlusmaTarihi,
        IF (ISNULL(p._createdDate) = FALSE, p._createdDate, BazKomisyon.OlusmaTarihi))) as OlusmaTarihi,
        COALESCE(BazKomisyon.SonlanmaTarihi,
        TerminalOzelKomisyon.SonlanmaTarihi,
        UyeOzelKomisyon.SonlanmaTarihi) as SonlanmaTarihi,
p.commissionRates as PlanKomisyon,
UyeOzelKomisyon.UyeOzelKomisyon,
TerminalOzelKomisyon.TerminalKomisyon,
BazKomisyon.BazKomisyon,
c.name
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id -- AND t.terminalStatus = 1
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN subscription.Subscription s ON s.id = t.subscription_id -- AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
    LEFT JOIN (SELECT ir.organisationId as UyeIsyeriID,MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT Tekil1.UyeKomisyon FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY Tekil.organisationId ORDER BY Tekil.name) as Sira
FROM (
SELECT T1.UyeKomisyon, T1.organisationId, T1.name FROM (
SELECT ir2.id, s2.name, ir2.installment, ir2.status, ir2.comission as UyeKomisyon, ir2.organisationId,
ROW_NUMBER() OVER (PARTITION BY ir2.organisationId, ir2.installment, ir2.comission, ir2.serviceId ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND s2.id <> 3 AND ir2.cardBinType = "LOCAL" AND ir2.installment = 1) as T1
WHERE T1.Sira = 1) as Tekil) AS Tekil1 WHERE Tekil1.Sira = 1 AND Tekil1.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL" AND ir.serviceId <> 3
GROUP BY ir.organisationId, o.marka) as UyeOzelKomisyon ON UyeOzelKomisyon.UyeIsyeriID = o.id
    LEFT JOIN (SELECT t.organisation_id as UyeIsyeriID, t.serial_no as MaliNo, t.id, ir.terminalId as TerminalID, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT TekilKomisyon.Komisyon1 FROM (
SELECT ir2.terminalId, ir2.comission as Komisyon1, ir2.id,
ROW_NUMBER() OVER (PARTITION BY ir2.terminalId, ir2.comission ORDER BY ir2.id) as Sira
FROM odeal.InstallmentRule ir2
WHERE ir2.terminalId IS NOT NULL AND ir2.brandId = 27 AND ir2.cardBinType = "LOCAL" AND ir2.status = 2 AND ir2.installment = 1) as TekilKomisyon
WHERE TekilKomisyon.Sira = 1 AND TekilKomisyon.terminalId = ir.terminalId) as TekCekimTerminalKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as TerminalKomisyon FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2 AND ir.cardBinType = "LOCAL"
GROUP BY t.organisation_id, t.serial_no, ir.terminalId) as TerminalOzelKomisyon ON TerminalOzelKomisyon.TerminalID = t.id
LEFT JOIN (SELECT s.id as ServisID, s.name as Servis, MAX(ir._createdDate) as OlusmaTarihi, MAX(ir.expiryDate) as SonlanmaTarihi,
(SELECT ir2.comission as TekCekimKomisyon  FROM odeal.InstallmentRule ir2
WHERE ir2.sectorId IS NULL AND ir2.cardBinType = "LOCAL"
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment = 1
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon
FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.cardBinType = "LOCAL" AND ir.serviceId IS NOT NULL AND ir.status = 2
GROUP BY s.id, s.name, ir.serviceId) as BazKomisyon ON BazKomisyon.ServisID = s2.id
WHERE o.demo = 0 AND c.id = 213

SELECT t.organisation_id, t.serial_no, t.id as TerminalID, t.firstActivationDate, t._createdDate, t.terminalStatus,
(SELECT MIN(bp.signedDate) as SonIslemTarihi FROM odeal.TerminalPayment tp
JOIN odeal.BasePayment bp ON bp.id = tp.id WHERE tp.terminal_id = t.id AND bp.currentStatus = 6) as SonIslem
FROM odeal.Terminal t
WHERE t.serial_no = "BCG00001378"

SELECT o.id, IF(o.isActivated=0,"PASİF","AKTİF") as Durum FROM odeal.Organisation o

SELECT s.tckn, COUNT(s.merchant_id) FROM payout_source.source s
GROUP BY s.tckn HAVING COUNT(s.merchant_id) > 1

SELECT * FROM (
SELECT OdealKart.tckn, OdealKart.account_no, OdealKart.merchant_id FROM (
SELECT s.tckn, s.account_no, s.merchant_id, COUNT(*) FROM payout_source.source s
                            WHERE s.tckn = 16595693992 AND s.type = "FIBACARD"
GROUP BY s.tckn, s.account_no, s.merchant_id) as OdealKart) as Odeal

SELECT * FROM payout_source.card_courier_history cch
         WHERE cch.tckn = 16595693992;

SELECT * FROM payout_source.source s
         LEFT JOIN payout_source.card_courier_history cch ON cch.tckn = s.tckn
         WHERE s.tckn = 16595693992 AND s.type = "FIBACARD"

SELECT * FROM payout_source.card_courier_history cch
JOIN (
SELECT OdealKart.tckn, OdealKart.account_no, OdealKart.merchant_id FROM (
SELECT s.tckn, s.account_no, s.merchant_id, COUNT(*) FROM payout_source.source s
                            WHERE s.tckn = 16595693992 AND s.type = "FIBACARD"
GROUP BY s.tckn, s.account_no, s.merchant_id) as OdealKart) as Odeal ON Odeal.tckn = cch.tckn
         WHERE cch.tckn = 16595693992



SELECT KuryeTarih.tckn, KuryeTarih.card_number, KuryeTarih.type, KuryeTarih.courier_company, KuryeTarih.barcode_number,
KuryeTarih.courier_main_status,
KuryeTarih.courier_detail_status, KuryeTarih.courier_date, KuryeTarih.SonTarih, KuryeTarih.TeslimTarihi, KuryeTarih.IlkKuryeTarih,
KuryeTarih.SonDurum, KuryeTarih.SonDurumDetay, DATEDIFF(KuryeTarih.SonTarih,KuryeTarih.courier_date) as FarkGun,
KuryeTarih.Sira
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date) as Sira,
FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn) AS IlkKuryeTarih,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn) AS SonTarih,
IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn)),"%Y-%m-%d %H:%i:%s"),null) AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn) AS SonDurumDetay
FROM payout_source.card_courier_history cch
) as KuryeTarih WHERE KuryeTarih.tckn = 55888257930
AND KuryeTarih.tckn NOT IN (SELECT s.tckn
FROM payout_source.source s
WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)
GROUP BY s.tckn)
ORDER BY KuryeTarih.tckn, KuryeTarih.courier_date;

 KuryeTarih.Sira = 1

SELECT s.tckn FROM payout_source.source s WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622);
SELECT s.tckn
FROM payout_source.source s
WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)
GROUP BY s.tckn;

SELECT s.tckn , COUNT(s.account_no) FROM payout_source.source s
WHERE s.type = "FIBACARD" AND s.status = "ACTIVATED"
GROUP BY s.tckn HAVING COUNT(s.account_no) > 1

SELECT * FROM payout_source.card_detail cd WHERE cd.tckn = 55888257930;

SELECT * FROM payout_source.source s WHERE s.tckn = 55888257930;

SELECT * FROM payout_source.card_courier_history cch WHERE cch.tckn = 55888257930;

SELECT * FROM payout_source.source s WHERE s.merchant_id = 301246682;

SELECT DATE(ct.transaction_date) as Gun, COUNT(ct.id) as KartaYatanIslemAdet, SUM(ct.amount) as KartaYatanTutar, ct.direction as IslemTipi, ct.transaction_type
FROM payout_source.card_transaction ct WHERE ct.direction = "INCOMING" AND DATE(ct.transaction_date) >= "2024-11-01"
GROUP BY DATE(ct.transaction_date), ct.transaction_type

SELECT DATE(bp.signedDate) as Gun, p.paymentStatus, IF(p.id IS NOT NULL,"GERİ ÖDEMESİ VAR","GERİ ÖDEMESİ YOK") as GeriOdemeDurum,
       COUNT(bp.id) as Islem, SUM(bp.amount) as Ciro, SUM(p.amount) as GeriOdeme FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id AND t.id IN (SELECT DISTINCT Kart.terminal_id FROM (
SELECT s.terminal_id, COUNT(*) FROM payout_source.source s
WHERE s.terminal_id IS NOT NULL AND s.type = 'FIBACARD'
GROUP BY s.terminal_id)as Kart)
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId AND p.dueDate >= "2024-11-01 00:00:00"
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.signedDate >= "2024-11-01 00:00:00" AND bp.signedDate <= "2024-11-04 23:59:59" AND bp.serviceId <> 3 AND bp.appliedRate = 0
GROUP BY DATE(bp.signedDate),IF(p.id IS NOT NULL,"GERİ ÖDEMESİ VAR","GERİ ÖDEMESİ YOK"),p.paymentStatus;

SELECT DISTINCT t.organisation_id as UyeID, t.id as TerminalID, DATE(bp.signedDate) as IslemTarih,
                bp.appliedRate, CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END as KomisyonDurum,
                COUNT(bp.id) as IslemAdedi, SUM(bp.amount) as Ciro, bi.type as GeriOdeme, A.SonrakiTarih, s.request_date as FibaBasvuruTarihi, A.PlanName
FROM (SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih, p.name as PlanName
      FROM (
SELECT sh.terminalId,
       MIN(sh._createdDate) as OlusmaTarihi,
       MIN(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh._createdDate >= '2024-05-01 00:00:00'
GROUP BY sh.terminalId, sh.planId) as SH
LEFT JOIN subscription.Plan p ON p.id = SH.PlanID) as A
JOIN odeal.Terminal t ON t.id = A.terminalId
LEFT JOIN payout_source.source s ON s.terminal_id = t.id AND s.type = 'FIBACARD'
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.signedDate >= s.request_date AND bp.signedDate <= A.SonrakiTarih AND (bp.signedDate BETWEEN A.OlusmaTarihi AND A.SonrakiTarih)
LEFT JOIN odeal.Payback pay ON pay.id = bp.paybackId
LEFT JOIN odeal.BankInfo bi ON bi.id = pay.bankInfoId
WHERE bp.appliedRate IS NOT NULL AND A.terminalId IN (SELECT DISTINCT Kart.terminal_id FROM (
SELECT s.terminal_id, COUNT(*) FROM payout_source.source s
WHERE s.terminal_id IS NOT NULL AND s.type = 'FIBACARD'
GROUP BY s.terminal_id) as Kart) AND (bi.type = 'FIBACARD' OR bi.type = 'SEKERCARD' OR bi.type = 'IBAN')
GROUP BY t.organisation_id, t.id, bp.appliedRate, bi.type,
         DATE(bp.signedDate), CASE WHEN bp.appliedRate = 0 THEN '0 Komisyonlu Ciro' ELSE 'Diğer Ciro' END, A.SonrakiTarih, s.request_date, A.PlanName

SELECT * FROM odeal.FailedPayment fp WHERE fp.organisationId = 301246682

SELECT * FROM odeal.Payment p WHERE p.id

SELECT * FROM odeal.BinInfo bi

SELECT t.organisation_id, t.serial_no, s.id, p.name FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
WHERE t.serial_no = "2A20131362";


SELECT KuryeTarih.tckn,
       KuryeTarih.merchant_id,
       KuryeTarih.terminal_id,
       KuryeTarih.card_number,
       KuryeTarih.type,
       KuryeTarih.courier_company,
       KuryeTarih.barcode_number,
       KuryeTarih.courier_main_status,
       KuryeTarih.courier_detail_status,
       KuryeTarih.courier_date,
       KuryeTarih.SonTarih,
       KuryeTarih.TeslimTarihi,
       KuryeTarih.IlkKuryeTarih,
       KuryeTarih.SonDurum,
       KuryeTarih.SonDurumDetay,
       DATEDIFF(KuryeTarih.SonTarih,KuryeTarih.courier_date) as FarkGun,
       KuryeTarih.Sira
FROM (
SELECT s.tckn,s.merchant_id, s.terminal_id, cch.card_number, s.type, cch.courier_company, cch.barcode_number, cch.courier_main_status, cch.courier_detail_status, cch.courier_date,
ROW_NUMBER() OVER (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date) as Sira,
FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number) AS IlkKuryeTarih,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonTarih,
IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number)),"%Y-%m-%d %H:%i:%s"),null) AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
) as KuryeTarih WHERE KuryeTarih.Sira = 1
AND KuryeTarih.tckn NOT IN (SELECT s.tckn FROM payout_source.source s WHERE s.merchant_id IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622))
ORDER BY KuryeTarih.tckn, KuryeTarih.courier_date


SELECT s.merchant_id,
       s.terminal_id,
       t.serial_no,
       MAX(bp.appliedRate) as SonKomisyon,
       MAX(bp.signedDate) as SonIslemTarih,
       MAX(bp.id) as SonIslemID
FROM payout_source.source s
JOIN odeal.TerminalPayment tp ON tp.terminal_id = s.terminal_id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.Terminal t ON t.id = s.terminal_id
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(s.request_date,INTERVAL 1 WEEK),"%Y-%m-01 00:00:00") AND bp.signedDate <= s.request_date
GROUP BY s.merchant_id, s.terminal_id, t.serial_no;


SELECT s.account_no,
       s.merchant_id,
       s.transferred_account_id,
       s.id as SourceID,
       s.terminal_id,
       t.serial_no,
       s.tckn,
       s.masked_card_number as KartNo,
       CASE WHEN s.status = 'ACTIVATED' THEN 'AKTİF'
            WHEN s.status = 'OTHER' THEN 'DİĞER'
            WHEN s.status = 'WAITING_VERIFICATION' THEN 'DOĞRULAMA BEKLENİYOR'
            WHEN s.status = 'CANCELED' THEN 'İPTAL'
       END as KartBasvuruDurum,
       s.reason as KartDurum,
       s.request_date as TalepTarihi,
       s.group_date as BasimTarihi,
       s.available_amount as KartBakiyesi,
       DATEDIFF(DATE(s.group_date), DATE(s.request_date)) as Talep_BasimGunFark,
       s._createdDate, IF(t.firstActivationDate=0,"Kurulmadı","Kuruldu") as KurulumBilgisi
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
WHERE s.type = 'FIBACARD' AND s.merchant_id <> 301196774
AND s.merchant_id NOT IN (301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032,301160192)
AND s.status <> 'CANCELED'



SELECT o.id, t.serial_no, ser.name as Hizmet,
       o.marka, o.unvan, m.tckNo, o.vergiNo,
       CONCAT(m.firstName," ",m.LastName) as Yetkili, c.name as TerminalKanal,
       c1.name as OrgKanal,
               (SELECT MAX(bp.signedDate) FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t2 ON t2.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND t2.serial_no = t.serial_no AND bp.organisationId = o.id) as SonIslemTarihi,
        (SELECT COUNT(bp.id) FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t2 ON t2.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND t2.serial_no = t.serial_no AND bp.organisationId = o.id) as IslemAdet,
       (SELECT SUM(bp.amount) FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t2 ON t2.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND t2.serial_no = t.serial_no AND bp.organisationId = o.id) as Ciro FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.Channel c1 ON c1.id = o.channelId
WHERE m.tckNo IN (
'28700016138',
'25147955570',
'46468659244',
'42199150326',
'17194660330',
'15856404384',
'60196201780',
'49807215118',
'71143140540',
'65752320202',
'33349122232',
'34574224562',
'39064886374',
'19505639592',
'35578799452',
'48520505650',
'42823921124',
'53110725318',
'47605621360',
'11621290282',
'35842702720',
'49759680132',
'45802231870',
'25181427088',
'17281971196',
'66289005792',
'28202278652',
'65341164606',
'39629169522',
'36895568516',
'20051198174',
'13600466916',
'19379169454',
'33215083476',
'19669284522',
'34375396178',
'24929051530',
'30721658754',
'50146530688',
'71614108468',
'61669345796',
'58435453502',
'11443559260',
'17461790814',
'66853131148',
'16625784256',
'15715684490',
'18701670392',
'35857181480',
'33628844312',
'13984493584',
'37000740438',
'36985302174',
'55834389678',
'44032922220',
'46651863694',
'17176649988',
'51349269436',
'23080603800',
'35669100358',
'40747191418',
'42949126984',
'18199235806',
'71320118430',
'10940878164',
'41908150312',
'47722918336',
'44239747572',
'23632734662',
'23824026322',
'23485589778',
'22544162310',
'30494104960',
'53470209572',
'12287570596',
'29914375998',
'27715069962',
'28036299526',
'50800551318',
'39481872158',
'38854251286',
'11725812748',
'14504208060',
'34913136044',
'28856298884',
'37642947530',
'17740228540',
'17018831762',
'17048830742',
'35092793042',
'54691688580',
'16174917006',
'10192622676',
'69457019720',
'10109484052',
'25430555234',
'10982968182',
'20948276558',
'34607194510',
'40774399474',
'72190086294',
'38989241756',
'52957743158',
'40267452662',
'31489323496',
'33151808324',
'25906208282',
'49330536834',
'34370049932',
'39646856108',
'62563127686',
'39436863170',
'63574259786',
'14285961826',
'22642815538',
'51295469270',
'17875338800',
'16106672492',
'10345756708',
'24853106368',
'11519969832',
'42022085474',
'14333958310',
'24026708290',
'68956044462',
'11836624124',
'13331521526',
'10286985762',
'47569234392',
'18838877572',
'60631189734',
'55804269672',
'16304644154',
'23903381076',
'25420819124',
'16760695684',
'30488202658',
'15328727140',
'19738276632',
'15562474824',
'67186089106',
'26579282258',
'35347209328',
'20129704252',
'31465103340',
'20704969434',
'39331209370',
'23350162372',
'17678316166',
'37099218054',
'64201232066',
'24626486536',
'18002158476',
'67489159896',
'67201088732',
'63559103462',
'41401286938',
'18815781762',
'20456076336',
'12257148404',
'43999291646',
'49987014136',
'23648728280',
'28195432802',
'18367321652',
'45727771246',
'21746404648',
'41974661682',
'10215007466',
'33107390736',
'69154048108',
'10874913856',
'36502976604',
'22417611778',
'33610793024',
'54883666310',
'47698315542',
'67921017340',
'10395146290',
'40516010636',
'39815074210',
'21830673134',
'36670452092',
'40034021138',
'46129257208',
'71152037770',
'11931092736',
'59404510592',
'35651310284',
'17435536554',
'19481109294',
'62899414856',
'22906908174',
'43201755300',
'28618519202',
'66247282456',
'13121382696',
'20675180166',
'17848638814',
'43093243794',
'30737209438',
'20536146614',
'48793614462',
'59386411580',
'64447244106',
'17684285944',
'12041937108',
'64069015382',
'34711815998',
'34666711116',
'31759511912',
'11402958448',
'18275916032',
'30703797488',
'54586676074',
'34297332452',
'46000444338',
'32641872418',
'43492812980',
'41059188578',
'40429933510',
'25985037346',
'47239387182',
'12308261946',
'18976872996',
'21739499408',
'23960162908',
'10681578668',
'36742988030',
'21082861648',
'17591752232',
'46747440174',
'43160080710',
'32963084476',
'12467239992',
'30293167876',
'59479129590',
'15577443310',
'45016014900',
'11461253430',
'11128448964',
'31807152074',
'16772428928',
'44152395126',
'48553622386',
'26851067634',
'43783941818',
'12721551846',
'71134005674',
'35233712994',
'23735075068',
'38044807330',
'30791382542',
'22472650378',
'13859404240',
'14077464474',
'22024214782',
'12764549008',
'35435116446',
'10912570690',
'15130729592',
'12934423626',
'16072670188',
'65530252930',
'31673153526',
'19348727630',
'15098738988',
'24325837318',
'20683265428',
'18491496080',
'54322475664',
'33188329816',
'42238553934',
'10743151136',
'35285001756',
'39562941964',
'61825458346',
'18635772100',
'28472251652',
'58003457642',
'39194037400',
'60367284758',
'13217935034',
'31528321926',
'49903298138',
'34904330512',
'13438776324',
'64048220714',
'24118150990',
'22912977638',
'32404466830',
'27910010066',
'21853219012',
'25547030488',
'50194344954',
'58138252778',
'48949576484',
'12656064954',
'63427174914',
'44482635152',
'23828075814',
'31369313852',
'30917306414',
'16324929354',
'38957011756',
'13407065084',
'40846817806',
'19882571348',
'32726418418',
'12758977534',
'72337018898',
'47815942460',
'43546007638',
'36298959034',
'59317537808',
'45727136724') OR o.vergiNo IN ('80102093',
'90590668',
'110343531',
'170462464',
'220157414',
'240463042',
'250513485',
'310426686',
'320190083',
'320195933',
'430049307',
'430079424',
'430194196',
'480823122',
'500086754',
'510240401',
'550484800',
'660141892',
'670790154',
'680764990',
'700477947',
'820536538',
'820924284',
'840454015',
'850301431',
'870718699',
'900056744',
'910010838',
'910218003',
'910575903',
'920281311',
'990686841',
'1040733354',
'1041390972',
'1050165638',
'1050593346',
'1080460060',
'1120060583',
'1120334544',
'1130237212',
'1210213570',
'1220367939',
'1230733879',
'1240041723',
'1310629255',
'1360150674',
'1360198485',
'1370352974',
'1430558427',
'1440043487',
'1510076687',
'1520022088',
'1570010688',
'1570048762',
'1570204621',
'1600283135',
'1640427865',
'1710304748',
'1740521091',
'1780110367',
'1780135743',
'1781326403',
'1810137711',
'1830057051',
'1840064950',
'1840345313',
'1840660909',
'1860051210',
'1860677953',
'1890621790',
'1910271770',
'1960471299',
'1961072320',
'2020189177',
'2040312086',
'2050090399',
'2051132852',
'2090155499',
'2100314073',
'2110034232',
'2120325730',
'2130228126',
'2160778796',
'2221052310',
'2240660413',
'2260333450',
'2280764487',
'2310317710',
'2310343896',
'2330501063',
'2330650875',
'2330736081',
'2340398738',
'2340414858',
'2361160119',
'2400236930',
'2410324321',
'2440257807',
'2440294526',
'2530555421',
'2630153932',
'2670690641',
'2680190481',
'2700133305',
'2710733468',
'2730641930',
'2730886916',
'2730939189',
'2750475559',
'2751400279',
'2780052391',
'2790292055',
'2820010717',
'2910099874',
'2910522994',
'2910548209',
'2910846679',
'2920009027',
'2960408840',
'2970490040',
'2970613653',
'2980096046',
'3010619704',
'3040314804',
'3050122940',
'3060524546',
'3150687004',
'3150780357',
'3180121575',
'3180523160',
'3200151616',
'3210022220',
'3260272621',
'3330457649',
'3340250562',
'3340387487',
'3360549898',
'3370328080',
'3530547123',
'3580217553',
'3600192974',
'3660322067',
'3720243132',
'3780202019',
'3810157199',
'3880226897',
'3920247482',
'3930515031',
'3990402267',
'4060360208',
'4110916999',
'4130637026',
'4150378586',
'4160056178',
'4180393240',
'4210509108',
'4230322367',
'4230456532',
'4270302084',
'4290209773',
'4290342376',
'4300590139',
'4350017673',
'4400295132',
'4510304833',
'4530086463',
'4560006719',
'4560043224',
'4640128525',
'4700096859',
'4720394129',
'4730250655',
'4770031164',
'4810338104',
'4810341270',
'4860441556',
'4920225037',
'4930264425',
'4930364718',
'4940069882',
'4990157800',
'5010034213',
'5010045169',
'5020237736',
'5030422393',
'5040476417',
'5040626841',
'5040650156',
'5060269702',
'5070057284',
'5090388359',
'5090460595',
'5170146379',
'5180364220',
'5220584923',
'5230497056',
'5280593613',
'5281035878',
'5310018327',
'5350358791',
'5440401527',
'5450341804',
'5450469243',
'5451064641',
'5470162926',
'5520021226',
'5560726615',
'5760026547',
'5760157685',
'5790464614',
'5850388793',
'5850694716',
'5870136530',
'5910377599',
'5930569817',
'5950181486',
'5960328981',
'6040269898',
'6110841783',
'6180136550',
'6220356388',
'6270279201',
'6270318963',
'6310195107',
'6320452384',
'6350289180',
'6360520434',
'6380100005',
'6410025997',
'6550434338',
'6600100304',
'6620072168',
'6620074483',
'6620692670',
'6620777754',
'6620929530',
'6660226182',
'6680126367',
'6720088628',
'6720246686',
'6750052795',
'6760544597',
'6810030162',
'6930329164',
'7030237894',
'7140333911',
'7140868343',
'7170343536',
'7310565283',
'7320023784',
'7320092932',
'7350419450',
'7380025316',
'7410589422',
'7430063413',
'7430436653',
'7460832567',
'7470103562',
'7470942600',
'7500083799',
'7540375795',
'7790414839',
'7820083565',
'7820579123',
'7840289181',
'7910001996',
'7920051523',
'7950360586',
'7960566192',
'8030997199',
'8040015442',
'8131043227',
'8220255263',
'8240030769',
'8251083278',
'8330074244',
'8330408740',
'8370549921',
'8510051638',
'8540130699',
'8540208808',
'8550422176',
'8580088977',
'8590325803',
'8650203960',
'8680190719',
'8710040642',
'8780211129',
'8790468629',
'8870074036',
'8880031872',
'8960054386',
'8960251575',
'8970189379',
'9020160494',
'9040775789',
'9180058563',
'9230001920',
'9260490732',
'9300479638',
'9310246165',
'9330155762',
'9400549243',
'9420465983',
'9450249786',
'9460153519',
'9460208654',
'9490062557',
'9490670205',
'9500013504',
'9510293807',
'9510471906',
'9520127719',
'9530259640',
'9550635754',
'9580205732',
'9600536715',
'9600665837',
'9630304732',
'9680275864',
'9690004421',
'9700027325',
'9730503303',
'9770148018',
'9800365755',
'9810630141',
'9890285637',
'9930327574',
'9950384659',
'9970077389',
'9970478774')