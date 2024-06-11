% Define range for induction "a"
a = -0.5:0.01:0.99;

% Calculate CT without correction
CTmom = CTfunction(a);

% Calculate CT with Glauert's correction
CTglauert = CTfunction(a, true);

% Calculate induction "a" using Glauert's correction
a2 = ainduction(CTglauert);

% Plot CT and CP as functions of induction "a"
figure;
plot(a, CTmom, 'k-', 'LineWidth', 2, 'DisplayName', 'CT');
hold on;
plot(a, CTglauert, 'b--', 'LineWidth', 2, 'DisplayName', 'CT Glauert');
plot(a, CTglauert .* (1 - a), 'g--', 'LineWidth', 2, 'DisplayName', 'CP Glauert');
xlabel('a');
ylabel('CT and CP');
grid on;
legend('show');