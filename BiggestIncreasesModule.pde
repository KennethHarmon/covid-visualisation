import java.time.LocalDate;
import java.time.ZoneId;

class BiggestIncreasesModule extends Module {
  
  HashMap<String, List> stateCaseNumbers;
  
  BiggestIncreasesModule(int x, int y, int wide, int tall, HashMap<String, List> stateData) {
    super(x,y,wide,tall);
    stateCaseNumbers = stateData;
  }
  
  @Override
  void subClassDraw() {
    ///Title 
    textAlign(LEFT, CENTER);
    final String text = "Biggest Increases:";
    fittedText(text, wide / 4 , tall / 7, MODULE_PADDING);
    fill(0);
    text(text, MODULE_PADDING, tall / 14);
    //drawGraph();
  }
  
  void drawGraph() {
     for (String state : STATES) {
       ArrayList<MyData> statesData = new ArrayList<MyData>(stateCaseNumbers.get(state));
       LocalDate currentDate = statesData.get(0).date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
       print(currentDate.toString());
       LocalDate aMonthAgo = currentDate.minusDays(30);
       print(aMonthAgo.toString());
       LocalDate twoMonthsAgo = currentDate.minusDays(60);
       print(twoMonthsAgo.toString());
     }
  }
  
  
}
