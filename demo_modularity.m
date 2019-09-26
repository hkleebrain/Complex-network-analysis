% demo_modularity.m
clear all;

network_name = {'RE','SW','RA','SF','HY'};

% Generate artificial complex networks with sparsity 0.2
sparsity = 0.2;
[RE,SW,RA,SF,HY] = graph_generation(sparsity);
% number of nodes 
p = size(RE,1); 

%%% Modularity
% Estimate the modular structure of networks and plot the modules
figure; 
for j = 1:5,
    if j == 1,
        A = RE;
    elseif j == 2,
        A = SW;
    elseif j == 3,
        A = RA;
    elseif j == 4,
        A = SF;
    else
        A = HY;
    end
    
    % Estimate modularity
    [Ci Q] = modularity_und(A);
    % Ci: the index of the node's modules 
    % Q: modularity 
    
    % Plot modularity 
    [row,col] = find(A); % find the index of nodes of connected edges (row,col)  
    tind = find(row < col); % because A is a symmetric matrix 
    row = row(tind); col = col(tind); 
    G = graph(row,col); 
    
    % number of modules 
    num_modules = max(Ci);
    % The color of a node is changed depending on its module  
    tcolor = colormap(jet(num_modules)); 
    node_color = tcolor(Ci,:); 
    node_size = 10; 
        
    subplot(1,5,j), 
    h = plot(G,'Layout','force','MarkerSize',node_size,'NodeColor',node_color); 
    layout(h,'force','UseGravity',true,'Iterations',1000); 
    xlabel(network_name{j});
    title(['Q = ' num2str(Q) ', #modules=' num2str(num_modules)]); 
    set(gca,'FontSize',14); 
end

