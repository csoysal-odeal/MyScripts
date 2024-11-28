SELECT DISTINCT o.id, t.serial_no,
-- ROW_NUMBER() OVER(PARTITION BY o.id ORDER BY t.firstActivationDate) as RN,
SUM(bp.amount) OVER(PARTITION BY t.serial_no) as ToplamCiro
-- LAG(t.serial_no) OVER(PARTITION BY o.id ORDER BY t.firstActivationDate) as Pre,
-- LEAD(t.serial_no) OVER(PARTITION BY o.id ORDER BY t.firstActivationDate) as Nxt
FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id 
JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id 
JOIN odeal.BasePayment bp ON bp.id = tp.id
JOIN subscription.Service s ON s.id = bp.serviceId
WHERE o.id = 301000195 AND bp.currentStatus = 6

SELECT * FROM (
SELECT th.organisationId, th.serialNo, th.physicalSerialId, th.historyStatus, th.`_createdDate`,
ROW_NUMBER() OVER(PARTITION BY th.serialNo ORDER BY th.`_createdDate` DESC) as Son
FROM odeal.TerminalHistory th) as SonKayit
WHERE SonKayit.Son = 1 AND SonKayit.serialNo = "PAX710003039"

SELECT * FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710003039"

SELECT DATE_FORMAT(bp.signedDate,"%Y-%m-%d") as Ay,  bp.serviceId, SUM(bp.amount) as Ciro, COUNT(bp.id) as IslemAdet FROM odeal.BasePayment bp 
WHERE bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH),"%Y-%m-01 00:00:00") AND bp.signedDate <= NOW() AND bp.currentStatus = 6 AND bp.serviceId = 2
GROUP BY bp.serviceId, DATE_FORMAT(bp.signedDate,"%Y-%m-%d")


 SELECT DISTINCT p.paybackId                AS 'Geri Ödeme Id',
       p.dueDate                  AS 'Geri Ödeme Tarihi',
       Islem.Ciro                 as IslemTutar,
       Islem.Komisyon,
       Islem.GeriOdemeyeEsasTutar as GeriOdemeyeEsas,
       p.amount              as GeriOdemeTutar,
       KesintiDetay.KesintiTutar  AS 'Geri Ödemeden Yapılan Kesinti Tutarı',
       KesintiDetay.id         AS 'Diğer Kesinti Id',
       KesintiDetay.KesintiTarihi AS 'Kesinti Tarihi'
FROM odeal.Payback p
         JOIN (SELECT bp.paybackId,
                      bp.paybackAmount as GeriOdemeyeEsasTutar,
                      bp.amount        as Ciro,
                      COUNT(bp.id)          as IslemAdet,
                      MAX(bp.appliedRate)   as Komisyon
               FROM odeal.BasePayment bp
                        LEFT JOIN odeal.Payback p2 ON bp.paybackId = p2.id
               WHERE p2.dueDate >= "2024-03-01 00:00:00"
                 AND p2.dueDate <= "2024-03-31 23:59:59"
               GROUP BY bp.paybackId, bp.paybackAmount, bp.amount) as Islem ON Islem.paybackId = p.id
         JOIN (SELECT cd.id,
                           cd.fixedPaybackId,
                           SUM(cd.fixedAmount) as KesintiTutar,
                           cd.createDate       as KesintiTarihi
                    FROM odeal.CutDetail cd
                             JOIN odeal.Cut c ON c.id = cd.cutId
                    GROUP BY cd.id, cd.fixedPaybackId, cd.createDate) as KesintiDetay
                   ON KesintiDetay.fixedPaybackId = p.id
                   WHERE KesintiDetay.id IS NOT NULL AND p.organisationId = 301249469 AND p.id = 44424573

SELECT * FROM odeal.Payback p WHERE p.paybackId = 57522066177

SELECT * FROM odeal.BasePayment bp WHERE bp.paybackId = 44424573

SELECT DISTINCT bp.id, bp.amount, bp.paybackAmount, bp.paybackId, Kesinti.id, Kesinti.KesintiTutar,
SUM(bp.amount) OVER (PARTITION BY bp.paybackId) as ToplamGeriOdeme
FROM odeal.BasePayment bp 
JOIN odeal.Payback p ON p.id = bp.paybackId
JOIN(SELECT cd.id,
                           cd.fixedPaybackId,
                           SUM(cd.fixedAmount) as KesintiTutar,
                           cd.createDate       as KesintiTarihi
                    FROM odeal.CutDetail cd
                             JOIN odeal.Cut c ON c.id = cd.cutId
                    GROUP BY cd.id, cd.fixedPaybackId, cd.createDate) as Kesinti ON Kesinti.fixedPaybackId = bp.paybackId
WHERE p.id = 44424573 AND bp.organisationId = 301249469

SELECT bp.paybackId, bp.id, bp.signedDate, bp.amount FROM odeal.BasePayment bp WHERE bp.currentStatus = 6 AND bp.paybackId =44424573
 

SELECT DISTINCT cd.id, cd.fixedPaybackId, cd.fixedAmount, Islem.paybackId, Islem.amount FROM odeal.CutDetail cd
LEFT JOIN (SELECT bp.paybackId, bp.id, bp.signedDate, bp.amount FROM odeal.BasePayment bp WHERE bp.currentStatus = 6 AND bp.paybackId = 44424573) as Islem ON Islem.paybackId = cd.fixedPaybackId
WHERE cd.fixedPaybackId = 44424573

