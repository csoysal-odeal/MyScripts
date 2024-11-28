  SELECT DISTINCT s.account_no,
       s.merchant_id as UyeIsyeriID,
       s.transferred_account_id,
       s.id as SourceID,
       case when t.serial_no IS NULL then '1' else t.serial_no end as MaliNo,
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
       s._createdDate,
       MusteriNo.MusteriNo,
       IsyeriBilgi.unvan,
       IsyeriBilgi.marka,
       IsyeriBilgi.Yetkili,
       IsyeriBilgi.OrgDurum,
       IsyeriBilgi.Iletisim,
       TerminalAbonelik.PlanAd,
       TerminalAbonelik.TerminalAktivasyonTarihi,
       TerminalAbonelik.TerminalDurumu,
       SonKuryeDurum.KuryeDurum,
       SonKuryeDurum.KuryeDetayDurum,
       SonKuryeDurum.courier_date,
       STR_TO_DATE(SonKuryeDurum.TeslimTarihi,"%Y-%m-%d %H:%i:%s") as TeslimTarihi,
       STR_TO_DATE(SonKuryeDurum.DagitimTarihi,"%Y-%m-%d %H:%i:%s") as DagitimTarihi,
       Hata.error_message,
       Hata.trace_id,
       Islemler.SonIslemTarihi,
       Islemler.ToplamTutar as ToplamCiro,
       Islemler.SifirKomisyonCiro,
       KartSifreDetay.firstPinSetDate,
       KartSifreDetay.LastPinChangeDate,
       KartSifreDetay.LastPinSetDate
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
LEFT JOIN (SELECT s.merchant_id, s.terminal_id,s.account_no,s.reason,JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"')) as MusteriNo
FROM payout_source.source s
WHERE JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"')) IN
(SELECT MAX(JSON_UNQUOTE(JSON_EXTRACT(s.metadata, '$."customerNumber"'))) FROM payout_source.source s GROUP BY s.merchant_id)) as MusteriNo ON MusteriNo.merchant_id = s.merchant_id AND MusteriNo.terminal_id = s.terminal_id AND MusteriNo.account_no = s.account_no
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
ROW_NUMBER() over (PARTITION BY cch.tckn, cch.barcode_number ORDER BY cch.courier_date DESC) AS Sira,
LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC) AS SonTarih,
STR_TO_DATE(IF((FIRST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)) = "Dağıtımda", DATE_FORMAT((FIRST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date ASC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS DagitimTarihi,
STR_TO_DATE(IF((LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)) = "Teslim", DATE_FORMAT((LAST_VALUE(cch.courier_date) OVER (PARTITION BY cch.tckn, cch.card_number ORDER BY cch.courier_date DESC)),"%Y-%m-%d %H:%i:%s"),null),"%Y-%m-%d %H:%i:%s") AS TeslimTarihi,
LAST_VALUE(cch.courier_main_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurum,
LAST_VALUE(cch.courier_detail_status) OVER (PARTITION BY cch.tckn, cch.card_number) AS SonDurumDetay
FROM payout_source.card_courier_history cch
         JOIN payout_source.source s ON s.tckn = cch.tckn AND s.account_no = cch.card_number
WHERE s.type = "FIBACARD") as KuryeDurum WHERE KuryeDurum.Sira = 1) as SonKuryeDurum ON SonKuryeDurum.merchant_id = s.merchant_id AND SonKuryeDurum.card_number = s.account_no
LEFT JOIN (SELECT DISTINCT t.organisation_id as UyeIsyeriID,
       t.serial_no as MaliNo, t.id as TerminalID,
       LAST_VALUE(bp.signedDate) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SonIslemTarihi,
       SUM(bp.amount) OVER (PARTITION BY s.merchant_id, s.terminal_id) as ToplamTutar,
       SUM(CASE WHEN bp.appliedRate = 0 THEN bp.amount END) OVER (PARTITION BY s.merchant_id, s.terminal_id) as SifirKomisyonCiro,
       s.merchant_id, s.terminal_id
FROM payout_source.source s
JOIN odeal.Terminal t ON t.organisation_id = s.merchant_id AND t.id = s.terminal_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-%d")
WHERE s.type = 'FIBACARD') as Islemler ON Islemler.merchant_id = s.merchant_id AND Islemler.terminal_id = s.terminal_id AND Islemler.MaliNo = t.serial_no
LEFT JOIN (SELECT s.id as SourceID, s.tckn, s.vkn, s.merchant_id, s.terminal_id, s.status, log.entity_id, log.error_message, log.trace_id
FROM payout_source.source s
JOIN (SELECT * FROM payout_source.request_response_logs r WHERE r.id IN (
SELECT MAX(r.id) FROM payout_source.request_response_logs r
GROUP BY r.entity_id)) as log ON s.id = log.entity_id
WHERE s.type='FIBACARD' AND status='WAITING_VERIFICATION') as Hata ON Hata.merchant_id = s.merchant_id AND Hata.terminal_id = s.terminal_id
LEFT JOIN (SELECT o.id as UyeIsyeriID, o.unvan, o.marka, IF(o.isActivated = 1,'Aktif','Pasif') as OrgDurum, CONCAT(m.firstName,' ',m.LastName) as Yetkili, m.phone as Iletisim
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0 AND o.id IN (SELECT DISTINCT s.merchant_id FROM payout_source.source s WHERE s.type = 'FIBACARD')) as IsyeriBilgi ON IsyeriBilgi.UyeIsyeriID = s.merchant_id
LEFT JOIN (SELECT t.serial_no as MaliNo, t.id as TerminalID, t.organisation_id as UyeIsyeriID, IF(t.terminalStatus=1,'Aktif','Pasif') as TerminalDurumu, t.firstActivationDate as TerminalAktivasyonTarihi,
s.id as AbonelikID, s.activationDate as AbonelikAktivasyonTarihi, s.cancelledAt as AbonelikIptalTarihi, p.id as PlanID, ser.name as Hizmet, p.name as PlanAd, sor.merchant_id, sor.terminal_id
FROM payout_source.source sor
JOIN odeal.Terminal t ON sor.terminal_id = t.id
JOIN subscription.Subscription s ON t.subscription_id = s.id
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service ser ON ser.id = p.serviceId) as TerminalAbonelik ON TerminalAbonelik.merchant_id = s.merchant_id AND TerminalAbonelik.terminal_id = s.terminal_id AND TerminalAbonelik.MaliNo = t.serial_no
LEFT JOIN (SELECT cd.first_pin_set_date as firstPinSetDate, cd.last_pin_change_date as LastPinChangeDate, cd.last_pin_set_date as LastPinSetDate, s.terminal_id, s.merchant_id
FROM payout_source.card_detail cd
JOIN payout_source.source s ON s.merchant_id = cd.merchant_id
WHERE cd.id IN (SELECT MAX(cd.id) FROM payout_source.card_detail cd GROUP BY cd.tckn)) as KartSifreDetay ON KartSifreDetay.merchant_id = s.merchant_id AND KartSifreDetay.terminal_id = s.terminal_id
LEFT JOIN (SELECT bi.*
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
LEFT JOIN odeal.BankInfo bi ON bi.organisationId = s.merchant_id
WHERE bi.status = 1) as Iban ON Iban.organisationId = s.merchant_id
LEFT JOIN (SELECT KuryeTarih.tckn, KuryeTarih.merchant_id, KuryeTarih.card_number, KuryeTarih.type, KuryeTarih.courier_company, KuryeTarih.barcode_number,
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
ORDER BY KuryeTarih.tckn, KuryeTarih.courier_date) KuryeDagitimDetay ON KuryeDagitimDetay.merchant_id = s.merchant_id
LEFT JOIN (SELECT o.id as UyeID, t.serial_no as MaliNo, ct.transaction_date as IslemTarihi, ct.transaction_type as IslemDurum,
ct.description as IslemTanimi, ct.amount as IslemTutar, s.account_no as KartNo,
CASE WHEN ct.direction = 'INCOMING' THEN 'Karta Yatan'
    WHEN ct.direction = 'OUTGOING' THEN 'Harcanan' END as KartHareketi
FROM payout_source.source s
LEFT JOIN payout_source.card_transaction ct ON ct.merchant_id = s.merchant_id AND ct.card_number = s.account_no
LEFT JOIN odeal.Organisation o ON o.id = s.merchant_id
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
WHERE s.type='FIBACARD' AND s.merchant_id NOT IN (301160192,301268032,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622)) as KartHareketi ON KartHareketi.UyeID = s.merchant_id AND KartHareketi.MaliNo = t.serial_no AND KartHareketi.KartNo = s.account_no
WHERE s.type='FIBACARD' AND s.merchant_id <> 301196774
AND s.merchant_id NOT IN (301160192,301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032)

SELECT o.id, o.unvan, c.name, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, o.activatedAt, o.deActivatedAt, MIN(bp.signedDate) as IlkIslemTarih, MAX(bp.signedDate) as SonIslemTarih, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar  FROM odeal.Organisation o
                 JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.paymentType <> 4
                JOIN odeal.City c ON c.id = o.cityId
                WHERE o.activatedAt >= "2018-01-01 00:00:00" AND o.activatedAt <= "2020-12-31 23:59:59" AND o.isActivated = 1 AND c.id = 34
GROUP BY o.id, o.unvan, c.name, IF(o.isActivated=1,"Aktif","Pasif"), o.activatedAt, o.deActivatedAt

SELECT c.id, c.name, t.organisation_id, t.serial_no, s.terminal_id, s.status  FROM odeal.Channel c
          JOIN odeal.Terminal t ON t.channelId = c.id
          JOIN payout_source.source s ON s.terminal_id = t.id
          WHERE c.id = 387

SELECT o.id as UyeIsyeriID,
       o.unvan,
       o.marka,
       IF(o.isActivated = 1,'Aktif','Pasif') as OrgDurum,
       CONCAT(m.firstName,' ',m.LastName) as Yetkili,
       m.phone as Iletisim, c.name as Sehir, t.name as Ilce
FROM odeal.Organisation o
LEFT JOIN odeal.City c ON c.id = o.cityId
LEFT JOIN odeal.Town t ON t.id = o.townId
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0 AND o.id IN (SELECT DISTINCT s.merchant_id FROM payout_source.source s WHERE s.type = "FIBACARD")


SELECT o.id as UyeIsyeriID, o.marka as Marka, o.unvan as Unvan, t.serial_no as MaliNo, t.channelId, o.channelId, c.name, IF(bp.paymentType=4,"Nakit","Nakit Dışı") as OdemeTipi,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-01" THEN bp.amount END) as 2024_01,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-02" THEN bp.amount END) as 2024_02,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-03" THEN bp.amount END) as 2024_03,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-04" THEN bp.amount END) as 2024_04,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-05" THEN bp.amount END) as 2024_05,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-06" THEN bp.amount END) as 2024_06,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-07" THEN bp.amount END) as 2024_07,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-08" THEN bp.amount END) as 2024_08,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-09" THEN bp.amount END) as 2024_09,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-10" THEN bp.amount END) as 2024_10,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-11" THEN bp.amount END) as 2024_11,
        SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-12" THEN bp.amount END) as 2024_12,
        SUM(bp.amount) as Genel_Toplam
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.Channel c ON c.id = t.channelId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= NOW()
WHERE o.demo = 0 AND t.channelId = 213
GROUP BY o.id, o.marka, o.unvan, t.serial_no, IF(bp.paymentType=4,"Nakit","Nakit Dışı")

