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
ni = 1.5; %refMat
nt = 1.0; %refAir

% plot spacing
incidenceAngles = linspace(0,pi/2,100);
transmissionAngles = getTransAngles(incidenceAngles,nt,ni);

[parCrit,parComponent] = parReflectance(incidenceAngles,transmissionAngles,nt,ni);
[perpCrit,perpComponent] = perpReflectance(incidenceAngles,transmissionAngles,nt,ni);

CriticalAngle = perpCrit;
CritAngleDegrees = CriticalAngle / pi * 180
perpCrit;
figure
plot(incidenceAngles,parComponent, incidenceAngles, perpComponent,CriticalAngle,incidenceAngles/2)
ylim([0,1]);
legend('Parallel Component','Perpendicular Component');
end

%Works out transmission angles from Snell's equation
function transmissionAngles = getTransAngles(incidenceAngles,nt,ni)
    transmissionAngles= zeros(1,size(incidenceAngles,2));
    for i = 1:size(incidenceAngles,2)
        snells = ni*sin(incidenceAngles(i));
        transmissionAngles(i) = asin(snells/nt);
    end
end

%Fresnel Reflectance for parallel polarized light
function [critical,reflectance] = parReflectance(incidenceAngles,transmissionAngles,nt,ni)
    airPar = nt * cos(incidenceAngles);
    materialPar = ni * cos(transmissionAngles);
    reflectance = power(abs((airPar-materialPar) ./ (airPar+materialPar)),2);
    [~,I] = find(reflectance == 1);
    critical = incidenceAngles(I);
    critical = critical(1);
end

%Fresnel Reflectance for perpendicular polarized light
function [critical,reflectance] = perpReflectance(incidenceAngles,transmissionAngles,nt,ni)
    materialPerp = nt * cos(transmissionAngles);
    airPerp = ni * cos(incidenceAngles);
    reflectance = power(abs((airPerp-materialPerp) ./ (airPerp+materialPerp)),2);
    [~,I] = find(reflectance == 1.0);
    critical = incidenceAngles(I);
    critical = critical(1);
end



