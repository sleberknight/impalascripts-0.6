select
   cd_credit_rating,
   count(*)
from customer_demographics
group by cd_credit_rating;
