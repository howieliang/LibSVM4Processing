//*********************************************
// LibSVM for Processing (v8)
// Example 0. Build Your App
// Rong-Hao Liang: r.liang@tue.nl
// The Example is based on the original LibSVM library
// LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/
//*********************************************
// A template for building an App involved support vector machine (SVM).

double C = 64;
double gamma = 1.;
int d = 2; //feature number

void setup() {
  size(500, 640);
}

void draw() {
  background(255);
  fill(52);
  text("Hello World!",10,20);
}