SELECT * FROM odeal.CutDetail cd WHERE cd.fixedPaybackId = 44424573


 SELECT p.paybackId                AS 'Geri Ödeme Id',
       p.dueDate                  AS 'Geri Ödeme Tarihi',
       Islem.Ciro                 as IslemTutar,
       Islem.Komisyon,
       Islem.GeriOdemeyeEsasTutar as GeriOdemeyeEsas,
       SUM(p.amount)              as GeriOdemeTutar,
       KesintiDetay.KesintiTutar  AS 'Geri Ödemeden Yapılan Kesinti Tutarı',
       KesintiDetay.cutId         AS 'Diğer Kesinti Id',
       KesintiDetay.KesintiTarihi AS 'Kesinti Tarihi'
FROM odeal.Payback p
         JOIN (SELECT bp.paybackId,
                      SUM(bp.paybackAmount) as GeriOdemeyeEsasTutar,
                      SUM(bp.amount)        as Ciro,
                      COUNT(bp.id)          as IslemAdet,
                      MAX(bp.appliedRate)   as Komisyon
               FROM odeal.BasePayment bp
                        LEFT JOIN odeal.Payback p2 ON bp.paybackId = p2.id
               WHERE p2.dueDate >= "2024-03-01 00:00:00"
                 AND p2.dueDate <= "2024-03-31 23:59:59"
               GROUP BY bp.paybackId) as Islem ON Islem.paybackId = p.id
         LEFT JOIN (SELECT cd.cutId,
                           cd.fixedPaybackId,
                           SUM(cd.fixedAmount) as KesintiTutar,
                           cd.createDate       as KesintiTarihi
                    FROM odeal.CutDetail cd
                             JOIN odeal.Cut c ON c.id = cd.cutId
                    GROUP BY cd.cutId, cd.fixedPaybackId, cd.createDate) as KesintiDetay
                   ON KesintiDetay.fixedPaybackId = p.id
WHERE p.organisationId = 301249469
  AND p.id = 44424573
GROUP BY p.id, KesintiDetay.KesintiTutar, KesintiDetay.cutId, KesintiDetay.KesintiTarihi


SELECT bmt.serial_no, bmt.bank_name, COUNT(*) FROM paymatch.bank_mid_tid bmt 
WHERE bmt.device_status = "Aktif"
GROUP BY bmt.serial_no, bmt.bank_name HAVING COUNT(*)>1

SELECT * FROM paymatch.bank_mid_tid bmt WHERE bmt.serial_no = "BCJ00066417"

SELECT Islemler.id, Islemler.batchNo, SUM(Islemler.amount) as Toplam, COUNT(Islemler.IslemId) as IslemAdet FROM (
SELECT o.id, bp.organisationId, t.serial_no, bp.id as IslemId, bp.batchNo, bp.signedDate, bp.amount, bp.isExternallyGenerated, bp.`_createdDate`, bp.uniqueKey FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= NOW()) as Islemler WHERE Islemler.id = 301133784 AND Islemler.batchNo = 1
GROUP BY Islemler.id, Islemler.batchNo

301133784 PAX710048125

SELECT ps.organisation_id, ps.terminal_serial_no, ps.payment_amount, ps.payment_count, Islemler.amount, Islemler.signedDate FROM odeal.payment_summary ps
LEFT JOIN (SELECT o.id, bp.organisationId, t.serial_no, bp.id as IslemID, bp.batchNo, bp.signedDate, bp.amount, bp.isExternallyGenerated, bp.`_createdDate`, bp.uniqueKey FROM odeal.Organisation o 
LEFT JOIN odeal.Terminal t ON t.organisation_id = o.id 
LEFT JOIN odeal.TerminalPayment tp ON tp.terminal_id = t.id
LEFT JOIN odeal.BasePayment bp ON bp.id = tp.id
WHERE bp.signedDate >= "2023-01-01 00:00:00" AND bp.signedDate <= NOW()) as Islemler ON Islemler.id = ps.organisation_id AND Islemler.serial_no = ps.terminal_serial_no
WHERE ps.organisation_id = 301133784 AND ps.terminal_serial_no = "PAX710048125"

SELECT * FROM paymatch.eod_received_payment erp 



SELECT * FROM paymatch.bank_report br WHERE br.unique_key IN ("20240308:5549:**08:423561:7000",
"20240308:5235:**41:111581:15000")

SELECT o.id as UyeID, c.name as Sehir, t2.name as Ilce, bp.id as IslemID, bp.amount as IslemTutar, bp.serviceId,
bp.signedDate as IslemTarih, bp.`_createdDate` as IslemOlusmaTarih, bp.paymentId, bp.paymentType, bp.batchNo, bp.cardNumber, fp.installment, fp.id, fp.installmentBrand,
fp.failedAt, fp.reason, fp.provider, fp.longitude, fp.latitude, p.name FROM odeal.BasePayment bp
LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
LEFT JOIN odeal.FailedPayment fp ON fp.paymentId = bp.paymentId
LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId 
LEFT JOIN odeal.City c ON c.id = o.cityId 
LEFT JOIN odeal.Town t2 ON t2.id = o.townId
LEFT JOIN odeal.POS p ON p.id = bp.posId
WHERE bp.signedDate >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 WEEK),"%Y-%m-%d 00:00:00") AND bp.paymentType <> 4

SELECT c.name, SUM(bp.amount) FROM odeal.BasePayment bp 
JOIN odeal.TerminalPayment tp ON tp.id = bp.id 
JOIN odeal.Terminal t ON t.id = tp.terminal_id 
LEFT JOIN odeal.Channel c ON c.id = t.channelId 
WHERE bp.currentStatus = 6 AND bp.signedDate >= "2024-01-01 00:00:00" AND c.name LIKE "%İş Ortağı%"
GROUP BY c.name

SELECT * FROM odeal.FailedPayment fp
WHERE fp.paymentId = 09362251

