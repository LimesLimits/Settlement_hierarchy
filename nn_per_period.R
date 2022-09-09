# calculates nearest neighbour distance for all sites per period

nnd_IJZL <- data.frame(nnd = nndist(pp_IJZL))
nnd_IJZL$PERIOD <- "IJZL"
nnd_IJZL$order <- 1
nnd_ROMV <- data.frame(nnd = nndist(pp_ROMV))
nnd_ROMV$PERIOD <- "ROMV"
nnd_ROMV$order <- 2
nnd_ROMM <- data.frame(nnd = nndist(pp_ROMM))
nnd_ROMM$PERIOD <- "ROMM"
nnd_ROMM$order <- 3
nnd_ROML <- data.frame(nnd = nndist(pp_ROML))
nnd_ROML$PERIOD <- "ROML"
nnd_ROML$order <- 4

# binds the data

nnd_ALL <- rbind(nnd_IJZL,nnd_ROMV,nnd_ROMM,nnd_ROML)

# plots the results

ggplot(nnd_ALL, aes(as.character(order), nnd)) + 
  geom_boxplot(fill="grey70", colour="black") +
  ggtitle("Distance to nearest rural settlement") +
  scale_x_discrete(labels = c("IJZL", "ROMV", "ROMM", "ROML")) +
  scale_y_log10() +
  xlab("Period") +
  ylab("Distance in m (log10)") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

