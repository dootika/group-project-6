library(shiny)
library(wordcloud)
library(RColorBrewer)
library(shinythemes)

load("Genre.RData")
load("Genre_vs_Rating(MAL).RData")
load("Final_data.RData")

# Define UI for application that draws a histogram
navbarPage("Anime", theme = shinytheme("darkly"),
           tabPanel("Plot",

              # Application title
              titlePanel("Insights on Anime Dataset"),

              # Sidebar with a slider input for number of bins
              sidebarLayout(
                  sidebarPanel(
                    checkboxGroupInput( "genres",
                                          "Select genres you want to see:",
                                        c("All", genre$genre), selected = "All"
                                      )
                              ),

                 # Show a plot of the generated distribution
                  mainPanel(
                    tabsetPanel(
                    tabPanel("Plot", plotOutput("histPlot")),
                    tabPanel("Summary", verbatimTextOutput("summary"))
                              )
                           )
                         )
                      ),
              tabPanel("Wordcloud",
                       
                       titlePanel("Wordcloud of Genres"),
                       
                       sidebarLayout(
                         sidebarPanel(
                           sliderInput("freq",
                                       "Minimum Frequency of Anime:",
                                       min = 1,  max = 2000 , step = 1,  value = 10),
                           sliderInput("max",
                                       "Maximum genre:",
                                       min = 1 ,  max = 45, step = 1, value = 30)
                         ),
                         # Show Word Cloud
                         mainPanel(
                           plotOutput("plot")
                         )
                       )
                  ),
           tabPanel("Combined Plot",
                    
                    titlePanel("Votes vs Ratings of Anime"),
                    sidebarLayout(
                      sidebarPanel(
                               sliderInput("votes", "Select range of Votes",
                                           0, 1014000, c(0, 1014000), step = 1000),
                               sliderInput("year", "Year released", 1907, 2021, value = c(1907, 2021),
                                           ),
                              selectizeInput("studio", "Select which studio's anime you want to see:",
                                             c("All", unique(main_dat$Studio)), selected = "All", multiple = TRUE),
                               checkboxGroupInput("type", "Select type of anime:",
                                           c("All", sort(unique(main_dat$type))), selected = "All"),
                               tags$small(paste0(
                                 
                                 "Note:An anime OVA (original video animation) is a special episode or movie that was
                                 released on DVD/Blu-Ray/VHS without being shown on TV or in theaters before."),
                                 tags$br(),
                                 paste0("An original net animation (ONA), known in Japan as web anime, is an anime that
                                 is directly released onto the Internet."),
                                 tags$br(),
                                 paste0("Specials are like OVA's they are not part of origial show but are 
                                 it's possible for a Special to be released as a television broadcast that
                                 is just separate from the rest of the show"
                               ))
                      ),
                      mainPanel(
                             h3("Scatter Plot with best fit curve :"),
                             plotOutput("graph"),
                             h3("Interactive GGplot of the same :"),
                             plotlyOutput("scatt")
                      )
                    ))

          )





