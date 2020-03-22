abstract class Osoba5 (val imie:String, val nazwisko:String){
  val podatek:Double
}

trait Pracownik extends Osoba5{
 var pensja:Double = 2020.99
 override val podatek = 0.2*pensja
}

trait Student extends Osoba5{
  override val podatek: Double = 0.0
}

trait Nauczyciel extends Pracownik{
  override val podatek: Double = 0.1*pensja
}