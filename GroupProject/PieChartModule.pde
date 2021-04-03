// M.A made a pie chart module to get top 10 areas affected by covid in a state, 03/04/2021
public class PieChartModule extends Module {
  private final String stateCasesLabel;
  private final int totalCasesOfTopTen;
  private HashMap<String, Integer> casesByAdminArea;
  private List<AdminArea> topTenAdminAreasList;

  PieChartModule(float x, float y, float wide, float tall, String state) { 
    super(x, y, wide, tall);
    this.stateCasesLabel = "Ten most affected areas in " + state;
    this.casesByAdminArea = initialiseCasesByAdminArea(stateCaseNumbers.get(state));
    this.topTenAdminAreasList = initialiseTopTenList();
    this.totalCasesOfTopTen = getTotalCases();
    initialiseAngles();
  }

  @Override
    void subClassDraw() {
    textAlign(CENTER, CENTER);
    fittedText(stateCasesLabel, wide / 3, tall / 3, MODULE_PADDING);
    outlineText(stateCasesLabel, wide / 2, tall / 12, 0, MODULE_COLOR);
    this.pieChart();
  }

  // Based on processing's example https://processing.org/examples/piechart.html
  private void pieChart() {
    float diameter = wide >= tall ? tall / 1.7 : wide / 1.7;
    double lastAngle = 0;
    float pieChartXPos = wide / 2;
    float pieChartYPos = tall / 1.8;
    for (int i = 0; i < topTenAdminAreasList.size(); i++) {
      fill(lerpColor(minMapColour, maxMapColour, (float) i / (topTenAdminAreasList.size() - 1)));
      double angleToBeAdded = radians(topTenAdminAreasList.get(i).angle);
      arc(pieChartXPos, pieChartYPos, diameter, diameter, (float) lastAngle, (float) (lastAngle + angleToBeAdded));
      lastAngle += angleToBeAdded;
    }
  }
  
  private int getTotalCases() {
    int result = 0;
    for (AdminArea a : topTenAdminAreasList) {
      result += a.totalCases;
    }
    return result;
  }

  private void initialiseAngles() {
    for (AdminArea a : topTenAdminAreasList) {
      a.percentageOfCasesAsDecimal = (double) a.totalCases / totalCasesOfTopTen;
      a.angle = (float) a.percentageOfCasesAsDecimal * 360;
    }
  }
  
  private List<AdminArea> initialiseTopTenList() {
    List<AdminArea> fullList = new ArrayList();
    for (Map.Entry<String, Integer> entry : this.casesByAdminArea.entrySet()) {
      fullList.add(new AdminArea(entry.getKey(), entry.getValue()));
    }
    Collections.sort(fullList);
    return fullList.subList(fullList.size() - 11, fullList.size() - 1);
  }

  private HashMap<String, Integer> initialiseCasesByAdminArea(final List<MyData> myDataList) { 
    HashMap<String, Integer> result = new HashMap();
    for (MyData myData : myDataList) {
      result.put(myData.administrativeArea, myData.cases);
    }
    return result;
  }
  
  private class AdminArea implements Comparable<AdminArea> {
    private final String adminArea;
    private final Integer totalCases;
    private double percentageOfCasesAsDecimal;
    private float angle;
    
    AdminArea(final String adminArea, final Integer totalCases) {
      this.adminArea = adminArea;
      this.totalCases = totalCases;
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
        return this.getTotalCases().compareTo(o.getTotalCases());
    }
  }
}
