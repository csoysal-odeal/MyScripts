SELECT @Ay:="2024-08", @AktivasyonBaslangic:="2024-08-01 00:00:00" ,
       @AktivasyonBitis:="2024-08-31 23:59:59",
       @iptalBaslangic:="2024-08-01 00:00:00",
       @iptalBitis:="2024-08-31 23:59:59",
       @islemBaslangic:="2024-08-01 00:00:00",
       @islemBitis:="2024-08-31 23:59:59";

-- TAM QUERY (CEPTEPOS+FİZİKİ CİRO BAĞIMSIZ)
SELECT FizikYeni.Ay, FizikYeni.Durum, FizikYeni.Hizmet, COUNT(FizikYeni.id) as Adet FROM (
SELECT @Ay as Ay, "Yeni" as Durum, t.id, t.firstActivationDate, p.serviceId, s2.name as Hizmet,
       CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId) as FizikYeni
WHERE FizikYeni.firstActivationDate >= @AktivasyonBaslangic AND FizikYeni.firstActivationDate <= @AktivasyonBitis
AND (FizikYeni.CancelledAt IS NULL OR FizikYeni.CancelledAt > @iptalBitis) AND FizikYeni.serviceId <> 3
GROUP BY @Ay, FizikYeni.Hizmet
UNION
SELECT FizikiBaz.Ay, FizikiBaz.Durum, FizikiBaz.Hizmet, COUNT(FizikiBaz.id) as Adet FROM (
SELECT @Ay as Ay, "Baz" as Durum, t.id, t.firstActivationDate, p.serviceId, s2.name as Hizmet,
       CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId) as FizikiBaz
WHERE FizikiBaz.firstActivationDate < @AktivasyonBaslangic AND (FizikiBaz.CancelledAt IS NULL OR FizikiBaz.CancelledAt > @iptalBitis) AND FizikiBaz.serviceId <> 3
GROUP BY @Ay, FizikiBaz.Hizmet
UNION
SELECT FizikiYeniIptal.Ay, FizikiYeniIptal.Durum, FizikiYeniIptal.Hizmet, COUNT(FizikiYeniIptal.id) as IptalAdet FROM (
SELECT @Ay as Ay, "Yeni İptal" as Durum, t.id, t.firstActivationDate, p.serviceId, s2.name as Hizmet,
       CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId) as FizikiYeniIptal
WHERE FizikiYeniIptal.firstActivationDate >= @AktivasyonBaslangic AND FizikiYeniIptal.firstActivationDate <= @AktivasyonBitis
  AND FizikiYeniIptal.CancelledAt >= @iptalBaslangic AND FizikiYeniIptal.CancelledAt <= @iptalBitis AND FizikiYeniIptal.serviceId <> 3
GROUP BY @Ay, FizikiYeniIptal.Hizmet
UNION
SELECT FizikiBazIptal.Ay, FizikiBazIptal.Durum, FizikiBazIptal.Hizmet, COUNT(FizikiBazIptal.id) as IptalAdet FROM (
SELECT @Ay as Ay, "Baz İptal" as Durum, t.id, t.firstActivationDate, p.serviceId, s2.name as Hizmet,
       CASE WHEN s.status = 1 AND t.terminalStatus = 1 THEN null
             WHEN s.cancelledAt IS NOT NULL THEN s.cancelledAt END as CancelledAt FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId <> 3
JOIN subscription.Service s2 ON s2.id = p.serviceId) as FizikiBazIptal
WHERE FizikiBazIptal.firstActivationDate < @AktivasyonBaslangic AND FizikiBazIptal.CancelledAt >= @iptalBaslangic AND FizikiBazIptal.CancelledAt <= @iptalBitis
GROUP BY @Ay, FizikiBazIptal.Hizmet
UNION
SELECT @Ay as Ay, "Baz" as Durum, s3.name as Hizmet, COUNT(*) as Adet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY @Ay, s3.name
UNION
SELECT @Ay as Ay, "Yeni" as Durum, s3.name as Hizmet, COUNT(*) as Adet  FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND  (s.cancelledAt IS NULL OR s.cancelledAt > @iptalBitis)
GROUP BY @Ay, s3.name
UNION
SELECT @Ay as Ay, "Baz İptal" as Durum, s3.name as Hizmet, COUNT(*) as Adet FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE p.serviceId = 3 AND s.activationDate < @AktivasyonBaslangic AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY @Ay, s3.name
UNION
SELECT @Ay as Ay, "Yeni İptal" as Durum, s3.name as Hizmet,  COUNT(*) as Adet  FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE p.serviceId = 3 AND s.activationDate >= @AktivasyonBaslangic AND s.activationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY @Ay, s3.name


