args <- commandArgs(TRUE)

path <- args[1]
name <- args[2]
fileName <- paste(args[1], name , ".csv", sep = "", collapse=NULL)

data <-read.csv(fileName, head=TRUE, sep=";")
pdf(paste('turbofan_perturbated_',name, '.pdf', sep = "", collapse = NULL))
par(mar=c(5,5,4,2)+0.1) # bigger margins (needed by labels)
matplot(	
		2:nrow(data),								#x = number of values (remove first data line all zero values)
		data[2:nrow(data), 							#y = values (remove first data line all zero values)
		1:ncol(data)],								#one plot line by data column
		type="l", 								#plot type is line
		lty = "solid", 								#line type is solid
		xlab=paste("number of evaluations of", name, sep = " ", collapse=NULL), 	#x label
		ylab=paste(name, "value", sep = " ", collapse=NULL), 			#ylabel
		cex.lab=2.6, cex.axis=2.2						#scale text size
	)

abline(a=,b=,v=67, lty=5, col="gray40") #draw vertical longdashed line
abline(a=,b=,v=134, lty=5, col="gray40") #draw vertical longdashed line
abline(a=,b=,v=201, lty=5, col="gray40") #draw vertical longdashed line
abline(a=,b=,v=225, lty=5, col="gray40") #draw vertical longdashed line
abline(a=,b=,v=249, lty=5, col="gray40") #draw vertical longdashed line

mtext(c("a","b", "c", "d", "e"),side=3,line=0,at=c(67,134, 201, 225, 249), cex=2)

dev.off()
