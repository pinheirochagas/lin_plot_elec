%% Example on how to plot electrodes in Matlab


%% 1. Load the template brain
cortex_TemplateRight = load('/Users/pinheirochagas/Pedro/Stanford/code/lin_plot_elec/Colin_cortex_right.mat');
cortex_TemplateLeft = load('/Users/pinheirochagas/Pedro/Stanford/code/lin_plot_elec/Colin_cortex_left.mat');

%% Load the electrode coordinates in MNI space
load('/Users/pinheirochagas/Downloads/ECOG.mat');
sEEG = load('/Users/pinheirochagas/Downloads/SEEG.mat');

elec_coords = origCoords;

%% Plot tamplate brain (lateral left hemisphere only)
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
% Note that this figure is interactive
% you can also configurate the view (last input parameter - viewside)

%%
dir_out = '/Users/pinheirochagas/Pedro/drive/Stanford/presentations/laschool_2018/'

%% initiate figure
figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 4)
plot3(el_mni(:,1),el_mni(:,2),el_mni(:,3), 'k.','MarkerSize', 50)
save2pdf([dir_out 'tvd_brain_ventral.pdf'], gcf, 600)


%% Add electrodes lateral
elec_coords_lat = elec_coords;
elec_coords_lat(elec_coords_lat(:,1)<0,1) = elec_coords_lat(elec_coords_lat(:,1)<0,1) - 30;
elec_coords_lat(elec_coords(:,1)>0,1) = elec_coords_lat(elec_coords_lat(:,1)>0,1) + 30;

% Lateral left hemisphere lateral
figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
plot3(elec_coords_lat(:,1),elec_coords_lat(:,2),elec_coords_lat(:,3), 'k.','MarkerSize', 25)
save2pdf([dir_out 'lateral_left.pdf'], gcf, 600)

% Lateral right hemisphere lateral
figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateRight.cortex,[0 0 0], 0, 'r', 1)
plot3(elec_coords_lat(:,1),elec_coords_lat(:,2),elec_coords_lat(:,3), 'k.','MarkerSize', 25)
save2pdf([dir_out 'lateral_right.pdf'], gcf, 600)


%% Add electrodes ventral
elec_coords_ven = elec_coords;
elec_coords_ven(:,3) = elec_coords_ven(:,3) - 30;
el = elec_coords_ven(:,1)<0;
er = elec_coords_ven(:,1)>0;

% Lateral left hemisphere ventral
figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 4)
plot3(elec_coords_ven(el,1),elec_coords_ven(el,2),elec_coords_ven(el,3), 'k.','MarkerSize', 22)
save2pdf([dir_out 'ventral_left.pdf'], gcf, 600)


% Lateral left hemisphere ventral
figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateRight.cortex,[0 0 0], 0, 'r', 4)
plot3(elec_coords_ven(er,1),elec_coords_ven(er,2),elec_coords_ven(er,3), 'k.','MarkerSize', 22)
save2pdf([dir_out 'ventral_left.pdf'], gcf, 600)
savePNG(gcf,600, [dir_out 'ventral_left.png'])

% Lateral right hemisphere ventral
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'r', 4)
for i = 1:length(a.origCoords)
    el_add(el_mni(i,:),'k','.',20,[1,1,1])
    % here you can configurate the elec size, color, etc. 
end
save2pdf([dir_out 'latera_right.mat'], gcf, 600)


%%
sEEG = load('/Users/pinheirochagas/Downloads/SEEG.mat');
el_exclude =[sEEG.origCoords(:,1)>60 sEEG.origCoords(:,2)>60 sEEG.origCoords(:,3)>40]
el_ex = sum(el_exclude,2);
sEEG.origCoords = sEEG.origCoords(el_ex == 0,:)
el_left = sEEG.origCoords(sEEG.origCoords(:,1)<0,:)
el_right = sEEG.origCoords(sEEG.origCoords(:,1)>0,:)


figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
plot3(el_left(:,1),el_left(:,2),el_left(:,3), 'k.','MarkerSize', 22)
alpha(0.2)
save2pdf([dir_out 'top_left_sEEG.pdf'], gcf, 600)

figureDim = [0 0 .7 .7];
figure('units','normalized','outerposition',figureDim)
ctmr_gauss_plot(cortex_TemplateRight.cortex,[0 0 0], 0, 'r', 4)
plot3(el_right(:,1),el_right(:,2),el_right(:,3), 'k.','MarkerSize', 22)
alpha(0.2)
save2pdf([dir_out 'ventral_right_sEEG.pdf'], gcf, 600)


col_plot = parula(200);

plot3(el_mni(:,1),el_mni(:,2),el_mni(:,3), 'Color', col_plot(i,:), 'Marker', '.', 'MarkerSize', 20)


for e = 1:1
    ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
    for i = 1:size(el_mni)
        f = plot3(el_mni(i,1),el_mni(i,2),el_mni(i,3), '.', 'Color', col_plot(i,:), 'MarkerSize', 50*rand)
    end
    F(e) = getframe(gcf, [100 100 100 100]);
    close all
end




fig = figure;
movie(fig,F,20)


videoRSA = VideoWriter([dir_out 'video_ex.avi']);
uncompressedVideo = VideoWriter([dir_out 'video_ex.avi'], 'Uncompressed AVI');
videoRSA.FrameRate = 10;  % Default 30
videoRSA.Quality = 100;    % Default 75
open(videoRSA);
writeVideo(videoRSA, [F]);
close(videoRSA);

%% Ventral left hemisphere







for e = 1:10:270
    ctmr_gauss_plot(cortex_TemplateLeft.cortex,[0 0 0], 0, 'l', 1)
    loc_view(0+e,0)
    F(e) = getframe(gcf, [100 100 100 100]);
    close all
end


fig = figure;
movie(fig,F,20)


videoRSA = VideoWriter([dir_out 'video_ex.avi']);
uncompressedVideo = VideoWriter([dir_out 'video_ex.avi'], 'Uncompressed AVI');
videoRSA.FrameRate = 10;  % Default 30
videoRSA.Quality = 100;    % Default 75
open(videoRSA);
writeVideo(videoRSA, [F]);
close(videoRSA);


%% Lateral left hemisphere
