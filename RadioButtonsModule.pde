//// made by Yi Ren on 31st of March. a class that extends module and takes in the user input to show new cases over different time periods.
public class RadioButtonsModule extends Module {
  ArrayList<Widget> radio;
  int current, event, day;
  List<MyData> dataList;
  String area;
  int initial, screen, duration;
  int[] days;

  RadioButtonsModule(float x, float y, float wide, float tall, final List<MyData> myDataList, int screen, String area, int initialIndex, int ...days) {
    super(x, y, wide, tall);
    this.duration = days[days.length-1];
    radio = new ArrayList<Widget>();
    for (int i = 0; i < days.length; i++) {
      radio.add(new Widget(days[i], GREY, NAVY, duration));
    }
    this.screen = screen;
    this.days = days;
    this.initial = initialIndex;
    current = initial;
    radio.get(current).clicked = true;
    event = days[initial]; 
    day = days[initial];
    this.area = area; 
    this.dataList = myDataList;
  }

  RadioButtonsModule(float x, float y, float wide, float tall, final List<MyData> myDataList, int screen, int initialIndex, int ...days) {
    super(x, y, wide, tall);
    radio = new ArrayList<Widget>();
    for (int i = 0; i < days.length; i++) {
      radio.add(new Widget(days[i], GREY, NAVY));
    }
    this.screen = screen;
    this.days = days;
    this.initial = initialIndex;
    current = initial;
    radio.get(current).clicked = true;
    event = days[initial]; 
    day = days[initial];
    this.dataList = myDataList;
  }

  @Override
    void subClassDraw() {
    if (screen == 1) {
      String text1 = "Show new cases\nin the past ";
      textAlign(CENTER);
      fittedText(text1, wide/2, tall, MODULE_PADDING);
      outlineText(text1, wide/4, tall/2, 0, MODULE_COLOR);
    } else {
      String text2 = "Show new cases in the past ";
      fittedText(text2, wide/3, tall, MODULE_PADDING);
      outlineText(text2, wide/6, tall / 2, 0, MODULE_COLOR);
    }
    for (int i = 0; i < radio.size(); i++) {
      if (mousePressed) {
        event = radio.get(i).getEvent(mouseX - super.xOrigin, mouseY - super.yOrigin);
        if (event != EVENT_NULL) {
          if (current != EVENT_NULL) {
            radio.get(current).clicked = false;
          }
          current = i;
          day = event;
          radio.get(i).clicked = true;
          if (screen == 1) {
            newCases.cases = FilterData.findTotalNewCases(myCompleteDataList, radioButtons.day);  
            biggestIncreasesModule.day = day;
            biggestIncreasesModule.topFiveStateIncreases = biggestIncreasesModule.calculateChart();
          }
        }
      }
      switch(screen) {
      case 1:
        fill(0);
        radio.get(i).resize(wide/2 + 2*MODULE_PADDING, (tall-(days.length+3)*MODULE_PADDING)/days.length*i + MODULE_PADDING*(i+2), wide/2 - 4*MODULE_PADDING, (tall-(days.length+3)*MODULE_PADDING)/days.length);
        radio.get(i).draw();
        break;
      case 2:
        fill(0);
        radio.get(i).resize(wide/3 + wide*2/3/days.length*i, MODULE_PADDING, (wide*2/3 - 2*MODULE_PADDING)/days.length, tall-2*MODULE_PADDING);
        radio.get(i).draw();
        break;
      }
    }
  }
}
