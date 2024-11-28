SELECT t.organisation_id, t.serial_no, SUM(bp.amount) as Ciro, COUNT(bp.id) as Adet, MAX(bp.signedDate) as SonIslemTarihi FROM odeal.Terminal t 
JOIN odeal.TerminalPayment tp 
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.Channel c ON c.id = t.channelId 
WHERE bp.currentStatus = 6 AND c.id = 213
GROUP BY t.organisation_id, t.serial_no


 #Osmanlı Gıda

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
    AND p.paidDate >= DATE_SUB(CURDATE(), INTERVAL 1 DAY) AND p.paidDate < CURDATE()
    ORDER BY p.paybackId ASC
   
    
#DinamikPOS
    
    SELECT o.id as UyeIsyeriID, o.marka as Marka, o.unvan as Unvan, t.serial_no as MaliNo, 
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-01" THEN bp.amount END) as 2024_01,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-02" THEN bp.amount END) as 2024_02,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-03" THEN bp.amount END) as 2024_03,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-04" THEN bp.amount END) as 2024_04,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-05" THEN bp.amount END) as 2024_05,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-06" THEN bp.amount END) as 2024_06,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-07" THEN bp.amount END) as 2024_07,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-08" THEN bp.amount END) as 2024_08,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-09" THEN bp.amount END) as 2024_09,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-10" THEN bp.amount END) as 2024_10,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-11" THEN bp.amount END) as 2024_11,
            SUM(CASE WHEN DATE_FORMAT(bp.signedDate, "%Y-%m") = "2024-12" THEN bp.amount END) as 2024_12,
            SUM(bp.amount) as Genel_Toplam
            FROM odeal.Organisation o 
            JOIN odeal.Terminal t ON t.organisation_id = o.id 
            LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
            LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id AND bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND bp.signedDate <= NOW()
            WHERE o.demo = 0 AND t.channelId = 213
            GROUP BY o.id, o.marka, o.unvan, t.serial_no
