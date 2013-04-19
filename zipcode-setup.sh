#!/bin/bash
cd /tmp
unzip /home/cloudera/impalascripts/median_income_by_zipcode_census_2000.zip
# Remove Header
awk 'FNR>2' DEC_00_SF3_P077_with_ann.csv > DEC_00_SF3_P077_with_ann_noheader.csv
# Create the Hive table that Impala will query from
hive -e "CREATE TABLE ZIPCODE_INCOMES (id STRING, zip STRING, description1 STRING, description2 STRING, income int) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;load data local inpath '/tmp/DEC_00_SF3_P077_with_ann_noheader.csv' into table zipcode_incomes;"
