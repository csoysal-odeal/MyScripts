
SELECT PIVOT.serviceId, PIVOT.channel_id, PIVOT.taksitli, PIVOT.isActivated, PIVOT.terminalStatus, 
DATE_FORMAT(PIVOT.activationDate,"%Y-%m") as AktivasyonGun,
DATE_FORMAT(PIVOT.cancelDate,"%Y-%m") as IptalGun, COUNT(PIVOT.terminal_id) as TerminalAdet  FROM (
SELECT
	Aktivasyon.id,
	Aktivasyon.organisationId,
	Aktivasyon.terminal_id,
	Aktivasyon.serial_no,
	Aktivasyon.serviceId ,
	Aktivasyon.channel_id,
	Aktivasyon.taksitli,
	Aktivasyon.isActivated ,
	Aktivasyon.terminalStatus,
	Aktivasyon.activationDate,
	Aktivasyon.cancelDate
FROM
	(SELECT
		o.id,
		o.organisationId,
		t.id as terminal_id,
		t.serial_no,
		pln.serviceId,
		t.channelId as channel_id,
		sb.status,
		o.isActivated ,
		o.activatedAt ,
		o.deActivatedAt,
		sb.start,
		pln.taksitli,
		t.terminalStatus,
		CASE
			WHEN date(o.activatedAt) > date(t.firstActivationDate)
			AND sb.status = 1 THEN date(o.activatedAt)
			ELSE date(t.firstActivationDate)
		END activationDate,
		CASE
			WHEN t.terminalStatus = 0
			and sb.status <> 0 THEN 
		    (CASE
					WHEN o.isActivated = 0
					AND sb.cancelledAt is NULL
					AND o.deActivatedAt>o.activatedAt THEN o.deActivatedAt
					ELSE sb.cancelledAt
				END)
			WHEN t.terminalStatus = 1 THEN NULL
			ELSE sb.cancelledAt
		END cancelDate
	FROM odeal.Organisation o
	JOIN subscription.Subscription sb ON sb.organisationId = o.id
	JOIN subscription.Plan pln ON pln.id = sb.planId AND serviceId <> 3
	JOIN odeal.Terminal t ON t.subscription_id = sb.id WHERE o.demo = 0
    ) as Aktivasyon
WHERE
	Aktivasyon.id NOT IN (301011013, 301160192)) as PIVOT
GROUP BY PIVOT.serviceId, PIVOT.channel_id, PIVOT.taksitli, PIVOT.isActivated, PIVOT.terminalStatus, 
DATE_FORMAT(PIVOT.activationDate,"%Y-%m"),
DATE_FORMAT(PIVOT.cancelDate,"%Y-%m")


SELECT o.id, t.id as TerminalID, 
t.serial_no as MaliNo,  
c.name, 
sh.subscriptionId, 
sh.activationDate, 
sh.cancelledAt, 
sh.currentPeriodStart, sh.currentPeriodEnd, 
p.amount, 
bi.iban, 
DATE_FORMAT(sh.currentPeriodEnd,"%Y-%m") as Donem FROM odeal.Organisation o 
JOIN odeal.Terminal t ON t.organisation_id = o.id
JOIN odeal.Channel c ON c.id = t.channelId AND t.channelId = 130
JOIN subscription.SubscriptionHistory sh ON sh.subscriptionId = t.subscription_id AND sh.terminalId = t.id
JOIN subscription.Plan p ON p.id = sh.planId
JOIN odeal.BankInfo bi ON bi.id = t.bankInfoId
WHERE sh.status = 1 
ORDER BY o.id, t.serial_no

SELECT * FROM odeal.Channel c 
