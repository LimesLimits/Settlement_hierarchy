# script hclass_pg_1500.R

# read the datafile

HCLASS_PG <- read.csv("./HCLASS_PG_1500.txt", header=TRUE, sep=";")

# plot the results

ggplot(HCLASS_PG, aes(x = Totals_1500m_Nb_mean, y = Palaeogeography_simplified, group = Palaeogeography_simplified)) + 
  geom_boxplot(fill="grey70", colour="black") +
  ggtitle("Mean hierarchical rank per palaeogeographical unit") +
  xlab("Mean hierarchical rank") +
  ylab("Unit") +
  scale_x_continuous(breaks=seq(0,7,1)) +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())
