function [membership, centres] = k_medoids(X, n_cluster)
% X: the data matrix, rows are data points and columns are features
% n_cluster: number of cluster

if n_cluster > 4
    disp ('You have set too many clusters.');
    disp ('Set the number of clusters to be 1-4.');
    disp ('The program and visualization allow for up to 4 clusters.');
    return;
end

% Initialize the figure
figure('position', [200, 200, 600, 500]);
    
% Get the number of data points and number of features
[n_sample, n_feat] = size(X); 

% Initialize the starting cluster centres as randomly selected medoids
centres = zeros(n_cluster, n_feat);
for i = 1:n_cluster
    centres(i, :) = X(randperm(length(X),1), :);
end

disp('Start K-medoids clustering ... ');

% Initialization:
% In the begining, all data points are in cluster 1
% The "old_membership" variable is an n_sample-by-1 matrix.
% It saves the cluster id that each data point belongs to.
% Again, in the begining, all data points are in cluster 1
old_membership = ones(n_sample, 1);

% Display the initial cluster membership for all datapoints
% and the initial cluster centres
show(X, old_membership, n_cluster, centres, 'Cluster centres initialized!')

while true
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % You need to add code here.
    % Calculate Manhattan distances
    % between every data point and every cluster centre.
    % Please put your results in an 
    % n_sample-by-n_cluster matrix named as "distance". 
    % You may find the Matlab function pdist2 to be useful here. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    distance = pdist2(X, centres, "cityblock"); 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % You need to add code here.
    % E step: Assign data points to closest clusters.
    % Specifically, for each data point, find closest 
    % cluster centre, and assign the data point
    % to that cluster.
    % Save your assignment to the variable "membership", 
    % which is an n_sample-by-1 vector and each row saves 
    % the cluster membership of a datapoint.
    % (See the description of "old_membership" as well.) 
    % You should use here the "distance" computed above.
    % You may find the function "min" useful here,
    % but feel free not to use it and write whatever code
    % you think can implement the above requirement.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [~, membership] = min(distance, [], 2);
    
    %Show the result of the E step.
    show(X, membership, n_cluster, centres, 'E step finished: Datapoints re-assigned!')

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % You need to add code here.
    % M step: Update cluster centres based on the new assignment.
    % You need to use "membership" here.
    % Save your new centres in variable "centres".
    % You may find the function "median" to be useful here.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Loop through each cluster centre
    for medoid = 1:n_cluster
        % Create array with all points in current cluster, and array to
        % hold sum of distances to all other points in cluster for this
        % cluster
        points_in_cluster = X(membership == medoid, :);
        point_distances = zeros(1, size(points_in_cluster, 1));
        % Loop through all points in current cluster and calculate the sum
        % of distance from this point to all other points in current
        % cluster
        for point = 1:size(points_in_cluster, 1)
            point_distances(1, point) = sum(pdist2(points_in_cluster(point, :), points_in_cluster, "cityblock"));
        end
        % Determine point that has minimum sum of distances to all other
        % points in cluster, and set this as the new centre for the current
        % cluster 
        [~, min_index] = min(point_distances);
        centres(medoid, :) = points_in_cluster(min_index, :);
    end
    
    %Show the result of the M step.
    show(X, membership, n_cluster, centres, 'M step finished: Cluster centers updated!')
    
    % Stop if no more updates.
    if sum(membership ~= old_membership)==0
        show(X, membership, n_cluster, centres, 'Done! ');
        break;
    end
    
    old_membership = membership;
end
end

function show(X, c_pred, n_cluster, centres, txt)
    symbol = ['ro'; 'gp'; 'bd'; 'k^'; 'r*'];
    hold off;
        
    for i = 1:n_cluster
        marker = mod(i,5);
        if i > 4            
            disp('Total number of clusters exceeds 4, some symbols in the plot are reused!');
        end
        plot(X(c_pred==i, 1), X(c_pred==i, 2), symbol(marker,:));
        hold on;
        plot(centres(i, 1), centres(i, 2), symbol(marker,2), 'MarkerFaceColor',symbol(marker,1));
    end
    text(4.2, 5.4, txt);
    drawnow;
    
    %Pause some time here.
    %Used to show figure with enough time.
    %You can change the pause time.
    pause(0.5);
end
