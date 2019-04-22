% Fit Gaussian distribution to estimate mu and sig
clear all
[fid, message]=fopen('gaussd.dat','r')
load gaussd.dat;
status=fclose(fid);
y=gaussd(:,1);
P=gaussd(:,2);
u=sqrt(2)*erfinv(2*P-1);
%
% Linear regression
unit=ones(size(y));
s=unit'*unit;
sx=u'*unit;
sy=y'*unit;
sxx=u'*u;
sxy=u'*y;
del=s*sxx-sx^2;
mu=(sxx*sy-sx*sxy)/del
sig=(s*sxy-sx*sy)/del
% Plot linear fit of data
ul(1)=u(1);
ul(2)=u(length(u));
yl(1)=mu+sig*ul(1);
yl(2)=mu+sig*ul(2);
figure(3)
clf reset
plot(u,y,'kx',ul,yl,'k-')
title('Linear Regression: y = mu + sig u')
xlabel('u')
ylabel('y')
