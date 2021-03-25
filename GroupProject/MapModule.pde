import org.gicentre.geomap.*;

class MapModule extends Module {
  
  GeoMap geoMap;
  
  MapModule(int x, int y, int width, int height, GeoMap geoMap) { 
    super(x, y, width, height);
    this.geoMap = geoMap;
  }
  
  void draw() {
    super.draw();
    translate(super.xOrigin,super.yOrigin);
    geoMap.draw();
    translate(-super.xOrigin,-super.yOrigin);
  }
}
