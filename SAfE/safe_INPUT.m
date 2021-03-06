%==========================================================================
%                  Input parameters for the fMRI analysis
%==========================================================================
% 
% Script to read all the parameters for the preprocessing and/or
% statistical analysis of fMRI data. Edit this file with your data.
% 
%--------------------------------------------------------------------------


% Basic input
%============
basic.parent_dir   = 'D:\AllSubjects';                % Parent directory for all subjects folder
basic.sbj_folder   = {{'xls1_tab1_sbjfolder','xls1_tab2_sbjfolder'},{'xls2_tab1_sbjfolder','xls2_tab2_sbjfolder'}};
                                                      % Subject folder inside "parent_dir"
% => sbj_folder{FF}{WW}: XLS file FF, worksheet tab WW
basic.fmri_path    = fullfile('Analysis','fMRIdata'); % Folders inside "parent_dir"\"sbj_folder" (same for all subjects)
basic.xlsfile      = {'xls1','xls2'};                 % List of XLS files => xlsfile{FF}: XLS file FF
basic.worksheet    = {{'xls1_tab1','xls1_tab2'},{'xls2_tab1','xls2_tab2'}};
                                                      % Worksheet inside the XLS file
% => worksheet{FF}{WW}: XLS file FF, worksheet tab WW (same size as SBJ_FOLDER)
basic.eeg_fmri_exp = 1;                               % 1 (EEG-fMRI experiment) or 0 (only fMRI)


% Preprocessing
%==============
preproc.run = 1;                         % 1 (preprocess) or 0 (don't preprocess)
    preproc.stc           = 1;           % slice timing correction
    preproc.norm.run      = 1;           % normalization
    preproc.norm.struc_vx = [-1 -1 -1];  % voxel size for the normalized structural image
    preproc.norm.func_vx  = [-1 -1 -1];  % voxel size for the normalized functional image
    preproc.smooth.run    = 1;           % smoothing
    preproc.smooth.fwhm   = [-2 -2 -2];  % smoothing kernel


% Design & Estimate
%==================
stat_des.run = 1;                        % 1 (create design matrix) or 0 (don't create)
    stat_des.pref_func    = 'sw';        % 'swa' (STC=1, NORM=1), 'sw' (STC=0, NORM=1), 'sar' (STC=1, NORM=0), 'sr' (STC=0, NORM=0)
    stat_des.pref_struc   = 'wm';        % 'wm' (NORM=1), '' (NORM=0)
    stat_des.tag_struc    = '';          % text to identify the structural image (useful when NORM=0)
    stat_des.use_rp       = 1;           % 1 (use realignment parameters) or 0 (don't use)
    stat_des.hpf          = 128;         % high-pass filter [s]
    stat_des.bf           = 'can_hrf';   % hemodynamic response function: 'can_hrf', 'fourier', 'fourier_han', 'gamma', 'fir'
    stat_des.bf_length    = 32;          % post-stimulus window length [s]
    stat_des.bf_order     = 3;           % number of basis functions
    stat_des.delay        = 0;           % delay vector


% Contrast
%=========
stat_con = 1;                            % 1 (create contrast) or 0 (don't create)


% Results
%========

stat_res.run = 1;                        % 1 (perform the analyses below) or 0 (don't perform)

% P-value
stat_res.thresh.adj = 'FWE';             % correction ('none' or 'FWE')
stat_res.thresh.P   = 0.05;              % P-value
stat_res.thresh.ET  = 0;                 % extent threshold (in voxels)

% PostScript file
stat_res.ps_save     = 1;                % 1 (save PS file) or 0 (don't save)

% Auxiliary files
stat_res.save_slover = 0;                % 1 (save slover object(s)) or 0 (don't save)
stat_res.save_thr    = 0;                % 1 (save thresholded image(s)) or 0 (don't save)

% Save image with slices
stat_res.slices.save = 1;                % 1 (create image with slices) or 0 (don't create)
    stat_res.slices.img_ext = 'png';     % image extension
    stat_res.slices.step    = 0;         % spacing between slices (mm)
    stat_res.slices.number  = 36;        % number of slices (to use this option, SLICES.STEP must be 0)
    stat_res.slices.slices  = 0;         % coordinates of the slices (to use this option, SLICES.STEP and SLICES.NUMBER must be 0)
    stat_res.slices.orient  = {'axial'}; % slice orientation (at least one of the following options: 'axial', 'coronal', 'sagittal')

% Group of images
stat_res.group.save = 0;                 % 1 (group delays) or 0 (don't group)
    stat_res.group.scale.adj   = 1;      % 1 (adjust scale) or 0 (don't adjust)
    stat_res.group.scale.ftest = 'max';  % value for the scale ('max' or [eps V_max])
    stat_res.group.scale.ttest = 'max';  % value for the scale ('max' or [eps V_max_pos eps V_max_neg])
    stat_res.group.number      = 3;      % number of delays per group

% Save sequence of images
stat_res.event_seq.save = 0;                  % 1 (save sequence of images) or 0 (don't save)
    stat_res.event_seq.scale.ftest   = 'max'; % value for the scale ('max' or [eps V_max])
    stat_res.event_seq.scale.posbold = 'max'; % value for the scale ('max' or [eps V_max])
    stat_res.event_seq.scale.negbold = 'max'; % value for the scale ('max' or [eps V_max])
    
% Use mask for results
stat_res.mask.use = 0;                   % 1 (use mask) or 0 (don't use)
    stat_res.mask.imgs_text  = {'mwc1*','mwc2*'}; % masking images prefix
    stat_res.mask.incl_excl  = 'inclusive';       % 'inclusive' or 'exclusive'
    stat_res.mask.bin        = 0;        % 1 (create binary mask) or 0 (don't create)
    stat_res.mask.bin_thresh = 0.5;      % threshold value for the binary mask

% Cleanup
stat_res.cleanup = 1;                    % 1 (clean up) or 0 (don't clean up)


% Make the complete structure and run
%====================================
opt_safe.basic    = basic;
opt_safe.preproc  = preproc;
opt_safe.stat_des = stat_des;
opt_safe.stat_con = stat_con;
opt_safe.stat_res = stat_res;
safe_preproc_stat(opt_safe)