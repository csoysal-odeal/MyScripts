 SELECT * FROM (
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, bp.cardNumber, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon, (SELECT bi.cardType FROM odeal.BinInfo bi WHERE bi.bin = substr(bp.cardNumber, 1, 6)) as KartTipi
FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.serviceId = 3
AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01") AND
bp.signedDate <= CURDATE()
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi,
tp.installment, bp.cardNumber, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon, (SELECT bi.cardType FROM odeal.BinInfo bi WHERE bi.bin = substr(bp.cardNumber, 1, 6)) as KartTipi
 FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8)
AND bp.serviceId IN (2,4,5,7) AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01") AND
bp.signedDate <= CURDATE()
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi, bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, "KARTTANIBANATRANSFER" as AbonelikID,
o.id as SerialNo, "KARTTANIBANATRANSFER" as Tedarikci,  "KARTTANIBANATRANSFER" as AktivasyonTarihi, p.installment,
IF(p.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, bp.cardNumber, "KARTTANIBANATRANSFER" as Kanal, "KARTTANIBANATRANSFER" as Cihaz,
"KARTTANIBANATRANSFER" as Plan, "KARTTANIBANATRANSFER" as PlanKomisyon, (SELECT bi.cardType FROM odeal.BinInfo bi WHERE bi.bin = substr(bp.cardNumber, 1, 6)) as KartTipi
FROM odeal.BasePayment bp
LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0
LEFT JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.currentStatus = 6 AND bp.paymentType = 18
AND bp.serviceId = 8 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 2 MONTH), "%Y-%m-01") AND
bp.signedDate <= CURDATE()
) as Islemler



-- Tüm işlemler Detaylı
SELECT * FROM (
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%Y-%m") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp
    as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon, bi.bankName as KartBankasi, bi.cardType as KartTipi, bi.brand as KartMarkasi
FROM odeal.BasePayment bp
LEFT JOIN odeal.BinInfo bi ON bi.bin = SUBSTR(bp.cardNumber,1,6)
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.serviceId = 3
AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%Y-%m") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, s.id as AbonelikID,
t.serial_no as SerialNo, t.supplier as Tedarikci,  t.firstActivationDate as AktivasyonTarihi,
tp.installment, IF(tp.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon, bi.bankName as KartBankasi, bi.cardType as KartTipi, bi.brand as KartMarkasi
 FROM odeal.BasePayment bp
LEFT JOIN odeal.BinInfo bi ON bi.bin = SUBSTR(bp.cardNumber,1,6)
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8)
AND bp.serviceId IN (2,4,5,7) AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi, bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%Y-%m") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, "KARTTANIBANATRANSFER" as AbonelikID,
o.id as SerialNo, "KARTTANIBANATRANSFER" as Tedarikci,  "KARTTANIBANATRANSFER" as AktivasyonTarihi, p.installment,
IF(p.installment>1, "Taksitli" , "Tek Çekim") as TaksitDurum, "KARTTANIBANATRANSFER" as Kanal, "KARTTANIBANATRANSFER" as Cihaz,
"KARTTANIBANATRANSFER" as Plan, "KARTTANIBANATRANSFER" as PlanKomisyon, bi.bankName as KartBankasi, bi.cardType as KartTipi, bi.brand as KartMarkasi
FROM odeal.BasePayment bp
LEFT JOIN odeal.BinInfo bi ON bi.bin = SUBSTR(bp.cardNumber,1,6)
LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId AND o.demo = 0
LEFT JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.currentStatus = 6 AND bp.paymentType = 18
AND bp.serviceId = 8 AND bp.signedDate BETWEEN "2022-11-01 00:00:00" AND "2022-11-30 23:59:59"
) as Islemler

SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 0 MONTH), "%Y-%m-01")

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
    WHEN bp.paymentType = 18 THEN "Kart'tan IBAN'a Transfer"
END as PaymentTipi,
bp.posId, bp.signedDate, DATE_FORMAT(bp.signedDate, "%m %Y") as YilAy, bp.appliedRate, bp.amount, bp.serviceId, Abonelik.id as AbonelikID,
bp.organisationId as SerialNo, "CeptePos" as Tedarikci, Abonelik.`_createdDate` as AktivasyonTarihi, p2.installment, IF(p2.installment>1,"Taksitli" , "Tek Çekim") as TaksitDurum, c2.name as Kanal, p.addonId as Cihaz,
p.name as Plan, p.commissionRates as PlanKomisyon, bi.bankName as KartBankasi, bi.cardType as KartTipi, bi.brand as KartMarkasi
FROM odeal.BasePayment bp
LEFT JOIN odeal.BinInfo bi ON bi.bin = SUBSTR(bp.cardNumber,1,6)
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.serviceId = 3
AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY), "%Y-%m-%d") AND
bp.signedDate <= NOW()



