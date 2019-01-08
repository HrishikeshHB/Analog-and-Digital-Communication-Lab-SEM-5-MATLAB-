clc
clear all
close all
len = input('Length = ')
fc = input('Carrier Frequency = ')
Tb = input('Bit time = ')
fs = input('Sampling Frequency = ')
Eb = input('Energy = ')
n = 2;
t = 0:1/fs:len*Tb/n-1/fs;
t1 = 0:1/fs:len*Tb-1/fs;
b = randi([0,1],1,len);
o = zeros(1,len/n);
e = zeros(1,len/n);
oo = 1;
ee = 1;
w = zeros(1,len*Tb*fs/n);
z = 0;
for i = 1:len
    for j = (i-z):Tb*fs
        if b(i)
            w(j+(i-1)*fs*Tb) = 1;
        else
            w(j+(i-1)*fs*Tb) = 0;
        end
    end
    z = z+1;
end

for i = 1:len
    if mod(i,2)
        o(oo) = b(i);
        oo = oo+1;
    else
        e(ee) = b(i);
        ee = ee+1;
    end
end
rtEb = sqrt(Eb);
phi1 = sqrt(2/Tb)*cos(2*pi*fc*t);
phi2 = sqrt(2/Tb)*sin(2*pi*fc*t);

for i = 1:len/n
    if o(i) == 1
            o(i) = rtEb;
    else
            o(i) = -rtEb;
    end
    if e(i) == 1
            e(i) = rtEb;
    else
            e(i) = -rtEb;
    end
end

om = zeros(1,len*Tb*fs/n);
em = zeros(1,len*Tb*fs/n);
z = 0;
for i = 1:len/n
    for j = (i-z):fs*Tb
        em(j+(i-1)*fs*Tb) = e(i);
        om(j+(i-1)*fs*Tb) = o(i);
    end
    z = z+1;
end

em = em.*phi2;
om = om.*phi1;
s = om+em;

q1 = s.*phi1;
q2 = s.*phi2;
o1 = zeros(1,len/n);
e1 = zeros(1,len/n);
z = 0;
for i=1:len/n
    sumo = 0;
    sume = 0;
    for j = (i-z):Tb*fs
        sumo = q1(j+(i-1)*Tb*fs)+sumo;
        sume = q2(j+(i-1)*Tb*fs)+sume;
    end
    if sumo>0
        o1(i) = 1;
    else
        o1(i) = 0;
    end
    if sume>0
        e1(i) = 1;
    else
        e1(i) = 0;
    end
    z = z+1;
end
oo = 1;
ee = 1;
c = zeros(1,len);
for i = 1:len
    if mod(i,2)==0
        c(i) = e1(ee);
        ee = ee+1;
    else
        c(i) = o1(oo);
        oo = oo+1;
    end
end
k = zeros(1,len*Tb*fs/n);
z = 0;
for i = 1:len
    for j = (i-z):Tb*fs
        if c(i)
            k(j+(i-1)*fs*Tb) = 1;
        else
            k(j+(i-1)*fs*Tb) = 0;
        end
    end
    z = z+1;
end

subplot(2,1,1)
plot(t1,w)
grid on
subplot(2,1,2)
plot(t1,k)
grid on
