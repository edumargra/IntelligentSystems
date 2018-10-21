function assignment1(k,eta,tmax)

X = load('data_lvq.mat');

[p,n] = size(X.w5_1) %data from x,y and z have the same size
original_values = zeros(p,n+1);
original_values(:,1:2) = X.w5_1; 
original_values(1:50,3) = 1;    %points belonging to class 1
original_values(51:100,3) = 2;  %points belonging to class 2
prototype_values = zeros(k,3);
prototype_values(1:k/2,1:2) = X.w5_1(randperm(p/2,k/2),:);
prototype_values(1:k/2,3) = 1;  %prototypes belonging to class 1
prototype_values((k/2)+1:k,1:2) = X.w5_1(50 + randperm(p/2,k/2),:);
prototype_values((k/2)+1:k,3) = 2;  %prototypes belonging to class 2
errClass = zeros(1,tmax);
figure(1); hold on;
p1 = scatter(X.w5_1(1:50,1),X.w5_1(1:50,2),'k');
p12 = scatter(X.w5_1(51:100,1),X.w5_1(51:100,2),'ks');
p2 = scatter(prototype_values(:,1),prototype_values(:,2),'r*');
for t = 1:tmax
    values = original_values(randperm(p),:);
    for i = 1:p     %training loop
        point = values(i,:);
        distance = zeros(1,k);
        for j = 1:k
            prototype = prototype_values(j,:);
            distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
        end
        [~,idx1] = min(distance(1:k/2)); %min class1
        [~,idx2] = min(distance((k/2)+1:k)); %min class 2
        idx2 = idx2 + k/2;
        if(point(3) == prototype_values(idx1,3))
            prototype_values(idx1,1:2) = prototype_values(idx1,1:2) + 1 * eta * (point(:,1:2) - prototype_values(idx1,1:2));
            prototype_values(idx2,1:2) = prototype_values(idx2,1:2) - 1 * eta * (point(:,1:2) - prototype_values(idx2,1:2));
        else
            prototype_values(idx1,1:2) = prototype_values(idx1,1:2) - 1 * eta * (point(:,1:2) - prototype_values(idx1,1:2));
            prototype_values(idx2,1:2) = prototype_values(idx2,1:2) + 1 * eta * (point(:,1:2) - prototype_values(idx2,1:2));
        end
    end
    p3 = scatter(prototype_values(idx1,1),prototype_values(idx1,2),'g.');
    p5 = scatter(prototype_values(idx2,1),prototype_values(idx2,2),'g.');
    %drawnow;
    for i = 1:p %test loop
        point = values(i,:);
        distance = zeros(1,k);
        for j = 1:k
            prototype = prototype_values(j,:);
            distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
        end
        [~,idx] = min(distance);
        if(prototype_values(idx,3) ~= point(3))
            errClass(t) = errClass(t) + 1; %different class, error
        end
    end
end
p4 = scatter(prototype_values(:,1),prototype_values(:,2),'m*');
title('LVQ2.1 implementation on data_lvq set for 4 prototypes', 'Interpreter', 'None');
h = [p1(1),p12(1),p2(1),p3(1),p4(1)];
legend(h,{'Class 1', 'Class 2', 'Initial prototypes', 'Prototypes in each iteration', 'Final prototypes'}, 'Location', 'northeastoutside', 'FontSize', 12);
hold off;
figure(2); hold on;
plot(errClass/100);
ylabel('Misclassified samples(%)');
xlabel('Epoch');
title('Error of classification for K=4 and eta=0.002 for 200 epochs');
hold off;
end