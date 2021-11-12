%% Anouk Verschuur - automatic detection of motion-affected slices
clear all
close all
clc

%% load scan

[file,path] = uigetfile('.nii');
disp(['filename: ',file])
volume = niftiread(strcat(path,file));
volsize = size(volume);

k=2;
for i=2:volsize(3)-1
    
    % slice of interest
    slice_masked = volume(:,:,i);
    median_slice = median(median(slice_masked(slice_masked>0)));
    
    % surrounding slices
    slice_pre_masked = volume(:,:,i-1);
    slice_post_masked = volume(:,:,i+1);
    values_pre = slice_pre_masked(slice_pre_masked>0);
    values_post = slice_post_masked(slice_post_masked>0);
    
    values_prepost = cat(1,values_pre,values_post);
    median_prepost = median(values_prepost);

    abs_diff(k) = abs(median_prepost-median_slice);
    
    medians_slices(k)=median_slice;
    
    k=k+1;
end

abs_diff(54) = NaN;
[lcs,pks] = peakseek(abs_diff,3,20);

disp(['slice numbers containing motion: ',num2str(lcs)])

figure('units','normalized','outerposition',[0 0 1 1])
bar(abs_diff), title('Absolute difference of median slice intensity compared to surrounding slices','FontSize',16), xlabel('slice number (caudal to cranial)','FontSize',16), ylabel('difference','FontSize',16), hold on
scatter(lcs,pks,'r','filled')
legend('difference','peak','FontSize',16)

