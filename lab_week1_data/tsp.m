   function anneal = tsp(n,maxsteps,temp,met)
%  tsp(n,ms,temp,method) tries to find the shortest path 
%  that connects n randomly placed cities
%  method=1 (2) corresponds to Metropolis (threshold) algorithm
%  ms*100 is the total number of performed steps
%  temp is the initial temperature, after each 100 steps it
%  is decreased by 1%.
   if (nargin<4)
      met =1;      % default: Metropolis algorithm
   end
   if (nargin<3) 
     temp = 0.1;   % default: T=0.1
   end
   temps = temp;   % intial temperature 

   maxsteps = 100;
   lt = zeros(1,ceil(maxsteps));   
   tt = 1:ceil(maxsteps);

   close all;
%  initialize random number generator and draw coordinates 
   rand('state',0); cities = rand(n,2); 
   ord = [1:n];  op = path(ord,cities);
  
   for jstep=1:ceil(maxsteps);
   for ins = 1:100 
      j = ceil(rand*n); len = ceil(rand*(n/2));
      cand = reverse(ord,j,len);
%  evaluate change of path length 
      diff = delta(ord,cities,j,j+len);
      np   = op + diff;
%  met=1: metropolis, met=2: threshold
      if ( (met==1 && (rand<exp(-diff/temp))||(diff<0)) || ...
           (met==2 && diff<temp))
         ord = cand;
         op = np; 
      end
   end

%  rescale length of path by sqrt(n) for output purposes
      lt(jstep) =  op/sqrt(n);
      curlen = path(ord,cities)/sqrt(n);
% plot map, cities and path 
%{
      figure(1); plotcities(ord,cities);
      title(['n =',num2str(n,'%3.0f'),       ...
             '   t =',num2str(jstep*100,'%8.0f'),  ... 
             '   l =',num2str(curlen,'%4.4f'),  ... 
             '   T =',num2str(temp,'%6.6f')],   ...
             'fontsize',16);
    if (met==1) 
        xlabel(['Metropolis algorithm, annealing'],'fontsize',16);
    else 
        xlabel(['Threshold algorithm', ...
                '    T(0)=',num2str(temps,'%4.4f')], ...
                'fontsize',16);
    end
      pause(0.1);
%}
   end
%  plot evolution of length versus iteration step
%       figure(2); plot(0,0); hold on; 
%       plot(tt,lt,'k.'); 
%       title(['n =',num2str(n,'%3.0f'),       ...
%              '   l =',num2str(curlen,'%4.4f'),  ... 
%              '   T =',num2str(temps,'%4.4f')],   ... 
%              'fontsize',16);
      if (met==1) 
         xlabel(['Metropolis steps / 100'],'fontsize',16);
         m = mean(lt(end-50:end)*sqrt(n));
         std = sqrt(var(lt(end-50:end)*sqrt(n)));
         anneal = [m,std];
      else 
         xlabel(['Threshold steps /100'],'fontsize',16);
      end
         ylabel(['l'],'fontsize',16);

