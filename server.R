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
library(stringr)
library(DT)


# Define server logic required to draw a histogram
shinyServer(function(session, input, output){
  
  
  allRating <- reactive({
    mv_rat %>%
      group_by(., title) %>%
      summarise(., mean_rating = mean(rating)) %>% 
      sample_n(input$points)
  })
  
  output$all_ratings <- renderPlotly({
      
    all = ggplot(allRating(), aes(x = title, y = mean_rating)) + geom_point() +  
      theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
    ggplotly(all) 
  })
  
  output$rating_dens <- renderPlotly({
      sep_genre = separate_rows(mv_rat, genres, convert = FALSE)
      sep_cleaned = sep_gen %>%
        filter(., genres != '') %>%
        filter(., genres != 'c') %>%
        filter(., genres != 'no') %>%
        filter(., genres != 'genres') %>%
        filter(., genres != 'listed') %>%
        filter(., genres != 'Fi') %>%
        filter(., genres != 'Film')
      
      sep_tmp = sep_cleaned %>%
        group_by(., genres) %>%
        summarise(., avg_rating = mean(rating)) %>%
        select(., genres, avg_rating)
      
      rat_dens <- ggplot(sep_tmp, aes(x = genres, y = avg_rating)) + geom_bar(stat = 'identity', fill = "steelblue") +
        theme(axis.text.x=element_blank(),
              axis.ticks.x=element_blank())
      
      ggplotly(rat_dens)
  })
  
  output$rating_pan <- renderDataTable({
    mv_rat %>%
      group_by(., rating) %>%
      summarise(n = n()) %>%
      select(., rating = rating, numbers = n)
  })
  
  output$genre_compare <- renderPlotly({
    sep_user = mv_rat %>%
        select(., userId, title, rating, genres) %>%
        filter(., userId == input$search_user) 
    
    sep_gen = separate_rows(sep_user, genres, convert = FALSE)
  
    sep_clean = sep_gen %>%
      filter(., genres != 'c') %>%
      filter(., genres != "")  %>%
      filter(., genres != 'no') %>%
      filter(., genres != 'genres') %>%
      filter(., genres != 'listed') %>%
      filter(., genres != 'Fi') %>%
      filter(., genres != 'Film')
    
    #head(sep_clean)
    tmp = sep_clean %>%
      group_by(., genres) %>%
      summarise(n = n()) %>%
      ggplot(., aes(x = genres, y = n)) + geom_bar(stat = 'identity')
    
    ggplotly(tmp)
  })
  
  
  output$genre_avg <- renderPlotly({
    sep_user = mv_rat %>%
      select(., userId, title, rating, genres) %>%
      filter(., userId == input$search_user) 
    
    sep_gen = separate_rows(sep_user, genres, convert = FALSE)
    
    sep_clean = sep_gen %>%
      filter(., genres != 'c') %>%
      filter(., genres != "")  %>%
      filter(., genres != 'no') %>%
      filter(., genres != 'genres') %>%
      filter(., genres != 'listed') %>%
      filter(., genres != 'Fi') %>%
      filter(., genres != 'Film')
    
    #head(sep_clean)
    tmp = sep_clean %>%
      group_by(., genres) %>%
      summarise(., avg_rating = mean(rating)) %>%
      ggplot(., aes(x = genres, y = avg_rating)) + geom_bar(stat = 'identity')
    
    ggplotly(tmp)
  })
})
