#!/bin/bash

mkdir /home/cloudera/tpcds
cd /home/cloudera/tpcds
curl --output tpcds_kit.zip http://www.tpc.org/tpcds/dsgen/dsgen-download-files.asp?download_key=NaN
unzip tpcds_kit.zip

cd tools
make clean
make

# generate the data
export PATH=$PATH:.
DIR=$HOME/tpcds/data
mkdir -p $DIR
SCALE=1
FORCE=Y

dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table store_sales
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table date_dim
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table time_dim
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table item
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer_demographics
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table household_demographics
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer_address
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table store
dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table promotion

# copy data to hdfs
hdfs dfs -mkdir /hive/tpcds/date_dim
hdfs dfs -mkdir /hive/tpcds/time_dim
hdfs dfs -mkdir /hive/tpcds/item
hdfs dfs -mkdir /hive/tpcds/customer
hdfs dfs -mkdir /hive/tpcds/customer_demographics
hdfs dfs -mkdir /hive/tpcds/household_demographics
hdfs dfs -mkdir /hive/tpcds/customer_address
hdfs dfs -mkdir /hive/tpcds/store
hdfs dfs -mkdir /hive/tpcds/promotion
hdfs dfs -mkdir /hive/tpcds/store_sales

cd $HOME/tpcds/data

for t in date_dim time_dim item customer customer_demographics household_demographics customer_address store promotion store_sales
do
hdfs dfs -put ${t}.dat /hive/tpcds/${t}
done

hdfs dfs -ls -R /hive/tpcds/*/*.dat

# create the tables via hive
hive -f /home/cloudera/impalascripts/tpcds_ss_tables.sql