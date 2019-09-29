rm(list = ls())
library(tidytext)
library(corpus) #steming
library(wordcloud)
library(dplyr)
library(stringr)
library(forcats)
library(ggplot2)


# Read data ---------------------------------------------------------------

wc <- readRDS('files/word_count.rds')


# Sentiment NRC -----------------------------------------------------------

word_nrc <- wc %>% 
  inner_join(get_sentiments("nrc"), by =  'word') %>% 
  group_by(sentiment) %>% 
  summarise(n = sum(n)) %>% 
  arrange(desc(n)) %>% 
  filter(!sentiment %in% c('positive','negative')) %>% 
  mutate(sentiment = fct_reorder(sentiment, n))

word_bing <- wc %>% 
  inner_join(get_sentiments("bing"), by =  'word') %>% 
  group_by(sentiment) %>% 
  summarise(n = sum(n))


# Charts ------------------------------------------------------------------

word_nrc %>% 
  ggplot(aes(sentiment, n)) +
  geom_col(fill = brewer.pal(8, "Set2")[1]) +
  coord_flip() +
  labs(title = "Greta Thumberg Speach",
       subtitle = "NRC Setiment Analysis",
       y = "Score",
       x = element_blank())
