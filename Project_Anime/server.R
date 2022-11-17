#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(rvest)
library(shiny)
load("Genre_vs_Rating(MAL).RData")
load("Genre.RData")
load("Final_data.RData")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  
   output$histPlot <- renderPlot({
    if( "All" %in% input$genres){
      
      
        hist(Genre_rat$rating, xlab = "Rating", col = "#007bc2", border = "white",
             main = "Histogram of Ratings of selected Genres")
      
    }
    else{
    a <- logical(length(Genre_rat$rating))
    for(i in 1:length(Genre_rat$genre)){
      
      if(sum(input$genres %in% Genre_rat$genre[[i]]) > 0){
        
        a[i] <- TRUE
      }
    }
    
    rating <- Genre_rat$rating[a]
    
        hist(rating, xlab = "Rating", col = "#007bc2", border = "white",
             main = "Histogram of Ratings of selected Genres")
    }
  })
   
   output$summary <- renderPrint({
     if( "All" %in% input$genres){
       
       cat("Statistics of ratings of selected genres:\n\n")
       summary(Genre_rat$rating)
     }else{
       
       a <- logical(length(Genre_rat$rating))
       for(i in 1:length(Genre_rat$genre)){
         
         if(sum(input$genres %in% Genre_rat$genre[[i]]) > 0){
           
           a[i] <- TRUE
         }
       }
       rating <- Genre_rat$rating[a]
       
       cat("Statistics of ratings of selected genres:\n\n")
       summary(rating)
     }
     
   })
   
   output$plot <- renderPlot({
     
     genre <- genre[which( (genre$avg_rat <=input$rat[2]) & (genre$avg_rat >=input$rat[1]) ), ]
     
     wordcloud(words = genre$genre, freq = genre$Freq, scale = c(3,1),
               min.freq = input$freq , max.words = input$max ,
               colors = brewer.pal(8,"Accent"))
   })
   

   
   output$scatt <- renderPlotly({
     
     load("Final_data.RData")
      studios <- unlist(input$studio)

     
     main_dat <- main_dat[which(main_dat$Release_year %in% c(input$year[1]:input$year[2])), ]
     
     if(!("All" %in% studios)){

       main_dat <- main_dat[which(main_dat$Studio %in% unlist(input$studio)), ]
     }
     if(!("All" %in% input$type)){
       main_dat <- main_dat[which(main_dat$type %in% input$type), ]
     }
     p <- ggplot(main_dat, aes(text = Name, x = rating, y = members, col = type)) + geom_point()+
       ylim(input$votes) + xlim(0, 10) + labs(y = "Votes" , x = "Ratings") +
       geom_smooth( method="loess", span=0.5)
       
     ggplotly(p, width = 1)
     
   })
   
   
   output$graph <- renderPlot({
     
     load("Final_data.RData")
     studios <- unlist(input$studio)

     
     main_dat <- main_dat[which(main_dat$Release_year %in% c(input$year[1]:input$year[2])), ]
     
     if(!("All" %in% studios)){
       
       main_dat <- main_dat[which(main_dat$Studio %in% unlist(input$studio)), ]
     }
     if(!("All" %in% input$type)){
       main_dat <- main_dat[which(main_dat$type %in% input$type), ]
     }

     plot(main_dat$rating, main_dat$members,xlim = c(0, 10),
          ylim = input$votes, col = as.factor(main_dat$type),
          xlab = "Ratings", ylab = "Votes")

          legend(x = "topleft", legend = sort(unique(main_dat$type)),
                 fill = 1:length(unique(main_dat$type)))
          lines(lowess(main_dat$rating, main_dat$members), col = "red", lwd = 3)
   })

})


