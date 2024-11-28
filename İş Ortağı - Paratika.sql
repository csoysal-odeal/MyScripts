
SELECT * FROM odeal.Channel c
WHERE c.name LIKE "%paratika%"

 # Paratika Durum Rapor
SELECT Basvuru.*,
    os.organisation_id AS UyeID,
    cm.name AS Marka,
    IF(cm.is_activated=1,"Aktif","Pasif") AS UyeDurum,
    os.mali_no AS MaliNo,
    cm.contact_tck_no AS TCKN,
    cm.tax_number AS VKN,
    CONCAT(Contact.firstname," ",Contact.lastname) AS Yetkili,
    fd5.label AS TerminalDurumu,
    os.odeal_satis_id AS SatisID,
    cp.potential_name AS FirsatAdi,
    fd6.label AS LeadKanal,
    fd3.label AS YazarKasa,
    fd2.label AS AramaDurumu,
    fd.label AS BeklemeNedeni,
    SatisSureci.YeniDeger_SatisSureci AS SatisSureci,
    cp.created_on AS FirsatTarihi,
    os.sales_date AS SatisTarihi,
    fd4.label AS BasvuruTuru,
    ch.subject AS TerminalKanal,
    ot.ilk_kurulum_tarihi AS TerminalAktivasyonTarihi,
    (
        SELECT SUM(islem.amount) FROM odeal_transaction islem WHERE
        islem.transaction_status = 1 AND islem.organizasyon_odeal_id = os.organisation_id AND islem.odeal_terminal = ot.odeal_terminal_id
        GROUP BY islem.organizasyon_odeal_id, islem.odeal_terminal
    ) AS Ciro,
    (
        SELECT MAX(islem.transaction_date) FROM odeal_transaction islem WHERE
        islem.transaction_status = 1 AND islem.organizasyon_odeal_id = os.organisation_id AND islem.odeal_terminal = ot.odeal_terminal_id
        GROUP BY islem.organizasyon_odeal_id, islem.odeal_terminal
    ) AS SonIslemTarihi
    FROM (SELECT DISTINCT sg.sales_general_id AS BasvuruID, sg.marka, sg.sube_kodu as Kanal, UPPER(CONCAT(sg.firstname," ",sg.lastname)) as BasvuruSahibi,
       fd.label as BasvuruDurumu, sg.created_on, CONCAT(u.firstname," ",u.lastname) as KayitSahibi
FROM sales_general sg
LEFT JOIN sales_general_device sgd ON sgd.general_sales = sg.sales_general_id
LEFT JOIN field_data fd ON fd.field_data_id = sg.satis_durumu AND fd.os_app_id = "sales" AND fd.os_model_id = "general" AND fd.field_id = "satis_durumu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = sg.account_type AND fd2.os_app_id = "sales" AND fd2.os_model_id = "general" AND fd2.field_id = "account_type"
LEFT JOIN user u ON u.user_id = sg.record_owner
          WHERE sg.dealer = 341 AND sg.test_record = 0 AND sg.status = 1 AND (sg.organisation_id IS NULL OR sg.organisation_id <> 301160192)) as Basvuru
    LEFT JOIN odeal_satis os ON os.general_sales = Basvuru.BasvuruID
    LEFT JOIN crm_account cm ON cm.crm_account_id = os.crm_account
    LEFT JOIN
    (
        SELECT cct.firstname, cct.lastname, cct.role, cct.organizasyon_odeal_id FROM crm_contact cct
        WHERE cct.role = 1
    ) AS Contact ON Contact.organizasyon_odeal_id = os.organisation_id
    LEFT JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
    LEFT JOIN
    (
        SELECT * FROM (
            SELECT hr.record_id, h.created_on,
                    ROW_NUMBER() over (partition by hr.record_id order by h.created_on desc) AS Sira,
                   JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.old_values.cfd_satis_sureci_label')) AS EskiDeger_SatisSureci,
                   JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.new_values.cfd_satis_sureci_label')) AS YeniDeger_SatisSureci
            FROM history h
            JOIN history2record hr ON hr.history_id = h.history_id
            JOIN
            (
                SELECT MAX(os.odeal_satis_id) AS OdealSatisID FROM odeal_satis os
                JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
                WHERE ot.odeal_channel = "319"
                GROUP BY os.organisation_id, os.mali_no
            ) AS Satis ON Satis.OdealSatisID = hr.record_id
            WHERE h.os_app_id = "odeal"
            AND h.os_model_id = "satis"
            AND JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.new_values.cfd_satis_sureci_label')) IS NOT NULL
        ) AS SS
        WHERE SS.Sira = 1
    ) AS SatisSureci ON SatisSureci.record_id = os.odeal_satis_id
    LEFT JOIN odeal_channel ch ON ch.odeal_channel_id = ot.odeal_channel
    LEFT JOIN crm_potential cp ON cp.crm_potential_id = os.iliskili_firsat
    LEFT JOIN field_data fd6 ON fd6.os_app_id = "crm" AND fd6.os_model_id = "potential" AND fd6.field_data_id = cp.lead_source AND fd6.field_id = "lead_source"
    LEFT JOIN field_data fd ON fd.os_app_id = "odeal" AND fd.os_model_id = "satis" AND fd.field_data_id = os.bekleme_nedeni AND fd.field_id = "bekleme_nedeni"
    LEFT JOIN field_data fd2 ON fd2.os_app_id = "odeal" AND fd2.os_model_id = "satis" AND fd2.field_data_id = os.arama_durumu AND fd2.field_id = "arama_durumu"
    LEFT JOIN field_data fd3 ON fd3.os_app_id = "crm" AND fd3.os_model_id = "potential" AND fd3.field_data_id = cp.yazar_kasa AND fd3.field_id = "yazar_kasa"
    LEFT JOIN field_data fd4 ON fd4.os_app_id = "crm" AND fd4.os_model_id = "account" AND fd4.field_data_id = cm.basvuru_account_type AND fd4.field_id = "basvuru_account_type"
    LEFT JOIN field_data fd5 ON fd5.os_app_id = "odeal" AND fd5.os_model_id = "terminal" AND fd5.field_data_id = ot.terminal_status AND fd5.field_id = "terminal_status"


