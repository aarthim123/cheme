%   Finite difference solution to 1-D, 2-phase flow; IMPES formulation
%   Asg 4.1; no capillary pressure or gravity
%   RAT End point mobility ratio, invading/displaced
%   KRD Relative permeability of displaced phase.
%   KRI Relative permeability of Invading phase
%   EX  Relative permeability exponent

%   dtdx dt/dx
%   NX   Number of gridblocks
%   NOUT Number of time steps between profile output
%   TSTOP Time to stop
%   NSTOP Numberof time steps to end
%   Inflow B.C.  Unit flux of invading phase.
%   Outflow B.C. pot(NX+1/2)=0.0

%   input.dat Has input parameters. Each row must have 3 columns

%   Subroutines: KRD, KR

    clear all
    global RAT EXD EXI
   
    INPUT=load('input.dat');
    ncases=INPUT(1,1);
    for icase=1:ncases  % (remember to put end)
    
    RAT =INPUT(2,1) ;
    EX=INPUT(2,2);
    EXI=EX;
    EXD=EX;
    dtdx=INPUT(3,1);
    NX=INPUT(3,2);
    fluxin=1.0;
    s=zeros(NX,1);
    pot=zeros(NX+1,1);
    krd=zeros(NX,1);
    kri=zeros(NX,1);
    totmob=zeros(NX,1);
    coefa=zeros(NX,1);
    coefb=zeros(NX,1);
    coefc=zeros(NX,1);
    right=zeros(NX,1);
    ds=zeros(NX,1);
    x=zeros(NX,1);
    prod=[];
    prof=[];
    dx=1/NX;
    dt=dtdx*dx;
    for i=1:NX
       x(i)=dx*(i-0.5);
    end
    nn=0;
    nnp=0;
    cum=0.;
    tim=0.;
    TSTOP =INPUT(4,1);
    NOUT =INPUT(4,2);
    NF=INPUT(4,3);
    NSTOP=round(TSTOP/dt);
    nnp=0;
    
    for nt=1:NSTOP
      nn=nn+1;
      dtdx2=dt*dx^-2;
      
%   Calculate pressure 
      coefa(1)=0.;
      coefc(NX)=0.0;
      pot(NX+1)=0.0;
      bcfac=1.0;
      for i=1:NX
          krd(i)=krdf(s(i));    
          kri(i)=krif(s(i));
          tmob(i)=krd(i)/RAT+kri(i);
          if i>1 coefa(i)=tmob(i-1); end
          if i==NX bcfac=2.0; end
          coefc(i)=bcfac*tmob(i);
          coefb(i)=-(coefa(i)+coefc(i));
          right(i)=0.0;
      end
      coefc(NX)=2.0*tmob(NX);
      right(1)=-dx;
      
 %  Calculate potential     
      pot=tridag([coefa coefb coefc],right, NX);
      
 %  Calculate Saturation 
    ds(1)=dtdx2*(kri(1)*(pot(2)-pot(1))+dx*fluxin);
    bcfac=1.0;
    pot(NX+1)=0.0;
    for i=2:NX
        if i==NX bcfac=2.0; end
        ds(i)=dtdx2*(kri(i)*bcfac*(pot(i+1)-pot(i))...
            -kri(i-1)*(pot(i)-pot(i-1)));
    end
    sum=0.0;
    for i=1:NX
        s(i)=s(i)+ds(i);
        sum=sum+s(i);
    end
    eff=sum/NX;
    cut=kri(NX)*pot(NX)/(kri(NX)*pot(NX)+krd(NX)*pot(NX)/RAT);
    cum=cum+(1.0-cut)*dt;
    rate=krd(NX)*pot(NX)/(0.5*dx*RAT);
    tim=tim+dt;
    nnp=nnp+1;
    if nnp >= NF   % Store production data
        prod=vertcat(prod, [tim cut eff cum rate]);
        nnp=0;
    end
    if nn >= NOUT  %store profile data
        pot(NX+1)=[];
        prof=vertcat(prof, [x s pot]);
        nn=0;
    end
    end
    savefile=['prod' num2str(icase) '.dat'];
    save(savefile,  'prod', '-ASCII')
    savefile=['prof' num2str(icase) '.dat'];
    save(savefile, 'prof', '-ASCII')
    end
    
  
    
    