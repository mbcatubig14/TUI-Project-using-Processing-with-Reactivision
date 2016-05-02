class TargetChoice {

  /* Rectangular targets.
   have x, y location location & dimensions.
   Can test whether an object inside them -- contains
   Display colour depends on whether they've been 'hit'.
   */

  int x, y, xSize, ySize, halfXSize, halfYSize;

  color fillCol, hitFillCol, strokeCol;
  boolean hit=false; 
  // better to store a list of tracked objects that are inside this target;
  // hit = list non-empty.

  String name="";

  TargetChoice(int xx, int yy, int sx, int sy, String n) {
    x=xx; 
    y=yy; 
    xSize=sx; 
    halfXSize=sx/2;
    ySize=sy;
    halfYSize=sy/2;
    fillCol=color(100, 150);
    hitFillCol=color(200, 0, 0, 150);
    strokeCol=color(200);
    name=n;
  }

  TargetChoice(int xx, int yy, int sx, int sy) {
    x=xx; 
    y=yy; 
    xSize=sx; 
    halfXSize=sx/2;
    ySize=sy;
    halfYSize=sy/2;
    fillCol=color(100, 150);
    hitFillCol=color(200, 0, 0, 150);
    strokeCol=color(200);
  }

  TargetChoice(String n) {
    name=n;
  }

  void draw() {
    pushStyle();
    if (hit) {
      fill(hitFillCol);
    } else {
      fill(fillCol);
    }  
    stroke(strokeCol);
    rect(x, y, xSize, ySize);
    fill(255);
    text(name, x-xSize/2+50, y-ySize/2+40);
    popStyle();
  }

  boolean contains(int ox, int oy) {
    // does this target contain the location (ox, oy)? 
    return (ox>x-halfXSize && ox<x+halfXSize && oy>y-halfYSize && oy<y+halfYSize);
  }

  void entered(AnswerCursor o) {
    hit=true;
  }
  void left(AnswerCursor o) {
    hit=false;
  }
  void moved(AnswerCursor o) {
  }
}