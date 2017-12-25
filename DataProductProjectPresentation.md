Find Out Your Iris Species
========================================================
title: "Find Out Your Iris Species"
transition: rotate
font-family: 'Helvetica'
width: 1440
height: 900



Wenzhao Wu

Dec 25,2017





Background
========================================================
The famous iris dataset gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris. 

<small>A brief summary of the dataset is shown below:
</small>


```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

In this app, users can input their own flower shape and find out the probabilities of iris species the customized flower belonged to.

How does the app work
========================================================

In the input panel, four probability density graphs are shown for each measurement of the flower. Different specis is painted with different color to give users a visual sense about the border for each species in specific measurement.

<img src="DataProductProjectPresentation-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="1440px" height="720px" />


How does the app work
========================================================

Users can use the app following two simple steps

- Slide the white button below each figure to choose the shape of the flower.
- Hit 'Classify My Iris' button to find out the species of the flower

Prediction result is shown as probabilities for each species according to the user's input.


<small>One example of the result is shown here:
</small>


```
  setosa versicolor virginica
1    0.2       0.73      0.07
```

Model behind the app
========================================================

- Random forest model is used to build the classifier of this app. 
-  fold cross validation is implemented to avoid overfitting. 
- Accuracy of the model is up to 95% with kappa value 0.93.


```
Random Forest 

150 samples
  4 predictor
  3 classes: 'setosa', 'versicolor', 'virginica' 

No pre-processing
Resampling: Cross-Validated (10 fold) 
Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
Resampling results across tuning parameters:

  mtry  Accuracy   Kappa
  2     0.9600000  0.94 
  3     0.9600000  0.94 
  4     0.9533333  0.93 

Accuracy was used to select the optimal model using  the largest value.
The final value used for the model was mtry = 2. 
```













