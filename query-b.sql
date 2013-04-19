select
   c.c_first_name,
   c.c_last_name,
   ca.ca_city,
   ca.ca_county,
   ca.ca_state
from customer c
   join customer_address ca on c.c_current_addr_sk = ca.ca_address_sk
limit 50;
