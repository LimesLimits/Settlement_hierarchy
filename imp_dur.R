# script imp_dur.R

# read the datafile

imp_dur <- read.csv("./IMP_DUR.txt", header=TRUE, sep=";")

ggplot(imp_dur, aes(x = IMP, y = FRQ, fill = DUR)) + 
  geom_bar(position = "fill", stat='identity') +
  guides(fill = guide_legend(reverse=TRUE)) +
  scale_fill_grey(start = 0.9, end = 0.1) +
  ggtitle("Duration and ceramic classes") +
  xlab("Ceramic class") +
  ylab("Proportion") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())
