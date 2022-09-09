# script nni_per_period.R

# install.packages("spatstat")
library(spatstat)

# create point patterns from data files

# the extent of the study region is defined by xmin xmax ymin ymax, this can be adapted if needed

xmin <- 73241
xmax <- 203530
ymin <- 412375
ymax <- 483121

xrange <- c(xmin,xmax)
yrange <- c(ymin,ymax)
extent <- (xmax - xmin) * (ymax - ymin)

pp_IJZL <- ppp(ASUM_IJZL$X_coordinate,ASUM_IJZL$Y_coordinate,xrange,yrange)
pp_ROMV <- ppp(ASUM_ROMV$X_coordinate,ASUM_ROMV$Y_coordinate,xrange,yrange)
pp_ROMM <- ppp(ASUM_ROMM$X_coordinate,ASUM_ROMM$Y_coordinate,xrange,yrange)
pp_ROML <- ppp(ASUM_ROML$X_coordinate,ASUM_ROML$Y_coordinate,xrange,yrange)

# calculate nearest neighbour indices from point patterns

nni_IJZL = mean(nndist(pp_IJZL))/(0.5 * sqrt(extent / NROW(ASUM_IJZL)))
nni_ROMV = mean(nndist(pp_ROMV))/(0.5 * sqrt(extent / NROW(ASUM_ROMV)))
nni_ROMM = mean(nndist(pp_ROMM))/(0.5 * sqrt(extent / NROW(ASUM_ROMM)))
nni_ROML = mean(nndist(pp_ROML))/(0.5 * sqrt(extent / NROW(ASUM_ROML)))

# bind outcomes to single data frame and convert numbers to numeric

NNI_PERIOD <- data.frame(rbind(c("IJZL",nni_IJZL),c("ROMV",nni_ROMV),c("ROMM",nni_ROMM),c("ROML",nni_ROML)))
NNI_PERIOD$X2 <- as.numeric(as.character(NNI_PERIOD$X2))

# plot the results

ggplot(NNI_PERIOD, aes(X1, y = X2)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = round(X2, digits = 3)), vjust = -0.5) +
  ggtitle("Nearest neighbour index per period") +
  xlab("Period") +
  ylab("NNI") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

  