function [CriticalAngle] = Mat2AirFresnel()
%Fresnal Reflection from Air(1.0) to Material (1.5)
%   Fucntion will generate plots of Fresnal reflectance 
%   for a dielectric material (index of refraction = 1.5)
%   Plots out reflectance values for incidence angles
%   in between 0 and 90 degrees. Must plot for
%   parallel and perpendicular polarized components
%   Also finds the reflectance of both components at
%   normal incidence and the Brewster's angle.

% Constant refraction indices
refMat = 1.5; %ni
refAir = 1.0; %nt

% plot spacing
incidenceAngles = linspace(0,pi/2,100);
transmissionAngles = getTransAngles(incidenceAngles,refAir,refMat);

[parCrit,parComponent] = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat);
[perpCrit,perpComponent] = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat);

CriticalAngle = parCrit;
CritAngleDegrees = CriticalAngle / pi * 180
perpCrit;
figure
plot(incidenceAngles,parComponent, incidenceAngles, perpComponent)

end

%Works out transmission angles from Snell's equation
function transmissionAngles = getTransAngles(incidenceAngles,refAir,refMat)
    transmissionAngles= zeros(1,size(incidenceAngles,2));
    for i = 1:size(incidenceAngles,2)
        snells = refMat*sin(incidenceAngles(i));
        transmissionAngles(i) = asin(snells/refAir);
    end
end

%Fresnel Reflectance for parallel polarized light
function [critical,reflectance] = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPar = refAir * cos(transmissionAngles);
    materialPar = refMat * cos(incidenceAngles);
    reflectance = abs((materialPar-airPar) ./ (materialPar+airPar));
    [~,I] = find(reflectance == 1);
    critical = incidenceAngles(I);
    critical = critical(1);
end

%Fresnel Reflectance for perpendicular polarized light
function [critical,reflectance] = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPerp = refAir * cos(incidenceAngles);
    materialPerp = refMat * cos(transmissionAngles);
    reflectance = abs((airPerp-materialPerp) ./ (airPerp+materialPerp));
    [~,I] = find(reflectance == 1.0);
    critical = incidenceAngles(I);
    critical = critical(1);
end



