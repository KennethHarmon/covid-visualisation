class TopLeftModule extends Module {
    
  TopLeftModule(int x, int y, int width, int height) {
    super(x,y,width,height);
  }
  
  void draw() {
    super.draw();
    fill(0);
    translate(super.xOrigin,super.yOrigin);
    text("Hello World",0,0);
  }

}
