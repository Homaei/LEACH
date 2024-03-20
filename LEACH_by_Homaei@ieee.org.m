%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                       %
% This is the LEACH [1] code we have used.                                              %
% The same code can be used for FAIR if m=1                                             %
%                                                                                       %
% [1] W.R.Heinzelman, A.P.Chandrakasan and H.Balakrishnan,                              %
% An application-specific protocol architecture for wireless microsensor networks       %
%                                                                                       %
% IEEE Transactions on Wireless Communications, 1(4):660-670,2002                       %
% Mohammad Hossein Homaei                                                               %
%                                           Homaei@ieee.org                             %
% Google Scholar: https://scholar.google.com/citations?user=8IGmFIoAAAAJ&hl=en&oi=ao    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% LEACH Protocol %
% %

clear;
%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Field Dimensions - Maximum x and y dimensions of the network area (in meters)
% ابعاد میدان - حداکثر ابعاد x و y منطقه شبکه (به متر)
xm = 100; % x dimension
ym = 100; % y dimension

% Coordinates of the Sink - Position of the base station
% مختصات محلی - موقعیت ایستگاه پایه (Base Station)
sink.x = 0.5 * xm;
sink.y = 0.5 * ym;

% Number of Nodes in the field
% تعداد نودها در میدان
n = 100;

% Optimal Election Probability of a node to become cluster head
% احتمال بهینه انتخاب یک نود به عنوان سرگروه
p = 0.1;

% Energy Model (all values in Joules)
% Initial Energy of nodes
% مدل انرژی (همه مقادیر به واحد ژول)
% انرژی اولیه نودها
Eo = 0.5;
% Energy consumption parameters for various operations
% پارامترهای مصرف انرژی برای عملیات‌های مختلف
ETX = 50 * 0.000000001; % Energy consumed during transmission
ERX = 50 * 0.000000001; % Energy consumed during reception
Efs = 10 * 0.000000000001; % Energy for free space model
Emp = 0.0013 * 0.000000000001; % Energy for multi-path fading model
EDA = 5 * 0.000000001; % Energy consumed during data aggregation

% Values for Heterogeneity 
% Percentage of nodes that are advanced
% مقادیر برای ناهمگونی
% درصد نود‌های پیشرفته
m = 0.1;
% Parameter alpha for energy model
% پارامتر آلفا برای مدل انرژی
a = 1;

% Maximum number of rounds for the simulation
% تعداد بیشینه دورها برای شبیه‌سازی
rmax = 200;





%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

% Computation of do - Calculating the optimal distance for energy calculations
% محاسبه do - محاسبه فاصله بهینه برای محاسبات انرژی
do = sqrt(Efs / Emp);

% Creation of the random Sensor Network
% ایجاد شبکه حسگری تصادفی
figure(1);
for i = 1:1:n
    S(i).xd = rand(1, 1) * xm;
    XR(i) = S(i).xd;
    S(i).yd = rand(1, 1) * ym;
    YR(i) = S(i).yd;
    S(i).G = 0;
    % initially there are no cluster heads only nodes
    % در ابتدا فقط نودها بدون سرگروه هستند
    S(i).type = 'N';
   
    temp_rnd0 = i;
    % Random Election of Normal Nodes
    % انتخاب تصادفی نود‌های عادی
    if (temp_rnd0 >= m * n + 1) 
        S(i).E = Eo;
        S(i).ENERGY = 0;
        plot(S(i).xd, S(i).yd, 'o');
        hold on;
    end
    % Random Election of Advanced Nodes
    % انتخاب تصادفی نود‌های پیشرفته
    if (temp_rnd0 < m * n + 1)  
        S(i).E = Eo * (1 + a);
        S(i).ENERGY = 1;
        plot(S(i).xd, S(i).yd, '+');
        hold on;
    end
end
S(n + 1).xd = sink.x;
S(n + 1).yd = sink.y;
plot(S(n + 1).xd, S(n + 1).yd, 'x');

  
    
    
    
    
    
    
    
    
    
    % First Iteration - Initializing the first iteration
% اولین تکرار - مقداردهی اولیه برای تکرار اول

figure(1);

% Counter for CHs - Counts the number of cluster heads
% تعداد سرگروه‌ها - تعداد سرگروه‌ها را محاسبه می‌کند
countCHs = 0;

% Counter for CHs per round - Counts the number of cluster heads per round
% تعداد سرگروه‌ها در هر دور - تعداد سرگروه‌ها را در هر دور محاسبه می‌کند
rcountCHs = 0;

% Initializing cluster counter
% شروع محاسبه تعداد سرگروه‌ها
cluster = 1;

% Initialize counters
% مقداردهی اولیه شمارنده‌ها
countCHs;
rcountCHs = rcountCHs + countCHs;

% Flag for the first dead node
% پرچم برای اولین نود مرده
flag_first_dead = 0;

for r = 0:1:rmax
    r

    % Operation for epoch - Updating node status for each epoch
    % عملیات برای دوره - بروزرسانی وضعیت نودها برای هر دور
    if (mod(r, round(1/p)) == 0)
        for i = 1:1:n
            S(i).G = 0;
            S(i).cl = 0;
        end
    end

    hold off;




% Number of dead nodes - Counts the total number of dead nodes
% تعداد نود‌های مرده - تعداد کل نود‌های مرده را محاسبه می‌کند
dead = 0;

% Number of dead Advanced Nodes - Counts the number of dead advanced nodes
% تعداد نود‌های پیشرفته مرده - تعداد نود‌های پیشرفته مرده را محاسبه می‌کند
dead_a = 0;

% Number of dead Normal Nodes - Counts the number of dead normal nodes
% تعداد نود‌های عادی مرده - تعداد نود‌های عادی مرده را محاسبه می‌کند
dead_n = 0;







