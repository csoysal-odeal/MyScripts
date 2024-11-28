SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, o.marka, SUM(bp.amount) as Ciro FROM odeal.Organisation o
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE o.demo = 0 AND o.id = 301023021 AND bp.signedDate >= "2023-01-01 00:00:00" AND bp.currentStatus = 6
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m") 

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, o.marka, COUNT(bp.id) as IslemAdet, bp.amount FROM odeal.Organisation o
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
WHERE o.demo = 0 AND o.id = 301023021 AND bp.signedDate >= "2023-07-01 00:00:00" AND bp.signedDate <= "2023-07-31 23:59:59" AND bp.currentStatus = 6
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), bp.amount ORDER BY COUNT(bp.id) DESC


SELECT 298 * 5249 1564202

SELECT 70 * 3299 230930

SELECT 22 * 5299 116578

SELECT 1564202 + 230930 + 116578

-- Organizasyon Dağılımı 2023
SELECT o.id as UyeIsyeriID, o.marka as Marka, IF(o.isActivated=1,"AKTİF","PASİF") as UyeIsyeriDurum, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.tckNo as TckNo, m.birthDate as DogumTarih, m.phone as Telefon,
c.name as UyeIsyeriKanal, 
c2.name as Sehir, t2.name as Ilce, 
CASE WHEN o.businessType=0 THEN "BİREYSEL" 
WHEN o.businessType=1 THEN "ŞAHIS" 
WHEN o.businessType=2 THEN "TÜZEL" 
WHEN o.businessType=3 THEN "DERNEK,APT.YÖN." 
END as IsyeriTipi, 
s3.sector_name as Sektor, GROUP_CONCAT(s2.name,",") as Hizmet, GROUP_CONCAT(t.serial_no,",") as Terminal, 
IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum, o.activatedAt as OrgAktivasyon FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.City c2 ON c2.id = o.cityId 
LEFT JOIN odeal.Town t2 ON t2.id = o.townId
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId
JOIN odeal.Channel c ON c.id = o.channelId
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.demo = 0
GROUP BY o.id, CONCAT(m.firstName," ",m.LastName), m.tckNo, m.birthDate, m.phone, IF(t.terminalStatus=0,"Pasif","Aktif")


SELECT o.id, o.marka, o.unvan, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum, t.supplier, t.serial_no, IF(p.taksitli=0,"Tek Çekim","Taksitli") as TaksitDurum FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 


SELECT "2023-11" as Ay, o.id as UyeIsyeriID, t.id as TerminalID, t.serial_no as MaliNo, s2.name as Hizmet,s3.sector_name as Sektor, c.name as Kanal, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.Sector s3 ON s3.id = o.sectorId 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId = 5 AND bp.amount > 1 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.firstActivationDate < "2023-11-01 00:00:00" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59") AND p.serviceId = 5
GROUP BY "2023-11", o.id, t.id, t.serial_no, s2.name,s3.sector_name, c.name

SELECT t.organisation_id, t.serial_no, MAX(bp.signedDate) as SonIslemTarih, MAX(bp.id) as SonIslemID FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.id IN (SELECT MAX(bp.id) as SonIslem FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
GROUP BY bp.organisationId, t.serial_no)
GROUP BY t.organisation_id, t.serial_no

SELECT wol.id, wol.SerialNumber, History.serialNo, History.historyStatus, History.physicalSerialId, History._createdDate FROM stargate.WorkOrderLog wol
LEFT JOIN (SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (SELECT MAX(th.id) as SonHistoryID FROM odeal.TerminalHistory th 
WHERE th.historyStatus IN ("SETUP_COMPLETED","ACTIVATED","DEACTIVATED","CANCELLED","RESERVATION_CANCELLED")
GROUP BY th.serialNo)) as History ON CONVERT(History.serialNo USING utf8) = wol.SerialNumber
WHERE wol.id IN (SELECT MAX(wol.id) as SonID FROM stargate.WorkOrderLog wol
WHERE wol.FieldService = "propay" AND wol.WorkOrderType = "SETUP"
GROUP BY wol.SerialNumber)

SELECT * FROM odeal.TerminalHistory th WHERE th.id IN (SELECT MAX(th.id) as SonHistoryID FROM odeal.TerminalHistory th 
WHERE th.historyStatus IN ("SETUP_COMPLETED","ACTIVATED","DEACTIVATED","CANCELLED","RESERVATION_CANCELLED")
GROUP BY th.serialNo)


