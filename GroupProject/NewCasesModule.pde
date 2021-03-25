// made by Yi Ren on 24th of March. a class that extends module and shows the number of new cases in a certain area over a period of time.
class NewCasesModule extends Module { 
  int cases;
  
  NewCasesModule(int x, int y, int width, int height, int cases) { 
    super(x, y, width, height);
    this.cases = cases;
  }

  void draw() {
    super.draw();
    fill(0);
    translate(super.xOrigin,super.yOrigin);
    textAlign(CENTER,CENTER);
    text("New cases:" + cases, super.xOrigin+width/2,super.yOrigin+height/2);
  }
}
