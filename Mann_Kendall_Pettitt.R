library(tidyverse)
library(trend)
library(lubridate)



df <- read_xlsx("Nova_Odessa.xlsx") # %>% mutate(prcp  = as.numeric(prcp), tmin = tmin/100, tmax = tmax/100)

# function to run Mann-Kendall and Pettitt tests over a region
calculate_trends <- function(dados) {
  
  # run Mann-Kendall and Pettitt tests on data (each variable)
  mk_tmin <- mk.test(dados$tmin)
  ptt_tmin <- pettitt.test(dados$tmin)
  
  mk_tmax <- mk.test(dados$tmax)
  ptt_tmax <- pettitt.test(dados$tmax)
  
  mk_prcp <- mk.test(dados$prcp)
  ptt_prcp <- pettitt.test(dados$prcp)
  
  # create dataframes for each variable
  df_tmin <- tibble(
    VARIABLE = "tmin",
    MK_p = mk_tmin$p.value,
    MK_z = mk_tmin$statistic,
    MK_S = mk_tmin$estimates[1],
    MK_varS = mk_tmin$estimates[2],
    MK_tau = mk_tmin$estimates[3],
    PTT_cp = dados[[ptt_tmin$estimate[1], 1]],
    PTT_p = ptt_tmin$p.value,
    PTT_U = ptt_tmin$statistic,
    PTT_mu1 = mean(dados[1:ptt_tmin$estimate[1],]$tmin),
    PTT_mu2 = mean(dados[ptt_tmin$estimate[1]:nrow(dados),]$tmin)
  )
  
  df_tmax <- tibble(
    VARIABLE = "tmax",
    MK_p = mk_tmax$p.value,
    MK_z = mk_tmax$statistic,
    MK_S = mk_tmax$estimates[1],
    MK_varS = mk_tmax$estimates[2],
    MK_tau = mk_tmax$estimates[3],
    PTT_cp = dados[[ptt_tmax$estimate[1], 1]],
    PTT_p = ptt_tmax$p.value,
    PTT_U = ptt_tmax$statistic,
    PTT_mu1 = mean(dados[1:ptt_tmax$estimate[1],]$tmax),
    PTT_mu2 = mean(dados[ptt_tmax$estimate[1]:nrow(dados),]$tmax)
  )
  
  df_prcp <- tibble(
    VARIABLE = "prcp",
    MK_p = mk_prcp$p.value,
    MK_z = mk_prcp$statistic,
    MK_S = mk_prcp$estimates[1],
    MK_varS = mk_prcp$estimates[2],
    MK_tau = mk_prcp$estimates[3],
    PTT_cp = dados[[ptt_prcp$estimate[1], 1]],
    PTT_p = ptt_prcp$p.value,
    PTT_U = ptt_prcp$statistic,
    PTT_mu1 = mean(dados[1:ptt_prcp$estimate[1],]$prcp),
    PTT_mu2 = mean(dados[ptt_prcp$estimate[1]:nrow(dados),]$prcp)
  )
  
  # combine into a single dataframe and interpret the test results
  results <- bind_rows(df_tmin, df_tmax, df_prcp) |> mutate(
    MK_trend = case_when(
      MK_S > 0 & MK_p < 0.05 ~ 'increasing',
      MK_S > 0 & MK_p > 0.05 ~ 'no trend',
      MK_S == 0 ~ 'no trend',
      MK_S < 0 & MK_p > 0.05 ~ 'no trend',
      MK_S < 0 & MK_p < 0.05 ~ 'decreasing'
    )
  ) |> relocate(MK_trend, .after = VARIABLE)
  
  return(results)
}


# apply function to all regions
#trends_df <- calculate_trends(df)
nova_odessa_novo = calculate_trends(df)
## Export ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

write_csv(nova_odessa_novo, "Nova_Odessa_trends.csv")
