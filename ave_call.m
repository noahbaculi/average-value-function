% utilizing example from https://www.whitman.edu/mathematics/calculus_online/section09.04.html

func = @(x) 16*x^2+5;
num_points = 1000;
range = [1,3];
method = 'Uniform';

f_ave = ave(func,num_points,range,method);

example_ave = 223/3;

fprintf('The average value of %s on the specified range utilizing the %s method is %.2f.\n',func2str(func),method,f_ave)
fprintf('The expected value of @(x)16*x^2+5 on the range [1,3] is theoretically 223/3, or %.2f.\n', example_ave)
