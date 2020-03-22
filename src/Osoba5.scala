abstract class Osoba5 (val imie:String, val nazwisko:String){
  val podatek:Double
}

trait Pracownik {
 var pensja:Double = 2020.99
  val podatek = 0.2*pensja
}

trait Student {
  val podatek: Double = 0.0
}

trait Nauczyciel extends Pracownik{
  override val podatek: Double = 0.1*pensja
}