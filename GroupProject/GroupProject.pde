import java.io.IOException;
import java.util.List;
import java.util.Iterator;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;


CaseModule casesModule;
NewCasesModule newCases;
HistogramModule histogram;
List<MyData> myCompleteDataList;
PrintList printList;
List<MyData> searchData;  // For testing
int searchData1;

PFont font;
String currentText;

void settings() {
  size(960, 540);
}

void setup() {
  surface.setResizable(true); // enables the window to resize when its edges are dragged.
  try {
    String dataPath = dataPath("cases-1M.csv");
    myCompleteDataList = LoadData.loadData(dataPath);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  // For testing
  int cases = 0;
  searchData = FilterData.sampleByDate(myCompleteDataList, 100);
  searchData1 = FilterData.findNewCases(myCompleteDataList, "Cook",7);
  for (final MyData myData : searchData) {
    cases += myData.cases;
  }
  font = createFont("Monospaced.bold", 22);
  printList = new PrintList(MODULE_PADDING, height/2 + MODULE_PADDING, width - 2 * MODULE_PADDING, height/2 - 2 * MODULE_PADDING, myCompleteDataList, 15);
  newCases = new NewCasesModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, searchData1);
  casesModule = new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, cases);
  histogram = new HistogramModule(width/2 + MODULE_PADDING/2, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) / 2, (height - 4 * MODULE_PADDING) * 3/8, searchData, 5);
}

void draw() {
  background(GLOBAL_BACKGROUND);
  printList.draw();
  casesModule.draw();
  newCases.draw();
  histogram.draw();
  printList.printToConsole();
}
