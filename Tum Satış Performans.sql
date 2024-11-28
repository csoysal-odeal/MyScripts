
SELECT e.id AS einvoiceId,
bp.id AS basepaymentId, 
e.organisationId AS OrgID,bp.organisationId as UyeIsyeriID,
s.id as AbonelikID, p.serviceId as HizmetID,
e.invoiceType AS FaturaTipi,
e.created_date AS FaturaTarihi, 
e.last_modified_date AS FaturaGuncellenmeTarihi, 
IF(bp.isExternallyGenerated=0,"Cihazdan","Bankadan") as IslemKaynak,
bp.signedDate AS IslemTarihi,
DATE(bp.signedDate) as IslemTarih,
bp.`_createdDate` as IslemOlusmaTarihi, 
b.gross_price AS Tutar,
bp.currentStatus, e.basketId as BasketID,
bp.serviceId as IslemServis, bp.amount,
e.status AS Statu, 
e.state AS Durum, 
c.einvoice_integrator AS Entegrator,
b.created_by AS Olusturan, 
t.serial_no, t.model, br.transaction_date, br.unique_key,
pmd.payment_id as PmPaymentID, pmd.mobile_client_type  as PmModel, pmd.mobile_client_version as PmVersiyon
FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON bp.id = tp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.EInvoice e ON bp.basketId = e.basketId 
LEFT JOIN retail.basket b ON b.id = e.basketId
LEFT JOIN retail.configuration c ON c.organisation_id = t.organisation_id
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey
LEFT JOIN PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE DATE_FORMAT(bp.signedDate,"%Y-%m-%d")>= DATE_FORMAT(CURDATE()-INTERVAL 31 DAY,"%Y-%m-%d") AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= DATE_FORMAT(CURDATE(),"%Y-%m-%d")


SELECT wol.SerialNumber, count(*), MAX(wol.CreatedDate) FROM stargate.WorkOrderLog wol 
GROUP BY wol.SerialNumber 

SELECT * FROM stargate.WorkOrderLog wol 
WHERE wol.SerialNumber = "PAX710013542"

SELECT t.serial_no, a.name, t.model FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Addon a ON a.id = p.addonId
WHERE t.serial_no = "PAX710013542"

SELECT * FROM stargate.ExternalStockDetail esd 

SELECT * FROM odeal.TerminalMerchantMappingHistory tmmh 

SELECT * FROM odeal.BasePayment bp 
WHERE bp.deviceId 

WHERE esd.FieldService = 'propay' 6

