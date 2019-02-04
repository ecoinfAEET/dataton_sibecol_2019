#First we save family keys.
#Gbif----
library(rgbif)
spain_code <- isocodes[grep("Spain", isocodes$name), "code"]
portugal_code <- isocodes[grep("Portugal", isocodes$name), "code"]
orthoptera_key <- name_backbone(name="Orthoptera", rank = "order")$usageKey

#Second we fetch data
dat <- data.frame(name = NA, decimalLatitude = NA,
                  decimalLongitude = NA, scientificName = NA,
                  family = NA, genus = NA, species = NA,
                  year = NA, month = NA, day = NA, recordedBy = NA,
                  identifiedBy = NA, sex = NA)
for(i in c(orthoptera_key)){
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