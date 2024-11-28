SELECT @Ay:="2023-12"

SELECT @AktivasyonBaslangic:="2023-12-01 00:00:00"

SELECT @AktivasyonBitis:="2023-12-31 23:59:59"

SELECT @iptalBaslangic:="2023-12-01 00:00:00"

SELECT @iptalBitis:="2023-12-31 23:59:59"

SELECT @islemBaslangic:="2023-12-01 00:00:00"

SELECT @islemBitis:="2023-12-31 23:59:59"

-- TAM QUERY (CEPTEPOS+FİZİKİ CİRO BAĞIMSIZ)
SELECT @Ay as Ay, "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis 
AND (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis) AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY @Ay, Aktivasyon.Hizmet

UNION

SELECT @Ay as Ay, "Baz" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, 
COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro,
SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < @AktivasyonBaslangic AND (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis) AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY @Ay, Aktivasyon.Hizmet

UNION

SELECT @Ay as Ay, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis AND p.serviceId <> 3
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay, Iptal.Hizmet

UNION

SELECT @Ay as Ay, "Baz İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay, Iptal.Hizmet

UNION

SELECT @Ay as Ay, "Baz" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, 
SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY o.id) as CeptePos
GROUP BY @Ay, CeptePos.Hizmet

UNION

SELECT @Ay as Ay, "Yeni" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, 
SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY o.id) as CeptePos
GROUP BY @Ay, CeptePos.Hizmet

UNION

SELECT @Ay as Ay, "Baz İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, 
SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id) as CeptePos
GROUP BY @Ay, CeptePos.Hizmet
UNION
SELECT @Ay as Ay, "Yeni İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, 
SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND
bp.amount > 1 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id) as CeptePos
GROUP BY @Ay, CeptePos.Hizmet
