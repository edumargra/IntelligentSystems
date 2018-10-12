function assignment1(k,eta,tmax)

X = load('w6_1x.mat');
Y = load('w6_1y.mat');
Z = load('w6_1z.mat');

[p,n] = size(X.w6_1x); %data from x,y and z have the same size
prototype_values = X.w6_1x(randperm(p,k),:)
figure(1); hold on;
p1 = scatter(X.w6_1x(:,1),X.w6_1x(:,2),'k.');
p2 = scatter(prototype_values(:,1),prototype_values(:,2),'r*');
for t = 1:tmax
    values = X.w6_1x(randperm(p),:);
    for i = 1:p
        point = values(i,:);
        distance = zeros(k);
        for j = 1:k
            prototype = prototype_values(j,:);
            distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
        end
        [~,idx] = min(distance);
        prototype_values(idx,:) = prototype_values(idx,:) + eta * (point - prototype_values(idx,:));
    end
    p3 = scatter(prototype_values(idx,1),prototype_values(idx,2),'g.');
    drawnow;
end
p4 = scatter(prototype_values(:,1),prototype_values(:,2),'m*');
title('Winner-takes-all implementation on w6_1x set for 2 prototypes', 'Interpreter', 'None');
h = [p1(1),p2(1),p3(1),p4(1)];
legend(h,'Data points', 'Initial prototypes', 'Prototypes in each iteration', 'Final prototypes', 'Location', 'northeastoutside');
hold off;
end