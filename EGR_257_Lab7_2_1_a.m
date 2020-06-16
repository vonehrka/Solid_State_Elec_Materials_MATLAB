%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab7_2_1_a.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 3/26/2020
% Instructor: Prof. Jaio
% Description: Program plots the hole concentration with diffusion action
% with no electrical field and no external light illumination except for a
% single light pulse. Program also creates an animation of the diffusion
% over time. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

n0 = 1e15;
ni = 1.5e10;
p0 = 2.25e5;
Sn0 = 1e7;
Sp0 = 1e7;
Dp = 12;

x = -0.5:0.01:0.5;
x1 = 0:0.01:1;

%%%%%%% Plot of Hole carrier concentration at given times %%%%%%%%
figure;
plot(x1, P(p0,Sp0,Dp,x,0.02), x1,P(p0,Sp0,Dp,x,0.1),...
    x1,P(p0,Sp0,Dp,x,0.2), x1,P(p0,Sp0,Dp,x,0.25));
legend("Px at t = 0.02ms", "Px at t = 0.1ms", "Px at t = 0.2ms", ...
    "Px at t = 0.25ms");
grid; xlabel('x (cm)'); ylabel('Px (1/cm^3)');
title("Hole Concentration at Different Times")

%%%%%%% Plot of Hole concentration over time, animated version %%%%%%%%
figure;
time_array  = 0.02: .005: 0.25;
for i = 1:length(time_array)
    plot(x1, P(p0,Sp0,Dp,x,time_array(i)));
    grid; xlabel('x (cm)'); ylabel('Px (1/cm^3)');
    title("Hole Concentration Over Time")
    xlim([0 1]);
    ylim([0 2e8]);
    pause(0.05);
end

%%%%%%% Hole concentration calculation function%%%%%%%%
function Px = P(p0,S0,D, x, t)
Px = p0 + (S0./(2.*sqrt(pi.*D.*t./1000))) .* ...
    exp(-1.*(x.^2)./(4.*D.*t./1000));
end










