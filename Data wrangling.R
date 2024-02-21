library(dplyr)
covid_past_df = read.csv("us_past_total.csv")
covid_current_df = read.csv("us_current.csv")
summarization_df <- full_join(covid_past_df, covid_current_df, by = c("date", "Location"))
summarization_df <- summarization_df %>%
  select(date, Location, past_total_cases, past_new_cases, past_total_deaths, past_new_deaths, past_icu, past_hosp, current_total_cases, current_total_death, current_new_death, current_icu, current_hosp)


threshold = 10000
 mutate(total_cases_category = ifelse(past_total_cases >= threshold | current_total_cases >= threshold, "Above Threshold", "Below Threshold"))

summarization_df <- summarization_df %>%
  mutate(cumulative_deaths = ifelse(is.na(past_total_deaths), 0, past_total_deaths) + 
           ifelse(is.na(current_total_death), 0, current_total_death))
