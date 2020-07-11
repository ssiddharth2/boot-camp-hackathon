import pandas as pd
import plotly.express as px

df=pd.read_csv("owid-covid-data.csv")
df=df[df['location']!= "World" ]
df=df[df['location']!= "International"]
df=df[df['iso_code']!=" "]
df=df[df["date"]=="2020-07-10"]
fig=px.choropleth(df,locations="iso_code",color="total_cases_per_million",hover_name="location",
    color_continuous_scale=px.colors.sequential.deep)


fig.show()