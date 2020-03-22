import scala.annotation.tailrec

object Task1
{
  val daysOfWeek = "poniedzialek" :: "wtorek" :: "sroda" :: "czwartek" :: "piatek" :: "sobota" :: "niedziela" :: Nil

  val products = Map("mleko"->2.99,"woda"->0.99, "jajka"->5.49, "chleb"->3.20)

  val numberList = 1::2::1::0::19::0::0::(-12)::0::123::0::(-50)::0::(-10)::0::0::1::1::11::Nil

  def rtrim(s: String, x: String) = s.replaceAll(x+"+$", "")

  def ltrim(s: String, x: String) = s.replaceAll("^"+x, "")

  def forLoopConcat(l:List[String]) =
  {
    var acc = ""
    for(i <- l)
    {
      acc+=i.concat(",")
    }
    rtrim(acc, ",")
  }

  def forLoopWithFilter(l:List[String]) =
  {
    var acc = ""
    for(i <- l)
      {
        if(i(0)=='p')
        {
          acc+=i.concat(",")
        }
      }
    rtrim(acc, ",")
  }

  def whileLoop(l:List[String]) =
  {
    var acc = ""
    var v_it = l

    while(!v_it.isEmpty)
    {
      acc+=(v_it.head+",")
      v_it = v_it.tail
    }
    rtrim(acc, ",")
  }

  def concatRecursiveForward[T](l: List[T]): String=
  {
    if(l.isEmpty)
    {
      return ""
    }
    l.head+","+concatRecursiveForward(l.tail)
  }

  def concatRecursiveBackward(l: List[String]): String=
  {
    if(l.isEmpty)
    {
      return ""
    }
    concatRecursiveBackward(l.tail)+ ","+l.head
  }

  @tailrec
  def tailRecursionConcat(l:List[String], acc:String):String =
    {
      if(l.isEmpty)
      {
        acc
      }
      else
      {
        tailRecursionConcat(l.tail,acc+","+l.head)
      }
    }

  def foldlUsage(l:List[String])=
    {
      rtrim(l.foldLeft("")(_+_+","),",")
    }

  def foldrUsage(l:List[String])=
  {
    rtrim(l.foldRight("")(_+","+_),",")
  }

  def foldlUsageWithFilter(l:List[String])=
  {
    ltrim(l.foldLeft("")
    {
      (x,y)=>
        if(y(0)=='p')
          x+","+y
        else
        x
    },",")
  }

  def applyDiscount(m:Map[String,Double])=
    {
      m.map(x=>(x._1,0.9*x._2))
    }

  def printMe3Values(x:(Any, Any, Any))=
    {
      println(s"Values: ${x._1}\t${x._2}\t${x._3}")
    }

  def optionDemo[T1](m:Map[String,T1], key:String) =
    m.get(key)

  @tailrec
  def zeroRemoval(l:List[Int], acc:List[Int]):List[Int]= {
    if (l.isEmpty)
    {
      return acc
    }
    if(l.head!=0)
    {
      zeroRemoval(l.tail,acc :+ l.head)
    }
    else
      {
        zeroRemoval(l.tail,acc)
      }
  }

  def incrementListElements(l:List[Int], inc:Int)=
  {
    l.map(x=>x+inc)
  }

  def filterAndProcessList(l:List[Int])=
  {
  l.filter(x=>x>=(-5)&&x<=12).map(_.abs)
  }

  def main(args :Array[String]): Unit =
  {
    println(forLoopConcat(daysOfWeek))

    println(forLoopWithFilter(daysOfWeek))

    println(whileLoop(daysOfWeek))

    println(rtrim(concatRecursiveForward(daysOfWeek),","))

    println(ltrim(concatRecursiveBackward(daysOfWeek),","))

    println(ltrim(tailRecursionConcat(daysOfWeek,""),","))

    println(foldlUsage(daysOfWeek))

    println(foldrUsage(daysOfWeek))

    println(foldlUsageWithFilter(daysOfWeek))

    applyDiscount(products).foreach(x=>print(f"${x._1}%s -> ${x._2}%2.2f; "))
    print("\n")

    printMe3Values((1, "BooYah", 12.6d))

    println(s"Options: ${optionDemo(products, "woda")}; ${optionDemo(products, "papier")};")

    println(concatRecursiveForward(zeroRemoval(numberList,List[Int]())))

    println(concatRecursiveForward(incrementListElements(numberList,1)))

    println(concatRecursiveForward(filterAndProcessList(numberList)))
  }

}
