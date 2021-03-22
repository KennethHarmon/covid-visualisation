// Miguel Arrieta, Added FilterData class that includes methods for filtering data, 5pm, 22/3/2021
import java.util.Date;
import java.util.List;

public static final class FilterData {

  public static List<MyData> filterByDate(final Date searchDates, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.date.equals(searchDates)) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }

  public static List<MyData> filterByAdminArea(final String searchAdminArea, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.administrativeArea.equals(searchAdminArea)) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }

  public static List<MyData> filterByCounty(final String searchCounties, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.county.equals(searchCounties)) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }

  public static List<MyData> filterByGeoIdentifier(final String searchGeoIDS, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.geoIdentifier.equals(searchGeoIDS)) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }

  public static List<MyData> filterByCases(final int searchCases, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.cases == searchCases) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }

  public static List<MyData> filterByCountry(final String searchCountries, final List<MyData> myDataList) {
    final List<MyData> searchedData = new ArrayList();
    for (final MyData matchCheck : myDataList) {
      if (matchCheck.country.equals(searchCountries)) {
        searchedData.add(matchCheck);
      }
    }
    return searchedData;
  }
}
