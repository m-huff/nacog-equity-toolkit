dist <- read.csv(file = "C:/Users/micha/Desktop/PickupDist.csv")

dist["Walkable"] = ifelse(dist$NearStopMi <= 0.25, "Yes", "No")

write.csv(dist, "C:/Users/micha/Desktop/AddressGeocode.csv")