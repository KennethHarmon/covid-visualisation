// Miguel Arrieta, Added LoadData class that includes methods for loading in data, 7pm, 22/3/2021
// This is faster than loadStrings()
// M.A optimised imports, 06/04/2021
import java.io.FileReader;
import java.text.ParseException;

public static final class LoadData {

  // Parses all data. Throws a ParseException if the data doesn't meet the required format
  private static MyData parseData(final String row) throws ParseException {
    final String[] data = trim(row.split(",")); // Trim to deal with unnecessary spaces
    return new MyData(DATE_FORMAT.parse(data[0]), data[1], data[2], 
      data[3], Integer.parseInt(data[4]), data[5]);
  }

  // Loads all the data into a List of type MyData. Throws an IOException
  public static List<MyData> loadData(String dataPath) throws IOException {
    final BufferedReader bufferedReader = new BufferedReader(new FileReader(dataPath));
    //K.H Intialised the capactiy of the list with an adequate level.
    final List<MyData> myDataList = new ArrayList<MyData>(1124916);
    String row;
    bufferedReader.readLine(); // Skips the column titles
    while ((row = bufferedReader.readLine()) != null) {
      try {
        myDataList.add(parseData(row));
      } 
      catch (ParseException e) {
        e.printStackTrace();
      }
    }
    bufferedReader.close();
    return myDataList;
  }
}
