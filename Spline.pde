class Spline {
  Curve[] curves;
  boolean active;
  int activeIndex;
 
  Spline() {
    curves = new Curve[1];
    curves[0] = new Curve();
    active = true;
    activeIndex = 0;
  } 
  
  void addCurve() {
    Curve[] newCurves;
    
    if (curves[activeIndex].order == 0) {
        curves[activeIndex] = new Curve(curves[activeIndex].first);
    }
    else {
       newCurves = new Curve[curves.length + 1];
       
       for (int i=0;i<curves.length;i++) {
         newCurves[i] = curves[i];
       }
       
       newCurves[curves.length] = new Curve(newCurves[curves.length - 1].last);
       activeIndex = curves.length;
       curves = newCurves;  
    }
  }
  
  void render() {
    for (int i=0;i<curves.length;i++) {
         curves[i].trace();
    }
  }
  
  void drag() {
    for (int i=0;i<curves.length;i++) {
         curves[i].drag();
    }
  }
  
  boolean lock() {
    for (int i=0;i<curves.length;i++) {
        if (curves[i].lock())
          return true;    
    }
    return false;
  }
  
  void unlockAll() {
    for (int i=0;i<curves.length;i++) {
         curves[i].unlockAll();
    }
  }
}
