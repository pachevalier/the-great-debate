library(dplyr)
library(readr)
library(purrr)
library(tricky)

table_transition <- read_csv(file = "data-raw/LA_TRANSITION_ECOLOGIQUE.csv") %>%
  set_names(nm = names(.) %>% sub(pattern = "^(Q[[:digit:]]+).*", replacement = "\\1", x = .))
table_transition %>% glimpse()

table_transition %>%
  select(id, trashed, publishedAt, authorType, authorZipCode, starts_with('Q160')) %>%
  filter(is.na(Q160) == FALSE)