SELECT cp.crm_potential_id, cp.potential_name, cp.created_on, cp.record_owner, cp.ziyaret, cp.isyeri_tipi, os.iliskili_firsat, os.mali_no FROM crm_potential cp
         LEFT JOIN odeal_satis os ON os.iliskili_firsat = cp.crm_potential_id
         ORDER BY crm_potential_id DESC

/* FetchView,S=DESKTOP,U=15873,V=paratika_tum_satislar */
 SELECT /*+ MAX_EXECUTION_TIME(90000) */ `sales_general`.`sales_general_id`,`sales_general`.`sales_general_id`AS`record_id`,`cfd_satis_durumu`.`color`AS`cfd_satis_durumu_color`,`cfd_satis_durumu`.`value`AS`cfd_satis_durumu_value`,`sales_general`.`satis_durumu`,`cfd_satis_durumu`.`label`AS`cfd_satis_durumu_label`,`sales_general`.`hos_geldin_aramasi_aciklamasi`,`cfd_sales_type`.`color`AS`cfd_sales_type_color`,`cfd_sales_type`.`value`AS`cfd_sales_type_value`,`sales_general`.`sales_type`,`cfd_sales_type`.`label`AS`cfd_sales_type_label`,`cfd_account_type`.`color`AS`cfd_account_type_color`,`cfd_account_type`.`value`AS`cfd_account_type_value`,`sales_general`.`account_type`,`cfd_account_type`.`label`AS`cfd_account_type_label`,`sales_general`.`code`,`sales_general`.`garantor_tckn`,`sales_general`.`tckn`, (CONCAT(sales_general.firstname,' ', sales_general.lastname)) AS`fullname`,`sales_general`.`iban`, ((SELECT GROUP_CONCAT(sgd.mali_no) FROM sales_general_device sgd
WHERE sgd.general_sales = sales_general.sales_general_id
AND sgd.status = 1)) AS`mali_no_bilgileri`,`sales_general`.`organisation_id`,`sales_general`.`record_owner`, CONCAT(rel_record_owner.firstname, ' ', rel_record_owner.lastname) AS`rel_record_owner_label`, DATE_FORMAT(CONVERT_TZ(sales_general.created_on, @@time_zone, '+03:00'), '%Y-%m-%d %H:%i:%s') AS`created_on`, (IF(sales_general.organisation_id > 0, CONCAT('<a target="_blank" href="https://admin.odealapp.com/organisations/', sales_general.organisation_id, '">Admin Link</a>'), '')) AS`admin_link`,`sales_general`.`created_by`, CONCAT(rel_created_by.firstname, ' ', rel_created_by.lastname) AS`rel_created_by_label`FROM`sales_general`
 LEFT JOIN`user`AS`rel_record_owner`ON sales_general.record_owner = rel_record_owner.user_id
 LEFT JOIN`user`AS`rel_created_by`ON sales_general.created_by = rel_created_by.user_id
 LEFT JOIN`field_data`AS`cfd_satis_durumu`FORCE INDEX(`idx_covering`)  ON`cfd_satis_durumu`.os_app_id = 'sales' AND`cfd_satis_durumu`.os_model_id = 'general' AND`cfd_satis_durumu`.field_id = 'satis_durumu' AND`cfd_satis_durumu`.field_data_id =`sales_general`.`satis_durumu`
 LEFT JOIN`field_data`AS`cfd_sales_type`FORCE INDEX(`idx_covering`)  ON`cfd_sales_type`.os_app_id = 'sales' AND`cfd_sales_type`.os_model_id = 'general' AND`cfd_sales_type`.field_id = 'sales_type' AND`cfd_sales_type`.field_data_id =`sales_general`.`sales_type`
 LEFT JOIN`field_data`AS`cfd_account_type`FORCE INDEX(`idx_covering`)  ON`cfd_account_type`.os_app_id = 'sales' AND`cfd_account_type`.os_model_id = 'general' AND`cfd_account_type`.field_id = 'account_type' AND`cfd_account_type`.field_data_id =`sales_general`.`account_type`
 WHERE ((/* View-Start */ ((`sales_general`.`dealer`= '340')) /* View-End */ ) AND`sales_general`.status = '1')
 ORDER BY`sales_general`.`sales_general_id`DESC LIMIT 100


 SELECT DISTINCT sg.sales_general_id AS BasvuruID, sg.sube_kodu as Kanal, sg.organisation_id as UyeID, UPPER(CONCAT(sg.firstname," ",sg.lastname)) as BasvuruSahibi,
       fd.label as SatisDurumu, fd2.label as UyeIsyeriTipi, sg.created_on, CONCAT(u.firstname," ",u.lastname) as KayitSahibi
