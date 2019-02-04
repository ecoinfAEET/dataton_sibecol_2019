#this file erge all datasets under the same columns:

#species, day, month, year, recordedBy, family,decimalLongitude,decimalLatitude, taxa

gh <- read.csv("web/_data/grasshoppers.csv")
head(gh)

qp <- read.csv("web/_data/data_chiroptera.csv")
head(qp)

bf <- read.csv("web/_data/lepidoptera.csv", sep = ";")
head(bf)
colnames(bf) <- c("species",
                  "family",
                  "decimalLatitude",
                  "decimalLongitude",
                  "datetime")

to_select <- c("species",
               "family",
               "decimalLatitude",
               "decimalLongitude")

temp <- rbind(gh, qp)
data <- rbind(temp[,to_select],bf[,to_select])
head(data)
dim(data)

#save on data.csv

write.csv(gh, "web/_data/data.csv")
