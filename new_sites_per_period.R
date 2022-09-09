# script new_sites_per_period.R

# read data files into R

ASUM_ROMV_NEW <- read.csv("./ASUM_ROMV_NEW.txt", header=TRUE, sep=";")
ASUM_ROMM_NEW <- read.csv("./ASUM_ROMM_NEW.txt", header=TRUE, sep=";")
ASUM_ROML_ABD <- read.csv("./ASUM_ROML_ABD.txt", header=TRUE, sep=";")

# create point pattern

pp_ROMV_NEW <- ppp(ASUM_ROMV_NEW$X_coordinate,ASUM_ROMV_NEW$Y_coordinate,xrange,yrange)
pp_ROMM_NEW <- ppp(ASUM_ROMM_NEW$X_coordinate,ASUM_ROMM_NEW$Y_coordinate,xrange,yrange)
pp_ROML_ABD <- ppp(ASUM_ROML_ABD$X_coordinate,ASUM_ROML_ABD$Y_coordinate,xrange,yrange)

# calculate nearest neighbour distances

nnd_ROMV_NEW <- nncross(pp_ROMV_NEW,pp_IJZL)
nnd_ROMM_NEW <- nncross(pp_ROMM_NEW,pp_ROMV)
nnd_ROML_ABD <- nncross(pp_ROML_ABD,pp_ROML)

# prepare data for histogram plot

h1 <- hist(nnd_ROMV_NEW$dist,breaks=seq(0,12000,by=1000),plot=FALSE)
d1 <- data.frame(x = h1$breaks,y = c((100*h1$counts)/sum(h1$counts),NA))
c1 <- data.frame(x = h1$breaks,y = cumsum(d1$y))
h2 <- hist(nnd_ROMM_NEW$dist,breaks=seq(0,12000,by=1000),plot=FALSE)
d2 <- data.frame(x = h2$breaks,y = c((100*h2$counts)/sum(h2$counts),NA))
c2 <- data.frame(x = h2$breaks,y = cumsum(d2$y))
h3 <- hist(nnd_ROML_ABD$dist,breaks=seq(0,12000,by=1000),plot=FALSE)
d3 <- data.frame(x = h3$breaks,y = c((100*h3$counts)/sum(h3$counts),NA))
c3 <- data.frame(x = h2$breaks,y = cumsum(d3$y))

# plot distances of new / abandoned sites per period

ggplot() +
  geom_line(aes(x=x,y=y,colour="1"), size=1, c1) +
  geom_line(aes(x=x,y=y,colour="2"), size=1, c2) +
  geom_line(aes(x=x,y=y,colour="3"), size=1, c3) +
  geom_point(aes(x=x,y=y,colour="1"), size=3, c1) +
  geom_point(aes(x=x,y=y,colour="2"), size=3, c2) +
  geom_point(aes(x=x,y=y,colour="3"), size=3, c3) +
  ggtitle("Distance at which new settlements appear / disappear") +
  scale_colour_manual(values=cbPalette, name="period",labels=c("ROMV (appearance)","ROMM (appearance)","ROML (disappearance)")) +
  xlim(0,12000) +
  ylim(0,100) +
  xlab("Distance (m)") +
  ylab("Proportion of settlements (%)") +
  theme(panel.background = element_rect(fill="white")) +
  theme(axis.ticks.x=element_blank())