SELECT DATE_FORMAT(fp.failedAt,"%Y-%m-%d") as Gun, SUM(bp.amount), COUNT(bp.id) as Adet, fp.reason, fp.reasonCode FROM odeal.FailedPayment fp
         JOIN odeal.BasePayment bp ON bp.paymentId = fp.paymentId WHERE bp.serviceId = 8
GROUP BY DATE_FORMAT(fp.failedAt,"%Y-%m-%d"), fp.reason, fp.reasonCode

SELECT bp.id, bp.signedDate, bp.amount, bp.paymentId, bp.organisationId, bp._createdDate FROM odeal.BasePayment bp WHERE bp.id = 742913184

SELECT fp.id, fp.paymentId, fp.failedAt, fp.amount, fp.organisationId, fp.reason, fp.reasonCode
FROM odeal.FailedPayment fp WHERE fp.failedAt >= "2024-11-27 18:01:41" AND fp.organisationId = 301012999

SELECT *,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId,Fatura.subscriptionId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId,Fatura.subscriptionId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="HUKUKİ SÜREÇ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId) as HukukiSurecDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="HUKUKİ SÜREÇ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId) as HukukiSurecDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId,Fatura.subscriptionId ) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId) as OdenmeyecekDonemTutar,
Fatura.KalanTutar as KalanFaturaTutar,
Fatura.IslemTutar as SonIslemTutar,
Fatura.IslemTarihi as SonIslemTarihi
FROM (
SELECT DISTINCT i.subscriptionId as FaturaAbonelik,
                DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ"
    WHEN i.invoiceStatus=1 THEN "ÖDENDİ"
    WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK"
    WHEN i.invoiceStatus=3 THEN "HUKUKİ SÜREÇTE"
    END as FaturaDurum,
i.id as FaturaID,
i.organisationId,
i.createdAt as FaturaKesimTarihi,
sh.terminalId,
sh.subscriptionId,
t.serial_no,
CASE WHEN t.terminalStatus=0 THEN "PASİF" ELSE "AKTİF" END as TerminalDurum,
SonIslem.IslemTutar,
SonIslem.IslemTarihi,
SonIslem.GeriOdemeTarih,
SonIslem.GeriOdemeTutar,
SonIslem.GeriOdemeDurumu,
SonIslem.GeriOdemeID,
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
COUNT(CASE WHEN i.invoiceStatus = 3 THEN i.id END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as HukukiSurecAdet,
SUM(CASE WHEN i.invoiceStatus = 3 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as HukukiSurecTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN (SELECT * FROM(SELECT t.organisation_id, t.serial_no, t.id, bp.id as IslemID, bp.signedDate as IslemTarihi, bp.amount as IslemTutar, p.id as GeriOdemeID, p.paymentStatus as GeriOdemeDurumu, p.dueDate as GeriOdemeTarih, p.amount as GeriOdemeTutar,
       ROW_NUMBER() OVER (PARTITION BY t.organisation_id, t.serial_no ORDER BY bp.signedDate DESC) as Sira
FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE bp.currentStatus = 6  AND bp.paymentType IN (0,1,2,3,7,8) AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 5 DAY), "%Y-%m-01")) as Islem
WHERE Islem.Sira = 1) as SonIslem ON SonIslem.organisation_id = t.organisation_id AND SonIslem.serial_no = t.serial_no
WHERE sh.terminalId IS NOT NULL
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id, SonIslem.IslemTutar,
SonIslem.IslemTarihi, SonIslem.GeriOdemeTarih, SonIslem.GeriOdemeTutar, SonIslem.GeriOdemeDurumu, SonIslem.GeriOdemeID) as Fatura
WHERE Fatura.organisationId = 301000162

SELECT * FROM information_schema.COLUMNS c WHERE c.COLUMN_NAME LIKE "%reasoncode%"

select oo.id,me.identifier_no 'userId' , oo.unvan 'formattedName' , m.firstName 'givenName' , '' middleName,
       m.LastName 'familyName', m.phone 'phone', m.email 'email', 'TÜRKİYE' as 'country' , c.name 'city', t.name 'county', me.created_date 'contractDate',
       tx.code 'taxOfficeId',me.`type` , me.envelope_status, me.envelope_description
from odeal.MerchantEnvelopeHistory me
join odeal.Organisation oo on me.merchant_id  = oo.id
join Merchant m on m.organisationId = oo.id and m.role = 0
left join odeal.TaxOffice tx on tx.id  = oo.taxOfficeId
left join odeal.Town t on t.id = oo.townId
left join odeal.City c on c.id = oo.cityId
where 1=1
    and date(created_date) >= '2022-04-01'
order by merchant_id