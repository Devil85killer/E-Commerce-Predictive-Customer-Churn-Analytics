import pandas as pd
import urllib
from sqlalchemy import create_engine

def get_db_connection(server=r"DEVIL\SQLEXPRESS", database="ecommerce"):
    """Establishes a connection to the SQL Server database."""
    params = urllib.parse.quote_plus(
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={server};"
        f"DATABASE={database};"
        f"Trusted_Connection=yes;"
    )
    
    engine = create_engine(
        "mssql+pyodbc:///?odbc_connect=" + params,
        pool_pre_ping=True
    )
    return engine

def load_ml_data(engine):
    """Loads the customer churn feature table from the database."""
    query = "SELECT * FROM dbo.Customer_Churn_ML WITH (NOLOCK)"
    df = pd.read_sql(query, engine)
    return df