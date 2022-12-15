/* Polyhedron
 * Approximates a sphere by rendering a
 * polyhedron made of a bunch of triangles connected to each other
 * NOTE: the current "export" processes is:
     1. save individual frames to a series of image files
     2. export using Tools -> Movie Maker or an online tool
 */

// If this is true, the program will
// export all 400 frames of animation into the "output" older
boolean recording = false;

void setup() {
  size(600, 600, P3D);
  noStroke();
}

void draw() {
  background(128);
  
  // center the shape in the center of the screeen
  translate(width/2, height/2);
  
  // Rotate the shape for animation
  float t = frameCount * (TWO_PI / 400);
  rotateX( sin(t) * PI );
  
  float SLICES = 10;
  float STEP = PI / SLICES;
  
  float radius = 200;
  for (float a = 0; a < PI; a += STEP) {
    // For each "ring" in the "sphere",
    // calculate its radius & distance from the top
    float offset = cos(a) * radius;
    float r = sin(a) * radius;
    
    // Calculate the "next" (lower) ring
    // so that the bottom left and right vertexes can be drawn
    float nextOffset = cos(a + STEP) * radius;
    float nextR = sin(a + STEP) * radius;
    
    for (float b = 0; b < TWO_PI; b += STEP / 2) {
      // "Up" facing trianbles are white
      fill(255);
      beginShape();
      
      // Triangle top vertex
      float topX = r * cos(b);
      float topY = r * sin(b);
      vertex(topX, topY, offset);
      
      // Triangle bottom-left vertex
      float blX = nextR * cos(b - STEP/2);
      float blY = nextR * sin(b - STEP/2);
      vertex(blX, blY, nextOffset);
      
      // Triangle bottom-right vertex
      float brX = nextR * cos(b + STEP/2);
      float brY = nextR * sin(b + STEP/2);
      vertex(brX, brY, nextOffset);
      endShape(CLOSE);
      
      // "Down" facing triangles are black
      fill(0);
      beginShape();
      
      // Calculate the black triangle's bottom vertx
      // and use the already known other vertexes
      float nextX = r * cos(b + STEP);
      float nextY = r * sin(b + STEP);
      vertex(topX, topY, offset);
      vertex(nextX, nextY, offset);
      vertex(brX, brY, nextOffset);
      endShape(CLOSE);
    }
  }
  
  // export to a folder of PNG files
  if (recording) {
    if (t < TWO_PI)
      saveFrame("output/frame-###.png");
    else
      exit();
  }
}