SELECT * FROM odeal.BasePayment bp WHERE bp.organisationId = 301050929
AND bp.signedDate >= "2020-01-01 00:00:00" AND bp.signedDate <= "2020-12-31 23:59:59" AND bp.currentStatus = 6;


SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 0 MONTH),"%Y-%m-01 00:00:00")

SELECT Islemler.UyeID, GROUP_CONCAT(Islemler.SerialNo) as Cihazlar, MIN(Islemler.IlkIslemTarih) as IlkIslemTarih, MAX(Islemler.SonIslemTarih) as SonIslemTarih,
       SUM(CASE WHEN Islemler.Hizmet = 3 THEN Islemler.Ciro END) as Ceptepos_Ciro,
       SUM(CASE WHEN Islemler.Hizmet = 3 THEN Islemler.IslemAdet END) as Ceptepos_IslemAdet,
       SUM(CASE WHEN Islemler.Hizmet <> 3 THEN Islemler.Ciro END) as Fiziki_Ciro,
       SUM(CASE WHEN Islemler.Hizmet <> 3 THEN Islemler.IslemAdet END) as Fiziki_IslemAdet,
       SUM(Islemler.Ciro) as ToplamCiro,
       SUM(Islemler.IslemAdet) as ToplamIslemAdet
FROM (
SELECT bp.organisationId as UyeID, t.serial_no as SerialNo,
COUNT(bp.id) as IslemAdet,
SUM(bp.amount) as Ciro,
MIN(bp.signedDate) as IlkIslemTarih,
MAX(bp.signedDate) as SonIslemTarih,
bp.serviceId as Hizmet
FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.Channel c2 ON c2.id = t.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8)
AND bp.serviceId IN (2,4,5,7) AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), "%Y-%m-01") AND
bp.signedDate <= CURDATE()
GROUP BY bp.organisationId, bp.serviceId, t.serial_no
UNION
SELECT bp.organisationId as UyeID, Abonelik.id as SerialNo,
COUNT(bp.id) as IslemAdet,
SUM(bp.amount) as Ciro,
MIN(bp.signedDate) as IlkIslemTarih,
MAX(bp.signedDate) as SonIslemTarih,
bp.serviceId as Hizmet
FROM odeal.BasePayment bp
JOIN (SELECT * FROM subscription.Subscription s WHERE s.id IN (
SELECT MAX(s.id) FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as Abonelik ON Abonelik.organisationId = bp.organisationId
JOIN subscription.Plan p ON p.id = Abonelik.planId
LEFT JOIN odeal.Payment p2 ON p2.id = bp.id
LEFT JOIN odeal.Channel c2 ON c2.id = Abonelik.channelId
WHERE bp.currentStatus = 6 AND bp.paymentType IN (0,1,2,3,7,8) AND bp.serviceId = 3
AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), "%Y-%m-01") AND
bp.signedDate <= CURDATE()
GROUP BY bp.organisationId, bp.serviceId, Abonelik.id
) as Islemler
GROUP BY Islemler.UyeID, Islemler.SerialNo


SELECT * FROM subscription.Invoice i order by i._createdDate DESC LIMIT 10

SELECT o.id, t.serial_no,
       SUM(CASE WHEN bp.serviceId = 8 AND bp.paymentType = 18 THEN bp.amount END) as NakiteDonusen,
       SUM(CASE WHEN bp.serviceId = 3 AND bp.paymentType IN (0,1,2,3,7,8) THEN bp.amount END) as CeptePos,
       SUM(bp.amount) as Ciro, COUNT(bp.id) as Adet
FROM odeal.Organisation o
LEFT JOIN odeal.BasePayment bp ON bp.organisationId = o.id
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 WEEK), "%Y-%m-01") AND
bp.signedDate <= NOW() AND o.demo = 0
GROUP BY o.id, t.serial_no

