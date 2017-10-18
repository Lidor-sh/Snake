int w = 20;
int dir = 3;
int[] vx = {0, 0, -1, 1},vy = {1, -1, 0, 0};
int appleX, appleY;

boolean gameOver = false;

ArrayList<Integer> x = new ArrayList<Integer>(),y = new ArrayList<Integer>();

void setup(){
  size(600,600);
  x.add(5);
  y.add(5);
  pickApple();
}

void draw(){
  background(255);
  createWalls();
  drawApple();
  drawSnake();
  checkCrashed();
  isPlaying();
}

void isPlaying(){
  if(!gameOver){
    if(frameCount % 5 == 0){
      if(x.get(0) == appleX && y.get(0) == appleY){
        pickApple();
        moveSnake(true);
      }else{
        moveSnake(false);
      }
    }
  }else{
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("GAME OVER, Press space.", width / 2, height / 2);
    if(keyPressed && key == ' '){
      restartGame();
    }
  }
}

void checkCrashed(){
  if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) > width / w || y.get(0) > height / w){
    gameOver = true;
  }
  for(int i = 1; i < x.size(); i++){
    if(x.get(0) == x.get(i) && y.get(0) == y.get(i)){
      gameOver = true;
    }
  }
}

void restartGame(){
  x.clear();
  y.clear();
  x.add(5);
  y.add(5);
  dir = 3;
  pickApple();
  gameOver = false;
}

void pickApple(){
  appleX = (int)random(0,width/w);
  appleY = (int)random(0,height/w);
}

void drawApple(){
  fill(255,0,0);
  rect(appleX * w, appleY * w, w, w);
}
void createWalls(){
  for(int i = 0; i < width/w; i++){
    line(i * w, 0, i * w, height);
  }
  for(int i = 0; i < width/w; i++){
    line(0, i * w, width, i * w);
  }
}

void drawSnake(){
  for(int i = 0; i < x.size(); i++){
    fill(0, 255, 0);
    rect(x.get(i) * w, y.get(i) * w, w, w);
  }
}

void moveSnake(boolean eat){
  x.add(0, x.get(0) + vx[dir]);
  y.add(0, y.get(0) + vy[dir]);
  if(!eat){
    x.remove(x.size() - 1);
    y.remove(y.size() - 1);
  }
}

void keyPressed(){
  int newDir = -1;
  switch(key){
    case 's':
      newDir = 0;
    break;
    case 'w':
      newDir = 1;
    break;
    case 'a':
      newDir = 2;
    break;
    case 'd':
      newDir = 3;
    break;
  }
  if(newDir != -1 && ((x.size() <= 1) || !(x.get(1) == x.get(0) + vx[newDir] && y.get(1) == y.get(0) + vy[newDir]))){
    dir = newDir;
  }
}