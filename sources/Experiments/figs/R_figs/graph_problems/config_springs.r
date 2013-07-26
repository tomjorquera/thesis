fileName <- "data_springs_watts_strogatz.csv"

data <-read.csv(fileName, head=TRUE, sep=";")

pdf("springs.pdf")
par(mar=c(5,5,1,1)) 						# bigger margins (needed by labels)
plot(	
		data[,1],						#x = number of values
		data[,2],						#y = values
		type="p", 						#plot type is dots
		lty = "solid", 						#line type is solid
		pch="x",
		xlab="agents number", 					#x label
		ylab="evaluations number",				#ylabel
		cex.lab=1.5, cex.axis=1.5,				#scale text size
		#xlim=c(250,400),
		ylim=c(0,400)
	)
#linear
points(	data[,1], data[,3],
	lty = "dashed",col="red", type="l")


dev.off()
