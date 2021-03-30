// Yi Ren, added some details to center the text. 24/3/2021
class CaseModule extends Module { 
  int cases;

  CaseModule(int x, int y, int wide, int tall, int cases) { 
    super(x, y, wide, tall);
    this.cases = cases;
  }

  //K.H changed to subclass draw
  @Override
  void subClassDraw() {
    textAlign(CENTER, CENTER);
    textSize(wide * tall / 1000);
    outlineText("Total Cases: " + formatText("##,###,###", cases), wide / 2, tall / 2, 0, MODULE_COLOR);
  }
  
}
