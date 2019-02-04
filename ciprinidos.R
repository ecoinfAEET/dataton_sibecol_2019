#First we save family keys.
#Gbif----
library(rgbif)
spain_code <- isocodes[grep("Spain", isocodes$name), "code"]
portugal_code <- isocodes[grep("Portugal", isocodes$name), "code"]
apidae_key <- name_backbone(name="Cyprinid", rank = "family")$usageKey
andrenidae_key <- name_backbone(name="Thricoptera", rank = "order")$usageKey
halictidae_key <- name_backbone(name="Halictidae", rank = "family")$usageKey
colletidae_key <- name_backbone(name="Colletidae", rank = "family")$usageKey
megachilidae_key <- name_backbone(name="Megachilidae", rank = "family")$usageKey
stenotritidae_key <- name_backbone(name="Stenotritidae", rank = "family")$usageKey
melittidae_key <- name_backbone(name="Melittidae", rank = "family")$usageKey

#Second we fetch data
dat <- data.frame(name = NA, decimalLatitude = NA,
                  decimalLongitude = NA, scientificName = NA,
                  family = NA, genus = NA, species = NA,
                  year = NA, month = NA, day = NA, recordedBy = NA,
                  identifiedBy = NA, sex = NA)
for(i in c(apidae_key, andrenidae_key,
           halictidae_key, colletidae_key,
           megachilidae_key,
           melittidae_key)){
    temp <- occ_search(taxonKey= i,
                       return='data',
                       hasCoordinate=TRUE,
                       hasGeospatialIssue=FALSE,
                       limit=7000, #based on rounding up counts above
                       country = c(spain_code, portugal_code),
                       fields = c('name','decimalLatitude',
                                  'decimalLongitude', 'scientificName',
                                  'family','genus', 'species',
                                  'year', 'month', 'day', 'recordedBy',
                                  'identifiedBy', 'sex'))
    if(length(temp$PT) == 1){
        temp$PT <- data.frame(name = NA, decimalLatitude = NA,
                              decimalLongitude = NA, scientificName = NA,
                              family = NA, genus = NA, species = NA,
                              year = NA, month = NA, day = NA, recordedBy = NA,
                              identifiedBy = NA, sex = NA)
    }
    if(is.null(temp$ES$sex)){
        temp$ES$sex <- NA
    }
    if(is.null(temp$PT$sex)){
        temp$PT$sex <- NA
    }
    temp$ES <- temp$ES[,c('name','decimalLatitude',
                          'decimalLongitude', 'scientificName',
                          'family','genus', 'species',
                          'year', 'month', 'day', 'recordedBy',
                          'identifiedBy', 'sex')]
    temp$PT <- temp$PT[,c('name','decimalLatitude',
                          'decimalLongitude', 'scientificName',
                          'family','genus', 'species',
                          'year', 'month', 'day', 'recordedBy',
                          'identifiedBy', 'sex')]
    dat <- rbind(dat, as.data.frame(temp$ES), as.data.frame(temp$PT))
}
dat <- dat[-1,]
head(dat)
tail(dat)
dat <- dat[-nrow(dat),]
dim(dat) #6859