FROM sales_general sg
LEFT JOIN sales_general_device sgd ON sgd.general_sales = sg.sales_general_id
LEFT JOIN field_data fd ON fd.field_data_id = sg.satis_durumu AND fd.os_app_id = "sales" AND fd.os_model_id = "general" AND fd.field_id = "satis_durumu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = sg.account_type AND fd2.os_app_id = "sales" AND fd2.os_model_id = "general" AND fd2.field_id = "account_type"
LEFT JOIN user u ON u.user_id = sg.record_owner
          WHERE sg.dealer = 340 AND sg.test_record = 0 AND sg.status = 1 AND (sg.organisation_id IS NULL OR sg.organisation_id <> 301160192)

SELECT sg.sales_general_id, sg.dealer, sg.sube_kodu, sg.organisation_id, sg.firstname, sg.lastname,
       fd.label as SatisDurumu, fd2.label as UyeIsyeriTipi, sg.created_on, CONCAT(u.firstname," ",u.lastname) as KayitSahibi
FROM sales_general sg
LEFT JOIN sales_general_device sgd ON sgd.general_sales = sg.sales_general_id
LEFT JOIN field_data fd ON fd.field_data_id = sg.satis_durumu AND fd.os_app_id = "sales" AND fd.os_model_id = "general" AND fd.field_id = "satis_durumu"
LEFT JOIN field_data fd2 ON fd2.field_data_id = sg.account_type AND fd2.os_app_id = "sales" AND fd2.os_model_id = "general" AND fd2.field_id = "account_type"
LEFT JOIN user u ON u.user_id = sg.record_owner
          WHERE sg.dealer = 341 AND sg.test_record = 0 AND sg.status = 1 AND sg.sube_kodu LIKE "%tami%"

 SELECT os.organisation_id, os.mali_no, os.marka, ot.serial_no, ch.subject, ch.odeal_channel_id FROM odeal_satis os
                JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
                JOIN odeal_channel ch ON ch.odeal_channel_id = ot.odeal_channel
                WHERE ch.subject LIKE "%tami%"




SELECT * FROM sales_general sg WHERE sg.dealer = 340 AND sg.organisation_id IS NOT NULL ORDER BY sg.sales_general_id DESC LIMIT 10


SELECT * FROM odeal_satis os WHERE os.general_sales = 6357

SELECT * FROM field_data fd WHERE fd.os_app_id = "sales" AND fd.os_model_id = "general"


SELECT SUM(islem.amount) FROM odeal_transaction islem WHERE
islem.transaction_status = 1 AND islem.transaction_date >= "2024-07-01 00:00:00" AND
islem.transaction_date <= "2024-07-01 23:59:59"
GROUP BY islem.organizasyon_odeal_id, islem.odeal_terminal



SELECT MAX(os.odeal_satis_id) as OdealSatisID FROM odeal_satis os
JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
WHERE ot.odeal_channel = "195"
GROUP BY os.organisation_id, os.mali_no

