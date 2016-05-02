class QuestionBox {

  int x, y, xSize, ySize, halfXSize, halfYSize;

  color fillCol, hitFillCol, strokeCol;
  boolean hit=false; 
  // better to store a list of tracked objects that are inside this target;
  // hit = list non-empty.

  String name="";
  String question = "";
  int id;

  QuestionBox() {
  }

  QuestionBox(String q, int id) {
    question = q;
    this.id = id;
  }

  QuestionBox(int xx, int yy, int sx, int sy, String n) {
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

  void draw() {
   text(question, x-xSize/2, y-ySize/2);//Question
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