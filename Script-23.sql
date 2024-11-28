SELECT Islemler.organisationId, Islemler.SerialNo,  Islemler.id, Islemler._createdDate, Islemler.currentStatus, Islemler.amount, Islemler.Tedarikci FROM (
SELECT bp.organisationId,
bp.id,
bp.uniqueKey,
bp.paymentType,
bp.posId,
bp.signedDate,
bp._createdDate,
bp.currentStatus,
bp.appliedRate,
bp.amount,
bp.paybackAmount as BpPaybackAmount,
bp.serviceId,
bp.batchNo,
Abonelik.id as AbonelikID,
bp.organisationId as SerialNo,
"CeptePos" as Tedarikci,
Abonelik.`_createdDate` as AktivasyonTarihi,
p2.installment,
IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum,
c2.name as Kanal,
p.addonId as Cihaz,
p.name as Plan,
p.commissionRates as PlanKomisyon,
pb.id as PaybackID,
pb.dueDate,
pb.totalAmount,
pb.amount as PaybackAmount,
pb.paymentStatus
FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
LEFT JOIN odeal.Payback pb ON pb.id = bp.paybackId
LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId
WHERE bp.serviceId = 3
  AND bp._createdDate >= "2024-03-01 00:00:00"
  AND bp._createdDate < "2024-04-01 00:00:00"
AND o.demo = 0
UNION
SELECT bp.organisationId,
bp.id,
bp.uniqueKey,
bp.paymentType,
bp.posId,
bp.signedDate,
bp._createdDate,
bp.currentStatus,
bp.appliedRate,
bp.amount,
bp.paybackAmount as BpPaybackAmount,
bp.serviceId,
bp.batchNo,
s.id as AbonelikID,
t.serial_no as SerialNo,
t.supplier as Tedarikci,
t.firstActivationDate as AktivasyonTarihi,
tp.installment,
IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum,
c2.name as Kanal,
p.addonId as Cihaz,
p.name as Plan,
p.commissionRates as PlanKomisyon,
pb.id as PaybackID,
pb.dueDate,
pb.totalAmount,
pb.amount as PaybackAmount,
pb.paymentStatus
FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
LEFT JOIN odeal.Payback pb ON pb.id = bp.paybackId
LEFT JOIN odeal.Organisation o ON o.id = t.organisation_id
WHERE  bp.serviceId <>3
  AND bp._createdDate >= "2024-03-01 00:00:00"
  AND bp._createdDate < "2024-04-01 00:00:00"
AND o.demo = 0
) as Islemler


SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01")

SELECT WEEK(bp.signedDate), SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet, MIN(bp.signedDate), MAX(bp.signedDate) FROM odeal.BasePayment bp 
WHERE bp.signedDate >= "2024-03-10 00:00:00" AND bp.signedDate <= "2024-03-10 23:59:59" AND bp.currentStatus = 6 AND bp.serviceId = 3
GROUP BY WEEK(bp.signedDate)

SELECT MINUTE(bp.`_createdDate`) as Dakika, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet  FROM odeal.BasePayment bp 
WHERE bp.`_createdDate` >= "2024-03-16 04:00:00" AND bp.`_createdDate` <= "2024-03-16 07:00:00"
GROUP BY MINUTE(bp.`_createdDate`)

 -- OKC BSMV Report
