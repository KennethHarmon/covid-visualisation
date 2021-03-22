// Miguel Arrieta, Added Data class for storing the data, 5pm, 22/3/2021
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");

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

  public static List<MyData> loadData(final String[] rows) {
    final List<MyData> myDataList = new ArrayList(rows.length);
    for (final String row : rows) {
      try {
        myDataList.add(parseData(row));
      } catch (ParseException e) {
        e.printStackTrace(); // Will throw an exception at the start for the titles
      } catch (RuntimeException e) {
        e.printStackTrace();
      }
    }
    return myDataList;
  }

  private static MyData parseData(final String row) throws ParseException {
    final String[] data = trim(row.split(",")); // Trim to deal with unnecessary spaces
    return new MyData(DATE_FORMAT.parse(data[0]), data[1], data[2], 
      data[3], Integer.parseInt(data[4]), data[5]);
  }
  
  @Override
    public String toString() {
    return String.format("Date: \"%s\" Administrative Area: \"%s\" County: \"%s\"" +
      " Geo identifier: \"%s\" cases: %d country: \"%s\"", 
      DATE_FORMAT.format(date), administrativeArea, county, geoIdentifier, cases, country);
  }
}
