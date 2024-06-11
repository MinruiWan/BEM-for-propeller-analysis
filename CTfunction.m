function CT = CTfunction(a, glauert)
    CT = zeros(size(a));
    CT = 4 * a .* (1 - a);
    if nargin > 1 && glauert
        CT1 = 1.816;
        a1 = 1 - sqrt(CT1) / 2;
        CT(a > a1) = CT1 - 4 * (sqrt(CT1) - 1) * (1 - a(a > a1));
    end
end




