import java.io.IOException;
import java.util.List;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;

List<MyData> myCompleteDataList;
List<MyData> searchData;  // For testing

void settings() {
  size(800, 800);
}

void setup() {
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
  // Simply for testing
  background(0);
  fill(255, 0, 0);
  rect(100, 100, 100, 100);
}
