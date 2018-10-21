%% Answer to Question 1 - Marginal and Conditional Numeric Distributions

clear all;
close all;
clc;

load('./data/a1distribs.mat');

%% Part 1 - Calculate and print out (or copy down) the following distributions.

%%% 1.1 - Marginal probability vector pC(x1)
pC_x1 = sum(sum(sum(pC, 2), 3), 4);
fprintf("Q1 Part 1.1 - Marginal probability vector pC(x1)\n");
disp(pC_x1);

%%% 1.2 - Conditional probability table pA(x3,x4 | x1 takes its third value)
pA_x2_x3_x4_given_x1_3rdValue = pA(3, :, :, :) / sum(sum(sum(pA(3, :, :, :), 2), 3), 4);
pA_x3_x4_given_x1_3rdValue = sum(pA_x2_x3_x4_given_x1_3rdValue, 2);
fprintf("\n\nQ1 Part 1.2 - Conditional probability table pA(x3,x4 | x1 takes its third value) (x3 by x4 (columns are x4, rows are x3)\n");
for x = 1:5
    for y = 1:5
        fprintf("%.4f\t", pA_x3_x4_given_x1_3rdValue(:, :, x, y));
    end
    fprintf("\n");
end

%%% 1.3 - Conditional probability vector pB(x4 | x2 takes its first value)
pB_x1_x3_x4_given_x2_1stValue = pB(:, 1, :, :) / sum(sum(sum(pB(:, 1, :, :), 1), 3), 4);
pB_x4_given_x2_1stValue = sum(sum(pB_x1_x3_x4_given_x2_1stValue, 1), 3);
fprintf("\n\nQ1 Part 1.3 - Conditional probability vector pB(x4 | x2 takes its first value)\n");
for i = 1:5
    fprintf("%.4f\t", pB_x4_given_x2_1stValue(:, :, :, i));
end

%% Part 2 - For each distribution in {A,B,C} and each of the following statements, say whether the statement applies

tolerance = 1e-5;

%%% 2.1 - x1 is conditionally independent of x2 given x3 (which is p(x1, x2|x3) = p(x1|x3)p(x2|x3)

% Calculate p(x1, x2, x4 | x3) for pA, pB, pC
pA_x1_x2_x4_given_x3 = pA ./ sum(sum(sum(pA(:, :, :, :), 1), 2), 4);
pB_x1_x2_x4_given_x3 = pB ./ sum(sum(sum(pB(:, :, :, :), 1), 2), 4);
pC_x1_x2_x4_given_x3 = pC ./ sum(sum(sum(pC(:, :, :, :), 1), 2), 4);

% Calculate p(x1, x2|x3) for pA, pB, pC
pA_x1_x2_given_x3 = sum(pA_x1_x2_x4_given_x3, 4);
pB_x1_x2_given_x3 = sum(pB_x1_x2_x4_given_x3, 4);
pC_x1_x2_given_x3 = sum(pC_x1_x2_x4_given_x3, 4);

% Calculate p(x1|x3) for pA, pB, pC
pA_x1_given_x3 = sum(sum(pA_x1_x2_x4_given_x3, 2), 4);
pB_x1_given_x3 = sum(sum(pB_x1_x2_x4_given_x3, 2), 4);
pC_x1_given_x3 = sum(sum(pC_x1_x2_x4_given_x3, 2), 4);

% Calculate p(x2|x3) for pA, pB, pC
pA_x2_given_x3 = sum(sum(pA_x1_x2_x4_given_x3, 1), 4);
pB_x2_given_x3 = sum(sum(pB_x1_x2_x4_given_x3, 1), 4);
pC_x2_given_x3 = sum(sum(pC_x1_x2_x4_given_x3, 1), 4);

% Calculate p(x1|x3)p(x2|x3) for pA, pB, pC
pA_x1_x2_given_x3_Calculated = pA_x1_given_x3 .* pA_x2_given_x3;
pB_x1_x2_given_x3_Calculated = pB_x1_given_x3 .* pB_x2_given_x3;
pC_x1_x2_given_x3_Calculated = pC_x1_given_x3 .* pC_x2_given_x3;

% Now determine conditional independence of each probability distribution pA, pB, pC

pA_condIndependent = true;
pB_condIndependent = true;
pC_condIndependent = true;

for x3 = 1:5
    if(abs(pA_x1_x2_given_x3(:, :, x3) - pA_x1_x2_given_x3_Calculated(:, :, x3)) > tolerance)
        pA_condIndependent = false;
    end
    
    if(abs(pB_x1_x2_given_x3(:, :, x3) - pB_x1_x2_given_x3_Calculated(:, :, x3)) > tolerance)
        pB_condIndependent = false;
    end
    
    if(abs(pC_x1_x2_given_x3(:, :, x3) - pC_x1_x2_given_x3_Calculated(:, :, x3)) > tolerance)
        pC_condIndependent = false;
    end
end

fprintf("\n\nPart 2.1 - x1 is conditionally independent of x2 given x3 (which is p(x1, x2|x3) = p(x1|x3)p(x2|x3)\n")
if(~pA_condIndependent)
    fprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pA distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3) == p(x1|x3)p(x2|x3) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    fprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pB distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3) == p(x1|x3)p(x2|x3) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    fprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pC distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3) == p(x1|x3)p(x2|x3) for pC distribution, so they are conditionally independent\n")