SELECT CeptePos.organisationId,
       SUM(CASE WHEN CeptePos.IslemTipi = "3D İşlem Alanlar" THEN CeptePos.Adet END) as 3DIslemAlan,
       SUM(CASE WHEN CeptePos.IslemTipi = "3D İşlem Almayanlar" THEN CeptePos.Adet END) as 3DIslemAlmayan
FROM (
SELECT bp.organisationId, "3D İşlem Alanlar" as IslemTipi, COUNT(*) as Adet FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6
AND bp.serviceId = 3
AND bp.signedDate >= "2024-09-01 00:00:00" AND bp.signedDate <= "2024-09-30 23:59:59"
AND bp.paymentType IN (1,3)
GROUP BY bp.organisationId
UNION
SELECT bp.organisationId, "3D İşlem Almayanlar" as IslemTipi, COUNT(*) as Adet FROM odeal.BasePayment bp
WHERE bp.currentStatus = 6
AND bp.serviceId = 3
AND bp.signedDate >= "2024-09-01 00:00:00" AND bp.signedDate <= "2024-09-30 23:59:59"
AND bp.paymentType NOT IN (1,3)
GROUP BY bp.organisationId) as CeptePos
GROUP BY CeptePos.organisationId;


SELECT o.id, t.serial_no, s.id FROM odeal.Organisation o
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE o.id = 301264283

SELECT t.organisation_id as UyeID, sh.terminalId as TerminalID, t.serial_no as MaliNo, sh.currentPeriodStart as Baslangic, sh.currentPeriodEnd as Bitis, p.id as PlanID, p.name as Plan, sh._createdDate as PlanOlusmaTarihi, p.amount as AbonelikBedeli, ser.name as Hizmet,
IF(p.vadeli>0,"Vadeli","Peşin") as PlanVadeDurum, IF(p.taksitli>0,"Taksitli","Tek Çekim") as PlanTaksitDurum, p.tag as Kampanya, p.commissionRates as PlanKomisyonu
FROM subscription.SubscriptionHistory sh
         LEFT JOIN subscription.Plan p ON p.id = sh.planId
         LEFT JOIN subscription.Service ser ON ser.id = p.serviceId
         LEFT JOIN odeal.Terminal t ON t.id = sh.terminalId
         WHERE sh.id IN (
SELECT MIN(sh.id) FROM subscription.SubscriptionHistory sh WHERE sh.subscriptionId = 917473
GROUP BY sh.terminalId, sh.subscriptionId, sh.planId)

SELECT DATE_FORMAT(CURDATE() , "%Y-%m-%d")

SELECT * FROM payout_source.source_history sh WHERE sh.id IN (
SELECT MAX(sh.id) FROM payout_source.source_history sh
WHERE sh.type = "FIBACARD" AND sh.reason = "AÇIK" AND sh.status = "ACTIVATED"
GROUP BY sh.account_no);

SELECT t.organisation_id, t.serial_no, bp.appliedRate, MIN(bp.signedDate) as IlkIslemTarihi, MAX(bp.signedDate) as SonIslemTarihi, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.Terminal t
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = s.planId
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND bp.appliedRate = 1.99 AND bp.signedDate >= "2024-01-01 00:00:00" AND t.id IN (SELECT ir.terminalId FROM odeal.InstallmentRule ir WHERE ir.comission = 1.99)
GROUP BY t.organisation_id, t.serial_no

SELECT * FROM odeal.InstallmentRule ir
         WHERE ir.comission = 1.9900 AND ir.status = 0
            OR (ir.terminalId IS NOT NULL AND ir.comission = 1.9900)

SELECT *, (SELECT COUNT(*) FROM odeal.Terminal t WHERE t.organisation_id = ir.organisationId) as Adet FROM odeal.InstallmentRule ir
LEFT JOIN (SELECT ir.terminalId as TerminalID, t.serial_no as SerialNo, t.organisation_id as UyeID, ir.installment as Taksit, ir.comission as Komisyon FROM odeal.InstallmentRule ir
         LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.terminalId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 0 AND ir.comission = 1.9900
         GROUP BY ir.terminalId)) as TerminalKomisyon ON TerminalKomisyon.UyeID = ir.organisationId
         WHERE ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.organisationId IS NOT NULL
           AND ir.serviceId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 0 AND ir.comission = 1.9900
         GROUP BY ir.organisationId);

