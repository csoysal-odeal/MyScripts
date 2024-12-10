
SELECT ROW_NUMBER() OVER (PARTITION BY wog.SerialNumber, wog.WorkOrderType ORDER BY wog.CreatedDate) as Sira, wog.*
FROM stargate.WorkOrderLog wog WHERE wog.SerialNumber LIKE "%PAX%";

SELECT
    wog.serialNumber,
    JSON_ARRAYAGG(
        JSON_OBJECT('status', wog.status, 'createdDate', wog.createdDate)
    ) AS statusCreatedDateJson
FROM stargate.WorkOrderLog wog
WHERE wog.SerialNumber = "PAX710024069" AND wog.WorkOrderType = "SETUP"
GROUP BY wog.serialNumber;

SELECT
    serialNumber,
    status,
    createdDate,
    COUNT(*) AS duplicateCount
FROM
    stargate.WorkOrderLog
WHERE
    serialNumber = "PAX710024069"
GROUP BY
    serialNumber, status, createdDate
HAVING
    COUNT(*) > 1;




SELECT  wog.Status, COUNT(*) FROM stargate.WorkOrderLog wog
GROUP BY  wog.Status;

PAX710024069 TEKNİSYEN

PAX710024058 KARGO