SELECT ccl.account_name, ccl.pool, ccl.pool_description,
       ccl.account_name, ccl.created_on, ccl.callcenter_call_id,
        ccl.arama_tarihi
FROM callcenter_call ccl WHERE ccl.account_name = 420484

SELECT cct.firstname, cct.lastname, cct.role, cct.organizasyon_odeal_id FROM crm_contact cct
WHERE cct.role = 1


SELECT MAX(os.odeal_satis_id) FROM odeal_satis os
JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
WHERE ot.odeal_channel = "195"
GROUP BY os.organisation_id, os.mali_no



SELECT * FROM crm_lead cp ORDER BY cp.created_on DESC

SELECT * FROM information_schema.COLUMNS c WHERE c.COLUMN_NAME LIKE "%basvuru%"

SELECT * FROM odeal.Terminal t WHERE t.channelId = 195

SELECT * FROM (
SELECT hr.record_id, h.created_on,
        ROW_NUMBER() over (partition by hr.record_id order by h.created_on desc) as Sira,
       JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.old_values.cfd_satis_sureci_label')) AS EskiDeger_SatisSureci,
       JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.new_values.cfd_satis_sureci_label')) AS YeniDeger_SatisSureci
FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
JOIN (SELECT MAX(os.odeal_satis_id) as OdealSatisID FROM odeal_satis os
JOIN odeal_terminal ot ON ot.organisation_id = os.organisation_id AND ot.serial_no = os.mali_no
WHERE ot.odeal_channel = "195"
GROUP BY os.organisation_id, os.mali_no) as Satis ON Satis.OdealSatisID = hr.record_id
WHERE h.os_app_id = "odeal"
  AND h.os_model_id = "satis"
  AND JSON_UNQUOTE(JSON_EXTRACT(NULLIF(IF(JSON_VALID(hr.data)=1,hr.data,NULL),''),'$.new_values.cfd_satis_sureci_label')) IS NOT NULL) as SS
         WHERE SS.Sira = 1

SELECT * FROM field_data fd
WHERE fd.os_app_id = "odeal" AND fd.os_model_id = "transaction"

SELECT * FROM information_schema.COLUMNS c WHERE c.COLUMN_NAME LIKE "%kurulum%"

SELECT * FROM odeal_okc_evrak_takibi evr WHERE evr.terminal = "113695"

SELECT tmmh.merchant_id, tmmh.serial_no, tmmh.physical_serial_no, tmmh.version
FROM odeal.TerminalMerchantMappingHistory tmmh WHERE tmmh.id IN (
SELECT MAX(tmmh.id) FROM odeal.TerminalMerchantMappingHistory tmmh
WHERE tmmh.serial_no = "PAX710058011" AND tmmh.status = "ACTIVE"
GROUP BY tmmh.merchant_id, tmmh.serial_no)


SELECT DISTINCT o.id as UyeIsyeriID, t.serial_no as MaliNo, bp.id as IslemID, bp.signedDate as IslemTarihi, bp.amount as IslemTutar, bp.paybackAmount as GeriOdemeyeEsasTutar, p.id as GeriOdemeID, p.amount as GeriOdenenTutar, p.dueDate as GeriOdemeOlusmaTarihi, p.paidDate as GeriOdemeTarihi,
(SELECT SonGun.SonGunSonu FROM (SELECT eod.organisation_id, eod.terminal_serial_no, MAX(eod.created_at) as SonGunSonu FROM odeal.end_of_day eod
WHERE eod.organisation_id = 301268588 AND eod.terminal_serial_no = "PAX710058011"
GROUP BY eod.organisation_id, eod.terminal_serial_no, DATE_FORMAT(eod.created_at, "%Y-%m-%d")) as SonGun
    WHERE SonGun.organisation_id = o.id
        AND CONVERT(SonGun.terminal_serial_no USING utf8) = t.serial_no
        AND SonGun.SonGunSonu > bp.signedDate ORDER BY SonGun.SonGunSonu ASC LIMIT 1) AS GunSonuTarihi
FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN odeal.Channel c ON c.id = t.channelId
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId
WHERE c.id = 195 AND o.id = 301268588 AND t.serial_no = "PAX710058011";

-- AND CONVERT(eod.terminal_serial_no USING utf8) = t.serial_no AND eod.created_at > bp.signedDate;

PAX710058024

SELECT t.serial_no, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.Terminal t
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE t.serial_no = "PAX710030015" AND bp.paymentType IN (0,1,2,3,6,7,8) AND bp.currentStatus = 6 AND bp.signedDate >= "2023-12-01 00:00:00" AND bp.signedDate <= "2023-12-31 23:59:59";


