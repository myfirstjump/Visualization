#install.packages("rjson")
library(rjson)
# import tool lists from 104, 518, yes123, 1111
tool104raw <- fromJSON(paste(readLines("D:/iiiR/20170718ETL/crawler_1104.json"), collapse=""))
tool518raw <- fromJSON(paste(readLines("D:/iiiR/20170718ETL/skcount518.json"), collapse=""))
toolyes123raw <- fromJSON(paste(readLines("D:/iiiR/20170718ETL/Yes123_JobCount.json"), collapse=""))
tool1111raw <- fromJSON(paste(readLines("D:/iiiR/20170718ETL/1111.json"), collapse=""))

#對toolnames做filter
fltname <- function(toolhr) { 
  cnt = 0
  for (something in names(toolhr)) {
    cnt = cnt + 1
    if (something == "") {
      toolhr = toolhr[-cnt]
    }
  }
  cnt = 0
  for (something in names(toolhr)) {
    cnt = cnt + 1
     names(toolhr)[cnt]= tolower(something)
  }
  return(toolhr)
}

# 丟入filter function
tool104 = fltname(tool104raw)
tool518 = fltname(tool518raw)
toolyes123 = fltname(toolyes123raw)
tool1111 = fltname(tool1111raw)

# 取出name list
toolname104 = names(tool104)
toolname518 = names(tool518)
toolnameyes123 = names(toolyes123)   
toolname1111 = names(tool1111)
  
class(names(tool104)) # character
class(attributes(tool104)) # list

length(toolname104)
length(toolname518)
length(toolnameyes123)
length(toolname1111)
?union

# 合併name list
length(union(toolname104, toolnameyes123))

toolList = Reduce(union, c(toolname104, toolname518, toolnameyes123, toolname1111))
class(toolList)

tool2union <- function(toolhr) {
  newVec = numeric() # 對照union工具，此人力銀行的數據統計
  cnt = 0 #表示newList的index
  for (tool in toolList) {
    cnt = cnt + 1
    if (tool %in% names(toolhr)) {
      newVec[cnt] = toolhr[[tool]]
    } else {
      newVec[cnt] = 0
    }
  }
  return(newVec)
}

toolAmount518 = tool2union(tool518)
toolAmount104 = tool2union(tool104)
toolAmountyes123 = tool2union(toolyes123)
toolAmount1111 = tool2union(tool1111)



tooldf = data.frame(toolList, toolAmount518, toolAmount104, toolAmountyes123, toolAmount1111)
tooldf
str(tooldf)
head(tooldf)

tooldf$total = toolAmount104 + toolAmount1111 + toolAmount518 + toolAmountyes123

tooldf[1:20,]

toolRank = tooldf[order(-tooldf$total),]
toolRank[1:25,]

#write.table(toolRank, "D:/iiiR/20170718ETL/toolRank.txt")
#write.csv(toolRank, "D:/iiiR/20170718ETL/toolRank.csv")

# export toolList

#xx = as.vector(tooldf$toolList)
#write(xx, "tool.txt", append = FALSE)

#l1 = list('a','b','c')
#l1
#l2 = list('d','e')
#l3 = list('f', 'a')
#union(l1,l3)
#Reduce(union, c(l1,l2,l3))

