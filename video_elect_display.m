%% Example on how to plot electrodes in Matlab


%% 1. Load the template brain
cortex_TemplateRight = load('/Users/pinheirochagas/Pedro/Stanford/code/lin_plot_elec/Colin_cortex_right.mat');
cortex_TemplateLeft = load('/Users/pinheirochagas/Pedro/Stanford/code/lin_plot_elec/Colin_cortex_left.mat');
dir_out = '/Users/pinheirochagas/Pedro/Stanford/code/lin_plot_elec/';

%% Load some electrode coordinates in MNI space
sEEG = load('/Users/pinheirochagas/Downloads/SEEG.mat');
el_exclude =[sEEG.origCoords(:,1)>60 sEEG.origCoords(:,2)>60 sEEG.origCoords(:,3)>40];
el_ex = sum(el_exclude,2);
sEEG.origCoords = sEEG.origCoords(el_ex == 0,:);
el_left = sEEG.origCoords(sEEG.origCoords(:,1)<0,:);
el_right = sEEG.origCoords(sEEG.origCoords(:,1)>0,:);

%% Define figure dims and brain angles
figureDim = [0 0 .5 .5];
loc = 0:10:270;

% Plot left hemisphere s
for e = 1:length(loc)
    figure('units', 'normalized', 'outerposition', figureDim)
    ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
    alpha(0.5)
    loc_view(0+loc(e),0)
    plot3(el_left(:,1),el_left(:,2),el_left(:,3), 'k.','MarkerSize', 25)
    F(e) = getframe(gcf);
    close all
end

%% Create and export movie
fig = figure('units', 'normalized', 'outerposition', figureDim);
movie(fig,F,1)

videoRSA = VideoWriter([dir_out 'video_ex.avi']);
uncompressedVideo = VideoWriter([dir_out 'video_ex.avi'], 'Uncompressed AVI');
videoRSA.FrameRate = 10;  % Default 30
videoRSA.Quality = 100;    % Default 75
open(videoRSA);
writeVideo(videoRSA, [F]);
close(videoRSA);

