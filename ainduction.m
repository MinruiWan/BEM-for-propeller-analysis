function a = ainduction(CT,F)
    % This function calculates the induction factor 'a' as a function of thrust coefficient CT
    % including Glauert's correction
    %{
    a = zeros(size(CT));
    CT1 = 1.816;
    CT2 = 2 * sqrt(CT1) - CT1;
    a(CT >= CT2) = 1 + (CT(CT >= CT2) - CT1) / (4 * (sqrt(CT1) - 1));
    a(CT < CT2) = 0.5 - 0.5 * sqrt(1 - CT(CT < CT2));
    %}

    %CT = 8/9 + (4*F-40/9)*a + (50/9-4*F)*a^2;
    
    a = (18*F-20-3*sqrt(CT*(50-36*F)))
end