SELECT LEFT(m.phone,3) as IlkUc, MAX(m.phone) as Son, LENGTH(m.phone) as Uzunluk, COUNT(*), MAX(m._lastModifiedDate) as SonDuzenleme FROM odeal.Merchant m 
JOIN odeal.Organisation o ON o.id = m.organisationId AND o.demo = 0 AND o.isActivated = 1
WHERE m.`role` = 0 -- AND LEFT(m.phone,3) IN ("505","532","555") -- AND (LENGTH(m.phone)>10 or LENGTH(m.phone)<10) 
GROUP BY LEFT(m.phone,3), LENGTH(m.phone) 

SELECT * FROM odeal.Merchant m 

SELECT t.organisation_id, t.serial_no, c.name, t.firstActivationDate, t.terminalStatus, s.id, s.activationDate, s.cancelledAt, s.status, s2.name, t.bankInfoId, bi.iban, bi.bank, SUM(bp.amount) as Ciro FROM odeal.Terminal t 
LEFT JOIN odeal.Channel c ON c.id = t.channelId
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id 
WHERE c.id = 130 AND bp.currentStatus = 6
GROUP BY t.organisation_id, t.serial_no, c.name, t.firstActivationDate, t.terminalStatus, s.id, t.bankInfoId

SELECT * FROM odeal.Channel c 
WHERE c.id = 130

SELECT * FROM odeal.BankInfo bi 

SELECT * FROM subscription.Plan p 
WHERE p.tag IS NOT NULL

SELECT o.id as UyeID, IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum, o.activatedAt as UyeAktivasyonTarihi, 
t.firstActivationDate as TerminalAktivasyonTarihi, IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
s.activationDate as AbonelikAktivasyonTarihi, 
s.cancelledAt as AbonelikIptalTarihi, t.serial_no as MaliNo, 
s.id as AbonelikID, p.name as Plan, p.commissionRates,
JSON_UNQUOTE(JSON_EXTRACT(NULLIF(p.tag,''),'$.campaign')) AS Kampanya
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND o.demo = 0
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= CURDATE() - INTERVAL 1 MONTH AND bp.signedDate <= CURDATE()
WHERE p.tag IS NOT NULL 
GROUP BY o.id, t.serial_no, t.firstActivationDate, t.terminalStatus, s.activationDate, s.cancelledAt, s.id

SELECT p.tag, COUNT(*) FROM subscription.Plan p 
GROUP BY p.tag

SELECT fp.id, fp.code, fp.failedAt, fp.provider, fp.reason, bp.id, bp.signedDate FROM odeal.FailedPayment fp
JOIN odeal.BasePayment bp ON bp.paymentId = fp.paymentId
WHERE fp.failedAt >= "2023-01-01 00:00:00" AND (fp.provider IS NULL OR fp.reason IS NULL) 

SELECT * FROM odeal.Terminal t 
WHERE t.serial_no = "PAX710012519"

SELECT * FROM odeal.Channel c 

SELECT o.id, t.serial_no, s.id, s.activationDate, s.`start`, s.stop, p.name
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND t.terminalStatus = 1
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId 

SELECT o.id, o.isActivated, o.activatedAt, o.deActivatedAt, t.id, t.serial_no, t.firstActivationDate, t.terminalStatus, s.activationDate, s.cancelledAt, 
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, MAX(bp.signedDate) as SonIslemTarih FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id AND o.demo=0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 
AND bp.signedDate >= "2023-11-01 00:00:00" AND bp.signedDate <= "2023-11-30 23:59:59"
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
GROUP BY o.id, t.id, s.activationDate, s.cancelledAt

SELECT t.organisation_id, t.serial_no, SUM(bp.amount) as Ciro, MIN(bp.signedDate) as IlkIslem FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2023-12-01 00:00:00"
GROUP BY t.organisation_id, t.serial_no

SELECT br.id, br.unique_key, bp.uniqueKey, bp.amount FROM paymatch.bank_report br 
LEFT JOIN odeal.BasePayment bp ON bp.uniqueKey = br.unique_key AND bp.currentStatus = 6 AND bp.signedDate >= "2023-12-15 00:00:00"
LIMIT 10000

SELECT * FROM paymatch.bank_report br 
LIMIT 10

SELECT bmt.serial_no, bmt.bank_name, COUNT(*) FROM paymatch.bank_mid_tid bmt
LEFT JOIN odeal.Terminal t ON t.serial_no = bmt.serial_no WHERE bmt.serial_no LIKE "%PAX%" AND t.terminalStatus = 1
GROUP BY bmt.serial_no, bmt.bank_name HAVING COUNT(*)>1

SELECT *, br.id, br.bank_merchant_id, br.pos_merchant_id FROM paymatch.bank_mid_tid bmt 
LEFT JOIN paymatch.bank_report br ON br.bank_merchant_id = bmt.mid AND br.pos_merchant_id = bmt.tid
WHERE bmt.serial_no = "PAX710013056"

