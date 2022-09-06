%% 分组：独白/表露者——男/女
baseline1_m = [];
baseline2_m = [];
super_mono1_m = [];   % 浅层面对面独白
deep_mono1_m  = [];   % 核心层面对面独白
super_mono2_m = [];   % 浅层背对背独白
deep_mono2_m  = [];   % 核心层背对背独白
super_comu1_m = [];   % 浅层面对面沟通
deep_comu1_m  = [];   % 核心层面对面沟通
super_comu2_m = [];   % 浅层背对背沟通
deep_comu2_m  = [];   % 核心层背对背沟通

baseline1_f = [];
baseline2_f = [];
super_mono1_f = [];   % 浅层面对面独白
deep_mono1_f  = [];   % 核心层面对面独白
super_mono2_f = [];   % 浅层背对背独白
deep_mono2_f  = [];   % 核心层背对背独白
super_comu1_f = [];   % 浅层面对面沟通
deep_comu1_f  = [];   % 核心层面对面沟通
super_comu2_f = [];   % 浅层背对背沟通
deep_comu2_f  = [];   % 核心层背对背沟通

isc_coh_alpha = load('C:\zhangzenan_data\Talk\results\mat\isc_coh_alpha.mat');
fields = fieldnames(isc_coh_alpha);
for i = 1:length(fields)
    switch i
        case 1
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_m = cat(1,baseline1_m,subisc(1,:));
                baseline2_m = cat(1,baseline2_m,subisc(2,:));
                super_mono1_m = cat(1,super_mono1_m,subisc(3,:));
                deep_mono1_m = cat(1,deep_mono1_m,subisc(4,:));
                super_mono2_m = cat(1,super_mono2_m,subisc(5,:));
                deep_mono2_m = cat(1,deep_mono2_m,subisc(6,:));
                super_comu1_m = cat(1,super_comu1_m,subisc(7,:));
                deep_comu1_m = cat(1,deep_comu1_m,subisc(8,:));
                super_comu2_m = cat(1,super_comu2_m,subisc(9,:));
                deep_comu2_m = cat(1,deep_comu2_m,subisc(10,:));
            end
        case 2
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_m = cat(1,baseline1_m,subisc(1,:));
                baseline2_m = cat(1,baseline2_m,subisc(2,:));
                super_mono1_m = cat(1,super_mono1_m,subisc(5,:));
                deep_mono1_m = cat(1,deep_mono1_m,subisc(6,:));
                super_mono2_m = cat(1,super_mono2_m,subisc(3,:));
                deep_mono2_m = cat(1,deep_mono2_m,subisc(4,:));
                super_comu1_m = cat(1,super_comu1_m,subisc(7,:));
                deep_comu1_m = cat(1,deep_comu1_m,subisc(8,:));
                super_comu2_m = cat(1,super_comu2_m,subisc(9,:));
                deep_comu2_m = cat(1,deep_comu2_m,subisc(10,:));
            end
        case 3
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_f = cat(1,baseline1_f,subisc(1,:));
                baseline2_f = cat(1,baseline2_f,subisc(2,:));
                super_mono1_f = cat(1,super_mono1_f,subisc(5,:));
                deep_mono1_f = cat(1,deep_mono1_f,subisc(6,:));
                super_mono2_f = cat(1,super_mono2_f,subisc(3,:));
                deep_mono2_f = cat(1,deep_mono2_f,subisc(4,:));
                super_comu1_f = cat(1,super_comu1_f,subisc(7,:));
                deep_comu1_f = cat(1,deep_comu1_f,subisc(8,:));
                super_comu2_f = cat(1,super_comu2_f,subisc(9,:));
                deep_comu2_f = cat(1,deep_comu2_f,subisc(10,:));
            end
        case 4
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_f = cat(1,baseline1_f,subisc(1,:));
                baseline2_f = cat(1,baseline2_f,subisc(2,:));
                super_mono1_f = cat(1,super_mono1_f,subisc(3,:));
                deep_mono1_f = cat(1,deep_mono1_f,subisc(4,:));
                super_mono2_f = cat(1,super_mono2_f,subisc(5,:));
                deep_mono2_f = cat(1,deep_mono2_f,subisc(6,:));
                super_comu1_f = cat(1,super_comu1_f,subisc(7,:));
                deep_comu1_f = cat(1,deep_comu1_f,subisc(8,:));
                super_comu2_f = cat(1,super_comu2_f,subisc(9,:));
                deep_comu2_f = cat(1,deep_comu2_f,subisc(10,:));
            end
        case 5
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_m = cat(1,baseline1_m,subisc(1,:));
                baseline2_m = cat(1,baseline2_m,subisc(2,:));
                super_mono1_m = cat(1,super_mono1_m,subisc(5,:));
                deep_mono1_m = cat(1,deep_mono1_m,subisc(6,:));
                super_mono2_m = cat(1,super_mono2_m,subisc(3,:));
                deep_mono2_m = cat(1,deep_mono2_m,subisc(4,:));
                super_comu1_m = cat(1,super_comu1_m,subisc(9,:));
                deep_comu1_m = cat(1,deep_comu1_m,subisc(10,:));
                super_comu2_m = cat(1,super_comu2_m,subisc(7,:));
                deep_comu2_m = cat(1,deep_comu2_m,subisc(8,:));
            end
        case 6
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_m = cat(1,baseline1_m,subisc(1,:));
                baseline2_m = cat(1,baseline2_m,subisc(2,:));
                super_mono1_m = cat(1,super_mono1_m,subisc(3,:));
                deep_mono1_m = cat(1,deep_mono1_m,subisc(4,:));
                super_mono2_m = cat(1,super_mono2_m,subisc(5,:));
                deep_mono2_m = cat(1,deep_mono2_m,subisc(6,:));
                super_comu1_m = cat(1,super_comu1_m,subisc(7,:));
                deep_comu1_m = cat(1,deep_comu1_m,subisc(8,:));
                super_comu2_m = cat(1,super_comu2_m,subisc(9,:));
                deep_comu2_m = cat(1,deep_comu2_m,subisc(10,:));
            end
        case 7
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_f = cat(1,baseline1_f,subisc(1,:));
                baseline2_f = cat(1,baseline2_f,subisc(2,:));
                super_mono1_f = cat(1,super_mono1_f,subisc(5,:));
                deep_mono1_f = cat(1,deep_mono1_f,subisc(6,:));
                super_mono2_f = cat(1,super_mono2_f,subisc(3,:));
                deep_mono2_f = cat(1,deep_mono2_f,subisc(4,:));
                super_comu1_f = cat(1,super_comu1_f,subisc(9,:));
                deep_comu1_f = cat(1,deep_comu1_f,subisc(10,:));
                super_comu2_f = cat(1,super_comu2_f,subisc(7,:));
                deep_comu2_f = cat(1,deep_comu2_f,subisc(8,:));
            end
        case 8
            isc = getfield(isc_coh_alpha, fields{i});
            subfields = fieldnames(isc);
            for j = 1:length(subfields)
                subisc = getfield(isc, subfields{j});
                baseline1_f = cat(1,baseline1_f,subisc(1,:));
                baseline2_f = cat(1,baseline2_f,subisc(2,:));
                super_mono1_f = cat(1,super_mono1_f,subisc(3,:));
                deep_mono1_f = cat(1,deep_mono1_f,subisc(4,:));
                super_mono2_f = cat(1,super_mono2_f,subisc(5,:));
                deep_mono2_f = cat(1,deep_mono2_f,subisc(6,:));
                super_comu1_f = cat(1,super_comu1_f,subisc(7,:));
                deep_comu1_f = cat(1,deep_comu1_f,subisc(8,:));
                super_comu2_f = cat(1,super_comu2_f,subisc(9,:));
                deep_comu2_f = cat(1,deep_comu2_f,subisc(10,:));
            end
    end
