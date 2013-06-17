csv <- "./test_degree"

data<- read.csv(paste(csv, ".csv", sep = "", collapse=NULL), head=FALSE, sep=";")

pdfname <- "comp_time_by_degree.pdf"
pdf(file=pdfname)
par(mar=c(5,5,2,2)) 
plot(data$V5,data$V2/1000000,
	col="blue", ann=FALSE, cex=2, cex.axis=2	)
title(xlab="mean degree", ylab="average time (in ms)", cex.lab=2.4)
dev.off()

#pdfname <- "comp_degree_avg.pdf"
#pdf(file=pdfname)
#par(mar=c(5,5,2,2)) 
#plot(aggregate(data$V2/1000000, by=list(data$V5), FUN=mean),
#	col="blue", ann=FALSE, cex=2, cex.axis=2	)
#title(xlab="degree", ylab="mean average time (in ms)", cex.lab=2.4)
#dev.off()
