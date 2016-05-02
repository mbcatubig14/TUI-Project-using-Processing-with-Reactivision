class Counter {

  int x, y;
  int w, h;
  color counterColour;
  int fid;
  
  Counter(){};

  Counter(int x, int y, int w, int h, int fid) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fid = fid;
  }
  
  boolean hasMoveTo(int newSquare){
    boolean hasMove = false;
    return hasMove;
  }
  
  
  
  void display() {
    stroke(0);
    fill(counterColour);
    ellipse(x, y, w, h);
    fill(0);
    text("P"+(fid+1), x+w/2, y+h/2);
  }
}