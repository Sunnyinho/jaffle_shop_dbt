
def model(dbt, session):
    data = dbt.ref('test_a')

    return data
