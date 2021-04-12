// William Walsh-Dowd created on 30th march, creates a screen with data from a spacific state.
// M.A implemented the pieChartModule within this Screen, 04/04/2021
// M.A fixed error screen. 06/04/2021
public class StateDataScreen extends Screen {
  List<MyData> allStateEntriees;
  String stateName;
  NewCasesModule newCases2;
  RadioButtonsModule radioButtons;

  StateDataScreen(String stateName) {
    this.stateName = stateName;
    this.allStateEntriees = stateCaseNumbers.get(stateName);
    radioButtons = new RadioButtonsModule(MODULE_PADDING, 2*MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, width - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) / 8, myCompleteDataList, 2, stateName, 1, 1, 7, 30);
    newCases2 = new NewCasesModule(width - MODULE_PADDING - (width - 4 * MODULE_PADDING) / 3, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, FilterData.findNewCasesForCounty(allStateEntriees, stateName, 7));
    try {
      super.addModules(
        new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateCaseTotals.get(stateName)), 
        new TextModule((width - 4 * MODULE_PADDING) / 3 + 2 * MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateName, MODULE_COLOR), 
        new HistogramModule(MODULE_PADDING * 2 + width / 3 - 2 * MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 * 2 - MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, FilterData.linkedHashMapToIntArray(FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList)), 5), 
        newCases2, 
        radioButtons, 
        new PieChartModule(MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, stateName)
        );
    } 
    catch (Exception e) {
      println("Not enough data for " + stateName);
      super.addModules(new TextModule(MODULE_PADDING + width / 5, MODULE_PADDING + height / 5, width / 5 * 3 - 2 * MODULE_PADDING, height / 5 * 3 - 2 * MODULE_PADDING, "Not enough data for " + stateName, RED));
    }
  }

  @Override
    void draw() {
    for (Module mod : moduleList) {
      mod.draw();
    }
    if (mousePressed) {
      println(radioButtons.day);
      if (radioButtons.day != EVENT_NULL) {
        newCases2.cases = FilterData.findNewCasesForCounty(allStateEntriees, stateName, radioButtons.day);
      }
    }
  }
}
