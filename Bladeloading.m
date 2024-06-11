function [Thrust, Fq] = Bladeloading(N_section, R_tip, R_root, section_data,...
                           aero_data, a1, a2, rho, rey, Uinf, Omega, num_blade)

    dr = (R_tip - R_root)/N_section;  % mm
    Thrust = 0;
    Fq = 0;

    for j = 1:1:N_section
        % radius of each section
        r = dr * (j-0.5) + R_root;  % mm
        
        % chord & pitch of each section
        for k = 1:1:(numel(section_data)-1)
            if section_data(k).r <= r && r <= section_data(k+1).r
                % linear index calculated by the radius ratio
                linear_ind = (r-section_data(k).r)/...
                    (section_data(k+1).r-section_data(k).r);
                % linear interpolation of the chord [mm]
                chord = linear_ind * (section_data(k+1).chord - ...
                    section_data(k).chord) + section_data(k).chord;
                % linear interpolation of the pitch angle [rad]
                pitch_sec = (linear_ind * (section_data(k+1).twist - section_data(k).twist) + ...
                    section_data(k).twist) * pi/180;
            end
        end

        % velocity components
        Uax = Uinf * (1-a1);
        Utan = (1+a2) * Omega * r * 10^(-3); % m/s
        W = sqrt(Uax^2 + Utan^2);

        % AoA =  inflow angle + pitch of the airfoil 
        aoa = atan(Utan/Uax) + pitch_sec;
        aoa_diff = abs(aero_data.alpha - aoa);
        [~, index_aoa] = min(aoa_diff);
        % radial position of the airfoil
        r_diff = abs(aero_data.r_norm - r/R_tip);
        [~, index_r] = min(r_diff);
        % aero_data.Cl(radius,rey,aoa) = (24,29,181)
        Cl_r = aero_data.Cl(index_r,rey,index_aoa);
        Cd_r = aero_data.Cd(index_r,rey,index_aoa);

        % Lift and drag for each segment
        L_dr = 0.5 * rho * W^2 * chord * Cl_r * dr * num_blade * 10^(-6);
        D_dr = 0.5 * rho * W^2 * chord * Cd_r * dr * num_blade * 10^(-6);

    % total thrust and moment 
    Thrust = Thrust + L_dr * cos(pitch_sec) - D_dr * sin(pitch_sec);
    Fq = Fq + L_dr * sin(pitch_sec) + D_dr * cos(pitch_sec);
    
    end
 



end
