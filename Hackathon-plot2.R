library('rworldmap')

df<-read.csv("owid-covid-data.csv")
df<-filter(df, location!="World")
df<-filter(df, location!="International")
df<-filter(df, iso_code!="")
df<-filter(df, date=="2020-07-10")
mapped_data <- joinCountryData2Map(df, joinCode = "ISO3", 
                                   nameJoinColumn = "iso_code")
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapCountryData(mapped_data, nameColumnToPlot = "total_cases_per_million")