SELECT Saydir.IslemAy, Saydir.GeriOdemeAy, Saydir.IslemDurum, COUNT(*) as Adet FROM (
SELECT EXTRACT(YEAR_MONTH FROM BSMV.signedDate) as IslemAy, EXTRACT(YEAR_MONTH FROM BSMV.paybackDate) as GeriOdemeAy, IF(YEAR(BSMV.signedDate)=YEAR(BSMV.paybackDate) AND MONTH(BSMV.signedDate)=MONTH(BSMV.paybackDate),"AYNI","FARKLI") as IslemDurum FROM (
SELECT bp.id,
       t.serial_no,
       bp.paymentId                                               as paymentId,
       pb.paybackId                                               as paybackId,
       bp.signedDate                                              as signedDate,
       pb.dueDate                                                 AS paybackDate,
       tp.installment                                             AS installment,
       COALESCE(c.brand, 'DEFAULT')                               as brand,
       COALESCE(bp.cardNumber, c.number)                          as cardNumber,
       bp.organisationId                                          as organisationId,
       plan.name                                                  AS planName,
       pos.name                                                   as posName,
       bp.amount                                                  as amount,
       bankreport.net_amount                                      as netAmount,
       bp.appliedRate                                             as appliedRate,
       bp.paymentType                                             as paymentType,
       bin.bankCode                                               as binBankCode,
       binBank.name                                               as binBankName,
       bin.brand                                                  as binBrand,
       CONVERT(bankreport.bank_commission_amount, DECIMAL(10, 2)) as bankCommissionAmount,
       bankreport.is_manuel                                       as bankaBazlıOdealBazlı,
       bp.uniqueKey
FROM odeal.BasePayment bp
         LEFT JOIN odeal.Payback pb ON pb.id = bp.paybackId -- gerçekten geri ödeme alan müşterilerde sadece JOIN
         JOIN odeal.TerminalPayment tp ON tp.id = bp.id
         JOIN odeal.Terminal t ON t.id = tp.terminal_id
         JOIN subscription.Subscription s ON s.id = t.subscription_id
         JOIN subscription.Plan plan ON plan.id = s.planId and plan.serviceId <> 3
         JOIN odeal.Organisation o ON o.id = bp.organisationId
         LEFT JOIN odeal.POS pos ON pos.id = bp.posId
         LEFT JOIN odeal.CreditCard c ON c.id = bp.cardId
         LEFT JOIN odeal.BinInfo bin on bin.bin = substr(COALESCE(bp.cardNumber, c.lastDigits, c.number), 1, 6)
         LEFT JOIN odeal.Bank binBank
                   on CONVERT(binBank.bankCode, UNSIGNED INTEGER) = CONVERT(bin.bankCode, UNSIGNED INTEGER)
         LEFT JOIN odeal.InstallmentBrand ib on CONVERT(ib.name USING UTF8) = CONVERT(
        COALESCE(c.brand, (select bin.brand from odeal.BinInfo bin where bin = substr(c.lastDigits, 1, 6)), 'DEFAULT')
        USING UTF8)
         LEFT JOIN (select br.is_manuel, br.net_amount, br.bank_commission_amount, br.unique_key
                    from paymatch.bank_report br
                    where
                        br.id IN (select MIN(br.id) from paymatch.bank_report br group by br.unique_key)) AS bankreport
                   ON bankreport.unique_key = bp.uniqueKey
WHERE pb.dueDate >= '2024-01-01 00:00:00'
  AND pb.dueDate <= '2024-01-31 23:59:59'
  AND bp.currentStatus = 6
  AND pb.paymentStatus in (1, 5)
  and bp.paymentType = 7
  and bp.serviceId <> 3) as BSMV) as Saydir
  GROUP BY Saydir.IslemAy, Saydir.GeriOdemeAy, Saydir.IslemDurum

  
ŞUBAT 2024 AYI İÇİNDE İŞLEM VE GERİ ÖDEMESİ OLAN	4579843
FARKLI AYDA İŞLEM VE GERİ ÖDEMESİ ŞUBAT 2024 OLAN	 157236

202204	202402	FARKLI	1
202309	202402	FARKLI	3
202310	202402	FARKLI	76
202311	202402	FARKLI	43
202312	202402	FARKLI	77
202401	202402	FARKLI	157036
202402	202402	AYNI	4579843

SELECT Iban.id, Iban.serial_no, COUNT(*) as Adet FROM (
SELECT o.id, t.serial_no, bi.iban, bi.status, bi._createdDate as KayitTarih FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE o.demo = 0 AND t.terminalStatus = 1) as Iban
GROUP BY Iban.id, Iban.serial_no HAVING COUNT(*)>1

SELECT DISTINCT o.id, t.serial_no, bi.id, bi.iban, bi.`_createdDate`, bi.status FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId AND bi.organisationId = o.id
WHERE o.demo = 0 AND o.id = 301256874 AND t.serial_no = "2C15735389"

SELECT * FROM odeal.BankInfo bi WHERE bi.organisationId = 301002470

SELECT t.organisation_id, t.serial_no, t.bankInfoId, t.terminalStatus FROM odeal.Terminal t 
WHERE t.organisation_id = 301002470

301256874	2C15735389

301134692	JH20093039

301115572	2B25017939


SELECT * FROM odeal.BasePayment bp
WHERE bp.signedDate >= "2024-03-15 00:00:00"
ORDER BY bp.signedDate DESC 

402174

SELECT tmmh.merchant_id, tmmh.serial_no, tmmh.physical_serial_no, tmmh.version FROM odeal.TerminalMerchantMappingHistory tmmh
LEFT JOIN odeal.Terminal t ON t.serial_no = tmmh.serial_no 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id

WHERE tmmh.id IN (
SELECT MAX(tmmh.id) FROM odeal.TerminalMerchantMappingHistory tmmh WHERE tmmh.state  = "ACTIVE" AND tmmh.status = "ACTIVE"
GROUP BY tmmh.merchant_id, tmmh.serial_no)


SELECT * FROM odeal.BasePayment bp WHERE bp.organisationId  = 301000078

