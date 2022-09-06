clc;
clear all��
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
    %xticklabels({'��Ϣ̬�Ե��ź�','��Χ����������','���Ĳ���������',...
        %'��Χ�㱳�Ա�����','���Ĳ㱳�Ա�����','��Χ������湵ͨ',...
        %'���Ĳ�����湵ͨ','��Χ�㱳�Ա���ͨ','���Ĳ㱳�Ա���ͨ'})
    %xtickangle(45)
    %title(['GammaƵ���µ缫-' channel{i} '��Ӧ��ISC\_coherenceָ���С����ͼ'])
    %set(gcf,'unit','centimeters','position',[3 5 20 15])
    %%path = ['G:\����ѧϵBBI\results\GammaƵ���µ缫-' channel{i} '��Ӧ��ISC_coherenceָ���С����ͼ'];
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
 title('�������Χ�����')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
 
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,4);
 Y{2} = mean_chan_isc_f(:,4);
 violin(Y);
 title('�������Ĳ����')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
 %sgtitle('DeltaƵ����Χ��/���Ĳ����������µ�ISC\_coherenceָ��')
 %sgtitle('AlphaƵ����Χ��/���Ĳ����������µ�ISC\_coherenceָ��')
 %sgtitle('BetaƵ����Χ��/���Ĳ����������µ�ISC\_coherenceָ��')
 sgtitle('ThetaƵ����Χ��/���Ĳ����������µ�ISC\_coherenceָ��')
% 
 figure(2);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,5);
 Y{2} = mean_chan_isc_f(:,5);
 violin(Y);
 title('���Ա���Χ�����')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,6);
 Y{2} = mean_chan_isc_f(:,6);
 violin(Y);
 title('���Ա����Ĳ����')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
 %sgtitle('DeltaƵ����Χ��/���Ĳ㱳�Ա������µ�ISC\_coherenceָ��')
 %sgtitle('AlphaƵ����Χ��/���Ĳ㱳�Ա������µ�ISC\_coherenceָ��')
 %sgtitle('BetaƵ����Χ��/���Ĳ㱳�Ա������µ�ISC\_coherenceָ��')
 sgtitle('ThetaƵ����Χ��/���Ĳ㱳�Ա������µ�ISC\_coherenceָ��')
 %sgtitle('DeltaƵ�β�ͬ���׷�ʽ�µ�ISC\_coherenceָ���С����ͼ')
% 
 figure(3);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,7);
 Y{2} = mean_chan_isc_f(:,7);
 violin(Y);
 title('�������Χ�㹵ͨ')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,8);
 Y{2} = mean_chan_isc_f(:,8);
 violin(Y);
 title('�������Ĳ㹵ͨ')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
 %sgtitle('DeltaƵ����Χ��/���Ĳ�����湵ͨ�µ�ISC\_coherenceָ��')
 %sgtitle('AlphaƵ����Χ��/���Ĳ�����湵ͨ�µ�ISC\_coherenceָ��')
 %sgtitle('BetaƵ����Χ��/���Ĳ�����湵ͨ�µ�ISC\_coherenceָ��')
 sgtitle('ThetaƵ����Χ��/���Ĳ�����湵ͨ�µ�ISC\_coherenceָ��')
% 
 figure(4);
 subplot(1,2,1)
 Y{1} = mean_chan_isc_m(:,9);
 Y{2} = mean_chan_isc_f(:,9);
 violin(Y);
 title('���Ա���Χ�㹵ͨ')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
% 

 subplot(1,2,2)
 Y{1} = mean_chan_isc_m(:,10);
 Y{2} = mean_chan_isc_f(:,10);
 violin(Y);
 title('���Ա����Ĳ㹵ͨ')
 ylabel('ISC\_coherence')
 xlabel('�Ա�')
 xticks([1 2])
 xticklabels({'��','Ů'})
 %sgtitle('DeltaƵ����Χ��/���Ĳ㱳�Ա���ͨ�µ�ISC\_coherenceָ��')
 %sgtitle('AlphaƵ����Χ��/���Ĳ㱳�Ա���ͨ�µ�ISC\_coherenceָ��')
 %sgtitle('BetaƵ����Χ��/���Ĳ㱳�Ա���ͨ�µ�ISC\_coherenceָ��')
 sgtitle('ThetaƵ����Χ��/���Ĳ㱳�Ա���ͨ�µ�ISC\_coherenceָ��')
 %sgtitle('DeltaƵ�β�ͬ��ͨ��ʽ�µ�ISC\_coherenceָ���С����ͼ')