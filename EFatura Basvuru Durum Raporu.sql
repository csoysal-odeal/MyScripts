select oo.id,me.identifier_no 'userId' , oo.unvan 'formattedName' , m.firstName 'givenName' , '' middleName,
       m.LastName 'familyName', m.phone 'phone', m.email 'email', 'TÜRKİYE' as 'country' , c.name 'city', t.name 'county', me.created_date 'contractDate',
       tx.code 'taxOfficeId',me.`type` , me.envelope_status, me.envelope_description
from odeal.MerchantEnvelopeHistory me
join odeal.Organisation oo on me.merchant_id  = oo.id
join Merchant m on m.organisationId = oo.id and m.role = 0
left join odeal.TaxOffice tx on tx.id  = oo.taxOfficeId
left join odeal.Town t on t.id = oo.townId
left join odeal.City c on c.id = oo.cityId
where 1=1
    and date(created_date) >= '2022-04-01'
order by merchant_id;

SELECT * FROM