// made by Yi Ren on 24th of March. a class that extends module and shows the number of new cases in a certain area over a period of time.
class NewCasesModule extends Module { 
  int cases;
  
  NewCasesModule(float x, float y, float wide, float tall, int cases) { 
    super(x, y, wide, tall);
    this.cases = cases;
  }

  void subClassDraw() {
    fill(0);
    textAlign(CENTER,CENTER);
    text("New cases:" + cases, wide/2,tall/2);
  }
}
