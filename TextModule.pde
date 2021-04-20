// William Walsh-dowd created on the 30th of march, a module that prints text.
// M.A fixed text fitting for this module, 06/04/2021
public class TextModule extends Module { 
  private String text;
  private color textColor;

  TextModule(float x, float y, float wide, float tall, String text, color textColor) {
    super(x, y, wide, tall);
    this.text = text;
    this.textColor = textColor;
  }

  void subClassDraw() {
    fill(textColor);
    textAlign(CENTER, CENTER);
    fittedText(text, wide, tall, int(tall/3));
    text(text, wide / 2, tall / 2);
  }

  void setText(String text) {
    this.text = text;
  }

  void setPosition(float x, float y) {
    this.xOrigin = x;
    this.yOrigin = y;
  }
}
