function assignment3()
p1 = load('person01.mat');
p2 = load('person02.mat');
length(find(xor(p1.iriscode(1,:),p1.iriscode(2,:)) == 1))
length(find(xor(p1.iriscode(1,:),p2.iriscode(1,:)) == 1))
fileNames = ['person01.mat','person02.mat','person03.mat','person04.mat','person05.mat','person06.mat','person07.mat','person08.mat','person09.mat','person10.mat','person11.mat','person12.mat','person13.mat','person14.mat','person15.mat','person16.mat','person17.mat','person18.mat','person19.mat','person20.mat']
s = [];
for i = 1:1000
    indices = randperm(20);
    rows = randperm(20);
    s(i) = hd_norm(fileNames(indices(1)).iricodes(rows(1),:),fileNames(indices(1)).iricodes(rows(2),:));
    
    
end
end