end


%%% 2.2 - x1 is conditionally independent of x2 given x3 and x4 (which is p(x1, x2|x3, x4) = p(x1|x3,x4)p(x2|x3,x4)

% Calculate p(x1, x2|x3, x4) for pA, pB, pC
pA_x1_x2_given_x3_x4 = pA ./ sum(sum(pA(:, :, :, :), 1), 2);
pB_x1_x2_given_x3_x4 = pB ./ sum(sum(pB(:, :, :, :), 1), 2);
pC_x1_x2_given_x3_x4 = pC ./ sum(sum(pC(:, :, :, :), 1), 2);

% Calculate p(x1|x3,x4) for pA, pB, pC
pA_x1_given_x3_x4 = sum(pA_x1_x2_given_x3_x4, 2);
pB_x1_given_x3_x4 = sum(pB_x1_x2_given_x3_x4, 2);
pC_x1_given_x3_x4 = sum(pC_x1_x2_given_x3_x4, 2);

% Calculate p(x2|x3,x4) for pA, pB, pC
pA_x2_given_x3_x4 = sum(pA_x1_x2_given_x3_x4, 1);
pB_x2_given_x3_x4 = sum(pB_x1_x2_given_x3_x4, 1);
pC_x2_given_x3_x4 = sum(pC_x1_x2_given_x3_x4, 1);

% Calculate p(x1|x3,x4)p(x2|x3,x4) for pA, pB, pC
pA_x1_x2_given_x3_x4_Calculated = pA_x1_given_x3_x4 .* pA_x2_given_x3_x4;
pB_x1_x2_given_x3_x4_Calculated = pB_x1_given_x3_x4 .* pB_x2_given_x3_x4;
pC_x1_x2_given_x3_x4_Calculated = pC_x1_given_x3_x4 .* pC_x2_given_x3_x4;

% Now determine conditional independence of each probability distribution pA, pB, pC

pA_condIndependent = true;
pB_condIndependent = true;
pC_condIndependent = true;

for x3 = 1:5
    for x4 = 1:5
        if(abs(pA_x1_x2_given_x3_x4(:, :, x3, x4) - pA_x1_x2_given_x3_x4_Calculated(:, :, x3, x4)) > tolerance)
            pA_condIndependent = false;
        end

        if(abs(pB_x1_x2_given_x3_x4(:, :, x3, x4) - pB_x1_x2_given_x3_x4_Calculated(:, :, x3, x4)) > tolerance)
            pB_condIndependent = false;
        end

        if(abs(pC_x1_x2_given_x3_x4(:, :, x3, x4) - pC_x1_x2_given_x3_x4_Calculated(:, :, x3, x4)) > tolerance)
            pC_condIndependent = false;
        end
    end
end

fprintf("\nPart 2.2 - x1 is conditionally independent of x2 given x3 and x4 (which is p(x1, x2|x3, x4) = p(x1|x3,x4)p(x2|x3,x4)\n")
if(~pA_condIndependent)
    fprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pA distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    fprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pB distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    fprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pC distribution, so not conditionally independent\n")
else
    fprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pC distribution, so they are conditionally independent\n")
end


%%% 2.3 - x1 is marginally independent of x2 (which is p(x1, x2) = p(x1)p(x2))

% Calculate p(x1, x2, x3, x4) for pA, pB, pC
pA_x1_x2_x3_x4 = pA ./ sum(sum(sum(sum(pA(:, :, :, :), 1), 2), 3), 4);
pB_x1_x2_x3_x4 = pB ./ sum(sum(sum(sum(pB(:, :, :, :), 1), 2), 3), 4);
pC_x1_x2_x3_x4 = pC ./ sum(sum(sum(sum(pC(:, :, :, :), 1), 2), 3), 4);

% Calculate p(x1, x2) for pA, pB, pC
pA_x1_x2 = sum(sum(pA_x1_x2_x3_x4, 3), 4);
pB_x1_x2 = sum(sum(pB_x1_x2_x3_x4, 3), 4);
pC_x1_x2 = sum(sum(pC_x1_x2_x3_x4, 3), 4);

% Calculate p(x1) for pA, pB, pC
pA_x1 = sum(sum(sum(pA, 2), 3), 4);
pB_x1 = sum(sum(sum(pB, 2), 3), 4);
pC_x1 = sum(sum(sum(pC, 2), 3), 4);

% Calculate p(x2) for pA, pB, pC
pA_x2 = sum(sum(sum(pA, 1), 3), 4);
pB_x2 = sum(sum(sum(pB, 1), 3), 4);
pC_x2 = sum(sum(sum(pC, 1), 3), 4);

% Calculate p(x1)p(x2) for pA, pB, pC
pA_x1_x2_Calculated = pA_x1 .* pA_x2;
pB_x1_x2_Calculated = pB_x1 .* pB_x2;
pC_x1_x2_Calculated = pC_x1 .* pC_x2;

% Now determine marginal independence of each probability distribution pA, pB, pC
fprintf("\nPart 2.3 - x1 is marginally independent of x2 (which is p(x1, x2) = p(x1)p(x2))\n")

if(abs(pA_x1_x2 - pA_x1_x2_Calculated) > tolerance)
    fprintf("p(x1, x2) != p(x1)p(x2) for pA distribution, so not marginally independent\n")
else
    fprintf("p(x1, x2) == p(x1)p(x2) for pA distribution, so is marginally independent\n")    
end

if(abs(pB_x1_x2 - pB_x1_x2_Calculated) > tolerance)
    fprintf("p(x1, x2) != p(x1)p(x2) for pB distribution, so not marginally independent\n")
else
    fprintf("p(x1, x2) == p(x1)p(x2) for pB distribution, so is marginally independent\n")    
end

if(abs(pC_x1_x2 - pC_x1_x2_Calculated) > tolerance)
    fprintf("p(x1, x2) != p(x1)p(x2) for pC distribution, so not marginally independent\n")
else
    fprintf("p(x1, x2) == p(x1)p(x2) for pC distribution, so is marginally independent\n")    
end

%%% 2.4 - x3 is conditionally independent of x4 given x1 and x2 (which is p(x3, x4|x1, x2) = p(x3|x1,x2)p(x4|x1,x2)

% Calculate p(x3, x4|x1, x2) for pA, pB, pC
pA_x3_x4_given_x1_x2 = pA ./ sum(sum(pA(:, :, :, :), 3), 4);
pB_x3_x4_given_x1_x2 = pB ./ sum(sum(pB(:, :, :, :), 3), 4);
pC_x3_x4_given_x1_x2 = pC ./ sum(sum(pC(:, :, :, :), 3), 4);

% Calculate p(x3|x1,x2) for pA, pB, pC
pA_x3_given_x1_x2 = sum(pA_x3_x4_given_x1_x2, 4);
pB_x3_given_x1_x2 = sum(pB_x3_x4_given_x1_x2, 4);
pC_x3_given_x1_x2 = sum(pC_x3_x4_given_x1_x2, 4);

% Calculate p(x4|x1,x2) for pA, pB, pC
pA_x4_given_x1_x2 = sum(pA_x3_x4_given_x1_x2, 3);
pB_x4_given_x1_x2 = sum(pB_x3_x4_given_x1_x2, 3);
pC_x4_given_x1_x2 = sum(pC_x3_x4_given_x1_x2, 3);

% Calculate p(x3|x1,x2)p(x4|x1,x2) for pA, pB, pC
pA_x3_x4_given_x1_x2_Calculated = pA_x3_given_x1_x2 .* pA_x4_given_x1_x2;
pB_x3_x4_given_x1_x2_Calculated = pB_x3_given_x1_x2 .* pB_x4_given_x1_x2;
pC_x3_x4_given_x1_x2_Calculated = pC_x3_given_x1_x2 .* pC_x4_given_x1_x2;

% Now determine conditional independence of each probability distribution pA, pB, pC

pA_condIndependent = true;
pB_condIndependent = true;
pC_condIndependent = true;

for x1 = 1:5
    for x2 = 1:5
        if(abs(pA_x3_x4_given_x1_x2(x1, x2, :, :) - pA_x3_x4_given_x1_x2_Calculated(x1, x2, :, :)) > tolerance)
            pA_condIndependent = false;
        end

        if(abs(pB_x3_x4_given_x1_x2(x1, x2, :, :) - pB_x3_x4_given_x1_x2_Calculated(x1, x2, :, :)) > tolerance)
            pB_condIndependent = false;
        end

        if(abs(pC_x3_x4_given_x1_x2(x1, x2, :, :) - pC_x3_x4_given_x1_x2_Calculated(x1, x2, :, :)) > tolerance)
            pC_condIndependent = false;
        end
    end
end

fprintf("\nPart 2.4 - x3 is conditionally independent of x4 given x1 and x2 (which is p(x3, x4|x1, x2) = p(x3|x1,x2)p(x4|x1,x2))\n")

if(~pA_condIndependent)
    fprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pA distribution, so not conditionally independent\n")
else
    fprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    fprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pB distribution, so not conditionally independent\n")
else
    fprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    fprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pC distribution, so not conditionally independent\n")
else
    fprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pC distribution, so they are conditionally independent\n")
end
