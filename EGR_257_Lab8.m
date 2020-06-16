%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename: EGR_257_Lab8.m
% Author: Karmyn VonEhr & Andrew Townley
% Date: 4/9/2020
% Instructor: Prof. Jaio
% Description: The following program graphs the electric field,
% electrostatic potential, charge carrier densities, and net charge
% densities of a PN junction under three different doping conditions.
% Depletion approximation was assumed. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clc

%%%%%%%%%%%% Constants %%%%%%%%%%%%%
T = 300;
kT = 0.0259;
er = 11.8;
eo = 8.85e-14;
q = 1.6e-19;
niSI = 1.5e10;

%%%%%%%%%%%%%%% PART II %%%%%%%%%%%%%%%%%
Nda1 = 2e15;

Vbi1 = VBI(Nda1,Nda1,niSI,kT);      %built in voltage function call
W1 = Width(Nda1,Nda1,Vbi1,q,er,eo); %depletion width function call
Xp1 = XP(W1,Nda1,Nda1);             %P and N depletion widths
Xn1 = XN(W1,Nda1,Nda1);
np1 = niSI^2/Nda1;                  %Minority carrier concentration calc
pn1 = niSI^2/Nda1;

X1 = -2e-4:1e-7:-Xp1;               %ranges for graphing within each region
X2 = -Xp1:1e-7:0;
X3 = 0:1e-7:Xn1;
X4 = Xn1:1e-7:1e-4;

Ones1 = ones(length(X1),1);         %ones vectors for graphing constants
Ones2 = ones(length(X2),1);
Ones3 = ones(length(X3),1);
Ones4 = ones(length(X4),1);

figure;
%Plot of the electric field in each of the four regions of x
subplot(2,1,1);
plot(X1,0.*X1, 'b', X2, ElectricField(X2,-Xp1,Nda1,q,er,eo),'b',...
    X3, ElectricField(X3,Xn1,Nda1,-q,er,eo),'b', X4, 0.*X4, 'b');
grid; xlabel('x (cm)'); ylabel('E (V/cm)');
title("Electric Field as a Function of X");

%Plot of the electrostatic potention in each region
subplot(2,1,2);
plot(X1,0.*X1, 'b', X2, PPotential(X2,Xp1,Nda1,q,er,eo),'b',...
    X3, NPotential(X3,Xn1,Xp1,Nda1,Nda1,q,er,eo),'b', X4, Vbi1.*Ones4, 'b');
grid; xlabel('x (cm)'); ylabel('Potential (V)');
title("Electrostatic Potential as a Function of X");

figure;
%plot of the charge densities in each region
%Doping = majority becuase N >> ni in all test cases
subplot(2,1,1);
plot(X1,Nda1*Ones1,'b',X1,pn1*Ones1,'r', ...
    X4,np1*Ones4,'m',X4,Nda1*Ones4,'g');
ylim([-1e15 3e15]);
grid; xlabel('x (cm)'); ylabel('Carrier Density (1/cm^3)');
title("Charge Carrier Densities, p and n, as a Function of X");
legend({'p_p','n_p','p_n','n_n'},'Location','southwest');

%plot of the net charge density in each region
subplot(2,1,2);
plot(X1,0.*X1, 'b-', X2, Rho(-q,Nda1)*Ones2,'b-',...
    X3, Rho(q,Nda1)*Ones3,'b-', X4, 0.*Ones4, 'b-');
grid; xlabel('x (cm)'); ylabel('Charge Density (C/cm^3)');
title("Net Charge Desity, p, as a Function of X");

%%%%%%%%%%%%%%% PART III %%%%%%%%%%%%%%%%%
Nda2 = 1e17;

Vbi2 = VBI(Nda2,Nda2,niSI,kT);
W2 = Width(Nda2,Nda2,Vbi2,q,er,eo);
Xp2 = XP(W2,Nda2,Nda2);
Xn2 = XN(W2,Nda2,Nda2);
np2 = niSI^2/Nda2;
pn2 = niSI^2/Nda2;

X1 = -2e-4:1e-7:-Xp2;
X2 = -Xp2:1e-7:0;
X3 = 0:1e-7:Xn2;
X4 = Xn2:1e-7:1e-4;

Ones1 = ones(length(X1),1);
Ones2 = ones(length(X2),1);
Ones3 = ones(length(X3),1);
Ones4 = ones(length(X4),1);

figure;
subplot(2,1,1);
plot(X1,0.*X1, 'b', X2, ElectricField(X2,-Xp2,Nda2,q,er,eo),'b',...
    X3, ElectricField(X3,Xn2,Nda2,-q,er,eo),'b', X4, 0.*X4, 'b');
grid; xlabel('x (cm)'); ylabel('E (V/cm)');
title("Electric Field as a Function of X");

subplot(2,1,2);
plot(X1,0.*X1, 'b', X2, PPotential(X2,Xp2,Nda2,q,er,eo),'b',...
    X3, NPotential(X3,Xn2,Xp2,Nda2,Nda2,q,er,eo),'b', X4, Vbi2.*Ones4, 'b');
grid; xlabel('x (cm)'); ylabel('Potential (V)');
title("Electrostatic Potential as a Function of X");

figure;
subplot(2,1,1);
plot(X1,Nda2*Ones1,'b',X1,pn2*Ones1,'r', ...
    X4,np2*Ones4,'m',X4,Nda2*Ones4,'g');
