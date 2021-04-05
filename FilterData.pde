// Miguel Arrieta, Added FilterData class that includes methods for filtering data, 5pm, 22/3/2021
// Kenneth Harmon, added sampling classes to extract a specified number of entries for each query, sorted by most recent. 22/03/2021
// William Walsh-Dowd, added filters for min/max cases along with functions to get the min/max cases of a data set and the data point with the min/max cases. 23/3/2021
// Yi Ren, added a function to get the number of new cases in a certain area over a period of time. 24/3/2021
// William Walsh-Dowd, 30th of march added findNewCasesForCounty() method
import java.util.Date;
import java.util.Calendar;
import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;

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
      for (int i = myDataList.size()-1; i >= myDataList.size() - amount; i--) {
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

  public static int findNewCasesForCounty(final List<MyData> myDataList, String county, int amount) {
    List<MyData> newData = filterByCounty(county, myDataList);
    int newCases = 0;
    List<MyData> stateCasesData = FilterData.filterByCounty(county, newData);
    HashSet<String> AdminAreas = new HashSet<String>();
    for (MyData data : stateCasesData) {
      if (!isNameAlreadySaved(AdminAreas, data.administrativeArea)) {
        AdminAreas.add(data.administrativeArea);
      }
    }
    for (String adminArea : AdminAreas) {
      List<MyData> stateAdminAreaCasesData = FilterData.filterByAdminArea(adminArea, stateCasesData);
      if (stateAdminAreaCasesData != null && stateAdminAreaCasesData.size() >= amount+1) {
        newCases += stateAdminAreaCasesData.get(stateAdminAreaCasesData.size()-1).cases - stateAdminAreaCasesData.get(stateAdminAreaCasesData.size()-1-amount).cases;
      }
    }
    return newCases;
  }

  public static LinkedHashMap<Date, Integer> createStateCasesPerTime(String state, HashMap<String, List> stateCaseNumbers, List<MyData> myCompleteDataList) {
    LinkedHashMap<Date, Integer> casesPerTime = new LinkedHashMap<Date, Integer>();
    List<MyData> allStateEntriees = stateCaseNumbers.get(state);
    int casesForThisDay = 0;
    Date date = myCompleteDataList.get(myCompleteDataList.size() - 1).date;
    Date lastestDate = new Date(120, 0, 0);
    Calendar cal = Calendar.getInstance();
    cal.setTime(date);
    int daysToDecrement = -1;
    while (!date.equals(lastestDate)) {
      casesForThisDay = 0;
      if (allStateEntriees != null && filterByDate(date, allStateEntriees).size() > 0) {
        for (MyData data : filterByDate(date, allStateEntriees)) {
          casesForThisDay += data.cases;
        }
        casesPerTime.put(date, casesForThisDay);
      }
      cal.add(Calendar.DATE, daysToDecrement);
      date = cal.getTime();
    }
    return casesPerTime;
  }

  public static int[] LinkedHashMapToIntArray(LinkedHashMap<Date, Integer> stateCasesPerTime) {
    int[] newIntArray = new int[stateCasesPerTime.size()];
    int i = 0;
    for (Date date : stateCasesPerTime.keySet()) {
      newIntArray[newIntArray.length - i -1] = stateCasesPerTime.get(date);
      i++;
    }
    return newIntArray;
  }

  public static LinkedHashMap<Date, Integer> filterLinkedHashMapByDate(LinkedHashMap<Date, Integer> stateCasesPerTime, Date afterThisDate) {
    LinkedHashMap<Date, Integer> newArray = new LinkedHashMap<Date, Integer>();
    for (Date date : stateCasesPerTime.keySet()) {
      if (date.after(afterThisDate)) {
        newArray.put(date, stateCasesPerTime.get(date));
        println(date + " : " + stateCasesPerTime.get(date));
      }
    }
    return newArray;
  }

  public static int findNewCases(final List<MyData> myDataList, String area, int amount) {
    List<MyData> newData = sampleByAdminArea(area, myDataList, amount);
    int newCases = newData.get(newData.size()-1).cases - newData.get(0).cases;
    return newCases;
  }

  public static HashMap[] findCurrentStateCases(List<MyData> myCompleteDataList) {
    HashMap<String, Integer> stateCaseTotals = new HashMap<String, Integer>();
    HashMap<String, List> stateCaseNumbers = new HashMap<String, List>(); 
    for (String state : STATES) {
      List<MyData> stateCasesData = FilterData.filterByCounty(state, myCompleteDataList);
      stateCaseNumbers.put(state, stateCasesData);
      int stateCases = 0;
      HashSet<String> AdminAreas = new HashSet<String>();
      for (MyData data : stateCasesData) {
        if (!isNameAlreadySaved(AdminAreas, data.administrativeArea)) {
          AdminAreas.add(data.administrativeArea);
        }
      }
      for (String adminArea : AdminAreas) {
        List<MyData> stateAdminAreaCasesData = FilterData.filterByAdminArea(adminArea, stateCasesData);
        if (stateAdminAreaCasesData != null) {
          stateCases += stateAdminAreaCasesData.get(stateAdminAreaCasesData.size()-1).cases;
          stateCaseTotals.put(state, stateCases);
        }
      }
      //println(state + " : " + stateCases);
    }
    HashMap[] mapArray = {stateCaseTotals, stateCaseNumbers};
    return mapArray;
  }

  public static boolean isNameAlreadySaved(HashSet<String> data, String string) {
    return data.contains(string);
  }
}
