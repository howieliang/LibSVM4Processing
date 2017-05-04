# LibSVM-for-Processing
A processing library for support vector classification and regression based on LibSVM.

by Rong-Hao Liang: r.liang@tue.nl

Without installing a library, you can perform SVM classification in processing with these examples.
The Example is based on the original LibSVM library
(LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/)

- Example 0. Build your App
A template for building an App involved support vector machine (SVM).

- Example 1. Train a Linear SV Classifier
Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
Output: A Linear SVM model for classifying the mouse position.

- Example 2. Load a Linear SV Classifier
Input: A SVM model.
Output: Classifying the mouse position based on the model loaded.

- Example 3. Load Data from CSV (Comma-Separated Values) files
Input: A Dataset in CSV file format.
Output: A model for classifying the mouse position based on the model loaded.

- Example 4. Load Data from non-CSV (Comma-Separated Values) files
Input: A Dataset in non-CSV file format.
Output: A model for classifying the mouse position based on the model loaded.

- Example 5. Train an RBF SV Classifier
Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
Output: An RBF-Kernel SVM model for classifying the mouse position.

- Example 6. Grid Search (for overfitting prevention)
Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
Output: A Linear- or RBF-Kernel SVM model with the best parameters in grid search.

Tools for generating CSV file is also provided
- CSV generator
Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
Output: A CSV file contains all the mouse position with label.

- SVMData generator
Input: Labelled data formed by Click and Drag the mouse cursor on the canvas.
Output: A SVM standard file contains all the mouse position with label.

More Dataset
- More Data set are available on the LibSVM Website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/

