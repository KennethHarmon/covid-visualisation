import java.util.List;

List<MyData> myCompleteDataList;
List<MyData> searchData;  // For testing

void settings() {
  size(800, 800);
}

void setup() {
  myCompleteDataList = MyData.loadData(loadStrings("cases-1M.csv"));
  // For testing
  searchData = FilterData.filterByDate(myCompleteDataList.get(3).date, myCompleteDataList);
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
