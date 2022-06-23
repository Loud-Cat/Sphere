/* Approximating A Sphere
 * This demo uses many tiny spheres to roughly
 * approximate the shape of a sphere
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
  rotateX(frameCount / 100);
  rotateY(frameCount / 100);
  normalMaterial();

  let step = PI / 25;
  let radius = min(width, height) / 3;
  for (let t = 0; t < PI + step; t += step) {
    let offset = cos(t) * radius;
    let r = abs( sin(t) ) * radius;

    for (let t2 = 0; t2 < TWO_PI; t2 += PI / 8) {
      let x = r * cos(t2);
      let y = r * sin(t2);
      
      push();
      translate(x, y, offset);
      sphere(5);
      pop();
    }
  }
  
  // stop looping after one full animation
  if (stop_anim && frameCount / 100 >= TWO_PI)
    noLoop();
}
