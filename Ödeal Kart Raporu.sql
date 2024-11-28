 SELECT DISTINCT t.serial_no as MaliNo,
       IsyeriBilgi.OrgID as UyeIsyeriID,
       Islemler.ToplamTutar,
       Islemler.SonIslemTarihi,
       Islemler.SifirKomisyonCiro,
       IsyeriBilgi.unvan,
       IsyeriBilgi.marka,
       s.account_no, s.transferred_account_id, s.id as SourceID,
       s.tckn,
       IsyeriBilgi.Yetkili,
       IsyeriBilgi.OrgDurum,
       s.masked_card_number as KartNo,
       Abonelik.PlanAd,
       IF(t.terminalStatus=1,'AKTİF','PASİF') as TerminalDurumu,
       CASE WHEN s.status = 'ACTIVATED' THEN 'AKTİF'
            WHEN s.status = 'OTHER' THEN 'DİĞER'
            WHEN s.status = 'WAITING_VERIFICATION' THEN 'DOĞRULAMA BEKLENİYOR'
       END as KartBasvuruDurum,
       s.reason as KartDurum,
       t.id as TerminalID,
       t.firstActivationDate as TerminalAktivasyonTarihi,
       SonKuryeDurum.courier_main_status as KuryeDurum,
       SonKuryeDurum.courier_detail_status as KuryeDetayDurum,
       SonKuryeDurum.courier_date,
       SonKuryeDurum.barcode_number as GonderiNo,
       STR_TO_DATE(SonKuryeDurum.TeslimTarihi,"%Y-%m-%d %H:%i:%s") as TeslimTarihi,
       STR_TO_DATE(SonKuryeDurum.DagitimTarihi,"%Y-%m-%d %H:%i:%s") as DagitimTarihi,
       s.request_date as TalepTarihi,
       s.group_date as BasimTarihi,
       s.available_amount as KartBakiyesi,
       Hata.error_message, Hata.trace_id,
       IsyeriBilgi.Iletisim,
       JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"')) as MusteriNo,
       DATEDIFF(DATE(s.group_date), DATE(s.request_date)) as Talep_BasimGunFark,
       KartDetay.first_pin_set_date as IlkSifreKoymaTarihi,
       KartDetay.last_pin_change_date as SifreDegismeTarihi
FROM payout_source.source s
LEFT JOIN (SELECT * FROM payout_source.card_detail cd
WHERE cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.merchant_id)) as KartDetay ON KartDetay.merchant_id = s.merchant_id
LEFT JOIN (
LEFT JOIN () as SonKuryeDurum ON SonKuryeDurum.merchant_id = s.merchant_id AND s.account_no = SonKuryeDurum.card_number
LEFT JOIN payout_source.card_transaction ct ON ct.merchant_id = SonKuryeDurum.merchant_id AND ct.card_number = SonKuryeDurum.card_number
JOIN odeal.Terminal t ON t.id = s.terminal_id
JOIN () as IsyeriBilgi ON IsyeriBilgi.OrgID = s.merchant_id
LEFT JOIN (SELECT s.id as AbonelikID, s.activationDate,
s.cancelledAt, p.id as PlanID, p.serviceId as Hizmet,
p.name as PlanAd FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId
WHERE s.status = 1) as Abonelik ON Abonelik.AbonelikID = t.subscription_id
LEFT JOIN (SELECT DISTINCT o.id as UyeIsyeriID,
       t.serial_no,
       MAX(bp.signedDate) OVER (PARTITION BY o.id, t.serial_no) as SonIslemTarihi,
       SUM(bp.amount) OVER (PARTITION BY o.id, t.serial_no) as ToplamTutar,
       SUM(CASE WHEN bp.appliedRate = 0 THEN bp.amount END) OVER (PARTITION BY o.id, t.serial_no) as SifirKomisyonCiro
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-%d")
AND o.id IN (
SELECT KartliUyeler.merchant_id FROM (
SELECT KuryeTarih.merchant_id, KuryeTarih.card_number, KuryeTarih.type, KuryeTarih.courier_company, KuryeTarih.barcode_number,
KuryeTarih.courier_main_status,
KuryeTarih.courier_detail_status, KuryeTarih.courier_date, KuryeTarih.SonTarih, KuryeTarih.TeslimTarihi, KuryeTarih.IlkKuryeTarih,
KuryeTarih.SonDurum, KuryeTarih.SonDurumDetay, DATEDIFF(KuryeTarih.SonTarih,KuryeTarih.courier_date) as FarkGun,
KuryeTarih.Sira
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cch.merchant_id, cch.barcode_number ORDER BY cch.courier_date DESC) as Sira,
FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id) AS IlkKuryeTarih,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id) AS SonTarih,
IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null) AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.merchant_id) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.merchant_id) AS SonDurumDetay
FROM payout_source.card_courier_history cch
) as KuryeTarih
WHERE KuryeTarih.merchant_id NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)
ORDER BY KuryeTarih.merchant_id, KuryeTarih.courier_date) as KartliUyeler)) AS Islemler ON Islemler.serial_no = t.serial_no AND Islemler.UyeIsyeriID = IsyeriBilgi.OrgID
WHERE s.type = 'FIBACARD' AND IsyeriBilgi.OrgID NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)

