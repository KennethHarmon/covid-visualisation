import java.time.LocalDate;
import java.time.ZoneId;

public class BiggestIncreasesModule extends Module {

  Map<String, List> stateCaseNumbers;
  Map<String, Integer> topFiveStateIncreases;
  List<String> topFiveStateNames;
  Map<Integer, HashMap> topFiveStatesCache;
  Map<Integer, Integer> maxValueCache;
  Map<String, Float> barWidthPerState;
  private float maxIncrease;
  private float padding;
  private float chartYStart;
  private float chartTextX;
  private float chartHeight;
  private float chartXStart;
  private float chartWidth;
  private int day;

  BiggestIncreasesModule(int x, int y, int wide, int tall, Map<String, List> stateData, int day) {
    super(x, y, wide, tall);
    this.day = day;
    stateCaseNumbers = stateData;
    topFiveStatesCache = new HashMap<Integer, HashMap>();
    maxValueCache = new HashMap<Integer, Integer>();
    barWidthPerState = new HashMap<String, Float>();
    topFiveStateIncreases = calculateChart();
    print("tall: " + tall);
  }

  @Override
    void subClassDraw() {
    ///Title 
    textAlign(LEFT, CENTER);
    final String text = "Biggest Increases:";
    fittedText(text, wide / 4, tall / 7, MODULE_PADDING);
    outlineText(text, MODULE_PADDING, tall / 14, 0, MODULE_COLOR);
    fill(0);
    //text(text, MODULE_PADDING, tall / 14);
    drawChart();
  }

  HashMap<String, Integer> calculateChart() {
    HashMap<String, Integer> topFiveStates;

    if (!topFiveStatesCache.containsKey(day)) { 
      //Get new cases over the last "day" days
      HashMap<String, Integer> newCasesPerState = new HashMap<String, Integer>();
      for (String state : STATES) {
        int stateCasesAMonthAgo = FilterData.findNewCasesForCounty(stateCaseNumbers.get(state), state, day);
        newCasesPerState.put(state, stateCasesAMonthAgo);
      }

      //Get top 5
      List<Map.Entry<String, Integer>>sortedList = sortByValue(newCasesPerState);
      topFiveStates = new LinkedHashMap<String, Integer>();
      int entry = sortedList.size()-1;
      int maxValue = 0;
      boolean hasGottenMax = false;
      while (topFiveStates.size() < 5) {
        Map.Entry<String, Integer> stateDataPoint = sortedList.get(entry);
        if (!hasGottenMax) {
          maxValue = stateDataPoint.getValue();
          hasGottenMax = true;
        }
        topFiveStates.put(stateDataPoint.getKey(), stateDataPoint.getValue());
        entry--;
      }
      topFiveStatesCache.put(day, topFiveStates);
      maxValueCache.put(day, maxValue);
    }

    topFiveStates = topFiveStatesCache.get(day);
    maxIncrease = maxValueCache.get(day);
    println(topFiveStates);
    topFiveStateNames = new ArrayList<String>(topFiveStates.keySet());
    for (String state : topFiveStates.keySet()) {
      barWidthPerState.put(state, float(0));
    }
    return topFiveStates;
  }

  void drawChart() {
    int offset = 0;
    padding = tall/6;
    chartYStart = tall/7;
    chartTextX = MODULE_PADDING;
    chartHeight = tall / 7;
    chartXStart = wide / 4;


    for (String state : topFiveStateIncreases.keySet()) {
      //Chart size variables
      moveBars(state);
      chartWidth = barWidthPerState.get(state);

      //Text
      fill(0);
      textAlign(LEFT, TOP);
      String text = state + ": ";
      fittedText("##########", wide / 5, tall / 6, 0);
      outlineText(text, chartTextX, (chartYStart + (padding*offset)), 0, MODULE_COLOR);
      text(text, chartTextX, (chartYStart + (padding*offset)));

      //Bar
      fill(TURQUIOSE);
      rect(chartXStart, chartYStart + (padding*offset), chartWidth, chartHeight);
      offset++;

    }

    checkMouseHover(barWidthPerState);
  }

  void moveBars(String state){
    float chartWidthMax = (float)(wide - ((MODULE_PADDING) + wide / 4)) * ((float)topFiveStateIncreases.get(state) / (float)maxIncrease);
    float barWidth = barWidthPerState.get(state);
    if(barWidth < chartWidthMax - 10){
      barWidthPerState.put(state, barWidth + 10);
    }
    else{
      barWidthPerState.put(state, chartWidthMax);
    }
  }

  void checkMouseHover(Map<String, Float> barWidthPerState) {
    for (int offset = 0; offset < 5; offset++) {
      // Mousing over the bar chart K.H Adapted from Miguel's hovering for pie chart.
      final int relativeMouseX = mouseX - (int) super.xOrigin;
      final int relativeMouseY = mouseY - (int) super.yOrigin;
      String state = topFiveStateNames.get(offset);
      if ((relativeMouseX >= chartXStart) && (relativeMouseX <= chartXStart + barWidthPerState.get(state)) && (relativeMouseY >= chartYStart + (padding*offset)) && (relativeMouseY <= (chartYStart + (padding*offset)) + chartHeight)) {
        textAlign(LEFT, CENTER);
        fill(BLACK, 63); // 25% opacity
        int xPos = relativeMouseX + 5;
        int yPos = relativeMouseY - 5;
        float xDimension = wide / 3;
        float yDimension = tall / 5;

        rectMode(CORNERS);
        rect(xPos, yPos, xPos + xDimension, yPos - yDimension);
        rectMode(CORNER);

        xPos += 5;

        // Total cases
        String information = formatText("###,###", topFiveStateIncreases.get(topFiveStateNames.get(offset))) + " cases";
        fittedText(information, xDimension, yDimension, MODULE_PADDING);
        yPos -= yDimension;
        outlineText(information, xPos, yPos + yDimension / 2, BLACK, GLOBAL_BACKGROUND);
      }
    }
  }

  //K.H Sort hashMap: based on geeksforgeeks sorting hashmap method but adapted for my use
  public List<Map.Entry<String, Integer>> sortByValue(HashMap<String, Integer> hm)
  {
    // Create a list from elements of HashMap
    List<Map.Entry<String, Integer> > list = new LinkedList<Map.Entry<String, Integer> >(hm.entrySet());

    // Sort the list
    Collections.sort(list, new Comparator<Map.Entry<String, Integer> >() {
      public int compare(Map.Entry<String, Integer> o1, 
        Map.Entry<String, Integer> o2)
      {
        return (o1.getValue()).compareTo(o2.getValue());
      }
    }
    );

    return list;
  }
}
