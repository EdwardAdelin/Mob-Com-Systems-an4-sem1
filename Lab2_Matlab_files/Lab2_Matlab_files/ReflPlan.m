function out = ReflPlan(dFrequency,dDistance,dGainT,dGainR,dAntHghtT,dAntHghtR)
%ReflPlan.M - PlaneReflectionLosses
%USAGE   : ReflPlan(dFrequency,dDistance,dGainT,dGainR,dAntHghtT,dAntHghtR)
%RETURNS : out (Value of losses)
%Subrutina calculeaza valoarea pierderilor de propagare in cazul
%reflexiei pe suprafete plane pentru un emitator si un receptor situati
%in apropierea unei suprafete reflectante plane la distanta dDistance.
%Semnalul emis are frecventa dFrequency. Emitatorul, respectiv receptorul,
%sunt caracterizati de castigurile dGainT, respectiv dGainR, avind antenele
%situate la inaltimile dAntHghtT, respectiv dAntHghtR.
%Ex: ReflPlan(10^8,1000.0,1.0,1.0,10,1)

dLightSpeed = 3.0*10^8;

if (nargin~=6)
   disp('Incorrect number of arguments in calling ReflPlan')
   disp('Require 6 double (float) positive values.')
else
   out = 10.0*log10(4*dGainT*dGainR*((dLightSpeed/(4*pi*dFrequency*dDistance))^2)*((sin(2*pi*dAntHghtT*dAntHghtR*dFrequency/(dLightSpeed*dDistance)))^2) );
end

clear dLightSpeed;
