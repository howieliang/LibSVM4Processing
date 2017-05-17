//*********************************************
// LibSVM for Processing (SVM4P)
// Example 0. Build Your App
// Rong-Hao Liang: r.liang@tue.nl
// The Example is based on the original LibSVM library
// LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/
//*********************************************
// A template for building an App involved support vector machine (SVM).

//The SVM parameters
double C = 64;
int d = 3; //feature number

import processing.serial.*;
Serial port; 
int[] rawData;

float[] histX, histY, histZ, modeN;
boolean isSampling = false;

void setup() {
  size(500, 640);
  String portName = Serial.list()[Serial.list().length-1];
  port = new Serial(this, portName, 115200);
  port.write('a');

  rawData = new int[d];
  histX = new float[width];
  histY = new float[width];
  histZ = new float[width];
  modeN = new float[width];
  for (int i = 0; i < width; i++) {
    modeN[i] = -1;
  }
  
  //// Uncomment to load a model that you just trained.
  //model = loadSVM_Model(sketchPath()+"/data/test.model");
  //svmTrained = true;
  //firstTrained = false;
}

void draw() {
  if (!svmTrained && firstTrained) {
    //train a linear support vector classifier (SVC) 
    trainLinearSVC(d, C);
  }

  background(255);
  fill(52);
  textSize(36);
  text("Current Label: "+type+"\nData Count: "+tCnt, 10, 36);
  getSerialMsg();

  if (mousePressed) {
    Data newData = new Data(new double[]{(float)rawData[0]/255., (float)rawData[1]/255., (float)rawData[2]/255., type});
    trainData.add(newData);
    ++tCnt;
    isSampling = true;
  } else {
    isSampling = false;
  }

  appendArray(modeN, (isSampling? type : -1));
  appendArray(histX, rawData[0]);
  appendArray(histY, rawData[1]);
  appendArray(histZ, rawData[2]);

  lineGraph(histX, 0, 255, 0, .5*height, height/2, width, color(255, 0, 0));
  lineGraph(histY, 0, 255, 0, .5*height, height/2, width, color(0, 255, 0));
  lineGraph(histZ, 0, 255, 0, .5*height, height/2, width, color(0, 0, 255));
  barGraph(modeN, 0, 100, 0, .5*height, height/2, width);

  if (svmTrained) {
    double[] testData = {(float)rawData[0]/255., (float)rawData[1]/255., (float)rawData[2]/255.};
    int predict = (int) svmPredict(testData);
    drawPredict(predict);
  }
}

void getSerialMsg() {
  int i = 0;
  while ( port.available () > 0) {
    if (i < d) {
      rawData[i] = (int)port.read();
      i++;
    } else {
      i = d;
      break;
    }
  }
  if (i == d) {
    port.clear();
    port.write('a');
  }
}

void keyPressed() {
  if (key == ENTER) {
    if (tCnt>0 || type>0) {
      if (!firstTrained) firstTrained = true;
      resetSVM();
    } else {
      println("Error: No Data");
    }
  }
  if (key >= '0' && key <= '9') {
    C = pow(2, key - '0');
    if (!firstTrained) firstTrained = true;
    resetSVM();
  }
  if (key == TAB) {
    if (tCnt>0) { 
      if (type<(colors.length-1))++type;
      tCnt = 0;
    }
  }
  if (key == '/') {
    firstTrained = false;
    resetSVM();
    clearSVM();
  }
  if (key == 'S' || key == 's') {
    if (model!=null) { 
      saveSVM_Model(sketchPath()+"/data/test.model", model);
      println("Model Saved");
    }
  }
}

//Functions for visualization

void drawPredict(int predict) {
  pushStyle();
  rectMode(CENTER);
  fill(colors[predict]);
  rect(width/2, height-(height-width)/2, width-1, (height-width-1));
  noStroke();
  popStyle();
}

float[] appendArray (float[] _array, float _val) {
  float[] array = _array;
  float[] tempArray = new float[_array.length-1];
  arrayCopy(array, tempArray, tempArray.length);
  array[0] = _val;
  arrayCopy(tempArray, 0, array, 1, tempArray.length);
  return array;
}

void lineGraph(float[] data, float l_, float u_, float x_, float y_, float h_, float w_, color c) {
  pushStyle();
  float x = x_;
  float y = y_;
  float delta = w_/data.length;
  beginShape();
  noFill();
  stroke(c);
  for (float i : data) {
    float h = map(i, l_, u_, 0, h_);
    vertex(x, h);
    x = x + delta;
  }
  endShape();
  popStyle();
}

void barGraph(float[] data, float l_, float u_, float x_, float y_, float h_, float w_) {
  pushStyle();
  noStroke();
  float x = x_;
  float y = y_;
  float delta = w_/data.length;
  for (int p = 0; p < data.length; p++) {
    float i = data[p];
    int cIndex = (int) i;
    if (i<0) fill(255, 100);
    else fill(colors[cIndex], 100);
    float h = map(u_, l_, u_, 0, h_);
    rect(x, y-h, delta, h);
    x = x + delta;
  }
  popStyle();
}