SELECT t.organisation_id, t.serial_no, bp.amount as Ciro, bp.signedDate as IslemTarih, bp.id as IslemID, s.id as AbonelikID FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00"
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id

SELECT bp.organisationId, 
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-01" THEN bp.amount END) as 2024_01_Ciro,
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-02" THEN bp.amount END) as 2024_02_Ciro,
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-03" THEN bp.amount END) as 2024_03_Ciro,
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-04" THEN bp.amount END) as 2024_04_Ciro,
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-05" THEN bp.amount END) as 2024_05_Ciro,
SUM(CASE DATE_FORMAT(bp.signedDate,"%Y-%m") WHEN "2024-06" THEN bp.amount END) as 2024_06_Ciro FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= CURDATE()
AND tp.installment IN (0,1)
GROUP BY bp.organisationId

SELECT 
CASE i.invoiceStatus WHEN 0 THEN "Ödenmedi"
WHEN 1 THEN "Ödendi" WHEN 2 THEN "Ödenmeyecek" END as FaturaDurum FROM subscription.Invoice i 

SELECT * FROM subscription.Invoice i 

SELECT Uyeler.id as UyeID, Uyeler.serial_no, Uyeler.AbonelikID, Uyeler.currentPeriodStart, Uyeler.currentPeriodEnd, Uyeler.cancelledAt FROM (
 SELECT o.id, t.serial_no, s.currentPeriodStart, s.id as AbonelikID, s.currentPeriodEnd, s.cancelledAt FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId <> 3 AND s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t on t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE p.serviceId <> 3 AND o.demo = 0
GROUP BY o.id, t.serial_no)) as Uyeler

SELECT i.id as FaturaID, i.organisationId, i.subscriptionId, i.periodStart, i.periodEnd, i.totalAmount, i.remainingAmount, CASE i.invoiceStatus WHEN 0 THEN "Ödenmedi"
WHEN 1 THEN "Ödendi" WHEN 2 THEN "Ödenmeyecek" END as FaturaDurum
FROM subscription.Invoice i WHERE i.id IN (
SELECT MAX(i.id) FROM subscription.Invoice i 
GROUP BY i.organisationId, i.subscriptionId )



SELECT o.id as UyeIsyeriID, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59" 
GROUP BY o.id, IF(o.isActivated=1,"Aktif","Pasif")