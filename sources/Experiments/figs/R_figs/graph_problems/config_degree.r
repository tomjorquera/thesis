csv <- "./data_barabasi_albert"

data<- read.csv(paste(csv, ".csv", sep = "", collapse=NULL), head=TRUE, sep=";")

pdfname <- "time_by_degree_barabasi_albert.pdf"
pdf(file=pdfname)
par(mar=c(5,5,2,2)) 
plot(data$meanDegree,data$totalTime/1000000,
	ann=FALSE, cex=2, cex.axis=2	)
title(xlab="mean degree", ylab="total time (in ms)", cex.lab=2.4)
dev.off()

#pdfname <- "comp_degree_avg.pdf"
#pdf(file=pdfname)
#par(mar=c(5,5,2,2)) 
#plot(aggregate(data$V2/1000000, by=list(data$V5), FUN=mean),
#	col="blue", ann=FALSE, cex=2, cex.axis=2	)
#title(xlab="degree", ylab="mean average time (in ms)", cex.lab=2.4)
#dev.off()
