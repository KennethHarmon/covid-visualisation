//// made by Yi Ren on 31st of March. a class that extends module and takes in the user input to show new cases over different time periods.
class RadioButtonsModule extends Module{
ArrayList<Widget> radio;
int current, event, day;
List<MyData> dataList;
String area;
  
  RadioButtonsModule(float x, float y, float wide, float tall, final List<MyData> myDataList, String area, int ...days) {
    super(x, y, wide, tall);
    radio = new ArrayList<Widget>();
    for(int i = 0; i < days.length; i++){
      radio.add(new Widget(wide/3 + wide*2/3/days.length*i, MODULE_PADDING, (wide*2/3 - 2*MODULE_PADDING)/days.length, tall-2*MODULE_PADDING, days[i], GREY, NAVY));
    }
    current = EVENT_NULL;
    event = 1; day = 1;
    this.area = area; this.dataList = myDataList;
  }

  @Override
  void subClassDraw() {
    final String text1 = "Show new cases in the past ";
    fittedText(text1, wide/3, tall, MODULE_PADDING);
    outlineText(text1, wide/6, tall / 2, 0, MODULE_COLOR);
    for(int i = 0; i < radio.size(); i++){
      if(mousePressed){
        event = radio.get(i).getEvent(mouseX - super.xOrigin, mouseY - super.yOrigin);
        if(event != EVENT_NULL){
          if(current != EVENT_NULL){
            radio.get(current).clicked = false;
          }
          current = i;
          day = event;
          radio.get(i).clicked = true;
        }
      }
      radio.get(i).draw();
    }
    
  }
}
