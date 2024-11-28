SELECT @Ay:= "2024-03"

SELECT @islemBaslangic:= "2024-03-01 00:00:00"

SELECT @islemBitis:= "2024-03-31 23:59:59"

SELECT @Ay as Ay,"2021-ÖNCESİ", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate <= "2020-12-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay


SELECT @Ay as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, @Ay, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= @islemBaslangic AND s.cancelledAt <= @islemBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay



SELECT "2023-11" as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION
SELECT "2023-11" as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION
SELECT "2023-11" as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"


UNION 
SELECT "2023-11" as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION
SELECT "2023-11" as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"
UNION 
SELECT "2023-11" as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-11"

-- ARALIK 2023 İPTAL
SELECT "2023-12" as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION
SELECT "2023-12" as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION
SELECT "2023-12" as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"

UNION
SELECT "2023-12" as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"
UNION 
SELECT "2023-12" as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2023-12"


-- OCAK 2024 İPTAL
SELECT "2024-01" as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION
SELECT "2024-01" as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION
SELECT "2024-01" as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION
SELECT "2024-01" as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"

UNION 
SELECT "2024-01" as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"
UNION 
SELECT "2024-01" as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-01"

-- ŞUBAT 2024 İPTAL
SELECT "2024-02" as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION
SELECT "2024-02" as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"
UNION 
SELECT "2024-02" as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"

UNION 
SELECT "2024-02" as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-02"




-- MART 2024 İPTAL
SELECT "2024-03" as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION
SELECT "2024-03" as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION
SELECT "2024-03" as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION
SELECT "2024-03" as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"
UNION 
SELECT "2024-03" as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY "2024-03"




-- MART 2024 İPTAL ŞUBAT 2024 Ciro

SELECT @Ay:= "2021-01"

SELECT @iptalBaslangic:= "2021-01-01 00:00:00"

SELECT @iptalBitis:= "2021-01-31 23:59:59"

SELECT @islemBaslangic:= "2020-12-01 00:00:00"

SELECT @islemBitis:= "2020-12-31 23:59:59"



SELECT @Ay as Ay,"2021-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-01-01 00:00:00" AND t.firstActivationDate <= "2021-01-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-02-01 00:00:00" AND t.firstActivationDate <= "2021-02-28 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-03-01 00:00:00" AND t.firstActivationDate <= "2021-03-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-04-01 00:00:00" AND t.firstActivationDate <= "2021-04-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-05-01 00:00:00" AND t.firstActivationDate <= "2021-05-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-06-01 00:00:00" AND t.firstActivationDate <= "2021-06-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-07-01 00:00:00" AND t.firstActivationDate <= "2021-07-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-08-01 00:00:00" AND t.firstActivationDate <= "2021-08-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-09-01 00:00:00" AND t.firstActivationDate <= "2021-09-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-10-01 00:00:00" AND t.firstActivationDate <= "2021-10-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-11-01 00:00:00" AND t.firstActivationDate <= "2021-11-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2021-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2021-12-01 00:00:00" AND t.firstActivationDate <= "2021-12-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2022-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-01-01 00:00:00" AND t.firstActivationDate <= "2022-01-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-02-01 00:00:00" AND t.firstActivationDate <= "2022-02-28 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-03-01 00:00:00" AND t.firstActivationDate <= "2022-03-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-04-01 00:00:00" AND t.firstActivationDate <= "2022-04-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-05-01 00:00:00" AND t.firstActivationDate <= "2022-05-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-06-01 00:00:00" AND t.firstActivationDate <= "2022-06-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-07-01 00:00:00" AND t.firstActivationDate <= "2022-07-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-08-01 00:00:00" AND t.firstActivationDate <= "2022-08-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-09-01 00:00:00" AND t.firstActivationDate <= "2022-09-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-10-01 00:00:00" AND t.firstActivationDate <= "2022-10-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-11-01 00:00:00" AND t.firstActivationDate <= "2022-11-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2022-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2022-12-01 00:00:00" AND t.firstActivationDate <= "2022-12-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2023-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-01-01 00:00:00" AND t.firstActivationDate <= "2023-01-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-02-01 00:00:00" AND t.firstActivationDate <= "2023-02-28 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-03-01 00:00:00" AND t.firstActivationDate <= "2023-03-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-04", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-04-01 00:00:00" AND t.firstActivationDate <= "2023-04-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-05", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-05-01 00:00:00" AND t.firstActivationDate <= "2023-05-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-06", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-06-01 00:00:00" AND t.firstActivationDate <= "2023-06-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-07", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-07-01 00:00:00" AND t.firstActivationDate <= "2023-07-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-08", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-08-01 00:00:00" AND t.firstActivationDate <= "2023-08-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-09", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-09-01 00:00:00" AND t.firstActivationDate <= "2023-09-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-10", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-10-01 00:00:00" AND t.firstActivationDate <= "2023-10-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-11", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-11-01 00:00:00" AND t.firstActivationDate <= "2023-11-30 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2023-12", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2023-12-01 00:00:00" AND t.firstActivationDate <= "2023-12-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION
SELECT @Ay as Ay,"2024-01", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-01-01 00:00:00" AND t.firstActivationDate <= "2024-01-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2024-02", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-02-01 00:00:00" AND t.firstActivationDate <= "2024-02-29 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay
UNION 
SELECT @Ay as Ay, "2024-03", "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= "2024-03-01 00:00:00" AND t.firstActivationDate <= "2024-03-31 23:59:59" AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay


SELECT @Ay:= "2024-03"

SELECT @AktivasyonAy:= "2021-09"

SELECT @AktivasyonBaslangic:= "2021-09-01 00:00:00"

SELECT @AktivasyonBitis:= "2021-09-30 23:59:59"

SELECT @iptalBaslangic:= "2024-03-01 00:00:00"

SELECT @iptalBitis:= "2024-03-31 23:59:59"

SELECT @islemBaslangic:= "2024-03-01 00:00:00"

SELECT @islemBitis:= "2024-03-31 23:59:59"

SELECT @Ay as Ay, @AktivasyonAy, "Yeni İptal" as Durum, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM 
(SELECT o.id as UyeIsyeriID, t.id as TerminalID, s2.name as Hizmet, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= @islemBaslangic AND bp.signedDate <= @islemBitis
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate >= @AktivasyonBaslangic AND t.firstActivationDate <= @AktivasyonBitis AND s.cancelledAt >= @iptalBaslangic AND s.cancelledAt <= @iptalBitis
GROUP BY o.id, t.id, t.serial_no, s2.name) as Iptal
GROUP BY @Ay



