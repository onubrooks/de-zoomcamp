#!/usr/bin/env python
# coding: utf-8


import pandas as pd
import argparse
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    
    file_name = 'yellow_tripdata.parquet'
        
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    df = pd.read_parquet('yellow_tripdata_2021-01.parquet')
    len(df)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    
    print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))

    # only create table but without data
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.to_sql(name=table_name, con=engine, if_exists='append')
    
    print('job finished successfully')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest Parquet data to postgres')

    parser.add_argument('--user', help='user name for postgres', type=str)
    parser.add_argument('--password', help='password for postgres', type=str)
    parser.add_argument('--host', help='host for postgres', type=str)
    parser.add_argument('--port', help='port for postgres', type=str)
    parser.add_argument('--db', help='database name for postgres', type=str)
    parser.add_argument('--table_name', help='table name for postgres', type=str)
    parser.add_argument('--url', help='file name for postgres', type=str)

    args = parser.parse_args()
    main(args)