SELECT * FROM paymatch.bank_mid_tid bmt 
WHERE bmt.serial_no = "PAX710013056"

SELECT t.organisation_id, t.serial_no, bp.id, bp.uniqueKey, br.bank_transaction_id, bp.transactionId, br.id, br.bank_merchant_id, br.pos_merchant_id, bmt.bank_name, bmt.mid, bmt.tid FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey
LEFT JOIN paymatch.bank_mid_tid bmt ON bmt.serial_no = t.serial_no AND bmt.mid = br.bank_merchant_id AND bmt.tid = br.pos_merchant_id
WHERE bp.currentStatus = 6 AND t.serial_no = "PAX710013056" -- AND bp.id = 545136717

SELECT o.id, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-01-01 00:00:00"
GROUP BY o.id, t.serial_no

SELECT bp.organisationId, bp.serviceId, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-01-01 00:00:00"
GROUP BY bp.organisationId, bp.serviceId, t.serial_no

SELECT DATE_FORMAT(bp.signedDate, "%Y-%m-%d") as Tarih, s.name, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01"
GROUP BY DATE_FORMAT(bp.signedDate, "%Y-%m-%d"),s.name

SELECT s.sector_name , COUNT(o.id) as Adet FROM odeal.Organisation o 
JOIN odeal.Sector s ON s.id = o.sectorId 
GROUP BY s.sector_name ORDER BY COUNT(o.id) DESC


-- END OF PERIOD - Terminal Adetleri - Üye İşyeri Aktifliğine Bakılmaksızın Aynı Ay içinde İptal Olan Terminali olan Üye İşyerleri ile Gelecek Ay içinde İptal Olan üye işyerleri listesi
SELECT EndOfPeriodTerminalAdet.Ay, EndOfPeriodTerminalAdet.id, EndOfPeriodTerminalAdet.isActivated, EndOfPeriodTerminalAdet.Adet as EODTerminalAdet, TerminalAdet.id, TerminalAdet.isActivated, TerminalAdet.TerminalAdet FROM (
SELECT "2023-01"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-02"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-03"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-04"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-05"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-06"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-07"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-08"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-09"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-10"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION 
SELECT "2023-11"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION 
SELECT "2023-12"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-12-31 23:59:59")
GROUP BY o.id, o.isActivated
) as EndOfPeriodTerminalAdet
LEFT JOIN 
(SELECT TerminalAdet.Ay, TerminalAdet.id, TerminalAdet.isActivated, TerminalAdet.Adet as TerminalAdet FROM (
SELECT "2023-01"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-01-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2022-12-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-02"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-02-28 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-01-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-03"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-02-28 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-04"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-04-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-03-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-05"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-05-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-04-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-06"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-06-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-05-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-07"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-07-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-06-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-08"  as Ay,o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-08-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-07-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-09"  as Ay, o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-09-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-08-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-10"  as Ay, o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-10-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-09-30 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-11"  as Ay, o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-11-30 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-10-31 23:59:59")
GROUP BY o.id, o.isActivated
UNION
SELECT "2023-12"  as Ay, o.id, o.isActivated, COUNT(*) as Adet FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2023-12-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2023-11-30 23:59:59")
GROUP BY o.id, o.isActivated
) as TerminalAdet) as TerminalAdet ON TerminalAdet.Ay = EndOfPeriodTerminalAdet.Ay AND TerminalAdet.id = EndOfPeriodTerminalAdet.id


-- GELECEK AY iptal olan organizasyonlar dahil - OCAK 2023
SELECT o.id, COUNT(*) FROM odeal.Organisation o 
WHERE o.activatedAt < "2023-01-31 23:59:59" AND (o.deActivatedAt IS NULL OR o.deActivatedAt> "2023-01-31 23:59:59")
GROUP BY o.id

-- AYNI AY iptal olan organizasyonlar dahil - OCAK 2023
SELECT o.id, COUNT(*) FROM odeal.Organisation o 
WHERE o.activatedAt < "2023-01-31 23:59:59" AND (o.deActivatedAt IS NULL OR o.deActivatedAt>= "2023-01-01 00:00:00")
GROUP BY o.id



SELECT s.name, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.signedDate >= "2024-01-09 00:00:00" AND bp.signedDate <= "2024-01-09 23:59:59"
GROUP BY s.name





PAX710038084  301236722


SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay,  t.organisation_id, t.serial_no, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE t.organisation_id = 301236722 AND t.serial_no = "PAX710038084"
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"),  t.organisation_id, t.serial_no


SELECT s.name, bp.isExternallyGenerated, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.signedDate >= "2024-01-08 00:00:00" AND bp.signedDate <= "2024-01-08 23:59:59" 
AND bp.`_createdDate` >= "2024-01-09 05:00:00" AND bp.`_createdDate` <= "2024-01-10 11:04:59"
GROUP BY s.name, bp.isExternallyGenerated HAVING s.name = "OKC"

