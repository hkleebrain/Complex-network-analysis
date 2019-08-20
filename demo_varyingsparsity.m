% demo_varyingsparsity.m 
clear all 

% cnm toolbox should be in current folder
addpath('.\cnm');  
% the name of networks we generate 
network_name = {'Regular network','Small world network','Random network'}; 

% number of nodes in a network 
p = 30;
% number of all possible edges 
q = p*(p-1)/2; 

% Plot RE, SW, and RA by varying sparsity 
figure; 
for s = 1:10, 
    % ratio of the number of connected edges to the number of all possible edges 
    sparsity = s*0.1; 
    % number of neareast neigbors to which each node is connected 
    k = round(q*sparsity*2/p); 

    % Step 1: Generating networks 
    % Regular network 
    RE = regular_net('N',p,'k',k); 
    % Small world network 
    SW = sw_net('N',p,'k',k); 
    % Random network 
    RA = er_net('N',p,'P',sparsity);

    % Step 2: Visualizing networks
    for i = 1:3, 
        if i == 1,
            net = RE; 
        elseif i == 2,
            net = SW; 
        else
            net = RA; 
        end 
        
        [row,col] = find(net); % find the index of nodes of connected edges (row,col) in SF  
        tind = find(row < col); % because SF is a symmetric matrix 
        row = row(tind); col = col(tind); 
        G = graph(row,col);
        subplot(3,10,(i-1)*10+s); 
        h = plot(G,'Layout','force'); 
        layout(h,'force','UseGravity',true,'Iterations',1000); 
        
        if s == 5, 
            title(network_name{i});
        end 
        if i == 3, 
            xlabel(['sparsity=' num2str(sparsity)]); 
        end 
        set(gca,'FontSize',14); 
    end
end