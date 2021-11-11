# Motion_detection
Preliminary code and results for automatic motion detection in T2-weighted neonatal MRI scans as supplement to "Improved neonatal brain MRI segmentation by interpolation of motion corrupted slices".

This tool enables automatic motion detection of moderate-severe motion artifacts in T2-weighted neonatal MRI. The absolute median difference between a slice and the two surrounding slcies (before and after) are calculated for all axial slices. Slices with motion artifacts will show a high difference compared to surrounding slices. These peaks can be detected using peak detection, providing the number of slices with motion artifacts. Peak detection was performd using PeakSeek <sup></sup>1

<sup></sup> 1 Peter O'Connor (2021). PeakSeek (https://www.mathworks.com/matlabcentral/fileexchange/26581-peakseek), MATLAB Central File Exchange. Retrieved November 11, 2021.

# Evaluation
![Peakdetection_motion](Peakdetection_motion.jpg)

![Peakdetection_nomotion](Peakdetection_nomotion.jpg)
