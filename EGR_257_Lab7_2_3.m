%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab7_2_3.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/26/2020
% Instructor: Prof. Jaio
% Description: This program plots the total hole concentration for two
% conditions. The first is under steady state injection and the excess
% carriers undergo diffusion and recombination. The second is also under
% steady state injection but all R-G processes are negligible, two boundary
% conditions are provided. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clc

n0 = 1e13;
ni = 1.5e10;
p0 = ni.^2./n0;
k = 1.38e-23;
T = 300;
excess0 = 1e7;
q = 1.6e-19;
mup = 480;
L = 0.1;

Dp = (k*T*mup)/q;  %Einstein's Relationship 
x = 0:0.0001:0.03;
x1 = 0:0.0001:L;

%%%%%%% Plot of total Hole con. at steady state and diff and recom %%%%%%%%
figure;
plot(x,P(p0,excess0,Dp,x,1e-6), x,P(p0,excess0,Dp,x,0.01e-6));
legend("Px at tau = 1 us", "Px at tau = 0.01 us");
grid; xlabel('x (cm)'); ylabel('Px (1/cm^3)');
title("Steady State, Diffusion and Recombination");

%%%%%%% Plot of total hole con. at steady state and neg. R-G %%%%%%%%
figure;
plot(x1,Pb(p0,excess0,x1,L));
grid; xlabel('x (cm)'); ylabel('Px (1/cm^3)');
title("Steady State, Diffusion Only")

%%%%%% Hole concentration calculation function, condition 1 %%%%%%%%
function Px = P(p0,S0,D, x, tau)
Px = p0 + S0 .* exp(-x./(sqrt(D.*tau)));    %equation 7 solution
end

%%%%%% Hole concentration calculation function, condition 2 %%%%%%%%
function Px = Pb(p0,S0, x, L)
Px = p0 + S0 -(S0./L).*x;       %linear solution to 2nd derivative
end

