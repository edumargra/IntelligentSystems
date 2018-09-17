function assignment2()
load('lab1_2.mat');
figure(3);
plot(measurements(:,1),measurements(:,2),'.'); hold on;
plot([165,192],[0,60]);
xlabel('Height in cm');
ylabel('Length of hair in cm');
hold off;
end