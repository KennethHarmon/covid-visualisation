class Module {
  int xOrigin, yOrigin, width, height;
  color moduleBackground;
  
  Module(int x, int y, int width, int height) {
    this.xOrigin = x;
    this.yOrigin = y;
    this.width = width;
    this.height = height;
  }
  
  void draw() {
    fill(moduleColor);
    rect(xOrigin,yOrigin,width,height);
  }
}
