SELECT o.id as UyeIsyeriKey,
       o.marka as UyeIsyeri,
       CONCAT(m.firstName," ",m.LastName) as IlgiliKisi,
       t.serial_no as MaliNo,
       bp.id as OdemeKey,
       bp.paymentId as OdemeID,
       bp.amount as Tutar,
       bp.appliedRate as Komisyon,
       bp.signedDate as IslemTarihi,
       p.paybackId as GeriOdemeID,
       bp.paybackAmount as GeriOdemeTutar,
       CASE WHEN p.paymentStatus = 0 THEN "Bekliyor"
            WHEN p.paymentStatus = 1 THEN "Ödendi"
            WHEN p.paymentStatus = 2 THEN "İptal Edildi"
            WHEN p.paymentStatus = 3 THEN "Ertelendi"
            WHEN p.paymentStatus = 4 THEN "Ödeme Bekleniyor"
            WHEN p.paymentStatus = 5 THEN "Gönderildi"
            WHEN p.paymentStatus = 6 THEN "Reddedildi"
            WHEN p.paymentStatus = 7 THEN "Bankada Yok"
            WHEN p.paymentStatus = 8 THEN "Sunucu Erteleme" END as GeriOdemeDurum,
       p.dueDate as GeriOdemeTarih,
       pos.name as Banka,
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
        END as OdemeTipi,
       bp.batchNo as Batch_ID,
       pmd.mobile_client_version as Version,
       pmd.backend_version as OdemeVersion,
       bp.cardNumber as KartNo,
       cd.bank as KartBank,
       ser.name as Hizmet,
       (SELECT GunSonu.SonGunSonu
        FROM (
            SELECT eod.organisation_id,
                eod.terminal_serial_no,
                DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
                eod.created_at AS SonGunSonu
            FROM odeal.end_of_day eod
            JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
            AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
            WHERE eod.created_at >= "2023-01-01 00:00:00"
        ) AS GunSonu
        WHERE GunSonu.organisation_id = o.id
        AND CONVERT(GunSonu.terminal_serial_no USING utf8) = t.serial_no
        AND GunSonu.SonGunSonu > bp.signedDate ORDER BY GunSonu.SonGunSonu ASC
        LIMIT 1
        ) AS GunSonuTarihi
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
LEFT JOIN odeal.POS pos ON pos.id = bp.posId
LEFT JOIN odeal.CreditCard cd ON cd.id = bp.cardId
JOIN subscription.Service ser ON ser.id = bp.serviceId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE bp.currentStatus = 6 AND o.id = 301209711
AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-12-31 23:59:59";

SELECT o.id as UyeIsyeriKey,
       o.marka as UyeIsyeri,
       CONCAT(m.firstName," ",m.LastName) as IlgiliKisi,
       bp.organisationId as MaliNo,
       bp.id as OdemeKey,
       bp.paymentId as OdemeID,
       bp.amount as Tutar,
       bp.appliedRate as Komisyon,
       bp.signedDate as IslemTarihi,
       p.paybackId as GeriOdemeID,
       bp.paybackAmount as GeriOdemeTutar,
       CASE WHEN p.paymentStatus = 0 THEN "Bekliyor"
            WHEN p.paymentStatus = 1 THEN "Ödendi"
            WHEN p.paymentStatus = 2 THEN "İptal Edildi"
            WHEN p.paymentStatus = 3 THEN "Ertelendi"
            WHEN p.paymentStatus = 4 THEN "Ödeme Bekleniyor"
            WHEN p.paymentStatus = 5 THEN "Gönderildi"
            WHEN p.paymentStatus = 6 THEN "Reddedildi"
            WHEN p.paymentStatus = 7 THEN "Bankada Yok"
            WHEN p.paymentStatus = 8 THEN "Sunucu Erteleme" END as GeriOdemeDurum,
       p.dueDate as GeriOdemeTarih,
       pos.name as Banka,
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
        END as OdemeTipi,
       bp.batchNo as Batch_ID,
       pmd.mobile_client_version as Version,
       pmd.backend_version as OdemeVersion,
       bp.cardNumber as KartNo,
       cd.bank as KartBank,
       ser.name as Hizmet,
"CEPTEPOS" AS GunSonuTarihi
FROM odeal.Organisation o
JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.organisationId = o.id
JOIN odeal.Payment pay ON pay.id = bp.id
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
LEFT JOIN odeal.POS pos ON pos.id = bp.posId
LEFT JOIN odeal.CreditCard cd ON cd.id = bp.cardId
JOIN subscription.Service ser ON ser.id = bp.serviceId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
WHERE bp.currentStatus = 6 AND o.id = 301249850
AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= "2024-12-31 23:59:59";

SELECT bp.organisationId, bp.id, bp.signedDate,
       bp.amount, bp.paymentType, bp.appliedRate, bp.currentStatus
FROM odeal.BasePayment bp
WHERE bp.serviceId = 8 AND bp.currentStatus = 6


SELECT * FROM (
SELECT DISTINCT o.id, ser.name as Hizmet, t.supplier, IFNULL(CeptePos.name,"YOK") as CeptePos FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 2
JOIN subscription.Service ser ON ser.id = p.serviceId
LEFT JOIN (SELECT o.id, s.id as AbonelikID, ser.name FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service ser ON ser.id = p.serviceId
WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN odeal.Organisation o ON o.id = s.organisationId
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)) as CeptePos ON CeptePos.id = o.id
WHERE o.isActivated = 1 AND t.supplier = "INGENICO" AND ser.id = 2) as Ingenico
WHERE Ingenico.CeptePos <> "YOK"
GROUP BY Ingenico.id

SELECT o.id, s.id as AbonelikID, ser.name FROM odeal.Organisation o
JOIN subscription.Subscription s ON s.organisationId = o.id
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
JOIN subscription.Service ser ON ser.id = p.serviceId
WHERE s.id IN (
SELECT MAX(s.id) FROM subscription.Subscription s
JOIN odeal.Organisation o ON o.id = s.organisationId
JOIN subscription.Plan p ON p.id = s.planId AND p.serviceId = 3
GROUP BY o.id)