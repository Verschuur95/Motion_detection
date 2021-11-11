%% Anouk Verschuur - automatic detection of motion-affected slices
clear all
close all
clc

%% load scan

volume = niftiread('BI001_T2_brain.nii');        %adjust to volume
%info = niftiinfo('BI010_T2_brain.nii');     %adjust to volume

mask = imbinarize(volume);

volsize = size(volume);

k=2;

for i=2:volsize(3)-1
    
    slice_masked = volume(:,:,i);%.*mask(:,:,i);
    mean_slice = mean(mean(slice_masked(slice_masked>0)));
    
    slice_pre_masked = volume(:,:,i-1);%.*mask(:,:,i-1);
    values_pre = slice_pre_masked(slice_pre_masked>0);
    
    slice_post_masked = volume(:,:,i+1);%.*mask(:,:,i+1);
    values_post = slice_post_masked(slice_post_masked>0);
    
    values_prepost = cat(1,values_pre,values_post);
    mean_prepost = mean(values_prepost);
    
    abs_diff(k) = abs(mean_prepost-mean_slice);
    
    means_slices(k)=mean_slice;
    
    k=k+1;
end

abs_diff(54) = NaN;
[lcs,pks] = peakseek(abs_diff,3,20)

figure('units','normalized','outerposition',[0 0 1 1])
bar(abs_diff), title('Absolute mean difference of slice compared to surrounding slices','FontSize',16), xlabel('slice number (caudal to cranial)','FontSize',16), ylabel('difference','FontSize',16), hold on
scatter(lcs,pks,'r','filled')
legend('difference','peak','FontSize',16)


test=abs_diff;
test(isnan(test))=[];
IQR=iqr(test);

threshold = 2*IQR
figure, plot(means_slices)

%% with median

volume = niftiread('BI003_T2_brain.nii');        %adjust to volume
%info = niftiinfo('BI010_T2_brain.nii');     %adjust to volume

mask = imbinarize(volume);

volsize = size(volume);

k=2;

for i=2:volsize(3)-1
    
    slice_masked = volume(:,:,i);%.*mask(:,:,i);
    median_slice = median(median(slice_masked(slice_masked>0)));

    slice_pre_masked = volume(:,:,i-1);%.*mask(:,:,i-1);
    values_pre = slice_pre_masked(slice_pre_masked>0);
    
    slice_post_masked = volume(:,:,i+1);%.*mask(:,:,i+1);
    values_post = slice_post_masked(slice_post_masked>0);
    
    values_prepost = cat(1,values_pre,values_post);
    median_prepost = median(values_prepost);

    abs_diff(k) = abs(median_prepost-median_slice);
    
    medians_slices(k)=median_slice;
    
    k=k+1;
end

abs_diff(54) = NaN;
[lcs,pks] = peakseek(abs_diff,3,20)

figure('units','normalized','outerposition',[0 0 1 1])
bar(abs_diff), title('Absolute difference of median slice intensity compared to surrounding slices','FontSize',16), xlabel('slice number (caudal to cranial)','FontSize',16), ylabel('difference','FontSize',16), hold on
scatter(lcs,pks,'r','filled')
legend('difference','peak','FontSize',16)


%%

volume = niftiread('BI037_T2_brain.nii');        %adjust to volume
[BW, threshOut] = edge(volume(:,:,28));
figure, imshow(BW)
