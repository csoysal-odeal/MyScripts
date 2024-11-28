SELECT o.id, COUNT(bp.id) as IslemAdet,  SUM(bp.amount) as Toplam FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND t.terminalStatus = 1
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 7
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.paymentType = 7 AND bp.serviceId = 7
GROUP BY o.id ORDER BY COUNT(bp.id) DESC LIMIT 100

SELECT o.id, SUM(bp.amount) as Ciro FROM odeal.Organisation o 

JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.paymentType = 7
GROUP BY o.id


SELECT o.id, t.serial_no, t.firstActivationDate, s2.name, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, IF(o.isActivated=1,"Akitf","Pasif") as UyeDurum, MIN(bp.signedDate) as IlkIslemTarihi FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND t.terminalStatus = 1
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <>3
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
WHERE t.firstActivationDate <= "2023-12-31 23:59:59"
GROUP BY o.id, t.serial_no, t.firstActivationDate, s2.name

SELECT DATE_FORMAT(t.firstActivationDate,"%Y-%m") as Yil, t.serial_no, t.firstActivationDate, s.cancelledAt, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum,
CASE WHEN t.supplier = "INGENICO" THEN "INGENICO"
WHEN t.supplier = "PROFILO" THEN "PROFILO" 
WHEN t.supplier = "HUGIN" THEN "HUGIN" 
WHEN t.supplier IN ("PROPAY","IBM") THEN "PAYSER" END as Tedarikci FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
WHERE t.firstActivationDate <= "2023-12-31 23:59:59" AND t.firstActivationDate >= "2021-01-01 00:00:00"
GROUP BY DATE_FORMAT(t.firstActivationDate,"%Y-%m"), Tedarikci, IF(t.terminalStatus=1,"Aktif","Pasif"), t.firstActivationDate, t.serial_no,s.cancelledAt
ORDER BY DATE_FORMAT(t.firstActivationDate,"%Y-%m") DESC

SELECT o.id, o.address, c.name as Sehir, t2.name as Ilce, MAX(bp.signedDate) as SonIslemTarihi, s2.sector_name as Sektor FROM odeal.Organisation o
JOIN odeal.City c ON c.id = o.cityId 
JOIN odeal.Town t2 ON t2.id = o.townId 
JOIN odeal.Sector s2 ON s2.id = o.sectorId 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2023-08-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE c.name = "İstanbul"
GROUP BY o.id

SELECT * FROM odeal.City c 


SELECT * FROM (

UNION
SELECT * FROM odeal.TerminalHistory th WHERE th.id IN 
(SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.serialNo)
AND th.historyStatus = "ACTIVATED") AS History
LIMIT 5

SELECT * FROM odeal.TerminalHistory th 
WHERE th.serialNo = "PAX710000232"

SELECT * FROM (
SELECT th.id, th.serialNo, th.setupKey, th.organisationId, th.physicalSerialId, th.historyStatus, th.description FROM odeal.TerminalHistory th WHERE th.id IN 
(SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.serialNo)
AND th.historyStatus = "SETUP_COMPLETED"
UNION 
SELECT th.id, th.serialNo, th.setupKey, th.organisationId, th.physicalSerialId, "ACTIVATED" as historyStatus, "completedtoactivated" as description FROM odeal.TerminalHistory th WHERE th.id IN 
(SELECT MAX(th.id) FROM odeal.TerminalHistory th GROUP BY th.serialNo) AND th.historyStatus = "SETUP_COMPLETED") as History
ORDER BY History.serialNo


SELECT th.id, th.serialNo, th.setupKey, th.organisationId, th.physicalSerialId, "ACTIVATED" as historyStatus, "completedtoactivated" as description FROM odeal.TerminalHistory th 
WHERE th.id IN 
(SELECT MAX(th.id) FROM odeal.TerminalHistory th GROUP BY th.serialNo) AND th.historyStatus = "SETUP_COMPLETED"



SELECT DISTINCT o.id as Org, t.serial_no as Mali, p.id as Plan, cd.fromPlanId, cd2.toPlanId FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND t.terminalStatus = 1
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.vadeli = 1
LEFT JOIN odeal.CampaignDefinition cd ON cd.fromPlanId = p.id
LEFT JOIN odeal.CampaignDefinition cd2 ON cd2.toPlanId = p.id



SELECT tmmh.serial_no, COUNT(*) FROM odeal.TerminalMerchantMappingHistory tmmh 
WHERE tmmh.acquiring_id IS NOT NULL AND tmmh.status = "ACTIVE"
GROUP BY tmmh.serial_no 

SELECT cd.status, COUNT(cd.fromPlanId) FROM odeal.CampaignDefinition cd 
GROUP BY cd.status 


SELECT meh.merchant_id, meh.identifier_no, meh.`type`,  MAX(meh.envelope_status) as Basarili FROM odeal.MerchantEnvelopeHistory meh 
JOIN odeal.Organisation o ON o.id = meh.merchant_id AND o.demo = 0 AND o.isActivated = 1
GROUP BY meh.merchant_id, meh.identifier_no, meh.`type`  HAVING MAX(meh.envelope_status) = "1300"

SELECT meh.merchant_id, meh.`type`, MAX(meh.envelope_status), COUNT(*) FROM odeal.MerchantEnvelopeHistory meh 
WHERE meh.merchant_id = 301001089
GROUP BY meh.merchant_id, meh.`type` 


