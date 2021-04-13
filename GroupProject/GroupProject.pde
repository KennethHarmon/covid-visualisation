import java.util.*;
import java.io.FileReader;
import java.io.IOException;
import processing.sound.*;
import org.gicentre.geomap.*;

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
PrintList printList;
List<MyData> searchData;
Map<String, Integer> stateCaseTotals;
Map<String, List> stateCaseNumbers;
PFont font;
SoundFile lobbyMusic;
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

  //Initialisation
  font = createFont("Monospaced.bold", 22);
  textSize(14);
  newCases = new NewCasesModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, initialNewCases); 
  casesModule = new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, totalCases);
  histogram = new HistogramModule(width/2 + MODULE_PADDING/2, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, FilterData.myDataToMyGraphData(searchData), 5); 
  mapModule = new MapModule(MODULE_PADDING, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 4/8, stateCaseTotals); 
  radioButtons = new RadioButtonsModule(2 * MODULE_PADDING + ((width - 3 * MODULE_PADDING) / 3 ) * 2, 3 * MODULE_PADDING + ( 5 * (height - 4 * MODULE_PADDING) / 8), (width - 3 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) * 3/8, myCompleteDataList, 1, 1, 1, 7, 30);
  biggestIncreasesModule = new  BiggestIncreasesModule(MODULE_PADDING, 3 * MODULE_PADDING + ( 5 * (height - 4 * MODULE_PADDING) / 8), ((width - 3 * MODULE_PADDING) / 3 ) * 2, (height - 4 * MODULE_PADDING) * 3/8, stateCaseNumbers, 7);
  searchBar = new  SearchBarModule(width/2-(width - 4 * MODULE_PADDING) / 6 + (width - 4 * MODULE_PADDING) / 3 + MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8); // Didn't know where to put it
  mainScreen = new Screen();
  casesScreen = new Screen();
  currentScreen = mainScreen;

  // M.A added some lobby music, 02/04/2021
  // Credit to https://youtu.be/L6d7dH6tNAs
  //lobbyMusic = new SoundFile(this, "Lounge-Music.mp3");
  //lobbyMusic.loop(1, 0.01);

  mainScreen.addModules(newCases, casesModule, histogram, mapModule, radioButtons, biggestIncreasesModule, searchBar);
}

void draw() {
  background(GLOBAL_BACKGROUND);
  currentScreen.draw();
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

// M.A made a method to fit the text to a boundary 30/03/2021
/*  
This method takes a String, two dimensions that make up a box (rectangle); these are the boundaries for the text, and a padding value.
Taking all of these values into account it will make the text size the largest possible while fitting into the given 'box' (with padding).
*/
public void fittedText(String str, float xDimension, float yDimension, int padding) {
  textSize(12);
  textSize(min(12 * (xDimension - padding)/ textWidth(str), 12 / (textDescent() + textAscent()) * (yDimension - padding)));
}
