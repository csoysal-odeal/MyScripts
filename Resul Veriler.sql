SELECT o.id as IsyeriID, o.marka as Marka, o.address as Adres, c.name as Il, t.name as Ilce, o.longitude as OrgBoylam, o.latitude as OrgEnlem, t2.serial_no, t2.model,
c2.name as KurulumTerminalSehir, t3.name as KurulumTerminalIlce, t2.setupAddress,
bp.id as IslemID, bp.amount as Tutar, bp.signedDate as Tarih, 
bp.longitude as IslemBoylam, bp.latitude as IslemEnlem, s3.name as Servis, p.name as Plan, a.name as Model FROM odeal.Organisation o 
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t ON t.id = o.townId 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t2 ON t2.id = tp.terminal_id
LEFT JOIN odeal.City c2 ON c2.id = t2.setupCityId 
LEFT JOIN odeal.Town t3 ON t3.id = t2.setupTownId 
JOIN subscription.Subscription s2 ON s2.id = t2.subscription_id
JOIN subscription.Plan p ON p.id = s2.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId 
JOIN subscription.Addon a ON a.id = p.addonId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-11-01 00:00:00" 
AND bp.signedDate <= "2023-11-30 23:59:59" 
AND bp.paymentType = 7
AND bp.serviceId = 7
UNION
SELECT o.id as IsyeriID, o.marka as Marka, o.address as Adres, c.name as Il, t.name as Ilce, o.longitude as OrgBoylam, o.latitude as OrgEnlem, t2.serial_no, t2.model,
c2.name as KurulumTerminalSehir, t3.name as KurulumTerminalIlce, t2.setupAddress,
bp.id as IslemID, bp.amount as Tutar, bp.signedDate as Tarih, 
bp.longitude as IslemBoylam, bp.latitude as IslemEnlem, s3.name as Servis, p.name as Plan, a.name as Model FROM odeal.Organisation o 
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t ON t.id = o.townId 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t2 ON t2.id = tp.terminal_id
LEFT JOIN odeal.City c2 ON c2.id = t2.setupCityId 
LEFT JOIN odeal.Town t3 ON t3.id = t2.setupTownId 
JOIN subscription.Subscription s2 ON s2.id = t2.subscription_id
JOIN subscription.Plan p ON p.id = s2.planId
JOIN subscription.Service s3 ON s3.id = p.serviceId 
JOIN subscription.Addon a ON a.id = p.addonId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-11-01 00:00:00" 
AND bp.signedDate <= "2023-11-30 23:59:59" 
AND bp.paymentType = 7
AND bp.serviceId = 5

SELECT * FROM information_schema.COLUMNS c
WHERE c.COLUMN_NAME LIKE "%bkm%"

    CARD(0, "Kartlı Ödeme"),
    ODEAL_PHONE(1, "Kredi Kartı / Banka Kartı / Ceptepos"),
    ODEAL_CLIENT(2, "Kredi Kartı / Banka Kartı / Terminal"),
    MERCHANT_3D(3, "Kredi Kartı / Banka Kartı / 3D Ödme"),
    POS(4, "Nakit"),
    BKM(5, "BKM Express"),
    RECURRING(6, "Tekrarlı Ödeme"),
    TERMINAL(7, "Kredi Kartı / Banka Kartı"),
    TECHPOS(8, "Kredi Kartı / Banka Kartı"),
    ISTANBULKART(9, "Istanbul Kart"),
    GIFT(10, "Hediye Kartı"),
    BOND(11, "Senet"),
    CHECKS(12, "Çek"),
    OPEN_ACCOUNT(13, "Açık Hesap"),
    ON_CREDIT(14, "Kredili"),
    MONEY_TRANSFER(15, "Havale/Eft"),
    FOOD_CARD(16, "Yemek Kartı/Çeki"),
    CITY_CARD(17, "Belediye Ulaşım Kartları, Yardım Kartları ve Çekleri"


SELECT t.organisation_id, t.serial_no, bp.signedDate, bp.id, bp.amount,
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
bp.appliedRate, tp.installment, s.name FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 AND bp.appliedRate IS NULL AND bp.signedDate >= "2023-12-19 00:00:00" AND bp.signedDate <= "2023-12-19 23:59:59"
AND t.serial_no IN ('PAX710017188',
'PAX710027116',
'PAX710006984',
'PAX710009110',
'PAX710041642',
'PAX710021558',
'PAX710011043',
'PAX710012146',
'PAX710016085',
'PAX710012250',
'PAX710012379',
'PAX710015994',
'PAX710014507',
'PAX710015064',
'PAX710016033',
'PAX710016074',
'PAX710016807',
'PAX710026610',
'PAX710026570',
'PAX710028882',
'PAX710029417',
'PAX710030161',
'PAX710028178',
'PAX710041884',
'PAX710035358',
'PAX710034993',
'PAX710035133',
'PAX710035132',
'PAX710035923',
'PAX710035924',
'PAX710041195')

SELECT o.id, o.marka, o.unvan, CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
WHERE o.id IN (301194566,301202922,301137110,301202109,301242482,301241639,301017320,301242674,301238228,301227321,301192550,301234730,301212249,
301031660,301241867,301227492,301181951,301085085,301182305,301044472,301029762,301163672,301231695,301025238,301100388,301238768,301187111,301214622,301233108,
301128966,301081009,301191101,301241561,301242674,301223886,301036400,301111891,301217574,301166482,301243097,301196981,301172246,301241558,301012490,301150052,
301241234,301169162,301234730,301222806,301002172,301169026,301142866)

SELECT * FROM odeal.Terminal t 

SELECT o.id, m.phone FROM odeal.Organisation o 
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id
WHERE o.id = 301243097

SELECT bp.id, t.serial_no, bp.amount, bp.paymentType, bp.serviceId, bp.appliedRate, bp.signedDate, bp.paybackId FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
WHERE bp.id = 639119264 AND bp.currentStatus = 6

SELECT * FROM odeal.PaymentMetaData pmd 
WHERE pmd.payment_id = 617420359

SELECT bp.id, t.serial_no, s.id, p.name, a.name FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
JOIN subscription.Subscription s ON s.id = t.subscription_id 
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Addon a ON a.id = p.addonId
WHERE bp.id = 630016331

SELECT * FROM odeal.Channel c 

SELECT Envelope.envelope_status, Envelope.type, COUNT(*) as StatuAdet FROM (
SELECT * FROM odeal.MerchantEnvelopeHistory meh WHERE meh.id IN (
SELECT MAX(meh.id) FROM odeal.MerchantEnvelopeHistory meh 
GROUP BY meh.merchant_id, meh.identifier_no, meh.`type` ) 
ORDER BY meh.id DESC) as Envelope
GROUP BY Envelope.envelope_status, Envelope.type




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
	and bp.signedDate is not null and cancelDate is null
        and DATE_FORMAT(bp.signedDate, '%Y-%m-%d')>='2017-01-01'
        and bp.signedDate <=NOW()
        
        
        SELECT * FROM odeal.Channel c 