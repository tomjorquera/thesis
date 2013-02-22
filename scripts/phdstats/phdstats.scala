#!/bin/sh
exec scala $0 $@
!#

import scala.sys.process._
import language.postfixOps //to remove warnings

val repoLocation = "../.././"
val files = Seq("sources/MAS4Optim/MAS4Optim.tex", "sources/StateoftheArt/SoA.tex", "sources/Implem/Implem.tex") ++ 
		Seq("MAS4Optim/MAS4Optim.tex", "StateoftheArt/SoA.tex") //required for backward compatibility

val hgCmd = "hg --repository "+repoLocation+ " "

def hgShowDateOfRev(revNb:Int) = (hgCmd + "log --template {date|shortdate}" + " -r" + revNb !!) trim

def hgShowRevisionOfFileCode(fileName:String, revNb:Int)= hgCmd +"cat -r "+ revNb + " "+fileName ! ProcessLogger( _ => (), _ => ())
def hgShowRevisionOfFile(fileName:String, revNb:Int)= if(hgShowRevisionOfFileCode(fileName, revNb)!=0) "" else hgCmd +"cat -r "+ revNb + " "+fileName !!

val lastRevNumber = (hgCmd + " id -n" !!).trim.replace("+", "").toInt

def countNbWords(text:String, removeNotes:Boolean = true) = {
  val note = """\[[^\]\[]*\]""" //regex for notes between double braces
  val newText = if(removeNotes) {
			recursiveRegexTrim(text, note)
		} else text
  newText.split(" ").filter(_.length > 0).size 
}

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


var res = Map[String, Seq[Int]]()

for (	rev <- 0 to lastRevNumber;
	file <- files
) {
	val updated = res.getOrElse(hgShowDateOfRev(rev), Seq[Int]()) :+ countNbWords(hgShowRevisionOfFile(repoLocation+file, rev))
	res = res + (hgShowDateOfRev(rev).->(updated))

}

//val resList = (k, v) <- res.map( kv => (kv._1-> kv._2.fold(-1)(math.max(_,_)))).List.sortBy(_._1)
//resList.foldLeft(List[Tuple2[String, Int])((curr, elem) => if)

for( (k, v) <- res.map( kv => (kv._1-> kv._2.fold(-1)(math.max(_,_)))).toSeq.sortBy(_._1) ){
  println(k+";"+v)
}

