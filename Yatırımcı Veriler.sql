SELECT * FROM odeal.Channel c 

-- Eskiler KASIM AYI - Yeniler Dahil - Aynı Ay iptaller Hariç
SELECT o.id FROM odeal.Organisation o 
WHERE o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-11-30 23:59:59")
-- 62621


-- Eskiler KASIM AYI - Yeniler Dahil - Aynı Ay iptaller Dahil
SELECT o.id FROM odeal.Organisation o 
WHERE o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")
-- 64202

-- Eskiler KASIM AYI - Yeniler Hariç - Aynı Ay iptaller Hariç
SELECT o.id FROM odeal.Organisation o 
WHERE o.demo = 0 AND o.activatedAt <= "2023-10-31 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-11-30 23:59:59")
-- 60639

-- Eskiler KASIM AYI - Yeniler Hariç - Aynı Ay iptaller Dahil
SELECT o.id FROM odeal.Organisation o 
WHERE o.demo = 0 AND o.activatedAt <= "2023-10-31 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")
-- 62131

-- Yeniler KASIM AYI - Eskiler Hariç - Aynı Ay İptaller Hariç
SELECT o.id FROM odeal.Organisation o 
WHERE o.demo = 0 AND o.activatedAt >= "2023-11-01 00:00:00" AND o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-11-30 23:59:59")
-- 1982

-- Yeniler KASIM AYI - Eskiler Hariç - Aynı Ay İptaller Dahil
SELECT o.id FROM odeal.Organisation o 
WHERE o.demo = 0 AND o.activatedAt >= "2023-11-01 00:00:00" AND o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")
-- 2071



SELECT 62131 + 2071 = 64202

SELECT 60639 + 1982 = 62621


-- Yeni Fiziki
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt >= "2021-01-01 00:00:00")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01"

-- Baz Fiziki
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet

-- Ay İçi Yeni İptal
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet

-- Ay İçi Baz İptal
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet

-- CeptePos Baz
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet

-- CeptePos Yeni
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet

-- CeptePos Baz İptal
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet

-- CeptePos Yeni İptal
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet


-- TAM QUERY (CEPTEPOS+FİZİKİ CİRO BAĞIMSIZ)
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet

-- TAM QUERY (CEPTEPOS+FİZİKİ CİROLU)
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.Hizmet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, Iptal.Hizmet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2021-01", Iptal.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Baz İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet
UNION
SELECT "2021-01" as Ay, "Yeni İptal" as Durum, COUNT(*) as Adet, CeptePos.Hizmet, SUM(CeptePos.Ciro) as Ciro FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id) as CeptePos
GROUP BY "2021-01", CeptePos.Hizmet


-- Fiziki Terminal Pivot
SELECT Ciro.Ay, Ciro.Durum, Ciro.Hizmet, Ciro.Sektor, Ciro.Kanal, SUM(Ciro.Adet) as TerminalAdet, SUM(Ciro.IslemAdet) as IslemAdet, SUM(Ciro.Ciro) as Ciro, SUM(Ciro.DolarCiro) as DolarCiro, SUM(Ciro.Gelir) as Gelir, SUM(Ciro.DolarGelir) as Gelir FROM (
SELECT "2021-01" as Ay, "Yeni" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet, Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo,Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION 
SELECT "2021-01" as Ay, "Baz" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet,Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo, Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
) as Ciro
GROUP BY Ciro.Ay, Ciro.Durum, Ciro.Hizmet, Ciro.Sektor, Ciro.Kanal

-- Fiziki Terminal Total
SELECT "2021-01" as Ay, "Yeni" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet, Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo,Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION 
SELECT "2021-01" as Ay, "Baz" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet,Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo, Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet, Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo,Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION 
SELECT "2021-01" as Ay, "Baz" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet,Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo, Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir


-- Fiziki Terminal İşlem Geçen
SELECT "2021-01" as Ay, "Yeni" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet, Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo,Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION 
SELECT "2021-01" as Ay, "Baz" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet,Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo, Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet, Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo,Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir
UNION 
SELECT "2021-01" as Ay, "Baz" as Durum, Aktivasyon.MaliNo, Aktivasyon.Hizmet,Aktivasyon.Sektor, Aktivasyon.Kanal, COUNT(Aktivasyon.TerminalID) as Adet, Aktivasyon.IslemAdet, Aktivasyon.Ciro as Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir as Gelir, Aktivasyon.DolarGelir FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, COUNT(bp.id) as IslemAdet,SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate <= "2021-01-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name) as Aktivasyon
GROUP BY "2021-01", Aktivasyon.Hizmet, Aktivasyon.Kanal, Aktivasyon.Sektor, Aktivasyon.MaliNo, Aktivasyon.IslemAdet, Aktivasyon.Ciro, Aktivasyon.DolarCiro, Aktivasyon.Gelir, Aktivasyon.DolarGelir