SELECT eod.organisation_id, eod.terminal_serial_no, MAX(eod.created_at) as SonGunSonu FROM odeal.end_of_day eod
WHERE eod.organisation_id = 301268588 AND eod.terminal_serial_no = "PAX710058011"
GROUP BY eod.organisation_id, eod.terminal_serial_no, DATE_FORMAT(eod.created_at, "%Y-%m-%d")

 SELECT
    o.id AS 'Üye İşyeri ID',
    o.unvan AS 'Üye İşyeri Ünvan',
    o.marka AS 'Marka',
    CONCAT(m.firstName, ' ', m.LastName) AS 'İlgili Kişi',
    o.isActivated AS 'Üye İşyeri Durum',
    bp.id AS 'Ödeme Key',
    bp.paymentId AS 'Ödeme ID',
    t.serial_no AS 'Seri No',
    sr.name AS 'Servis',
    TerminalHistory.version AS 'Versiyon Bilgisi',
    bp.signedDate AS 'İşlem Tarihi',
    bp.amount AS 'İşlem Tutarı',
    (SELECT GunSonu.SonGunSonu
        FROM (
            SELECT eod.organisation_id,
                eod.terminal_serial_no,
                DATE_FORMAT(eod.created_at,"%Y-%m-%d") AS Gun,
                eod.created_at AS SonGunSonu
            FROM odeal.end_of_day eod
            JOIN odeal.Terminal t ON t.organisation_id = eod.organisation_id
            AND t.serial_no = CONVERT(eod.terminal_serial_no USING utf8)
            WHERE eod.created_at >= "2024-01-01 00:00:00" AND t.channelId = 195
        ) AS GunSonu
        WHERE GunSonu.organisation_id = o.id
        AND GunSonu.SonGunSonu < "2024-08-15 00:00:00"
        AND GunSonu.SonGunSonu >= "2024-08-14 00:00:00"
        AND CONVERT(GunSonu.terminal_serial_no USING utf8) = t.serial_no
        AND GunSonu.SonGunSonu > bp.signedDate ORDER BY GunSonu.SonGunSonu ASC
        LIMIT 1
    ) AS GunSonuTarihi,
    bp.appliedRate AS 'Komisyon Oranı',
    tp.installment AS 'Taksit',
    pmd.mobile_client_version AS 'Ödeme Versiyon',
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
    END as 'OdemeTipi',
    p.paybackId AS 'Geri Ödeme ID',
    p.amount AS 'Geri Ödemeye Esas Tutarı',
    p.dueDate AS 'Geri Ödeme Tarihi',
    pos.name AS 'Banka',
    bp.cardNumber AS 'Kart Numarası',
    bini.bankName AS 'Kart Bankası',
    bp.authCode AS 'Banka Onay Kodu',
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
    END AS 'Geri ödeme durumu',
    bp.basketId AS 'E-Fatura No'
FROM odeal.Payback p
JOIN odeal.Organisation o ON o.id = p.organisationId
LEFT JOIN odeal.Merchant m ON m.organisationId = o.id AND m.role = 0
JOIN odeal.BasePayment bp ON bp.paybackId = p.id
JOIN odeal.TerminalPayment tp ON tp.id = bp.id
JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN (
    SELECT MAX(tmmh.id), tmmh.serial_no, tmmh.version FROM odeal.TerminalMerchantMappingHistory tmmh
    GROUP BY tmmh.serial_no, tmmh.version
) AS TerminalHistory ON TerminalHistory.serial_no = t.serial_no
LEFT JOIN  odeal.BinInfo bini ON bini.bin = substr(COALESCE(bp.cardNumber), 1, 6)
LEFT JOIN odeal.BankInfo bi ON bi.id = p.bankInfoId AND bi.status = 1
JOIN odeal.POS pos ON pos.id = bp.posId
LEFT JOIN paymatch.bank_report br ON br.unique_key = bp.uniqueKey
JOIN subscription.Subscription s ON s.id = t.subscription_id
JOIN subscription.Plan pl ON pl.id = s.planId
JOIN subscription.Service sr ON sr.id = pl.serviceId
LEFT JOIN odeal.PaymentMetaData pmd ON pmd.payment_id = bp.id
LEFT JOIN odeal.Channel c ON c.id = t.channelId
WHERE t.channelId = '195'
AND p.paidDate >= DATE_SUB(CURDATE(), INTERVAL 3 DAY)
AND p.paidDate < CURDATE()
ORDER BY p.paybackId ASC;