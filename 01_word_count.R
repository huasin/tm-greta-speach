rm(list = ls())
library(tidytext)
library(wordcloud)
library(dplyr)
library(stringr)

# Read the data -----------------------------------------------------------

spech <- readRDS('files/00_speach_greta.rds')


# Word count --------------------------------------------------------------

word_count <- spech %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  count(word) %>% 
  filter(str_detect(word, '[:alpha:]'))
  
#Lematizacion
word_count <- word_count %>% 
  left_join(lexicon::hash_lemmas, by = c('word' = 'token')) %>% 
  mutate(word = ifelse(is.na(lemma), word, lemma)) %>%
  group_by(word) %>% 
  summarise(n = sum(n)) %>% 
  arrange(desc(n))


# Word cloud --------------------------------------------------------------

set.seed(111)
wordcloud(words = word_count$word,
          freq = word_count$n,
          min.freq = 1,
          max.words = 80,
          random.order = F,
          rot.per = .2,
          fixed.asp = T,
          colors = brewer.pal(4, "Set2"),
          scale = c(3.5, .1))


# Save the word count -----------------------------------------------------

saveRDS(word_count, 'files/word_count.rds')
