# script hclass_1500.R

# extract the data per class, and calculate the statistics (number of settlements, mean and standard deviation of class rank)
# and bind it all back together

hrank_urban <- subset(rural_hc1500, final_groups_1_FINAL.GROUP > 7)
hrank_rural <- subset(rural_hc1500, final_groups_1_FINAL.GROUP < 8)

hrank_urban_cnt <- aggregate(hrank_1$final_groups_FINAL.GROUP, list(hrank_1$LimesLimits.sites_LimesLimits_ID), length)
hrank_rural_cnt <- aggregate(hrank_2$final_groups_FINAL.GROUP, list(hrank_2$LimesLimits.sites_LimesLimits_ID), length)

hrank_urban_cnt$hclass <- "urban"
hrank_rural_cnt$hclass <- "rural"

hrank_all_cnt <- rbind(hrank_urban_cnt,hrank_rural_cnt)

hrank_urban_mean <- aggregate(hrank_1$final_groups_FINAL.GROUP, list(hrank_1$LimesLimits.sites_LimesLimits_ID), mean)
hrank_rural_mean <- aggregate(hrank_2$final_groups_FINAL.GROUP, list(hrank_2$LimesLimits.sites_LimesLimits_ID), mean)

hrank_urban_mean$hclass <- "urban"
hrank_rural_mean$hclass <- "rural"

hrank_all_mean <- rbind(hrank_urban_mean,hrank_rural_mean)

hrank_urban_std <- aggregate(hrank_1$final_groups_FINAL.GROUP, list(hrank_1$LimesLimits.sites_LimesLimits_ID), sd)
hrank_rural_std <- aggregate(hrank_2$final_groups_FINAL.GROUP, list(hrank_2$LimesLimits.sites_LimesLimits_ID), sd)

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

summary(aov(hrank_all_cnt$x ~ as.factor(hrank_all_cnt$hclass)))
summary(aov(hrank_all_mean$x ~ as.factor(hrank_all_mean$hclass)))
summary(aov(hrank_all_std$x ~ as.factor(hrank_all_std$hclass)))

plot(TukeyHSD(aov(hrank_all_cnt$x ~ as.factor(hrank_all_cnt$hclass))))
plot(TukeyHSD(aov(hrank_all_mean$x ~ as.factor(hrank_all_mean$hclass))))
plot(TukeyHSD(aov(hrank_all_std$x ~ as.factor(hrank_all_std$hclass))))

