setwd("~/")
library.path <-.libPaths()[1]
library(googlesheets4)
library(readr)
library(httr)
library(jsonlite)
require(dplyr)
library(tidyverse)
library(lubridate)
gs4_auth(email = "abc@gmail.com") 
DataA1 <- GET("https://graph.facebook.com/v11.0/act_123456789123456/insights?date_preset=today&time_increment=1&level=adset&fields=campaign_name,impressions,clicks,reach,ctr,spend,cpc&access_token=Put Your Graph API Token Here")
DataA2<- content(DataA1, "text" , encoding = "UTF-8")
DataA3 <- jsonlite::fromJSON(DataA2)
DataA4 <- as.data.frame(DataA3, row.names = NULL, optional = FALSE)


DataA5 <- DataA4 [ , c("data.date_start",
                       "data.campaign_name",
                       "data.impressions",
                       "data.clicks",
                       "data.reach",
                       "data.ctr",
                       "data.spend",
                       "data.cpc")]


colnames(DataA5)[colnames(DataA5) == "data.campaign_name"] <- "Campaign"
colnames(DataA5)[colnames(DataA5) == "data.impressions"] <- "Impressions"
colnames(DataA5)[colnames(DataA5) == "data.clicks"] <- "Clicks"
colnames(DataA5)[colnames(DataA5) == "data.reach"] <- "Reach"
colnames(DataA5)[colnames(DataA5) == "data.ctr"] <- "CTR"
colnames(DataA5)[colnames(DataA5) == "data.spend"] <- "Spend"
colnames(DataA5)[colnames(DataA5) == "data.date_start"] <- "Date"
colnames(DataA5)[colnames(DataA5) == "data.cpc"] <- "CPC"
DataA5 <- DataA5


DataA6 <- DataA5

ss <- gs4_get("Google Sheet URL for Writing file ")
#Below 8 lines for Writing data from the first time in a google sheet
range_write(
  ss,
  DataA6,
  sheet = 1,
  range = NULL,
  col_names = TRUE,
  reformat = TRUE
)
##For writing data on existing sheet
sheet_append(
  ss,
  DataA6
)

