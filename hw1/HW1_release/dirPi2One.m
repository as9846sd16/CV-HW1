function [oneDir] = dirPi2One(piDir)
    oneDir = piDir + pi;
    oneDir = oneDir ./ (2 * pi);
end