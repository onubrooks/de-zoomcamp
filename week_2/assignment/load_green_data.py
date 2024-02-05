if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
import pandas as pd

@data_loader
def load_data(*args, **kwargs):
    """
    Template code for loading data from any source.

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your data loading logic here
    urls = [
        "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2020-10.parquet",
        "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2020-11.parquet",
        "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2020-12.parquet"
    ]
    df = pd.concat([pd.read_parquet(url) for url in urls])

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
