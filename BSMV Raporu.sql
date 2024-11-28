 -- OKC BSMV Report
SELECT UniqueKey.uniqueKey, COUNT(*) FROM (SELECT bp.id,
           bp.paymentId                                                                      as paymentId,
           pb.paybackId                                                                      as paybackId,
           bp.signedDate                                                                     as signedDate,
           COALESCE(pb.dueDate, pb.paidDate)                                                 AS paybackDate,
           IF(COALESCE(p.installment, tp.installment, 1) = 0, 1,COALESCE(p.installment, tp.installment, 1))                                    AS installment,
           COALESCE(c.brand, 'DEFAULT')                                                      as brand,
           COALESCE(bp.cardNumber, c.number)                                                 as cardNumber,
           bp.organisationId                                                                 as organisationId,
           IF(tp.id > 0, plan.name, 'CEP_POS_PLAN')                                          as planName,
           pos.name                                                                          as posName,
           bp.amount                                                                         as amount,
           br.net_amount                                                                     as netAmount,
           bp.appliedRate                                                                    as appliedRate,
           bp.paymentType                                                                    as paymentType,
           bin.bankCode                                                                      as binBankCode,
           binBank.name                                                                      as binBankName,
           bin.brand                                                                         as binBrand,
           CONVERT(br.bank_commission_amount, DECIMAL(10, 2))                                as bankCommissionAmount,
           br.is_manuel,
           bp.uniqueKey
    FROM odeal.BasePayment bp
             LEFT JOIN odeal.Payment p ON p.id = bp.id
             LEFT JOIN odeal.Payback pb ON pb.id = bp.paybackId
             LEFT JOIN odeal.TerminalPayment tp ON tp.id = bp.id
             LEFT JOIN odeal.Terminal t ON t.id = tp.terminal_id
             LEFT JOIN subscription.Subscription s ON s.id = t.subscription_id
             LEFT JOIN subscription.Plan plan ON plan.id = s.planId
             LEFT JOIN odeal.Organisation o ON o.id = bp.organisationId
             LEFT JOIN odeal.POS pos ON pos.id = bp.posId
             LEFT JOIN odeal.CreditCard c ON c.id = bp.cardId
             LEFT JOIN odeal.BinInfo bin on bin.bin = substr(COALESCE(bp.cardNumber, c.lastDigits, c.number), 1, 6)
             LEFT JOIN odeal.Bank binBank on CONVERT(binBank.bankCode, UNSIGNED INTEGER) = CONVERT(bin.bankCode, UNSIGNED INTEGER)
             LEFT JOIN odeal.InstallmentBrand ib on CONVERT(ib.name USING UTF8) = CONVERT(COALESCE(c.brand, (select bin.brand from odeal.BinInfo bin where bin = substr(c.lastDigits, 1, 6)), 'DEFAULT')USING UTF8)
           --  LEFT JOIN paymatch.matched_payment mp on bp.id = mp.base_payment_id
             LEFT JOIN paymatch.bank_report br on bp.uniqueKey = br.unique_key
    WHERE COALESCE(pb.dueDate, pb.paidDate) >= '2023-10-01'
      AND COALESCE(pb.dueDate, pb.paidDate) < '2023-11-01'
     --  AND br.is_manuel = true
      AND bp.currentStatus = 6
      AND bp.paymentType != 4
      AND pb.paymentStatus in (1,5)
      and bp.paymentType = 7
and bp.uniqueKey = '20230731:5168:**92:154600:1600') as UniqueKey
GROUP BY UniqueKey.uniqueKey