SELECT Hizmetler.*, COUNT(Islem.id) as IslemAdet, SUM(Islem.amount) as Ciro FROM (
SELECT o.id as UyeIsyeriID, t.serial_no as MaliNo FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE t.terminalStatus = 1 AND o.isActivated = 1
UNION 
SELECT o.id as UyeIsyeriID, o.id as MaliNo FROM odeal.Organisation o
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = o.id 
WHERE o.isActivated = 1) as Hizmetler
LEFT JOIN (SELECT *FROM (
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
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3 AND s.status = 1
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), "%Y-%m-01") AND
bp.signedDate <= NOW() AND Abonelik.status = 1
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
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId,
t.serial_no as SerialNo, t.supplier as Tedarikci, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 DAY), "%Y-%m-01") AND
bp.signedDate <= NOW() AND t.terminalStatus = 1
) as Islemler) as Islem ON Islem.organisationId = Hizmetler.UyeIsyeriID AND Islem.SerialNo = Hizmetler.MaliNo
GROUP BY Hizmetler.UyeIsyeriID, Hizmetler.MaliNo


SELECT o.id as UyeIsyeriID, Islem.* FROM odeal.Organisation o 
LEFT JOIN (
SELECT o.id, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar, MAX(bp.id) as SonIslemID, MAX(bp.signedDate) as SonIslemTarihi,MIN(bp.id) as IlkIslemID, MIN(bp.signedDate) as IlkIslemTarihi FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
WHERE bp.currentStatus = 6 AND o.isActivated = 1 AND bp.organisationId IS NOT NULL AND bp.signedDate IS NOT NULL
GROUP BY o.id,IF(o.isActivated=1,"Aktif","Pasif")) as Islem ON Islem.id = o.id

SELECT DATE(t.firstActivationDate) as Gun, DAYNAME(t.firstActivationDate) as HaftaninGunu, 
COUNT(CASE WHEN s2.name = "OKC" THEN t.id END) as OKC_Aktivasyon,
COUNT(CASE WHEN s2.name = "SADEPOS" THEN t.id END) as SADEPOS_Aktivasyon,
COUNT(CASE WHEN s2.name = "SADEPOS507" THEN t.id END) as EFATURAPOS_Aktivasyon
FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId <> 3 AND t.firstActivationDate >= "2024-03-11 00:00:00" AND t.firstActivationDate <= NOW()
GROUP BY DATE(t.firstActivationDate),DAYNAME(t.firstActivationDate)

SELECT t.organisation_id, t.serial_no, s2.name, t.terminalStatus FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE p.serviceId = 7 AND t.terminalStatus = 1

SELECT * FROM odeal.FailedPayment fp 

SELECT MONTH(bp.signedDate) as Ay, SUM(bp.amount) as Ciro, COUNT(bp.id) as Islem FROM odeal.BasePayment bp 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59" AND bp.serviceId = 3
GROUP BY MONTH(bp.signedDate)


SELECT CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate)) as Ay, o.id, t.serial_no, SUM(bp.amount) as Ciro
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.signedDate >= "2021-01-01 00:00:00" AND bp.signedDate <= "2021-01-31 23:59:59" AND bp.serviceId <> 3 AND bp.currentStatus = 6 AND bp.amount > 1
GROUP BY CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate)), o.id, t.serial_no 

SELECT CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate)) as Ay, o.id as UyeIsyeriID, t.serial_no MaliNo, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.serviceId <> 3 AND bp.amount > 1 
AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId
WHERE t.firstActivationDate <= "2024-02-29 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-02-29 23:59:59")
GROUP BY CONCAT(YEAR(bp.signedDate),"-",MONTH(bp.signedDate)), o.id, t.serial_no

SELECT t.organisation_id, t.serial_no, t.terminalStatus, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-02-01 00:00:00" AND bp.signedDate <= "2024-02-29 23:59:59"
AND t.organisation_id = 301234014
GROUP BY t.organisation_id, t.serial_no, t.terminalStatus


SELECT t.serial_no, t.organisation_id, i.id, i.totalAmount, i.period,pr.id, pr.created, CASE WHEN i.invoiceStatus=0 THEN "ÖDENMEDİ" WHEN i.invoiceStatus=1 THEN "ÖDENDİ" WHEN i.invoiceStatus=2 THEN "ÖDENMEYECEK" END as FaturaDurum
FROM odeal.Terminal t
JOIN subscription.Invoice i ON i.subscriptionId = t.subscription_id
LEFT JOIN subscription.PaymentReceipt pr ON pr.invoiceId = i.id 
WHERE t.organisation_id = 301234014

SELECT o.id, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, m.phone as Telefon FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND o.demo = 0

SELECT * FROM subscription.PaymentReceipt pr WHERE pr.invoiceId = 2745402

SELECT * FROM subscription.Invoice i WHERE i.id = 2798518


SELECT NOW() - INTERVAL 1 DAY

select DATE(bp.signedDate) as Gun, MIN(bp.signedDate), MAX(bp.signedDate), COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 1 DAY AND bp.signedDate <= NOW() and bp.currentStatus=6
GROUP BY DATE(bp.signedDate), IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name

