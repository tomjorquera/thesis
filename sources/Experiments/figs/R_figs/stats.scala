#!/home/jorquera/Documents/scala/scala-2.10.0-RC5/bin/scala
!#

val experiments = collection.immutable.SortedMap[String, Double](
		 	 "res_Alexandrov/o.csv" -> 0.11627907
			,"res_Turbofan/o1.csv" -> 275
			,"res_Turbofan/o2.csv" -> 155
			,"res_Viennet1/viennet_o1.csv" -> 2
			,"res_Viennet1/viennet_o2.csv" -> 2
			,"res_Viennet1/viennet_o3.csv" -> 2
			,"res_Rosenbrock/minimizer.csv" -> 1
);


for((file, solution) <- experiments){

val precision = 0.1

var expe = scala.Array[Seq[Double]]()
var first = true

for( line <- scala.io.Source.fromFile(file).getLines ){
	if (first){
		first = false
		val size = line.split(";").size
		expe = new scala.Array[Seq[Double]](size)
		for( i <- 0 to size -1){
			expe(i) = Seq[Double]()
		}
		
	} else if (!(line == "")){
		var i = 0
		for(value <- line.split(";")){
			expe(i) = expe(i) :+ value.toDouble
			i=i+1
		}
	}
}

var rank = 0
val nbSteps4bestSol = (for(e <- expe) yield {
	var res = Double.PositiveInfinity

	var stop = false
	var i = 0	
	while(!stop){
		val curr = e(i)
		if(math.abs(solution - curr) <= precision){
			stop = true
			res = curr
		}
		i=i+1
		if(i==e.size) stop = true
	}

	rank = rank+1
	i
}).sortWith(_<_)

val avgDist2bestSol = expe.map(l => l.map(e => math.abs(solution - e))).toList.transpose.map( s => (s.foldLeft(0.0)(_+_))/s.size )

val symbol = " & "


println(file
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.1).toInt)
//	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.3).toInt)
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.5).toInt)
//	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.7).toInt)
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.9).toInt)

	+ symbol + math.floor(avgDist2bestSol(2)*1000)/1000
	//+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*1/10)*1000)/1000
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*3/10)*1000)/1000
	//+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*5/10)*1000)/1000
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*6/10)*1000)/1000
	//+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*7/10)*1000)/1000
	//+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*9/10)*1000)/1000
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1))*1000)/1000
)


/*
println(file
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.1).toInt)
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.5).toInt)
	+ symbol + nbSteps4bestSol((nbSteps4bestSol.size*0.9).toInt)
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*1/10)*1000)/1000
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*1/2)*1000)/1000
	+ symbol + math.floor(avgDist2bestSol((avgDist2bestSol.size-1)*9/10)*1000)/1000
	+ """\\"""
)
*/

}