SELECT
id as  'Satış Kanal Id',
name as  'Satış Kanal Adı',
description as 'Satış Kanalı Tanımı',
tenantName as 'Tenant Adı',
CASE WHEN name LIKE '%bayi%' OR id IN (17,28,52,149) THEN 'Bayi' 
	 WHEN name LIKE '%İş Ortağı%' THEN 'İş Ortağı'
     WHEN name LIKE '%belbim%' THEN 'Belbim' 
     WHEN name LIKE '%bank%' or id=16 THEN (CASE WHEN name NOT LIKE '%ce%' THEN 'Kanal Satış' ELSE 'Mobil Uygulama' END)
     WHEN name LIKE '%kurumsal%' THEN 'Kurumsal Satış' 
     WHEN name LIKE '%pazaryeri%' THEN 'Pazaryeri' 
     WHEN id=1 THEN 'Saha Satış' 
     WHEN name LIKE '%telesatış%' THEN 'Telesatış' 
     WHEN name LIKE '%web%' THEN 'Pazaryeri' 
     WHEN  name  LIKE '%cep%' THEN 'Mobil Uygulama'
     WHEN  name LIKE '%ceb%'  THEN 'Mobil Uygulama'
     WHEN (id>=3 AND id<=12 ) OR id=32 THEN "Diğer"
     ELSE name
     END AS 'Satış Kanalı Grubu'
FROM odeal.Channel c

SELECT o.id, o.organisationId, o.marka, o.vergiNo, IF(o.isActivated=1,"Akitf","Pasif") as UyeDurum FROM odeal.Organisation o 
WHERE o.vergiNo = 10730991752

SELECT o.id, o.organisationId, o.marka, o.vergiNo, IF(o.isActivated=1,"Akitf","Pasif") as UyeDurum, IF(s.status=1,"Aktif","Pasif") as AbonelikDurum FROM odeal.Organisation o 
-- LEFT JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0 AND o.vergiNo = 10941535

SELECT tmmh.merchant_id, tmmh.serial_no, tmmh.physical_serial_no, tmmh.name, tmmh.acquiring_id, b.name as Banka, tmmh.mid, tmmh.tid, tmmh.version, tmmh.supplier as Tedarikci, tmmh.state as BankaDurum, tmmh.status as VersiyonDurum, t.supplier as TerminalTedarikci, s2.name FROM odeal.TerminalMerchantMappingHistory tmmh 
LEFT JOIN odeal.Terminal t ON t.organisation_id = tmmh.merchant_id AND t.serial_no = tmmh.serial_no
LEFT JOIN odeal.Bank b ON b.bankCode = tmmh.acquiring_id
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE tmmh.id IN (
SELECT MAX(tmmh.id) FROM odeal.TerminalMerchantMappingHistory tmmh
WHERE tmmh.status = "ACTIVE"
GROUP BY tmmh.merchant_id, tmmh.serial_no, tmmh.version)

SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-01")


SELECT 24252 - (SELECT SUM(bp.amount) FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate < "2024-02-29 00:00:00"
AND t.serial_no = "2A20142380")


SELECT o.id, count(*) FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE c.id = 213
GROUP BY o.id

SELECT * FROM odeal.Channel c WHERE c.name LIKE "%dinamik%"

SELECT * FROM odeal.TerminalMerchantMappingHistory tmmh 
WHERE tmmh.supplier = "HUGIN"

SELECT e.id AS einvoiceId,bp.id AS basepaymentId, e.organisationId AS "Organizasyon Id",e.invoiceType AS "Fatura Tipi",t.id as terminal_id, t.serial_no as "Mali No",
e.created_date AS "Fatura Oluşturulma Tarihi", e.last_modified_date AS "Fatura Güncellenme Tarihi",
bp.signedDate AS "İşlem Tarihi",b.gross_price AS "Tutar",
TIME_TO_SEC(TIMEDIFF(e.created_date,bp.`_createdDate`)) AS "Fatura Oluşma Süresi",
CASE WHEN e.state IN ("COMPLETED","CANCELLED") THEN 
	IF(bp.id IS NULL,TIME_TO_SEC(TIMEDIFF(e.last_modified_date ,e.created_date)),
	TIME_TO_SEC(TIMEDIFF(e.last_modified_date ,bp.`_createdDate`))) ELSE NULL END AS "Fatura Tamamlanma Süresi",
bp.currentStatus, bp.serviceId,
IF(COALESCE(tp.installment,p.installment) = 1 OR
COALESCE(tp.installment,p.installment) = 0 OR
bp.id IS NULL, "Tek Çekim","Taksitli") AS "İşlem Türü",
IF(bp.id IS NULL, "Nakit İşlem", "İşlem Kaydı Var") AS "İşlem Kaydı",
e.status AS "Statü", e.state AS "Durum", e.integrator AS "Entegratör", b.created_by AS "Oluşturan"
FROM odeal.EInvoice e 
LEFT JOIN odeal.BasePayment bp ON bp.basketId = e.basketId 
LEFT JOIN odeal.TerminalPayment tp ON bp.id = tp.id 
LEFT JOIN odeal.Terminal t ON tp.terminal_id = t.id 
LEFT JOIN odeal.Payment p ON p.id = bp.id 
JOIN retail.basket b ON b.id = e.basketId
WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND bp.signedDate <= NOW()


select i.id as FaturaID, i.receiver as UyeIsyeri, i.sender, i.toAddress, i.fromAddress, i.phoneNumber, i.mail, i.city, i.totalAmount, i.totalVat, i.remainingAmount, i.description, i.paid, i.subscriptionId, i.organisationId,
i.period, i.periodStart, i.periodEnd, i.createdAt, i.invoiceStatus, i.`_createdDate`, i.`_lastModifiedDate` from subscription.Invoice i
where date(period)>= '2021-01-01'
and i.remainingAmount > 0