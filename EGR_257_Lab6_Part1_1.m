%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab6_Part1_1.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/12/2020
% Instructor: Prof. Jaio
% Description:  Generates plots of intrinsic carrier concentrations of 
% three different semiconductors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all
clc

%%%%%%%% Constants %%%%%%%%
EgzGERM = 0.7437;
alphaGERM = 4.4e-4;
betaGERM = 235;
MnGERM = 0.56*9.11e-31;
MpGERM = 0.29*9.11e-31;

EgzSILI = 1.166;
alphaSILI = 4.73e-4;
betaSILI = 636;
MnSILI = 1.08*9.11e-31;
MpSILI = 0.81*9.11e-31;

EgzGAAS  = 1.519;
alphaGAAS = 5.41e-4;
betaGAAS = 204;
MnGAAS = 0.067*9.11e-31;
MpGAAS = 0.47*9.11e-31;

h = 6.63e-34;           %Planck's Constant
kev = 8.617e-5;         %K in terms of eV
kJ = 1.38e-23;          %K in terms of J
T = 200:1:700;          %In Kelvin

%%%%%%% Temp Dependent Eg values %%%%%%%%%%%
EgGERM = E(EgzGERM, alphaGERM, betaGERM, T);
EgSILI = E(EgzSILI, alphaSILI, betaSILI, T);
EgGAAS = E(EgzGAAS, alphaGAAS, betaGAAS, T);

%%%%%%% Intrinsic carrier concentration function calls %%%%%%%%%
NiGERM = NI(h,kev,kJ,T,MnGERM,MpGERM,EgGERM);
NiSILI = NI(h,kev,kJ,T,MnSILI,MpSILI,EgSILI);
NiGAAS = NI(h,kev,kJ,T,MnGAAS,MpGAAS,EgGAAS);

%%%%%%% Logarithmic plot of carrier concentration %%%%%%%%
figure;
semilogy(T, NiGERM, T,NiSILI, T,NiGAAS);
legend("Germanium", "Silicon", "GaAs");
grid; xlabel('Temperature (K)'); ylabel('Ni(T)');
title("Intrinsic Carrier Concentration of Three Materials");

%%%%%%% Eg calculation function %%%%%%%%
function Eg = E(Eg, alpha, beta,temp)
Eg = Eg - (alpha * (temp.^2)) ./ (temp + beta);
end

%%%%%%% Ni calculation function %%%%%%%%
function Ni = NI(h,kev,kJ,T, Mn, Mp,Eg)
Ni = 2.*(((2.*pi.*kJ).*T )./ h^2).^(3./2) .* (Mn .* Mp).^(3/4) .* ...
    exp(-Eg./(2.*kev.*T)) .* (100^-3);
end
