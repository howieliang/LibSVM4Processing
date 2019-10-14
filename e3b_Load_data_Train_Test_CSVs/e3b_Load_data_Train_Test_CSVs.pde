//*********************************************
// LibSVM for Processing (SVM4P)
// Example 4-2. Load two CSV files of Train/Test Splits
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

  trainData = loadCSV("train.csv", 1); // 1 = scale : Data is not scaled.
  testData = loadCSV("test.csv", 1); // 1 = scale : Data is not scaled.
  if (trainData.size()>0) { //get the d = "feature number" from the training data
    d = trainData.get(0).dof;
  }
  //Which means that the d of the testData has to be the same.
  //train the model once it's loaded
  svmTrained = false; 
  firstTrained = true;
}

void draw() {
  background(255);
  fill(52);
  text(info, 10, 20);
  if (!svmTrained && firstTrained) {
    trainLinearSVC(d, C);
    println("Confusion Matrix: Training Set");
    printTrainConfMatrix();
   
    //calculate your in-sample precisions, recalls, and F1 scores with trainConfMatrix[][].
    //*************************************************************************************
    //for (int i = 0; i < trainConfMatrix.length; i++) {
    //  for (int j = 0; j < trainConfMatrix[0].length; j++) {
    //    print(trainConfMatrix[i][j]);
    //    print('\t');
    //  }
    //  print('\n');
    //}

    println("Confusion Matrix: Testing Set");
    outOfSample_accuracy = evaluateTestSet(testData);
    printTestConfMatrix();
    
    //calculate the out-of-sample precisions, recalls, and F1 scores with testConfMatrix[][].
    //*************************************************************************************
    //for (int i = 0; i < testConfMatrix.length; i++) {
    //  for (int j = 0; j < testConfMatrix[0].length; j++) {
    //    print(testConfMatrix[i][j]);
    //    print('\t');
    //  }
    //  print('\n');
    //}

    info+="\nData #: "+trainData.size() + "\nFeature #: "+trainData.get(0).dof + "\nClass #: "+svm.svm_get_nr_class(model);
    info+="\nDone.\n[In-Sample Accuracy:] "+nf ((float)best_accuracy*100, 1, 2)+"%\n[Testing]";
    info+="\nDone.\n[Out-of-Sample Accuracy:] "+nf ((float)outOfSample_accuracy*100, 1, 2)+"%";
  }
}
