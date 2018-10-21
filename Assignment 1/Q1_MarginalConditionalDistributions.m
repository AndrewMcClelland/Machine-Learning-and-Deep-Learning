%% Answer to Question 1 - Marginal and Conditional Numeric Distributions

clear all;
close all;
clc;

load('./data/a1distribs.mat');

%% Calculate and print out (or copy down) the following distributions.
%%% Marginal probability vector pC(x1)

% Initialize pC(x1 = [1..5.]) variables to 0
pC_x1 = zeros(5);
pC_count = 0;

% Loop through pC and sum to get pC(x1 = [1..5.]) depending on current
% looped x1 value

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pC_x1(x1) = pC_x1(x1) + pC(x1, x2, x3, x4);
                pC_count = pC_count + 1;
            end
        end
    end
end

% Print each and sum of pC(x1 = [1..5.]) to 4 decimal places 
sprintf('pC(x1=1) = %0.4f\npC(x1=2) = %0.4f\npC(x1=3) = %0.4f\npC(x1=4) = %0.4f\npC(x1=5) = %0.4f\nSum of pC(x1 = [1..5.]) = %0.4f\nCount = %d\n', pC_x1(1), pC_x1(2), pC_x1(3), pC_x1(4), pC_x1(5), sum(pC_x1), pC_count)

%%% Conditional probability table pA(x3,x4 | x1 takes its third value)

% Create table where rows represent x3 and columns represent x4
pA_table = zeros(5,5);
pA_count = 0;

for x1 = 3
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_count = pA_count + 1;
                pA_table(x3, x4) = pA_table(x3, x4) + pA(x1, x2, x3, x4);
            end
        end
    end
end

for x3 = 1:5
    sprintf('pA(x3=%d, x4 = 1 | x1 = 3) = %0.4f\tpA(x3=%d, x4 = 2 | x1 = 3) = %0.4f\tpA(x3=%d, x4 = 3 | x1 = 3) = %0.4f\tpA(x3=%d, x4 = 4 | x1 = 3) = %0.4f\tpA(x3=%d, x4 = 5 | x1 = 3) = %0.4f\n', x3, pA_table(x3, 1), x3, pA_table(x3, 2), x3, pA_table(x3, 3), x3, pA_table(x3, 4), x3, pA_table(x3, 5))
end
sprintf('pA_count = %d', pA_count)


%%% Conditional probability vector pB(x4 | x2 takes its first value)
% Initialize pB(x4 = [1..5.]) variables to 0

pB_x4 = zeros(5);
pB_count = 0;

for x1 = 1:5
    for x2 = 1
        for x3 = 1:5
            for x4 = 1:5
                pB_x4(x4) = pB_x4(x4) + pB(x1, x2, x3, x4);
                pB_count = pB_count + 1;
            end
        end
    end
end

sprintf('pB(x4=1 | x2 = 1) = %0.4f\npB(x4=2 | x2 = 1) = %0.4f\npB(x4=3 | x2 = 1) = %0.4f\npB(x4=4 | x2 = 1) = %0.4f\npB(x4=5 | x2 = 1) = %0.4f\nCount = %d\n', pB_x4(1), pB_x4(2), pB_x4(3), pB_x4(4), pB_x4(5), pB_count)

