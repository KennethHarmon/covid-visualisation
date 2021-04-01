// William Walsh-Dowd created on 30th march, creates a screen with data from a spacific state.
class StateDataScreen extends Screen {
List<MyData> allStateEntriees;
String stateName;
NewCasesModule newCases2;
RadioButtonsModule radioButtons;

  StateDataScreen(String stateName) {
    this.stateName = stateName;
    this.allStateEntriees = stateCaseNumbers.get(stateName);
    radioButtons = new RadioButtonsModule(MODULE_PADDING, 2*MODULE_PADDING + (height - 4 * MODULE_PADDING) / 8, width - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) / 8, myCompleteDataList, stateName, 1, 7, 30);
    newCases2 = new NewCasesModule(width - MODULE_PADDING - (width - 4 * MODULE_PADDING) / 3, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, FilterData.findNewCasesForCounty(allStateEntriees, stateName,1));
    super.addModules(
      new CaseModule(MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateCaseTotals.get(stateName)), 
      new TextModule((width - 4 * MODULE_PADDING) / 3 + 2 * MODULE_PADDING, MODULE_PADDING, (width - 4 * MODULE_PADDING) / 3, (height - 4 * MODULE_PADDING) / 8, stateName), 
      new HistogramModule(MODULE_PADDING, 3 * MODULE_PADDING + 2 * (height - 4 * MODULE_PADDING) / 8, width - 2 * MODULE_PADDING, (height - 4 * MODULE_PADDING) * 6 / 8, FilterData.createStateCasesPerTime(stateName, stateCaseNumbers, myCompleteDataList), 5), 
      newCases2,
      radioButtons
      );
  }
  
  @Override
  void draw() {
    for (Module mod : moduleList) {
      mod.draw();
    }
    if(mousePressed){
      if(radioButtons.day != EVENT_NULL){
        newCases2.cases = FilterData.findNewCasesForCounty(allStateEntriees, stateName, radioButtons.day);
      }
    }
  }
}
