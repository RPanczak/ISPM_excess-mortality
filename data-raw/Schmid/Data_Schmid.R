library(openxlsx)
library(readr)
library(tidyr)
library(dplyr)

Altersklassen_delete <- c("Total der Sterbefälle unter dem 20. Lebensjahr","Total der Sterbefälle über dem 20. Lebensjahr","Total der sämtlichen Sterbefälle",
                          "Entsprechende Sterblichkeitsziffer per Jahr und 20 Einwohner")

data.schmid <- read.xlsx("data-raw/Schmid/Schmid_Tabelle_XX.xlsx") %>%
  fill(Altersklassen) %>%
  filter(!(Altersklassen %in% Altersklassen_delete)) %>%
  select(-Total) %>%
  gather(.,Month,Number_death,3:14) %>%
  mutate(Number_death = as.integer(Number_death),
         Age=Altersklassen,
         Age=replace(Age, Age=="Unter 1 Jahr","<1"),
         Age=replace(Age, Age=="1-4 Jahre","1-4"),
         Age=replace(Age, Age=="5-19 Jahre","5-19"),
         Age=replace(Age, Age=="20-39 Jahre","20-39"),
         Age=replace(Age, Age=="40-59 Jahre","40-59"),
         Age=replace(Age, Age=="60-79 Jahre ","60-79"),
         Age=replace(Age, Age=="80 Jahre und darüber",">79"),
         Month=replace(Month, Month=="Januar","January"),
         Month=replace(Month, Month=="Februar","February"),
         Month=replace(Month, Month=="März","March"),
         Month=replace(Month, Month=="Mai","May"),
         Month=replace(Month, Month=="Juni","June"),
         Month=replace(Month, Month=="Juli","July"),
         Month=replace(Month, Month=="Sept.","September"),
         Month=replace(Month, Month=="Oktober","October"),
         Month=replace(Month, Month=="Nov.","November"),
         Month=replace(Month, Month=="Dez.","December")) %>%
  mutate(Age_f = factor(Age, levels = c("<1", "5-9", "1-4", 
                                      "20-39", "40-59", "60-79", ">79"))) %>% 
  mutate(Month_num = as.integer(factor(Month, levels = month.name))) %>% 
  select(Year=Jahre,Month,Month_num,Age,Age_f,Number_death) %>% 
  mutate(Date = lubridate::ymd(paste0(Year, "-", Month_num, "-01"))) %>% 
  as_tibble()

write_rds(data.schmid, "data/Schmid/Schmid_death.Rds")

# library(ggplot2)
# 
# ggplot(data.schmid, aes(x = Month_num, y = Number_death)) + 
#   geom_col() +
#   scale_x_continuous(breaks = c(1,6,12), labels = c('1','6','12')) +
#   facet_grid(vars(Age_f), vars(Year)) + 
#   theme_minimal()
# 
# ggplot(data.schmid, aes(x = Month_num, y = Number_death, color = factor(Year))) + 
#   geom_line() +
#   scale_x_continuous(breaks = c(1,6,12), labels = c('1','6','12')) +
#   facet_grid(vars(Age_f), scale = "free_y") + 
#   theme_minimal()