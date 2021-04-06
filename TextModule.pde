// William Walsh-dowd created on the 30th of march, a module that prints text.
// M.A fixed text fitting for this module, 06/04/2021
class TextModule extends Module { 
  private String text;
  private color textColor;

  TextModule(float x, float y, float wide, float tall, String text, color textColor) {
    super(x, y, wide, tall);
    this.text = text;
    this.textColor = textColor;
  }

  void subClassDraw() {
    textAlign(CENTER, CENTER);
    fittedText(text, wide, tall, MODULE_PADDING);
    outlineText(text, wide / 2, tall / 2, 0, textColor);
  }

  void setText(String text) {
    this.text = text;
  }

  void setPosition(float x, float y) {
    this.xOrigin = x;
    this.yOrigin = y;
  }
}
