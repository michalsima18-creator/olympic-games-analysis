import os 
import glob
import pandas 
import sqlalchemy

SCRIPT_FOLDER = os.path.dirname(__file__) 
PROJECT_FOLDER = os.path.dirname(SCRIPT_FOLDER)
SCRIPT_FILENAME = os.path.basename(__file__)  
DATA_FOLDER = os.path.join(PROJECT_FOLDER,'data')

csv_file_path = os.path.join(DATA_FOLDER,'olympic_athletes.csv')
df = pandas.read_csv(csv_file_path)

df.info()
print(df)

DBURI = 'mysql+pymysql://root:90Nko5hr@localhost:3317/projekt'
sqldb = sqlalchemy.create_engine(DBURI)  
df.to_sql("olympic_athletes",sqldb, if_exists='replace')