-- CeptePos Total
SELECT "2021-01" as Ay, "Baz" as Durum, CeptePos.id, CeptePos.Hizmet, CeptePos.Sektor, CeptePos.Kanal, CeptePos.Ciro, CeptePos.DolarCiro, CeptePos.Gelir, COUNT(*) as Adet  FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY CeptePos.id, CeptePos.Kanal, CeptePos.Ciro, CeptePos.Gelir
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, CeptePos.id, CeptePos.Hizmet, CeptePos.Sektor, CeptePos.Kanal, CeptePos.Ciro, CeptePos.DolarCiro, CeptePos.Gelir, COUNT(*) as Adet  FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY CeptePos.id, CeptePos.Kanal, CeptePos.Ciro, CeptePos.Gelir

-- CeptePos İşlem Geçen
SELECT "2021-01" as Ay, "Baz" as Durum, CeptePos.id, CeptePos.Hizmet, CeptePos.Sektor, CeptePos.Kanal, CeptePos.Ciro, CeptePos.DolarCiro, CeptePos.Gelir, COUNT(*) as Adet  FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate < "2021-01-01 00:00:00" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY CeptePos.id, CeptePos.Kanal, CeptePos.Ciro, CeptePos.Gelir
UNION
SELECT "2021-01" as Ay, "Yeni" as Durum, CeptePos.id, CeptePos.Hizmet, CeptePos.Sektor, CeptePos.Kanal, CeptePos.Ciro, CeptePos.DolarCiro, CeptePos.Gelir, COUNT(*) as Adet  FROM 
(SELECT o.id, s3.name as Hizmet, c.name as Kanal, s2.sector_name as Sektor, COUNT(o.id) as CeptePosAdet, SUM(bp.amount) as Ciro,SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND o.demo = 0
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE p.serviceId = 3 AND s.activationDate >= "2021-01-01 00:00:00" AND s.activationDate <= "2021-01-31 23:59:59" AND  (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as CeptePos
GROUP BY CeptePos.id, CeptePos.Kanal, CeptePos.Ciro, CeptePos.Gelir

SELECT * FROM subscription.Plan




-- Eskiler KASIM AYI - Yeniler Hariç - Aynı Ay iptaller Dahil
SELECT DATE_FORMAT(bp.signedDate,"%Y-%m")as Ay, o.id, s.sector_name as Sektor, c.name as Kanal, CAST(SUM(bp.amount) as DECIMAL(15,2)) as Ciro, CAST(SUM((bp.amount*bp.appliedRate)/100)as DECIMAL(15,2)) as Gelir, COUNT(bp.id) as IslemAdet FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.organisationId IS NOT NULL AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
LEFT JOIN odeal.Sector s ON s.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE o.demo = 0 AND o.activatedAt <= "2023-10-31 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), o.id
-- 62131

-- Yeniler KASIM AYI - Eskiler Hariç - Aynı Ay İptaller Dahil
SELECT DATE_FORMAT(bp.signedDate,"%Y-%m")as Ay, o.id, s.sector_name as Sektor, c.name as Kanal, CAST(SUM(bp.amount) as DECIMAL(15,2)) as Ciro, CAST(SUM((bp.amount*bp.appliedRate)/100)as DECIMAL(15,2)) as Gelir, COUNT(bp.id) as IslemAdet FROM odeal.Organisation o
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.organisationId IS NOT NULL AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59" AND bp.amount > 1 AND bp.paymentType <> 4
LEFT JOIN odeal.Sector s ON s.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE o.demo = 0 AND o.activatedAt >= "2023-11-01 00:00:00" AND o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), o.id
-- 2071

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m")as Ay, o.id, s.sector_name as Sektor, c.name as Kanal, bp.amount as Ciro, bp.appliedRate as Komisyon, ((bp.amount*bp.appliedRate)/100) as Gelir, bp.id as IslemID FROM odeal.Organisation o
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.organisationId IS NOT NULL AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59" AND bp.amount > 1 AND bp.paymentType <> 4
LEFT JOIN odeal.Sector s ON s.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE o.demo = 0 AND o.activatedAt >= "2023-11-01 00:00:00" AND o.activatedAt <= "2023-11-30 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m")as Ay, o.id, s.sector_name as Sektor, c.name as Kanal, bp.amount as Ciro, bp.appliedRate as Komisyon, ((bp.amount*bp.appliedRate)/100) as Gelir, bp.id as IslemID FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.organisationId IS NOT NULL AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
LEFT JOIN odeal.Sector s ON s.id = o.sectorId
LEFT JOIN odeal.Channel c ON c.id = o.channelId
WHERE o.demo = 0 AND o.activatedAt <= "2023-10-31 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-10-31 23:59:59")

-- Eskiler KASIM AYI - Yeniler Hariç - Aynı Ay iptaller Hariç
SELECT t.serial_no FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
WHERE o.demo = 0 AND o.activatedAt <= "2023-10-31 23:59:59" AND (o.deActivatedAt  IS NULL OR o.deActivatedAt  > "2023-11-30 23:59:59")
-- 60639

SELECT o.id FROM odeal.Organisation o 
JOIN subscription.Subscription s on s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE s2.id = 3
GROUP BY o.id HAVING COUNT(*) > 1

SELECT * FROM odeal.Organisation o 

SELECT o.id, SUM(bp.amount) FROM odeal.Organisation o 
JOIN subscription.Subscription s on s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59"
WHERE s2.id = 3 AND o.id = 301001402
GROUP BY o.id

SELECT * FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.amount > 1 AND bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-01 23:59:59"