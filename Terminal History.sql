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
WHERE th.serialNo = "PAX710075560"

SELECT th.organisationId, th.serialNo, th.physicalSerialId, c.name, town.name,
       MIN(th._createdDate), MAX(th._createdDate), COUNT(*)
FROM odeal.TerminalHistory th
JOIN odeal.Terminal t ON t.serial_no = CONVERT(th.serialNo USING utf8)
JOIN odeal.City c ON c.id = t.setupCityId
JOIN odeal.Town town ON town.id = t.setupTownId
WHERE th.historyStatus = "ACTIVATED" AND c.name = "Ankara"
GROUP BY th.organisationId, th.serialNo, th.physicalSerialId, c.name, town.name HAVING COUNT(*)>1