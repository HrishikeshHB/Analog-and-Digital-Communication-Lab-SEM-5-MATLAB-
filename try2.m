clc
close all
clear all
fm = input('fm = ')
am = input('am = ')
phase = input('phase = ')
fs1 = 40*fm;
t = 0:1/fs1:10/fm;
min = -am;
max = am;
m = am*sin(2*pi*fm*t+phase);
n = input('Nubmer of Bits to represent the signal = ')
L = 2^n;
ss = 2*am/(L-1);
delta = ss/2;
p = zeros(1,length(t));
l = zeros(1,length(t));

for i = 1:length(t)
    for k = -1:L-2
        if((m(i)>(min+k*ss+delta))&&(m(i)<min+(k+1)*ss+delta))
            p(i) = min+(k+1)*ss;
            l(i) = (k+1);
         end
    end
end
% subplot(1,2,1)
u = de2bi(l);
b = u(:); 
plot(t,m)
ylabel('Amplitude')
xlabel('time')
grid on
hold on
% subplot(1,2,2)
plot(t,p,'r')
grid on
ylabel('Amplitude')
xlabel('time')
figure 
plot(t,l)
grid on

figure 
plot(b)
ylabel('Amplitude')
xlabel('time')
grid on

wc=2*pi*fm/fs1;
nn=0:1:200;
h=sinc(nn*wc)*wc/pi;
y = filter(h,1,l);
figure 
plot(t,y)
ylabel('Amplitude')
xlabel('time')
% plot(h)
grid on


T_sqnr = var(m)/((ss^2)/12)
P_sqnr = var(m)/var(m-p) 

