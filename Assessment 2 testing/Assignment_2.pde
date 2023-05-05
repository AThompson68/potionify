//  Fly Swatter Game  //
//  Assignment 2 COSC101  //
//  Arron Thompson  //

//  added this comment for a testing of how this github workflow works  //

//  The program is a fly swatting game that randomally generates flys to be swatted by the user in an 800x400 GUI and  //
//  a score is kept.  //
//  of the flys swatted.  //

//  Before running the program, you will need to install the "Sound" library in the processing tool to be able to play  //
//  the sound effects file that will activate every time a fly is swattted.  //

//  To run the program, open this file "Assignment_2" and run the assignment in the processing software. Press play  //
//  and the game will activate. 
//  Refer to attached ReadMe.txt file in the Assignment_2 folder for more information  //

//  Defining all of the global variables  //
PImage fly,flybye,swatter,swatted;
float[] fX,fY;  // fly locations array
float[] swat;  // fly swatted binary boolean array, 1 = swatted, 0 = not swatted
int score=0;  // increments when swatted.
boolean value = true;  //  added to solve the issue of not being able to hold the swatter down to continue to swatt flys  //
int counter = 0;

import processing.sound.*;  // Imports the 'sound' library
SoundFile file;  // Creates a SoundFile called 'file'  

void setup() {
  size(800,400);
  fX = new float[0];
  fY = new float[0];
  float RX = random(50, 725); //  created variable for random fX location  //
  float RY = random(50, 325); //  created variable for random fY location  //
  swat=new float[0];
  
  //  load images for flys and swatters  //
  fly = loadImage("fly.png");
  flybye = loadImage("flybye.png");
  swatter = loadImage("swatter.png");
  swatted = loadImage("swatted.png");
  
  fX = append(fX, RX); //  first fly - random location  //
  fY = append(fY, RY);
  swat = append(swat,0); //  used as a boolean and matches to each individual fly, 0 = fly not swatted, 1 = swatted.  //
  file = new SoundFile(this, "cartoon-splat-6086.wav");  //  creates the variable 'file' for the sound effects  //
}

//  populate function that adds flys to the screen  //
void populate(){ // draw the flies in memory to the screen.
    for(int i=0;i<fX.length;i++){
        if(swat[i] == 1){  
            //  if swatted, resize the swatted fly image and place based on fx/fy array values  //
            image(flybye, fX[i], fY[i], 50, 50);
        } else {
            //  if not swatted, resize the fly image and place based on fx/fy array values
            image(fly, fX[i], fY[i], 50, 50);
        }
    }
}

//  collision detection for the swatter and the flys  //
void collisionDetect(){ //collision detection - detect collision between swatter and fly
    for(int i=0; i<swat.length;i++){ // bounding box detection
        if((mouseX + 35 > fX[i] + 10 && mouseX - 35 < fX[i] + 32 ) && (mouseY + 35 > fY[i] + 18 && mouseY - 35 < fY[i] + 35)) {  // condition look at location of mouse and individual coordinates in fX and fY  //
            if (swat[i] == 0){ //  if statement to check the condition that a fly is not previously swatted and cannot be swatted again  //
                swat[i] = 1; // swatted  //
                file.play();  //  adds the sound effects  //
                float RX = random(50, 725); //  created variable for random fX location
                float RY = random(50, 325); //  created variable for random fY location
                fX =append(fX, RX); //  new fly placed in random location when old fly dies.
                fY =append(fY, RY); //  new fly placed in random location when old fly dies.
                swat =append(swat,0); //  new fly not swatted
                score++; //  increment score
            }
        }    
    }  
}


//  added to make sure that once the mouse is released, then it can only be a swatt  //
void mouseReleased() {
    value = true;
}

void draw(){
    background(255);
    
    //  sets a text size and location for the score.  //
    textSize(30);
    fill(0);
    text("Score " + score, 650, 50);  //  adds the score to the screen  //
  
    populate(); // calls the 'populate' function and draws flys of swatted flys to screen.  //
    
    //  if the mouse is pressed and the value equals true, then a fly will be swatted and it will set the value back to false to be ready to swat unswatted flys  //
    if(mousePressed && value){  
        collisionDetect();
        value = false;
    }
    
    //  adds the swatter image to the screen that follows the mouse pointer around, slightly offset to be in the middle of the mmouse pointer/swatter image  //
    if (mousePressed) {
        image(swatted, mouseX - 35, mouseY - 35);   //draws a swatter image to around mouse locaiton.  //
    } else {
        image(swatter, mouseX - 35, mouseY - 35); // if not pressed then alternative image.  //
    }
  
}
