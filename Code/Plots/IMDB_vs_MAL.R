library(plotly)
load("Common_titles_from_MAL.RData")
load("Common_titles_from_IMDB.RData")

num_votes <- paste(mal$members, imdb$votes, sep = " / ")

plot_ly() %>%
  add_markers(
    type = 'scatter',
    mode = 'markers',
    x = mal$rating,
    y = imdb$ratings,
    text = mal$Name,
    customdata = num_votes,
    hovertemplate = paste(' <b>%{text}</b><br>',
                          ' MAL rating : %{x} <br>',
                          ' IMDB rating : %{y} <br>',
                          ' MAL/IMDB votes : %{customdata} <br>'),
    name = "Anime Points"
    
  ) %>%
  add_lines(
    x = c(0:10),
    y = c(0:10),
    name = "Y=X line for comparison"
  ) %>%
  layout(title = 'Rating comparision', plot_bgcolor = "#e5ecf6", xaxis = list(title = 'MAL ratings'), 
         yaxis = list(title = 'IMDB ratings'))
