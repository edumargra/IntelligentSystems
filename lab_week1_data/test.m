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

j = 0.5:-0.01:0; %temp
k = 20:30:140; %cities

results = zeros(length(j),2);
finalResults = zeros(length(j),length(k)*2);
column = 1;
for l = k
    z = 1;
    for i = j
        results(z,:) = tsp(l,100,i,1);
        z = z + 1;
    end
    finalResults(:,column:column+1) = results;
    column = column + 2;
end
figure(3); hold on; 
%fem grafic de les diferents ciutats

for column = 1:2:2*length(k)
    errorbar(j,finalResults(:,column), finalResults(:,column+1),'o-');
    hold on;
end

title('Mean Length vs Temperature comparsion for different number of cities','fontsize',16);
xlabel('Temperature Values','fontsize',16);
ylabel('Mean length of path values','fontsize',16);
legend({'20 cities','50 cities','80 cities','110 cities','140 cities'},'Location','northwest','FontSize',12);

    