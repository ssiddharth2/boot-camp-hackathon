library(tidyverse)
library(ggplot2)

df<-read.csv("owid-covid-data.csv")
head(df)
df$date<-as.Date(df$date)
df$country<-case_when(
  df$iso_code %in% c("USA")~"United States",
  df$iso_code %in% c("KOR")~"South Korea",
  df$iso_code %in% c("CHN")~"China",
  df$iso_code %in% c("GBR")~"United Kingdom",
  TRUE~"World"
)

df<-df %>%
  filter(date>= "2020-01-22")%>%
  filter(total_cases >= 0)%>%
  group_by(country,date)%>%
    summarise(total=sum(total_cases))

print(df)

ggplot(data=df)+geom_line(mapping = aes(x=date,y=log(total),colour=country))+ggtitle("Total confirmmed Covid-19 cases per millon people")
