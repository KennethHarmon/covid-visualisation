// Miguel Arrieta, Added a Text class to make it easier to print a list to the screen, 4pm, 24/03/2021
public class Text {
  // Miguel Arrieta, Linked the fade offset to the scroll speed, 5pm,24/03/21
  private static final float SCROLL_SPEED = 0.2;
  private static final int FADE_OFFSET = (int) (SCROLL_SPEED * 50);
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
    this.y -= SCROLL_SPEED;
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
    alphaValue += FADE_OFFSET;
  }

  public void fadeOut() {
    alphaValue -= FADE_OFFSET;
  }

  void draw() {
    textAlign(CENTER);
    fill(NAVY, alphaValue);
    text(string, x, y);
  }
}
