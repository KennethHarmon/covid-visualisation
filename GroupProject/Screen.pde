//Created by Kenneth Harmon, a screen class based on our previous work in the module. Each screen is simply a collection of modules which are drawn.
public class Screen {
  public final List<Module> moduleList;

  Screen() {
    moduleList = new ArrayList();
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
