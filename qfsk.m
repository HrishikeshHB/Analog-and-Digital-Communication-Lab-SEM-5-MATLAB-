clc
clear all
close all
len = input('Length = ')
f1 = input('Carrier Frequency1 = ')
f2 = input('Carrier Frequency2 = ')
f3 = input('Carrier Frequency3 = ')
f4 = input('Carrier Frequency4 = ')
Tb = input('Bit time = ')
fs = input('Sampling Frequency = ')
Eb = input('Energy = ')
n = 2;
t = 0:1/fs:len*Tb/n-1/fs;

b = randi([0,1],1,len);
c = zeros(1,len/n);
d = zeros(1,n);
p = 1;
for i=1:n:len
    k = 1;
    for j=i:i+n-1
        d(k) = b(j);
        k = k+1;
    end
    c(p) = bi2de(fliplr(d));
    p = p+1;
end

phi1 = sqrt(2/Tb)*cos(2*pi*f1*t);
phi2 = sqrt(2/Tb)*cos(2*pi*f2*t);
phi3 = sqrt(2/Tb)*cos(2*pi*f3*t);
phi4 = sqrt(2/Tb)*cos(2*pi*f4*t);

s = zeros(1,len*Tb*fs/n);
z = 0;
for i=1:len/n
    for j = (i-z):fs*Tb
        if c(i) == 0
            s(j+(i-1)*fs*Tb) = phi1(j+(i-1)*fs*Tb);
        elseif c(i) == 1
            s(j+(i-1)*fs*Tb) = phi2(j+(i-1)*fs*Tb);
        elseif c(i) == 2
            s(j+(i-1)*fs*Tb) = phi3(j+(i-1)*fs*Tb);
        else
            s(j+(i-1)*fs*Tb) = phi4(j+(i-1)*fs*Tb);
        end
    end
    z = z+1;
end

s1 = s.*phi1;
s2 = s.*phi2;
s3 = s.*phi3;
s4 = s.*phi4;
p = 1;
a = zeros(1,len/n);
z = 0;
for i = 1:len/n
    sum0=0;sum1=0;sum2=0;sum3=0;
    for j = (i-z):Tb*fs
        sum0 = sum0+s1(j+(i-1)*fs*Tb);
        sum1 = sum1+s2(j+(i-1)*fs*Tb);
        sum2 = sum2+s3(j+(i-1)*fs*Tb);
        sum3 = sum3+s4(j+(i-1)*fs*Tb);
    end
    z = z+1;
    sum = max([sum0,sum1,sum2,sum3]);
    if sum == sum0
        a(p) = 0;
    elseif sum == sum1
        a(p) = 1;
    elseif sum == sum2
        a(p) = 2;
    else
        a(p) = 3;
    end
    p = p+1;
end
z = 0;
k = zeros(1,len*fs*Tb/n);
for i = 1:len/n
    for j = (i-z):fs*Tb
        k(j+(i-1)*fs*Tb) = a(i);
    end
    z = z+1;
end
plot(t,k)
grid on

         