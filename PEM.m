clc;
clear;
close all;
% Given parameters
T = 310;                  % Temperature (K)
PH2 = 1;                  % Hydrogen pressure (atm)
PO2 = 1;                  % Oxygen pressure (atm)
A = 69.7;                 % Active area (cm^2)
xi1 = -0.475;
xi3 = 7.6e-5;
xi4 = -1e-4;
Rc = 0.00019;             % Contact resistance (ohm)
Rm = 0.08;                % Membrane resistance (ohm)
B = 0.0171;
Jmax = 1600;
N = 52;                   % Number of cells
% Current
I = 0.1:0.1:10;
% Nernst voltage
EN = 1.229 - 0.85e-3*(T-298.15) ...
     + 1.31e-5*T*(log(PH2)+0.5*log(PO2));
% Oxygen concentration
CO2 = PO2/(5.08e6*exp(-498/T));
% Activation coefficient
xi2 = 0.00286 + 0.0002*log(A) ...
      + 4.3e-5*log(CO2);
% Calculate voltage and power
for k = 1:length(I)
    Vact = -(xi1 + xi2*T + xi3*T*log(CO2) ...
             + xi4*T*log(I(k)));

    Vohmic = I(k)*(Rm + Rc);
    J = I(k)/A;
    Vcon = -B*log(1-J/Jmax);
    V(k) = N*(EN - Vact - Vohmic - Vcon);
    P(k) = V(k)*I(k);
end
% Plot
figure;
yyaxis left
plot(I,V,'LineWidth',1.5);
ylabel('Fuel Cell Voltage (V)');
ylim([0 100]);
yyaxis right
plot(I,P,'LineWidth',1.5);
ylabel('Fuel Cell Power (W)');
ylim([0 300]);
xlabel('Fuel Cell Current (A)');
xlim([0 10]);
xticks(0:1:10);
grid on;
title('PEM Fuel Cell Voltage and Power Characteristics');
legend('Voltage','Power','Location','best');