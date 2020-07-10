library(tidyverse)
library(ggplot2)

df<-read.csv("owid-covid-data.csv")
head(df)

df$date<-as.Date(df$date)
df$location<-as.factor(df$location)
print(levels(df$location))

df<-filter(df, location =="World"|location =="United States"|location =="China"|location =="South Korea"|location =="United Kingdom")

#df<-filter(df, location!="International")
country_label<-function(x){
  if(x == "USA"){
    "United States"
  }else if(x== "KOR"){
    "South Korea"
  }else if(x == "CHN"){
    "China"
  }else if(x == "GBR"){
    "United Kingdom"
  }else{
    "World"
  }
}
#df$country<-case_when(
 # df$iso_code %in% c("USA")~"United States",
 # df$iso_code %in% c("KOR")~"South Korea",
 # df$iso_code %in% c("CHN")~"China",
 # df$iso_code %in% c("GBR")~"United Kingdom",
  #TRUE~"World"
#)
df$country<-sapply(df$iso_code, country_label)
df
df<-df %>%
  filter(date>= "2020-01-22")%>%
  filter(total_cases>= 0)%>%
  group_by(country,date)%>%
    summarise(total=sum(total_cases_per_million))

print(df)

ggplot(data=df)+geom_line(mapping = aes(x=date,y=total,colour=country)) +ggtitle("Total confirmed Covid-19 cases per Million People")+scale_y_continuous(trans = "log10", labels = scales::comma)
