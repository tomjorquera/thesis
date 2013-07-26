fileName <- "res.csv"

data <-read.csv(fileName, head=TRUE, sep=";")
constraints <-read.csv("constraints.csv", head=TRUE, sep=";")

pdf("uncertainties.pdf")
par(mar=c(5,5,1,1)) 						# bigger margins (needed by labels)
plot(	
		data[,1],						#x = number of values (remove first data line all zero values)
		data[,-1],						#y = values (remove first data line all zero values)
		type="b", 						#plot type is both line and point,
		lty = "solid", 						#line type is solid
		pch="x",
		xlab="Power/Mass Ratio", 					#x label
		ylab="Wing Loading", 					#ylabel
		cex.lab=1.5, cex.axis=1.5,				#scale text size
		xlim=c(250,400),
		ylim=c(150,350)
	)
#constraints
points(	constraints[,1], constraints[,2],
	lty = "dashed",col="red", type="l")

points(	constraints[,1], constraints[,3],
	lty = "dashed",col="red", type="l")

#points(	constraints[,1], constraints[,4],
#		col="red", type="l")

abline(a=,b=,v=376.75,lty = "dashed",col="red") #draw vertical longdashed line*


#solution points
points(x = 376.26, y = 186.95, col = "blue", pch = 1, cex = 4)
points(x = 329, y = 244, col = "green", pch = 1, cex = 4)

#starting point
points(x = 297, y = 307, col = "black", pch = "S", cex = 1)

dev.off()
