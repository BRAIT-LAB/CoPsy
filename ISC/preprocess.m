clc;
clear all;
%%
path = 'C:\zhangzenan_data\epoch\deep_mono1';
addpath(path);
channel = {'Fp1','F3','F7','FC5','FC1','C3','T7','TP9','CP5','CP1','Pz',...
    'P3','P7','O1','O2','P4','P8','TP10','CP6','CP2','Cz','C4','T8','FC6',...
    'FC2','F4','F8','Fp2'};
locfile = 'C:\zhangzenan_data\Talk\ISC code\ele\BioSemi28.loc';
comp_no = (1:1:28);

%% 
       
    
         
        folder_base = path;
        file = dir(fullfile(folder_base,'*set'));
        filename = {file.name};
        for j = 1:length(filename)/2    
            % 男生基线
            EEG_M = pop_loadset(filename{2*j-1},folder_base);
            EEG_M = pop_select(EEG_M,'channel',channel);
            % 去除50Hz工频干扰
            EEG_M = pop_eegfilt(EEG_M,49,51,[],1,1);
            % 0-75Hz滤波
            EEG_M = pop_eegfilt(EEG_M,0,75,[],[],1);
            % 重参考
            EEG_M = pop_reref(EEG_M,[]);
            % ICA 去除伪迹
            EEG_M = pop_runica(EEG_M,'icatype','runica');
            [kurt,rej_no] = rejkurt(EEG_M.icaact,1.64,[],1);
            rej_comp = comp_no(rej_no);
            EEG_M = pop_subcomp(EEG_M,rej_comp);
            
            
            
            
            
            % 女生基线
            EEG_W = pop_loadset(filename{2*j},folder_base);
            EEG_W = pop_select(EEG_W,'channel',channel);
            % 去除50Hz工频干扰
            EEG_W = pop_eegfilt(EEG_W,49,51,[],1,1);
            % 重参考
            EEG_W = pop_reref(EEG_W,[]);
            % 0-75Hz滤波
            EEG_W = pop_eegfilt(EEG_W,0,75,[],[],1);
            % ICA 去除伪迹
            EEG_W = pop_runica(EEG_W,'icatype','runica');
            [kurt,rej_no] = rejkurt(EEG_W.icaact,1.64,[],1);
            rej_comp = comp_no(rej_no);
            EEG_W = pop_subcomp(EEG_W,rej_comp);
            
            Locs_M = {EEG_M.chanlocs.labels};
            Locs_W = {EEG_W.chanlocs.labels};
            [~,~,idx_M] = intersect(channel,Locs_M);
            [~,~,idx_W] = intersect(channel,Locs_W);
            
           %% 
            DATA_M = double(EEG_M.data');
            DATA_W = double(EEG_W.data');
            DATA_M = DATA_M(:,idx_M);
            DATA_W = DATA_W(:,idx_W);
            s1 = size(DATA_M,1);
            s2 = size(DATA_W,1);
            min_s = min(s1,s2);
            DATA_M = DATA_M(s1-min_s+1:s1,:);
            DATA_W = DATA_W(s2-min_s+1:s2,:);
            
            DATA = cat(3,DATA_M,DATA_W);
            EEGData.deep_mono1 = DATA;
            EEGData.deep_mono1_W = DATA_W;
            EEGData.deep_mono1_M = DATA_M;
            EEGData.fs = 250;
            EEGData.badchannels = {};
            EEGData.eogchannels = [];            
            save('C:\zhangzenan_data\code\ISC code\deep_mono1','-struct','EEGData')
            clear EEG_M  EEG_W DATA_M DATA_W DATA EEGData 
            
            
            
       end
    
