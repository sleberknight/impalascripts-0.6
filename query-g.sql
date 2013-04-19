select
   count(c.c_customer_sk)
from customer c
   join customer_address ca
       on c.c_current_addr_sk = ca.ca_address_sk
   join customer_demographics cd
       on c.c_current_cdemo_sk = cd.cd_demo_sk
where
   ca.ca_zip in ('20191', '20194') and
   cd.cd_credit_rating in ('Unknown', 'High Risk');
