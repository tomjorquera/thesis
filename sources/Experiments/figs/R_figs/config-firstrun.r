args <- commandArgs(TRUE)

path <- args[1]
name <- args[2]
fileName <- paste(args[1], name , ".csv", sep = "", collapse=NULL)

data <-read.csv(fileName, head=TRUE, sep=";")
pdf(paste(name, '_one_run.pdf', sep = "", collapse = NULL))
par(mar=c(5,5,4,2)+0.1) # bigger margins (needed by labels)
matplot(
		2:nrow(data),
		data[2:nrow(data),1:1],
		type="l", lty = "solid",
		xlab=paste("nb evaluations of ", name, sep = " ", collapse=NULL), 	#x label
		ylab=paste(name, "value", sep = " ", collapse=NULL), 			#ylabel
		cex.lab=2.6, cex.axis=2.2
	)
dev.off()
