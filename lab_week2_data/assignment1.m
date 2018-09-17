function assignment1()

%load data
load('lab1_1.mat')
%plot histogram
figure(1);
histogram(length_women);hold on;
histogram(length_men); 
legend({'Women','Men'},'Location','northwest');
xlabel('Height in cm');
ylabel('Number of people');
hold off;
%find how many men are less than 170cm
length(find(length_men < 170)) %returns 0
%find how many women are more than 170cm
length(find(length_women > 170)) %returns 29
%find nuber of total errors in the interval 170 to 190
outliners = [];
for k = 1:21
    outliners(k)=length(find(length_men < k + 169)) + length(find(length_women > k + 169));
end
%find the minimum value
[value,idx] = min(outliners);
idx = idx + 169
figure(2);
plot(170:190,outliners);
xlabel('Height in cm');
ylabel('Number of errors');

end