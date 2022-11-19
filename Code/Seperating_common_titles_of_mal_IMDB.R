setwd("Datasets")
load("IMDB.RData") # as df
load("Final_data.RData") # as main_dat(from mal)

#Comparing MAL and IMDB rating
id <- which(df$names %in% main_dat$Name) 
id <- c(id, which(df$names %in% main_dat$Japanese_name))
id <- unique(id)

df_subset <- df[id, ] # imdb ratings with common names with our main data

id2 <- which(main_dat$Name %in% df_subset$names)
common_dat <- main_dat[id2, c(2, 5, 6)]

id2 <- which(main_dat$Japanese_name %in% df_subset$names)
dat <- subset(main_dat[id2, c(3, 5, 6)])
colnames(dat) <- c("Name", "rating", "members")
common_dat <- rbind(common_dat, dat)

df_subset <- df_subset[order(df_subset$names), ]
common_dat <- common_dat[order(common_dat$Name), ]

common_dat <- common_dat[!duplicated(common_dat$Name), ]
df_subset <- df_subset[!duplicated(df_subset$names), ]

imdb <- df_subset
mal <- common_dat
all(imdb$names == mal$Name) # checking if all values in name are equal
# TRUE

save(mal, file = "Common_titles_from_MAL.RData")
save(imdb, file = "Common_titles_from_IMDB.RData")
