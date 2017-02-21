require(data.table)
require(ggplot2)
require(scales)
#Read post 1 table
post1 <- fread("post1.csv")

#Post 1 charts: Live+SD, Live+7, total viewers vs. ad rates
qplot(Demo,AdRate,data=post1,color=I("purple"),xlab="Live+SD A18-49") + geom_smooth(method="lm",color="blue") + scale_y_continuous(labels=dollar)
qplot(L7,AdRate,data=post1,color=I("brown"),xlab="Live+7 A18-49") + geom_smooth(method="lm",color="blue") + scale_y_continuous(labels=dollar)
qplot(Viewers,AdRate,data=post1,color=I("red"),xlab="Live+SD Viewers") + geom_smooth(method="lm",color="blue") + scale_y_continuous(labels=dollar)

#add Price and ranks
post1[,Price:=AdRate/Demo]
setorder(post1,-Price)
post1[,PriceRank:=1:.N]
setorder(post1,-L7Bump)
post1[,L7BumpRank:=1:.N]

#Post 1 chart: Live+7 bump vs. Price-per-point
qplot(L7Bump,Price,data=post1,color=I("#009900"),xlab="Live + 7 Bump (vs. Live+SD rating)",ylab="Ad price per Live+SD rating point") + geom_smooth(method="lm",color="blue") + scale_y_continuous(labels=dollar) + scale_x_continuous(labels=percent)

#Post 1 table:
setorder(post1,-L7Bump)
post1[1:15,.(Name,`Price/pt`=Price,PriceRank,L7Bump,L7BumpRank)]
