function lab3()
%assignment1(); %add answer to question 2
assignment2();
end

function assignment1()
    load('lab3_1.mat');
    posterior_salmon = [];
    posterior_seabass = [];
    for i = 1:length(p_salmon)
        posterior_salmon(i) = (p_salmon(i) * 1/4)/(p_salmon(i)*1/4 + p_seabass(i)*3/4);
        posterior_seabass(i) = (p_seabass(i) * 3/4)/(p_salmon(i)*1/4 + p_seabass(i)*3/4);
    end
    figure(1); hold on;
    plot(l,posterior_salmon,'r');
    plot(l,posterior_seabass,'b');
    plot([8,8],[0,1],'k');
    plot([20,20],[0,1],'k');
    xlabel('Length in cm of the fish');
    ylabel('Posterior probability');
    legend({'Salmon','Seabass'},'Location','northwest');
    title('Posterior probability of salmons and sea basses based on their length')
    hold off;
end

function assignment2()
    load('normdist.mat');
    figure(1); hold on;
    plot(S1,zeros(length(S1)),'bo');
    plot(S2,zeros(length(S2)),'ro');
    plot(T,zeros(length(T)),'ks');
    title('Values of the sets S1, S2 and T')
    xlabel('Value');
    hold off;
    
    mean_s1 = mean(S1);
    mean_s2 = mean(S2);
    std_s1 = std(S1);
    std_s2 = std(S2);
    
    norm_s1 = normpdf(-50:95,mean_s1,std_s1);
    norm_s2 = normpdf(-50:95,mean_s2,std_s2);
    figure(2); hold on;
        plot(S1,zeros(length(S1)),'bo');
        plot(S2,zeros(length(S2)),'ro');
        plot(T,zeros(length(T)),'ks');
        plot(-50:95,norm_s1);
        plot(-50:95,norm_s2);
        title('Gaussian distributions of sets S1 and S2')
        ylabel('Class conditional probability');
        xlabel('Value');
    hold off;
    
    prior_s1 = length(S1)/(length(S1)+length(S2));
    prior_s2 = length(S2)/(length(S1)+length(S2));
    
    post_prob_s1 = prior_s1 * norm_s1;
    post_prob_s2 = prior_s2 * norm_s2;
    
    figure(3); hold on;
        plot(S1,zeros(length(S1)),'bo');
        plot(S2,zeros(length(S2)),'ro');
        plot(T,zeros(length(T)),'ks');
        plot(-50:95,post_prob_s1);
        plot(-50:95,post_prob_s2);
        title('Posterior Gaussian distributions of sets S1 and S2')
        ylabel('Posterior probability');
        xlabel('Value');
    hold off;
    
    figure(4); hold on;
        plot(S1,zeros(length(S1)),'bo');
        plot(S2,zeros(length(S2)),'ro');
        plot(T,zeros(length(T)),'ks');
        plot(-50:95,post_prob_s1);
        plot(-50:95,post_prob_s2);
        treshold1 = 35.8596;
        treshold2 = 123.847;
        plot([treshold1 treshold1],[0 0.014],'k');
        plot([treshold2 treshold2],[0 0.014],'k');
        text(-60+((treshold1+60)/2), 0.007, 'S1');
        text(treshold1+((treshold2-treshold1)/2), 0.007, 'S2');
        text(130, 0.007, 'S1');
        title('Posterior Gaussian distributions of sets S1 and S2')
        ylabel('Posterior probability');
        xlabel('Value');
    hold off;
    errorS1 = (1 - sum(S1<treshold1)/length(S1)) %0.1333
    errorS2 = sum(S2<treshold1)/length(S2) %0.0667
end