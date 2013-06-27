args <- commandArgs(TRUE)

csv_rand <- "./data_random_eclidean"
csv_ws <- "./data_watts_strogatz"


data_rand <- read.csv(paste(csv_rand, ".csv", sep = "", collapse=NULL), head=TRUE, sep=";")
attach(data_rand)
ordered_rand <- data_rand[order(nbAgents),]

data_ws <- read.csv(paste(csv_ws, ".csv", sep = "", collapse=NULL), head=TRUE, sep=";")
attach(data_ws)
ordered_ws <- data_ws[order(nbAgents),]

#RE graphs
pdfname <- paste("time_by_size_random_eclidean.pdf", sep = "", collapse=NULL)
pdf(file=pdfname)
par(mar=c(5,5,2,2)) #margins size
plot(	ordered_rand[,1], ordered_rand[,2]/1000000,	#data do plot
	col="blue",pch="x",  ann=FALSE, cex=2, cex.axis=2	)	#display parameters
title(xlab="agents number", ylab="total time (in ms)", cex.lab=2.4)	#axis labels
dev.off()

#WS graphs
pdfname <- paste("time_by_size_watts_strogatz.pdf", sep = "", collapse=NULL)
pdf(file=pdfname)
par(mar=c(5,5,2,2)) #margins size
plot(	ordered_ws[,1], ordered_ws[,2]/1000000,
	col="red",pch="x",  ann=FALSE, cex=2, cex.axis=2	)	#display parameters
title(xlab="agents number", ylab="total time (in ms)", cex.lab=2.4)	#axis labels
dev.off()


#Degree comparison
pdfname <- paste("degree_by_size_comparison.pdf", sep = "", collapse=NULL)
pdf(file=pdfname)
par(mar=c(5,5,2,2)) 
plot(	ordered_rand[,1], ordered_rand[,5],
	col="blue", ann=FALSE, cex=2, cex.axis=2	)
points(	ordered_ws[,1], ordered_ws[,5],
	col="red",pch="x", ann=FALSE, cex=2)
title(xlab="nodes number", ylab="mean degree", cex.lab=2.4)
legend(	"topleft",  c("random euclidean","small-world"),
	col=c("blue","red"), pch=c(21,4), cex=2	);

dev.off()

#par(mar=c(5,7,2,2)) #margins size

#plot(	ordered_rand[,1], ordered_rand[,5],	#data do plot
#	col="blue",pch=".", type="o"
#	, cex=2, cex.axis=2			#font size
#	, axes=F, xaxt='n', yaxt='n', xlab="", ylab=""	)
#axis(2, col='blue', ylim=c(0,max(ordered_rand[,5])), lwd=2, cex.axis=2.4)

#par(new=T)
#plot(	ordered_ws[,1], ordered_ws[,5],
#	col="red", pch=".", type="o",  cex=2,
#	axes=F ,xaxt='n', yaxt='n', xlab=NA, ylab=NA	)
#axis(2, col='red', ylim=c(0,max(ordered_ws[,5])),lwd=2, cex.axis=2.4, line=3.5)
#
#axis(1,pretty(range(ordered_rand[,1]), 10)
