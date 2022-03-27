import java.util.*;
import java.io.IOException;
import org.gicentre.geomap.*;

// M.A These three Maps are used by PieChartModule and are used for caching, 13/04/2021
Map<String, List> stateAdminAreaCases30;
Map<String, List> stateAdminAreaCases7;
Map<String, List> stateAdminAreaCasesDay;

GeoMap geoMap;
CaseModule casesModule;
NewCasesModule newCases;
HistogramModule histogram;
MapModule mapModule;
BiggestIncreasesModule biggestIncreasesModule;
List<MyData> myCompleteDataList;
SearchBarModule searchBar;
RadioButtonsModule radioButtons;
LoadingScreen loadingScreen;
PrintList printList;
List<MyData> searchData;
Map<String, Integer> stateCaseTotals;
Map<String, List> stateCaseNumbers;
PFont font;
String currentText;
Screen currentScreen;
Screen mainScreen;
Screen casesScreen;
Map<Integer, Integer> newCasesCache;

// M.A Made loading bar smoother
static boolean isSetup;
static double loadingPercent;

void settings() {
  size(960, 540);
}

void setup() {
  isSetup = false;
  loadingPercent = 0;
  loadingScreen = new LoadingScreen();
  thread("setupProgram");
  font = createFont("Yu Gothic UI Regular", 22);
  textFont(font);
}

void draw() {
  if(isSetup) {
    background(GLOBAL_BACKGROUND);
    currentScreen.draw();
  }
  else {
    loadingScreen.draw();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    currentScreen = mainScreen;
  }
}

void keyPressed() {
  if (currentScreen.equals(mainScreen)) {
    searchBar.isKeyPressed();
  }
}

void setupProgram() {
  surface.setResizable(true); // enables the window to resize when its edges are dragged.
  loadingPercent += 0.1;

  //Data retrieval
  try {
    String dataPath = dataPath("cases-1M.csv");
    myCompleteDataList = LoadData.loadData(dataPath);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  loadingPercent += 0.1;

  //Querying
  int totalCases = 0;
  searchData = FilterData.sampleByDate(myCompleteDataList, 100);
  loadingPercent += 0.1;

  //Map interface
  Map[] stateCaseInformation = FilterData.findCurrentStateCases(myCompleteDataList);
  stateCaseTotals = stateCaseInformation[0];
  stateCaseNumbers = stateCaseInformation[1];
  
  stateAdminAreaCases30 = new HashMap();
  stateAdminAreaCases7 = new HashMap();
  stateAdminAreaCasesDay = new HashMap();

  //Total Cases
  for (int caseTotals : stateCaseTotals.values()) {
    totalCases += caseTotals;
  }

  //Initial new cases
  int initialNewCases = FilterData.findTotalNewCases(myCompleteDataList, 7);
  
  loadingPercent += 0.1;

  //Initialisation
  newCasesCache = new HashMap();
  
  loadingPercent += 0.05;
  
  textSize(14);
  newCases = new NewCasesModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, initialNewCases); 
  casesModule = new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, totalCases);

  loadingPercent += 0.05;
  
  
  mapModule = new MapModule(MODULE_PADDING, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, stateCaseTotals); 
  radioButtons = new RadioButtonsModule(2 * MODULE_PADDING + ((width - 3 * MODULE_PADDING) / 3 ) * 2, 3 * MODULE_PADDING + ( 5 * (height - 4 * MODULE_PADDING) / 8), (width - 3 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) * 3/8, myCompleteDataList, 1, 1, 1, 7, 30);
  
  loadingPercent += 0.05;
  
  biggestIncreasesModule = new  BiggestIncreasesModule(MODULE_PADDING, 3 * MODULE_PADDING + ( 5 * (height - 4 * MODULE_PADDING) / 8), ((width - 3 * MODULE_PADDING) / 3 ) * 2, (height - 4 * MODULE_PADDING) * 3/8, stateCaseNumbers, 7);
  histogram = new HistogramModule(width/2 + MODULE_PADDING/2, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, FilterData.createTotalCasesPerTime(stateCaseNumbers, myCompleteDataList), 5); searchBar = new  SearchBarModule(width/2-(width - 4 * MODULE_PADDING) / 6 + (width - 4 * MODULE_PADDING) / 3 + MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8);
  mainScreen = new Screen();
  casesScreen = new Screen();
  currentScreen = mainScreen;

  mainScreen.addModules(newCases, casesModule, histogram, mapModule, radioButtons, biggestIncreasesModule, searchBar);
  isSetup = true;
  loadingPercent = 1;
}

// M.A made a method to fit the text to a boundary 30/03/2021
/*  
This method takes a String, two dimensions that make up a box (rectangle); these are the boundaries for the text, and a padding value.
Taking all of these values into account it will make the text size the largest possible while fitting into the given 'box' (with padding).
*/
public void fittedText(String str, float xDimension, float yDimension, int padding) {
  textSize(12);
  textSize(min(12 * (xDimension - padding)/ textWidth(str), 12 / (textDescent() + textAscent()) * (yDimension - padding)));
}
