
SELECT id, organisationId, terminal_id, serial_no, serviceId, channel_id, taksitli, isActivated ,terminalStatus, activationDate, cancelDate,
@row_number := CASE WHEN @orgid <> id THEN 1 ELSE @row_number + 1 END AS rn,
@orgid := id AS clset
FROM (
    SELECT o.id, o.organisationId, t.id as terminal_id, t.serial_no, pln.serviceId, t.channelId as channel_id, sb.status, o.isActivated , o.activatedAt  , o.deActivatedAt, sb.start,
pln.taksitli,t.terminalStatus, (@row_number := 0) AS dummy_var, @orgid:=0 AS c,
        CASE 
            WHEN o.activatedAt > t.firstActivationDate AND sb.status=1 THEN o.activatedAt
            ELSE t.firstActivationDate
        END activationDate,
           CASE 
              WHEN t.terminalStatus=0  AND sb.status<>0 THEN 
                (CASE WHEN o.isActivated=0 AND sb.cancelledAt IS NULL AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt 
                      ELSE sb.cancelledAt END)
              WHEN terminalStatus=1 THEN NULL 
              ELSE sb.cancelledAt
        END cancelDate
FROM odeal.Organisation o
        JOIN subscription.Subscription sb ON sb.organisationId = o.id 
        JOIN subscription.Plan pln ON pln.id = sb.planId and serviceId<>3 
        JOIN odeal.Terminal t ON t.subscription_id = sb.id
        WHERE o.demo = 0
    ) temp2 
WHERE id NOT IN (301011013,301160192) AND id = 301252362

