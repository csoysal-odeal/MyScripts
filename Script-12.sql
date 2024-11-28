SELECT COUNT(bp.id) as Adet, SUM(bp.amount) as Tutar
FROM odeal.BasePayment bp
WHERE bp.signedDate >= "2021-11-01 00:00:00" and bp.signedDate <= "2021-11-30 23:59:59" and bp.currentStatus = 6

SELECT DATE_FORMAT(BtransFiziki.dueDate,"%Y-%m") as Yil, COUNT(BtransFiziki.lref) as IslemAdet, SUM(BtransFiziki.islemtutar) as IslemTutar  FROM (
SELECT DISTINCT 'E'                                                                             AS 'recordtype',
                bp.id                                                                           AS 'lref',
                'FS001'                                                                         AS 'islemturu',
                '8370548092'                                                                    AS 'gonokvkn',
                'ÖDEAL ÖDEME KURULUŞU A.Ş.'                                                     AS 'gonokunvan',
                IF(po.name IS NOT NULL, po.name, 'XX')                                          AS 'gonposbankaad',
                IF(po.bank_id IS NOT NULL, po.bank_id, '00')                                    AS 'gonposbankakod',
                CASE
                    WHEN po.bank_id in (select *
                                        from (select distinct bank_id
                                              from odeal.POS
                                              where isActive = true
                                              union
                                              select distinct bank_code
                                              from paymatch.bank_mid_tid
                                              where device_status = 'Aktif'
                                                 OR device_status = 'Açık') as ActiveBankid) AND tp.bankMerchantId <> ''
                        THEN tp.bankMerchantId
                    WHEN tp.bankMerchantId = '' OR tp.bankMerchantId is null THEN '0000000' END AS 'gonuyeisyerino',
                CASE
                    WHEN po.bank_id IN (SELECT bank_id
                                        FROM (SELECT DISTINCT bank_id
                                              FROM odeal.POS
                                              WHERE isActive = true
                                              UNION
                                              SELECT DISTINCT bank_code
                                              FROM paymatch.bank_mid_tid
                                              WHERE device_status = 'Aktif'
                                                 OR device_status = 'Açık') AS ActiveBankid) AND tp.posMerchantId <> ''
                        THEN tp.posMerchantId
                    WHEN tp.posMerchantId = '' OR tp.posMerchantId is null THEN 'XX' END        AS 'gonteridno',
                'Akbank'                                                                        AS 'gonbankaad',
                '46'                                                                            AS 'gonbankakod',
                'TR250004600175888000235089'                                                    AS 'goniban',
                '0175 - 0235089 TL'                                                             AS 'gonhesno',
                'E'                                                                             AS 'musterimi',
                IF((o.businesstype = 2 or o.businessType = 3) and (o.vergiNo is not null) and LENGTH(o.vergiNo) < 11,
                   o.vergiNo,
                   IF((o.businessType = 1 and LENGTH(o.vergiNo) = 10 and o.unvan is not null AND m.firstName is null and
                       m.LastName is null), o.vergiNo,
                      ''))                                                                      AS 'altkvkn',
                IF((o.businesstype = 2 or o.businessType = 3) and (o.unvan is not null) and LENGTH(o.vergiNo) < 11,
                   o.unvan,
                   IF((o.businessType = 1 and LENGTH(o.vergiNo) = 10 and o.unvan is not null AND m.firstName is null and
                       m.LastName is null), o.unvan,
                      ''))                                                                      AS 'altkunvan',
                IF((o.businesstype = 0 OR o.businessType = 1) AND (m.tckno IS NOT NULL) AND LENGTH(m.tckno) = 11,
                   m.tckNo,
                   IF((o.businesstype = 0 OR o.businessType = 1 or o.businessType = 2) AND LENGTH(o.vergiNo) = 11,
                      o.vergiNo,
                      ''))                                                                      AS algkkimlikno,
                IF((o.businesstype = 0 or o.businessType = 1) and (m.tckno is not null), m.firstName,
                   IF((o.businesstype = 0 OR o.businessType = 1 or o.businessType = 2) AND (o.vergiNo is not null) and
                      o.unvan is not null and LENGTH(o.vergiNo)=11, SUBSTRING_INDEX(o.unvan, ' ', 1), '')
                    )                                                                           AS 'algkad',
                IF((o.businesstype = 0 or o.businessType = 1) and (m.tckno is not null), m.LastName,
                   IF((o.businesstype = 0 OR o.businessType = 1 or o.businessType = 2) AND (o.vergiNo is not null) and
                      o.unvan is not null and LENGTH(o.vergiNo)=11, SUBSTRING_INDEX(o.unvan, ' ', -1), '')
                    )                                                                           AS 'algksoyad',
                IF(m.tckNo IS NULL AND o.vergiNo IS NULL, 'XX', '')                             AS 'alnosuzad',
                IF(m.tckNo IS NULL AND o.vergiNo IS NULL, '5', '')                              AS 'alnosuzkimliktipi',
                IF(m.tckNo IS NULL AND o.vergiNo IS NULL, '00000000000', '')                    AS 'alnosuzkimlikno',
                IF(m.tckNo IS NULL AND o.vergiNo IS NULL, 'TR', '')                             AS 'alnosuzulke',
                IF(m.tckNo IS NULL AND o.vergiNo IS NULL, 'XX', '')                             AS 'alnosuziladi',
                'XX'                                                                            AS 'aluyruk',
                o.address                                                                       AS 'aladres',
                tw.name                                                                         AS 'alilceadi',
                CONCAT(ct.id, '000')                                                            AS 'alpostakod',
                ct.id                                                                           AS 'alilkod',
                ct.name                                                                         AS 'aliladi',
                IF(m.phone IS NOT NULL, m.phone, '0000000000')                                  AS 'altel',
                ''                                                                              AS 'alokhesno',
                ''                                                                              AS 'alokepara',
                ''                                                                              AS 'alokkartno',
                IF(bi.bank IS NOT NULL, bi.bank, 'XX')                                          AS 'albankaad',
                IF(bi.iban IS NOT NULL AND bi.iban > 0, SUBSTR(bi.iban, 3, 5),
                   '00000')                                                                     AS 'albankakod',
                ''                                                                              AS 'alsubead',
                IF(bi.iban IS NOT NULL AND bi.iban > 0, CONCAT('TR', bi.iban),
                   'TR000000000000000000000000')                                                AS 'aliban',
                IF(bi.iban IS NOT NULL AND bi.iban > 0, SUBSTRING(bi.iban, 9, 16),
                   '0000000000000000')                                                          AS 'alhesno',
                IF(bp.cardNumber IS NULL, '0000000000000000', bp.cardNumber)                    AS 'alkredikartno',
                REPLACE(CAST(DATE(bp.signedDate) AS CHAR), '-', '')                             AS 'istar',
                REPLACE(CAST(DATE(pb.dueDate) AS CHAR), '-', '')                                AS 'odemetar',
                bp.amount                                                                       AS 'islemtutar',
                bp.amount                                                                       AS 'asiltutar',
                'TRY'                                                                           AS 'parabirim',
                bp.paybackAmount                                                                AS 'bruttutar',
                'H'                                                                             AS 'sirketmi',
                '0000000000'                                                                    AS 'sirketvkn',
                'XX'                                                                            AS 'sirketunvan',
                CAST(bp.amount AS DECIMAL(10, 2)) - CAST(bp.paybackAmount AS DECIMAL(10, 2))    AS 'bruttahtutar',
                'Satış İşlemi'                                                                  AS 'kuraciklama',
                ''                                                                              AS 'musaciklama',
                'KK025'                                                                         AS 'kurumkod',
                bp._lastModifiedDate                                                            AS 'lastModifiedDate',
                pb.dueDate                                                                      AS 'dueDate',
                bp._createdDate                                                                 AS 'createdDate',
                bp.id                                                                           AS 'basePayment_id'
FROM odeal.BasePayment bp
         LEFT JOIN odeal.TerminalPayment tp on tp.id = bp.id
         LEFT JOIN odeal.Terminal t on t.id = tp.terminal_id and t.terminalStatus = 1
         LEFT JOIN odeal.POS po ON po.id = bp.posId
         LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId
         LEFT JOIN odeal.Merchant m ON m.id = bp.merchantId and m.role = 0
         LEFT JOIN odeal.Payback pb ON pb.id = bp.paybackId
         LEFT JOIN odeal.BankInfo bi ON bi.id = pb.bankInfoId
         LEFT JOIN odeal.Town tw ON tw.id = o.townId
         LEFT JOIN odeal.City ct ON ct.id = o.cityId
WHERE bp.id in (SELECT DISTINCT bp2.id
                FROM odeal.BasePayment bp2
                         JOIN (SELECT DISTINCT bp3.id
                               FROM odeal.BasePayment bp3
                                        JOIN odeal.Payback pb3 ON pb3.id = bp3.paybackId
                               WHERE pb3.paymentStatus = 1
                                 AND bp3.currentStatus = 6
                                 AND bp3.serviceId <> 3
 AND pb3.dueDate BETWEEN
     "2022-12-01 00:00:00" and
     "2022-12-31 23:59:59"
                               ) AS subquery ON bp2.id = subquery.id)) as BtransFiziki
GROUP BY DATE_FORMAT(BtransFiziki.dueDate,"%Y-%m")