SELECT Islemler.Gun, MIN(Islemler.MinTarih),MAX(Islemler.MaxTarih), SUM(Islemler.Adet), SUM(Islemler.Ciro) FROM (
select "1.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 1 DAY AND bp.signedDate <= NOW() and bp.currentStatus=6 and bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION
select "2.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 2 DAY AND bp.signedDate <= NOW() - INTERVAL 1 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION
select "3.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 3 DAY AND bp.signedDate <= NOW() - INTERVAL 2 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION
select "4.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 4 DAY AND bp.signedDate <= NOW() - INTERVAL 3 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION 
select "5.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 5 DAY AND bp.signedDate <= NOW() - INTERVAL 4 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION 
select "6.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 6 DAY AND bp.signedDate <= NOW() - INTERVAL 5 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name
UNION 
select "7.Gun" as Gun, MIN(bp.signedDate) as MinTarih, MAX(bp.signedDate) as MaxTarih, COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro,
	 IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim") as Installment, s.name as Servis, p2.name as Pos
from
	odeal.BasePayment bp
	LEFT JOIN odeal.Payment p ON p.id = bp.id 
	LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
	JOIN subscription.Service s ON s.id = bp.serviceId
	JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE
	bp.signedDate > NOW() - INTERVAL 7 DAY AND bp.signedDate <= NOW() - INTERVAL 6 DAY and bp.currentStatus=6 AND bp.serviceId = 2 and p2.name = "ANADOLUBANK A.S."
GROUP BY IF(COALESCE(tp.installment, p.installment)>1,"Taksitli","Tek Çekim"), s.name, p2.name) as Islemler
GROUP BY Islemler.Gun


SELECT Islem.pos_name, IF(Islem.Taksit>1,"Taksitli","Tek Çekim") as TaksitDurum, COUNT(Islem.`id (BasePayment)`) FROM (
SELECT 
  bp.id AS `id (BasePayment)`,
  bp.organisationId AS `organisationId (BasePayment)`,
 bp.signedDate AS `signedDate`,
 bp.cancelDate AS `cancelDate`,
  bp.currentStatus AS `currentStatus`,
  bp.paymentType  AS `paymentType`,
  bp.paybackId AS `paybackId`,
  bp.serviceId AS `serviceId`,
bp.amount AS `amount (BasePayment)`,
s.name as service_name,
pos.name as pos_name,
COALESCE(tp.installment,p.installment) as Taksit
FROM odeal.BasePayment bp 
JOIN odeal.Organisation o
on o.id= bp.organisationId
JOIN subscription.Service s on s.id=bp.serviceId
JOIN odeal.POS pos ON pos.id=bp.posid 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Payment p ON p.id = bp.id
WHERE
	bp.amount >= 1
        and signedDate >='2024-01-01 00:00:00'
        and signedDate <=NOW()) as Islem
        GROUP BY Islem.pos_name, IF(Islem.Taksit>1,"Taksitli","Tek Çekim")
        
SELECT t.id, t.organisation_id, o.marka, o.unvan, t.serial_no, s.id, IF(s.status=1,"Aktif","Pasif") as AbonelikDurum, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum FROM odeal.Terminal t 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.serial_no IN ("2C50895224","2C50858379")  
        
SELECT bp.organisationId, bp.serviceId, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
WHERE bp.organisationId = 301216056
AND bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59"
GROUP BY bp.organisationId, bp.serviceId

SELECT t.organisation_id, t.serial_no, SUM(bp.amount) FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59" AND t.organisation_id = 301216056
GROUP BY t.organisation_id, t.serial_no

SELECT * FROM odeal.TerminalMerchantMappingHistory tmmh 
WHERE tmmh.merchant_id = 301216056

SELECT p.organisationId, p.paybackId, p.dueDate, DATE(p.dueDate) as GeriOdemeTarih, p.paidDate, p.amount, p.totalAmount, i.id, i.invoiceStatus, i.totalAmount as FaturaTutar FROM odeal.Payback p
LEFT JOIN subscription.PaymentReceipt pr ON pr.referenceId = p.id
LEFT JOIN subscription.Invoice i ON i.organisationId = p.organisationId
WHERE p.paybackId IN (
SELECT MAX(p.paybackId)
FROM odeal.Payback p
         JOIN odeal.BasePayment bp ON bp.paybackId = p.id
         LEFT JOIN subscription.PaymentReceipt pr ON pr.referenceId = p.id
         LEFT JOIN subscription.Invoice i ON p.organisationId = i.organisationId
         LEFT JOIN odeal.CutDetail cd ON cd.fixedPaybackId = p.id
         LEFT JOIN campaign.Bonus b ON b.paybackId = p.id
WHERE 
  pr.id IS NULL
  AND i.id IS NOT NULL
  AND p.creationDate > '2024-03-01 00:00:00'
  AND i.createdAt > '2024-03-01 00:00:00'
  AND bp._createdDate > '2024-03-01 00:00:00'
  AND b.id IS NULL
  AND i.createdAt < p.creationDate
  AND p.amount > 0
  AND cd.id IS NULL
  AND p.paymentStatus IN (4, 5, 1)
  AND i.invoiceStatus = 0
  AND p.notes NOT LIKE 'FRAUD%'
GROUP BY p.paybackId) AND i.invoiceStatus = 0

