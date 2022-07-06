%% Code for BoxPLot
% rng default  % For reproducibility
% x1 = normrnd(5,1,100,1);
% x2 = normrnd(6,1,100,1);
% figure
% boxplot([x1,x2],'Notch','on','Labels',{'mu = 5','mu = 6'})
% title('Compare Random Data from Different Distributions')
% 

% y1=[71.7;
%     80.7;
%     89.7];
% y2=[54.8;
%     61.35;
%     67.9];
% y3=[54.6;
%     62.45;
%     70.3];
% y4=[52.5;
%     61.45;
%     70.4];
% y5=[59.4;
%     65.35;
%     71.3];
% 
% y6=[59.2;
%     64.95;
%    70.7];
% y7=[58.9;
%     73.55;
%     88.2];
v1=92.0;
v2=91.0;
v3=85.4;
v4=93.8;
v5=94.7;
v6=91.7;
v7=95.0;

figure
boxplot([v1,v2,v3,v4,v5,v6,v7],'Notch','on','Labels',...
{'42','38','39','40','41','19','Proposed'})
title('Min Max Avg Values')
