# script imp_var.R

# read the datafile
# library(data.table)
# IMP_ALLSITES <- read.csv("./IMP_ALLSITES.txt", header=TRUE, sep=";", fileEncoding = "utf16")

# first select all rural settlements using the data.table() package

# rural_imp <- subset(IMP_ALLSITES, Site_type %like% "rural")

# count diversity of ceramic imports 

var_cnt <- table(rural_imp$DIV_AWG)

# crosstabulate ceramic import classes and diversity

var_imp_tab <- table(rural_imp$IMP_GROUP, rural_imp$DIV_AWG)

# conver to proportional tables with horizontal and vertical marginals

prop_tab <- prop.table(var_imp_tab) 
prop_tab1 <- prop.table(var_imp_tab,1)
prop_tab2 <- prop.table(var_imp_tab,2)

# display in percentages 

t(prop_tab2) * 100

# calculate contingency coefficient and Cramer's V

chi <- chisq.test(var_imp_tab)
cont_coeff <- unname(sqrt(chi$statistic / (chi$statistic + sum(var_imp_tab))))

paste("Contingency coefficient: ", cont_coeff)

CramerV <- unname(sqrt((chi$statistic/sum(var_imp_tab))/min(nrow(var_imp_tab) - 1 ,ncol(var_imp_tab) - 1)))

paste("Cramer's V: ", CramerV)

# plot diversity of ceramic imports 

ggplot(as.data.frame(var_cnt), aes(Var1, Freq)) + 
  geom_col(fill="grey70", colour="black") +
  geom_text(aes(label = Freq, vjust = -0.5)) +
  ggtitle("Rural settlements and diversity of ceramic imports") +
  xlab("Number of groups") +
  ylab("Number") + 
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())
