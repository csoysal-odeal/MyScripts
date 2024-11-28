SELECT @abas:= "2023-05-01 00:00:00", @abit:= "2023-05-31 23:59:59";

SELECT "2021-01" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-02" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-03" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-04" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-05" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-06" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-07" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-08" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-09" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-10" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-11" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021-12" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-01" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-02" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-03" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-04" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-05" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-06" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-07" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-08" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-09" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-10" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-11" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2022-12" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-01" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-02" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-03" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-04" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-05" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-06" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-07" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-08" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-09" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-10" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-11" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2023-12" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-01" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-02" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-03" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-04" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-05" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-06" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2024-07" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon

SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE t.firstActivationDate <= "2020-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE t.firstActivationDate <= "2020-12-31 23:59:59"  AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi"  as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2021-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-01-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-04-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-05-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-06-30 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE t.firstActivationDate BETWEEN @abas AND @abit AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon

SELECT "2020-12" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate BETWEEN "2020-12-01 00:00:00" AND "2020-12-31 23:59:59"
WHERE t.firstActivationDate >= "2020-12-01 00:00:00" AND t.firstActivationDate <= "2020-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2020-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon

SELECT "2020-11" as Ay, COUNT(Aktivasyon.TerminalID) as AktivasyonAdet, SUM(Aktivasyon.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3  AND bp.signedDate >= "2020-11-01 00:00:00" AND bp.signedDate <= "2020-11-31 23:59:59"
WHERE t.firstActivationDate >= "2020-12-01 00:00:00" AND t.firstActivationDate <= "2020-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2020-12-31 23:59:59")
GROUP BY o.id, t.id, t.serial_no) as Aktivasyon


SELECT @abas:= "2023-04-01 00:00:00", @abit:= "2023-04-30 23:59:59";

-- CEPTEPOS ABONELİKLERİ
SELECT "2021-01" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-02" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-03" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-04" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-05" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-06" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-07" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-08" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-09" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-10" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-11" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021-12" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-01" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-02" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-03" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-04" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-05" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-06" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-07" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-08" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-09" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-10" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-11" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2022-12" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-01" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-02" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-03" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-04" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-05" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-06" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-07" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-08" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-09" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-10" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-11" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2023-12" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-01" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-02" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-03" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-04" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-05" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-06" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2024-07" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon

-- CEPTEPOS 2021 ÖNCESİ
SELECT @abas:= "2010-01-01 00:00:00", @abit:= "2020-12-31 23:59:59";

SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2021-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2022-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2023-12-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-01-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-02-29 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-03-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-04-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-05-31 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-06-30 23:59:59")
GROUP BY o.id) as Aktivasyon
UNION
SELECT "2021 Öncesi" as Ay, COUNT(Aktivasyon.id) as Adet, SUM(Aktivasyon.Ciro) as Ciro FROM (
SELECT o.id, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY s.organisationId)) as Abonelik ON Abonelik.organisationId = o.id
JOIN subscription.Plan p ON p.id = Abonelik.planId AND p.serviceId = 3
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
AND bp.currentStatus = 6 AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE Abonelik.activationDate BETWEEN @abas AND @abit
AND (Abonelik.cancelledAt IS NULL OR Abonelik.cancelledAt > "2024-07-31 23:59:59")
GROUP BY o.id) as Aktivasyon

-- İPTALLER
SELECT @abas:="2023-04-01 00:00:00", @abit:="2023-04-30 23:59:59";


