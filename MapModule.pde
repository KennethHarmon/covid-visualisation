//K.H Created MapModule from geomap library 25/03/2021
//K.H converted to subclass draw 26/03/2021
import org.gicentre.geomap.*;

class MapModule extends Module {
  
  GeoMap geoMap;
  
  MapModule(int x, int y, int width, int height, GeoMap geoMap) { 
    super(x, y, width, height);
    this.geoMap = geoMap;
  }
  
  void subClassDraw() {
    geoMap.draw();
  }
}
