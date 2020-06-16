%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab6_Part1_2.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/12/2020
% Instructor: Prof. Jaio
% Description:  Generates plots of mobility and resistivity versus doping
% and temperature.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all
clc

%%%%%%%% Constants %%%%%%%%
EgzSILI = 1.166;
alphaSILI = 4.73e-4;
betaSILI = 636;
MnSILI = 1.08*9.11e-31;
MpSILI = 0.81*9.11e-31;

h = 6.63e-34;
kev = 8.617e-5;
kJ = 1.38e-23;

NrefE = 1.3e17;
MuminE = 92;
Mu0E = 1268;
alphaE = 0.91;
Nd = logspace(14,19);

NrefH = 2.35e17;
MuminH = 54.3;
Mu0H = 406.9;
alphaH = 0.88;
Na = logspace(14,19);

%%%%%%%%%%% Mobility vectors generated from doping vectors %%%%%%%%%%%%
MunD = MU(NrefE, MuminE, Mu0E, alphaE, Nd);
MupD = MU(NrefH, MuminH, Mu0H, alphaH, Na);

%%%%%%%%%%% Mobility generated from a range of temperatures %%%%%%%%%%%%
n = [2.4, -0.57, -2.3, -0.146];
T = 200:1:600;
MunT = MU(A(NrefE,T,n(1)), A(MuminE,T,n(2)), A(Mu0E, T, n(3)),...
    A(alphaE, T, n(4)), 1e16);
MupT = MU(A(NrefH,T,n(1)), A(MuminH,T,n(2)), A(Mu0H, T, n(3)),...
    A(alphaH, T, n(4)), 1e16);

%%%% Resistivity based on doping, used previous functions %%%%
EgSILI = E(EgzSILI, alphaSILI, betaSILI, 300);
NiSILI = NI(h,kev,kJ,300,MnSILI,MpSILI,EgSILI);
n0 = N0(0, Nd, NiSILI);
p0 = P0(Na, 0, NiSILI);
RnD = Resistivity(n0, MunD);
RpD = Resistivity(p0, MupD);

%%%% Resistibity based on temperature, used previous functions %%%%
EgSILI = E(EgzSILI, alphaSILI, betaSILI, T);
NiSILI = NI(h,kev,kJ,T,MnSILI,MpSILI,EgSILI);
n0 = N0(0, 1e14, NiSILI);
p0 = P0(1e14, 0, NiSILI);

RnT = Resistivity(n0, MunT);
RpT = Resistivity(p0, MupT); 

%%%%%%% Logarithmic plot of Mobility with doping %%%%%%%%
figure;
loglog(Nd, MunD, Na,MupD);
legend("Electron Mobility", "Hole Mobility");
grid; xlabel('Doping Nd/Na (1/cm^3)'); ylabel('Mobility (cm^2/Vs)');
title("Mobility of Silicon versus Doping at Thermal Equilibrium");

%%%%%%% Logarithmic plot of Mobility with Temperature %%%%%%%%
figure;
semilogy(T, MunT, T,MupT);
legend("Electron Mobility", "Hole Mobility");
grid; xlabel('Temperature (K)'); ylabel('Mobility (cm^2/Vs)');
title("Mobility of Silicon versus Temperature with Constant Doping");

%%%%%%% Logarithmic plot of Resistivity with doping %%%%%%%%
figure;
loglog(Nd,RnD, Na,RpD);
legend("n-type", "p-type");
grid; xlabel('Doping Nd/Na (1/cm^3)'); ylabel('Resistivity (cm^2/Vs)');
title("Resistivity of Silicon versus Doping at Thermal Equilibirum");

%%%%%%% Logarithmic plot of Resistivity with temperature %%%%%%%%
figure;
semilogy(T, RnT, T,RpT);
legend("n-type", "p-type");
grid; xlabel('Temperature (K)'); ylabel('Resistivity (cm^2/Vs)');
title("Resistivity of Silicon versus Temperature with Constant Doping");

%%%%%%% Mobility Calculation %%%%%%%%
function Mu = MU(Nref, mumin, mu0, alpha, N)
Mu = mumin + (mu0 ./ ((1 + (N ./ Nref)).^ alpha));
end

%%%%%%% A Parameter Calculation (Temperature dependent) %%%%%%%%
function a = A(A300, T, n)
a = A300 .* (T / 300) .^ n;
end

%%%%%%% Eg calculation function %%%%%%%%
function Eg = E(Eg, alpha, beta,temp)
Eg = Eg - (alpha * (temp.^2)) ./ (temp + beta);
end

%%%%%%% Ni calculation function %%%%%%%%
function Ni = NI(h,kev,kJ,T, Mn, Mp,Eg)
Ni = 2.*(((2.*pi.*kJ).*T )./ h^2).^(3./2) .* (Mn .* Mp).^(3/4) .* ...
    exp(-Eg./(2.*kev.*T)) .* (100^-3);
end

%%%%%%% Carrier Concentration Calculations %%%%%%
function n0 = N0(Na,Nd,ni)
n0 = (Nd - Na)./2 + (((Nd - Na)./2).^2 + ni.^2).^0.5;
end

function p0 = P0(Na,Nd,ni)
p0 = (Na - Nd)./2 + (((Na - Nd)./2).^2 + ni.^2).^0.5;
end

%%%%%%% Resistivity Calculation %%%%%%%%
function R = Resistivity(C, mu)
q = 1.602e-19;
R = 1 ./ (q.*C.*mu);
end
