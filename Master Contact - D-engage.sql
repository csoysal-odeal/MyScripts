select
  *,
  o._lastModifiedDate lastModifiedDate
from
  (
    SELECT
      m.id as EntityId,
      DATE_FORMAT(
        IF (
          m._lastModifiedDate > org._lastModifiedDate,
          m._lastModifiedDate, org._lastModifiedDate
        ),
        '%Y-%m-%d %H:%i:%s'
      ) as _lastModifiedDate,
      json_object(
        'contact_key',
        m.id,
        'name',
        m.firstName,
        'surname',
        m.LastName,
        'gsm',
        IF(m.phone IS NULL, '', m.phone),
        'email',
        IF(m.email IS NULL, '', m.email),
        'birth_date',
        IF(
          DATE_FORMAT(
            m.birthDate, '%Y-%m-%d %H:%i:%s'
          ) IS NULL,
          '',
          m.birthDate
        ),
        'gender',
        IF(m.gender IS NULL, '', m.gender),
        'activated_at',
        IF(
          org.activatedAt IS NULL, '', org.activatedAt
        ),
        'city',
        IF(org.city IS NULL, '', org.city),
        'brand_name',
        IF(org.marka IS NULL, '', org.marka),
        'channel_name',
        IF(c.name IS NULL, '', c.name),
        'deactivation_date',
        IF(
          DATE_FORMAT(
            org.deActivatedAt, '%Y-%m-%d %H:%i:%s'
          ) IS NULL,
          '',
          org.deActivatedAt
        ),
        'contact_status',
        CASE WHEN m.isActive = 0 THEN 'P' WHEN m.isActive = 1 THEN 'A' END,
        'merchant_id',
        m.organisationId,
        'is_activated',
        CASE WHEN org.isActivated = 1 THEN 'A' ELSE 'P' END,
        'contact_type',
        'TACIR',
        'contact_role',
        CASE WHEN m.role = 0 THEN 'YETKILI' WHEN m.role = 1 THEN 'CALISAN' END
      ) AS metadata
    FROM
      odeal.Merchant m
      JOIN (
        SELECT
          id,
          status
        FROM
          odeal.Merchant
        WHERE
          status in (0, 1)
      ) x ON x.id = m.id
      JOIN odeal.Organisation org on m.organisationId = org.id
      JOIN odeal.Channel c on org.channelId = c.id
  ) o {0}
order by
  o._lastModifiedDate ASC
LIMIT
  100