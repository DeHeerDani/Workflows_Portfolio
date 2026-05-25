
# ~/Workflows/Workflows_Portfolio/Opdracht_5_SQL

library(tidyverse)
library(dslabs)
library(ggplot2)

# gapminder is al tidy en hoeft niet aangepast te worden.
data(gapminder)
# view(gapminder)

readLines("~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/dengue_data.csv", n = 15)

# data laten inlezen maar skip de meta data
dengue <- read_csv("~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/dengue_data.csv", skip = 11)
flu <- read_csv("~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/flu_data.csv", skip = 11)
# view(dengue)
# view(flu)

# data tidy maken
dengue_long <- dengue %>%
  pivot_longer(
    cols = -1,
    names_to = "country",
    values_to = "cases"
  )

flu_long <- flu %>%
  pivot_longer(
    cols = -1,
    names_to = "country",
    values_to = "cases"
  )


# view(dengue_long)
# view(flu_long)
# view(gapminder)

# dubbel check of het goed staat
str(dengue_long$Date)
summary(dengue_long$cases)
unique(dengue_long$country)

# dubbel check of het goed staat
str(flu_long$Date)
summary(flu_long$cases)
unique(flu_long$country)

# stap 3 het gelijk stellen van country en Date.
gapminder <- gapminder %>% mutate(Date = as.Date(paste0(year, "-01-01"))) %>% select(Date, everything(), -year)

gapminder <- gapminder %>% mutate(country = as.character(country))


# stap 4 is het join ready maken van de data. 

# check of alles hetzelfe type is.
str(gapminder$Date)
str(dengue_long$Date)
str(flu_long$Date)

str(gapminder$country)
str(dengue_long$country)
str(flu_long$country)

gapminder_join <- gapminder %>%
  mutate(
    Date = as.Date(paste0(year, "-01-01")),
    country = as.character(country)
  ) %>%
  select(country, Date, life_expectancy)


gapminder_join <- gapminder %>%
  mutate(country = as.character(country)) %>%
  select(country, Date, life_expectancy)


# stap 5 is het opslaan als csv bestanden.
write_csv(flu_long, "~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/flu_clean.csv")
write_csv(dengue_long, "~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/dengue_clean.csv")
write_csv(gapminder_join, "~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/gapminder_clean.csv")


data <- read_csv("~/Workflows/Workflows_Portfolio/Opdracht_5_SQL/joined_data.csv")

data_clean <- data %>%
  filter(!is.na(flu_cases), !is.na(dengue_cases))

ggplot(data_clean, aes(x = flu_cases, y = dengue_cases)) +
  geom_point()

ggplot(data_clean, aes(x = life_expectancy, y = flu_cases)) +
  geom_point()



