# script mean_nn_per_period.R

# calculate mean of nearest neighbour distances

mnn_IJZL = mean(nndist(pp_IJZL))
mnn_ROMV = mean(nndist(pp_ROMV))
mnn_ROMM = mean(nndist(pp_ROMM))
mnn_ROML = mean(nndist(pp_ROML))

# bind outcomes to single data frame, and convert number to numeric

MNN_PERIOD <- data.frame(rbind(c("IJZL",mnn_IJZL),c("ROMV",mnn_ROMV),c("ROMM",mnn_ROMM),c("ROML",mnn_ROML)))
MNN_PERIOD$X2 <- as.numeric(as.character(MNN_PERIOD$X2))

# plot the results

ggplot(MNN_PERIOD, aes(X1, y = X2)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = round(X2, digits = 0)), vjust = -0.5) +
  ggtitle("Mean nearest neighbour distance per period") +
  xlab("Period") +
  ylab("Distance in m") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())