SELECT bp.organisationId, MAX(bp.signedDate) as SonIslemTarihi, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as ToplamCiro FROM odeal.BasePayment bp 
JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0 AND o.isActivated = 1
WHERE bp.currentStatus = 6 AND bp.organisationId IS NOT NULL
GROUP BY bp.organisationId

SELECT o.id, MAX(bp.signedDate) as SonIslemTarihi, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as ToplamCiro FROM odeal.Organisation o 
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND o.demo = 0 AND o.isActivated = 1
WHERE bp.currentStatus = 6 AND bp.organisationId IS NOT NULL 
GROUP BY o.id
ORDER BY SUM(bp.amount) DESC LIMIT 10

301244177 2C51247849

TIMESTAMPDIFF(unit, datetime_expr1, datetime_expr2)


301004892

SET @sira := 0;
SET @onceki_uye := NULL;

SELECT DATE_FORMAT(o.activatedAt,"%Y-%m") as YılAy, o.id, o.activatedAt, t.serial_no, t.firstActivationDate,TIMESTAMPDIFF(SECOND,o.activatedAt,t.firstActivationDate) as Fark  FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.firstActivationDate IS NOT NULL AND o.id = 301004892
ORDER BY TIMESTAMPDIFF(SECOND,o.activatedAt,t.firstActivationDate)

select o.id, t.serial_no,
(select o2.id, t.serial_no, COUNT(*) from odeal.Organisation o2 
JOIN odeal.Terminal t2 ON t2.organisation_id = o2.id
where o.id = o2.id and t2.serial_no >= t.serial_no
GROUP BY o2.id, t.serial_no) rnk
from odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id 
WHERE o.id = 301004892
order by rnk


SELECT o.id, t.serial_no, COUNT(*) FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301004892

select o.id, o.unvan, o.marka, t.serial_no,
       (select count(*)
        from odeal.Organisation o2
        JOIN odeal.Terminal t2 ON t2.serial_no = t.serial_no 
        where o2.id <= o.id AND t2.serial_no <= t.serial_no) as row_number
from odeal.Organisation o 
join odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301004892
order by o.id;

select count(*)
        from odeal.Organisation o2
        where o2.id <= o.id

SELECT o.id, t.serial_no, (SELECT COUNT(*) FROM odeal.Terminal t2 WHERE t2.serial_no <= t.serial_no AND t2.organisation_id <= t.organisation_id) as Sira FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301004892

SET @sira_numarasi := 0;
SET @onceki_organisation_id := NULL;

SELECT 
    CASE WHEN organisation_id = @onceki_organisation_id 
         THEN @sira_numarasi := @sira_numarasi + 1
         ELSE @sira_numarasi := 1 END AS Sira,
    @onceki_organisation_id := organisation_id AS organisation_id,
    t.serial_no
FROM 
    odeal.Organisation o JOIN odeal.Terminal t ON t.organisation_id = o.id
ORDER BY 
    organisation_id, serial_no;
   
   SELECT * FROM odeal.Organisation o 
   WHERE o.id = 301004892



SELECT t.organisation_id, t.serial_no, t.firstActivationDate, s.cancelledAt,t.channelId, c.name FROM odeal.Terminal t 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE c.name LIKE "%ANTURA%"

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, c.name, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
WHERE c.id = 255 AND DATE_FORMAT(bp.signedDate,"%Y-%m") = "2024-01"
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), t.channelId

SELECT t.channelId, t.serial_no, DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE t.channelId = 255
GROUP BY t.channelId, t.serial_no, DATE_FORMAT(bp.signedDate,"%Y-%m")



SELECT Aktivasyon.UyeID, Aktivasyon.organisationId, Aktivasyon.TerminalID, Aktivasyon.serial_no, Aktivasyon.serviceId, Aktivasyon.channel_id, Aktivasyon.status,
Aktivasyon.isActivated, Aktivasyon.deActivatedAt, Aktivasyon.start, Aktivasyon.taksitli, Aktivasyon.terminalStatus,MIN(bp.signedDate) as Min, SUM(bp.amount) as Ciro FROM (
SELECT o.id as UyeID,
    o.organisationId,
    t.id as TerminalID,
    t.serial_no,
    serviceId,
    t.channelId as channel_id,
    sb.status,
    isActivated, 
    o.activatedAt, 
    o.deActivatedAt,
    sb.start,
    pln.taksitli,
    t.terminalStatus,
        CASE
            WHEN date(o.activatedAt) > date(t.firstActivationDate) AND sb.status=1 THEN date(o.activatedAt)
            ELSE date(t.firstActivationDate)
        END activationDate,
       CASE 
	  WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
	    (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
	            ELSE sb.cancelledAt END )
	  WHEN t.terminalStatus=1 THEN NULL 
	  ELSE sb.cancelledAt
	END cancelDate
        FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId AND serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id) as Aktivasyon
        LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = Aktivasyon.TerminalID
        LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
        WHERE Aktivasyon.UyeID NOT IN (301011013,301160192) AND Aktivasyon.channel_id = 255
        GROUP BY Aktivasyon.UyeID, Aktivasyon.organisationId, Aktivasyon.TerminalID, Aktivasyon.serial_no, Aktivasyon.serviceId, Aktivasyon.channel_id, Aktivasyon.status,
