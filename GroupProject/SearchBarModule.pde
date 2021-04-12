// M.A made a search bar module for taking queries, 31/03/2021
// M.A made slight improvements to the search bar, including not adding spaces when the length of the sb is 0, trimming the return String in sendText() and adjusting the size of the text, 01/04/2021
// M.A made it so the module takes queries and handled errors for it, 01/04/2021
public class SearchBarModule extends Module {
  private StringBuilder text = new StringBuilder();
  private String textAsString;
  private float leftLimit;
  private float rightLimit;
  private boolean error;

  /*  Allows a user to search for a state using their keyboard.
   If the user types in an invalid input they are told so.
   If they hit enter after getting an error the error message goes away.
   Alternatively if they start typing when the error message appears 
   the error message will get changed for whatever the user types
   */
  SearchBarModule(float xOrigin, float yOrigin, float wide, float tall) {
    super(xOrigin, yOrigin, wide, tall);
    this.adjustLimits();
    this.error = false;
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

    textAlign(LEFT, CENTER);
    setTextAsString(); // Converting to String 
    this.adjustLimits();
    outlineText(textAsString + ((frameCount >> 5 & 1) == 0 && !error ? "_" : ""), leftLimit, tall / 2, 0, (error) ? RED : MODULE_COLOR); // Drawing the text to the screen with a blinking underscore
    popMatrix();

    positionAndSizeUpdater();
  }

  private void adjustLimits() {
    this.leftLimit = wide / 12;
    this.rightLimit = 6.5 * wide / 8;
    fittedText(STATES[8], rightLimit - leftLimit, tall, 0); // Sets text size
  }

  public void isKeyPressed() { // Boolean method so that I can use this with sendText()
    if (keyCode == (int) BACKSPACE) {
      this.backspace();
    } else if (keyCode == 32 && text.length() > 0) { // Space character
      this.addText(' ');
    } else if (keyCode == (int) ENTER) {
      this.sendState();
    } else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z') || (key >= '0' && key <= '9')) {
      this.addText(key);
    }
  }

  private void addText(char character) {
    // If the text width is in the boundaries of the box then it is added
    this.checkError();
    if (textWidth(this.textAsString + character) < this.rightLimit) {
      text.append(character);
    }
  }

  private boolean checkError() {
    if (error) {
      text.setLength(0);
      error = false;
      return true;
    }
    return false;
  }

  private void backspace() {
    if (text.length() > 0 && !this.checkError()) { // Checking that it's not empty 
      text.deleteCharAt(text.length() - 1);
    }
  }

  private void sendState() {
    String textToBeSent = checkState(sendText());
    if (textToBeSent != null) {
      currentScreen = new StateDataScreen(textToBeSent);
    } else {
      text.append("Not a valid state");
      this.error = true;
    }
  }

  private String checkState(String stateToBeChecked) {
    for (String s : STATES) {
      if (s.equalsIgnoreCase(stateToBeChecked)) {
        return s;
      }
    }
    return null;
  }
}
