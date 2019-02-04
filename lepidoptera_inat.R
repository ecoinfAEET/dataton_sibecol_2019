library(rinat)


bounds <- c(44.15, -10.13, 35.67, 4.76) #Spain


hesp <- get_inat_obs(taxon_name = "Hesperiidae", geo = TRUE, maxresults = 70000 , bounds = bounds)
lyc <- get_inat_obs(taxon_name = "Lycaenidae", geo = TRUE, maxresults = 70000 , bounds = bounds)

hesp$family <- "Hesperiidae"
lyc$family <- "Lycaenidae"

noc <- readr::read_delim("noctuidae.csv",delim = ";")
noc$family <- "Noctuidae"

nimph <- readr::read_delim("nymphalidae.csv",delim = ";")
nimph$family <- "Nymphalidae"

data_isa <- readr::read_delim("data_isa(1).csv",delim = ";")
names(data_isa)[which(names(data_isa) == "Family")] <- "family"

lep_all <- rbind(hesp,lyc,noc,nimph,data_isa)

#---------------------
lep_all <- lep_all[,c("scientific_name","family","latitude","longitude","datetime")]

readr::write_delim(lep_all,"lepidoptera.csv",delim = ";")






