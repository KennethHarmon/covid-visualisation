// made by Yi Ren on 31st of March. Added a widget class to create radio buttons.
public class Widget {
  int event;
  float x, y, wide, tall;
  color widgetColor1, widgetColor2;
  boolean clicked;

  Widget(int day, color unclickedColor, color clickedColor) {
    this.widgetColor1 = unclickedColor; 
    this.widgetColor2 = clickedColor;
    this.event = day;
    clicked = false;
  }


  void resize(float x, float y, float wide, float tall) {
    this.x = x; 
    this.y = y;
    this.wide = wide; 
    this.tall = tall;
  }

  void draw() {
    fill(clicked ? widgetColor2 : widgetColor1);
    stroke(GLOBAL_MODULE_STROKE);
    strokeWeight(3);
    rect(x, y, wide, tall);
    textAlign(CENTER, CENTER);
    String text = event + ((event<= 1) ? "day" : "days");
    fittedText(text, wide, tall, MODULE_PADDING);
    outlineText(text, x+wide/2, y+tall/2, 0, MODULE_COLOR);
  }

  int getEvent(float mX, float mY) {
    if (mX >= x && mX <= x+wide && mY > y && mY < y+tall) {
      return event;
    }
    return EVENT_NULL;
  }
}
