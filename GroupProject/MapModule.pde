//K.H Created MapModule from geomap library 25/03/2021
//K.H converted to subclass draw 26/03/2021
// M.A made the map scalable and started to set up a system for queries and made an outline for the text 29/03/2021
// M.A fixed top text scaling for map
import org.gicentre.geomap.*;

class MapModule extends Module {

  GeoMap geoMap;
  HashMap<String, Integer> stateCaseNumbers;
  int mapMax;
  boolean hasDrawn;

  MapModule(int x, int y, int wide, int tall, HashMap<String, Integer> stateCaseNumbers) { 
    super(x, y, wide, tall);
    this.stateCaseNumbers = stateCaseNumbers;
    mapMax = 0;
    for (int mapCases : stateCaseNumbers.values()) {
      mapMax = max(mapMax, mapCases);
    }
    hasDrawn = false;
    scaleGeoMap();
  }

  private void scaleGeoMap() {
    this.geoMap = new GeoMap(MODULE_PADDING*2, MODULE_PADDING*2, wide - MODULE_PADDING * 4, tall - MODULE_PADDING * 4, GroupProject.this);
    geoMap.readFile("usContinental");
  }

  void subClassDraw() {
    stroke(0, 40);
    //Initial calculation
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

    //Highlighting
    final int relativeMouseX = mouseX - (int) super.xOrigin;
    final int relativeMouseY = mouseY - (int) super.yOrigin;
    int id = geoMap.getID(relativeMouseX, relativeMouseY);
    if (id != -1) {
      fill(NAVY);
      geoMap.draw(id);
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("Name");
      textSize(wide * tall / 8000); // 8000 seems to be the right ratio
      if (relativeMouseX > textWidth(name)) {
        textAlign(RIGHT);
      } else {
        textAlign(LEFT);
      }
      outlineText(name, relativeMouseX + 5, relativeMouseY - 5, 0, GLOBAL_BACKGROUND);
    }

    // Top Text
    float topTextSize = wide * tall / 9000;
    int textLimitter = 27;
    if (topTextSize > textLimitter) { // Setting the text size limit to 22
      textSize(textLimitter);
    } else {
      textSize(topTextSize);
    }
    textAlign(CENTER, TOP);
    outlineText("Total Covid Cases Per State", wide / 2, 2, 0, MODULE_COLOR);

    //Scale
    topTextSize = wide * tall / 12000;
    textLimitter = 8;
    if (topTextSize > textLimitter) { // Setting the text size limit to 22
      textSize(textLimitter);
    } else {
      textSize(topTextSize);
    }
    textAlign(CENTER, BOTTOM);
    fill(0);
    int x1 = MODULE_PADDING;
    int y1 = (int) tall - (2 * MODULE_PADDING);
    float x2 = wide / 4;
    //line(x1, y1, );
    text("0" + "\n |", MODULE_PADDING, y1);
    text(mapMax / 2 + "\n |", MODULE_PADDING + (wide / 8), y1);
    text(mapMax + "\n |", x2, y1);
    stroke(0);
    strokeWeight(1);
    rect(x1 - 1, y1 - 1, x2 + 2, (tall / 18) + 2);
    setGradient(x1, y1, x2, tall / 18, minMapColour, maxMapColour, X_AXIS);
    textSize(13);
  }

  void OnSizeUpdateEvent() {
    scaleGeoMap();
  }

  //Taken from Processing docs
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
    noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}