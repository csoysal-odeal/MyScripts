SELECT 
bp.organisationId as UyeIsyeriID, 
rp.id as TekrarliOdemeID, 
rp.errorRate as TekrarSayisi, 
rp.`_createdDate` as TekrarliOlusmaTarih, 
rp.dueDate as TekrarliOdemeVadesi, 
rp.`_lastModifiedDate`as TekrarliOdemeSonDeneme, 
rpo.cardNumber as KartNumarasi, 
rpo.cardId as KartID, 
rp.errorDate as TekrarliOdemeHata, 
rp.orderId as IslemSiparisID, 
bp.signedDate as IslemTarihi,
bp.cancelDate as IslemIptalTarihi, 
CASE 
	WHEN bp.currentStatus = 0 THEN "INACTIVE"
	WHEN bp.currentStatus = 1 THEN "ACTIVE"
	WHEN bp.currentStatus = 2 THEN "ARCHIVED"
	WHEN bp.currentStatus = 3 THEN "SUSPENDED"
	WHEN bp.currentStatus = 4 THEN "INITIALIZED"
	WHEN bp.currentStatus = 5 THEN "FINALIZED"
	WHEN bp.currentStatus = 6 THEN "PAID"
	WHEN bp.currentStatus = 7 THEN "TRANSACTION_ERROR"
	WHEN bp.currentStatus = 8 THEN "USER_CANCELLED"
	WHEN bp.currentStatus = 9 THEN "MERCHANT CANCELLED"
	WHEN bp.currentStatus = 10 THEN "PAID_BACK"
	WHEN bp.currentStatus = 11 THEN "DELAYED"
	WHEN bp.currentStatus = 12 THEN "SYSTEM_CANCELLED"
	WHEN bp.currentStatus = 13 THEN "REFUND"
	WHEN bp.currentStatus = 14 THEN "PROCESSING"
	WHEN bp.currentStatus = 15 THEN "FAILED"
END as IslemDurum,
bp.currentStatus, 
bp.`_createdDate` as IslemOlusmaTarihi, 
bp.amount as IslemTutar, 
bp.paybackId as BPPaybackID, 
p.id as PaybackID, 
p.amount as GeriOdemeTutar 
FROM odeal.RecurringPayment rp 
JOIN odeal.RecurringPaymentOrder rpo ON rpo.id = rp.orderId
LEFT JOIN odeal.BasePayment bp ON bp.id = rp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE rp.errorRate >= 7 AND bp.currentStatus = 11

SELECT o.id as UyeIsyeri, UPPER(o.marka) as Marka, UPPER(o.unvan) as Unvan, 
UPPER(CONCAT(m.firstName," ",m.LastName)) as Yetkili, m.phone as Telefon, m.email as Email, 
IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0

SELECT t.serial_no, SUM(bp.amount) FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE t.serial_no = "PAX710049660" AND bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00"


SELECT * FROM odeal.BasePayment bp WHERE bp.paymentId  = "31900043"

SELECT * FROM odeal.FailedPayment fp WHERE fp.id = 403577863

SELECT o.id as UyeIsyeri, o.marka as Marka, IF(o.isActivated=1,"Aktif","Pasif") as UyeIsyeriDurum, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.tckNo as TCKNo, m.birthDate as DogumTarihi, m.phone as Telefon,
c.name as UyeIsyeriKanal, c2.name as Sehir, t2.name as Ilce, 
CASE WHEN o.businessType = 0 THEN "Bireysel" 
WHEN o.businessType = 1 THEN "Şahıs" 
WHEN o.businessType = 2 THEN "Tüzel" 
WHEN o.businessType = 3 THEN "Dernek, Apartman Yöneticiliği" END as IsyeriTipi, 
s2.sector_name as Sektor, s3.name as Hizmet, t.serial_no as Terminal, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum, o.activatedAt as OrgAktivasyonTarihi 
FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s3 ON s3.id = p.serviceId 
LEFT JOIN odeal.Town t2 ON t2.id = o.townId 
LEFT JOIN odeal.City c2 ON c2.id = o.cityId 
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId 
WHERE o.demo = 0 ORDER BY o.id, t.firstActivationDate

SELECT * FROM odeal.Organisation o WHERE o.id = 301256535

SELECT o.id, o.marka, o.unvan, t.id, t.organisation_id, t.serial_no, s2.name, t.terminalStatus FROM odeal.Terminal t
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE s2.id = 7 AND t.organisation_id = 301100049

SELECT * FROM odeal.Channel c 

