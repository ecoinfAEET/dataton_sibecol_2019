#this file erge all datasets under the same columns:

#species, day, month, year, recordedBy, family,decimalLongitude,decimalLatitude, taxa

gh <- read.csv("web/_data/grasshoppers.csv")
head(gh)
gh$taxa <- "ortoptera"

qp <- read.csv("web/_data/data_chiroptera.csv")
head(qp)
qp$taxa <- "chiroptera"

bf <- read.csv("web/_data/lepidoptera.csv", sep = ";")
head(bf)
bf$taxa <- "lepidoptera"

colnames(bf) <- c("species",
                  "family",
                  "decimalLatitude",
                  "decimalLongitude",
                  "datetime",
                  "taxa")

sl <- read.csv("web/_data/Tamarix_Retama_Chamaerops.csv")
head(sl)
sl$taxa <- "scrubland"

to_select <- c("species",
               "family",
               "decimalLatitude",
               "decimalLongitude",
               "taxa")

temp <- rbind(gh, qp)
temp2 <- rbind(temp[,to_select],bf[,to_select])
data <- rbind(temp2, sl[,to_select])
head(temp)
head(data)
dim(data)

#save on data.csv

write.csv(data, "web/_data/data.csv")
