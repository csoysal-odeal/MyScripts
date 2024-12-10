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

SELECT *,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENDİ" THEN Fatura.OdendiTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.terminalId) as OdendiDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.terminalId END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEDİ" THEN Fatura.OdenmeyenTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.subscriptionId, Fatura.terminalId) as OdenmediDonemTutar,
COUNT(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekAdet END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.FaturaID) as OdenmeyecekDonemAdet,
SUM(CASE WHEN Fatura.FaturaDurum="ÖDENMEYECEK" THEN Fatura.OdenmeyecekTutar END) OVER (PARTITION BY Fatura.Donem, Fatura.organisationId, Fatura.FaturaID) as OdenmeyecekDonemTutar,
Fatura.KalanTutar as KalanFaturaTutar
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
SH.terminalId,
SH.subscriptionId,
t.serial_no
FROM subscription.Invoice i
LEFT JOIN (SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.id IN (
SELECT MAX(sh1.id) FROM subscription.SubscriptionHistory sh1 GROUP BY sh1.terminalId)) as SH ON SH.subscriptionId = i.subscriptionId
LEFT JOIN odeal.Terminal t ON t.id = SH.terminalId AND t.subscription_id = SH.subscriptionId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE SH.terminalId IS NOT NULL AND o.id = 301000162
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, SH.terminalId, i.invoiceStatus, i.id, t.id) as Fatura WHERE Fatura.organisationId = 301000162;


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
COUNT(CASE WHEN i.invoiceStatus = 0 THEN i.id END) OVER (PARTITION BY o.id, i.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenAdet,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.totalAmount END) OVER (PARTITION BY o.id, i.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyenTutar,
COUNT(CASE WHEN i.invoiceStatus = 1 THEN i.id END) OVER (PARTITION BY o.id, i.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiAdet,
SUM(CASE WHEN i.invoiceStatus = 1 THEN i.totalAmount END) OVER (PARTITION BY o.id, i.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdendiTutar,
COUNT(CASE WHEN i.invoiceStatus = 2 THEN i.id END) OVER (PARTITION BY o.id, i.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekAdet,
SUM(CASE WHEN i.invoiceStatus = 2 THEN i.totalAmount END) OVER (PARTITION BY o.id, i.id, t.id, DATE_FORMAT(i.periodEnd,"%Y-%m")) as OdenmeyecekTutar,
SUM(CASE WHEN i.invoiceStatus = 0 THEN i.remainingAmount END) OVER (PARTITION BY o.id, i.id, i.subscriptionId, DATE_FORMAT(i.periodEnd,"%Y-%m")) as KalanTutar
FROM subscription.Invoice i
LEFT JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = i.subscriptionId
JOIN odeal.Terminal t ON t.id = sh.terminalId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE sh.terminalId IS NOT NULL AND o.id = 301000162
GROUP BY DATE_FORMAT(i.periodEnd,"%Y-%m"), i.subscriptionId, sh.terminalId, i.invoiceStatus, i.id

SELECT * FROM subscription.SubscriptionHistory sh GROUP BY sh.terminalId

SELECT * FROM (
SELECT t.serial_no as MaliNo, o.vergiNo, m.tckNo, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, t.id as TerminalID, i.id as FaturaID,  i.subscriptionId as AbonelikID, i.organisationId as UyeIsyeriID, DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem, i.periodStart, i.periodEnd, i.receiver, i.totalAmount as FaturaBedeli, i.totalVat as Vergi, i.remainingAmount as Bakiye,  CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ"
    WHEN i.invoiceStatus=1 THEN "ÖDENDİ"
    WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK"
    WHEN i.invoiceStatus=3 THEN "HUKUKİ SÜREÇTE"
    END as FaturaDurum, i._createdDate, i.createdAt
FROM subscription.Invoice i
LEFT JOIN (SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.id IN (
SELECT MAX(sh1.id) FROM subscription.SubscriptionHistory sh1 GROUP BY sh1.subscriptionId)) as SH ON SH.subscriptionId = i.subscriptionId
LEFT JOIN odeal.Terminal t ON t.id = SH.terminalId
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
WHERE SH.terminalId IS NOT NULL AND o.id = 301000079) as Fatura;



SELECT i.organisationId, GROUP_CONCAT(i.period) as Period, GROUP_CONCAT(DATE_FORMAT(i.periodStart,"%Y-%m-%d")) as PeriodBaslangic,
       GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m-%d")) as PeriodBitis, COUNT(*) as Bos_Fatura_Donem
FROM subscription.Invoice i
JOIN odeal.Organisation o ON o.id = i.organisationId
WHERE i.periodStart IS NULL AND i.periodEnd IS NULL
GROUP BY i.organisationId


SELECT
    (SELECT GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m")) as Donem FROM subscription.Invoice i WHERE i.invoiceStatus = 0 AND i.organisationId = o.id GROUP BY i.organisationId) as OdenmediDonem,
        (SELECT GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m")) as Donem FROM subscription.Invoice i WHERE i.invoiceStatus = 1 AND i.organisationId = o.id GROUP BY i.organisationId) as OdendiDonem,
            (SELECT GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m")) as Donem FROM subscription.Invoice i WHERE i.invoiceStatus = 2 AND i.organisationId = o.id GROUP BY i.organisationId) as OdenmeyecekDonem,
                (SELECT GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m")) as Donem FROM subscription.Invoice i WHERE i.invoiceStatus = 3 AND i.organisationId = o.id GROUP BY i.organisationId) as HukukiSurecDonem,
    o.vergiNo,
    m.tckNo,
    IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
    i.id as FaturaID,
    i.subscriptionId as AbonelikID,
    i.organisationId as UyeIsyeriID,
    DATE_FORMAT(i.periodEnd,"%Y-%m") as Donem,
    i.periodStart,
    i.periodEnd,
    i.receiver,
    i.totalAmount as FaturaBedeli,
    i.totalVat as Vergi,
    i.remainingAmount as Bakiye,
    i.vadeli,
    CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ"
    WHEN i.invoiceStatus=1 THEN "ÖDENDİ"
    WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK"
    WHEN i.invoiceStatus=3 THEN "HUKUKİ SÜREÇTE"
    END as FaturaDurum
FROM subscription.Invoice i
JOIN odeal.Organisation o ON o.id = i.organisationId AND o.demo = 0
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
WHERE o.id = 301000079;

SELECT  GROUP_CONCAT(DATE_FORMAT(i.periodEnd,"%Y-%m")) as Donem
FROM subscription.Invoice i
WHERE i.invoiceStatus = 2 AND i.organisationId = 301000079
GROUP BY i.organisationId;

SELECT i.vadeli, COUNT(*) FROM subscription.Invoice i
GROUP BY i.vadeli

SELECT COUNT(*)
FROM subscription.Invoice i
JOIN odeal.Organisation o ON o.id = i.organisationId
WHERE i.periodStart IS NULL AND i.periodEnd IS NULL

SELECT * FROM subscription.Invoice i WHERE i.organisationId = 301018903;

SELECT

SELECT o.id, t.serial_no  FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id WHERE o.id = 301000079


SELECT bp.signedDate, bp.subscriptionId, bp.appliedRate, bp.paymentType, bp.currentStatus, bp.paymentFacilitator FROM odeal.BasePayment bp
                                                                           WHERE bp.currentStatus = 6 AND bp.paymentType <> 4
                                                                           ORDER BY bp._createdDate DESC LIMIT 10000


SELECT * FROM subscription.Invoice i WHERE i.organisationId = 301000079;

SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.terminalId = 285;

SELECT i.subscriptionId, SH.subscriptionId, COUNT(*) FROM subscription.Invoice i
                                  LEFT JOIN (SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.id IN (
SELECT MAX(sh1.id) FROM subscription.SubscriptionHistory sh1 GROUP BY sh1.subscriptionId)) as SH ON SH.subscriptionId = i.subscriptionId
                                  WHERE i.organisationId = 301000079 GROUP BY i.subscriptionId