//K.H Created MapModule from geomap library 25/03/2021
//K.H converted to subclass draw 26/03/2021
import org.gicentre.geomap.*;

class MapModule extends Module {

  GeoMap geoMap;

  MapModule(int x, int y, int wide, int tall, GeoMap geoMap) { 
    super(x, y, wide, tall);
    this.geoMap = geoMap;
  }

  void subClassDraw() {
    fill(SKY_BLUE);
    stroke(0, 40);
    geoMap.draw();
    final float relativeMouseX = map(mouseX, super.xOrigin, super.xOrigin + wide, 0, wide);
    final float relativeMouseY = map(mouseY, super.yOrigin, super.yOrigin + tall, 0, tall);
    int id = geoMap.getID(relativeMouseX, relativeMouseY);
    if (id != -1) {
      fill(NAVY);
      geoMap.draw(id);
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("State_Name");
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
