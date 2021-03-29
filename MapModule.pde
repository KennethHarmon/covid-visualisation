//K.H Created MapModule from geomap library 25/03/2021
//K.H converted to subclass draw 26/03/2021
// M.A made the map scalable and started to set up a system for queries and made an outline for the text 29/03/2021
import org.gicentre.geomap.*;

class MapModule extends Module {

  GeoMap geoMap;
  HashMap<String, Integer> stateCaseNumbers;
  int mapMax;
  boolean hasDrawn;

  MapModule(int x, int y, int width, int height, HashMap<String, Integer> stateCaseNumbers) { 
    super(x, y, width, height);
    this.stateCaseNumbers = stateCaseNumbers;
    mapMax = 0;
    for (int mapCases : stateCaseNumbers.values()) {
      mapMax = max(mapMax, mapCases);
    }
    hasDrawn = false;
    scaleGeoMap();
  }

  private void scaleGeoMap() {
    this.geoMap = new GeoMap(MODULE_PADDING, MODULE_PADDING, wide - MODULE_PADDING * 2, tall - MODULE_PADDING * 2, GroupProject.this);
    geoMap.readFile("usContinental");
  }

  void subClassDraw() {
    stroke(0, 40);
    if (! hasDrawn) {
      for (int id : geoMap.getFeatures().keySet()) {
        String state = geoMap.getAttributeTable().findRow(str(id), 0).getString("Name");
        int stateCases = 0;
        try {
          stateCases = stateCaseNumbers.get(state);
        }
        catch (NullPointerException e) {
          //print(e.getMessage());
          stateCases = -1;
        }

        if (stateCases != -1) {
          float normStateCases = (float) stateCases / (float) mapMax;
          fill (lerpColor (minMapColour, maxMapColour, normStateCases));
        } else {
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
      fill(0);
      textSize(wide * tall / 8000); // 8000 seems to be the right ratio
      if (relativeMouseX > textWidth(name)) {
        textAlign(RIGHT);
      } else {
        textAlign(LEFT);
      }
      final float textXPos = relativeMouseX + 5;
      final float textYPos = relativeMouseY - 5;
      for (int x = -1; x < 2; x++) {        // This creates an outline for the text
        text(name, textXPos + x, textYPos);
        text(name, textXPos, textYPos + x);
      }
      fill(GLOBAL_BACKGROUND);
      text(name, textXPos, textYPos);
      textSize(13);
    }
  }

  void OnSizeUpdateEvent() {
    scaleGeoMap();
  }
}
