class Dice {

  int value;
  int x, y, w, h;
  int id;
  float angle;

  Dice(int x, int y, int w, int h,int id) {
    this();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.id = id;
  }
  
  
  Dice(){
    value = (int) random(1, 6);
  }

  int getDiceValue() {
    return value;
  }
  
  void display() {
    pushStyle();
    fill(255);
    pushMatrix();
    translate(x, y);
    rotate (angle);
    rect(0, 0, w, h, 7);
    fill(0);
    text(""+value, w/2, h/2);
    popMatrix();
    popStyle();
  }
}