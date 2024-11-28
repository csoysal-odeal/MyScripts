         SELECT Terminal.serial_no as MaliNo,
            fd2.label as Tedarikci,
            fd6.label as YazarKasaTipi,
            fd3.label as GeriOdemeTipi,
            IF(ISNULL(os.satis_kanali)=TRUE,oc.subject,fd.label) as SatisKanali,
            os.odeal_satis_id,
            ca.odeal_id as OrgID,
            ac.city_name as Sehir,
            at.town_name as Ilce,
            os.adres as Adres,
            os.sales_date as SatisaDonusmeTarihi,
            os.welcome_tarihi as WelcomeTarihi,
            Terminal.ilk_kurulum_tarihi as KurulumTarihi,
            DATEDIFF(Terminal.ilk_kurulum_tarihi,os.sales_date) as KurulumSuresi,
            fd4.label as AramaDurumu,
            fd5.label as BeklemeNedeni,
            CONCAT(u.firstname,' ',u.lastname) as KayitSahibi,
            ur.role_name as KayitSahibiRolu
        FROM odeal_satis os
        JOIN crm_account ca ON ca.crm_account_id = os.crm_account
        JOIN (SELECT ot.odeal_terminal_id, ot.serial_no, ot.organisation_id, ot.ilk_kurulum_tarihi, ot.odeal_channel FROM odeal_terminal ot WHERE ot.odeal_terminal_id IN (
        SELECT MAX(ot.odeal_terminal_id) FROM odeal_terminal ot GROUP BY ot.serial_no, ot.organisation_id)) as Terminal ON Terminal.serial_no = os.mali_no AND Terminal.organisation_id = os.organisation_id
        LEFT JOIN field_data fd ON fd.field_data_id = os.satis_kanali AND fd.os_app_id = 'odeal' AND fd.os_model_id = 'satis' AND fd.field_id = 'satis_kanali'
        LEFT JOIN field_data fd2 ON fd2.field_data_id = os.tedarikci AND fd2.os_app_id = 'odeal' AND fd2.os_model_id = 'satis' AND fd2.field_id = 'tedarikci'
        LEFT JOIN field_data fd3 ON fd3.field_data_id = os.geri_odeme_tipi AND fd3.os_app_id = 'odeal' AND fd3.os_model_id = 'satis' AND fd3.field_id = 'geri_odeme_tipi'
        LEFT JOIN field_data fd4 ON fd4.field_data_id = os.arama_durumu AND fd4.os_app_id = 'odeal' AND fd4.os_model_id = 'satis' AND fd4.field_id = 'arama_durumu'
        LEFT JOIN field_data fd5 ON fd5.field_data_id = os.bekleme_nedeni AND fd5.os_app_id = 'odeal' AND fd5.os_model_id = 'satis' AND fd5.field_id = 'bekleme_nedeni'
        LEFT JOIN field_data fd6 ON fd6.field_data_id = os.yazar_kasa_tipi AND fd6.os_app_id = 'odeal' AND fd6.os_model_id = 'satis' AND fd6.field_id = 'yazar_kasa_tipi'
        LEFT JOIN odeal_channel oc ON oc.odeal_channel_id = Terminal.odeal_channel
        LEFT JOIN user u ON u.user_id = os.record_owner
        LEFT JOIN user_role ur ON u.user_role_id = ur.user_role_id
        LEFT JOIN addr_city ac ON ac.addr_city_id = os.kurulum_il
        LEFT JOIN addr_town at ON at.addr_town_id = os.kurulum_ilce
        WHERE os.odeal_satis_id IN (SELECT MAX(os.odeal_satis_id) FROM odeal_satis os GROUP BY os.organisation_id, os.mali_no) AND os.satis_kanali = 7;

