import java.util.LinkedList;
import java.util.List;
import java.util.Iterator;

// Miguel Arrieta, Added a PrintList class to print a list, 4pm, 24/03/2021
// Miguel Arrieta, fixed potential NullPointer, IndexOutOfBounds exceptions
// and error where it wouldn't delete the first Text in the list if the size was 1, 6pm, 24/03/2021
// Yi Ren, put the list into a module. 24/3/2021
class PrintList extends Module {
  private int yLimit;
  private int spacing = 15;
  private List<MyData> fullList;
  private List<Text> listToBePrinted;
  private Iterator printIterator;

  PrintList(int x, int y, int width, int height, final List<MyData> fullList, final int desiredListLength) {
    super(x, y, width, height);
    this.fullList = new ArrayList(fullList);
    this.yLimit = MODULE_PADDING*2;
    this.listToBePrinted = new LinkedList();
    printIterator = this.fullList.iterator();
    if (fullList.size() >= desiredListLength) {
      for (int i = 0; i < desiredListLength && printIterator.hasNext(); i++) {
        this.listToBePrinted.add(new Text(printIterator.next().toString(), width/2, yLimit + (i + 1) * spacing, false));
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
      if (printIterator.hasNext()) {
        listToBePrinted.add(new Text(printIterator.next().toString(), width/2, listToBePrinted.get(listToBePrinted.size() - 1).getY() + spacing, true));
      }
    }
  }

  private void fadeIn() {
    if (listToBePrinted.size() > 1) {
      Text lastText = listToBePrinted.get(listToBePrinted.size() - 1);
      if (lastText.getAlphaValue() < 255) {
        lastText.fadeIn();
      }
    }
  }

  void draw() {
    super.draw();
    translate(super.xOrigin,super.yOrigin);
    if (listToBePrinted.size() != 0) {
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
    translate(-super.xOrigin,-super.yOrigin);
  }
}
