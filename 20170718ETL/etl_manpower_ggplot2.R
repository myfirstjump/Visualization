rm(list=ls())
#install.packages("ggplot2")

library(ggplot2)
library(dplyr)
library('reshape2')
target = read.csv("R/etl/toolRank.csv")
top = target[1:10,]


df = data.frame()
for (tool in top$toolList) {
  xf = rbind(df, top[top$toolList==tool,], top[top$toolList==tool,], top[top$toolList==tool,], top[top$toolList==tool,])
}
man_power = c("518", "104", "yes123", "1111")
xf = cbind(xf, man_power)

mp = c()
for(tool in top$toolList) {
  mp = c(mp, top[top[,2]==tool,][3:6])
}

total_by_mp = unlist(mp, use.names = FALSE)
xf = cbind(xf, total_by_mp)
ggplot(xf, aes(x=toolList, y=total_by_mp, fill=man_power)) + geom_bar(stat='identity') + scale_x_discrete(limits=top$toolList[1:10])
top$toolList


#ggplot(top, aes(x=toolList, y=total)) + geom_bar(stat='identity') + scale_x_discrete(limits=top$toolList)

mf = as.data.frame(t(top))
mf = mf[-1,]
names(mf) = unlist(mf[1,])
mf = mf[c(-1,-6),]  #去掉工具 & total
mf$mp = c("518", "104", "yes123", "1111")

mf.m = melt(mf,id.vars = 'mp')
g = ggplot(mf.m, aes(mp, value))   
g + geom_bar(aes(fill = variable), position = "stack", stat="identity")


