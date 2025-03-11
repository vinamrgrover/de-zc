#!/bin/bash
set -uo pipefail
export PGPASSWORD=SHINchan123
QUERY_FILE=nyc_create.sql
NUM_RECORDS=`cat nyc_taxi.csv | wc -l`

echo 'converting parquet to csv'
duckdb -c "COPY (SELECT * FROM read_parquet('~/Downloads/yellow_tripdata_2024-01.parquet')) TO 'nyc_taxi.csv' (FORMAT csv);" > /dev/null 2>&1

if [ -f $QUERY_FILE ]; then
    echo "query file exists"
else
    echo "query file does not exist"
fi

echo "creating table nyc_taxi"
psql --host 34.131.19.30 -U vinamrgrover --db postgres -c "$(cat nyc_create.sql)" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "table already exists"
    exit 1
else
    echo "table created"
fi
echo "loading $NUM_RECORDS records from csv file"
psql --host 34.131.19.30 -U vinamrgrover --db postgres <<EOF > /dev/null 2>&1
\copy nyc_taxi FROM 'nyc_taxi.csv' WITH CSV HEADER;
EOF
echo "success"

