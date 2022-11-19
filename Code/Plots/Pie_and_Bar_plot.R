library(ggplot2)
library(plotly)
setwd("Plots/Data")
load("Genre.RData")
# Top Genres Bar Plot

data <- genre
a <- data$genre
b <- data$Freq
bar <- ggplot(data, aes(x= reorder(a,b), y = b)) + 
        geom_bar(stat = "identity", fill = "blue")  +   coord_flip() +
        labs(y = "Frequency", x = "GENRE") + 
            labs(title = "Top Genres as per My Anime List Data") 
final1 <- bar +  theme(plot.title=element_text(size=20, face = "bold",
                                         color="tomato",
                                         hjust=0.5,
                                         lineheight=1.2),
                 axis.title.x=element_text(size=15, face = "bold"),  
                 axis.title.y=element_text(size=20, face = "bold"))



# Pie Chart showing type of Animes Plot

dat2 <- read.csv("anime_2.csv")
df <- as.data.frame(table(dat2$type))[-1,]
colnames(df) <- c("Type", "freq")

t <- list(
  family = "Courier New",
  size = 20,
  color = "blue")

fig <- plot_ly(df, labels = ~Type, values = ~freq, type = 'pie' )
fig <- fig %>% layout(title = list(text = 'Types of Anime',y = 0.98, x = 0.5,
                                   xanchor = 'center', yanchor =  'top',font = t),
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

setwd("../..")
