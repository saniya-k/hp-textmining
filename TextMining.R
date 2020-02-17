# This program is used to perform text mining for harry potter scripts(part 7)
# In the end, I generated a wordcloud to identify popular themes/characters in the movie.
# Author: saniya-khan ; Github : https://github.com/saniya-k
#devtools::install_github("lchiffon/wordcloud2")
library(dplyr) # dplyr package is used for data manipulation; it uses pipes: %>%
library(tm) # contains the stopwords dictionary
library(textstem) # used for stemming and lemmatization
library(SnowballC)
library(wordcloud2)
library(RColorBrewer)
library(igraph)
setwd("C:/Workarea 1.1/General/LEARN/MSBA/Fall 2019/MIS 612/HP project/DeathlyHallows/") #change to custom path
script.df <- read.csv("script.csv",header = TRUE,encoding = "UTF-8")
stop=read.table("stop.txt",header = TRUE)  #custom stop words
stop_vec = as.vector(stop$CUSTOM_STOP_WORDS)
# Transform and clean the text
docs <- Corpus(VectorSource(script.df$Dialogue))
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords,c(stopwords('english'),stop_vec))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
#remove 's 
docs <- tm_map(docs, removeWords, c("'s"))
# Text stemming (reduce to word root)
#docs <- tm_map(docs, stemDocument)
# Text lemmatization (remove word's suffix)
docs <- tm_map(docs,lemmatize_strings(dictionary = "wordnet"))
tdm <- as.matrix(TermDocumentMatrix(docs))
#tdm
dtm <- as.matrix(DocumentTermMatrix(docs))
str(tdm)
################################
######### create Tf-Idf ########
################################
tfidf <- as.matrix(DocumentTermMatrix(docs, control = list(weighting = weightTfIdf)))
str(tfidf)
v <- sort(rowSums(tdm),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
#create wordcloud of popular themes in the movie
wordcloud2(d, backgroundColor ='white',size=1.5)
