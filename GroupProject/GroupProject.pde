import java.io.IOException;
import java.util.List;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;


TopLeftModule topLeft;
List<MyData> myCompleteDataList;
List<MyData> searchData;  // For testing

void settings() {
  size(800, 800);
}

void setup() {
  topLeft = new TopLeftModule(modulePadding,modulePadding,(width-3*modulePadding)/3,(height-3*modulePadding)/7);
  try {
    myCompleteDataList = LoadData.loadData();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  // For testing
  searchData = FilterData.sampleByDate(myCompleteDataList,10);
  for (final MyData myData : searchData) {
    println(myData.toString());
  }
}

void draw() {
  background(globalBackground);
  topLeft.draw();
}
