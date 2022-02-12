class srednia{
    
  int [] Values;
  int array_size;
  float mean,suma;
  int X,Y;
  
  void start(int[] values, int size, int Xpos, int Ypos){
    Values = values;
    array_size = size;
    suma = 0;
    X = Xpos;
    Y = Ypos;
    
    for (int i=0; i < array_size; i++)
    {
      suma = suma + Values[i];
    }
    mean = suma/array_size;
  }
  
  
  void Show(){
    textFont(font,12);
    textAlign(LEFT, LEFT);
    text("Potencjal: " , X-15,Y);
    text(mean,X+90,Y);
  }
}
