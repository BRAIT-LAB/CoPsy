clc;
clear all；
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_gamma_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_gamma_f.mat');
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_f.mat');
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_beta_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_beta_f.mat');
isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_theta_m.mat');
isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_theta_f.mat');
fields_m = fieldnames(isc_m); 
for i = 1:length(fields_m)
    sub_isc_m = getfield(isc_m,fields_m{i});
    for j = 1:28
        chan_isc_m(:,i,j) =  sub_isc_m(:,j);
    end
end

fields_f = fieldnames(isc_f);
for i = 1:length(fields_f)
    sub_isc_f = getfield(isc_f,fields_f{i});
    for j = 1:28
        chan_isc_f(:,i,j) =  sub_isc_f(:,j);
    end
end

%%
chan_isc = cat(1,chan_isc_m,chan_isc_f);
channel = {'Fp1','F3','F7','FC5','FC1','C3','T7','TP9','CP5','CP1','Pz',...
    'P3','P7','O1','O2','P4','P8','TP10','CP6','CP2','Cz','C4','T8','FC6',...
    'FC2','F4','F8','Fp2'};
%for i = 1:28   
    %Y{1} = cat(1,chan_isc(:,1,i),chan_isc(:,2,i));
    %Y{2} = chan_isc(:,3,i);
    %Y{3} = chan_isc(:,4,i);
    %Y{4} = chan_isc(:,5,i);
    %Y{5} = chan_isc(:,6,i);
    %Y{6} = chan_isc(:,7,i);
    %Y{7} = chan_isc(:,8,i);
    %Y{8} = chan_isc(:,9,i);
    %Y{9} = chan_isc(:,10,i);
    %figure;
    %violin(Y);
    %ylabel('ISC\_coherence')
    %xticks([1 2 3 4 5 6 7 8 9])
    %xticklabels({'静息态脑电信号','外围层面对面独白','核心层面对面独白',...
        %'外围层背对背独白','核心层背对背独白','外围层面对面沟通',...
        %'核心层面对面沟通','外围层背对背沟通','核心层背对背沟通'})
    %xtickangle(45)
    %title(['Gamma频段下电极-' channel{i} '对应的ISC\_coherence指标的小提琴图'])
    %set(gcf,'unit','centimeters','position',[3 5 20 15])
    %%path = ['G:\心理学系BBI\results\Gamma频段下电极-' channel{i} '对应的ISC_coherence指标的小提琴图'];
    %%saveas(gcf,path,'jpg')
    %close(gcf)
%end


%%
 mean_chan_isc_f = mean(chan_isc_f,3);
 mean_chan_isc_m = mean(chan_isc_m,3);

 figure(1);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,3);
 Y{2} = mean_chan_isc_f(:,3);
 violin(Y);
 title('面对面外围层独白')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
 
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,4);
 Y{2} = mean_chan_isc_f(:,4);
 violin(Y);
 title('面对面核心层独白')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
 %sgtitle('Delta频段外围层/核心层面对面独白下的ISC\_coherence指标')
 %sgtitle('Alpha频段外围层/核心层面对面独白下的ISC\_coherence指标')
 %sgtitle('Beta频段外围层/核心层面对面独白下的ISC\_coherence指标')
 sgtitle('Theta频段外围层/核心层面对面独白下的ISC\_coherence指标')
% 
 figure(2);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,5);
 Y{2} = mean_chan_isc_f(:,5);
 violin(Y);
 title('背对背外围层独白')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,6);
 Y{2} = mean_chan_isc_f(:,6);
 violin(Y);
 title('背对背核心层独白')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
 %sgtitle('Delta频段外围层/核心层背对背独白下的ISC\_coherence指标')
 %sgtitle('Alpha频段外围层/核心层背对背独白下的ISC\_coherence指标')
 %sgtitle('Beta频段外围层/核心层背对背独白下的ISC\_coherence指标')
 sgtitle('Theta频段外围层/核心层背对背独白下的ISC\_coherence指标')
 %sgtitle('Delta频段不同独白范式下的ISC\_coherence指标的小提琴图')
% 
 figure(3);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,7);
 Y{2} = mean_chan_isc_f(:,7);
 violin(Y);
 title('面对面外围层沟通')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,8);
 Y{2} = mean_chan_isc_f(:,8);
 violin(Y);
 title('面对面核心层沟通')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
 %sgtitle('Delta频段外围层/核心层面对面沟通下的ISC\_coherence指标')
 %sgtitle('Alpha频段外围层/核心层面对面沟通下的ISC\_coherence指标')
 %sgtitle('Beta频段外围层/核心层面对面沟通下的ISC\_coherence指标')
 sgtitle('Theta频段外围层/核心层面对面沟通下的ISC\_coherence指标')
% 
 figure(4);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,9);
 Y{2} = mean_chan_isc_f(:,9);
 violin(Y);
 title('背对背外围层沟通')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,10);
 Y{2} = mean_chan_isc_f(:,10);
 violin(Y);
 title('背对背核心层沟通')
 ylabel('ISC\_coherence')
 xlabel('性别')
 xticks([1 2])
 xticklabels({'男','女'})
 %sgtitle('Delta频段外围层/核心层背对背沟通下的ISC\_coherence指标')
 %sgtitle('Alpha频段外围层/核心层背对背沟通下的ISC\_coherence指标')
 %sgtitle('Beta频段外围层/核心层背对背沟通下的ISC\_coherence指标')
 sgtitle('Theta频段外围层/核心层背对背沟通下的ISC\_coherence指标')
 %sgtitle('Delta频段不同沟通范式下的ISC\_coherence指标的小提琴图')