end
static_isc_coh_alpha_m.baseline1 = baseline1_m;
static_isc_coh_alpha_m.baseline2 = baseline2_m;
static_isc_coh_alpha_m.supermono1 = super_mono1_m;
static_isc_coh_alpha_m.deepmono1 = deep_mono1_m;
static_isc_coh_alpha_m.supermono2 = super_mono2_m;
static_isc_coh_alpha_m.deepmono2 = deep_mono2_m;
static_isc_coh_alpha_m.supercomu1 = super_comu1_m;
static_isc_coh_alpha_m.deepcomu1 = deep_comu1_m;
static_isc_coh_alpha_m.supercomu2 = super_comu2_m;
static_isc_coh_alpha_m.deepcomu2 = deep_comu2_m;
save('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_m','-struct','static_isc_coh_alpha_m')


static_isc_coh_alpha_f.baseline1 = baseline1_f;
static_isc_coh_alpha_f.baseline2 = baseline2_f;
static_isc_coh_alpha_f.supermono1 = super_mono1_f;
static_isc_coh_alpha_f.deepmono1 = deep_mono1_f;
static_isc_coh_alpha_f.supermono2 = super_mono2_f;
static_isc_coh_alpha_f.deepmono2 = deep_mono2_f;
static_isc_coh_alpha_f.supercomu1 = super_comu1_f;
static_isc_coh_alpha_f.deepcomu1 = deep_comu1_f;
static_isc_coh_alpha_f.supercomu2 = super_comu2_f;
static_isc_coh_alpha_f.deepcomu2 = deep_comu2_f;
save('C:\zhangzenan_data\Talk\results\mat\static_isc_coh_alpha_f','-struct','static_isc_coh_alpha_f')