library(data.table)
library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(plotly)


ratings <- read.csv("./ml-latest-small/ratings.csv", stringsAsFactors = FALSE)
movies <- read.csv('./ml-latest-small/movies.csv', stringsAsFactors = FALSE)

movie_ratings <- inner_join(ratings, movies, by = "movieId")

mv_rat <- movie_ratings %>%
   mutate(., genres = strsplit(genres, '|', fixed = T)) 
mv_rat$timestamp <- NULL


#mv_with_rate <- write.csv(movie_ratings, file = "movie_ratings.csv")
  