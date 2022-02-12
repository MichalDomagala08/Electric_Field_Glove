int inPin = 5; 
int val = 0;              
int val_org =0;
int pin11 = 11;      
int count = 0;
int vec_size= 17;
int vec[17];
int vec_rep;
int s =0;
float temp_freq;

void setup() {
  Serial.begin(9600);
}

float freq(int vector[17]){
    float zeros_counts = 0.0;
    for(int i = 0; i < vec_size; i++){
      Serial.print(vector[i]);
      Serial.print(' ');

      if (int(vector[i]) !=int(0))
      {
        zeros_counts +=1;
      }
       vec[i] = 0;
    }
    return zeros_counts*6;

}
void loop() {
  count += 1;
  val = analogRead(inPin); 
    
  if (count <=vec_size){
    delay(1);
    if (val >3){
      val_org = constrain(val, 1, 100);                                      
      val = map(val_org, 1, 100, 1, 255);  
      vec[count] = val_org;
      analogWrite(pin11, val);
    }
    else{
      analogWrite(pin11, 0); 
    }
  }
  else{

    for (int i=0; i< vec_size; i++)
    {
       s += vec[i];
    }
    
    temp_freq = freq(vec);
    Serial.print("freq: ");
    Serial.print(temp_freq);
    Serial.print(' ');
    Serial.println(); 
    
    count  = 0;
    vec_rep = s/vec_size;
    s = 0;
  }
}
