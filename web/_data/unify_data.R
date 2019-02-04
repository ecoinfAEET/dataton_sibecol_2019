#this file erge all datasets under the same columns:

#species, day, month, year, recordedBy, family,decimalLongitude,decimalLatitude, taxa

gh <- read.csv("web/_data/grasshoppers.csv")
head(gh)


#save on data.csv

write.csv(gh, "web/_data/data.csv")
