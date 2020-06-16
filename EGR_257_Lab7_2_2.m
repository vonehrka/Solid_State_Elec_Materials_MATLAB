%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab7_2_2.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/26/2020
% Instructor: Prof. Jaio
% Description: The total hole concentration for n-type Si material doped
% with 1e13 doners is ploted for several instances of optical generation
% and recombination. The conductivity and change of conductivity are also
% calculated in the program. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clc

n0 = 1e13;
ni = 1.5e10;
p0 = (ni.^2)./n0;
length = 0.1;
gop = 1e20;
tau = 1e-6;
tauf = 0.5e-6;
q = 1.6e-19;
mun = 1350;
mup = 480;

T1 = tau;
T2 = 10*tau;
T4 = 2*tau;

t = 0:0.01e-6:10e-6;
t0 = 0:0.01e-6:1e-6;
t1 = 1e-6:0.01e-6:10e-6;
t3 = 10e-6:0.01e-6:20e-6;
t4 = 1e-6:0.01e-6:2e-6;
t5 = 2e-6:0.01e-6:10e-6;

%A%%%%%% Plot of Hole concentration with time %%%%%%%%
figure;
plot(t,Optical(p0,gop,tau,t));
grid; xlabel('Time (s)'); ylabel('Px (1/cm^3)');
title("Hole Concentration given Optical Generation");
xlim([0 10e-6]);


%B%%%%%% Photoconductivity for t >> 5tau %%%%%%%%
Photo_sigma = q .* (mun*Optical(0,gop,tau,100*tau) + ...
    mup*Optical(0,gop,tau,100*tau))

%C%%%%%% Fractional Change of Conductivity %%%%%%%%
sigma0 = q * (mun*n0 + mup*p0)
sigma_change = (Photo_sigma - sigma0)./sigma0

%D%%%%%% Plot of Hole concentration with time, light off at tau %%%%%%%%
figure;
plot(t0,Optical(p0,gop,tau,t0),'-b',t1,LightOff(p0,gop,tau,T1,t1),'-b');
grid; xlabel('Time (s)'); ylabel('Px (1/cm^3)');
title("At Time = 1us, Light is Turned Off");
xlim([0 10e-6]);

%E%%%%%% Plot of Hole concentration with time, light off at 10tau %%%%%%%%
figure;
plot(t,Optical(p0,gop,tau,t),'-b', t3,LightOff(p0,gop,tau,T2,t3),'-b');
grid; xlabel('Time (s)'); ylabel('Px (1/cm^3)');
title("At Time = 10us, Light is Turned Off");
xlim([0 20e-6]);

%F%%%%%% Plot of Hole con. with time, light off at 10tau, new tau %%%%%%%%
figure;
plot(t,Optical(p0,gop,tauf,t),'-b', t3,LightOff(p0,gop,tauf,T2,t3),'-b');
grid; xlabel('Time (s)'); ylabel('Px (1/cm^3)');
title("At Time = 10us, Light is Turned Off, New Tau = 0.5us");
ylim([0 10e13]);
xlim([0 20e-6]);

%G%%%%%% Plot of Hole con. with time, light off at tau, on at 2tau %%%%%%%%
figure;
plot(t0,Optical(p0,gop,tau,t0),'-b',t4,LightOff(p0,gop,tau,T1,t4),'-b', ...
    t5, OnAgain(p0,gop,tau,T1,T4,t5),'-b');
grid; xlabel('Time (s)'); ylabel('Px (1/cm^3)');
title("Time = 1us, Light Off, Time = 2 us, Light On Again");
xlim([0 10e-6]);

%%%%%%% Concentration calculation based on optical generation%%%%%%%%
function Concentration0 = Optical(p0,gop,tau,t)
Concentration0 = p0 + gop.*tau.*(1 - exp((-t)./tau));
end

%%%%%%% Concentration calculation based on recombination %%%%%%%%
function Concentration1 = LightOff(p0,gop,tau,T,t)
Concentration1 = p0 + gop.*tau.*(1 - exp(-T./tau)).*exp(-(t-T)./tau);
end

%%%%%%% Concentration after light is turned on a second time %%%%%%%%
function Concentration2 = OnAgain(p0,gop,tau,T1,T2,t)
Concentration2 = LightOff(p0,gop,tau,T1,T2)+ Optical(p0,gop,tau,t-T2);
end






