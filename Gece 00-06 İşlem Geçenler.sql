SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Gun, bp.organisationId,MIN(bp.signedDate) as Ilk, MAX(bp.signedDate) as Son, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp
-- JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
-- JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-10-01" and DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-12-08" 
AND DATE_FORMAT(bp.signedDate,"%H") >= "00" AND DATE_FORMAT(bp.signedDate,"%H") <= "05"
-- AND bp.organisationId = 301197575
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m-%d"), bp.organisationId 
-- t.serial_no



-- DATE_FORMAT(bp.signedDate,"%Y-%m-%d"),

DATE_FORMAT(bp.signedDate,"%Y-%m-%d %h:%m:%s")

SELECT *, DATE_FORMAT(bp.signedDate,"%H") as Saat FROM odeal.BasePayment bp
WHERE DATE_FORMAT(bp.signedDate,"%H") >= "00" AND DATE_FORMAT(bp.signedDate,"%H") <= "06"

SELECT * FROM odeal.CampaignDefinition cd 
WHERE cd.FromPlanId = 14847

SELECT * FROM odeal.CampaignDefinition cd 
WHERE cd.toPlanId = 14847

SELECT * FROM subscription.Plan p 
WHERE p.id = 13265

SELECT sh.terminalId, sh.subscriptionId, MAX(sh.`start`), sh.planId, p.intervalCount FROM subscription.SubscriptionHistory sh 
LEFT JOIN subscription.Plan p ON p.id = sh.planId
WHERE sh.terminalId IS NOT NULL AND p.vadeli = 1 AND p.isFinanced = 0
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId

SELECT t.id as TerminalId, t.serial_no, s.id as Abonelik, p.id as Plan, p.intervalCount, p.vadeli, p.isFinanced, 
(SELECT cd.toPlanId FROM odeal.CampaignDefinition cd WHERE cd.FromPlanId = p.id) as ToPlanID, 
(SELECT cd.FromPlanId FROM odeal.CampaignDefinition cd WHERE cd.toPlanId = p.id) as FromPlanID FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId
WHERE t.terminalStatus = 1 AND p.vadeli = 1 AND p.isFinanced = 0R

SELECT
  t.serial_no,
  s.id AS Abonelik,
  p.id AS Plan,
  p.intervalCount,
  p.vadeli,
  p.isFinanced,
  cd.ToPlanId AS FromPlanId,
  p2.intervalCount AS FromPlanId_intervalCount
FROM
  odeal.Terminal t
  JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
  JOIN subscription.Plan p ON p.id = s.planId
  LEFT JOIN odeal.CampaignDefinition cd ON cd.FromPlanId = p.id
  LEFT JOIN subscription.Plan p2 ON p2.id = cd.ToPlanId
WHERE
  t.terminalStatus = 1 AND p.vadeli = 1 AND p.isFinanced = 0;
 
 SELECT t.serial_no, t.organisation_id, t.setupCityId, t.setupTownId, bp.serviceId, bp.latitude, bp.longitude FROM odeal.Terminal t
 JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
 JOIN odeal.BasePayment bp ON bp.id = tp.id 
 WHERE t.serial_no = "PAX710040552" 

SELECT CeptePos.UyeId, CeptePos.marka, CeptePos.Abonelik, CeptePos.activationDate as AktivasyonTarih, CeptePos.name as Plan, 
CeptePos.iban as Iban, CeptePos.paymentStatus as PaybackStatus, MAX(CeptePos.mobile_client_type) as Model, MAX(CeptePos.mobile_client_version) as Version, COUNT(CeptePos.paymentStatus) as Payback, SUM(CeptePos.IslemAdet) as IslemAdet, SUM(CeptePos.Tutar) as Ciro  FROM (
SELECT
o.id as UyeID, o.marka, s.id as Abonelik, s.activationDate, p.name, bi.iban, p3.id, p3.paymentStatus, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Tutar,
pmd.mobile_client_type, pmd.mobile_client_version FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6
LEFT JOIN odeal.Payback p3 ON p3.id = bp.paybackId AND (p3.paymentStatus NOT IN (1,5) OR p3.paymentStatus IS NOT NULL)
JOIN odeal.BankInfo bi ON bi.organisationId = o.id AND bi.status = 1
JOIN odeal.Payment p2 ON p2.id = bp.id AND bp.serviceId = 3
JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id 
WHERE s.id IN (
SELECT MIN(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p on p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId 
GROUP BY o.id)
AND bp.signedDate  >= "2023-12-20 00:00:00" 
GROUP BY 
o.id, s.id, s.activationDate, p.name, bi.iban, p3.id, p3.paymentStatus,
pmd.mobile_client_type, pmd.mobile_client_version
UNION 
SELECT
o.id as UyeID, o.marka, s.id as Abonelik, s.activationDate, p.name, bi.iban, p3.id, p3.paymentStatus, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Tutar,
pmd.mobile_client_type, pmd.mobile_client_version FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6
LEFT JOIN odeal.Payback p3 ON p3.id = bp.paybackId AND p3.paymentStatus IN (1,5)
JOIN odeal.BankInfo bi ON bi.organisationId = o.id AND bi.status = 1
JOIN odeal.Payment p2 ON p2.id = bp.id AND bp.serviceId = 3
JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id 
WHERE s.id IN (
SELECT MIN(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p on p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId 
GROUP BY o.id)
AND bp.signedDate  >= "2023-12-20 00:00:00" AND p3.paymentStatus IS NOT NULL
GROUP BY 
o.id, s.id, s.activationDate, p.name, bi.iban, p3.id, p3.paymentStatus,
pmd.mobile_client_type, pmd.mobile_client_version) as CeptePos
WHERE CeptePos.UyeID = 301032953
GROUP BY CeptePos.marka, CeptePos.Abonelik, CeptePos.activationDate, CeptePos.name, CeptePos.iban, CeptePos.paymentStatus



SELECT * FROM odeal.PaymentMetaData pmd 

SELECT * FROM subscription.Addon a 

SELECT * FROM odeal.BasePayment bp 
JOIN odeal.Payback p ON p.id = bp.paybackId
JOIN odeal.TerminalPayment tp  ON tp.id = bp.id AND bp.serviceId <> 3
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.signedDate >= "2023-12-22 12:00:00" 



SELECT t.organisation_id, t.serial_no, MAX(bp.id), MAX(bp.signedDate) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE t.organisation_id = 301000793
GROUP BY t.organisation_id, t.serial_no

SELECT th.*,s2.name as Hizmet,
CASE 
WHEN s.status = 0 THEN "Pasif"
WHEN s.status = 1 THEN "Aktif"
WHEN s.status = 2 THEN "Arşiv"
WHEN s.status = 3 THEN "Askıda"
WHEN s.status = 4 THEN "İptal"
WHEN s.status = 5 THEN "Durduruldu"
WHEN s.status = 6 THEN "Uzatıldı"
ELSE "Boş"
END as AbonelikDurum,
IF(t.terminalStatus=0,"Pasif",IF(t.terminalStatus=1,"Aktif","Boş")) as TerminalDurum, 
IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum  
FROM odeal.TerminalHistory th 
LEFT JOIN odeal.Organisation o ON o.id = th.organisationId 
LEFT JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th 
GROUP BY th.serialNo )

SELECT * FROM subscription.Service s 