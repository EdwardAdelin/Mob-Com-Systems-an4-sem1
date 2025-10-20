function out = trueReflPlan(dFrequency,dDistance,dGainT,dGainR,dAntHghtT,dAntHghtR,dPsi)
%trueReflPlan.M - PlaneReflectionLosses
%USAGE   : trueReflPlan(dFrequency,dDistance,dGainT,dGainR,dAntHghtT,dAntHghtR,dPsi)
%RETURNS : out (Value of losses)
%Subrutina calculeaza valoarea pierderilor de propagare in cazul
%reflexiei pe suprafete plane pentru un emitator si un receptor situati
%in apropierea unei suprafete reflectante plane la distanta dDistance.
%Semnalul emis are frecventa dFrequency. Emitatorul, respectiv receptorul,
%sunt caracterizati de castigurile dGainT, respectiv dGainR, avind antenele
%situate la inaltimile dAntHghtT, respectiv dAntHghtR, dPsi unghiu
%deternimat de distanta dintre emitator si receptor (in radiani)
%Ex: trueReflPlan(10^8,1000.0,1.0,1.0,10,1,10)

dLightSpeed = 3.0*10^8;
epsRelativ = 15;
sigma = 0.012;

if (nargin~=7)
   disp('Incorrect number of arguments in calling ReflPlan')
   disp('Require 6 double (float) positive values.')
else
    outVector = ErthRefC(dFrequency,dPsi,epsRelativ,sigma);
    %rho_h = outVector(1);
    rho_v = outVector(2);
    
    PhaseDif = 4*pi*dLightSpeed*dAntHghtT*dAntHghtR/(dFrequency*dDistance); % deltaFi, diferenta de faza
    
   out = 10.0*log10((dGainR*dGainT*(dLightSpeed^2))/((4*dDistance*pi*dFrequency)^2)*((1+abs(rho_v)*exp(-i*PhaseDif-angle(rho_v)))^2));
end

clear dLightSpeed;
