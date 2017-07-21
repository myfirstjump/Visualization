rm(list=ls())
#install.packages("dplyr")

library(ggplot2)
library(dplyr)
target = read.csv("R/etl/toolRank.csv")
top = target[1:10,]


df = data.frame()
for (tool in top$toolList) {
  df = rbind(df, top[top$toolList==tool,], top[top$toolList==tool,], top[top$toolList==tool,], top[top$toolList==tool,])
}
man_power = c("518", "104", "yes123", "1111")
df = cbind(df, man_power)

mp = c()
for(tool in top$toolList) {
  mp = c(mp, top[top[,2]==tool,][3:6])
}

total_by_mp = unlist(mp, use.names = FALSE)
df = cbind(df, total_by_mp)
ggplot(df, aes(x=toolList, y=total_by_mp, fill=man_power)) + geom_bar(stat='identity') + scale_x_discrete(limits=top$toolList[1:10])
top$toolList


#ggplot(top, aes(x=toolList, y=total)) + geom_bar(stat='identity') + scale_x_discrete(limits=top$toolList)
