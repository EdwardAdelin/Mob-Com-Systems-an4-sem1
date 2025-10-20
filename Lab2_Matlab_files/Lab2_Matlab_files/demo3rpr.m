


function demo3rpr(x)

crlf = sprintf('\r\n');
disp(crlf)
disp('Simularea pierderilor de propagare in cazul reflectiei pe suprafete plane')
disp(crlf)

%if (nargin==0)
 %   dMinDistance = input('Introduceti valoarea minima a distantei intre emitator si receptor [m] = ')
  %  dMaxDistance = input('Introduceti valoarea maxima a distantei intre emitator si receptor [m] = ')
   % dGainT = input('Introduceti valoarea castigului in putere a antenei emitatorului = ')
    %dGainR = input('Introduceti valoarea castigului in putere a antenei receptorului = ')
    %dHeightT = input('Introduceti inaltimea antenei emitatorului [m] = ')
    %dHeightR = input('Introduceti inaltimea antenei receptorului [m] = ')
%else
    dMinDistance=10
    dMaxDistance=10000
    %dMaxDistance=60
    dGainT = 1
    dGainR = 1
    dHeightT = 10
    dHeightR = 1
%end

dDistanceShortRange = 25;
dDistanceForComparison = 150;
Resolution=1000;
dFrequency=[10^6 4*10^6 12*10^6 9*10^8 10^9];

for i=1:5
    dPsi(i)=pi*i/(2*5); % unghi incidenta: 5 valori
end

% ========================================================================================
disp(crlf)
disp(' Programul utilizeaza pentru determinari functia ReflPlan ce determina ')
disp(' pierderile de propagare in situatia reflexiei pe suprafete plane. ')
disp(' Modul de utilizare a functiei ReflPlan:')
help ReflPlan
disp(crlf)

% =========================== PLANE SURFACE REFLECTION ================================
% Calcul pierderi de propagare la reflectia pe suprafete plane
for i=1:Resolution
   dx(i)=dMaxDistance*i/Resolution;
   dxlog(i)=dMinDistance*(dMaxDistance/dMinDistance)^(i/Resolution);
   dxShortRange(i)=dDistanceShortRange*i/Resolution;
   dxlogShortRange(i)=(dDistanceShortRange/100)*(100)^(i/Resolution);
   dxForComparison(i)=dDistanceForComparison*i/Resolution;
   dxlogForComparison(i)=(dDistanceForComparison*7/10000)*(9000)^(i/Resolution);
   FreeSpaceLoss(i)=FrSpcLss(dxForComparison(i), dFrequency(4), dGainT, dGainR);
   logFreeSpaceLoss(i)=FrSpcLss(dxlogForComparison(i), dFrequency(4), dGainT, dGainR);
   PlanReflLossForComparison(i)=ReflPlan(dFrequency(4), dxForComparison(i), dGainT, dGainR, dHeightT, dHeightR);
   logPlanReflLossForComparison(i)=ReflPlan(dFrequency(4), dxlogForComparison(i), dGainT, dGainR, dHeightT, dHeightR);
   for j=1:5
      PlanReflLoss(i,j)=ReflPlan(dFrequency(j), dx(i), dGainT, dGainR, dHeightT, dHeightR);
      LogPlanReflLoss(i,j)=ReflPlan(dFrequency(j), dxlog(i), dGainT, dGainR, dHeightT, dHeightR);
      PlanReflLossShortRange(i,j)=ReflPlan(dFrequency(j), dxShortRange(i), dGainT, dGainR, dHeightT, dHeightR);
      LogPlanReflLossShortRange(i,j)=ReflPlan(dFrequency(j), dxShortRange(i), dGainT, dGainR, dHeightT, dHeightR);
      truePlanReflLoss(i,j) = trueReflPlan(dFrequency(5), dx(i), dGainT, dGainR, dHeightT, dHeightR, dPsi(j)); % 1GHz; 5 valori pt unghiul  de incidenta
   end
end

disp(crlf)
disp(' Apasa ENTER pentru a afisa pierderile de propagare in spatiul liber')
disp(' comparativ cu reflexia pe suprafete plane la frecventa f=100 MHz. ')
disp(' Pentru afisare pe axa Ox s-a ales o reprezentare liniara.')
disp(crlf)
pause;

figure
subplot(111), plot(dxForComparison,PlanReflLossForComparison,'red',dxForComparison,FreeSpaceLoss,'green');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane comparativ cu propagarea in spatiu liber functie de distanta');
legend('Reflexie pe supr. plane','Propagare in spatiul liber', 'f=100 MHz')
grid on
zoom on

