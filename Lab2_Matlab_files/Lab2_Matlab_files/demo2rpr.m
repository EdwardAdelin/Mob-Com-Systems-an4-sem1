




function demo2rpr(x)

crlf = sprintf('\r\n');
disp(crlf)
disp('Simularea variatiei coeficientului de reflexie al pamintului')
disp(crlf)

%if (nargin==0)
 %   epsRelativ = input('Introduceti valoarea relativa a constantei dielectrice epsilon_relativ = ')
  %  sigma = input('Introduceti valoarea conductivitatii sigma = ')
%else
    epsRelativ=15   % epsRelativ al pamintului %
    sigma = 0.012   
%end

dFrequency=[10^6 4*10^6 12*10^6 10^8 10^9];

Resolution=1000;

% ========================================================================================
disp(crlf)
disp(' Programul utilizeaza pentru determinari functia ErthRefC ce determina ')
disp(' valoarea coeficientului de reflexie al pamintului pentru un unghi de ')
disp(' incidenta dat, functie de tipul de polarizare a undei, conductivitatea')
disp(' si constanta dielectrica a pamintului.')
disp(' Modul de utilizare a functiei ErthRefC:')
help ErthRefC
disp(crlf)

% =========================== REFLECTION COEFFICIENTS ================================
% Calcul variatie coeficienti de reflexie
for i=1:Resolution
    %dx(i)=dMaxDistance*i/Resolution;
    dAngle(i)=pi*i/(2*Resolution);
end

for i=1:Resolution
   for j=1:5
      outVector=ErthRefC(dFrequency(j), dAngle(i), epsRelativ, sigma);
      absRhoH(i,j)=outVector(3);
      absRhoV(i,j)=outVector(4);
      angRhoH(i,j)=outVector(5);
      angRhoV(i,j)=outVector(6);
   end
end

disp(crlf)
disp(' Apasa ENTER pentru a afisa modulul coef. de reflexie pentru')
disp(' unda polarizata vertical.')
disp(crlf)
pause;

figure
subplot(111), plot(dAngle,absRhoV(1:Resolution,1),'magenta',dAngle,absRhoV(1:Resolution,2),'blue',dAngle,absRhoV(1:Resolution,3),'red',dAngle,absRhoV(1:Resolution,4),'green',dAngle,absRhoV(1:Resolution,5),'yellow');
ylabel('Modul RhoV')
xlabel('Unghi incidenta [rad]')
title('Modulul coef. de reflexie al pamintului RhoV, functie de unghiul de incidenta, cu frecventa parametru');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru a afisa faza coef. de reflexie pentru')
disp(' unda polarizata vertical.')
disp(crlf)
pause;

figure
subplot(111), plot(dAngle,angRhoV(1:Resolution,1),'magenta',dAngle,angRhoV(1:Resolution,2),'blue',dAngle,angRhoV(1:Resolution,3),'red',dAngle,angRhoV(1:Resolution,4),'green',dAngle,angRhoV(1:Resolution,5),'yellow');
ylabel('Faza RhoV')
xlabel('Unghi incidenta [rad]')
title('Faza coef. de reflexie al pamintului RhoV, functie de unghiul de incidenta, cu frecventa parametru');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru a afisa modulul coef. de reflexie pentru')
disp(' unda polarizata orizontal.')
disp(crlf)
pause;

figure
subplot(111), plot(dAngle,absRhoH(1:Resolution,1),'magenta',dAngle,absRhoH(1:Resolution,2),'blue',dAngle,absRhoH(1:Resolution,3),'red',dAngle,absRhoH(1:Resolution,4),'green',dAngle,absRhoH(1:Resolution,5),'yellow');
ylabel('Modul RhoH')
xlabel('Unghi incidenta [rad]')
title('Modulul coef. de reflexie al pamintului RhoH, functie de unghiul de incidenta, cu frecventa parametru');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru a afisa faza coef. de reflexie pentru')
disp(' unda polarizata orizontal.')
disp(crlf)
pause;

figure
subplot(111), plot(dAngle,angRhoH(1:Resolution,1),'magenta',dAngle,angRhoH(1:Resolution,2),'blue',dAngle,angRhoH(1:Resolution,3),'red',dAngle,angRhoH(1:Resolution,4),'green',dAngle,angRhoH(1:Resolution,5),'yellow');
ylabel('Faza RhoH')
xlabel('Unghi incidenta [rad]')
title('Faza coef. de reflexie al pamintului RhoH, functie de unghiul de incidenta, cu frecventa parametru');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

clear all;
