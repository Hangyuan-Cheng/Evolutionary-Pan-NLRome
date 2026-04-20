library(stats)
setwd("C:/Users/6A13/Desktop")

# 读取分组信息
density <- read.table("JAP-IND distribution.tsv",header = T,row.names = 1,sep = "\t")

# 先画出一个分组的直方图，breaks指定直方图中的箱数。
hist(density$JAP, breaks = c(0,12,24,36,48,60,72,84,96,108,120,132,144,156,168,180,192), xlim=c(0,200), col=rgb(1,0,0,0.5), xlab="NLRs number", 
     ylab="OGs number", main="Number distribution of NLRomes within OGs" )

hist(density$IND, breaks = c(0,12,24,36,48,60,72,84,96,108,120,132,144,156,168,180,192), xlim=c(0,200), col=rgb(1,0,0,0.5), xlab="NLRs number", 
     ylab="OGs number", main="Number distribution of NLRomes within OGs" )
# 使用add=T把第二个分组的直方图加到图里
hist(density$rufi, breaks=20, xlim=c(0,500), col=rgb(0,0,1,0.5))

#添加图例：pt.cex指定图例中标记点的相对大小，pch=15指定标记点的形状大小，cex文本的相对大小,box.lty去掉图例周围的边框
legend("topright", legend=c("O. rufipogon","O. sativa"), col=c(rgb(1,0,0,0.5), 
                                                      rgb(0,0,1,0.5)), pt.cex=2, pch=15,cex = 0.8,box.lty = 0)