Aktivasyon.isActivated, Aktivasyon.deActivatedAt, Aktivasyon.start, Aktivasyon.taksitli, Aktivasyon.terminalStatus

        
        GROUP BY id,organisationId,terminal_id,serial_no,serviceId ,channel_id,taksitli, isActivated ,terminalStatus,activationDate,cancelDate

SELECT o.id, bp.id, bp.signedDate FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id AND bp.signedDate >= "2023-01-01 00:00:00"
WHERE o.isActivated = 1 AND o.id = 301000087

SELECT * FROM odeal.BasePayment bp 



WHERE bp.organisationId = 301000087

SELECT tp.terminal_id FROM odeal.TerminalPayment tp 

SELECT o.id, o.activatedAt, o.createdAt, o. t.serial_no, t.firstActivationDate FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301172525 AND bp.id

301000615

SELECT o.id, o.isActivated, o.activatedAt, s.created, s.activationDate, p.name, s2.name FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE o.id = 301000615 

SELECT * FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.organisationId IN (SELECT o.id FROM odeal.Organisation o WHERE o.id = 301138670)


SELECT Islemler.organisationId, Islemler.SerialNo, SUM(Islemler.amount) AS Ciro FROM (
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 2 DAY, '%Y-%m-%d') AND
bp.signedDate <= NOW()
UNION
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 2 DAY, '%Y-%m-%d') AND
bp.signedDate <= NOW() 
) as Islemler
GROUP BY Islemler.organisationId, Islemler.SerialNo. IF(tp.installment>1, "Taksitli" , "Tek Çekim")

301170708

SELECT DATE_FORMAT(Islemler.signedDate,"%Y-%m") as Ay, SUM(Islemler.amount) as Ciro FROM (
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = s.planId 
JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, '%Y-%m-01') AND
bp.signedDate <= NOW()) as Islemler

GROUP BY DATE_FORMAT(Islemler.signedDate,"%Y-%m")


SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.amount >= 1 AND DATE_FORMAT(bp.signedDate, "%Y-%m-01 00:00:00") >= DATE_FORMAT(NOW() - INTERVAL 2 MONTH,"%Y-%m-%d %H:%i:%s") AND
DATE_FORMAT(bp.signedDate,"%Y-%m-%d %H:%i:%s") <= DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AND bp.organisationId = 301086856

SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.amount >= 1 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-01") AND
bp.signedDate <= DATE_FORMAT(CURDATE(), "%Y-%m-%d")

SELECT DATE_FORMAT(DATE_SUB("2024-02-22", INTERVAL 1 MONTH), "%Y-%m-01")

SELECT DATE_FORMAT(CURDATE(), "%Y-%m-%d")

SELECT MAX(bp.signedDate), MIN(bp.signedDate) FROM odeal.BasePayment bp WHERE bp.currentStatus = 6 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), "%Y-%m-01") AND
bp.signedDate <= DATE_FORMAT(CURDATE(), "%Y-%m-%d")

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet, bp.id FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
AND bp.organisationId IN (SELECT CeptePos.uyeid FROM (
SELECT o.id as uyeid, MAX(s.id) as aboneid FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3
GROUP BY o.id) as CeptePos)
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), bp.id

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, bp.organisationId, bp.amount as Ciro, bp.id, bp.serviceId FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-31 23:59:59"
AND bp.organisationId IN (SELECT CeptePos.uyeid FROM (
SELECT o.id as uyeid, MAX(s.id) as aboneid FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id) as CeptePos)

SELECT * FROM (
SELECT o.id as uyeid, s.id as aboneid, s.status as durum FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE o.isActivated = 1 AND p.serviceId = 3 AND s.status = 1
ORDER BY o.id, s.id) as CeptePos
LEFT JOIN (SELECT o.id as orgid, s.id as abonelik, s.status as abonedurum FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE o.isActivated = 1 AND p.serviceId = 3 AND s.status = 1
ORDER BY o.id, s.id) as Islemler ON Islemler.orgid = CeptePos.uyeid
WHERE Islemler.orgid >= CeptePos.uyeid AND Islemler.orgid = 301000195

