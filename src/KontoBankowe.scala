class KontoBankowe
{
  private var _stanKonta:Double=_

  def stanKonta = _stanKonta

  def this(poczatkowyStan:Double) =
  {
    this()
    this._stanKonta = poczatkowyStan
  }


  def wplata(kwota:Double) =
    {
      if(kwota>0.0)
        _stanKonta+=kwota
    }
  def wyplata(kwota:Double) =
    {
      if(kwota<=_stanKonta)
      {
        _stanKonta-=kwota
      }
    }
}

