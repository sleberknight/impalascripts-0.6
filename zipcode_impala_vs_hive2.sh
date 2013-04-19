echo Impala Query 
time impala-shell --impalad=127.0.0.1:21000 --query="select count(*) from zipcode_incomes where income > 60000"

echo 
echo
echo Hive running the same query
time hive <<eoj
select count(*)  from zipcode_incomes where income > 60000;
eoj

