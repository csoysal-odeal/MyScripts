SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE s2.id = 3


SELECT o.id as UyeID, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum, s.id as AbonelikID, c2.name as UyeKanal, c.name as AbonelikKanal, s2.id, s2.name, p.name, p.commissionRates, UyeOzelKomisyon.UyeOzelKomisyon, BazKomisyon.BazKomisyon, Islem.SonIslemKomisyon FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId 
LEFT JOIN odeal.Channel c ON c.id = s.channelId 
LEFT JOIN odeal.Channel c2 ON c2.id = o.channelId
LEFT JOIN (SELECT ir.organisationId as UyeIsyeriID, 
(SELECT GROUP_CONCAT("Hizmet : ",s2.name," / Taksit : ",ir2.installment," / Komisyon Oran : ",ir2.comission) as UyeKomisyon FROM odeal.InstallmentRule ir2 
LEFT JOIN subscription.Service s2 ON s2.id = ir2.serviceId 
WHERE ir2.organisationId IS NOT NULL AND ir2.brandId = 27 AND ir2.status = 2 AND ir2.installment IN (0,1) AND ir2.organisationId = ir.organisationId) as TekCekimUyeKomisyon,
GROUP_CONCAT("Hizmet : ",s.name," / Taksit : ",ir.installment," / Komisyon Oran : ",ir.comission) as UyeOzelKomisyon, IF(ir.status=2,"Aktif","Pasif") as Durum FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.organisationId IS NOT NULL AND ir.brandId = 27 AND ir.status = 2
GROUP BY ir.organisationId, o.marka) as UyeOzelKomisyon ON UyeOzelKomisyon.UyeIsyeriID = o.id
LEFT JOIN (SELECT s.id as ServisID, s.name as Servis, 
(SELECT GROUP_CONCAT(" Taksit : ",ir2.installment," / Komisyon Oran : ",ir2.comission) as TekCekimKomisyon  FROM odeal.InstallmentRule ir2 
WHERE ir2.sectorId IS NULL 
AND ir2.planId IS NULL AND ir2.organisationId IS NULL AND ir2.installment IN (0,1)
AND ir2.serviceId IS NOT NULL AND ir2.status = 2 AND ir2.serviceId = ir.serviceId) as TekCekimBazKomisyon,
GROUP_CONCAT(" Taksit : ",ir.installment," / Komisyon Oran :  ",ir.comission) as BazKomisyon 
FROM odeal.InstallmentRule ir 
LEFT JOIN subscription.Service s ON s.id = ir.serviceId 
LEFT JOIN subscription.Plan p ON p.id = ir.planId
LEFT JOIN odeal.Terminal t ON t.id = ir.terminalId 
LEFT JOIN odeal.Organisation o ON o.id = ir.organisationId 
WHERE ir.sectorId IS NULL AND ir.planId IS NULL AND ir.organisationId IS NULL AND ir.serviceId IS NOT NULL AND ir.status = 2
GROUP BY s.id, s.name, ir.serviceId) AS BazKomisyon ON BazKomisyon.ServisID = s2.id
LEFT JOIN (SELECT bp.organisationId, p.installment as Taksit, MAX(bp.appliedRate) as SonIslemKomisyon, MAX(bp.signedDate) as SonIslemTarihi FROM odeal.BasePayment bp 
JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 
GROUP BY bp.organisationId, p.installment) as Islem ON Islem.organisationId = o.id
WHERE s2.id = 3 AND s.id IN (SELECT MAX(s.id) FROM odeal.Organisation o 
JOIN subscription.Subscription s ON s.organisationId = o.id 
JOIN subscription.Plan p ON p.id = s.planId
JOIN subscription.Service s2 ON s2.id = p.serviceId 
WHERE s2.id = 3
GROUP BY o.id) AND o.channelId = 24


SELECT * FROM odeal.Terminal t WHERE t.channelId = 316


SELECT o.id AS 'Üye İşyeri ID',
    p._createdDate,
    bp.isExternallyGenerated,
    o.unvan          AS 'Üye İşyeri Ünvan',
    o.marka          AS 'Marka',
    bp.id            AS 'Ödeme Key',
    bp.paymentId     AS 'Ödeme ID',
    t.serial_no      AS 'Seri No',
    bp.signedDate    AS 'İşlem Tarihi',
    bp.amount        AS 'İşlem Tutarı',
       bp.paybackAmount AS 'Net Tutar',
       bp.appliedRate   AS 'Komisyon Oranı',
    p.paybackId      AS 'Geri Ödeme ID',
    p.amount         AS 'Geri Ödeme Tutarı',
       p.dueDate        AS 'Geri Ödeme Tarihi',
       p.paidDate,
    pos.name         AS 'Banka',
    bp.cardNumber    AS 'Kart Numarası',
    bp._createdDate,
    bp.uniqueKey,
    bp.authCode      AS 'Banka Onay Kodu',
    CASE 
        WHEN p.paymentStatus = 0 THEN 'Bekliyor'
        WHEN p.paymentStatus = 1 THEN 'Ödendi'
        WHEN p.paymentStatus = 2 THEN 'İptal'
        WHEN p.paymentStatus = 3 THEN 'Ertelendi'
        WHEN p.paymentStatus = 4 THEN 'Ödeme Bekleniyor'
        WHEN p.paymentStatus = 5 THEN 'Gönderildi'
        WHEN p.paymentStatus = 6 THEN 'Geri Döndü' -- reddedildi
        WHEN p.paymentStatus = 7 THEN 'Bankada Olmayan'
        WHEN p.paymentStatus = 8 THEN 'Fraud'
    END AS 'Geri ödeme durumu',
        br.file_id,
        tp.posMerchantId    tid,
        tp.bankMerchantId,
        t.supplier 
    FROM odeal.Payback p
    JOIN odeal.Organisation o on o.id = p.organisationId
    LEFT JOIN odeal.Merchant m on m.organisationId = o.id AND m.role = 0
    JOIN odeal.BasePayment bp on bp.paybackId = p.id
    JOIN odeal.TerminalPayment tp on tp.id = bp.id
    JOIN odeal.Terminal t on t.id = tp.terminal_id
    LEFT JOIN odeal.BankInfo bi on bi.id = p.bankInfoId AND bi.status = 1
    JOIN odeal.POS pos on pos.id = bp.posId
    LEFT JOIN paymatch.bank_report br on br.unique_key = bp.uniqueKey
    LEFT JOIN odeal.Channel c on c.id = t.channelId
    WHERE t.channelId = '313'
    AND p.paidDate >= '2024-05-01 00:00:00' AND p.paidDate < CURDATE()
    ORDER BY p.paybackId ASC

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") AS YilAy, o.id, o.marka, IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, SUM(bp.amount) AS Ciro, COUNT(bp.id) AS IslemAdet FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
WHERE t.channelId = 213 AND o.id = 301088093
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), o.id, o.marka, IF(o.isActivated=1,"Aktif","Pasif");

