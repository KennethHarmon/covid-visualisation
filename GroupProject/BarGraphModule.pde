// made by William Walsh-Dowd on 23rd of March. a class that extends module and creates a simple histogram of the cases of the inputed MyFata List.
// it visualy scales with its wide and tall based on the size of the given data set and that sets' maximum value.
// it also has another constructor alowing you to create a histogram with a best fit line and a variable of how many data points that line will average then draw itself between.
import java.util.Arrays;

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
    maxDataValue = FilterData.findHighestCaseCount(data) * 1.05;
    this.data = new int[data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
    }
    this.averageRange = averageRange;
    lineData = saveBestFitLineAlt(this.data);
  }

  HistogramModule(int x, int y, int wide, int tall, int[] data, int averageRange) {
    super(x, y, wide, tall);
    barwide = wide/data.length;


    int[] dataCopy = new int[data.length];
    for (int i = 0; i < data.length; i++) {
      dataCopy[i] = data[i];
    }
    Arrays.sort(data);
    maxDataValue = data[data.length-1] * 1.05;
    data = dataCopy;

    this.data = new int[data.length];
    for (int i = 0; i < data.length; i++) {
      this.data[i] = data[i];
    }
    this.averageRange = averageRange;
    lineData = saveBestFitLineAlt(this.data);
  }

  HistogramModule(int x, int y, int wide, int tall, List<MyData> data) { 
    super(x, y, wide, tall);
    barwide = wide/data.size();
    maxDataValue = FilterData.findHighestCaseCount(data) * 1.05;
    this.data = new int[data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
    }
  }

  @Override
    void subClassDraw() {
    fill(0);
    for (int i = 0; i < data.length; i++) {
      fill(NAVY);
      strokeWeight(1);
      stroke(NAVY);
      rect(map(i, 0, data.length, boarderSize, wide - boarderSize) + 2, tall - boarderSize, barwide-2, map(data[i], 0, maxDataValue, boarderSize, -tall + boarderSize));
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
  
  void 

  int[] saveBestFitLineAlt(int[] data) {    // this method averages out the data around each point and saves each one, thus there is the same amount of points as the original data
    ArrayList newArray = new ArrayList();
    for (int i = 0; i < data.length; i++) {
      int averageOfElements = 0;
      boolean scaleAverage = false;
      int overflow = 0;
      for (int j = -averageRange; j < averageRange; j++) {
        if (i+j >= 0 && i+j < data.length) {
          averageOfElements += data[i+j];
        } else if (i+j >= data.length) {
          scaleAverage = true;
          overflow = averageRange + j;
          break;
        }
      }
      if (!scaleAverage) {
        averageOfElements = averageOfElements/(averageRange*2);
      } else {
        averageOfElements = averageOfElements/(overflow);
      }
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
