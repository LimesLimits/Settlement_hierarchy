# script hclass_cnt.R

# read the datafile

HCLASS_RURAL <- read.csv("./HCLASS_RURAL.txt", header=TRUE, sep=";")

# tabulate the totals per group

hclass_cnt <- table(HCLASS_RURAL$HCLASS)

# plot the results

ggplot(as.data.frame(hclass_cnt), aes(Var1, Freq)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = Freq, vjust = -0.5)) +
  ggtitle("Rural settlements per hierarchical class") +
  xlab("Class") +
  ylab("Number") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

