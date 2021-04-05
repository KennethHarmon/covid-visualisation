public final color MODULE_COLOR = color(255);
public final color GLOBAL_BACKGROUND = color(242, 248, 250);
public final color RED = color(255, 0, 0);
public final color GLOBAL_MODULE_STROKE = color(230);
public final color NAVY = color(0, 0, 128);
public final color BLACK = color(0);
public final color GOLD = color(249, 166, 2);
public final color GREY = color(240);
public final color SKY_BLUE = color(135, 206, 235);
public final color TURQUIOSE = color(0, 162, 207);
public final color minMapColour = color(222, 235, 247);   // Light blue
public final color maxMapColour = color(0, 41, 149);    // Dark blue.

// M.A Made a method to outline text 30/03/2021
public void outlineText(String name, float textXPos, float textYPos, color outlineColor, color innerTextColor) {
  fill(outlineColor);
  for (int x = -1; x < 2; x++) {        // This creates an outline for the text
    text(name, textXPos + x, textYPos);
    text(name, textXPos, textYPos + x);
  }
  fill(innerTextColor);
  text(name, textXPos, textYPos);
}
