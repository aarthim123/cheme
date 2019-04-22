%   Convective, Dispersion, and Adsorption
%   Linear adsorption isotherm is assumed, i.e., Henry's law
%   Approximate, error function solution is assumed
%   Gaussian distribution is assumed for very small slug, i.e., pulse
%   i.e., B.C. at x=0 is only approximate
%   Initial concentration is zero
%   Injected concentration is unity for a time, delt
%   x:  dimsnaionless distance; 0 <= x <= 1
%   t:  dimsnsionless time, PV throughput; t>0
%   C:  Error function solution
%   Capprox:    Approximate solution for pulse
%
%   beta:   retardation parameter
%   NPe:    Peclet number
%   delt:   dimensionless slug size, PV
%   tprof:  time for profile
%   tstop:  time to stop calculations

    clear all
    x=(0:0.01:1);
    tstop=2;
    t=(0:0.01:tstop);
    beta=input('beta = ');
    NPe=input('NPe = ');
    delt=input('delt = ');
    tprof=input('tprof = ');
    if tprof<delt 
        'tprof must be > delt'
        quit
    end
    
%   Profile at t = tprof
    figure(1)
    clf reset
    eta=(x(:)-(tprof)/(1+beta))./ ... 
        (2*sqrt((tprof)/(NPe*(1+beta))));
    etadel=(x(:)-(tprof-delt)/(1+beta))./ ... 
        (2*sqrt((tprof-delt)/(NPe*(1+beta))));
    C=-0.5.*(erf(eta)-erf(etadel));
    plot(x,C,'-k')
    title(['Profile: t = ' num2str(tprof) ' ,beta = ' num2str(beta) ...
        ' ,NPe = ' num2str(NPe) ' ,delt = ' num2str(delt)])
    xlabel('Distance')
    ylabel('Concentration')
    hold on
%   Approximate solution  
    Capprox=(delt*sqrt(NPe/(1+beta)))/(2*sqrt(pi*tprof)) ...
        .*exp(-eta(:).^2);
    plot(x,Capprox,':r')
    
%   Effluent history
    clear eta etadel C Capprox
    figure(2)
    clf reset
    eta=(1-(t(:))./(1+beta))./ ... 
        (2.*sqrt((t(:))./(NPe*(1+beta))));
    etadel=(1-(t(:)-delt)./(1+beta))./ ... 
        (2.*sqrt((t(:)-delt)./(NPe*(1+beta))));
    C=zeros(length(eta));
    Capprox=C;
    for n=1:length(eta)
        if t(n)<delt
            C(n)=0.5*(1-erf(eta(n)));
        else
            C(n)=-0.5*(erf(eta(n))-erf(etadel(n)));
        end
    end
%   Approximate solution  
    Capprox=(delt*sqrt(NPe/(1+beta)))./(2.*sqrt(pi.*t(:))) ...
        .*exp(-eta(:).^2);
    plot(t,C,'-k',t,Capprox,':r')
    title(['Effluent History:  ,beta = ' num2str(beta) ...
        ' ,NPe = ' num2str(NPe) ' ,delt = ' num2str(delt)])
    xlabel('Time, PV')
    ylabel('Concentration')

    