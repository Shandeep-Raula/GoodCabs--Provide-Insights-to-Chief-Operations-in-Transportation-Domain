import pandas as pd
from sqlalchemy import create_engine

# function for Postgres database connection 
def move_to_postgres(dataframe, table_name, db_name, user, password, host, port):
    connection_string = f"postgresql://{user}:{password}@{host}:{port}/{db_name}"
    engine = create_engine(connection_string)
    dataframe.to_sql(table_name, engine, if_exists='replace', index='False')

# read all the files and change the datatype
city_target = pd.read_csv('city_target_passenger_rating.csv')

dim_city = pd.read_csv('dim_city.csv')

dim_date = pd.read_csv('dim_date.csv')
dim_date['date'] = pd.to_datetime(dim_date['date'])
dim_date['start_of_month'] = pd.to_datetime(dim_date['start_of_month'])

dim_repeat_trip = pd.read_csv('dim_repeat_trip_distribution.csv')
dim_repeat_trip['month'] = pd.to_datetime(dim_repeat_trip['month'])

fact_passenger = pd.read_csv('fact_passenger_summary.csv')
fact_passenger['month'] = pd.to_datetime(fact_passenger['month'])

fact_trips = pd.read_csv('fact_trips.csv')
fact_trips['date'] = pd.to_datetime(fact_trips['date'])

monthly_target = pd.read_csv('monthly_target_new_passengers.csv')
monthly_target['month'] = pd.to_datetime(monthly_target['month'])

monthly_target_trips = pd.read_csv('monthly_target_trips.csv')
monthly_target_trips['month'] = pd.to_datetime(monthly_target_trips['month'])


# Parameters for database connection
db_name = "Goodcabs"
user = "postgres"
password = "subu2003"
host = "localhost"
port = 5432


# Load all the files to Postgres database
move_to_postgres(city_target, "city_target_passenger_rating", db_name, user, password, host, port)
move_to_postgres(dim_city, "dim_city", db_name, user, password, host, port)
move_to_postgres(dim_date, "dim_date", db_name, user, password, host, port)
move_to_postgres(dim_repeat_trip, "dim_repeat_trip_distribution", db_name, user, password, host, port)
move_to_postgres(fact_passenger, "fact_passenger_summary", db_name, user, password, host, port)
move_to_postgres(fact_trips, "fact_trips", db_name, user, password, host, port)
move_to_postgres(monthly_target, "monthly_target_new_passengers", db_name, user, password, host, port)
move_to_postgres(monthly_target_trips, "monthly_target_trips", db_name, user, password, host, port)
