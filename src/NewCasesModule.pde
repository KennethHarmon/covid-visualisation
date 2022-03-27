// made by Yi Ren on 24th of March. a class that extends module and shows the number of new cases in a certain area over a period of time.
public class NewCasesModule extends Module { 
  int cases;

  NewCasesModule(float x, float y, float wide, float tall, int cases) { 
    super(x, y, wide, tall);
    this.cases = cases;
  }

  @Override
    void subClassDraw() {
    fill(TEXT_COLOR);
    textAlign(CENTER, CENTER);
    final String text = "New Cases: " + formatText("##,###,###", cases);
    fittedText(text, wide, tall, int(tall/3));
    text(text, wide / 2, tall / 2);
  }
}
