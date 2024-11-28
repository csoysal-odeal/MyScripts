SELECT * FROM history h 
JOIN history2record hr ON hr.history_id = h.history_id 
WHERE h.os_app_id = "odeal" AND h.os_model_id = "satis" AND hr.record_id = 98855 AND h.created_on >= "2024-02-10 00:00:00"

SELECT * FROM history h 
WHERE h.os_app_id = "odeal" AND h.os_model_id = "satis" AND h.created_on >= "2024-02-10 00:00:00"