SELECT ir.terminalId as TerminalID, t.serial_no as SerialNo, t.organisation_id as UyeID, ir.installment as Taksit, ir.comission as Komisyon FROM odeal.InstallmentRule ir
         LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE t.serial_no = "PAX710023476" AND ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.terminalId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 0 AND ir.comission = 1.9900
         GROUP BY ir.terminalId);

SELECT t.organisation_id, t.serial_no, t.firstActivationDate, t.deactivationDate, IF(t.terminalStatus=1,"Aktif","Pasif") as TerminalDurum FROM odeal.Terminal t

SELECT t.id, t.serial_no, p.name, p.tag, p.commissionRates, p.commissionRate FROM odeal.Terminal t
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
LEFT JOIN subscription.Plan p ON p.id = s.planId
WHERE t.serial_no = "PAX710023476"

SELECT * FROM odeal.InstallmentRule ir WHERE ir.terminalId =217188;

SELECT COUNT(*) FROM odeal.Terminal t
         WHERE t.organisation_id = 301164048
GROUP BY t.organisation_id;

SELECT t.organisation_id, t.serial_no, t.id, p.name, Kampanya.UyeKomisyon, Kampanya.TerminalKomisyon, bp.appliedRate, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro,
       MIN(bp.signedDate) as IlkIslemTarihi, MAX(bp.signedDate) as SonIslemTarihi FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN subscription.Subscription sub ON sub.id = t.subscription_id
LEFT JOIN subscription.Plan p ON p.id = sub.planId
LEFT JOIN (SELECT t.organisation_id, t.id, t.serial_no,Komisyon.UyeKomisyon, Komisyon.UyeTaksit, Komisyon.TerminalKomisyon, Komisyon.TerminalTaksit
      FROM odeal.Terminal t
JOIN (SELECT ir.organisationId, TerminalKomisyon.Komisyon as TerminalKomisyon, ir.comission as UyeKomisyon, ir.installment as UyeTaksit, TerminalKomisyon.Taksit as TerminalTaksit, (SELECT COUNT(*) FROM odeal.Terminal t WHERE t.organisation_id = ir.organisationId) as Adet
      FROM odeal.InstallmentRule ir
LEFT JOIN (SELECT ir.terminalId as TerminalID,
                  t.serial_no as SerialNo,
                  t.organisation_id as UyeID,
                  ir.installment as Taksit,
                  ir.comission as Komisyon
         FROM odeal.InstallmentRule ir
         LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE ir.status = 0 AND ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.terminalId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 0 AND ir.comission = 1.9900 AND ir.status = 0
         GROUP BY ir.terminalId)) as TerminalKomisyon ON TerminalKomisyon.UyeID = ir.organisationId
         WHERE ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.organisationId IS NOT NULL
           AND ir.serviceId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 0 AND ir.comission = 1.9900 AND ir.status = 0
         GROUP BY ir.organisationId)) as Komisyon ON Komisyon.organisationId = t.organisation_id
ORDER BY t.organisation_id) as Kampanya ON Kampanya.id = t.id AND Kampanya.organisation_id = t.organisation_id
WHERE bp.currentStatus = 6 AND bp.paymentType <> 4 AND t.serial_no = "BCJ00064033"
GROUP BY t.organisation_id, t.serial_no, t.id, p.name, bp.appliedRate, Kampanya.UyeKomisyon, Kampanya.TerminalKomisyon;

SELECT * FROM odeal.Terminal

SELECT p.name, p.commissionRates FROM subscription.Plan p WHERE p.commissionRates IS NOT NULL


SELECT t.organisation_id,
       t.id,
       t.serial_no,
       Komisyon.UyeKomisyon,
       Komisyon.UyeTaksit,
       Komisyon.TerminalKomisyon,
       Komisyon.TerminalTaksit
      FROM odeal.Terminal t