-- Kurye Bilgileri
SELECT * FROM (
SELECT cch.id, cch.merchant_id, cch.card_number, cch.type, cch.courier_company, cch.courier_date, cch.courier_main_status, cch.courier_detail_status,
ROW_NUMBER() over (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC) AS SonTarih,
IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null) AS DagitimTarihi,
IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.merchant_id ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null) AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.merchant_id) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.merchant_id) AS SonDurumDetay
FROM payout_source.card_courier_history cch
         JOIN payout_source.source s ON s.merchant_id = cch.merchant_id AND s.account_no = cch.card_number
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1;

-- İşlemler
SELECT DISTINCT t.organisation_id as UyeIsyeriID,
       t.serial_no,
       LAST_VALUE(bp.signedDate) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SonIslemTarihi,
       SUM(bp.amount) OVER (PARTITION BY s.merchant_id, s.terminal_id) as ToplamTutar,
       SUM(CASE WHEN bp.appliedRate = 0 THEN bp.amount END) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SifirKomisyonCiro
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.organisation_id = s.merchant_id AND t.id = s.terminal_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
                                      AND bp.paymentType <> 4 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-%d")
WHERE s.type = "FIBACARD";

-- Hata
select s.id, s.tckn, s.vkn, s.merchant_id, s.terminal_id, s.status, log.entity_id, log.error_message, log.trace_id from payout_source.source s
    join (SELECT * FROM payout_source.request_response_logs r WHERE r.id IN (
SELECT MAX(r.id) FROM payout_source.request_response_logs r
GROUP BY r.entity_id)) as log ON s.id = log.entity_id
WHERE s.type='FIBACARD' AND status='WAITING_VERIFICATION';

-- Üye Bilgileri
SELECT o.id as OrgID, o.unvan, o.marka, IF(o.isActivated=1,'Aktif','Pasif') as OrgDurum,
       CONCAT(m.firstName,' ',m.LastName) as Yetkili, m.phone as Iletisim
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0 AND o.id IN (SELECT DISTINCT s.merchant_id FROM payout_source.source s WHERE s.type = "FIBACARD");


-- Terminal ve Abonelik
SELECT t.serial_no as MaliNo, t.organisation_id as UyeIsyeriID, sor.terminal_id as TerminalID,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, t.firstActivationDate as KurulumTarihi,
       s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi,
s.cancelledAt as AbonelikIptalTarihi, p.id as PlanID, ser.name as Hizmet,
p.name as PlanAd
FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId
JOIN odeal.Terminal t ON t.subscription_id = s.id
JOIN payout_source.source sor ON sor.terminal_id = t.id
WHERE s.status = 1 AND t.organisation_id = 301270460

SELECT * FROM odeal.Channel c WHERE c.id = 312

SELECT * FROM payout_source.source s WHERE s.merchant_id = 301268998

SELECT * FROM payout_source.source_history sh WHERE sh.account_no = 1201242050005766234

SELECT s.merchant_id, s.terminal_id, t.serial_no, s.type, s.status, s.available_amount FROM payout_source.source s
JOIN odeal.Terminal t ON t.id = s.terminal_id
WHERE s.type = "SEKERCARD"
LIMIT 10

SELECT s.merchant_id, s.terminal_id FROM payout_source.source s WHERE s.type = "FIBACARD" AND s.merchant_id = 301270460

SELECT * FROM odeal.CreditCard cc

