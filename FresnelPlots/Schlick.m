function [] = Shlick()
%UNTITLED Summary of this function goes here
%   Plots the curve for Schlick’s approximation of Fresnel 
%   reflectance for such a material using the reflectance value 
%   at normal incidence from 1st part as the R0 parameter.

r0 = 0.2; % Optained from Air2MatFresnel
incidenceAngles = linspace(0,pi/2,100);
approximations = schlickApprox(r0,incidenceAngles);

figure
plot(incidenceAngles,approximations)
ylim([0,1]);

end

function fresnelApprox = schlickApprox(r0,incidenceAngles)
    fresnelApprox = r0 + (1-r0) * (power(1-cos(incidenceAngles),5));
end