SELECT o.id, o.marka, o.unvan, o.latitude, o.longitude, o.address,CONCAT(c2.firstName," ",c2.lastName) as Customer, c.name as Sehir, t.name as Ilce, Islemler.organisationId, Islemler.customerId, Islemler.IslemID, Islemler.paymentType, Islemler.amount, Islemler.deviceId, d.manufacturer, d.device, d.osVersion, Islemler.signedDate, 
Islemler.latitude, Islemler.longitude FROM odeal.Organisation o
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t ON t.id = o.townId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN (SELECT bp.organisationId, bp.customerId, bp.id as IslemID, bp.paymentType, bp.signedDate, bp.amount, bp.deviceId, bp.latitude, bp.longitude FROM odeal.BasePayment bp 
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-11-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30") as Islemler ON Islemler.organisationId = o.id
LEFT JOIN odeal.Customer c2 ON c2.id = Islemler.customerId
LEFT JOIN odeal.Device d ON d.id = Islemler.deviceId
WHERE o.demo = 0 AND o.id IN (SELECT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId AND p.serviceId = 3
GROUP BY o.id);

SELECT * FROM odeal.BasePayment bp
WHERE bp.paybackId = 38301668

SELECT CONCAT(c.firstName," ",c.lastName) as Customer, c.* FROM odeal.Customer c 

SELECT * FROM retail.customer c 

(SELECT bp.organisationId, bp.id as IslemID, bp.signedDate, bp.amount, bp.latitude, bp.longitude FROM odeal.BasePayment bp 
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-09-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30") as Islemler ON Islemler.organisationId = o.id

SELECT MAX(Islemler.Adet) as Adet FROM (SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Tarih, bp.currentStatus as IslemDurum, COUNT(bp.id) as Adet FROM odeal.BasePayment bp 
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-01-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30"
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m-%d"), bp.currentStatus) as Islemler 

SELECT * FROM odeal.Payback p
WHERE p.id = 38301668


SELECT bp.id, bp.signedDate, bp.amount, bp.latitude, bp.longitude FROM odeal.BasePayment bp 
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-09-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30"


SELECT DISTINCT o.id, s2.name, c.name FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId AND 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.Channel c ON c.id = s.channelId 
WHERE o.id IN (SELECT CepPos.OrgID FROM (SELECT CeptePos.Kanal, CeptePos.id as OrgID, COUNT(*) as Adet FROM (SELECT c.name as Kanal, o.id, COUNT(*) as Adet FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1 
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.Channel c ON c.id = s.channelId
/*JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.serviceId = 3
WHERE bp.currentStatus = 6*/
GROUP BY c.id, o.id) as CeptePos
WHERE CeptePos.Kanal IS NULL
GROUP BY CeptePos.Kanal, CeptePos.id) as CepPos)

SELECT * FROM stargate.ExternalStockDetail esd 

SELECT * FROM stargate.ExternalStockTotal est 

SELECT * FROM subscription.Subscription s 
WHERE s.organisationId = 301018337

SELECT * FROM subscription.SubscriptionHistory sh 
WHERE sh.subscriptionId = 27886

SELECT * FROM subscription.SubscriptionHistory sh 
WHERE sh.subscriptionId = 25


SELECT o.id, o.address, c.name as Sehir, t.name as Ilce, o.latitude, o.longitude FROM odeal.Organisation o 
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t ON t.id = o.townId

SELECT p.name, p.amount FROM subscription.Plan p 
WHERE p.serviceId = 3

SELECT * FROM odeal.BasePayment bp 

SELECT bp.organisationId, bp.serviceId, bp.signedDate, bp.amount, bp.latitude, bp.longitude FROM odeal.BasePayment bp WHERE bp.id IN (SELECT MIN(bp.id) FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2015-01-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30" 
GROUP BY bp.organisationId) 


SELECT o.id, MIN(bp.id) as IlkID FROM odeal.Organisation o
  LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2023-01-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= "2023-11-30"
  WHERE bp.id IS NOT NULL AND o.id IN (SELECT CeptePosAbonelik.organisationId FROM (SELECT DISTINCT s2.*,s.organisationId, s.start,s.status,s.channelId,s.planId 
  FROM subscription.Subscription s
  JOIN subscription.Plan p ON p.id = s.planId
  JOIN subscription.Service s2 on s2.id = p.serviceId
  JOIN odeal.Organisation o ON o.id = s.organisationId AND o.demo = 0
  WHERE s.status = 1 AND p.serviceId = 3
  and s.planId = p.id AND p.serviceId = s2.id order by s.start desc) as CeptePosAbonelik
GROUP BY CeptePosAbonelik.organisationId)


SELECT cd.fromPlanId, p.name, p.amount,  cd.toPlanId, p.name, OrgFromPlan.organisation_id, OrgFromPlan.serial_no FROM subscription.Plan p 
LEFT JOIN odeal.CampaignDefinition cd ON cd.fromPlanId = p.id 
LEFT JOIN odeal.CampaignDefinition cd2 ON cd2.toPlanId = p.id
JOIN (SELECT t.organisation_id, t.serial_no, p.id, p.name, p.amount, p.intervalCount FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId;
GROUP BY o.id, o.marka) as OrgFromPlan ON OrgFromPlan.id = cd.fromPlanId
WHERE cd.fromPlanId IS NOT NULL

SELECT s.group_date  FROM payout_source.source s 

SELECT SourceHistory.*, s.status as KartDurum, s.merchant_id, s.terminal_id,s.request_date, s.group_date  FROM payout_source.source s 
LEFT JOIN (SELECT * FROM payout_source.source_history sh 
WHERE sh.id IN (SELECT MAX(sh.id) FROM payout_source.source_history sh 
GROUP BY sh.record_id)) as SourceHistory ON SourceHistory.record_id = s.record_id
WHERE s.terminal_id IS NOT NULL

SELECT bp.currentStatus as IslemDurum, MIN(bp.signedDate) as IlkTarih, MAX(bp.signedDate) as SonTarih, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Tutar FROM odeal.BasePayment bp 
WHERE bp.signedDate >= NOW() - INTERVAL 31 DAY AND 
bp.signedDate <= NOW()
GROUP BY bp.currentStatus


SELECT t.organisation_id, t.serial_no, p.name, p.amount, p.intervalCount FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId;
GROUP BY o.id, o.marka