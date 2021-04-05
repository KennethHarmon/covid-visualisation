import java.io.IOException;
import java.util.*;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import processing.sound.*;
import org.gicentre.geomap.*;

GeoMap geoMap;
CaseModule casesModule;
NewCasesModule newCases;
HistogramModule histogram;
MapModule mapModule;
BiggestIncreasesModule biggestIncreasesModule;
List<MyData> myCompleteDataList;
SearchBarModule searchBar;
PrintList printList;
List<MyData> searchData;  // For testing
HashMap<String, Integer> stateCaseTotals;
HashMap<String, List> stateCaseNumbers;
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
  biggestIncreasesModule = new  BiggestIncreasesModule(MODULE_PADDING, 3 * MODULE_PADDING + ( 5 * (height - 4 * MODULE_PADDING) / 8), ((width - 3 * MODULE_PADDING) / 3 ) * 2, (height - 4 * MODULE_PADDING) * 3/8, stateCaseNumbers);
  searchBar = new  SearchBarModule(width/2-(width - 4 * MODULE_PADDING) / 6 + (width - 4 * MODULE_PADDING) / 3 + MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8); // Didn't know where to put it
  mainScreen = new Screen();
  casesScreen = new Screen();
  currentScreen = mainScreen;
  
  // M.A added some lobby music, 02/04/2021
  // Credit to https://youtu.be/L6d7dH6tNAs
  //lobbyMusic = new SoundFile(this, "Lounge-Music.mp3");
  //lobbyMusic.loop(1, 0.01);

  mainScreen.addModules(newCases, casesModule, histogram, mapModule, biggestIncreasesModule, searchBar);
}

void draw() {
  background(GLOBAL_BACKGROUND);
  currentScreen.draw();
  //printList.printToConsole();
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    currentScreen = mainScreen;
  } else if (mouseButton == LEFT) {
    int event = currentScreen.getEvent();
    switch (event) {
    case 2:
      currentScreen = casesScreen;
      break;
    }
  }
}

void keyPressed() {
  if (currentScreen.equals(mainScreen)) {
    searchBar.isKeyPressed();
  }
}

// M.A made a method to fit the text to a boundary 30/03/2021
public void fittedText(String str, float xDimension, float yDimension, int padding) {
  textSize(12);
  textSize(min(12 * (xDimension - padding)/ textWidth(str), 12 / (textDescent() + textAscent()) * (yDimension - padding)));
}
