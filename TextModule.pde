// William Walsh-dowd created on the 30th of march, a module that prints text.
class TextModule extends Module { 
  String text;
  
  TextModule(float x, float y, float wide, float tall, String text) { 
    super(x, y, wide, tall);
    this.text = text;
  }

  void subClassDraw() {
    textAlign(CENTER, CENTER);
    textSize(wide * tall / 1000);
    outlineText(text, wide / 2, tall / 2, 0, MODULE_COLOR);
  }
}
