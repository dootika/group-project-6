# Anime Analysis

## Description
This is the project of group - 6 for the course MTH208. In this project we have analysed the dataset from kaggle containing anime rating data from two different websites [MyAnimeList](https://myanimelist.net/) and [Anime Planet](https://www.anime-planet.com/) and tried to get some insights related to groeth of anime over time, genres, studios, etc. We also tried to compare [IMDb](https://www.imdb.com/) ratings with [MyAnimeList's](https://myanimelist.net/) ratings Along with that, we have also built an app using `Shiny` package in R Studio for analysisng data in an interactive way.

## Contents
- **Code : **Contains all the code for scrapping data, cleaning datasets, combining 2 datasets and making plots.
- The **presentation** includes the ppt file we created to explain our analysis, as well as a brief video demonstration of our app on the final slide.
- The **report** folder in the project contains a markdown file that contains all the results and conclusion from the data analysis we performed. The html format of the report is more interactive than the pdf format.
- **Shiny App :** Shiny is a R package that makes it easier to build interactive web pages from R. Here is the [link](https://shabadpreet.shinyapps.io/shiny_app/) to oue app which is hosted online on [Shinyapps.io](https://shinyapps.io). All it's code can be found in the above **Shiny App** folder. To run the app using code kindly download whole shiny app folder and run any of `server.R` or `ui.R` file in it. 
> In app the graphs in "Combined Plot" section might take some time to load but they'll load eventually, and in there the ggplot provided is interactive as you can zoom in/out and hover over the points to get more information about them.

## Instruction to run the code:
- For running code please set the respectove parent folder as working directory, e.g. if I want to run `Genre.R` file in Code folder I'll set "code"(my parent folder in this case) as my working directory. 
- If while running the code you run into `there is no package called ....` error then kindly run the `Required Packages` file first to download required packages used in the code.
