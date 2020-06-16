%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab6_Part1_2.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/12/2020
% Instructor: Prof. Jaio
% Description:  Generates electron and hole concentrations and the position
% of the fermi-level given different input conditions from the user. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

h = 6.63e-34;
kev = 8.617e-5;
kJ = 1.38e-23;

%%%%%%%%%%%%% Calculations based on user input %%%%%%%%%%%%%
s = 'Y';
while(s == 'Y')
T  = input('T: ');
Na = input('Na: ');
Nd = input('Nd: ');
EgSILI = E(EgzSILI, alphaSILI, betaSILI, T);
NiSILI = NI(h,kev,kJ,T,MnSILI,MpSILI,EgSILI);

fprintf('N0 = %.2e\n', N0(Na,Nd,NiSILI));
fprintf('P0 = %.2e\n', P0(Na,Nd,NiSILI));
fprintf('Ef - Ei = %.4f\n', EfEi(kev,T,N0(Na,Nd,NiSILI),NiSILI));

s = input('\nContinue?\n', 's');
end

%%%%%%% N0 calculation function %%%%%%%%
function n0 = N0(Na,Nd,ni)
n0 = (Nd - Na)/2 + (((Nd - Na)/2)^2 + ni.^2).^0.5;
end

%%%%%%% P0 calculation function %%%%%%%%
function p0 = P0(Na,Nd,ni)
p0 = (Na - Nd)/2 + (((Na - Nd)/2)^2 + ni.^2).^0.5;
end

%%%%%%% Ef-Ei calculation function %%%%%%%%
function EFEI = EfEi(k, T, n0, ni)
EFEI = k*T*log(n0/ni);
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