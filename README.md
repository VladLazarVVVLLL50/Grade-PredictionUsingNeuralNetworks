# Grade Prediction Using Neural Networks

## Project Overview

This project aims to predict student grades in a Portuguese language course using machine learning regression techniques. The dataset used for this project is `student-por.csv`, which contains various characteristics of students, such as their school, age, study time, family relationships, and more. The goal is to develop models that can predict final grades based on these features.

## Dataset

The dataset `student-por.csv` includes the following features for each student:
- **School**: The school attended (binary: "GP" - Gabriel Pereira or "MS" - Mousinho da Silveira)
- **Sex**: Gender of the student (binary: "F" - Female or "M" - Male)
- **Age**: Student’s age (numeric: 15 to 22)
- **Address**: Type of home address (binary: "U" - Urban or "R" - Rural)
- **Family Size**: Family size (binary: "LE3" - Less than or equal to 3 or "GT3" - Greater than 3)
- **Parental Status**: Whether the parents live together (binary: "T" - Together or "A" - Apart)
- **Mother’s and Father’s Education**: Education levels from 0 (none) to 4 (higher education)
- **Parent’s Job**: Various job categories, such as "teacher", "health", "services", etc.
- **Other Features**: Study time, failures, family relationships, and more.

## Algorithms Implemented

The project implements three optimization algorithms for training a neural network to predict student grades:

### 1. Gradient Descent
The gradient descent algorithm minimizes the error by iteratively adjusting the network's parameters. The process is tracked by monitoring the error and gradient norms at each step. 

Key results for 10,000 iterations:
- **Final Error**: 9.3017
- **Mean Square Error**: 39.3558

### 2. Stochastic Gradient Descent
Stochastic gradient descent (SGD) updates parameters using random samples, allowing for faster convergence, although with more variability in the path to the solution.

Key results for 100,000 iterations:
- **Final Error**: 3.4356
- **Mean Square Error**: 10.1466

### 3. Accelerated Gradient Descent
This method introduces momentum to speed up convergence compared to the traditional gradient descent. It typically reaches lower errors in fewer iterations.

Key results:
- **Final Error**: 3.5504 (after 1,000 iterations)

## Performance Summary

Each algorithm provides different results:
- **Gradient Descent** achieves relatively stable convergence but may get stuck in local minima.
- **Stochastic Gradient Descent** shows the best performance overall due to its ability to escape local minima and saddle points.
- **Accelerated Gradient Descent** converges the fastest but may not always reach the best possible error.



