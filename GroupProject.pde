import java.io.IOException;
import java.util.List;
import java.util.Iterator;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import org.gicentre.geomap.*;

GeoMap geoMap;
CaseModule casesModule;
NewCasesModule newCases;
HistogramModule histogram;
MapModule mapModule;
List<MyData> myCompleteDataList;
PrintList printList;
List<MyData> searchData;  // For testing
List<MyData> mapData;  // For testing
int searchData1;
PFont font;
String currentText;
Screen currentScreen;
Screen mainScreen;
Screen casesScreen;

void settings() {
  size(960, 540);
}

void setup() {
  surface.setResizable(true); // enables the window to resize when its edges are dragged.
  
  //Map
  geoMap = new GeoMap(MODULE_PADDING, MODULE_PADDING, ((width - 3 * MODULE_PADDING) / 2) - MODULE_PADDING * 2, ((height - 4 * MODULE_PADDING) * 3 / 8) - MODULE_PADDING * 2, this);  ///K.H added in map to test
  geoMap.readFile("usContinental");
  
  //Data retrieval
  try {
    String dataPath = dataPath("cases-1M.csv");
    myCompleteDataList = LoadData.loadData(dataPath);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  //Querying
  int cases = 0;
  searchData = FilterData.sampleByDate(myCompleteDataList, 100);
  searchData1 = FilterData.findNewCases(myCompleteDataList, "Cook",7);
  mapData = FilterData.filterByDate(searchData.get(0).date, myCompleteDataList);
  
  //Data calculations
  int mapMax = 0;
  for (MyData data : mapData) {
    mapMax = max(mapMax, data.cases);
  }
  for (final MyData myData : searchData) {
    cases += myData.cases;
  }
  
  //Initialisation
  font = createFont("Monospaced.bold", 22);
  printList = new PrintList(MODULE_PADDING, height/2 + MODULE_PADDING, width - 2 * MODULE_PADDING, height/2 - 2 * MODULE_PADDING, myCompleteDataList, 15); //ID:0
  newCases = new NewCasesModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, searchData1); //ID:1
  casesModule = new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, cases); //ID:2
  histogram = new HistogramModule(width/2 + MODULE_PADDING/2, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 3/8, searchData, 5); //ID:3
  mapModule = new MapModule(MODULE_PADDING, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 3/8, geoMap); //ID:4
  mainScreen = new Screen();
  casesScreen = new Screen();
  currentScreen = mainScreen;
  
  mainScreen.addModules(printList,newCases,casesModule,histogram,mapModule);
  geoMap.writeAttributesAsTable(5);
}

void draw() {
  background(GLOBAL_BACKGROUND);
  currentScreen.draw();
  //printList.printToConsole();
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    currentScreen = mainScreen;
  }
  else if (mouseButton == LEFT) {
    int event = currentScreen.getEvent();
    switch (event) {
    case 2:
      currentScreen = casesScreen;
      break;
    }
  }
}