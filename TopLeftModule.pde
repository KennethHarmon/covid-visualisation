class TopLeftModule extends Module {
<<<<<<< .mine
  
  int cases;
  
  TopLeftModule(int x, int y, int width, int height, int cases) {
||||||| .r9
    
  TopLeftModule(int x, int y, int width, int height) {
=======

  TopLeftModule(int x, int y, int width, int height) {
>>>>>>> .r11
    super(x, y, width, height);
    this.cases = cases;
  }

  void draw() {
    super.draw();
    fill(0);
<<<<<<< .mine
    translate(super.xOrigin,super.yOrigin);
    text("Cases:" + cases,0,0);
||||||| .r9
    translate(super.xOrigin,super.yOrigin);
    text("Hello World",0,0);
=======
    translate(super.xOrigin, super.yOrigin);
    text("Hello World", 0, 0);
>>>>>>> .r11
  }
}
