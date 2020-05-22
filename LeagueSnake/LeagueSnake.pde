//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;

// Add a constructor with parameters to initialize each variable.
  Segment(int x, int y){
    this.x = x;
    this.y = y;
  }

}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;

int foodX;
int foodY;

int direction = UP;
int foodEaten;

ArrayList<Segment> tail = new ArrayList<Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500,500);
  
  int x = 250;
  int y = 250;
  head = new Segment(x, y);
  frameRate(20);
  
  dropFood();
}

void dropFood() {
  //Set the food in a new random location
  foodX = ((int) random(50)*10);
  foodY = ((int) random(50)*10);
    
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0, 0, 0);
  
  drawFood();
  move();
  drawSnake();
  
  eat();
  
}

void drawFood() {
  //Draw the food
  fill(127,255,212);
  square(foodX, foodY, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(255,250,205);
  rect(head.x, head.y, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for (Segment s: tail){
    rect(s.x, s.y, 10, 10);
  }
}

void manageTail() {
  checkTailCollision();
  drawTail();
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end"
  tail.add(new Segment(head.x, head.y));
  tail.remove(0);
  //This produces the illusion of the snake tail moving.
  
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (Segment s: tail){
    if (s.x == head.x && s.y == head.y) {
      tail = new ArrayList<Segment>();
      tail.add(new Segment(head.x, head.y));
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (key == CODED){
    if (keyCode == UP){
      direction = UP;  
    } else if (keyCode == DOWN){
      direction = DOWN;  
    } else if (keyCode == RIGHT){
      direction = RIGHT;
    } else if (keyCode == LEFT){
      direction = LEFT;  
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
  switch(direction) {
  case UP:
    // move head up here 
    head.y -= 10;
    break;
  case DOWN:
    // move head down here 
    head.y += 10;
    break;
  case LEFT:
   // figure it out 
    head.x -= 10;
    break;
  case RIGHT:
    // mystery code goes here 
    head.x += 10;
    break;
  }
  
  checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
  if (head.x < 0) {
    head.x = width;
  }
  if (head.x > width) {
    head.x = 0;  
  }
  if (head.y < 0) {
    head.y = height;  
  }
  if (head.y > height) {
    head.y = 0;  
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if (head.x == foodX && head.y == foodY){
    foodEaten++;
    
    foodX = ((int) random(50)*10);
    foodY = ((int) random(50)*10);
    
    tail.add(new Segment(head.x, head.y));
  }
}
