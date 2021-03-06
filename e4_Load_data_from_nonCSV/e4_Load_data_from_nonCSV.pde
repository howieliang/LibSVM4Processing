//*********************************************
// LibSVM for Processing (SVM4P)
// Example 4. Load a non-CSV file
// Rong-Hao Liang: r.liang@tue.nl
// The Example is based on the original LibSVM library
// LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/
//*********************************************
// A toy example that demonstrates the capability of multi-class classification on a 2D SVM.
// Input: A Dataset in non-CSV file format
// Output: A model for classifying the mouse position based on the model loaded.

double C = 64;
int d = 2; //feature number

String info = "[Training]";

void setup() {
  size(500, 640);
  
  //load a non-CSV file for training and classification
  //trainData = loadData("out.txt", 2); 
  trainData = loadData("dna.scale", 180); // 2000 3
  //load and scale a non-CSV file for training and classification
  //trainData = loadDataScaled("pendigits100",16,100); //7494 10

  //Other examples
  //trainData = loadData("satimage.scale",36); //4435 6
  //trainData = loadData("letter.scale", 16); //15000 26

  //Use the trained SVM to test
  //testData = loadData("out.txt", 2); // 2000 3
  testData = loadData("dna.scale.t", 180);
  //testData = loadData("satimage.scale.t",36); //4435 6
  //testData = loadDataScaled("pendigits100",16,100); //7494 10
  //testData = loadData("letter.scale.t", 16); //15000 26
  
  if (trainData.size()>0) {
    d = trainData.get(0).dof;
  }
  svmTrained = false;
  firstTrained = true;
}

void draw() {
  background(255);
  fill(52);
  text(info, 10, 20);
  if (!svmTrained && firstTrained) {
    trainLinearSVC(d, C);
    println("In-sample confusion matrix");
    printTrainConfMatrix();
    outOfSample_accuracy = evaluateTestSet(testData);
    println("Out-of-sample confusion matrix");
    printTestConfMatrix();
    info+="\nData #: "+trainData.size() + "\nFeature #: "+trainData.get(0).dof + "\nClass #: "+svm.svm_get_nr_class(model);
    info+="\nDone.\n[In-Sample Accuracy:] "+nf ((float)best_accuracy*100, 1, 2)+"%\n[Testing]";
    info+="\nDone.\n[Out-of-Sample Accuracy:] "+nf ((float)outOfSample_accuracy*100, 1, 2)+"%";
  }
}
