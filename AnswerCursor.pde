class AnswerCursor {
  /* TrackedObjects are things that're displayed
   on screen and created & moved around - e.g. 
   by the movement of TUIO objects
   */

  int x, y, xSize, ySize, fiducialID;
  long fiducialID1;
  color fillCol, strokeCol;
  
  AnswerCursor(){}

  AnswerCursor(int xx, int yy, int sx, int sy, int id) {
    x=xx; 
    y=yy; 
    xSize=sx; 
    ySize=sy;
    fillCol=color(100);
    strokeCol=color(200);
    fiducialID=id;
  }

  void draw() {
    /* basic draw method - just draws a circle
     */
    pushStyle();
    fill(fillCol);
    stroke(strokeCol);
    ellipse(x, y, xSize, ySize);
    popStyle();
  }
}