% demo_graphplot.m

% demo_generation.m continued 
demo_generation; 

% Step 2: Visualizing SF
[row,col] = find(SF); % find the index of nodes of connected edges (row,col) in SF  
tind = find(row < col); % because SF is a symmetric matrix 
row = row(tind); col = col(tind); 
G = graph(row,col); 

figure; 
h = plot(G,'Layout','force'); 
layout(h,'force','UseGravity',true,'Iterations',1000); 
title(network_name{4}); 
set(gca,'FontSize',14); 