SELECT "2021-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE t.firstActivationDate >=@abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-02-01 00:00:00" AND s.cancelledAt <= "2021-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-03-01 00:00:00" AND s.cancelledAt <= "2021-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE t.firstActivationDate >=@abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-04-01 00:00:00" AND s.cancelledAt <= "2021-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-05-01 00:00:00" AND s.cancelledAt <= "2021-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-06-01 00:00:00" AND s.cancelledAt <= "2021-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-07-01 00:00:00" AND s.cancelledAt <= "2021-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-08-01 00:00:00" AND s.cancelledAt <= "2021-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-09-01 00:00:00" AND s.cancelledAt <= "2021-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-10-01 00:00:00" AND s.cancelledAt <= "2021-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-11-01 00:00:00" AND s.cancelledAt <= "2021-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-12-01 00:00:00" AND s.cancelledAt <= "2021-12-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-01-01 00:00:00" AND s.cancelledAt <= "2022-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-02-01 00:00:00" AND s.cancelledAt <= "2022-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-03-01 00:00:00" AND s.cancelledAt <= "2022-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-04-01 00:00:00" AND s.cancelledAt <= "2022-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-05-01 00:00:00" AND s.cancelledAt <= "2022-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-06-01 00:00:00" AND s.cancelledAt <= "2022-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-07-01 00:00:00" AND s.cancelledAt <= "2022-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-08-01 00:00:00" AND s.cancelledAt <= "2022-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-09-01 00:00:00" AND s.cancelledAt <= "2022-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-10-01 00:00:00" AND s.cancelledAt <= "2022-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2022-11-01 00:00:00" AND s.cancelledAt <= "2022-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-12-01 00:00:00" AND s.cancelledAt <= "2022-12-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-01-01 00:00:00" AND s.cancelledAt <= "2023-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-02-01 00:00:00" AND s.cancelledAt <= "2023-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-03-01 00:00:00" AND s.cancelledAt <= "2023-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-04-01 00:00:00" AND s.cancelledAt <= "2023-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-05-01 00:00:00" AND s.cancelledAt <= "2023-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-06-01 00:00:00" AND s.cancelledAt <= "2023-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-07-01 00:00:00" AND s.cancelledAt <= "2023-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-08-01 00:00:00" AND s.cancelledAt <= "2023-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-09-01 00:00:00" AND s.cancelledAt <= "2023-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-10-01 00:00:00" AND s.cancelledAt <= "2023-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-04-01 00:00:00" AND s.cancelledAt <= "2024-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-05-01 00:00:00" AND s.cancelledAt <= "2024-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-06-01 00:00:00" AND s.cancelledAt <= "2024-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-07-01 00:00:00" AND s.cancelledAt <= "2024-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal

-- İPTALLER
SELECT @abas:="2014-01-01 00:00:00", @abit:="2020-12-31 23:59:59";