SELECT CeptePos.uyeid FROM (
SELECT o.id as uyeid, MAX(s.id) as aboneid FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId 
WHERE p.serviceId = 3
GROUP BY o.id) as CeptePos

select s.name, SUM(bp.amount) as Ciro -- ,count(1)
    -- bp.serviceId,posId,bp._createdDate,tp.terminal_id,t.model,t.supplier,a.name
from BasePayment bp
                                    -- join TerminalPayment tp on bp.id = tp.id
                                    -- join Terminal t on t.id = tp.terminal_id
-- join subscription.Subscription s on s.id = bp.subscriptionId
-- join subscription.Plan p on p.id = s.planId
-- join subscription.Addon a on a.id = p.addonId
left join subscription.Service s on s.id = bp.serviceId
where bp._createdDate > '2024-01-01 00:00:00' and paybackAmount > 0 and currentStatus = 6
GROUP BY s.name

SELECT bp.id, bp.signedDate, bp.amount as Ciro, p.serviceId, bp.serviceId, bp.paymentType FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-24 23:59:59"


SELECT SUM(bp.amount) as Ciro, bp.serviceId FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.serviceId = 7 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-01-24 23:59:59"
GROUP BY bp.serviceId

SELECT o.id, o.isActivated, t.serial_no, t.terminalStatus, t.subscription_id, p.serviceId, bp.serviceId, bp.id FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE o.id = 301243328

SELECT bp.id, bp.serviceId, p.serviceId, t.serial_no, bp.organisationId, bp.currentStatus, bp.signedDate FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE bp.id = 648920828 AND bp.currentStatus = 6

301243328

SELECT * FROM odeal.BasePayment bp 
WHERE bp.id = 648920828 AND bp.currentStatus = 6

SELECT * FROM odeal.TerminalPayment tp WHERE tp.id = 648920828

SELECT * FROM odeal.RecurringPayment rp 
WHERE rp.dueDate >= "2024-01-01 00:00:00"

SELECT * FROM payout_source.source_history sh WHERE sh.record_id = "2601dwlqkmwoh800"

SELECT * FROM payout_source.source s WHERE s.merchant_id = 301133709

SELECT * FROM subscription.Plan p

SELECT * FROM odeal.Channel c WHERE c.name LIKE "%mert%"


SELECT t.id as TerminalID, t.serial_no, t.subscription_id, t.organisation_id, IF(t.terminalStatus=1,"AKTİF","PASİF") as TerminalDurum, t.firstActivationDate, Islemler.id as IslemID, Islemler.amount, Islemler.signedDate,
SourceHistory.*, THistory.historyStatus as GecmisDurum, THistory._createdDate as GecmisOlusmaTarih
FROM odeal.Terminal t 
LEFT JOIN (SELECT s.tckn as TckNo, s.vkn as VkNumber, s.phone_number as PNumber, s.merchant_id as UyeIsyeri, s.last_blocked_date as SLastBlockedDate, s.record_id as SRecordID, s.terminal_id, s.merchant_id, SourceHistory.* FROM payout_source.source s 
LEFT JOIN (SELECT * FROM payout_source.source_history sh 
WHERE sh.id IN (SELECT MAX(sh.id) FROM payout_source.source_history sh 
GROUP BY sh.record_id)) as SourceHistory ON SourceHistory.record_id = s.record_id
WHERE s.terminal_id IS NOT NULL) as SourceHistory ON SourceHistory.terminal_id = t.id AND SourceHistory.merchant_id = t.organisation_id
LEFT JOIN (SELECT * FROM odeal.TerminalHistory th 
WHERE th.id IN (SELECT MAX(th.id) FROM odeal.TerminalHistory th 
GROUP BY th.serialNo)) as THistory ON THistory.organisationId = t.organisation_id AND CONVERT(THistory.serialNo USING utf8) = t.serial_no
LEFT JOIN (SELECT bp.id, bp.amount, bp.signedDate, t.serial_no, bp.organisationId, p.name, p.commissionRates FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
WHERE DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= "2022-11-01" AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= CURDATE() AND bp.currentStatus = 6
AND t.id IN (SELECT t.id FROM odeal.Terminal t 
WHERE t.id IN (SELECT s.terminal_id FROM payout_source.source s 
WHERE s.terminal_id IS NOT NULL
GROUP BY s.terminal_id))) as Islemler ON Islemler.organisationId = t.organisation_id AND Islemler.serial_no = t.serial_no
WHERE t.id IN (SELECT s.terminal_id FROM payout_source.source s 
LEFT JOIN (SELECT * FROM payout_source.source_history sh 
WHERE sh.id IN (SELECT MAX(sh.id) FROM payout_source.source_history sh 
GROUP BY sh.record_id)) as SourceHistory ON SourceHistory.record_id = s.record_id
WHERE s.terminal_id IS NOT NULL)

