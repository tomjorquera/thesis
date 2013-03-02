args <- commandArgs(TRUE)

path <- args[1]
name <- args[2]
fileName <- paste(args[1], name , ".csv", sep = "", collapse=NULL)

data <-read.csv(fileName, head=TRUE, sep=";")
pdf(paste(name, '_pertubated.pdf', sep = "", collapse = NULL))
par(mar=c(5,5,4,2)+0.1) # bigger margins (needed by labels)
matplot(	
		40:nrow(data),
		data[40:nrow(data),1:1],
		xlim=c(40,130), 							#display only x values between 40 and 130
		type="l", lty = "solid", 
		xlab=paste("nb evaluations of ", name, sep = " ", collapse=NULL), 	#x label
		ylab=paste(name, "value", sep = " ", collapse=NULL), 			#ylabel
		cex.lab=2.6, cex.axis=2.2

	)

abline(a=,b=,v=65, lty=5, col="gray40") #draw vertical longdashed line
dev.off()
