%     Analyze effluent data for dispersion coefficient
clear all
figure(1)
clf reset
[fid, message]=fopen('kern.dat','r')
load kern.dat
status=fclose(fid);
t=kern(:,1)
c=kern(:,2)
% plot(t,c)
% hold
% plot(t,c,'x')
% title('Original Data')
% xlabel('Time, PV')
% ylabel('Concentration')
% 
% figure(2)
% clf reset
% %     Normalize concentrations
% % c0=input('c0 = ');
% % c1=input('c1 = ');
% c0=0.022;
% c1=0.178;
% c(:)=(c(:)-c0)/(c1-c0);
% plot(t,c,'x')
% title('Normalized Concentration')
% xlabel('Time, PV')
% ylabel('Normalized Concentration')
% axis([0 4.5 0 1.1])
%  
% %     Fit selected data to Gaussian distribution
% % datfst=input('First data point to be fitted = ');
% % datlst=input('Last data point to be fitted = ');
% datfst=5;
% datlst=11;
% %     P is c, (cumulative probability of Gaussian distribution)
% %     y is (1-t)/sqrt(t), (y is variable which has Gaussian distribution)
% P=1.0-c(datfst:datlst);
% y=t(datfst:datlst);
% y=(1-y)./sqrt(y);
% gaussd=[y P];
% fid=fopen('gaussd.dat');
% save gaussd.dat gaussd -ascii
% status=fclose(fid);
% gaussf
