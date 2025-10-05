// Name: Safa Ghazi
// ICS 4U1
// Last Edited: April 14th, 2025 at 12:08 PM
/* Online Simon game in Java Processing. Four button options, user has to re-click the blinks
   in correct order. saves score as well as highest score and number of missed attempts. */

Button btn;

// button stuff
final color[][] btnColors = {{#800000, #4169E1, #228B22, #ffd900}, {#d40202, #7294fc, #32e632, #ffff14}};
byte[] buttonOnOff = {0, 0, 0, 0};
Object[] objBtns = new Object[buttonOnOff.length];

// game logic
int[] sequence = new int[1000]; // flashes sequence
int sequenceStep = 0;
boolean showSequence = false;
int sequenceIndex = 0;
int flashDuration = 550; // length of one flash
int pauseBetweenFlashes = 300; // length between each flash
boolean flashing = false;
int flashStartTime = 0; // start time for each flash
int playerIndex = 0;
boolean playerTurn = false; // turns true when it is player's turn to guess

int score = 0;
int highScore = 0;

void setup() {
  size(500, 530);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  
  initializeGame();
}

void draw() {
  background(#555555);
  if (showSequence) updateSequence();
  drawBoard();
  
  textSize(25);
  text("High Score: " + highScore, width - 110, height - 60);
  text("Score: " + score, width - 85, height - 30);
  // text("Misses: " + Button.getMisses(), 80, height - 30) // with static variable, could display number of missed attempts the user made
}

void initializeGame() {
  sequenceStep = 1; // start sequence
  sequenceIndex = 0;
  sequence[0] = (int) random(4); // randomly decide first step of sequence
  showSequence = true;
  flashStartTime = millis();
  flashing = false;
  playerIndex = 0;
  playerTurn = false;
  
  if (score > highScore) highScore = score;
  score = 0;
  // Button.resetMisses();
}

void updateSequence() {
  if (sequenceIndex >= sequenceStep) {
    showSequence = false;
    playerTurn = true;
    playerIndex = 0;
    return;
  }
  
  int btn = sequence[sequenceIndex]; // flashing button
  
  if (!flashing && millis() - flashStartTime > pauseBetweenFlashes) { // flash button after wait
    buttonOnOff[btn] = 1; // turn on flash
    flashing = true;
    flashStartTime = millis(); // new start time for next flash
  } else if (flashing && millis() - flashStartTime > flashDuration) { // turn off the flash once duration ends
    buttonOnOff[btn] = 0; // turn off button
    flashing = false;
    flashStartTime = millis(); // new start time
    sequenceIndex++;
  }
}

void drawBoard() {
  // main board
  stroke(#000000);
  fill(Button.simonColor);
  ellipse(250, 250, 400, 400);
  
  // button
  for (int i = 0; i < 4; i++) {
    btn = new Button(i, btnColors[buttonOnOff[i]][i]);
    objBtns[i] = btn;
    btn.drawBtn();
  }
  
  // create button shape
  fill(Button.simonColor);
  stroke(Button.simonColor);
  rect(250, 250, 25, 380);
  rect(250, 250, 380, 25);
  
  // game title
  drawSimonText();
}

void drawSimonText() {
  fill(#FFFFFF);
  textSize(32);
  text("SIMON", 250, 250);
}

void mousePressed() {
  if (!playerTurn) return;
  
  for (int i = 0; i < objBtns.length; i++) {
    Button currentBtn = ((Button) objBtns[i]);
    
    if (currentBtn.btnIsClicked()) {
      buttonOnOff[i] = 1;
      
      if (i == sequence[playerIndex]) {
        playerIndex++;
        if (playerIndex == sequenceStep) {
          sequenceStep++; // next step in sequence
          sequence[sequenceStep - 1] = (int) random(4); // create next flash
          sequenceIndex = 0;
          flashing = false;
          score++;
          playerTurn = false; // end player's turn
          showSequence = true; // game continues
          flashStartTime = millis(); // set next flash new start time
        }
      } else {
        initializeGame(); // restart game
        // Button.incrementMisses();
      }
    }
  }
}
void mouseReleased() {
  for (int i = 0; i < objBtns.length; i++) {
    buttonOnOff[i] = 0;
  }
}
