
// Miguel Arrieta, Added a PrintList class to print a list, 4pm, 24/03/2021
// Miguel Arrieta, fixed potential NullPointer, IndexOutOfBounds exceptions
// and error where it wouldn't delete the first Text in the list if the size was 1, 6pm, 24/03/2021
// Yi Ren, put the list into a module. 24/3/2021
public class PrintList extends Module {
  private int spacing = 15;
  private int yUpperLimit = spacing;
  private List<MyData> fullList;
  private LinkedList<Text> listToBePrinted;
  private Iterator printIterator;

  PrintList(int x, int y, int wide, int tall, final List<MyData> fullList, final int desiredListLength) {
    super(x, y, wide, tall);
    this.fullList = new ArrayList(fullList);
    this.listToBePrinted = new LinkedList();
    printIterator = this.fullList.iterator();
    if (fullList.size() >= desiredListLength) {
      for (int i = 0; i < desiredListLength && printIterator.hasNext(); i++) {
        this.listToBePrinted.add(new Text(printIterator.next().toString(), (int) wide/2, yUpperLimit + (i + 1) * spacing, false));
      }
    } else {
      println("PrintList initialisation unsuccessful");
    }
  }

  public void printToConsole() {
    for (Text t : listToBePrinted) {
      println(t.getMyString());
    }
    println();
  }

  private boolean reachedLimit() {
    return listToBePrinted.getFirst().getY() <= yUpperLimit;
  }

  private void removeAndAddFromList() {
    if (listToBePrinted.getFirst().getAlphaValue() <= 0) {
      listToBePrinted.removeFirst();
      if (printIterator.hasNext()) {
        listToBePrinted.add(new Text(printIterator.next().toString(), (int) wide/2, listToBePrinted.get(listToBePrinted.size() - 1).getY() + spacing, true));
      }
    }
  }

  private void fadeIn() {
    if (listToBePrinted.size() > 1) {
      Text lastText = listToBePrinted.getLast();
      if (lastText.getAlphaValue() < 255) {
        lastText.fadeIn();
      }
    }
  }

  void subClassDraw() {
    if (listToBePrinted.size() != 0) {
      for (Text t : listToBePrinted) {
        t.draw();
        t.scrollText();
      }
      if (reachedLimit()) {
        listToBePrinted.getFirst().fadeOut();
      }
      this.fadeIn();
      removeAndAddFromList();
    }
  }
}