SELECT os.organisation_id, os.mali_no, os.satis_kanali, ot.odeal_channel FROM odeal_satis os
                                                       LEFT JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
                                                       WHERE os.mali_no = "PAX710064957";



 SELECT
    o.id             AS 'UYE_ISYERI_ID',
    bp.id            AS 'ODEME_KEY',
    bp.paymentId    AS 'ODEME_ID',
    bp.uniqueKey    AS 'UNIQUE_KEY',
    bp.`_createdDate` AS 'CREATED_DATE',
    bp.isExternallyGenerated AS 'IS_EXTARNALLY_GENERATED',
    o.unvan            AS 'UYE_ISYERI_UNVAN',
    o.marka         AS 'MARKA',
    CASE
        WHEN o.businessType = 0 THEN 'Bireysel'
        WHEN o.businessType = 1 THEN 'Şahıs'
        WHEN o.businessType = 2 THEN 'Tüzel'
        WHEN o.businessType = 3 THEN 'Dernek / Apartman Yöneticiliği'
    END             AS 'IS_YERI_TIPI',
    m.tckNo         AS 'TCKN',
    o.vergiNo          AS 'VKN',
    o.address         AS 'ADRES',
    c.name            AS 'KANAL',
    t.serial_no     AS 'SERI_NO',
    bp.signedDate     AS 'ISLEM_TARIHI',
    bp.amount        AS 'ISLEM_TUTARI',
    bp.amount - (bp.amount * bp.appliedRate / 100) AS 'NET_TUTAR',
    bp.appliedRate     AS 'KOMISYON_ORANI',
    (SELECT GunSonu.SonGunSonu
        FROM (
            SELECT eod.organisation_id,
                eod.terminal_serial_no,
                DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
                eod.created_at AS SonGunSonu
            FROM odeal.end_of_day eod
            JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
            AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
            WHERE eod.created_at >= "2024-01-01 00:00:00" AND t.channelId = '357'
        ) AS GunSonu
        WHERE GunSonu.organisation_id = o.id
        AND CONVERT(GunSonu.terminal_serial_no USING utf8) = t.serial_no
        AND GunSonu.SonGunSonu > bp.signedDate ORDER BY GunSonu.SonGunSonu ASC
        LIMIT 1
    )                 AS 'GUN_SONU_TARIHI',
    p.amount        AS 'GERI_ODEME_TUTARI',
    p.dueDate         AS 'GERI_ODEME_TARIHI',
    bini.bankName    AS 'BANKA',
    bp.cardNumber     AS 'KART_NUMARASI',
    bp.authCode     AS 'BANKA_ONAY_KODU',
    CASE
        WHEN p.paymentStatus = 0 THEN 'Bekliyor'
        WHEN p.paymentStatus = 1 THEN 'Ödendi'
        WHEN p.paymentStatus = 2 THEN 'İptal'
        WHEN p.paymentStatus = 3 THEN 'Ertelendi'
        WHEN p.paymentStatus = 4 THEN 'Ödeme Bekleniyor'
        WHEN p.paymentStatus = 5 THEN 'Gönderildi'
        WHEN p.paymentStatus = 6 THEN 'Geri Döndü'
        WHEN p.paymentStatus = 7 THEN 'Bankada Olmayan'
        WHEN p.paymentStatus = 8 THEN 'Fraud'
    END                AS 'GERI_ODEME_DURUMU',
    ""                AS 'FILE_ID',
    report.pos_merchant_id  AS 'TID',
    report.bank_merchant_id  AS 'BANKMERCHANTID',
    t.supplier        AS 'SUPPLIER'
FROM odeal.Payback p
JOIN odeal.Organisation o ON o.id = p.organisationId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.paybackId = p.id
LEFT JOIN paymatch.bank_report report ON report.unique_key = bp.uniqueKey
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN  odeal.BinInfo bini ON bini.bin = substr(COALESCE(bp.cardNumber), 1, 6)
LEFT JOIN odeal.BankInfo bi ON bi.id = p.bankInfoId AND bi.status = 1
JOIN odeal.POS pos ON pos.id = bp.posId
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan pl ON pl.id = s.planId
JOIN subscription.Service sr ON sr.id = pl.serviceId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.channelId = '357'
AND p.paidDate >= "2024-09-11 00:00:00"
AND p.paidDate <= "2024-09-11 23:59:59"
ORDER BY p.paybackId ASC;


SELECT * FROM paymatch.bank_report br LIMIT 10;