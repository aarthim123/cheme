%     Assignment 4.2 IMPES with drainage Pc
%     PLOT FINITE DIFFERENCE PROD AND COMPARE WITH MOC SOLUTION
%     MOC FROM ASG12.M
      clear
      clf reset
      load prod.dat
      tmoc1=prod(:,1);
      cutmoc=prod(:,2);
      tmoc2=prod(:,3);
      ermoc=prod(:,4);
      ncases=input('ncases = ')
      
      figure(1)     % Plot fractional flow of effluent
      clf reset
for ifile=1:ncases
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
  end
      time=prodfd(:,1);
      cut=prodfd(:,2);
      er=prodfd(:,3);
      plot(tmoc1,cutmoc,':',time,cut,'-')
      hold on
      axis([0 5 0 1])
      title('M=2.0, n=1.5, NX=10,20,40,80, DT/DX2=0.5, dra Pc')
      xlabel('DIMENSIONLESS TIME')
      ylabel('WATER CUT')
      hold on
end
   
   figure(2)        %Plot recovery efficiency
   clf reset
for ifile=1:ncases
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
  end
      time=prodfd(:,1);
      cut=prodfd(:,2);
      er=prodfd(:,3);
      plot(tmoc2,ermoc,':',time,er,'-')
      hold on
end
      axis([0 5 0 1])
      title('M=2.0, n=1.5, NX=10,20,40,80, DT/DX2=0.5, Drain Pc ')
      xlabel('DIMENSIONLESS TIME')
      ylabel('RECOVERY EFFICIENCY')
      
    figure(3)       % Plot profiles; only for ncase=1
    clf reset
    if ncases==1
      NX=input('NX = ')
      hold on
      clear X S
      load prof1.dat
      nprof=length(prof1(:,1))/NX;
      for np=1:nprof
          for ix=1:NX
              X(ix)=prof1((np-1)*NX+ix,1);
              S(ix)=prof1((np-1)*NX+ix,2);
          end
          plot(X,S)
      end
      axis([0 1 0 1])
      title(['M = 2.0, n = 1.5, NX= ' num2str(NX)])
      xlabel('DIMENSIONLESS DISTANCE')
      ylabel('SATURATION')
    end
     
