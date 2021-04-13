// Miguel Arrieta, Added Data class for storing the data, 5pm, 22/3/2021
import java.text.SimpleDateFormat;
import java.util.Date;

public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

/*  A class to store data.
It has attributes for the: Date, Administrative Area, County, Geo Identifier, cases and Country.
*/
public static class MyData {
  public final Date date;
  public final String administrativeArea;
  public final String county;
  public final String geoIdentifier;
  public final int cases;
  public final String country;

  public MyData(final Date date, final String administrativeArea, final String county, final String geoIdentifier, 
    final int cases, final String country) {
    this.date = date;
    this.administrativeArea = administrativeArea;
    this.county = county;
    this.geoIdentifier = geoIdentifier;
    this.cases = cases;
    this.country = country;
  }

  @Override
    public String toString() {
    return String.format("Date: \"%s\" Administrative Area: \"%s\" County: \"%s\"" +
      " Geo identifier: \"%s\" cases: %d country: \"%s\"", 
      DATE_FORMAT.format(date), administrativeArea, county, geoIdentifier, cases, country);
  }
}
