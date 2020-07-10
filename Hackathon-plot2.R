library('rworldmap')
library(classInt)
library(RColorBrewer)
df<-read.csv("owid-covid-data.csv")
df<-filter(df, location!="World")
df<-filter(df, location!="International")
df<-filter(df, iso_code!="")
df<-filter(df, date=="2020-07-10")
mapped_data <- joinCountryData2Map(df, joinCode = "ISO3", 
                                   nameJoinColumn = "iso_code")
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
classInt <- classIntervals(mapped_data$total_cases_per_million, n=8, style="jenks")
catMethod = classInt$brks
#getting a colour scheme from the RColorBrewer package
colourPalette <- brewer.pal(8,'RdPu')
#calling mapCountryData with the parameters from classInt and RColorBrewer
mapParams <- mapCountryData( mapped_data, nameColumnToPlot="total_cases_per_million", addLegend=FALSE
                             , catMethod = catMethod, colourPalette=colourPalette )
do.call(addMapLegend, c(mapParams
                        ,legendLabels="all"
                        ,legendWidth=0.5
                        ,legendIntervals="data"))