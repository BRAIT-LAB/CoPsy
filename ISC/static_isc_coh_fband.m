baseline1 = [];
baseline2 = [];
super_mono1 = [];   % ǳ����������
deep_mono1  = [];   % ���Ĳ���������
super_mono2 = [];   % ǳ�㱳�Ա�����
deep_mono2  = [];   % ���Ĳ㱳�Ա�����
super_comu1 = [];   % ǳ������湵ͨ
deep_comu1  = [];   % ���Ĳ�����湵ͨ
super_comu2 = [];   % ǳ�㱳�Ա���ͨ
deep_comu2  = [];   % ���Ĳ㱳�Ա���ͨ

isc_coh_theta = load('C:\zhangzenan_data\Talk\results\mat\isc_coh_theta.mat');
fields = fieldnames(isc_coh_theta);
for i = 1:length(fields)
    switch i
        case 1
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(3,:));
                deep_mono1 = cat(1,deep_mono1,subisc(4,:));
                super_mono2 = cat(1,super_mono2,subisc(5,:));
                deep_mono2 = cat(1,deep_mono2,subisc(6,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
        case 2
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(5,:));
                deep_mono1 = cat(1,deep_mono1,subisc(6,:));
                super_mono2 = cat(1,super_mono2,subisc(3,:));
                deep_mono2 = cat(1,deep_mono2,subisc(4,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
        case 3
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(5,:));
                deep_mono1 = cat(1,deep_mono1,subisc(6,:));
                super_mono2 = cat(1,super_mono2,subisc(3,:));
                deep_mono2 = cat(1,deep_mono2,subisc(4,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
        case 4
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(3,:));
                deep_mono1 = cat(1,deep_mono1,subisc(4,:));
                super_mono2 = cat(1,super_mono2,subisc(5,:));
                deep_mono2 = cat(1,deep_mono2,subisc(6,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
        case 5
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(5,:));
                deep_mono1 = cat(1,deep_mono1,subisc(6,:));
                super_mono2 = cat(1,super_mono2,subisc(3,:));
                deep_mono2 = cat(1,deep_mono2,subisc(4,:));
                super_comu1 = cat(1,super_comu1,subisc(9,:));
                deep_comu1 = cat(1,deep_comu1,subisc(10,:));
                super_comu2 = cat(1,super_comu2,subisc(7,:));
                deep_comu2 = cat(1,deep_comu2,subisc(8,:));
            end
        case 6
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(3,:));
                deep_mono1 = cat(1,deep_mono1,subisc(4,:));
                super_mono2 = cat(1,super_mono2,subisc(5,:));
                deep_mono2 = cat(1,deep_mono2,subisc(6,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
        case 7
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(5,:));
                deep_mono1 = cat(1,deep_mono1,subisc(6,:));
                super_mono2 = cat(1,super_mono2,subisc(3,:));
                deep_mono2 = cat(1,deep_mono2,subisc(4,:));
                super_comu1 = cat(1,super_comu1,subisc(9,:));
                deep_comu1 = cat(1,deep_comu1,subisc(10,:));
                super_comu2 = cat(1,super_comu2,subisc(7,:));
                deep_comu2 = cat(1,deep_comu2,subisc(8,:));
            end
        case 8
            isc = getfield(isc_coh_theta, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1 = cat(1,baseline1,subisc(1,:));
                baseline2 = cat(1,baseline2,subisc(2,:));
                super_mono1 = cat(1,super_mono1,subisc(3,:));
                deep_mono1 = cat(1,deep_mono1,subisc(4,:));
                super_mono2 = cat(1,super_mono2,subisc(5,:));
                deep_mono2 = cat(1,deep_mono2,subisc(6,:));
                super_comu1 = cat(1,super_comu1,subisc(7,:));
                deep_comu1 = cat(1,deep_comu1,subisc(8,:));
                super_comu2 = cat(1,super_comu2,subisc(9,:));
                deep_comu2 = cat(1,deep_comu2,subisc(10,:));
            end
    end
end
static_isc_coh_theta.baseline1 = baseline1;
static_isc_coh_theta.baseline2 = baseline2;
static_isc_coh_theta.supermono1 = super_mono1;
static_isc_coh_theta.deepmono1 = deep_mono1;
static_isc_coh_theta.supermono2 = super_mono2;
static_isc_coh_theta.deepmono2 = deep_mono2;
static_isc_coh_theta.supercomu1 = super_comu1;
static_isc_coh_theta.deepcomu1 = deep_comu1;
static_isc_coh_theta.supercomu2 = super_comu2;
static_isc_coh_theta.deepcomu2 = deep_comu2;
save('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_theta','-struct','static_isc_coh_theta')