library(dplyr)
library(readr)
library(purrr)
library(tricky)

table_transition <- read_csv(file = "data-raw/LA_TRANSITION_ECOLOGIQUE.csv") %>%
  set_names(nm = names(.) %>% sub(pattern = "^(Q[[:digit:]]+).*", replacement = "\\1", x = .))
table_transition %>% glimpse()

table_transition %>%
  select(reference, starts_with("Q")) %>%
  gather(key = question, value = contribution, -reference) %>%
  filter(is.na(contribution) == FALSE) 

  
table_grandeannotation <- read_csv(file = "data-raw/actions.csv") 
table_grandeannotation %>% 
  select(Contribution, Question, Categorie) %>%
  mutate(Question = paste0("Q", Question)) %>%
  distinct() %>%
  left_join(
    y = table_transition %>%
      select(reference, starts_with("Q")) %>%
      gather(key = question, value = contribution, -reference) %>%
      filter(is.na(contribution) == FALSE),  
    by = c(
      "Question" = "question", 
      "Contribution" = "reference"
      )    
    )


  