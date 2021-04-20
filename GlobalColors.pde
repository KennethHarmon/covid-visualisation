//Kenneth Harmon: Created GlobalColors Class to more easily keep track of colors
public final color GLOBAL_BACKGROUND = color(241,243,245);
public final color MODULE_COLOR = color(248,249,250);
public final color RED = color(255, 0, 0);
public final color GLOBAL_MODULE_STROKE = color(222,226,230);
public final color NAVY = color(24,100,171);
public final color LIGHT_BLUE = color(208,235,255);
public final color BLACK = color(0);
public final color GREY = color(206,212,218);
public final color WHITE = color(255);
public final color TEXT_COLOR = color(90,90,90); 
public final color BAR_COLOR = color(75,136,192);
public final color minMapColour = color(231,245,255);   // Light blue
public final color maxMapColour = NAVY;    // Dark blue.

// M.A Made a method to outline text 30/03/2021
/*  
 Outputs a String as an outlined text in the given position. The inner text color and outline color can be chosen.
 The textAlign() method can be called before calling this method for aligning the text.
 */
public void outlineText(String name, float textXPos, float textYPos, color outlineColor, color innerTextColor) {
  fill(outlineColor);
  for (int x = -1; x < 2; x++) {        // This creates an outline for the text
    text(name, textXPos + x, textYPos);
    text(name, textXPos, textYPos + x);
  }
  fill(innerTextColor);
  text(name, textXPos, textYPos);
}