SELECT * FROM (
SELECT MONTH(bp.signedDate) as Ay, o.id as UyeID, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.Organisation o ON o.id = bp.organisationId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
GROUP BY o.id, MONTH(bp.signedDate) HAVING SUM(bp.amount)>=100000 ORDER BY SUM(bp.amount) DESC
LIMIT 400) as Ocak400
JOIN (SELECT * FROM (
SELECT MONTH(bp.signedDate) as Ay, o.id as UyeID, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.Organisation o ON o.id = bp.organisationId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
GROUP BY o.id, MONTH(bp.signedDate) HAVING SUM(bp.amount)>=100000 ORDER BY SUM(bp.amount) DESC
LIMIT 400) as Subat400) as Subat400 ON Subat400.UyeID = Ocak400.UyeID

SELECT * FROM (
SELECT MONTH(bp.signedDate) as Ay, o.id as UyeID, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp
JOIN odeal.Organisation o ON o.id = bp.organisationId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
GROUP BY o.id, MONTH(bp.signedDate) HAVING SUM(bp.amount)>=100000 ORDER BY SUM(bp.amount) DESC
LIMIT 400) as Subat400

SELECT o.id, t.serial_no, s.id, p.name, p.commissionRate, p.commissionRates, s2.name, OzelTerminalKomisyon.TerminalKomisyon FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN (SELECT t.organisation_id as UyeIsyeriID, o.marka as Marka, t.serial_no as MaliNo, ir.terminalId as TerminalID, p.name as Plan, s.name as Servis, ir.installment as Taksit, ir.comission as TerminalKomisyon,
       ir.`_createdDate` as OlusmaTarihi, ir.expiryDate as BitisTarihi, IF(ir.status=2,"Aktif","Pasif") as Durum, bp.id, bp.signedDate, bp.amount, bp.appliedRate FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE ir.terminalId IS NOT NULL AND ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.installment = 1 AND bp.signedDate >= ir._createdDate AND bp.currentStatus = 6 AND tp.installment IN (0,1) AND ir.status = 2 AND bp.paymentType <> 4) as OzelTerminalKomisyon
ON OzelTerminalKomisyon.MaliNo = t.serial_no AND OzelTerminalKomisyon.UyeIsyeriID = o.id
WHERE p.serviceId <> 3 AND o.id = 301039383


SELECT t.organisation_id as UyeIsyeriID, o.marka as Marka, t.serial_no as MaliNo, ir.terminalId as TerminalID, p.name as Plan, s.name as Servis, ir.installment as Taksit, ir.comission as TerminalKomisyon,
       ir.`_createdDate` as OlusmaTarihi, ir.expiryDate as BitisTarihi, IF(ir.status=2,"Aktif","Pasif") as Durum, bp.id, bp.signedDate, bp.amount, bp.appliedRate FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE ir.terminalId IS NOT NULL AND ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.installment = 1 AND bp.signedDate >= ir._createdDate AND bp.currentStatus = 6 AND tp.installment IN (0,1) AND ir.status = 2 AND bp.paymentType <> 4

SELECT Islemler.UyeIsyeriID, Islemler.MaliNo, Islemler.TerminalKomisyon, SUM(Islemler.amount) FROM (
SELECT t.organisation_id as UyeIsyeriID, o.marka as Marka, t.serial_no as MaliNo, ir.terminalId as TerminalID, p.name as Plan, s.name as Servis, ir.installment as Taksit, ir.comission as TerminalKomisyon,
       ir.`_createdDate` as OlusmaTarihi, ir.expiryDate as BitisTarihi, 
       IF(ir.status=2,"Aktif","Pasif") as Durum, bp.id, bp.signedDate, 
       bp.amount, bp.appliedRate FROM odeal.InstallmentRule ir
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE ir.terminalId IS NOT NULL AND ir.terminalId IS NOT NULL AND ir.brandId = 27 AND ir.installment = 1 AND bp.signedDate >= ir._createdDate AND bp.currentStatus = 6 AND tp.installment IN (0,1) AND ir.status = 2 AND bp.paymentType <> 4
) as Islemler
WHERE Islemler.UyeIsyeriID = 301084795
GROUP BY Islemler.UyeIsyeriID, Islemler.MaliNo, Islemler.TerminalKomisyon 

SELECT bp.organisationId, MAX(bp.signedDate) as SonIslem, SUM(bp.amount) FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.serviceId <> 3 AND bp.organisationId = 301084795 AND bp.signedDate >= "2024-02-05 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
GROUP BY bp.organisationId

SELECT bp.organisationId, bp.appliedRate, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.serviceId = 3 AND bp.organisationId = 301084795
GROUP BY bp.organisationId, bp.appliedRate


SELECT * FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id