SELECT p.paybackId as PaybackID, p.organisationId as UyeID, p.dueDate, DATE(p.dueDate) as GeriOdemeTarih, p.amount as GeriOdemeEsasTutar,
COUNT(p.paybackId) OVER	(PARTITION BY p.organisationId) as Adet,
SUM(p.amount) OVER (PARTITION BY p.organisationId) as GeriOdemeTutar
FROM odeal.Payback p 
WHERE p.paybackId IN (
SELECT p.paybackId
FROM odeal.Payback p
         JOIN odeal.BasePayment bp ON bp.paybackId = p.id
         LEFT JOIN subscription.PaymentReceipt pr ON pr.referenceId = p.id
         LEFT JOIN subscription.Invoice i ON p.organisationId = i.organisationId
         LEFT JOIN odeal.CutDetail cd ON cd.fixedPaybackId = p.id
         LEFT JOIN campaign.Bonus b ON b.paybackId = p.id
WHERE -- p.organisationId IN (:organisationIds)
   pr.id IS NULL
  AND i.id IS NOT NULL
  AND p.creationDate > '2024-03-01 00:00:00'
  AND i.createdAt > '2024-03-01 00:00:00'
  AND bp._createdDate > '2024-03-01 00:00:00'
  AND b.id IS NULL
  AND i.createdAt < p.creationDate
  AND p.amount > 0
  AND cd.id IS NULL
  AND p.paymentStatus IN (4, 5, 1)
  AND i.invoiceStatus = 0
    AND p.notes NOT LIKE 'FRAUD%'
    GROUP BY p.paybackId)


45772566, 2776296

SELECT bp.organisationId, MAX(bp.signedDate), MAX(bp.`_createdDate`), SUM(bp.amount), MAX(bp.appliedRate), SUM((bp.amount*bp.appliedRate)/100) as BPamount, MAX(p.amount), MAX(p.totalAmount), MAX((p.totalAmount-p.amount))
as Fark, MAX(pr.amount), MAX(i.invoiceStatus), SUM(i.remainingAmount) FROM odeal.Payback p
JOIN odeal.BasePayment bp ON bp.paybackId = p.id
         LEFT JOIN subscription.PaymentReceipt pr ON pr.referenceId = p.id
         LEFT JOIN subscription.Invoice i ON p.organisationId = i.organisationId AND i.id = pr.invoiceId
WHERE p.id = 45772566
GROUP BY bp.organisationId, (bp.amount*bp.appliedRate)/100

SELECT * FROM subscription.PaymentReceipt pr 

SELECT MAX(p.paybackId) FROM odeal.Payback p 
GROUP BY p.organisationId 


select i.id as FaturaID, i.receiver as UyeIsyeri, i.sender, i.toAddress, i.fromAddress, i.phoneNumber, i.mail, i.city, i.totalAmount, 
i.totalVat, i.remainingAmount, i.description, i.paid, i.subscriptionId, i.organisationId,
i.period, i.periodStart, i.periodEnd, i.createdAt, i.invoiceStatus, i.`_createdDate`, i.`_lastModifiedDate`,
SUM(CASE WHEN i.description IS NULL THEN i.totalAmount END) OVER (PARTITION BY i.organisationId) as ToplamFaturaBedeli,
COUNT(CASE WHEN i.description IS NULL THEN i.id END) OVER (PARTITION BY i.organisationId) as FaturaAdet
from subscription.Invoice i
where date(period)>= '2021-01-01'
and i.remainingAmount > 0

SELECT bp.organisationId, p.id, t.serial_no, DATE_FORMAT(bp.signedDate,"%Y-%m")  as Ay, 
p.name, 
COUNT(bp.id) as Adet, 
SUM(bp.amount) as Toplam FROM odeal.BasePayment bp 
JOIN odeal.POS p ON p.id = bp.posId 
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.Payback p2 ON p2.id = bp.paybackId
WHERE bp.organisationId = 301067389 AND bp.currentStatus = 6 AND p2.id IS NULL
GROUP BY bp.organisationId, p.id, t.serial_no, bp.paybackId, p.name, DATE_FORMAT(bp.signedDate,"%Y-%m") 
ORDER BY Ay DESC

SELECT * FROM subscription.Invoice i WHERE i.organisationId = 301213215 AND i.invoiceStatus = 0

SELECT * FROM subscription.InvoiceItem ii WHERE ii.invoiceId = 2554833

SELECT * FROM odeal.Channel c WHERE c.name LIKE "%dinamik%"

SELECT 141.29 + 199 + 199 + 59.7

SELECT * FROM (
SELECT o.id, t.id as TerminalID, t.serial_no, t.firstActivationDate, t.terminalStatus, s.status, s.cancelledAt,
ROW_NUMBER() OVER (PARTITION BY t.serial_no ORDER BY o.id) as Sayi
FROM odeal.Terminal t
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE t.firstActivationDate <= "2024-03-31 23:59:59" AND (s.cancelledAt IS NULL OR s.cancelledAt > "2024-03-31 23:59:59")) as Terminaller WHERE Terminaller.Sayi > 1

