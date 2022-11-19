#Studio Analysis
setwd("Datasets")
load("Final_data.RData")

main_dat <- main_dat[!is.na(main_dat$rating), ]

std <- sort(unique(main_dat$Studio))
std <- std[-1] #removing the row with empty/no ("") studio name
Mean_ratings <- numeric(length(std))

for(i in 1:length(std)){
  
  Mean_ratings[i] <- mean(main_dat$rating[which(main_dat$Studio == std[i])])
}

std_rat <- data.frame(std, Mean_ratings, as.data.frame(table(main_dat$Studio))[-1, 2])
std_rat <- std_rat[!is.na(Mean_ratings), ]

colnames(std_rat) <- c("Studio Name", "Avg rating of Anime produced", "No. of Anime produced")
std_rat <- std_rat[which(std_rat[, 3] > 3), ]

save(std_rat, file = "Studio_comparison.RData")
setwd("..")
