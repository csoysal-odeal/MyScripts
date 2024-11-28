SELECT ca.odeal_id, ca.takipteki_isletme, ca.takipteki_isletme_nedeni, ca.record_owner, ca.created_by, COUNT(*) FROM crm_account ca
WHERE ca.takipteki_isletme IS NOT NULL AND ca.odeal_id IS NOT NULL
GROUP BY ca.takipteki_isletme, ca.takipteki_isletme_nedeni, ca.record_owner, ca.created_by
ORDER BY ca.crm_account_id DESC

SELECT os.mali_no, os.odeal_satis_id, os.organisation_id, os.geri_odeme_tipi FROM odeal_satis os WHERE os.mali_no = "2B25002165"

SELECT *
FROM (
SELECT *,
       ROW_NUMBER() over (PARTITION BY TakipTeki.record_id ORDER BY TakipTeki.created_on) as Sira
       FROM (
SELECT h.history_id, hr.record_id, h.created_on, h.created_by, hr.data
FROM crm_account ca
JOIN history2record hr ON hr.record_id = ca.crm_account_id
JOIN history h ON h.history_id = hr.history_id
WHERE ca.takipteki_isletme = 1 AND h.os_app_id = "crm"
  AND h.os_model_id = "account"
  AND h.created_on >= DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 1 MONTH),"%Y-%m-01 00:00:00")) as TakipTeki) as Takip
       WHERE Takip.Sira = 1 AND Takip.data IS NOT NULL;


SELECT DATE_FORMAT(DATE_SUB(CURDATE(),INTERVAL 0 DAY),"%Y-%m-%d 00:00:00");

SELECT ca.crm_account_id, ca.odeal_id, ca.takipteki_isletme, ca.takipteki_isletme_nedeni FROM crm_account ca WHERE ca.takipteki_isletme = 1;


AND hr.record_id = 472739

SELECT *,
       FIRST_VALUE(TakipTeki.created_on) over (PARTITION BY TakipTeki.record_id ORDER BY TakipTeki.created_on) as OlusmaTarih,
       (CASE WHEN EskiTakipKaydı = 0 THEN TakipTeki.created_on END) AS IlkKayitTarih
FROM (
    SELECT h.history_id, hr.record_id, h.created_on, h.created_by,
           ROW_NUMBER() over (PARTITION BY hr.record_id ORDER BY h.created_on) as Sira,
           JSON_SEARCH(NULLIF(data,''), 'one', 'takipteki_isletme') AS JSONSearch,
           JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.takipteki_isletme')) AS EskiTakipKaydı,
           JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.takipteki_isletme')) AS YeniTakipKaydı
    FROM history h
    JOIN history2record hr ON hr.history_id = h.history_id
    WHERE h.os_app_id = "crm" AND h.os_model_id = "account" AND hr.record_id = 472739 AND hr.data IS NOT NULL
) AS TakipTeki WHERE TakipTeki.Sira = 1 AND (TakipTeki.EskiTakipKaydı = 0 OR TakipTeki.JSONSearch IS NULL);
