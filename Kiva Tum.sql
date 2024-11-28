SELECT u.user_id, CONCAT(u.firstname," ",u.lastname) as AdSoyad, u.status FROM user u

SELECT ot.serial_no, ot.reason_code, fd.label FROM odeal_terminal ot
         LEFT JOIN field_data fd ON fd.field_data_id = ot.reason_code AND fd.field_id = "reason_code" AND fd.os_app_id = "odeal"
         AND fd.os_model_id = "terminal"
         WHERE ot.reason_code IS NOT NULL AND ot.reason_code = 1

SELECT * FROM field_data fd WHERE fd.os_app_id = "callcenter" AND fd.os_model_id = "call" AND fd.field_id = "pool"

SELECT cc.pool, cp.pool_name, COUNT(*)  FROM callcenter_call cc
                          LEFT JOIN callcenter_lead_pool cp ON cp.callcenter_lead_pool_id = cc.pool
group by cc.pool, cp.pool_name

SELECT * FROM(
SELECT
ticket_issue_id,
issue_number,
ti.crm_account_id,
ca.name, ca.unvan, ca.odeal_id,
ttt.subject as talepTuru,
ttt2.subject as talepTipi,
tta.subject as talepAltTipi,
ti.talep_alttipi,
fd3.label as resource,
fd6.label as requestType,
fd.label as talepEden,
fd2.label as ilgliEkip,
CONCAT(u.firstname," ",u.lastname) as Atanan,
CONCAT(u1.firstname," ",u1.lastname) as Atayan,
CONCAT(u2.firstname," ",u2.lastname) as Olusturan,
up.profile_name as yonlendirilenRol,
ti.analiz_gerektiriyor,
ti.subject,
ti.status,
ti.aciklama,
dt.detail_text,
fd1.label as lastStatus,
ti.assigned_response_time,
ti.assign_response_time,
ti.closed_time,
ti.first_touch_time,
ti.resolution_time,
ti.created_on as talepYaratılmaTarihi,
DATE_FORMAT(ti.created_on, '%Y-%m') as Donem,
ti.last_modified_on,
ti.status as Tstatus,
ti.hatali_talep_,
ti.record_owner as AtayanID,
ti.assigned as AtananID,
ti.created_by as OlusturanID,
dt.ticket_detail_id,
dt.Dstatus,
dt.last_time,
dt.detailStatus,
dt.detayKayıtAcan,
dt.created_on as detayYaratılmaTarihi,
dt.SonrakiIslemTarihi,
ROW_NUMBER() OVER (PARTITION BY ti.ticket_issue_id ORDER BY dt.ticket_detail_id DESC) as _Sira,
dt.IlkAciklama,
ti.last_text,
fd4.label as Urun
FROM ticket_issue ti
LEFT JOIN crm_account ca ON ca.crm_account_id = ti.crm_account_id
LEFT JOIN field_data fd ON ti.talep_eden=fd.field_data_id  AND fd.os_model_id="issue" AND fd.os_app_id="ticket" AND fd.field_id="talep_eden"
LEFT JOIN field_data fd1 ON ti.last_status=fd1.field_data_id  AND fd1.os_model_id="issue" AND fd1.os_app_id="ticket" AND fd1.field_id="last_status"
LEFT JOIN field_data fd2 ON ti.ilgili_ekip =fd2.field_data_id  AND fd2.os_model_id="issue" AND fd2.os_app_id="ticket" AND fd2.field_id="ilgili_ekip"
LEFT JOIN field_data fd3 ON ti.resource =fd3.field_data_id  AND fd3.os_model_id="issue" AND fd3.os_app_id="ticket" AND fd3.field_id="resource"
LEFT JOIN field_data fd6 ON ti.request_type =fd6.field_data_id  AND fd6.os_model_id="issue" AND fd6.os_app_id="ticket" AND fd6.field_id="request_type"
LEFT JOIN field_data fd4 ON ti.urun = fd4.field_data_id AND fd4.os_app_id = "ticket" AND fd4.os_model_id = "issue" AND fd4.field_id = "urun"
LEFT JOIN ticket_talep_turleri ttt ON ttt.ticket_talep_turleri_id=ti.talep_turu
LEFT JOIN ticket_talep_tipleri ttt2 ON ttt2.ticket_talep_tipleri_id=ti.talep_tipi
LEFT JOIN ticket_talep_alttipleri tta ON tta.ticket_talep_alttipleri_id =ti.talep_alttipi
LEFT JOIN user u ON u.user_id = ti.assigned
LEFT JOIN user u1 ON u1.user_id = ti.record_owner
LEFT JOIN user u2 ON u2.user_id = ti.created_by
LEFT JOIN user_profile up ON u1.user_profile_id  =up.user_profile_id
LEFT JOIN (SELECT
      ticket_detail_id,
      td.detail_text,
      FIRST_VALUE(td.detail_text) over (PARTITION BY td.ticket_issue ORDER BY td.ticket_detail_id) as IlkAciklama,
      td.status as Dstatus,
      last_time,
      fd.label as detailStatus,
      ticket_issue,
      CONCAT(u.firstname," ",u.lastname) as detayKayıtAcan,
      td.created_on,
      IFNULL(LEAD (td.created_on) OVER (PARTITION BY td.ticket_issue ORDER BY td.created_on), NOW()) as SonrakiIslemTarihi
      FROM ticket_detail td
      LEFT JOIN `user` u ON u.user_id=td.record_owner
      LEFT JOIN field_data fd ON td.detail_status =fd.field_data_id  AND fd.os_model_id="detail" AND fd.os_app_id="ticket" AND fd.field_id="detail_status") dt
      ON dt.ticket_issue=ti.ticket_issue_id) as YardimTalepleri
      WHERE YardimTalepleri._Sira = 1 AND YardimTalepleri.talepYaratılmaTarihi >= "2024-01-01 00:00:00" AND YardimTalepleri.ticket_issue_id = 93962

SELECT ca.unvan FROM crm_account ca WHERE ca.crm_account_id = 218696
