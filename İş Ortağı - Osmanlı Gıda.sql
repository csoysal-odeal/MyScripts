 SELECT * FROM (
    SELECT c.name      AS 'Kanal',
    o.id              AS 'UyeID',
    o.marka          AS 'Marka',
    t.serial_no      AS 'MaliNo',
    m.tckNo          AS 'TCKN',
    o.vergiNo           AS 'VKN',
    o.address          AS 'Adres',
    IF(o.isActivated=1,"Aktif","Pasif")     AS 'UyeDurum',
    IF(t.terminalStatus=1,"Aktif","Pasif")     AS 'TerminalDurum',
    s.id              AS 'AbonelikID',
    p.name              AS 'Plan',
    s2.name             AS 'Hizmet',
    bp.id             AS 'IslemId',
    bp.signedDate      AS 'IslemTarihi',
    bp.amount         AS 'IslemTutar',
    bp.appliedRate      AS 'Komisyon',
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
    END AS PaymentTipi,
    (SELECT GunSonu.SonGunSonu FROM (
        SELECT eod.organisation_id,
            eod.terminal_serial_no,
            DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
            eod.created_at AS SonGunSonu
        FROM odeal.end_of_day eod
        JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
        AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
        WHERE eod.created_at >= "2024-03-01 00:00:00" AND t.channelId = 357) AS GunSonu
    WHERE GunSonu.organisation_id = 301160554
    AND CONVERT(GunSonu.terminal_serial_no USING utf8) = "PAX710064957"
    AND GunSonu.SonGunSonu > "2024-01-01 00:00:00" ORDER BY GunSonu.SonGunSonu ASC
    LIMIT 1) AS GunSonuTarihi
    FROM odeal.Organisation o
    JOIN odeal.Terminal t ON t.organisation_id = o.id
    LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
    LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
    LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
    AND bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 6 MONTH),"%Y-%m-01 00:00:00")
    LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
    LEFT JOIN subscription.Plan p ON p.id = s.planId
    LEFT JOIN subscription.Service s2 ON s2.id = p.serviceId
    LEFT JOIN odeal.Channel c ON c.id = t.channelId
    WHERE t.channelId = 357 AND bp.id IS NOT NULL AND t.serial_no = "PAX710064957"
    ORDER BY o.id, t.serial_no, bp.signedDate
) as Islem;

SELECT * FROM odeal.Channel c WHERE c.name LIKE "%bizim%"

SELECT t.serial_no, t.organisation_id, t.terminalStatus, t.channelId, SUM(bp.amount) as Ciro FROM odeal.Terminal t
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND t.channelId = 357
GROUP BY t.serial_no, t.organisation_id, t.terminalStatus, t.channelId


SELECT DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 4 MONTH),"%Y-%m-01 00:00:00")

SELECT o.id, t.serial_no, tp.installment, bp.id, bp.signedDate, bp.amount, bp.paymentType FROM odeal.Terminal t
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.Organisation o ON o.id = t.organisation_id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.currentStatus = 6 AND t.serial_no = "PAX710026012" -- o.id = 301156432

Mehmet Ungan


SELECT * FROM (
	SELECT c.name AS Kanal,
	o.id AS UyeID,
	o.marka AS Marka,
	t.serial_no AS MaliNo,
	IF(o.isActivated=1,"Aktif","Pasif") AS UyeDurum,
	IF(t.terminalStatus=1,"Aktif","Pasif") AS TerminalDurum,
	s.id AS AbonelikID,
	p.name AS Plan,
	s2.name AS Hizmet,
	bp.id AS IslemId,
	bp.signedDate AS IslemTarihi,
	bp.amount AS IslemTutar,
	bp.appliedRate AS Komisyon,
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
	(SELECT GunSonu.SonGunSonu FROM (
		SELECT eod.organisation_id,
		    eod.terminal_serial_no,
		    DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
		    eod.created_at AS SonGunSonu
		FROM odeal.end_of_day eod
		JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
		AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
		WHERE eod.created_at >= "2024-01-01 00:00:00" AND t.channelId = 313) AS GunSonu
	WHERE GunSonu.organisation_id = o.id
	AND CONVERT(GunSonu.terminal_serial_no USING utf8) = t.serial_no
	AND GunSonu.SonGunSonu > bp.signedDate ORDER BY GunSonu.SonGunSonu ASC
	LIMIT 1) AS GunSonuTarihi
	FROM odeal.Organisation o
	JOIN odeal.Terminal t ON t.organisation_id = o.id
	LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
	LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6
	AND bp.signedDate >= "2024-01-01 00:00:00"
	JOIN subscription.Subscription s ON s.id = t.subscription_id
	JOIN subscription.Plan p ON p.id = s.planId
	JOIN subscription.Service s2 ON s2.id = p.serviceId
	JOIN odeal.Channel c ON c.id = t.channelId
	WHERE t.channelId = 313 AND bp.id IS NOT NULL
	ORDER BY o.id, t.serial_no, bp.signedDate
) as Islem

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
    AND p.paidDate >= "2024-01-01 00:00:00" AND p.paidDate < CURDATE()
    ORDER BY p.paybackId ASC;

SELECT * FROM odeal.Organisation o WHERE o.unvan LIKE "%ungan%"