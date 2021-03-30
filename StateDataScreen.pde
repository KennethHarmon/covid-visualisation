// William Walsh-Dowd created on 30th march, creates a screen with data from a spacific state.
class StateDataScreen extends Screen {

  StateDataScreen(String stateName) {
    List<MyData> allStateEntriees = stateCaseNumbers.get(stateName);
    super.addModules(
      new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateCaseTotals.get(stateName)), 
      new TextModule(width/2-(width - 4 * MODULE_PADDING) / 6, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateName), 
      new HistogramModule(MODULE_PADDING, 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, (width - 3 * MODULE_PADDING) + MODULE_PADDING, height - ( 2 * MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8) - MODULE_PADDING, FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList), 5), 
      new NewCasesModule(width- (width/2-(width - 4 * MODULE_PADDING) / 6) + MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, FilterData.findNewCasesForCounty(allStateEntriees, stateName))
      );
  }
}
