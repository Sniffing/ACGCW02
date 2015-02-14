function [reflPar, reflPerp, Brewsters] = Air2MatFresnel()
%Fresnal Reflection from Air(1.0) to Material (1.5)
%   Fucntion will generate plots of Fresnal reflectance 
%   for a dielectric material (index of refraction = 1.5)
%   Plots out reflectance values for incidence angles
%   in between 0 and 90 degrees. Must plot for
%   parallel and perpendicular polarized components
%   Also finds the reflectance of both components at
%   normal incidence and the Brewster's angle.

% Constant refraction indices
refMat = 1.5;
refAir = 1.0;

% plot spacing
incidenceAngles = linspace(0,90,300);
transmissionAngles = getTransAngles(incidenceAngles,refAir,refMat);

parComponent = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat);
perpComponent = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat);

figure
plot(incidenceAngles,parComponent, incidenceAngles, perpComponent)

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
function reflectance = parReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPar = refAir * cos(transmissionAngles);
    materialPar = refMat * cos(incidenceAngles);
    
    reflectance = (materialPar-airPar) / (materialPar+airPar);
end

%Fresnel Reflectance for perpendicular polarized light
function reflectance = perpReflectance(incidenceAngles,transmissionAngles,refAir,refMat)
    airPerp = refAir * cos(incidenceAngles);
    materialPerp = refMat * cos(transmissionAngles);
    
    reflectance = (airPerp-materialPerp) / (airPerp+materialPerp);
end

