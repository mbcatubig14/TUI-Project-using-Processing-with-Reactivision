import TUIO.*;
TuioProcessing tuioClient;
Board[][] board;
HashMap<Integer, Counter> fidObjects;
HashMap<Integer, AnswerCursor> cursorObjects;
HashMap<Integer, Dice> diceObjects;

boolean answerCorrect=false;
String correctAnswer = "";
HashMap<Integer, ArrayList<TargetChoice>> targetChoices = new HashMap<Integer, ArrayList<TargetChoice>>();
HashMap<Integer, TargetChoice> choiceSet = new HashMap<Integer, TargetChoice>();
HashMap<Integer, String> questions=new HashMap<Integer, String>();
HashMap<Integer, String> answers=new HashMap<Integer, String>();
HashMap<Integer, QuestionBox> questionSet;

int w, h ;
int squareSize = 100;
int xpos, ypos;
int numOfSquare;
boolean isRightSquare = false;
int newSquare = 0;
boolean isDiceExist = false;
int goalSquare = 25;
int squareId = 0;

color squareColors[] = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0)};
Dice dice;

String category= "";

int currentQuestion = 0;
QuestionBox qb = new QuestionBox();

String a = "", b = "", c = "";
void setupQuestionAndAnswer(String a, String b, String c) {
  this.a = a;
  this.b = b;
  this.c = c;
  ArrayList <TargetChoice>tgts= new ArrayList <TargetChoice>();
  tgts.add(new TargetChoice(520, 250, 100, 100, a));
  tgts.add(new TargetChoice(640, 250, 100, 100, b));
  tgts.add(new TargetChoice(760, 250, 100, 100, c));
  targetChoices.put(currentQuestion, tgts);
}

void setup() {
  size(900, 700);
  textSize(15);
  surface.setResizable(true);
  tuioClient  = new TuioProcessing(this);
  fidObjects = new HashMap<Integer, Counter>();
  diceObjects = new HashMap<Integer, Dice>();
  questionSet = new HashMap<Integer, QuestionBox>();
  cursorObjects = new HashMap<Integer, AnswerCursor>();
  setupQuestionAndAnswer(a, b, c);
  w = 500/squareSize;
  h = 500/squareSize;
  numOfSquare = w *h;
  board = new Board[w][h];
  dice = new Dice();
  dice.angle = 0.1;
  for (int i = 0; i <w; i++) {
    for (int j = 0; j < h; j++) {
      xpos = i * squareSize;
      ypos =j * squareSize;
      board[i][j] = new Board(xpos, ypos, squareSize, squareSize, j*h+i+1, squareColors[(int) random(4)]);
    }
  }
}

void draw() {
  background(128);
  //draw board
  for (int i = 0; i <w; i++) {
    for (int j = 0; j < h; j++) {
      board[i][j].display();
    }
  }
  //Display Counter
  for (Counter c : fidObjects.values()) {
    c.display();
    text("P"+ c.fid+ " Current square " + squareId, 100, 570);
  }

  //draw question
  if (currentQuestion != 0) {
    for (QuestionBox qb : questionSet.values() ) {
      qb.draw();
      text("Question "+currentQuestion, 520, 180);
      text(questions.get(currentQuestion), 520, 200);
    }
  }

  //if answer is correct
  if (answerCorrect) {
    text(answers.get(currentQuestion)+" is the correct answer! ", 520, 400);
    text("Next Player", 520, 500);
  }

  //draw values for targetchoice
  for (TargetChoice t : choiceSet.values()) {
    t.draw();
  }

  //draw boxes
  if (targetChoices.get(currentQuestion) != null) {
    for (TargetChoice t : targetChoices.get(currentQuestion)) {
      t.draw();
    }
  }
  //display answer cursor
  for (AnswerCursor ac : cursorObjects.values()) {
    ac.draw();
  }

  //display dice
  for (Dice dice : diceObjects.values()) {
    dice.display();
    isDiceExist = true;
  }

  //if it's in the right square
  if (!isRightSquare) {
    text("Pick " + category + "card in order to move on.", 520, 100);
    text("Move to " + newSquare, 100, 550);
  }

  //if the new square is the goal or above the goal number player wins
  if (newSquare >= 25) {
    text("You win!", 300, 550 );
  }
}

