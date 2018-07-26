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

shinyUI(dashboardPage(
  dashboardHeader(title = "Movie Dashboard"),
  dashboardSidebar(
    sidebarMenu( menuItem("General Info", tabName = "general", icon = icon("database")),
                 menuItem("Users Info", tabName = "users", icon = icon("user"))
                 )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "general",
              fluidRow(
                sliderInput("points", "How many ratings of movies do you want to see?", min = 0, max = 100, value = 20, width = "100%"),
                box(plotlyOutput("all_ratings"), width = 12),
                box(plotlyOutput("rating_dens"), width = 6),
                box(plotOutput("rating_pan"), width = 6)
              )
        ),
              
      tabItem(tabName = "users",
              fluidRow(
                textInput("search_user", label = "Enter the userID (from 1 to 671): ", placeholder = "Enter the userID ...", value = 1), 
                submitButton(text = "Submit", icon("refresh")),
                box(plotOutput('genre_compare'), width = 12)
              )
            )
      )
    )
  )
)
