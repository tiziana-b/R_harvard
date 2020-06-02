#Packages for data visualization
library(gtools)
library(ggplot2)
library(ggrepel)
library(scales)
#Package for web scraping, tidying data, sentiment analysis
library(tidyverse)
library(tidyr)
library(tidytext)
library(textdata)
#Package for piping
library(dplyr)
#Package for sample data
library(dslabs)
#Packages for data import and webscraping
library(rvest)
library(stringr)
#Package for converting lists into data frames
library(purrr)
#Package for scraping pdfs
library(pdftools)

#Package for formatting dates and times
library(lubridate)
library(tidytext)

#Package for extracting data from Twitter
library(rtweet)

#Package containing Project Gutenberg digital archive of public domain books
library(gutenbergr)


#Webscraping info from AMAZON
url<-"https://www.amazon.ca/Shilucheng-6-Piece-Brushed-Microfiber-Percale/dp/B085PZYR5M/ref=sr_1_1?keywords=egyptian+cotton+sheets&qid=1590504562&sr=8-1"
#url2<-"https://www.amazon.ca/Pillow-Certified-Egyptian-Staple-Cotton/dp/B07TJVJD2J/ref=sr_1_1_sspa?crid=UNONVJAYUB2H&keywords=egyptian+cotton+sheets&qid=1590603336&s=kitchen&sprefix=egy%2Ckitchen%2C177&sr=1-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEzRUlaMlo4S0syTko4JmVuY3J5cHRlZElkPUEwMDkwNTM3MkVPRkNYU0Y0MURSOCZlbmNyeXB0ZWRBZElkPUExMDAzMTE4QldaSDY2UEVSTVNJJndpZGdldE5hbWU9c3BfYXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ=="
h<-read_html(url)

labels<-h%>%html_nodes(".label")%>%html_text()%>%tibble()
labels

values<-h%>%html_nodes(".value")%>%html_text()
values

#Regex for the parent category and subcategory ranking from the string of text in values [[3]]
pattern<-"#\\d*,*\\d*"

#Position of substring that matches the pattern
pos<-str_locate_all(values[[3]],pattern)

#Isolate parent category and subcategory rankings from string of text in values[[3]]
ranks<-str_extract_all(values[[3]],pattern)
class(ranks)

#Convert ranks to character and replace values[[3]] with characters contained in ranks
#To use str_sub, ranks must be of type character
ranks<-as.character(ranks)
class(ranks)
str_sub(values[[3]],1,-1)<-ranks

#Convert values vector to tibble
values<-values%>%tibble()

#Combine headers column with values column
bind_cols(labels,values)

price<-h%>%html_nodes("#priceblock_saleprice")%>%html_text()

