// Miguel Arrieta, Added a Text class to make it easier to print a list to the screen, 4pm, 24/03/2021
public class Text {
  private int alphaValue;
  private String string;
  private int x;
  private float y;

  Text(final String string, final int x, final float y, final boolean isTransparent) {
    this.string = string;
    this.x = x;
    this.y = y;
    this.alphaValue = (isTransparent) ? 0 : 255;
  }
  
  Text(final String string, final float y, final boolean isTransparent) {
    this(string, width / 2, y, isTransparent);
  }
  
  public void scrollText() {
    this.y -= 0.2;
  }

  public String getMyString() {
    return string;
  }

  public void setMyString(final String string) {
    this.string = string;
  }

  public int getX() {
    return x;
  }

  public void setX(final int x) {
    this.x = x;
  }

  public float getY() {
    return y;
  }

  public void setY(final float y) {
    this.y = y;
  }

  public void setText(final String string, final int x, final float y) {
    setMyString(string);
    setX(x);
    setY(y);
  }
  
  public int getAlphaValue() {
    return alphaValue;
  }
  
  public void fadeIn() {
    alphaValue += 10;
  }
  
  public void fadeOut() {
    alphaValue -= 10;
  }
  
  void draw() {
    textAlign(CENTER);
    fill(NAVY, alphaValue);
    text(string, x, y);
  }
}