SELECT "2021 Öncesi" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-01-01 00:00:00" AND "2021-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-01-01 00:00:00" AND s.cancelledAt <= "2021-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-02-01 00:00:00" AND "2021-02-28 23:59:59"
WHERE t.firstActivationDate >=@abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-02-01 00:00:00" AND s.cancelledAt <= "2021-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-03-01 00:00:00" AND "2021-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-03-01 00:00:00" AND s.cancelledAt <= "2021-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-04-01 00:00:00" AND "2021-04-30 23:59:59"
WHERE t.firstActivationDate >=@abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-04-01 00:00:00" AND s.cancelledAt <= "2021-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-05-01 00:00:00" AND "2021-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-05-01 00:00:00" AND s.cancelledAt <= "2021-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-06-01 00:00:00" AND "2021-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-06-01 00:00:00" AND s.cancelledAt <= "2021-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-07-01 00:00:00" AND "2021-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-07-01 00:00:00" AND s.cancelledAt <= "2021-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-08-01 00:00:00" AND "2021-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-08-01 00:00:00" AND s.cancelledAt <= "2021-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-09-01 00:00:00" AND "2021-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-09-01 00:00:00" AND s.cancelledAt <= "2021-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-10-01 00:00:00" AND "2021-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-10-01 00:00:00" AND s.cancelledAt <= "2021-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-11-01 00:00:00" AND "2021-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2021-11-01 00:00:00" AND s.cancelledAt <= "2021-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2021-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2021-12-01 00:00:00" AND "2021-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2021-12-01 00:00:00" AND s.cancelledAt <= "2021-12-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-01-01 00:00:00" AND "2022-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-01-01 00:00:00" AND s.cancelledAt <= "2022-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-02-01 00:00:00" AND "2022-02-28 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-02-01 00:00:00" AND s.cancelledAt <= "2022-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-03-01 00:00:00" AND "2022-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-03-01 00:00:00" AND s.cancelledAt <= "2022-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-04-01 00:00:00" AND "2022-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-04-01 00:00:00" AND s.cancelledAt <= "2022-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-05-01 00:00:00" AND "2022-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-05-01 00:00:00" AND s.cancelledAt <= "2022-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-06-01 00:00:00" AND "2022-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-06-01 00:00:00" AND s.cancelledAt <= "2022-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-07-01 00:00:00" AND "2022-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-07-01 00:00:00" AND s.cancelledAt <= "2022-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-08-01 00:00:00" AND "2022-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-08-01 00:00:00" AND s.cancelledAt <= "2022-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-09-01 00:00:00" AND "2022-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-09-01 00:00:00" AND s.cancelledAt <= "2022-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-10-01 00:00:00" AND "2022-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-10-01 00:00:00" AND s.cancelledAt <= "2022-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <=@abit AND s.cancelledAt >= "2022-11-01 00:00:00" AND s.cancelledAt <= "2022-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2022-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2022-12-01 00:00:00" AND "2022-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2022-12-01 00:00:00" AND s.cancelledAt <= "2022-12-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-01-01 00:00:00" AND "2023-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-01-01 00:00:00" AND s.cancelledAt <= "2023-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-02-01 00:00:00" AND "2023-02-28 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-02-01 00:00:00" AND s.cancelledAt <= "2023-02-28 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-03-01 00:00:00" AND "2023-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-03-01 00:00:00" AND s.cancelledAt <= "2023-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-04-01 00:00:00" AND "2023-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-04-01 00:00:00" AND s.cancelledAt <= "2023-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-05-01 00:00:00" AND "2023-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-05-01 00:00:00" AND s.cancelledAt <= "2023-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-06-01 00:00:00" AND "2023-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-06-01 00:00:00" AND s.cancelledAt <= "2023-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-07-01 00:00:00" AND "2023-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-07-01 00:00:00" AND s.cancelledAt <= "2023-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-08" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-08-01 00:00:00" AND "2023-08-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-08-01 00:00:00" AND s.cancelledAt <= "2023-08-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-09" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-09-01 00:00:00" AND "2023-09-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-09-01 00:00:00" AND s.cancelledAt <= "2023-09-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-10" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-10-01 00:00:00" AND "2023-10-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-10-01 00:00:00" AND s.cancelledAt <= "2023-10-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-11" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-11-01 00:00:00" AND "2023-11-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-11-01 00:00:00" AND s.cancelledAt <= "2023-11-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2023-12" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2023-12-01 00:00:00" AND "2023-12-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2023-12-01 00:00:00" AND s.cancelledAt <= "2023-12-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-01" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-01-01 00:00:00" AND "2024-01-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-01-01 00:00:00" AND s.cancelledAt <= "2024-01-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-02" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-02-01 00:00:00" AND "2024-02-29 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-02-01 00:00:00" AND s.cancelledAt <= "2024-02-29 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-03" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-03-01 00:00:00" AND "2024-03-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-03-01 00:00:00" AND s.cancelledAt <= "2024-03-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-04" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-04-01 00:00:00" AND "2024-04-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-04-01 00:00:00" AND s.cancelledAt <= "2024-04-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-05" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-05-01 00:00:00" AND "2024-05-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-05-01 00:00:00" AND s.cancelledAt <= "2024-05-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-06" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-06-01 00:00:00" AND "2024-06-30 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-06-01 00:00:00" AND s.cancelledAt <= "2024-06-30 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal
UNION
SELECT "2024-07" as Ay, COUNT(Iptal.TerminalID) as IptalAdet, SUM(Iptal.Ciro) as Ciro FROM (SELECT o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate BETWEEN "2024-07-01 00:00:00" AND "2024-07-31 23:59:59"
WHERE t.firstActivationDate >= @abas AND t.firstActivationDate <= @abit AND s.cancelledAt >= "2024-07-01 00:00:00" AND s.cancelledAt <= "2024-07-31 23:59:59"
GROUP BY o.id, t.id, t.serial_no) as Iptal



SELECT * FROM payout_source.source s WHERE s.merchant_id = 301160192

SELECT * FROM odeal.Terminal t WHERE t.serial_no = "PAX710062844"


