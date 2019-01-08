clearvars
close all
n=input('n for rand() and randn()');
p=rand(1,n);
g=randn(1,n);
mu=input('Gaussian Rv mean');
sigm=input('Gaussian RV var');
G=g*sigm^2+mu;
Ph=p*(2*pi)-pi;
figure(1)
subplot(3,1,1)
histogram(g)
xlabel('x')
ylabel('F(x)')
title('Distribution of randn fn')
subplot(3,1,2)
histogram(g,'Normalization','pdf')
xlabel('x')
ylabel('F(x)')
title('Probability Distribution of Gaussina Rv(0,1)')
subplot(3,1,3)
histogram(G)
xlabel('x')
ylabel('F(x)')
title('Probability Distribution of Gaussina Rv (mu,sigma)')
figure(2)
subplot(3,1,1)
histogram(p)
xlabel('x')
ylabel('F(x)')
title('Distribution of rand fn')
subplot(3,1,2)
histogram(p,'Normalization','pdf')
xlabel('x')
ylabel('U(x)')
title('Probability Distribution of Uniform RV (0,1)')
subplot(3,1,3)
histogram(Ph)
xlabel('x')
ylabel('U(x)')
title('Probability Distribution of Uniform RV (-pi to pi)')