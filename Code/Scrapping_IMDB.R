library(rvest)
library(tidyverse)
setwd("Datasets")

#getting names, ratings, and votes From imdb by web scrapping

html <- read_html("https://www.imdb.com/search/keyword/?keywords=anime&sort=moviemeter,asc&mode=detail&page=1&ref_=kw_nxt")
names <- html %>% html_elements("img") %>% html_attr("alt")
names <- names[-c(1, 2, 53)]  # removing extra enteries


ratings <- html %>% html_elements("strong") %>% html_text()
ratings <- as.numeric(ratings[-c(1:11)])


votes <- html %>% html_elements("span") %>% html_attr("data-value")
votes <- votes[!is.na(votes)]
votes <- votes[which(votes != "0")]
votes <- votes[!grepl(",", votes)] # removing all those votes with "," as those are dollars in box office( for movie)

for(i in 6:10){
  
  html <- read_html(paste("https://www.imdb.com/search/keyword/?keywords=anime&sort=moviemeter,asc&mode=detail&page=", i, "&ref_=kw_nxt", sep = ""))
  
  name <- html %>% html_elements("img") %>% html_attr("alt")
  name <- name[-c(1, 2, 53)]
  names <- c(names, name) 
  
  rating <- html %>% html_elements("strong") %>% html_text()
  rating <- as.numeric(rating[-c(1:11)])
  ratings <- c(ratings, rating)
  
  vote <- html %>% html_elements("span") %>% html_attr("data-value")
  vote <- vote[!is.na(vote)]
  vote <- vote[which(vote != "0")]
  vote <- vote[!grepl(",", vote)]
  votes <- c(votes, vote)
  
}
votes <- as.integer(votes)
#removing names with no votes/ratings
names <- names[-c(59, 78, 260, 265, 324, 354, 410, 419, 465, 471)]   # removing those names whose other data is not available as they are not yet released globally,
                                                                     # released only in Japan/or upcoming therefore rating and votes doesn't exists
df <- data.frame(names, ratings, votes)
save(df, file = "IMDB.RData") # saving data frame
