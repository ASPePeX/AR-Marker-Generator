float triangleSize = 1;
int triangleLimit;
int colorUpperLimit;
int colorLowerLimit;
int exitAfterNumberOfMarkers;
int markerCounter;
int borderSize;
color backgroundClearColor;

String randomBatchName;

void setup() {
  //Configure these values
  //actuale pixel size of the maker
  size(2500, 2500);

  //width of the lines
  strokeWeight(15);

  //triangle max size in pixel
  triangleSize = 1200;
  
  //Color limits to control overall color brightness
  colorUpperLimit = 255;
  colorLowerLimit = 224;

  //Draw number of triangles per marker
  triangleLimit = 250;
  
  //Exits after number of markers generated
  exitAfterNumberOfMarkers = 20;
  
  //Border in pixels in addition to the canvas size, borders ar blank white
  borderSize = 0;  
  
  //Background clear color
  backgroundClearColor = 255;
  
  //Only madness and despair past his line ...
  
  randomBatchName = str((int)random(10000000,99999999));
  println("Bulding " +  exitAfterNumberOfMarkers + " markers, batch name " + randomBatchName + ".");
  background(backgroundClearColor);
}
 
void draw() {
  
  for (int i = 0; i < triangleLimit; i++)
  {
    //Randoming triangle corners, in their own relative coordinate system
    PVector a = new PVector(random(-triangleSize/2, triangleSize/2), random(-triangleSize/2, triangleSize/2));
    PVector b = new PVector(random(-triangleSize/2, triangleSize/2), random(-triangleSize/2, triangleSize/2));
    PVector c = new PVector(random(-triangleSize/2, triangleSize/2), random(-triangleSize/2, triangleSize/2));
    
    //Randoming the center position on the canvas
    PVector p = new PVector(random(width), random(height));
    
    //Randoming fill color
    fill(random(colorLowerLimit, colorUpperLimit),random(colorLowerLimit, colorUpperLimit),random(colorLowerLimit, colorUpperLimit));
  
    //Drawing the triangle
    triangle(a.x + p.x, a.y + p.y,
             b.x + p.x, b.y + p.y,
             c.x + p.x, c.y + p.y); 
  }
  
  SaveAndClear();
}

void SaveAndClear() {
  markerCounter++;
  String filename = "marker-"+ randomBatchName + "-" + nf(markerCounter, 3) + ".png";
  
  int newwidth = width + 2*borderSize;
  int newheight = height + 2*borderSize;
  
  PImage oldimg = get();
  clear();
  background(backgroundClearColor);
  
  PImage newimg = get();
  newimg.resize(newwidth, newheight);
  newimg.set(borderSize, borderSize, oldimg);
  newimg.save(savePath(filename));
  
  if (exitAfterNumberOfMarkers <= markerCounter)
  {
    println("All done!");
    exit();
  }
  else
  {
    println("Done with marker " + markerCounter);
    clear();
    background(backgroundClearColor);
  }
}