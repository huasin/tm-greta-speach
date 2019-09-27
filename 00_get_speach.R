rm(list = ls())
library(rvest)
library(stringr)


# Get the html data -------------------------------------------------------

doc <- read_html('https://www.npr.org/2019/09/23/763452863/transcript-greta-thunbergs-speech-at-the-u-n-climate-action-summit')


# Get the speach from html ------------------------------------------------

# all paragraps
parag <- doc %>% 
  html_nodes('p') %>% 
  html_text()

# get only paragraphs we wont
speach <- parag[3:16] %>% 
  paste(collapse = ' ') %>%
  str_remove_all('"') %>% 
  str_squish()


# Save the data -----------------------------------------------------------

speach %>% saveRDS('files/00_speach_greta.rds')