SELECT * FROM odeal.POS p 

 SELECT bp.id, bp.signedDate, bp.posId, p2.name, bp.amount, p.installment, bp.serviceId FROM odeal.BasePayment bp 
LEFT JOIN odeal.Payment p ON p.id = bp.id 
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND p2.id IN (129,10) AND p.installment = 3
AND bp.signedDate >= DATE_SUB(NOW(),INTERVAL 604800 SECOND) AND bp.signedDate < NOW()


SELECT DATE_SUB(NOW(), INTERVAL 7 DAY)

 SELECT @Hafta_0 := "2024-04-19 10:21:52", 
@Hafta_1 := DATE_SUB(@Hafta_0,INTERVAL 7 DAY), 
@Hafta_2 := DATE_SUB(@Hafta_1,INTERVAL 7 DAY), 
@Hafta_3 := DATE_SUB(@Hafta_2,INTERVAL 7 DAY), 
@Hafta_4 := DATE_SUB(@Hafta_3,INTERVAL 7 DAY), 
@Hafta_5 := DATE_SUB(@Hafta_4,INTERVAL 7 DAY),
@Hafta_6 := DATE_SUB(@Hafta_5,INTERVAL 7 DAY),
@Hafta_7 := DATE_SUB(@Hafta_6,INTERVAL 7 DAY)

-- CEPTEPOS Banka Taksit İşlem Dağılım
SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, 
COUNT(*) as Hafta0_Adet, 
MAX(Hafta_1.Hafta1_Adet) as Hafta1_Adet, 
MAX(Hafta_2.Hafta2_Adet) as Hafta2_Adet,
MAX(Hafta_3.Hafta3_Adet) as Hafta3_Adet,
MAX(Hafta_4.Hafta4_Adet) as Hafta4_Adet,
MAX(Hafta_5.Hafta5_Adet) as Hafta5_Adet,
MAX(Hafta_6.Hafta6_Adet) as Hafta6_Adet 
FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta1_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_2 AND bp.signedDate < @Hafta_1
GROUP BY s.name, p.installment, p2.name) as Hafta_1 ON Hafta_1.Hizmet = s.name AND Hafta_1.Banka = p2.name AND Hafta_1.Taksit = p.installment
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta2_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_3 AND bp.signedDate < @Hafta_2
GROUP BY s.name, p.installment, p2.name) as Hafta_2 ON Hafta_2.Hizmet = s.name AND Hafta_2.Banka = p2.name AND Hafta_2.Taksit = p.installment
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta3_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_4 AND bp.signedDate < @Hafta_3
GROUP BY s.name, p.installment, p2.name) as Hafta_3 ON Hafta_3.Hizmet = s.name AND Hafta_3.Banka = p2.name AND Hafta_3.Taksit = p.installment
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta4_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_5 AND bp.signedDate < @Hafta_4
GROUP BY s.name, p.installment, p2.name) as Hafta_4 ON Hafta_4.Hizmet = s.name AND Hafta_4.Banka = p2.name AND Hafta_4.Taksit = p.installment
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta5_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_6 AND bp.signedDate < @Hafta_5
GROUP BY s.name, p.installment, p2.name) as Hafta_5 ON Hafta_5.Hizmet = s.name AND Hafta_5.Banka = p2.name AND Hafta_5.Taksit = p.installment
LEFT JOIN (SELECT s.name as Hizmet, p2.name as Banka, p.installment as Taksit, COUNT(*) as Hafta6_Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_7 AND bp.signedDate < @Hafta_6
GROUP BY s.name, p.installment, p2.name) as Hafta_6 ON Hafta_6.Hizmet = s.name AND Hafta_6.Banka = p2.name AND Hafta_6.Taksit = p.installment
WHERE bp.serviceId = 3 AND p2.name IS NOT NULL AND p.installment = 1 AND p2.id IN (14,160)
AND bp.signedDate >= @Hafta_1 AND bp.signedDate < @Hafta_0
GROUP BY s.name, p.installment, p2.name


SELECT bp.id, p.installment, bp.signedDate, bp.currentStatus, p2.id  FROM odeal.BasePayment bp
LEFT JOIN odeal.Payment p ON p.id = bp.id
LEFT JOIN odeal.POS p2 ON p2.id = bp.posId
WHERE bp.id IN (690085465,690103794)


 SELECT @Hafta_0 := "2024-04-19 10:21:52", 
