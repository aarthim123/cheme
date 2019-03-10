%     PLOT FINITE DIFFERENCE RESULT AND COMPARE WITH MOC SOLUTION
%     MOC FROM ASG12.M
      clear all
      figure(1)
      clf reset
      load prod.dat
      tmoc1=prod(:,1);
      cutmoc=prod(:,2);
      tmoc2=prod(:,3);
      ermoc=prod(:,4);
      load prod1.dat
      time=prod1(:,1);
      cut=prod1(:,2);
      er=prod1(:,3);
      plot(tmoc1,cutmoc,':',time,cut,'-')
      axis([0 2 0 1])
      title('M=2.0, n=1.5, NX=10, DT/DX=0.1, 1-Point')
      xlabel('DIMENSIONLESS TIME')
      ylabel('WATER CUT')
      in=input('hit ENTER to continue');
      figure(2)
      clf reset
      plot(tmoc2,ermoc,':',time,er,'-')
      axis([0 2 0 1])
      title('M=2.0, n=1.5, NX=10, DT/DX=0.1, 1-Point ')
      xlabel('DIMENSIONLESS TIME')
      ylabel('RECOVERY EFFICIENCY')
      in=input('hit ENTER to continue');
      figure(3)
      clf reset
% PLOT SATURATION PROFILES
      load prof.dat
      X=prof(:,1);
      S=prof(:,2);
      plot(X,S,':')
      axis([0 1 0 1])
      title('M = 2, n = 1.5, NX=10, DT/DX=0.1, 1-Point, t=0.5')
      xlabel('DIMENSIONLESS DISTANCE')
      ylabel('SATURATION')
      hold
      clear X S
      load prof1.dat
      X=prof1(:,1);
      S=prof1(:,2);
      plot(X,S,'-')
