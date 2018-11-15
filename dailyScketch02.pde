PShape currentShape;


int tileCount=15;
float tileWidth, tileHeight;
float shapeSize=50;
float hue=240;
color bg=21;
float maxDist;
float angleNoise=0;

void setup() {
  fullScreen(P2D);
  size(600,600);
  background(bg);
  pixelDensity(displayDensity());
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  tileWidth=width/tileCount;
  tileHeight=height/tileCount;
  maxDist = sqrt(sq(width)+sq(height));
}

void draw() {
  background(bg); 
  smooth();
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      float posX=tileWidth*gridX+tileWidth/2;
      float posY=tileHeight*gridY+tileHeight/2;
      float angle=atan2(mouseY-posY, mouseX-posX)+radians(map(noise(angleNoise), 0, 1, 0, 360));
      //float angle = atan2(mouseY-posY, mouseX-posX) ;

      pushMatrix();
      translate(posX, posY);
      rotate(angle);
      noStroke();

      //float a = map(dist(mouseX, mouseY, posX, posY), 0, maxDist, 0, 100);
      fill(hue, 80, 80, 80);
      
      popMatrix();
      angleNoise+=0.1;
    }
  }
}
