class Elec_Line{
  float x1,x2,y1,y2;
  float tangens,alpha,base_y;
  
  void start(float xpos1, float ypos1,float xpos2, float ypos2,float alph,float basey){
    x1= (xpos1);
    y1= (ypos1);
    x2= (xpos2);
    y2= (ypos2);
    base_y = basey;
    alpha =  alph;
    
  }
  void DrawPoint(){

    if (x2-x1 != 0){
      tangens = (y2-y1)/(x2-x1);
    }
    else{
     tangens = 1; 
    }
    int minim = int(x2-x1);
    
    for (int tm =0;tm < abs(minim); tm++){
        stroke(256-map(y1,425-base_y,490-base_y,0,256)*0.5,100,200+map(y1,425-base_y,490-base_y,0,256)*0.15,alpha);
        
        strokeWeight(2);
        point(x1+1,y1+int(tangens));
        x1=x1+1;
        y1 = y1+tangens;
    }
  }
}
