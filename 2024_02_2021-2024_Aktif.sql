SELECT "2024-02" as Ay, "2021-01 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-02 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-03 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-04 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-05 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-06 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-07 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-08 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-09 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-10 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-11 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2021-12 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-01 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-02 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-03 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-04 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-05 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-06 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-07 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-08 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-09 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-10 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-11 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2022-12 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-01 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-02 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-03 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-04 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-05 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-06 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-07 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-08 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-09 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-10 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-11 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2023-12 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2024-01 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay, "2024-01 AKTİFLER", "Yeni" as Durum, COUNT(Aktivasyon.TerminalID) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no MaliNo, s2.name as Hizmet, s3.sector_name as Sektor, c.name as Kanal,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, SUM(bp.amount/7.39) as DolarCiro, SUM((bp.amount*bp.appliedRate)/100) as Gelir, SUM((bp.amount*bp.appliedRate)/100/7.39) as DolarGelir FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no, s2.name, s3.sector_name) as Aktivasyon
GROUP BY "2024-02"
