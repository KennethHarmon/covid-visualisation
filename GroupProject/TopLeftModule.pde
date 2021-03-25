// Yi Ren, added some details to center the text. 24/3/2021
class CaseModule extends Module { 
  int cases;
  
  CaseModule(int x, int y, int width, int height, int cases) { 
    super(x, y, width, height);
    this.cases = cases;
  }

  void draw() {
    super.draw();
    fill(0);
    translate(super.xOrigin,super.yOrigin);
    textAlign(CENTER,CENTER);
    text("Cases:" + cases, width/2,height/2);
    translate(-super.xOrigin,-super.yOrigin);
  }
}
