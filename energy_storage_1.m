clear;
clc;
close all;
Ibat = 5;
ns = 6;
SOC1 = 0.2;
K = 0.8;
D = 1e-5;
SOCm = 936;
t = 0:0.1:7;
SOC = zeros(size(t));
Vbat = zeros(size(t));
SOC(1) = SOC1;
for k = 2:length(t)
    B = SOC(k-1);
    V1 = (2 + 0.148*B)*ns;
    R1 = (0.758 + 0.1309/(1.06-B))*ns/SOCm;
    dSOC = (K*V1*Ibat - D*B*SOCm)/SOCm;
    SOC(k) = SOC(k-1) + dSOC*(t(k)-t(k-1));
    Vbat(k) = V1 + Ibat*R1;
end
Vbat(1) = (2 + 0.148*SOC(1))*ns + ...
          Ibat*((0.758 + 0.1309/(1.06-SOC(1)))*ns/SOCm);
figure;
plot(t*10,Vbat,'LineWidth',1);
xlabel('Time');
ylabel('Battery Voltage');
grid on;
figure;
plot(t*10,SOC,'LineWidth',1);
xlabel('Time');
ylabel('State of Charge');
grid on;