SELECT cch.merchant_id, cch.courier_company, cch.courier_main_status, cch.courier_detail_status, cch.courier_date, cch.created_date
FROM payout_source.card_courier_history cch WHERE cch.merchant_id IN (301267945,301268411,301268601)


SELECT t.organisation_id, t.serial_no, bp.appliedRate, SUM(bp.amount) FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
         WHERE bp.currentStatus = 6 AND t.serial_no = "PAX710058655"
GROUP BY t.organisation_id, t.serial_no, bp.appliedRate

SELECT * FROM payout_source.source s
         JOIN (SELECT * FROM payout_source.card_courier_history cch2 WHERE cch2.id IN  (SELECT MAX(cch.id) FROM payout_source.card_courier_history cch GROUP BY cch.merchant_id, cch.merchant_id ORDER BY cch.courier_date DESC)) AS Kurye ON Kurye.card_number = s.account_no AND Kurye.merchant_id = s.merchant_id
         WHERE s.merchant_id = 301268998;

301267574
301267743

SELECT * FROM payout_source.card_transaction ct WHERE ct.card_number = 1201241850005728918

SELECT * FROM payout_source.source_history sh WHERE sh.account_no = "1201241930005744552"


-- PAX710036957 301223775
-- Şekerkart ve Fibakart olan üye
SELECT * FROM payout_source.source s WHERE s.merchant_id = 301251994
AND s.type = "SEKERCARD" AND s.status <> "CANCELED" AND s.merchant_id NOT IN (
SELECT s.merchant_id FROM payout_source.source s WHERE s.merchant_id = 301251994
AND s.type = "FIBACARD" AND s.status <> "CANCELED");

