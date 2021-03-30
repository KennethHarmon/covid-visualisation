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
HashMap<String, Integer> stateCaseTotals;
HashMap<String, List> stateCaseNumbers;
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
  
  //Data retrieval
  try {
    String dataPath = dataPath("cases-1M.csv");
    myCompleteDataList = LoadData.loadData(dataPath);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  //Querying
  int totalCases = 0;
  searchData = FilterData.sampleByDate(myCompleteDataList, 100);
  
  //Map HashMap
  HashMap[] stateCaseInformation = FilterData.findCurrentStateCases(myCompleteDataList);
  stateCaseTotals = stateCaseInformation[0];
  stateCaseNumbers = stateCaseInformation[1];
  
  //Total Cases
  for (int caseTotals : stateCaseTotals.values()) {
    totalCases += caseTotals;
  }
  
  //Initialisation
  font = createFont("Monospaced.bold", 22);
  textSize(14);
  newCases = new NewCasesModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, 0); //ID:1
  casesModule = new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, totalCases); //ID:2
  histogram = new HistogramModule(width/2 + MODULE_PADDING/2, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, searchData, 5); //ID:3
  mapModule = new MapModule(MODULE_PADDING, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, stateCaseTotals); //ID:4
  mainScreen = new Screen();
  casesScreen = new Screen();
  currentScreen = mainScreen;
  
  mainScreen.addModules(newCases,casesModule,histogram,mapModule);
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
