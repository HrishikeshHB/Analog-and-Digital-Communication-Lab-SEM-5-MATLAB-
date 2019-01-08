clc
clear all
close all
len = input('Length = ')
fc = input('Carrier Frequency = ')
Tb = input('Bit time = ')
fs = input('Sampling Frequency = ')
Eb = input('Energy = ')

b = randi([0,1],1,len);
rtEb = sqrt(Eb);
t = 0:1/fs:len*Tb-1/fs;
w = zeros(1,len*Tb*fs);
z = 0;
for i = 1:len
    for j = (i-z):Tb*fs
        if b(i)
            w(j+(i-1)*Tb*fs) = rtEb;
        else
            w(j+(i-1)*Tb*fs) = -rtEb;
        end
    end
    z = z+1;
end

c = sqrt(2/Tb)*cos(2*pi*fc*t);
s = w.*c;

q = s.*c;
z = 0;
o = zeros(1,len);
for i = 1:len
    sum = 0;
    for j = (i-z):Tb*fs
        sum = sum+q(j+(i-1)*Tb*fs);
    end
    if sum>0
        o(i) = 1;
    else
        o(i) = 0;
    end
    z= z+1;
end
z = 0;
k = zeros(1,len*Tb*fs);
for i = 1:len
    for j = (i-z):Tb*fs
        if o(i)==1
            k(j+(i-1)*fs*Tb) = 1;
        else
            k(j+(i-1)*fs*Tb) = 0;
        end
    end
    z= z+1;
end
subplot(2,1,1)
plot(t,w)
grid on
subplot(2,1,2)
plot(t,k)
grid on
figure
subplot(2,1,1)
plot(t,s)
grid on
subplot(2,1,2)
plot(t,q)
grid on