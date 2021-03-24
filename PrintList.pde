import java.util.LinkedList;
import java.util.List;
import java.util.Iterator;

// Miguel Arrieta, Added a PrintList class to print a list, 4pm, 24/03/2021
class PrintList {
  private int yLimit = height / 2;
  private int spacing = 15;
  private List<MyData> fullList;
  private List<Text> listToBePrinted;
  private Iterator printIterator;

  PrintList(final List<MyData> fullList, final int desiredListLength) {
    this.fullList = new ArrayList(fullList);
    this.listToBePrinted = new LinkedList();
    printIterator = this.fullList.iterator();
    if (fullList.size() >= desiredListLength) {
      for (int i = 0; i < desiredListLength && printIterator.hasNext(); i++) {
        this.listToBePrinted.add(new Text(printIterator.next().toString(), yLimit + ((i + 1) * spacing), false));
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
    return listToBePrinted.get(0).getY() <= yLimit;
  }

  private void removeAndAddFromList() {
    if (listToBePrinted.get(0).getAlphaValue() <= 0) {
      listToBePrinted.remove(0);
      listToBePrinted.add(new Text(printIterator.next().toString(), listToBePrinted.get(listToBePrinted.size() - 1).getY() + spacing, true));
    }
  }
  
  private void fadeIn() {
    Text lastText = listToBePrinted.get(listToBePrinted.size() - 1);
    if (lastText.getAlphaValue() < 255) {
      lastText.fadeIn();
    }
  }

  void draw() {
    for (Text t : listToBePrinted) {
      t.draw();
      t.scrollText();
    }
    if (reachedLimit()) {
      listToBePrinted.get(0).fadeOut();
    }
    this.fadeIn();
    removeAndAddFromList();
  }
}