SELECT o.id as UyeID, o.marka as Marka, t.serial_no as MaliNo, t.firstActivationDate as AktivasyonTarihi, o.unvan as Unvan, IF(o.isActivated=1,"AKTİF","PASİF") as UyeDurum, IF(t.terminalStatus=1,"AKTİF","PASİF") as TerminalDurum,
CONCAT(m.firstName," ",m.LastName) as Yetkili, m.email FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE m.email IN (
SELECT m.email FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
GROUP BY m.email HAVING COUNT(m.email)>1)
ORDER BY m.email 



SELECT s.organisationId, p.name, p.serviceId FROM subscription.Subscription s 
LEFT JOIN subscription.Plan p ON p.id = s.planId
WHERE s.organisationId = 301173038

SELECT bp.serviceId as Hizmet, CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as OdemeTipi,  COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar FROM odeal.BasePayment bp 
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59" AND bp.currentStatus = 6
GROUP BY bp.serviceId, bp.paymentType 

SELECT bmt.serial_no, bmt.bank_name, COUNT(*) as Adet FROM paymatch.bank_mid_tid bmt 
GROUP BY bmt.serial_no, bmt.bank_name HAVING COUNT(*)>1

SELECT 
  bp.id AS `id (BasePayment)`,
  bp.organisationId AS `organisationId (BasePayment)`,
 bp.signedDate AS `signedDate`,
  bp.currentStatus AS `currentStatus`,
  bp.paymentType  AS `paymentType`,
CASE 
	WHEN bp.paymentType = 0 THEN "Kartlı Ödeme"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as OdemeTipi,
  bp.serviceId AS `serviceId`,
bp.amount  AS `amount (BasePayment)`,
bp.deviceId,
s.name as service_name
FROM odeal.BasePayment bp
JOIN subscription.Service s on s.id = bp.serviceId
WHERE
	bp.currentStatus = 6
        and bp.organisationId is not null
        AND bp.paymentType <> 4
	    and bp.signedDate is not null and cancelDate is null
        and DATE_FORMAT(bp.signedDate, '%Y-%m-%d')>='2017-01-01'
        and bp.signedDate <=NOW()

SELECT o.id, t.serial_no, s.activationDate, t.firstActivationDate FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN odeal.Channel c ON c.id = t.channelId
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE  t.channelId = 130 and o.id = 301247021

SELECT o.id, s.id, p.name, s2.name, t.id, bp.id, bp.signedDate, bp.amount FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= "2024-02-11 00:00:00" AND t.id = 54864

SELECT o.id, s.id, p.name, s2.name, t.id, bp.id, bp.signedDate, bp.amount FROM odeal.Organisation o 
LEFT JOIN subscription.Subscription s ON s.organisationId = o.id 
LEFT JOIN odeal.BasePayment bp ON bp.

LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= "2024-02-11 00:00:00" AND t.id = 54864

WHERE o.id = 301007035

SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = s.planId 
JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE(bp.signedDate) >= DATE(CURDATE() - INTERVAL 3 DAY) AND
DATE(bp.signedDate) <= DATE(NOW())

SELECT o.id, s.id, p.name, s2.name, t.id, bp.id, bp.signedDate, bp.amount FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= "2024-02-11 00:00:00" AND t.id = 54864

SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 2 DAY, '%Y-%m-%d') AND
DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= DATE_FORMAT(NOW(),"%Y-%m-%d")
UNION
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND DATE_FORMAT(bp.signedDate,"%Y-%m-%d") >= DATE_FORMAT(CURDATE() - INTERVAL 2 DAY, '%Y-%m-%d') AND
DATE_FORMAT(bp.signedDate,"%Y-%m-%d") <= DATE_FORMAT(NOW(),"%Y-%m-%d")

SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, s.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
LEFT JOIN subscription.Subscription s ON s.organisationId = bp.organisationId
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = s.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p.serviceId = 3 AND DATE(bp.signedDate) >= DATE(CURDATE() - INTERVAL 2 DAY) AND
DATE(bp.signedDate) <= DATE(NOW())
UNION
SELECT bp.organisationId, bp.id,
CASE
	WHEN bp.paymentType = 0 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 1 THEN "Kredi Kartı / Banka Kartı / Ceptepos"
	WHEN bp.paymentType = 2 THEN "Kredi Kartı / Banka Kartı / Terminal"
	WHEN bp.paymentType = 3 THEN "Kredi Kartı / Banka Kartı / 3D Ödeme"
	WHEN bp.paymentType = 4 THEN "Nakit"
	WHEN bp.paymentType = 5 THEN "BKM Express"
	WHEN bp.paymentType = 6 THEN "Tekrarlı Ödeme"
	WHEN bp.paymentType = 7 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 8 THEN "Kredi Kartı / Banka Kartı"
	WHEN bp.paymentType = 9 THEN "Istanbul Kart"
	WHEN bp.paymentType = 10 THEN "Hediye Kartı"
	WHEN bp.paymentType = 11 THEN "Senet"
	WHEN bp.paymentType = 12 THEN "Çek"
	WHEN bp.paymentType = 13 THEN "Açık Hesap"
	WHEN bp.paymentType = 14 THEN "Kredili"
	WHEN bp.paymentType = 15 THEN "Havale/Eft"
	WHEN bp.paymentType = 16 THEN "Yemek Kartı/Çeki"
	WHEN bp.paymentType = 17 THEN "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"
END as PaymentTipi,
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi, tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND DATE_FORMAT(bp.signedDate, "%Y-%m-01 00:00:00") >= NOW() - INTERVAL 1 MONTH AND
DATE_FORMAT(bp.signedDate,"%Y-%m-%d %HH-%mm-%ss") <= NOW()


310249187

SELECT * FROM odeal.BasePayment bp WHERE bp.currentStatus = 6 AND bp.serviceId <> 3 AND DATE_FORMAT(bp.signedDate, "%Y-%m-01 00:00:00") >= NOW() - INTERVAL 1 MONTH AND
DATE_FORMAT(bp.signedDate,"%Y-%m-%d %HH-%mm-%ss") <= NOW()

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Gun,  bp.serviceId as Hizmet,COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro, MAX(bp.amount) as EnYuksek,  FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-13 00:00:00" AND bp.signedDate <= "2024-02-14 23:59:59" AND bp.serviceId = 2
GROUP BY DATE(bp.signedDate,"%Y-%m-%d"),bp.serviceId
 
SELECT 134139-121238

SELECT * FROM subscription.SubscriptionHistory sh 
WHERE sh.terminalId = 112403

SELECT * FROM  subscription.SubscriptionHistory sh  
LEFT JOIN subscription.Subscription s ON sh.subscriptionId = s.id
WHERE s.id = 565494

SELECT o.id, t.id, s.id, p.name, s2.name, IF(tp.installment>1,"Taksitli","Tek Çekim"), MAX(bp.signedDate), SUM(bp.amount), COUNT(bp.id) FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.paymentType <>4 AND bp.signedDate >= "2024-02-13 00:00:00" AND s2.id = 7 AND o.id IN(
SELECT o.id FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id 
LEFT JOIN subscription.Plan p ON p.id = s.planId 
LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.paymentType <>4 AND bp.signedDate >= "2024-02-13 00:00:00" AND s2.id = 2) and o.id = 301035369
GROUP BY o.id, t.id, s.id, p.name, s2.name, IF(tp.installment>1,"Taksitli","Tek Çekim")

 select sum(intervalCount) as 'VadeSuresi',sum(intervalCount*amount) as 'VadeTutarı' from subscription.Plan
where id in (select distinct(planId) from subscription.SubscriptionHistory
where terminalId=206844 and status<>0);

SELECT * FROM subscription.SubscriptionHistory sh WHERE sh.terminalId = 206844

SELECT * FROM subscription.Plan p WHERE p.id = 16261

SELECT * FROM subscription.Plan p WHERE p.id = 18492


SELECT p.id, bp.id, t.serial_no, o.id, p2.id, br.id, br.gross_amount,  p.paymentStatus  FROM odeal.Payback p 
JOIN odeal.BasePayment bp ON bp.paybackId = p.id 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
JOIN odeal.Organisation o ON o.id = t.organisation_id 
JOIN odeal.POS p2 ON p2.id = bp.posId 
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey 
WHERE p.dueDate >= "2024-02-16 00:00:00"

SELECT bp.id, bp.amount, bp.serviceId, bp.basketId, bp.signedDate, bp.organisationId, t.serial_no, e.basketId, e.status, e.invoiceType, e.created_date FROM odeal.BasePayment bp 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.EInvoice e ON e.basketId = bp.basketId 
WHERE bp.id = 558377799

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%organisation%"


SELECT o.id, o.activatedAt, t.serial_no, t.firstActivationDate, o.isNew FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id



SELECT t.serial_no, t.organisation_id, t.firstActivationDate, o.id, o.activatedAt FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE o.activatedAt >= "2024-01-01 00:00:00" AND o.activatedAt <= "2024-01-31 23:59:59"
