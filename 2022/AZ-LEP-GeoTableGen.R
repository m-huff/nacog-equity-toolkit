### NACOG - LEP DATA BY TRACT, STATE OF AZ ###
### MICHAEL HUFF ###

# Load libraries
packages <- c("data.table","tidyverse","tidycensus","tigris")
lapply(packages, require, character.only=TRUE); rm(packages)
censusYear <- 2020

# Set ACS API key and review variables
census_api_key("c56d5e0f0945fe0e6b0f681269a98a91bf815eeb", install=TRUE, overwrite=TRUE); readRenviron("~/.Renviron")
vars <- load_variables(2019, "acs5", cache=TRUE)

# TOTAL POPULATION
pop_tot <- get_acs(geography="tract", state="AZ",variables=c("B01001_001"), year=censusYear)[,c(1,4)]; colnames(pop_tot) <- c("GEOID","pop_tot")

lep_spa <- get_acs(geography="tract", state = "AZ", variables=c("B06007_005"), year=censusYear)[,4]; colnames(lep_spa) <- "lep_spa"
lep_oth <- get_acs(geography="tract", state = "AZ", variables=c("B06007_008"), year=censusYear)[,4]; colnames(lep_oth) <- "lep_oth"


dat_acs <- data.frame(pop_tot[,1])

dat_acs$ct_lep_spa <- lep_spa
dat_acs$ct_lep_oth <- lep_oth

rm(list=setdiff(ls(), "dat_acs"))

# WRITE COMPILED DATA TO FILE
write.csv(data.frame(dat_acs$GEOID, dat_acs$ct_lep_spa, dat_acs$ct_lep_oth), "C:/Users/micha/Desktop/AZ-LEP-tract.csv")

rm(list = ls())