class Module {
  float xOrigin, yOrigin, wide, tall;
  color moduleBackground;
  float originalWidthRatio, originalHeightRatio, originalXPosRatio, originalYPosRatio;
  int originalWidth, originalHeight, moduleID;


  Module(float x, float y, float wide, float tall) {
    this.xOrigin = x;
    this.yOrigin = y;
    this.wide = wide;
    this.tall = tall;

    originalWidthRatio = wide/width;
    originalHeightRatio = tall/height;

    originalXPosRatio = x/width;
    originalYPosRatio = y/height;
  }

  void draw() {
    fill(MODULE_COLOR);
    strokeWeight(3);
    stroke(230);

    pushMatrix();
    translate(xOrigin, yOrigin);
    rect(0, 0, wide, tall);
    subClassDraw();
    popMatrix();

    positionAndSizeUpdater();
  }

  void subClassDraw() {
  }

  void OnSizeUpdateEvent() {
  }
  
  boolean isClicked(){
     if (mouseX > xOrigin && mouseX < xOrigin + wide && mouseY > yOrigin && mouseY < yOrigin+tall) {
       return true;
     }
     return false;
  }

  void positionAndSizeUpdater() {
    if (originalWidth != width || originalHeight != height) {
      originalWidth = width;
      originalHeight = height;

      xOrigin = int(width * originalXPosRatio);
      yOrigin = int(height * originalYPosRatio);

      wide = int(width * originalWidthRatio);
      tall = int(height * originalHeightRatio);
      OnSizeUpdateEvent();
    }
  }
}