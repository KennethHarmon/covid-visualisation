//Kenneth Harmon: Created loading screen class 14/04/21
public class LoadingScreen {
  
  int barWidth;
  int barHeight;
  
  public LoadingScreen() {
    barWidth = width/4;
    barHeight = height/13;
  }
  
  void draw() {
    background(GLOBAL_BACKGROUND);
    fill(MODULE_COLOR);
    stroke(GREY);
    rect((width/8) * 3, height/2 - 40, barWidth, barHeight);
    fill(NAVY);
    noStroke();
    rect(((width/8) * 3) + 1, (height/2) - 39,  (float)(loadingPercent * (barWidth - 2)), barHeight - 2);
    fill(NAVY);
    textSize(32);
    outlineText("Loading...", width / 8 * 3, height / 2 + 40, NAVY, NAVY); // Makes it look bold
  }
}
