function assignment3()
p1 = load('person01.mat');
p2 = load('person02.mat');
length(find(xor(p1.iriscode(1,:),p1.iriscode(2,:)) == 1))
length(find(xor(p1.iriscode(1,:),p2.iriscode(1,:)) == 1))
fileNames = ["person01.mat","person02.mat","person03.mat","person04.mat","person05.mat","person06.mat","person07.mat","person08.mat","person09.mat","person10.mat","person11.mat","person12.mat","person13.mat","person14.mat","person15.mat","person16.mat","person17.mat","person18.mat","person19.mat","person20.mat"];
s = [];
d = [];
for i = 1:1000
    %randperm allows us to obtain two different integers
    %by getting the two first positions
    indices = randperm(20);
    rows = randperm(20);
    file1 = load(fileNames(indices(1)));
    file2 = load(fileNames(indices(2)));
    s(i) = hd_norm(file1.iriscode(rows(1),:),file1.iriscode(rows(2),:));
    %We use randi because in this case the integers can be the same for the
    %row
    d(i) = hd_norm(file1.iriscode(randi([1,20]),:),file2.iriscode(randi([1,20]),:));
end
figure(4);
%Adjusted the number of bins so it's seen clearly
histogram(s); hold on;
disp(s)
disp(d)
histogram(d);
legend({'Equal Iris','Different Iris'},'Location','northeast');
hold off;
figure(5); hold on;
histfit(s,7); 
histfit(d,17);
legend({'Equal Iris','Normal distribution of same Iris','Different Iris','Normal distribution of different iris'},'Location','northeast');
ylabel('Number of occurrences');
xlabel('Normalised Hamming Distance');
hold off;

end

function diff = hd_norm(row1,row2)
    %xor returns a vector with 1's where its different
    %find returns a vector with the indices where 1's appear
    %length of the vector find is the hamming distance
    diff = length(find(xor(row1,row2) == 1))/30;
end