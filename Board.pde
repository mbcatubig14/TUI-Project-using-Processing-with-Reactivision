class Board {

  int x, y, w, h;
  int squareId;
  color squareColor;
  String numText = "";
  int goal = 25;

  Board(int x, int y, int w, int h, int squareId, color squareColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.squareColor = squareColor;
    this.h = h;
    this.squareId = squareId;
  }

  boolean contains(int ox, int oy, int id) {
    boolean isIn = false;
    if (ox>x-w/2 && ox<x+w/2 && oy>y-h/2 && oy<y+h/2) {
      isIn = true;
    } else {
      isIn = false;
    }
    return isIn;
  }

  int moveTo(boolean isIn, int sid, int dvalue) {
    if (isIn) {
      sid+= dvalue;
      return sid;
    } else {
      return sid;
    }
  }

  boolean isInGoal(int cx, int cy, int cid, int currentSquare, int goalSquare) {
    boolean isGoal = false;
    if (contains(cx, cy, cid) && currentSquare == goalSquare ) {
      isGoal = true;
      return isGoal;
    }
    return isGoal;
  }

  void verifyCounterPosition(int fid) {
    boolean isGoal = false;
    if (isGoal) {
    }
  }

  boolean hit = false;
  void enteredBy(int cid) {
    hit = true;
  }

  void leftBy(Counter c) {
    hit=false;
  }

  void display() {
    stroke(153);
    strokeWeight(5);
    fill(squareColor);
    rect(x, y, w, h);
    fill(0);
    text(squareId, x+w/2, y+h/2);
  }

  String toString() {

    return numText;
  }
}