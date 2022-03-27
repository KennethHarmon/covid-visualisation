// William Walsh-Dowd created on 30th march, creates a screen with data from a spacific state.
// Yi Ren implemented the radioButtonModule in this screen.
// M.A implemented the pieChartModule within this Screen, 04/04/2021
// M.A fixed error screen. 06/04/2021
// M.A made it so that the pieChartModule can interact with the radio buttons, 13/04/2021
public class StateDataScreen extends Screen {
  List<MyData> allStateEntries;
  String stateName;
  NewCasesModule newCases2;
  RadioButtonsModule radioButtons;

  StateDataScreen(String stateName) {
    this.stateName = stateName;
    this.allStateEntries = stateCaseNumbers.get(stateName);
    int duration = FilterData.calculateDuration(stateName, stateCaseNumbers);
    radioButtons = new RadioButtonsModule(MODULE_PADDING, 2*MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, width - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) / 8, myCompleteDataList, 2, stateName, 3, 1, 7, 30, duration); //The buttons are first set to "All Time".
    newCases2 = new NewCasesModule(width - MODULE_PADDING - (width - 4 * MODULE_PADDING) / 3, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, FilterData.findNewCasesForCounty(allStateEntries, stateName, duration));
    try {
      super.addModules(
        new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateCaseTotals.get(stateName)), 
        new TextModule((width - 4 * MODULE_PADDING) / 3 + 2 * MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateName, TEXT_COLOR), 
        new HistogramModule(MODULE_PADDING * 2 + width / 3 - 2 * MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 * 2 - MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList), 5), 
        newCases2, 
        radioButtons, 
        new PieChartModule(MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, stateName, stateCaseNumbers.get(stateName))
        );
    } 
    catch (Exception ignored) {
      super.addModules(new TextModule(MODULE_PADDING + width / 5, MODULE_PADDING + height / 5, width / 5 * 3 - 2 * MODULE_PADDING, height / 5 * 3 - 2 * MODULE_PADDING, "Not enough data for " + stateName, RED));
    }
  }

  @Override
    void draw() {
    for (Module mod : super.moduleList) {
      mod.draw();
    }
    if (mousePressed) {
      if (radioButtons.day != EVENT_NULL) {
        // M.A made it so that this data is cached in case it needs to be accessed again, 13/04/2021
        List<MyData> stateAdminAreas;
        List<MyData> stateAdminAreasForGraph =  new ArrayList<MyData>();
        HashMap<String, List> stateAdminAreaCasesDayGraph = new HashMap<String, List>();
        List<MyGraphData> GraphDataList = new ArrayList<MyGraphData>();
        switch (radioButtons.day) {
        case 1:
          stateAdminAreas = stateAdminAreaCasesDay.get(this.stateName);
          if (stateAdminAreas == null) {
            stateAdminAreas = FilterData.findCasesInListAfterDate(myCompleteDataList, this.stateName, radioButtons.day);
            stateAdminAreaCasesDay.put(this.stateName, stateAdminAreas);
            
          }
          stateAdminAreasForGraph = FilterData.findCasesInListAfterDate(myCompleteDataList, this.stateName, radioButtons.day + 1);
          stateAdminAreaCasesDayGraph.put(this.stateName, stateAdminAreasForGraph);
          GraphDataList = FilterData.createStateCasesPerTime(this.stateName, stateAdminAreaCasesDayGraph, stateAdminAreas);
          break;

        case 7:
          stateAdminAreas = stateAdminAreaCases7.get(this.stateName);
         // GraphDataList = FilterData.filterMyGraphDataListByDate(FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList), radioButtons.day);
          if (stateAdminAreas == null) {
            stateAdminAreas = FilterData.findCasesInListAfterDate(myCompleteDataList, this.stateName, radioButtons.day);
            stateAdminAreaCases7.put(this.stateName, stateAdminAreas);
          }
          GraphDataList = FilterData.createStateCasesPerTime(this.stateName, stateAdminAreaCases7, stateAdminAreas);
          break;

        case 30:
          stateAdminAreas = stateAdminAreaCases30.get(this.stateName);
         // GraphDataList = FilterData.filterMyGraphDataListByDate(FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList), radioButtons.day);
          if (stateAdminAreas == null) {
            stateAdminAreas = FilterData.findCasesInListAfterDate(myCompleteDataList, this.stateName, radioButtons.day);
            stateAdminAreaCases30.put(this.stateName, stateAdminAreas);
          }
          GraphDataList = FilterData.createStateCasesPerTime(this.stateName, stateAdminAreaCases30, stateAdminAreas);
          break;

        default:
          stateAdminAreas = stateCaseNumbers.get(stateName);
          GraphDataList = FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, stateAdminAreas);
        }
        PieChartModule pieChart = new PieChartModule(MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, stateName, stateAdminAreas);
        HistogramModule graph = new HistogramModule(MODULE_PADDING * 2 + width / 3 - 2 * MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width / 3 * 2 - MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, GraphDataList, 5);
        super.moduleList.set(super.moduleList.size()-1, pieChart);
        super.moduleList.set(super.moduleList.size()-4, graph);
        // As to not calculate it twice
        newCases2.cases = pieChart.getTotalStateCases();
      }
    }
  }
}
