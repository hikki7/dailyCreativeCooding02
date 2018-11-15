
float hueRight=240;
float hueLeft=270;

int tileCountX;
int tileCountY;
int randSeed=0;

int lengthX, lengthY;

float[]lightPosX=new float[3]; 
float[]lightPosY=new float[3];

float alpha;

float maxLength;

float[]noiseX=new float[3];
float[]noiseY=new float[3];
float lightLength;
float radius=300;
float[]angle=new float[3];
float radiusTheta=0;

void setup() {
  fullScreen();
  noCursor();
  tileCountX=width/30;
  tileCountY=height/30;
  lengthX=width/tileCountX;
  lengthY=height/tileCountY;
  background(21);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  pixelDensity(displayDensity());
  for (int i=0; i<noiseX.length; i++) {
    lightPosX[i]=random(width);
    lightPosY[i]=random(height);
    noiseX[i]=random(100);
    noiseY[i]=random(100);
  }
  alpha=100;
  maxLength=sqrt(sq(width)+sq(height));
  for (int i=0; i<angle.length; i++) {
    angle[i]=i*360/angle.length;
  }
}

void draw() {
  randomSeed(randSeed); 
  background(21);
  for (int i=0; i<noiseX.length; i++) {
    //lightPosX[i]=map(noise(noiseX[i]), 0, 1, 0, width); 
    //lightPosY[i]=map(noise(noiseY[i]), 0, 1, 0, height);

    lightPosX[i]=radius*cos(radians(angle[i]))+width/2;
    lightPosY[i]=radius*sin(radians(angle[i]))+height/2;
    angle[i]+=5;
  }
  radius=300+200*sin(radiusTheta);
  radiusTheta+=0.1;
  for (int gridX=0; gridX<tileCountX; gridX++) {
    for (int gridY=0; gridY<tileCountY; gridY++) {
      int posX=lengthX*gridX; 
      int posY=lengthY*gridY; 
      int rand=(int)random(0, 2); 

      lightLength=dist(posX, posY, lightPosX[0], lightPosY[0]);

      for (int i=0; i<lightPosX.length; i++) {
        if (lightLength>dist(posX, posY, lightPosX[i], lightPosY[i])) {
          lightLength=dist(posX, posY, lightPosX[i], lightPosY[i]);
        }
      }

      alpha=map(lightLength, 0, maxLength/8, 100, 0); 

      //右斜め下
      if (rand==0) {
        stroke(hueLeft, 100, 100, alpha); 
        line(posX, posY, posX+lengthX, posY+lengthY);
      }
      //右斜め上
      if (rand==1) {
        stroke(hueRight, 80, 80, alpha); 
        line(posX, posY+lengthX, posX+lengthY, posY);
      }
    }
  }

  for (int i=0; i<noiseX.length; i++) {
    noiseX[i]+=0.1; 
    noiseY[i]+=0.1;
  }
  
  //saveFrame("frames/######.tif");

}
