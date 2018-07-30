#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(data.table)
library(dplyr)
library(ggplot2)
library(tidyr)
library(DT)

shinyUI(dashboardPage(
  dashboardHeader(title = "Movie Dashboard"),
  dashboardSidebar(
    sidebarMenu( 
      menuItem("Intro", tabName = "intro", icon = icon("info")),
      menuItem("General Info", tabName = "general", icon = icon("database")),
      menuItem("Users Info", tabName = "users", icon = icon("user"))
      )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro", 
              fluidRow(
                box("Movie ratings have become one of the most important factors for people to choose a movie before going to cinemas.
                By evaluating the ratings from individual users from IMdB, this allows movie industries to evaluate and learn people's
                current taste and background. This website gives a general overview of the dataset offered by Movie lens lab group from 
                University of Minnesota. The future goal of this website is to predict movies ratings and make a recommendation system
                based on users' activities combining with the future algorithm and techniques learning from the future. ", width = 12),
                #img(src = "https://cdn20.patchcdn.com/users/22949620/20180504/071619/styles/T800x600/public/processed_images/jag_cz_movie_theater_retro_shutterstock_594132752-1525432478-9343.jpg"),
                img(src = "https://boygeniusreport.files.wordpress.com/2016/03/movies-tiles.jpg?quality=98&strip=all")
              )
              ), 
      tabItem(tabName = "general",
              fluidRow(
                sliderInput("points", "How many ratings of movies do you want to see?", min = 0, max = 100, value = 20, width = "100%"),
                box(plotlyOutput("all_ratings"), width = 12),
                box(plotlyOutput("rating_dens"), width = 6),
                box(DT::dataTableOutput("rating_pan"), width = 6)
              )
        ),
              
      tabItem(tabName = "users",
              fluidRow(
                textInput("search_user", label = "Enter the userID (from 1 to 671): ", placeholder = "Enter the userID ...", value = 1), 
                submitButton(text = "Submit", icon("refresh")),
                box(plotlyOutput('genre_compare'), width = 12),
                box(plotlyOutput('genre_avg'), width = 12)
              )
            )
      
      )
    )
  )
)
