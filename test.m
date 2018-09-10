function result = test()
%{
z = 1;
results = zeros(6,2);
for i = [0.5 0.2 0.1 0.05 0.02 0.01]
    results(z,:) = tsp(50,100,i,1);
    z = z + 1;
end

disp(results)
figure(3); plot(0,0); hold on; 
errorbar([0.5 0.2 0.1 0.05 0.02 0.01],results(:,1),results(:,2),'ko-');
title('<l> vs T comparsion','fontsize',16);
xlabel('Temperature Values','fontsize',16);
ylabel('<l> values','fontsize',16);
%}

z = 1;
j = 0.5:-0.01:0;
results = zeros(length(j),2);
for i = j
    results(z,:) = tsp(50,100,i,1);
    z = z + 1;
end

disp(results)
figure(3); plot(0,0); hold on; 
errorbar(j,results(:,1),results(:,2),'ko-');
title('<l> vs T comparsion','fontsize',16);
xlabel('Temperature Values','fontsize',16);
ylabel('<l> values','fontsize',16);

    