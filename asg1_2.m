%     Assignment 1.2 Truncation Error
%     PLOT FINITE DIFFERENCE RESULT AND COMPARE WITH MOC SOLUTION
%     MOC FROM MOC.M
      clear
      clf reset
      load prod.dat
      lenprod=length(prod(:,1));
      tmoc1=zeros(lenprod,1); cutmoc=zeros(lenprod,1); 
      tmoc2=zeros(lenprod,1); ermoc=zeros(lenprod,1);
      tmoc1(:)=prod(:,1);
      cutmoc(:)=prod(:,2);
      tmoc2(:)=prod(:,3);
      ermoc(:)=prod(:,4);
      % Eleminate constant time values from tmoc1, cutmoc
      nsame=0;
      for n=2:length(tmoc1)
        if(tmoc1(n-1)>=tmoc1(n))
          nsame=nsame+1;
        end
      end
      tdum=tmoc1(nsame+1:length(tmoc1)-1);
      cdum=cutmoc(nsame+1:length(cutmoc)-1);
      tmoc11=tmoc1(1)-1.e-5;
      clear tmoc1 cutmoc
      tmoc1= [0 tmoc11 tdum']';
      cutmoc=[0 1.e-6  cdum']';
      npt=input('No. points upstream = ');
for ifile=1:5
  clear prodfd time cut er
  if ifile==1
      load prod1.dat
      prodfd=prod1;
  elseif ifile==2
      load prod2.dat
      prodfd=prod2;
  elseif ifile==3
      load prod3.dat
      prodfd=prod3;
  elseif ifile==4
      load prod4.dat
      prodfd=prod4;
  elseif ifile==5
      load prod5.dat
      prodfd=prod5;
  end
      clear time cut er
      lenprodfd=length(prodfd(:,1));
      time=zeros(lenprodfd,1);cut=zeros(lenprodfd,1);er=zeros(lenprodfd,1);
      time(:)=prodfd(:,1);
      cut(:)=prodfd(:,2);
      er(:)=prodfd(:,3);
      plot(tmoc1,cutmoc,':',time,cut,'-')
      hold on
end
      axis([0 2 0 1])
      title(['M=2.0, n=1.5, NX=5,10,20,40,80, DT/DX=0.01, '...
           ,int2str(npt),'-Point'])

      xlabel('DIMENSIONLESS TIME')
      ylabel('WATER CUT')
      in=input('hit ENTER to continue');
      clf
      hold off
for ifile=1:5
  clear prodfd time cut er
  if ifile==1
      load prod1.dat
      prodfd=prod1;
  elseif ifile==2
      load prod2.dat
      prodfd=prod2;
  elseif ifile==3
      load prod3.dat
      prodfd=prod3;
  elseif ifile==4
      load prod4.dat
      prodfd=prod4;
  elseif ifile==5
      load prod5.dat
      prodfd=prod5;
  end
      clear time cut er
      lenprodfd=length(prodfd(:,1));
      time=zeros(lenprodfd,1);cut=zeros(lenprodfd,1);er=zeros(lenprodfd,1);
      time(:)=prodfd(:,1);
      cut(:)=prodfd(:,2);
      er(:)=prodfd(:,3);
      plot(tmoc2,ermoc,':',time,er,'-')
      hold on
end
      axis([0 2 0 1])
      title(['M=2.0, n=1.5, NX=5,10,20,40,80, DT/DX=0.01, '...
           ,int2str(npt),'-Point'])
      xlabel('DIMENSIONLESS TIME')
      ylabel('RECOVERY EFFICIENCY')
      in=input('hit ENTER to continue');
      clf

%     CALCULATE NORM OF ERROR IN CUT AND RECOVERY
      dt=[0.002 0.001 0.0005 0.00025 0.000125];
for ifile=1:5
  clear prodfd time cut er
  if ifile==1
      load prod1.dat
      prodfd=prod1;
  elseif ifile==2
      load prod2.dat
      prodfd=prod2;
  elseif ifile==3
      load prod3.dat
      prodfd=prod3;
  elseif ifile==4
      load prod4.dat
      prodfd=prod4;
  elseif ifile==5
      load prod5.dat
      prodfd=prod5;
  end
      clear time cut er
      lenprodfd=length(prodfd(:,1));
      time=zeros(lenprodfd,1);cut=zeros(lenprodfd,1);er=zeros(lenprodfd,1);
      time(:)=prodfd(:,1);
      cut(:)=prodfd(:,2);
      er(:)=prodfd(:,3);
      nt=length(time);
      sum1=0;
      sum2=0;
      moccut=zeros(nt,1);
      mocer =zeros(nt,1);
  for j=1:nt
      sum1=sum1+abs(cut(j)-interp1(tmoc1,cutmoc,time(j)));
      sum2=sum2+abs( er(j)-interp1(tmoc2, ermoc,time(j)));
      moccut(j)=interp1(tmoc1,cutmoc,time(j));
      mocer(j)=interp1(tmoc2, ermoc,time(j));
  end
      enorm(ifile)=sum1/nt;
      ernorm(ifile)=sum2/nt;
end   % END OF LOOP ON FILES
%     Convergence to MOC solution
      clf
      nx=[5 10 20 40 80];
      dx=1 ./nx;
      ldx=log10(dx);
      lerr=log10(enorm);
      X=[ones(size(ldx')) ldx'];
      regress=X\lerr';
      mu=regress(1,1);
      sig=regress(2,1);
      loglog(dx',enorm',dx',enorm','+')
      title(['M=2.0, n=1.5, NX=5,10,20,40,80, DT/DX=0.01, '...
           ,int2str(npt),'-Point,'...
           ,' Slope = ',num2str(sig)])
      xlabel('DX')
      ylabel('1 Norm of Error in Cut')
      axis([1.e-2 1. 1.e-3 1.e-1]);
      wait=input('Hit enter to continue');
      hold off

%     Convergence of Recovery
      clf
      ldx=log10(dx);
      lerr=log10(ernorm);
      X=[ones(size(ldx')) ldx'];
      regress=X\lerr';
      mu=regress(1,1);
      sig=regress(2,1);
      loglog(dx',ernorm',dx',ernorm','+')
      title(['M=2.0, n=1.5, NX=5,10,20,40,80, DT/DX=0.01, '...
           ,int2str(npt),'-Point,'...
           ,' Slope = ',num2str(sig)])
      xlabel('DX')
      ylabel('1 Norm of Error in Recovery')
      wait=input('Hit enter to continue');
      hold off

