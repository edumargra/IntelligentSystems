function assignment1(k,eta,tmax)

X = load('data_lvq.mat');

[p,n] = size(X.w5_1) %data from x,y and z have the same size
original_values = zeros(p,n+1);
original_values(:,1:2) = X.w5_1;
original_values(1:50,3) = 1;
original_values(51:100,3) = 2;
prototype_values = zeros(k,3);
prototype_values(1:k/2,1:2) = X.w5_1(randperm(p/2,k/2),:);
prototype_values(1:k/2,3) = 1;
prototype_values((k/2)+1:k,1:2) = X.w5_1(50 + randperm(p/2,k/2),:);
prototype_values((k/2)+1:k,3) = 2;
h_vq = zeros(1,tmax);
figure(1); hold on;
p1 = scatter(X.w5_1(1:50,1),X.w5_1(1:50,2),'k');
p12 = scatter(X.w5_1(51:100,1),X.w5_1(51:100,2),'ks');
p2 = scatter(prototype_values(:,1),prototype_values(:,2),'r*');
for t = 1:tmax
    values = original_values(randperm(p),:);
    for i = 1:p
        point = values(i,:);
        distance = zeros(1,k);
        for j = 1:k
            prototype = prototype_values(j,:);
            distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
        end
        [value,idx] = min(distance);
        h_vq(t) = h_vq(t) + value;
        if(prototype_values(idx,3) == point(3))
            sign = 1;
        else
            sign = -1;
        end
        prototype_values(idx,1:2) = prototype_values(idx,1:2) + sign * eta * (point(:,1:2) - prototype_values(idx,1:2));
    end
    p3 = scatter(prototype_values(idx,1),prototype_values(idx,2),'g.');
    %drawnow;
end
p4 = scatter(prototype_values(:,1),prototype_values(:,2),'m*');
title('Winner-takes-all implementation on w6_1x set for 4 prototypes', 'Interpreter', 'None');
h = [p1(1),p12(1),p2(1),p3(1),p4(1)];
legend(h,{'Class 1', 'Class 2', 'Initial prototypes', 'Prototypes in each iteration', 'Final prototypes'}, 'Location', 'northeastoutside', 'FontSize', 12);
hold off;
figure(2); hold on;
plot(h_vq);
ylabel('Quantization Error');
xlabel('Epoch');
title('Quantization Error for K=2 and eta=0.005 for 200 epochs');
hold off;
end