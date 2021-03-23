class TopLeftModule extends Module { 
  int cases;
  
  TopLeftModule(int x, int y, int width, int height, int cases) { 
    super(x, y, width, height);
    this.cases = cases;
  }

  void draw() {
    super.draw();
    fill(0);
    translate(super.xOrigin,super.yOrigin);
    text("Cases:" + cases,0,0);
  }
}
