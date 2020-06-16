

q = 1.6e-19;
E = (-2:0.04:2)*q;
Ev = 0 * q;
Ec = 1.1 * q;
Mn = 1.08 * 9.11e-31;
Mp = 0.8 * 9.11e-31;
h = 6.63e-34;

Nc = NC(E, Ec, Mn,h,q);
Nv = NV(E, Ev, Mp,h,q);

kT = 0.0259;         %using room temperature = 300 K
Ef = 0.5;

figure;

subplot(1,3,2);
hold on
plot(real(Nc),E/q,'Color', 'Blue'); 
plot(real(Nv),E/q,'Color', 'Green'); 
hold off
grid; xlabel('density of states'); ylabel('Energy (eV)');
title('Density of States');

subplot(1,3,1);
hold on
plot(Fer(Ef, kT, E/q), E/q, 'Color', 'Blue');
plot((1-Fer(Ef, kT, E/q)), E/q, 'Color', 'Green');
grid; xlabel('f'); ylabel('Energy (eV)');
title('Fermi-Dirac');
hold off

subplot(1,3,3);
hold on
plot(Fer(Ef, kT, E/q).*real(Nc), E/q, 'Color', 'Blue');
plot((1-Fer(Ef, kT, E/q)).*real(Nv), E/q, 'Color', 'Green');
hold off
grid; xlabel('Electron Density'); ylabel('Energy (eV)');
title('Electron Density');

[x, Ef] = ginput(1);

while(Ef ~= 0.5)
    subplot(1,3,1);
    delete(plot(Fer(Ef, kT, E/q), E/q, 'Color', 'Blue'));
    delete(plot((1-Fer(Ef, kT, E/q)), E/q, 'Color', 'Green'));
    hold on
    plot(Fer(Ef, kT, E/q), E/q, 'Color', 'Blue');
    plot((1-Fer(Ef, kT, E/q)), E/q, 'Color', 'Green');
    hold off
    grid; xlabel('f'); ylabel('Energy (eV)');
    title('Fermi-Dirac');
    
    subplot(1,3,3);
    delete(plot(Fer(Ef, kT, E/q).*real(Nc), E/q, 'Color', 'Blue'));
    delete(plot((1-Fer(Ef, kT, E/q)).*real(Nv), E/q, 'Color', 'Green'));
    hold on
    plot(Fer(Ef, kT, E/q).*real(Nc), E/q, 'Color', 'Blue');
    plot((1-Fer(Ef, kT, E/q)).*(real(Nv)), E/q, 'Color', 'Green');
    hold off
    grid; xlabel('Electron Density'); ylabel('Energy (eV)');
    title('Electron Density');
    
    [x, Ef] = ginput(1);
end

function N = NC(E, Ec, M, h,q)
N = (q/100^3)*((8 * pi * sqrt(2)) / (h^3)) .* (M^(3/2)) .* sqrt(E - Ec);
end

function N = NV(E, Ev, M, h,q)
N = (q/100^3)*((8 * pi * sqrt(2)) / (h^3)) * (M^(3/2)) * sqrt(Ev - E);
end

function F = Fer(Ef, kT, E)
F = 1 ./ (1 + exp((E - Ef)./kT));
end