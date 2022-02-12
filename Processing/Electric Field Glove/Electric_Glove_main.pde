
import processing.sound.*;
import processing.serial.*;
int array_size = 17;

// Variables Reading
Serial myPort;                                     // Create object from Serial class
String val;                                        // Elcetric field value
String[] Strings = new String[array_size+3];       //Array of temp values
int[] Values;                                      // 17 ms Values
float freqs;
boolean null_flag = true;
int counts = 0;
ArrayList<int[]> VecList = new ArrayList<int[]>();

// Sine Waves and sounds
SinOsc sineWaves[]; 
float sineVolume;
float frequency;      
float sineFreq[];
int numSines = array_size; // Number of oscillators to use

PImage glove,instrukcja,icon;
PFont font, font2, font3;

//Guziki
int instruction =1;
int rectX, rectY;      // Position of square button
int rectSize = 25;     
color rectColor;
color rectHighlight;
boolean rectOver = false;
Guziki Rect;

Frequency_show fre;  //Czestotliwośc
srednia mean;        // Mean
Elec_Line temp_line; //Gradinet line


void setup()
{
  frameRate(20);
  background(0,0,0);
  size(490,700);
  
  glove = loadImage("glove final 2.png");
  instrukcja = loadImage("instrukcja.png");
  icon = loadImage("glove icon.png");
  font = createFont("Revamped-X3q1a.ttf",20);
  font2 = createFont("TickingTimebombBb-RB0l.ttf",20);
  font3 = createFont("Arial Bold", 18);

  //Port downloading
  String portName = Serial.list()[4]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  mean = new srednia();
  fre = new Frequency_show();
  
  //Tworzenie Przycisku
  rectColor = color(256,256,256);
  rectHighlight = color(256/2,125,200+50);  
  rectX = 150;
  rectY = 620;
  Rect = new Guziki();
  Rect.start(rectX,rectY,rectSize*7-10,rectSize*2,rectColor,rectHighlight,28);


  // Create the oscillators
  sineVolume = (1.0/17) /(1);
  sineFreq = new float[numSines]; // Initialize array for Frequencies
  sineWaves = new SinOsc[numSines];
  for (int i = 0; i < numSines; i++) {
      // Calculate the amplitude for each oscillator
      float sineVolume = (1.0 / numSines) / (i + 1);
      // Create the oscillators
      sineWaves[i] = new SinOsc(this);
      // Start Oscillators
      sineWaves[i].play();
      // Set the amplitudes for all oscillators
      sineWaves[i].amp(sineVolume);
  }
} 
void draw()
{
  background(0,0,0);
  textFont(font,30);
  textAlign(CENTER, CENTER);
  text("REKAWICA KREACJUSZA",width/2,45);
  imageMode(CENTER);
  image(glove,(width/2),(height/2 +75), (glove.width/3), glove.height/3);

  Rect.update(mouseX, mouseY);
  background(0, 0, 0);

  if (Rect.rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  Rect.show();
  
  if (instruction%2 ==0){
   
    background(0,0,0);
    textFont(font, 16);
    textAlign(CENTER, CENTER);
    text("Z BAJEK ROBOTOW - SKARBY KROLA BISKALARA" +"\n" + "A MOZE BY TAK ZALOZYC INTELIGENTNE UBRANIE", width/2, height/2-255);
    
    textFont(font,30);
    textAlign(CENTER, CENTER);
    text("REKAWICA KREACJUSZA",width/2,45);
    
    image(instrukcja,(width/2),(height/2)+50, (instrukcja.width)/1.4, (instrukcja.height)/1.4);
    stroke(255);
    
    if (Rect.rectOver) {
    fill(rectHighlight);
    } 
    else {
    fill(rectColor);
    }
    Rect.show();
    
    imageMode(CENTER);
    image(icon, (width/2)-10, 645, (icon.width)/4, (icon.height)/4);
  }
  else{
      textFont(font, 16);
      textAlign(CENTER, CENTER);
      text("Z BAJEK ROBOTOW - SKARBY KROLA BISKALARA" +"\n" + "A MOZE BY TAK ZALOZYC INTELIGENTNE UBRANIE", width/2, height/2-255);
      textFont(font,30);
      textAlign(CENTER, CENTER);
      text("REKAWICA KREACJUSZA",width/2,45);
      
      imageMode(CENTER);
      image(glove,(width/2),(height/2 +75), (glove.width/3), glove.height/3);
      Rect.show();

      counts = counts +1;
      Serial_decoding();
      if (null_flag) {
      
          mean.start(VecList.get(VecList.size()-1),array_size,165,610);
          mean.Show();
          for (int j =VecList.size(); j >0; j--)
          {
          
          int[] temp_values = VecList.get(j-1);
          for( int i=0; i < array_size-1; i++){
             if (temp_values[i] >25){
              temp_values[i] = 25;
             }
             if (temp_values[i+1] >25){
               temp_values[i+1] = 25;
             }
             fre.start(freqs,125,440);
             fre.ShowText();
             fre.ShowBar();
             float detune = map(temp_values[i], 0, 25, -2, 10);
             float yoffset = map(temp_values[i], 0, 30, 0, 1);
             float frequency = pow(5000, yoffset);

             sineFreq[i] = frequency*i* detune;
             sineWaves[i].freq(sineFreq[i]);
        
             stroke(0,0,0,256-25.6*j);
             temp_line= new Elec_Line();
             temp_line.start((((width-width*1/3)*0.1*i) +455)/3.09,500+map(temp_values[i],0,25,100,height/array_size)-j*10,(((width-width*1/3)*0.1*(i+1)) +455)/3.09,500+map(temp_values[i+1],0,25,100,height/array_size)-j*10,(256-25.6*j)+100,j*10-100);
             temp_line.DrawPoint();
             if (Rect.rectOver) {
                fill(rectHighlight);
              } 
              else {
                fill(rectColor);
              }
              Rect.show();
              
              textFont(font3,20);
              fill(255,255,255);
              textAlign(CENTER,CENTER);
              text("POWRÓT", width/2-10, 640);
             
            }
          }
       }
    }
 }
 



void Serial_decoding(){
    
  if ( myPort.available() > 0) 
  {
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  if (val != null)
  {
    null_flag = true; 
    Strings = split(val,' ');
    Values = int(subset(Strings,0,array_size));
    VecList.add(Values);
    freqs = float(Strings[array_size+1]);
    if (VecList.size() >10){
       VecList.remove(0)  ;
    }

  }
  else{
   null_flag = false; 
  }
}

void mousePressed() {
  if (Rect.rectOver) {
    instruction = instruction+1;
  }
}
