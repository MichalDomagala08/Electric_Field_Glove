class Frequency_show{

  float Frequency,Freq_rel;
  int X,Y;
    
  void start(float frequency, int Xpos, int Ypos){
    Frequency = frequency;
    X = Xpos;
    Y = Ypos;
  }
  
  void ShowText(){
    textFont(font,12);
   textAlign(LEFT, LEFT);

    text("F: " , X-15,Y);
    text(int(Frequency),X+5,Y);
  }
  
  void ShowBar(){
    Freq_rel = map(Frequency,0,60,0,150);
    fill(256/2,125,200+50);
    rect(X,Y+150,20,-Freq_rel);
  }
  
}
