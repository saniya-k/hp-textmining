#The program is used for performing sentiment analysis on the top characters identified in social network analysis.
# Author: saniya-khan ; Github : https://github.com/saniya-k
#install necessary packages
library(tm)
library(tidyverse)
library(tidytext)
library(stringr)
library(dplyr)
library(glue)
library(devtools)
library(plotly)
rm(list = ls()) 
#import the cleaned script
script.df <-  read.csv("script.csv", header = TRUE, encoding = "UTF-8")
#top 7 speakers based on dialogue selected for sentiment analysis
speaker=c("HARRY","DUMBLEDORE","BELLATRIX","VOLDEMORT","NEVILLE","RON","HERMIONE")
#dataframe created for output
final=data.frame()
#performing sentiment analysis on top 7 character
for(val in speaker){
  script.df_filtered <- script.df[which(script.df$X.U.FEFF.Speaker == val), ] #speaker input as val
  dialogues <- paste(script.df_filtered$Dialogue, collapse = "|") 
  tokens <- tibble(text = dialogues) %>% unnest_tokens(word, text)
  sent <- tokens %>% inner_join(get_sentiments("nrc")) %>% # pull out only sentiment words
    count(sentiment) %>% # count of the sentiments
    mutate(speaker=val) #create a speaker column 
  
  final <- rbind(final,sent) #outputs the count, speaker and the sentiment

}
final
#plotting top sentiments for the above mentioned characters using plotly function
#output the graphs as html widgets
for(char in speaker){
  print(char)
  plotdata <- final[which(final$speaker==char),c(1,2)]
  plotdata
  p <- plot_ly(plotdata, x=~sentiment, y=~n, type="bar", color=~sentiment) %>%
  layout(yaxis=list(title="Count"), showlegend=FALSE,
         title=paste("Distribution of sentiment categories for ",char))
  htmlwidgets::saveWidget(p, "index.html")
  print(p) #display sentiment
}
dev.off()