// M.A made a search bar module for taking queries, 31/03/2021
// M.A made slight improvements to the search bar, including not adding spaces when the length of the sb is 0, trimming the return String in sendText() and adjusting the size of the text, 01, 04, 2021
public class SearchBarModule extends Module {
  private StringBuilder text = new StringBuilder();
  private String textAsString;
  private float leftLimit;
  private float rightLimit;

  SearchBarModule(float xOrigin, float yOrigin, float wide, float tall) {
    super(xOrigin, yOrigin, wide, tall);
    this.adjustLimits();
  }

  public String sendText() {
    text.setLength(0);
    return textAsString.trim();
  }

  private void setTextAsString() {
    this.textAsString = text.toString();
  }

  @Override
    void draw() {

    fill(MODULE_COLOR);
    strokeWeight(3);
    stroke(230);

    pushMatrix();
    translate(xOrigin, yOrigin);
    fill(MODULE_COLOR);
    rect(0, 0, wide, tall, wide / 2); // The radius gives it a curved look

    fill(GLOBAL_BACKGROUND);
    textAlign(LEFT, CENTER);
    setTextAsString(); // Converting to String 
    outlineText(textAsString + ((frameCount >> 5 & 1) == 0 ? "_" : ""), leftLimit, tall / 2, 0, GLOBAL_BACKGROUND); // Drawing the text to the screen with a blinking underscore
    popMatrix();

    positionAndSizeUpdater();
  }

  private void adjustLimits() {
    this.leftLimit = wide / 12;
    this.rightLimit = 6.5 * wide / 8;
    fittedText(STATES[8], rightLimit - leftLimit, tall, 0); // Sets text size
  }

  @Override
  void OnSizeUpdateEvent() {
    this.adjustLimits();
  }

  public boolean isKeyPressed() { // Boolean method so that I can use this with sendText()
    if (keyCode == (int) BACKSPACE) {
      this.backspace();
    } else if (keyCode == 32 && text.length() > 0) { // Space character
      this.addText(' ');
    } else if (keyCode == (int) ENTER) {
      return true;
    } else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z') || (key >= '0' && key <= '9')) {
      this.addText(key);
    }
    return false;
  }

  private void addText(char character) {
    // If the text width is in the boundaries of the box then it is added
    if (textWidth(this.textAsString + character) < this.rightLimit) {
      text.append(character);
    }
  }

  private void backspace() {
    if (text.length() > 0) { // Checking that it's not empty 
      text.deleteCharAt(text.length() - 1);
    }
  }
}
