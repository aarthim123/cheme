 clear all
clear all
clf reset
M= [2];
S=[0:0.01:1.0]';
n=1.5;
f=zeros(length(S),length(M));
dfds=f;
for i=1:length(M)
  f(:,i)=1 ./(1+((1-S(:).^M)./(S(:)+eps))./(M(i)+eps));
  dfds(:,i)=f(:,i).^2 ./(M(i).*(S(:)+eps).^2);
end
subplot(121), plot(S,f)
title('FRACTIONAL FLOW')
xlabel('NORMALIZED SATURATION')
ylabel('FRACTIONAL FLOW')
text(0.05,0.90,'M = 0.5, 1.0, 2.0')
gtext('0.5')
gtext('1.0')
gtext('2.0')
subplot(122), plot(S,dfds)
title('DERIVATIVE OF FRACTIONAL FLOW')
xlabel('NORMALIZED SATURATION')
ylabel('df/dS')
text(0.05,1.9,'M = 0.5, 1.0, 2.0')
gtext('0.5')
gtext('1.0')
gtext('2.0')