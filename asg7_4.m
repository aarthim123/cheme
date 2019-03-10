%     Assignment # 7.4
%     calculate f vs S; n=1.5
%     calculate tajectory, saturation profile, and fw and Er history
clear
clf reset
global M n1 n2
M=[2.0];
S=[0:0.01:1.0]';
n=1.5;
n1=n;
n2=n;
f=zeros(length(S),length(M));
dfds=f;
for i=1:1
  f(:,i)=1 ./(1+((1-S(:)).^n2./((S(:)+eps).^n1))/(M(i)+eps));
  dfds(:,i)=((f(:,i).^2)/M(i)).*(((1-S(:)+eps).^n2)./(S(:)+eps).^n1)...
  .*(n2./(1-S(:)+eps)+n1./(S(:)+eps));
end
%     LOCATION OF SHOCK
ST=fzero('asg7_4f',0.5);
fT=1/(1+((1-ST)^n2/(ST^n1+eps))/(M(i)+eps));
SS=[0 ST];
fS=[0 fT];
vS=[fT/ST fT/ST];
%
subplot(121), plot(S,f,SS,fS)
title('FRAC. FLOW')
xlabel('NORMALIZED SATURATION')
ylabel('FRACTIONAL FLOW')
text(0.05,0.90,'M = 2.0, n = 1.5')
subplot(122), plot(S,dfds,SS,vS)
title('DERIVATIVE')
xlabel('NORMALIZED SATURATION')
ylabel('df/dS')
text(0.05,1.70,'M = 2.0, n = 1.5')
in=input('hit ENTER to continue')
clf
%   DISTANCE TIME DIAGRAMS
for k=1:1
  IND=[1 81 101];
  X=zeros(2,3);
  T=zeros(2,3);
  for i=1:3
      if i==1
         V(1)=fT/ST;
         T(2,1)=2.0;
         X(2,1)=2.0*V(1);
      else
         j=IND(i);
         V(i)=dfds(j,k);
         T(2,i)=2.0;
         X(2,i)=2*V(i);
      end
  end
    plot(T,X)
    title(['DISTANCE - TIME DIAGRAM, M = 2, n = 1.5'])
    xlabel('DIMENSIONLESS TIME')
    ylabel('DIMENSIONLESS DISTANCE')
    gtext(['S= ',num2str(ST)])
    gtext(['S= ',num2str(S(81))])
    gtext('S=1.0')
  end

in=input('hit ENTER to continue')
clf
tim=0.5;
k=1;
X=ones(length(S),k);
X(:,k)=tim*dfds(:,k);
for i=1:length(S)
   if S(i)<ST, X(i,k)=tim*fT/ST;
   end
end
subplot(111),  plot(X,S)
title('SATURATION PROFILE, M = 2, n = 1.5, t=0.5')
xlabel('DIMENSIONLESS DISTANCE')
ylabel('SATURATION')
in=input('hit ENTER to continue')
clf
prof=[X S];
save prof.dat prof /ascii
%     fractional flow and recovery history
k=1;
TF=ones(length(S),length(M));
TF(:,k)=1 ./dfds(:,k);
for i=1:length(S)
   if S(i)<ST
   TF(i,k)=ST/fT;
   end
end
hist=[TF f];
subplot(121), plot(TF,f)
axis([0. 4. 0. 1.])
title('FRACTIONAL FLOW HISTORY')
xlabel('DIMENSIONLESS TIME')
ylabel('FRACTIONAL FLOW')
%     recovery efficiency
ER=[S];
TF=ER;
for i=1:length(S)
  if S(i)>ST
     ER(i,1)=S(i)+(1-f(i,1))/dfds(i,1);
     TF(i,1)=1/dfds(i,1);
  end
end
hist=[hist TF ER];
save prod.dat hist /ascii
subplot(122), plot(TF,ER)
axis([0. 4. 0. 1.])
title('RECOVERY EFFICIENCY')
xlabel('DIMENSIONLESS TIME')
ylabel('RECOVERY')
in=input('hit ENTER to continue')
clf
