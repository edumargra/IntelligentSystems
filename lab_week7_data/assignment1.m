function assignment1(k,eta,tmax,ncross)

X = load('data_lvq.mat');

[p,n] = size(X.w5_1); %data from x,y and z have the same size
original_values = zeros(p,n+1);
original_values(:,1:2) = X.w5_1; 
original_values(1:50,3) = 1;    %points belonging to class 1
original_values(51:100,3) = 2;  %points belonging to class 2
original_values = original_values(randperm(p),:);%initial shuffle
section = round(p/ncross); %section
errClass = zeros(ncross,tmax); %error test
errClassTrain = zeros(ncross,tmax); %error training
for cross = 1:ncross
    test_values = original_values((cross-1)*section+1:cross*section,:);
    training_values = original_values(~ismember(original_values,test_values,'rows'),:);
    %sample prototypes from the training set
    prototype_values = zeros(k,3);
    class1 = training_values(training_values(:,3) == 1,:);
    prototype_values(1:k/2,:) = class1(randperm(size(class1,1),k/2),:); %k/2 random points of class1
    class2 = training_values(training_values(:,3) == 2,:);
    prototype_values((k/2)+1:k,:) = class2(randperm(size(class2,1),k/2),:); %k/2 random points of class2
    for t = 1:tmax
        values = training_values(randperm(size(training_values,1)),:);
        for i = 1:size(training_values,1)     %training loop
            point = values(i,:);
            distance = zeros(1,k);
            for j = 1:k
                prototype = prototype_values(j,:);
                distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
            end
            [~,idx] = min(distance);
            if(prototype_values(idx,3) == point(3))
                sign = 1; %same class, get closer
            else
                sign = -1; %different class, get farther
            end
            prototype_values(idx,1:2) = prototype_values(idx,1:2) + sign * eta * (point(:,1:2) - prototype_values(idx,1:2));
        end
        
        for i = 1:size(training_values,1) %error training loop
            point = values(i,:);
            distance = zeros(1,k);
            for j = 1:k
                prototype = prototype_values(j,:);
                distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
            end
            [~,idx] = min(distance);
            if(prototype_values(idx,3) ~= point(3))
                errClassTrain(cross,t) = errClassTrain(cross,t) + 1; %different class, error
            end
        end
        
        values = test_values(randperm(size(test_values,1)),:);
        for i = 1:size(test_values,1) %test loop
            point = values(i,:);
            distance = zeros(1,k);
            for j = 1:k
                prototype = prototype_values(j,:);
                distance(j) = (prototype(1)-point(1))^2 + (prototype(2)-point(2))^2;
            end
            [~,idx] = min(distance);
            if(prototype_values(idx,3) ~= point(3))
                errClass(cross,t) = errClass(cross,t) + 1; %different class, error
            end
        end
    end
end
figure(1); hold on;
errClassTrain = errClassTrain/80;
errClass = errClass/20;
disp(std(errClassTrain));
errorbar(mean(errClass),std(errClass),'r');
errorbar(mean(errClassTrain),std(errClassTrain),'b');
hold off;
end