@Hafta_1 := DATE_SUB(@Hafta_0,INTERVAL 7 DAY), 
@Hafta_2 := DATE_SUB(@Hafta_1,INTERVAL 7 DAY), 
@Hafta_3 := DATE_SUB(@Hafta_2,INTERVAL 7 DAY), 
@Hafta_4 := DATE_SUB(@Hafta_3,INTERVAL 7 DAY), 
@Hafta_5 := DATE_SUB(@Hafta_4,INTERVAL 7 DAY),
@Hafta_6 := DATE_SUB(@Hafta_5,INTERVAL 7 DAY),
@Hafta_7 := DATE_SUB(@Hafta_6,INTERVAL 7 DAY)

 SELECT IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit, 
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 0" THEN IslemAdet.Adet ELSE 0 END) as Hafta0_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 1" THEN IslemAdet.Adet ELSE 0 END) as Hafta1_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 2" THEN IslemAdet.Adet ELSE 0 END) as Hafta2_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 3" THEN IslemAdet.Adet ELSE 0 END) as Hafta3_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 4" THEN IslemAdet.Adet ELSE 0 END) as Hafta4_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 5" THEN IslemAdet.Adet ELSE 0 END) as Hafta5_Adet,
SUM(CASE WHEN IslemAdet.Hafta = "Hafta 6" THEN IslemAdet.Adet ELSE 0 END) as Hafta6_Adet 
FROM(
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 0" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_1 AND bp.signedDate < @Hafta_0
GROUP BY s.name, tp.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 1" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_2 AND bp.signedDate < @Hafta_1
GROUP BY s.name, tp.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 2" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_3 AND bp.signedDate < @Hafta_2
GROUP BY s.name, tp.installment, p2.name
UNION 
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 3" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE  bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_4 AND bp.signedDate < @Hafta_3
GROUP BY s.name, tp.installment, p2.name
UNION
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 4" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE  bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_5 AND bp.signedDate < @Hafta_4
GROUP BY s.name, tp.installment, p2.name
UNION 
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 5" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE  bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_6 AND bp.signedDate < @Hafta_5
GROUP BY s.name, tp.installment, p2.name
UNION 
SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 6" as Hafta, COUNT(*) as Adet FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.POS p2 on p2.id = bp.posId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId <> 3 AND p2.name IS NOT NULL
AND bp.signedDate >= @Hafta_7 AND bp.signedDate < @Hafta_6
GROUP BY s.name, tp.installment, p2.name) IslemAdet
GROUP BY IslemAdet.Hizmet, IslemAdet.Banka, IslemAdet.Taksit



SELECT s.name as Hizmet, p2.name as Banka, tp.installment as Taksit, "Hafta 0" as Hafta, bp.signedDate, bp.id, bp.currentStatus FROM odeal.BasePayment bp
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.POS p2 on p2.id = bp.posId
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.serviceId <> 3 AND p2.name IS NOT NULL AND p2.id = 121 AND tp.installment = 1
AND bp.signedDate >= @Hafta_1 AND bp.signedDate < @Hafta_0

SELECT bp.id, bp.signedDate, bp.paymentType, bp.amount, p.installment, p2.name FROM odeal.BasePayment bp 
LEFT JOIN odeal.Payment p ON p.id = bp.id 
LEFT JOIN odeal.POS p2 ON p2.id = bp.posId 
WHERE bp.currentStatus = 6 AND p.installment IS NULL AND bp.serviceId = 3 
AND p2.id = 5 AND bp.signedDate >= "2024-03-01 00:00:00"



SELECT s.name, DATE(bp.signedDate),COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-17 00:00:00" AND bp.signedDate <= "2024-04-17 23:59:59" AND bp.serviceId IN (5,7) AND bp.amount > 10000
GROUP BY s.name,DATE(bp.signedDate)
UNION
SELECT s.name, DATE(bp.signedDate), COUNT(bp.id), SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-18 00:00:00" AND bp.signedDate <= "2024-04-18 23:59:59" AND bp.serviceId IN (5,7) AND bp.amount > 10000
GROUP BY s.name, DATE(bp.signedDate)
UNION
SELECT s.name, DATE(bp.signedDate), COUNT(bp.id) as Adet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-19 00:00:00" AND bp.signedDate <= "2024-04-19 23:59:59" AND bp.serviceId IN (5,7) AND bp.amount > 10000
GROUP BY s.name, DATE(bp.signedDate)

SELECT o.id, o.marka, o.unvan, IF(o.isActivated=1,"AKTİF","PASİF"), m.phone as UyeDurum,
CASE WHEN o.businessType = 0 THEN "Bireysel" 
WHEN o.businessType = 1 THEN "Şahıs" 
WHEN o.businessType = 2 THEN "Tüzel" 
WHEN o.businessType = 3 THEN "Dernek vs" END as IsyeriTipi, o.vergiNo
FROM odeal.Organisation o
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id
WHERE o.demo = 0 and m.`role` = 0 AND m.phone = 5343943002

UNION 

SELECT s.name, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-13 00:00:00" AND bp.signedDate <= "2024-04-13 23:59:59" AND bp.serviceId = 5 AND bp.amount > 100000

UNION 
SELECT s.name, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-06 00:00:00" AND bp.signedDate <= "2024-04-06 23:59:59" AND bp.serviceId = 5

