% demo_generation.m 
clear all; 

% cnm toolbox should be in current folder
addpath('.\cnm');  
% the name of networks we generate 
network_name = {'RE','SW','RA','SF','HY'};

% number of nodes in a network 
p = 30;
% ratio of the number of connected edges to the number of all possible edges 
sparsity = 0.2;

% number of all possible edges 
q = p*(p-1)/2; 
% number of neareast neigbors to which each node is connected 
k = round(q*sparsity*2/p); 
% power law scaling exponent of the network's node degree distribution
gamma = 4; 
% network temperature that allows for clustering tuning
T = 0.1; 

%%% Step 1: Generating artificial complex networks 
% Regular network 
RE = regular_net('N',p,'k',k); 
% Small world network 
SW = sw_net('N',p,'k',k); 
% Random network 
RA = er_net('N',p,'P',sparsity);
% Scale free network 
SF = ba_net('N',p,'m',round(k/2));
% Hyperbolic geometric network
HY = h2_net('N',p,'ave_deg',k,'gamma',gamma,'T',T,'plot','no'); 

% Plot adjacency matrices 
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
    
    subplot(1,5,j); 
    imagesc(A); 
    title(network_name{j}); set(gca,'FontSize',14); 
end 
colormap(hot); 

            
