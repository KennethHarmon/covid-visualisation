// made by William Walsh-Dowd on 23rd of March. a class that extends module and creates a simple histogram of the cases of the inputed MyFata List.
// it visualy scales with its wide and tall based on the size of the given data set and that sets' maximum value.
// it also has another constructor alowing you to create a histogram with a best fit line and a variable of how many data points that line will average then draw itself between.
import java.util.Arrays;

public class HistogramModule extends Module { 
  int[] data;
  String[] dates;
  int[] lineData = new int[0];
  private float barwide;
  private float maxDataValue;
  private float minDataValue;
  private int averageRange = 1;
  private float boarderSize = 2;
  TextModule textBox = new TextModule(wide/2-(wide/6), 0, wide/3, tall/10, "", TEXT_COLOR);

  HistogramModule(int x, int y, int wide, int tall, List<MyGraphData> data, int averageRange) {
    super(x, y, wide, tall);
    barwide = (wide *9/10)/data.size();
    maxDataValue = FilterData.findHighestCaseCountFromGraphDataList(data) * 1.05;
    minDataValue = FilterData.findLowestCaseCountFromGraphDataList(data);
    this.data = new int[data.size()];
    this.dates = new String[data.size()];
    SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
      this.dates[i] = DATE_FORMAT.format(data.get(i).date).toString();
    }
    this.averageRange = averageRange;
    lineData = saveBestFitLineAlt(this.data);
  }

  HistogramModule(int x, int y, int wide, int tall, int[] data, int averageRange) {
    super(x, y, wide, tall);
    barwide = (wide*9/10 - boarderSize)/data.length;
    this.dates = null;  // For now


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

  HistogramModule(int x, int y, int wide, int tall, List<MyGraphData> data) {
    super(x, y, wide, tall);
    barwide = (wide*9/10 - boarderSize)/data.size();
    maxDataValue = FilterData.findHighestCaseCountFromGraphDataList(data) * 1.05;
    this.data = new int[data.size()];
    this.dates = new String[data.size()];
    for (int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
      this.dates[i] = DATE_FORMAT.format(data.get(i).date).toString();
    }
  }

  @Override
    void subClassDraw() {
    drawBars();
    bestFitLine(lineData);
    scaleLines();
    selectBar();
  }

  public void drawBars() {
    fill(0);
    rectMode(CORNER);
    for (int i = 0; i < data.length; i++) {
      fill(NAVY);
      stroke(NAVY);
      strokeWeight(0.5);
      rect(map(i, 0, data.length, wide/10 + boarderSize, wide - boarderSize) + 2, tall - boarderSize, barwide-2, map(data[i], minDataValue, maxDataValue, boarderSize, -tall + boarderSize));
    }
  }

  private void bestFitLine(int[] dataToMap) {
    for (int i = 0; i < dataToMap.length-1; i++) {
      stroke(LIGHT_BLUE);
      line(map(i + .5, 0, dataToMap.length, wide/10, wide), tall - map(dataToMap[i], minDataValue, maxDataValue, 0, tall), map(i+1 + .5, 0, dataToMap.length, wide/10, wide), tall - map(dataToMap[i+1], minDataValue, maxDataValue, 0, tall));
      stroke(0);
    }
  }

  private void scaleLines() {
    int scale = int((maxDataValue - minDataValue)/10);
    for (int i = 1; i < 11; i++) {
      textSize(tall/25);
      fill(TEXT_COLOR);
      textAlign(LEFT);
      text(formatText("##,###,###", int(((10-i) * (scale)) + minDataValue)), 5, (i-1) * (tall/10) + tall/13);
      stroke(TEXT_COLOR);
      line(0, i * (tall/10), wide, i * (tall/10));
    }
  }

  private void selectBar() {
    if (mouseX > wide/10 + boarderSize + super.xOrigin && mouseX < wide + super.xOrigin && mouseY > 0 + super.yOrigin && mouseY < tall + super.yOrigin) {
      for (int i = 0; i < data.length; i++) {
        if (mouseX >= (map(i, 0, data.length, wide/10 + boarderSize, wide - boarderSize) + 2) + super.xOrigin && mouseX < (map(i + 1, 0, data.length, wide/10 + boarderSize, wide - boarderSize) + 2) + super.xOrigin) {
          rectMode(CORNER);
          noStroke();
          fill(GREY);
          rect((map(i, 0, data.length, wide/10 + boarderSize, wide - boarderSize) + 2), 0, 2, tall);
          textBox.setText((this.dates == null ? "" : "Cases on " + this.dates[i] + ": ") + formatText("##,###,###", data[i]));
          break;
        }
      }
      textBox.draw();
    }
  }

  private int[] saveBestFitLineAlt(int[] data) {    // this method averages out the data around each point and saves each one, thus there is the same amount of points as the original data
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

  private int[] toIntArray(List<Integer> ints) {
    int[] newArray = new int[ints.size()];
    for (int i=0; i < newArray.length; i++) {
      newArray[i] = ints.get(i).intValue();
    }
    return newArray;
  }
}
