

EgzGERM = 0.7437;
alphaGERM = 4.4e-4;
betaGERM = 235;

EgzSILI = 1.166;
alphaSILI = 4.73e-4;
betaSILI = 636;

EgzGAAS  = 1.519;
alphaGAAS = 5.41e-4;
betaGAAS = 204;

T = 100:5:1000;

EgGERM = EgzGERM - (alphaGERM * (T.^2)) ./ (T + betaGERM);
EgSILI = EgzSILI - (alphaSILI * (T.^2)) ./ (T + betaSILI);
EgGAAS = EgzGAAS - (alphaGAAS * (T.^2)) ./ (T + betaGAAS);

Temperature = [300, 400, 600];
Germanium = [E(EgzGERM, alphaGERM, betaGERM, 300), E(EgzGERM, alphaGERM, ...
    betaGERM, 400), E(EgzGERM, alphaGERM, betaGERM, 600)]
Silicon = [E(EgzSILI, alphaSILI, betaSILI, 300), E(EgzSILI, alphaSILI, ...
    betaSILI, 400), E(EgzSILI, alphaSILI, betaSILI, 470)]
GaAs = [E(EgzGAAS, alphaGAAS, betaGAAS, 300), E(EgzGAAS, alphaGAAS, ...
    betaGAAS, 400), E(EgzGAAS, alphaGAAS, betaGAAS, 600)]


figure;
hold on
GERM = plot(T, EgGERM, 'Color', 'Green'); N1 = "Germanium";
SILI = plot(T, EgSILI, 'Color', 'Red'); N2 = "Silicon";
GAAS = plot(T, EgGAAS, 'Color', 'Blue'); N3 = "GaAs";
legend([GERM, SILI, GAAS], [N1, N2, N3]);
hold off
grid; xlabel('Temperature (K)'); ylabel('Eg (eV)');
title("Energy Bandgap for Three Semiconductors");

function Eg = E(Eg0, alpha, beta,temp)
Eg = Eg0 - (alpha * (temp.^2)) ./ (temp + beta);
end


