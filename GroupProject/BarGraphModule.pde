// made by William Walsh-Dowd on 23rd of March. a class that extends module and creates a simple histogram of the cases of the inputed MyFata List.
// it visualy scales with its wide and tall based on the size of the given data set and that sets' maximum value.
// it also has another constructor alowing you to create a histogram with a best fit line and a variable of how many data points that line will average then draw itself between.
class HistogramModule extends Module { 
  int[] data;
  int[] lineData = new int[0];
  private float barwide;
  private float maxDataValue;
  private int averageRange = 1;
  private float boarderSize = 2;

  HistogramModule(int x, int y, int wide, int tall, List<MyData> data, int averageRange) { 
    super(x, y, wide, tall);
    barwide = wide/data.size();
    maxDataValue = FilterData.findHighestCaseCount(data);
    this.data = new int[data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
    }
    this.averageRange = averageRange;
    lineData = saveBestFitLineAlt(this.data);
  }

  HistogramModule(int x, int y, int wide, int tall, List<MyData> data) { 
    super(x, y, wide, tall);
    barwide = wide/data.size();
    maxDataValue = FilterData.findHighestCaseCount(data);
    this.data = new int[data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
    }
  }

  @Override
  void subClassDraw() {
    fill(0);
    for (int i = 0; i < data.length; i++) {
      stroke(NAVY);
      fill(NAVY);
      if (i == 0) {
        rect(map(i, 0, data.length, boarderSize, wide - boarderSize) + 3, tall - boarderSize - 1, barwide-4, map(data[i], 0, maxDataValue, boarderSize, -tall + boarderSize));
      } else {
        rect(map(i, 0, data.length, boarderSize, wide - boarderSize) + 2, tall - boarderSize, barwide-2, map(data[i], 0, maxDataValue, boarderSize, -tall + boarderSize));
      }
      strokeWeight(1);
      stroke(0);
    }
    bestFitLine(lineData);
  }

  void bestFitLine(int[] dataToMap) {
    for (int i = 0; i < dataToMap.length-1; i++) {
      stroke(255, 0, 0);
      line(map(i + .5, 0, dataToMap.length, 0, wide), tall - map(dataToMap[i], 0, maxDataValue, 0, tall), map(i+1 + .5, 0, dataToMap.length, 0, wide), tall - map(dataToMap[i+1], 0, maxDataValue, 0, tall));
      stroke(0);
    }
  }

  int[] saveBestFitLine(int[] data) {    // this method averages the data of the given range and saves it as a single data point
    ArrayList newArray = new ArrayList();
    for (int i = 0; i < data.length-averageRange; i += averageRange) {
      int averageOfLastElements = 0;
      for (int j = 0; j < averageRange; j++) {
        averageOfLastElements += data[i+j];
      }
      averageOfLastElements = averageOfLastElements/averageRange;
      newArray.add(int(averageOfLastElements));
    }
    if (data.length-1 % averageRange != 0) {
      int averageOfLastElements = 0;
      for (int j = 0; j < (data.length-1 - newArray.size()*averageRange); j++) {
        averageOfLastElements += data[newArray.size()*averageRange+j];
      }
      newArray.add(int(averageOfLastElements));
    }
    return toIntArray(newArray);
  }

  int[] saveBestFitLineAlt(int[] data) {    // this method averages out the data around each point and saves each one, thus there is the same amount of points as the original data
    ArrayList newArray = new ArrayList();
    for (int i = averageRange; i < data.length-averageRange; i++) {
      int averageOfElements = 0;
      for (int j =  -averageRange; j < averageRange; j++) {
        averageOfElements += data[i+j];
      }
      averageOfElements = averageOfElements/((averageRange*2)+1);
      newArray.add(int(averageOfElements));
    }
    return toIntArray(newArray);
  }

  public int[] toIntArray(List<Integer> ints) {
    int[] newArray = new int[ints.size()];
    for (int i=0; i < newArray.length; i++) {
      newArray[i] = ints.get(i).intValue();
    }
    return newArray;
  }
}
