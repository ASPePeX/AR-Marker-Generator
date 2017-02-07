boolean calcX;
float offsetmultiX = 1;
float offsetmultiY = 1;

float overdrawX = 0;
float overdrawY = 0;
float fullwidth = 0;
float fullheight = 0;

void setup() {
  //background(0);
  size(2560, 512);
  strokeWeight(10);
  float overdraw = 0.2;

  overdrawX = width * overdraw;
  overdrawY = height * overdraw;
  fullwidth = width + 2*overdrawX;
  fullheight = height + 2*overdrawY;
  
  if (width >= height)
  {
    calcX = true;
    offsetmultiX = fullwidth/fullheight;
  }
  else
  {
    calcX = false;
    offsetmultiY = fullheight/fullwidth;
  }
}
 
void draw() {
  float f = random(1);
  if (f <= 0.93f)
  {fill(255);}
  else
  {fill(0);}
  
  float offsetX = 0;
  float offsetY = 0;
  
  if (calcX)
  {offsetX = random(fullwidth-fullwidth/offsetmultiX);}
  else
  {offsetY = random(fullheight-fullheight/offsetmultiY);}
  
  triangle(offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY,
           offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY,
           offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY); 
}

void keyPressed() {
  saveFrame(str((int)random(10000000,99999999)));
  clear();
}