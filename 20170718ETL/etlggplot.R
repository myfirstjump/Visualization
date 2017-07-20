rm(list=ls())
#install.packages("ggplot2")
library(ggplot2)
library(dplyr)
head(diamonds)
str(diamonds)
diamonds[sample(nrow(diamonds), 10), ]
diamonds$carat
qplot(carat, data = diamonds, geom = "histogram")


toolRank = read.csv("D:/iiiR/20170718ETL/toolRank.csv")
target = toolRank[1:10,]

qplot(toolList, total, data = target, geom = "point")  # 竟然不會照順序
str(target)


##
target$toolList <- factor(target$toolList, levels = target$toolList[order(target$toolList)])
str(target)
target$per = c(0.1,0.9)
target[1,"per"] = c(0.1,0.9)
ggplot(target,aes(x=toolList,y=total, fill=per))+ geom_bar(stat='identity') + scale_x_discrete(limits=target$toolList)
OrdToolList = toolRank$toolList[order(toolRank$toolList)]


stat='identity'
ntar = t(target)
ntar
position='stack'
target
java = c(58, 100)
df = data.frame(java)
df
bank = c("104", "1111")
df = cbind(df, bank)
ggplot(df, aes(x=java, fill=bank)) + geom_bar()
