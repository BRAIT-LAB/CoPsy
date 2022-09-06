clc;
clear all；
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_gamma_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_gamma_f.mat');
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_f.mat');
%isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_beta_m.mat');
%isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_beta_f.mat');
isc_m = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_delta_m.mat');
isc_f = load('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_delta_f.mat');
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
for i = 1:28   
    Y{1} = cat(1,chan_isc(:,1,i),chan_isc(:,2,i));
    Y{2} = chan_isc(:,3,i);
    Y{3} = chan_isc(:,4,i);
    Y{4} = chan_isc(:,5,i);
    Y{5} = chan_isc(:,6,i);
    Y{6} = chan_isc(:,7,i);
    Y{7} = chan_isc(:,8,i);
    Y{8} = chan_isc(:,9,i);
    Y{9} = chan_isc(:,10,i);
    figure;
    violin(Y);
    ylabel('ISC\_coherence')
    xticks([1 2 3 4 5 6 7 8 9])
    xticklabels({'静息态脑电信号','面对面外围层独白','面对面核心层独白',...
        '背对背外围层独白','背对背核心层独白','面对面外围层沟通',...
        '面对面核心层沟通','背对背外围层沟通','背对背核心层沟通'})
    xtickangle(45)
    %title(['Gamma频段下' channel{i} '电极对应的ISC\_coherence指标对比'])
    %title(['Alpha频段下' channel{i} '电极对应的ISC\_coherence指标对比'])
    %title(['Beta频段下' channel{i} '电极对应的ISC\_coherence指标对比'])
    title(['Delta频段下' channel{i} '电极对应的ISC\_coherence指标对比'])
    
    
    set(gcf,'unit','centimeters','position',[3 5 20 15])
    %path = ['C:\zhangzenan_data\code\results\gamma电极\Gamma频段下' channel{i} '电极对应的ISC_coherence指标对比'];
    %path = ['C:\zhangzenan_data\code\results\alpha电极\Alpha频段下' channel{i} '电极对应的ISC_coherence指标对比'];
    path = ['C:\zhangzenan_data\code\results\delta电极\Delta频段下' channel{i} '电极对应的ISC_coherence指标对比'];
    saveas(gcf,path,'jpg')
    close(gcf)
    
end