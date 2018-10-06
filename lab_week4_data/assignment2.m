function assignment2()
    load('dataAEX.mat'); %19x277 matrix time series
    load('labelsAEX.mat'); %1x19 matrix labels
    X = data;
    Y = pdist(X); %pairwise dist, default dist is euclidian
    Z = linkage(Y,'average'); %all dist contribute the same
    dendrogram(Z);
    xt = xticks;
    lab = labels;
    new_xt = lab(xt);
    xticklabels(new_xt);
    xtickangle(45);