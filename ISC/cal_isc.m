clc;
clear all；

path = 'C:\zhangzenan_data\Experiment Form';
addpath(path);
folder = dir(fullfile(path));
folder = {folder.name};
channel = {'Fp1','F3','F7','FC5','FC1','C3','T7','TP9','CP5','CP1','Pz',...
    'P3','P7','O1','O2','P4','P8','TP10','CP6','CP2','Cz','C4','T8','FC6',...
    'FC2','F4','F8','Fp2'};
locfile = 'C:\zhangzenan_data\Talk\ISC code\ele\BioSemi28.loc';
comp_no = (1:1:28);
% Fbp1 = 8; Fbp2 = 13;   % 带通滤波
%% 独白基线
for i = 3:10        % # of forms
    folderpath = [path '\' folder{i}];
    subfolder = dir(fullfile(folderpath));
    subfolder = {subfolder.name};
    for m = 3:12        % # of states
        folder_base = [folderpath '\' subfolder{m}];
        file = dir(fullfile(folder_base,'*set'));
        filename = {file.name};
        for j = 1:length(filename)/2    % # of couples
            % 男生基线
            EEG_M = pop_loadset(filename{2*j-1},folder_base);
            EEG_M = pop_select(EEG_M,'channel',channel);
            % 去除50Hz工频干扰
            EEG_M = pop_eegfilt(EEG_M,49,51,[],1,1);
%             % 0-75Hz滤波
%             EEG_M = pop_eegfilt(EEG_M,0,75,[],[],1);
            % 重参考
            EEG_M = pop_reref(EEG_M,[]);
            % ICA 去除伪迹
            EEG_M = pop_runica(EEG_M,'icatype','runica');
            [kurt,rej_no] = rejkurt(EEG_M.icaact,1.64,[],1);
            rej_comp = comp_no(rej_no);
            EEG_M = pop_subcomp(EEG_M,rej_comp);
            % 带通滤波
            EEG_M_delta = pop_eegfilt(EEG_M,1,3,[],[],1);
            EEG_M_theta = pop_eegfilt(EEG_M,4,7,[],[],1);
            EEG_M_alpha = pop_eegfilt(EEG_M,8,12,[],[],1);
            EEG_M_beta = pop_eegfilt(EEG_M,13,30,[],[],1);
            EEG_M_gamma = pop_eegfilt(EEG_M,31,49,[],[],1);
            
            % 女生基线
            EEG_W = pop_loadset(filename{2*j},folder_base);
            EEG_W = pop_select(EEG_W,'channel',channel);
            % 去除50Hz工频干扰
            EEG_W = pop_eegfilt(EEG_W,49,51,[],1,1);
            % 重参考
            EEG_W = pop_reref(EEG_W,[]);
%             % 0-75Hz滤波
%             EEG_W = pop_eegfilt(EEG_W,0,75,[],[],1);
            % ICA 去除伪迹
            EEG_W = pop_runica(EEG_W,'icatype','runica');
            [kurt,rej_no] = rejkurt(EEG_W.icaact,1.64,[],1);
            rej_comp = comp_no(rej_no);
            EEG_W = pop_subcomp(EEG_W,rej_comp);
            % 带通滤波
            EEG_W_delta = pop_eegfilt(EEG_W,1,3,[],[],1);
            EEG_W_theta = pop_eegfilt(EEG_W,4,7,[],[],1);
            EEG_W_alpha = pop_eegfilt(EEG_W,8,12,[],[],1);
            EEG_W_beta = pop_eegfilt(EEG_W,13,30,[],[],1);
            EEG_W_gamma = pop_eegfilt(EEG_W,31,49,[],[],1);
            
            % 判断两组脑电信号的电极顺序是否一致
            Locs_M = {EEG_M.chanlocs.labels};
            Locs_W = {EEG_W.chanlocs.labels};
            [~,~,idx_M] = intersect(channel,Locs_M);
            [~,~,idx_W] = intersect(channel,Locs_W);
            clear EEG_M EEG_W
            %% alpha频段
            DATA_M_alpha = double(EEG_M_alpha.data');
            DATA_W_alpha = double(EEG_W_alpha.data');
            DATA_M_alpha = DATA_M_alpha(:,idx_M);
            DATA_W_alpha = DATA_W_alpha(:,idx_W);
            s1 = size(DATA_M_alpha,1);
            s2 = size(DATA_W_alpha,1);
            min_s = min(s1,s2);
            DATA_M_alpha = DATA_M_alpha(s1-min_s+1:s1,:);
            DATA_W_alpha = DATA_W_alpha(s2-min_s+1:s2,:);
            
            DATA_alpha = cat(3,DATA_M_alpha,DATA_W_alpha);
            EEGData_alpha.X = DATA_alpha;
            EEGData_alpha.fs = 250;
            EEGData_alpha.badchannels = {};
            EEGData_alpha.eogchannels = [];            
            save('C:\zhangzenan_data\code\ISC code\EEGData_alpha','-struct','EEGData_alpha')
            clear EEG_M_alpha DATA_M_alpha DATA_W_alpha DATA_alpha EEGData_alpha 
            
            datafile = 'C:\zhangzenan_data\code\ISC code\EEGData_alpha.mat';
            gamma = 0.4;
            Nsec = 1;
            plotfig = 0;
            [ISC_alpha,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec,plotfig);
            ISC_alpha_all(i-2,j,m-2,:) = ISC_alpha(1);
%             ISC_persecond_alpha_all(i-2,j,m-2,:) = ISC_persecond_alpha(1,:);
%             A_alpha_all(i-2,j,m-2,:) = A_alpha(1,:);          
            
            %% beta频段
            DATA_M_beta = double(EEG_M_beta.data');
            DATA_W_beta = double(EEG_W_beta.data');
            DATA_M_beta = DATA_M_beta(:,idx_M);
            DATA_W_beta = DATA_W_beta(:,idx_W);
            s1 = size(DATA_M_beta,1);
            s2 = size(DATA_W_beta,1);
            min_s = min(s1,s2);
            DATA_M_beta = DATA_M_beta(s1-min_s+1:s1,:);
            DATA_W_beta = DATA_W_beta(s2-min_s+1:s2,:);
            
            DATA_beta = cat(3,DATA_M_beta,DATA_W_beta);
            EEGData_beta.X = DATA_beta;
            EEGData_beta.fs = 250;
            EEGData_beta.badchannels = {};
            EEGData_beta.eogchannels = [];
            save('C:\zhangzenan_data\code\ISC code\EEGData_beta','-struct','EEGData_beta')
            clear EEG_M_beta DATA_M_beta DATA_W_beta DATA_beta EEGData_beta 
            
            datafile = 'C:\zhangzenan_data\code\ISC code\EEGData_beta.mat';
            gamma = 0.4;
            Nsec = 1;
            plotfig = 0;
            [ISC_beta,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec,plotfig);
            ISC_beta_all(i-2,j,m-2,:) = ISC_beta(1);
%             ISC_persecond_beta_all(i-2,j,m-2,:) = ISC_persecond_beta(1,:);
%             A_beta_all(i-2,j,m-2,:) = A_beta(1,:);
            
            %% delta频段
            DATA_M_delta = double(EEG_M_delta.data');
            DATA_W_delta = double(EEG_W_delta.data');
            DATA_M_delta = DATA_M_delta(:,idx_M);
            DATA_W_delta = DATA_W_delta(:,idx_W);
            s1 = size(DATA_M_delta,1);
            s2 = size(DATA_W_delta,1);
            min_s = min(s1,s2);
            DATA_M_delta = DATA_M_delta(s1-min_s+1:s1,:);
            DATA_W_delta = DATA_W_delta(s2-min_s+1:s2,:);
            
            DATA_delta = cat(3,DATA_M_delta,DATA_W_delta);
            EEGData_delta.X = DATA_delta;
            EEGData_delta.fs = 250;
            EEGData_delta.badchannels = {};
            EEGData_delta.eogchannels = [];
            save('C:\zhangzenan_data\code\ISC code\EEGData_delta','-struct','EEGData_delta')
            clear EEG_M_delta DATA_M_delta DATA_W_delta DATA_delta EEGData_delta 
            
            datafile = 'C:\zhangzenan_data\code\ISC code\EEGData_delta.mat';
            gamma = 0.4;
            Nsec = 1;
            plotfig = 0;
            [ISC_delta,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec,plotfig);
            ISC_delta_all(i-2,j,m-2,:) = ISC_delta(1);
%             ISC_persecond_delta_all(i-2,j,m-2,:) = ISC_persecond_delta(1,:);
%             A_delta_all(i-2,j,m-2,:) = A_delta(1,:);
            
            %% gamma频段
            DATA_M_gamma = double(EEG_M_gamma.data');
            DATA_W_gamma = double(EEG_W_gamma.data');
            DATA_M_gamma = DATA_M_gamma(:,idx_M);
            DATA_W_gamma = DATA_W_gamma(:,idx_W);
            s1 = size(DATA_M_gamma,1);
            s2 = size(DATA_W_gamma,1);
            min_s = min(s1,s2);
            DATA_M_gamma = DATA_M_gamma(s1-min_s+1:s1,:);
            DATA_W_gamma = DATA_W_gamma(s2-min_s+1:s2,:);
            
            DATA_gamma = cat(3,DATA_M_gamma,DATA_W_gamma);
            EEGData_gamma.X = DATA_gamma;
            EEGData_gamma.fs = 250;
            EEGData_gamma.badchannels = {};
            EEGData_gamma.eogchannels = [];
            save('C:\zhangzenan_data\code\ISC code\EEGData_gamma','-struct','EEGData_gamma')
            clear EEG_M_gamma DATA_M_gamma DATA_W_gamma DATA_gamma EEGData_gamma
            
            datafile = 'C:\zhangzenan_data\code\ISC code\EEGData_gamma.mat';
            gamma = 0.4;
            Nsec = 1;
            plotfig = 0;
            [ISC_gamma,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec,plotfig);
            ISC_gamma_all(i-2,j,m-2,:) = ISC_gamma(1);
%             ISC_persecond_gamma_all(i-2,j,m-2,:) = ISC_persecond_gamma(1,:);
%             A_gamma_all(i-2,j,m-2,:) = A_gamma(1,:);
             
            %% theta频段
            DATA_M_theta = double(EEG_M_theta.data');
            DATA_W_theta = double(EEG_W_theta.data');
            DATA_M_theta = DATA_M_theta(:,idx_M);
            DATA_W_theta = DATA_W_theta(:,idx_W);
            s1 = size(DATA_M_theta,1);
            s2 = size(DATA_W_theta,1);
            min_s = min(s1,s2);
            DATA_M_theta = DATA_M_theta(s1-min_s+1:s1,:);
            DATA_W_theta = DATA_W_theta(s2-min_s+1:s2,:);
            
            DATA_theta = cat(3,DATA_M_theta,DATA_W_theta);
            EEGData_theta.X = DATA_theta;
            EEGData_theta.fs = 250;
            EEGData_theta.badchannels = {};
            EEGData_theta.eogchannels = [];
            save('C:\zhangzenan_data\code\ISC code\EEGData_theta','-struct','EEGData_theta')
            clear EEG_M_theta DATA_M_theta DATA_W_theta DATA_theta EEGData_theta 
            
            datafile = 'C:\zhangzenan_data\code\ISC code\EEGData_theta.mat';
            gamma = 0.4;
            Nsec = 1;
            plotfig = 0;
            [ISC_theta,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec,plotfig);
            ISC_theta_all(i-2,j,m-2,:) = ISC_theta(1);
%             ISC_persecond_theta_all(i-2,j,m-2,:) = ISC_persecond_theta(1,:);
%             A_theta_all(i-2,j,m-2,:) = A_theta(1,:);
            
        end
    end
end

% %% alpha频段
isc_coh_alpha.form1.sub01 = squeeze(ch_isc12_alpha(1,1,:,:));
isc_coh_alpha.form1.sub09 = squeeze(ch_isc12_alpha(1,2,:,:));
isc_coh_alpha.form1.sub17 = squeeze(ch_isc12_alpha(1,3,:,:));
isc_coh_alpha.form1.sub25 = squeeze(ch_isc12_alpha(1,4,:,:));
isc_coh_alpha.form1.sub33 = squeeze(ch_isc12_alpha(1,5,:,:));
% 
isc_coh_alpha.form2.sub02 = squeeze(ch_isc12_alpha(2,1,:,:));
isc_coh_alpha.form2.sub10 = squeeze(ch_isc12_alpha(2,2,:,:));
isc_coh_alpha.form2.sub18 = squeeze(ch_isc12_alpha(2,3,:,:));
isc_coh_alpha.form2.sub34 = squeeze(ch_isc12_alpha(2,4,:,:));
isc_coh_alpha.form2.sub33 = squeeze(ch_isc12_alpha(2,5,:,:));
% 
isc_coh_alpha.form3.sub02 = squeeze(ch_isc12_alpha(3,1,:,:));
isc_coh_alpha.form3.sub11 = squeeze(ch_isc12_alpha(3,2,:,:));
isc_coh_alpha.form3.sub27 = squeeze(ch_isc12_alpha(3,3,:,:));
isc_coh_alpha.form3.sub35 = squeeze(ch_isc12_alpha(3,4,:,:));
isc_coh_alpha.form3.sub33 = squeeze(ch_isc12_alpha(3,5,:,:));
% 
isc_coh_alpha.form4.sub12 = squeeze(ch_isc12_alpha(4,1,:,:));
isc_coh_alpha.form4.sub36 = squeeze(ch_isc12_alpha(4,2,:,:));
isc_coh_alpha.form4.sub17 = squeeze(ch_isc12_alpha(4,3,:,:));
isc_coh_alpha.form4.sub25 = squeeze(ch_isc12_alpha(4,4,:,:));
isc_coh_alpha.form4.sub33 = squeeze(ch_isc12_alpha(4,5,:,:));
% 
isc_coh_alpha.form5.sub05 = squeeze(ch_isc12_alpha(5,1,:,:));
isc_coh_alpha.form5.sub13 = squeeze(ch_isc12_alpha(5,2,:,:));
isc_coh_alpha.form5.sub21 = squeeze(ch_isc12_alpha(5,3,:,:));
isc_coh_alpha.form5.sub29 = squeeze(ch_isc12_alpha(5,4,:,:));
isc_coh_alpha.form5.sub37 = squeeze(ch_isc12_alpha(5,5,:,:));
% 
isc_coh_alpha.form6.sub06 = squeeze(ch_isc12_alpha(6,1,:,:));
isc_coh_alpha.form6.sub22 = squeeze(ch_isc12_alpha(6,2,:,:));
isc_coh_alpha.form6.sub30 = squeeze(ch_isc12_alpha(6,3,:,:));
isc_coh_alpha.form6.sub38 = squeeze(ch_isc12_alpha(6,4,:,:));
isc_coh_alpha.form6.sub33 = squeeze(ch_isc12_alpha(6,5,:,:));
% 
isc_coh_alpha.form7.sub15 = squeeze(ch_isc12_alpha(7,1,:,:));
isc_coh_alpha.form7.sub31 = squeeze(ch_isc12_alpha(7,2,:,:));
isc_coh_alpha.form7.sub17 = squeeze(ch_isc12_alpha(7,3,:,:));
isc_coh_alpha.form7.sub25 = squeeze(ch_isc12_alpha(7,4,:,:));
isc_coh_alpha.form7.sub33 = squeeze(ch_isc12_alpha(7,5,:,:));
% 
isc_coh_alpha.form8.sub08 = squeeze(ch_isc12_alpha(8,1,:,:));
isc_coh_alpha.form8.sub16 = squeeze(ch_isc12_alpha(8,2,:,:));
isc_coh_alpha.form8.sub24 = squeeze(ch_isc12_alpha(8,3,:,:));
isc_coh_alpha.form8.sub32 = squeeze(ch_isc12_alpha(8,4,:,:));
isc_coh_alpha.form8.sub33 = squeeze(ch_isc12_alpha(8,5,:,:));
% 
% %% beta频段
isc_coh_beta.form1.sub01 = squeeze(ch_isc12_beta(1,1,:,:));
isc_coh_beta.form1.sub09 = squeeze(ch_isc12_beta(1,2,:,:));
isc_coh_beta.form1.sub17 = squeeze(ch_isc12_beta(1,3,:,:));
isc_coh_beta.form1.sub25 = squeeze(ch_isc12_beta(1,4,:,:));
isc_coh_beta.form1.sub33 = squeeze(ch_isc12_beta(1,5,:,:));
% 
isc_coh_beta.form2.sub02 = squeeze(ch_isc12_beta(2,1,:,:));
isc_coh_beta.form2.sub10 = squeeze(ch_isc12_beta(2,2,:,:));
isc_coh_beta.form2.sub18 = squeeze(ch_isc12_beta(2,3,:,:));
isc_coh_beta.form2.sub34 = squeeze(ch_isc12_beta(2,4,:,:));
isc_coh_beta.form2.sub33 = squeeze(ch_isc12_beta(2,5,:,:));
% 
isc_coh_beta.form3.sub02 = squeeze(ch_isc12_beta(3,1,:,:));
isc_coh_beta.form3.sub11 = squeeze(ch_isc12_beta(3,2,:,:));
isc_coh_beta.form3.sub27 = squeeze(ch_isc12_beta(3,3,:,:));
isc_coh_beta.form3.sub35 = squeeze(ch_isc12_beta(3,4,:,:));
isc_coh_beta.form3.sub33 = squeeze(ch_isc12_beta(3,5,:,:));
% 
isc_coh_beta.form4.sub12 = squeeze(ch_isc12_beta(4,1,:,:));
isc_coh_beta.form4.sub36 = squeeze(ch_isc12_beta(4,2,:,:));
isc_coh_beta.form4.sub17 = squeeze(ch_isc12_beta(4,3,:,:));
isc_coh_beta.form4.sub25 = squeeze(ch_isc12_beta(4,4,:,:));
isc_coh_beta.form4.sub33 = squeeze(ch_isc12_beta(4,5,:,:));
% 
isc_coh_beta.form5.sub05 = squeeze(ch_isc12_beta(5,1,:,:));
isc_coh_beta.form5.sub13 = squeeze(ch_isc12_beta(5,2,:,:));
isc_coh_beta.form5.sub21 = squeeze(ch_isc12_beta(5,3,:,:));
isc_coh_beta.form5.sub29 = squeeze(ch_isc12_beta(5,4,:,:));
isc_coh_beta.form5.sub37 = squeeze(ch_isc12_beta(5,5,:,:));
% 
isc_coh_beta.form6.sub06 = squeeze(ch_isc12_beta(6,1,:,:));
isc_coh_beta.form6.sub22 = squeeze(ch_isc12_beta(6,2,:,:));
isc_coh_beta.form6.sub30 = squeeze(ch_isc12_beta(6,3,:,:));
isc_coh_beta.form6.sub38 = squeeze(ch_isc12_beta(6,4,:,:));
isc_coh_beta.form6.sub33 = squeeze(ch_isc12_beta(6,5,:,:));
% 
isc_coh_beta.form7.sub15 = squeeze(ch_isc12_beta(7,1,:,:));
isc_coh_beta.form7.sub31 = squeeze(ch_isc12_beta(7,2,:,:));
isc_coh_beta.form7.sub17 = squeeze(ch_isc12_beta(7,3,:,:));
isc_coh_beta.form7.sub25 = squeeze(ch_isc12_beta(7,4,:,:));
isc_coh_beta.form7.sub33 = squeeze(ch_isc12_beta(7,5,:,:));
% 
isc_coh_beta.form8.sub08 = squeeze(ch_isc12_beta(8,1,:,:));
isc_coh_beta.form8.sub16 = squeeze(ch_isc12_beta(8,2,:,:));
isc_coh_beta.form8.sub24 = squeeze(ch_isc12_beta(8,3,:,:));
isc_coh_beta.form8.sub32 = squeeze(ch_isc12_beta(8,4,:,:));
isc_coh_beta.form8.sub33 = squeeze(ch_isc12_beta(8,5,:,:));
% 
% 
% %% delta频段
isc_coh_delta.form1.sub01 = squeeze(ch_isc12_delta(1,1,:,:));
isc_coh_delta.form1.sub09 = squeeze(ch_isc12_delta(1,2,:,:));
isc_coh_delta.form1.sub17 = squeeze(ch_isc12_delta(1,3,:,:));
isc_coh_delta.form1.sub25 = squeeze(ch_isc12_delta(1,4,:,:));
isc_coh_delta.form1.sub33 = squeeze(ch_isc12_delta(1,5,:,:));
% 
isc_coh_delta.form2.sub02 = squeeze(ch_isc12_delta(2,1,:,:));
isc_coh_delta.form2.sub10 = squeeze(ch_isc12_delta(2,2,:,:));
isc_coh_delta.form2.sub18 = squeeze(ch_isc12_delta(2,3,:,:));
isc_coh_delta.form2.sub34 = squeeze(ch_isc12_delta(2,4,:,:));
isc_coh_delta.form2.sub33 = squeeze(ch_isc12_delta(2,5,:,:));
% 
isc_coh_delta.form3.sub02 = squeeze(ch_isc12_delta(3,1,:,:));
isc_coh_delta.form3.sub11 = squeeze(ch_isc12_delta(3,2,:,:));
isc_coh_delta.form3.sub27 = squeeze(ch_isc12_delta(3,3,:,:));
isc_coh_delta.form3.sub35 = squeeze(ch_isc12_delta(3,4,:,:));
isc_coh_delta.form3.sub33 = squeeze(ch_isc12_delta(3,5,:,:));
% 
isc_coh_delta.form4.sub12 = squeeze(ch_isc12_delta(4,1,:,:));
isc_coh_delta.form4.sub36 = squeeze(ch_isc12_delta(4,2,:,:));
isc_coh_delta.form4.sub17 = squeeze(ch_isc12_delta(4,3,:,:));
isc_coh_delta.form4.sub25 = squeeze(ch_isc12_delta(4,4,:,:));
isc_coh_delta.form4.sub33 = squeeze(ch_isc12_delta(4,5,:,:));
% 
isc_coh_delta.form5.sub05 = squeeze(ch_isc12_delta(5,1,:,:));
isc_coh_delta.form5.sub13 = squeeze(ch_isc12_delta(5,2,:,:));
isc_coh_delta.form5.sub21 = squeeze(ch_isc12_delta(5,3,:,:));
isc_coh_delta.form5.sub29 = squeeze(ch_isc12_delta(5,4,:,:));
isc_coh_delta.form5.sub37 = squeeze(ch_isc12_delta(5,5,:,:));
% 
isc_coh_delta.form6.sub06 = squeeze(ch_isc12_delta(6,1,:,:));
isc_coh_delta.form6.sub22 = squeeze(ch_isc12_delta(6,2,:,:));
isc_coh_delta.form6.sub30 = squeeze(ch_isc12_delta(6,3,:,:));
isc_coh_delta.form6.sub38 = squeeze(ch_isc12_delta(6,4,:,:));
isc_coh_delta.form6.sub33 = squeeze(ch_isc12_delta(6,5,:,:));
% 
isc_coh_delta.form7.sub15 = squeeze(ch_isc12_delta(7,1,:,:));
isc_coh_delta.form7.sub31 = squeeze(ch_isc12_delta(7,2,:,:));
isc_coh_delta.form7.sub17 = squeeze(ch_isc12_delta(7,3,:,:));
isc_coh_delta.form7.sub25 = squeeze(ch_isc12_delta(7,4,:,:));
isc_coh_delta.form7.sub33 = squeeze(ch_isc12_delta(7,5,:,:));
% 
isc_coh_delta.form8.sub08 = squeeze(ch_isc12_delta(8,1,:,:));
isc_coh_delta.form8.sub16 = squeeze(ch_isc12_delta(8,2,:,:));
isc_coh_delta.form8.sub24 = squeeze(ch_isc12_delta(8,3,:,:));
isc_coh_delta.form8.sub32 = squeeze(ch_isc12_delta(8,4,:,:));
isc_coh_delta.form8.sub33 = squeeze(ch_isc12_delta(8,5,:,:));
% 
% 
% %% gamma频段
isc_coh_gamma.form1.sub01 = squeeze(ch_isc12_gamma(1,1,:,:));
isc_coh_gamma.form1.sub09 = squeeze(ch_isc12_gamma(1,2,:,:));
isc_coh_gamma.form1.sub17 = squeeze(ch_isc12_gamma(1,3,:,:));
isc_coh_gamma.form1.sub25 = squeeze(ch_isc12_gamma(1,4,:,:));
isc_coh_gamma.form1.sub33 = squeeze(ch_isc12_gamma(1,5,:,:));
% 
isc_coh_gamma.form2.sub02 = squeeze(ch_isc12_gamma(2,1,:,:));
isc_coh_gamma.form2.sub10 = squeeze(ch_isc12_gamma(2,2,:,:));
isc_coh_gamma.form2.sub18 = squeeze(ch_isc12_gamma(2,3,:,:));
isc_coh_gamma.form2.sub34 = squeeze(ch_isc12_gamma(2,4,:,:));
isc_coh_gamma.form2.sub33 = squeeze(ch_isc12_gamma(2,5,:,:));
% 
isc_coh_gamma.form3.sub02 = squeeze(ch_isc12_gamma(3,1,:,:));
isc_coh_gamma.form3.sub11 = squeeze(ch_isc12_gamma(3,2,:,:));
isc_coh_gamma.form3.sub27 = squeeze(ch_isc12_gamma(3,3,:,:));
isc_coh_gamma.form3.sub35 = squeeze(ch_isc12_gamma(3,4,:,:));
isc_coh_gamma.form3.sub33 = squeeze(ch_isc12_gamma(3,5,:,:));
% 
isc_coh_gamma.form4.sub12 = squeeze(ch_isc12_gamma(4,1,:,:));
isc_coh_gamma.form4.sub36 = squeeze(ch_isc12_gamma(4,2,:,:));
isc_coh_gamma.form4.sub17 = squeeze(ch_isc12_gamma(4,3,:,:));
isc_coh_gamma.form4.sub25 = squeeze(ch_isc12_gamma(4,4,:,:));
isc_coh_gamma.form4.sub33 = squeeze(ch_isc12_gamma(4,5,:,:));
% 
isc_coh_gamma.form5.sub05 = squeeze(ch_isc12_gamma(5,1,:,:));
isc_coh_gamma.form5.sub13 = squeeze(ch_isc12_gamma(5,2,:,:));
isc_coh_gamma.form5.sub21 = squeeze(ch_isc12_gamma(5,3,:,:));
isc_coh_gamma.form5.sub29 = squeeze(ch_isc12_gamma(5,4,:,:));
isc_coh_gamma.form5.sub37 = squeeze(ch_isc12_gamma(5,5,:,:));
% 
isc_coh_gamma.form6.sub06 = squeeze(ch_isc12_gamma(6,1,:,:));
isc_coh_gamma.form6.sub22 = squeeze(ch_isc12_gamma(6,2,:,:));
isc_coh_gamma.form6.sub30 = squeeze(ch_isc12_gamma(6,3,:,:));
isc_coh_gamma.form6.sub38 = squeeze(ch_isc12_gamma(6,4,:,:));
isc_coh_gamma.form6.sub33 = squeeze(ch_isc12_gamma(6,5,:,:));
% 
isc_coh_gamma.form7.sub15 = squeeze(ch_isc12_gamma(7,1,:,:));
isc_coh_gamma.form7.sub31 = squeeze(ch_isc12_gamma(7,2,:,:));
isc_coh_gamma.form7.sub17 = squeeze(ch_isc12_gamma(7,3,:,:));
isc_coh_gamma.form7.sub25 = squeeze(ch_isc12_gamma(7,4,:,:));
isc_coh_gamma.form7.sub33 = squeeze(ch_isc12_gamma(7,5,:,:));
% 
isc_coh_gamma.form8.sub08 = squeeze(ch_isc12_gamma(8,1,:,:));
isc_coh_gamma.form8.sub16 = squeeze(ch_isc12_gamma(8,2,:,:));
isc_coh_gamma.form8.sub24 = squeeze(ch_isc12_gamma(8,3,:,:));
isc_coh_gamma.form8.sub32 = squeeze(ch_isc12_gamma(8,4,:,:));
isc_coh_gamma.form8.sub33 = squeeze(ch_isc12_gamma(8,5,:,:));
% 
% 
% %% theta频段
isc_coh_theta.form1.sub01 = squeeze(ch_isc12_theta(1,1,:,:));
isc_coh_theta.form1.sub09 = squeeze(ch_isc12_theta(1,2,:,:));
isc_coh_theta.form1.sub17 = squeeze(ch_isc12_theta(1,3,:,:));
isc_coh_theta.form1.sub25 = squeeze(ch_isc12_theta(1,4,:,:));
isc_coh_theta.form1.sub33 = squeeze(ch_isc12_theta(1,5,:,:));
% 
isc_coh_theta.form2.sub02 = squeeze(ch_isc12_theta(2,1,:,:));
isc_coh_theta.form2.sub10 = squeeze(ch_isc12_theta(2,2,:,:));
isc_coh_theta.form2.sub18 = squeeze(ch_isc12_theta(2,3,:,:));
isc_coh_theta.form2.sub32 = squeeze(ch_isc12_theta(2,4,:,:));
isc_coh_theta.form2.sub33 = squeeze(ch_isc12_theta(2,5,:,:));
% 
isc_coh_theta.form3.sub03 = squeeze(ch_isc12_theta(3,1,:,:));
isc_coh_theta.form3.sub11 = squeeze(ch_isc12_theta(3,2,:,:));
isc_coh_theta.form3.sub27 = squeeze(ch_isc12_theta(3,3,:,:));
isc_coh_theta.form3.sub35 = squeeze(ch_isc12_theta(3,4,:,:));
isc_coh_theta.form3.sub33 = squeeze(ch_isc12_theta(3,5,:,:));
% 
isc_coh_theta.form4.sub12 = squeeze(ch_isc12_theta(4,1,:,:));
isc_coh_theta.form4.sub36 = squeeze(ch_isc12_theta(4,2,:,:));
isc_coh_theta.form4.sub17 = squeeze(ch_isc12_theta(4,3,:,:));
isc_coh_theta.form4.sub25 = squeeze(ch_isc12_theta(4,4,:,:));
isc_coh_theta.form4.sub33 = squeeze(ch_isc12_theta(4,5,:,:));
% 
isc_coh_theta.form5.sub05 = squeeze(ch_isc12_theta(5,1,:,:));
isc_coh_theta.form5.sub13 = squeeze(ch_isc12_theta(5,2,:,:));
isc_coh_theta.form5.sub21 = squeeze(ch_isc12_theta(5,3,:,:));
isc_coh_theta.form5.sub29 = squeeze(ch_isc12_theta(5,4,:,:));
isc_coh_theta.form5.sub37 = squeeze(ch_isc12_theta(5,5,:,:));
% 
isc_coh_theta.form6.sub06 = squeeze(ch_isc12_theta(6,1,:,:));
isc_coh_theta.form6.sub22 = squeeze(ch_isc12_theta(6,2,:,:));
isc_coh_theta.form6.sub30 = squeeze(ch_isc12_theta(6,3,:,:));
isc_coh_theta.form6.sub38 = squeeze(ch_isc12_theta(6,4,:,:));
isc_coh_theta.form6.sub33 = squeeze(ch_isc12_theta(6,5,:,:));
% 
isc_coh_theta.form7.sub15 = squeeze(ch_isc12_theta(7,1,:,:));
isc_coh_theta.form7.sub31 = squeeze(ch_isc12_theta(7,2,:,:));
isc_coh_theta.form7.sub17 = squeeze(ch_isc12_theta(7,3,:,:));
isc_coh_theta.form7.sub25 = squeeze(ch_isc12_theta(7,4,:,:));
isc_coh_theta.form7.sub33 = squeeze(ch_isc12_theta(7,5,:,:));
% 
isc_coh_theta.form8.sub08 = squeeze(ch_isc12_theta(8,1,:,:));
isc_coh_theta.form8.sub16 = squeeze(ch_isc12_theta(8,2,:,:));
isc_coh_theta.form8.sub24 = squeeze(ch_isc12_theta(8,3,:,:));
isc_coh_theta.form8.sub32 = squeeze(ch_isc12_theta(8,4,:,:));
isc_coh_theta.form8.sub33 = squeeze(ch_isc12_theta(8,5,:,:));


figure;
topoplot(double(ch_isc12_delta(j,:)),locfile,'electrodes','on')
figure;
topoplot(double(ch_isc12_theta(j,:)),locfile,'electrodes','on')
figure;
topoplot(double(ch_isc12_alpha(j,:)),locfile,'electrodes','on')
figure;
topoplot(double(ch_isc12_beta(j,:)),locfile,'electrodes','on')
figure;
topoplot(double(ch_isc12_gamma(j,:)),locfile,'electrodes','on')