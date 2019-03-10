%     Assignment # 7.2& 7.3
%     calculate f vs S
%     calculate tajectory, saturation profile, and fw and Er history
clear
clf
orient landscape
M=[0.5 1.0 2.0];
S=[0:0.01:1.0]';
n=1;
f=zeros(length(S),length(M));
dfds=f;
for i=1:length(M)
  f(:,i)=1 ./(1+((1-S(:))./(S(:)+eps))./(M(i)+eps));
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
in=input('hit ENTER to continue')
clf
%   DISTANCE TIME DIAGRAMS
for k=1:3
  Sv=[0 0.5 1.0];
  IND=[1 51 101];
  X=zeros(2,3);
  T=zeros(2,3);
  for i=1:3
    j=IND(i);
    V(i)=dfds(j,k);
    if M(k)<=1.0
       V(i)=1.0;
    end
    T(2,i)=2.0;
    X(2,i)=2*V(i);
  end
  if k>1
    if k<3
       subplot(121), axis([0 2 0 1]), plot(T,X)
    else
       subplot(122), axis([0 2 0 1]), plot(T,X)
    end
    title(['M = ',num2str(M(k))])
    xlabel('DIMENSIONLESS TIME')
    ylabel('DIMENSIONLESS DISTANCE')
    gtext('S=0')
    gtext('S=0.5')
    gtext('S=1.0')
  end
end
in=input('hit ENTER to continue')
clf
%  saturation profile
  X=ones(length(S),3);
  tim=0.5;
  X(:)=tim*X(:);
for k=1:3
  if M(k)>1
     X(:,k)=tim*dfds(:,k);
  end
end
subplot(111), axis([0 2 0 1]), plot(X,S)
title('SATURATION PROFILE, t=0.5')
xlabel('DIMENSIONLESS DISTANCE')
ylabel('SATURATION')
gtext('M=0.5')
gtext('M=1.0')
gtext('M=2.0')
in=input('hit ENTER to continue')
clf
%     fractional flow and recovery history
TF=ones(length(S),length(M));
for k=1:3
  if M(k)>1
    TF(:,k)=1 ./dfds(:,k);
  end
end
subplot(121), axis([0 2 0 1]), plot(TF,f)
title('FRAC. FLOW HISTORY')
xlabel('DIMENSIONLESS TIME')
ylabel('FRACTIONAL FLOW')
gtext('M=0.5')
gtext('M=1.0')
gtext('M=2.0')
in=input('hit ENTER to continue')
%     recovery efficiency
ER=[S S S];
TF=ER;
ER(:,3)=S(:)+(1-f(:,3))./dfds(:,3);
TF(:,3)=1 ./dfds(:,3);
subplot(122), axis([0 2 0 1]), plot(TF,ER)
title('RECOV. EFF.')
xlabel('DIMENSIONLESS TIME')
ylabel('RECOVERY')
gtext('M=0.5')
gtext('M=1.0')
gtext('M=2.0')
in=input('hit ENTER to continue')
clf
