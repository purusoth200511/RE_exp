clc;
clear;
close all;
% Parameters
K=1.38065e-23;
q=1.602e-19;
Iscn=8.21;
Vocn=32.9;
Ki=0.0032;
Tn=25+273;
T=25+273;
Gn=1000;
G=1000;
a=2;
Eg=1.2;
Rs=0.221;
Rp=415.405;
Ns=54;
% PV parameters
Vt=Ns*K*T/q;
Ipv=(Iscn+Ki*(T-Tn))*(G/Gn);
I0=Iscn/(exp(Vocn/(a*Ns*K*Tn/q))-1);
% Voltage range
V=0:0.1:Vocn;
I=zeros(size(V));
% I-V calculation
for k=1:length(V)
    I(k)=Ipv;
    for n=1:100
        Inew=Ipv-I0*(exp((V(k)+I(k)*Rs)/(a*Vt))-1) ...
              -(V(k)+I(k)*Rs)/Rp;
        if abs(Inew-I(k))<1e-8
            break;
        end
        I(k)=Inew;
    end
    I(k)=max(Inew,0);
end
% P-V calculation
P=V.*I;
% Output
[Pmax,idx]=max(P);
Vmp=V(idx);
Imp=I(idx);
fprintf('Isc = %.2f A\n',I(1));
fprintf('Voc = %.2f V\n',Vocn);
fprintf('Vmp = %.2f V\n',Vmp);
fprintf('Imp = %.2f A\n',Imp);
fprintf('Pmax = %.2f W\n',Pmax);
% I-V Characteristic
figure;
plot(V,I,'LineWidth',2);
grid on;
xlabel('Voltage (V)');
ylabel('Current (A)');
title('I-V Characteristics of PV Array');
% P-V Characteristic
figure;
plot(V,P,'LineWidth',2);
grid on;
xlabel('Voltage (V)');
ylabel('Power (W)');
title('P-V Characteristics of PV Array');