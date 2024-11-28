SELECT o.id as UyeIsyeriID,
       o.unvan as Unvan,
       o.marka as Marka,
       IF(o.isActivated=1,"Aktif","Pasif") as OrganizasyonStatusu,
       t.serial_no as MaliNo,
       THistory.historyStatus as TerminalTarihiDurum,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalStatusu,
       THistory.physicalSerialId as FizikiSeriNo, THistory.`_createdDate`, THistory.id,
       CASE WHEN s2.id = 2 THEN "OKC" 
       WHEN s2.id = 5 THEN "SADEPOS"
       WHEN s2.id = 7 THEN "EFATURAPOS"
       END as Hizmet
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN (SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY History.serialNo ORDER BY History.`_createdDate` DESC) as Sira2 FROM (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY th.physicalSerialId ORDER BY th.`_createdDate` DESC) as Sira
FROM odeal.TerminalHistory th) as History  
WHERE History.Sira = 1) as History2 WHERE History2.Sira2 = 1) as THistory ON CONVERT(THistory.serialNo USING utf8) = t.serial_no
WHERE o.demo = 0 AND t.serial_no LIKE "PAX%" AND THistory.physicalSerialId IS NULL;

SELECT *, ROW_NUMBER() OVER (PARTITION BY History.serialNo ORDER BY History.`_createdDate` DESC) as Sira2 FROM (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY th.physicalSerialId ORDER BY th.`_createdDate` DESC) as Sira
FROM odeal.TerminalHistory th) as History 
WHERE History.physicalSerialId = "6M606610"


SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th 
GROUP BY th.physicalSerialId) AND th.physicalSerialId = "6M904994";

SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.serialNo) AND th.serialNo = "PAX710059334"

SELECT * FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710059334"

SELECT * FROM odeal.TerminalHistory th WHERE th.physicalSerialId = "6M606610"

SELECT * FROM odeal.Terminal t WHERE t.serial_no = "PAX710029237"

SELECT th.physicalSerialId, Fiziki.physicalSerialId FROM odeal.TerminalHistory th 
RIGHT JOIN (SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th 
GROUP BY th.physicalSerialId) AND th.physicalSerialId = "6K367811") AS Fiziki ON Fiziki.physicalSerialId = th.physicalSerialId 
WHERE th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th 
GROUP BY th.serialNo) AND th.serialNo = "PAX710004861";

6M417725
6K367811 PAX710004861


SELECT t.serial_no, t.organisation_id, s.id, p.name, p.serviceId, s.`_lastModifiedDate`  FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
WHERE t.serial_no = "PAX710005277"

SELECT * FROM odeal.Terminal t WHERE t.serial_no = "PAX710050407"

SELECT * FROM odeal.TerminalHistory th WHERE th.physicalSerialId = "6K367811"

SELECT o.id as UyeIsyeriID,
       o.unvan as Unvan,
       o.marka as Marka,
       IF(o.isActivated=1,"Aktif","Pasif") as OrganizasyonStatusu,
       t.serial_no as MaliNo,
       THistory.historyStatus as TerminalTarihiDurum,
       IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalStatusu,
       THistory.physicalSerialId as FizikiSeriNo, THistory.`_createdDate`, THistory.id
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN (SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY History.physicalSerialId ORDER BY History.`_createdDate` DESC) as Sira2 FROM (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY th.serialNo ORDER BY th.`_createdDate` DESC) as Sira
FROM odeal.TerminalHistory th) as History 
WHERE History.Sira = 1) as History2 WHERE History2.Sira2 = 1) as THistory ON CONVERT(THistory.serialNo USING utf8) = t.serial_no
WHERE o.demo = 0 AND t.serial_no LIKE "PAX%"


SELECT * FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND t.serial_no = "PAX710045958"

SELECT t.organisation_id, t.serial_no, Islemler.id, Islemler.mobile_client_version
FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN (SELECT bp.id, bp.signedDate, pm.payment_id, pm.mobile_client_version FROM odeal.BasePayment bp
JOIN odeal.PaymentMetaData pm ON pm.payment_id = bp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 1 WEEK),"%Y-%m-%d 00:00:00")) as Islemler
ON Islemler.id = tp.id
WHERE Islemler.id IN (
SELECT MAX(Islemler.id)
FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN (SELECT bp.id, bp.signedDate, pm.payment_id, pm.mobile_client_version FROM odeal.BasePayment bp
JOIN odeal.PaymentMetaData pm ON pm.payment_id = bp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 1 WEEK),"%Y-%m-%d 00:00:00")) as Islemler
ON Islemler.id = tp.id
GROUP BY t.organisation_id, t.serial_no)


