args <- commandArgs(TRUE)

csv_rand <- "./test_size_random"
csv_ws <- "./test_size_ws"

#for(name in c(csv_rand, csv_ws)) {

	#csvname <- paste(name, ".csv", sep = "", collapse=NULL)

	#data <- read.csv(csvname, head=FALSE, sep=";")
	#attach(data)
	#ordered <- t(data[order(V1),])

	#pdfname <- paste(name, "_degree_boxplot.pdf", sep = "", collapse=NULL)
	#pdf(file=pdfname)
	#boxplot(ordered[3:nrow(ordered),],names=ordered[1,])
	#dev.off()

	#pdfname <- paste(name, "_degree_scatter.pdf", sep = "", collapse=NULL)
	#pdf(file=pdfname)
	#plot(ordered[5,],col="blue")
	#dev.off()
#}

data_rand <- read.csv(paste(csv_rand, ".csv", sep = "", collapse=NULL), head=FALSE, sep=";")
attach(data_rand)
ordered_rand <- t(data_rand[order(V1),])

data_ws <- read.csv(paste(csv_ws, ".csv", sep = "", collapse=NULL), head=FALSE, sep=";")
attach(data_ws)
ordered_ws <- t(data_ws[order(V1),])

pdfname <- paste("comp_time_by_size.pdf", sep = "", collapse=NULL)
pdf(file=pdfname)
par(mar=c(5,5,2,2)) 
plot(	ordered_rand[1,], ordered_rand[2,]/1000000,
	col="blue", ann=FALSE, cex=2, cex.axis=2	)
points(	ordered_rand[1,], ordered_ws[2,]/1000000,
	col="red",pch=22, ann=FALSE, cex=2)
title(xlab="agents number", ylab="average time (in ms)", cex.lab=2.4)
legend(	"topleft",  c("random euclidean","small-world"),
	col=c("blue","red"), pch=21:22, cex=2	);

dev.off()

pdfname <- paste("comp_degree_by_size.pdf", sep = "", collapse=NULL)
pdf(file=pdfname)
par(mar=c(5,5,2,2)) 
plot(	ordered_rand[1,], ordered_rand[5,],
	col="blue", ann=FALSE, cex=2, cex.axis=2	)
points(	ordered_rand[1,], ordered_ws[5,],
	col="red",pch=22, ann=FALSE, cex=2)
title(xlab="nodes number", ylab="mean degree", cex.lab=2.4)
legend(	"topleft",  c("random euclidean","small-world"),
	col=c("blue","red"), pch=21:22, cex=2	);

dev.off()
