select i.id as FaturaID, i.receiver as UyeIsyeri, i.sender, i.toAddress, i.fromAddress, i.phoneNumber, i.mail, i.city, i.totalAmount, i.totalVat, i.remainingAmount, i.description, i.paid, i.subscriptionId, i.organisationId,
i.period, i.periodStart, i.periodEnd, i.createdAt, i.invoiceStatus, i.`_createdDate`, i.`_lastModifiedDate`,
SUM(i.totalAmount) OVER (PARTITION BY i.organisationId) as ToplamFaturaBedeli,
COUNT(i.id) OVER (PARTITION BY i.organisationId) as FaturaAdet
from subscription.Invoice i
LEFT JOIN (SELECT sh.subscriptionId, t.serial_no, t.organisation_id FROM subscription.SubscriptionHistory sh 
LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
WHERE sh.id IN (SELECT MAX(sh.id) FROM subscription.SubscriptionHistory sh WHERE sh.terminalId IS NOT NULL GROUP BY sh.terminalId, sh.subscriptionId)) as AbonelikTerminal 
ON AbonelikTerminal.subscriptionId = i.subscriptionId AND AbonelikTerminal.organisation_id
where date(period)>= '2021-01-01'
and i.remainingAmount > 0


SELECT sh.subscriptionId, t.serial_no, t.organisation_id FROM subscription.SubscriptionHistory sh 
LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
WHERE sh.id IN (SELECT MAX(sh.id) FROM subscription.SubscriptionHistory sh WHERE sh.terminalId IS NOT NULL GROUP BY sh.terminalId, sh.subscriptionId)

SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.subscriptionId = 525624


PAX710033931

SELECT t.organisation_id, t.serial_no, tp.id, bp.id, bp.amount, bp.paybackId, bp.signedDate, p.id, p.amount FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE t.serial_no = "PAX710033931"


SELECT *,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemTutar,
Fatura.KalanTutar as KalanFaturaTutar,
Fatura.IslemTutar as SonIslemTutar,
Fatura.IslemTarihi as SonIslemTarihi
FROM (
SELECT DISTINCT i.subscriptionId as FaturaAbonelik,
                DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ" WHEN i.invoiceStatus=1 THEN "ÖDENDİ" WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK" END as FaturaDurum,
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
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = i.organisationId AND o.demo = 0
LEFT JOIN (SELECT * FROM(SELECT t.organisation_id, t.serial_no, t.id, bp.id as IslemID, bp.signedDate as IslemTarihi, bp.amount as IslemTutar, p.id as GeriOdemeID, p.paymentStatus as GeriOdemeDurumu, p.dueDate as GeriOdemeTarih, p.amount as GeriOdemeTutar,
       ROW_NUMBER() OVER (PARTITION BY t.organisation_id, t.serial_no ORDER BY bp.signedDate DESC) as Sira
FROM odeal.Terminal t
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-01")) as Islem
WHERE Islem.Sira = 1) as SonIslem ON SonIslem.organisation_id = t.organisation_id AND SonIslem.serial_no = t.serial_no
WHERE sh.terminalId IS NOT NULL AND i.periodEnd >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-01")
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id, SonIslem.IslemTutar,
SonIslem.IslemTarihi, SonIslem.GeriOdemeTarih, SonIslem.GeriOdemeTutar, SonIslem.GeriOdemeDurumu, SonIslem.GeriOdemeID) as Fatura WHERE Fatura.organisationId = 301008257

  SELECT Fatura.FaturaAbonelik, Fatura.Donem, Fatura.FaturaDurum, Fatura.organisationId, Fatura.FaturaKesimTarihi, Fatura.terminalId, Fatura.subscriptionId, Fatura.serial_no, Fatura.TerminalDurum,
       Fatura.OdenmeyenAdet, Fatura.OdenmeyenTutar, Fatura.OdendiAdet,
       Fatura.OdendiTutar, Fatura.OdenmeyecekAdet, Fatura.OdenmeyecekTutar, Fatura.KalanTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemTutar
FROM (
SELECT DISTINCT i.subscriptionId as FaturaAbonelik,
                DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ" WHEN i.invoiceStatus=1 THEN "ÖDENDİ" WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK" END as FaturaDurum,
i.organisationId,
i.createdAt as FaturaKesimTarihi,
sh.terminalId,
sh.subscriptionId,
t.serial_no,
CASE WHEN t.terminalStatus=0 THEN "PASİF" ELSE "AKTİF" END as TerminalDurum,
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = i.organisationId AND o.demo = 0
WHERE sh.terminalId IS NOT NULL
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id) as Fatura WHERE Fatura.organisationId IN ()


SELECT DISTINCT i.subscriptionId as FaturaAbonelik,
                DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ" WHEN i.invoiceStatus=1 THEN "ÖDENDİ" WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK" END as FaturaDurum,
i.organisationId,
i.createdAt as FaturaKesimTarihi,
sh.terminalId,
sh.subscriptionId,
t.serial_no,
CASE WHEN t.terminalStatus=0 THEN "PASİF" ELSE "AKTİF" END as TerminalDurum,
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = i.organisationId AND o.demo = 0
WHERE sh.terminalId IS NOT NULL AND i.invoiceStatus = 0 AND o.id = 301035518
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id;

301000162

SELECT *,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemTutar,
Fatura.KalanTutar as KalanFaturaTutar
FROM (
SELECT DISTINCT i.subscriptionId as FaturaAbonelik,
                DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ"
    WHEN i.invoiceStatus=1 THEN "ÖDENDİ"
    WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK"
    WHEN i.invoiceStatus=3 THEN "HUKUKİ SÜREÇTE"
    END as FaturaDurum,
i.organisationId,
i.createdAt as FaturaKesimTarihi,
sh.terminalId,
sh.subscriptionId,
t.serial_no,
CASE WHEN t.terminalStatus=0 THEN "PASİF" ELSE "AKTİF" END as TerminalDurum,
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE sh.terminalId IS NOT NULL
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id) as Fatura WHERE Fatura.organisationId = 301035518;

SELECT *,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdenmeyecekDonemTutar,
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
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, t.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
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
SonIslem.IslemTarihi, SonIslem.GeriOdemeTarih, SonIslem.GeriOdemeTutar, SonIslem.GeriOdemeDurumu, SonIslem.GeriOdemeID) as Fatura WHERE Fatura.organisationId = 301035518;

SELECT os.odeal_satis_id as SatisID,
       os.organisation_id as UyeID,
       os.mali_no as MaliNo,
       os.invoice_total as CihazBedeli
FROM odeal_satis os WHERE os.organisation_id IS NOT NULL
AND os.odeal_satis_id IN (
SELECT MAX(os.odeal_satis_id) FROM odeal_satis os WHERE os.organisation_id IS NOT NULL GROUP BY os.organisation_id, os.mali_no)
