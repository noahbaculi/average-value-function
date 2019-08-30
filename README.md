# average-value-function
Created by Noah Baculi.

Expanded from November 2016 Northwestern University course project.

Set of MATLAB functions to return the average value of a mathematical function.

This project was completed for educational purposes only.
The `ave_call.m` file calls the `ave.m` function, which in turn utilizes the `uniform.m` function.

## How to run:
1. Download the project files and open the directory in MATLAB.
2. Open the `ave_call.m` file to test the `ave` function.
3. To utilize the `ave.m` function in another file, ensure the `ave.m` and `uniform.m` files are in the same directory and call the `ave.m` function using
```
ave(func, num_points, range, method)
```
4. The possible methods are `Uniform`, `Random`, or `Halton`.
5. The function will then return the average value of the passed.
