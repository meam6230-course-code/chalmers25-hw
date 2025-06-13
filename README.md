# Chalmers Figueroa PhD Course Homework (Summer 2025)

Maintainers: Contact 2025 Spring semester TAs

This repo is the course homework repo for the PhD course on Learning and Control for Adaptive and Reactive Robots @ Chalmers.

The libraries and exercises have been adapted from the Matlab code published alongside the textbook ["Learning for Adaptive and Reactive Robot Control: A Dynamical Systems Approach"](https://mitpress.mit.edu/9780262046169/learning-for-adaptive-and-reactive-robot-control/) by Aude Billard, Sina Mirrazavi and Nadia Figueroa with MIT Press in 2022. 

Original book code found here: [https://github.com/learningadaptivereactiverobotcontrol/book-code](https://github.com/learningadaptivereactiverobotcontrol/book-code)


---

## MATLAB Pre-Requisites

You will need a version of Matlab from 2019 or higher with the following toolboxes :
- Control System
- Curve Fitting
- Deep Learning
- Image Processing 
- Model Predictive Control
- Optimization
- Robotic System
- ROS 
- Signal Processing
- Statistics and Machine Learning


## Homework Structure:

In general, the entire repo will be in the format of
```
This repo
    |
    |--hw1
    |    |--lib
    |    |--test
    |    |--{some main files}
    |...
    |--hwN
    |     |--lib
    |     |--test
    |     |--{some main files}
    |--libraries
    |--README.md
```

Your goal is to implement all the functions in the lib folder. The main files are for you to understand the context of the functions and create visualizations. The ```test``` folder is what we use to give you grade. It serves as an autograder for you to know if you pass all the tests. It is recommended to first read the main files to understand the context and then start working on the functions.

## Usage

#### Running main files
In case you are not familiar with MATLAB. The most straighforward way to run any program (for example the main files) is to click on the green arrow button (```says "Run"```) on top in the ```Editor``` tab.

#### Running test files
The test files are called ```pcode```, which the source code are hidden. We use this as an autograder for you to test. To use the test file, you will cd into the test folder and call the ```.p``` file name in the MATLAB command window
```
cd test
{test file name without the .p}
```
