pickup <- readxl::read_excel("C:/Users/micha/Desktop/GIS/mtnline/addresses_raw.xlsx", 
                             sheet = "Pickup Address", col_names = FALSE)

colnames(pickup) <- c("Address", "City")
pickup["State"] <- "Arizona"
pickup["Country"] <- "United States"

## MANUAL ADDRESS FIXES
pickup$Address[1] <- "1 E Route 66"
pickup$Address[12] <- "1201 East Ponderosa Parkway"
pickup$Address[26] <- "1716 E Route 66"
pickup$Address[31] <- "201 E Switzer Drive"
pickup$Address[41] <- "2610 E Route 66"
pickup$Address[54] <- "4308 E Route 66"
pickup$Address[55] <- "4650 US 89"
pickup$Address[57] <- "5060 US 89"
pickup$Address[66] <- "914 E Route 66"

write.csv(pickup, file = "C:/Users/micha/Desktop/GIS/mtnline/addresses_csv_formatted.csv")