LEFT JOIN (SELECT ir.organisationId, TerminalKomisyon.TerminalID, TerminalKomisyon.Komisyon as TerminalKomisyon, ir.comission as UyeKomisyon, ir.installment as UyeTaksit, TerminalKomisyon.Taksit as TerminalTaksit, (SELECT COUNT(*) FROM odeal.Terminal t WHERE t.organisation_id = ir.organisationId) as Adet
      FROM odeal.InstallmentRule ir
      LEFT JOIN (SELECT ir.terminalId as TerminalID,
                  t.serial_no as SerialNo,
                  t.organisation_id as UyeID,
                  ir.installment as Taksit,
                  ir.comission as Komisyon
         FROM odeal.InstallmentRule ir
         LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE ir.status = 2 AND ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.terminalId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 2
         GROUP BY ir.terminalId)) as TerminalKomisyon ON TerminalKomisyon.UyeID = ir.organisationId
         WHERE ir.id IN (
SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.organisationId IS NOT NULL
           AND ir.serviceId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 2
         GROUP BY ir.organisationId)) as Komisyon ON Komisyon.organisationId = t.organisation_id AND Komisyon.TerminalID = t.id
      WHERE t.serial_no = "BCJ00064033"
ORDER BY t.organisation_id

SELECT ir.terminalId as TerminalID,
                  t.serial_no as SerialNo,
                  t.organisation_id as UyeID,
                  ir.installment as Taksit,
                  ir.comission as Komisyon
         FROM odeal.InstallmentRule ir
         LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE ir.status = 2 AND ir.id IN (
        SELECT MAX(ir.id) FROM odeal.InstallmentRule ir
         WHERE ir.terminalId IS NOT NULL
           AND ir.installment IN (0,1)
           AND ir.status = 2
         GROUP BY ir.terminalId) AND t.serial_no = "BCJ00064033";

-- Üyeye Özel Komisyon
SELECT ir.id, ir.organisationId, ir.terminalId, ir.comission, ir.status, ir._createdDate FROM odeal.InstallmentRule ir
         WHERE ir.comission = 1.99
           AND ir.organisationId IS NOT NULL
           AND ir.serviceId IS NOT NULL
           AND ir.status = 2
           AND ir.installment = 1;

-- Terminale Özel Komisyon
SELECT ir.id,
       t.organisation_id,
       t.serial_no,
       o.marka,
       o.unvan,
       o.activatedAt,
       IF(o.isActivated=0,"Pasif","Aktif") as UyeDurum,
       IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
       ir.terminalId,
       ir.comission,
       IF(ir.status=0,"Pasif","Aktif") as KomisyonStatus,
       ir._createdDate,
       bp.amount as Ciro,
       bp.id as IslemID,
       bp.signedDate as IslemTarihi
       FROM odeal.InstallmentRule ir
         JOIN odeal.Terminal t ON t.id = ir.terminalId
         JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
         JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
         JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.paymentType <> 4 AND bp.signedDate >= ir._createdDate
         WHERE ir.comission = 1.99
           AND ir.organisationId IS NULL
           AND ir.terminalId IS NOT NULL
           AND ir.serviceId IS NULL
           AND ir.status = 2
           AND ir.installment = 1;


SELECT * FROM odeal.Organisation o WHERE o.marka LIKE "%mobilport%"

SELECT * FROM payout_source.source s WHERE s.merchant_id = 301011013

SELECT ir.id, "TerminalOzel" as KomisyonDurum, t.organisation_id, ir.terminalId, ir.comission, ir.status, ir._createdDate FROM odeal.InstallmentRule ir
         JOIN odeal.Terminal t ON t.id = ir.terminalId
         WHERE ir.comission = 1.99
           AND ir.organisationId IS NULL
           AND ir.terminalId IS NOT NULL
           AND ir.serviceId IS NULL
           AND ir.status = 2
           AND ir.installment = 1
UNION
SELECT ir.id, "UyeyeOzel" as KomisyonDurum, ir.organisationId, ir.terminalId, ir.comission, ir.status, ir._createdDate FROM odeal.InstallmentRule ir
         WHERE ir.comission = 1.99
           AND ir.organisationId IS NOT NULL
           AND ir.serviceId IS NOT NULL
           AND ir.status = 2
           AND ir.installment = 1


SELECT bp.organisationId, bp.serviceId, COUNT(bp.id), SUM(bp.amount), bp.appliedRate, MAX(bp.signedDate)
FROM odeal.BasePayment bp WHERE bp.currentStatus = 6 AND bp.serviceId = 3 AND bp.appliedRate = 1.99 AND bp.signedDate >="2024-01-01 00:00:00"
GROUP BY bp.organisationId, bp.serviceId, bp.appliedRate

SELECT * FROM odeal.BasePayment bp WHERE bp.serviceId = 3 AND bp.currentStatus = 6 LIMIT 2