#Studio analysis
library(plotly)
load("Studio_comparison.RData") # as std_rat

#Studio and their avg rating

std_rat <- std_rat[order(std_rat[, 3], decreasing = TRUE) ,]

plt <- barplot(std_rat[1:60, 2], col='steelblue', xaxt="n", ylim = c(0, 8), main = "Avg Rating of anime produced")
text(plt, par("usr")[3], labels = std_rat[1:60, 1], srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=0.6)

#########
#Interactive Scatter Plot
plot_ly(
  type = 'scatter',
  mode = 'markers',
  x = std_rat[, 2],
  y = std_rat[, 3],
  text = std_rat[, 1],
  hovertemplate = paste('<b> %{text} </b><br>',
                        'Rating(x axis) : %{x:.2f} <br>',
                        'Frequency(y axis) : %{y}')
) %>%
  layout(title = 'STUDIO analysis', plot_bgcolor = "#e5ecf6", xaxis = list(title = "Avg rating of Anime produced"), 
         yaxis = list(title = "No. of Anime produced"))