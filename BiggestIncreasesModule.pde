import java.time.LocalDate;
import java.time.ZoneId;

class BiggestIncreasesModule extends Module {
  
  HashMap<String, List> stateCaseNumbers;
  HashMap<String, Integer> topFiveStateIncreases;
  float maxIncrease;
  
  BiggestIncreasesModule(int x, int y, int wide, int tall, HashMap<String, List> stateData) {
    super(x,y,wide,tall);
    stateCaseNumbers = stateData;
    topFiveStateIncreases = calculateChart();
    print("tall: " + tall);
  }
  
  @Override
  void subClassDraw() {
    ///Title 
    textAlign(LEFT, CENTER);
    final String text = "Biggest Increases:";
    fittedText(text, wide / 4 , tall / 7, MODULE_PADDING);
    fill(0);
    text(text, MODULE_PADDING, tall / 14);
    drawChart();
  }
  
  HashMap<String, Integer> calculateChart() {
    //Get new cases over the last month
    HashMap<String, Integer> newCasesPerState = new HashMap<String, Integer>();
    for (String state: STATES) {
      int stateCasesAMonthAgo = FilterData.findNewCasesForCounty(stateCaseNumbers.get(state), state, 30);
      newCasesPerState.put(state, stateCasesAMonthAgo);
    }
    
    //Get top 5
     List<Map.Entry<String, Integer>>sortedList = sortByValue(newCasesPerState);
     HashMap<String, Integer> topFiveStates = new LinkedHashMap<String, Integer>();
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
     println(topFiveStates);
     maxIncrease = maxValue;
     return topFiveStates;
  }
  
  void drawChart() {
    int offset = 0;
    float padding = tall/6;
    float chartYStart = tall/7;
    for (String state : topFiveStateIncreases.keySet()) {
      float chartWidth = (float)(wide - ((MODULE_PADDING) + wide / 4)) * ((float)topFiveStateIncreases.get(state) / (float)maxIncrease);
      fill(0);
      textAlign(LEFT, TOP);
      fittedText("//////////////////", wide / 5, tall / 6, 0);
      text(state + " (" + topFiveStateIncreases.get(state) + "): ", MODULE_PADDING ,(chartYStart + (padding*offset)));
      fill(TURQUIOSE);
      rect(wide / 4, chartYStart+(padding*offset), chartWidth, tall / 7);
      offset++;
    }
  }
  
  //K.H Sort hashMap: based on geeksforgeeks sorting hashmap method but adapted for my use
    public List<Map.Entry<String, Integer>> sortByValue(HashMap<String, Integer> hm)
    {
        // Create a list from elements of HashMap
        List<Map.Entry<String, Integer> > list =
               new LinkedList<Map.Entry<String, Integer> >(hm.entrySet());
  
        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<String, Integer> >() {
            public int compare(Map.Entry<String, Integer> o1, 
                               Map.Entry<String, Integer> o2)
            {
                return (o1.getValue()).compareTo(o2.getValue());
            }
        });
          
        return list;  
    }
  
  
}
