#importing Datasets Uploaded on github

dat1 <- as.data.frame(read.csv("Anime.csv")) #Having dataset from MAL
dat2 <-as.data.frame(read.csv("anime_2.csv")) # dataset rom Anime planet
dat1 <- dat1[, -c(1, 7, 8, 11:14, 16, 17)]
dat1$Japanese_name <- str_remove(dat1$Japanese_name, " ") # extra space was unnessary

#Trying to combine 2 datasets dat1 & dat2 on basis of common names

index2 <- which(dat2$name %in% dat1$Japanese_name) #gives index of common names in dat2
index1 <- which(dat1$Japanese_name %in% dat2$name) # common titles in Japanese(Romaji)

index2_1 <- which(dat2$name %in% dat1$Name) # common titles in english
index1_1 <- which(dat1$Name %in% dat2$name)

name1 <- data.frame(c(index1, index1_1), c(dat1$Japanese_name[index1], dat1$Name[index1_1]))
name2 <- data.frame(c(index2, index2_1), c(dat2$name[index2], dat2$name[index2_1]))

name1 <- name1[!duplicated(name1$c.dat1.Japanese_name.index1...dat1.Name.index1_1..), ]

name2 <- name2[!duplicated(name2$c.index2..index2_1.), ] # removiing duplicated index
name2 <- name2[!duplicated(name2$c.dat2.name.index2...dat2.name.index2_1..), ] #removing duplicate names if any

name1 <- name1[order(name1$c.dat1.Japanese_name.index1...dat1.Name.index1_1..), ]
name2 <- name2[order(name2$c.dat2.name.index2...dat2.name.index2_1..), ]

colnames(name1) <- c("index", "name") # changing names of columns
colnames(name2) <- c("index", "name")

#checking whether names in both dataframe are equal
all.equal(name1$name, name2$name) # TRUE

# creating final dataset

main_dat <- data.frame(name2$index, dat2[name2$index, ], dat1[name1$index, c(1, 2, 5, 7)])
main_dat <- main_dat[, c(1, 2, 9, 10, 4, 7, 8, 5, 6, 11, 12)]
main_dat <- main_dat[order(main_dat$name2.index), ]
main_dat <- main_dat[, -1]
for(i in 5:10){
  main_dat <- main_dat[which(!is.na(main_dat[, i])), ]
}

save(main_dat, file = "Final_data.RData")
