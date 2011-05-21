//A curve refers to single Bezier curve of variable order

class Curve {
  //Control points
  Node[] controls;
  
  //First node
  Node first;
  //Last node
  Node last;
  //Order
  int order;
  
  //Constants
  final color LINECOLOR = color(130);
  final float STEPSIZE = 0.0001;
  final color POLYCOLOR = color(#86CBFF);
  final int POLYALPHA = 100;
  
  //Constructor for the first curve of a spline
  Curve() {
    first = new Node(mouseX,mouseY,'p');
    last = null;
    controls = null;
    order = 0;
  }
  
  //Constructor for an curve already part of a spline
  Curve(Node previous) {
    first = previous;
    last = new Node(mouseX,mouseY,'p');
    controls = null;
    order = 1;
  }
  
  void plusplus(){
    Node[] newControls;
    
    if (order >0) {
      newControls = new Node[order];
      
      if (order != 1) {
        for (int i=0;i<controls.length;i++) {
          newControls[i] = controls[i];
        }
      }
      
      newControls[order-1] = newControlCreator();
      controls = newControls;
      order++;
    }
      
    
  }
  
  Node newControlCreator() {
    int newX;
    int newY;
    switch (order) {
      case 1:
        return new Node(int((first.x+last.x)/2),int((first.y+last.y)/2),'c');
      case 2:
        newX = int((last.x+(2*controls[0].x))/3);
        newY = int((last.y+(2*controls[0].y))/3);
        controls[0].x = int((first.x+(2*controls[0].x))/3);
        controls[0].y = int((first.y+(2*controls[0].y))/3);
        return new Node(newX,newY,'c');
      default:
        return new Node(mouseX, mouseY, 'c');
    }
  }
  
  //Draws the curve
   void trace() {
     
     switch (order) {
       case 1:
          linear();
          break;
        case 2:
          quadratic();
          break;
        case 3:
          cubic();
          break;
     }
     update();
 
   }
   
   //Method for linear case
   void linear() {
     stroke(LINECOLOR);
     noFill();
     line(first.x,first.y,last.x,last.y); 

   }
   
   //Method for quadratic case;
   void quadratic() { 
    fill(POLYCOLOR,POLYALPHA);
    noStroke();
    smooth();
    triangle(first.x,first.y,controls[0].x,controls[0].y,last.x,last.y);
    
    fill(255);
    stroke(LINECOLOR);
    smooth();
    beginShape();
    for(float t=STEPSIZE;t<1;t+=STEPSIZE) {
      vertex( pow(1-t,2)*first.x + 2*(1-t)*t*controls[0].x + pow(t,2)*last.x,
              pow(1-t,2)*first.y + 2*(1-t)*t*controls[0].y + pow(t,2)*last.y);
    }
    endShape();    
   }
   
   void cubic(){
     fill(POLYCOLOR,POLYALPHA);
     noStroke();
     smooth();
     quad(first.x,first.y,controls[0].x,controls[0].y,controls[1].x,controls[1].y,last.x,last.y);
     
     fill(255);
    stroke(LINECOLOR);
    smooth();
    bezier(first.x,first.y,controls[0].x,controls[0].y,controls[1].x,controls[1].y,last.x,last.y);
   }
  
  //Update the status of nodes
  void update() {
     first.update();
     if (last != null)
       last.update();
     if (controls != null) {
       for (int i=0;i<controls.length;i++) {
         controls[i].update();
       }
     }
     
   }
   
   //Locks a single node
   boolean lock() {
     if (first.lock())
       return true;
     else if (last != null) {
       if (last.lock())
       return true;
     }
     if (controls != null) { 
       for (int i=0;i<controls.length;i++) {
         if (controls[i].lock()) 
           return true;
       }
     }
     return false;
     
   }
   
   //Drag the nodes appropriately
   void drag() {
     first.drag();
     if (last != null)
       last.drag();
     if (controls != null) {
       for (int i=0;i<controls.length;i++) {
         controls[i].drag();
       }
     }
   }
   
   //Unlock all nodes
   void unlockAll() {
     first.locked = false;
     if (last != null)
       last.locked = false;
     if (controls != null) {
       for (int i=0;i<controls.length;i++) {
         controls[i].locked = false;
       }
     }
   }
   
  float bezierthree(float[][] p, float t, int i) {
  return pow((1-t),3)*p[0][i] + 3*pow((1-t),2)*t*p[1][i] + 3*(1-t)*pow(t,2)*p[2][i] + pow(t,3)*p[4][i];
  }

  float bezierfour(float[][] p, float t, int i) {
  return pow((1-t),4)*p[0][i] + 4*pow((1-t),3)*t*p[1][i] + 6*pow((1-t),2)*pow(t,2)*p[2][i] + 4*(1-t)*pow(t,3)*p[3][i] + pow(t,4)*p[4][i];
  }

   
 }
    
