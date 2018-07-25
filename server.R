#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyr)
library(dplyr)
library(ggplot2)
library(plotly)


# Define server logic required to draw a histogram
shinyServer(function(input, output){
  
  
  allRating <- reactive({
    mv_rat %>%
      group_by(., title) %>%
      summarise(., mean_rating = mean(rating)) %>% 
      sample_n(input$points)
  })
  
  output$all_ratings <- renderPlotly({
      
    all = ggplot(allRating(), aes(x = title, y = mean_rating)) + geom_point() +  
      theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
    ggplotly(all) 
  })
  
  output$rating_dens <- renderPlotly({
      rat_dens = mv_rat %>%
        group_by(., userId) %>%
        ggplot(., aes(x = userId)) + geom_histogram(stat = "count") + 
        theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
      ggplotly(rat_dens)
  })
  
  output$rating_pan <- renderPlot({
    mv_rat %>%
      group_by(., rating) %>%
      summarise(n = n()) %>%
      ggplot(., x = rating, aes(x = "", y = n, fill = factor(rating))) + geom_bar(width = 1, stat = "identity") +
      coord_polar("y") + labs(x = "", y = "", title = "") + theme(axis.ticks = element_blank()) + 
      theme(legend.title = element_blank(), legend.position = "top") + theme(axis.text.x = element_blank())
      
  })
  
})