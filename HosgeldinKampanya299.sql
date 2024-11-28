
SELECT t.organisation_id as UyeIsyeriID,
       IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       GROUP_CONCAT(t.serial_no) as MaliNo,
       IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
       t.firstActivationDate as IlkAktivasyonTarihi,
       bp.appliedRate as KomisyonOran,
       bp.signedDate as IslemTarihi,
       bp.amount as IslemTutar,
       bp.id as IslemID
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
                                      AND bp.currentStatus = 6
                                      AND bp.appliedRate = 2.99
                                      AND tp.installment IN (0,1)
                                      AND bp.paymentType IN (0,1,2,3,7,8)
                                      AND bp.signedDate > t.firstActivationDate
WHERE o.activatedAt >= "2024-10-01 00:00:00" AND o.id IN (SELECT Terminaller.id FROM (
SELECT o.id, t.serial_no, t.firstActivationDate, ROW_NUMBER() over (PARTITION BY o.id ORDER BY t.firstActivationDate ASC) as Sira FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id) as Terminaller WHERE Terminaller.Sira = 1 AND Terminaller.firstActivationDate >= "2024-10-01 00:00:00")
GROUP BY t.organisation_id, IF(o.isActivated=1,"Aktif","Pasif"), IF(t.terminalStatus=0,"Pasif","Aktif"), t.firstActivationDate, bp.appliedRate, bp.signedDate, bp.amount, bp.id



SELECT o.id, t.serial_no, t.firstActivationDate, ROW_NUMBER() over (PARTITION BY o.id ORDER BY t.firstActivationDate ASC) as Sira FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
WHERE o.id = 301277839


SELECT t.organisation_id as UyeIsyeriID,
       IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       t.serial_no as MaliNo,
       IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
       t.firstActivationDate as IlkAktivasyonTarihi,
       bp.appliedRate as Komisyon,
       bp.signedDate as IslemTarihi,
       bp.amount as IslemTutar,
       CAST(SUM(bp.amount) OVER (PARTITION BY t.serial_no ORDER BY bp.signedDate, bp.id) AS DECIMAL(10,2)) AS KumulatifTutar,
       bp.id
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
                                      AND bp.currentStatus = 6
                                      AND bp.appliedRate > 1.99 -- 1.99 ÜZERİ BÜTÜN KOMİSYONLAR 1.99 OLARAK MÜŞTERİYE YANSITILACAKTIR.
                                      AND tp.installment IN (0,1)
                                      AND bp.paymentType IN (0,1,2,3,6,7,8)
                                      AND bp.signedDate > t.firstActivationDate
WHERE o.activatedAt >= "2024-10-01 00:00:00" AND o.id IN (SELECT Terminaller.id FROM (
SELECT o.id, t.serial_no, t.firstActivationDate, ROW_NUMBER() over (PARTITION BY o.id ORDER BY t.firstActivationDate ASC) as Sira FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id) as Terminaller
WHERE Terminaller.Sira = 1 AND Terminaller.firstActivationDate >= "2024-10-01 00:00:00");


        SUM(işlem_tutarı) OVER (PARTITION BY müşteri_no ORDER BY işlem_tarihi, işlem_id) AS running_total

                CASE
            WHEN running_total - işlem_tutarı < 100000 AND running_total > 100000 THEN
                100000 - (running_total - işlem_tutarı)
            ELSE işlem_tutarı
        END AS işlem_tutarı

            WHERE
        running_total <= 100000 OR running_total - işlem_tutarı < 100000

WITH OrderedTransactions AS (
SELECT t.organisation_id as UyeIsyeriID,
       IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum,
       t.serial_no as MaliNo,
       IF(t.terminalStatus=0,"Pasif","Aktif") as TerminalDurum,
       t.firstActivationDate as IlkAktivasyonTarihi,
       bp.appliedRate as KomisyonOran,
       bp.signedDate as IslemTarihi,
       CAST(SUM(bp.amount) OVER (PARTITION BY t.serial_no ORDER BY bp.signedDate, bp.id) AS DECIMAL(10,2)) AS running_total,
       bp.amount as IslemTutar,
       bp.id as IslemID
FROM odeal.Terminal t
JOIN odeal.Organisation o ON o.id = t.organisation_id AND o.demo = 0
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
                                      AND bp.currentStatus = 6
                                      AND bp.appliedRate > 1.99 -- 1.99 ÜZERİ BÜTÜN KOMİSYONLAR 1.99 OLARAK MÜŞTERİYE YANSITILACAKTIR.
                                      AND tp.installment IN (0,1)
                                      AND bp.paymentType IN (0,1,2,3,6,7,8)
                                      AND bp.signedDate > t.firstActivationDate
WHERE o.activatedAt >= "2024-10-01 00:00:00" AND o.id IN (SELECT Terminaller.id FROM (
SELECT o.id, t.serial_no, t.firstActivationDate, ROW_NUMBER() over (PARTITION BY o.id ORDER BY t.firstActivationDate ASC) as Sira FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id) as Terminaller
WHERE Terminaller.Sira = 1 AND Terminaller.firstActivationDate >= "2024-10-01 00:00:00")
),
FilteredTransactions AS (
    SELECT
        UyeIsyeriID,
        UyeDurum,
        MaliNo,
        TerminalDurum,
        IlkAktivasyonTarihi,
        KomisyonOran,
        IslemTarihi,
        running_total,
        IslemTutar,
        IslemID,
        CASE
            WHEN running_total - IslemTutar < 100000 AND running_total > 100000 THEN
                100000 - (running_total - IslemTutar)
            ELSE IslemTutar
        END AS BonusTutar
    FROM
        OrderedTransactions
    WHERE
        running_total <= 100000 OR running_total - IslemTutar < 100000
)
SELECT
    MaliNo,
    IslemID,
    IslemTarihi,
    KomisyonOran,
    IslemTutar, running_total
FROM
    FilteredTransactions
ORDER BY
    MaliNo, IslemTarihi, IslemID





SELECT * FROM odeal.Organisation o
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE
