import java.io.IOException;
import java.util.List;
import java.util.Iterator;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;


TopLeftModule topLeft;
List<MyData> myCompleteDataList;
List<MyData> searchData;  // For testing

PFont font;
Iterator iterator;
int i = 0;
String currentText;

void settings() {
  size(960, 540);
}

void setup() {
  try {
    String dataPath = dataPath("cases-1M.csv");
    myCompleteDataList = LoadData.loadData(dataPath);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  // For testing
  int cases = 0;
  searchData = FilterData.sampleByDate(myCompleteDataList,10000);
  for (final MyData myData : searchData) {
    cases += myData.cases;
  }
  font = createFont("Monospaced.bold", 20);
  iterator = searchData.iterator();
  textAlign(CENTER);
    //for (final MyData myData : myCompleteDataList) {
    //  cases += myData.cases;
    //}
  topLeft = new TopLeftModule(MODULE_PADDING, MODULE_PADDING, (width - 3 * MODULE_PADDING) / 3, (height - 3 * MODULE_PADDING) / 7,cases);
}

void draw() {
  background(GLOBAL_BACKGROUND);
  if (iterator.hasNext() && i % 70 == 0) {
    currentText = iterator.next().toString();
  }
  fill(NAVY);
  text(currentText, width / 2, height / 2);
  i++;
  topLeft.draw();
}