void addTuioObject(TuioObject fObject) {
  int counterId = fObject.getSymbolID();
  int diceId = fObject.getSymbolID();
  int questId = fObject.getSymbolID();
  int ansId = fObject.getSymbolID();
  color red, blue, green;

  red = color(255, 0, 0);
  green = color(0, 255, 0);
  blue = color(0, 0, 255);
  Counter counter;

  if (counterId < 2) {
    counter = new Counter(fObject.getScreenX(width), fObject.getScreenY(height), 30, 30, counterId);
    fidObjects.put(new Integer(counterId), counter);
    switch(counterId) {
    case 0:
      counter.counterColour = red;
      break;
    case 1:
      counter.counterColour = green;
      break;
    }
  }

  AnswerCursor ac;
  if (ansId == 4) {
    ac = new AnswerCursor(fObject.getScreenX(width), fObject.getScreenY(height), 20, 20, ansId);
    cursorObjects.put(new Integer(ansId), ac);
  }

  if (questId > 4) {
    TargetChoice tc;
    ArrayList <TargetChoice>tgts= new ArrayList <TargetChoice>();
    switch(questId) {
      //first question
    case 5:
      currentQuestion = questId;
      qb = new QuestionBox("Where do I live?", questId);
      questionSet.put(new Integer(questId), qb);
      questions.put(new Integer(currentQuestion), qb.question);
      break;
    case 8:
      a = "London";
      tc = new TargetChoice(520, 250, 100, 100, a );
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      //make this correct answer
      correctAnswer = tc.name;
      targetChoices.put(currentQuestion, tgts);
      answers.put(new Integer(currentQuestion), correctAnswer);
      break;
    case 9:
      b = "Edinburgh";
      tc = new TargetChoice(640, 250, 100, 100, b);
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      break;
    case 10:
      c = "Birmingham";
      tc = new TargetChoice(760, 250, 100, 100, c );
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      break;
      //second question
    case 6:
      currentQuestion = questId;
      qb = new QuestionBox("What's my name?", questId);
      questionSet.put(new Integer(questId), qb);
      questions.put(new Integer(currentQuestion), qb.question);
      tgts = new ArrayList<TargetChoice>();
      break;
    case 11:
      a = "MC";
      tc = new TargetChoice(520, 250, 100, 100, a );
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      break;
    case 12:
      b = "Mad";
      tc = new TargetChoice(640, 250, 100, 100, b);
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      break;
    case 13:
      c = "Muhammad";
      tc = new TargetChoice(760, 250, 100, 100, c );
      tgts.add(tc);
      choiceSet.put(new Integer(questId), tc);
      //make this the correct answer
      targetChoices.put(currentQuestion, tgts);
      correctAnswer = tc.name;
      answers.put(new Integer(currentQuestion), correctAnswer);
      break;
    default:
      break;
    }
  }

  if (diceId == 2) {
    dice = new Dice(fObject.getScreenX(width), fObject.getScreenY(height), 55, 55, diceId);
    diceObjects.put(new Integer(diceId), dice);
    isDiceExist = true;
    newSquare = squareId + dice.getDiceValue() ;
  }
}
void removeTuioObject(TuioObject fObject) {
  int diceId = fObject.getSymbolID();
  int counterId = fObject.getSymbolID();
  int ansId = fObject.getSymbolID();

  fidObjects.remove(new Integer(counterId));
  diceObjects.remove(new Integer(diceId));
  cursorObjects.remove(new Integer(ansId));
}

void updateTuioObject (TuioObject fObject) {
  Counter counter = new Counter();
  Dice dice = new Dice();
  AnswerCursor ac = new AnswerCursor();

  int cXpos = 0, cYpos = 0;
  int counterId = fObject.getSymbolID(), diceId =fObject.getSymbolID();
  int ansId = fObject.getSymbolID(), questId = fObject.getSymbolID();
  int oldCX = 0, oldCY =0, thatId=0;
  if (counterId < 2) {
    counter = fidObjects.get(new Integer(counterId));
    oldCX = counter.x;
    oldCY = counter.y;
    thatId =counter.fid;
    counter.x=fObject.getScreenX(width);
    counter.y=fObject.getScreenY(height);
    cXpos = counter.x;
    cYpos = counter.y;
  }
  for (Board[] b : board) {
    for (Board square : b) {

      boolean wasIn = square.contains(oldCX, oldCY, thatId);
      boolean isIn = square.contains(cXpos, cYpos, counter.fid);

      if (diceId == 2) 
        dice = diceObjects.get(diceId);
      dice.x = fObject.getScreenX(width);
      dice.y = fObject.getScreenY(height);
      dice.angle = fObject.getAngle();

      if (!wasIn && isIn) {
        square.enteredBy(counter.fid);
        squareId = square.squareId;
        if (counter.hasMoveTo(newSquare)) {
          isRightSquare = true;
          if (square.squareColor == squareColors[0]) {
            category = "Red";
          } else if (square.squareColor == squareColors[1]) {
            category = "Blue";
          } else if (square.squareColor == squareColors[2]) {
            category = "Green";
          } else if (square.squareColor == squareColors[2]) {
            category = "Blue";
          }
        }
        println("In " + squareId);
        println("Move to " + newSquare);
      }

      if (wasIn && !isIn) {
        square.leftBy(counter);
      }
    }
  }//end of for each square
  int oldCx = 0, oldCy = 0;
  if (ansId == 4) {
    ac = cursorObjects.get(new Integer(ansId));
    oldCx = ac.x; 
    oldCy = ac.y;
    ac.x = fObject.getScreenX(width);
    ac.y = fObject.getScreenY(height);
  }

  // check if o is in any of the targets; if so 'hit' the target
  if (targetChoices.get(currentQuestion) != null) {
    for (TargetChoice t : targetChoices.get(currentQuestion)) {
      //println(qb.id);
      boolean wasIn = t.contains(oldCx, oldCy);
      boolean isIn = t.contains(ac.x, ac.y);

      // has object o moved into the target? 
      if (!wasIn && isIn) {
        t.entered(ac);

        // if we're in a target and the target stands for the correct answer
        // then set answerCorrect.
        if (t.name.equals(answers.get(currentQuestion))) {
          answerCorrect=true;
        }
      }
    }
  }
}