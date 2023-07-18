### NACOG - EQUITY DATA BY TRACT, STATE OF AZ ###
### MICHAEL HUFF ###

# Load libraries
packages <- c("data.table","tidyverse","tidycensus","tigris")
lapply(packages, require, character.only=TRUE); rm(packages)
censusYear <- 2020

# Set ACS API key and review variables
census_api_key("c56d5e0f0945fe0e6b0f681269a98a91bf815eeb", install=TRUE, overwrite=TRUE); readRenviron("~/.Renviron")
vars <- load_variables(2019, "acs5", cache=TRUE)

# TOTAL POPULATION
pop_tot <- get_acs(geography="tract", state="AZ",variables=c("B01001_001"), year=censusYear)[,c(1,4)]; colnames(pop_tot) <- "pop_tot"

# COUNT OF RACE
rac_tot <- get_acs(geography="tract", state = "AZ", variables=c("B02001_001"), year=censusYear)[,4]; colnames(rac_tot) <- "rac_tot"
rac_tot_wh <- get_acs(geography="tract", state = "AZ", variables=c("B02001_002"), year=censusYear)[,4]; colnames(rac_tot_wh) <- "rac_tot_wh"
rac_tot_ba <- get_acs(geography="tract", state = "AZ", variables=c("B02001_003"), year=censusYear)[,4]; colnames(rac_tot_ba) <- "rac_tot_ba"
rac_tot_ai <- get_acs(geography="tract", state = "AZ", variables=c("B02001_004"), year=censusYear)[,4]; colnames(rac_tot_ai) <- "rac_tot_ai"
rac_tot_as <- get_acs(geography="tract", state = "AZ", variables=c("B02001_005"), year=censusYear)[,4]; colnames(rac_tot_as) <- "rac_tot_as"
rac_tot_nh <- get_acs(geography="tract", state = "AZ", variables=c("B02001_006"), year=censusYear)[,4]; colnames(rac_tot_nh) <- "rac_tot_nh"

# COUNT OF LATINO RACE
lat_tot_xxx <- get_acs(geography="tract", state = "AZ", variables=c("B03002_012"), year=censusYear)[,4]; colnames(lat_tot_xxx) <- "lat_tot_xxx"
lat_tot_whi <- get_acs(geography="tract", state = "AZ", variables=c("B03002_013"), year=censusYear)[,4]; colnames(lat_tot_whi) <- "lat_tot_whi"

# COUNT OF EDUCATIONAL STATUS
edu_tot <- get_acs(geography="tract", state = "AZ", variables=c("B06009_001"), year=censusYear)[,4]; colnames(edu_tot) <- "edu_tot"
edu_tot_lhs <- get_acs(geography="tract", state = "AZ", variables=c("B06009_002"), year=censusYear)[,4]; colnames(edu_tot_lhs) <- "edu_tot_lhs"
edu_tot_hse <- get_acs(geography="tract", state = "AZ", variables=c("B06009_003"), year=censusYear)[,4]; colnames(edu_tot_hse) <- "edu_tot_hse"
edu_tot_sca <- get_acs(geography="tract", state = "AZ", variables=c("B06009_004"), year=censusYear)[,4]; colnames(edu_tot_sca) <- "edu_tot_sca"
edu_tot_bch <- get_acs(geography="tract", state = "AZ", variables=c("B06009_005"), year=censusYear)[,4]; colnames(edu_tot_bch) <- "edu_tot_bch"
edu_tot_grd <- get_acs(geography="tract", state = "AZ", variables=c("B06009_006"), year=censusYear)[,4]; colnames(edu_tot_grd) <- "edu_tot_grd"

# COUNT OF INCOME
inc_xxx_xxx <- get_acs(geography="tract", state = "AZ", variables=c("B19001_001"), year=censusYear)[,4]; colnames(inc_xxx_xxx) <- "inc_xxx_xxx"
inc_xxx_010 <- get_acs(geography="tract", state = "AZ", variables=c("B19001_002"), year=censusYear)[,4]; colnames(inc_xxx_010) <- "inc_xxx_010"
inc_010_015 <- get_acs(geography="tract", state = "AZ", variables=c("B19001_003"), year=censusYear)[,4]; colnames(inc_010_015) <- "inc_010_015"
inc_015_020 <- get_acs(geography="tract", state = "AZ", variables=c("B19001_004"), year=censusYear)[,4]; colnames(inc_015_020) <- "inc_015_020"
inc_020_025 <- get_acs(geography="tract", state = "AZ", variables=c("B19001_005"), year=censusYear)[,4]; colnames(inc_020_025) <- "inc_020_025"

# COUNT OF RESIDENTS WITH LIMITED ENGLISH PROFICIENCY
lep_spa <- get_acs(geography="tract", state = "AZ", variables=c("B06007_005"), year=censusYear)[,4]; colnames(inc_xxx_xxx) <- "lep_spa"
lep_oth <- get_acs(geography="tract", state = "AZ", variables=c("B06007_008"), year=censusYear)[,4]; colnames(inc_xxx_xxx) <- "lep_spa"


dat_acs <- data.frame(pop_tot[,1])

dat_acs$ct_pop_tot <- pop_tot

dat_acs$ct_edu_1 <- (edu_tot_lhs + edu_tot_hse)
dat_acs$ct_edu_2 <- (edu_tot_sca + edu_tot_bch)
dat_acs$ct_edu_3 <- (edu_tot_grd)

dat_acs$ct_rac_whi <- (rac_tot_wh - lat_tot_whi)
dat_acs$ct_rac_lat <- (lat_tot_whi)
dat_acs$ct_rac_baa <- (rac_tot_ba)
dat_acs$ct_rac_asn <- (rac_tot_as)
dat_acs$ct_rac_aia <- (rac_tot_ai)
dat_acs$ct_rac_npi <- (rac_tot_nh)

dat_acs$ct_pov <- (inc_xxx_010 + inc_010_015 + inc_015_020 + inc_020_025)

dat_acs$ct_lep <- (lep_spa + lep_oth)

rm(list=setdiff(ls(), "dat_acs"))

# WRITE COMPILED DATA TO FILE
write.csv(dat_acs, "C:/Users/micha/Desktop/AZ-equity-tract.csv")

rm(list = ls())