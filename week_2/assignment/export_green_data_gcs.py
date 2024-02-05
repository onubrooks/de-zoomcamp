import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/zoomcamp_google_credentials.json'
bucket_name = 'mage-zoomcamp-onubrooks'
project_id = 'zoomcamp-de-411412'

table_name = 'nyc_taxi_green_data'

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data_to_gcs(data, *args, **kwargs):
    # Specify your data exporting logic here
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )