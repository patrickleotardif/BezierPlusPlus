
Spline testSpline;
PImage logo;
PImage textLogo;
void setup() 
{
  size(600, 600);
  testSpline = null;
  logo = loadImage("b+.png");
  textLogo = loadImage("bezier++.jpg");
  smooth();
  noStroke();
}

void draw() 
{ 
  //Simple white background with logos
  background(255); 
  image(logo,10,10);
  image(textLogo,45,10);
  
  if (testSpline != null)
    testSpline.render();
  noFill();


}

void mousePressed() {
  if (mouseButton == RIGHT) {
      if (testSpline != null) {
        if (!testSpline.lock())
          testSpline.addCurve();
      }
      else
        testSpline = new Spline();
  }
  else if (mouseButton == LEFT) {
    if (testSpline != null) {
      if (!testSpline.lock()) {
        testSpline.curves[testSpline.activeIndex].plusplus();
      }
    }
  }
}

void mouseDragged() {
  if (testSpline != null)
    testSpline.drag();
}

void mouseReleased() {
  if (testSpline != null)
    testSpline.unlockAll();

}



