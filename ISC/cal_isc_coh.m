path = 'C:\zhangzenan_data\Experiment Form';
addpath(path);
folder = dir(fullfile(path));
folder = {folder.name};
channel = {'Fp1','F3','F7','FC5','FC1','C3','T7','TP9','CP5','CP1','Pz',...
    'P3','P7','O1','O2','P4','P8','TP10','CP6','CP2','Cz','C4','T8','FC6',...
    'FC2','F4','F8','Fp2'};
locfile = 'C:\zhangzenan_data\Talk\ISC code\ele\BioSemi28.loc';
comp_no = (1:1:28);
Fbp1 = 8; Fbp2 = 13;   % 带通滤波
%% 独白基线
for i = 3:10 % # of forms
    folderpath = [path '\' folder{i}];
    subfolder = dir(fullfile(folderpath));
    subfolder = {subfolder.name};
    for m = 3:12 % # of states
        folder_base = [folderpath '\' subfolder{m}];
        file = dir(fullfile(folder_base,'*set'));
        filename = {file.name};
        for j = 1:length(filename)/2 % # of couples/experiments
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
            [kurt,rej_no] = rejkurt(EEG_M.icaact,1.64,[],1);  % similar to iclabel
            rej_comp = comp_no(rej_no);
            EEG_M = pop_subcomp(EEG_M,rej_comp);
            % 带通滤波
            EEG_M = pop_eegfilt(EEG_M,Fbp1,Fbp2,[],[],1);    % filtering here then broadband later?
            
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
            %         EEG_W = pop_eegfilt(EEG_W,Fbp1,Fbp2,[],[],1);
            % 重参考？
            
            % 判断两组脑电信号的电极顺序是否一致
            Locs_M = {EEG_M.chanlocs.labels};
            Locs_W = {EEG_W.chanlocs.labels};
            [~,~,idx_M] = intersect(channel,Locs_M);
            [~,~,idx_W] = intersect(channel,Locs_W);
            DATA_M = double(EEG_M.data');
            DATA_W = double(EEG_W.data');
            DATA_M = DATA_M(:,idx_M);
            DARA_W = DATA_W(:,idx_W);
            
            %
            s1 = size(DATA_M,1);
            s2 = size(DATA_W,1);
            min_s = min(s1,s2);
            DATA_M = DATA_M(s1-min_s+1:s1,:); % mistake
            DATA_W = DATA_W(s2-min_s+1:s2,:); % mistake
            %         DATA = cat(3,DATA_M,DATA_W);
            %         EEGData.X = DATA;
            %         EEGData.fs = 250;
            %         EEGData.badchannels = {};
            %         EEGData.eogchannels = [];
            %         save('G:\心理学系BBI\ISC code\EEGData','-struct','EEGData')
            %         datafile = 'G:\心理学系BBI\ISC code\EEGData.mat';
            %         gamma = 0.4;
            %         Nsec = 5;
            %         [ISC,ISC_persubject,ISC_persecond,W,A] = isceeg(datafile,locfile,gamma,Nsec);
            for k = 1:28
                ch1 = DATA_M(:,k)';
                ch2 = DATA_W(:,k)';
                % 计算交叉谱密度
                [c12,f] = cpsd(ch1,ch2,[],[],500,250);
                
                % 计算功率谱密度
                [p1,f] = pwelch(ch1,[],[],500,250);
                [p2,f] = pwelch(ch2,[],[],500,250);
                
                
                idx_delta = (f>=1 & f<= 3);
                idx_theta = (f>=4 & f<= 7);
                idx_alpha = (f>=8 & f<= 13);
                idx_beta = (f>=14 & f<= 30);
                idx_gamma = (f>=31 & f<= 45);
                
                m_c12_delta = c12(idx_delta);
                m_p1_delta = p1(idx_delta);
                m_p2_delta = p2(idx_delta);
                
                m_c12_theta = c12(idx_theta);
                m_p1_theta = p1(idx_theta);
                m_p2_theta = p2(idx_theta);
                
                m_c12_alpha = c12(idx_alpha);
                m_p1_alpha = p1(idx_alpha);
                m_p2_alpha = p2(idx_alpha);
                
                m_c12_beta = c12(idx_beta);
                m_p1_beta = p1(idx_beta);
                m_p2_beta = p2(idx_beta);
                
                m_c12_gamma = c12(idx_gamma);
                m_p1_gamma = p1(idx_gamma);
                m_p2_gamma = p2(idx_gamma);
                
                isc12_delta = abs(m_c12_delta).^2 ./ (m_p1_delta .* m_p2_delta);
                isc12_theta = abs(m_c12_theta).^2 ./ (m_p1_theta .* m_p2_theta);
                isc12_alpha = abs(m_c12_alpha).^2 ./ (m_p1_alpha .* m_p2_alpha);
                isc12_beta = abs(m_c12_beta).^2 ./ (m_p1_beta .* m_p2_beta);
                isc12_gamma = abs(m_c12_gamma).^2 ./ (m_p1_gamma .* m_p2_gamma);
                
                ch_isc12_delta(i-2,j,m-2,k) = mean(isc12_delta);
                ch_isc12_theta(i-2,j,m-2,k) = mean(isc12_theta);
                ch_isc12_alpha(i-2,j,m-2,k) = mean(isc12_alpha);
                ch_isc12_beta(i-2,j,m-2,k) = mean(isc12_beta);
                ch_isc12_gamma(i-2,j,m-2,k) = mean(isc12_gamma);
            end
        end
    end
end

%% alpha频段
isc_coh_alpha.form1.sub01 = squeeze(ch_isc12_alpha(1,1,:,:));
isc_coh_alpha.form1.sub09 = squeeze(ch_isc12_alpha(1,2,:,:));
isc_coh_alpha.form1.sub17 = squeeze(ch_isc12_alpha(1,3,:,:));
isc_coh_alpha.form1.sub25 = squeeze(ch_isc12_alpha(1,4,:,:));
isc_coh_alpha.form1.sub33 = squeeze(ch_isc12_alpha(1,5,:,:));

isc_coh_alpha.form2.sub02 = squeeze(ch_isc12_alpha(2,1,:,:));
isc_coh_alpha.form2.sub10 = squeeze(ch_isc12_alpha(2,2,:,:));
isc_coh_alpha.form2.sub18 = squeeze(ch_isc12_alpha(2,3,:,:));
isc_coh_alpha.form2.sub34 = squeeze(ch_isc12_alpha(2,4,:,:));
isc_coh_alpha.form2.sub33 = squeeze(ch_isc12_alpha(2,5,:,:));

isc_coh_alpha.form3.sub02 = squeeze(ch_isc12_alpha(3,1,:,:));
isc_coh_alpha.form3.sub11 = squeeze(ch_isc12_alpha(3,2,:,:));
isc_coh_alpha.form3.sub27 = squeeze(ch_isc12_alpha(3,3,:,:));
isc_coh_alpha.form3.sub35 = squeeze(ch_isc12_alpha(3,4,:,:));
isc_coh_alpha.form3.sub33 = squeeze(ch_isc12_alpha(3,5,:,:));

isc_coh_alpha.form4.sub12 = squeeze(ch_isc12_alpha(4,1,:,:));
isc_coh_alpha.form4.sub36 = squeeze(ch_isc12_alpha(4,2,:,:));
isc_coh_alpha.form4.sub17 = squeeze(ch_isc12_alpha(4,3,:,:));
isc_coh_alpha.form4.sub25 = squeeze(ch_isc12_alpha(4,4,:,:));
isc_coh_alpha.form4.sub33 = squeeze(ch_isc12_alpha(4,5,:,:));

isc_coh_alpha.form5.sub05 = squeeze(ch_isc12_alpha(5,1,:,:));
isc_coh_alpha.form5.sub13 = squeeze(ch_isc12_alpha(5,2,:,:));
isc_coh_alpha.form5.sub21 = squeeze(ch_isc12_alpha(5,3,:,:));
isc_coh_alpha.form5.sub29 = squeeze(ch_isc12_alpha(5,4,:,:));
isc_coh_alpha.form5.sub37 = squeeze(ch_isc12_alpha(5,5,:,:));

isc_coh_alpha.form6.sub06 = squeeze(ch_isc12_alpha(6,1,:,:));
isc_coh_alpha.form6.sub22 = squeeze(ch_isc12_alpha(6,2,:,:));
isc_coh_alpha.form6.sub30 = squeeze(ch_isc12_alpha(6,3,:,:));
isc_coh_alpha.form6.sub38 = squeeze(ch_isc12_alpha(6,4,:,:));
isc_coh_alpha.form6.sub33 = squeeze(ch_isc12_alpha(6,5,:,:));

isc_coh_alpha.form7.sub15 = squeeze(ch_isc12_alpha(7,1,:,:));
isc_coh_alpha.form7.sub31 = squeeze(ch_isc12_alpha(7,2,:,:));
isc_coh_alpha.form7.sub17 = squeeze(ch_isc12_alpha(7,3,:,:));
isc_coh_alpha.form7.sub25 = squeeze(ch_isc12_alpha(7,4,:,:));
isc_coh_alpha.form7.sub33 = squeeze(ch_isc12_alpha(7,5,:,:));

isc_coh_alpha.form8.sub08 = squeeze(ch_isc12_alpha(8,1,:,:));
isc_coh_alpha.form8.sub16 = squeeze(ch_isc12_alpha(8,2,:,:));
isc_coh_alpha.form8.sub24 = squeeze(ch_isc12_alpha(8,3,:,:));
isc_coh_alpha.form8.sub32 = squeeze(ch_isc12_alpha(8,4,:,:));
isc_coh_alpha.form8.sub33 = squeeze(ch_isc12_alpha(8,5,:,:));

%% beta频段
isc_coh_beta.form1.sub01 = squeeze(ch_isc12_beta(1,1,:,:));
isc_coh_beta.form1.sub09 = squeeze(ch_isc12_beta(1,2,:,:));
isc_coh_beta.form1.sub17 = squeeze(ch_isc12_beta(1,3,:,:));
isc_coh_beta.form1.sub25 = squeeze(ch_isc12_beta(1,4,:,:));
isc_coh_beta.form1.sub33 = squeeze(ch_isc12_beta(1,5,:,:));

isc_coh_beta.form2.sub02 = squeeze(ch_isc12_beta(2,1,:,:));
isc_coh_beta.form2.sub10 = squeeze(ch_isc12_beta(2,2,:,:));
isc_coh_beta.form2.sub18 = squeeze(ch_isc12_beta(2,3,:,:));
isc_coh_beta.form2.sub34 = squeeze(ch_isc12_beta(2,4,:,:));
isc_coh_beta.form2.sub33 = squeeze(ch_isc12_beta(2,5,:,:));

isc_coh_beta.form3.sub02 = squeeze(ch_isc12_beta(3,1,:,:));
isc_coh_beta.form3.sub11 = squeeze(ch_isc12_beta(3,2,:,:));
isc_coh_beta.form3.sub27 = squeeze(ch_isc12_beta(3,3,:,:));
isc_coh_beta.form3.sub35 = squeeze(ch_isc12_beta(3,4,:,:));
isc_coh_beta.form3.sub33 = squeeze(ch_isc12_beta(3,5,:,:));

isc_coh_beta.form4.sub12 = squeeze(ch_isc12_beta(4,1,:,:));
isc_coh_beta.form4.sub36 = squeeze(ch_isc12_beta(4,2,:,:));
isc_coh_beta.form4.sub17 = squeeze(ch_isc12_beta(4,3,:,:));
isc_coh_beta.form4.sub25 = squeeze(ch_isc12_beta(4,4,:,:));
isc_coh_beta.form4.sub33 = squeeze(ch_isc12_beta(4,5,:,:));

isc_coh_beta.form5.sub05 = squeeze(ch_isc12_beta(5,1,:,:));
isc_coh_beta.form5.sub13 = squeeze(ch_isc12_beta(5,2,:,:));
isc_coh_beta.form5.sub21 = squeeze(ch_isc12_beta(5,3,:,:));
isc_coh_beta.form5.sub29 = squeeze(ch_isc12_beta(5,4,:,:));
isc_coh_beta.form5.sub37 = squeeze(ch_isc12_beta(5,5,:,:));

isc_coh_beta.form6.sub06 = squeeze(ch_isc12_beta(6,1,:,:));
isc_coh_beta.form6.sub22 = squeeze(ch_isc12_beta(6,2,:,:));
isc_coh_beta.form6.sub30 = squeeze(ch_isc12_beta(6,3,:,:));
isc_coh_beta.form6.sub38 = squeeze(ch_isc12_beta(6,4,:,:));
isc_coh_beta.form6.sub33 = squeeze(ch_isc12_beta(6,5,:,:));

isc_coh_beta.form7.sub15 = squeeze(ch_isc12_beta(7,1,:,:));
isc_coh_beta.form7.sub31 = squeeze(ch_isc12_beta(7,2,:,:));
isc_coh_beta.form7.sub17 = squeeze(ch_isc12_beta(7,3,:,:));
isc_coh_beta.form7.sub25 = squeeze(ch_isc12_beta(7,4,:,:));
isc_coh_beta.form7.sub33 = squeeze(ch_isc12_beta(7,5,:,:));

isc_coh_beta.form8.sub08 = squeeze(ch_isc12_beta(8,1,:,:));
isc_coh_beta.form8.sub16 = squeeze(ch_isc12_beta(8,2,:,:));
isc_coh_beta.form8.sub24 = squeeze(ch_isc12_beta(8,3,:,:));
isc_coh_beta.form8.sub32 = squeeze(ch_isc12_beta(8,4,:,:));
isc_coh_beta.form8.sub33 = squeeze(ch_isc12_beta(8,5,:,:));


%% delta频段
isc_coh_delta.form1.sub01 = squeeze(ch_isc12_delta(1,1,:,:));
isc_coh_delta.form1.sub09 = squeeze(ch_isc12_delta(1,2,:,:));
isc_coh_delta.form1.sub17 = squeeze(ch_isc12_delta(1,3,:,:));
isc_coh_delta.form1.sub25 = squeeze(ch_isc12_delta(1,4,:,:));
isc_coh_delta.form1.sub33 = squeeze(ch_isc12_delta(1,5,:,:));

isc_coh_delta.form2.sub02 = squeeze(ch_isc12_delta(2,1,:,:));
isc_coh_delta.form2.sub10 = squeeze(ch_isc12_delta(2,2,:,:));
isc_coh_delta.form2.sub18 = squeeze(ch_isc12_delta(2,3,:,:));
isc_coh_delta.form2.sub34 = squeeze(ch_isc12_delta(2,4,:,:));
isc_coh_delta.form2.sub33 = squeeze(ch_isc12_delta(2,5,:,:));

isc_coh_delta.form3.sub02 = squeeze(ch_isc12_delta(3,1,:,:));
isc_coh_delta.form3.sub11 = squeeze(ch_isc12_delta(3,2,:,:));
isc_coh_delta.form3.sub27 = squeeze(ch_isc12_delta(3,3,:,:));
isc_coh_delta.form3.sub35 = squeeze(ch_isc12_delta(3,4,:,:));
isc_coh_delta.form3.sub33 = squeeze(ch_isc12_delta(3,5,:,:));

isc_coh_delta.form4.sub12 = squeeze(ch_isc12_delta(4,1,:,:));
isc_coh_delta.form4.sub36 = squeeze(ch_isc12_delta(4,2,:,:));
isc_coh_delta.form4.sub17 = squeeze(ch_isc12_delta(4,3,:,:));
isc_coh_delta.form4.sub25 = squeeze(ch_isc12_delta(4,4,:,:));
isc_coh_delta.form4.sub33 = squeeze(ch_isc12_delta(4,5,:,:));

isc_coh_delta.form5.sub05 = squeeze(ch_isc12_delta(5,1,:,:));
isc_coh_delta.form5.sub13 = squeeze(ch_isc12_delta(5,2,:,:));
isc_coh_delta.form5.sub21 = squeeze(ch_isc12_delta(5,3,:,:));
isc_coh_delta.form5.sub29 = squeeze(ch_isc12_delta(5,4,:,:));
isc_coh_delta.form5.sub37 = squeeze(ch_isc12_delta(5,5,:,:));

isc_coh_delta.form6.sub06 = squeeze(ch_isc12_delta(6,1,:,:));
isc_coh_delta.form6.sub22 = squeeze(ch_isc12_delta(6,2,:,:));
isc_coh_delta.form6.sub30 = squeeze(ch_isc12_delta(6,3,:,:));
isc_coh_delta.form6.sub38 = squeeze(ch_isc12_delta(6,4,:,:));
isc_coh_delta.form6.sub33 = squeeze(ch_isc12_delta(6,5,:,:));

isc_coh_delta.form7.sub15 = squeeze(ch_isc12_delta(7,1,:,:));
isc_coh_delta.form7.sub31 = squeeze(ch_isc12_delta(7,2,:,:));
isc_coh_delta.form7.sub17 = squeeze(ch_isc12_delta(7,3,:,:));
isc_coh_delta.form7.sub25 = squeeze(ch_isc12_delta(7,4,:,:));
isc_coh_delta.form7.sub33 = squeeze(ch_isc12_delta(7,5,:,:));

isc_coh_delta.form8.sub08 = squeeze(ch_isc12_delta(8,1,:,:));
isc_coh_delta.form8.sub16 = squeeze(ch_isc12_delta(8,2,:,:));
isc_coh_delta.form8.sub24 = squeeze(ch_isc12_delta(8,3,:,:));
isc_coh_delta.form8.sub32 = squeeze(ch_isc12_delta(8,4,:,:));
isc_coh_delta.form8.sub33 = squeeze(ch_isc12_delta(8,5,:,:));


%% gamma频段
isc_coh_gamma.form1.sub01 = squeeze(ch_isc12_gamma(1,1,:,:));
isc_coh_gamma.form1.sub09 = squeeze(ch_isc12_gamma(1,2,:,:));
isc_coh_gamma.form1.sub17 = squeeze(ch_isc12_gamma(1,3,:,:));
isc_coh_gamma.form1.sub25 = squeeze(ch_isc12_gamma(1,4,:,:));
isc_coh_gamma.form1.sub33 = squeeze(ch_isc12_gamma(1,5,:,:));

isc_coh_gamma.form2.sub02 = squeeze(ch_isc12_gamma(2,1,:,:));
isc_coh_gamma.form2.sub10 = squeeze(ch_isc12_gamma(2,2,:,:));
isc_coh_gamma.form2.sub18 = squeeze(ch_isc12_gamma(2,3,:,:));
isc_coh_gamma.form2.sub34 = squeeze(ch_isc12_gamma(2,4,:,:));
isc_coh_gamma.form2.sub33 = squeeze(ch_isc12_gamma(2,5,:,:));

isc_coh_gamma.form3.sub02 = squeeze(ch_isc12_gamma(3,1,:,:));
isc_coh_gamma.form3.sub11 = squeeze(ch_isc12_gamma(3,2,:,:));
isc_coh_gamma.form3.sub27 = squeeze(ch_isc12_gamma(3,3,:,:));
isc_coh_gamma.form3.sub35 = squeeze(ch_isc12_gamma(3,4,:,:));
isc_coh_gamma.form3.sub33 = squeeze(ch_isc12_gamma(3,5,:,:));

isc_coh_gamma.form4.sub12 = squeeze(ch_isc12_gamma(4,1,:,:));
isc_coh_gamma.form4.sub36 = squeeze(ch_isc12_gamma(4,2,:,:));
isc_coh_gamma.form4.sub17 = squeeze(ch_isc12_gamma(4,3,:,:));
isc_coh_gamma.form4.sub25 = squeeze(ch_isc12_gamma(4,4,:,:));
isc_coh_gamma.form4.sub33 = squeeze(ch_isc12_gamma(4,5,:,:));

isc_coh_gamma.form5.sub05 = squeeze(ch_isc12_gamma(5,1,:,:));
isc_coh_gamma.form5.sub13 = squeeze(ch_isc12_gamma(5,2,:,:));
isc_coh_gamma.form5.sub21 = squeeze(ch_isc12_gamma(5,3,:,:));
isc_coh_gamma.form5.sub29 = squeeze(ch_isc12_gamma(5,4,:,:));
isc_coh_gamma.form5.sub37 = squeeze(ch_isc12_gamma(5,5,:,:));

isc_coh_gamma.form6.sub06 = squeeze(ch_isc12_gamma(6,1,:,:));
isc_coh_gamma.form6.sub22 = squeeze(ch_isc12_gamma(6,2,:,:));
isc_coh_gamma.form6.sub30 = squeeze(ch_isc12_gamma(6,3,:,:));
isc_coh_gamma.form6.sub38 = squeeze(ch_isc12_gamma(6,4,:,:));
isc_coh_gamma.form6.sub33 = squeeze(ch_isc12_gamma(6,5,:,:));

isc_coh_gamma.form7.sub15 = squeeze(ch_isc12_gamma(7,1,:,:));
isc_coh_gamma.form7.sub31 = squeeze(ch_isc12_gamma(7,2,:,:));
isc_coh_gamma.form7.sub17 = squeeze(ch_isc12_gamma(7,3,:,:));
isc_coh_gamma.form7.sub25 = squeeze(ch_isc12_gamma(7,4,:,:));
isc_coh_gamma.form7.sub33 = squeeze(ch_isc12_gamma(7,5,:,:));

isc_coh_gamma.form8.sub08 = squeeze(ch_isc12_gamma(8,1,:,:));
isc_coh_gamma.form8.sub16 = squeeze(ch_isc12_gamma(8,2,:,:));
isc_coh_gamma.form8.sub24 = squeeze(ch_isc12_gamma(8,3,:,:));
isc_coh_gamma.form8.sub32 = squeeze(ch_isc12_gamma(8,4,:,:));
isc_coh_gamma.form8.sub33 = squeeze(ch_isc12_gamma(8,5,:,:));


%% theta频段
isc_coh_theta.form1.sub01 = squeeze(ch_isc12_theta(1,1,:,:));
isc_coh_theta.form1.sub09 = squeeze(ch_isc12_theta(1,2,:,:));
isc_coh_theta.form1.sub17 = squeeze(ch_isc12_theta(1,3,:,:));
isc_coh_theta.form1.sub25 = squeeze(ch_isc12_theta(1,4,:,:));
isc_coh_theta.form1.sub33 = squeeze(ch_isc12_theta(1,5,:,:));

isc_coh_theta.form2.sub02 = squeeze(ch_isc12_theta(2,1,:,:));
isc_coh_theta.form2.sub10 = squeeze(ch_isc12_theta(2,2,:,:));
isc_coh_theta.form2.sub18 = squeeze(ch_isc12_theta(2,3,:,:));
isc_coh_theta.form2.sub32 = squeeze(ch_isc12_theta(2,4,:,:));
isc_coh_theta.form2.sub33 = squeeze(ch_isc12_theta(2,5,:,:));

isc_coh_theta.form3.sub03 = squeeze(ch_isc12_theta(3,1,:,:));
isc_coh_theta.form3.sub11 = squeeze(ch_isc12_theta(3,2,:,:));
isc_coh_theta.form3.sub27 = squeeze(ch_isc12_theta(3,3,:,:));
isc_coh_theta.form3.sub35 = squeeze(ch_isc12_theta(3,4,:,:));
isc_coh_theta.form3.sub33 = squeeze(ch_isc12_theta(3,5,:,:));

isc_coh_theta.form4.sub12 = squeeze(ch_isc12_theta(4,1,:,:));
isc_coh_theta.form4.sub36 = squeeze(ch_isc12_theta(4,2,:,:));
isc_coh_theta.form4.sub17 = squeeze(ch_isc12_theta(4,3,:,:));
isc_coh_theta.form4.sub25 = squeeze(ch_isc12_theta(4,4,:,:));
isc_coh_theta.form4.sub33 = squeeze(ch_isc12_theta(4,5,:,:));

isc_coh_theta.form5.sub05 = squeeze(ch_isc12_theta(5,1,:,:));
isc_coh_theta.form5.sub13 = squeeze(ch_isc12_theta(5,2,:,:));
isc_coh_theta.form5.sub21 = squeeze(ch_isc12_theta(5,3,:,:));
isc_coh_theta.form5.sub29 = squeeze(ch_isc12_theta(5,4,:,:));
isc_coh_theta.form5.sub37 = squeeze(ch_isc12_theta(5,5,:,:));

isc_coh_theta.form6.sub06 = squeeze(ch_isc12_theta(6,1,:,:));
isc_coh_theta.form6.sub22 = squeeze(ch_isc12_theta(6,2,:,:));
isc_coh_theta.form6.sub30 = squeeze(ch_isc12_theta(6,3,:,:));
isc_coh_theta.form6.sub38 = squeeze(ch_isc12_theta(6,4,:,:));
isc_coh_theta.form6.sub33 = squeeze(ch_isc12_theta(6,5,:,:));

isc_coh_theta.form7.sub15 = squeeze(ch_isc12_theta(7,1,:,:));
isc_coh_theta.form7.sub31 = squeeze(ch_isc12_theta(7,2,:,:));
isc_coh_theta.form7.sub17 = squeeze(ch_isc12_theta(7,3,:,:));
isc_coh_theta.form7.sub25 = squeeze(ch_isc12_theta(7,4,:,:));
isc_coh_theta.form7.sub33 = squeeze(ch_isc12_theta(7,5,:,:));

isc_coh_theta.form8.sub08 = squeeze(ch_isc12_theta(8,1,:,:));
isc_coh_theta.form8.sub16 = squeeze(ch_isc12_theta(8,2,:,:));
isc_coh_theta.form8.sub24 = squeeze(ch_isc12_theta(8,3,:,:));
isc_coh_theta.form8.sub32 = squeeze(ch_isc12_theta(8,4,:,:));
isc_coh_theta.form8.sub33 = squeeze(ch_isc12_theta(8,5,:,:));

save('C:\zhangzenan_data\code\results\isc_coh_alpha','-struct','isc_coh_alpha');
save('C:\zhangzenan_data\code\results\isc_coh_beta','-struct','isc_coh_beta');
save('C:\zhangzenan_data\code\results\isc_coh_delta','-struct','isc_coh_delta');
save('C:\zhangzenan_data\code\results\isc_coh_gamma','-struct','isc_coh_gamma');
save('C:\zhangzenan_data\code\results\isc_coh_theta','-struct','isc_coh_theta');
% figure;
% topoplot(double(ch_isc12_delta(j,:)),locfile,'electrodes','on')
% figure;
% topoplot(double(ch_isc12_theta(j,:)),locfile,'electrodes','on')
% figure;
% topoplot(double(ch_isc12_alpha(j,:)),locfile,'electrodes','on')
% figure;
% topoplot(double(ch_isc12_beta(j,:)),locfile,'electrodes','on')
% figure;
% topoplot(double(ch_isc12_gamma(j,:)),locfile,'electrodes','on')