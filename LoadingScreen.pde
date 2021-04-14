public class LoadingScreen {
  
  int barWidth;
  int barHeight;
  
  public LoadingScreen() {
    barWidth = width/4;
    barHeight = height/13;
  }
  
  void draw() {
    background(GLOBAL_BACKGROUND);
    fill(GREY);
    rect((width/8) * 3, height/2, barWidth, barHeight);
    fill(NAVY);
    rect(((width/8) * 3) + 1, (height/2) + 1,  loadingPercent * barWidth, barHeight);
    textSize(32);
    outlineText("Loading...", width / 8 * 3, height / 2 + 80, NAVY, NAVY); // Makes it look bold
  }
}
