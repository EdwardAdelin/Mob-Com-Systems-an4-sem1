function outVector=ErthRefC(dFrequency,dPsi,epsRelativ,sigma)
%ErthRefC.M - EarthRelectionCoefficients
%USAGE   : ErthRefC(dFrequency,dPsi,epsRelativ,sigma)
%RETURNS : outVector=[rho_h rho_v abs(rho_h) abs(rho_v) angle(rho_h) angle(rho_v) chi]
%Subrutina calculeaza valorile complexe ale coeficientilor de reflexie
%ai pamintului, rho_h si rho_v, pentru undele polarizate orizontal si
%vertical. Se utilizeaza de asemenea valorile constantei dielectrice
%epsilon si a conductivitatii sigma.
%Ex: ErthRefC(10^8,pi/4,15,0.012).

dLightSpeed=3.0*10^8;
epsilon_0=8.856/(10^12);

if (nargin~=4)
   disp('Incorrect number of args in calling EarthRelectionCoefficients.')
   disp('Require 4 double (float) positive values.')
else
   chi=sigma/(2*pi*dFrequency*epsilon_0);
   rho_h=(sin(dPsi)- sqrt(epsRelativ - i*chi - (cos(dPsi))^2)) / (sin(dPsi) + sqrt(epsRelativ - i*chi - (cos(dPsi))^2));
   rho_v=((epsRelativ - i*chi)*sin(dPsi)- sqrt(epsRelativ - i*chi-(cos(dPsi))^2)) / ((epsRelativ - i*chi)*sin(dPsi) + sqrt(epsRelativ - i*chi-(cos(dPsi))^2));
end

outVector=[rho_h rho_v abs(rho_h) abs(rho_v) angle(rho_h) angle(rho_v) chi];

clear rho_h;
clear rho_v;
clear chi;

clear epsilon_0;
clear dLightSpeed;
