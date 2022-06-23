/* Approximating a sphere
 * In this demo, we will use rings (tori) to
 * roughly display a sphere
 */

// When this variable is true, the animation will
// Stop after one finished animation to make it easier
// To export via screen recorder
let stop_anim = true;

function setup() {
  createCanvas(windowWidth, windowHeight, WEBGL);
  noStroke();
}

function draw() {
  background(225);
  rotateX(frameCount / 150);
  rotateY(frameCount / 150);
  normalMaterial();

  let radius = min(width, height) / 3;
  for (let t = 0; t < PI; t += PI / 25) {
    let offset = cos(t) * radius;
    let r = abs( sin(t) ) * radius;

    push();
    translate(0, 0, offset);
    torus(r, 2);
    pop();
  }
  
  // stop looping after one full animation
  if (stop_anim && frameCount / 150 >= TWO_PI)
    noLoop();
}
