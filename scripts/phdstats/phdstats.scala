#!/bin/sh
exec scala $0 $@
!#

import scala.sys.process._
import language.postfixOps //to remove warnings

val cachePath = "./.cache.data"
val repoLocation = "../.././"

val files = Seq("sources/MAS4Optim/MAS4Optim.tex", "sources/StateoftheArt/SoA.tex", "sources/Implem/Implem.tex", "sources/CPSP/CPSP.tex")
val legacyFiles = Seq("MAS4Optim/MAS4Optim.tex", "StateoftheArt/SoA.tex") //required for backward compatibility


/////////////// HG COMMANDS ///////////////
val hgCmd = "hg --repository "+repoLocation+ " "

def hgShowDateOfRev(revNb:Int) = (hgCmd + "log --template {date|shortdate}" + " -r" + revNb !!) trim

def hgShowRevisionOfFileCode(fileName:String, revNb:Int)= hgCmd +"cat -r "+ revNb + " "+fileName ! ProcessLogger( _ => (), _ => ())
def hgShowRevisionOfFile(fileName:String, revNb:Int)= if(hgShowRevisionOfFileCode(fileName, revNb)!=0) "" else hgCmd +"cat -r "+ revNb + " "+fileName !!

/////////////////////////////////////////////


/////////////// WORD COUNT COMMANDS ///////////////

def countNbWords(text:String, removeNotes:Boolean = true) = {

  def recursiveRegexTrim(text:String, regex:String) = {

    //val exampleText = "Ceci est [[teztfzetgze]]un test[[]][[\n[[blablabla\nblablabla\n]]\n\n\n]] pour\nsupprimer[[zezfzef[[zefzef[[]][[zfzef]]]]]] les notes[[zefzfef]]"
    // => recursiveRegexTrim(exampleText, note) should give "Ceci est un test pour\nsupprimer les notes"

    var trimmed = text
    var oldText = ""
    while(trimmed != oldText){	
      oldText = trimmed
      trimmed = oldText.replaceAll(regex, "")
    }
    trimmed
  }

  val note = """\[[^\]\[]*\]""" //regex for notes between double braces
  val newText = if(removeNotes) {
			recursiveRegexTrim(text, note)
		} else text
  newText.split(" ").filter(_.length > 0).size 
}
/////////////////////////////////////////////


/////////////// CACHE COMMANDS ///////////////

def readCache(cachePath:String): collection.SortedMap[String, Int] = {
  var res = collection.SortedMap[String, Int]()

  val cache = new java.io.File(cachePath)

  if(!cache.exists){
    cache.createNewFile
  }

  for(line <- scala.io.Source.fromFile(cache).getLines){
    res = res + (line.split(" ")(0) -> line.split(" ")(1).toInt)
  }
  return res
}

def writeCache(cachePath:String, values:collection.SortedMap[String, Int]){
  val todayDate = "date +%Y-%m-%d".!!.trim
  val output = new java.io.PrintWriter(cachePath)
  for(
    (date, count) <- values;
    if date != todayDate	//do not cache wordCount from today date
  ){
    output.write(date + " "+ count +"\n")
  }
  output.close
}

/////////////////////////////////////////////

/////////////// MAIN ///////////////

val lastRevNumber = (hgCmd + " id -n" !!).trim.replace("+", "").toInt

var res = readCache(cachePath)

var newValues = collection.SortedMap[String, Seq[Int]]()

val filesList = if(res.isEmpty){
    files ++ legacyFiles    //full cache rebuild, include legacy files
} else {
    files
}

for (rev <- 0 to lastRevNumber) {
  val date = hgShowDateOfRev(rev)
  if(!res.contains(date)){
    var wordCount = 0
    for(file <- filesList){
      wordCount = wordCount + countNbWords(hgShowRevisionOfFile(repoLocation+file, rev))
      
    }
    newValues = newValues + (date -> ((newValues.getOrElse(date, Seq[Int]())) :+ wordCount))
  }
}

if(!newValues.isEmpty){
  for((date, wordCounts) <- newValues){
    res = res + (date -> wordCounts.fold(-1)(math.max(_,_)))
  }
  writeCache(cachePath, res)
}

for( (k, v) <- res){
  println(k+";"+v)
}

