
# Load data from Gbif and then run the following code:
# Name 'dat' to your data

ji <- function(xy, origin=c(0,0), cellsize=c(0.1,0.1)) {
  t(apply(xy, 1, function(z) cellsize/2+origin+cellsize*(floor((z - origin)/cellsize))))
}

JI <- ji(cbind(dat$decimalLongitude, dat$decimalLatitude))
dat$X <- JI[, 1]
dat$Y <- JI[, 2]
dat$Cell <- paste(dat$X, dat$Y)


counts <- by(dat, dat$Cell, function(d) c(d$X[1], d$Y[1], 
                                          length(unique(d$scientificName))))
head(counts)
counts.m <- matrix(unlist(counts), nrow=3)
rownames(counts.m) <- c("X", "Y", "Count")
write.csv(as.data.frame(t(counts.m)), "grid.csv")

count.max <- max(counts.m["Count",])
colors = sapply(counts.m["Count",], function(n) hsv(sqrt(n/count.max), .7, .7, .5))
plot(counts.m["X",] + 1/2, counts.m["Y",] + 1/2, cex=1,
     pch = 19, col=colors, xlim=c(-12,5), ylim=c(35,45),
     xlab="Longitude of cell center", ylab="Latitude of cell center",
     main="Shrub richness within 1 km grid cells")


# Code was extracted and modified from:
# https://gis.stackexchange.com/questions/48416/aggregating-points-to-grid-using-r