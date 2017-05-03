import java.io.BufferedWriter;
import java.io.FileWriter;

int featureNum = 2;
int labelIndex = featureNum;
ArrayList<Data> dataList;
boolean showInfo = true; //Show the info of results (or not)
int type = 0;
float noise = 10;

String[] svmData;
String fileName = "out.txt";
boolean b_save = false;

//Table table;
//String fileName = "data/testData.scale";


void setup() {
  size(500, 500);
  ellipseMode(CENTER);
  dataList = new ArrayList<Data>();
  //table = new Table();
  //table.addColumn("x");
  //table.addColumn("y");
  //table.addColumn("label");
}

void draw() {
  background(255);
  if (b_save) {
    int size = dataList.size();
    if (size>0) {
      svmData = new String[size];
      for(int i = 0 ; i < size ; i++){
        Data d = (Data)dataList.get(i);
        String s = "";
        s += d.label;
        s += ' ';
        for(int j = 0 ; j < d.features.length-1 ; j ++){
          s += (j+1);
          s += ':';
          s += (int) d.features[j];
          s += ' ';
        }  
        svmData[i] = s; 
      }
      appendTextToFile(fileName, svmData);
      println("Saved as: ", fileName);
    }
    b_save = false;
  }
  drawData (dataList);
  drawInfo (10, 20);
}

void mouseDragged() {
  if (mouseX < width && mouseY < height) {
    double px = (double)mouseX + (-noise/2.+noise*randomGaussian());
    double py = (double)mouseY + (-noise/2.+noise*randomGaussian());
    if (px>=0 && px<=width && py>=0 && py<=height) { 
      double[] p = {px, py, type};
      dataList.add(new Data(p));
    }
  }
}

void keyPressed() {
  if (key >= '0' && key <= '9') {
    type = key-'0';
  }
  if (key == '/') {
    dataList.clear();
    type = 0;
  }
  if (key == 'S' || key == 's') {
    b_save = true;
  }
  if (key == 'I' || key == 'i') {
    showInfo = !showInfo;
  }
}