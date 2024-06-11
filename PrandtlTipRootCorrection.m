function [Prandtl, Ftip, Froot] = PrandtlTipRootCorrection(r_R, rootradius_R, tipradius_R, ...
                                                          TSR, NBlades, axial_induction)
    % This function calculates the combined tip and root Prandtl correction
    % at a given radial position 'r_R' (non-dimensioned by rotor radius), 
    % given a root and tip radius (also non-dimensioned), a tip speed ratio TSR, 
    % the number of blades NBlades, and the axial induction factor
    
    temp1 = -NBlades/2*(tipradius_R-r_R)./r_R.*sqrt(1+((TSR*r_R).^2)./((1-axial_induction).^2));
    Ftip = 2/pi*acos(exp(temp1));
    %Ftip(isnan(Ftip)) = 0;
    
    temp1 = NBlades/2*(rootradius_R-r_R)./r_R.*sqrt(1+((TSR*r_R).^2)./((1-axial_induction).^2));
    Froot = 2/pi*acos(exp(temp1));
    %Froot(isnan(Froot)) = 0;
    
    Prandtl = Froot.*Ftip;

end