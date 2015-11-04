//You should implement your assign3 here.
PImage background1, background2, enemy, fighter, hpImg, treasure,
       start1, start2;
int backgroundX, background1X, background2X, hpW, enemyWave, speed, 
    fighterX, fighterY, enemyX, enemyY, treasureX, treasureY, gameState; 
final int GAME_START=0, GAME_RUN=1, FIRST_WAVE=2, SECOND_WAVE=3, THIRD_WAVE=4;
boolean upPressed, downPressed, leftPressed, rightPressed;


void setup () {
  size(640, 480) ;
  //loadImage
  background1=  loadImage("img/bg1.png");
  background2=  loadImage("img/bg2.png");
  enemy      =  loadImage("img/enemy.png");
  fighter    =  loadImage("img/fighter.png");
  hpImg      =  loadImage("img/hp.png");
  treasure   =  loadImage("img/treasure.png");
  start1     =  loadImage("img/start1.png");
  start2     =  loadImage("img/start2.png");
  
  //init variables
  backgroundX = 0;
  hpW         = 200;
  fighterX    = 550;
  fighterY    = 240;
  enemyX      = -61;
  enemyY      = floor(random(0,419));
  treasureX   = floor(random(20,501));
  treasureY   = floor(random(60,401));
  enemyWave   = FIRST_WAVE;
  speed       = 5;
  upPressed = downPressed = leftPressed = downPressed = false;
}

void draw() {
  switch (gameState){
    case GAME_START:
         if(mouseY > 375 && mouseY < 420 && mouseX > 200 && mouseX < 450){
           //click
           if(mousePressed){
             gameState = GAME_RUN;
           }
           //hover
           else
             image(start1,0,0);
         }
         else
           image(start2,0,0);
         break;
    case GAME_RUN:
      //bg
      image(background2,background2X,0);
      image(background1,background1X,0);
      background2X = backgroundX + 640;
      background1X = backgroundX ;
      backgroundX += 2;
      background2X = (background2X %= 1280) - 640;
      background1X = (background1X %= 1280) - 640;
      
      //treasure
      if(fighterX-treasureX <= 41 && fighterY-treasureY <= 41 && 
         treasureX-fighterX <= 51 && treasureY-fighterY <= 51){
        treasureX = floor(random(20,501));
        treasureY = floor(random(60,401));
      }
      image(treasure,treasureX,treasureY);
      
      //fighter
      if(upPressed)
        fighterY -= speed;
      if(downPressed)
        fighterY += speed;
      if(leftPressed)
        fighterX -= speed;
      if(rightPressed)
        fighterX += speed;  
        //Boundary detection
        if(fighterX<0)
          fighterX = 0;
        if(fighterX > 590)
          fighterX = 590;
        if(fighterY < 0)
          fighterY = 0;
        if(fighterY > 430)
          fighterY = 430;
      image(fighter,fighterX,fighterY);
      
      //enemy
      switch (enemyWave){
        case FIRST_WAVE:
          for(int enemyNumber = 0; enemyNumber < 5; enemyNumber++){
            pushMatrix();
            translate(-65*enemyNumber,0);
            image(enemy,enemyX,enemyY);
            popMatrix();
          }
          if(enemyX < 969)
            enemyX +=5 ;
          else{
            enemyX = -61;
            enemyY = floor(random(0,159));
            enemyWave = SECOND_WAVE;
          }
          break;
        case SECOND_WAVE:
          for(int enemyNumber = 0; enemyNumber < 5; enemyNumber++){
            pushMatrix();
            translate(-65*enemyNumber,65*enemyNumber);
            image(enemy,enemyX,enemyY);
            popMatrix();
          }
          if(enemyX < 969){
            enemyX +=5;
          }
          else{
            enemyX = -61;
            enemyY = floor(random(0,159));
            enemyWave = THIRD_WAVE;
          }
          break;
        case THIRD_WAVE:
          for(int enemyNumber = 0; enemyNumber < 5; enemyNumber++){
            pushMatrix();
            translate(-65*enemyNumber,0);
            if(enemyNumber == 0 || enemyNumber == 4)
              translate(0,140);
            if(enemyNumber == 1 || enemyNumber == 3)
              translate(0,70);
            image(enemy,enemyX,enemyY);  
            popMatrix();
          }
          for(int enemyNumber = 0; enemyNumber < 5; enemyNumber++){
            pushMatrix();
            translate(-65*enemyNumber,70*4);
            if(enemyNumber == 0 || enemyNumber == 4)
              translate(0,-140);
            if(enemyNumber == 1 || enemyNumber == 3)
              translate(0,-70);
            image(enemy,enemyX,enemyY);
            popMatrix();
          }
          if(enemyX < 969){
            enemyX +=5;
          }
          else{
            enemyX = -61;
            enemyY = floor(random(0,419));
            enemyWave = FIRST_WAVE;
          }
          break;
      }  
       
      //hpVolume
      stroke(255,0,0);
      fill(255,0,0);
      rect(20,20,hpW,20);
      
      //hpImg
      image(hpImg,15,15);
      break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