% Counter for bits transmitted to Base Station and to Cluster Heads
% تعداد بیت‌های ارسال شده به ایستگاه پایه و به سرگروه‌ها
packets_TO_BS = 0;
packets_TO_CH = 0;

% Counter for bits transmitted to Base Station and to Cluster Heads per round
% تعداد بیت‌های ارسال شده به ایستگاه پایه و به سرگروه‌ها در هر دور
PACKETS_TO_CH(r + 1) = 0;
PACKETS_TO_BS(r + 1) = 0;

figure(1);

for i = 1:1:n
    % Checking if there is a dead node
    % بررسی اینکه آیا یک نود مرده است یا نه
    if (S(i).E <= 0)
        plot(S(i).xd, S(i).yd, 'red .');
        dead = dead + 1;
        if (S(i).ENERGY == 1)
            dead_a = dead_a + 1;
        end
        if (S(i).ENERGY == 0)
            dead_n = dead_n + 1;
        end
        hold on;    
    end
    if S(i).E > 0
        S(i).type = 'N';
        if (S(i).ENERGY == 0)  
            plot(S(i).xd, S(i).yd, 'o');
        end
        if (S(i).ENERGY == 1)  
            plot(S(i).xd, S(i).yd, '+');
        end
        hold on;
    end
end
plot(S(n + 1).xd, S(n + 1).yd, 'x');

% Recording statistics about dead nodes
% ثبت آمار درباره نود‌های مرده
STATISTICS(r + 1).DEAD = dead;
DEAD(r + 1) = dead;
DEAD_N(r + 1) = dead_n;
DEAD_A(r + 1) = dead_a;

% When the first node dies
% زمانی که اولین نود می‌میرد
if (dead == 1)
    if (flag_first_dead == 0)
        first_dead = r;
        flag_first_dead = 1;
    end
end








countCHs = 0;
cluster = 1;
for i = 1:1:n
    if (S(i).E > 0)
        temp_rand = rand;     
        if ((S(i).G) <= 0)
            % Election of Cluster Heads
            % انتخاب سرگروه‌ها
            if (temp_rand <= (p / (1 - p * mod(r, round(1 / p)))))
                countCHs = countCHs + 1;
                packets_TO_BS = packets_TO_BS + 1;
                PACKETS_TO_BS(r + 1) = packets_TO_BS;
                
                S(i).type = 'C';
                S(i).G = round(1 / p) - 1;
                C(cluster).xd = S(i).xd;
                C(cluster).yd = S(i).yd;
                plot(S(i).xd, S(i).yd, 'k*');
                
                distance = sqrt((S(i).xd - (S(n + 1).xd))^2 + (S(i).yd - (S(n + 1).yd))^2);
                C(cluster).distance = distance;
                C(cluster).id = i;
                X(cluster) = S(i).xd;
                Y(cluster) = S(i).yd;
                cluster = cluster + 1;
                
                % Calculation of Energy dissipated
                % محاسبه انرژی مصرفی
                distance;
                if (distance > do)
                    S(i).E = S(i).E - ((ETX + EDA) * (4000) + Emp * 4000 * (distance^4)); 
                end
                if (distance <= do)
                    S(i).E = S(i).E - ((ETX + EDA) * (4000) + Efs * 4000 * (distance^2)); 
                end
            end     
        end
    end
end



STATISTICS(r + 1).CLUSTERHEADS = cluster - 1;
CLUSTERHS(r + 1) = cluster - 1;

%Election of Associated Cluster Head for Normal Nodes
% انتخاب سرگروه مرتبط برای نود‌های عادی
for i = 1:1:n
    if (S(i).type == 'N' && S(i).E > 0)
        if (cluster - 1 >= 1)
            min_dis = sqrt((S(i).xd - S(n + 1).xd)^2 + (S(i).yd - S(n + 1).yd)^2);
            min_dis_cluster = 1;
            for c = 1:1:cluster - 1
                temp = min(min_dis, sqrt((S(i).xd - C(c).xd)^2 + (S(i).yd - C(c).yd)^2));
                if (temp < min_dis)
                    min_dis = temp;
                    min_dis_cluster = c;
                end
            end

            % Energy dissipated by associated Cluster Head
            % انرژی مصرفی توسط سرگروه مرتبط
            min_dis;
            if (min_dis > do)
                S(i).E = S(i).E - (ETX * (4000) + Emp * 4000 * (min_dis^4)); 
            end
            if (min_dis <= do)
                S(i).E = S(i).E - (ETX * (4000) + Efs * 4000 * (min_dis^2)); 
            end
            % Energy dissipated
            % مصرف انرژی
            if (min_dis > 0)
                S(C(min_dis_cluster).id).E = S(C(min_dis_cluster).id).E - ((ERX + EDA) * 4000); 
                PACKETS_TO_CH(r + 1) = n - dead - cluster + 1; 
            end

            S(i).min_dis = min_dis;
            S(i).min_dis_cluster = min_dis_cluster;

        end
    end
end
hold on;

countCHs;
rcountCHs = rcountCHs + countCHs;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   STATISTICS    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                     %
%  DEAD  : a rmax x 1 array of number of dead nodes/round 			      %
%  DEAD_A : a rmax x 1 array of number of dead Advanced nodes/round	      	      %
%  DEAD_N : a rmax x 1 array of number of dead Normal nodes/round                     %
%  CLUSTERHS : a rmax x 1 array of number of Cluster Heads/round                      %
%  PACKETS_TO_BS : a rmax x 1 array of number packets send to Base Station/round      %
%  PACKETS_TO_CH : a rmax x 1 array of number of packets send to ClusterHeads/round   %
%  first_dead: the round where the first node died                                    %
%                                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