%% Calculate and print out (or copy down) the following distributions.
%%% x1 is conditionally independent of x2 given x3 (which is p(x1, x2|x3) =
%%% p(x1|x3)p(x2|x3)

decimals_rounded = 6;

% First calculate p(x1, x2|x3) for pA, pB, and pC
pA_x1_x2_given_x3 = zeros(5, 5, 5);
pB_x1_x2_given_x3 = zeros(5, 5, 5);
pC_x1_x2_given_x3 = zeros(5, 5, 5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x1_x2_given_x3(x1, x2, x3) = pA_x1_x2_given_x3(x1, x2, x3) + pA(x1, x2, x3, x4);
                pB_x1_x2_given_x3(x1, x2, x3) = pB_x1_x2_given_x3(x1, x2, x3) + pB(x1, x2, x3, x4);
                pC_x1_x2_given_x3(x1, x2, x3) = pC_x1_x2_given_x3(x1, x2, x3) + pC(x1, x2, x3, x4);
            end
        end
    end
end

% Now calculate p(x1|x3)p(x2|x3)
pA_x1_given_x3 = zeros(5, 5);
pA_x2_given_x3 = zeros(5, 5);
pB_x1_given_x3 = zeros(5, 5);
pB_x2_given_x3 = zeros(5, 5);
pC_x1_given_x3 = zeros(5, 5);
pC_x2_given_x3 = zeros(5, 5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x1_given_x3(x1, x3) = pA_x1_given_x3(x1, x3) + pA(x1, x2, x3, x4);
                pA_x2_given_x3(x2, x3) = pA_x2_given_x3(x2, x3) + pA(x1, x2, x3, x4);
                pB_x1_given_x3(x1, x3) = pB_x1_given_x3(x1, x3) + pB(x1, x2, x3, x4);
                pB_x2_given_x3(x2, x3) = pB_x2_given_x3(x2, x3) + pB(x1, x2, x3, x4);
                pC_x1_given_x3(x1, x3) = pC_x1_given_x3(x1, x3) + pC(x1, x2, x3, x4);
                pC_x2_given_x3(x2, x3) = pC_x2_given_x3(x2, x3) + pC(x1, x2, x3, x4);
            end
        end
    end
end

% Now determine conditional independence of each probability distribution
% pA, pB, pC

pA_condIndependent = true;
pB_condIndependent = true;
pC_condIndependent = true;

for x3 = 1:5
    if(~isequal(rank(pA_x1_x2_given_x3(:, :, x3)), rank(pA_x1_given_x3(:, x3) * pA_x2_given_x3(:, x3)')))
        pA_condIndependent = false;
    end
    
    if(~isequal(round(pA_x1_x2_given_x3(:, :, x3), decimals_rounded), round(pA_x1_given_x3(:, x3) * pA_x2_given_x3(:, x3)'), decimals_rounded))
        pA_condIndependent = false;
    end
    
    if(~isequal(rank(pB_x1_x2_given_x3(:, :, x3)), rank(pB_x1_given_x3(:, x3) * pB_x2_given_x3(:, x3)')))
        pB_condIndependent = false;
    end
    
    if(~isequal(rank(pC_x1_x2_given_x3(:, :, x3)), rank(pC_x1_given_x3(:, x3) * pC_x2_given_x3(:, x3)')))
        pC_condIndependent = false;
    end
end

if(~pA_condIndependent)
    sprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pA distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3) = p(x1|x3)p(x2|x3) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    sprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pB distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3) = p(x1|x3)p(x2|x3) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    sprintf("p(x1, x2|x3) ~= p(x1|x3)p(x2|x3) for pC distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3) = p(x1|x3)p(x2|x3) for pC distribution, so they are conditionally independent\n")
end

%% x1 is conditionally independent of x2 given x3 and x4 (which is p(x1, x2|x3, x4) = p(x1|x3,x4)p(x2|x3,x4)

% % First calculate p(x1|x3,x4) and p(x2|x3,x4)
% pA_x1_given_x3_x4 = zeros(5, 5, 5);
% pA_x2_given_x3_x4 = zeros(5, 5, 5);
% pB_x1_given_x3_x4 = zeros(5, 5, 5);
% pB_x2_given_x3_x4 = zeros(5, 5, 5);
% pC_x1_given_x3_x4 = zeros(5, 5, 5);
% pC_x2_given_x3_x4 = zeros(5, 5, 5);
% 
% for x1 = 1:5
%     for x2 = 1:5
%         for x3 = 1:5
%             for x4 = 1:5
%                 pA_x1_given_x3_x4(x1, x3, x4) = pA_x1_given_x3_x4(x1, x3, x4) + pA(x1, x2, x3, x4);
%                 pA_x2_given_x3_x4(x2, x3, x4) = pA_x2_given_x3_x4(x2, x3, x4) + pA(x1, x2, x3, x4);
%                 pB_x1_given_x3_x4(x1, x3, x4) = pB_x1_given_x3_x4(x1, x3, x4) + pB(x1, x2, x3, x4);
%                 pB_x2_given_x3_x4(x2, x3, x4) = pB_x2_given_x3_x4(x2, x3, x4) + pB(x1, x2, x3, x4);
%                 pC_x1_given_x3_x4(x1, x3, x4) = pC_x1_given_x3_x4(x1, x3, x4) + pC(x1, x2, x3, x4);
%                 pC_x2_given_x3_x4(x2, x3, x4) = pC_x2_given_x3_x4(x2, x3, x4) + pC(x1, x2, x3, x4);
%             end
%         end
%     end
% end
% 
% % Now calculate p(x1, x2|x3, x4) for pA, pB, and pC
% pA_x1_x2_given_x3_x4 = zeros(5, 5, 5, 5);
% pB_x1_x2_given_x3_x4 = zeros(5, 5, 5, 5);
% pC_x1_x2_given_x3_x4 = zeros(5, 5, 5, 5);
% 
% for x1 = 1:5
%     for x2 = 1:5
%         for x3 = 1:5
%             for x4 = 1:5
%                 pA_x1_x2_given_x3_x4(x1, x2, x3, x4) = pA_x1_x2_given_x3_x4(x1, x2, x3, x4) + pA(x1, x2, x3, x4);
%                 pB_x1_x2_given_x3_x4(x1, x2, x3, x4) = pB_x1_x2_given_x3_x4(x1, x2, x3, x4) + pB(x1, x2, x3, x4);
%                 pC_x1_x2_given_x3_x4(x1, x2, x3, x4) = pC_x1_x2_given_x3_x4(x1, x2, x3, x4) + pC(x1, x2, x3, x4);
%             end
%         end
%     end
% end
% 
% % Now determine conditional independence of each probability distribution
% % pA, pB, pC
% 
% pA_condIndependent = true;
% pB_condIndependent = true;
% pC_condIndependent = true;
% 
% for x3 = 1:5
%     for x4 = 1:5
%         if(~isequal(rank(pA_x1_x2_given_x3_x4(:, :, x3, x4)), rank(pA_x1_given_x3_x4(:, x3, x4) * pA_x2_given_x3_x4(:, x3, x4)')))
%             pA_condIndependent = false;
%         end
%         
% %         if(~isequal(round(pA_x1_x2_given_x3_x4(:, :, x3, x4), decimals_rounded), round(pA_x1_given_x3_x4(:, x3, x4) * pA_x2_given_x3_x4(:, x3, x4)'), decimals_rounded))
% %             pA_condIndependent = false;
% %         end
% 
% %         if(abs(pA_x1_x2_given_x3_x4(:, :, x3, x4) - (pA_x1_given_x3_x4(:, x3, x4) * pA_x2_given_x3_x4(:, x3, x4)')) > 0.0001)
% %             pA_condIndependent = false;
% %         end
% 
%         if(~isequal(rank(pB_x1_x2_given_x3_x4(:, :, x3, x4)), rank(pB_x1_given_x3_x4(:, x3, x4) * pB_x2_given_x3_x4(:, x3, x4)')))
%             pB_condIndependent = false;
%         end
% 
%         if(~isequal(rank(pC_x1_x2_given_x3_x4(:, :, x3, x4)), rank(pC_x1_given_x3_x4(:, x3, x4) * pC_x2_given_x3_x4(:, x3, x4)')))
%             pC_condIndependent = false;
%         end
%     end
% end

pA_x1_given_x3_x4 = sum(pA,2); % summed away x2


if(~pA_condIndependent)
    sprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pA distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    sprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pB distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    sprintf("p(x1, x2|x3, x4) ~= p(x1|x3,x4)p(x2|x3,x4) for pC distribution, so not conditionally independent\n")
else
    sprintf("p(x1, x2|x3, x4) == p(x1|x3,x4)p(x2|x3,x4) for pC distribution, so they are conditionally independent\n")
end

%% x1 is marginally independent of x2 (which is p(x1, x2) = p(x1)p(x2))

% First calculate p(x1) and p(x2) for each of the distributions pA, pB, pC

pA_x1 = zeros(5);
pA_x2 = zeros(5);
pB_x1 = zeros(5);
pB_x2 = zeros(5);
pC_x1 = zeros(5);
pC_x2 = zeros(5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x1(x1) = pA_x1(x1) + pA(x1, x2, x3, x4);
                pA_x2(x1) = pA_x2(x1) + pA(x2, x1, x3, x4);
                pB_x1(x1) = pB_x1(x1) + pB(x1, x2, x3, x4);
                pB_x2(x1) = pB_x2(x1) + pB(x2, x1, x3, x4);
                pC_x1(x1) = pC_x1(x1) + pC(x1, x2, x3, x4);
                pC_x2(x1) = pC_x2(x1) + pC(x2, x1, x3, x4);
            end
        end
    end
end

% Now calculate p(x1, x2) for each of the distributions pA, pB, pC
pA_x1_x2 = zeros(5, 5);
pB_x1_x2 = zeros(5, 5);
pC_x1_x2 = zeros(5, 5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x1_x2(x1, x2) = pA_x1_x2(x1, x2) + pA(x1, x2, x3, x4);
                pB_x1_x2(x1, x2) = pB_x1_x2(x1, x2) + pB(x1, x2, x3, x4);
                pC_x1_x2(x1, x2) = pC_x1_x2(x1, x2) + pC(x1, x2, x3, x4);
            end
        end
    end
end

if(~isequal(rank(pA_x1_x2), rank(pA_x1 * pA_x2')))  
    sprintf("p(x1, x2) != p(x1)p(x2) for pA distribution, so not marginally independent\n")
else
    sprintf("p(x1, x2) == p(x1)p(x2) for pA distribution, so is marginally independent\n")
end

if(~isequal(rank(pB_x1_x2), rank(pB_x1 * pB_x2')))
    sprintf("p(x1, x2) != p(x1)p(x2) for pB distribution, so not marginally independent\n")
else
    sprintf("p(x1, x2) == p(x1)p(x2) for pB distribution, so is marginally independent\n")
end

if(~isequal(rank(pC_x1_x2), rank(pC_x1 * pC_x2')))
    sprintf("p(x1, x2) != p(x1)p(x2) for pC distribution, so not marginally independent\n")
else
    sprintf("p(x1, x2) == p(x1)p(x2) for pC distribution, so is marginally independent\n")
end

%% x3 is conditionally independent of x4 given x1 and x2 (which is p(x3, x4|x1, x2) = p(x3|x1,x2)p(x4|x1,x2)

% First calculate p(x3|x1,x2) and p(x4|x1,x2)
pA_x3_given_x1_x2 = zeros(5, 5, 5);
pA_x4_given_x1_x2 = zeros(5, 5, 5);
pB_x3_given_x1_x2 = zeros(5, 5, 5);
pB_x4_given_x1_x2 = zeros(5, 5, 5);
pC_x3_given_x1_x2 = zeros(5, 5, 5);
pC_x4_given_x1_x2 = zeros(5, 5, 5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x3_given_x1_x2(x3, x1, x2) = pA_x3_given_x1_x2(x3, x1, x2) + pA(x1, x2, x3, x4);
                pA_x4_given_x1_x2(x4, x1, x2) = pA_x4_given_x1_x2(x4, x1, x2) + pA(x1, x2, x3, x4);
                pB_x3_given_x1_x2(x3, x1, x2) = pB_x3_given_x1_x2(x3, x1, x2) + pB(x1, x2, x3, x4);
                pB_x4_given_x1_x2(x4, x1, x2) = pB_x4_given_x1_x2(x4, x1, x2) + pB(x1, x2, x3, x4);
                pC_x3_given_x1_x2(x3, x1, x2) = pC_x3_given_x1_x2(x3, x1, x2) + pC(x1, x2, x3, x4);
                pC_x4_given_x1_x2(x4, x1, x2) = pC_x4_given_x1_x2(x4, x1, x2) + pC(x1, x2, x3, x4);
            end
        end
    end
end

% Now calculate p(x3, x4|x1, x2) for pA, pB, and pC
pA_x3_x4_given_x1_x2 = zeros(5, 5, 5, 5);
pB_x3_x4_given_x1_x2 = zeros(5, 5, 5, 5);
pC_x3_x4_given_x1_x2 = zeros(5, 5, 5, 5);

for x1 = 1:5
    for x2 = 1:5
        for x3 = 1:5
            for x4 = 1:5
                pA_x3_x4_given_x1_x2(x3, x4, x1, x2) = pA_x3_x4_given_x1_x2(x3, x4, x1, x2) + pA(x1, x2, x3, x4);
                pB_x3_x4_given_x1_x2(x3, x4, x1, x2) = pB_x3_x4_given_x1_x2(x3, x4, x1, x2) + pB(x1, x2, x3, x4);
                pC_x3_x4_given_x1_x2(x3, x4, x1, x2) = pC_x3_x4_given_x1_x2(x3, x4, x1, x2) + pC(x1, x2, x3, x4);
            end
        end
    end
end

% Now determine conditional independence of each probability distribution
% pA, pB, pC

pA_condIndependent = true;
pB_condIndependent = true;
pC_condIndependent = true;

for x1 = 1:5
    for x2 = 1:5
        if(~isequal(rank(pA_x3_x4_given_x1_x2(:, :, x1, x2)), rank(pA_x3_given_x1_x2(:, x1, x2) * pA_x4_given_x1_x2(:, x1, x2)')))
            pA_condIndependent = false;
        end

        if(~isequal(rank(pB_x3_x4_given_x1_x2(:, :, x1, x2)), rank(pB_x3_given_x1_x2(:, x1, x2) * pB_x4_given_x1_x2(:, x1, x2)')))
            pB_condIndependent = false;
        end

        if(~isequal(rank(pC_x3_x4_given_x1_x2(:, :, x1, x2)), rank(pC_x3_given_x1_x2(:, x1, x2) * pC_x4_given_x1_x2(:, x1, x2)')))
            pC_condIndependent = false;
        end
    end
end

if(~pA_condIndependent)
    sprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pA distribution, so not conditionally independent\n")
else
    sprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pA distribution, so they are conditionally independent\n")
end

if(~pB_condIndependent)
    sprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pB distribution, so not conditionally independent\n")
else
    sprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pB distribution, so they are conditionally independent\n")
end

if(~pC_condIndependent)
    sprintf("p(x3, x4|x1, x2) ~= p(x3|x1,x2)p(x4|x1,x2) for pC distribution, so not conditionally independent\n")
else
    sprintf("p(x3, x4|x1, x2) == p(x3|x1,x2)p(x4|x1,x2) for pC distribution, so they are conditionally independent\n")
end