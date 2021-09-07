% 1. szintrol indulunk
% egyszerre egy szintet lephetunk fel/le
% pontosan 1 vagy 2 dolgot vihetunk mindig magunkkal
% nem szabad: microchip(X) es generator(Y) egy szinten, kiveve ha generator(X) is ott van
% cel: mindent felvinni a 4. szintre
% minimum lepesszam?

floors([generator(promethium),microchip(promethium)],
       [generator(cobalt),generator(curium),generator(ruthenium),generator(plutonium)],
       [microchip(cobalt),microchip(curium),microchip(ruthenium),microchip(plutonium)],
       []).
