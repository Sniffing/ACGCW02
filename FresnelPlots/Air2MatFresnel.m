function [r0,Brewsters] = Air2MatFresnel()
%Fresnal Reflection from Air(1.0) to Material (1.5)
%   Fucntion will generate plots of Fresnal reflectance 
%   for a dielectric material (index of refraction = 1.5)
%   Plots out reflectance values for incidence angles
%   in between 0 and 90 degrees. Must plot for
%   parallel and perpendicular polarized components
%   Also finds the reflectance of both components at
%   normal incidence and the Brewster's angle.

% Constant refraction indices
refMat = 1.5; %nt
refAir = 1.0; %ni

% plot spacing
incidenceAngles = linspace(0,pi/2,100);
transmissionAngles = getTransAngles(incidenceAngles,refAir,refMat);

[Brewsters,parComponent] = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat);
Brewsters
BrewstersAngle = (Brewsters/pi) * 180
[r0,perpComponent] = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat);

figure
plot(incidenceAngles,parComponent, incidenceAngles, perpComponent,Brewsters,incidenceAngles/2,'-')
legend('Parallel Component', 'Perpendicular Component');
end

%Works out transmission angles from Snell's equation
function transmissionAngles = getTransAngles(incidenceAngles,refAir,refMat)
    transmissionAngles= zeros(1,size(incidenceAngles,2));
    for i = 1:size(incidenceAngles,2)
        snells = refAir*sin(incidenceAngles(i));
        transmissionAngles(i) = asin(snells/refMat);
    end
end

%Fresnel Reflectance for parallel polarized light
function [Brewsters,reflectance] = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPar = refAir * cos(transmissionAngles);
    materialPar = refMat * cos(incidenceAngles);
    reflectance = power(abs((materialPar-airPar) ./ (materialPar+airPar)),2);
    [C,I] = min(reflectance);
    Brewsters = incidenceAngles(I);
end

%Fresnel Reflectance for perpendicular polarized light
function [r0,reflectance] = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPerp = refAir * cos(incidenceAngles);
    materialPerp = refMat * cos(transmissionAngles);
    reflectance = power(abs((airPerp-materialPerp) ./ (airPerp+materialPerp)),2);
    r0 = reflectance(1);
end