SELECT t.serial_no as MaliNo, t.id as TerminalID, t.organisation_id as UyeID, t.firstActivationDate as IlkAktivasyonTarihi, COUNT(bp.id) as IslemAdet, SUM(bp.amount) as Ciro FROM odeal.Terminal t 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-03-01 00:00:00" AND bp.signedDate <= NOW()
WHERE t.firstActivationDate >= "2024-03-01 00:00:00"
GROUP BY t.serial_no, t.id, t.organisation_id, t.firstActivationDate

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m") as Ay, o.id, s.name, bp.paymentType, bp.appliedRate, SUM(bp.amount) FROM odeal.Organisation o 
JOIN odeal.BasePayment bp ON bp.organisationId = o.id 
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2023-01-01 00:00:00" AND o.id IN (301133028,
301207776,
301121745,
301219296,
301079659,
301154450,
301220448,
301216056,
301213842,
301220976,
301132665,
301169714,
301232424,
301200290,
301053033,
301035751,
301192685,
301143394,
301146044,
301153036,
301124076,
301135388,
301158818,
301220565)
GROUP BY DATE_FORMAT(bp.signedDate,"%Y-%m"), o.id, s.name, bp.paymentType, bp.appliedRate

SELECT * FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 

SELECT * FROM stargate.WorkOrderLog wol WHERE wol.WorkOrderNo = "533061864cc1e7a46"

SELECT bp.organisationId, p.installment as Taksit, MAX(bp.appliedRate) as SonIslemKomisyon, MAX(bp.signedDate) as SonIslemTarihi FROM odeal.BasePayment bp 
JOIN odeal.Payment p ON p.id = bp.id
WHERE bp.serviceId = 3 AND bp.currentStatus = 6 
GROUP BY bp.organisationId, p.installment

SELECT c.name AS Kanal, o.id AS UyeID, o.marka AS Marka, t.serial_no AS MaliNo,
IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum, IF(t.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum,
s.id AS AbonelikID, p.name AS Plan, s2.name AS Hizmet,
bp.id as IslemId, bp.signedDate as IslemTarihi, bp.amount as IslemTutar, 
bp.appliedRate as Komisyon, 
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
END as PaymentTipi
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-05-01 00:00:00" AND bp.signedDate <= NOW()
JOIN subscription.Subscription s ON s.id = t.subscription_id AND s.status = 1
JOIN subscription.Plan p ON p.id = s.planId 
JOIN subscription.Service s2 ON s2.id = p.serviceId
JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.channelId = 313;


-- Merkez Bankası
SELECT o.id as UyeID, 
o.unvan as Unvan, 
o.marka as Marka, 
o.activatedAt as UyeAktivasyonTarihi, 
o.deActivatedAt as UyeDeaktivasyonTarihi,
o.vergiNo, o.address, t.name as Ilce, c.name as Sehir,
IF(o.isActivated=1,"AKTİF","PASİF") as UyeDurum, 
CONCAT(m.firstName," ",m.LastName) as Yetkili, 
m.tckNo as TCKNo, 
m.phone as Telefon, 
m.email as Email,
s2.sector_name as Sektor,
bp.id as IslemID, 
bp.signedDate as IslemTarihi, 
IF(bp.currentStatus=6,"BAŞARILI","BAŞARISIZ") as IslemDurum, 
bp.amount as IslemTutar, 
bp.appliedRate as IslemKomisyonu, 
bp.paybackAmount as GeriOdemeyeEsasTutar,
FORMAT((bp.amount * (bp.appliedRate/100)),2) as KomisyonTutar, s.name as Hizmet, 
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
END as PaymentTipi
FROM odeal.BasePayment bp 
JOIN odeal.Organisation o ON o.id = bp.organisationId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.`role` = 0
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t ON t.id = o.townId
LEFT JOIN subscription.Service s ON s.id = bp.serviceId
LEFT JOIN odeal.Sector s2 ON s2.id = o.sectorId
WHERE bp.signedDate >= "2024-06-01 00:00:00" AND bp.signedDate <= "2024-06-01 23:59:59" AND bp.paymentType IN (0,1,2,3,6,7,8)

SELECT * FROM payout_source.card_transaction ct 


SELECT CONCAT(m.firstName," ",m.LastName) as Yetkili, m.phone as Telefon, m.organisationId FROM odeal.Merchant m WHERE m.role = 0


SELECT * FROM odeal.Organisation o WHERE o.id = 301002578


