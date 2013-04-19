select
   c.c_first_name,
   c.c_last_name,
   ca.ca_city,
   ca.ca_county,
   ca.ca_state,
   cd.cd_marital_status,
   cd.cd_education_status
from customer c
   join customer_address ca
       on c.c_current_addr_sk = ca.ca_address_sk
   join customer_demographics cd
       on c.c_current_cdemo_sk = cd.cd_demo_sk
where
   ca.ca_zip in ('20191', '20194') and
   cd.cd_credit_rating in ('Unknown', 'High Risk')
limit 100;
