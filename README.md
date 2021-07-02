# Particle Image Velocimetry for an experimental debris flow

Particle Image Velocimetry (PIV) analysis of a small-scale experimental debris flow with Matlab.
These experiments were performed at the Sorby Environmental Fluid Dynamics Labority at the University of Leeds.
This work is detailed in [Spatial and temporal evolution of an experimental debris flow, exhibiting coupled fluid and particulate phases](https://link.springer.com/content/pdf/10.1007/s11440-021-01265-y.pdf)

1) **Obtaining the PIV data** 
The data necessary to recreate the figures in the above paper can be accessed via google drive (https://drive.google.com/drive/folders/1IVwKy6NcONNRE73yw8iySk3GIFxqOspi?usp=sharing). 
This consists of a .mat file (*PIV_data.mat*) containing the instantaneous flow velocity (in the *x* and *y* directions) for three experimental runs, jpegs of the flow corresponding to 12 different snapshots in time, and a scale image to convert from pixels to material coordinates. It also includes *PIV_flow.mat* which contains the processed PIV data for the 12 different flow times.
To use this data with the following codes, download it and store it in a directory named *data* within the working directory.

2) **Process the instantaneous PIV data**<br>
[wrangle_PIV_data.m](https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/wrangle_PIV_data.m) processes the raw PIV data. It loads *PIV_data.mat*, time averages the data, and extracts the flow free surface at specified flow times. The PIV data is cropped at the free surface, and the processed data is stored and saved in *PIV_flow.mat*. 
The free surface extraction requires the user to select the free surface by clicking on the image and approximating it as a straight line.

3) **Plotting the PIV vectors on top of the flow snapshot**<br>
[PIV_vector_plots.m](https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/PIV_vector_plots.m) plots the processed PIV vectors on top of the flow snapshots at specified times.
<p align="center">
 <img src="https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/Figures/vectorPlot.jpeg"  
</p>

4) **Contours of velocity and standard deviation**<br>
[vel_SD_contours.m](https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/vel_SD_contours.m) produces contour plots of horizontal velocity and standard deviation. For example, the following plot shows velocity contours at a flow time of *t = 0.6* s, where red denotes highest velocities.
<p align="center">
 <img src="https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/Figures/vel_contour.jpg"  
</p>

5) **Vertical profiles of velocity**<br>
[velocity_profiles.m](https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/velocity_profiles.m) produces plots of horizontal velocity against the vertical coordinate:
<p align="center">
 <img src="https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/Figures/vel_profiles.jpeg"  
</p>
It also plots analytical profiles on top of the experimental profiles, that derived by making assumptions on the flow rheology:
<p align="center">
 <img src="https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/Figures/vel_scaling.jpeg"  
</p>

6) **Vertical profiles of shear**<br>
[shear_profiles.m](https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/shear_profiles.m) approximates the horizontal component of the shear rate, and plots the profile against the vertical coordinate:
<p align="center">
 <img src="https://github.com/CaitlinChalk/experimental_debris_flow/blob/main/Figures/shear.jpeg"  
</p>