SELECT s.name, DAYNAME(DATE_FORMAT(bp.signedDate,"%Y-%m-%d")) as HaftaninGunu,  DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Gun, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro FROM odeal.BasePayment bp 
JOIN subscription.Service s ON s.id = bp.serviceId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-04-01 00:00:00" AND bp.signedDate <= "2024-04-22 23:59:59" AND bp.serviceId IN (5,7)
GROUP BY s.name, DATE_FORMAT(bp.signedDate,"%Y-%m-%d"), DAYNAME(DATE_FORMAT(bp.signedDate,"%Y-%m-%d"))

SELECT * FROM (
SELECT th.id, th.serialNo, th.physicalSerialId, th.`_createdDate`, 
ROW_NUMBER() OVER (PARTITION BY th.serialNo ORDER BY th.id) as Sira
FROM odeal.TerminalHistory th WHERE th.physicalSerialId IS NOT NULL) as Terminal WHERE Terminal.Sira = 1

SELECT Islemler.organisationId, COUNT(Islemler.id),SUM(Islemler.amount) FROM (
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
bp.posId, bp.signedDate, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon
 FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.signedDate >= "2024-03-01 00:00:00" AND
bp.signedDate <= "2024-03-31 23:59:59"
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
WHERE bp.currentStatus = 6 AND bp.serviceId <>3 AND bp.signedDate >= "2024-03-01 00:00:00" AND
bp.signedDate <= "2024-03-31 23:59:59"
) as Islemler WHERE Islemler.organisationId = 301216056


SELECT t.organisation_id, t.serial_no, t.channelId FROM odeal.Terminal t WHERE t.serial_no = "FT40004948"

SELECT *, DATEDIFF(firstActivationDate,`_lastModifiedDate`)  FROM odeal.OrganisationActivationInfo oai 

 -- Master Contact Tablosu
SELECT *, o._lastModifiedDate lastModifiedDate
FROM (
    SELECT
      m.id as EntityId,
      DATE_FORMAT(IF (m._lastModifiedDate > org._lastModifiedDate, m._lastModifiedDate, org._lastModifiedDate), '%Y-%m-%d %H:%i:%s') as _lastModifiedDate,
      JSON_OBJECT(
        'contact_key', m.id,
        'name', m.firstName,
        'surname', m.LastName,
        'gsm', IF(m.phone IS NULL, '', m.phone),
        'email', IF(m.email IS NULL, '', m.email),
        'birth_date', IF( DATE_FORMAT(m.birthDate, '%Y-%m-%d %H:%i:%s') IS NULL, '', m.birthDate),
        'gender', IF(m.gender IS NULL, '', m.gender),
        'activated_at', IF(org.activatedAt IS NULL, '', org.activatedAt),
        'city', IF(org.city IS NULL, '', org.city),
        'brand_name', IF(org.marka IS NULL, '', org.marka),
        'sector', IF(s.sector_name IS NULL,'',s.sector_name),
        'channel_name', IF(c.name IS NULL, '', c.name),
        'deactivation_date', IF(DATE_FORMAT(org.deActivatedAt, '%Y-%m-%d %H:%i:%s') IS NULL, '', org.deActivatedAt),
        'contact_status', CASE WHEN m.isActive = 0 THEN 'P' WHEN m.isActive = 1 THEN 'A' END,
        'merchant_id', m.organisationId,
        'is_activated', CASE WHEN org.isActivated = 1 THEN 'A' ELSE 'P' END,
        'contact_type', 'TACIR',
        'contact_role', CASE WHEN m.role = 0 THEN 'YETKILI' WHEN m.role = 1 THEN 'CALISAN' END) as metadata
    FROM odeal.Merchant m
    JOIN ( SELECT id, status
           FROM odeal.Merchant
           WHERE status IN (0, 1) ) x ON x.id = m.id
    JOIN odeal.Organisation org ON m.organisationId = org.id
    JOIN odeal.Channel c ON org.channelId = c.id
    LEFT JOIN odeal.Sector s ON s.id = org.sectorId) o
ORDER BY o._lastModifiedDate ASC


SELECT * FROM odeal.TerminalHistory th WHERE th.`_createdDate` IN (
SELECT MAX(th.`_createdDate`) FROM odeal.TerminalHistory th 
GROUP BY th.physicalSerialId) AND th.physicalSerialId = "6M700370"

SELECT * FROM odeal.TerminalHistory th WHERE th.physicalSerialId = "6M700370"

SELECT * FROM odeal.Channel c WHERE c.name LIKE "Dinamik%"


SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay,  o.id, c.name as TerminalKanal, c2.name as UyeKanal, t.serial_no, 
COUNT(bp.id) as IslemAdet, SUM(bp.amount) as IslemTutar FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
LEFT JOIN odeal.Channel c2 ON c2.id = o.channelId  
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-03-31 23:59:59" AND bp.paymentType <>4
AND (c.id = 213 OR c2.id = 213)
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), o.id,c.name, t.serial_no



