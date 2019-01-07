install.packages("ggplot2")
library("ggplot2")

poroceni2 <- head(poroceni, 15)
ggplot(poroceni2, aes(x=starostni.tip, y=stevilo)) + geom_point()


       