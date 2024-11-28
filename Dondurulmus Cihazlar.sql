 SELECT * FROM (
        SELECT *, LAG(created_on) OVER(PARTITION BY record_id ORDER BY created_on) previous_created_on FROM (
                SELECT *, ROW_NUMBER() OVER(PARTITION BY record_id, EskiAramaDurum ORDER BY created_on) _rank FROM (
                        SELECT h.created_on, h.history_id, hr.record_id,
                                    JSON_SEARCH(NULLIF(data,''), 'one', 'cfd_arama_durumu_label') AS JSONSearch,
                                    JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.old_values.cfd_arama_durumu_label')) AS EskiAramaDurum,
                                    JSON_UNQUOTE(JSON_EXTRACT(NULLIF(data,''),'$.new_values.cfd_arama_durumu_label')) AS YeniAramaDurum,
                                    CONCAT(u.firstname,' ',u.lastname) AS Temsilci
                        FROM history h
                        JOIN history2record hr ON hr.history_id = h.history_id
                        LEFT JOIN user u ON u.user_id = h.created_by
                        WHERE h.os_app_id = 'odeal' AND h.os_model_id = 'terminal' AND h.created_on > DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
                        ORDER BY h.created_on DESC
                    ) AS Tbl ORDER BY record_id, created_on
            ) AS Tbl2 WHERE _rank = 1 AND (EskiAramaDurum = 'Aranacak' OR JSONsearch IS NULL) ORDER BY record_id, created_on) AS Tbl3
WHERE previous_created_on IS NOT NULL

SELECT * FROM history h
JOIN history2record hr ON hr.history_id = h.history_id
WHERE h.os_app_id = "odeal" AND h.os_model_id = "terminal"
AND h.created_on > DATE_SUB(CURDATE(), INTERVAL 1 MONTH)


SELECT
os.odeal_satis_id as "Satış Id",
os.fiziksel_seri_no as "Fiziki Seri No",
os.organisation_id as "Organizasyon Id",
mali_no as "Mali No",
ot.odeal_id  as "Terminal Id",
fd4.label as "Pasife Alınma Sebebi",
ot.pasife_alinma_tarihi as "Pasife Alınma Tarihi",
fd1.label as "Tedarikçi",
fd2.label as "Yazar Kasa Tipi",
os.yazar_kasa as "Yazar Kasa Sahiplik Durumu",
fd3.label as "Komisyon Tipi",
date(os.sales_date) as "Satış Tarihi",
ac1.city_name as "Kurulum İl",
adt1.town_name  as "Kurulum İlçe",
ac.city_name as "Şehir" ,
adt.town_name as "İlçe",
os.record_owner as "Satış Temsilcisi Id",
CONCAT(u.firstname," ",u.lastname) as "Satış Temsilcisi",
up.profile_name  as "Kiva Rol Bilgisi",
oys.odeal_yazarkasa_sokum_id as "İptal Id",
fd.label as "Deaktif Nedeni",
os.iliskili_firsat as "Fırsat Id"
FROM odeal_terminal ot
LEFT JOIN odeal_satis os ON os.mali_no = ot.serial_no
                  AND os.organisation_id = ot.organisation_id
                  AND (DATEDIFF(date(ot.created_on),date(os.sales_date))<=10)
                  AND (DATEDIFF(date(ot.created_on),date(os.sales_date))>=0)
LEFT JOIN odeal_yazarkasa_sokum oys  ON oys.terminal =ot.odeal_terminal_id
LEFT JOIN field_data fd ON fd.field_data_id = oys.deaktif_nedenleri and fd.field_id  = "deaktif_nedenleri"and fd.os_model_id = "yazarkasa_sokum"
LEFT JOIN field_data fd1 ON fd1.field_data_id = os.tedarikci  and fd1.field_id  = "tedarikci"and fd1.os_model_id = "satis"
LEFT JOIN field_data fd2 ON fd2.field_data_id = os.yazar_kasa_tipi  and fd2.field_id  = "yazar_kasa_tipi"and fd2.os_model_id = "satis"
LEFT JOIN field_data fd3 ON fd3.field_data_id = os.komisyon_tipi  and fd3.field_id  = "komisyon_tipi"and fd3.os_model_id = "satis"
LEFT JOIN field_data fd4 ON fd4.field_data_id = ot.reason_code AND fd4.field_id = "reason_code" AND fd4.os_model_id = "terminal" AND fd4.os_app_id = "odeal"
LEFT JOIN `user` u ON u.user_id=os.record_owner
LEFT JOIN user_profile up ON u.user_profile_id =up.user_profile_id
LEFT JOIN addr_city ac ON ac.addr_city_id=os.sehir
LEFT JOIN addr_city ac1 ON ac1.addr_city_id=os.kurulum_il
LEFT JOIN addr_town adt ON adt.addr_town_id =os.ilce
LEFT JOIN addr_town adt1 ON adt1.addr_town_id =os.kurulum_ilce
LEFT JOIN crm_potential cp ON cp.crm_potential_id=os.iliskili_firsat
WHERE os.organisation_id LIKE "301%" AND mali_no IS NOT NULL AND ot.reason_code = 1
ORDER BY ot.pasife_alinma_tarihi