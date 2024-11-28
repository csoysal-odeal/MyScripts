SELECT o.id as UyeIsyeriID, 
t.serial_no as MaliNo, 
MAX(s.name) as Hizmet,
MAX(o.activatedAt) as UyeAktivasyonTarih, 
MAX(t.firstActivationDate) as TerminalAktivasyonTarih,
MAX(bp.id) as IslemID, 
MAX(bp.signedDate) as SonIslemTarih, 
MAX(bp.amount) as SonIslemTutar,
DATEDIFF(NOW(),MAX(bp.signedDate)) as FarkGun,
CONCAT(FLOOR(DATEDIFF(NOW(), MAX(bp.signedDate)) / 365)," Yıl ",
FLOOR((DATEDIFF(NOW(), MAX(bp.signedDate)) % 365) / 30)," Ay ",
DATEDIFF(NOW(), MAX(bp.signedDate)) % 30 ," Gün") as GecenZaman
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate <= CURDATE()
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE o.isActivated = 1 AND t.terminalStatus = 1
GROUP BY o.id, t.id, t.serial_no
UNION
SELECT o.id as UyeIsyeriID, 
MAX(s.id) as AbonelikID, 
MAX(s2.name) as Hizmet,
MAX(o.activatedAt) as UyeAktivasyonTarih, 
MAX(s.activationDate) as CeptePosAktivasyonTarihi,  
MAX(bp.id) as SonIslemID, 
MAX(bp.signedDate) as SonIslemTarih, 
MAX(bp.amount) as SonIslemTutar,
DATEDIFF(NOW(),MAX(bp.signedDate)) as FarkGun,
CONCAT(FLOOR(DATEDIFF(NOW(), MAX(bp.signedDate)) / 365)," Yıl ",
FLOOR((DATEDIFF(NOW(), MAX(bp.signedDate)) % 365) / 30)," Ay ",
DATEDIFF(NOW(), MAX(bp.signedDate)) % 30 ," Gün") as GecenZaman
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate <= CURDATE()
LEFT JOIN subscription.Service s2 ON s2.id = bp.serviceId
WHERE o.isActivated = 1 AND o.demo = 0
GROUP BY o.id

SELECT * FROM odeal.BasePayment bp 

SELECT History.serialNo, COUNT(*) FROM (
SELECT * FROM odeal.TerminalHistory th 
WHERE th.`_createdDate` IN (
SELECT MAX(DATE_FORMAT(th.`_createdDate`,"%Y-%m-%d %T")) FROM odeal.TerminalHistory th WHERE th.serialNo LIKE "%PAX%" GROUP BY th.serialNo)) as History
GROUP BY History.serialNo HAVING COUNT(*)>1

SELECT * FROM odeal.TerminalHistory th 
WHERE th.`_createdDate` IN (
SELECT MAX(th.`_createdDate`) FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710001127")


SELECT * FROM odeal.TerminalHistory th 
WHERE th.serialNo = "PAX710001127" ORDER BY th.`_createdDate` DESC

SELECT DATE_FORMAT(NOW(),"%Y-%m-%d %T")

SELECT NOW()

SELECT t.serial_no, bp.signedDate, bp.amount FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 17:00:00" AND t.serial_no = "PAX710014038"