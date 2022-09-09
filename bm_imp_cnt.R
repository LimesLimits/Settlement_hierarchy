# script bm_imp_cnt.R

install.packages("data.table")
library(data.table)

# read the datafiles

BM_ALLSITES <- read.csv("./BM_ALLSITES.txt", header=TRUE, sep=";")
IMP_ALLSITES <- read.csv("./IMP_ALLSITES.txt", header=TRUE, sep=";", fileEncoding = "utf16")

# first select all rural settlements using the data.table() package

rural_bm <- subset(BM_ALLSITES, Site_type %like% "rural")
rural_imp <- subset(IMP_ALLSITES, Site_type %like% "rural")

# tabulate the totals per group

rbm_cnt <- table(rural_bm$BM_GROUP)
rimp_cnt <- table(rural_imp$IMP_GROUP)

# plot the results

ggplot(as.data.frame(rbm_cnt), aes(Var1, Freq)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = Freq, vjust = -0.5)) +
  ggtitle("Rural settlements and building material") +
  xlab("Group") +
  ylab("Number") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

ggplot(as.data.frame(rimp_cnt), aes(Var1, Freq)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = Freq, vjust = -0.5)) +
  ggtitle("Rural settlements and imported ceramics") +
  xlab("Group") +
  ylab("Number") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())
  
