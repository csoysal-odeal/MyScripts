select ps.*,
       ISLEM.dueDate,
       ISLEM.supplier,
       'okc1' as durum
from odeal.payment_summary ps
         JOIN (SELECT bp.batchNo,
                      bp.organisationId,
                      t.serial_no,
                      p.bank_id,
                      t.supplier,
                      ANY_VALUE(pb.dueDate) AS dueDate
               FROM odeal.BasePayment bp
                        JOIN odeal.TerminalPayment tp on tp.id = bp.id
                        JOIN odeal.Terminal t on t.id = tp.terminal_id
                        JOIN odeal.POS p on p.id = bp.posId
                        join odeal.Payback pb on pb.id = bp.paybackId
                        join odeal.BankInfo bi on bi.id = pb.bankInfoId and bi.status = 1
                        JOIN odeal.Merchant m on m.organisationId = bp.organisationId and m.role = 0
               where pb.creationDate > DATE_FORMAT(NOW() - INTERVAL 14 DAY, '%Y-%m-%d 00:00:00')
                 and pb.creationDate < DATE_FORMAT(NOW(), '%Y-%m-%d 00:00:00')
                 and bp.serviceId in (2, 4, 5, 7)
                 and bp.paybackId is not null
                 and pb.amount > 0
                 and pb.paymentStatus in (1, 5)
                 and pb.dueDate >= DATE_FORMAT(NOW() - INTERVAL 14 DAY, '%Y-%m-%d 00:00:00')
                 and pb.dueDate <= DATE_FORMAT(NOW(), '%Y-%m-%d 23:59:59')
                 and bp.signedDate > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
               group by bp.batchNo, bp.organisationId, t.serial_no, p.bank_id, t.supplier) as ISLEM on
    ISLEM.batchNo = ps.batch_id and ISLEM.organisationId = ps.organisation_id and
    ISLEM.serial_no = ps.terminal_serial_no and ISLEM.bank_id = ps.bank_id
where ps.payback_id is not null
  and ps.status = 'EOD_MATCHED'
  and ps.created_at > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
UNION
select ps.*,
       ISLEM2.dueDate,
       ISLEM2.supplier,
       'okc2' as durum
from odeal.payment_summary ps
         JOIN (SELECT bp.batchNo,
                      bp.organisationId,
                      t.serial_no,
                      t.supplier
               FROM odeal.BasePayment bp
                        JOIN odeal.TerminalPayment tp on tp.id = bp.id
                        JOIN odeal.Terminal t on t.id = tp.terminal_id
                        JOIN odeal.POS p on p.id = bp.posId
                        LEFT join odeal.Payback pb on pb.id = bp.paybackId
                        join odeal.BankInfo bi on bi.id = pb.bankInfoId and bi.status = 1
                        JOIN odeal.Merchant m on m.organisationId = bp.organisationId and m.role = 0
                        left join paymatch.matched_payment mp on mp.base_payment_id = bp.id
               where 
                 bp.serviceId in (2, 4, 5, 7)
                 and bp.paybackId is null
                 and bp.signedDate > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
               group by bp.batchNo, bp.organisationId, t.serial_no, t.supplier) as ISLEM2 on
    ISLEM2.batchNo = ps.batch_id and ISLEM2.organisationId = ps.organisation_id and
    ISLEM2.serial_no = ps.terminal_serial_no and ISLEM2.bank_id = ps.bank_id
where ps.payback_id is null
  and ps.created_at > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
  

  SELECT bp.batchNo,
                      bp.organisationId,
                      t.serial_no,
                      p.bank_id,
                      t.supplier,
                      ANY_VALUE(pb.dueDate) AS dueDate
               FROM odeal.BasePayment bp
                        JOIN odeal.TerminalPayment tp on tp.id = bp.id
                        JOIN odeal.Terminal t on t.id = tp.terminal_id
                        JOIN odeal.POS p on p.id = bp.posId
                        join odeal.Payback pb on pb.id = bp.paybackId
                        join odeal.BankInfo bi on bi.id = pb.bankInfoId and bi.status = 1
                        JOIN odeal.Merchant m on m.organisationId = bp.organisationId and m.role = 0
                        join paymatch.matched_payment mp on mp.base_payment_id = bp.id
               where pb.creationDate <= DATE_FORMAT(NOW() - INTERVAL 14 DAY , '%Y-%m-%d 00:00:00')
                 and pb.creationDate >= DATE_FORMAT(NOW(),'%Y-%m-%d 00:00:00')
                 and bp.serviceId in (2, 4, 5, 7)
                 and bp.paybackId is not null
                 and pb.amount > 0
                 and pb.paymentStatus in (1, 5)
                 and pb.dueDate >= DATE_FORMAT(NOW()-INTERVAL 14 DAY, '%Y-%m-%d 00:00:00')
                 and pb.dueDate <= DATE_FORMAT(NOW(), '%Y-%m-%d 23:59:59')
                 and bp.signedDate > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
               group by bp.batchNo, bp.organisationId, t.serial_no, p.bank_id, t.supplier
 
               
               
SELECT bp.batchNo,
                      bp.organisationId,
                      t.serial_no,
                      p.bank_id,
                      t.supplier,
                      ANY_VALUE(pb.dueDate) AS dueDate
               FROM odeal.BasePayment bp
                        JOIN odeal.TerminalPayment tp on tp.id = bp.id
                        JOIN odeal.Terminal t on t.id = tp.terminal_id
                        JOIN odeal.POS p on p.id = bp.posId
                        join odeal.Payback pb on pb.id = bp.paybackId
                        join odeal.BankInfo bi on bi.id = pb.bankInfoId and bi.status = 1
                        JOIN odeal.Merchant m on m.organisationId = bp.organisationId and m.role = 0
               where pb.creationDate > DATE_FORMAT(NOW() - INTERVAL 14 DAY, '%Y-%m-%d 00:00:00')
                 and pb.creationDate < DATE_FORMAT(NOW(), '%Y-%m-%d 00:00:00')
                 and bp.serviceId in (2, 4, 5, 7)
                 and bp.paybackId is not null
                 and pb.amount > 0
                 and pb.paymentStatus in (1, 5)
                 and pb.dueDate >= DATE_FORMAT(NOW() - INTERVAL 14 DAY, '%Y-%m-%d 00:00:00')
                 and pb.dueDate <= DATE_FORMAT(NOW(), '%Y-%m-%d 23:59:59')
                 and bp.signedDate > DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 3 MONTH), '%Y-%m-%d 23:59:59')
               group by bp.batchNo, bp.organisationId, t.serial_no, p.bank_id, t.supplier
               
               
SELECT bp.id, bp.paybackId, bp.amount, bp.signedDate, p.paybackId 
FROM odeal.BasePayment bp 
LEFT JOIN odeal.Payback p ON p.id = bp.paybackId 
WHERE p.paybackId IS NULL and bp.currentStatus = 6 AND bp.signedDate >= "2024-05-20 00:00:00"

SELECT * FROM payout_source.source s

SELECT t.serial_no as MaliNo, IF(t.terminalStatus=1,"AKTİF","PASİF") as TerminalDurum, t.firstActivationDate as AktivasyonTarihi, s.cancelledAt as IptalTarihi FROM odeal.Terminal t 
LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
WHERE t.serial_no = "PAX710038062"
 