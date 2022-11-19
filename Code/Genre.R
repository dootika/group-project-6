library(tidyverse)
setwd("Datasets")
#importing Datasets Uploaded on github

dat1 <- as.data.frame(read.csv("Anime.csv"))
dat2 <-as.data.frame(read.csv("anime_2.csv"))
dat1 <- dat1[, -c(1, 7, 8, 11:14, 16, 17)]
dat1$Japanese_name <- str_remove(dat1$Japanese_name, " ") # extra space was unnessary


############
#getting names, ratings, and votes

Genre_rat <- subset(dat2[, c(3, 6)])
Genre_rat$genre <- str_remove_all(Genre_rat$genre , " ")
Genre_rat$genre <- strsplit(Genre_rat$genre, ",") #turning a list into sub list of genres

#making a vector with all 18+ rating genres, these contain extreme bloodshed, gore...
r18 <- c("Hentai", "Ecchi", "ShoujoAi", "Yuri", "ShounenAi", "Yaoi")


for(i in 1:length(Genre_rat$genre)){
  
  a <- Genre_rat$genre[[i]] %in% r18 #checking whether list contain any 18+ genre
  
  if(sum(a) > 0) # If atleast one is true, then sum(a) >=1
    Genre_rat$genre[[i]] <- append( Genre_rat$genre[[i]][!a], "Adult") #removing r18 elements and adding only one Adult tag
}
Genre_rat <- Genre_rat[which(!is.na(Genre_rat$rating)), ]
save(Genre_rat, file = "Genre_vs_Rating(MAL).RData")


genre <- "a" # for creating a vector to store all genre
for( i in 1:length( Genre_rat$genre)){
  
  genre <- c(genre,  Genre_rat$genre[[i]])
}
genre <- genre[-1] #removing that dummy char
genre <- as.data.frame(table(genre)) #creating data frame with freq and names of unique genres
genre[, 1] <- as.character(genre$genre) #converting levels to char

#Adding a column for avg rating of each genre
avg_rat <- numeric(length(genre$genre))

for(i in 1:length(genre$genre)){
  a <- logical(length(Genre_rat$rating))
  
  for(j in 1: length( Genre_rat$genre)){
    
    if(genre$genre[i] %in% Genre_rat$genre[[j]]){
      a[j] <- TRUE
    }
  }
  avg_rat[i] <- mean(Genre_rat$rating[a])
  
}
genre <- data.frame(genre, avg_rat)
save(genre, file = "Genre.RData") 
setwd("..")
