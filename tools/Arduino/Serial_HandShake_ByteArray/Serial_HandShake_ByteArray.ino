#define PIN_NUM 3
int analogInPin[PIN_NUM] = {A0, A1, A2};
byte data[PIN_NUM];
void setup(){
  Serial.begin(115200);
}
void loop(){
  for (int i = 0; i < PIN_NUM; i++) data[i] = analogRead (analogInPin[i])>>2;
  if (Serial.available() && (char)Serial.read() == 'a') Serial.write(data, PIN_NUM);
}
