//A node includes controls points

class Node {
  //Coords
  float x;
  float y;
  
  //Indicators for mouse interaction
  boolean over;
  boolean locked;
  
  //Handlers for mouse interaction
  float difx;
  float dify;
  
  //Size of node
  int nodeSize;
  
  //nodeColor refers to standard color while fill could also be red (if selected)
  color nodeColor;
  color nodeFill;
  
  //Constants
  final color CONTROLCOLOR = color(#0000FF);
  final color POINTCOLOR = color(#000000);
  final color HIGHLIGHTCOLOR = color(#FF0000);
  
  final int CONTROLSIZE = 7;
  final int POINTSIZE = 10;
  
  //Constructor
  Node(int newx, int newy, char type) {
    switch(type){
      case 'p':
        nodeColor = POINTCOLOR;
        nodeSize = POINTSIZE;
        break;
      case 'c':
        nodeColor = CONTROLCOLOR;
        nodeSize = CONTROLSIZE;
        break;    
    }
    x = newx;
    y = newy;
    difx = 0;
    dify = 0;
    over = false;
    locked = false;

  }
  
  //Main display method
  void show(){
    noStroke();
    fill(nodeFill);
    ellipse(x,y,nodeSize,nodeSize);
  }
  
  //Checks if mouse is over the node
  void update(){
    over = (mouseX > x-nodeSize && mouseX < x+nodeSize && mouseY > y-nodeSize && mouseY < y+nodeSize);
    if (over) 
      nodeFill = #FF0000;
    else
      nodeFill = nodeColor;
    
    show();
  }
  
  //Locks node
  boolean lock() {
    if (over) {
      locked = true;
      difx = mouseX - x;
      dify = mouseY - y;
    }
    else {
      locked = false;
    }
    return locked;    
  }
  
  //Moves the node when locked
  void drag() {
    if (locked) {
      x = mouseX - difx;
      y = mouseY - dify;
    }
  }
  
}
