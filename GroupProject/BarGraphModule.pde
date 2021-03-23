class BarGraphModule extends Module { 
  int[] data;
  private float barWidth;
  private float maxDataValue;

  BarGraphModule(int x, int y, int width, int height, List<MyData> data) { 
    super(x, y, width, height);
    barWidth = width/data.size();
    FilterData dataFilter = new FilterData();
    maxDataValue = dataFilter.findHighestCaseCount(data);
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
      fill(200);
      rect(map(i, 0, data.length, 0, width), height, barWidth, map(data[i], 0, maxDataValue, 0, -height));
    }
  }
}
