// Yi Ren, added some details to center the text. 24/3/2021
class CaseModule extends Module { 
  int cases;
  int fontSize;

  CaseModule(int x, int y, int wide, int tall, int cases) { 
    super(x, y, wide, tall);
    this.cases = cases;
    this.fontSize = 24;
  }

  //K.H changed to subclass draw
  void subClassDraw() {
    fill(0);
    textAlign(CENTER, CENTER);
    text("Cases:" + cases, wide/2, tall/2);
  }
  
}
