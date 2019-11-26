library(ggplot2)
setwd("~/Documents/South Asia /IND_NSS_75_2017/Education/1. literacy")

Literacy <- read.csv(file="tableau_literacy_long.csv", header=TRUE, sep=",")
Literacy <- Literacy[which(Literacy$gender != "gap"),]
boxplot(Literacy$lit_~Literacy$state, range=0)

Literacy_wide <- read.csv(file="tableau_literacy_wide.csv", header=TRUE, sep=",")
Literacy_wide <- Literacy_wide[which(Literacy_wide$urban == "Rural"),]


qplot(y    = reorder(state,lit_female) , 
      x    = lit_total,
      data = na.omit(Literacy_wide)) +
  
  geom_errorbarh(aes( 
    xmin  = lit_female, 
    xmax  = lit_male, 
    width = 0.25))        

ggplot(data = na.omit(Literacy_wide), 
       aes(lit_total,reorder(state,lit_female))) + 
  geom_point() + 
  geom_errorbarh(aes(xmax = lit_male, xmin =lit_female))