SELECT Planlar.*, p.name FROM (
SELECT  s.merchant_id, s.terminal_id, s.status, s.type as AbonelikTipi, s.account_no,
       s.cancelled_date, s.provider, s._createdDate, s.reason, bi.bank, bi.type as GeriOdemeTipi,
       s.available_amount, s.request_date, s.group_date, bp.appliedRate, tp.installment, s._lastModifiedDate, bp.id, bp.signedDate, bp.amount,
(SELECT A.PlanID FROM (SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId, SH.subscriptionId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih FROM (
SELECT sh.terminalId,
       sh.subscriptionId,
       MAX(sh._createdDate) as OlusmaTarihi,
       MAX(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as SH) as A
WHERE A.terminalId = s.terminal_id AND A.SonrakiTarih > bp.signedDate ORDER BY A.SonrakiTarih ASC LIMIT 1) as PlanID,
(SELECT A.SonrakiTarih FROM (SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId, SH.subscriptionId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih FROM (
SELECT sh.terminalId,
       sh.subscriptionId,
       MAX(sh._createdDate) as OlusmaTarihi,
       MAX(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as SH) as A
WHERE A.terminalId = s.terminal_id AND A.SonrakiTarih > bp.signedDate ORDER BY A.SonrakiTarih ASC LIMIT 1) as PlanOlusmaTarihi
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE s.terminal_id IS NOT NULL
  AND s.terminal_id = 286728 AND bp.currentStatus = 6
  AND bp.signedDate >= "2024-09-01 00:00:00" AND bp.paymentType IN (0,1,2,3,6,7,8)) as Planlar
LEFT JOIN subscription.Plan p ON Planlar.PlanID = p.id;

SELECT *, IFNULL(LEAD(SH.OlusmaTarihi) OVER (PARTITION BY SH.terminalId, SH.subscriptionId ORDER BY SH.OlusmaTarihi),NOW()) as SonrakiTarih FROM (
SELECT sh.terminalId,
       sh.subscriptionId,
       MAX(sh._createdDate) as OlusmaTarihi,
       MAX(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh.terminalId = 286728
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as SH;


SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.terminalId = 286728;

merchant_id,terminal_id
301254993,277677

 select * from payout_source.source s
                join (select entity_id, error_message, retry, request, response, trace_id from payout_source.request_response_logs r
    WHERE id IN (select MAX(id) from payout_source.request_response_logs r
    group by entity_id) and r.error_message is not null) as log on s.id = log.entity_id
where s.type = 'FIBACARD'
  and s.status = 'WAITING_VERIFICATION';


SELECT *, (SELECT IslemTarihiAraligi.OlusmaTarihi FROM (
SELECT sh.terminalId, sh.subscriptionId, MAX(sh._createdDate) as OlusmaTarihi, MAX(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh.terminalId = 277677
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as IslemTarihiAraligi) as IslemTarih FROM payout_source.source s WHERE s.merchant_id = 301254993 AND s.terminal_id = 277677

SELECT A.OlusmaTarihi FROM (
SELECT sh.terminalId,
       sh.subscriptionId,
       MAX(sh._createdDate) as OlusmaTarihi,
       MAX(sh.planId) as PlanID
FROM subscription.SubscriptionHistory sh
WHERE sh.terminalId = 277677
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId) as A;


(SELECT GunSonu.SonGunSonu FROM (
        SELECT eod.organisation_id,
            eod.terminal_serial_no,
            DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
            eod.created_at AS SonGunSonu
        FROM odeal.end_of_day eod
        JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
        AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
        WHERE eod.created_at >= "2024-05-01 00:00:00" AND t.channelId = 313) AS GunSonu
    WHERE GunSonu.organisation_id = o.id
    AND CONVERT(GunSonu.terminal_serial_no USING utf8) = t.serial_no
    AND GunSonu.SonGunSonu > bp.signedDate ORDER BY GunSonu.SonGunSonu ASC
    LIMIT 1;

SELECT
    s.merchant_id AS uye,
    s.terminal_id AS id,
    s.type AS Tip,
    s._createdDate,
    A.plan
FROM payout_source.source s
LEFT JOIN (
    SELECT Abonelik.plan, Abonelik.TerminalID, Abonelik.KayitTarihi
    FROM (
        SELECT
            sh.planId AS plan,
            sh.terminalId AS TerminalID,
            MIN(sh._createdDate) AS KayitTarihi
        FROM subscription.SubscriptionHistory sh
        WHERE sh.activationDate IS NOT NULL
        GROUP BY sh.planId, sh.terminalId
    ) AS Abonelik
) AS A
ON A.TerminalID = s.terminal_id
   AND A.KayitTarihi <= s._createdDate
WHERE s.terminal_id = 288827
ORDER BY A.KayitTarihi DESC
LIMIT 1;


SELECT * FROM (
SELECT sh.planId as plan, sh.terminalId as TerminalID, MIN(sh._createdDate) as KayitTarihi
FROM subscription.SubscriptionHistory sh WHERE sh.terminalId = 288827 AND sh.activationDate IS NOT NULL
GROUP BY sh.planId) as Abonelik;

SELECT * FROM (
SELECT sh.planId as plan, sh.terminalId as TerminalID, MAX(sh._createdDate) as KayitTarihi
FROM subscription.SubscriptionHistory sh WHERE sh.terminalId = 288827 AND sh.activationDate IS NOT NULL
GROUP BY sh.planId) as Abonelik;

SELECT s.merchant_id as uye, s.terminal_id as id, s.type as Tip, s._createdDate as KayitTarihi
FROM payout_source.source s
WHERE s.merchant_id = 301262723 AND s.terminal_id = 288827;  -- İlgili üye için

3.18 4.04

SELECT DATE_FORMAT(bp._createdDate,"%Y-%m-%d") as Gun, MIN(bp._createdDate) as IlkIslem, MAX(bp._createdDate) as SonIslem,
       COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp._createdDate BETWEEN "2024-09-17 03:18:00" AND  "2024-09-17 04:04:00"
GROUP BY DATE_FORMAT(bp._createdDate,"%Y-%m-%d")
UNION
SELECT DATE_FORMAT(bp._createdDate,"%Y-%m-%d") as Gun, MIN(bp._createdDate) as IlkIslem, MAX(bp._createdDate) as SonIslem,
       COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6 AND bp._createdDate BETWEEN "2024-09-18 03:18:00" AND  "2024-09-18 04:04:00"
GROUP BY DATE_FORMAT(bp._createdDate,"%Y-%m-%d")

SELECT DATE_FORMAT(bp._createdDate,"%Y-%m-%d") as Gun, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro
FROM odeal.BasePayment bp
WHERE TIME(bp._createdDate) BETWEEN "03:18:00" AND "04:04:00"
AND bp._createdDate >= "2024-09-01 00:00:00" AND bp.currentStatus = 6
GROUP BY DATE_FORMAT(bp._createdDate,"%Y-%m-%d");

SELECT TIME("2024-09-18 03:18:15")

SELECT * FROM odeal.base

