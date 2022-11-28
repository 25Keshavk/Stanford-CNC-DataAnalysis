% PCA-ICA Analysis with Cellsort
%
% Cellsort library created by Mukamel et al. 
% Library documentation: https://brainome.ucsd.edu/CellSortDoc/
%
% @author Keshav Kotamraju



% Step 1: Do the PCA

% cellRange = [1:10];

fn = 'correct-rigid-full.tif';
nPCs = 25;

[mixedsig, mixedfilters, CovEvals, covtrace, movm, movtm] = CellsortPCA(fn, [], nPCs, [], [], []);
 
% Step 2: Choose PCs and plot PC spectrum
[PCuse] = CellsortChoosePCs(fn, mixedfilters);

figure(2)
CellsortPlotPCspectrum(fn, CovEvals, PCuse)

% Step 3: Select ICs

mu = 0.5;

[ica_sig, ica_filters, ica_A, numiter] = CellsortICA(mixedsig, mixedfilters, CovEvals, PCuse, mu, length(PCuse));

figure(3)
CellsortICAplot('series', ica_filters, ica_sig, movm, [], 0.1, [], [], cellRange); % show the signal graphs for all frames
 
% Step 4: Segmentation

smwidth = 3;
thresh = 4;
arealims = 100;

% Provides overlay of the discovered regions
figure(4)
[ica_segments, segmentlabel, sgcentroid] = CellsortSegmentation(ica_filters, smwidth, thresh, arealims, 1);

cell_sig = CellsortApplyFilter(fn, ica_segments, flims, movm, 1);

% Step 5: Find Spikes

deconvtau = 0;
spike_thresh = 2;
normalization = 1;

[spmat, spt, spc] = CellsortFindspikes(ica_sig, spike_thresh, dt, deconvtau, normalization);

figure(5)
CellsortICAplot('series', ica_filters, ica_sig, movm, tlims, dt, 1, 2, [1:5], spt, spc);

figure(6)
CellsortICAplot('series', ica_filters, ica_sig, movm, tlims, dt, 1, 2, [6:10], spt, spc);

figure(7)
CellsortICAplot('series', ica_filters, ica_sig, movm, tlims, dt, 1, 2, [11:15], spt, spc);
figure(8)
CellsortICAplot('series', ica_filters, ica_sig, movm, tlims, dt, 1, 2, [16:20], spt, spc);

figure(9)
CellsortICAplot('series', ica_filters, ica_sig, movm, tlims, dt, 1, 2, [21:25], spt, spc);

% Save the results in a text file. 

writetable(array2table(ica_sig),'test.xlsx')

% Save the filters as images.

for t = 1:nPCs
    
    f = figure('visible','off');

    figure(20);

    img_arr = ica_filters(t, :, :);

    % reshape the array to be saved as an image
    shaped_arr = reshape(img_arr, [512, 512]);

    imagesc(shaped_arr)

    axis equal;
    axis tight;

    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
     % Make the axes occupy the whole figure
    set(gca,'Position',[0 0 1 1])

    saveas(gcf, strcat('filters/filter-', string(t)),'tif') % gcf = get current figure
end 
