library(kableExtra)
library(openxlsx)
library(tidyverse)
library(lubridate)
library(scales)
library(magrittr)
library(slider)
library(doParallel)
library(foreach)
library(rmarkdown)
library(rmdformats)
library(pxR)
library(janitor)
library(viridis)
library(pxR)


# prepare data
source("R/fn_prepare_monthly_weekly_data.R")

fn_prepare_monthly_weekly_data(Country.data="Switzerland",data.timespan="Week")
fn_prepare_monthly_weekly_data(Country.data="Switzerland",data.timespan="Month")
fn_prepare_monthly_weekly_data(Country.data="Spain",data.timespan="Week")
fn_prepare_monthly_weekly_data(Country.data="Spain",data.timespan="Month")
fn_prepare_monthly_weekly_data(Country.data="Sweden",data.timespan="Week")
fn_prepare_monthly_weekly_data(Country.data="Sweden",data.timespan="Month")


# # combine data
source("R/fn_comparison_monthly_weekly.R")
source("R/plot_appendix_month_weeks.R")
# fn_comparison_monthly_weekly("Switzerland")
# fn_comparison_monthly_weekly("Spain")
# fn_comparison_monthly_weekly("Sweden")

function_plot_appendix_month_weeks()

# render 
# setwd("./analyses")
render("analyses/06_Comparison_week_month.Rmd")
# setwd(rprojroot::find_rstudio_root_file())

