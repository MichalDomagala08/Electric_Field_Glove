class Guziki{
  int instruction =1;
  int rectX, rectY, r;      // Position of square button
  int rectSize1;    
  int rectSize2;     
  color rectColor, baseColor;
  color rectHighlight;
  color currentColor;
  boolean rectOver = false;
  boolean circleOver = false;
    
  void start(int rect_X,int rect_Y, int Size , int Size2, color Color, color Highlight,int radius){
    rectX = rect_X;
    rectY = rect_Y;
    rectSize1 = Size;
    rectSize2 = Size2;
    r = radius;
  
    rectColor = Color;
    rectHighlight = Highlight;
  }
  
  void show(){
    rect(rectX,rectY,rectSize1,rectSize2,r);
  }
  void update(int x, int y) {
     if ( overRect(rectX, rectY, rectSize1, rectSize2) ) {
      rectOver = true;
      circleOver = false;
    } else {
      circleOver = rectOver = false;
    }
  }
  
  boolean overRect(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
