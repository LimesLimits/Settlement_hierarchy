# script sites_per_period.R

# ASUM_IJZL <- read.csv("./ASUM_IJZL.txt", header=TRUE, sep=";")
# ASUM_ROMV <- read.csv("./ASUM_ROMV.txt", header=TRUE, sep=";")
# ASUM_ROMM <- read.csv("./ASUM_ROMM.txt", header=TRUE, sep=";")
# ASUM_ROML <- read.csv("./ASUM_ROML.txt", header=TRUE, sep=";")

# script sites_per_period.R
# install.packages("ggplot2")
library(ggplot2)

# count numbers of sites per period and bind them together, convert numbers to numeric

N_PERIOD <- data.frame(rbind(c("IJZL",nrow(ASUM_IJZL)),c("ROMV",nrow(ASUM_ROMV)),c("ROMM",nrow(ASUM_ROMM)),c("ROML",nrow(ASUM_ROML))))

N_PERIOD$X2 <- as.numeric(as.character(N_PERIOD$X2))

# plot numbers of sites per period

ggplot(N_PERIOD, aes(X1, y = X2)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = X2), vjust = -0.5) +
  ggtitle("Rural settlements per period") +
  xlab("Period") +
  ylab("Number") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())
  