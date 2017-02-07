boolean calcX;
boolean useColor;
boolean useFrameLimit;
float offsetmultiX = 1;
float offsetmultiY = 1;

float overdrawX = 0;
float overdrawY = 0;
float fullwidth = 0;
float fullheight = 0;

float bwWhite = 0.5f;
int frameCounter = 0;
int frameLimit;
int colorUpperLimit;
int colorLowerLimit;
int exitAfterNumberOfMarkers;
int markerCounter;
int borderSize;

String randomBatchName;

void setup() {
  //Configure these values
  //actuale pixel size of the maker
  size(1024, 512);

  //width of the lines
  strokeWeight(15);

  //how far points can go past the visible border in percent
  float overdraw = 0.3;
  
  //colors or black/white
  useColor = true;
  
  //Color limits to control overall color brightness
  colorUpperLimit = 255;
  colorLowerLimit = 224;

  //How big a chance to draw white 0.75 would be 75% white (only for useColor = false)
  bwWhite = 0.99f;
  
  //Stop after frameLimit number of frames and save the marker (else hit a button to save the current frame)
  useFrameLimit = true;
  frameLimit = 200;
  
  //Exits after number of markers generated
  exitAfterNumberOfMarkers = 20;
  
  //Border in pixels in addition to the canvas size, borders ar blank white
  borderSize = 256;  
  
  //Only madness and despair past his line ...
  
  randomBatchName = str((int)random(10000000,99999999));
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
  println("Bulding " +  exitAfterNumberOfMarkers + " markers, batch name " + randomBatchName + ".");
}
 
void draw() {
  frameCounter++;
  
  float f = random(1);
  
  if (useColor)
  {
    fill(random(colorLowerLimit, colorUpperLimit), random(colorLowerLimit, colorUpperLimit), random(colorLowerLimit, colorUpperLimit));
  }
  else
  {
    if (f <= bwWhite)
    {
      fill(255);
    }
    else
    {
      fill(0);
    }
  }
  float offsetX = 0;
  float offsetY = 0;
  
  if (calcX)
  {offsetX = random(fullwidth-fullwidth/offsetmultiX);}
  else
  {offsetY = random(fullheight-fullheight/offsetmultiY);}
  
  triangle(offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY,
           offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY,
           offsetX + random((fullwidth)/offsetmultiX)- overdrawX, offsetY + random((fullheight)/offsetmultiY) - overdrawY);
           
  if (useFrameLimit && frameLimit <= frameCounter)
  {
    SaveAndClear();
  }
}

void keyPressed() {
  if (!useFrameLimit) {
    SaveAndClear();
  }
}

void SaveAndClear() {
  markerCounter++;
  String filename = "marker-"+ randomBatchName + "-" + nf(markerCounter, 3) + ".png";
  
  int newwidth = width + 2*borderSize;
  int newheight = height + 2*borderSize;
  
  PImage oldimg = get();
  clear();
  background(255);
  
  PImage newimg = get();
  newimg.resize(newwidth, newheight);
  newimg.set(borderSize, borderSize, oldimg);
  newimg.save(savePath(filename));
  
  frameCounter = 0;
  
  if (exitAfterNumberOfMarkers <= markerCounter)
  {
    println("All done!");
    exit();
  }
  else
  {
    println("Done with marker " + markerCounter);
    clear();
  }
}