disp(crlf)
disp(' Acelasi grafic, dar cu o reprezentare logaritmica pe axa Ox. Apasa ENTER.')
disp(crlf)
pause;

figure
subplot(111), semilogx( dxlogForComparison, logPlanReflLossForComparison, 'red', dxlogForComparison, logFreeSpaceLoss, 'green');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane comparativ cu propagarea in spatiu liber functie de distanta');
legend('Reflexie pe supr. plane','Propagare in spatiul liber', 'f=100 MHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru a afisa pierderile de propagare in cazul reflexiei')
disp(' pe suprafete plane functie de distanta cu frecventa parametru. ')
disp(' Graficele sunt facute in proximitatea emitatorului. Pentru afisare ')
disp(' pe axa Ox s-a ales o reprezentare liniara.')
disp(crlf)
pause;

figure
subplot(111), plot(dxShortRange,PlanReflLossShortRange(1:Resolution,1),'magenta',dxShortRange,PlanReflLossShortRange(1:Resolution,2),'blue',dxShortRange,PlanReflLossShortRange(1:Resolution,3),'red',dxShortRange,PlanReflLossShortRange(1:Resolution,4),'green',dxShortRange,PlanReflLossShortRange(1:Resolution,5),'yellow');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane functie de distanta cu frecventa parametru in proximitatea emitatorului');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Acelasi grafic, dar cu o reprezentare logaritmica pe axa Ox. Apasa ENTER.')
disp(crlf)
pause;

figure
subplot(111), semilogx(dxlogShortRange,LogPlanReflLossShortRange(1:Resolution,1),'magenta',dxlogShortRange,LogPlanReflLossShortRange(1:Resolution,2),'blue',dxlogShortRange,LogPlanReflLossShortRange(1:Resolution,3),'red',dxlogShortRange,LogPlanReflLossShortRange(1:Resolution,4),'green',dxlogShortRange,LogPlanReflLossShortRange(1:Resolution,5),'yellow');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane functie de distanta cu frecventa parametru in proximitatea emitatorului');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru a afisa pierderile de propagare in cazul reflexiei')
disp(' pe suprafete plane functie de distanta cu frecventa parametru. ')
disp(' Graficele sunt facute la distanta de emitator. Pentru afisare ')
disp(' pe axa Ox s-a ales o reprezentare liniara.')
disp(crlf)
pause;

figure
subplot(111), plot(dx,PlanReflLoss(1:Resolution,1),'magenta',dx,PlanReflLoss(1:Resolution,2),'blue',dx,PlanReflLoss(1:Resolution,3),'red',dx,PlanReflLoss(1:Resolution,4),'green',dx,PlanReflLoss(1:Resolution,5),'yellow');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane functie de distanta cu frecventa parametru la distanta');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Acelasi grafic, dar cu o reprezentare logaritmica pe axa Ox. Apasa ENTER.')
disp(crlf)
pause;

figure
subplot(111), semilogx( dxlog,LogPlanReflLoss(1:Resolution,1),'magenta',dxlog,LogPlanReflLoss(1:Resolution,2),'blue',dxlog,LogPlanReflLoss(1:Resolution,3),'red', dxlog,LogPlanReflLoss(1:Resolution,4),'green', dxlog,LogPlanReflLoss(1:Resolution,5),'yellow');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de propagare in cazul reflexiei pe suprafete plane functie de distanta cu frecventa parametru la distanta');
legend('f=1 MHz','f=4 MHz','f=12 MHz','f=100 MHz','f=1 GHz')
grid on
zoom on

disp(crlf)
disp(' Apasa ENTER pentru afisarea pierderilor de propagare calculate cu relatia exacta ')
disp(' comparativ cu relatia obtinuta cu aproximarea de suprafata plana. ')
disp(crlf)
pause;

figure
subplot(111), plot(dx,PlanReflLoss(1:Resolution,5),'magenta',dx,-abs(truePlanReflLoss(1:Resolution,3)),'blue',dx,-abs(truePlanReflLoss(1:Resolution,3)),'red',dx,-abs(truePlanReflLoss(1:Resolution,4)),'green',dx,-abs(truePlanReflLoss(1:Resolution,5)),'yellow');
ylabel('Losses [dB]')
xlabel('Distance [m]')
title('Pierderile de pr. pt. reflexia pe suprafete plane, 1GHz, rel. exacta versus rel cu aproximare ');
legend('Aprox.supraf.plana','Fara aprox.;Psi1','Fara aprox.;Psi3','Fara aprox.;Psi4','Fara aprox.;Psi5')
grid on
zoom on

clear all;