ylim([-1e15 2e17]);
grid; xlabel('x (cm)'); ylabel('Carrier Density (1/cm^3)');
title("Charge Carrier Densities, p and n, as a Function of X");
legend({'p_p','n_p','p_n','n_n'},'Location','southwest');

subplot(2,1,2);
plot(X1,0.*X1, 'b-', X2, Rho(-q,Nda2)*Ones2,'b-',...
    X3, Rho(q,Nda2)*Ones3,'b-', X4, 0.*Ones4, 'b-');
grid; xlabel('x (cm)'); ylabel('Charge Density (C/cm^3)');
title("Net Charge Desity, p, as a Function of X");

%%%%%%%%%%%%%%% PART IV %%%%%%%%%%%%%%%%%%
Nd3 = 1e15;
Na3 = 5e16;

Vbi3 = VBI(Na3,Nd3,niSI,kT);
W3 = Width(Na3,Nd3,Vbi3,q,er,eo);
Xp3 = XP(W3,Na3,Nd3);
Xn3 = XN(W3,Na3,Nd3);
np3 = niSI^2/Na3;
pn3 = niSI^2/Nd3;

X1 = -2e-4:1e-7:-Xp3;
X2 = -Xp3:1e-7:0;
X3 = 0:1e-7:Xn3;
X4 = Xn3:1e-7:1e-4;

Ones1 = ones(length(X1),1);
Ones2 = ones(length(X2),1);
Ones3 = ones(length(X3),1);
Ones4 = ones(length(X4),1);

figure;
subplot(2,1,1);
plot(X1,0.*X1, 'b', X2, ElectricField(X2,-Xp3,Na3,q,er,eo),'b',...
    X3, ElectricField(X3,Xn3,Nd3,-q,er,eo),'b', X4, 0.*X4, 'b');
grid; xlabel('x (cm)'); ylabel('E (V/cm)');
title("Electric Field as a Function of X");

subplot(2,1,2);
plot(X1,0.*X1, 'b', X2, PPotential(X2,Xp3,Na3,q,er,eo),'b',...
    X3, NPotential(X3,Xn3,Xp3,Nd3,Na3,q,er,eo),'b', X4, Vbi3.*Ones4, 'b');
grid; xlabel('x (cm)'); ylabel('Potential (V)');
title("Electrostatic Potential as a Function of X");

figure;
subplot(2,1,1);
plot(X1,Na3*Ones1,'b',X1,pn3*Ones1,'r', ...
    X4,np3*Ones4,'m',X4,Nd3*Ones4,'g');
ylim([-1e16 6e16]);
grid; xlabel('x (cm)'); ylabel('Carrier Density (1/cm^3)');
title("Charge Carrier Densities, p and n, as a Function of X");
legend({'p_p','n_p','p_n','n_n'},'Location','southwest');

subplot(2,1,2);
plot(X1,0.*X1, 'b-', X2, Rho(-q,Na3)*Ones2,'b-',...
    X3, Rho(q,Nd3)*Ones3,'b-', X4, 0.*Ones4, 'b-');
ylim([-9e-3 1e-3]);
grid; xlabel('x (cm)'); ylabel('Charge Density (C/cm^3)');
title("Net Charge Desity, p, as a Function of X");

%%%%%%%%%%%%%%% Xn depletion width %%%%%%%%%%%%%
function xn = XN(W,NA,ND)
    xn = W * (NA/(NA+ND));
end

%%%%%%%%%%%%%%% Xp depletion width %%%%%%%%%%%%%
function xp = XP(W,NA,ND)
    xp = W * (ND/(NA+ND));
end

%%%%%%%%%%%%%%% Built in Voltage %%%%%%%%%%%%%%
function Vbi = VBI(Pp,Nn,Ni,kT)
    Vbi = kT .* log((Pp.*Nn)./ (Ni).^2);
end

%%%%%%%%%%%%%%% Total depletion width %%%%%%%%%%%%%%
function W = Width(NA,ND,Vbi,q,er,eo)
    W = (((2*er*eo)/q)*Vbi*((NA + ND)/(NA*ND))).^0.5;
end

%%%%%%%%%%%%%%% Electric Field as a funciton of x %%%%%%%%%%%%
function E = ElectricField(x,xpn,N,q,er,eo)
    E = -(q ./ (er .* eo)) .* N .*(x - xpn);
end

%%%%%%%% Electrostatic potential as a function of x (Pside) %%%%%%%
function PP = PPotential(x,xp,Na,q,er,eo)
    PP = -(q ./ (er .* eo)) .* Na .*(-(x.^2)./2 - xp.*x - (1/2).*(xp.^2));
end

%%%%%%%% Electrostatic potential as a function of x (Nside) %%%%%%%
function NP = NPotential(x,xn,xp,Nd,Na,q,er,eo)
    NP = (PPotential(0,xp,Na,q,er,eo) - N(0,xn,Nd,q,er,eo) + ...
        N(x,xn,Nd,q,er,eo));
end

%%%%%%%% Electrostatic potential initial value (Nside) %%%%%%%%
function NP = N(x,xn,Nd,q,er,eo)
    NP = -(q ./ (er .* eo)) .* Nd .*((x.^2)./2 - xn.*x + (1/2).*(xn.^2));
end

%%%%%%%%%%%%%%% Net charge Density Calculation %%%%%%%%%%%
function P = Rho(q,N)
    P = q * N;
end


