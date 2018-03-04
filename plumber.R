#load libraries

library(tidyverse)
library(magrittr)
library(RPostgreSQL)
library(plumber)

#establish database connections

drv <- dbDriver("PostgreSQL")
pgconn <- dbConnect(drv, dbname="pg1",
                    host="pdb1.c7asxuecrarw.us-west-2.rds.amazonaws.com", port=5432,
                    user="postgreskadmin", password="ht534!nk")

# start plumbering

#' Return the description of the ticker received
#' @param tick The ticker whose description should be returned to the user
#' @post /description
function(tick=""){
  
  descript <- dbGetQuery(pgconn,'SELECT ticker,long_description FROM companydescription')
  descript_show <- descript %>% filter(ticker==tick)
  return(descript_show$long_description)
}
