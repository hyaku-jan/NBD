import scala.annotation.tailrec

object Task2
{
  val daysOfWeek = "poniedzialek" :: "wtorek" :: "sroda" :: "czwartek" :: "piatek" :: "sobota" :: "niedziela" :: "poreda":: Nil

  val persona3 = List[Osoba3](new Osoba3("Anna", "Nowak"),
                              new Osoba3("Kamil", "Kowalski"),
                              new Osoba3("Krzysztof", "Kwiatkowski"),
                              new Osoba3("Urszula", "Kevey"),
                              new Osoba3("Marcin", "Aowicz"))

  def matchDays(d:String)=
  {
    d match
    {
      case "poniedzialek" | "wtorek" | "sroda" | "czwartek" | "piatek" => "praca"
      case "sobota" | "niedziela" => "wolne"
      case _ => "nie ma takiego dnia"
    }
  }

  def greet(p:Osoba3) =
    {
      p match
      {
        case Osoba3("Anna",_) | Osoba3("Urszula",_) => s"Dzien dobry ${p.imie} ${p.nazwisko}"
        case Osoba3(_, "Kowalski")| Osoba3(_,"Kwiatkowski") => s"Witaj ${p.nazwisko} ${p.imie}"
        case _ => s"Milo poznac ${p.imie}"
      }
    }

  def validateStatement[T](statement:()=>T, validate:T=>Unit)=
  {
    validate(statement())
  }

  @tailrec
  def passFunction(v:Int, f:Int=>Int, it:Int): Int=
  {
    if(it==0)
      return v
    else
    {
      passFunction(f(v),f,it-1)
    }
  }

  def main(args :Array[String]): Unit =
  {
    for(x<-daysOfWeek)
      validateStatement(()=>matchDays(x), println)
    println("---------------------------------------------------")

    validateStatement(()=>new KontoBankowe(), (x:KontoBankowe)=>println(f"${x.stanKonta}%.2f$$"))
    validateStatement(()=>new KontoBankowe(48151623.42), (x:KontoBankowe)=>println(f"${x.stanKonta}%.2f$$"))
    validateStatement(()=>{val x = new KontoBankowe(); x.wplata(12.23);x}, (x:KontoBankowe)=>println(f"${x.stanKonta}%.2f$$"))
    validateStatement(()=>{val x = new KontoBankowe(15.00); x.wyplata(12.50);x}, (x:KontoBankowe)=>println(f"${x.stanKonta}%.2f$$"))
    println("---------------------------------------------------")

    for(p<-persona3)
      validateStatement(()=>greet(p),println)
    println("---------------------------------------------------")

    validateStatement(()=>passFunction(10,(x:Int)=>x-2,3),println)
    validateStatement(()=>passFunction(10,(x:Int)=>x*2,3),println)
    println("---------------------------------------------------")

    validateStatement(()=>new Osoba5("Jan","Student") with Student, (x:Osoba5)=>println(f"${x.imie} ${x.nazwisko} ${x.podatek}%.2f$$"))
    validateStatement(()=>new Osoba5("Jan","Nauczyciel") with Nauczyciel, (x:Osoba5)=>println(f"${x.imie} ${x.nazwisko} ${x.podatek}%.2f$$"))
    validateStatement(()=>new Osoba5("Jan","Pracownik") with Pracownik, (x:Osoba5)=>println(f"${x.imie} ${x.nazwisko} ${x.podatek}%.2f$$"))

    validateStatement(()=>new Osoba5("Jan","Multi1") with Pracownik with Student, (x:Osoba5)=>println(f"${x.imie} ${x.nazwisko} ${x.podatek}%.2f$$"))

    validateStatement(()=>new Osoba5("Jan","Multi2") with  Student with Pracownik, (x:Osoba5)=>println(f"${x.imie} ${x.nazwisko} ${x.podatek}%.2f$$"))
  }
}
