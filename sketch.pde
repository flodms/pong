int xb,yb,rb;
int dirx, diry;
int x1,y1,x2,y2,w,h;

int score1,score2,hiscore = 0;

int mode = 1;

void setup() {
  //orientation(LANDSCAPE);
  //size(800,500);
  //fullScreen();
  //noCursor();
  rb = height/50;
  dirx = -width/400;
  w = width/200;
  h = int(height/12.5);
  start();
  
  //font = createFont("technology.regular.ttf",height/8);
}

void draw() {
  rectMode(CENTER);
  background(0);
  rect(width/2,height/2,5,height);
  
  ellipse(xb,yb,rb*2,rb*2);
  rect(x1,y1,w*2,h*2);
  
  //textFont(font);
  textSize(100);
  text(score1,width/3,height/10);

  
  xb+= dirx;
  yb+= diry;

  switch(mode) {
    case 1:
    mode1();
    break;
    case 2:
    mode2();
    break;
  }
  
}

void touched(int y) {
  dirx = -dirx;
  int mult = y-yb; 
  diry += diry+mult/10;
}

void start() {
    xb = width/2;
    yb = height/2;
    diry = 0;
    y1 = height/2;
    x1 = width/100;
    y2 = height/2;
    x2 = width-x1;
}

void mode1() {
  text(score2,width/3*2,height/10);
  rect(x2,y2,w*2,h*2);
  
  if(yb+rb > height || yb-rb < 0) {
    diry = -diry;
  }
  
  if(xb-rb < x1+w && abs(y1-yb)< h) {
    touched(y1);
  }
  
  if(xb+rb > x2-w && abs(y2-yb)< h) {
    touched(y2);
  }
  
  if(xb-rb < 0) { //p2 win
    score2++;
    //println(score1);
    start();
  }
  
  if(xb+rb > width) {
    score1++; //p1 win
    //println(score2);
    start();
  }
  
  for(TouchEvent.Pointer te: touches) {
    if(te.y<=height/2) {//haut ecran
      if(te.x<=width/2) { //gauche ecran
        if(y1-h>0) y1-=5;
      } else if(y2-h>0) y2-=5;
    } else {//bas ecran
      if(te.x<=width/2) { //gauche ecran
        if(y1+h<height) y1+=5;
      } else if(y2+h<height) y2+=5;
    }
  }
}

void mode2() { // to implement
  text("hi score: " + hiscore,width/3*2,height/10);
  
  if(yb+rb > height || yb-rb < 0) {
    diry = -diry;
  }
  
  if(xb-rb < x1+w && abs(y1-yb)< h) {
    touched(y1);
    score1++;
  }
  
  if(xb+rb > width) {
    dirx = -dirx;
  }
  
  if(xb-rb < 0) { //p1 loses
    if(score1 > hiscore) hiscore = score1;
    start();
    score1 = 0;
  }
  
  for(TouchEvent.Pointer te: touches) {
    if(te.y<=height/2) {//haut ecran
      if(te.x<=width/2) { //gauche ecran
        if(y1-h>0) y1-=5;
      }
    } else {//bas ecran
      if(te.x<=width/2) { //gauche ecran
        if(y1+h<height) y1+=5;
      }
    }
  }
  
}