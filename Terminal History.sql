SELECT * FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710075166" AND th.serialNo LIKE "%PAX%" AND th.id IN (
SELECT MAX(th.id) FROM odeal.TerminalHistory th
GROUP BY th.serialNo);

SELECT * FROM odeal.TerminalHistory th WHERE th.serialNo = "PAX710002642";

SELECT *, t.serial_no, t.setupCityId, t.setupTownId FROM odeal.TerminalHistory th
JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
WHERE th.serialNo = "PAX710044975" AND th.historyStatus = "ACTIVATED"

SELECT th.serialNo, th.organisationId, th.physicalSerialId, th.historyStatus, th._createdDate, t.serial_no,c.name as Sehir,town.name as Ilce  FROM odeal.TerminalHistory th
JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
JOIN odeal.City c ON c.id = t.setupCityId
JOIN odeal.Town town ON town.id = t.setupTownId
WHERE th.historyStatus = "ACTIVATED" AND c.name = "Ankara"

SELECT *, t.serial_no, t.setupCityId, t.setupTownId FROM odeal.TerminalHistory th
JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
WHERE th.serialNo = "PAX710036144" AND th.historyStatus = "ACTIVATED"

SELECT th.organisationId, th.serialNo, th.physicalSerialId, c.name, town.name,
       MIN(th._createdDate), MAX(th._createdDate), COUNT(*)
FROM odeal.TerminalHistory th
JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
JOIN odeal.City c ON c.id = t.setupCityId
JOIN odeal.Town town ON town.id = t.setupTownId
WHERE th.historyStatus = "ACTIVATED" AND c.name = "Ankara"
GROUP BY th.organisationId, th.serialNo, th.physicalSerialId, c.name, town.name HAVING COUNT(*)>1

SELECT o.id, IF(o.isActivated=1,"Aktif","Pasif") as UyeDurum FROM odeal.Organisation o

SELECT * FROM subscription.SubscriptionHistory sh
         LEFT JOIN subscription.Invoice i ON i.subscriptionId = sh.subscriptionId
         WHERE sh.id IN (
SELECT MAX(sh.id) FROM subscription.SubscriptionHistory sh GROUP BY sh.subscriptionId) AND i.organisationId = 301000162


SELECT s.account_no,
       s.merchant_id,
       s.transferred_account_id,
       s.id as SourceID,
       s.terminal_id,
       t.serial_no,
       s.tckn,
       s.masked_card_number as KartNo,
       CASE WHEN s.status = 'ACTIVATED' THEN 'AKTİF'
            WHEN s.status = 'OTHER' THEN 'DİĞER'
            WHEN s.status = 'WAITING_VERIFICATION' THEN 'DOĞRULAMA BEKLENİYOR'
            WHEN s.status = 'CANCELED' THEN 'İPTAL'
       END as KartBasvuruDurum,
       s.reason as KartDurum,
       s.request_date as TalepTarihi,
       s.group_date as BasimTarihi,
       s.available_amount as KartBakiyesi,
       DATEDIFF(DATE(s.group_date), DATE(s.request_date)) as Talep_BasimGunFark,
       s._createdDate
FROM payout_source.source s
LEFT JOIN odeal.Terminal t ON t.id = s.terminal_id AND t.organisation_id = s.merchant_id
WHERE s.type = 'FIBACARD' AND s.merchant_id <> 301196774
AND s.merchant_id NOT IN (301082761,301253079,301130442,301263531,301264751,301264757,301265031,301265705,301266242,301267382,301267622,301268032,301160192)
AND s.status <> 'CANCELED'