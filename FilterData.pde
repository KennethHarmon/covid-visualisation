// Miguel Arrieta, Added FilterData class that includes methods for filtering data, 5pm, 22/3/2021
// Kenneth Harmon, added sampling classes to extract a specified number of entries for each query, sorted by most recent. 22/03/2021
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

  public static List<MyData> sampleByDate(final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = new ArrayList(); 
    if (myDataList.size() > 0) {
      for (int i = myDataList.size()-1; i > myDataList.size() - amount; i--) {
        searchedData.add(myDataList.get(i));
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

  public static List<MyData> sampleByAdminArea(final String searchAdminArea, final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = sampleByDate(filterByAdminArea(searchAdminArea, myDataList), amount);
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

  public static List<MyData> sampleByCounty(final String searchCounty, final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = sampleByDate(filterByCounty(searchCounty, myDataList), amount);
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

  public static List<MyData> sampleByGeoIdentifier(final String searchGeoID, final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = sampleByDate(filterByGeoIdentifier(searchGeoID, myDataList), amount);
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

  public static List<MyData> sampleByCases(final int searchCases, final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = sampleByDate(filterByCases(searchCases, myDataList), amount);
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

  public static List<MyData> sampleByCountry(final String searchCountry, final List<MyData> myDataList, int amount) {
    final List<MyData> searchedData = sampleByDate(filterByCountry(searchCountry, myDataList), amount);
    return searchedData;
  }

  public static List<MyData> filterByMinCases(final List<MyData> myDataList, int minCases) {
    final List<MyData> newData = new ArrayList(); 
    if (myDataList.size() > 0) {
      for (final MyData currentData : myDataList) {
        if (currentData.cases >= minCases) { 
          newData.add(currentData);
        }
      }
    }
    return newData;
  }

  public static List<MyData> filterByMaxCases(final List<MyData> myDataList, int maxCases) {
    final List<MyData> newData = new ArrayList(); 
    if (myDataList.size() > 0) {
      for (final MyData currentData : myDataList) {
        if (currentData.cases <= maxCases) { 
          newData.add(currentData);
        }
      }
    }
    return newData;
  }

  public static int findHighestCaseCount(final List<MyData> myDataList) {
    int highestCases = 0;
    for (final MyData currentData : myDataList) {
      if (currentData.cases > highestCases) {
        highestCases = currentData.cases;
      }
    }
    return highestCases;
  }

  public static MyData findHighestCase(final List<MyData> myDataList) {
    MyData highestCase = myDataList.get(0);
    for (final MyData currentData : myDataList) {
      if (currentData.cases > highestCase.cases) {
        highestCase = currentData;
      }
    }
    return highestCase;
  }
  
  public static int findLowestCaseCount(final List<MyData> myDataList) {
    int highestCases = 0;
    for (final MyData currentData : myDataList) {
      if (currentData.cases < highestCases) {
        highestCases = currentData.cases;
      }
    }
    return highestCases;
  }

  public static MyData findLowestCase(final List<MyData> myDataList) {
    MyData highestCase = myDataList.get(0);
    for (final MyData currentData : myDataList) {
      if (currentData.cases < highestCase.cases) {
        highestCase = currentData;
      }
    }
    return highestCase;
  }
}
