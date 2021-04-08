// M.A made a pie chart module to get top 10 areas affected by covid in a state, 03/04/2021
// M.A improved upon pie chart with error handling, mousing over to give more information and more, 04/04/2021
public class PieChartModule extends Module {
  private final String state;
  private final String stateCasesLabel;
  private final int totalCasesOfList;
  private List<AdminArea> topAdminAreasList;

  PieChartModule(float x, float y, float wide, float tall, String state) { 
    super(x, y, wide, tall);
    this.state = state;
    this.topAdminAreasList = initialiseTopTenList(initialiseCasesByAdminArea(stateCaseNumbers.get(state)), state);
    this.totalCasesOfList = getTotalCases();
    initialiseAngles();
    this.stateCasesLabel = (topAdminAreasList.size() > 1 ? "Most affected areas in " : "Not enough data for ") + state;
  }

  @Override
    void subClassDraw() {
    textAlign(CENTER, CENTER);
    if (topAdminAreasList.size() > 1) {
      fittedText(stateCasesLabel, wide / 1.2, tall / 3, MODULE_PADDING); // Change to take wide if it's going to be a square module
      outlineText(stateCasesLabel, wide / 2, tall / 12, 0, MODULE_COLOR);
      this.pieChart();
    } else {
      fittedText(stateCasesLabel, wide, tall, MODULE_PADDING * 2);
      outlineText(stateCasesLabel, wide / 2, tall / 2, 0, RED);
    }
  }

  // Based on processing's example https://processing.org/examples/piechart.html
  private void pieChart() {
    // Drawing the pie chart
    final float diameter = (wide >= tall ? tall : wide) / 1.3;
    float startAngle = 0;
    final float pieChartXPos = wide / 2;
    final float pieChartYPos = tall / 1.75;
    for (int i = 0; i < topAdminAreasList.size(); i++) {
      fill(lerpColor(maxMapColour, minMapColour, (float) i / (topAdminAreasList.size() - 1)));
      final float nextAngle = topAdminAreasList.get(i).angle + startAngle;
      arc(pieChartXPos, pieChartYPos, diameter, diameter, startAngle, nextAngle);
      startAngle = nextAngle;
    }

    // Mousing over the pie chart
    final int relativeMouseX = mouseX - (int) super.xOrigin;
    final int relativeMouseY = mouseY - (int) super.yOrigin;
    final float radius = diameter / 2;

    if (dist(pieChartXPos, pieChartYPos, relativeMouseX, relativeMouseY) <= radius) {
      float angle = atan2(relativeMouseY - pieChartYPos, relativeMouseX - pieChartXPos);
      if (angle < 0) {
        angle = TWO_PI + angle;
      }
      AdminArea sector = containsAngle(angle);
      if (sector != null) {
        textAlign(LEFT, CENTER);
        fill(BLACK, 63); // 25% opacity
        int xPos = relativeMouseX + 5;
        int yPos = relativeMouseY - 5;
        float xDimension = wide / 2;
        float yDimension = tall / 2;

        rectMode(CORNERS);
        rect(xPos, yPos, xPos + xDimension, yPos - yDimension);
        rectMode(CORNER);

        float yToBeDrawnIn = yDimension / 3;
        xPos += 5;

        // Percentage
        String information = twoDecimalPlacesFormat.format(sector.actualPercentageOfCases) + "% of cases in " + this.state;
        fittedText(information, xDimension, yToBeDrawnIn, (int) (MODULE_PADDING * 1.5));
        yPos -= yToBeDrawnIn;
        outlineText(information, xPos, yPos + yToBeDrawnIn / 2, BLACK, GLOBAL_BACKGROUND);

        // Total cases
        information = "Total cases: " + sector.totalCases;
        fittedText(information, xDimension, yToBeDrawnIn, (int) (MODULE_PADDING * 1.5));
        yPos -= yToBeDrawnIn;
        outlineText(information, xPos, yPos + yToBeDrawnIn / 2, BLACK, GLOBAL_BACKGROUND);

        // Admin area name
        information = "Region: " + sector.adminArea;
        fittedText(information, xDimension, yToBeDrawnIn, (int) (MODULE_PADDING * 1.5));
        yPos -= yToBeDrawnIn;
        outlineText(information, xPos, yPos + yToBeDrawnIn / 2, BLACK, GLOBAL_BACKGROUND);
      }
    }
  }

  private AdminArea containsAngle(final float angle) {
    float startAngle = 0; 
    for (AdminArea a : topAdminAreasList) {
      final float nextAngle = a.angle + startAngle;
      if (angle >= startAngle && angle < nextAngle) {
        return a;
      }
      startAngle = nextAngle;
    }
    return null;
  }

  private int getTotalCases() {
    int result = 0;
    for (AdminArea a : topAdminAreasList) {
      result += a.totalCases;
    }
    return result;
  }

  private void initialiseAngles() {
    for (AdminArea a : topAdminAreasList) {
      a.relativePercentageOfCasesAsDecimal = (double) a.totalCases / totalCasesOfList;
      a.angle = radians((float) a.relativePercentageOfCasesAsDecimal * 360);
    }
  }

  private List<AdminArea> initialiseTopTenList(Map<String, Integer> casesByAdminArea, String state) {
    List<AdminArea> fullList = new ArrayList(casesByAdminArea.size());
    for (Map.Entry<String, Integer> entry : casesByAdminArea.entrySet()) {
      fullList.add(new AdminArea(entry.getKey(), entry.getValue(), (float) entry.getValue() / stateCaseTotals.get(state) * 100));
    }
    Collections.sort(fullList);
    return fullList.subList(0, Math.min(10, fullList.size()));
  }

  private Map<String, Integer> initialiseCasesByAdminArea(final List<MyData> myDataList) { 
    Map<String, Integer> result = new HashMap();
    for (MyData myData : myDataList) {
      result.put(myData.administrativeArea, myData.cases);
    }
    return result;
  }

  private class AdminArea implements Comparable<AdminArea> {
    private final String adminArea;
    private final Integer totalCases;
    private double relativePercentageOfCasesAsDecimal;
    private final float actualPercentageOfCases;
    private float angle;

    AdminArea(final String adminArea, final Integer totalCases, final float actualPercentageOfCases) {
      this.adminArea = adminArea;
      this.totalCases = totalCases;
      this.actualPercentageOfCases = actualPercentageOfCases;
    }

    Integer getTotalCases() {
      return totalCases;
    }

    @Override
      public String toString() {
      return "Total cases: " + totalCases;
    }

    @Override
      public int compareTo(AdminArea o) {
      return -this.getTotalCases().compareTo(o.getTotalCases()); // Doing it in reverse
    }
  }
}
