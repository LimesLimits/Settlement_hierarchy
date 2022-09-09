# script percolation.R

#uncomment to run percopackage() - this may take some time! 
# percopackage() will store the results in two folders, [maps] and [analysis_results]
# for the purpose of this appendix, the analyses have already been run

# install.packages("spatial", "percopackage")
# library(spatial)
# library(percopackage)

# create input files for percopackage

perco_IJZL <- as.data.frame(cbind(PlcIndex = ASUM_IJZL$LimesLimits_ID,Easting = ASUM_IJZL$X_coordinate,Northing = ASUM_IJZL$Y_coordinate))
perco_ROMV <- as.data.frame(cbind(PlcIndex = ASUM_ROMV$LimesLimits_ID,Easting = ASUM_ROMV$X_coordinate,Northing = ASUM_ROMV$Y_coordinate))
perco_ROMM <- as.data.frame(cbind(PlcIndex = ASUM_ROMM$LimesLimits_ID,Easting = ASUM_ROMM$X_coordinate,Northing = ASUM_ROMM$Y_coordinate))
perco_ROML <- as.data.frame(cbind(PlcIndex = ASUM_ROML$LimesLimits_ID,Easting = ASUM_ROML$X_coordinate,Northing = ASUM_ROML$Y_coordinate))

# runs percolation analysis per period
# MAKE SURE THAT YOU RENAME OR MOVE FILES IN THE FOLDER [analysis_results] after each run!

# percolate(perco_IJZL,NULL,20,1,1,20,1000)
# mapClusters(perco_map,"Late Iron Age","perco_IJZL")
# plotClustFreq()

# percolate(perco_ROMV,NULL,20,1,1,20,1000)
# mapClusters(perco_map,"Early Roman period","perco_ROMV")
# plotClustFreq()

# percolate(perco_ROMM,NULL,20,1,1,20,1000)
# mapClusters(perco_map,"Middle Roman period","perco_ROMM")
# plotClustFreq()

# percolate(perco_ROML,NULL,20,1,1,20,1000)
# mapClusters(perco_map,"Late Roman period","perco_ROML")
# plotClustFreq()

# import analysis results in R

analysis_by_radius_IJZL <- read.csv("./analysis_results/IJZL/analysis_by_radius.csv")
analysis_by_radius_ROMV <- read.csv("./analysis_results/ROMV/analysis_by_radius.csv")
analysis_by_radius_ROMM <- read.csv("./analysis_results/ROMM/analysis_by_radius.csv")
analysis_by_radius_ROML <- read.csv("./analysis_results/ROML/analysis_by_radius.csv")

# plot the results as number of clusters and normalized maximum cluster size per radius

cbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

ggplot() +
geom_line(aes(radius, num_clust, colour="1"), size = 1, analysis_by_radius_IJZL) +
geom_line(aes(radius, num_clust, colour="2"), size = 1, analysis_by_radius_ROMV) +
geom_line(aes(radius, num_clust, colour="3"), size = 1, analysis_by_radius_ROMM) +
geom_line(aes(radius, num_clust, colour="4"), size = 1, analysis_by_radius_ROML) +
geom_point(aes(radius, num_clust, colour="1"), size = 3, analysis_by_radius_IJZL) +
geom_point(aes(radius, num_clust, colour="2"), size = 3, analysis_by_radius_ROMV) +
geom_point(aes(radius, num_clust, colour="3"), size = 3, analysis_by_radius_ROMM) +
geom_point(aes(radius, num_clust, colour="4"), size = 3, analysis_by_radius_ROML) +
ggtitle("Percolation analysis per period") +
scale_colour_manual(values=cbPalette, name="period",labels=c("IJZL","ROMV","ROMM","ROML")) +
xlab("Radius (km)") +
ylab("Number of clusters") +
theme(panel.background = element_rect(fill="white")) +
theme(axis.ticks.x=element_blank())

ggplot() +
  geom_line(aes(radius, max_normalized, colour="1"), size = 1, analysis_by_radius_IJZL) +
  geom_line(aes(radius, max_normalized, colour="2"), size = 1, analysis_by_radius_ROMV) +
  geom_line(aes(radius, max_normalized, colour="3"), size = 1, analysis_by_radius_ROMM) +
  geom_line(aes(radius, max_normalized, colour="4"), size = 1, analysis_by_radius_ROML) +
  geom_point(aes(radius, max_normalized, colour="1"), size = 3, analysis_by_radius_IJZL) +
  geom_point(aes(radius, max_normalized, colour="2"), size = 3, analysis_by_radius_ROMV) +
  geom_point(aes(radius, max_normalized, colour="3"), size = 3, analysis_by_radius_ROMM) +
  geom_point(aes(radius, max_normalized, colour="4"), size = 3, analysis_by_radius_ROML) +
  ggtitle("Percolation analysis per period") +
  scale_colour_manual(values=cbPalette, name="period",labels=c("IJZL","ROMV","ROMM","ROML")) +
  xlab("Radius (km)") +
  ylab("Maximum cluster size (normalized)") +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())