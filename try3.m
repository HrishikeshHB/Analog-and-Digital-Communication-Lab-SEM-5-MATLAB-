clc
clear all
close all
n = input('Length = ');
y = rand(1,n);
z = randn(1,n);

var = input('Variance = ');
mean = input('Mean = ');

gauss = z*var+mean;
uniform = y*(20*pi)-10*pi;

subplot(4,1,1)
histogram(y)
grid on
subplot(4,1,2)
histogram(y,'Normalization','pdf')
grid on
subplot(4,1,3)
histogram(z)
grid on
subplot(4,1,4)
histogram(z,'Normalization','pdf')
grid on

figure
subplot(4,1,1)
histogram(gauss)
grid on
subplot(4,1,2)
histogram(gauss,'Normalization','pdf')
grid on
subplot(4,1,3)
histogram(uniform)
grid on
subplot(4,1,4)
histogram(uniform,'Normalization','pdf')
grid on

