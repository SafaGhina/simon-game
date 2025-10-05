// Last Edited: April 14th, 2025 at 12:00 PM
/* base code for one individual button */

public class Button {
  private static final color simonColor = #222222;
  //private static int missedAttempts = 0;
  
  private int quadrant;
  private color btnColor;
  
  // methods
  //public static void incrementMisses() {
  //  missedAttempts++;
  //}
  
  //public static int getMisses() {
  //  return missedAttempts;
  //}
  
  //public static void resetMisses() {
  //  missedAttempts = 0;
  //}
  
  void drawBtn() {
    pushMatrix();
    translate(250, 250);
    rotate(-HALF_PI*(this.quadrant + 1));
    translate(-250, -250);
    fill(this.btnColor);
    arc(250, 250, 380, 380, 0, HALF_PI);
    fill(simonColor);
    arc(250, 250, 180, 180, 0, HALF_PI);
    popMatrix();
  }
  
  boolean btnIsClicked() {
    if (get(mouseX, mouseY) == this.btnColor) {
      return true;
    }
    return false;
  }
  
  // constructors
  Button(int quadrant, color btnColor) {
    this.quadrant = quadrant;
    this.btnColor = btnColor;
  }
  
  // accessors (getters)
  color getBtnColor() {
    return this.btnColor;
  }

  // mutators (setters)
  void setBtnColor(color newBtnColor) {
    this.btnColor = newBtnColor;
  }
}
