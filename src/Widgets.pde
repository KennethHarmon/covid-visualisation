// made by Yi Ren on 31st of March. Added a widget class to create radio buttons.
public class Widget {
  int event, duration;
  float x, y, wide, tall;
  color widgetColor1, widgetColor2;
  boolean clicked;

  Widget(int day, color unclickedColor, color clickedColor, int duration) {
    this.widgetColor1 = unclickedColor; 
    this.widgetColor2 = clickedColor;
    this.event = day;
    this.duration = duration;
    clicked = false;
  }

  Widget(int day, color unclickedColor, color clickedColor) {
    this.widgetColor1 = unclickedColor; 
    this.widgetColor2 = clickedColor;
    this.event = day;
    this.duration = 0;
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
    rect(x, y, wide, tall);
    fill(clicked ? WHITE : TEXT_COLOR);
    textAlign(CENTER, CENTER);
    String text =(event == duration) ? "All Time" : (event + ((event<= 1) ? "day" : "days"));
    fittedText(text, wide, tall, int(tall/4));
    text(text, x+wide/2, y+tall/2);
  }

  int getEvent(float mX, float mY) {
    if (mX >= x && mX <= x+wide && mY > y && mY < y+tall) {
      return event;
    }
    return EVENT_NULL;
  }
}
