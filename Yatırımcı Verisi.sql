 SELECT @Ay:="2023-12",
       @AktivasyonBaslangic:="2023-12-01 00:00:00",
       @AktivasyonBitis:="2023-12-30 23:59:59",
       @iptalBaslangic:="2023-12-01 00:00:00",
       @iptalBitis:="2023-12-30 23:59:59",
       @islemBaslangic:="2023-12-01 00:00:00",
       @islemBitis:="2023-12-30 23:59:59",
       @dolarkur:= 19.30;

-- TAM QUERY (CEPTEPOS+FİZİKİ CİRO BAĞIMSIZ)
-- FİZİKİ BAZ
SELECT @Ay, 'Baz' as Durum, FizikiBaz.UyeIsyeriID, FizikiBaz.TerminalID, FizikiBaz.MaliNo,
       FizikiBaz.Hizmet, FizikiBaz.Sektor, FizikiBaz.Kanal,
Islemler.Taksit, Islemler.IslemAdet, Islemler.Ciro, Islemler.DolarCiro, Islemler.Gelir, Islemler.DolarGelir
FROM odeal.Terminal t
LEFT JOIN (SELECT t.id, t.organisation_id, t.serial_no, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
        WHEN bp.appliedRate > 0 AND tp.installment <= 1 THEN 'Tek Çekim'
        WHEN tp.installment > 1 THEN 'Taksitli' END as Taksit, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro, " " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
GROUP BY t.id, t.organisation_id, t.serial_no, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
        WHEN bp.appliedRate > 0 AND tp.installment <= 1 THEN 'Tek Çekim'
        WHEN tp.installment > 1 THEN 'Taksitli' END) AS Islemler ON Islemler.id = t.id
JOIN (
SELECT  o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no as MaliNo, s.id as AbonelikID,
        s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal, t.firstActivationDate, p.serviceId,
        CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId) as FizikiBaz ON FizikiBaz.TerminalID = t.id
WHERE FizikiBaz.firstActivationDate < @AktivasyonBaslangic AND (FizikiBaz.CancelledAt IS NULL OR FizikiBaz.CancelledAt > @iptalBitis) AND FizikiBaz.serviceId <> 3;

UNION

-- FİZİKİ YENİ
SELECT @Ay, 'Yeni' as Durum, FizikiBaz.UyeIsyeriID, FizikiBaz.TerminalID, FizikiBaz.MaliNo,
       FizikiBaz.Hizmet, FizikiBaz.Sektor, FizikiBaz.Kanal,
Islemler.Taksit, Islemler.IslemAdet, Islemler.Ciro, Islemler.DolarCiro, Islemler.Gelir, Islemler.DolarGelir
FROM odeal.Terminal t
LEFT JOIN (SELECT t.id, t.organisation_id, t.serial_no, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
        WHEN bp.appliedRate > 0 AND tp.installment <= 1 THEN 'Tek Çekim'
        WHEN tp.installment > 1 THEN 'Taksitli' END as Taksit,
               COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro, " " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
GROUP BY t.id, t.organisation_id, t.serial_no, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
        WHEN bp.appliedRate > 0 AND tp.installment <= 1 THEN 'Tek Çekim'
        WHEN tp.installment > 1 THEN 'Taksitli' END) AS Islemler ON Islemler.id = t.id
JOIN (
SELECT  o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no as MaliNo, s.id as AbonelikID,
        s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal, t.firstActivationDate, p.serviceId,
        CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId) as FizikiBaz ON FizikiBaz.TerminalID = t.id
WHERE FizikiBaz.firstActivationDate>= @AktivasyonBaslangic AND FizikiBaz.firstActivationDate <= @AktivasyonBitis
AND (FizikiBaz.CancelledAt IS NULL OR FizikiBaz.CancelledAt > @iptalBitis) AND FizikiBaz.serviceId <> 3;

UNION

-- FİZİKİ YENİ İPTAL
SELECT @Ay, "Yeni İptal", o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, s2.name as Hizmet,
       s3.sector_name as Sektor, c.name as Kanal,
    CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
     WHEN bp.appliedRate > 0 AND tp.installment = 1 THEN 'Tek Çekim'
     WHEN tp.installment > 1 THEN 'Taksitli' END as Taksit, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
     WHEN bp.appliedRate > 0 AND tp.installment = 1 THEN 'Tek Çekim'
     WHEN tp.installment > 1 THEN 'Taksitli' END;

UNION

-- FİZİKİ BAZ IPTAL
SELECT @Ay, "Baz İptal", o.id as UyeIsyeriID, t.id as TerminalID,  t.serial_no, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,
       CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
     WHEN bp.appliedRate > 0 AND tp.installment = 1 THEN 'Tek Çekim'
     WHEN tp.installment > 1 THEN 'Taksitli' END as Taksit,
       COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
" " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir  FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name, CASE WHEN bp.appliedRate = 0 THEN 'Tek Çekim - 0 Komisyon'
     WHEN bp.appliedRate > 0 AND tp.installment = 1 THEN 'Tek Çekim'
     WHEN tp.installment > 1 THEN 'Taksitli' END;

UNION

-- CEPTEPOS BAZ
SELECT @Ay, "Baz", o.id, o.id as Terminal, o.id as MaliNo, Abonelik.Hizmet as Hizmet,s2.sector_name as Sektor, c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit,  COUNT(bp.id) as IslemAdet,
SUM(bp.amount) as Ciro, " " as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir FROM odeal.Organisation o
JOIN (SELECT s.organisationId, s.activationDate, p.serviceId, s2.name as Hizmet, s.cancelledAt FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id AND o.demo = 0
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE Abonelik.serviceId = 3 AND Abonelik.activationDate < @AktivasyonBaslangic AND  (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > @iptalBitis)
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");

UNION

-- CEPTEPOS YENİ
SELECT @Ay, "Yeni", o.id, o.id as Terminal,
o.id as MaliNo,
Abonelik.Hizmet as Hizmet,s2.sector_name as Sektor,
c.name as Kanal,
IF(p2.installment>1,"Taksitli","Tek Çekim") as Taksit,
COUNT(bp.id) as IslemAdet,
SUM(bp.amount) as Ciro, " " as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, " " as DolarGelir
FROM odeal.Organisation o
JOIN (SELECT s.organisationId, s.activationDate, p.serviceId, s2.name as Hizmet, s.cancelledAt FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id AND o.demo = 0
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.paymentType IN (0,1,2,3,6,7,8)
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE Abonelik.serviceId = 3 AND Abonelik.activationDate >= @AktivasyonBaslangic AND Abonelik.activationDate <= @AktivasyonBitis AND  (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > @iptalBitis)
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");

UNION

-- CEPTEPOS IPTALLER
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
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.paymentType IN (0,1,2,3,6,7,8)
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
bp.amount > 1 AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, IF(p2.installment>1,"Taksitli","Tek Çekim");







SELECT s.organisationId, p.serviceId, s2.name as Hizmet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)

SELECT t.serial_no, tp.installment, bp.appliedRate, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.Terminal t
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE t.serial_no = "PAX710061118"
  AND bp.currentStatus = 6 AND bp.signedDate >= "2024-08-01 00:00:00" AND bp.signedDate <= "2024-08-31 23:59:59"
GROUP BY t.serial_no, tp.installment, bp.appliedRate