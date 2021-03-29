//K.H Created MapModule from geomap library 25/03/2021
//K.H converted to subclass draw 26/03/2021
import org.gicentre.geomap.*;

class MapModule extends Module {

  GeoMap geoMap;
  HashMap<String, Integer> stateCaseNumbers;
  int mapMax;
  boolean hasDrawn;
  
  MapModule(int x, int y, int width, int height, GeoMap geoMap, HashMap<String, Integer> stateCaseNumbers) { 
    super(x, y, width, height);
    this.geoMap = geoMap;
    this.stateCaseNumbers = stateCaseNumbers;
    mapMax = 0;
    for (int mapCases : stateCaseNumbers.values()) {
      mapMax = max(mapMax, mapCases);
    }
    hasDrawn = false;
  }

  void subClassDraw() {
    stroke(0, 40);
    if (! hasDrawn) {
      for (int id : geoMap.getFeatures().keySet()) {
        String state = geoMap.getAttributeTable().findRow(str(id),0).getString("Name");
        int stateCases = 0;
        try {
          stateCases = stateCaseNumbers.get(state);
        }
        catch (NullPointerException e) {
          print(e.getMessage());
          stateCases = -1;
        }
        
        if (stateCases != -1) {
          float normStateCases = (float) stateCases / (float) mapMax;
          fill (lerpColor (minMapColour, maxMapColour, normStateCases));
        }
        else {
          fill(250);
        }
        geoMap.draw(id);
      }
    }
    
    final float relativeMouseX = map(mouseX, super.xOrigin, super.xOrigin + wide, 0, wide);
    final float relativeMouseY = map(mouseY, super.yOrigin, super.yOrigin + tall, 0, tall);
    int id = geoMap.getID(relativeMouseX, relativeMouseY);
    if (id != -1) {
      fill(NAVY);
      geoMap.draw(id);
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("Name");
      fill(GOLD);
      if (relativeMouseX > textWidth(name)) {
        textAlign(RIGHT);
      } else {
        textAlign(LEFT);
      }
      text(name, relativeMouseX + 5, relativeMouseY - 5);
    }
  }
  
}
