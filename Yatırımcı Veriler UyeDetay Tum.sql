SELECT @Ay:="2024-07",
       @AktivasyonBaslangic:="2024-07-01 00:00:00",
       @AktivasyonBitis:="2024-07-31 23:59:59",
       @iptalBaslangic:="2024-07-01 00:00:00",
       @iptalBitis:="2024-07-31 23:59:59",
       @islemBaslangic:="2024-07-01 00:00:00",
       @islemBitis:="2024-07-31 23:59:59",
       @dolarkur:= 19.30;

-- TAM QUERY (CEPTEPOS+FİZİKİ CİRO BAĞIMSIZ)
SELECT @Ay, "Yeni", o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no as MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal, IF(tp.installment>1,"Taksitli","Tek Çekim") as Taksit,
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, " " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount
AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis 
AND (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis) AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name, IF(tp.installment>1,"Taksitli","Tek Çekim");

UNION

SELECT @Ay, "Baz", o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no as MaliNo,
       s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, IF(tp.installment>1,"Taksitli","Tek Çekim") as Taksit,
COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro, " " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
LEFT JOIN odeal.Payback p2 ON p2.id = bp.paybackId AND p2.paymentStatus 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < @AktivasyonBaslangic AND (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis) AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name, IF(tp.installment>1,"Taksitli","Tek Çekim");



UNION

SELECT @Ay, "Yeni İptal", o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, s2.name as Hizmet,
       s3.sector_name as Sektor, c.name as Kanal, IF(tp.installment>1,"Taksitli","Tek Çekim") as Taksit, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name, IF(tp.installment>1,"Taksitli","Tek Çekim");

UNION

SELECT @Ay, "Baz İptal", o.id as UyeIsyeriID, t.id as TerminalID,  t.serial_no, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal, IF(tp.installment>1,"Taksitli","Tek Çekim") as Taksit,
       COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir  FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name, IF(tp.installment>1,"Taksitli","Tek Çekim");

UNION

SELECT @Ay, "Baz", o.id, o.id as Terminal, o.id as MaliNo, s3.name as Hizmet,s2.sector_name as Sektor, c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit,  COUNT(bp.id) as IslemAdet, 
SUM(bp.amount) as Ciro, " " as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");

UNION

SELECT @Ay, "Yeni", o.id, o.id as Terminal, 
o.id as MaliNo, 
s3.name as Hizmet,s2.sector_name as Sektor,
c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit, 
COUNT(bp.id) as IslemAdet, 
SUM(bp.amount) as Ciro, " " as DolarCiro, 
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir 
FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");

UNION

SELECT @Ay, "Baz İptal", o.id, o.id as Terminal,
       o.id as MaliNo, s3.name as Hizmet,s2.sector_name as Sektor,
c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit,
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir,
" " as DolarGelir
FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim")
UNION
SELECT @Ay, "Yeni İptal", o.id, o.id as Terminal,o.id as MaliNo, s3.name as Hizmet,s2.sector_name as Sektor,
c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit,
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir,
" " as DolarGelir FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND
bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");

SELECT "2023-10", "TUM", SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.currentStatus = 6
UNION
SELECT "2023-10", "Fiziki", SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.currentStatus = 6 AND bp.serviceId <> 3
UNION
SELECT "2023-10", "CeptePos", SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
WHERE bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.currentStatus = 6 AND bp.serviceId = 3

SELECT "2023-11" as Ay, COUNT(t.id) as FizikAktivasyon FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")

SELECT SUM(CeptePos.Ciro) FROM (
SELECT o.id, SUM(bp.amount) as Ciro FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
WHERE s.activationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id)
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.serviceId = 3 AND bp.currentStatus = 6 AND bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59"
WHERE s.activationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id) as CeptePos


SELECT "2023-10", bp.organisationId, s.id, s.activationDate, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.Organisation o ON o.id = bp.organisationId 
JOIN subscription.Subscription s ON s.organisationId = o.id
WHERE bp.signedDate >= "2023-10-01 00:00:00" AND bp.signedDate <= "2023-10-31 23:59:59" AND bp.currentStatus = 6 AND bp.serviceId = 3
GROUP BY bp.organisationId, s.id, s.activationDate
