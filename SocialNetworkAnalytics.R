# The program is used for performing social network analysis on Harry Potter Scripts. 
# Used to understand speaker-listner relation in the HP movie.
# It creates a characater communication graph based on number of dialouges exchanged    
# Author: saniya-khan ; Github : https://github.com/saniya-k
library(tidyverse)
library(tidytext)
library(igraph)
library(stringr)
library(circlize)

setwd("C:/Workarea 1.1/General/LEARN/MSBA/Fall 2019/MIS 612/HP project/DeathlyHallows/") #change to custom path
script = read.csv("script.csv",
                  encoding = "UTF-8",
                  stringsAsFactors = FALSE)

names <- c("Speaker", "Listener", "Num of dialogues", "dialogues")
new_df = data.frame()
colnames(new_df) = c("Speaker", "Listener", "Count", "dialogues")
i = 1

while (i < nrow(script)) {
  speaker = script[i, 1]
  listener = script[i, 2]
  #filter out specific speaker listener combo and combine their dialogues
  filtered_output = filter(script,
                           script$X.U.FEFF.Speaker == speaker,
                           script$Listener == listener)
  dialouge = paste(filtered_output$Dialogue, collapse = "|")
  new_df = rbind(new_df,
                 data.frame(
                   filtered_output[1, 1],
                   filtered_output[1, 2],
                   count(filtered_output),
                   dialouge
                 ))
  i <- i + 1
}
#remove duplicates
new_df <- new_df %>% distinct()
colnames(new_df) = c("Speaker", "Listener", "Count", "Dialogues")

# uncomment to get filter out less than 10 dialogues.
#new_df <- new_df[!(new_df$Count <10),]

links <-
  aggregate(new_df, by = list(new_df$Speaker, new_df$Listener), length)
nodes = data.frame(c(new_df$Speaker), new_df$Listener)
#assign random colours to nodes
colr <- c(rand_color(nrow(new_df), luminosity = "light"))
hpnet <- graph_from_data_frame(d = links, directed = T) # d links,
V(hpnet)$color <- colr

# this ensures the starting random position is the same
# for the layouts that use a random starting position
set.seed(1492)
#layout with fr to bring related nodes together and separate out unsimilar nodes
l <- layout_with_fr(hpnet, niter = 50) 

#Change node size to depict betweeness
#deg <- igraph::degree(hpnet, mode = "all")
# V(hpnet)$size <-  deg* 2

#plot graph for all nodes
par(bg = 'white')
plot(
  hpnet,
  layout = l,
  vertex.shape = "circle",
  edge.arrow.size = .2,
  vertex.label.color = "black",
  vertex.label.cex = .6
)

#create a dataframe for further analysis in tableau /excel
dialouge_lengths <- c(apply(new_df, 2, nchar)[, 4])
dialouge_lengths
communication_data = new_df
communication_data <- cbind(communication_data, dialouge_lengths)
write.csv(communication_data, file = "CommunicationData.csv")

