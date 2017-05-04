//*********************************************
// LibSVM for Processing (SVM4P)
// Example 5. Train a RBF SVM
// Rong-Hao Liang: r.liang@tue.nl
// The Example is based on the original LibSVM library
// LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/
//*********************************************
// A toy example that demonstrates the capability of multi-class classification on a 2D SVM.
// Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
// Output: A RBF-Kernel SVM model for classifying the mouse position

double C = 64;
double gamma = 1.; //additional parameter for RBF SVM
int d = 2; //feature number
boolean isRBF = true;

void setup() {
  size(500, 640);
}

void draw() {
  background(255);
  if (!svmTrained && firstTrained) {
    //train a RBF support vector classifier (SVC)
    if(isRBF) trainRBFSVC(d, gamma, C);
    else trainLinearSVC(d, C);
  }
  //draw the SVM
  if (d == 2) drawSVM();

  if (svmTrained) { 
    //form a test data
    double[] testData = {(double)mouseX/(double)width, (double)mouseY/(double)height};
    int predict = (int) svmPredict(testData);
    drawPrediction(predict, testData);
  } else {
    drawCursor();
  }
  drawInfo(10, height-124);
}

void drawInfo(int x, int y) {
  String manual = "\n- Press [ENTER] to Train the SVM"+
    "\n- Press N=[1-5] to Train an RBF SVM with C=4^N"+
    "\n- Press N=[6-9] to Train an RBF SVM with Gamma=4^(N-9)"+
    "\n- Press N=[0] to Train a Linear SVM with C=1024"+
    "\n- Press [TAB] to change label color"+
    "\n- Press [/] to clear data"+
    "\n- Press [S] to save model";
  if (firstTrained) {
    trainingInfo = "RBF-Kernel SVM, C = "+ nf ((float)C, 1, 0) +", Gamma = "+ nf ((float)gamma, 1, 3) +", In-sample Accuracy = "  + nf ((float)best_accuracy*100, 1, 2) + "%"+ manual;
  } else {
    trainingInfo = "RBF-Kernel SVM, C = "+ nf ((float)C, 1, 0) +", Gamma = "+ nf ((float)gamma, 1, 3) + manual;
  }
  pushStyle();
  stroke(0);
  noFill();
  rectMode(CENTER);
  rect(width/2, width/2, width-1, width-1);
  fill(255);
  rect(width/2, height-(height-width)/2, width-1, (height-width-1));
  stroke(0);
  fill(255, 52);
  noStroke();
  fill(0);
  textSize(12);
  text(trainingInfo, x, y);
  popStyle();
}


void mouseWheel(MouseEvent event) {
  noise += event.getCount();
  if (noise > width) noise = width;
  if (noise < 1) noise = 1;
}

void mouseDragged() {
  if (mouseX < width && mouseY < height) {
    double px = (double)mouseX/(double)width+ (-(noise/2)+noise*randomGaussian())/(4*width);
    double py = (double)mouseY/(double)height+ (-(noise/2)+noise*randomGaussian())/(4*width);
    if (px>=0 && px<=1 && py>=0 && py<= ((double)width/(double)height)) { 
      Data newData = new Data(new double[]{px, py, type});
      trainData.add(newData);
      ++tCnt;
    }
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
  if (key == '0') {
    isRBF = false;
    C = 64;
    if (!firstTrained) firstTrained = true;
    resetSVM();
  }
  if (key >= '1' && key <= '5') {
    isRBF = true;
    C = pow(2, (key - '0')*2);
    gamma = 1;
    if (!firstTrained) firstTrained = true;
    resetSVM();
  }
  if (key >= '6' && key <= '9') {
    isRBF = true;
    C = 64;
    gamma = pow(2, (key - '9')*2);
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