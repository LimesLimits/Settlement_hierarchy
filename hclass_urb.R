# script hclass_urb.R

# extract the data per class, and calculate the statistics (number of settlements, mean and standard deviation of class rank)
# and bind it all back together

urban_hc1500 <- subset(HCLASS_1500, HCLASS_1 > 7 & HCLASS_2 < 8)
rural_hc1500 <- subset(HCLASS_1500, Site_type %like% "rural" & HCLASS_2 < 8)

hrank_urban_cnt <- aggregate(urban_hc1500$HCLASS_2, list(urban_hc1500$LimesLimits_ID_1), length)
hrank_rural_cnt <- aggregate(rural_hc1500$HCLASS_2, list(rural_hc1500$LimesLimits_ID_1), length)

hrank_urban_cnt$hclass <- "urban"
hrank_rural_cnt$hclass <- "rural"

hrank_all_cnt <- rbind(hrank_urban_cnt,hrank_rural_cnt)

hrank_urban_mean <- aggregate(urban_hc1500$HCLASS_2, list(urban_hc1500$LimesLimits_ID_1), mean)
hrank_rural_mean <- aggregate(rural_hc1500$HCLASS_2, list(rural_hc1500$LimesLimits_ID_1), mean)

hrank_urban_mean$hclass <- "urban"
hrank_rural_mean$hclass <- "rural"

hrank_all_mean <- rbind(hrank_urban_mean,hrank_rural_mean)

hrank_urban_std <- aggregate(urban_hc1500$HCLASS_2, list(urban_hc1500$LimesLimits_ID_1), sd)
hrank_rural_std <- aggregate(rural_hc1500$HCLASS_2, list(rural_hc1500$LimesLimits_ID_1), sd)

hrank_urban_std$hclass <- "urban"
hrank_rural_std$hclass <- "rural"

hrank_all_std <- rbind(hrank_urban_std,hrank_rural_std)

# plot the results

ggplot(hrank_all_cnt, aes(x = hclass, y = x, group = hclass)) +
  geom_boxplot(fill="grey70", colour="black") +
  stat_summary(fun=mean, shape=18, colour="black", size=3, geom="point") +
  ggtitle("Number of settlements within 1500 m per class") +
  xlab("Class") +
  ylab("Number") +
  #  scale_x_continuous(breaks=seq(1,7,1)) +
  scale_y_continuous(breaks=seq(0,20,2)) +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

ggplot(hrank_all_mean, aes(x = hclass, y = x, group = hclass)) +
  geom_boxplot(fill="grey70", colour="black") +
  stat_summary(fun=mean, shape=18, colour="black", size=3, geom="point") +
  ggtitle("Mean rank of settlements within 1500 m per class") +
  xlab("Class") +
  ylab("Mean rank") +
  #  scale_x_continuous(breaks=seq(1,7,1)) +
  scale_y_continuous(breaks=seq(0,7,1)) +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

ggplot(hrank_all_std, aes(x = hclass, y = x, group = hclass)) +
  geom_boxplot(fill="grey70", colour="black") +
  stat_summary(fun=mean, shape=18, colour="black", size=3, geom="point") +
  ggtitle("Standard deviation of rank of settlements within 1500 m per class") +
  xlab("Class") +
  ylab("Standard deviation of rank") +
  #  scale_x_continuous(breaks=seq(1,7,1)) +
  scale_y_continuous(breaks=seq(0,4,0.5)) +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

# calculate the ANOVA

summary(aov(hrank_all_cnt$x ~ as.factor(hrank_all_cnt$hclass)))
summary(aov(hrank_all_mean$x ~ as.factor(hrank_all_mean$hclass)))
summary(aov(hrank_all_std$x ~ as.factor(hrank_all_std$hclass)))
