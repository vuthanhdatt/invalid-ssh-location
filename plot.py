import plotly.express as px
import pandas as pd
import numpy as np
df = pd.read_csv('fraud_login.csv')
# df['count'] = df['count'].apply(lambda x: np.log2(x) if x > 1 else x)
fig = px.scatter_geo(df, lat="lat",
                    lon="long",
                    hover_name="ip_address", 
                    # size="count", # size of markers
                     )
fig.write_image("fig.png", scale=10)

