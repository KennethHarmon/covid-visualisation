// made by William Walsh-Dowd on 23rd of March. a class that extends module and creates a simple histogram of the cases of the inputed MyFata List.
// it visualy scales with its width and height based on the size of the given data set and that sets' maximum vslue.
class HistogramModule extends Module { 
  int[] data;
  private float barWidth;
  private float maxDataValue;

  HistogramModule(int x, int y, int width, int height, List<MyData> data) { 
    super(x, y, width, height);
    barWidth = width/data.size();
    maxDataValue = FilterData.findHighestCaseCount(data);
    this.data = new int[data.size()];
    for(int i = 0; i < data.size(); i++) {
      this.data[i] = data.get(i).cases;
    }
  }

  void draw() {
    super.draw();
    fill(0);
    translate(super.xOrigin, super.yOrigin);
    for (int i = 0; i < data.length; i++) {
      stroke(NAVY);
      fill(NAVY);
      rect(map(i, 0, data.length, 0, width), height, barWidth, map(data[i], 0, maxDataValue, 0, -height));
      stroke(0);
    }
  }
}
