from typing import Union
from fastapi import FastAPI
from google.cloud import bigquery

app = FastAPI()


@app.get("/get-flights/{month}")
def get_flights_by_month():
    # Construct a BigQuery client object.
    client = bigquery.Client()

    query = f"""
        SELECT flight_id,flight_origin,flight_destination,flight_month
        FROM `angelic-digit-302818.ds_challenge.flights`
        WHERE flight_month='{month}'
        LIMIT 20
    """
    rows = client.query_and_wait(query)  # Make an API request.
    flight_list = []

    print("The query data:")
    for row in rows:
        # Row values can be accessed by field name or index.
        flight_list.append({
            "flight_id": row["flight_id"],
            "flight_origin": row["flight_origin"],
            "flight_destination": row["flight_destination"],
            "flight_month": row["flight_month"]
        })
    print(flight_list)
    return flight_list

@app.get("/get-flights")
def get_flights():
    # Construct a BigQuery client object.
    client = bigquery.Client()

    query = f"""
        SELECT flight_id,flight_origin,flight_destination,flight_month
        FROM `angelic-digit-302818.ds_challenge.flights`
        LIMIT 20
    """
    rows = client.query_and_wait(query)  # Make an API request.
    flight_list = []

    print("The query data:")
    for row in rows:
        # Row values can be accessed by field name or index.
        flight_list.append({
            "flight_id": row["flight_id"],
            "flight_origin": row["flight_origin"],
            "flight_destination": row["flight_destination"],
            "flight_month": row["flight_month"]
        })
    print(flight_list)
    return flight_list