SELECT t.serial_no    AS 'Mali No',
       t.firstActivationDate AS 'Terminalin İlk Aktivasyon Tarihi',
       s.cancelledAt  AS 'Abonelik Pasiflenme Tarihi',
       t._createdDate                                 AS 'Terminal Oluşma Tarihi',
       IF(t.terminalStatus=1,"Aktif","Pasif") AS 'Terminal Durumu',
       c.name                                         AS 'Kanal',
       o.id                                           AS 'Organizasyon Id',
       o.organisationId                               AS 'Organizasyon Id - Random',
       o.unvan                                        AS 'Unvan',
       o.marka                                        AS 'Marka',
       sc.sector_name                                 AS 'Sektor',
       ci.name AS 'Organizasyonun Şehir Bilgisi',
       t.subscription_id                              AS 'Abonelik Id',
       IF(s.status = 1, 'Aktif', 'Pasif')             AS 'Abonelik Durumu',
       s.planId                                       AS 'Plan Id',
       p.name                                         AS 'Plan Adı',
       p.amount                                       AS 'Terminalin Aylık Ucret Bilgisi',
       IF((SELECT bp2.id
           FROM odeal.BasePayment bp2
                    JOIN odeal.TerminalPayment tp on tp.id = bp2.id
                    JOIN odeal.Terminal t2 on t2.id = tp.terminal_id
           WHERE bp2.currentStatus = 6
             and bp2.amount > 1
             AND t2.id = t.id
           limit 1) is null, 'YOK', 'VAR')            AS 'Başarılı İşlemi Var mı'
FROM odeal.Terminal t
         JOIN odeal.Organisation o ON o.id = t.organisation_id
         JOIN subscription.Subscription s ON s.id = t.subscription_id
         JOIN subscription.Plan p ON p.id = s.planId
         LEFT OUTER JOIN odeal.Channel c ON c.id = t.channelId
         JOIN odeal.City ci ON ci.id = o.cityId
         JOIN odeal.Sector sc ON sc.id = o.sectorId
where t.serial_no
          IN ("PAX710053295","2B25022300","2B20136932")
ORDER BY t._createdDate DESC;
