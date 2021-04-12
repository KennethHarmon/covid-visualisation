public class Screen {
  List<Module> moduleList;

  Screen() {
    moduleList = new ArrayList<Module>();
  }

  int getEvent() {
    for (int i = 0; i < moduleList.size(); i++) {
      if (moduleList.get(i).isClicked()) {
        return i;
      }
    }
    return -1;
  }

  void addModules(Module ...newModules) {
    for (Module newModule : newModules) {
      moduleList.add(newModule);
    }
  }

  void draw() {
    for (Module mod : moduleList) {
      mod.draw();
    }
  }
}
