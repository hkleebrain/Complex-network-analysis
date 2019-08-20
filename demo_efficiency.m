% demo_efficiency.m
clear all;

network_name = {'RE','SW','RA','SF','HY'};

% Estimate global and local efficiencies
Eglob = []; Eloc = [];
for iter = 1:100,
    for s = 1:10,
        sparsity = s*0.1;
        [RE,SW,RA,SF,HY] = graph_generation(sparsity);
        
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
            
            Eglob(s,j,iter) = efficiency_bin(A);
            Eloc(s,j,iter) = mean(efficiency_bin(A,1)); 
        end
    end
    display(num2str(iter)); 
end

% plot the average global and local efficiencies of 100 random complex networks 
figure;
subplot(1,2,1), plot([1:10]*0.1,mean(Eglob,3),'.-','MarkerSize',10);
xlabel('Sparsity'); ylabel('Global efficiency'); 
legend(network_name); set(gca,'FontSize',14);
subplot(1,2,2), plot([1:10]*0.1,mean(Eloc,3),'.-','MarkerSize',10);
xlabel('Sparsity'); ylabel('Local efficiency'); 
legend(network_name); set(gca,'FontSize',14);